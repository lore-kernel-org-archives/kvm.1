Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23B73164A9;
	Tue, 12 May 2026 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550042; cv=none; b=e20Vx2P+8Mm+PFnX+R1noY/9GzpPAja+2BpCUNqHkeApTxoL/DiVZR+W4+xfsl9xd++MXkk/1MiTW27Eb3QlpIxKEjrNnej1SBU+AjAsRZp0WmT/yk7lQS0LF9iTQjYx9+eTXuibPwzPlrlHBjFg7E8p1gET6kWipY+Zj4rfznY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550042; c=relaxed/simple;
	bh=IODy8Aa4qLzryR6er+0d7UKmZ+K5zIK5zWnJNb0bQvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqeP/RsvRmgrqDQWwJ+UwbxUd8LuJ5vFRf+Sew63zdOURJK+C5d0li1IWwuXxZwsB9MZcczvTW8ghtPhTAYQevzrYWNxhqjPNOjQDL2zK5MG0t+s+x3dL3OYM1WSmIFQUCXdtOh18Yy2mSFOHqiN3s2lgM7Yeh2XDFNrpzGMLhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hnajmxbm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hnajmxbm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778550041; x=1810086041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IODy8Aa4qLzryR6er+0d7UKmZ+K5zIK5zWnJNb0bQvg=;
  b=hnajmxbmuFcdzNJeojGWcT29ofejOGMPaxajXR7z2kQW7p/wE9T40nC8
   xk1n6XDIU21qBAKqvFRWF2WWxm0QzsR9g6mAsCDGAAkPo0jFRzUZVRGPd
   FSZtqqFWpCF0YpLcU0z4/9PxdTiSInY7bWNTPT9F0fZ9skYmj6Rm3ZqsL
   J0i5oj209lfPCI+eNBLnJkGjuVL5JZzJjac7YrdJfZ1GSVvDeKZCRIXR4
   +ejRRaVPYpkYYRMdbJxAi2ZfrkraIRvi4SiZsNPJOA5c4HhtncyCaQiKZ
   nQI5BV43d8kQt8H+hupWo/BksUg6dVuKXYVxJyWuTJcQPDYFtzE71AAl7
   A==;
X-CSE-ConnectionGUID: TJS9aDyOTFy26CP/NPcSsg==
X-CSE-MsgGUID: dDyLoyDYTV6vwZ5WQLkkrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83322198"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83322198"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:40:33 -0700
X-CSE-ConnectionGUID: WrW7DQD5RnqLUN2qj6b6gQ==
X-CSE-MsgGUID: H9RF5DMVQ1aEzPW1wYOckQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="234572839"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by fmviesa007.fm.intel.com with ESMTP; 11 May 2026 18:40:33 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v4 20/21] KVM: x86: selftests: Add APX state and ABI test
Date: Tue, 12 May 2026 01:15:01 +0000
Message-ID: <20260512011502.53072-21-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512011502.53072-1-chang.seok.bae@intel.com>
References: <20260512011502.53072-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test APX-specific behavior and ABI interactions as these are unique
comparing to other state components:

  * EGPR state is saved on VM entry assembly (unlike other components).
  * The saved state is retained even if the guest disables APX.
  * EGPR state is exposed via the XSAVE ABI while not stored in the
    kernel XSAVE buffer.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     | 120 +++++++++++
 tools/testing/selftests/kvm/x86/apx_test.c    | 191 ++++++++++++++++++
 3 files changed, 312 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/apx_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9118a5a51b89..7fcb1b88bdd6 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -158,6 +158,7 @@ TEST_GEN_PROGS_x86 += rseq_test
 TEST_GEN_PROGS_x86 += steal_time
 TEST_GEN_PROGS_x86 += system_counter_offset_test
 TEST_GEN_PROGS_x86 += pre_fault_memory_test
+TEST_GEN_PROGS_x86 += x86/apx_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 77f576ee7789..4c3cd65fce81 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -90,6 +90,7 @@ struct xstate {
 #define XFEATURE_MASK_LBR		BIT_ULL(15)
 #define XFEATURE_MASK_XTILE_CFG		BIT_ULL(17)
 #define XFEATURE_MASK_XTILE_DATA	BIT_ULL(18)
+#define XFEATURE_MASK_APX		BIT_ULL(19)
 
 #define XFEATURE_MASK_AVX512		(XFEATURE_MASK_OPMASK | \
 					 XFEATURE_MASK_ZMM_Hi256 | \
@@ -177,6 +178,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_SPEC_CTRL		KVM_X86_CPU_FEATURE(0x7, 0, EDX, 26)
 #define	X86_FEATURE_ARCH_CAPABILITIES	KVM_X86_CPU_FEATURE(0x7, 0, EDX, 29)
 #define	X86_FEATURE_PKS			KVM_X86_CPU_FEATURE(0x7, 0, ECX, 31)
+#define X86_FEATURE_APX			KVM_X86_CPU_FEATURE(0x7, 1, EDX, 21)
 #define	X86_FEATURE_XTILECFG		KVM_X86_CPU_FEATURE(0xD, 0, EAX, 17)
 #define	X86_FEATURE_XTILEDATA		KVM_X86_CPU_FEATURE(0xD, 0, EAX, 18)
 #define	X86_FEATURE_XSAVES		KVM_X86_CPU_FEATURE(0xD, 1, EAX, 3)
@@ -859,6 +861,124 @@ static inline void write_sse_reg(int reg, const sse128_t *data)
 	}
 }
 
+static inline unsigned long read_egpr(int reg)
+{
+	unsigned long data = 0;
+
+	/* mov %r16..%r31, %rax */
+	switch (reg) {
+	case 16:
+		asm(".byte 0xd5, 0x48, 0x89, 0xc0" : "=a"(data));
+		break;
+	case 17:
+		asm(".byte 0xd5, 0x48, 0x89, 0xc8" : "=a"(data));
+		break;
+	case 18:
+		asm(".byte 0xd5, 0x48, 0x89, 0xd0" : "=a"(data));
+		break;
+	case 19:
+		asm(".byte 0xd5, 0x48, 0x89, 0xd8" : "=a"(data));
+		break;
+	case 20:
+		asm(".byte 0xd5, 0x48, 0x89, 0xe0" : "=a"(data));
+		break;
+	case 21:
+		asm(".byte 0xd5, 0x48, 0x89, 0xe8" : "=a"(data));
+		break;
+	case 22:
+		asm(".byte 0xd5, 0x48, 0x89, 0xf0" : "=a"(data));
+		break;
+	case 23:
+		asm(".byte 0xd5, 0x48, 0x89, 0xf8" : "=a"(data));
+		break;
+	case 24:
+		asm(".byte 0xd5, 0x4c, 0x89, 0xc0" : "=a"(data));
+		break;
+	case 25:
+		asm(".byte 0xd5, 0x4c, 0x89, 0xc8" : "=a"(data));
+		break;
+	case 26:
+		asm(".byte 0xd5, 0x4c, 0x89, 0xd0" : "=a"(data));
+		break;
+	case 27:
+		asm(".byte 0xd5, 0x4c, 0x89, 0xd8" : "=a"(data));
+		break;
+	case 28:
+		asm(".byte 0xd5, 0x4c, 0x89, 0xe0" : "=a"(data));
+		break;
+	case 29:
+		asm(".byte 0xd5, 0x4c, 0x89, 0xe8" : "=a"(data));
+		break;
+	case 30:
+		asm(".byte 0xd5, 0x4c, 0x89, 0xf0" : "=a"(data));
+		break;
+	case 31:
+		asm(".byte 0xd5, 0x4c, 0x89, 0xf8" : "=a"(data));
+		break;
+	default:
+		BUG();
+	}
+
+	return data;
+}
+
+static inline void write_egpr(int reg, unsigned long data)
+{
+	/* mov %%rax, %r16...%r31*/
+	switch (reg) {
+	case 16:
+		asm(".byte 0xd5, 0x18, 0x89, 0xc0" : : "a"(data));
+		break;
+	case 17:
+		asm(".byte 0xd5, 0x18, 0x89, 0xc1" : : "a"(data));
+		break;
+	case 18:
+		asm(".byte 0xd5, 0x18, 0x89, 0xc2" : : "a"(data));
+		break;
+	case 19:
+		asm(".byte 0xd5, 0x18, 0x89, 0xc3" : : "a"(data));
+		break;
+	case 20:
+		asm(".byte 0xd5, 0x18, 0x89, 0xc4" : : "a"(data));
+		break;
+	case 21:
+		asm(".byte 0xd5, 0x18, 0x89, 0xc5" : : "a"(data));
+		break;
+	case 22:
+		asm(".byte 0xd5, 0x18, 0x89, 0xc6" : : "a"(data));
+		break;
+	case 23:
+		asm(".byte 0xd5, 0x18, 0x89, 0xc7" : : "a"(data));
+		break;
+	case 24:
+		asm(".byte 0xd5, 0x19, 0x89, 0xc0" : : "a"(data));
+		break;
+	case 25:
+		asm(".byte 0xd5, 0x19, 0x89, 0xc1" : : "a"(data));
+		break;
+	case 26:
+		asm(".byte 0xd5, 0x19, 0x89, 0xc2" : : "a"(data));
+		break;
+	case 27:
+		asm(".byte 0xd5, 0x19, 0x89, 0xc3" : : "a"(data));
+		break;
+	case 28:
+		asm(".byte 0xd5, 0x19, 0x89, 0xc4" : : "a"(data));
+		break;
+	case 29:
+		asm(".byte 0xd5, 0x19, 0x89, 0xc5" : : "a"(data));
+		break;
+	case 30:
+		asm(".byte 0xd5, 0x19, 0x89, 0xc6" : : "a"(data));
+		break;
+	case 31:
+		asm(".byte 0xd5, 0x19, 0x89, 0xc7" : : "a"(data));
+		break;
+	default:
+		BUG();
+	}
+}
+
 static inline void cpu_relax(void)
 {
 	asm volatile("rep; nop" ::: "memory");
diff --git a/tools/testing/selftests/kvm/x86/apx_test.c b/tools/testing/selftests/kvm/x86/apx_test.c
new file mode 100644
index 000000000000..796ed9eb6957
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/apx_test.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "processor.h"
+
+enum stages {
+	GUEST_UPDATE,
+	USERSPACE_UPDATE,
+	GUEST_APXOFF,
+};
+
+enum egpr_ops {
+	EGPRS_WRITE,
+	EGPRS_CHECK,
+};
+
+#define for_each_egpr(reg)	for (reg = 16; reg <= 31; reg++)
+
+/*
+ * Deterministic per-stage test values for EGPRs so that guest and
+ * userspace can validate state transitions.
+ */
+static inline unsigned long egpr_data(enum stages stage, int reg)
+{
+	switch (stage) {
+	case GUEST_UPDATE:
+		return 0xabcd + reg;
+	case USERSPACE_UPDATE:
+		return 0xbcde + reg;
+	case GUEST_APXOFF:
+		return 0xcdef + reg;
+	default:
+		return 0;
+	}
+}
+
+/*
+ * Read/write or validate EGPR values either directly via registers
+ * (guest context) or via a provided buffer (userspace XSAVE).
+ */
+static bool handle_egprs(enum egpr_ops ops, unsigned long *egprs, enum stages stage)
+{
+	unsigned long data;
+	int reg;
+
+	for_each_egpr(reg) {
+		data = egpr_data(stage, reg);
+
+		if (ops == EGPRS_WRITE) {
+			if (egprs)
+				egprs[reg - 16] = data;
+			else
+				write_egpr(reg, data);
+			continue;
+		}
+
+		if (ops != EGPRS_CHECK)
+			return false;
+
+		if (egprs) {
+			if (egprs[reg - 16] != data)
+				return false;
+			continue;
+		}
+
+		if (read_egpr(reg) != data)
+			return false;
+	}
+
+	return true;
+}
+
+static void write_egprs(enum stages stage)
+{
+	handle_egprs(EGPRS_WRITE, NULL, stage);
+}
+
+static bool validate_egprs(enum stages stage)
+{
+	return handle_egprs(EGPRS_CHECK, NULL, stage);
+}
+
+static void test_guest_update(void)
+{
+	write_egprs(GUEST_UPDATE);
+	GUEST_SYNC(GUEST_UPDATE);
+	GUEST_ASSERT(validate_egprs(GUEST_UPDATE));
+}
+
+static void test_userspace_update(void)
+{
+	/* Userspace updates EGPR state via the KVM XSAVE ABI */
+	GUEST_SYNC(USERSPACE_UPDATE);
+	GUEST_ASSERT(validate_egprs(USERSPACE_UPDATE));
+}
+
+static void test_guest_apxoff(void)
+{
+	write_egprs(GUEST_APXOFF);
+	/* Disable APX to verify state is preserved */
+	GUEST_ASSERT(!xsetbv_safe(0, this_cpu_supported_xcr0() & ~XFEATURE_MASK_APX));
+	GUEST_SYNC(GUEST_APXOFF);
+	GUEST_ASSERT(!xsetbv_safe(0, this_cpu_supported_xcr0()));
+	GUEST_ASSERT(validate_egprs(GUEST_APXOFF));
+}
+
+static void guest_code(void)
+{
+	set_cr4(get_cr4() | X86_CR4_OSXSAVE);
+	GUEST_ASSERT(!xsetbv_safe(0, this_cpu_supported_xcr0()));
+
+	test_guest_update();
+	test_userspace_update();
+	test_guest_apxoff();
+
+	GUEST_DONE();
+}
+
+#define X86_PROPERTY_XSTATE_APX_OFFSET	KVM_X86_CPU_PROPERTY(0xd, 19, EBX, 0, 31)
+#define XSAVE_HDR_OFFSET		512
+
+static inline unsigned long *xsave_egprs(void *xsave)
+{
+	return xsave + kvm_cpu_property(X86_PROPERTY_XSTATE_APX_OFFSET);
+}
+
+static inline void xstatebv_set(void *xsave, uint64_t mask)
+{
+	*(uint64_t *)(xsave + XSAVE_HDR_OFFSET) |= mask;
+}
+
+static void write_xsave_egprs(void *xsave, enum stages stage)
+{
+	handle_egprs(EGPRS_WRITE, xsave_egprs(xsave), stage);
+	xstatebv_set(xsave, XFEATURE_MASK_APX);
+}
+
+static bool validate_xsave_egprs(void *xsave, enum stages stage)
+{
+	return handle_egprs(EGPRS_CHECK, xsave_egprs(xsave), stage);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_xsave *xsave;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	enum stages stage;
+	struct ucall uc;
+	int xsave_size;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_XSAVE));
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_APX));
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	xsave_size = vm_check_cap(vcpu->vm, KVM_CAP_XSAVE2);
+	TEST_ASSERT(xsave_size, "KVM_CAP_XSAVE2 not supported");
+	xsave = malloc(xsave_size);
+	TEST_ASSERT(xsave, "Failed to allocate XSAVE buffer");
+
+	while (1) {
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			break;
+		case UCALL_SYNC: {
+			stage = uc.args[1];
+			vcpu_xsave_get(vcpu, xsave);
+			if (stage == USERSPACE_UPDATE) {
+				write_xsave_egprs(xsave, stage);
+			} else {
+				TEST_ASSERT(validate_xsave_egprs(xsave, stage),
+					    "EGPR state mismatch in userspace XSAVE buffer");
+			}
+			vcpu_xsave_set(vcpu, xsave);
+			break;
+		}
+		case UCALL_DONE:
+			goto done;
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+	}
+
+done:
+	free(xsave);
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.51.0

