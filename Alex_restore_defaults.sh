#!/system/bin/sh

# ===============================================
# Script Name: Alex performance v2 Revert
# Description: Revert device settings to default
# Instagram: ussefayman_
# Telegram: @uusergram
# ===============================================

echo "Starting Alex performance v2 Revert script..."

# Reset CPU governor to default
echo "==============================================="
echo "Resetting CPU governors to default..."
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
  echo interactive > $cpu  # Change this to your default governor if different
done

# Enable thermal throttling
echo "==============================================="
echo "Enabling thermal throttling..."
echo 1 > /sys/module/msm_thermal/core_control/enabled
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/; do
  echo 0 > $cpu/thermal_throttle/core_temp_limit  # Adjust this based on default settings
done

# Reset GPU governor to default (if applicable)
echo "==============================================="
echo "Resetting GPU governor to default..."
echo interactive > /sys/class/kgsl/kgsl-3d0/devfreq/governor  # Change to default if different

# Reset read-ahead buffer size
echo "==============================================="
echo "Resetting read-ahead buffer size to default..."
echo 128 > /sys/block/mmcblk0/bdi/read_ahead_kb  # Change to default if different

# Disable zRAM
echo "==============================================="
echo "Disabling zRAM..."
swapoff /dev/block/zram0
echo 0 > /sys/block/zram0/reset

# Clear cached memory
echo "==============================================="
echo "Clearing cached memory..."
echo 3 > /proc/sys/vm/drop_caches

# Reset swappiness to default
echo "==============================================="
echo "Resetting swappiness to default..."
echo 60 > /proc/sys/vm/swappiness  # Change to default if different

# Reset display frame rate and refresh rate to default
echo "==============================================="
echo "Resetting display frame rate and refresh rate to default..."
# Add your specific commands here to reset frame rate and refresh rate

# Kill any running temperature monitoring scripts
echo "==============================================="
echo "Stopping any running temperature monitoring scripts..."
pkill -f "temperature monitoring script"

echo "==============================================="
echo "Alex performance v2 Revert script completed."