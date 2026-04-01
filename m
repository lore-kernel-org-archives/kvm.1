Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC33370D64
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 04:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775017256; cv=none; b=sdsn4JgqQXpImACApBuRT3psrToT9RuC0mHMULl/MUmMvAT++LS+ESjkIFsu2ysBC9MLhYy7lHx9+6oMV3fZB8hIf6tvZ5h690uI34XdzKcMsS+gmyzzt7c3bkVbEPmNVCjCof0DtNmBWIKCwhAjUkCKnJIji0dd5QJlT7LzVjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775017256; c=relaxed/simple;
	bh=I4IamHRzpQzhc70ZdoU5bULR45y6S8J1XFyTVDFrnwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EvgR06BILOyWtrkEbMYUMzCcuUkI5TKIFZXWO82FihS2xx4mMFfItl+HcStZJYxd9j8NE5q9oPvGiTae0JDpzdKsmFBCjIakzEepS5cU5nZ8sGmuKm5JNufqfp6denE1BczOKpNILrJV2XGZGKz35GAtpyfgIFNZlu5XMiuMupE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNIh4Ta5; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNIh4Ta5"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-35d8e548a05so4526103a91.1
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 21:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775017251; x=1775622051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEe6jPbo8hSUncYLiRg4S/X4fkwAU16z7tTWVEMISbI=;
        b=NNIh4Ta5JDGKEKMEg5zUmVGe4YYlGsDKSqBmPNFNy4UU29Tpx3epZuJIPS012ycR4X
         KXZElqcVdaOYaSU/Dr8Gg3oWrmZqgxcpg8KhvIy9vPPaIM/yIZeI/ZYrkM6p77o2kGMa
         gAv9GQY7JqDR/8gPJPqAu9IBMexnif2aTlA/leHVUhmsesa1sgFBBNurp3q0H5xKxKbc
         v6YbzuafSeTAUCt7m4RNkPHWwLEkFNZV+DhqzaPgmfyxsuJUKM13BhhdgbIJFx9ZXjUf
         Ucrvm37JknuDj+QEpVQczTmAKt3SDo8wq/IURLm+cpOkv3Z2RxRQhBLolUpoHZ+T58fd
         v2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775017251; x=1775622051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zEe6jPbo8hSUncYLiRg4S/X4fkwAU16z7tTWVEMISbI=;
        b=oaaTz+QCNKAhdAs1RFhRgrf7khw7/PA/R2ZTMcDfATPVPQRzQjQCkU92rMQEefcCbp
         L83cIGNf+Pc0VzFN1Yxm3UmOYSyEOPJrJQ/YLcckNnuI93uDIfAua6bHjD0Z0shoO+Xb
         aBZQ3KOnA+MkCTkvULjD+DCG+YUhLEqml5fdUuYL8+BhpeiDQOnb5PIpv+jc5PApCRi3
         OojIAT4GBRZOJzPBUgJQlAlqAmRDJFDwUmJDH/OBdwOpCfxHTTJz107KMuiHInYZkkTx
         Ip8d5cLrGHk3ck0tzjKq3yuPX3NvNHGTJj1tSrb77yae+cgt/pScL9pbu/kYYStf3dky
         K9VA==
X-Gm-Message-State: AOJu0YxcCqA21DujO9g6bfugqZP16LNApAX+yXOOIGPM1uNh4oyJ6Kvb
	R2pT0K6U4kKBcGrYoXre9gKwjb+y0ifha1KJVZXQ3iT2frEXd2ErQ3unvLj2AFBbFMoHQBRb
X-Gm-Gg: ATEYQzxdwlAkrr8/9WZyyehwwtplqVfETDDii1+0dPoQgxyXfCw5kE0KzuDmFt3xFYG
	G/xBCIPDkIjgAq8nFEKc+VB0N4Tpomi1oKrS8p74eqHqGcFegK3T2MkNC3J4PUh3zX+QkmiVgcZ
	RhtuhsB9mZgHt/lrEy1ks+0vyCUQPc0uf2mY1qAQoxomcTIYNtC86J2Q+JHVcSBL5YQ8bcIczWK
	R2nbTog4SHC69M5FuK+CioXG1GVF2OP2aNPqnTDptkGGQnNtEAiLiOQWaSlGNmaBHJ95SiL2Aho
	Hc2yCDj/mE8woxsdmLcLkU5PtJYXwZtPz7p5Rk5P438j9gQtICs27Q2Zmc+WerxOD/LEpUL6B0Q
	mnBiKQ+wWHUDDPz3Uk0NszVlq+MCXIS5UjyuWAhqMWRJteh6e6l5nGg3FSPLVwvlim42XzqAzjg
	b3lYlfQU5u9xAdGOu8Tbyr8ExCtYByP0eoyFWUErS0TcDHRqFC2bW+aO+O/dfxzV+eew==
X-Received: by 2002:a17:902:e78e:b0:2b0:7531:b61e with SMTP id d9443c01a7336-2b269cc1b41mr18995255ad.41.1775017249080;
        Tue, 31 Mar 2026 21:20:49 -0700 (PDT)
Received: from tmp.Av2oqF2xxu (awork062061.netvigator.com. [203.198.28.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242766396sm127338675ad.45.2026.03.31.21.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 21:20:48 -0700 (PDT)
From: vince <liuwf0302@gmail.com>
To: kvm@vger.kernel.org
Cc: ryan.roberts@arm.com,
	will@kernel.org,
	julien.thierry.kdev@gmail.com,
	vince <liuwf0302@gmail.com>
Subject: [PATCH v3 1/3] x86: Add GDB stub and step-debug support
Date: Wed,  1 Apr 2026 12:20:32 +0800
Message-Id: <20260401042034.755639-2-liuwf0302@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401042034.755639-1-liuwf0302@gmail.com>
References: <177457996500.86179.14991222733583648054@gmail.com>
 <20260401042034.755639-1-liuwf0302@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the x86 GDB remote stub implementation and wire it into lkvm run
via --gdb/--gdb-wait. This includes step-debug stability fixes,
software-breakpoint state handling, protocol hardening, and an x86
smoke test workflow.

Also include user-facing GDB documentation in README and convert the
architecture/test/security stub documents to English for upstream review.

Link: https://lore.kernel.org/kvm/
Signed-off-by: vince <liuwf0302@gmail.com>

gdb, x86: Fix post-review issues in GDB stub

- gdb.c: fix gdb_disable_debug() to actually clear KVM debug state.
  The previous implementation called kvm_gdb__arch_set_debug(vcpu,
  false, NULL) which still set KVM_GUESTDBG_ENABLE|USE_SW_BP, leaving
  the VM taking KVM_EXIT_DEBUG after GDB disconnects.  Issue a direct
  KVM_SET_GUEST_DEBUG with control=0 to fully disable interception.

- gdb.c: validate 'M' packet payload length before calling hex_to_bin().
  A malformed packet with a claimed len larger than the actual hex data
  in the packet could cause hex_to_bin() to read past the packet buffer
  and write unintended bytes into guest memory.  Reject packets where
  the remaining packet bytes are fewer than len*2.

- gdb.c, x86/gdb.c: fix C89 style violations throughout.  Linux kernel
  style requires all variable declarations at the top of their block,
  before any statements.  Replace all for (int i = ...) loop initialisers
  with a pre-declared loop variable, and hoist all mixed declarations to
  the start of their enclosing block.

Signed-off-by: vince <liuwf0302@gmail.com>
---
 Makefile                       |   13 +-
 README                         |   29 +
 builtin-run.c                  |   13 +-
 docs/gdb-stub-architecture.md  |  142 ++
 gdb.c                          | 2225 ++++++++++++++++++++++++++++++++
 include/kvm/gdb.h              |  138 ++
 include/kvm/kvm-config.h       |    2 +
 kvm-cpu.c                      |    9 +-
 term.c                         |   18 +-
 tests/Makefile                 |    4 +
 tests/boot/Makefile            |   10 +-
 tests/gdb/Makefile             |    8 +
 tests/gdb/test-x86-gdb-stub.py |  178 +++
 x86/gdb.c                      |  578 +++++++++
 14 files changed, 3355 insertions(+), 12 deletions(-)
 create mode 100644 docs/gdb-stub-architecture.md
 create mode 100644 gdb.c
 create mode 100644 include/kvm/gdb.h
 create mode 100644 tests/gdb/Makefile
 create mode 100644 tests/gdb/test-x86-gdb-stub.py
 create mode 100644 x86/gdb.c

diff --git a/Makefile b/Makefile
index d84dc8e..7d75a67 100644
--- a/Makefile
+++ b/Makefile
@@ -131,6 +131,8 @@ endif
 #x86
 ifeq ($(ARCH),x86)
 	DEFINES += -DCONFIG_X86
+	DEFINES += -DCONFIG_HAS_GDB_STUB
+	OBJS	+= gdb.o
 	OBJS	+= hw/i8042.o
 	OBJS	+= hw/serial.o
 	OBJS	+= x86/boot.o
@@ -140,6 +142,7 @@ ifeq ($(ARCH),x86)
 	OBJS	+= x86/irq.o
 	OBJS	+= x86/kvm.o
 	OBJS	+= x86/kvm-cpu.o
+	OBJS	+= x86/gdb.o
 	OBJS	+= x86/mptable.o
 # Exclude BIOS object files from header dependencies.
 	OTHEROBJS	+= x86/bios.o
@@ -188,6 +191,7 @@ endif
 # ARM64
 ifeq ($(ARCH), arm64)
 	DEFINES		+= -DCONFIG_ARM64
+	OBJS		+= gdb.o
 	OBJS		+= $(OBJS_ARM_COMMON)
 	OBJS		+= arm/aarch64/arm-cpu.o
 	OBJS		+= arm/aarch64/kvm-cpu.o
@@ -551,10 +555,17 @@ x86/bios/bios-rom.h: x86/bios/bios.bin.elf
 	$(E) "  NM      " $@
 	$(Q) cd x86/bios && sh gen-offsets.sh > bios-rom.h && cd ..
 
+
+BOOT_TEST_KERNEL ?= $(firstword $(wildcard /boot/vmlinuz-$(shell uname -r) /boot/vmlinuz-* /boot/vmlinuz))
+
 check: all
 	$(MAKE) -C tests
 	./$(PROGRAM) run tests/pit/tick.bin
-	./$(PROGRAM) run -d tests/boot/boot_test.iso -p "init=init"
+	@if [ -n "$(BOOT_TEST_KERNEL)" ] && [ -r "$(BOOT_TEST_KERNEL)" ]; then \
+		./$(PROGRAM) run -k "$(BOOT_TEST_KERNEL)" -d tests/boot/boot_test.iso -p "init=init"; \
+	else \
+		echo "SKIP: boot runtime check (no readable /boot/vmlinuz* found)."; \
+	fi
 .PHONY: check
 
 install: all
diff --git a/README b/README
index d3c2d3a..c0b7d37 100644
--- a/README
+++ b/README
@@ -88,6 +88,35 @@ or
 		 --kernel ../../arch/x86/boot/bzImage \
 		 --network virtio
 
+GDB remote debugging
+--------------------
+
+kvmtool now supports a built-in GDB stub on x86 and arm64.
+
+Start a guest with a GDB server on localhost port 1234:
+
+  ./lkvm run --gdb 1234 --kernel <guest-kernel> [other options]
+
+To wait for GDB to attach before running guest vCPUs:
+
+  ./lkvm run --gdb 1234 --gdb-wait --kernel <guest-kernel> [other options]
+
+From GDB:
+
+  (gdb) target remote :1234
+
+Recommended kernel-debug workflow:
+
+ - Use a single vCPU for stepping-sensitive sessions:
+
+     ./lkvm run --gdb 1234 --gdb-wait -c 1 --kernel <guest-kernel> ...
+
+ - Use nokaslr in the guest command line for stable symbol addresses.
+
+Quick validation command:
+
+  make -C tests/gdb smoke
+
 The tool has been written by Pekka Enberg, Cyrill Gorcunov, Asias He,
 Sasha Levin and Prasad Joshi. Special thanks to Avi Kivity for his help
 on KVM internals and Ingo Molnar for all-around support and encouragement!
diff --git a/builtin-run.c b/builtin-run.c
index c26184e..64c86ba 100644
--- a/builtin-run.c
+++ b/builtin-run.c
@@ -33,6 +33,7 @@
 #include "kvm/guest_compat.h"
 #include "kvm/kvm-ipc.h"
 #include "kvm/builtin-debug.h"
+#include "kvm/gdb.h"
 
 #include <linux/types.h>
 #include <linux/err.h>
@@ -276,6 +277,10 @@ static int loglevel_parser(const struct option *opt, const char *arg, int unset)
 			"Enable MMIO debugging"),			\
 	OPT_INTEGER('\0', "debug-iodelay", &(cfg)->debug_iodelay,	\
 			"Delay IO by millisecond"),			\
+	OPT_INTEGER('\0', "gdb", &(cfg)->gdb_port,			\
+			"Start GDB stub on given TCP port"),		\
+	OPT_BOOLEAN('\0', "gdb-wait", &(cfg)->gdb_wait,			\
+			"Wait for GDB connection before starting VM"),	\
 									\
 	OPT_ARCH(RUN, cfg)						\
 	OPT_END()							\
@@ -734,8 +739,12 @@ static struct kvm *kvm_cmd_run_init(int argc, const char **argv)
 		kvm->vmlinux = kvm->cfg.vmlinux_filename;
 	}
 
-	if (kvm->cfg.nrcpus == 0)
-		kvm->cfg.nrcpus = nr_online_cpus;
+	if (kvm->cfg.nrcpus == 0) {
+		if (kvm->cfg.gdb_port)
+			kvm->cfg.nrcpus = 1;
+		else
+			kvm->cfg.nrcpus = nr_online_cpus;
+	}
 
 	if (!kvm->cfg.ram_size)
 		kvm->cfg.ram_size = get_ram_size(kvm->cfg.nrcpus);
diff --git a/docs/gdb-stub-architecture.md b/docs/gdb-stub-architecture.md
new file mode 100644
index 0000000..ca0b3f5
--- /dev/null
+++ b/docs/gdb-stub-architecture.md
@@ -0,0 +1,142 @@
+# kvmtool GDB Stub Architecture
+
+## 1. Background and goals
+
+kvmtool now provides a built-in GDB Remote Serial Protocol (RSP) stub for
+guest kernel debugging on x86 and arm64.
+
+Design goals:
+
+1. Provide practical remote debugging (`target remote`) for `lkvm run`
+2. Support breakpoints, single-step, register access, and memory access
+3. Keep protocol handling generic and architecture-specific behavior isolated
+4. Improve stepping stability in kernel-heavy interrupt contexts
+
+---
+
+## 2. Top-level architecture
+
+```
++--------------------------------------------------------------+
+|  Host                                                        |
+|                                                              |
+|  +---------+  GDB RSP over TCP   +------------------------+ |
+|  |  GDB    | <------------------> |  kvmtool GDB stub      | |
+|  | (client)|  localhost:PORT     |  (gdb.c / x86/gdb.c /  | |
+|  +---------+                     |   arm/aarch64/gdb.c)   | |
+|                                  +----------+-------------+ |
+|                                             | KVM ioctls    |
+|                                  +----------v-------------+ |
+|                                  |  KVM vCPU threads      | |
+|                                  |  KVM_EXIT_DEBUG        | |
+|                                  |  KVM_SET_GUEST_DEBUG   | |
+|                                  +----------+-------------+ |
+|                                             |               |
+|  +------------------------------------------v-------------+ |
+|  |  Guest VM (Linux kernel/userspace)                     | |
+|  +--------------------------------------------------------+ |
++--------------------------------------------------------------+
+```
+
+### 2.1 Generic layer (`gdb.c`)
+
+Responsibilities:
+
+- RSP packet transport and command dispatch
+- stop-reply generation
+- software/hardware breakpoint bookkeeping
+- coordination between vCPU threads and the GDB thread
+- guest virtual memory access with controlled translation fallback
+
+### 2.2 Architecture layer (`x86/gdb.c`, `arm/aarch64/gdb.c`)
+
+Responsibilities:
+
+- map GDB register layout to KVM register interfaces
+- program architecture debug controls (single-step / hw breakpoints)
+- classify debug exit reasons
+- apply architecture-specific resume fixes
+  - x86: `RFLAGS` handling (`TF`/`RF` and step window IRQ behavior)
+  - arm64: `PSTATE/DAIF` handling for single-step windows
+
+---
+
+## 3. Thread model and synchronization
+
+Two cooperating runtime contexts:
+
+1. **vCPU thread**
+   - Executes `KVM_RUN`
+   - On `KVM_EXIT_DEBUG`, enters `kvm_gdb__handle_debug()`
+
+2. **GDB thread**
+   - Accepts TCP connection from GDB
+   - Runs packet-level debug sessions while guest is stopped
+   - Decides resume behavior (`continue`, `step`, detach)
+
+Synchronization primitives:
+
+- `stopped_vcpu`: currently trapped vCPU
+- `vcpu_stopped`: condvar for vCPU -> GDB notification
+- `vcpu_resume`: condvar for GDB -> vCPU release
+- VM-wide pause/continue via `kvm__pause()` / `kvm__continue()`
+
+---
+
+## 4. Control-flow highlights
+
+### 4.1 Debug trap flow
+
+```text
+guest executes
+ -> KVM_EXIT_DEBUG
+ -> vCPU thread marks stopped_vcpu and waits
+ -> GDB thread runs debug session and handles packets
+ -> debug state is updated for resume
+ -> vCPU is signaled and VM continues
+```
+
+### 4.2 Software breakpoint step-over flow
+
+```text
+hit software breakpoint
+ -> restore original instruction bytes
+ -> run single-step over current instruction
+ -> reinsert software breakpoint bytes
+ -> resume according to user command semantics
+```
+
+This avoids immediate retrap on the same breakpoint byte.
+
+### 4.3 Step stability strategy
+
+- x86: adjust resume flags before stepping and restore state after stop
+- arm64: save and restore DAIF around the step window
+
+Goal: reduce interrupt noise during `next/finish` style stepping without
+changing guest behavior permanently.
+
+---
+
+## 5. Protocol support boundary
+
+Core packet handling includes:
+
+- `?`, `g/G`, `p/P`, `m/M`, `X`
+- `Z/z` software/hardware breakpoints
+- `c/s`, `C/S`
+- `qSupported`, `qXfer:features:read`
+
+Protocol safety hardening in the common layer includes:
+
+- binary write length handling based on packet boundaries (not `strlen`)
+- bounded thread-list formatting for `qfThreadInfo`
+
+---
+
+## 6. Practical boundaries
+
+- Kernel stepping is inherently noisy under interrupts and scheduling
+- For stable stepping sessions, prefer `-c 1` and `nokaslr`
+- The architecture split is designed for maintainability and incremental
+  extension of protocol features over time
diff --git a/gdb.c b/gdb.c
new file mode 100644
index 0000000..842c3bb
--- /dev/null
+++ b/gdb.c
@@ -0,0 +1,2225 @@
+/*
+ * GDB Remote Serial Protocol (RSP) stub for kvmtool.
+ *
+ * Enables debugging a KVM guest via a standard GDB connection,
+ * similar to QEMU's -s/-S options.
+ *
+ * Usage:
+ *   lkvm run --gdb 1234 -k bzImage ...   # listen on TCP port 1234
+ *   lkvm run --gdb 1234 --gdb-wait ...   # wait for GDB before starting
+ *
+ *   (gdb) target remote localhost:1234
+ *
+ * Features:
+ *   - Continue / single-step
+ *   - Ctrl+C interrupt
+ *   - Software breakpoints (Z0/z0) via INT3
+ *   - Hardware execution breakpoints (Z1/z1)
+ *   - Hardware write/access watchpoints (Z2/z4)
+ *   - Multi-vCPU: all vCPUs paused on stop, per-thread register access
+ *   - Target XML register description
+ */
+
+#include "kvm/gdb.h"
+
+#ifdef CONFIG_ARM64
+#include <asm/ptrace.h>
+#endif
+
+#include "kvm/kvm.h"
+#include "kvm/kvm-cpu.h"
+#include "kvm/util.h"
+#include "kvm/util-init.h"
+#include "kvm/mutex.h"
+
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <netinet/tcp.h>
+#include <arpa/inet.h>
+#include <pthread.h>
+#include <poll.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <errno.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <ctype.h>
+#include <unistd.h>
+
+#ifdef CONFIG_ARM64
+/*
+ * KVM register ID for TTBR1_EL1: S3_0_C2_C0_1
+ * op0=3, op1=0, CRn=2, CRm=0, op2=1
+ * Built without including arch headers to keep gdb.c architecture-agnostic.
+ */
+# define GDB_KVM_REG_ARM64		0x6000000000000000ULL
+# define GDB_KVM_REG_ARM64_SYSREG	(0x0013ULL << 16)
+# define GDB_KVM_REG_SIZE_U64		0x0030000000000000ULL
+# define GDB_ARM64_SYSREG(op0,op1,crn,crm,op2) \
+	(GDB_KVM_REG_ARM64 | GDB_KVM_REG_SIZE_U64 | GDB_KVM_REG_ARM64_SYSREG | \
+	 (((u64)(op0) & 0x3)  << 14) | \
+	 (((u64)(op1) & 0x7)  << 11) | \
+	 (((u64)(crn) & 0xf)  <<  7) | \
+	 (((u64)(crm) & 0xf)  <<  3) | \
+	 (((u64)(op2) & 0x7)  <<  0))
+# define GDB_KVM_REG_TTBR1_EL1		GDB_ARM64_SYSREG(3, 0, 2, 0, 1)
+#endif
+
+#include <linux/kvm.h>
+
+#define GDB_MAX_SW_BP		64
+#define GDB_MAX_HW_BP		4
+#define GDB_PACKET_MAX		16384
+
+#ifdef CONFIG_ARM64
+/*
+ * ARM64 software breakpoint: BRK #0 (little-endian 4-byte encoding)
+ * Encoding: 0xD4200000  ->  bytes: 0x00 0x00 0x20 0xD4
+ */
+# define GDB_SW_BP_INSN_LEN	4
+static const u8 GDB_SW_BP_INSN[4] = { 0x00, 0x00, 0x20, 0xD4 };
+#else
+/*
+ * x86 software breakpoint: INT3 (1-byte opcode 0xCC)
+ */
+# define GDB_SW_BP_INSN_LEN	1
+static const u8 GDB_SW_BP_INSN[1] = { 0xCC };
+#endif
+
+/*
+ * Only use raw address-as-GPA fallback for very low addresses where
+ * real-mode/early-boot identity mapping is plausible.
+ */
+#define GDB_IDMAP_FALLBACK_MAX	0x100000ULL
+
+/* Software breakpoint saved state */
+struct sw_bp {
+	u64  addr;
+	u8   orig_bytes[GDB_SW_BP_INSN_LEN];	/* original instruction bytes */
+	int  refs;
+	bool active;
+};
+
+/*
+ * All GDB stub state lives here.
+ * Accesses must be done with gdb.lock held, except where noted.
+ */
+static struct kvm_gdb {
+	int		 port;
+	int		 listen_fd;
+	int		 fd;		/* Connected GDB fd, -1 if none */
+	bool		 active;	/* Stub is configured */
+	bool		 wait;		/* --gdb-wait: block until GDB connects */
+	bool		 connected;	/* A GDB client is currently connected */
+
+	struct kvm	*kvm;
+	pthread_t	 thread;
+
+	/* vCPU <-> GDB thread synchronisation */
+	pthread_mutex_t	lock;
+	pthread_cond_t	vcpu_stopped;	/* vCPU -> GDB: we hit a debug event */
+	pthread_cond_t	vcpu_resume;	/* GDB -> vCPU: you may run again */
+
+	/*
+	 * Set by vCPU thread when it enters debug handling.
+	 * Cleared when GDB signals vcpu_resume.
+	 */
+	struct kvm_cpu	*stopped_vcpu;
+
+	/* Currently selected thread for Hg / Hc commands (-1 = any) */
+	int		 g_tid;		/* register ops */
+	int		 c_tid;		/* step/continue */
+
+	/* Breakpoints */
+	struct sw_bp		sw_bp[GDB_MAX_SW_BP];
+	struct kvm_gdb_hw_bp	hw_bp[GDB_MAX_HW_BP];
+
+	/* If true we are about to single-step the current vCPU */
+	bool		 single_step;
+
+	/* Used to wait for GDB connection before starting vCPUs */
+	pthread_cond_t	 connected_cond;
+} gdb = {
+	.fd          = -1,
+	.listen_fd   = -1,
+	.g_tid       = -1,
+	.c_tid       = -1,
+	.lock        = PTHREAD_MUTEX_INITIALIZER,
+	.vcpu_stopped   = PTHREAD_COND_INITIALIZER,
+	.vcpu_resume    = PTHREAD_COND_INITIALIZER,
+	.connected_cond = PTHREAD_COND_INITIALIZER,
+};
+
+struct sw_bp_resume {
+	int	idx;
+	u64	addr;
+	bool	active;
+	bool	auto_resume;
+};
+
+static struct sw_bp_resume sw_bp_resume = {
+	.idx = -1,
+};
+
+static bool gdb_write_guest_mem(u64 addr, const void *buf, size_t len);
+static bool gdb_write_guest_insn(u64 addr, const void *buf, size_t len);
+static struct kvm_cpu *current_vcpu(void);
+
+/* ------------------------------------------------------------------ */
+/* Utility: hex / binary conversion                                    */
+/* ------------------------------------------------------------------ */
+
+static const char hex_chars[] = "0123456789abcdef";
+
+static int hex_nibble(char c)
+{
+	if (c >= '0' && c <= '9') return c - '0';
+	if (c >= 'a' && c <= 'f') return c - 'a' + 10;
+	if (c >= 'A' && c <= 'F') return c - 'A' + 10;
+	return -1;
+}
+
+static void bin_to_hex(const void *bin, size_t len, char *hex)
+{
+	const u8 *b = bin;
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		hex[i * 2]     = hex_chars[b[i] >> 4];
+		hex[i * 2 + 1] = hex_chars[b[i] & 0xf];
+	}
+}
+
+/* Returns number of bytes written, or -1 on invalid hex. */
+static int hex_to_bin(const char *hex, size_t hexlen, void *bin)
+{
+	u8 *b = bin;
+	size_t i;
+
+	if (hexlen & 1)
+		return -1;
+	for (i = 0; i < hexlen / 2; i++) {
+		int hi = hex_nibble(hex[i * 2]);
+		int lo = hex_nibble(hex[i * 2 + 1]);
+		if (hi < 0 || lo < 0)
+			return -1;
+		b[i] = (u8)((hi << 4) | lo);
+	}
+	return hexlen / 2;
+}
+
+static int gdb_unescape_binary(const char *in, size_t in_len, void *out,
+			       size_t out_len)
+{
+	const u8 *src = (const u8 *)in;
+	u8 *dst = out;
+	size_t i = 0, j = 0;
+
+	while (i < in_len && j < out_len) {
+		u8 ch = src[i++];
+
+		if (ch == '}') {
+			if (i >= in_len)
+				return -1;
+			ch = src[i++] ^ 0x20;
+		}
+
+		dst[j++] = ch;
+	}
+
+	return (i == in_len && j == out_len) ? 0 : -1;
+}
+
+/* Parse a hex number from *p, advancing *p past the digits. */
+static u64 parse_hex(const char **p)
+{
+	u64 val = 0;
+	while (**p && hex_nibble(**p) >= 0) {
+		val = (val << 4) | hex_nibble(**p);
+		(*p)++;
+	}
+	return val;
+}
+
+/* ------------------------------------------------------------------ */
+/* Packet I/O                                                          */
+/* ------------------------------------------------------------------ */
+
+/*
+ * Read exactly one byte from fd.
+ * Returns the byte value [0..255] or -1 on error/EOF.
+ */
+static int gdb_read_byte(int fd)
+{
+	unsigned char c;
+	ssize_t r = read(fd, &c, 1);
+	if (r <= 0)
+		return -1;
+	return c;
+}
+
+/*
+ * Receive one GDB RSP packet.
+ * Skips leading junk until '$', reads data until '#', reads 2-char checksum.
+ * Returns:
+ *   >= 0  number of bytes in buf (NUL-terminated)
+ *   -1    I/O error or disconnect
+ *   -2    Ctrl+C received (0x03 interrupt byte)
+ */
+static int gdb_recv_packet(int fd, char *buf, size_t bufsz)
+{
+	int c;
+	size_t len;
+	u8 cksum;
+	int cs_hi;
+	int cs_lo;
+	u8 expected;
+	char nak;
+	char ack;
+
+retry:
+	/* Scan for '$' or 0x03 */
+	do {
+		c = gdb_read_byte(fd);
+		if (c < 0)
+			return -1;
+		if (c == 0x03)
+			return -2;
+	} while (c != '$');
+
+	/* Read packet data */
+	len = 0;
+	cksum = 0;
+	while (1) {
+		c = gdb_read_byte(fd);
+		if (c < 0)
+			return -1;
+		if (c == '#')
+			break;
+		if (len + 1 >= bufsz)
+			return -1;	/* overflow */
+		buf[len++] = (char)c;
+		cksum += (u8)c;
+	}
+	buf[len] = '\0';
+
+	/* Read 2-digit checksum from client */
+	cs_hi = gdb_read_byte(fd);
+	cs_lo = gdb_read_byte(fd);
+	if (cs_hi < 0 || cs_lo < 0)
+		return -1;
+
+	expected = (u8)((hex_nibble(cs_hi) << 4) | hex_nibble(cs_lo));
+	if (expected != cksum) {
+		/* Checksum mismatch: NAK and retry (best-effort send) */
+		nak = '-';
+		if (write(fd, &nak, 1) < 0)
+			return -1;
+		goto retry;
+	}
+
+	/* ACK (best-effort send) */
+	ack = '+';
+	if (write(fd, &ack, 1) < 0)
+		return -1;
+
+	return (int)len;
+}
+
+/*
+ * Send a GDB RSP packet "$data#checksum".
+ * data must be a NUL-terminated string.
+ * Returns 0 on success, -1 on error.
+ */
+static int gdb_send_packet(int fd, const char *data)
+{
+	size_t len = strlen(data);
+	size_t i;
+	u8 cksum = 0;
+	char trailer[4];
+	char header;
+	char ack;
+
+	for (i = 0; i < len; i++)
+		cksum += (u8)data[i];
+
+	snprintf(trailer, sizeof(trailer), "#%02x", cksum);
+
+	/* We send as three separate writes to avoid a heap allocation.
+	 * Small enough that no buffering is needed. */
+	header = '$';
+	if (write(fd, &header, 1)   != 1 ||
+	    write(fd, data, len)    != (ssize_t)len ||
+	    write(fd, trailer, 3)   != 3)
+		return -1;
+
+	/* Consume the ACK/NAK (best-effort; ignore NACK) */
+	if (read(fd, &ack, 1) != 1)
+		return -1;
+	return 0;
+}
+
+static void gdb_send_ok(int fd)
+{
+	gdb_send_packet(fd, "OK");
+}
+
+static void gdb_send_error(int fd, int err)
+{
+	char buf[8];
+	snprintf(buf, sizeof(buf), "E%02x", err & 0xff);
+	gdb_send_packet(fd, buf);
+}
+
+static void gdb_send_empty(int fd)
+{
+	gdb_send_packet(fd, "");
+}
+
+/* ------------------------------------------------------------------ */
+/* vCPU selection helpers                                              */
+/* ------------------------------------------------------------------ */
+
+/* Convert a GDB thread-ID string to a vCPU index (0-based).
+ * GDB thread IDs are 1-based (thread 1 = vCPU 0).
+ * Returns -1 on "all threads" or parse error, or the vCPU index.
+ */
+static int tid_to_vcpu(const char *s)
+{
+	const char *p = s;
+	long tid;
+
+	if (s[0] == '-' && s[1] == '1')
+		return -1;	/* "all threads" */
+	if (!*p)
+		return -2;
+	/* GDB may send hex thread IDs; parse as hex */
+	tid = (long)parse_hex(&p);
+	if (*p != '\0' || tid <= 0)
+		return -2;
+	return (int)(tid - 1);
+}
+
+static int sw_bp_find(u64 addr)
+{
+	int i;
+
+	for (i = 0; i < GDB_MAX_SW_BP; i++) {
+		if (gdb.sw_bp[i].active && gdb.sw_bp[i].addr == addr)
+			return i;
+	}
+
+	return -1;
+}
+
+static int sw_bp_restore(int idx)
+{
+	if (idx < 0 || idx >= GDB_MAX_SW_BP || !gdb.sw_bp[idx].active)
+		return -1;
+
+	return gdb_write_guest_insn(gdb.sw_bp[idx].addr,
+				   gdb.sw_bp[idx].orig_bytes,
+				   GDB_SW_BP_INSN_LEN) ? 0 : -1;
+}
+
+static int sw_bp_reinsert(int idx)
+{
+	if (idx < 0 || idx >= GDB_MAX_SW_BP || !gdb.sw_bp[idx].active)
+		return -1;
+
+	return gdb_write_guest_insn(gdb.sw_bp[idx].addr,
+				   GDB_SW_BP_INSN,
+				   GDB_SW_BP_INSN_LEN) ? 0 : -1;
+}
+
+static bool prepare_sw_bp_resume(bool auto_resume)
+{
+	struct kvm_cpu *vcpu = current_vcpu();
+	u64 bp_addr;
+	int idx;
+
+	if (!vcpu || !kvm_gdb__arch_is_sw_bp_exit(vcpu))
+		return false;
+
+	bp_addr = kvm_gdb__arch_debug_pc(vcpu);
+	idx = sw_bp_find(bp_addr);
+	if (idx < 0)
+		return false;
+
+	if (sw_bp_restore(idx) < 0)
+		return false;
+
+	gdb.sw_bp[idx].active = false;
+	sw_bp_resume.idx = idx;
+	sw_bp_resume.addr = bp_addr;
+	sw_bp_resume.active = true;
+	sw_bp_resume.auto_resume = auto_resume;
+
+	return true;
+}
+
+static bool finish_sw_bp_resume(bool *auto_resume)
+{
+	int idx;
+
+	if (!sw_bp_resume.active)
+		return false;
+
+	idx = sw_bp_resume.idx;
+	if (idx >= 0 && idx < GDB_MAX_SW_BP) {
+		gdb.sw_bp[idx].active = true;
+		sw_bp_reinsert(idx);
+	}
+
+	*auto_resume = sw_bp_resume.auto_resume;
+	sw_bp_resume.idx = -1;
+	sw_bp_resume.active = false;
+	return true;
+}
+
+#if !defined(CONFIG_X86) && !defined(CONFIG_ARM64)
+void kvm_gdb__arch_read_registers(struct kvm_cpu *vcpu, u8 *buf, size_t *size)
+{
+	*size = 0;
+}
+
+void kvm_gdb__arch_write_registers(struct kvm_cpu *vcpu, const u8 *buf,
+				    size_t size)
+{
+}
+
+int kvm_gdb__arch_read_register(struct kvm_cpu *vcpu, int regno,
+				u8 *buf, size_t *size)
+{
+	return -1;
+}
+
+int kvm_gdb__arch_write_register(struct kvm_cpu *vcpu, int regno,
+				 const u8 *buf, size_t size)
+{
+	return -1;
+}
+
+u64 kvm_gdb__arch_get_pc(struct kvm_cpu *vcpu)
+{
+	return 0;
+}
+
+void kvm_gdb__arch_set_pc(struct kvm_cpu *vcpu, u64 pc)
+{
+}
+
+void kvm_gdb__arch_set_debug(struct kvm_cpu *vcpu, bool single_step,
+			      struct kvm_gdb_hw_bp *hw_bps)
+{
+}
+
+void kvm_gdb__arch_prepare_resume(struct kvm_cpu *vcpu, bool single_step,
+				   bool from_debug_exit)
+{
+}
+
+void kvm_gdb__arch_handle_stop(struct kvm_cpu *vcpu)
+{
+}
+
+const char *kvm_gdb__arch_target_xml(void)
+{
+	return NULL;
+}
+
+size_t kvm_gdb__arch_reg_pkt_size(void)
+{
+	return 0;
+}
+
+int kvm_gdb__arch_signal(struct kvm_cpu *vcpu)
+{
+	return 5;
+}
+
+bool kvm_gdb__arch_is_sw_bp_exit(struct kvm_cpu *vcpu)
+{
+	return false;
+}
+
+u64 kvm_gdb__arch_debug_pc(struct kvm_cpu *vcpu)
+{
+	return 0;
+}
+
+void kvm_gdb__arch_reinject_sw_bp(struct kvm_cpu *vcpu)
+{
+}
+#endif
+
+/* Return the vCPU pointer for the currently selected thread (g_tid).
+ * Falls back to vCPU 0.
+ */
+static struct kvm_cpu *current_vcpu(void)
+{
+	int idx;
+
+	if (gdb.stopped_vcpu)
+		return gdb.stopped_vcpu;
+
+	idx = (gdb.g_tid <= 0) ? 0 : (gdb.g_tid - 1);
+	if (idx >= gdb.kvm->nrcpus)
+		idx = 0;
+	return gdb.kvm->cpus[idx];
+}
+
+/* ------------------------------------------------------------------ */
+/* Guest memory access                                                 */
+/* ------------------------------------------------------------------ */
+
+/*
+ * Linux x86-64 virtual address space constants.
+ * Used as a last-resort fallback when KVM_TRANSLATE fails.
+ *
+ * __START_KERNEL_map (0xffffffff80000000):
+ *   Maps physical RAM starting from 0.  With nokaslr the kernel binary
+ *   is loaded at physical 0x1000000 and linked at 0xffffffff81000000.
+ *   Formula: GPA = GVA - __START_KERNEL_map
+ *
+ * PAGE_OFFSET / direct-map (0xffff888000000000):
+ *   Direct 1:1 mapping of all physical RAM.
+ *   Formula: GPA = GVA - PAGE_OFFSET
+ *   This offset is fixed in the x86-64 ABI regardless of KASLR.
+ */
+#ifdef CONFIG_X86
+/*
+ * x86-64 Linux kernel virtual address layout (with nokaslr):
+ *   __START_KERNEL_map  0xffffffff80000000  kernel text, GPA = GVA - base
+ *   PAGE_OFFSET         0xffff888000000000  direct phys map, GPA = GVA - base
+ */
+# define GDB_KERNEL_MAP_BASE	0xffffffff80000000ULL
+# define GDB_DIRECT_MAP_BASE	0xffff888000000000ULL
+# define GDB_DIRECT_MAP_SIZE	0x100000000000ULL	/* 16 TB */
+#endif
+
+#ifdef CONFIG_ARM64
+/*
+ * ARM64 Linux kernel virtual address layout:
+ *
+ * Linear map (PAGE_OFFSET):
+ *   The kernel maps all physical RAM at PAGE_OFFSET.  The exact value
+ *   depends on VA_BITS (48 or 52), but for a standard kernel with VA_BITS=48:
+ *     PAGE_OFFSET = 0xffff000000000000
+ *   With VA_BITS=39 (some embedded configs):
+ *     PAGE_OFFSET = 0xffffff8000000000
+ *   Formula: GPA = GVA - PAGE_OFFSET
+ *
+ * Kernel text / vmalloc (KIMAGE_VADDR):
+ *   Standard arm64 kernel is linked at 0xffff800008000000 (VA_BITS=48).
+ *   The kernel image occupies [KIMAGE_VADDR, KIMAGE_VADDR + TEXT_OFFSET + size).
+ *   For kvmtool guests, the default load address is usually 0x80000 (physical),
+ *   so kernel text GPA ~= GVA - 0xffff800008000000 + 0x80000
+ *   = GVA - 0xffff800007f80000.
+ *
+ *   Simpler approximation: treat the full vmalloc/kernel range as a linear
+ *   region from 0xffff800000000000 onward, with offset 0xffff800000000000 -
+ *   PHYS_OFFSET where PHYS_OFFSET is typically 0x40000000 on kvmtool guests.
+ *
+ * In practice, KVM_TRANSLATE works correctly when the vCPU is paused in EL1
+ * (kernel mode).  The fallback is only needed when the vCPU is paused in EL0
+ * (userspace) with TTBR1_EL1 loaded but active stage-1 translation using
+ * TTBR0_EL1 (user page table) which does not cover kernel addresses.
+ *
+ * We use the same strategy as x86: check for the well-known linear map range
+ * first, then fall back to the kernel image range.
+ *
+ * PAGE_OFFSET for VA_BITS=48:  0xffff000000000000
+ * All kernel virtual addresses are >= 0xffff000000000000.
+ * kvmtool maps guest RAM at IPA 0x80000000 (ARM_MEMORY_AREA).
+ *
+ * Linear map formula:  GPA = GVA - 0xffff000000000000 + ARM_MEMORY_AREA
+ *   (kvmtool's physical memory slot starts at IPA 0x80000000.  See arm/kvm.c.)
+ *
+ * Kernel image formula: GPA = GVA - 0xffff800008000000 + 0x80000
+ *   Approximated as:    GPA = GVA - 0xffff800007f80000
+ *
+ * Because these offsets vary by kernel config, this fallback is a best-effort
+ * heuristic; use nokaslr and ensure the vCPU is in EL1 for reliable results.
+ */
+
+/* VA_BITS=48 linear map base (PAGE_OFFSET) */
+# define GDB_ARM64_PAGE_OFFSET		0xffff000000000000ULL
+/* kvmtool ARM64 guest RAM starts at IPA 0x80000000 (ARM_MEMORY_AREA) */
+# define GDB_ARM64_PHYS_OFFSET		0x80000000ULL
+# define GDB_ARM64_LINEAR_MAP_SIZE	0x1000000000000ULL  /* 256 TB region */
+
+/* Kernel image virtual base (KIMAGE_VADDR, VA_BITS=48) */
+# define GDB_ARM64_KIMAGE_VADDR		0xffff800008000000ULL
+/* TEXT_OFFSET: read from kernel image header; 0x0 for newer kernels, 0x80000 for older */
+# define GDB_ARM64_TEXT_OFFSET		0x0ULL
+
+/*
+ * arm64_sw_walk_ttbr1() - software walk of the kernel stage-1 page table.
+ *
+ * KVM_TRANSLATE is not implemented on ARM64 (returns ENXIO).  Instead we
+ * manually walk the TTBR1_EL1 4-level page table that the guest kernel uses
+ * for all kernel virtual addresses (bit[55] == 1, i.e. TTBR1 range).
+ *
+ * Supports 4KB granule, VA_BITS=48 (the most common arm64 Linux config):
+ *   Level 0 (PGD): bits [47:39]  ->  9 bits, 512 entries
+ *   Level 1 (PUD): bits [38:30]  ->  9 bits, 512 entries
+ *   Level 2 (PMD): bits [29:21]  ->  9 bits, 512 entries
+ *   Level 3 (PTE): bits [20:12]  ->  9 bits, 512 entries
+ *   Page offset:   bits [11:0]   -> 12 bits
+ *
+ * Each entry is 8 bytes.  Bits [47:12] of a non-block entry hold the next
+ * table's IPA (= GPA in kvmtool's flat Stage-2 identity map).
+ *
+ * Block entries:
+ *   L1 block: 1 GB,  output address = entry[47:30] << 30
+ *   L2 block: 2 MB,  output address = entry[47:21] << 21
+ *
+ * Entry validity:
+ *   bit[0] == 1:  valid
+ *   bit[1] == 1:  table (if at L0/L1/L2), page (if at L3)
+ *   bit[1] == 0:  block (if at L1/L2), reserved (if at L0)
+ *
+ * Returns the GPA on success, (u64)-1 on failure.
+ */
+static u64 arm64_sw_walk_ttbr1(u64 gva)
+{
+	struct kvm_cpu *cur = current_vcpu();
+	struct kvm_one_reg reg;
+	u64 ttbr1;
+	u64 tbl;
+	int shifts[4] = { 39, 30, 21, 12 };
+	u64 masks[4]  = { 0x1ff, 0x1ff, 0x1ff, 0x1ff };
+	int level;
+
+	if (!cur) {
+		pr_warning("GDB: arm64_walk: no current_vcpu");
+		return (u64)-1;
+	}
+
+	/*
+	 * Read TTBR1_EL1.  The ASID field is in bits [63:48]; the base
+	 * address is in bits [47:1] (BADDR), effectively [47:12] for 4KB
+	 * granule after masking ASID and CnP.
+	 */
+	reg.id   = GDB_KVM_REG_TTBR1_EL1;
+	reg.addr = (u64)&ttbr1;
+	if (ioctl(cur->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0) {
+		pr_warning("GDB: arm64_walk: KVM_GET_ONE_REG(TTBR1_EL1) failed: %s",
+			   strerror(errno));
+		return (u64)-1;
+	}
+
+	/* Strip ASID (bits [63:48]) and CnP (bit[0]) to get table base GPA */
+	tbl = ttbr1 & 0x0000fffffffff000ULL;
+
+	pr_debug("GDB: arm64_walk GVA=0x%llx TTBR1=0x%llx tbl=0x%llx",
+		 (unsigned long long)gva,
+		 (unsigned long long)ttbr1,
+		 (unsigned long long)tbl);
+
+	/* VA bits for each level (4KB granule, VA_BITS=48) */
+	for (level = 0; level < 4; level++) {
+		u64 idx       = (gva >> shifts[level]) & masks[level];
+		u64 entry_gpa = tbl + idx * 8;
+		u64 pte;
+		u8  *host;
+
+		/* Read the 8-byte page-table entry from guest memory */
+		host = guest_flat_to_host(gdb.kvm, entry_gpa);
+		if (!host || !host_ptr_in_ram(gdb.kvm, host) ||
+		    !host_ptr_in_ram(gdb.kvm, host + 7)) {
+			pr_warning("GDB: arm64_walk L%d: entry_gpa=0x%llx not in RAM (tbl=0x%llx idx=%llu)",
+				   level,
+				   (unsigned long long)entry_gpa,
+				   (unsigned long long)tbl,
+				   (unsigned long long)idx);
+			return (u64)-1;
+		}
+
+		memcpy(&pte, host, 8);
+
+		pr_debug("GDB: arm64_walk L%d idx=%llu entry_gpa=0x%llx pte=0x%llx",
+			 level, (unsigned long long)idx,
+			 (unsigned long long)entry_gpa,
+			 (unsigned long long)pte);
+
+		/* Entry must be valid (bit[0]) */
+		if (!(pte & 1ULL)) {
+			pr_warning("GDB: arm64_walk L%d: pte=0x%llx not valid",
+				   level, (unsigned long long)pte);
+			return (u64)-1;
+		}
+
+		if (level == 3) {
+			/* L3 page entry: output address = pte[47:12] */
+			u64 pa = (pte & 0x0000fffffffff000ULL) |
+				 (gva & 0xfffULL);
+			pr_debug("GDB: arm64_walk -> PA=0x%llx", (unsigned long long)pa);
+			return pa;
+		}
+
+		/* bit[1]: 0 = block, 1 = table */
+		if (!(pte & 2ULL)) {
+			u64 pa;
+
+			/* Block entry at L1 (1GB) or L2 (2MB) */
+			if (level == 1) {
+				pa = (pte & 0x0000ffffc0000000ULL) |
+				     (gva & 0x3fffffffULL);
+				pr_debug("GDB: arm64_walk L1 block -> PA=0x%llx", (unsigned long long)pa);
+				return pa;
+			} else if (level == 2) {
+				pa = (pte & 0x0000ffffffe00000ULL) |
+				     (gva & 0x1fffffULL);
+				pr_debug("GDB: arm64_walk L2 block -> PA=0x%llx", (unsigned long long)pa);
+				return pa;
+			}
+			/* L0 block is reserved */
+			pr_warning("GDB: arm64_walk L%d: unexpected block entry", level);
+			return (u64)-1;
+		}
+
+		/* Table entry: next level base = pte[47:12] */
+		tbl = pte & 0x0000fffffffff000ULL;
+	}
+
+	return (u64)-1;
+}
+#endif
+
+/*
+ * Translate a guest virtual address (GVA) to a guest physical address (GPA).
+ *
+ * Uses three strategies in order:
+ *
+ * 1. KVM_TRANSLATE on the currently selected vCPU.
+ *    Fails when the vCPU was paused in user mode (Linux KPTI / ARM64 TTBR0)
+ *    because the user-mode page table does not map kernel addresses.
+ *
+ * 2. KVM_TRANSLATE on every other vCPU.
+ *    On multi-vCPU systems, another vCPU may be paused in kernel mode
+ *    whose page tables include kernel mappings.
+ *
+ * 3. Fixed-offset arithmetic for well-known Linux kernel ranges.
+ *    This is the safety net for single-vCPU systems where ALL vCPUs are
+ *    paused in user mode (common when debugging a booted VM running a
+ *    shell).  Only reliable with the nokaslr kernel parameter.
+ *
+ * Returns the GPA on success, or (u64)-1 on failure.
+ */
+static u64 gva_to_gpa(u64 gva)
+{
+	struct kvm_cpu *cur = current_vcpu();
+	int i;
+
+	/* Strategy 1: KVM_TRANSLATE on the preferred vCPU */
+	if (cur) {
+		struct kvm_translation trans = { .linear_address = gva };
+		if (ioctl(cur->vcpu_fd, KVM_TRANSLATE, &trans) == 0 &&
+		    trans.valid)
+			return trans.physical_address;
+	}
+
+	/*
+	 * Strategy 2: try every other vCPU.
+	 *
+	 * x86 Linux KPTI / ARM64: user-mode page tables do NOT map kernel
+	 * virtual addresses.  If the selected vCPU was interrupted while
+	 * running a userspace process, a different vCPU that was paused inside
+	 * the kernel will have the kernel-mode page table loaded and can
+	 * translate kernel addresses successfully.
+	 */
+	for (i = 0; i < gdb.kvm->nrcpus; i++) {
+		struct kvm_cpu *vcpu = gdb.kvm->cpus[i];
+		struct kvm_translation trans;
+
+		if (vcpu == cur)
+			continue;
+		trans.linear_address = gva;
+		if (ioctl(vcpu->vcpu_fd, KVM_TRANSLATE, &trans) == 0 &&
+		    trans.valid)
+			return trans.physical_address;
+	}
+
+#ifdef CONFIG_X86
+	/*
+	 * Strategy 3 (x86-64): fixed-offset fallback for Linux kernel ranges.
+	 *
+	 * When ALL vCPUs are paused in user mode (e.g. a single-vCPU VM
+	 * running a shell), KVM_TRANSLATE will fail for every kernel address.
+	 *
+	 * Direct physical map (PAGE_OFFSET): always fixed, KASLR-safe.
+	 * Kernel text/data (__START_KERNEL_map): fixed only with nokaslr.
+	 */
+	if (gva >= GDB_DIRECT_MAP_BASE &&
+	    gva <  GDB_DIRECT_MAP_BASE + GDB_DIRECT_MAP_SIZE)
+		return gva - GDB_DIRECT_MAP_BASE;
+
+	if (gva >= GDB_KERNEL_MAP_BASE)
+		return gva - GDB_KERNEL_MAP_BASE;
+#endif
+
+#ifdef CONFIG_ARM64
+	/*
+	 * Strategy 3 (ARM64): software page-table walk via TTBR1_EL1.
+	 *
+	 * KVM_TRANSLATE is NOT implemented on ARM64 (always returns ENXIO).
+	 * Instead we read TTBR1_EL1 (kernel page-table base) and walk the
+	 * stage-1 4-level page table in software using guest_flat_to_host()
+	 * to access guest memory.
+	 *
+	 * This works correctly regardless of KASLR or non-standard PHYS_OFFSET,
+	 * as long as:
+	 *   - The vCPU has TTBR1_EL1 configured (true after MMU is enabled).
+	 *   - kvmtool's stage-2 IPA->GPA mapping is a flat identity (it is).
+	 *   - The granule is 4KB with VA_BITS=48 (standard arm64 Linux).
+	 *
+	 * Fallback to fixed-offset arithmetic is kept for early boot (MMU off)
+	 * or unusual kernel configs.
+	 */
+	if (gva >= 0xffff000000000000ULL) {
+		u64 gpa = arm64_sw_walk_ttbr1(gva);
+		if (gpa != (u64)-1)
+			return gpa;
+	}
+
+	/*
+	 * Fixed-offset fallback (best-effort, requires nokaslr):
+	 *
+	 *   Linear map  [0xffff000000000000, 0xffff000000000000 + 256TB):
+	 *     GPA = GVA - PAGE_OFFSET + PHYS_OFFSET
+	 *   Kernel image [0xffff800000000000, ...):
+	 *     GPA = GVA - KIMAGE_VADDR + TEXT_OFFSET + PHYS_OFFSET
+	 *
+	 * These constants match VA_BITS=48, 4KB granule, kvmtool default
+	 * PHYS_OFFSET=0x40000000, TEXT_OFFSET=0x80000.
+	 */
+
+	/* Linear map range: [PAGE_OFFSET, PAGE_OFFSET + LINEAR_MAP_SIZE) */
+	if (gva >= GDB_ARM64_PAGE_OFFSET &&
+	    gva <  GDB_ARM64_PAGE_OFFSET + GDB_ARM64_LINEAR_MAP_SIZE)
+		return gva - GDB_ARM64_PAGE_OFFSET + GDB_ARM64_PHYS_OFFSET;
+
+	/* Kernel image / vmalloc range: [0xffff800000000000, ...) */
+	if (gva >= GDB_ARM64_KIMAGE_VADDR)
+		return gva - GDB_ARM64_KIMAGE_VADDR
+		       + GDB_ARM64_TEXT_OFFSET
+		       + GDB_ARM64_PHYS_OFFSET;
+#endif
+
+	return (u64)-1;
+}
+
+/*
+ * Read/write guest memory at a guest virtual address.
+ * Handles page-boundary crossing and GVA->GPA translation.
+ * Falls back to treating the address as a GPA if translation fails.
+ */
+static bool gdb_read_guest_mem(u64 addr, void *buf, size_t len)
+{
+	u8 *out = buf;
+
+	while (len > 0) {
+		u64 gpa = gva_to_gpa(addr);
+		size_t page_rem;
+		size_t chunk;
+		u8 *host;
+
+		/*
+		 * Only fall back to treating addr as GPA for low (real-mode /
+		 * identity-mapped) addresses.  For kernel virtual addresses
+		 * (above 2GB) the fallback would produce a wildly wrong GPA
+		 * and cause guest_flat_to_host() to print a spurious warning.
+		 */
+		if (gpa == (u64)-1) {
+			if (addr < GDB_IDMAP_FALLBACK_MAX)
+				gpa = addr;	/* real-mode identity mapping */
+			else
+				return false;
+		}
+
+		/* Clamp transfer to the current page */
+		page_rem = 0x1000 - (gpa & 0xfff);
+		chunk = (page_rem < len) ? page_rem : len;
+
+		host = guest_flat_to_host(gdb.kvm, gpa);
+		if (!host || !host_ptr_in_ram(gdb.kvm, host) ||
+		    !host_ptr_in_ram(gdb.kvm, host + chunk - 1))
+			return false;
+
+		memcpy(out, host, chunk);
+		out  += chunk;
+		addr += chunk;
+		len  -= chunk;
+	}
+	return true;
+}
+
+static bool gdb_write_guest_mem_internal(u64 addr, const void *buf, size_t len,
+					 bool sync_icache)
+{
+	const u8 *in = buf;
+
+	while (len > 0) {
+		u64 gpa = gva_to_gpa(addr);
+		size_t page_rem;
+		size_t chunk;
+		u8 *host;
+
+		if (gpa == (u64)-1) {
+			if (addr < GDB_IDMAP_FALLBACK_MAX)
+				gpa = addr;
+			else
+				return false;
+		}
+
+		page_rem = 0x1000 - (gpa & 0xfff);
+		chunk = (page_rem < len) ? page_rem : len;
+
+		host = guest_flat_to_host(gdb.kvm, gpa);
+		if (!host || !host_ptr_in_ram(gdb.kvm, host) ||
+		    !host_ptr_in_ram(gdb.kvm, host + chunk - 1))
+			return false;
+
+		memcpy(host, in, chunk);
+		if (sync_icache)
+			kvm_gdb__arch_sync_guest_insn(host, chunk);
+		in   += chunk;
+		addr += chunk;
+		len  -= chunk;
+	}
+	return true;
+}
+
+static bool gdb_write_guest_mem(u64 addr, const void *buf, size_t len)
+{
+	return gdb_write_guest_mem_internal(addr, buf, len, false);
+}
+
+static bool gdb_write_guest_insn(u64 addr, const void *buf, size_t len)
+{
+	return gdb_write_guest_mem_internal(addr, buf, len, true);
+}
+
+/* ------------------------------------------------------------------ */
+/* Software breakpoints                                                */
+/* ------------------------------------------------------------------ */
+
+static int sw_bp_insert(u64 addr, int len)
+{
+	int i;
+
+	for (i = 0; i < GDB_MAX_SW_BP; i++) {
+		if (gdb.sw_bp[i].refs > 0 && gdb.sw_bp[i].addr == addr) {
+			gdb.sw_bp[i].refs++;
+			return 0;
+		}
+	}
+
+	/* Find a free slot */
+	for (i = 0; i < GDB_MAX_SW_BP; i++) {
+		if (gdb.sw_bp[i].refs > 0)
+			continue;
+
+		if (!gdb_read_guest_mem(addr, gdb.sw_bp[i].orig_bytes,
+					GDB_SW_BP_INSN_LEN)) {
+			pr_warning("GDB: sw_bp_insert read failed at GVA 0x%llx",
+				   (unsigned long long)addr);
+			return -1;
+		}
+		if (!gdb_write_guest_insn(addr, GDB_SW_BP_INSN,
+					  GDB_SW_BP_INSN_LEN)) {
+			pr_warning("GDB: sw_bp_insert write failed at GVA 0x%llx",
+				   (unsigned long long)addr);
+			return -1;
+		}
+
+		gdb.sw_bp[i].addr   = addr;
+		gdb.sw_bp[i].refs   = 1;
+		gdb.sw_bp[i].active = true;
+		return 0;
+	}
+	return -1;	/* table full */
+}
+
+static int sw_bp_remove(u64 addr, int len)
+{
+	int i;
+
+	for (i = 0; i < GDB_MAX_SW_BP; i++) {
+		if (gdb.sw_bp[i].refs <= 0 || gdb.sw_bp[i].addr != addr)
+			continue;
+
+		if (--gdb.sw_bp[i].refs > 0)
+			return 0;
+
+		if (gdb.sw_bp[i].active)
+			gdb_write_guest_insn(addr, gdb.sw_bp[i].orig_bytes,
+				     GDB_SW_BP_INSN_LEN);
+		gdb.sw_bp[i].active = false;
+		return 0;
+	}
+	return -1;
+}
+
+/* Return true if there is an active software breakpoint at addr. */
+static bool sw_bp_active_at(u64 addr)
+{
+	int i;
+
+	for (i = 0; i < GDB_MAX_SW_BP; i++) {
+		if (gdb.sw_bp[i].active && gdb.sw_bp[i].addr == addr)
+			return true;
+	}
+	return false;
+}
+
+/* Remove all software breakpoints before resuming the guest. */
+static void sw_bp_remove_all(void)
+{
+	int i;
+
+	for (i = 0; i < GDB_MAX_SW_BP; i++) {
+		if (gdb.sw_bp[i].refs <= 0)
+			continue;
+		if (gdb.sw_bp[i].active)
+			gdb_write_guest_insn(gdb.sw_bp[i].addr,
+					     gdb.sw_bp[i].orig_bytes,
+					     GDB_SW_BP_INSN_LEN);
+		gdb.sw_bp[i].refs = 0;
+		gdb.sw_bp[i].active = false;
+	}
+}
+
+/* ------------------------------------------------------------------ */
+/* Hardware breakpoints / watchpoints                                  */
+/* ------------------------------------------------------------------ */
+
+static int hw_bp_insert(int type, u64 addr, int len)
+{
+	int i;
+
+	for (i = 0; i < GDB_MAX_HW_BP; i++) {
+		if (!gdb.hw_bp[i].active) {
+			gdb.hw_bp[i].addr   = addr;
+			gdb.hw_bp[i].len    = len;
+			gdb.hw_bp[i].type   = type;
+			gdb.hw_bp[i].active = true;
+			return 0;
+		}
+	}
+	return -1;
+}
+
+static int hw_bp_remove(int type, u64 addr, int len)
+{
+	int i;
+
+	for (i = 0; i < GDB_MAX_HW_BP; i++) {
+		if (gdb.hw_bp[i].active &&
+		    gdb.hw_bp[i].addr == (u64)addr &&
+		    gdb.hw_bp[i].type == type) {
+			gdb.hw_bp[i].active = false;
+			return 0;
+		}
+	}
+	return -1;
+}
+
+/*
+ * Apply current debug configuration to all vCPUs.
+ * Only step_vcpu gets KVM_GUESTDBG_SINGLESTEP; all others keep breakpoint
+ * interception active but run without TF set.
+ */
+static void apply_debug_to_all(struct kvm_cpu *step_vcpu, bool single_step)
+{
+	int i;
+
+	for (i = 0; i < gdb.kvm->nrcpus; i++)
+		kvm_gdb__arch_set_debug(gdb.kvm->cpus[i],
+					gdb.kvm->cpus[i] == step_vcpu && single_step,
+					gdb.hw_bp);
+}
+
+/* ------------------------------------------------------------------ */
+/* Stop reply                                                          */
+/* ------------------------------------------------------------------ */
+
+/*
+ * Send a "T" stop-reply packet:
+ *   T<sig>thread:<tid>;
+ * where <sig> = SIGTRAP (5) in hex.
+ */
+static void gdb_send_stop_reply(int fd, struct kvm_cpu *vcpu)
+{
+	int sig = kvm_gdb__arch_signal(vcpu);
+	int tid = (int)(vcpu->cpu_id + 1);
+
+	char buf[80];
+	/* Include swbreak: since we advertise swbreak+ in qSupported */
+	if (kvm_gdb__arch_is_sw_bp_exit(vcpu))
+		snprintf(buf, sizeof(buf), "T%02xswbreak:;thread:%x;", sig, tid);
+	else
+		snprintf(buf, sizeof(buf), "T%02xthread:%x;", sig, tid);
+	gdb_send_packet(fd, buf);
+}
+
+/* ------------------------------------------------------------------ */
+/* qXfer: features                                                     */
+/* ------------------------------------------------------------------ */
+
+/*
+ * Handle qXfer:features:read:target.xml:offset,length
+ * Returns true if handled.
+ */
+static bool handle_qxfer_features(int fd, const char *annex,
+				   u64 offset, u64 reqlen)
+{
+	const char *xml;
+	size_t xmllen;
+	size_t avail;
+	size_t send;
+	bool   last;
+	size_t bufsz;
+	char *buf;
+
+	if (strcmp(annex, "target.xml") != 0)
+		goto notfound;
+
+	xml = kvm_gdb__arch_target_xml();
+	if (!xml)
+		goto notfound;
+
+	xmllen = strlen(xml);
+	if (offset >= xmllen) {
+		gdb_send_packet(fd, "l");	/* end-of-data */
+		return true;
+	}
+
+	avail = xmllen - offset;
+	send  = (avail < reqlen) ? avail : reqlen;
+	last  = (offset + send >= xmllen);
+
+	/* Response: 'm' (more) or 'l' (last) followed by data */
+	bufsz = 2 + send * 2 + 1;
+	buf = malloc(bufsz);
+	if (!buf) {
+		gdb_send_error(fd, ENOMEM);
+		return true;
+	}
+	buf[0] = last ? 'l' : 'm';
+	/* The content is text, not binary - copy it directly */
+	memcpy(buf + 1, xml + offset, send);
+	buf[1 + send] = '\0';
+	gdb_send_packet(fd, buf);
+	free(buf);
+	return true;
+
+notfound:
+	gdb_send_packet(fd, "E00");
+	return true;
+}
+
+/* ------------------------------------------------------------------ */
+/* Main GDB packet dispatcher                                          */
+/* ------------------------------------------------------------------ */
+
+/*
+ * Handle one GDB packet.
+ * Returns:
+ *   0  continue protocol loop
+ *   1  resume guest (c / s / C / S)
+ *   2  detach / kill
+ */
+static int handle_packet(int fd, const char *pkt, size_t pkt_len)
+{
+	const char *p = pkt;
+	const char *pkt_end = pkt + pkt_len;
+
+	switch (*p++) {
+
+	/* ---- ? : stop reason ---- */
+	case '?':
+		gdb_send_stop_reply(fd, current_vcpu());
+		break;
+
+	/* ---- g : read all registers ---- */
+	case 'g': {
+		struct kvm_cpu *vcpu = current_vcpu();
+		size_t regsz = kvm_gdb__arch_reg_pkt_size();
+		size_t written = 0;
+		u8 *regbuf;
+		char *hexbuf;
+
+		regbuf = malloc(regsz);
+		if (!regbuf) { gdb_send_error(fd, ENOMEM); break; }
+
+		kvm_gdb__arch_read_registers(vcpu, regbuf, &written);
+
+		hexbuf = malloc(written * 2 + 1);
+		if (!hexbuf) { free(regbuf); gdb_send_error(fd, ENOMEM); break; }
+		bin_to_hex(regbuf, written, hexbuf);
+		hexbuf[written * 2] = '\0';
+		gdb_send_packet(fd, hexbuf);
+		free(hexbuf);
+		free(regbuf);
+		break;
+	}
+
+	/* ---- G : write all registers ---- */
+	case 'G': {
+		struct kvm_cpu *vcpu = current_vcpu();
+		size_t hexlen = strlen(p);
+		size_t binlen = hexlen / 2;
+		u8 *regbuf = malloc(binlen);
+		if (!regbuf) { gdb_send_error(fd, ENOMEM); break; }
+		if (hex_to_bin(p, hexlen, regbuf) < 0) {
+			free(regbuf);
+			gdb_send_error(fd, EINVAL);
+			break;
+		}
+		kvm_gdb__arch_write_registers(vcpu, regbuf, binlen);
+		free(regbuf);
+		gdb_send_ok(fd);
+		break;
+	}
+
+	/* ---- p n : read register n ---- */
+	case 'p': {
+		struct kvm_cpu *vcpu = current_vcpu();
+		int regno = (int)parse_hex(&p);
+		u8 regbuf[16] = {0};
+		size_t rsize = 0;
+		char hexbuf[33];
+
+		if (kvm_gdb__arch_read_register(vcpu, regno, regbuf, &rsize) < 0) {
+			gdb_send_error(fd, EINVAL);
+			break;
+		}
+		bin_to_hex(regbuf, rsize, hexbuf);
+		hexbuf[rsize * 2] = '\0';
+		gdb_send_packet(fd, hexbuf);
+		break;
+	}
+
+	/* ---- P n=v : write register n ---- */
+	case 'P': {
+		struct kvm_cpu *vcpu = current_vcpu();
+		int regno = (int)parse_hex(&p);
+		size_t hexlen;
+		u8 regbuf[16] = {0};
+
+		if (*p++ != '=') { gdb_send_error(fd, EINVAL); break; }
+		hexlen = strlen(p);
+		hex_to_bin(p, hexlen, regbuf);
+		if (kvm_gdb__arch_write_register(vcpu, regno, regbuf,
+						 hexlen / 2) < 0)
+			gdb_send_error(fd, EINVAL);
+		else
+			gdb_send_ok(fd);
+		break;
+	}
+
+	/* ---- m addr,len : read memory ---- */
+	case 'm': {
+		u64 addr = parse_hex(&p);
+		u64 len;
+		u8 *mem;
+		char *hexbuf;
+
+		if (*p++ != ',') { gdb_send_error(fd, EINVAL); break; }
+		len  = parse_hex(&p);
+		if (len > 4096) len = 4096;
+
+		mem = malloc(len);
+		if (!mem) { gdb_send_error(fd, ENOMEM); break; }
+		if (!gdb_read_guest_mem(addr, mem, len)) {
+			free(mem);
+			gdb_send_error(fd, EFAULT);
+			break;
+		}
+		hexbuf = malloc(len * 2 + 1);
+		if (!hexbuf) { free(mem); gdb_send_error(fd, ENOMEM); break; }
+		bin_to_hex(mem, len, hexbuf);
+		hexbuf[len * 2] = '\0';
+		gdb_send_packet(fd, hexbuf);
+		free(hexbuf);
+		free(mem);
+		break;
+	}
+
+	/* ---- M addr,len:data : write memory ---- */
+	case 'M': {
+		u64 addr = parse_hex(&p);
+		u64 len;
+		u8 *mem;
+
+		if (*p++ != ',') { gdb_send_error(fd, EINVAL); break; }
+		len  = parse_hex(&p);
+		if (*p++ != ':') { gdb_send_error(fd, EINVAL); break; }
+		if (len > 4096) { gdb_send_error(fd, EINVAL); break; }
+		if ((ptrdiff_t)(len * 2) > pkt_end - p) {
+			gdb_send_error(fd, EINVAL);
+			break;
+		}
+
+		mem = malloc(len);
+		if (!mem) { gdb_send_error(fd, ENOMEM); break; }
+		if (hex_to_bin(p, len * 2, mem) < 0 ||
+		    !gdb_write_guest_mem(addr, mem, len)) {
+			free(mem);
+			gdb_send_error(fd, EFAULT);
+			break;
+		}
+		free(mem);
+		gdb_send_ok(fd);
+		break;
+	}
+
+	/* ---- X addr,len:data : write binary memory ---- */
+	case 'X': {
+		u64 addr = parse_hex(&p);
+		u64 len;
+		const char *data;
+		size_t data_len;
+		u8 *mem;
+
+		if (*p++ != ',') { gdb_send_error(fd, EINVAL); break; }
+		len  = parse_hex(&p);
+		if (*p++ != ':') { gdb_send_error(fd, EINVAL); break; }
+		if (len == 0) {
+			gdb_send_ok(fd);
+			break;
+		}
+		if (len > 4096) { gdb_send_error(fd, EINVAL); break; }
+		data = p;
+		data_len = (size_t)(pkt_end - data);
+		mem = malloc(len);
+		if (!mem) { gdb_send_error(fd, ENOMEM); break; }
+		if (gdb_unescape_binary(data, data_len, mem, len) < 0 ||
+		    !gdb_write_guest_mem(addr, mem, len)) {
+			free(mem);
+			gdb_send_error(fd, EFAULT);
+			break;
+		}
+		free(mem);
+		gdb_send_ok(fd);
+		break;
+	}
+
+	/* ---- c [addr] : continue ---- */
+	case 'c': {
+		if (*p) {
+			u64 addr = parse_hex(&p);
+			kvm_gdb__arch_set_pc(current_vcpu(), addr);
+		}
+		gdb.single_step = prepare_sw_bp_resume(true) ? true : false;
+		return 1;	/* resume */
+	}
+
+	/* ---- C sig[;addr] : continue with signal ---- */
+	case 'C': {
+		/* We ignore the signal number but honour the address. */
+		parse_hex(&p);	/* skip signal */
+		if (*p == ';') {
+			u64 addr;
+
+			p++;
+			addr = parse_hex(&p);
+			kvm_gdb__arch_set_pc(current_vcpu(), addr);
+		}
+		gdb.single_step = prepare_sw_bp_resume(true) ? true : false;
+		return 1;	/* resume */
+	}
+
+	/* ---- s [addr] : single step ---- */
+	case 's': {
+		if (*p) {
+			u64 addr = parse_hex(&p);
+			kvm_gdb__arch_set_pc(current_vcpu(), addr);
+		}
+		gdb.single_step = true;
+		prepare_sw_bp_resume(false);
+		return 1;	/* resume */
+	}
+
+	/* ---- S sig[;addr] : step with signal ---- */
+	case 'S': {
+		parse_hex(&p);	/* skip signal */
+		if (*p == ';') {
+			u64 addr;
+
+			p++;
+			addr = parse_hex(&p);
+			kvm_gdb__arch_set_pc(current_vcpu(), addr);
+		}
+		gdb.single_step = true;
+		prepare_sw_bp_resume(false);
+		return 1;
+	}
+
+	/* ---- Z type,addr,len : insert breakpoint/watchpoint ---- */
+	case 'Z': {
+		int type = (int)parse_hex(&p);
+		u64 addr;
+		int len;
+		int rc;
+
+		if (*p++ != ',') { gdb_send_error(fd, EINVAL); break; }
+		addr = parse_hex(&p);
+		if (*p++ != ',') { gdb_send_error(fd, EINVAL); break; }
+		len  = (int)parse_hex(&p);
+
+		if (type == 0) {
+			rc = sw_bp_insert(addr, len);
+		} else {
+			/* type 1=exec, 2=write, 3=read, 4=access */
+			int hwtype = type - 1;	/* 0=exec,1=write,2=read,3=access */
+				rc = hw_bp_insert(hwtype, addr, len);
+				if (rc == 0)
+					apply_debug_to_all(NULL, false);
+		}
+		if (rc == 0) gdb_send_ok(fd); else gdb_send_error(fd, ENOSPC);
+		break;
+	}
+
+	/* ---- z type,addr,len : remove breakpoint/watchpoint ---- */
+	case 'z': {
+		int type = (int)parse_hex(&p);
+		u64 addr;
+		int len;
+		int rc;
+
+		if (*p++ != ',') { gdb_send_error(fd, EINVAL); break; }
+		addr = parse_hex(&p);
+		if (*p++ != ',') { gdb_send_error(fd, EINVAL); break; }
+		len  = (int)parse_hex(&p);
+
+		if (type == 0) {
+			rc = sw_bp_remove(addr, len);
+		} else {
+			int hwtype = type - 1;
+				rc = hw_bp_remove(hwtype, addr, len);
+				if (rc == 0)
+					apply_debug_to_all(NULL, false);
+		}
+		if (rc == 0) gdb_send_ok(fd); else gdb_send_error(fd, ENOENT);
+		break;
+	}
+
+	/* ---- H op tid : set thread ---- */
+	case 'H': {
+		char op = *p++;
+		int vcpu_idx = tid_to_vcpu(p);
+		if (vcpu_idx >= gdb.kvm->nrcpus || vcpu_idx < -1) {
+			gdb_send_error(fd, EINVAL);
+			break;
+		}
+		if (op == 'g')
+			gdb.g_tid = (vcpu_idx < 0) ? -1 : vcpu_idx + 1;
+		else if (op == 'c')
+			gdb.c_tid = (vcpu_idx < 0) ? -1 : vcpu_idx + 1;
+		else {
+			gdb_send_error(fd, EINVAL);
+			break;
+		}
+		gdb_send_ok(fd);
+		break;
+	}
+
+	/* ---- T tid : is thread alive? ---- */
+	case 'T': {
+		u64 tid = parse_hex(&p);
+		int idx = (int)(tid - 1);
+		if (tid > 0 && idx < gdb.kvm->nrcpus)
+			gdb_send_ok(fd);
+		else
+			gdb_send_error(fd, ESRCH);
+		break;
+	}
+
+	/* ---- D : detach ---- */
+	case 'D':
+		gdb_send_ok(fd);
+		return 2;
+
+	/* ---- k : kill ---- */
+	case 'k':
+		return 2;
+
+	/* ---- q : general queries ---- */
+	case 'q': {
+		if (strncmp(p, "Supported", 9) == 0) {
+			char buf[256];
+			snprintf(buf, sizeof(buf),
+				 "PacketSize=%x;"
+				 "qXfer:features:read+;"
+				 "swbreak+;hwbreak+",
+				 GDB_PACKET_MAX);
+			gdb_send_packet(fd, buf);
+
+		} else if (strncmp(p, "Xfer:features:read:", 19) == 0) {
+			char annex[64];
+			const char *colon;
+			size_t annex_len;
+			u64 offset;
+			u64 reqlen;
+
+			p += 19;
+			/* annex:offset,length */
+			colon = strchr(p, ':');
+			if (!colon) { gdb_send_error(fd, EINVAL); break; }
+			annex_len = (size_t)(colon - p);
+			if (annex_len >= sizeof(annex)) annex_len = sizeof(annex)-1;
+			memcpy(annex, p, annex_len);
+			annex[annex_len] = '\0';
+			p = colon + 1;
+			offset = parse_hex(&p);
+			if (*p++ != ',') { gdb_send_error(fd, EINVAL); break; }
+			reqlen = parse_hex(&p);
+			handle_qxfer_features(fd, annex, offset, reqlen);
+
+		} else if (strcmp(p, "C") == 0) {
+			/* Current thread ID */
+			char buf[32];
+			int tid = gdb.stopped_vcpu
+				  ? (int)(gdb.stopped_vcpu->cpu_id + 1) : 1;
+			snprintf(buf, sizeof(buf), "QC%x", tid);
+			gdb_send_packet(fd, buf);
+
+		} else if (strcmp(p, "fThreadInfo") == 0) {
+			/* First batch of thread IDs */
+			char buf[256];
+			char *bp = buf;
+			int i;
+
+			*bp++ = 'm';
+			for (i = 0; i < gdb.kvm->nrcpus; i++) {
+				size_t rem = sizeof(buf) - (size_t)(bp - buf);
+				int w = snprintf(bp, rem, "%s%x", i ? "," : "", i + 1);
+				if (w < 0)
+					break;
+				if ((size_t)w >= rem) {
+					bp = buf + sizeof(buf) - 1;
+					break;
+				}
+				bp += w;
+			}
+			*bp = '\0';
+			gdb_send_packet(fd, buf);
+
+		} else if (strcmp(p, "sThreadInfo") == 0) {
+			gdb_send_packet(fd, "l");	/* end of thread list */
+
+		} else if (strncmp(p, "ThreadExtraInfo,", 16) == 0) {
+			u64 tid;
+			int idx;
+			char info[64];
+			char hexinfo[sizeof(info) * 2 + 1];
+
+			p += 16;
+			tid = parse_hex(&p);
+			idx = (int)(tid - 1);
+			if (idx >= 0 && idx < gdb.kvm->nrcpus)
+				snprintf(info, sizeof(info),
+					 "vCPU %d", idx);
+			else
+				snprintf(info, sizeof(info), "unknown");
+			bin_to_hex(info, strlen(info), hexinfo);
+			hexinfo[strlen(info) * 2] = '\0';
+			gdb_send_packet(fd, hexinfo);
+
+		} else if (strncmp(p, "Symbol:", 7) == 0) {
+			gdb_send_ok(fd);
+		} else {
+			gdb_send_empty(fd);
+		}
+		break;
+	}
+
+	/* ---- v : extended commands ---- */
+	case 'v': {
+		if (strncmp(p, "Cont?", 5) == 0) {
+			gdb_send_empty(fd);
+		} else if (strncmp(p, "Cont;", 5) == 0) {
+			gdb_send_empty(fd);
+		} else {
+			gdb_send_empty(fd);
+		}
+		break;
+	}
+
+	default:
+		gdb_send_empty(fd);
+		break;
+	}
+
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* Debug session: handle GDB interaction when guest is stopped        */
+/* ------------------------------------------------------------------ */
+
+/*
+ * Called from the GDB thread when a vCPU has stopped.
+ * Loops handling GDB packets until a resume command is received.
+ *
+ * send_stop_first: if true, send a T05 stop reply immediately.
+ *   - true:  use when resuming from c/s (GDB is waiting for a stop reply)
+ *            or after Ctrl+C (GDB expects a stop reply after 0x03).
+ *   - false: use for the initial GDB connection handshake (GDB will ask
+ *            for the stop reason via '?').
+ *
+ * Returns:
+ *   0  resume normally
+ *   1  detach / kill
+ */
+static int run_debug_session(struct kvm_cpu *vcpu, bool send_stop_first)
+{
+	int fd = gdb.fd;
+	int ret = 0;
+	int r;
+	int action;
+	char *pkt = malloc(GDB_PACKET_MAX);
+
+	if (!pkt)
+		return 1;
+
+	/* Announce the stop only when the caller needs it */
+	if (send_stop_first)
+		gdb_send_stop_reply(fd, vcpu);
+
+	while (1) {
+		/*
+		 * Poll for: socket data or Ctrl+C while running.
+		 * Here the guest is stopped so just do a blocking read.
+		 */
+		r = gdb_recv_packet(fd, pkt, GDB_PACKET_MAX);
+		if (r == -1) {
+			pr_warning("GDB: connection lost");
+			ret = 1;
+			break;
+		}
+		if (r == -2) {
+			/* Ctrl+C while stopped - send stop reply again */
+			gdb_send_stop_reply(fd, vcpu);
+			continue;
+		}
+
+		action = handle_packet(fd, pkt, (size_t)r);
+		if (action == 1)
+			break;	/* resume */
+		if (action == 2) {
+			ret = 1;
+			break;	/* detach/kill */
+		}
+	}
+
+	free(pkt);
+	return ret;
+}
+
+/* ------------------------------------------------------------------ */
+/* GDB thread: accept connection and handle Ctrl+C                    */
+/* ------------------------------------------------------------------ */
+
+/*
+ * Enable debug interception on all vCPUs after GDB connects.
+ */
+static void gdb_enable_debug(void)
+{
+	int i;
+
+	for (i = 0; i < gdb.kvm->nrcpus; i++)
+		kvm_gdb__arch_set_debug(gdb.kvm->cpus[i], false, gdb.hw_bp);
+}
+
+/*
+ * Disable debug interception on all vCPUs when GDB disconnects.
+ */
+static void gdb_disable_debug(void)
+{
+	struct kvm_guest_debug dbg = { 0 };	/* control = 0: disable all */
+	int i;
+
+	for (i = 0; i < gdb.kvm->nrcpus; i++) {
+		if (ioctl(gdb.kvm->cpus[i]->vcpu_fd,
+			  KVM_SET_GUEST_DEBUG, &dbg) < 0)
+			pr_warning("GDB: KVM_SET_GUEST_DEBUG(disable) failed: %s",
+				   strerror(errno));
+	}
+}
+
+/*
+ * Main body of the GDB thread.
+ * Accepts one GDB connection at a time, handles debug sessions.
+ */
+static void *gdb_thread_fn(void *arg)
+{
+	struct kvm *kvm = arg;
+
+	/* Block signals that are intended for vCPU threads */
+	sigset_t mask;
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGKVMEXIT);
+	sigaddset(&mask, SIGKVMPAUSE);
+	sigaddset(&mask, SIGKVMTASK);
+	pthread_sigmask(SIG_BLOCK, &mask, NULL);
+
+	pr_info("GDB: listening on port %d", gdb.port);
+
+	while (1) {
+		/* Accept a new GDB connection */
+		struct sockaddr_in client;
+		socklen_t clen = sizeof(client);
+		int cfd;
+		int one;
+		int i;
+
+		cfd = accept(gdb.listen_fd, (struct sockaddr *)&client, &clen);
+		if (cfd < 0) {
+			if (errno == EINTR)
+				continue;
+			pr_warning("GDB: accept failed: %s", strerror(errno));
+			break;
+		}
+
+		/* Disable Nagle for lower latency */
+		one = 1;
+		setsockopt(cfd, IPPROTO_TCP, TCP_NODELAY, &one, sizeof(one));
+
+		pr_info("GDB: connected from %s", inet_ntoa(client.sin_addr));
+
+		if (gdb.wait) {
+			/*
+			 * --gdb-wait mode: vCPUs have not yet called KVM_RUN.
+			 * Enable single-step on vCPU 0 so it stops at its
+			 * very first instruction.  All other vCPUs get normal
+			 * debug (SW_BP intercept) without single-step.
+			 *
+			 * This must be done BEFORE signalling connected_cond so
+			 * that kvm_gdb__init() cannot return (and the vCPU
+			 * threads cannot start) until the debug flags are set.
+			 */
+			kvm_gdb__arch_set_debug(kvm->cpus[0], true, gdb.hw_bp);
+			for (i = 1; i < kvm->nrcpus; i++)
+				kvm_gdb__arch_set_debug(kvm->cpus[i], false,
+							gdb.hw_bp);
+		}
+
+		pthread_mutex_lock(&gdb.lock);
+		gdb.fd        = cfd;
+		gdb.connected = true;
+		/* Notify the main thread if it was waiting for --gdb-wait */
+		pthread_cond_broadcast(&gdb.connected_cond);
+		pthread_mutex_unlock(&gdb.lock);
+
+		if (!gdb.wait) {
+			/*
+			 * Normal (non-wait) mode: the guest is already running.
+			 *
+			 * Pause all vCPUs FIRST, then enable debug interception.
+			 * This prevents any INT3 in the running guest (e.g. from
+			 * Linux jump-label patching) from triggering
+			 * KVM_EXIT_DEBUG before GDB has finished its initial
+			 * handshake.
+			 *
+			 * The initial debug session runs WITHOUT sending a stop
+			 * reply upfront; GDB will ask for the stop reason with
+			 * the '?' packet once it has completed the handshake.
+			 */
+			kvm__pause(kvm);
+			gdb_enable_debug();
+
+			if (run_debug_session(kvm->cpus[0], false)) {
+				/* GDB detached or connection lost */
+				gdb_disable_debug();
+				sw_bp_remove_all();
+				kvm__continue(kvm);
+				goto disconnect;
+			}
+
+			/* GDB sent c/s - apply debug flags and resume */
+			apply_debug_to_all(gdb.single_step ? kvm->cpus[0] : NULL,
+					   gdb.single_step);
+			kvm__continue(kvm);
+
+		} else {
+			/*
+			 * --gdb-wait mode: wait for vCPU 0 to stop at its
+			 * first instruction (via the single-step flag we set
+			 * above).
+			 */
+			struct kvm_cpu *vcpu;
+
+			pthread_mutex_lock(&gdb.lock);
+			while (!gdb.stopped_vcpu)
+				pthread_cond_wait(&gdb.vcpu_stopped, &gdb.lock);
+			vcpu = gdb.stopped_vcpu;
+			pthread_mutex_unlock(&gdb.lock);
+
+			/* Pause all other vCPUs */
+			kvm__pause(kvm);
+
+			/*
+			 * Initial session: no upfront stop reply.
+			 * GDB will ask with '?' after completing its handshake.
+			 */
+			if (run_debug_session(vcpu, false)) {
+				pthread_mutex_lock(&gdb.lock);
+				gdb.stopped_vcpu = NULL;
+				pthread_cond_signal(&gdb.vcpu_resume);
+				pthread_mutex_unlock(&gdb.lock);
+				kvm__continue(kvm);
+				goto disconnect;
+			}
+
+			apply_debug_to_all(gdb.single_step ? vcpu : NULL,
+					   gdb.single_step);
+			pthread_mutex_lock(&gdb.lock);
+			gdb.stopped_vcpu = NULL;
+			pthread_cond_signal(&gdb.vcpu_resume);
+			pthread_mutex_unlock(&gdb.lock);
+			kvm__continue(kvm);
+		}
+
+		/* -------------------------------------------------------- */
+		/* Main event loop: guest is now running                    */
+		/* -------------------------------------------------------- */
+		while (1) {
+			struct kvm_cpu *vcpu;
+
+			pthread_mutex_lock(&gdb.lock);
+			vcpu = gdb.stopped_vcpu;
+			pthread_mutex_unlock(&gdb.lock);
+
+			if (vcpu) {
+				bool auto_resume;
+
+				/*
+				 * A vCPU stopped at a breakpoint or single-step.
+				 * Pause all other vCPUs (stopped_vcpu already has
+				 * paused=1, so kvm__pause() counts it immediately).
+				 *
+				 * Send T05 proactively - GDB is waiting for a stop
+				 * reply after the 'c'/'s' command it sent.
+				 */
+				kvm__pause(kvm);
+				kvm_gdb__arch_handle_stop(vcpu);
+
+				if (finish_sw_bp_resume(&auto_resume)) {
+					gdb.single_step = false;
+					kvm_gdb__arch_prepare_resume(vcpu, false, true);
+					pthread_mutex_lock(&gdb.lock);
+					gdb.stopped_vcpu = NULL;
+					pthread_cond_signal(&gdb.vcpu_resume);
+					pthread_mutex_unlock(&gdb.lock);
+
+					if (auto_resume) {
+						apply_debug_to_all(NULL, false);
+						kvm__continue(kvm);
+						continue;
+					}
+				}
+
+				if (run_debug_session(vcpu, true)) {
+					pthread_mutex_lock(&gdb.lock);
+					gdb.stopped_vcpu = NULL;
+					pthread_cond_signal(&gdb.vcpu_resume);
+					pthread_mutex_unlock(&gdb.lock);
+					kvm__continue(kvm);
+					goto disconnect;
+				}
+
+				kvm_gdb__arch_prepare_resume(vcpu, gdb.single_step, true);
+				apply_debug_to_all(gdb.single_step ? vcpu : NULL,
+					   gdb.single_step);
+				pthread_mutex_lock(&gdb.lock);
+				gdb.stopped_vcpu = NULL;
+				pthread_cond_signal(&gdb.vcpu_resume);
+				pthread_mutex_unlock(&gdb.lock);
+				kvm__continue(kvm);
+
+			} else {
+				/*
+				 * No vCPU stopped. Poll the socket for Ctrl+C
+				 * or unexpected packets.
+				 */
+				struct pollfd pfd = {
+					.fd     = cfd,
+					.events = POLLIN,
+				};
+				int r;
+				unsigned char byte;
+				ssize_t n;
+
+				r = poll(&pfd, 1, 200 /* ms */);
+				if (r < 0 && errno != EINTR)
+					goto disconnect;
+				if (r == 0)
+					continue;
+
+				/* Peek at the first byte */
+				n = recv(cfd, &byte, 1, MSG_PEEK);
+				if (n <= 0)
+					goto disconnect;
+
+				if (byte == 0x03) {
+					struct kvm_cpu *cur;
+
+					recv(cfd, &byte, 1, 0);	/* consume */
+
+					/*
+					 * Ctrl+C: pause all vCPUs.
+					 * If a vCPU happened to stop at a
+					 * breakpoint at the same time, use that
+					 * one; otherwise use vCPU 0.
+					 */
+					kvm__pause(kvm);
+
+					pthread_mutex_lock(&gdb.lock);
+					cur = gdb.stopped_vcpu
+					      ? gdb.stopped_vcpu
+					      : kvm->cpus[0];
+					pthread_mutex_unlock(&gdb.lock);
+
+					/*
+					 * Send T05 proactively - GDB expects a
+					 * stop reply after the Ctrl+C it sent.
+					 */
+					if (run_debug_session(cur, true)) {
+						pthread_mutex_lock(&gdb.lock);
+						if (gdb.stopped_vcpu) {
+							gdb.stopped_vcpu = NULL;
+							pthread_cond_signal(
+							  &gdb.vcpu_resume);
+						}
+						pthread_mutex_unlock(&gdb.lock);
+						kvm__continue(kvm);
+						goto disconnect;
+					}
+
+					kvm_gdb__arch_prepare_resume(cur, gdb.single_step,
+							   !!gdb.stopped_vcpu);
+					apply_debug_to_all(gdb.single_step ? cur : NULL,
+						   gdb.single_step);
+
+					pthread_mutex_lock(&gdb.lock);
+					if (gdb.stopped_vcpu) {
+						gdb.stopped_vcpu = NULL;
+						pthread_cond_signal(
+						  &gdb.vcpu_resume);
+					}
+					pthread_mutex_unlock(&gdb.lock);
+
+					kvm__continue(kvm);
+
+				} else {
+					/*
+					 * Unexpected packet while running -
+					 * handle it (probably a query).
+					 */
+					char pktbuf[GDB_PACKET_MAX];
+					int pr;
+
+					pr = gdb_recv_packet(cfd, pktbuf,
+							sizeof(pktbuf));
+					if (pr < 0)
+						goto disconnect;
+					handle_packet(cfd, pktbuf, (size_t)pr);
+				}
+			}
+		}
+
+disconnect:
+		pr_info("GDB: client disconnected");
+		gdb_disable_debug();
+		sw_bp_remove_all();
+
+		pthread_mutex_lock(&gdb.lock);
+		gdb.fd        = -1;
+		gdb.connected = false;
+		/* If a vCPU is still stuck waiting, let it go */
+		if (gdb.stopped_vcpu) {
+			gdb.stopped_vcpu->paused = 0;
+			gdb.stopped_vcpu = NULL;
+			pthread_cond_broadcast(&gdb.vcpu_resume);
+		}
+		pthread_mutex_unlock(&gdb.lock);
+
+		close(cfd);
+	}
+
+	return NULL;
+}
+
+/* ------------------------------------------------------------------ */
+/* Public API                                                          */
+/* ------------------------------------------------------------------ */
+
+/*
+ * Called from a vCPU thread when KVM_EXIT_DEBUG is received.
+ * Blocks until the GDB session says to resume.
+ */
+void kvm_gdb__handle_debug(struct kvm_cpu *vcpu)
+{
+	if (!gdb.active)
+		return;
+
+	/*
+	 * Filter out native guest INT3s that are NOT in our sw_bp table.
+	 *
+	 * With KVM_GUESTDBG_USE_SW_BP enabled, KVM intercepts every INT3
+	 * in the guest, including ones that belong to the guest kernel
+	 * itself (e.g. int3_selftest(), jump-label patching, kprobes).
+	 * Those are not our breakpoints, so we re-inject the #BP exception
+	 * back to the guest and return without involving GDB at all.
+	 *
+	 * This check is intentionally done before acquiring gdb.lock so
+	 * that the common fast-path (native guest INT3, not our BP) does
+	 * not serialise on the lock.
+	 */
+	if (kvm_gdb__arch_is_sw_bp_exit(vcpu)) {
+		u64 bp_addr = kvm_gdb__arch_debug_pc(vcpu);
+		pr_warning("GDB: sw_bp exit at 0x%llx, active=%d",
+			   (unsigned long long)bp_addr,
+			   sw_bp_active_at(bp_addr));
+		if (!sw_bp_active_at(bp_addr)) {
+			kvm_gdb__arch_reinject_sw_bp(vcpu);
+			return;
+		}
+	}
+
+	pthread_mutex_lock(&gdb.lock);
+
+	if (!gdb.connected) {
+		/* GDB not connected yet - ignore debug events */
+		pthread_mutex_unlock(&gdb.lock);
+		return;
+	}
+
+	/*
+	 * Mark ourselves as paused so that kvm__pause() from the GDB
+	 * thread does not wait for us (it counts paused vCPUs immediately).
+	 */
+	vcpu->paused       = 1;
+	gdb.stopped_vcpu   = vcpu;
+
+	/* Wake the GDB thread */
+	pthread_cond_signal(&gdb.vcpu_stopped);
+
+	/* Sleep until the GDB thread says we may run again */
+	pthread_cond_wait(&gdb.vcpu_resume, &gdb.lock);
+
+	vcpu->paused = 0;
+	pthread_mutex_unlock(&gdb.lock);
+}
+
+bool kvm_gdb__active(struct kvm *kvm)
+{
+	return gdb.active;
+}
+
+/* ------------------------------------------------------------------ */
+/* init / exit                                                         */
+/* ------------------------------------------------------------------ */
+
+int kvm_gdb__init(struct kvm *kvm)
+{
+	int reuse = 1;
+	struct sockaddr_in addr;
+
+	if (!kvm->cfg.gdb_port)
+		return 0;
+
+#if !defined(CONFIG_X86) && !defined(CONFIG_ARM64)
+	pr_err("GDB stub is supported only on x86 and arm64");
+	return -ENOSYS;
+#endif
+
+	gdb.port = kvm->cfg.gdb_port;
+	gdb.wait = kvm->cfg.gdb_wait;
+	gdb.kvm  = kvm;
+
+	if (kvm->nrcpus > 1)
+		pr_warning("GDB: SMP guest debugging may make 'next/finish' unstable; use -c 1 for reliable stepping");
+
+	/* Create TCP listen socket */
+	gdb.listen_fd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	if (gdb.listen_fd < 0)
+		die_perror("GDB: socket");
+
+	setsockopt(gdb.listen_fd, SOL_SOCKET, SO_REUSEADDR, &reuse,
+		   sizeof(reuse));
+
+	addr.sin_family      = AF_INET;
+	addr.sin_port        = htons((u16)gdb.port);
+	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+	if (bind(gdb.listen_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
+		die_perror("GDB: bind");
+	if (listen(gdb.listen_fd, 1) < 0)
+		die_perror("GDB: listen");
+
+	gdb.active = true;
+
+	if (pthread_create(&gdb.thread, NULL, gdb_thread_fn, kvm) != 0)
+		die_perror("GDB: pthread_create");
+
+	if (gdb.wait) {
+		pr_info("GDB: waiting for connection on port %d ...",
+			gdb.port);
+		pthread_mutex_lock(&gdb.lock);
+		while (!gdb.connected)
+			pthread_cond_wait(&gdb.connected_cond, &gdb.lock);
+		pthread_mutex_unlock(&gdb.lock);
+		pr_info("GDB: client connected, starting VM");
+	}
+
+	return 0;
+}
+late_init(kvm_gdb__init);
+
+int kvm_gdb__exit(struct kvm *kvm)
+{
+	if (!gdb.active)
+		return 0;
+
+	gdb.active = false;
+
+	/*
+	 * Unblock the GDB thread if it is waiting in accept().
+	 *
+	 * close() alone is NOT sufficient on Linux: close() removes the fd
+	 * from the process fd table but the underlying socket object lives on
+	 * (accept() holds an internal reference), so accept() keeps blocking.
+	 * shutdown(SHUT_RDWR) triggers the socket's wait-queue wakeup, which
+	 * causes accept() to return immediately with EINVAL.
+	 */
+	if (gdb.listen_fd >= 0) {
+		shutdown(gdb.listen_fd, SHUT_RDWR);
+		close(gdb.listen_fd);
+		gdb.listen_fd = -1;
+	}
+
+	/* Unblock the GDB thread if it is inside a debug session */
+	if (gdb.fd >= 0) {
+		close(gdb.fd);
+		gdb.fd = -1;
+	}
+
+	/* Wake any vCPU stuck in kvm_gdb__handle_debug() */
+	pthread_mutex_lock(&gdb.lock);
+	if (gdb.stopped_vcpu) {
+		gdb.stopped_vcpu->paused = 0;
+		gdb.stopped_vcpu         = NULL;
+	}
+	pthread_cond_broadcast(&gdb.vcpu_resume);
+	pthread_mutex_unlock(&gdb.lock);
+
+	pthread_join(gdb.thread, NULL);
+	return 0;
+}
+late_exit(kvm_gdb__exit);
diff --git a/include/kvm/gdb.h b/include/kvm/gdb.h
new file mode 100644
index 0000000..31d44ad
--- /dev/null
+++ b/include/kvm/gdb.h
@@ -0,0 +1,138 @@
+#ifndef KVM__GDB_H
+#define KVM__GDB_H
+
+#include <stdbool.h>
+#include <stddef.h>
+#include <linux/types.h>
+
+struct kvm;
+struct kvm_cpu;
+
+/* Hardware breakpoint descriptor (shared with arch-specific code) */
+struct kvm_gdb_hw_bp {
+	u64  addr;
+	int  len;	/* 1, 2, 4, or 8 bytes */
+	int  type;	/* 0=exec, 1=write, 2=read, 3=access */
+	bool active;
+};
+
+#ifdef CONFIG_HAS_GDB_STUB
+
+/*
+ * Public GDB stub API
+ */
+
+/* Initialize and start the GDB stub (called from late_init) */
+int kvm_gdb__init(struct kvm *kvm);
+
+/* Shutdown the GDB stub */
+int kvm_gdb__exit(struct kvm *kvm);
+
+/* Called by kvm_cpu__start() when KVM_EXIT_DEBUG occurs */
+void kvm_gdb__handle_debug(struct kvm_cpu *vcpu);
+
+/* Returns true when a GDB stub is active on this VM */
+bool kvm_gdb__active(struct kvm *kvm);
+
+/*
+ * Architecture-specific callbacks (implemented per-arch, e.g. x86/gdb.c)
+ */
+
+/* Read all registers into buf, set *size to number of bytes written */
+void kvm_gdb__arch_read_registers(struct kvm_cpu *vcpu, u8 *buf,
+				   size_t *size);
+
+/* Write all registers from buf (size bytes) */
+void kvm_gdb__arch_write_registers(struct kvm_cpu *vcpu, const u8 *buf,
+				    size_t size);
+
+/* Read a single register (GDB regno) into buf, set *size */
+int kvm_gdb__arch_read_register(struct kvm_cpu *vcpu, int regno,
+				 u8 *buf, size_t *size);
+
+/* Write a single register (GDB regno) from buf (size bytes) */
+int kvm_gdb__arch_write_register(struct kvm_cpu *vcpu, int regno,
+				  const u8 *buf, size_t size);
+
+/* Return current PC of the vCPU */
+u64 kvm_gdb__arch_get_pc(struct kvm_cpu *vcpu);
+
+/* Set PC of the vCPU */
+void kvm_gdb__arch_set_pc(struct kvm_cpu *vcpu, u64 pc);
+
+/*
+ * Enable/disable guest debugging on a vCPU.
+ *  single_step: true  -> enable instruction-level single-step
+ *  hw_bps:      array of 4 hardware breakpoints (may be NULL)
+ */
+void kvm_gdb__arch_set_debug(struct kvm_cpu *vcpu, bool single_step,
+			      struct kvm_gdb_hw_bp *hw_bps);
+
+/*
+ * Prepare guest architectural state before resuming from a GDB stop.
+ * from_debug_exit is true when the current stop came from KVM_EXIT_DEBUG.
+ */
+void kvm_gdb__arch_prepare_resume(struct kvm_cpu *vcpu, bool single_step,
+				   bool from_debug_exit);
+
+/*
+ * Called when a KVM_EXIT_DEBUG stop is selected for a GDB session.
+ * Arch code can restore temporary state applied for stepping.
+ */
+void kvm_gdb__arch_handle_stop(struct kvm_cpu *vcpu);
+
+/* Return the GDB target XML description string (NULL-terminated) */
+const char *kvm_gdb__arch_target_xml(void);
+
+/* Total byte size of the 'g' register packet */
+size_t kvm_gdb__arch_reg_pkt_size(void);
+
+/* GDB signal number to report on stop (SIGTRAP=5) */
+int kvm_gdb__arch_signal(struct kvm_cpu *vcpu);
+
+/*
+ * Returns true if the KVM_EXIT_DEBUG exit was caused by a software
+ * breakpoint (INT3 / #BP exception), as opposed to a hardware debug
+ * trap (#DB, single-step, hardware breakpoint).
+ */
+bool kvm_gdb__arch_is_sw_bp_exit(struct kvm_cpu *vcpu);
+
+/*
+ * Returns the guest virtual address of the INT3 instruction that triggered
+ * the current software-breakpoint exit (i.e. the byte that holds 0xCC).
+ * Only meaningful when kvm_gdb__arch_is_sw_bp_exit() returns true.
+ */
+u64 kvm_gdb__arch_debug_pc(struct kvm_cpu *vcpu);
+
+/*
+ * Re-inject the #BP exception back into the guest so that the guest's
+ * own INT3 handler (e.g. kernel jump-label patching, int3_selftest) sees
+ * it instead of us treating it as a GDB breakpoint.
+ * Only meaningful when kvm_gdb__arch_is_sw_bp_exit() returns true.
+ */
+void kvm_gdb__arch_reinject_sw_bp(struct kvm_cpu *vcpu);
+
+#else
+
+static inline int kvm_gdb__init(struct kvm *kvm)
+{
+	return 0;
+}
+
+static inline int kvm_gdb__exit(struct kvm *kvm)
+{
+	return 0;
+}
+
+static inline void kvm_gdb__handle_debug(struct kvm_cpu *vcpu)
+{
+}
+
+static inline bool kvm_gdb__active(struct kvm *kvm)
+{
+	return false;
+}
+
+#endif
+
+#endif /* KVM__GDB_H */
diff --git a/include/kvm/kvm-config.h b/include/kvm/kvm-config.h
index 592b035..15a8317 100644
--- a/include/kvm/kvm-config.h
+++ b/include/kvm/kvm-config.h
@@ -54,6 +54,8 @@ struct kvm_config {
 	const char *real_cmdline;
 	struct virtio_net_params *net_params;
 	bool single_step;
+	int  gdb_port;		/* GDB stub TCP port (0 = disabled) */
+	bool gdb_wait;		/* Wait for GDB connection before starting */
 	bool vnc;
 	bool gtk;
 	bool sdl;
diff --git a/kvm-cpu.c b/kvm-cpu.c
index 1c566b3..74f0a6a 100644
--- a/kvm-cpu.c
+++ b/kvm-cpu.c
@@ -3,6 +3,7 @@
 #include "kvm/symbol.h"
 #include "kvm/util.h"
 #include "kvm/kvm.h"
+#include "kvm/gdb.h"
 #include "kvm/virtio.h"
 #include "kvm/mutex.h"
 #include "kvm/barrier.h"
@@ -174,8 +175,12 @@ int kvm_cpu__start(struct kvm_cpu *cpu)
 		case KVM_EXIT_UNKNOWN:
 			break;
 		case KVM_EXIT_DEBUG:
-			kvm_cpu__show_registers(cpu);
-			kvm_cpu__show_code(cpu);
+			if (kvm_gdb__active(cpu->kvm)) {
+				kvm_gdb__handle_debug(cpu);
+			} else {
+				kvm_cpu__show_registers(cpu);
+				kvm_cpu__show_code(cpu);
+			}
 			break;
 		case KVM_EXIT_IO: {
 			bool ret;
diff --git a/term.c b/term.c
index b8a70fe..40064e2 100644
--- a/term.c
+++ b/term.c
@@ -26,6 +26,11 @@ static pthread_t term_poll_thread;
 /* ctrl-a is used for escape */
 #define term_escape_char	0x01
 
+static bool guest_has_started(struct kvm *kvm)
+{
+	return kvm->cpus && kvm->cpus[0] && kvm->cpus[0]->thread != 0;
+}
+
 int term_getc(struct kvm *kvm, int term)
 {
 	static bool term_got_escape = false;
@@ -36,12 +41,21 @@ int term_getc(struct kvm *kvm, int term)
 
 	if (term_got_escape) {
 		term_got_escape = false;
-		if (c == 'x')
-			kvm__reboot(kvm);
+		if (c == 'x') {
+			if (guest_has_started(kvm))
+				kvm__reboot(kvm);
+			else
+				raise(SIGTERM);
+		}
 		if (c == term_escape_char)
 			return c;
 	}
 
+	if (c == 0x03 && !guest_has_started(kvm)) {
+		raise(SIGTERM);
+		return -1;
+	}
+
 	if (c == term_escape_char) {
 		term_got_escape = true;
 		return -1;
diff --git a/tests/Makefile b/tests/Makefile
index cad14ec..46671cd 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -12,6 +12,10 @@ boot:
 	$(MAKE) -C boot
 .PHONY: boot
 
+gdb:
+	$(MAKE) -C gdb smoke
+.PHONY: gdb
+
 clean:
 	$(MAKE) -C kernel clean
 	$(MAKE) -C pit clean
diff --git a/tests/boot/Makefile b/tests/boot/Makefile
index 2b950d2..89fef2f 100644
--- a/tests/boot/Makefile
+++ b/tests/boot/Makefile
@@ -1,17 +1,17 @@
 NAME	:= init
 
 OBJ	:= $(NAME).o
-MKISOFS := $(shell which mkisofs)
-ifndef MKISOFS
-MKISOFS := $(shell which xorrisofs)
+MKISOFS := $(shell command -v mkisofs 2>/dev/null)
+ifeq ($(MKISOFS),)
+MKISOFS := $(shell command -v xorrisofs 2>/dev/null)
 endif
 
-all: $(.o)
+all: $(OBJ)
 	rm -rf rootfs
 	mkdir rootfs
 	gcc -static init.c -o rootfs/init
 ifdef MKISOFS
-	$(MKISOFS) rootfs -o boot_test.iso
+	$(MKISOFS) -o boot_test.iso rootfs
 else
 	$(error "mkisofs or xorriso needed to build boot_test.iso")
 endif
diff --git a/tests/gdb/Makefile b/tests/gdb/Makefile
new file mode 100644
index 0000000..58fc79d
--- /dev/null
+++ b/tests/gdb/Makefile
@@ -0,0 +1,8 @@
+PORT ?= 12345
+LKVM ?= ../../lkvm
+GUEST ?= ../pit/tick.bin
+PYTHON ?= python3
+
+smoke: $(LKVM) $(GUEST)
+	$(PYTHON) test-x86-gdb-stub.py --lkvm $(LKVM) --guest $(GUEST) --port $(PORT)
+.PHONY: smoke
diff --git a/tests/gdb/test-x86-gdb-stub.py b/tests/gdb/test-x86-gdb-stub.py
new file mode 100644
index 0000000..a92f34a
--- /dev/null
+++ b/tests/gdb/test-x86-gdb-stub.py
@@ -0,0 +1,178 @@
+#!/usr/bin/env python3
+import argparse
+import os
+import socket
+import subprocess
+import sys
+import time
+
+
+def checksum(data: bytes) -> bytes:
+	return f"#{sum(data) & 0xff:02x}".encode()
+
+
+class RspClient:
+	def __init__(self, sock: socket.socket):
+		self.sock = sock
+
+	def _read_exact(self, length: int) -> bytes:
+		buf = bytearray()
+		while len(buf) < length:
+			chunk = self.sock.recv(length - len(buf))
+			if not chunk:
+				raise RuntimeError("unexpected EOF")
+			buf.extend(chunk)
+		return bytes(buf)
+
+	def send_packet(self, payload: bytes) -> None:
+		self.sock.sendall(b"$" + payload + checksum(payload))
+		ack = self._read_exact(1)
+		if ack != b"+":
+			raise RuntimeError(f"unexpected ack: {ack!r}")
+
+	def recv_packet(self) -> bytes:
+		while True:
+			ch = self._read_exact(1)
+			if ch == b"$":
+				break
+			if ch in (b"+", b"-"):
+				continue
+			raise RuntimeError(f"unexpected prefix byte: {ch!r}")
+
+		payload = bytearray()
+		while True:
+			ch = self._read_exact(1)
+			if ch == b"#":
+				break
+			payload.extend(ch)
+
+		got = self._read_exact(2)
+		expected = f"{sum(payload) & 0xff:02x}".encode()
+		if got.lower() != expected:
+			self.sock.sendall(b"-")
+			raise RuntimeError(
+				f"checksum mismatch: got {got!r}, expected {expected!r}"
+			)
+
+		self.sock.sendall(b"+")
+		return bytes(payload)
+
+
+def escape_binary(data: bytes) -> bytes:
+	out = bytearray()
+	for value in data:
+		if value in (ord("#"), ord("$"), ord("}"), ord("*")):
+			out.append(ord("}"))
+			out.append(value ^ 0x20)
+		else:
+			out.append(value)
+	return bytes(out)
+
+
+def wait_for_port(port: int, timeout: float) -> socket.socket:
+	deadline = time.time() + timeout
+	last_error = None
+	while time.time() < deadline:
+		try:
+			sock = socket.create_connection(("127.0.0.1", port), timeout=1)
+			sock.settimeout(5)
+			return sock
+		except OSError as exc:
+			last_error = exc
+			time.sleep(0.1)
+	raise RuntimeError(f"failed to connect to GDB stub: {last_error}")
+
+
+def stop_process(proc: subprocess.Popen) -> None:
+	if proc.poll() is not None:
+		return
+	proc.terminate()
+	try:
+		proc.wait(timeout=5)
+	except subprocess.TimeoutExpired:
+		proc.kill()
+		proc.wait(timeout=5)
+
+
+def main() -> int:
+	parser = argparse.ArgumentParser()
+	parser.add_argument("--lkvm", required=True)
+	parser.add_argument("--guest", required=True)
+	parser.add_argument("--port", type=int, required=True)
+	args = parser.parse_args()
+
+	if not os.path.exists("/dev/kvm"):
+		print("SKIP: /dev/kvm is unavailable")
+		return 0
+
+	proc = subprocess.Popen(
+		[
+			os.path.abspath(args.lkvm),
+			"run",
+			"--gdb",
+			str(args.port),
+			"--gdb-wait",
+			os.path.abspath(args.guest),
+		],
+		stdout=subprocess.PIPE,
+		stderr=subprocess.STDOUT,
+	)
+
+	try:
+		sock = wait_for_port(args.port, 10)
+		client = RspClient(sock)
+
+		client.send_packet(b"qSupported:multiprocess+")
+		reply = client.recv_packet().decode()
+		assert "PacketSize=" in reply
+		assert "qXfer:features:read+" in reply
+
+		client.send_packet(b"?")
+		reply = client.recv_packet().decode()
+		assert reply.startswith("T")
+
+		client.send_packet(b"qXfer:features:read:target.xml:0,80")
+		reply = client.recv_packet().decode()
+		assert reply[0] in ("m", "l")
+		assert "<target" in reply[1:]
+
+		client.send_packet(b"g")
+		reply = client.recv_packet().decode()
+		assert len(reply) > 32
+		assert len(reply) % 2 == 0
+		regs = bytes.fromhex(reply)
+		rip = int.from_bytes(regs[16 * 8:16 * 8 + 8], "little")
+
+		client.send_packet(f"Z0,{rip:x},1".encode())
+		reply = client.recv_packet().decode()
+		assert reply == "OK"
+
+		client.send_packet(f"z0,{rip:x},1".encode())
+		reply = client.recv_packet().decode()
+		assert reply == "OK"
+
+		payload = bytes([0x23, 0x24, 0x7D, 0x2A, 0x55])
+		addr = 0x200000
+		binary = escape_binary(payload)
+		client.send_packet(
+			f"X{addr:x},{len(payload):x}:".encode() + binary
+		)
+		reply = client.recv_packet().decode()
+		assert reply == "OK"
+
+		client.send_packet(f"m{addr:x},{len(payload):x}".encode())
+		reply = client.recv_packet().decode()
+		assert reply == payload.hex()
+
+		client.send_packet(b"D")
+		reply = client.recv_packet().decode()
+		assert reply == "OK"
+		sock.close()
+		print("PASS: x86 GDB stub smoke test")
+		return 0
+	finally:
+		stop_process(proc)
+
+
+if __name__ == "__main__":
+	sys.exit(main())
diff --git a/x86/gdb.c b/x86/gdb.c
new file mode 100644
index 0000000..f0fa941
--- /dev/null
+++ b/x86/gdb.c
@@ -0,0 +1,578 @@
+/*
+ * x86 / x86-64 architecture-specific GDB stub support.
+ *
+ * GDB x86-64 register set (described in target.xml):
+ *
+ *  No.  Name      Size    KVM field
+ *  ---  ------    ----    ---------
+ *   0   rax        8      regs.rax
+ *   1   rbx        8      regs.rbx
+ *   2   rcx        8      regs.rcx
+ *   3   rdx        8      regs.rdx
+ *   4   rsi        8      regs.rsi
+ *   5   rdi        8      regs.rdi
+ *   6   rbp        8      regs.rbp
+ *   7   rsp        8      regs.rsp
+ *   8   r8         8      regs.r8
+ *   9   r9         8      regs.r9
+ *  10   r10        8      regs.r10
+ *  11   r11        8      regs.r11
+ *  12   r12        8      regs.r12
+ *  13   r13        8      regs.r13
+ *  14   r14        8      regs.r14
+ *  15   r15        8      regs.r15
+ *  16   rip        8      regs.rip
+ *  17   eflags     4      regs.rflags (low 32 bits)
+ *  18   cs         4      sregs.cs.selector
+ *  19   ss         4      sregs.ss.selector
+ *  20   ds         4      sregs.ds.selector
+ *  21   es         4      sregs.es.selector
+ *  22   fs         4      sregs.fs.selector
+ *  23   gs         4      sregs.gs.selector
+ *
+ * Total: 16x8 + 8 + 4 + 6x4 = 164 bytes
+ */
+
+#include "kvm/gdb.h"
+#include "kvm/kvm-cpu.h"
+#include "kvm/util.h"
+
+#include <sys/ioctl.h>
+#include <string.h>
+#include <errno.h>
+
+#include <linux/kvm.h>
+
+#define GDB_NUM_REGS		24
+#define GDB_REG_RIP		16
+#define GDB_REG_EFLAGS		17
+#define GDB_REG_CS		18
+
+/* Byte size of the 'g' register packet */
+#define GDB_REGS_SIZE		(16 * 8 + 8 + 4 + 6 * 4)	/* 164 */
+
+#define X86_EFLAGS_TF		(1U << 8)
+#define X86_EFLAGS_IF		(1U << 9)
+#define X86_EFLAGS_RF		(1U << 16)
+
+static struct {
+	struct kvm_cpu *vcpu;
+	bool		pending;
+	bool		if_was_set;
+} step_irq_state;
+
+/* ------------------------------------------------------------------ */
+/* Target XML                                                          */
+/* ------------------------------------------------------------------ */
+
+static const char target_xml[] =
+	"<?xml version=\"1.0\"?>\n"
+	"<!DOCTYPE target SYSTEM \"gdb-target.dtd\">\n"
+	"<target version=\"1.0\">\n"
+	"  <feature name=\"org.gnu.gdb.i386.core\">\n"
+	"    <reg name=\"rax\"    bitsize=\"64\"/>\n"
+	"    <reg name=\"rbx\"    bitsize=\"64\"/>\n"
+	"    <reg name=\"rcx\"    bitsize=\"64\"/>\n"
+	"    <reg name=\"rdx\"    bitsize=\"64\"/>\n"
+	"    <reg name=\"rsi\"    bitsize=\"64\"/>\n"
+	"    <reg name=\"rdi\"    bitsize=\"64\"/>\n"
+	"    <reg name=\"rbp\"    bitsize=\"64\"/>\n"
+	"    <reg name=\"rsp\"    bitsize=\"64\"/>\n"
+	"    <reg name=\"r8\"     bitsize=\"64\"/>\n"
+	"    <reg name=\"r9\"     bitsize=\"64\"/>\n"
+	"    <reg name=\"r10\"    bitsize=\"64\"/>\n"
+	"    <reg name=\"r11\"    bitsize=\"64\"/>\n"
+	"    <reg name=\"r12\"    bitsize=\"64\"/>\n"
+	"    <reg name=\"r13\"    bitsize=\"64\"/>\n"
+	"    <reg name=\"r14\"    bitsize=\"64\"/>\n"
+	"    <reg name=\"r15\"    bitsize=\"64\"/>\n"
+	"    <reg name=\"rip\"    bitsize=\"64\" type=\"code_ptr\"/>\n"
+	"    <reg name=\"eflags\" bitsize=\"32\"/>\n"
+	"    <reg name=\"cs\"     bitsize=\"32\" type=\"int\"/>\n"
+	"    <reg name=\"ss\"     bitsize=\"32\" type=\"int\"/>\n"
+	"    <reg name=\"ds\"     bitsize=\"32\" type=\"int\"/>\n"
+	"    <reg name=\"es\"     bitsize=\"32\" type=\"int\"/>\n"
+	"    <reg name=\"fs\"     bitsize=\"32\" type=\"int\"/>\n"
+	"    <reg name=\"gs\"     bitsize=\"32\" type=\"int\"/>\n"
+	"  </feature>\n"
+	"</target>\n";
+
+const char *kvm_gdb__arch_target_xml(void)
+{
+	return target_xml;
+}
+
+size_t kvm_gdb__arch_reg_pkt_size(void)
+{
+	return GDB_REGS_SIZE;
+}
+
+/* ------------------------------------------------------------------ */
+/* Helpers: read/write KVM register structures                        */
+/* ------------------------------------------------------------------ */
+
+static int get_regs(struct kvm_cpu *vcpu, struct kvm_regs *regs)
+{
+	if (ioctl(vcpu->vcpu_fd, KVM_GET_REGS, regs) < 0) {
+		pr_warning("GDB: KVM_GET_REGS failed: %s", strerror(errno));
+		return -1;
+	}
+	return 0;
+}
+
+static int set_regs(struct kvm_cpu *vcpu, struct kvm_regs *regs)
+{
+	if (ioctl(vcpu->vcpu_fd, KVM_SET_REGS, regs) < 0) {
+		pr_warning("GDB: KVM_SET_REGS failed: %s", strerror(errno));
+		return -1;
+	}
+	return 0;
+}
+
+static int get_sregs(struct kvm_cpu *vcpu, struct kvm_sregs *sregs)
+{
+	if (ioctl(vcpu->vcpu_fd, KVM_GET_SREGS, sregs) < 0) {
+		pr_warning("GDB: KVM_GET_SREGS failed: %s", strerror(errno));
+		return -1;
+	}
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* Register read / write                                               */
+/* ------------------------------------------------------------------ */
+
+void kvm_gdb__arch_read_registers(struct kvm_cpu *vcpu, u8 *buf, size_t *size)
+{
+	struct kvm_regs  regs;
+	struct kvm_sregs sregs;
+	u8 *p = buf;
+	u32 eflags;
+
+	*size = 0;
+
+	if (get_regs(vcpu, &regs) < 0 || get_sregs(vcpu, &sregs) < 0)
+		return;
+
+	/* GPRs - 8 bytes each, GDB order */
+#define PUT64(field) do { memcpy(p, &regs.field, 8); p += 8; } while (0)
+	PUT64(rax); PUT64(rbx); PUT64(rcx); PUT64(rdx);
+	PUT64(rsi); PUT64(rdi); PUT64(rbp); PUT64(rsp);
+	PUT64(r8);  PUT64(r9);  PUT64(r10); PUT64(r11);
+	PUT64(r12); PUT64(r13); PUT64(r14); PUT64(r15);
+#undef PUT64
+
+	/* rip (8 bytes) */
+	memcpy(p, &regs.rip, 8);
+	p += 8;
+
+	/* eflags (4 bytes - low 32 bits of rflags) */
+	eflags = (u32)regs.rflags;
+	memcpy(p, &eflags, 4);
+	p += 4;
+
+	/* Segment selectors (4 bytes each) */
+#define PUTSEL(seg) do {			\
+	u32 sel = (u32)sregs.seg.selector;	\
+	memcpy(p, &sel, 4);			\
+	p += 4;					\
+} while (0)
+	PUTSEL(cs); PUTSEL(ss); PUTSEL(ds);
+	PUTSEL(es); PUTSEL(fs); PUTSEL(gs);
+#undef PUTSEL
+
+	*size = (size_t)(p - buf);
+}
+
+void kvm_gdb__arch_write_registers(struct kvm_cpu *vcpu, const u8 *buf,
+				    size_t size)
+{
+	struct kvm_regs  regs;
+	struct kvm_sregs sregs;
+	const u8 *p = buf;
+	u32 eflags;
+
+	if (size < GDB_REGS_SIZE)
+		return;
+
+	if (get_regs(vcpu, &regs) < 0 || get_sregs(vcpu, &sregs) < 0)
+		return;
+
+#define GET64(field) do { memcpy(&regs.field, p, 8); p += 8; } while (0)
+	GET64(rax); GET64(rbx); GET64(rcx); GET64(rdx);
+	GET64(rsi); GET64(rdi); GET64(rbp); GET64(rsp);
+	GET64(r8);  GET64(r9);  GET64(r10); GET64(r11);
+	GET64(r12); GET64(r13); GET64(r14); GET64(r15);
+#undef GET64
+
+	memcpy(&regs.rip, p, 8);
+	p += 8;
+
+	memcpy(&eflags, p, 4);
+	regs.rflags = (regs.rflags & ~0xffffffffULL) | eflags;
+	p += 4;
+
+	/* Segment selectors - only update the selector field */
+#define SETSEL(seg) do {				\
+	u32 sel;					\
+	memcpy(&sel, p, 4);				\
+	sregs.seg.selector = (u16)sel;			\
+	p += 4;						\
+} while (0)
+	SETSEL(cs); SETSEL(ss); SETSEL(ds);
+	SETSEL(es); SETSEL(fs); SETSEL(gs);
+#undef SETSEL
+
+	set_regs(vcpu, &regs);
+	/* We don't write sregs back for segment selector-only changes
+	 * to avoid corrupting descriptor caches; GDB mainly needs rip. */
+	(void)sregs;
+}
+
+int kvm_gdb__arch_read_register(struct kvm_cpu *vcpu, int regno,
+				 u8 *buf, size_t *size)
+{
+	struct kvm_regs  regs;
+	struct kvm_sregs sregs;
+	struct kvm_segment *segs[6];
+	u32 eflags;
+	u32 sel;
+	int idx;
+
+	if (regno < 0 || regno >= GDB_NUM_REGS)
+		return -1;
+
+	if (get_regs(vcpu, &regs) < 0)
+		return -1;
+
+	if (regno >= GDB_REG_CS && get_sregs(vcpu, &sregs) < 0)
+		return -1;
+
+	if (regno < 16) {
+		/* GPRs */
+		static const size_t offs[] = {
+			offsetof(struct kvm_regs, rax),
+			offsetof(struct kvm_regs, rbx),
+			offsetof(struct kvm_regs, rcx),
+			offsetof(struct kvm_regs, rdx),
+			offsetof(struct kvm_regs, rsi),
+			offsetof(struct kvm_regs, rdi),
+			offsetof(struct kvm_regs, rbp),
+			offsetof(struct kvm_regs, rsp),
+			offsetof(struct kvm_regs, r8),
+			offsetof(struct kvm_regs, r9),
+			offsetof(struct kvm_regs, r10),
+			offsetof(struct kvm_regs, r11),
+			offsetof(struct kvm_regs, r12),
+			offsetof(struct kvm_regs, r13),
+			offsetof(struct kvm_regs, r14),
+			offsetof(struct kvm_regs, r15),
+		};
+		memcpy(buf, (u8 *)&regs + offs[regno], 8);
+		*size = 8;
+	} else if (regno == GDB_REG_RIP) {
+		memcpy(buf, &regs.rip, 8);
+		*size = 8;
+	} else if (regno == GDB_REG_EFLAGS) {
+		eflags = (u32)regs.rflags;
+		memcpy(buf, &eflags, 4);
+		*size = 4;
+	} else {
+		/* Segment selectors (18-23) */
+		segs[0] = &sregs.cs; segs[1] = &sregs.ss; segs[2] = &sregs.ds;
+		segs[3] = &sregs.es; segs[4] = &sregs.fs; segs[5] = &sregs.gs;
+		idx = regno - GDB_REG_CS;
+		sel = (u32)segs[idx]->selector;
+		memcpy(buf, &sel, 4);
+		*size = 4;
+	}
+
+	return 0;
+}
+
+int kvm_gdb__arch_write_register(struct kvm_cpu *vcpu, int regno,
+				  const u8 *buf, size_t size)
+{
+	struct kvm_regs regs;
+	struct kvm_sregs sregs;
+	struct kvm_segment *segs[6];
+	u32 eflags;
+	u32 sel;
+	int idx;
+
+	if (regno < 0 || regno >= GDB_NUM_REGS)
+		return -1;
+
+	if (get_regs(vcpu, &regs) < 0)
+		return -1;
+
+	if (regno < 16) {
+		static const size_t offs[] = {
+			offsetof(struct kvm_regs, rax),
+			offsetof(struct kvm_regs, rbx),
+			offsetof(struct kvm_regs, rcx),
+			offsetof(struct kvm_regs, rdx),
+			offsetof(struct kvm_regs, rsi),
+			offsetof(struct kvm_regs, rdi),
+			offsetof(struct kvm_regs, rbp),
+			offsetof(struct kvm_regs, rsp),
+			offsetof(struct kvm_regs, r8),
+			offsetof(struct kvm_regs, r9),
+			offsetof(struct kvm_regs, r10),
+			offsetof(struct kvm_regs, r11),
+			offsetof(struct kvm_regs, r12),
+			offsetof(struct kvm_regs, r13),
+			offsetof(struct kvm_regs, r14),
+			offsetof(struct kvm_regs, r15),
+		};
+		if (size < 8) return -1;
+		memcpy((u8 *)&regs + offs[regno], buf, 8);
+		return set_regs(vcpu, &regs);
+	}
+
+	if (regno == GDB_REG_RIP) {
+		if (size < 8) return -1;
+		memcpy(&regs.rip, buf, 8);
+		return set_regs(vcpu, &regs);
+	}
+
+	if (regno == GDB_REG_EFLAGS) {
+		if (size < 4) return -1;
+		memcpy(&eflags, buf, 4);
+		regs.rflags = (regs.rflags & ~0xffffffffULL) | eflags;
+		return set_regs(vcpu, &regs);
+	}
+
+	/* Segment selector: write via sregs */
+	if (get_sregs(vcpu, &sregs) < 0)
+		return -1;
+
+	segs[0] = &sregs.cs; segs[1] = &sregs.ss; segs[2] = &sregs.ds;
+	segs[3] = &sregs.es; segs[4] = &sregs.fs; segs[5] = &sregs.gs;
+	idx = regno - GDB_REG_CS;
+	if (size < 4) return -1;
+	memcpy(&sel, buf, 4);
+	segs[idx]->selector = (u16)sel;
+
+	if (ioctl(vcpu->vcpu_fd, KVM_SET_SREGS, &sregs) < 0)
+		return -1;
+
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* PC                                                                  */
+/* ------------------------------------------------------------------ */
+
+u64 kvm_gdb__arch_get_pc(struct kvm_cpu *vcpu)
+{
+	struct kvm_regs regs;
+	if (get_regs(vcpu, &regs) < 0)
+		return 0;
+	return regs.rip;
+}
+
+void kvm_gdb__arch_set_pc(struct kvm_cpu *vcpu, u64 pc)
+{
+	struct kvm_regs regs;
+	if (get_regs(vcpu, &regs) < 0)
+		return;
+	regs.rip = pc;
+	set_regs(vcpu, &regs);
+}
+
+/* ------------------------------------------------------------------ */
+/* Debug control (single-step + hardware breakpoints)                 */
+/* ------------------------------------------------------------------ */
+
+/*
+ * DR7 bit layout:
+ *   G0..G3 (bits 1,3,5,7): global enable for DR0..DR3
+ *   cond0..cond3 (bits 16-17, 20-21, 24-25, 28-29):
+ *     00=execution, 01=write, 11=read/write
+ *   len0..len3 (bits 18-19, 22-23, 26-27, 30-31):
+ *     00=1B, 01=2B, 10=8B, 11=4B
+ */
+
+static u64 dr7_for_bp(struct kvm_gdb_hw_bp *bps)
+{
+	u64 dr7 = 0;
+	u64 cond;
+	u64 len;
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		if (!bps[i].active)
+			continue;
+
+		/* Global enable bit */
+		dr7 |= (1ULL << (i * 2 + 1));
+
+		/* Condition */
+		switch (bps[i].type) {
+		case 0:  cond = 0; break;	/* execution  (00) */
+		case 1:  cond = 1; break;	/* write      (01) */
+		case 2:  cond = 3; break;	/* read/write (11) - no read-only */
+		case 3:  cond = 3; break;	/* access     (11) */
+		default: cond = 0; break;
+		}
+		dr7 |= (cond << (16 + i * 4));
+
+		/* Length */
+		switch (bps[i].len) {
+		case 1:  len = 0; break;	/* 1B (00) */
+		case 2:  len = 1; break;	/* 2B (01) */
+		case 4:  len = 3; break;	/* 4B (11) */
+		case 8:  len = 2; break;	/* 8B (10) */
+		default: len = 0; break;
+		}
+		dr7 |= (len << (18 + i * 4));
+	}
+
+	return dr7;
+}
+
+void kvm_gdb__arch_set_debug(struct kvm_cpu *vcpu, bool single_step,
+			      struct kvm_gdb_hw_bp *hw_bps)
+{
+	struct kvm_guest_debug dbg = { 0 };
+	u64 dr7;
+	int i;
+
+	dbg.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
+
+	if (single_step)
+		dbg.control |= KVM_GUESTDBG_SINGLESTEP;
+
+	if (hw_bps) {
+		dr7 = dr7_for_bp(hw_bps);
+		if (dr7) {
+			dbg.control |= KVM_GUESTDBG_USE_HW_BP;
+			for (i = 0; i < 4; i++) {
+				if (hw_bps[i].active)
+					dbg.arch.debugreg[i] = hw_bps[i].addr;
+			}
+			dbg.arch.debugreg[7] = dr7;
+		}
+	}
+
+	if (ioctl(vcpu->vcpu_fd, KVM_SET_GUEST_DEBUG, &dbg) < 0)
+		pr_warning("GDB: KVM_SET_GUEST_DEBUG failed: %s",
+			   strerror(errno));
+}
+
+void kvm_gdb__arch_prepare_resume(struct kvm_cpu *vcpu, bool single_step,
+				   bool from_debug_exit)
+{
+	struct kvm_regs regs;
+
+	if (!from_debug_exit)
+		return;
+
+	if (get_regs(vcpu, &regs) < 0)
+		return;
+
+	regs.rflags &= ~X86_EFLAGS_TF;
+	if (single_step)
+		regs.rflags |= X86_EFLAGS_TF;
+
+	if (single_step) {
+		step_irq_state.vcpu = vcpu;
+		step_irq_state.pending = true;
+		step_irq_state.if_was_set = !!(regs.rflags & X86_EFLAGS_IF);
+		regs.rflags &= ~X86_EFLAGS_IF;
+	}
+
+	regs.rflags |= X86_EFLAGS_RF;
+	set_regs(vcpu, &regs);
+}
+
+void kvm_gdb__arch_handle_stop(struct kvm_cpu *vcpu)
+{
+	struct kvm_regs regs;
+
+	if (!step_irq_state.pending || step_irq_state.vcpu != vcpu)
+		return;
+
+	if (get_regs(vcpu, &regs) < 0)
+		return;
+
+	if (step_irq_state.if_was_set)
+		regs.rflags |= X86_EFLAGS_IF;
+	else
+		regs.rflags &= ~X86_EFLAGS_IF;
+
+	set_regs(vcpu, &regs);
+	step_irq_state.pending = false;
+	step_irq_state.vcpu = NULL;
+}
+
+/* ------------------------------------------------------------------ */
+/* Stop signal                                                         */
+/* ------------------------------------------------------------------ */
+
+int kvm_gdb__arch_signal(struct kvm_cpu *vcpu)
+{
+	/* Always report SIGTRAP (5) */
+	return 5;
+}
+
+/* ------------------------------------------------------------------ */
+/* Software-breakpoint re-injection                                    */
+/* ------------------------------------------------------------------ */
+
+/*
+ * x86 exception numbers in kvm_run->debug.arch.exception:
+ *   1  = #DB  (single-step / hardware breakpoint)
+ *   3  = #BP  (INT3 software breakpoint)
+ */
+bool kvm_gdb__arch_is_sw_bp_exit(struct kvm_cpu *vcpu)
+{
+	return vcpu->kvm_run->debug.arch.exception == 3;
+}
+
+/*
+ * Return the address of the INT3 byte that triggered the exit.
+ *
+ * KVM intercepts the #BP VM-exit BEFORE delivering the exception to the
+ * guest.  At that point the guest RIP still points at the INT3 instruction
+ * itself (not the next byte), and KVM copies that value into
+ * kvm_run->debug.arch.pc.  So no adjustment is needed.
+ *
+ * (Earlier code subtracted 1 here, which was wrong: it produced an address
+ * one byte before the INT3, causing sw_bp_active_at() to miss every hit.)
+ */
+u64 kvm_gdb__arch_debug_pc(struct kvm_cpu *vcpu)
+{
+	return vcpu->kvm_run->debug.arch.pc;
+}
+
+/*
+ * Re-inject the #BP exception so the guest's own INT3 handler sees it.
+ *
+ * At this point:
+ *   - Guest RIP points at the INT3 byte itself (KVM intercepted the VM-exit
+ *     before the exception was delivered, so the CPU has not yet advanced RIP).
+ *   - We inject exception #3 with no error code.
+ *   - When KVM delivers the injected #BP, the CPU will advance RIP past the
+ *     INT3 and push RIP+1 into the exception frame, which is the standard
+ *     x86 #BP convention the guest's handler expects.
+ */
+void kvm_gdb__arch_reinject_sw_bp(struct kvm_cpu *vcpu)
+{
+	struct kvm_vcpu_events events;
+
+	if (ioctl(vcpu->vcpu_fd, KVM_GET_VCPU_EVENTS, &events) < 0) {
+		pr_warning("GDB: KVM_GET_VCPU_EVENTS failed: %s",
+			   strerror(errno));
+		return;
+	}
+
+	events.exception.injected     = 1;
+	events.exception.nr           = 3;	/* #BP */
+	events.exception.has_error_code = 0;
+
+	if (ioctl(vcpu->vcpu_fd, KVM_SET_VCPU_EVENTS, &events) < 0)
+		pr_warning("GDB: KVM_SET_VCPU_EVENTS failed: %s",
+			   strerror(errno));
+}
-- 
2.34.1


