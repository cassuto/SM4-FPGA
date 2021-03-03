# SM4-FPGA
Implementation of high-speed SM4 encryption and decryption on FPGA.

Please see this [blog post](https://www.cnblogs.com/the-wind/p/14335632.html) for details.

# Toplevel module

![](https://img2020.cnblogs.com/blog/2284808/202101/2284808-20210129232025601-39920051.png)

|   Signal Name   |   Description   |
| ---- | ---- |
|   CLK_i   |   System clock   |
|   RST_N_i   |   Asynchronous reset input (falling edge valid)   |
|   MK_i   |   128bit key input   |
|   MK_VALID_i   |   Indicates whether the key input is valid   |
|   DAT_i   |   128 bit plaintext (ciphertext) block input   |
|   DAT_VALID_i   |   Indicates whether the block input is valid   |
|   DAT_o   |   128 bit ciphertext (plaintext) block output   |
|   DAT_READY_o   |   Indicates whether the block output is valid   |

# Overview of internal modules

![](https://img2020.cnblogs.com/blog/2284808/202101/2284808-20210129231811199-1056222967.png)

`keyexp` implements key expansion algorithm.

`decenc` implements nonlinear iterative algorithm for encryption / decryption.

# Parameters

The top module can implement both encryption and decryption. In addition, it can be configured to use a fixed round key to save the resources.

|   Parameters   |   Description  |  Default |
| ---- | ---- | ---- |
|   MODE   |  0: Encryption; 1: Decryption  |  |
|   ENABLE_FIXED_RK   |  0: Do not use fixed round key; 1: Use fixed round key  | 0 |
|   FIXED_RK   |   If fixed round key is used (ENABLE_FIXED_RK=1), specify 1024bit round key  | 128’h0 |

Note: If you set ENABLE_FIXED_RK=1, then fixed round key is used, and the port `MK_I` and `MK_VALID_I` are out of function.

## Resource utilization

![](https://img2020.cnblogs.com/blog/2284808/202102/2284808-20210201200242019-1703551880.png)

![](https://img2020.cnblogs.com/blog/2284808/202102/2284808-20210201200623372-1779157708.png)

## Timing（Fclk=100MHz）

![](https://img2020.cnblogs.com/blog/2284808/202102/2284808-20210201200452837-391724203.png)

$ F_{max} = \frac{1}{T-WNS} = 130 MHz $

## Power

![](https://img2020.cnblogs.com/blog/2284808/202102/2284808-20210201200431583-981751464.png)
