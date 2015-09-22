import assert from 'assert';
import greet from '../lib';

describe('greet', function () {
  it('should have unit test!', function () {
    assert(greet('test') === 'Hello test', 'we expected this package author to add actual unit tests.');
  });
});
