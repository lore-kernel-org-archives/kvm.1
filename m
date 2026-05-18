Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C943932F1;
	Mon, 18 May 2026 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135926; cv=none; b=TySyNX2kGfuOtP5N21EtCApTPuO+zWW9kCROvLPr0gCb4IP7oOD0YpPIZgTlcxqSrlHu5Edb5TQQ/VRM+RIw6IVJrelyD4aeMsuP4G+lvEmZK+XlzIjEkfnbSFt5uQ6o6Hc3b3v+f7WDHI/yCTxS9EjkUPJ+gvdi2EFv0oOyvh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135926; c=relaxed/simple;
	bh=HSb47MisDIWaBtAfUVH6Fca2Jw11AUST0u8QouNfSHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJtzt2Fjw8nXJ4BPDcdJ8bjLh3FOPpH+U1D9gI+4T+AiibmtxwM6RpnVBohxqoc2o44Xt8P2aurxGl24OcejPNUBByH+GWHOJKlnYyMYeNg1OBlBxvmJ4IGW5a9VfqYqvPBZOxXHz5ZTmepzJ9lwowIy3hSa3YeStkIfk4/Fn8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkdirD9J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkdirD9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3102C2BCC9;
	Mon, 18 May 2026 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779135925;
	bh=HSb47MisDIWaBtAfUVH6Fca2Jw11AUST0u8QouNfSHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JkdirD9J+vXNvO4QqPJXaTH7aEnM+gmjWN7uLP0hzRt3oGmx23EPVyXzJD2jrZhNW
	 EzlVXq7jL7lMiwgndTHPe02oa/H+sFDQLj9eTgoAFydq95VWgpH2ELdEpMazMm7BG6
	 XCOmFfAZCvrHk1FIYbj5gKwxFHYfuBhhLBwY0kJhgpxZI6/jatdmz6hz6iVbDVwNY3
	 eZhsipc1FVxJR0eeLWWk/X4oB2Kz0Fo5xsjbIR5Ch8zYcyoRLDCZrkpJlDYLFUsJIY
	 sSig/8Fxnqtjq2X0+UhkgnO3yYISiemonjaXQ423zYqIvDfNe2lDU55Xp7MWzpt1os
	 vzAIzyU2/Kntg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosryahmed@google.com>,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 5/8] KVM: selftests: Add basic stress test for save+restore and #PF handling
Date: Mon, 18 May 2026 20:25:11 +0000
Message-ID: <20260518202514.2037078-6-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260518202514.2037078-1-yosry@kernel.org>
References: <20260518202514.2037078-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yosry Ahmed <yosryahmed@google.com>

Add a basic stress test for handling #PFs in a guest while the host is
doing save+restore cycles. The guest periodically accesses non-present
memory causing a #PF, and the #PF handler walks the page tables and
updates the PTE to be present, like a proper #PF handler.

After every access (and #PF), the guest triggers a sync and the test
performs save+restore of the VM. This is not very meaningful as
save+restore are performed after the access and #PF handling complete,
but following changes will change that.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |  15 ++
 .../testing/selftests/kvm/lib/x86/processor.c |  11 ++
 .../kvm/x86/stress_save_restore_pf_test.c     | 171 ++++++++++++++++++
 4 files changed, 198 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 82fa943b95038..9327284dd5bbf 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -110,6 +110,7 @@ TEST_GEN_PROGS_x86 += x86/set_sregs_test
 TEST_GEN_PROGS_x86 += x86/smaller_maxphyaddr_emulation_test
 TEST_GEN_PROGS_x86 += x86/smm_test
 TEST_GEN_PROGS_x86 += x86/state_test
+TEST_GEN_PROGS_x86 += x86/stress_save_restore_pf_test
 TEST_GEN_PROGS_x86 += x86/vmx_preemption_timer_test
 TEST_GEN_PROGS_x86 += x86/svm_vmcall_test
 TEST_GEN_PROGS_x86 += x86/svm_int_ctl_test
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index ca2ec92490f7c..41bffe031eb88 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -610,6 +610,15 @@ static inline void set_cr0(u64 val)
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
@@ -905,6 +914,11 @@ static inline void write_sse_reg(int reg, const sse128_t *data)
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
@@ -1557,6 +1571,7 @@ void __virt_pg_map(struct kvm_vm *vm, struct kvm_mmu *mmu, gva_t gva,
 		   gpa_t gpa,  int level);
 void virt_map_level(struct kvm_vm *vm, gva_t gva, gpa_t gpa,
 		    u64 nr_bytes, int level);
+void virt_map_page_tables(struct kvm_vm *vm);
 
 void vm_enable_tdp(struct kvm_vm *vm);
 bool kvm_cpu_has_tdp(void);
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index caefcd12df8d2..6708fa8b6a304 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -343,6 +343,17 @@ void virt_map_level(struct kvm_vm *vm, gva_t gva, gpa_t gpa,
 	}
 }
 
+void virt_map_page_tables(struct kvm_vm *vm)
+{
+	gpa_t gpa = KVM_GUEST_PAGE_TABLE_MIN_PADDR;
+	struct userspace_mem_region *region;
+	u64 pt_size;
+
+	region = memslot2region(vm, vm->memslots[MEM_REGION_PT]);
+	pt_size = region->region.guest_phys_addr + region->region.memory_size - gpa;
+	virt_map(vm, gpa, gpa, pt_size / getpagesize());
+}
+
 static bool vm_is_target_pte(struct kvm_mmu *mmu, u64 *pte,
 			     int *level, int current_level)
 {
diff --git a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
new file mode 100644
index 0000000000000..12da74b4f725c
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
@@ -0,0 +1,171 @@
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
+#define CURSOR_UP		"\033[A"
+#define PRINT_ITER(s, x)					\
+({								\
+	printf("%s\r%s%d\n", (x ? CURSOR_UP : ""), s, x);	\
+	fflush(stdout);						\
+})
+
+#define TEST_MEM_BASE		0xc0000000ULL
+#define NR_TEST_ADDRS		512
+#define PATTERN			0xabcdefabcdefabcdULL
+
+#define PTRS_PER_PTE		512
+#define PXD_INDEX(vaddr, level)	(((vaddr) >> PG_LEVEL_SHIFT(level)) & (PTRS_PER_PTE - 1))
+
+static u64 pte_present_mask;
+static u64 pte_huge_mask;
+
+static u64 expected_vaddr;
+static u64 guest_accesses;
+
+static u64 *guest_get_pte(u64 vaddr)
+{
+	u64 *pgd, *p4d, *pud, *pmd, *pte;
+	u64 pgde, p4de, pude, pmde;
+	bool la57;
+
+	la57 = !!(get_cr4() & X86_CR4_LA57);
+	pgd = (u64 *)(get_cr3() & PHYSICAL_PAGE_MASK);
+
+	if (la57) {
+		pgde = pgd[PXD_INDEX(vaddr, PG_LEVEL_256T)];
+		GUEST_ASSERT(pgde & pte_present_mask);
+		p4d = (u64 *)PTE_GET_PA(pgde);
+		p4de = p4d[PXD_INDEX(vaddr, PG_LEVEL_512G)];
+	} else {
+		pgde = pgd[PXD_INDEX(vaddr, PG_LEVEL_512G)];
+		p4de = pgde;
+	}
+
+	GUEST_ASSERT(p4de & pte_present_mask);
+	pud = (u64 *)PTE_GET_PA(p4de);
+
+	pude = pud[PXD_INDEX(vaddr, PG_LEVEL_1G)];
+	GUEST_ASSERT(pude & pte_present_mask);
+	GUEST_ASSERT(!(pude & pte_huge_mask));
+	pmd = (u64 *)PTE_GET_PA(pude);
+
+	pmde = pmd[PXD_INDEX(vaddr, PG_LEVEL_2M)];
+	GUEST_ASSERT(pmde & pte_present_mask);
+	GUEST_ASSERT(!(pmde & pte_huge_mask));
+	pte = (u64 *)PTE_GET_PA(pmde);
+
+	return &pte[PXD_INDEX(vaddr, PG_LEVEL_4K)];
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
+}
+
+static void guest_access_memory(void *arg)
+{
+	u64 vaddr, val;
+
+	for (;; guest_accesses++) {
+		vaddr = TEST_MEM_BASE + (guest_accesses % NR_TEST_ADDRS) * PAGE_SIZE;
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
+		GUEST_SYNC(guest_accesses);
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_x86_state *state;
+	struct kvm_vcpu *vcpu;
+	int r, i, count = 0;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	gva_t gva;
+	gpa_t gpa;
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
+		gva = TEST_MEM_BASE + i * getpagesize();
+		virt_pg_map(vm, gva, gpa);
+		*vm_get_pte(vm, gva) &= ~pte_present_mask;
+	}
+
+	/* Map the page tables so that the guest #PF handler can walk them */
+	virt_map_page_tables(vm);
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
+	sync_global_from_guest(vm, guest_accesses);
+	pr_info("Guest page accesses: %lu\n", guest_accesses);
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.54.0.563.g4f69b47b94-goog

