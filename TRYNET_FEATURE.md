# Trynet Pod Version Selection

## Overview

The installer now supports selecting trynet (testing) pod versions for advanced testing and development purposes.

## Trynet Packages

Trynet versions are automated testing builds:
- Format: `0.4.2~trynet.YYYYMMDDHHMMSS.COMMITHASH-1`
- Built automatically from the trynet branch
- Tagged with build timestamp and git commit hash
- Use tilde (`~`) versioning to prevent accidental upgrades over stable

### Available Versions (Example):
```
0.4.2~trynet.20251126115954.bedda09-1  (Nov 26, 2025, commit bedda09)
0.4.2~trynet.20251126050445.5e9ace7-1  (Nov 26, 2025, commit 5e9ace7)
0.4.2~trynet.20251119092339.cac9af1-1  (Nov 19, 2025, commit cac9af1)
```

## Usage

### Standard Installation (Stable):
```bash
sudo bash install.sh
```
Installs latest stable versions of all components.

### Advanced Installation (Trynet Testing):
```bash
sudo bash install.sh -d
```
Provides interactive selection for testing versions.

## Selection Process

When using advanced installation mode, you will be prompted to:

1. Select xandminer repository branch
2. Select xandminerd repository branch
3. Select pod trynet version

### Pod Version Selection:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Trynet Pod Version Selection
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Available trynet pod versions (10 most recent):

 1. 0.4.2~trynet.20251126115954.bedda09-1     2025-11-26  bedda09
 2. 0.4.2~trynet.20251126050445.5e9ace7-1     2025-11-26  5e9ace7
 3. 0.4.2~trynet.20251119092339.cac9af1-1     2025-11-19  cac9af1
 ...

Select version number (1-10), enter custom version, or press Enter for latest stable:
```

## Repository Information

### Stable Packages:
- Repository: https://xandeum.github.io/pod-apt-package/
- Versions: 0.5.1-1, 0.5.0-1, 0.4.2-1, etc.

### Trynet Packages:
- Repository: https://raw.githubusercontent.com/Xandeum/trynet-packages/main/
- Source: https://github.com/Xandeum/trynet-packages
- Versions: 0.4.2~trynet.TIMESTAMP.HASH-1

## Manual Installation

If you need to manually install a specific trynet version:

```bash
# Add trynet repository
echo "deb [trusted=yes] https://raw.githubusercontent.com/Xandeum/trynet-packages/main/ stable main" | sudo tee /etc/apt/sources.list.d/xandeum-pod-trynet.list

# Update apt cache
sudo apt update

# List available versions
apt-cache madison pod | grep trynet

# Install specific version
sudo apt install pod=0.4.2~trynet.20251126115954.bedda09-1
```

## Safety

- ⚠️ Trynet versions are for testing only - not recommended for production
- ✅ Standard installation always uses stable releases
- ✅ Pressing Enter during version selection defaults to stable
- ✅ Tilde versioning prevents accidental stable-to-trynet upgrades

## Verification

After installation, verify your pod version:

```bash
pod --version
apt list --installed | grep pod
```

---

For more information, visit: https://docs.xandeum.network/api/pnode-cli-usage
