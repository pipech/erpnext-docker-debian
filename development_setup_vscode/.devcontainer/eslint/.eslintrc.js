module.exports = {
  'env': {
    'browser': true,
    'es6': true
  },
  'extends': 'google',
  'globals': {
    'Atomics': 'readonly',
    'SharedArrayBuffer': 'readonly'
  },
  'parserOptions': {
    'ecmaVersion': 2018,
    'sourceType': 'module'
  },
  'rules': {
    // frappe use 4 space indentation style
    'indent': ['error', 4],
    // set "Line exceeds the maximum line length of 80" to warning not error
    'max-len': [1, 80, 4]
  }
}
