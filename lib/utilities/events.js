/**
 * events.js
 * The primary event emitter bus for piston.
 */
import mixin from './mixins';

export default mixin({
  // Bind [listener] for events of type [event].
  on(event, listener) {
    this.listenersForEvent(event).push(listener);
    return this;
  },

  // Bind
  off(event, listener = null) {
    if (listener !== null) {
      this.removeListenerForEvent(event, listener);
    } else {
      if (this.listenersForEvent(event).length !== 0) {
        delete this.listeners()[event];
      } else {
        return this;
      }
    }

    return this;
  },

  // Emit an [event] to all of its listener.
  emit(event) {
    this.listenersForEvent(event.constructor).forEach(l => l(event));
    return this;
  },

  // Private

  // Get the event => listeners map
  listeners() {
    return this.listenersMap || (this.listenersMap = {});
  },

  // Get the array of listeners for an event, or initialize it
  listenersForEvent(event) {
    return this.listeners()[event] || (this.listeners()[event] = []);
  },

  // Remove a given listener for an event
  removeListenerForEvent(event, listener) {
    // Get all the listeners for the given event
    let listeners = this.listenersForEvent(event);
    // Attempt to find the listener in the array
    let listenerIndex = listeners.indexOf(listener);

    // Remove if listener found
    if (listenerIndex !== -1) {
      listeners.splice(listenerIndex, 1);

      // Remove event listener array if no listeners left
      if (listeners.length === 0) {
        delete this.listeners()[event];
      }
    }

    return this;
  }
});
