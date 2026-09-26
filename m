Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC933403E3
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406071; cv=none; b=UjFlutvqh5k0ane35lBECfBGCH0mM3NXDZehRqDNynFc+kYlVxeMfxFatU4m/v7QA+dnDlb8fvPzoKJilCa82mZVCnpcMzFqWWVcVxpR0w0K7ABSZeX9BnXC/k0GYgQl53VTlNLLqAmAt2E6H4gOvA6I+bfp7iQ5yh7GQ64qeUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406071; c=relaxed/simple;
	bh=+Yw3UhkYW0TjgZyTo6WxXcCtNGS9kWu3uHmYzYU1Wtc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BSXG9EIPOMT0JJ5I4niSYP/nxxLGih1zwzscLuDh0GO/IGAJnsvOlatWLmHgegCTDQdmJ5BvudVp3sTHnd++MGOZl9blFVG4Eat4Zc1VE4sxNXSyglxUb4gK1fSMxWms++ld3KTIWy+yv1ttafwl9VumxwtFX5P8InonLKSpaJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5VxU7Pr; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5VxU7Pr"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341fe27b718so1358840eec.0
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406067; x=1791010867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yFfE2AD4S3H6nH9ctKeqkkpjiDHnBmc770hplBED8D8=;
        b=g5VxU7PrxNB8cUCHedPo1l8Ls0dwY6GhO6ytuG/WbxngIAXXqZzDfQu5ryFQdD22pu
         H90QMWn7R6sf6KSt6SS9ZiceHZcu3hBO5BKutUw+AKXDFwmMjOdD7xQneRWuk5pfypvD
         JcWk5nVd2OIw9y2b0r0dX7wZJTgr+Tl/T2mSi8O32FQOMCmTPf3E5plUz60mXuXTYkGG
         Xcxn12L7VTgVJwqJ+1xX1CXFT32v3XdsPl5EyzM3QWUokmPwLGwtYMomCFNpXcOYi313
         na8HPDDghtQqzLxhSKwuI0hmO+n+tEEbLwzO424J6i42MdhAeQBRNqGJErylrm/BcG4r
         5a2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406067; x=1791010867;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yFfE2AD4S3H6nH9ctKeqkkpjiDHnBmc770hplBED8D8=;
        b=H1njZU9ubvQp9BURMfAIuj0lkJE7PKIC+MMq0NG2PpzqeAsIMAvsOzl//zIMi1CXi9
         qSKGAWNdSTi1PBDRQTzMaGxrC9jETDVakfBDXxTDMc9rdjo8aELh9/Y4k01L9Ku7hyYh
         AVWIPLFoFVnkw8RmxvCwwwU5bqQRYmA9qE3uWxgNmm0Z2IAzeGf+IFBBpydi+LvwANQy
         mDb/A/u5TKu++BzdRzUJ1Xh16MbiP20nBcMvTOglofahaU90L6iaxOuSqhMoy6dlDBnr
         FiK4FC6SyaiepW3RgLMugd7gJWzIWAGlSOaaD8b2UyrysYghY7ppnrVlKOV6yD7ojY35
         gnCw==
X-Forwarded-Encrypted: i=1; AKwUvBxszmVUZ+2yle9ddBRgLG9Ck4cEOGpQnKtZJAjMLKbnVW+AbPjLqvGPKa3D/ODKUMiGLOQ=@vger.kernel.org
X-Gm-Message-State: AFuF++m9ukWYfyuysFKHNwAxoVlsBd45RvkiERzVmrEOfjNsSFg0pn4F
	i2GHFpBeCOQOyQxEfEshshJrheX1Y7iTqlyCIMDUWynhWIerhkyrKBcs
X-Gm-Gg: AYBFou0p+/gQrdgdh+AqBR+XH+dqDz22dekTqQAE2D3fIkzM92Y5dG70b+rtjhXEd1K
	5dtUKrjy83gcZ5mv5QXXfPIyR2E47euLnj87U8uzUo3H2QO9KwD1MNyWMdNHsYbgqMZVwHBhX5t
	TxSZgqeIbhr44Doe0Y4isALjVKyycNF5SQm9XZ+6KdnXxvTCwJGFZ48Bqq/Ht64Pu2A/ZbS9P0h
	hjOZ76zkdsOyNCB0Xn0DuIzKMfX6OH5JocCL/evNJbiht37q32nviq85PdKL3V0EM6owZGJOfKh
	BRknJ4xq+LK39Hk+y7aX1XCQbk3ZlGJ6cpWcA9lcmcZ5uUI41gaEjd6EDrYoAAt8FSogNa4ImF+
	QieiR0ABxBNDVuJJzxOEl4RG18zQhvyhCOTxpQNkp3FH0YSsohHbSCdKxZ1L/BC4hzqTbp6bK3x
	autyXkxPkQJOaVji2jms+iw6brTdYvLtgQsOf31IpD3ohc+QqNakRjTjf5yEUrRFzRj042nTV4k
	lmhM5aq/+qS/ezxlL3gwE4ky1dY15g=
X-Received: by 2002:a05:7301:b0f:b0:342:451b:c0cc with SMTP id 5a478bee46e88-3426fbbef10mr2268917eec.6.1790406066002;
        Sat, 26 Sep 2026 00:01:06 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:01:05 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 00/55] single-binary: link multi-targets into qemu-system
Date: Sat, 26 Sep 2026 14:59:59 +0800
Message-ID: <20260926070057.1234-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series produces one qemu-system binary that can run ARM (32 and 64) and
MicroBlaze. Upstream filters machines with TypeInfo.is_available. This series
passes a TargetInfo into that callback and compiles ARM and MicroBlaze once so
they can share qemu-system.

ARM virt keeps the QOM name virt. MicroBlaze boards keep their own names, so
TYPE_ACCEL_CPU and the virt ACPI helpers stay per target. aarch64 and arm share
one copy of the ARM sources. MicroBlaze is folded the same way. qemu-system
links a target only when its arch sources are target-info-def.c alone. Machine
is_available accepts ARM-family boards for arm and aarch64, aarch64-only boards
for aarch64, and MicroBlaze boards for microblaze.

target_ulong and TCG _tl helpers:

arm and microblaze are 32-bit and aarch64 is 64-bit, so the shared compile uses
a uint64_t target_ulong in softmmu common code. MO_TL follows
target_long_bits(). target_long stays per-target. tcg_gen_*_tl and the TL memory
helpers call the i32 or i64 operation through tl_is_64(). A helper tl argument
uses an i64 slot in common code: tcg_gen_callN zero-extends a 32-bit temp into
that slot and truncates an i64 return. Per-target builds keep target_ulong and
TCGv tied to TARGET_LONG_BITS.

Target selection has to work with more than one TargetInfo:

- The combined binary takes arch:name on -M/-machine and in a [machine] type
  (aarch64:virt). arch: binds the target. microblaze: runs that target's
  default machine. arm and aarch64 have no default. No -M leaves target none
  and the empty none machine. qemu-system-$arch keeps the historic -M name.
  -M help lists every target; arch:help lists one. A later bare name keeps the
  last arch prefix. query-targets lists each linked target, including none.
- TargetInfo is a constructor list. target_info_select() picks the entry,
  including SYS_EMU_TARGET_NONE. is_available takes const TargetInfo *. A
  single-target binary keeps its TargetInfo. arch: must match that binary or
  the machine is rejected. That binary drops types that fail is_available at
  registration. The combined binary keeps those types and filters with
  is_available for the selected target.

Peter Maydell suggested this arch:name form in review of
https://patchwork.ozlabs.org/project/qemu-devel/cover/20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com/#3749257

Daniel P. Berrange asked to query every machine in the binary and which targets
can run it. This series adds query-targets for that:
https://patchwork.ozlabs.org/project/qemu-devel/cover/20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com/#3749292

qemu-system-$TARGET is still built, including the Windows *w twin. qemu-system
is extra. It links aarch64, arm, and microblaze. Do not add qemu-systemw for
that binary. A GUI twin would keep QEMU exporting data from the .exe into
DLLs, and those data exports cannot be delay-loaded (qdev_prop_array and other
qdev_prop_*). That would block enabling modules globally on Windows.

Examples:

  qemu-system -M aarch64:virt ...
  qemu-system -M microblaze:petalogix-s3adsp1800 ...
  qemu-system-aarch64 -M virt ...

A bare machine name on qemu-system needs an arch: prefix. An unknown target
fails with "target '...' is not available".

v1: https://patchew.org/QEMU/20260823150731.896-1-luoyonggang@gmail.com/
v2: https://patchew.org/QEMU/20260826184229.1145-1-luoyonggang@gmail.com/
v3: https://patchew.org/QEMU/20260923131635.1894-1-luoyonggang@gmail.com/
branch: https://gitlab.com/lygstate-qemu/qemu/-/tree/single-binary-arm-riscv?ref_type=heads
x86_64 and i386: https://gitlab.com/lygstate-qemu/qemu/-/tree/combined-binary-multi-targets?ref_type=heads

Changes v3 -> v4:

v4 keeps arch:name selection, target none, and query-targets. qemu-system links
ARM and MicroBlaze only.

- Limit the combined binary to aarch64, arm, and microblaze. RISC-V stays on
  qemu-system-riscv32 and qemu-system-riscv64. Remove the target/riscv and
  hw/riscv compile-once patches and the RISC-V TARGET_LONG_BITS rewrites.
- Drop virt QOM prefixes, MachineInfo typename, the shared TYPE_ACCEL_CPU
  parent, virt ACPI prefixes, and the RISC-V crc32, crc32c, and wfi helper
  renames. Those names are already unique for ARM and MicroBlaze.
- Drop TargetCpuOps, AccelClass is_available, the move of kvm and whpx onto
  system_ss, and TargetInfo-gated migration fields.
- The combined binary registers every machine and filters with is_available
  for the selected target. v3 skipped that filter while the target was none.

v4 builds without these series:

  [PATCH v2 0/9] machine: uniquify virt QOM names
  https://patchew.org/QEMU/20260922215533.641-1-luoyonggang@gmail.com/
  [PATCH 00/21] accel/tcg: share raise_excp across TCG targets
  https://patchew.org/QEMU/20260918004225.827-1-luoyonggang@gmail.com/
  [PATCH v5 00/11] single-binary: Compile hw/riscv once
  https://patchew.org/QEMU/20260918-hw-riscv-cpu-int-v5-0-f98c5a244636@rev.ng/

Anton Johansson via qemu development (1):
  target-info: Introduce target_riscv32

Pierrick Bouvier (2):
  configs/targets: remove target info definitions
  target-info: rename target-info-stub.c in target-info-def.c

Yonggang Luo (52):
  target-info: rename target-info-impl.h to target-info-def.h
  vl: parse early options before target-info init
  target-info: replace QOM registration with a constructor list
  tests/unit: add test-target-info
  tests/qtest: prepare machine-list-test for combined qemu-system
  kconfig: rename REGISTER to HW_REGISTER
  target-info: add TargetKconfig
  target-info: add target_is_* helpers for each architecture
  target-info: add target_is_any()
  qom: pass TargetInfo to is_available for latter use
  target/arm: move kvm_arm_set_cpreg_mig_tolerances to kvm.c
  target/arm: allow -cpu host with Nitro
  target/arm: gate -cpu host with TypeIsAvailable
  target/arm: replace target_long in A64 translate
  target/arm: use vaddr for the A64 insn_start pc
  tests/qtest: raise aspeed_smc-test timeout to 12 minutes
  target-info: add tl_is_64() and target_is_tl32/64 helpers
  tcg: declare TCGv in tcg.h
  tcg: dispatch TL memory helpers from tcg-op-mem.h
  tcg: dispatch tcg_gen_*_tl without TARGET_LONG_BITS
  tcg: dispatch tcg_gen_gvec_dup_tl at runtime
  tcg: give common-system helper tl an i64 slot
  accel/tcg: move helper_exit_atomic next to cpu_loop_exit_atomic
  tcg: move dup_const into tcg.c
  tcg: move goto_tb helpers into tcg-op-ldst.c
  accel/tcg: move gvec helpers into tcg-runtime-gvec.h
  accel/tcg: move helper_lookup_tb_ptr into cpu-exec.h
  accel/tcg: move memory helpers out of tcg-runtime.h
  tests/unit: cover common-system tl dispatch and calls
  target/arm: fix A64 guest address width at 64
  target/arm: pass tl temps into SVE and SME helpers
  exec: provide target_ulong for softmmu common code
  exec: compile abi_ptr.h without per-target cpu-param.h
  accel/tcg: keep cpu-ldst endian aliases per-target
  target/arm: fold arm_ss into common source sets
  target/microblaze: fold system sources into common source sets
  meson: link shared objects into qemu-system
  target-info: add SysEmuTarget none
  module: load every arch-tagged module when target is none
  accel/tcg: tolerate NULL target_cpu_type for -M none
  target-info: select combined qemu-system target by name
  vl: parse arch: machine types on combined qemu-system
  qapi: add query-targets
  target-info: add target_is_microblaze
  hw/microblaze: set petalogix-s3adsp1800 TypeInfo.is_available
  hw/microblaze: expand petalogix-ml605 and xlnx-zynqmp-pmu to TypeInfo
  hw/arm: expand leftover 32-bit DEFINE_MACHINE to TypeInfo
  hw/arm: expand imx8mm-evk DEFINE_MACHINE to TypeInfo
  hw/arm: set virt TypeInfo.is_available
  hw/arm: set remaining 32-bit machine TypeInfo.is_available
  hw/arm: set aarch64-only machine TypeInfo.is_available
  tests/qtest: cover combined qemu-system machines

 accel/tcg/atomic_common.c.inc                 |   4 +
 accel/tcg/atomic_common.h                     |  70 ++
 accel/tcg/cpu-exec-common.c                   |  10 +
 accel/tcg/cpu-exec-common.h                   |   1 +
 accel/tcg/cpu-exec.c                          |   5 +
 accel/tcg/cpu-exec.h                          |   1 +
 accel/tcg/ldst_common.c.inc                   |   4 +
 accel/tcg/ldst_common.h                       |  13 +
 accel/tcg/meson.build                         |   2 +-
 accel/tcg/tcg-all.c                           |   9 +-
 accel/tcg/tcg-runtime-gvec.c                  |   3 +
 .../tcg/{tcg-runtime.h => tcg-runtime-gvec.h} | 111 ---
 accel/tcg/tcg-runtime.c                       |   8 -
 accel/tcg/tcg-runtime.h                       | 293 ------
 configs/targets/aarch64-softmmu.c             |  25 -
 configs/targets/arm-softmmu.c                 |  25 -
 configs/targets/meson.build                   |   6 -
 configs/targets/riscv32-softmmu.c             |  24 -
 configs/targets/riscv64-softmmu.c             |  24 -
 hw/Kconfig                                    |   2 +-
 hw/arm/aspeed_ast1040_evb.c                   |   1 +
 hw/arm/aspeed_ast10x0_evb.c                   |   2 +
 hw/arm/aspeed_ast2400_palmetto.c              |   1 +
 hw/arm/aspeed_ast2400_quanta-q71l.c           |   1 +
 hw/arm/aspeed_ast2400_supermicrox11.c         |   1 +
 hw/arm/aspeed_ast2500_evb.c                   |   1 +
 hw/arm/aspeed_ast2500_g220a.c                 |   1 +
 hw/arm/aspeed_ast2500_romulus.c               |   1 +
 hw/arm/aspeed_ast2500_supermicro-x11spi.c     |   1 +
 hw/arm/aspeed_ast2500_tiogapass.c             |   1 +
 hw/arm/aspeed_ast2500_witherspoon.c           |   1 +
 hw/arm/aspeed_ast2500_yosemitev2.c            |   1 +
 hw/arm/aspeed_ast2600_anacapa.c               |   1 +
 hw/arm/aspeed_ast2600_bletchley.c             |   1 +
 hw/arm/aspeed_ast2600_catalina.c              |   1 +
 hw/arm/aspeed_ast2600_evb.c                   |   1 +
 hw/arm/aspeed_ast2600_fby35.c                 |   1 +
 hw/arm/aspeed_ast2600_fuji.c                  |   1 +
 hw/arm/aspeed_ast2600_gb200nvl.c              |   1 +
 hw/arm/aspeed_ast2600_rainier.c               |   1 +
 hw/arm/aspeed_ast2600_sanmiguel.c             |   1 +
 hw/arm/aspeed_ast27x0-fc.c                    |   2 +-
 hw/arm/aspeed_ast27x0_evb.c                   |   4 +-
 hw/arm/ax3000-evk.c                           |   1 +
 hw/arm/b-l475e-iot01a.c                       |   1 +
 hw/arm/bananapi_m2u.c                         |  22 +-
 hw/arm/collie.c                               |   1 +
 hw/arm/cubieboard.c                           |  23 +-
 hw/arm/digic_boards.c                         |  19 +-
 hw/arm/exynos4_boards.c                       |   2 +
 hw/arm/imx25_pdk.c                            |  19 +-
 hw/arm/imx8mm-evk.c                           |  23 +-
 hw/arm/imx8mp-evk.c                           |   1 +
 hw/arm/integratorcp.c                         |  23 +-
 hw/arm/kzm.c                                  |  19 +-
 hw/arm/max78000fthr.c                         |  19 +-
 hw/arm/mcimx6ul-evk.c                         |  19 +-
 hw/arm/mcimx7d-sabre.c                        |  23 +-
 hw/arm/microbit.c                             |   1 +
 hw/arm/mps2-tz.c                              |   5 +
 hw/arm/mps2.c                                 |   4 +
 hw/arm/mps3r.c                                |   1 +
 hw/arm/msf2-som.c                             |  19 +-
 hw/arm/musca.c                                |   2 +
 hw/arm/netduino2.c                            |  19 +-
 hw/arm/netduinoplus2.c                        |  19 +-
 hw/arm/npcm7xx_boards.c                       |   5 +
 hw/arm/npcm8xx_boards.c                       |   1 +
 hw/arm/olimex-stm32-h405.c                    |  19 +-
 hw/arm/omap_sx1.c                             |   2 +
 hw/arm/orangepi.c                             |  23 +-
 hw/arm/raspi.c                                |   7 +-
 hw/arm/raspi4b.c                              |   2 +-
 hw/arm/realview.c                             |   4 +
 hw/arm/sabrelite.c                            |   1 +
 hw/arm/sbsa-ref.c                             |   1 +
 hw/arm/stellaris.c                            |   2 +
 hw/arm/stm32vldiscovery.c                     |  19 +-
 hw/arm/versatilepb.c                          |   2 +
 hw/arm/vexpress.c                             |   2 +
 hw/arm/virt.c                                 |   1 +
 hw/arm/xen-pvh.c                              |   1 +
 hw/arm/xilinx_zynq.c                          |   1 +
 hw/arm/xlnx-versal-virt.c                     |   2 +
 hw/arm/xlnx-zcu102.c                          |   1 +
 hw/core/Kconfig                               |   2 +-
 hw/core/machine-qmp-cmds.c                    |  30 +
 hw/core/meson.build                           |   2 +-
 hw/dma/Kconfig                                |   4 +-
 hw/i2c/Kconfig                                |   2 +-
 hw/microblaze/petalogix_ml605_mmu.c           |  19 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c      |   1 +
 hw/microblaze/xlnx-zynqmp-pmu.c               |  19 +-
 hw/usb/Kconfig                                |   2 +-
 include/accel/tcg/cpu-ldst.h                  |   4 +-
 include/exec/abi_ptr.h                        |   7 +-
 include/exec/helper-gen-common.h              |  20 +
 include/exec/helper-head.h.inc                |  21 +-
 include/exec/helper-proto-common.h            |  20 +
 include/exec/target_long.h                    |  11 +
 include/qemu/config-file.h                    |   2 +
 include/qemu/module.h                         |   1 -
 include/qemu/target-info-def.h                |  90 ++
 include/qemu/target-info-impl.h               |  42 -
 include/qemu/target-info-init.h               |  53 --
 include/qemu/target-info-qom.h                |  30 -
 include/qemu/target-info-select.h             |  24 +
 include/qemu/target-info.h                    | 174 +++-
 include/qemu/target-kconfig-has.h             |   7 +
 include/qemu/target-kconfig.h                 |  34 +
 include/qom/object.h                          |  26 +-
 include/tcg/tcg-op-gvec.h                     |  21 +-
 include/tcg/tcg-op-mem.h                      | 114 ++-
 include/tcg/tcg-op-tl.h                       | 568 ++++++++++++
 include/tcg/tcg-op.h                          | 291 +-----
 include/tcg/tcg.h                             |  73 +-
 meson.build                                   | 233 ++++-
 page-vary-common.c                            |   2 +-
 page-vary-system.c                            |   2 +-
 qapi/machine.json                             |  48 +-
 qemu-options.hx                               |  11 +-
 qom/object.c                                  |  20 +-
 scripts/gen-target-kconfig.py                 | 162 ++++
 stubs/meson.build                             |   1 +
 stubs/target-info-select.c                    |  14 +
 system/target-info-select.c                   |  26 +
 system/vl.c                                   | 312 ++++++-
 target-info-stub.c => target-info-def.c       |   9 +-
 target-info-qom.c                             |  55 --
 target-info.c                                 | 180 +++-
 target-kconfig.c                              |  20 +
 target/arm/cpu.c                              |   6 +-
 target/arm/cpu.h                              |   1 +
 target/arm/cpu64.c                            |  80 +-
 target/arm/hvf/hvf-stub.c                     |  14 +
 target/arm/hvf/meson.build                    |   1 +
 target/arm/kvm-stub.c                         |   5 +
 target/arm/kvm.c                              |  36 +
 target/arm/kvm_arm.h                          |   9 +
 target/arm/meson.build                        |   4 +-
 target/arm/tcg/translate-a64.c                |   6 +-
 target/arm/tcg/translate-a64.h                |   3 +
 target/arm/tcg/translate-sme.c                |   5 +-
 target/arm/tcg/translate-sve.c                |  18 +-
 target/arm/whpx/whpx-stub.c                   |   5 +
 target/microblaze/meson.build                 |   2 +-
 target/none/cpu-param.h                       |   7 +
 target/none/cpu-qom.h                         |   6 +
 target/none/cpu.h                             |  18 +
 tcg/meson.build                               |   9 +-
 tcg/tcg-op-gvec.c                             |  17 -
 tcg/tcg-op-ldst.c                             |  31 +
 tcg/tcg-op.c                                  |  32 -
 tcg/tcg.c                                     |  52 +-
 tests/qtest/fuzz/fuzz.c                       |   3 -
 .../qtest/machine-list-combined-targets.h.in  |   4 +
 tests/qtest/machine-list-combined-test.c      | 104 +++
 tests/qtest/machine-list-test.c               |  94 ++
 tests/qtest/machine-list-test.inc.h           | 876 ++++++++++++++++++
 tests/qtest/machine-option-test.c             | 714 ++++++++++++++
 tests/qtest/meson.build                       |  41 +-
 tests/unit/meson.build                        |  35 +
 tests/unit/test-helper-tl.c                   |  20 +
 tests/unit/test-helper-tl.h                   |  25 +
 tests/unit/test-helper-tl32.c                 |  27 +
 tests/unit/test-helper-tl64.c                 |  27 +
 tests/unit/test-target-info.c                 |  38 +
 tests/unit/test-target-kconfig-has.c          |  22 +
 tests/unit/test-tcg-call-tl-stubs.c           |  45 +
 tests/unit/test-tcg-call-tl.c                 | 280 ++++++
 tests/unit/test-tcg-op-dispatch.h             | 203 ++++
 tests/unit/test-tcg-op-mem-config32.h         |   2 +
 tests/unit/test-tcg-op-mem-config64.h         |   2 +
 tests/unit/test-tcg-op-mem-tl32.c             |  26 +
 tests/unit/test-tcg-op-mem-tl64.c             |  26 +
 tests/unit/test-tcg-op-mem-va32-tl64.c        |  35 +
 tests/unit/test-tcg-op-mem.c                  |  51 +
 tests/unit/test-tcg-op-tl32.c                 |  24 +
 tests/unit/test-tcg-op-tl64.c                 |  24 +
 tests/unit/test-tcg-op.c                      |  66 ++
 util/module.c                                 |   4 +-
 util/qemu-config.c                            |  10 +-
 182 files changed, 5772 insertions(+), 1281 deletions(-)
 create mode 100644 accel/tcg/atomic_common.h
 create mode 100644 accel/tcg/cpu-exec-common.h
 create mode 100644 accel/tcg/cpu-exec.h
 create mode 100644 accel/tcg/ldst_common.h
 copy accel/tcg/{tcg-runtime.h => tcg-runtime-gvec.h} (70%)
 delete mode 100644 configs/targets/aarch64-softmmu.c
 delete mode 100644 configs/targets/arm-softmmu.c
 delete mode 100644 configs/targets/meson.build
 delete mode 100644 configs/targets/riscv32-softmmu.c
 delete mode 100644 configs/targets/riscv64-softmmu.c
 create mode 100644 include/qemu/target-info-def.h
 delete mode 100644 include/qemu/target-info-impl.h
 delete mode 100644 include/qemu/target-info-init.h
 delete mode 100644 include/qemu/target-info-qom.h
 create mode 100644 include/qemu/target-info-select.h
 create mode 100644 include/qemu/target-kconfig-has.h
 create mode 100644 include/qemu/target-kconfig.h
 create mode 100644 include/tcg/tcg-op-tl.h
 create mode 100644 scripts/gen-target-kconfig.py
 create mode 100644 stubs/target-info-select.c
 create mode 100644 system/target-info-select.c
 rename target-info-stub.c => target-info-def.c (88%)
 delete mode 100644 target-info-qom.c
 create mode 100644 target-kconfig.c
 create mode 100644 target/arm/hvf/hvf-stub.c
 create mode 100644 target/none/cpu-param.h
 create mode 100644 target/none/cpu-qom.h
 create mode 100644 target/none/cpu.h
 create mode 100644 tests/qtest/machine-list-combined-targets.h.in
 create mode 100644 tests/qtest/machine-list-combined-test.c
 create mode 100644 tests/qtest/machine-list-test.c
 create mode 100644 tests/qtest/machine-list-test.inc.h
 create mode 100644 tests/qtest/machine-option-test.c
 create mode 100644 tests/unit/test-helper-tl.c
 create mode 100644 tests/unit/test-helper-tl.h
 create mode 100644 tests/unit/test-helper-tl32.c
 create mode 100644 tests/unit/test-helper-tl64.c
 create mode 100644 tests/unit/test-target-info.c
 create mode 100644 tests/unit/test-target-kconfig-has.c
 create mode 100644 tests/unit/test-tcg-call-tl-stubs.c
 create mode 100644 tests/unit/test-tcg-call-tl.c
 create mode 100644 tests/unit/test-tcg-op-dispatch.h
 create mode 100644 tests/unit/test-tcg-op-mem-config32.h
 create mode 100644 tests/unit/test-tcg-op-mem-config64.h
 create mode 100644 tests/unit/test-tcg-op-mem-tl32.c
 create mode 100644 tests/unit/test-tcg-op-mem-tl64.c
 create mode 100644 tests/unit/test-tcg-op-mem-va32-tl64.c
 create mode 100644 tests/unit/test-tcg-op-mem.c
 create mode 100644 tests/unit/test-tcg-op-tl32.c
 create mode 100644 tests/unit/test-tcg-op-tl64.c
 create mode 100644 tests/unit/test-tcg-op.c

-- 
2.52.0.windows.1

