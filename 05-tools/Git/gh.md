# gh
## workforward
```powershell
# search
gh search repos <owner>/<repo>

# readme
gh repos view <owner>/<repo>
```
## release
```powershell
# list
gh release list `
    --repo <owner>/<repo> 
## list tag
gh release view `
    --repo <owner>/<repo> `
    <tag>
    
# download
gh release download <tag> `
    --repo <owner>/<repo> `
    -[p]{--pattern:匹配} '<release>' `
    -[D]{--dir:指定存放目录} '<path>'
```
