Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D53310784;
	Fri,  9 Oct 2026 02:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791511362; cv=none; b=At7iIA8RMTCR74R77olUGBrvteIZBlix0FQJRmvPZp0EoQiogpOks6cvBzHqZaPGKC/9qLxl6wYu5Z2vmfId8kD41KxKaHaAwJlD2ufR6oOJ0gRoWZniaonB+O0WBoAgnjX2DyULzmRopA35UJVyAUVyJUzmlArYiIRWfJhiPvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791511362; c=relaxed/simple;
	bh=FVv+j8T7MsBqpP+5li0sWJn/HE62cNEBxVGeO0jT9Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n1FtBZPm48LZk8fkp0/KPBPEdCtILvkqHkj8w0402uFLk7ylhSEFVvhLgt7q2bFii7th94R7sJ5xQwkDkG560s0eogfbsX30QM4pKF8CBZ/gWk+kcj9/8ck5sD7R3RPqK/qUFB5sEWMS/s/O9PVYr6Xzyi/6Q9tJsOKBperuqKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bKDMh9of; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bKDMh9of"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791511360; x=1823047360;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FVv+j8T7MsBqpP+5li0sWJn/HE62cNEBxVGeO0jT9Lo=;
  b=bKDMh9ofeW8a7b2CGYqVSXFxMbaFYjSi7U1Ehl/s8uP7FdmZT1b7cBpd
   V/7zFvNZA7IYo9lxaleqHuC+j0/giwqZ03Uhn2FCR+F/o1ILQpCcWyT7L
   P6YoG6K0i/7s09igp51BZg5LUhWkiCBVfrHuTtVrAvFe0c9u880scCEXz
   dbZ6je4QaeifD/noofwu8a6MXnZTUAQD5Pxc946dIXNdi690yM1U5eKOv
   /mMNLvUUEZzGTDF3g7VDuGxjlDw9HK4HoBjiq/Anv6Mc5nDjCIV0PaJde
   6FOTMj/Z4ycC1/grROqc23H5xzp+w5U69xm2jqVIddEWwLwpgv42FKBoZ
   w==;
X-CSE-ConnectionGUID: yG2bVVhhQDSDU204Bwlf/Q==
X-CSE-MsgGUID: i+Sp1OOCS++HtaERTh/Tjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="199188"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="199188"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 19:02:40 -0700
X-CSE-ConnectionGUID: AIb48RUiSkGoc+ZwRY15fA==
X-CSE-MsgGUID: 7QxMra1bQL+gMREbC55I8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="293200"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa005.fm.intel.com with ESMTP; 08 Oct 2026 19:02:39 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2] selftests/x86: Add a test for LASS enforcement
Date: Thu,  8 Oct 2026 19:00:25 -0700
Message-ID: <20261009020025.4175228-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With LASS enabled, a user-mode access to a kernel address raises a #GP
instead of the #PF that paging alone would produce. Nothing in the x86
selftests specifically tests for a LASS violation. The vsyscall selftest
exercises this flow but doesn't verify the resulting #GP.

Add a test that reads, writes and executes at a kernel address and
verifies each one faults with a #GP and a zero error code. For the
instruction fetch, also verify the fault is reported at the target,
since LASS enforcement only occurs when the branch target is fetched.

LASS rejects an address based on bit 63 alone, but a non-canonical
address raises the very same #GP for a different reason. So, access a
canonical kernel address to attribute the fault specifically to LASS.

Note, the CPUID bit does not reflect whether the kernel enabled LASS;
only the cpuinfo flag does. But parsing cpuinfo is cumbersome, and the
kernel enables LASS whenever the CPU supports it unless the command line
opts out (vsyscall=emulate or clearcpuid=lass). To keep it simple, rely
on the CPUID bit and accept a failure in these unusual cases.

The test was initially generated by an LLM but has been heavily modified
to match upstream expectations.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v2:
 - Simplified using CPUID instead of /proc/cpuinfo for detecting LASS
 - Used jmp for instruction fetch tests instead of a call.
 - Removed the SIGBUS handler since it can never generate a #SS here
   (Binbin)
 - Did not pick up the review and test tags as the code has
   significantly changed.

v1 (Part of LASS KVM v4):
 - https://lore.kernel.org/lkml/20260806011536.4172258-8-sohil.mehta@intel.com/
---
 tools/testing/selftests/x86/Makefile |   3 +-
 tools/testing/selftests/x86/lass.c   | 158 +++++++++++++++++++++++++++
 2 files changed, 160 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/lass.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index d478b13cc8d5..025c187a563d 100644
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
index 000000000000..5f6e326e4f4a
--- /dev/null
+++ b/tools/testing/selftests/x86/lass.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test Linear Address Space Separation (LASS) enforcement
+ *
+ * With LASS enabled, a user-mode read, write or instruction fetch at a kernel
+ * address raises a #GP instead of the #PF that paging alone would produce.
+ */
+#define _GNU_SOURCE
+
+#include <setjmp.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <sys/ucontext.h>
+
+#include "helpers.h"
+
+#ifndef __x86_64__
+# error This test is 64-bit only
+#endif
+
+/*
+ * Canonicality enforcement generates the same #GP as LASS for non-canonical
+ * addresses. So, use a canonical address to specifically attribute the fault
+ * to LASS. Bits 63:47 are all set here, which is canonical with 4-level
+ * paging as well as 5-level paging.
+ */
+#define KERNEL_ADDR	0xffff800000000000UL
+
+static sigjmp_buf jmpbuf;
+
+static volatile unsigned long fault_trapno, fault_err, fault_rip;
+
+/* Handle SIGSEGV (#GP and #PF) */
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
+/* Check CPUID bit corresponding to X86_FEATURE_LASS */
+static bool is_lass_supported(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	__cpuid_count(0x7, 0x1, eax, ebx, ecx, edx);
+	return eax & (1 << 6);
+}
+
+/* A LASS violation raises a #GP with a null error code. */
+static bool is_lass_violation(void)
+{
+	return fault_trapno == 13 && !fault_err;
+}
+
+static void test_kernel_read(void)
+{
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		*(volatile unsigned long *)KERNEL_ADDR;
+		ksft_test_result_fail("The read did not fault\n");
+		return;
+	}
+
+	ksft_test_result(is_lass_violation(),
+			 "The read faulted with trap=%ld, error=0x%lx\n",
+			 fault_trapno, fault_err);
+}
+
+static void test_kernel_write(void)
+{
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		*(volatile unsigned long *)KERNEL_ADDR = 0x1a55;
+		ksft_test_result_fail("The write did not fault\n");
+		return;
+	}
+
+	ksft_test_result(is_lass_violation(),
+			 "The write faulted with trap=%ld, error=0x%lx\n",
+			 fault_trapno, fault_err);
+}
+
+/*
+ * Branch to the kernel address by hand: a direct 'call rel32' cannot reach
+ * that far, and an indirect call through a function pointer is free to be
+ * elided, which would stop testing the fetch.
+ *
+ * A 'jmp' fetches the target without writing the stack and never returns, so
+ * there is no call-clobbered register state to describe.
+ */
+static void do_fetch(unsigned long addr)
+{
+	asm volatile ("jmp *%[fn]" : : [fn] "r" (addr));
+}
+
+static void test_kernel_fetch(void)
+{
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		do_fetch(KERNEL_ADDR);
+
+		/*
+		 * Control does not come back from the jump, so reaching here
+		 * means execution went somewhere unknown. Don't try to run
+		 * the rest of the tests.
+		 */
+		ksft_exit_fail_msg("The fetch did not fault\n");
+	}
+
+	/*
+	 * Branch instructions do not check their target against LASS. The
+	 * violation happens when the target address is used to fetch the next
+	 * instruction, so the fault must be reported at the target rather
+	 * than at the branch.
+	 */
+	if (fault_rip != KERNEL_ADDR) {
+		ksft_test_result_fail("The fetch faulted at RIP 0x%lx instead of 0x%lx\n",
+				      fault_rip, KERNEL_ADDR);
+		return;
+	}
+
+	ksft_test_result(is_lass_violation(),
+			 "The fetch faulted with trap=%ld, error=0x%lx\n",
+			 fault_trapno, fault_err);
+}
+
+#define TOTAL_TESTS 3
+
+int main(void)
+{
+	ksft_print_header();
+
+	/*
+	 * Only the cpuinfo flag truly reflects whether the kernel enabled
+	 * LASS. In practice, the kernel always enables LASS when the CPU
+	 * supports it, so check the CPUID bit instead.
+	 *
+	 * The test is expected to fail if LASS is disabled via the kernel
+	 * command line.
+	 */
+	if (!is_lass_supported())
+		ksft_exit_skip("LASS is not present\n");
+
+	ksft_set_plan(TOTAL_TESTS);
+
+	sethandler(SIGSEGV, fault_handler, 0);
+
+	ksft_print_msg("Accessing the kernel address 0x%lx from userspace\n",
+		       KERNEL_ADDR);
+	test_kernel_read();
+	test_kernel_write();
+	test_kernel_fetch();
+
+	clearhandler(SIGSEGV);
+
+	ksft_finished();
+}
-- 
2.43.0

