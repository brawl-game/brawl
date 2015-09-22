import assert from 'assert';
import brawl from '../lib';

describe('brawl', function () {
  it('should have unit test!', function () {
    assert(brawl("test") === 'Hello test', 'we expected this package author to add actual unit tests.');
  });
});
