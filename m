Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30523A5E9C
	for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848537; cv=none; b=gfCa87ltPkGfgwS8p30PYonL2ACxrRqtl3xb8sgGYHfSQ9Dps+MkjLF4rL8ftmjghtYmF0Vba5PilHWisT3PXJnF+R8v9YM8+hqC/RKObK/msychO8An2eKRxKnCZe/3S46d7DQZ1mm/Acxy0VFr++TthAHZJQR7tQAEmL7z/6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848537; c=relaxed/simple;
	bh=/9rvEh8Bxmk+fpG0zk6+HWHK4cmXTHkfy7Ra+AtWjH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvwvNWftwF1Yd4N995e8RCO7MnhQaPU1qZQilFEmrzI/DDh6ry7xQvHMlDrYwqsKrq6AZwFJX7jq9ckm54FXF3IGb5/owWmJmBaLcA0RFS6O4HOYS0CTnRqL9ga572Kst6/mhv05fh4f3vgS82SWZDjayhcq055uzKswKY2O6NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsjMhcFf; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsjMhcFf"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-35ba749f441so75052a91.1
        for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 08:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773848530; x=1774453330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6UJRUeHBb+XLqMyxax66S1qP1ny5TZZ1BnAiUgaJVA=;
        b=TsjMhcFfi8S4CA2hCxZsuBnzDkaK6vGw1zfrtU4LbWu6gvCvsUv4d569Aqs3EyqJdU
         piKjXNDuCz8fastWbdSDyTPLtDBobm/Wqi0dWSpcVgmMuoyhGLe6e6tjWm+fBc0Qfx0y
         zBeejihJ1KeDkt5HGTr0Ml6Gg9j1GI31XX9wpM/e7W7lM3HB4INmDaFuqtNxp31LTeQf
         e7Kn6TH7ZK80RSLnseXJ/A2iLAycRDVz1Ndw8k56BEUFv6OBhlkuc8SHnnb7y9s3u+fn
         uYwmkK1MIXu0LGXlU+nIY1weGCivCUf+U4SohSbtq3gvqNb9njafYY5bj3IgtQwRB2yF
         9AnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773848530; x=1774453330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m6UJRUeHBb+XLqMyxax66S1qP1ny5TZZ1BnAiUgaJVA=;
        b=cw0jY6UPw5Pf15+yB0i2RoKc9qzTEcYG4F+iJgTS1YgxPUNvtWX3xSVp+6m5zEfufC
         Bvg1xsPkopqsJvyiJzbZFbHifCxR+MH3mQOgwYfwnXTrML11p7tEWoxwv7voGwUA5Uyo
         LKoCIy30/VdIrjfVswEZ3krKhvf3o9Zqr7H4TEz7KaB3bbnWd4mEKJ3tKbXiv30TtYw1
         bEZ4nEdvgy+zBPLRSk6RCNyIE6ibHTboODJvDY/MDRIBrCAtBgtnXb4Twuh3I/I5p3/y
         AzPi+hsx/Yi9Cyex04rcyuieizcN8k5ONjs9HZ/dg+eicLxw7ckhdN35AVC38ZoEEDsC
         byTA==
X-Gm-Message-State: AOJu0YwPNsubSTm0PHnG9lxvW9iEOmk74rv+fUS+50/sSZJv15tEdmuw
	8GT5tZ0Ur3HtYn3+1IyyoWIYmHPoOlxthmL/OgXaVmOvky27kglHqlZjLH0GQwLMqDX0DcY6
X-Gm-Gg: ATEYQzwBPjWdqUQNSgPgw4aGZ0TAdKxlgq9JUSS7+DWkmMrx91H3Xofon7f1TmxPBvG
	DQO1GZe5ZlmMtF+W00BJpgcAyP6vkONRNiuOYsUmtUymh4PLz0ajZr+Xijxtbhcbg7bhgqKK1ib
	r4IB32nyHeSqflQ4UetZY9gZ4wQrU1DD7VvNpzoBTyF4oJ3JnMCsy1SCXPlmRtWDOPFY6HmKOZQ
	WkZ6x0ZrkTpPtAEadUxIVLBulmlVvVSTkwxs7Rdf8MEISnvtlJLCcJugqocBCaMzwJ1a62ATvmy
	FKzEDve0piRpp8ARX/Px3rbI2RGczkOVInJ0lh7lIZLGIuTRet49xZmh5FliEvfaBxP9KcArVMK
	s3gCd2EuCQWEyd4mxkwAdGoeG4IH3SBvcT/4D/73gVuf8lbNCYK01QHtWa3a7yWbFI+kV688S0j
	y6NFCknl0aJmTuJNnvMRX5hHvZQSiz8ltCHj2gaww7FXx9bA==
X-Received: by 2002:a17:90b:5350:b0:353:5595:3247 with SMTP id 98e67ed59e1d1-35bb9e5608cmr3673904a91.12.1773848529651;
        Wed, 18 Mar 2026 08:42:09 -0700 (PDT)
Received: from lwfone-System-Product-Name.lan ([112.28.134.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc60117basm28826a91.5.2026.03.18.08.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:42:09 -0700 (PDT)
From: vince <liuwf0302@gmail.com>
To: kvm@vger.kernel.org
Cc: will@kernel.org,
	julien.thierry.kdev@gmail.com,
	vince <liuwf0302@gmail.com>
Subject: [PATCH 2/2] arm64: Add GDB stub and step-debug support
Date: Wed, 18 Mar 2026 23:41:56 +0800
Message-Id: <20260318154156.2064989-3-liuwf0302@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318154156.2064989-1-liuwf0302@gmail.com>
References: <20260318154156.2064989-1-liuwf0302@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the arm64 architecture backend for the built-in GDB stub, including
register mapping, software/hardware breakpoint handling, and step-debug
resume behavior suitable for kernel debugging paths.

The generic protocol layer remains shared with x86, while arm64-specific
state transitions and debug controls are implemented in arm/aarch64 code.

Link: https://lore.kernel.org/kvm/
Signed-off-by: vince <liuwf0302@gmail.com>
---
 Makefile          |   2 +-
 arm/aarch64/gdb.c | 744 ++++++++++++++++++++++++++++++++++++++++++++++
 gdb.c             | 323 ++++++++++++++++++--
 include/kvm/gdb.h |   2 +-
 4 files changed, 1043 insertions(+), 28 deletions(-)
 create mode 100644 arm/aarch64/gdb.c

diff --git a/Makefile b/Makefile
index 7d75a67..3472d40 100644
--- a/Makefile
+++ b/Makefile
@@ -131,7 +131,6 @@ endif
 #x86
 ifeq ($(ARCH),x86)
 	DEFINES += -DCONFIG_X86
-	DEFINES += -DCONFIG_HAS_GDB_STUB
 	OBJS	+= gdb.o
 	OBJS	+= hw/i8042.o
 	OBJS	+= hw/serial.o
@@ -198,6 +197,7 @@ ifeq ($(ARCH), arm64)
 	OBJS		+= arm/aarch64/kvm.o
 	OBJS		+= arm/aarch64/pvtime.o
 	OBJS		+= arm/aarch64/pmu.o
+	OBJS		+= arm/aarch64/gdb.o
 	ARCH_INCLUDE	:= $(HDRS_ARM_COMMON)
 	ARCH_INCLUDE	+= -Iarm/aarch64/include
 
diff --git a/arm/aarch64/gdb.c b/arm/aarch64/gdb.c
new file mode 100644
index 0000000..6fe04db
--- /dev/null
+++ b/arm/aarch64/gdb.c
@@ -0,0 +1,744 @@
+/*
+ * AArch64 architecture-specific GDB stub support.
+ *
+ * GDB AArch64 register set (org.gnu.gdb.aarch64.core, described in target.xml):
+ *
+ *  No.  Name    Size   KVM field
+ *  ---  ------  ----   ---------
+ *   0   x0       8     regs.regs[0]
+ *   1   x1       8     regs.regs[1]
+ *   ...
+ *  30   x30      8     regs.regs[30]  (link register)
+ *  31   sp       8     sp_el1  (kernel SP; SP_EL0 when PSTATE.EL==0)
+ *  32   pc       8     regs.pc
+ *  33   cpsr     4     regs.pstate (low 32 bits)
+ *
+ * Total: 31×8 + 8 + 8 + 4 = 268 bytes
+ *
+ * Software breakpoints:
+ *   BRK #0  →  little-endian bytes: 0x00 0x00 0x20 0xD4
+ *   (u32 = 0xD4200000)
+ *   ARM64 BRK is always 4 bytes and must be 4-byte aligned.
+ *
+ * Debug exit detection via ESR_EL2 (kvm_run->debug.arch.hsr):
+ *   EC = bits[31:26]
+ *   0x3C = BRK64  (AArch64 BRK instruction)  → software breakpoint
+ *   0x32 = SSTEP  (software single-step)
+ *   0x30 = HW_BP  (hardware execution breakpoint)
+ *   0x35 = WPTFAR (watchpoint)
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
+#include <asm/ptrace.h>
+#include <linux/kvm.h>
+
+/* ------------------------------------------------------------------ */
+/* Register layout constants                                           */
+/* ------------------------------------------------------------------ */
+
+#define GDB_NUM_REGS		34	/* x0-x30, sp, pc, cpsr */
+#define GDB_REG_SP		31
+#define GDB_REG_PC		32
+#define GDB_REG_CPSR		33
+
+/* Byte size of the 'g' register packet: 31×8 + 8 + 8 + 4 = 268 */
+#define GDB_REGS_SIZE		268
+
+/* BRK #0 instruction encoding (little-endian) */
+#define BRK0_INSN		0xD4200000U
+
+/* ESR EC field */
+#define ESR_EC_SHIFT		26
+#define ESR_EC_MASK		(0x3fU << ESR_EC_SHIFT)
+#define ESR_EC_BRK64		0x3C	/* AArch64 BRK instruction */
+#define ESR_EC_SSTEP		0x32	/* software single-step */
+#define ESR_EC_HW_BP		0x30	/* hardware execution breakpoint */
+#define ESR_EC_WATCHPT		0x35	/* watchpoint */
+
+#define ARM64_DAIF_MASK		(PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
+
+static struct {
+	struct kvm_cpu *vcpu;
+	u32		daif_bits;
+	bool		pending;
+} step_irq_state;
+
+/* ------------------------------------------------------------------ */
+/* ARM64_CORE_REG helper (same logic as arm/aarch64/kvm-cpu.c)        */
+/* ------------------------------------------------------------------ */
+
+static __u64 __core_reg_id(__u64 offset)
+{
+	__u64 id = KVM_REG_ARM64 | KVM_REG_ARM_CORE | offset;
+
+	if (offset < KVM_REG_ARM_CORE_REG(fp_regs))
+		id |= KVM_REG_SIZE_U64;
+	else if (offset < KVM_REG_ARM_CORE_REG(fp_regs.fpsr))
+		id |= KVM_REG_SIZE_U128;
+	else
+		id |= KVM_REG_SIZE_U32;
+
+	return id;
+}
+
+#define ARM64_CORE_REG(x)	__core_reg_id(KVM_REG_ARM_CORE_REG(x))
+
+/* VBAR_EL1: S3_0_C12_C0_0  (op0=3, op1=0, CRn=12, CRm=0, op2=0) */
+#define KVM_REG_VBAR_EL1	ARM64_SYS_REG(3, 0, 12, 0, 0)
+/* ESR_EL1:  S3_0_C5_C2_0   (op0=3, op1=0, CRn=5, CRm=2, op2=0) */
+#define KVM_REG_ESR_EL1		ARM64_SYS_REG(3, 0, 5, 2, 0)
+
+/* ------------------------------------------------------------------ */
+/* Single-register get/set helpers                                     */
+/* ------------------------------------------------------------------ */
+
+static int get_one_reg(struct kvm_cpu *vcpu, __u64 id, u64 *val)
+{
+	struct kvm_one_reg reg = { .id = id, .addr = (u64)val };
+
+	if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0) {
+		pr_warning("GDB: KVM_GET_ONE_REG id=0x%llx failed: %s",
+			   (unsigned long long)id, strerror(errno));
+		return -1;
+	}
+	return 0;
+}
+
+static int set_one_reg(struct kvm_cpu *vcpu, __u64 id, u64 val)
+{
+	struct kvm_one_reg reg = { .id = id, .addr = (u64)&val };
+
+	if (ioctl(vcpu->vcpu_fd, KVM_SET_ONE_REG, &reg) < 0) {
+		pr_warning("GDB: KVM_SET_ONE_REG id=0x%llx failed: %s",
+			   (unsigned long long)id, strerror(errno));
+		return -1;
+	}
+	return 0;
+}
+
+/*
+ * pstate for KVM_GET_ONE_REG is 32-bit; wrap it so the 64-bit helper works.
+ */
+static int get_pstate(struct kvm_cpu *vcpu, u32 *out)
+{
+	u64 id = ARM64_CORE_REG(regs.pstate);
+	u32 val;
+	struct kvm_one_reg reg = { .id = id, .addr = (u64)&val };
+
+	if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0) {
+		pr_warning("GDB: KVM_GET_ONE_REG(pstate) failed: %s",
+			   strerror(errno));
+		return -1;
+	}
+	*out = val;
+	return 0;
+}
+
+static int set_pstate(struct kvm_cpu *vcpu, u32 val)
+{
+	u64 id = ARM64_CORE_REG(regs.pstate);
+	struct kvm_one_reg reg = { .id = id, .addr = (u64)&val };
+
+	if (ioctl(vcpu->vcpu_fd, KVM_SET_ONE_REG, &reg) < 0) {
+		pr_warning("GDB: KVM_SET_ONE_REG(pstate) failed: %s",
+			   strerror(errno));
+		return -1;
+	}
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* Target XML                                                          */
+/* ------------------------------------------------------------------ */
+
+static const char target_xml[] =
+	"<?xml version=\"1.0\"?>\n"
+	"<!DOCTYPE target SYSTEM \"gdb-target.dtd\">\n"
+	"<target version=\"1.0\">\n"
+	"  <feature name=\"org.gnu.gdb.aarch64.core\">\n"
+	"    <reg name=\"x0\"   bitsize=\"64\"/>\n"
+	"    <reg name=\"x1\"   bitsize=\"64\"/>\n"
+	"    <reg name=\"x2\"   bitsize=\"64\"/>\n"
+	"    <reg name=\"x3\"   bitsize=\"64\"/>\n"
+	"    <reg name=\"x4\"   bitsize=\"64\"/>\n"
+	"    <reg name=\"x5\"   bitsize=\"64\"/>\n"
+	"    <reg name=\"x6\"   bitsize=\"64\"/>\n"
+	"    <reg name=\"x7\"   bitsize=\"64\"/>\n"
+	"    <reg name=\"x8\"   bitsize=\"64\"/>\n"
+	"    <reg name=\"x9\"   bitsize=\"64\"/>\n"
+	"    <reg name=\"x10\"  bitsize=\"64\"/>\n"
+	"    <reg name=\"x11\"  bitsize=\"64\"/>\n"
+	"    <reg name=\"x12\"  bitsize=\"64\"/>\n"
+	"    <reg name=\"x13\"  bitsize=\"64\"/>\n"
+	"    <reg name=\"x14\"  bitsize=\"64\"/>\n"
+	"    <reg name=\"x15\"  bitsize=\"64\"/>\n"
+	"    <reg name=\"x16\"  bitsize=\"64\"/>\n"
+	"    <reg name=\"x17\"  bitsize=\"64\"/>\n"
+	"    <reg name=\"x18\"  bitsize=\"64\"/>\n"
+	"    <reg name=\"x19\"  bitsize=\"64\"/>\n"
+	"    <reg name=\"x20\"  bitsize=\"64\"/>\n"
+	"    <reg name=\"x21\"  bitsize=\"64\"/>\n"
+	"    <reg name=\"x22\"  bitsize=\"64\"/>\n"
+	"    <reg name=\"x23\"  bitsize=\"64\"/>\n"
+	"    <reg name=\"x24\"  bitsize=\"64\"/>\n"
+	"    <reg name=\"x25\"  bitsize=\"64\"/>\n"
+	"    <reg name=\"x26\"  bitsize=\"64\"/>\n"
+	"    <reg name=\"x27\"  bitsize=\"64\"/>\n"
+	"    <reg name=\"x28\"  bitsize=\"64\"/>\n"
+	"    <reg name=\"x29\"  bitsize=\"64\"/>\n"
+	"    <reg name=\"x30\"  bitsize=\"64\"/>\n"
+	"    <reg name=\"sp\"   bitsize=\"64\" type=\"data_ptr\"/>\n"
+	"    <reg name=\"pc\"   bitsize=\"64\" type=\"code_ptr\"/>\n"
+	"    <reg name=\"cpsr\" bitsize=\"32\"/>\n"
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
+/* Helpers: which SP to expose as GDB register 31                     */
+/* ------------------------------------------------------------------ */
+
+/*
+ * When the guest is in EL1 (kernel mode), the active stack pointer is SP_EL1.
+ * When in EL0 (user mode), the active SP is SP_EL0 (regs.sp in kvm_regs).
+ * Return the appropriate KVM register ID for the active SP.
+ */
+static __u64 sp_reg_id(struct kvm_cpu *vcpu)
+{
+	u32 pstate;
+
+	if (get_pstate(vcpu, &pstate) < 0)
+		return ARM64_CORE_REG(sp_el1);	/* best-effort default */
+
+	/* PSTATE.EL = bits [3:2] */
+	if (((pstate >> 2) & 0x3) >= 1)
+		return ARM64_CORE_REG(sp_el1);
+	else
+		return ARM64_CORE_REG(regs.sp);
+}
+
+/* ------------------------------------------------------------------ */
+/* Register read / write (bulk 'g'/'G' packet)                        */
+/* ------------------------------------------------------------------ */
+
+void kvm_gdb__arch_read_registers(struct kvm_cpu *vcpu, u8 *buf, size_t *size)
+{
+	u8 *p = buf;
+	u32 pstate;
+	int i;
+
+	*size = 0;
+
+	/* x0-x30: 31 × 8 bytes */
+	for (i = 0; i < 31; i++) {
+		u64 xn;
+
+		if (get_one_reg(vcpu, ARM64_CORE_REG(regs.regs[i]), &xn) < 0)
+			return;
+		memcpy(p, &xn, 8);
+		p += 8;
+	}
+
+	/* sp (register 31): 8 bytes — active stack pointer */
+	{
+		u64 sp;
+
+		if (get_one_reg(vcpu, sp_reg_id(vcpu), &sp) < 0)
+			return;
+		memcpy(p, &sp, 8);
+		p += 8;
+	}
+
+	/* pc (register 32): 8 bytes */
+	{
+		u64 pc;
+
+		if (get_one_reg(vcpu, ARM64_CORE_REG(regs.pc), &pc) < 0)
+			return;
+		memcpy(p, &pc, 8);
+		p += 8;
+	}
+
+	/* cpsr (register 33): 4 bytes — low 32 bits of pstate */
+	if (get_pstate(vcpu, &pstate) < 0)
+		return;
+	memcpy(p, &pstate, 4);
+	p += 4;
+
+	*size = (size_t)(p - buf);
+}
+
+void kvm_gdb__arch_write_registers(struct kvm_cpu *vcpu, const u8 *buf,
+				    size_t size)
+{
+	const u8 *p = buf;
+	int i;
+
+	if (size < GDB_REGS_SIZE)
+		return;
+
+	/* x0-x30 */
+	for (i = 0; i < 31; i++) {
+		u64 xn;
+
+		memcpy(&xn, p, 8);
+		p += 8;
+		if (set_one_reg(vcpu, ARM64_CORE_REG(regs.regs[i]), xn) < 0)
+			return;
+	}
+
+	/* sp */
+	{
+		u64 sp;
+
+		memcpy(&sp, p, 8);
+		p += 8;
+		if (set_one_reg(vcpu, sp_reg_id(vcpu), sp) < 0)
+			return;
+	}
+
+	/* pc */
+	{
+		u64 pc;
+
+		memcpy(&pc, p, 8);
+		p += 8;
+		if (set_one_reg(vcpu, ARM64_CORE_REG(regs.pc), pc) < 0)
+			return;
+	}
+
+	/* cpsr */
+	{
+		u32 pstate;
+
+		memcpy(&pstate, p, 4);
+		p += 4;
+		set_pstate(vcpu, pstate);
+	}
+}
+
+/* ------------------------------------------------------------------ */
+/* Single-register read/write ('p n' / 'P n=v')                       */
+/* ------------------------------------------------------------------ */
+
+int kvm_gdb__arch_read_register(struct kvm_cpu *vcpu, int regno,
+				 u8 *buf, size_t *size)
+{
+	if (regno < 0 || regno >= GDB_NUM_REGS)
+		return -1;
+
+	if (regno < 31) {
+		/* x0 – x30 */
+		u64 xn;
+
+		if (get_one_reg(vcpu, ARM64_CORE_REG(regs.regs[regno]), &xn) < 0)
+			return -1;
+		memcpy(buf, &xn, 8);
+		*size = 8;
+	} else if (regno == GDB_REG_SP) {
+		u64 sp;
+
+		if (get_one_reg(vcpu, sp_reg_id(vcpu), &sp) < 0)
+			return -1;
+		memcpy(buf, &sp, 8);
+		*size = 8;
+	} else if (regno == GDB_REG_PC) {
+		u64 pc;
+
+		if (get_one_reg(vcpu, ARM64_CORE_REG(regs.pc), &pc) < 0)
+			return -1;
+		memcpy(buf, &pc, 8);
+		*size = 8;
+	} else {
+		/* GDB_REG_CPSR */
+		u32 pstate;
+
+		if (get_pstate(vcpu, &pstate) < 0)
+			return -1;
+		memcpy(buf, &pstate, 4);
+		*size = 4;
+	}
+
+	return 0;
+}
+
+int kvm_gdb__arch_write_register(struct kvm_cpu *vcpu, int regno,
+				  const u8 *buf, size_t size)
+{
+	if (regno < 0 || regno >= GDB_NUM_REGS)
+		return -1;
+
+	if (regno < 31) {
+		u64 xn;
+
+		if (size < 8)
+			return -1;
+		memcpy(&xn, buf, 8);
+		return set_one_reg(vcpu, ARM64_CORE_REG(regs.regs[regno]), xn);
+	} else if (regno == GDB_REG_SP) {
+		u64 sp;
+
+		if (size < 8)
+			return -1;
+		memcpy(&sp, buf, 8);
+		return set_one_reg(vcpu, sp_reg_id(vcpu), sp);
+	} else if (regno == GDB_REG_PC) {
+		u64 pc;
+
+		if (size < 8)
+			return -1;
+		memcpy(&pc, buf, 8);
+		return set_one_reg(vcpu, ARM64_CORE_REG(regs.pc), pc);
+	} else {
+		/* GDB_REG_CPSR */
+		u32 pstate;
+
+		if (size < 4)
+			return -1;
+		memcpy(&pstate, buf, 4);
+		return set_pstate(vcpu, pstate);
+	}
+}
+
+/* ------------------------------------------------------------------ */
+/* PC                                                                  */
+/* ------------------------------------------------------------------ */
+
+u64 kvm_gdb__arch_get_pc(struct kvm_cpu *vcpu)
+{
+	u64 pc = 0;
+
+	get_one_reg(vcpu, ARM64_CORE_REG(regs.pc), &pc);
+	return pc;
+}
+
+void kvm_gdb__arch_set_pc(struct kvm_cpu *vcpu, u64 pc)
+{
+	set_one_reg(vcpu, ARM64_CORE_REG(regs.pc), pc);
+}
+
+/* ------------------------------------------------------------------ */
+/* Debug control (single-step + hardware breakpoints / watchpoints)   */
+/* ------------------------------------------------------------------ */
+
+/*
+ * BCR (Breakpoint Control Register) for an enabled execution breakpoint:
+ *
+ *   Bit  1    : EN = 1 (enable)
+ *   Bits 3:2  : PMC = 0b11 (match EL0 + EL1, i.e. user and kernel)
+ *   Bits 8:5  : BAS = 0b1111 (byte address select, all 4 bytes of insn)
+ *   Bits 13:9 : (reserved / HMC, leave 0)
+ *   Bits 15:14: SSC = 0b00
+ */
+#define BCR_EXEC_ANY	0x000001e7ULL	/* EN=1, PMC=11, BAS=1111 */
+
+/*
+ * WCR (Watchpoint Control Register) base: EN=1, PAC=EL0+EL1
+ *   Bit  1    : EN = 1
+ *   Bits 3:2  : PAC = 0b11 (EL0 + EL1)
+ *   Bits 5:4  : (LSC — Load/Store/Both) — set by caller
+ *   Bits 12:5 : BAS — set by caller (byte enable)
+ */
+#define WCR_BASE	0x7ULL		/* EN=1, PAC=11 */
+
+static u64 arm64_watchpoint_bas(u64 addr, int len)
+{
+	int shift = addr & 7;
+	u64 mask;
+
+	if (len <= 0 || len > 8 || shift + len > 8)
+		return 0;
+
+	mask = (1ULL << len) - 1;
+	return mask << shift;
+}
+
+void kvm_gdb__arch_set_debug(struct kvm_cpu *vcpu, bool single_step,
+			      struct kvm_gdb_hw_bp *hw_bps)
+{
+	struct kvm_guest_debug dbg = { 0 };
+	int i;
+
+	dbg.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
+
+	if (single_step)
+		dbg.control |= KVM_GUESTDBG_SINGLESTEP;
+
+	if (hw_bps) {
+		bool any_hw = false;
+		int bp_idx = 0;	/* hardware breakpoints (exec) use dbg_bvr/bcr */
+		int wp_idx = 0;	/* watchpoints use dbg_wvr/wcr */
+
+		for (i = 0; i < 4; i++) {
+			if (!hw_bps[i].active)
+				continue;
+
+			if (hw_bps[i].type == 0) {
+				/* Execution breakpoint (Z1) */
+				if (bp_idx >= KVM_ARM_MAX_DBG_REGS)
+					continue;
+				dbg.arch.dbg_bvr[bp_idx] =
+					hw_bps[i].addr & ~3ULL; /* 4-byte align */
+				dbg.arch.dbg_bcr[bp_idx] = BCR_EXEC_ANY;
+				bp_idx++;
+			} else {
+				/* Watchpoint: write(1), read(2), access(3) */
+				u64 wcr;
+				u64 bas;
+
+				if (wp_idx >= KVM_ARM_MAX_DBG_REGS)
+					continue;
+
+				/*
+				 * BAS: byte-address-select bitmask.
+				 * For len=1→0x1, len=2→0x3, len=4→0xf, len=8→0xff.
+				 * Encode in WCR bits [12:5].
+				 */
+				bas = arm64_watchpoint_bas(hw_bps[i].addr,
+						   hw_bps[i].len);
+				if (!bas)
+					continue;
+
+				/*
+				 * LSC (Load/Store Control):
+				 *   01 = load (read), 10 = store (write),
+				 *   11 = load+store (access)
+				 * Bits [4:3] of WCR.
+				 */
+				{
+					u64 lsc;
+
+					switch (hw_bps[i].type) {
+					case 1:  lsc = 0x2; break;  /* write */
+					case 2:  lsc = 0x1; break;  /* read  */
+					default: lsc = 0x3; break;  /* access */
+					}
+					wcr = WCR_BASE |
+					      (lsc << 3) |
+					      (bas << 5);
+				}
+
+				dbg.arch.dbg_wvr[wp_idx] =
+					hw_bps[i].addr & ~7ULL; /* 8-byte align */
+				dbg.arch.dbg_wcr[wp_idx] = wcr;
+				wp_idx++;
+			}
+			any_hw = true;
+		}
+
+		if (any_hw)
+			dbg.control |= KVM_GUESTDBG_USE_HW;
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
+	u32 pstate;
+
+	if (!single_step || !from_debug_exit)
+		return;
+
+	if (get_pstate(vcpu, &pstate) < 0)
+		return;
+
+	step_irq_state.vcpu = vcpu;
+	step_irq_state.daif_bits = pstate & ARM64_DAIF_MASK;
+	step_irq_state.pending = true;
+
+	pstate |= ARM64_DAIF_MASK;
+	set_pstate(vcpu, pstate);
+}
+
+void kvm_gdb__arch_handle_stop(struct kvm_cpu *vcpu)
+{
+	u32 pstate;
+
+	if (!step_irq_state.pending || step_irq_state.vcpu != vcpu)
+		return;
+
+	if (get_pstate(vcpu, &pstate) < 0)
+		return;
+
+	pstate &= ~ARM64_DAIF_MASK;
+	pstate |= step_irq_state.daif_bits;
+	set_pstate(vcpu, pstate);
+
+	step_irq_state.pending = false;
+	step_irq_state.vcpu = NULL;
+}
+
+/* ------------------------------------------------------------------ */
+/* Stop signal                                                         */
+/* ------------------------------------------------------------------ */
+
+int kvm_gdb__arch_signal(struct kvm_cpu *vcpu __attribute__((unused)))
+{
+	/* All debug exits report SIGTRAP (5) */
+	return 5;
+}
+
+/* ------------------------------------------------------------------ */
+/* Software-breakpoint exit detection and re-injection                 */
+/* ------------------------------------------------------------------ */
+
+/*
+ * ARM64 debug exits are identified by the EC field in ESR_EL2
+ * (reported in kvm_run->debug.arch.hsr).
+ *
+ *   EC = bits[31:26] of HSR.
+ *   0x3C = ESR_ELx_EC_BRK64 → AArch64 BRK instruction.
+ */
+bool kvm_gdb__arch_is_sw_bp_exit(struct kvm_cpu *vcpu)
+{
+	u32 hsr = vcpu->kvm_run->debug.arch.hsr;
+	u32 ec  = (hsr >> ESR_EC_SHIFT) & 0x3f;
+
+	return ec == ESR_EC_BRK64;
+}
+
+/*
+ * Return the guest virtual address of the BRK instruction that triggered
+ * the current debug exit.
+ *
+ * On ARM64, when KVM intercepts a BRK:
+ *   - The guest PC has NOT been advanced (no RIP-style auto-increment).
+ *   - The PC register (regs.pc) still points at the BRK instruction itself.
+ *   - kvm_run->debug.arch.far is the FAR_EL2 value, which is UNKNOWN for
+ *     instruction-class exceptions (BRK), so we do NOT use far here.
+ *
+ * Therefore we read the current PC via KVM_GET_ONE_REG.
+ */
+u64 kvm_gdb__arch_debug_pc(struct kvm_cpu *vcpu)
+{
+	return kvm_gdb__arch_get_pc(vcpu);
+}
+
+/*
+ * Re-inject the BRK exception into the guest so that the guest kernel's own
+ * brk_handler (in arch/arm64/kernel/debug-monitors.c) can process it.
+ *
+ * ARM64 does not support arbitrary exception injection via KVM_SET_VCPU_EVENTS
+ * (the ARM64 kvm_vcpu_events struct only has SError).  Instead, we manually
+ * simulate what the CPU would do when taking a synchronous exception to EL1:
+ *
+ *   1. Save current PC → ELR_EL1          (exception return address)
+ *   2. Save current PSTATE → SPSR_EL1     (saved processor state)
+ *   3. Set ESR_EL1 = HSR from the debug exit  (syndrome for brk_handler)
+ *   4. Read VBAR_EL1 to find the exception vector base
+ *   5. Set PC = VBAR_EL1 + vector_offset   (synchronous exception vector)
+ *   6. Set PSTATE = EL1h mode, all interrupts masked
+ *
+ * Vector offset within VBAR_EL1 (ARM ARM D1.10):
+ *   +0x000  current EL, SP_EL0  (PSTATE.EL==1, PSTATE.SP==0)
+ *   +0x200  current EL, SP_ELx  (PSTATE.EL==1, PSTATE.SP==1)  ← common kernel
+ *   +0x400  lower EL, AArch64   (PSTATE.EL==0)
+ *   +0x600  lower EL, AArch32   (not used here)
+ *   Synchronous = +0x000 within each quadrant.
+ *
+ * On failure, we advance PC by 4 to skip the BRK and avoid an infinite loop,
+ * accepting that the kernel's BRK handler won't run for this instruction.
+ */
+void kvm_gdb__arch_reinject_sw_bp(struct kvm_cpu *vcpu)
+{
+	u64 pc, vbar;
+	u32 pstate, hsr;
+	u64 new_pc;
+	u64 vec_off;
+
+	hsr = vcpu->kvm_run->debug.arch.hsr;
+
+	/* Read current PC and PSTATE */
+	if (get_one_reg(vcpu, ARM64_CORE_REG(regs.pc), &pc) < 0)
+		goto advance_pc;
+	if (get_pstate(vcpu, &pstate) < 0)
+		goto advance_pc;
+
+	/* Read VBAR_EL1 — the base of the EL1 exception vector table */
+	if (get_one_reg(vcpu, KVM_REG_VBAR_EL1, &vbar) < 0)
+		goto advance_pc;
+
+	/* Step 1: ELR_EL1 = current PC (return address = BRK instruction) */
+	if (set_one_reg(vcpu, ARM64_CORE_REG(elr_el1), pc) < 0)
+		goto advance_pc;
+
+	/* Step 2: SPSR_EL1 = current PSTATE */
+	{
+		u64 spsr = pstate;
+		struct kvm_one_reg reg = {
+			.id   = ARM64_CORE_REG(spsr[KVM_SPSR_EL1]),
+			.addr = (u64)&spsr,
+		};
+		if (ioctl(vcpu->vcpu_fd, KVM_SET_ONE_REG, &reg) < 0) {
+			pr_warning("GDB: reinject: KVM_SET_ONE_REG(spsr) failed: %s",
+				   strerror(errno));
+			goto advance_pc;
+		}
+	}
+
+	/*
+	 * Step 3: ESR_EL1 = syndrome from the BRK exit.
+	 * The HSR value (ESR_EL2 at the time of the VM exit) contains the
+	 * correct EC and ISS (BRK immediate) that the kernel's brk_handler
+	 * will inspect via read_sysreg(esr_el1).
+	 */
+	if (set_one_reg(vcpu, KVM_REG_ESR_EL1, (u64)hsr) < 0)
+		goto advance_pc;
+
+	/*
+	 * Step 4+5: Determine vector offset and set PC.
+	 *
+	 * PSTATE.EL = bits[3:2], PSTATE.SP = bit[0].
+	 */
+	{
+		u32 el    = (pstate >> 2) & 0x3;
+		u32 spsel = pstate & 0x1;
+
+		if (el >= 1) {
+			/* From EL1: current EL, SP_ELx or SP_EL0 */
+			vec_off = spsel ? 0x200ULL : 0x000ULL;
+		} else {
+			/* From EL0: lower EL, AArch64 */
+			vec_off = 0x400ULL;
+		}
+	}
+	new_pc = vbar + vec_off;
+	if (set_one_reg(vcpu, ARM64_CORE_REG(regs.pc), new_pc) < 0)
+		goto advance_pc;
+
+	/* Step 6: Set PSTATE = EL1h mode, all interrupts masked */
+	if (set_pstate(vcpu, PSR_D_BIT | PSR_A_BIT | PSR_I_BIT |
+			     PSR_F_BIT | PSR_MODE_EL1h) < 0)
+		goto advance_pc;
+
+	return;
+
+advance_pc:
+	/*
+	 * Fallback: skip the 4-byte BRK instruction to prevent an infinite
+	 * KVM_EXIT_DEBUG loop.  The guest's BRK handler will NOT run.
+	 */
+	pr_warning("GDB: reinject_sw_bp failed; skipping BRK at 0x%llx",
+		   (unsigned long long)pc);
+	set_one_reg(vcpu, ARM64_CORE_REG(regs.pc), pc + 4);
+}
diff --git a/gdb.c b/gdb.c
index 50f7dfe..489084d 100644
--- a/gdb.c
+++ b/gdb.c
@@ -47,12 +47,45 @@
 #include <ctype.h>
 #include <unistd.h>
 
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
 #include <linux/kvm.h>
 
 #define GDB_MAX_SW_BP		64
 #define GDB_MAX_HW_BP		4
 #define GDB_PACKET_MAX		16384
-#define GDB_SW_BP_INSN		0xCC	/* INT3 */
+
+#ifdef CONFIG_ARM64
+/*
+ * ARM64 software breakpoint: BRK #0 (little-endian 4-byte encoding)
+ * Encoding: 0xD4200000  →  bytes: 0x00 0x00 0x20 0xD4
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
 
 /*
  * Only use raw address-as-GPA fallback for very low addresses where
@@ -63,7 +96,7 @@
 /* Software breakpoint saved state */
 struct sw_bp {
 	u64  addr;
-	u8   orig_byte;
+	u8   orig_bytes[GDB_SW_BP_INSN_LEN];	/* original instruction bytes */
 	int  refs;
 	bool active;
 };
@@ -368,8 +401,8 @@ static int sw_bp_restore(int idx)
 		return -1;
 
 	return gdb_write_guest_mem(gdb.sw_bp[idx].addr,
-				  &gdb.sw_bp[idx].orig_byte,
-				  1) ? 0 : -1;
+				  gdb.sw_bp[idx].orig_bytes,
+				  GDB_SW_BP_INSN_LEN) ? 0 : -1;
 }
 
 static int sw_bp_reinsert(int idx)
@@ -377,10 +410,9 @@ static int sw_bp_reinsert(int idx)
 	if (idx < 0 || idx >= GDB_MAX_SW_BP || !gdb.sw_bp[idx].active)
 		return -1;
 
-	u8 brk = GDB_SW_BP_INSN;
 	return gdb_write_guest_mem(gdb.sw_bp[idx].addr,
-				  &brk,
-				  1) ? 0 : -1;
+				  GDB_SW_BP_INSN,
+				  GDB_SW_BP_INSN_LEN) ? 0 : -1;
 }
 
 static bool prepare_sw_bp_resume(bool auto_resume)
@@ -537,25 +569,217 @@ static struct kvm_cpu *current_vcpu(void)
  *   This offset is fixed in the x86-64 ABI regardless of KASLR.
  */
 #ifdef CONFIG_X86
+/*
+ * x86-64 Linux kernel virtual address layout (with nokaslr):
+ *   __START_KERNEL_map  0xffffffff80000000  kernel text, GPA = GVA - base
+ *   PAGE_OFFSET         0xffff888000000000  direct phys map, GPA = GVA - base
+ */
 # define GDB_KERNEL_MAP_BASE	0xffffffff80000000ULL
 # define GDB_DIRECT_MAP_BASE	0xffff888000000000ULL
 # define GDB_DIRECT_MAP_SIZE	0x100000000000ULL	/* 16 TB */
 #endif
 
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
+ *   so kernel text GPA ≈ GVA - 0xffff800008000000 + 0x80000
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
+ * All kernel virtual addresses are ≥ 0xffff000000000000.
+ * kvmtool maps guest RAM at physical 0x40000000 (ARM64 default).
+ *
+ * Linear map formula:  GPA = GVA - 0xffff000000000000 + 0
+ *   (works because kvmtool's physical memory starts at GPA 0x0 in the slot,
+ *    but the guest itself sees RAM at IPA 0x40000000.  See arm/kvm.c.)
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
+ *   Level 0 (PGD): bits [47:39]  →  9 bits, 512 entries
+ *   Level 1 (PUD): bits [38:30]  →  9 bits, 512 entries
+ *   Level 2 (PMD): bits [29:21]  →  9 bits, 512 entries
+ *   Level 3 (PTE): bits [20:12]  →  9 bits, 512 entries
+ *   Page offset:   bits [11:0]   → 12 bits
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
+	u64 tbl = ttbr1 & 0x0000fffffffff000ULL;
+
+	pr_debug("GDB: arm64_walk GVA=0x%llx TTBR1=0x%llx tbl=0x%llx",
+		 (unsigned long long)gva,
+		 (unsigned long long)ttbr1,
+		 (unsigned long long)tbl);
+
+	/* VA bits for each level (4KB granule, VA_BITS=48) */
+	int shifts[4] = { 39, 30, 21, 12 };
+	u64 masks[4]  = { 0x1ff, 0x1ff, 0x1ff, 0x1ff };
+
+	for (int level = 0; level < 4; level++) {
+		u64 idx   = (gva >> shifts[level]) & masks[level];
+		u64 entry_gpa = tbl + idx * 8;
+
+		/* Read the 8-byte page-table entry from guest memory */
+		u8  *host = guest_flat_to_host(gdb.kvm, entry_gpa);
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
+		u64 pte;
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
+			/* Block entry at L1 (1GB) or L2 (2MB) */
+			if (level == 1) {
+				u64 pa = (pte & 0x0000ffffc0000000ULL) |
+					 (gva & 0x3fffffffULL);
+				pr_debug("GDB: arm64_walk L1 block -> PA=0x%llx", (unsigned long long)pa);
+				return pa;
+			} else if (level == 2) {
+				u64 pa = (pte & 0x0000ffffffe00000ULL) |
+					 (gva & 0x1fffffULL);
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
 /*
  * Translate a guest virtual address (GVA) to a guest physical address (GPA).
  *
  * Uses three strategies in order:
  *
  * 1. KVM_TRANSLATE on the currently selected vCPU.
- *    Fails when the vCPU was paused in user mode with Linux KPTI active,
- *    because the user-mode page table (CR3) does not map kernel addresses.
+ *    Fails when the vCPU was paused in user mode (Linux KPTI / ARM64 TTBR0)
+ *    because the user-mode page table does not map kernel addresses.
  *
  * 2. KVM_TRANSLATE on every other vCPU.
  *    On multi-vCPU systems, another vCPU may be paused in kernel mode
- *    whose page tables do include kernel mappings.
+ *    whose page tables include kernel mappings.
  *
- * 3. Fixed-offset arithmetic for well-known Linux x86-64 kernel ranges.
+ * 3. Fixed-offset arithmetic for well-known Linux kernel ranges.
  *    This is the safety net for single-vCPU systems where ALL vCPUs are
  *    paused in user mode (common when debugging a booted VM running a
  *    shell).  Only reliable with the nokaslr kernel parameter.
@@ -577,12 +801,11 @@ static u64 gva_to_gpa(u64 gva)
 	/*
 	 * Strategy 2: try every other vCPU.
 	 *
-	 * Linux KPTI uses separate CR3 values for user mode and kernel mode.
-	 * If the selected vCPU was interrupted while running a userspace
-	 * process its CR3 points to the user-mode page table, which does NOT
-	 * map kernel virtual addresses (0xffffffff8xxxxxxx).  A different
-	 * vCPU that was paused inside the kernel will have the kernel-mode
-	 * CR3 loaded and can translate those addresses successfully.
+	 * x86 Linux KPTI / ARM64: user-mode page tables do NOT map kernel
+	 * virtual addresses.  If the selected vCPU was interrupted while
+	 * running a userspace process, a different vCPU that was paused inside
+	 * the kernel will have the kernel-mode page table loaded and can
+	 * translate kernel addresses successfully.
 	 */
 	for (int i = 0; i < gdb.kvm->nrcpus; i++) {
 		struct kvm_cpu *vcpu = gdb.kvm->cpus[i];
@@ -596,11 +819,10 @@ static u64 gva_to_gpa(u64 gva)
 
 #ifdef CONFIG_X86
 	/*
-	 * Strategy 3: fixed-offset fallback for x86-64 Linux kernel ranges.
+	 * Strategy 3 (x86-64): fixed-offset fallback for Linux kernel ranges.
 	 *
 	 * When ALL vCPUs are paused in user mode (e.g. a single-vCPU VM
 	 * running a shell), KVM_TRANSLATE will fail for every kernel address.
-	 * We fall back to the known-fixed virtual→physical offsets.
 	 *
 	 * Direct physical map (PAGE_OFFSET): always fixed, KASLR-safe.
 	 * Kernel text/data (__START_KERNEL_map): fixed only with nokaslr.
@@ -613,6 +835,54 @@ static u64 gva_to_gpa(u64 gva)
 		return gva - GDB_KERNEL_MAP_BASE;
 #endif
 
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
+	 *   - kvmtool's stage-2 IPA→GPA mapping is a flat identity (it is).
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
 	return (u64)-1;
 }
 
@@ -704,21 +974,20 @@ static int sw_bp_insert(u64 addr, int len)
 		if (gdb.sw_bp[i].refs > 0)
 			continue;
 
-		u8 orig;
-		if (!gdb_read_guest_mem(addr, &orig, 1)) {
+		if (!gdb_read_guest_mem(addr, gdb.sw_bp[i].orig_bytes,
+					GDB_SW_BP_INSN_LEN)) {
 			pr_warning("GDB: sw_bp_insert read failed at GVA 0x%llx",
 				   (unsigned long long)addr);
 			return -1;
 		}
-		u8 brk = GDB_SW_BP_INSN;
-		if (!gdb_write_guest_mem(addr, &brk, 1)) {
+		if (!gdb_write_guest_mem(addr, GDB_SW_BP_INSN,
+					 GDB_SW_BP_INSN_LEN)) {
 			pr_warning("GDB: sw_bp_insert write failed at GVA 0x%llx",
 				   (unsigned long long)addr);
 			return -1;
 		}
 
 		gdb.sw_bp[i].addr   = addr;
-		gdb.sw_bp[i].orig_byte = orig;
 		gdb.sw_bp[i].refs   = 1;
 		gdb.sw_bp[i].active = true;
 		return 0;
@@ -736,7 +1005,8 @@ static int sw_bp_remove(u64 addr, int len)
 			return 0;
 
 		if (gdb.sw_bp[i].active)
-			gdb_write_guest_mem(addr, &gdb.sw_bp[i].orig_byte, 1);
+			gdb_write_guest_mem(addr, gdb.sw_bp[i].orig_bytes,
+				    GDB_SW_BP_INSN_LEN);
 		gdb.sw_bp[i].active = false;
 		return 0;
 	}
@@ -761,7 +1031,8 @@ static void sw_bp_remove_all(void)
 			continue;
 		if (gdb.sw_bp[i].active)
 			gdb_write_guest_mem(gdb.sw_bp[i].addr,
-					    &gdb.sw_bp[i].orig_byte, 1);
+					    gdb.sw_bp[i].orig_bytes,
+					    GDB_SW_BP_INSN_LEN);
 		gdb.sw_bp[i].refs = 0;
 		gdb.sw_bp[i].active = false;
 	}
diff --git a/include/kvm/gdb.h b/include/kvm/gdb.h
index 655fae8..1c3bbb5 100644
--- a/include/kvm/gdb.h
+++ b/include/kvm/gdb.h
@@ -16,7 +16,7 @@ struct kvm_gdb_hw_bp {
 	bool active;
 };
 
-#ifdef CONFIG_HAS_GDB_STUB
+#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
 
 /*
  * Public GDB stub API
-- 
2.34.1

