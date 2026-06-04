Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CEC4C9572;
	Thu,  4 Jun 2026 20:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605364; cv=none; b=mAg3qlSRb1BT6nvC8QPm9Pw/5JeLQVZiPpqi5NKqp0Uu0pU375YNuAufHgh41R1Jv4rFOzUfBB3to0GMHulnx8IDOz2dkipWMcuW8xuxu01qwTo34fIMNsoIK4634SnDoFv/nUsOS3fiwXfigwaXzI1wl8MPfSoWol/EzZXbUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605364; c=relaxed/simple;
	bh=Y4eDkGK0ehQ12zM1FBuXQANl48HN/yccSnXn6UEKv10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YueDYH7d6vjTcIm7qGawLN09Fxy4IO8N/Bti3i085aST7vYSbS8AcOjOWUNgUU4HMdaZJXo4+1qzI0YCrM6a1DHSw7wW2hBTJzBclQyk0PvVGgr6wY9ECxjy1wPNm8ioGsxN7sGYR8ojxmkCRNWZkq5crXUq+3WKrVrVJ802adE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3TIXWLC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3TIXWLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4241F00893;
	Thu,  4 Jun 2026 20:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780605362;
	bh=X3Y0rZQMz1+PTOXhliSdx0TPFg2QLN/dHqojh29LrrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L3TIXWLCkgs+wiiF9OGD1o7Q9pcR/C+3F5kwkEdRe1ayENZx6hQkZWDfl25WXoiWK
	 //YxxdUBzGQ09QtZ2CzsQPEwPXGvR1C+SiiJ5HKJ4Z+pf9otngSdh7ginEWkw6auT7
	 6C7vsbP8ySvzlecYNhMSBcp/ttMmTe5hV4hu8/KO0SCxoiSd9Xc8zUyF2YOGbiQ+x3
	 1FPQLla+lG3lIYdu5j4dZUkUBHc7xg835iczkdjtwKILgLgEoINQNCJYGUjZIwoPMv
	 TmBEbsrRxvsg5I7ugn3jaoErZj0lm2FfH2aZS5gSCzLqrFkvvSxeqa+vD7o6ZIWT68
	 aAUQMp2rUMTww==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 07/10] KVM: selftests: Add basic stress test for save+restore and #PF handling
Date: Thu,  4 Jun 2026 20:35:43 +0000
Message-ID: <20260604203546.365658-8-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260604203546.365658-1-yosry@kernel.org>
References: <20260604203546.365658-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a basic stress test for handling #PFs in a guest while the host is
doing save+restore cycles. The guest periodically accesses non-present
memory causing a #PF, and the #PF handler walks the page tables and
updates the PTE to be present, like a proper #PF handler.

After every access (and #PF), the guest triggers a sync and the test
performs save+restore of the VM. This is not very meaningful as
save+restore are performed after the access and #PF handling complete,
but following changes will change that.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |  14 ++
 .../kvm/x86/stress_save_restore_pf_test.c     | 182 ++++++++++++++++++
 3 files changed, 197 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index e0ddd3ff9472d..731ef7de1afb4 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -111,6 +111,7 @@ TEST_GEN_PROGS_x86 += x86/set_sregs_test
 TEST_GEN_PROGS_x86 += x86/smaller_maxphyaddr_emulation_test
 TEST_GEN_PROGS_x86 += x86/smm_test
 TEST_GEN_PROGS_x86 += x86/state_test
+TEST_GEN_PROGS_x86 += x86/stress_save_restore_pf_test
 TEST_GEN_PROGS_x86 += x86/vmx_preemption_timer_test
 TEST_GEN_PROGS_x86 += x86/svm_vmcall_test
 TEST_GEN_PROGS_x86 += x86/svm_int_ctl_test
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 57f81f0bcc42d..10d26e079a1a8 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -585,6 +585,15 @@ static inline void set_cr0(u64 val)
 	__asm__ __volatile__("mov %0, %%cr0" : : "r" (val) : "memory");
 }
 
+static inline u64 get_cr2(void)
+{
+	u64 cr2;
+
+	__asm__ __volatile__("mov %%cr2, %[cr2]"
+			     : /* output */ [cr2]"=r"(cr2));
+	return cr2;
+}
+
 static inline u64 get_cr3(void)
 {
 	u64 cr3;
@@ -880,6 +889,11 @@ static inline void write_sse_reg(int reg, const sse128_t *data)
 	}
 }
 
+static inline void invlpg(u64 addr)
+{
+	__asm__ __volatile__("invlpg (%0)" : : "r"(addr) : "memory");
+}
+
 static inline void cpu_relax(void)
 {
 	asm volatile("rep; nop" ::: "memory");
diff --git a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
new file mode 100644
index 0000000000000..622d102179e66
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+#define NR_ITERATIONS		500
+
+#define GOTO_PREV_LINE		"\033[A\r"
+#define PRINT_ITER(s, x)					\
+do {								\
+	if (x == 1)						\
+		printf(s "%d\n", x);                            \
+	else							\
+		printf(GOTO_PREV_LINE s "%d\n", x);		\
+	fflush(stdout);						\
+} while (0)
+
+#define PTRS_PER_PTE		512
+#define PXD_INDEX(vaddr, level)	(((vaddr) >> PG_LEVEL_SHIFT(level)) & (PTRS_PER_PTE - 1))
+
+#define TEST_MEM_BASE_GVA	0xc0000000ULL
+#define TEST_PGTABLE_GVA_OFFSET	0xd0000000ULL
+#define NR_TEST_ADDRS		PTRS_PER_PTE
+#define PATTERN			0xabcdefabcdefabcdULL
+
+static u64 pte_present_mask;
+static u64 pte_huge_mask;
+
+static u64 expected_vaddr;
+static u64 guest_faults;
+
+static u64 *guest_get_pte(u64 vaddr)
+{
+	u64 pgtable_pa, pte;
+	u64 *pgtable;
+	int level;
+	bool la57;
+
+	la57 = !!(get_cr4() & X86_CR4_LA57);
+	level = la57 ? PG_LEVEL_256T : PG_LEVEL_512G;
+
+	pgtable_pa = get_cr3() & PHYSICAL_PAGE_MASK;
+	for (; level > PG_LEVEL_4K; level--) {
+		pgtable = (u64 *)(pgtable_pa + TEST_PGTABLE_GVA_OFFSET);
+		pte = pgtable[PXD_INDEX(vaddr, level)];
+		GUEST_ASSERT(pte & pte_present_mask);
+		GUEST_ASSERT(!(pte & pte_huge_mask));
+		pgtable_pa = PTE_GET_PA(pte);
+	}
+
+	pgtable = (u64 *)(pgtable_pa + TEST_PGTABLE_GVA_OFFSET);
+	return &pgtable[PXD_INDEX(vaddr, PG_LEVEL_4K)];
+}
+
+static void guest_pf_handler(struct ex_regs *regs)
+{
+	u64 fault_addr;
+	u64 *ptep;
+
+	fault_addr = get_cr2();
+	GUEST_ASSERT_EQ(fault_addr, READ_ONCE(expected_vaddr));
+
+	ptep = guest_get_pte(fault_addr);
+	GUEST_ASSERT(ptep);
+	GUEST_ASSERT(!(*ptep & pte_present_mask));
+
+	*ptep |= pte_present_mask;
+	invlpg(fault_addr);
+
+	guest_faults++;
+}
+
+static void guest_access_memory(void *arg)
+{
+	u64 vaddr, val;
+	int i = 0;
+
+	for (;; i++) {
+		vaddr = TEST_MEM_BASE_GVA + (i % NR_TEST_ADDRS) * PAGE_SIZE;
+		WRITE_ONCE(expected_vaddr, vaddr);
+
+		/* Read to trigger #PF */
+		val = READ_ONCE(*(u64 *)vaddr);
+		GUEST_ASSERT_EQ(val, PATTERN);
+
+		/* Clear the present bit again so it faults next time */
+		*guest_get_pte(vaddr) &= ~pte_present_mask;
+		invlpg(vaddr);
+
+		GUEST_SYNC(guest_faults);
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_x86_state *state;
+	int r, i, level, count = 0;
+	gpa_t gpa, pgtable_gpa;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	u64 *pgtable;
+	gva_t gva;
+	u64 pte;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_access_memory);
+	vm_install_exception_handler(vm, PF_VECTOR, guest_pf_handler);
+
+	pte_present_mask = PTE_PRESENT_MASK(&vm->mmu);
+	pte_huge_mask = PTE_HUGE_MASK(&vm->mmu);
+	sync_global_to_guest(vm, pte_present_mask);
+	sync_global_to_guest(vm, pte_huge_mask);
+
+	/* Allocate a page and write the pattern to it */
+	gva = vm_alloc_page(vm);
+	*(u64 *)addr_gva2hva(vm, gva) = PATTERN;
+	gpa = addr_gva2gpa(vm, gva);
+
+	/*
+	 * Map all virtual addresses to the pattern page and clear the present
+	 * bit such that guest accesses will cause a #PF.
+	 */
+	for (i = 0; i < NR_TEST_ADDRS; i++) {
+		gva = TEST_MEM_BASE_GVA + i * getpagesize();
+		virt_pg_map(vm, gva, gpa);
+		*vm_get_pte(vm, gva) &= ~pte_present_mask;
+	}
+
+	/*
+	 * Now create mappings for the page tables created above so that the
+	 * guest #PF handler can walk them. All PTEs for test virtual addresses
+	 * should lie on the same PTE page, so one page is mapped for each page
+	 * table level.
+	 *
+	 * Use an offset for the GVA instead of creating identity mappings to
+	 * avoid collision with existing mappings at low GVAs (e.g. ELF).
+	 */
+	pgtable_gpa = vm->mmu.pgd;
+	for (level = vm->mmu.pgtable_levels; level >= PG_LEVEL_4K; level--) {
+		virt_map(vm, pgtable_gpa + TEST_PGTABLE_GVA_OFFSET, pgtable_gpa, 1);
+		pgtable = addr_gpa2hva(vm, pgtable_gpa);
+		pte = pgtable[PXD_INDEX(TEST_MEM_BASE_GVA, level)];
+		pgtable_gpa = PTE_GET_PA(pte);
+	}
+
+	while (count++ < NR_ITERATIONS) {
+		r = __vcpu_run(vcpu);
+		TEST_ASSERT(!r, "vcpu_run failed");
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		get_ucall(vcpu, &uc);
+		if (uc.cmd == UCALL_ABORT) {
+			REPORT_GUEST_ASSERT(uc);
+			break;
+		}
+		TEST_ASSERT_EQ(uc.cmd, UCALL_SYNC);
+		TEST_ASSERT_EQ(uc.args[1], count - 1);
+
+		state = vcpu_save_state(vcpu);
+
+		kvm_vm_release(vm);
+		vcpu = vm_recreate_with_one_vcpu(vm);
+		vcpu_load_state(vcpu, state);
+		kvm_x86_state_cleanup(state);
+
+		PRINT_ITER("Save+restore iterations: ", count);
+	}
+
+	sync_global_from_guest(vm, guest_faults);
+	pr_info("Guest page faults: %lu\n", guest_faults);
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.54.0.1032.g2f8565e1d1-goog

