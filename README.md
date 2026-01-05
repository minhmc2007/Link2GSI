# LinkToGSI Action

A GitHub Action workflow to automatically download Android stock firmware and convert it into a Generic System Image (GSI) using `LinkToGSI.sh`.

## 🚀 Features

- **Automated Environment Setup**: Installs all necessary extraction tools (unrar, 7zip, brotli, etc.) and Python dependencies.
- **Cloud Processing**: Runs the conversion on GitHub's servers, saving your local bandwidth and storage.
- **Artifact Upload**: Automatically uploads the resulting GSI and logs as a downloadable artifact.
- **Multiple ROM Support**: tailored presets for various OEM firmware types.

## 📋 Supported ROM Types

When running the workflow, you can select from the following configurations:
- `Pixel` (Google)
- `OneUI` (Samsung)
- `MIUIGeneric` (Xiaomi/Poco/Redmi)
- `HyperOS` (New Xiaomi)
- `HMD` (Nokia/HMD Global)

## 🛠️ How to Use (GitHub Actions)

You do not need a computer to run this. You can trigger the build directly from your browser:

1.  **Star & Fork** this repository to your account.
2.  Go to the **Actions** tab in your forked repository.
3.  Select the **Link to GSI Generator** workflow on the left sidebar.
4.  Click the **Run workflow** dropdown button.
5.  **Enter Inputs**:
    *   **Stock Firmware Link**: Paste the direct download link (must be downloadable via `wget`).
    *   **ROM Type**: Select the appropriate type from the dropdown list.
6.  Click the green **Run workflow** button.

Once finished, click on the completed run, and look for the **GSI-Build-Output** in the **Artifacts** section at the bottom to download your files.

## 💻 Local Usage (Manual)

If you prefer to run this on your own Linux machine (Ubuntu/Debian), follow these steps:

### 1. Install System Dependencies
```bash
sudo apt-get update
sudo apt-get install -y unace unrar zip unzip p7zip-full p7zip-rar sharutils \
rar uudeview mpack arj cabextract rename liblzma-dev python3-pip brotli \
lz4 protobuf-compiler git gawk
```

### 2. Install Python Dependencies
```bash
pip3 install backports.lzma protobuf twrpdtgen extract-dtb pycryptodome
```

### 3. Run the Script
Make sure `LinkToGSI.sh` is executable and run it with `sudo`:

```bash
chmod +x LinkToGSI.sh
sudo bash LinkToGSI.sh <Firmware_URL> <ROM_Type>
```

**Example:**
```bash
sudo bash LinkToGSI.sh https://dl.google.com/dl/android/aosp/lynx-bp1a.zip Pixel
```

## ⚠️ Requirements

*   **Script**: This repository must contain the `LinkToGSI.sh` script in the root directory.
*   **Space**: The GitHub Runner has limited disk space (~14GB free). Very large firmware files may fail to extract.
*   **Link**: The firmware link provided must be a direct link (no captchas or wait times).

## ⚖️ Disclaimer

*   This tool is for development and testing purposes.
*   I am not responsible for bricked devices, dead SD cards, or thermonuclear war.
*   Please check your device's specific GSI compatibility before flashing.
