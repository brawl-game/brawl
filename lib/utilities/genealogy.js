/**
 * genealogy.js
 * Helpers for finding out whether two objects are related and at what point in the
 * ancestry tree.
 */
import mixin from './mixins'

/**
 * Applies the genealogy functions to the target object.
 * @param  {Object} target The target to add the genealogy functions to.
 */
export default mixin({
  /**
   * Returns the whole family tree of the object
   * @return {[string]} The family constructor names of the object.
   */
  constructorTree() {
    var constructors = [this.constructor.name];

    var Proto = Object.getPrototypeOf(this.constructor);
    while (Proto.name !== '') {
      constructors.push(Proto.name);
      Proto = Object.getPrototypeOf(new Proto().constructor);
    }

    return constructors;
  },

  /**
   * Returns whether this is an ancestor of another object.
   * @param  {Object} possibleDescendant The object to check against.
   * @return {bool}                      True if this is an ancestor.
   */
  isAncestorOf(possibleDescendant) {
    if (this.constructor.name === possibleDescendant.constructor.name) {
      return false;
    }

    let ancestors = possibleDescendant.constructorTree();
    return ancestors.indexOf(this.constructor.name) !== -1;
  },

  /**
   * Returns whether this is a descendant of another object.
   * @param  {Object} possibleAncestor   The object to check against.
   * @return {bool}                      True if this is a descendant.
   */
  isDescendantOf(possibleAncestor) {
    if (this.constructor.name === possibleAncestor.constructor.name) {
      return false;
    }

    let ancestors = this.constructorTree();
    return ancestors.indexOf(possibleAncestor.constructor.name) !== -1;
  },

  /**
   * Returns whether this is related to another object.
   * @param  {Object} possibleRelative The object to check against.
   * @return {bool}                    True if they're related.
   */
  isRelatedTo(possibleRelative) {
    if (this.constructor.name === possibleRelative.constructor.name) {
      return true;
    }

    return this.isAncestorOf(possibleRelative) ||
           this.isDescendantOf(possibleRelative);
  }
});
