#!/system/bin/sh

# ===============================================
# Script Name: Alex performance v2
# Description: Performance optimization script for Android
# Instagram: ussefayman_
# Telegram: @uusergram
# ===============================================

echo "Starting Alex performance v2 script..."

# Ensure the script is running as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

# Set CPU governor to performance for all CPUs
echo "==============================================="
echo "Configuring CPU governors to 'performance'..."
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
  echo performance > $cpu
done

# Disable thermal throttling
echo "==============================================="
echo "Disabling thermal throttling..."
echo 0 > /sys/module/msm_thermal/core_control/enabled
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/; do
  echo -1 > $cpu/thermal_throttle/core_temp_limit
done

# Set GPU governor to performance (if applicable)
echo "==============================================="
echo "Configuring GPU governor to 'performance'..."
echo performance > /sys/class/kgsl/kgsl-3d0/devfreq/governor

# Increase read-ahead buffer size
echo "==============================================="
echo "Increasing read-ahead buffer size to 2048KB..."
echo 2048 > /sys/block/mmcblk0/bdi/read_ahead_kb

# Enable zRAM (if not already enabled)
echo "==============================================="
echo "Enabling zRAM with 1GB size..."
echo 1 > /sys/block/zram0/reset
echo 1073741824 > /sys/block/zram0/disksize
mkswap /dev/block/zram0
swapon /dev/block/zram0

# Clear cached memory
echo "==============================================="
echo "Clearing cached memory..."
echo 3 > /proc/sys/vm/drop_caches

# Reduce swappiness to prioritize RAM usage
echo "==============================================="
echo "Setting swappiness to 10..."
echo 10 > /proc/sys/vm/swappiness

# Launch the script in the background to monitor temperature and manage performance
echo "==============================================="
echo "Launching temperature monitoring script in the background..."
nohup sh -c "
while true; do
  # Monitor device temperature and apply necessary throttling if needed
  temp=\$(cat /sys/class/thermal/thermal_zone*/temp | sort -nr | head -n 1)
  if [ \"\$temp\" -ge 75000 ]; then
    echo \"Temperature high (\$temp), switching CPUs to 'powersave'...\"
    for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
      echo powersave > \$cpu
    done
  else
    echo \"Temperature normal (\$temp), setting CPUs to 'performance'...\"
    for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
      echo performance > \$cpu
    done
  fi
  sleep 10
done
" &

echo "==============================================="
echo "Alex performance v2 script completed."