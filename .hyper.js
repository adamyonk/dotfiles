// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

const themes = {
  "base16_default-dark": {
    black: "#181818",
    red: "#AB4642",
    green: "#A1B56C",
    yellow: "#F7CA88",
    blue: "#7CAFC2",
    magenta: "#BA8BAF",
    cyan: "#86C1B9",
    white: "#D8D8D8",
    lightBlack: "#585858",
    lightWhite: "#F8F8F8"
  },

  "base16_default-light": {
    black: "#F8F8F8",
    red: "#AB4642",
    green: "#A1B56C",
    yellow: "#F7CA88",
    blue: "#7CAFC2",
    magenta: "#BA8BAF",
    cyan: "#86C1B9",
    white: "#383838",
    lightBlack: "#B8B8B8",
    lightWhite: "#181818"
  },
  base16_github: {
    black: "#ffffff",
    red: "#ed6a43",
    green: "#183691",
    yellow: "#795da3",
    blue: "#795da3",
    magenta: "#a71d5d",
    cyan: "#183691",
    white: "#333333",
    lightBlack: "#969896",
    lightWhite: "#ffffff"
  },
  "base16_ia-light": {
    black: "#f6f6f6",
    red: "#9c5a02",
    green: "#38781c",
    yellow: "#c48218",
    blue: "#48bac2",
    magenta: "#a94598",
    cyan: "#2d6bb1",
    white: "#181818",
    lightBlack: "#898989",
    lightWhite: "#f8f8f8"
  },
  "base16_tomorrow": {
    black: "#ffffff",
    red: "#c82829",
    green: "#718c00",
    yellow: "#eab700",
    blue: "#4271ae",
    magenta: "#8959a8",
    cyan: "#3e999f",
    white: "#4d4d4c",
    lightBlack: "#8e908c",
    lightWhite: "#1d1f21",
  },
  "base16_tomorrow-night": {
    black: "#1d1f21",
    red: "#cc6666",
    green: "#b5bd68",
    yellow: "#f0c674",
    blue: "#81a2be",
    magenta: "#b294bb",
    cyan: "#8abeb7",
    white: "#c5c8c6",
    lightBlack: "#969896",
    lightWhite: "#ffffff",
  },
};

let colors = themes["base16_tomorrow"];
const backupColor = (colors, check, backup) => {
  if (!colors[check]) {
    colors[check] = colors[backup]
  }
}
backupColor(colors, 'background', 'black')
backupColor(colors, 'foreground', 'white')
backupColor(colors, 'lightRed', 'red')
backupColor(colors, 'lightGreen', 'green')
backupColor(colors, 'lightYellow', 'yellow')
backupColor(colors, 'lightBlue', 'blue')
backupColor(colors, 'lightMagenta', 'magenta')
backupColor(colors, 'lightCyan', 'cyan')

module.exports = {
  config: {
    // choose either `'stable'` for receiving highly polished,
    // or `'canary'` for less polished but more frequent updates
    updateChannel: "stable",

    // default font size in pixels for all tabs
    fontSize: 14,

    // font family with optional fallbacks
    fontFamily:
      '"Fira Code Retina", Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',

    // default font weight: 'normal' or 'bold'
    fontWeight: "normal",

    // font weight for bold characters: 'normal' or 'bold'
    fontWeightBold: "bold",

    // line height as a relative unit
    lineHeight: 1,

    // letter spacing as a relative unit
    letterSpacing: 0,

    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    cursorColor: "rgba(255,51,102,1)",

    // terminal text color under BLOCK cursor
    cursorAccentColor: colors.lightWhite,

    // `'BEAM'` for |, `'UNDERLINE'` for _, `'BLOCK'` for █
    cursorShape: "BLOCK",

    // set to `true` (without backticks and without quotes) for blinking cursor
    cursorBlink: false,

    // color of the text
    foregroundColor: colors.foreground,

    // terminal background color
    // opacity is only supported on macOS
    backgroundColor: colors.background,

    // terminal selection color
    selectionColor: "rgba(248,28,229,0.3)",

    // border color (window, tabs)
    borderColor: colors.background,

    // custom CSS to embed in the main window
    css: "",

    // custom CSS to embed in the terminal window
    termCSS: "",

    // if you're using a Linux setup which show native menus, set to false
    // default: `true` on Linux, `true` on Windows, ignored on macOS
    showHamburgerMenu: "",

    // set to `false` (without backticks and without quotes) if you want to hide the minimize, maximize and close buttons
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` (without backticks and without quotes) on Windows and Linux, ignored on macOS
    showWindowControls: "",

    // custom padding (CSS format, i.e.: `top right bottom left`)
    padding: "3px",

    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors,

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    //
    // Windows
    // - Make sure to use a full path if the binary name doesn't work
    // - Remove `--login` in shellArgs
    //
    // Bash on Windows
    // - Example: `C:\\Windows\\System32\\bash.exe`
    //
    // PowerShell on Windows
    // - Example: `C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe`
    shell: "",

    // for setting shell arguments (i.e. for using interactive shellArgs: `['-i']`)
    // by default `['--login']` will be used
    shellArgs: ["--login"],

    // for environment variables
    env: {},

    // set to `false` for no bell
    bell: "SOUND",

    // if `true` (without backticks and without quotes), selected text will automatically be copied to the clipboard
    copyOnSelect: false,

    // if `true` (without backticks and without quotes), hyper will be set as the default protocol client for SSH
    defaultSSHApp: true,

    // if `true` (without backticks and without quotes), on right click selected text will be copied or pasted if no
    // selection is present (`true` by default on Windows and disables the context menu feature)
    quickEdit: false,

    // choose either `'vertical'`, if you want the column mode when Option key is hold during selection (Default)
    // or `'force'`, if you want to force selection regardless of whether the terminal is in mouse events mode
    // (inside tmux or vim with mouse mode enabled for example).
    macOptionSelectionMode: "vertical",

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',

    // Whether to use the WebGL renderer. Set it to false to use canvas-based
    // rendering (slower, but supports transparent backgrounds)
    webGLRenderer: true

    // for advanced config flags please refer to https://hyper.is/#cfg
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [],

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: [],

  keymaps: {
    // Example
    // 'window:devtools': 'cmd+alt+o',
  }
};
