# Install `fd` and `ripgrep` for telescope:

`sudo apt install fd-find ripgrep`

# Install `cspell`:

```
sudo npm install -g cspell@latest
sudo npm install -g @cspell/dict-fa-ir
cspell link add @cspell/dict-fa-ir
sudo npm install -g @cspell/dict-vim
cspell link add @cspell/dict-vim
```

# Install `wordnet` for cmp-dictionary description:

`sudo apt install wordnet`

# Notes

- Be sure install python3-venv for Mason python install
- Use VPN for Mason Install and Update registry

# **Explanation for Using Non-Standard Unicode Characters for Keybindings**

In order to set custom keybindings in terminal emulators like Wezterm or Konsole, sometimes you need to use non-standard characters that won’t interfere with regular typing or display. One way to achieve this is by using rare or unused Unicode characters from languages like Chinese, Japanese, or Korean. These characters are rarely used in daily English or Persian typing, so they can serve as a perfect solution for custom keybinding sequences without conflicting with regular text input.

For example, characters like `亜` (`\u4E9C`), `日` (`\u65E5`), or `山` (`\u5C71`) from the Chinese or Japanese writing systems are rarely typed in most contexts. They can be used as "invisible" keys or symbols that terminals can recognize but won't display in a way that interferes with regular text editing.

## **Why use these characters?**

- These characters don’t appear in regular English or Persian input, so they won’t conflict with standard text or commands.
- They serve as unique identifiers for keybindings in your terminal or text editor (e.g., Neovim).
- These characters are simply passed through as special sequences, so they won’t affect the text you’re writing in the terminal.

This technique is particularly useful when you want to define keybindings for custom commands or shortcuts that don't have an easy-to-remember key sequence but still need to be easily accessed in a terminal environment.

---

## **List of Unicode Characters for Keybindings:**

- [x] \u4E9C 亜
- [x] \u65E5 日
- [x] \u56FD 国
- [x] \u5C71 山
- [x] \u9F8D 龍
- [x] \u99AC 馬
- [ ] \u9CE5 鳥
- [ ] \u6708 月
- [ ] \u738B 王
- [ ] \u4F55 何
- [ ] \u529B 力
- [ ] \u9B5A 魚
- [ ] \u58E8 壌
- [ ] \u5152 朋
- [ ] \u826F 良
- [ ] \u5FB7 德
- [ ] \u559C 喜
- [ ] \u559C 喜
- [ ] \u79C0 禄
- [ ] \u5B50 子
- [ ] \u592A 太
- [ ] \u5F25 忥
- [ ] \u4F0A 亊
- [ ] \u8C6A 豪

# Useful

`:verbose set option?`
