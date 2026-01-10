# Portable Neovim DevBox

A fully configured, portable Docker container with Neovim, Tmux, and modern CLI tools for developers.

## 🚀 Overview

This repository provides a **fully configured Docker container** for a portable Neovim-based development environment. Whether you're setting up a new machine or working across multiple systems, this container ensures consistency and includes all the essential tools and configurations you need to be productive immediately.

### Key Benefits

- 🔄 Reproducible Neovim environment across any machine
- 📦 No local system pollution - everything runs in Docker
- 🚀 Quick setup - get coding in minutes
- 🛠️ Pre-configured with modern development tools

## 👥 Who This Is For

### ✅ Ideal For

- **Neovim enthusiasts** who want a consistent setup across multiple machines
- **Developers** working on different computers (work, home, servers)
- **Team leads** who want to standardize development environments
- **Students/Learners** exploring modern CLI-based development workflows
- **Remote developers** needing quick, reproducible environment setup
- **Terminal lovers** who prefer keyboard-driven workflows

### ⚠️ May Not Be Ideal For

- Beginners completely new to terminal/command-line interfaces
- Developers who prefer GUI-based IDEs (VS Code, IntelliJ, etc.)
- Users who need Windows-native development tools (WSL may help them)
- Teams requiring specific IDE integrations not available in Neovim

### 📚 Recommended Background

- Basic understanding of:
  - Command-line navigation (`cd`, `ls`, `mkdir`)
  - Text editing concepts (insert mode, normal mode)
  - Git basics (clone, commit, push)
  - Docker fundamentals (images, containers, docker-compose)
- Willingness to learn Neovim keybindings and modal editing

## ✨ Features

- **Nerd Fonts**: Patched fonts with icons and glyphs for enhanced terminal aesthetics and better visual feedback in your editor  
Pre-installed fonts are below(Needless to say, you can add more fonts as you like!):
  - [JetBrainsMonoNerdFont_v3.0.2](https://github.com/ryanoasis/nerd-fonts/)
  - [MoralerspaceHWJPDOC_v2.0.0](https://github.com/yuru7/moralerspace)
- **Editor**: Pre-installed Neovim with syntax highlighting, autocompletion, and custom keybindings for efficient coding  
See more about Neovim in [Repository of Neovim](https://github.com/neovim/neovim)!
- **Modern Prompt**: Starship prompt showing git status, language versions, execution time, and more at a glance  
The default configuration is based on [Gruvbox Rainbow Preset](https://starship.rs/ja-JP/presets/gruvbox-rainbow)  
You can customize as you like in `ProjectRoot/devenv/starship/starship.toml`!  
See more about Starship in [Repository of Starship](https://github.com/starship/starship)!
- **Terminal Multiplexer**: Tmux for managing multiple terminal sessions, split panes, and persistent sessions that survive disconnections. See more about Tmux in [Repository of Tmux](https://github.com/tmux/tmux)!

## 📋 Prerequisites

### Required Software

- Docker Engine 29.1.2 or later (`stable` version recommended)
- Docker Compose v2.40.3 or later (`stable` version recommended)

### Recommended Skills

- Basic familiarity with Docker commands
- Terminal/command-line experience
- A Nerd Font installed on your host system for optimal display

### Supported Platforms

- Linux (with Docker Engine)
- macOS 11+ (with Docker Desktop)
- Windows 10/11 (with Docker Desktop)

## 🔧 Installation

### 1. Install from the Repository

#### Case of Quick Start (No Customization Needed)

If you just want to use the pre-configured environment without modifications:

1. Go to the repository page <https://github.com/Xinor-a/MyDevelopmentEnvironment>.
2. Click on the green "Code" button and select "Download ZIP".
3. Extract the downloaded ZIP file anywhere you want to locate.

#### Case of Customization or Contribution

If you also want to customize configurations or contribute to the project:

1. Ensure you have Git installed on your machine.
2. Open your terminal and run the following command to clone the repository:

   ```bash
   git clone https://github.com/Xinor-a/MyDevelopmentEnvironment.git
   ```

   or

    ```bash
    git clone git@github.com:Xinor-a/MyDevelopmentEnvironment.git
    ```

3. Navigate into the cloned directory:

   ```bash
   cd MyDevelopmentEnvironment
   ```

### 2. Building the Docker Image

Run the following command in the root directory of the cloned repository:

```bash
docker-compose build
```

### 3. Running the Container

Start the container for the development environment on background with:

```bash
docker-compose up -d
```

## 📖 Usage

### Entering Your Development Environment

To enter your Neovim development environment, run:

```bash
docker-compose exec DevBox /bin/bash
```

You can also use SSH to connect if your host has SSH client installed. Use the following command:

```bash
ssh root@localhost -p 3000
```

## 📁 Project Structure

### Directory Architecture

```plaintext
ProjectRoot
├── README.md (this file)
├── devenv: Configuration files for any tools in the development environment
│   ├── git
│   │   └── .gitconfig
│   ├── nvim
│   │   ├── init.lua
│   │   ├── lazy-lock.json
│   │   ├── lsp
│   │   │   └── lua-ls.lua
│   │   └── lua
│   │       ├── config: configuration scripts
│   │       │   ├── keymaps.lua: custom keybindings
│   │       │   ├── lazy.lua: plugin manager setup
│   │       │   └── plugins: lua modules for plugins
│   │       │       └── define: plugin definitions
│   │       └── myluamodule.lua: helpers/utilities for Neovim config scripts
│   ├── starship
│   │   └── starship.toml: Starship prompt configuration
│   └── tmux
│        └── .tmux.conf: Tmux configuration file
├── docker-compose.yml
├── dockerfile
├── projects: Your code projects (mounted: shared with ProjectRoot/projects/)
│   └── README.md
├── scripts: Installation and setup scripts
│   ├── 1-0_InstallLatestGit
│   │   └── init.sh
│   ├── 1-1_InstallLatestOpenSsh
│   │   └── init.sh
│   ├── 1-2_InstallLatestNeovim
│   │   └── init.sh
│   ├── 1-3_InstallLatestStarship
│   │   └── init.sh
│   ├── 1-4_InstallLatestTmux
│   │   └── init.sh
│   ├── entrypoint.sh (called from dockerfile)
│   └── init.sh
└── ssh: SSH server configuration and host keys (mounted: shared with ProjectRoot/ssh/)
     ├── ssh_host_ecdsa_key
     ├── ssh_host_ecdsa_key.pub
     ├── ssh_host_ed25519_key
     ├── ssh_host_ed25519_key.pub
     ├── ssh_host_rsa_key
     ├── ssh_host_rsa_key.pub
     └── sshd_config
```

### Configuration Files

#### `ProjectRoot/devenv/`

| File                       | Description                            |
| :------------------------- | :------------------------------------- |
| `./git/.gitconfig`         | Git global configuration               |
| `./nvim/`                  | Neovim configuration files and plugins |
| `./starship/starship.toml` | Starship prompt configuration          |
| `./tmux/.tmux.conf`        | Tmux configuration file                |

#### `ProjectRoot/projects/`

| File               | Description                                             |
| :----------------- | :------------------------------------------------------ |
| `ProjectRoot/ssh/` | SSH server configuration and host keys (mounted volume) |

### `ProjectRoot/scripts/`

| File                                | Description                                                   |
| :---------------------------------- | :------------------------------------------------------------ |
| `entrypoint.sh`                     | Entrypoint script called from dockerfile                      |
| `init.sh`                           | Installation and setup scripts (called from `entrypoint.sh`)  |
| `1-0_InstallLatestGit/init.sh`      | Script to install the latest Git (called from `init.sh`)      |
| `1-1_InstallLatestOpenSsh/init.sh`  | Script to install the latest OpenSSH (called from `init.sh`)  |
| `1-2_InstallLatestNeovim/init.sh`   | Script to install the latest Neovim (called from `init.sh`)   |
| `1-3_InstallLatestStarship/init.sh` | Script to install the latest Starship (called from `init.sh`) |
| `1-4_InstallLatestTmux/init.sh`     | Script to install the latest Tmux (called from `init.sh`)     |

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
