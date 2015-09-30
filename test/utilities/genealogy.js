// Dependencies
import { expect } from 'chai';
import genealogy from '../../lib/utilities/genealogy';

// Helpers

class Larva {
  constructor(name) {
    this.name = name;
  }

  toString() {
    return `Larva: ${this.name}`;
  }
}

class Cocoon extends Larva {
  constructor(name) {
    super(name);
  }

  toString() {
    return `Cocoon: ${this.name}`;
  }
}

class Butterfly extends Cocoon {
  constructor(name) {
    super(name);
  }

  toString() {
    return `Butterfly: ${this.name}`;
  }
}

// Tests

describe('Genealogy', () => {
  var larry;
  var caleb;
  var barry;

  beforeEach(() => {
    larry = new Larva('Larry');
    caleb = new Cocoon('Caleb');
    barry = new Butterfly('Barry');
  });

  it('should apply the mixin correctly', () => {
    genealogy(Larva);
    expect(barry.isDescendantOf(larry)).to.equal(true);
    expect(larry.isAncestorOf(barry)).to.equal(true);
    expect(caleb.isDescendantOf(larry)).to.equal(true);
  });

  it('should get the correct constructor tree', () => {
    let barryTree = barry.constructorTree();
    let calebTree = caleb.constructorTree();
    let larryTree = larry.constructorTree();
    expect(barryTree).to.deep.equal(['Butterfly', 'Cocoon', 'Larva']);
    expect(calebTree).to.deep.equal(['Cocoon', 'Larva']);
    expect(larryTree).to.deep.equal(['Larva']);
  });

  it('should say that caleb and larry are barrys ancestors', () => {
    expect(larry.isAncestorOf(barry)).to.equal(true);
    expect(caleb.isAncestorOf(barry)).to.equal(true);
  });

  it('should not match ancestors or descendants to same instances', () => {
    expect(larry.isDescendantOf(larry)).to.equal(false);
    expect(barry.isAncestorOf(barry)).to.equal(false);
  });

  it('should say that caleb, larry and barry are related', () => {
    const insects = [larry, caleb, barry];
    insects.forEach((one) => {
      insects.forEach((two) => {
        expect(one.isRelatedTo(two)).to.equal(true);
      });
    });
  });
});
