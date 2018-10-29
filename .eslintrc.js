module.exports = {
  env: {
    browser: true,
    es6: true,
    jest: true,
    node: true
  },
  parser: "babel-eslint",
  parserOptions: {
    sourceType: "module"
  },
  plugins: ["react"],
  extends: ["eslint:recommended", "plugin:react/recommended"],
  rules: {
    "no-console": ["error", { allow: ["warn", "error"] }],
    "no-unused-vars": ["error", { args: "none", ignoreRestSiblings: true }],
    "react/prop-types": "off"
  }
};
