# SLiM Installer 🚀

Welcome to the SLiM Installer, your friendly neighborhood tool for getting SLiM
up and running with minimal fuss. Cooked up by a human-AI duo, this script is
here to streamline your journey into evolutionary simulations.

## What It Does

This nifty script will:
1. Track down the latest version of SLiM
2. Download it in a jiffy
3. Build it from source
4. Install it in your personal ~/.local/bin

## Why ~/.local/bin?

We chose ~/.local/bin for your SLiM installation because:
- It's your own space (no need for sudo powers)
- It's often already in your PATH
- It follows good Unix practices

## How to Use

Ready to evolve? Just run:

```bash
curl -sSL https://raw.githubusercontent.com/vsbuffalo/slim-installer/main/install.sh | bash
```

## Keeping Up with Evolution

Want to upgrade to the latest SLiM? Simply run the script again.

## Troubleshooting

If SLiM isn't available after installation, try this:

```
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## About

This was quickly cooked up with AI pair programming between Vince and
[Claude](https://claude.ai/).

