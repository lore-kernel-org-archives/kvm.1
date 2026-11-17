Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940347;
	b=x9Z/NvI/8TwsUbPF5297m4maRQTuVpa6t+q/tk20SWZrWaUKZGZTyHl07hjJH11Jh7wr
	 rE/0TIbyqB/yx/SZEkf2aJLzhVmdVqzEHMV4YtVmzTv+8JxfPEDW+z+u9YdMt7UdGNFTB
	 D4VM3SigX5oSssNDPJanthNkSQGGOFrlcEvZAPGUR26ZLxoKJMtxnTEobpuRULZk3+3DK
	 /hjMY+gM/5JzmkuANbGTh3JDjse8WNlDbQGS5Sqwl33ZmmOAp8UYdpe9SimGk5P0YZYhr
	 Ih/MoK/WFEpRldpQ8fQhvohAjPduVw5n7/EYOdzOMObRiNNDh5lHCgQio1fr3/GMylA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940347;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+ybsgDpDL6V7uokQLj4QSvEqL4I0A+RycmDOqAOMhuA=;
	b=qQrBcXAPzP7v3S5GUKrdaYhwxkpQsePSt7HX6NHheiPj9t72Mdqkabd3zl4awix/Ertr
	 Xm1BewtlsxeLBCG/3LLeTj7dHCjDcyOqnBxnGpBN9oFMqT4e5l733apYAhXfm4a/jSBIA
	 FdLOi/ea90hN56214byeJaKpxpqMxgYQrgK35qYGYq8qYkJ9Q1OnYQJS7gdvkXuOrtBDT
	 8FVfdwg/JCVMk9415LPJ6et0DqJmc3eqpIsH1HkAJ5lIvn7lu0W1JpTBes6K7KYK2iQ/G
	 wz4uOjP1ahaIa6Nw3m+Vm/5wgvGWxIRNNTiMoLAUmwUJcvuyrQ0B487EIA/vgWU5KKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J93oMG35;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1317960A3811;
	Tue, 17 Nov 2026 18:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1317960A3811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J93oMG35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794940347; x=1826476347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e9kKEk5EShzmKQ/HQespqG3uyBMUaLWjoN/1T9nG4HA=;
  b=J93oMG35wOOoXoibZ+WfmdJAsqq04RZ6Kw+6JUFqup83YHLCZ7N7Z69b
   IZYb2cJXawFZPonVEmLLqklcNHkuvd/mXlWfmhaLk7Ls9IFJjIJYbcAcb
   BBKUkVJoDp4rwFdXJvB3S8pK36N27/GwpCzv5HYnl4OJh4yjGpKtCqi2I
   Np79iJTojM+RY7xT/frRc5YZ53KjRHyUPCASC0NDitK8lrxmoMTirB33n
   l6QmIE+RxkV/7aBlW8HASlz44Y7MYDuo8spl4WrxABjkUAXWXV+FwjCe8
   nHgW0bhWkAJ46lUXdo5nc7hKP2SHqWVfiSws0MmrMY1HewWHsf8v/1GUY
   Q==;
X-CSE-ConnectionGUID: jODOOfPTSzK1wXAddpZ+gg==
X-CSE-MsgGUID: m9FMp3PyTCmxRoy/DhbQqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3607383"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3607383"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:31:06 -0800
X-CSE-ConnectionGUID: oWuQjIybRtuCQtqwbzIvgA==
X-CSE-MsgGUID: auR9mXz9RVCCqd79SDws/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9775099"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 17 Nov 2026 10:31:06 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 19/20] KVM: selftests: Add APX state and ABI test
Date: Tue, 17 Nov 2026 18:03:09 +0000
Message-ID: <20261117180310.921701-20-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117180310.921701-1-chang.seok.bae@intel.com>
References: <20261117180310.921701-1-chang.seok.bae@intel.com>
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

Test APX-specific behavior and ABI interactions as these are unique
compared to other state components:

  * EGPR state is saved on VM entry assembly (unlike other components).
  * The saved state is retained even if the guest disables APX.
  * EGPR state is exposed via the XSAVE ABI while not stored in the
    kernel XSAVE buffer.
  * EGPR state is initialized through the XSAVE ABI by clearing
    XSTATE_BV[APX]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V8 -> V9:
 * Add APX clearing test (Jim Mattson)
 * Add volatile to inline asm (Jim Mattson)
 * uint64_t -> u64 (Jim Mattson)
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     | 120 ++++++++++
 tools/testing/selftests/kvm/x86/apx_test.c    | 209 ++++++++++++++++++
 3 files changed, 330 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/apx_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 95867977beb3..ed935da8cc3e 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -169,6 +169,7 @@ TEST_GEN_PROGS_x86 += x86/recalc_apic_map_test
 TEST_GEN_PROGS_x86 += x86/aperfmperf_test
 TEST_GEN_PROGS_x86 += x86/guest_memfd_conversions_test
 TEST_GEN_PROGS_x86 += x86/tdx_vm_test
+TEST_GEN_PROGS_x86 += x86/apx_test
 TEST_GEN_PROGS_x86 += access_tracking_perf_test
 TEST_GEN_PROGS_x86 += coalesced_io_test
 TEST_GEN_PROGS_x86 += dirty_log_perf_test
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 3e4351ccb359..c9a76c68fded 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -122,6 +122,7 @@ struct xstate {
 #define XFEATURE_MASK_LBR		BIT_ULL(15)
 #define XFEATURE_MASK_XTILE_CFG		BIT_ULL(17)
 #define XFEATURE_MASK_XTILE_DATA	BIT_ULL(18)
+#define XFEATURE_MASK_APX		BIT_ULL(19)
 
 #define XFEATURE_MASK_AVX512		(XFEATURE_MASK_OPMASK | \
 					 XFEATURE_MASK_ZMM_Hi256 | \
@@ -209,6 +210,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_SPEC_CTRL		KVM_X86_CPU_FEATURE(0x7, 0, EDX, 26)
 #define	X86_FEATURE_ARCH_CAPABILITIES	KVM_X86_CPU_FEATURE(0x7, 0, EDX, 29)
 #define	X86_FEATURE_PKS			KVM_X86_CPU_FEATURE(0x7, 0, ECX, 31)
+#define	X86_FEATURE_APX			KVM_X86_CPU_FEATURE(0x7, 1, EDX, 21)
 #define	X86_FEATURE_XTILECFG		KVM_X86_CPU_FEATURE(0xD, 0, EAX, 17)
 #define	X86_FEATURE_XTILEDATA		KVM_X86_CPU_FEATURE(0xD, 0, EAX, 18)
 #define	X86_FEATURE_XSAVES		KVM_X86_CPU_FEATURE(0xD, 1, EAX, 3)
@@ -948,6 +950,124 @@ static inline void write_sse_reg(int reg, const sse128_t *data)
 	}
 }
 
+static inline unsigned long read_egpr(int reg)
+{
+	unsigned long data = 0;
+
+	/* mov %r16...%r31, %rax */
+	switch (reg) {
+	case 16:
+		asm volatile(".byte 0xd5, 0x48, 0x89, 0xc0" : "=a"(data));
+		break;
+	case 17:
+		asm volatile(".byte 0xd5, 0x48, 0x89, 0xc8" : "=a"(data));
+		break;
+	case 18:
+		asm volatile(".byte 0xd5, 0x48, 0x89, 0xd0" : "=a"(data));
+		break;
+	case 19:
+		asm volatile(".byte 0xd5, 0x48, 0x89, 0xd8" : "=a"(data));
+		break;
+	case 20:
+		asm volatile(".byte 0xd5, 0x48, 0x89, 0xe0" : "=a"(data));
+		break;
+	case 21:
+		asm volatile(".byte 0xd5, 0x48, 0x89, 0xe8" : "=a"(data));
+		break;
+	case 22:
+		asm volatile(".byte 0xd5, 0x48, 0x89, 0xf0" : "=a"(data));
+		break;
+	case 23:
+		asm volatile(".byte 0xd5, 0x48, 0x89, 0xf8" : "=a"(data));
+		break;
+	case 24:
+		asm volatile(".byte 0xd5, 0x4c, 0x89, 0xc0" : "=a"(data));
+		break;
+	case 25:
+		asm volatile(".byte 0xd5, 0x4c, 0x89, 0xc8" : "=a"(data));
+		break;
+	case 26:
+		asm volatile(".byte 0xd5, 0x4c, 0x89, 0xd0" : "=a"(data));
+		break;
+	case 27:
+		asm volatile(".byte 0xd5, 0x4c, 0x89, 0xd8" : "=a"(data));
+		break;
+	case 28:
+		asm volatile(".byte 0xd5, 0x4c, 0x89, 0xe0" : "=a"(data));
+		break;
+	case 29:
+		asm volatile(".byte 0xd5, 0x4c, 0x89, 0xe8" : "=a"(data));
+		break;
+	case 30:
+		asm volatile(".byte 0xd5, 0x4c, 0x89, 0xf0" : "=a"(data));
+		break;
+	case 31:
+		asm volatile(".byte 0xd5, 0x4c, 0x89, 0xf8" : "=a"(data));
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
+	/* mov %rax, %r16...%r31 */
+	switch (reg) {
+	case 16:
+		asm volatile(".byte 0xd5, 0x18, 0x89, 0xc0" : : "a"(data));
+		break;
+	case 17:
+		asm volatile(".byte 0xd5, 0x18, 0x89, 0xc1" : : "a"(data));
+		break;
+	case 18:
+		asm volatile(".byte 0xd5, 0x18, 0x89, 0xc2" : : "a"(data));
+		break;
+	case 19:
+		asm volatile(".byte 0xd5, 0x18, 0x89, 0xc3" : : "a"(data));
+		break;
+	case 20:
+		asm volatile(".byte 0xd5, 0x18, 0x89, 0xc4" : : "a"(data));
+		break;
+	case 21:
+		asm volatile(".byte 0xd5, 0x18, 0x89, 0xc5" : : "a"(data));
+		break;
+	case 22:
+		asm volatile(".byte 0xd5, 0x18, 0x89, 0xc6" : : "a"(data));
+		break;
+	case 23:
+		asm volatile(".byte 0xd5, 0x18, 0x89, 0xc7" : : "a"(data));
+		break;
+	case 24:
+		asm volatile(".byte 0xd5, 0x19, 0x89, 0xc0" : : "a"(data));
+		break;
+	case 25:
+		asm volatile(".byte 0xd5, 0x19, 0x89, 0xc1" : : "a"(data));
+		break;
+	case 26:
+		asm volatile(".byte 0xd5, 0x19, 0x89, 0xc2" : : "a"(data));
+		break;
+	case 27:
+		asm volatile(".byte 0xd5, 0x19, 0x89, 0xc3" : : "a"(data));
+		break;
+	case 28:
+		asm volatile(".byte 0xd5, 0x19, 0x89, 0xc4" : : "a"(data));
+		break;
+	case 29:
+		asm volatile(".byte 0xd5, 0x19, 0x89, 0xc5" : : "a"(data));
+		break;
+	case 30:
+		asm volatile(".byte 0xd5, 0x19, 0x89, 0xc6" : : "a"(data));
+		break;
+	case 31:
+		asm volatile(".byte 0xd5, 0x19, 0x89, 0xc7" : : "a"(data));
+		break;
+	default:
+		BUG();
+	}
+}
+
 static inline void invlpg(u64 addr)
 {
 	__asm__ __volatile__("invlpg (%0)" : : "r"(addr) : "memory");
diff --git a/tools/testing/selftests/kvm/x86/apx_test.c b/tools/testing/selftests/kvm/x86/apx_test.c
new file mode 100644
index 000000000000..fce737e623ac
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/apx_test.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "processor.h"
+
+enum stages {
+	GUEST_UPDATE,
+	USERSPACE_UPDATE,
+	GUEST_APXOFF,
+	USERSPACE_CLEAR,
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
+	case USERSPACE_CLEAR:
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
+static void test_userspace_clear(void)
+{
+	/* Userspace clears XSTATE_BV[APX] via the KVM XSAVE ABI */
+	GUEST_SYNC(USERSPACE_CLEAR);
+	GUEST_ASSERT(validate_egprs(USERSPACE_CLEAR));
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
+	test_userspace_clear();
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
+static inline void xstatebv_set(void *xsave, u64 mask)
+{
+	*(u64 *)(xsave + XSAVE_HDR_OFFSET) |= mask;
+}
+
+static inline void xstatebv_clear(void *xsave, u64 mask)
+{
+	*(u64 *)(xsave + XSAVE_HDR_OFFSET) &= ~mask;
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
+			vcpu_xsave2_get(vcpu, xsave);
+			if (stage == USERSPACE_UPDATE) {
+				write_xsave_egprs(xsave, stage);
+				vcpu_xsave_set(vcpu, xsave);
+			} else if (stage == USERSPACE_CLEAR) {
+				xstatebv_clear(xsave, XFEATURE_MASK_APX);
+				vcpu_xsave_set(vcpu, xsave);
+			} else {
+				TEST_ASSERT(validate_xsave_egprs(xsave, stage),
+					    "EGPR state mismatch in userspace XSAVE buffer");
+			}
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
2.53.0

