Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EFF3AE189;
	Thu,  6 Aug 2026 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785979131; cv=none; b=Kg/DsnqbhUTVnHJ0SgwxpzR7lNKgYHGxtdOajP3joTDXs9ULYo1Gp2dnpNa999hdCFAINEOWrfOtFj5rGZmgxH/yIZs+oCtQFXUVBS41M1sprOow9ZUE5gSCO5VeLyb7JgD81Wt/u2fyZcgcKS0EGgJFug5GnMTvIgOXzBBt3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785979131; c=relaxed/simple;
	bh=BxOfS5hgTAajTtSDCNTFao/0xEiji6AJ9kG7+J2yQ08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpQgUcfCjN/EVB9ntHxGsAn+hChaf8bjyypZpPIgpd/Ej59VwawNw7tfhVgpKH6hj3BJwq++242BMlJOJrlHywZqgzBZZKKZwDfBzU/Q/ebMTl/CejSLxW0NNFW+1GllqYi8bHiRzQaBdU2siuUp2Tu0xK5w5kqKv7Dgc/qjg6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bosx+33v; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bosx+33v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785979128; x=1817515128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BxOfS5hgTAajTtSDCNTFao/0xEiji6AJ9kG7+J2yQ08=;
  b=Bosx+33vhBHJYj4t+1d3UWSp1uO4KjaKTt6QPHi0azNRjjgZOmzI1jen
   eKEEGtLrbOJTYLmT2s5vXUv+4OGpzFV3OtYWR03KFmQLr4mzzZNjy/h+x
   s+TPTAghia2pzOb4ZWkfzAFBzKo69gEn9LoUE07LkY7JSgc9ar8T4OrNh
   l60EEe4nwC0DwKZx1yNvDjoyz334pM1aK6w+VVAKfcS2wHoHn6HwvABwc
   orzYUT7bzBKjscSRa4XYUd3NRddNyXQlCKbSu81hBTsCNzNaEtlpv75lb
   JVx9yoEBf4ezHeTcrniBtXijfZI19+cux9eJh2vlPBMuWKEx+SxHhvaJV
   Q==;
X-CSE-ConnectionGUID: JQJaupxkQ7u7mEV78OFlOg==
X-CSE-MsgGUID: vZ1+xjy3R4iCkvWVUoUZBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86594021"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="86594021"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 18:18:46 -0700
X-CSE-ConnectionGUID: sf82Y9u0Ss+9BJmr2eJvyg==
X-CSE-MsgGUID: eDfMpPsyTKmzAQeKgq3NYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="265804625"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 05 Aug 2026 18:18:46 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org,
	x86@kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Chao Gao <chao.gao@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Matlack <dmatlack@google.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 6/7] KVM: selftests: Add coverage for LASS CPUID and CR4 handling
Date: Wed,  5 Aug 2026 18:15:35 -0700
Message-ID: <20260806011536.4172258-7-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806011536.4172258-1-sohil.mehta@intel.com>
References: <20260806011536.4172258-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a LASS selftest for KVM's handling of CPUID advertisement and
CR4.LASS. Verify that a guest write to CR4.LASS generates #GP, and
leaves CR4 unchanged, when LASS isn't enumerated in the guest's CPUID.

Extend set_sregs_test to cover CR4.LASS and verify that KVM_SET_SREGS
accepts CR4.LASS when LASS is supported, and rejects it, without
modifying sregs, when it isn't.

Don't try running with CR4.LASS enabled in the guest or attempt to
trigger LASS violations. Selftests run guest code in the lower half of
the address space at CPL0, so enabling CR4.LASS would make the next
instruction fetch a violation and triple-fault the guest.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v4:
 - New patch

lass_test.c doesn't really test LASS enforcement or any other LASS
functionality. It just tests that a guest write to CR4.LASS generates
a #GP when LASS isn't enumerated. There could be a generic test which
covers such CPUID/CR4 interactions. For now, I added something for LASS
because I couldn't find one.
---
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/include/x86/processor.h     |  2 +
 tools/testing/selftests/kvm/x86/lass_test.c   | 56 +++++++++++++++++++
 .../selftests/kvm/x86/set_sregs_test.c        |  3 +
 4 files changed, 62 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/lass_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 00123169a190..86fa93e0f6c0 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -91,6 +91,7 @@ TEST_GEN_PROGS_x86 += x86/hyperv_tlb_flush
 TEST_GEN_PROGS_x86 += x86/kvm_clock_test
 TEST_GEN_PROGS_x86 += x86/kvm_pv_test
 TEST_GEN_PROGS_x86 += x86/kvm_buslock_test
+TEST_GEN_PROGS_x86 += x86/lass_test
 TEST_GEN_PROGS_x86 += x86/monitor_mwait_test
 TEST_GEN_PROGS_x86 += x86/msrs_test
 TEST_GEN_PROGS_x86 += x86/nested_close_kvm_test
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 6e6f70035508..f425166174f9 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -79,6 +79,7 @@ const char *ex_str(int vector);
 #define X86_CR4_SMEP		(1ul << 20)
 #define X86_CR4_SMAP		(1ul << 21)
 #define X86_CR4_PKE		(1ul << 22)
+#define X86_CR4_LASS		(1ul << 27)
 
 struct xstate_header {
 	u64				xstate_bv;
@@ -195,6 +196,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_SPEC_CTRL		KVM_X86_CPU_FEATURE(0x7, 0, EDX, 26)
 #define	X86_FEATURE_ARCH_CAPABILITIES	KVM_X86_CPU_FEATURE(0x7, 0, EDX, 29)
 #define	X86_FEATURE_PKS			KVM_X86_CPU_FEATURE(0x7, 0, ECX, 31)
+#define	X86_FEATURE_LASS		KVM_X86_CPU_FEATURE(0x7, 1, EAX, 6)
 #define	X86_FEATURE_XTILECFG		KVM_X86_CPU_FEATURE(0xD, 0, EAX, 17)
 #define	X86_FEATURE_XTILEDATA		KVM_X86_CPU_FEATURE(0xD, 0, EAX, 18)
 #define	X86_FEATURE_XSAVES		KVM_X86_CPU_FEATURE(0xD, 1, EAX, 3)
diff --git a/tools/testing/selftests/kvm/x86/lass_test.c b/tools/testing/selftests/kvm/x86/lass_test.c
new file mode 100644
index 000000000000..7c5cfa24c2bd
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/lass_test.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Linear Address Space Separation (LASS) test
+ *
+ * Copyright (C) 2026, Intel Corporation.
+ *
+ * Only test that the guest can't set CR4.LASS when LASS isn't
+ * enumerated in the guest's CPUID.  KVM's handling of CR4.LASS via
+ * KVM_SET_SREGS is covered by set_sregs_test.
+ *
+ * Testing LASS enforcement requires running supervisor code in the
+ * upper half of the address space, which the KVM selftests framework
+ * doesn't support. Enabling CR4.LASS in the current framework would
+ * make the next instruction fetch a violation and triple-fault the
+ * guest.
+ */
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+/*
+ * Without LASS in CPUID, a guest write must generate #GP without
+ * changing CR4. Reserved bits are owned by KVM so the write is
+ * guaranteed to exit to KVM.
+ */
+static void guest_code(void)
+{
+	u8 vector;
+
+	GUEST_ASSERT(!this_cpu_has(X86_FEATURE_LASS));
+
+	vector = kvm_asm_safe("mov %[cr4], %%cr4",
+			      [cr4] "r"(get_cr4() | X86_CR4_LASS));
+	__GUEST_ASSERT(vector == GP_VECTOR,
+		       "Wanted #GP on CR4.LASS, got %s", ex_str(vector));
+	GUEST_ASSERT(!(get_cr4() & X86_CR4_LASS));
+
+	GUEST_DONE();
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_LASS));
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	vcpu_clear_cpuid_feature(vcpu, X86_FEATURE_LASS);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
+
+	kvm_vm_free(vm);
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/x86/set_sregs_test.c b/tools/testing/selftests/kvm/x86/set_sregs_test.c
index 603226ffe437..8b375fea84d0 100644
--- a/tools/testing/selftests/kvm/x86/set_sregs_test.c
+++ b/tools/testing/selftests/kvm/x86/set_sregs_test.c
@@ -72,6 +72,8 @@ static u64 calc_supported_cr4_feature_bits(void)
 		cr4 |= X86_CR4_SMAP;
 	if (kvm_cpu_has(X86_FEATURE_PKU))
 		cr4 |= X86_CR4_PKE;
+	if (kvm_cpu_has(X86_FEATURE_LASS))
+		cr4 |= X86_CR4_LASS;
 
 	return cr4;
 }
@@ -128,6 +130,7 @@ static void test_cr_bits(struct kvm_vcpu *vcpu, u64 cr4)
 	TEST_INVALID_SREG_BIT(vcpu, cr4, sregs, X86_CR4_SMEP);
 	TEST_INVALID_SREG_BIT(vcpu, cr4, sregs, X86_CR4_SMAP);
 	TEST_INVALID_SREG_BIT(vcpu, cr4, sregs, X86_CR4_PKE);
+	TEST_INVALID_SREG_BIT(vcpu, cr4, sregs, X86_CR4_LASS);
 
 	for (i = 32; i < 64; i++)
 		TEST_INVALID_SREG_BIT(vcpu, cr0, sregs, BIT(i));
-- 
2.43.0

