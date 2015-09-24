// Dependencies
import { expect } from 'chai';
import mixin from '../../lib/utilities/mixins';


const Weapon = mixin({
  attack() {
    return this._attack || (this._attack = 0)
  }
});

@Weapon
class Sword {
  constructor(name) {
    this.name = name;
  }
}


describe('Mixins', function () {
  var sword;

  beforeEach(function () {
    sword = new Sword("Hello");
  });

  it('should add new methods to the class', function () {
    expect(sword.attack()).to.equal(0);
    sword._attack = 4;
    expect(sword.attack()).to.equal(4);
  });

});