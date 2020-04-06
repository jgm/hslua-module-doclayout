--
-- Tests for the doclayout module
--
local doclayout = require 'doclayout'
local tasty = require 'tasty'

local group = tasty.test_group
local test = tasty.test_case
local assert = tasty.assert

-- Check existence static fields
return {
  group 'constructors' {
    test('empty', function ()
      assert.are_equal(type(doclayout.empty), 'userdata')
    end),
    test('blankline', function ()
      assert.are_equal(type(doclayout.blankline), 'userdata')
    end),
    test('cr', function ()
      assert.are_equal(type(doclayout.cr), 'userdata')
    end),
    test('space', function ()
      assert.are_equal(type(doclayout.space), 'userdata')
    end),
  },

  group 'functions' {
    group 'render' {
      test('empty doc', function ()
        assert.are_equal(doclayout.render(doclayout.empty), '')
      end)
    }
  },

  group 'Doc type' {
    test('strings can be used as Doc values', function ()
      assert.are_equal(doclayout.render('hello world'), 'hello world')
    end),

    test('equality', function ()
      assert.is_truthy(doclayout.literal "true", doclayout.literal "true")
    end),

    test('concatenate docs', function ()
      assert.are_equal(
        tostring(doclayout.literal 'Rock-' .. doclayout.literal 'Ola'),
       'Rock-Ola'
      )
    end),

    test('has tostring method', function ()
      local str = 'just a literal string for now'
      assert.are_equal(tostring(str), str)
    end),

    test('adding concatenates with space', function ()
      local helloworld = doclayout.literal 'Hello,'
        .. doclayout.space
        .. doclayout.literal 'World'
      assert.are_equal(doclayout.literal 'Hello,' + 'World', helloworld)
    end),

    test('dividing sets the first above the second', function ()
      local first = doclayout.literal 'first'
      local second = doclayout.literal 'second'
      assert.are_equal(first / second, first .. doclayout.cr .. second)
    end),
  }
}
