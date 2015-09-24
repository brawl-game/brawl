/**
 * mixins.js
 * Contains functionality needed by class mixin objects.
 */
export default function mixin(behaviour) {
  const instanceKeys = Reflect.ownKeys(behaviour);
  const typeTag = Symbol('isa');

  function _mixin (clazz) {
    for (let property of instanceKeys)
      Object.defineProperty(clazz.prototype, property, {
        value: behaviour[property],
        writable: true
      });

    Object.defineProperty(clazz.prototype, typeTag, { value: true });
    return clazz;
  }

  return _mixin;
};
