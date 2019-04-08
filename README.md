# qemu_stm32

Docker container for QEMU with an STM32 microcontroller implementation

This docker image is based on a copy of QEMU that has been modified to include an implementation of the STM32 microcontroller. You can find the implementation [here](https://github.com/beckus/qemu_stm32).

### Docker pull command

```
docker pull onatm/qemu_stm32
```

## How to use

- You need to map `/var/kernel` to the directory where your kernel image resides
- You can pass any `QEMU` flag you want

### Examples

#### Run a kernel image

```bash
↪ docker run -v $HOME/dev/mini-arm-os/03-ContextSwitch-2:/var/kernel --rm qemu_stm32 -M stm32-p103 -kernel os.bin

LED Off
OS: Starting...
OS: Calling the usertask (1st time)
usertask: 1st call of usertask!
usertask: Now, return to kernel mode
OS: Return to the OS mode !
OS: Calling the usertask (2nd time)
usertask: 2nd call of usertask!
usertask: Now, return to kernel mode
OS: Return to the OS mode !
OS: Going to infinite loop...
```

#### List supported machines

```bash
↪ docker run -v --rm qemu_stm32 -M help

Supported machines are:
lm3s811evb           Stellaris LM3S811EVB
canon-a1100          Canon PowerShot A1100 IS
vexpress-a15         ARM Versatile Express for Cortex-A15
vexpress-a9          ARM Versatile Express for Cortex-A9
...
```

## Credits
- Andre Beckus [@beckus](https://github.com/beckus)
