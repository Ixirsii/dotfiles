local lint = {
    unknownAtRules = "ignore",
}

return {
    settings = {
        css = { lint = lint },
        less = { lint = lint },
        scss = { lint = lint },
    },
}
