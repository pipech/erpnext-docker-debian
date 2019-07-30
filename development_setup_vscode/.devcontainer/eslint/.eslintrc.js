module.exports = {
  'env': {
    'browser': true,
    'es6': true
  },
  'extends': ['google'],
  'globals': {
    'Atomics': 'readonly',
    'SharedArrayBuffer': 'readonly'
  },
  'parserOptions': {
    'ecmaVersion': 2018,
    'sourceType': 'module'
  },
  'rules': {
    // frappe use tabs indentation style
    'indent': ['error', 'tab'],
    'no-tabs': ['error', {allowIndentationTabs: true}],
    // set somes setting to warn not error
    'max-len': [1, 80, 4],  // max-length
    'camelcase': 'warn',
    'no-var': 'warn',
    'require-jsdoc': 'warn', 
  }
}
