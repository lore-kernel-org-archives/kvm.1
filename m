Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D4E3AAF6F;
	Thu,  6 Aug 2026 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785979132; cv=none; b=Q4g8YBHFm+AWhkSj8xLYsPZfRsb0Vvk9ANzNEqJxoLIvdjebtaetuz+PCoMX5hkHoNedOXRVnaPClHj4bhjSTQ3dB8c/mty0xpyOiXeJFi1+r6v5bu2b3flUqmYrmJmH2VZ4DnSoypzTlNVUq4HzuPwJdDeKbWEklItQJL/t7w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785979132; c=relaxed/simple;
	bh=JwrLBmLPZiV7n39tRdGSdaQ9o/LklC1Ew4xirHM6vSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnVxHiWqgYQkKEu0B3qSooJyWYVGvl9CzP7zWr64F+mw9Pfpy9xBt3NhpX/PFaBTwPnDVPSET65y6Kxbv2PyvQ6VwufsYJxFj0kQ+Kn0ZTPrC3o74vF4IOTQNFRnXfi1VQLZgZ33N34HVm75vFscpduuumSrAMjuOd2aXzMrp9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d/Y+nZ6x; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d/Y+nZ6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785979129; x=1817515129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JwrLBmLPZiV7n39tRdGSdaQ9o/LklC1Ew4xirHM6vSA=;
  b=d/Y+nZ6xGdzMNMuTtpwzCf72iGDD36Ma7Mi1otssEv41LKGuGTJViRtK
   Rw4qCPVnizec+BnYWNowNwX2wQYLrCeBkRH/Vdq/Gz1QlVhOORxlYHiSP
   7II0pyMSRknH4iIwB4gX0+E8L1/PogHz/8bTTlHevvS6Tbkoo6ud3Gg4F
   3dwpXZD7YqcnhBuQhJsXKoLyry0bumccfsrXGYcFdTT7/eeFMpsi1gQ2C
   mVclU+byk1++26Mu3pOpnym3w/+t+pG0xi3z1USt21zUiklj+NpwcAD2I
   H75ij92eW5o/QTMp4R3HQ1YUbseAuW0voI+xrftN8J6eCmrzpaktS+joL
   Q==;
X-CSE-ConnectionGUID: knVl1waRQf+jiNMAJNGMJg==
X-CSE-MsgGUID: deVjvGVHSpOXZFrkdZqT4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86594031"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="86594031"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 18:18:47 -0700
X-CSE-ConnectionGUID: Ep1FntngSqmeM4Ec48xFjg==
X-CSE-MsgGUID: 6fWDtsFsRW2jKrc7HwDcxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="265804628"
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
Subject: [PATCH v4 7/7] selftests/x86: Add a userspace test for LASS enforcement
Date: Wed,  5 Aug 2026 18:15:36 -0700
Message-ID: <20260806011536.4172258-8-sohil.mehta@intel.com>
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

With LASS enabled, a user-mode access to a kernel address raises a #GP
instead of the #PF that SMAP/SMEP would produce. Nothing in the x86
selftests specifically tests for a LASS violation. The vsyscall selftest
exercises this flow but doesn't verify the resulting #GP.

Add a test that reads, writes and executes at a canonical kernel address
and verifies each one faults with a #GP and a null error code. For the
instruction fetch, also verify the fault is reported at the target,
since LASS does not check the target of a branch.

Skip the test unless /proc/cpuinfo reports the lass flag. The CPUID bit
alone does not say whether the kernel enabled LASS.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v4:
 - New patch
---
 tools/testing/selftests/x86/Makefile |   3 +-
 tools/testing/selftests/x86/lass.c   | 196 +++++++++++++++++++++++++++
 2 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/lass.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 434065215d12..252d757fc1b2 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -19,7 +19,8 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
-			corrupt_xstate_header amx lam test_shadow_stack avx apx
+			corrupt_xstate_header amx lam test_shadow_stack avx apx \
+			lass
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
diff --git a/tools/testing/selftests/x86/lass.c b/tools/testing/selftests/x86/lass.c
new file mode 100644
index 000000000000..3dd3dc8e41d1
--- /dev/null
+++ b/tools/testing/selftests/x86/lass.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * lass.c - Test Linear Address Space Separation (LASS) enforcement
+ *
+ * With LASS enabled, a user-mode read, write or instruction fetch at a
+ * kernel address raises a #GP instead of the #PF that SMAP/SMEP would
+ * produce.
+ */
+#define _GNU_SOURCE
+
+#include <setjmp.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/ucontext.h>
+
+#include "helpers.h"
+
+#ifndef __x86_64__
+# error This test is 64-bit only
+#endif
+
+/*
+ * LASS rejects an address based on bit 63 alone, but a non-canonical
+ * address raises the very same #GP for a different reason, so the
+ * address has to be canonical to attribute the fault to LASS.
+ *
+ * Bits 63:47 are all set here, which is canonical with 4-level paging
+ * as well as 5-level paging.
+ */
+#define KERNEL_ADDR	0xffff800000000000UL
+
+static sigjmp_buf jmpbuf;
+
+static volatile unsigned long fault_trapno, fault_err, fault_rip;
+
+/* Handle SIGSEGV (#GP and #PF) as well as SIGBUS (#SS) */
+static void fault_handler(int sig, siginfo_t *info, void *ctx_void)
+{
+	ucontext_t *ctx = (ucontext_t *)ctx_void;
+
+	fault_trapno = ctx->uc_mcontext.gregs[REG_TRAPNO];
+	fault_err = ctx->uc_mcontext.gregs[REG_ERR];
+	fault_rip = ctx->uc_mcontext.gregs[REG_RIP];
+	siglongjmp(jmpbuf, 1);
+}
+
+static bool is_lass_active(void)
+{
+	static const char delims[] = " \n";
+	unsigned int eax, ebx, ecx, edx;
+	bool found = false;
+	char line[4096];
+	FILE *cpuinfo;
+
+	/*
+	 * Only the cpuinfo flag reflects whether the kernel actually
+	 * enabled LASS.
+	 */
+	cpuinfo = fopen("/proc/cpuinfo", "r");
+	if (!cpuinfo)
+		ksft_exit_fail_msg("failed to open /proc/cpuinfo\n");
+
+	while (!found && fgets(line, sizeof(line), cpuinfo)) {
+		char *flag;
+
+		if (strncmp(line, "flags", 5))
+			continue;
+
+		/* Match whole words only, not a substring of another flag. */
+		for (flag = strtok(line, delims); flag; flag = strtok(NULL, delims)) {
+			if (!strcmp(flag, "lass")) {
+				found = true;
+				break;
+			}
+		}
+	}
+
+	fclose(cpuinfo);
+
+	if (found)
+		return true;
+
+	/* Check CPUID.(EAX=07H,ECX=1):EAX.LASS[bit 6] */
+	__cpuid_count(0x7, 0x1, eax, ebx, ecx, edx);
+	if (eax & (1 << 6))
+		ksft_print_msg("LASS is supported by the CPU but not enabled by the kernel\n");
+
+	return false;
+}
+
+/* General Protection Fault (trapnr.h is not exported to uapi) */
+#define X86_TRAP_GP	13
+
+/* A LASS violation raises a #GP with a null error code. */
+static bool is_lass_violation(void)
+{
+	return fault_trapno == X86_TRAP_GP && !fault_err;
+}
+
+static void test_kernel_read(void)
+{
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		*(volatile unsigned long *)KERNEL_ADDR;
+		ksft_test_result_fail("the read did not fault\n");
+		return;
+	}
+
+	ksft_test_result(is_lass_violation(),
+			 "the read faulted with trap=%ld, error=0x%lx\n",
+			 fault_trapno, fault_err);
+}
+
+static void test_kernel_write(void)
+{
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		*(volatile unsigned long *)KERNEL_ADDR = 0x1a55;
+		ksft_test_result_fail("the write did not fault\n");
+		return;
+	}
+
+	ksft_test_result(is_lass_violation(),
+			 "the write faulted with trap=%ld, error=0x%lx\n",
+			 fault_trapno, fault_err);
+}
+
+/*
+ * Use inline asm rather than a call through a function pointer: a direct
+ * 'call rel32' cannot reach a kernel address, and letting the compiler lower
+ * the indirect branch risks routing it through a thunk, or eliding it
+ * altogether, either of which would stop testing the fetch.
+ */
+static void do_fetch(unsigned long addr)
+{
+	asm volatile ("call *%[fn]"
+		      : : [fn] "r" (addr)
+		      : "memory", "cc", "rax", "rcx", "rdx", "rsi", "rdi",
+			"r8", "r9", "r10", "r11");
+}
+
+static void test_kernel_fetch(void)
+{
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		do_fetch(KERNEL_ADDR);
+
+		/*
+		 * Execution resumed at an unknown point with an undefined
+		 * register state, so don't try to run the rest of the tests.
+		 */
+		ksft_exit_fail_msg("the fetch returned without faulting\n");
+	}
+
+	/*
+	 * Branch instructions do not check their target against LASS. The
+	 * violation happens when the target address is used to fetch the
+	 * next instruction, so the fault must be reported at the target
+	 * rather than at the branch.
+	 */
+	if (fault_rip != KERNEL_ADDR) {
+		ksft_test_result_fail("the fetch faulted at RIP 0x%lx instead of 0x%lx\n",
+				      fault_rip, (unsigned long)KERNEL_ADDR);
+		return;
+	}
+
+	ksft_test_result(is_lass_violation(),
+			 "the fetch faulted with trap=%ld, error=0x%lx\n",
+			 fault_trapno, fault_err);
+}
+
+#define TOTAL_TESTS 3
+
+int main(void)
+{
+	ksft_print_header();
+
+	if (!is_lass_active())
+		ksft_exit_skip("LASS is not enabled\n");
+
+	ksft_set_plan(TOTAL_TESTS);
+
+	sethandler(SIGSEGV, fault_handler, 0);
+	/* Only to report a #SS; LASS shouldn't cause one here. */
+	sethandler(SIGBUS, fault_handler, 0);
+
+	ksft_print_msg("Accessing the kernel address 0x%lx from userspace\n",
+		       (unsigned long)KERNEL_ADDR);
+	test_kernel_read();
+	test_kernel_write();
+	test_kernel_fetch();
+
+	clearhandler(SIGBUS);
+	clearhandler(SIGSEGV);
+
+	ksft_finished();
+}
-- 
2.43.0

