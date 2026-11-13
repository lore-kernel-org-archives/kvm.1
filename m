Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.161.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563316;
	b=0maSzaysPBNLEJCHW5a+MjmBPupn12G0YfzMIbVYXU8DNBhTHqEyVMS5vx/MhjDXWD6u
	 XXHFTumkHG2TJCc/LMu2hISsvsxosM0qP0Rb8/9D5VlTeba0aHjlMJQxO4TY2A7Je0Wkd
	 48mxkImaIpgdpspeAQcEpVwaEPDjEXHio7a8fwLfipOGz4dg3o6kVfqy1xjw9YP160YqD
	 p+Pj5MEbDKFDNZxGuB2wQRPgJ9oseiw61oobrmmuEtRLdaltRMQA6qqJbSCSQ67igbAk2
	 d+MWD0N7Zw7i67AoynWSsD/LwzhoXeYAsqJto84slJvUY5xj8z3Hal5Lu5w0rmoT9zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563316;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=2OuYuwDSIVfTPlLHBFplT3Fsykaz6y/ZYTd6iGyKIGg=;
	b=tuTpYc3Mbw2o655Cg8PCgGkM4Hkq9VoOSjRPn3dOFi6+PCut20wj4BCTAtlSpCIAfcqi
	 cz6BTBn4PzAOM9axcfh8/6OUbHlLOQkS8VQ16kOvSS4f2KjGX9N9Se1C3AnV/6uCnwHwY
	 UkBpgyCy8NpZj504uw0qvK58iLPxy5HiWaGRx5rn8eaHnl9z03K0UZWsgpAdC7fhAAamo
	 FPKhCTzejOWTBE2/a5JfbLjwJjaZvgHCzfIw/PsOOUmAljmgIGdsvH+QivPEFnsIEU1gy
	 RwcC+OCS7mO4GvnHXPko5PgRggkwQVRtoIAp1/WBWhdnEr9xthcoonUUdGx/rFr46Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mails.tsinghua.edu.cn;
	spf=pass smtp.mailfrom=mails.tsinghua.edu.cn;
	dkim=pass header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=nGXyCgwR;
	arc=none smtp.remote-ip=162.243.161.220
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAAC606A31C
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FAAC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=nGXyCgwR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=2OuYu
	wDSIVfTPlLHBFplT3Fsykaz6y/ZYTd6iGyKIGg=; b=nGXyCgwRjuIHlCaeQN6cX
	FlXdq91QhupNrkVwOA3HymR+DC8pH99QZqscmzu2fXf7UQLcsqDDR1Sm0AlfG09R
	h+bZbZUhAFwY4EvOBD3+EUI33pGsdwRMR04gCmDiF2nVwglVOzSs6CGcSLabTKNy
	7c/RmlzRHj93AFsAUj1DNU=
Received: from ubuntu (unknown [101.5.154.165])
	by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S2;
	Fri, 13 Nov 2026 17:48:12 +0800 (CST)
From: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
To: qemu-devel@nongnu.org
Cc: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org,
	kvm@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	bin.meng@processmission.com,
	tangtao1634@phytium.com.cn
Subject: [RFC PATCH 00/20] hw/arm: Add initial RK3588 and ROCK 5B support
Date: Fri, 13 Nov 2026 17:47:34 +0800
Message-ID: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yAQGZQA3qzvR3PZqgA5CAg--.9318S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4kuF4kCr15uF18AF1fZwb_yoW5KFWfpa
	n5Arn8Krs7Gay3XrWSvFnrJF4Sv3WkWrWjkw1xXrW7AFWaqF40krnrK3Z09FyfJFWfXF13
	CFn2qryrGw47ZFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU6mhrU
	UUUU=
X-CM-SenderInfo: fzn1wj2s6ptxtovo32xlqjx3vdohv3gofq/

Hi,

This series adds initial support for the Rockchip RK3588 SoC and the
Radxa ROCK 5B board. It supports booting Linux through U-Boot SPL and
U-Boot from SPI NOR flash, as well as direct kernel boot.

The implementation includes the eight Cortex-A55/A76 CPUs, GICv3,
architectural timers, SRAM, UARTs, and the Rockchip SPI flash controller.
It also models the CRU, OTP, and HPTIMER registers needed by the boot
software.

Patches 1-5 extend DW8250 and ARM SMC support and add the XTX XT25F128
flash device. Patches 6-15 add the RK3588 SoC and its devices. Patches
16-18 add the ROCK 5B board and firmware boot support. Patch 19 adds
functional boot tests, and patch 20 adds documentation.

Both boot paths have been tested with Linux 6.12.4, with U-Boot 2025.01
used for the firmware boot path. The included functional tests cover
booting to a Buildroot shell, reboot, and poweroff.

Comments and suggestions are welcome.

Thanks,
Yifan

Chao Liu (20):
  hw/char/dw8250: implement the UART status register
  hw/char/dw8250: expose the baudbase property
  target/arm: report SMCCC v1.1 support
  target/arm: allow machines to handle SMC calls
  hw/block/m25p80: add the XTX XT25F128 SPI NOR flash
  hw/arm: add the Rockchip RK3588 SoC
  hw/timer: add Rockchip HPTIMER boot control
  hw/arm/rk3588: add the unimplemented device map
  hw/arm/rk3588: add the GICv3 interrupt controller
  hw/arm/rk3588: add the UARTs
  hw/misc: add the RK3588 clock and reset unit
  hw/misc: add the RK3588 OTP controller
  hw/ssi: add the Rockchip SPI flash controller
  hw/misc: add RK3588 SCMI server
  hw/arm/rk3588: wire up the SCMI server
  hw/arm: add Radxa ROCK 5B board
  hw/arm/rock-5b: connect the XTX XT25F128 SPI NOR flash
  hw/arm/rock-5b: add firmware booting
  tests/functional: add ROCK 5B boot tests
  docs/system/arm: document the Radxa ROCK 5B machine

 MAINTAINERS                              |  19 +
 docs/system/arm/rock-5b.rst              |  86 ++++
 docs/system/target-arm.rst               |   1 +
 hw/arm/Kconfig                           |  16 +
 hw/arm/meson.build                       |   3 +
 hw/arm/rk3588.c                          | 452 +++++++++++++++++
 hw/arm/rock-5b.c                         | 297 ++++++++++++
 hw/block/m25p80.c                        |  20 +
 hw/char/dw8250.c                         |  45 ++
 hw/misc/meson.build                      |   5 +
 hw/misc/rk3588-scmci.c                   | 589 +++++++++++++++++++++++
 hw/misc/rockchip_cru.c                   | 233 +++++++++
 hw/misc/rockchip_otp.c                   | 146 ++++++
 hw/ssi/Kconfig                           |   5 +
 hw/ssi/meson.build                       |   1 +
 hw/ssi/rockchip_sfc.c                    | 439 +++++++++++++++++
 hw/timer/meson.build                     |   1 +
 hw/timer/rockchip-hptimer.c              | 115 +++++
 include/hw/arm/arm-smc.h                 |  31 ++
 include/hw/arm/rk3588.h                  |  64 +++
 include/hw/misc/rk3588-scmci.h           |  25 +
 include/hw/timer/rockchip-hptimer.h      |  20 +
 target/arm/helper.c                      |  80 +++
 target/arm/internals.h                   |   3 +
 target/arm/kvm-consts.h                  |   5 +
 target/arm/tcg/psci.c                    |  15 +
 tests/functional/aarch64/meson.build     |   2 +
 tests/functional/aarch64/test_rock_5b.py | 118 +++++
 28 files changed, 2836 insertions(+)
 create mode 100644 docs/system/arm/rock-5b.rst
 create mode 100644 hw/arm/rk3588.c
 create mode 100644 hw/arm/rock-5b.c
 create mode 100644 hw/misc/rk3588-scmci.c
 create mode 100644 hw/misc/rockchip_cru.c
 create mode 100644 hw/misc/rockchip_otp.c
 create mode 100644 hw/ssi/rockchip_sfc.c
 create mode 100644 hw/timer/rockchip-hptimer.c
 create mode 100644 include/hw/arm/arm-smc.h
 create mode 100644 include/hw/arm/rk3588.h
 create mode 100644 include/hw/misc/rk3588-scmci.h
 create mode 100644 include/hw/timer/rockchip-hptimer.h
 create mode 100755 tests/functional/aarch64/test_rock_5b.py


base-commit: 49559567804523cb28cad002aa8e97f444e23ad7
-- 
2.53.0

