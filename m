Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD0A49E13D
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169413; cv=none; b=qc0+H7+S08u4/kCVlUjCEANX/s6kj94NX/PhhyO6C7swoLu4GAvsHmrUibNLVItl4xfiityEK8Fd54GwSqcnmQ9kUROBjRQMeIjb7mfEEDWSYEGJSDa6+ksDaWolbKDgKuzDU6if/Y1dP1f3SFUzORm/+2LDMKP8e0fTZxU0Vio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169413; c=relaxed/simple;
	bh=BJ4v4tXFLNF0m2TSky3L096NziFBCNwsqJN2P4e2qAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YVYorp35pQcXkQr+L+V0N5uc3yKVmLfTM0P7lN+Rfl9xZpfFCdsOvMNOEFY3NLqYu/GNTbc5mPKTE7jb7hhIgbuXfhbpncH4nILJccE8HGNx15bWnAFMJ95EpkEXSJTwEvs8IGhhN1+x8iqMo0LgGCLqohSlhSYzVvlZ5w61Oco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HU5slrNZ; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU5slrNZ"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3115c4451c8so635306eec.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169409; x=1790774209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p8tyiRwxKQdp0RZD4SXOyBX8lB+B9XyIJi0FcZ12QW8=;
        b=HU5slrNZYLlYyE98hapyzD/i93srdk7zdAzbDuV5pDXiD/PBvw51iI/4oKQRjKF+OL
         G4h4NmpHlmGXojzHUDmNzgvLmEVjNLiB+pLQDh+PHN/mghvz1quARwzdESx8PZro+7z2
         VWzj9JNv+gz4UsxvWuNAwJ8C6mbZhalcbFwZUDEZePjmBn0BdYb6ghHiDPlQXDyFohjy
         agd7rwa9GV6/KoAAT3JkIOQ6oetU8wdI0ksZL/GJ4hJ/A5sKY9jjRSetNTSnQ/qqqzz8
         NyibJmHTGDdYRhd7ergxD0ms7WRJfhtvmXnH4+umAQDsOwyT4xRqnI8mRScyKsjynHYt
         TfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169409; x=1790774209;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p8tyiRwxKQdp0RZD4SXOyBX8lB+B9XyIJi0FcZ12QW8=;
        b=YjH3Dtj0LbuaDKjXlZQk+KDnky03MY3JSewQkWx5rXVRDt7hRiMzMQ51imyHP/uTpD
         O0lHd3selAzSNW/hIUWyP4jNuICBuC7MrJRoaGRZ7Mee+rA6sIMmZx9hgZjvs5wqRASa
         Nmgn6uEFP52xtrREhpsjzL5iPsf8As6RsowTQ2m12cLEACkDNuoXsjK9If+ztCJTito4
         9oIVccCfLcLWqh3cSSZtz/v7gJMqbRLZ0k7dBJr40j8qaV/22W5dMtwxC9SKnbUBTOjO
         L028UwEQL8RZukZ+8CzRgGRKvKAJngroUiUqW3+XWNkxjjeW7QgdyCrehjRIidqjcZR8
         Iw5w==
X-Forwarded-Encrypted: i=1; AKwUvBzoEzQq1SSxZkrgbNiEzGV7lCuq2hPmnnA45BNqCZlTcBRkYQ68GF/cA8sVpocN/h4WW+k=@vger.kernel.org
X-Gm-Message-State: AFuF++kdl6OQu0DsXyLy/UqWOSzpxFEXOPQaF+zGbV8r/+ysHB2zsRzl
	eTJMHiJy48VXC/X480SWUuCgBbaRBITiOel0/+GIGxESK/tvtHEkv0xB
X-Gm-Gg: AYBFou1GVCIlsklR9Q3gmHK3QgmnDtuzQOx+1PpwxSf/S4ubjGWm5un0uezYrNvYgMo
	5rHFCzevYQbFiJO0zCniTbxtXK14v51n57x5dGbzjMNEyegS5m7yAnbhcfNEuVxBGEkE8fNDozK
	r6XyoffIB076UMleo3qc3mj4AMfGNJxRa3xR/d3TGNuZ1TYMZK7NQRctJ/R56r0CnIDc9f/dr7d
	HM8jeagVDBJnVhhSPg2jMN4o7rJZxwGBG48xdLYRWPiFUesHXGvq/Tx+FE0aIFQB9Bp9SpOUwsd
	ZyX18yg7rRiblK2KhsXzOBKGKRYVFEHjZGZ6K9Y7A4v8/DMrZYMaSQK3m9jlSspcmIk508yoN8G
	TnGzIQ+ddrPHPvLdkPffKlEKGkhpBenrRdC5nhIudW7QZ4p2JMeeAq3QlcnbW/VIBkKhM7X0cw5
	vNO1RE0dG3XIIiQ6x5lCoalw7dmdR3Zr9Oz4luUZ+1C0N15ivyjGkhCoQRhjmgBwHCZYrYITBSp
	bEsnhx5y/EW9p6t3yqlVRYMxGa6pYY=
X-Received: by 2002:a05:7301:d586:b0:33e:5f5a:4b55 with SMTP id 5a478bee46e88-33e5f5a53f6mr2889546eec.19.1790169407963;
        Wed, 23 Sep 2026 06:16:47 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:16:46 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>,
	xen-devel@lists.xenproject.org,
	Chao Liu <chao.liu@processmission.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Peter Xu <peterx@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Fabiano Rosas <farosas@suse.de>,
	Xianglai Li <lixianglai@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	qemu-ppc@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Bibo Mao <maobibo@loongson.cn>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	David Hildenbrand <david@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	qemu-riscv@nongnu.org,
	kvm@vger.kernel.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Song Gao <17746591750@163.com>,
	qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org,
	Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 000/114] single-binary: link multi-targets into qemu-system
Date: Wed, 23 Sep 2026 21:14:34 +0800
Message-ID: <20260923131635.1894-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This series produces one qemu-system binary that can run ARM (32 and
64), RISC-V (32 and 64), and MicroBlaze.
Upstream filters machines with TypeInfo.is_available. This series
passes a TargetInfo into that callback, uniquifies QOM names that
collide in one process, and compiles those targets once so they can
share qemu-system.

A combined link cannot keep C symbols or QOM type names that were
unique only because each qemu-system-$arch was a separate binary.
These patches remove those collisions:

- TYPE_ACCEL_CPU is the fixed abstract type accel-cpu, registered
  once next to TYPE_ACCEL. Leaf names still encode the CPU type so
  accel_init_cpu_interfaces() can look up "<accel>-" plus
  target_cpu_type() (tcg-accel-arm-cpu).
- virt QOM names are prefixed: arm-virt, riscv-virt, and the same
  for or1k, hexagon, loongarch, m68k, and xtensa. Boards keep
  -machine virt via machine_class_set_name(). query-machines returns
  the QOM type in MachineInfo typename.
- virt ACPI helpers and RISC-V TCG crc32/crc32c/wfi helpers get an
  arch prefix so the combined link does not need meson -D name
  mangling. LoongArch virt_acpi_setup is renamed in the same pass.

Target selection has to work with more than one TargetInfo:

- The combined binary takes arch:name on -M/-machine and in a
  [machine] type (aarch64:virt). arch: binds the target. microblaze:
  runs that target's default machine. arm, aarch64, riscv32, and
  riscv64 have no default. No -M leaves target none and the empty
  none machine. qemu-system-$arch keeps the historic -M name.
  -M help lists every target; arch:help lists one. query-targets
  lists each linked target, including none.
- TargetInfo is a constructor list. target_info_select() picks the
  entry, including SYS_EMU_TARGET_NONE. is_available takes const
  TargetInfo *. While the target is still none, QOM skips the
  unavailable filter so grouped -M help can list every machine.
- query-cpu-definitions, dump notes, and Angel semihosting sit on
  TargetCpuOps indexed by target_arch(). Registration uses a
  QEMU_ARCH_* bitmask so one object can fill ARM and AARCH64. The
  table is target-ops.h / target-ops.c.

qemu-system-$TARGET is still built, including the Windows *w twin.
qemu-system is extra. It links each target whose arch sources are
only target-info-def.c: arm, aarch64, riscv32, riscv64, and
microblaze. Do not add qemu-systemw for that binary. A GUI
twin would keep QEMU exporting data from the .exe into DLLs, and
those data exports cannot be delay-loaded (qdev_prop_array and
other qdev_prop_*). That would block enabling modules globally on
Windows.

Examples:

  qemu-system -M aarch64:virt ...
  qemu-system -M microblaze:petalogix-s3adsp1800 ...
  qemu-system-riscv64 -M virt ...

A bare machine name on qemu-system needs an arch: prefix. An unknown
target fails with "target '...' is not available".

Prerequisites:
  [PATCH v2 0/9] machine: uniquify virt QOM names
  https://patchew.org/QEMU/20260922215533.641-1-luoyonggang@gmail.com/
  [PATCH 00/21] accel/tcg: share raise_excp across TCG targets
  https://patchew.org/QEMU/20260918004225.827-1-luoyonggang@gmail.com/
  [PATCH v5 00/11] single-binary: Compile hw/riscv once
  https://patchew.org/QEMU/20260918-hw-riscv-cpu-int-v5-0-f98c5a244636@rev.ng/

v1: https://patchew.org/QEMU/20260823150731.896-1-luoyonggang@gmail.com/
v2: https://patchew.org/QEMU/20260826184229.1145-1-luoyonggang@gmail.com/
branch: https://gitlab.com/lygstate-qemu/qemu/-/tree/single-binary-arm-riscv?ref_type=heads
x86_64 and i386: https://gitlab.com/lygstate-qemu/qemu/-/tree/combined-binary-multi-targets?ref_type=heads

Changes v2 -> v3:
- Drop -target. v2 parsed a target_name token and required it on
  bare qemu-system, with -target ? to list names. v3 selects the
  target with arch:name on -M. No -M leaves target none. -M help
  and arch:help list machines.
- Rebased onto current master. Upstream is_available(void) replaces
  TYPE_TARGET_SPECIFIC. v3 passes const TargetInfo * into
  is_available. The v2 patches that registered TYPE_TARGET_SPECIFIC
  on ARM and RISC-V virt are dropped.
- TargetInfo is a constructor list, not chosen from argv[0].
  target_info_select() sets the current entry. Add SysEmuTarget
  none. A single-target binary does not switch TargetInfo; arch:
  must match that binary or the machine is rejected.
- Drop -Dsingle_binary. qemu-system is built from
  single_binary_supported_targets once arch_srcs are only
  target-info-def.c. microblaze joins ARM and RISC-V. Per-target
  binaries stay. Still no qemu-systemw for the combined binary.
- Unique virt QOM names extend past ARM and RISC-V to or1k,
  hexagon, loongarch, m68k, and xtensa. query-machines returns
  MachineInfo typename.
- TargetCpuOps is an array indexed by target_arch(), registered
  with a QEMU_ARCH_* bitmask. The header moves from
  target-info-qom.h to target-ops.h.
- Those targets are compiled once: ARM, RISC-V, and MicroBlaze fold
  into common source sets, TARGET_* ifdefs become runtime checks, and
  KVM moves to system_ss.

Pierrick Bouvier (2):
  configs/targets: remove target info definitions
  target-info: rename target-info-stub.c in target-info-def.c

Yonggang Luo (112):
  meson: stale qemu-version.h only when .git exists
  target-info: rename target-info-impl.h to target-info-def.h
  target-info: set cpu_type from TARGET_BASE_ARCH
  target: remove CPU_RESOLVING_TYPE
  vl: parse early options before target-info init
  target-info: replace QOM registration with a constructor list
  tests/unit: add test-target-info
  tests/qtest: prepare machine-list-test for combined qemu-system
  kconfig: rename REGISTER to HW_REGISTER
  target-info: add TargetKconfig
  target-info: add target_is_* helpers for each architecture
  target-info: add i386 and x86_64 helpers
  qom: pass TargetInfo to is_available
  module: use static ModuleEntry and per-type DSO lists
  module: add before/after hooks and module_call_init_fn
  qom: register late types through module_call_init_fn
  qom: inherit is_available and filter after MODULE_INIT_QOM
  tests/unit: add module-init and qom is-available tests
  hw/arm/virt: prefix ACPI helpers with arm_virt_
  hw/riscv/virt: prefix ACPI helpers with riscv_virt_
  hw/loongarch/virt: prefix ACPI helper with loongarch_virt_
  target/riscv: uniquify TCG crc32, crc32c, and wfi helper names
  hw/riscv: gate boards with target_is_base_riscv
  hw/intc: use target_long_bits in IMSIC geilen
  hw/misc/riscv_cmgcr: replace target_ulong with uint64_t
  hw/intc: use kvm_enabled() in APLIC AIA helpers
  hw/intc: send IMSIC MSI via kvm_irqchip_send_msi()
  target/riscv: add kvm stubs source set
  tcg: fix off-by-one in helper extend-free assert
  gdbstub: drop per-target cpu-param.h from helpers.h
  hw/riscv: expand boston-aia and microblaze-v-generic to TypeInfo
  target/riscv: Include migration/vmstate.h instead of migration/cpu.h
    in machine.c
  target/riscv: gate CPU types with TargetInfo
  target/riscv: select ELF dump class from target_riscv64
  target/riscv: replace TARGET_* macros in CSR helpers
  target/riscv: use target_long_bits in pmpaddr granule checks
  target/riscv: preserve signed XLEN semantics without target_long
  target/riscv: replace leftover TARGET_LONG_BITS
  target/riscv: select monitor width at runtime
  target/riscv: replace target-width format macros
  target/riscv: replace TARGET_LONG_BITS in translate
  target-info: add tl_is_64() and target_is_tl32/64 helpers
  target-info: dispatch CPU QMP, dump, and Angel semihosting
  tcg: give TCGv its own type and runtime tl ops
  exec: allow target_long.h, abi_ptr.h and cpu-ldst.h from common code
  migration: add TargetInfo-gated vmstate fields
  target/i386: always compile XMM, YMMH, and Hi16 VMSD
  target/i386: replace VMSTATE_UINTTL with 32/64 TI fields
  target/ppc: replace VMSTATE_UINTTL with 32/64 TI fields
  target/sparc: replace VMSTATE_UINTTL with 32/64 TI fields
  target/mips: replace VMSTATE_UINTTL with 32/64 TI fields
  hw/hexagon: drop unused migration/cpu.h include
  migration: remove unused cpu.h
  target/riscv: gate KVM CPU VMSDs with target_has_kconfig_kvm
  target/riscv: use tcg_imm_tl in translate
  target/riscv: select FP and amocas width at runtime
  target/riscv: drop TARGET_RISCV XL shortcuts in translate
  target/riscv: select KVM host CPU width at runtime
  accel: use a shared TYPE_ACCEL_CPU parent
  kvm: always compile guest debug
  hw/i386: move APIC_DEFAULT_ADDRESS to apic.h
  kvm: stop including cpu.h from kvm.h
  kvm: default kvm_arch_reset_parked_vcpu in stubs
  kvm: drop COMPILING_PER_TARGET wrap around kvm_arch APIs
  kvm: add split irqchip and send_msi stubs
  kvm: replace TARGET_S390X and TARGET_PPC hints
  kvm: move kvm_ss to system_ss
  system: add qemu_host_arch() and reject unavailable -accel
  kvm: add AccelClass is_available for host/guest pairing
  hvf: add AccelClass is_available for host/guest pairing
  xen: add AccelClass is_available for host/guest pairing
  nitro: add AccelClass is_available for host/guest pairing
  mshv: add AccelClass is_available for host/guest pairing
  whpx: add AccelClass is_available for host/guest pairing
  target/i386/nvmm: add AccelClass is_available for host/guest pairing
  accel: replace ACCEL_CPU_NAME with accel_cpu_register_type
  whpx: move whpx_ss to system_ss
  hw/riscv: move boards and irqchip onto hw_common_arch
  target/riscv: include target_long.h in TCG helpers
  target/riscv: compile CPU and TCG once
  target/arm: replace target_long in A64 translate
  target/arm: use 64-bit TCG addresses in A64 translate
  target/arm: move kvm_arm_set_cpreg_mig_tolerances to kvm.c
  target/arm: allow -cpu host with Nitro
  target/arm: gate -cpu host with TypeIsAvailable
  target/arm: fix family-common KVM compile
  tests/qtest: raise aspeed_smc-test timeout to 12 minutes
  hw/intc: move ARM GIC kvm/hvf/whpx onto arm_common_ss
  target/arm: fold arm_ss into common source sets
  meson: link shared objects into qemu-system
  target/microblaze: fold system sources into common source sets
  meson: add microblaze-softmmu to the combined qemu-system list
  boards: remove unused DEFINE_MACHINE_WITH_INTERFACES
  hw/arm: set virt TypeInfo.is_available
  hw/arm: set remaining 32-bit machine TypeInfo.is_available
  hw/arm: set aarch64-only machine TypeInfo.is_available
  hw/microblaze: set petalogix-s3adsp1800 TypeInfo.is_available
  hw/arm: expand leftover 32-bit DEFINE_MACHINE to TypeInfo
  hw/arm: expand imx8mm-evk DEFINE_MACHINE to TypeInfo
  hw/microblaze: expand petalogix-ml605 and xlnx-zynqmp-pmu to TypeInfo
  hw/i386: set TYPE_X86_MACHINE TypeInfo.is_available
  hw/block/dataplane: move xen-block onto system_ss
  hw/remote: move multiprocess memory onto remote_ss
  hw/remote: set x-remote TypeInfo.is_available
  target-info: add SysEmuTarget none
  accel/tcg: tolerate NULL target_cpu_type for -M none
  qom: skip unavailable filter when target_none()
  module: load every arch-tagged module when target is none
  target-info: select combined qemu-system target by name
  vl: parse arch: machine types on combined qemu-system
  qapi: add query-targets
  tests/qtest: cover combined qemu-system machines and accel-cpu

 MAINTAINERS                                   |    1 -
 accel/accel-common.c                          |   62 +-
 accel/hvf/hvf-all.c                           |   15 +
 accel/kvm/kvm-accel-ops.c                     |    4 -
 accel/kvm/kvm-all.c                           |   45 +-
 accel/kvm/meson.build                         |    2 +-
 accel/mshv/mshv-all.c                         |    8 +
 accel/nitro/nitro-accel.c                     |    8 +
 accel/stubs/kvm-stub.c                        |   11 +
 accel/tcg/tcg-all.c                           |    9 +-
 accel/whpx/meson.build                        |    2 +-
 accel/whpx/whpx-common.c                      |   32 +-
 accel/xen/xen-all.c                           |   18 +
 configs/targets/aarch64-softmmu.c             |   25 -
 configs/targets/aarch64-softmmu.mak           |    1 -
 configs/targets/arm-softmmu.c                 |   25 -
 configs/targets/i386-softmmu.mak              |    2 -
 configs/targets/loongarch64-softmmu.mak       |    1 -
 configs/targets/meson.build                   |    6 -
 configs/targets/ppc-softmmu.mak               |    1 -
 configs/targets/ppc64-softmmu.mak             |    1 -
 configs/targets/riscv32-softmmu.c             |   24 -
 configs/targets/riscv64-softmmu.c             |   24 -
 configs/targets/riscv64-softmmu.mak           |    1 -
 configs/targets/s390x-softmmu.mak             |    1 -
 configs/targets/x86_64-softmmu.mak            |    2 -
 hw/Kconfig                                    |    2 +-
 hw/arm/aspeed_ast1040_evb.c                   |    1 +
 hw/arm/aspeed_ast10x0_evb.c                   |    2 +
 hw/arm/aspeed_ast2400_palmetto.c              |    1 +
 hw/arm/aspeed_ast2400_quanta-q71l.c           |    1 +
 hw/arm/aspeed_ast2400_supermicrox11.c         |    1 +
 hw/arm/aspeed_ast2500_evb.c                   |    1 +
 hw/arm/aspeed_ast2500_g220a.c                 |    1 +
 hw/arm/aspeed_ast2500_romulus.c               |    1 +
 hw/arm/aspeed_ast2500_supermicro-x11spi.c     |    1 +
 hw/arm/aspeed_ast2500_tiogapass.c             |    1 +
 hw/arm/aspeed_ast2500_witherspoon.c           |    1 +
 hw/arm/aspeed_ast2500_yosemitev2.c            |    1 +
 hw/arm/aspeed_ast2600_anacapa.c               |    1 +
 hw/arm/aspeed_ast2600_bletchley.c             |    1 +
 hw/arm/aspeed_ast2600_catalina.c              |    1 +
 hw/arm/aspeed_ast2600_evb.c                   |    1 +
 hw/arm/aspeed_ast2600_fby35.c                 |    1 +
 hw/arm/aspeed_ast2600_fuji.c                  |    1 +
 hw/arm/aspeed_ast2600_gb200nvl.c              |    1 +
 hw/arm/aspeed_ast2600_rainier.c               |    1 +
 hw/arm/aspeed_ast2600_sanmiguel.c             |    1 +
 hw/arm/aspeed_ast27x0-fc.c                    |    2 +-
 hw/arm/aspeed_ast27x0_evb.c                   |    4 +-
 hw/arm/ax3000-evk.c                           |    1 +
 hw/arm/b-l475e-iot01a.c                       |    1 +
 hw/arm/bananapi_m2u.c                         |   22 +-
 hw/arm/collie.c                               |    1 +
 hw/arm/cubieboard.c                           |   23 +-
 hw/arm/digic_boards.c                         |   19 +-
 hw/arm/exynos4_boards.c                       |    2 +
 hw/arm/imx25_pdk.c                            |   19 +-
 hw/arm/imx8mm-evk.c                           |   23 +-
 hw/arm/imx8mp-evk.c                           |    1 +
 hw/arm/integratorcp.c                         |   23 +-
 hw/arm/kzm.c                                  |   19 +-
 hw/arm/max78000fthr.c                         |   19 +-
 hw/arm/mcimx6ul-evk.c                         |   19 +-
 hw/arm/mcimx7d-sabre.c                        |   23 +-
 hw/arm/microbit.c                             |    1 +
 hw/arm/mps2-tz.c                              |    5 +
 hw/arm/mps2.c                                 |    4 +
 hw/arm/mps3r.c                                |    1 +
 hw/arm/msf2-som.c                             |   19 +-
 hw/arm/musca.c                                |    2 +
 hw/arm/netduino2.c                            |   19 +-
 hw/arm/netduinoplus2.c                        |   19 +-
 hw/arm/npcm7xx_boards.c                       |    5 +
 hw/arm/npcm8xx_boards.c                       |    1 +
 hw/arm/olimex-stm32-h405.c                    |   19 +-
 hw/arm/omap_sx1.c                             |    2 +
 hw/arm/orangepi.c                             |   23 +-
 hw/arm/raspi.c                                |    7 +-
 hw/arm/raspi4b.c                              |    2 +-
 hw/arm/realview.c                             |    4 +
 hw/arm/sabrelite.c                            |    1 +
 hw/arm/sbsa-ref.c                             |    1 +
 hw/arm/stellaris.c                            |    2 +
 hw/arm/stm32vldiscovery.c                     |   19 +-
 hw/arm/versatilepb.c                          |    2 +
 hw/arm/vexpress.c                             |    2 +
 hw/arm/virt-acpi-build.c                      |    4 +-
 hw/arm/virt.c                                 |   13 +-
 hw/arm/xen-pvh.c                              |    1 +
 hw/arm/xilinx_zynq.c                          |    1 +
 hw/arm/xlnx-versal-virt.c                     |    2 +
 hw/arm/xlnx-zcu102.c                          |    1 +
 hw/block/dataplane/meson.build                |    2 +-
 hw/core/Kconfig                               |    2 +-
 hw/core/cpu-system.c                          |   23 +
 hw/core/machine-qmp-cmds.c                    |   57 +
 hw/core/meson.build                           |    2 +-
 hw/dma/Kconfig                                |    4 +-
 hw/hexagon/hexagon_dsp.c                      |    1 -
 hw/i2c/Kconfig                                |    2 +-
 hw/i386/acpi-common.c                         |    1 +
 hw/i386/sgx.c                                 |    1 +
 hw/i386/vmport.c                              |    1 +
 hw/i386/x86.c                                 |    2 +
 hw/intc/arm_gic_kvm.c                         |    1 +
 hw/intc/arm_gicv3_its_kvm.c                   |    1 +
 hw/intc/arm_gicv3_kvm.c                       |    1 +
 hw/intc/meson.build                           |   16 +-
 hw/intc/riscv_aplic.c                         |   14 +-
 hw/intc/riscv_imsic.c                         |   18 +-
 hw/intc/s390_flic.c                           |    1 +
 hw/intc/s390_flic_kvm.c                       |    1 +
 hw/loongarch/virt-acpi-build.c                |    6 +-
 hw/loongarch/virt.c                           |    2 +-
 hw/microblaze/petalogix_ml605_mmu.c           |   19 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c      |    1 +
 hw/microblaze/xlnx-zynqmp-pmu.c               |   19 +-
 hw/misc/meson.build                           |    4 +-
 hw/misc/riscv_cmgcr.c                         |    2 +-
 hw/remote/machine.c                           |    3 +
 hw/remote/meson.build                         |    4 +-
 hw/riscv/boston-aia.c                         |    4 +-
 hw/riscv/k230.c                               |    5 +-
 hw/riscv/microblaze-v-generic.c               |   19 +-
 hw/riscv/microchip_pfsoc.c                    |    5 +-
 hw/riscv/opentitan.c                          |    5 +-
 hw/riscv/shakti_c.c                           |    5 +-
 hw/riscv/sifive_e.c                           |    1 +
 hw/riscv/sifive_u.c                           |    1 +
 hw/riscv/spike.c                              |    1 +
 hw/riscv/tt_atlantis.c                        |    5 +-
 hw/riscv/virt-acpi-build.c                    |    2 +-
 hw/riscv/virt.c                               |    7 +-
 hw/riscv/xiangshan_kmh.c                      |    5 +-
 hw/s390x/css.c                                |    1 +
 hw/s390x/s390-pci-bus.c                       |    1 +
 hw/s390x/s390-pci-inst.c                      |    1 +
 hw/s390x/virtio-ccw.c                         |    1 +
 hw/timer/meson.build                          |    2 +-
 hw/usb/Kconfig                                |    2 +-
 include/accel/accel-cpu-target.h              |   31 -
 include/accel/accel-cpu.h                     |   13 +
 include/accel/tcg/cpu-ldst.h                  |    4 +-
 include/exec/abi_ptr.h                        |    7 +-
 include/exec/helper-head.h.inc                |   21 +-
 include/exec/poison.h                         |    2 +
 include/exec/target_long.h                    |   13 +
 include/gdbstub/helpers.h                     |    3 -
 include/hw/arm/virt.h                         |    4 +-
 include/hw/core/boards.h                      |   10 +-
 include/hw/i386/apic.h                        |    3 +
 include/hw/loongarch/virt.h                   |    2 +-
 include/hw/riscv/virt.h                       |    4 +-
 include/migration/cpu.h                       |   30 -
 include/migration/vmstate.h                   |  125 ++
 include/qemu/base-arch-defs.h                 |    9 +
 include/qemu/config-file.h                    |    2 +
 include/qemu/module.h                         |   41 +-
 include/qemu/queue.h                          |   10 +
 include/qemu/target-info-def.h                |   90 ++
 include/qemu/target-info-impl.h               |   42 -
 include/qemu/target-info-init.h               |   53 -
 include/qemu/target-info-qom.h                |   30 -
 include/qemu/target-info-select.h             |   24 +
 include/qemu/target-info.h                    |  214 +++-
 include/qemu/target-kconfig-has.h             |    7 +
 include/qemu/target-kconfig.h                 |   34 +
 include/qemu/target-ops.h                     |   58 +
 include/qom/object.h                          |   27 +-
 include/semihosting/common-semi.h             |   63 +-
 include/system/kvm.h                          |   23 +-
 include/system/kvm_int.h                      |    2 -
 include/tcg/tcg-op-common.h                   |    2 +
 include/tcg/tcg-op-gvec-common.h              |   12 +
 include/tcg/tcg-op-gvec.h                     |   12 -
 include/tcg/tcg-op-mem.h                      |   96 +-
 include/tcg/tcg-op-tl.h                       | 1133 +++++++++++++++++
 include/tcg/tcg-op.h                          |  293 +----
 include/tcg/tcg.h                             |   42 +-
 meson.build                                   |  221 +++-
 migration/savevm.c                            |    4 +
 migration/trace-events                        |    1 +
 migration/vmstate-types.c                     |   86 ++
 migration/vmstate.c                           |  135 +-
 page-vary-common.c                            |    2 +-
 page-vary-system.c                            |    2 +-
 qapi/machine.json                             |   48 +-
 qemu-options.hx                               |   11 +-
 qom/object.c                                  |  145 ++-
 rust/util/src/module.rs                       |   16 +-
 scripts/gen-target-kconfig.py                 |  162 +++
 stubs/dump.c                                  |   27 -
 stubs/kvm.c                                   |    4 +
 stubs/meson.build                             |    3 +-
 stubs/qmp-cpu.c                               |   21 -
 stubs/target-info-select.c                    |   14 +
 system/arch_init.c                            |   19 +
 system/target-info-select.c                   |   26 +
 system/vl.c                                   |  319 ++++-
 target-info-stub.c => target-info-def.c       |   20 +-
 target-info-qom.c                             |   55 -
 target-info.c                                 |  213 +++-
 target-kconfig.c                              |   20 +
 target-ops.c                                  |   50 +
 target/alpha/cpu.h                            |    2 -
 target/arm/arch_dump.c                        |    8 +-
 target/arm/arm-qmp-cmds.c                     |   15 +-
 target/arm/common-semi-target.c               |   26 +-
 target/arm/cpu.c                              |    6 +-
 target/arm/cpu.h                              |    3 +-
 target/arm/cpu64.c                            |   80 +-
 target/arm/hvf/hvf-stub.c                     |   14 +
 target/arm/hvf/meson.build                    |    1 +
 target/arm/kvm-stub.c                         |    5 +
 target/arm/kvm.c                              |   40 +-
 target/arm/kvm_arm.h                          |    9 +
 target/arm/meson.build                        |   11 +-
 target/arm/tcg/translate-a64.c                |    6 +-
 target/arm/tcg/translate-a64.h                |    3 +
 target/arm/tcg/translate-sme.c                |    5 +-
 target/arm/tcg/translate-sve.c                |   18 +-
 target/arm/whpx/whpx-all.c                    |    1 -
 target/arm/whpx/whpx-stub.c                   |    5 +
 target/avr/cpu.h                              |    2 -
 target/hexagon/common-semi-target.c           |   26 +-
 target/hexagon/cpu.h                          |    1 -
 target/hppa/cpu.h                             |    2 -
 target/i386/arch_dump.c                       |    8 +-
 target/i386/cpu-qom.h                         |    1 +
 target/i386/cpu-system.c                      |   12 +-
 target/i386/cpu.c                             |    6 +-
 target/i386/cpu.h                             |   12 +-
 target/i386/hvf/hvf-cpu.c                     |   13 +-
 target/i386/kvm/kvm-cpu.c                     |   12 +-
 target/i386/kvm/kvm_i386.h                    |    2 +
 target/i386/kvm/xen-emu.c                     |    1 +
 target/i386/machine.c                         |   94 +-
 target/i386/mshv/mshv-cpu.c                   |   12 +-
 target/i386/nvmm/nvmm-all.c                   |   28 +-
 target/i386/tcg/tcg-cpu.c                     |   12 +-
 target/i386/whpx/whpx-all.c                   |    1 -
 target/loongarch/arch_dump.c                  |    8 +-
 target/loongarch/cpu.h                        |    2 -
 target/loongarch/kvm/kvm.c                    |    1 +
 target/loongarch/kvm/kvm_loongarch.h          |    2 +
 target/loongarch/loongarch-qmp-cmds.c         |   15 +-
 target/m68k/cpu.h                             |    2 -
 target/microblaze/cpu.h                       |    2 -
 target/microblaze/meson.build                 |    2 +-
 target/mips/cpu.h                             |    2 -
 target/mips/system/machine.c                  |  124 +-
 target/mips/system/mips-qmp-cmds.c            |   15 +-
 target/none/cpu-param.h                       |    6 +
 target/none/cpu-qom.h                         |    6 +
 target/or1k/cpu-qom.h                         |    1 +
 target/or1k/cpu.h                             |    2 -
 target/ppc/arch_dump.c                        |    8 +-
 target/ppc/cpu-qom.h                          |    1 +
 target/ppc/cpu.h                              |    2 -
 target/ppc/cpu_init.c                         |    1 +
 target/ppc/kvm.c                              |   24 +-
 target/ppc/machine.c                          |   78 +-
 target/ppc/ppc-qmp-cmds.c                     |   15 +-
 target/riscv/arch_dump.c                      |   18 +-
 target/riscv/common-semi-target.c             |   28 +-
 target/riscv/cpu.c                            |  133 +-
 target/riscv/cpu.h                            |    9 +-
 target/riscv/helper.h                         |    6 +-
 target/riscv/internals.h                      |   12 +-
 target/riscv/kvm/kvm-cpu.c                    |  115 +-
 target/riscv/kvm/kvm-stub.c                   |   33 +-
 target/riscv/kvm/meson.build                  |    2 +-
 target/riscv/machine.c                        |   16 +-
 target/riscv/meson.build                      |   18 +-
 target/riscv/monitor.c                        |   41 +-
 target/riscv/riscv-qmp-cmds.c                 |   15 +-
 target/riscv/tcg/bitmanip_helper.c            |   14 +-
 target/riscv/tcg/cpu_helper.c                 |   53 +-
 target/riscv/tcg/crypto_helper.c              |    1 +
 target/riscv/tcg/csr.c                        |   20 +-
 .../tcg/insn_trans/trans_privileged.c.inc     |    2 +-
 target/riscv/tcg/insn_trans/trans_rvb.c.inc   |   18 +-
 target/riscv/tcg/insn_trans/trans_rvd.c.inc   |   18 +-
 target/riscv/tcg/insn_trans/trans_rvf.c.inc   |   11 +-
 target/riscv/tcg/insn_trans/trans_rvi.c.inc   |   12 +-
 target/riscv/tcg/insn_trans/trans_rvm.c.inc   |    6 +-
 .../riscv/tcg/insn_trans/trans_rvzacas.c.inc  |   32 +-
 target/riscv/tcg/insn_trans/trans_rvzfh.c.inc |    8 +-
 target/riscv/tcg/insn_trans/trans_xlrbr.c.inc |    4 +-
 .../riscv/tcg/insn_trans/trans_xthead.c.inc   |    2 +-
 target/riscv/tcg/m128_helper.c                |    3 +-
 target/riscv/tcg/meson.build                  |    8 +-
 target/riscv/tcg/op_helper.c                  |    2 +-
 target/riscv/tcg/pmp.c                        |    5 +-
 target/riscv/tcg/tcg-cpu.c                    |   13 +-
 target/riscv/tcg/translate.c                  |  123 +-
 target/riscv/tcg/vector_helper.c              |   21 +-
 target/riscv/tcg/vector_internals.c           |    2 +-
 target/riscv/tcg/vector_internals.h           |    9 +-
 target/rx/cpu.h                               |    2 -
 target/s390x/arch_dump.c                      |    8 +-
 target/s390x/cpu-qom.h                        |    1 +
 target/s390x/cpu.h                            |    3 -
 target/s390x/cpu_models_system.c              |   15 +-
 target/sh4/cpu-qom.h                          |    1 +
 target/sh4/cpu.h                              |    2 -
 target/sparc/cpu.h                            |    2 -
 target/sparc/machine.c                        |   24 +-
 target/tricore/cpu.h                          |    2 -
 target/xtensa/cpu.h                           |    2 -
 tcg/tcg.c                                     |   42 +-
 tests/qtest/accel-cpu-qom-test.c              |   82 ++
 tests/qtest/fuzz/fuzz.c                       |    3 -
 tests/qtest/machine-list-combined-test.c      |  111 ++
 tests/qtest/machine-list-test.c               |   94 ++
 tests/qtest/machine-list-test.inc.h           |  876 +++++++++++++
 tests/qtest/machine-option-test.c             |  714 +++++++++++
 tests/qtest/meson.build                       |   31 +-
 tests/unit/check-qom-interface.c              |   12 +-
 tests/unit/check-qom-proplist.c               |   13 +-
 tests/unit/meson.build                        |   13 +
 tests/unit/test-io-channel-websock.c          |    7 +-
 tests/unit/test-io-task.c                     |    7 +-
 tests/unit/test-module-init.c                 |  186 +++
 tests/unit/test-qdev-global-props.c           |   14 +-
 tests/unit/test-qdev.c                        |    8 +-
 tests/unit/test-qom-is-available.c            |  250 ++++
 tests/unit/test-ram-discard-manager.c         |    7 +-
 tests/unit/test-target-info.c                 |   38 +
 tests/unit/test-target-kconfig-has.c          |   22 +
 tests/unit/test-vmstate.c                     |  377 +++++-
 ui/console-vc.c                               |   13 +-
 ui/dbus.c                                     |    8 +-
 ui/gtk.c                                      |   10 +-
 ui/spice-app.c                                |    7 +-
 util/module.c                                 |  171 ++-
 util/qemu-config.c                            |   10 +-
 338 files changed, 8224 insertions(+), 1876 deletions(-)
 delete mode 100644 configs/targets/aarch64-softmmu.c
 delete mode 100644 configs/targets/arm-softmmu.c
 delete mode 100644 configs/targets/meson.build
 delete mode 100644 configs/targets/riscv32-softmmu.c
 delete mode 100644 configs/targets/riscv64-softmmu.c
 delete mode 100644 include/accel/accel-cpu-target.h
 delete mode 100644 include/migration/cpu.h
 create mode 100644 include/qemu/target-info-def.h
 delete mode 100644 include/qemu/target-info-impl.h
 delete mode 100644 include/qemu/target-info-init.h
 delete mode 100644 include/qemu/target-info-qom.h
 create mode 100644 include/qemu/target-info-select.h
 create mode 100644 include/qemu/target-kconfig-has.h
 create mode 100644 include/qemu/target-kconfig.h
 create mode 100644 include/qemu/target-ops.h
 create mode 100644 include/tcg/tcg-op-tl.h
 create mode 100644 scripts/gen-target-kconfig.py
 delete mode 100644 stubs/dump.c
 delete mode 100644 stubs/qmp-cpu.c
 create mode 100644 stubs/target-info-select.c
 create mode 100644 system/target-info-select.c
 rename target-info-stub.c => target-info-def.c (71%)
 delete mode 100644 target-info-qom.c
 create mode 100644 target-kconfig.c
 create mode 100644 target-ops.c
 create mode 100644 target/arm/hvf/hvf-stub.c
 create mode 100644 target/none/cpu-param.h
 create mode 100644 target/none/cpu-qom.h
 create mode 100644 tests/qtest/accel-cpu-qom-test.c
 create mode 100644 tests/qtest/machine-list-combined-test.c
 create mode 100644 tests/qtest/machine-list-test.c
 create mode 100644 tests/qtest/machine-list-test.inc.h
 create mode 100644 tests/qtest/machine-option-test.c
 create mode 100644 tests/unit/test-module-init.c
 create mode 100644 tests/unit/test-qom-is-available.c
 create mode 100644 tests/unit/test-target-info.c
 create mode 100644 tests/unit/test-target-kconfig-has.c

-- 
2.52.0.windows.1

