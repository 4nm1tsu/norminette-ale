# norminette-ale
vim ALE implementation of [norminette](https://github.com/42School/norminette).

## Usage
You must install [norminette](https://github.com/42School/norminette) first.

And then, move scripts to your plugin directory.

If you use **vim-plug**, you just need to run

```
bash install.sh
```

enable norminette.

```
let g:ale_linters['c'] = ['norminette']
let g:ale_linters['cpp'] = ['norminette']
```

## Enjoy coding!
[Screenshot](./pictures/Screenshot_20210207_045656.png)
