


我在 Windows 平台中嘗試執行 `prepare_git_repo` 目標，但是缺出現【檔案名稱太長】而出現錯誤的情況。

後來我參考：https://stackoverflow.com/a/22575737/16265240

```
git config --global core.longpaths true
```

