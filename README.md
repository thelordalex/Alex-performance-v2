# Alex Performance v2

## Description

`Alex Performance v2` is a performance optimization script for Android devices. It optimizes CPU, GPU, and memory settings to enhance system performance. Root access is required.

## Features

- Sets CPU governors to 'performance'
- Disables thermal throttling
- Configures GPU governor to 'performance'
- Increases read-ahead buffer size
- Enables zRAM
- Clears cached memory
- Reduces swappiness
- Monitors temperature and adjusts performance

## Requirements

- Root access

## Usage

1. **Ensure Root Access**

2. **Prepare the Script**

   - List the contents of the directory to ensure the script is in the right location:

     ```sh
     ls /sdcard/Android/
     ```

   - Make the script executable:

     ```sh
     chmod +x /sdcard/Android/performance_script.sh
     ```

   - View the script contents (optional):

     ```sh
     cat /sdcard/Android/performance_script.sh
     ```

   - Activate the Script

     Execute the script to optimize performance:

     ```sh
     sh /sdcard/Android/performance_script.sh
     ```

   - Deactivate the Script

     To revert to default settings, make the revert script executable:

     ```sh
     chmod +x /sdcard/Android/Alex_restore_defaults.sh
     ```

     View the revert script contents (optional):

     ```sh
     cat /sdcard/Android/Alex_restore_defaults.sh
     ```

     Execute the revert script:

     ```sh
     sh /sdcard/Android/Alex_restore_defaults.sh
     ```
