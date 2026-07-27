Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9E53FBEAB;
	Mon, 27 Jul 2026 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196370; cv=none; b=FYXFC+wdlYqTFhyJmQj6zeogp8If6tnF0xDYYJ3pnBlzq/8dTvFE2o3OvZT8uymbeCP82OovFu2kPr4brfzNjcz0lWKiLsnzHMP+IT6d5MpdHVDHrIgD4mrwdFVAQyxaDlWRyVmnf/Cqco412tpRkuRo6nb0PPqaQemylWGMrNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196370; c=relaxed/simple;
	bh=EIBMHyn6M4/vzNBTM6o8h+MDNZWTdlMUJx2yMK+LT/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJN6xcnODaMX6aqydOQSDbP2zmc9AdxYZg/Kh2tI4oKS2ELz0EWjxgENoDD3esQQ2OKjJUEDYLYbyXmdOqssUIv4K1vk53lipB5Zt9OkKBwtQulad3nLj+Pu+7StOTfoOEiU2zoIyyfzccp8QCv2Z9T27e3dzq6QTivEkys+l9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CauuuND+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CauuuND+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E30F1F00A3F;
	Mon, 27 Jul 2026 23:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196368;
	bh=ojkXJiOm4R+dxtJ7L6MmxunxPv4Ep8EuxHV11iWZNXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CauuuND+cLc8hab9qNHpAWmNpq1sBT4oqPn5qrFrpUsfe1RisyB1eL/Q2hor0oe0Z
	 7C3vG2J1iupMk/6C8nZqRYkAvPrp3HHcCd66aD8exW7xGTK+wNUZIghZOzkvnlN8kr
	 QWiuGdlECl2Ja7x899dUYVGJh6a2UdQW0C9yVTI/Jh+kymId405/lX70OgHQ1mgKfI
	 qts1YgknNdg4wrL/TFhZOkdNLvdrWAsc7i//GEUBBLe2EfHB0L6VM6dwa5vs0aedVc
	 TEq5L8ocLRPBNQlWHSkKAERaB5M82MAlMHY7UUZSKJW56XmQT1sRfd2tyTIAn6gzj2
	 y2zf0A88Pw0Zg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 09/12] KVM: selftests: Add basic stress test for save+restore and #PF handling
Date: Mon, 27 Jul 2026 23:52:25 +0000
Message-ID: <20260727235228.1007324-10-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260727235228.1007324-1-yosry@kernel.org>
References: <20260727235228.1007324-1-yosry@kernel.org>
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
 .../kvm/x86/save_restore_pf_stress_test.c     | 160 ++++++++++++++++++
 3 files changed, 175 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 88c6c8046ddec..e67b1e9893f68 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -112,6 +112,7 @@ TEST_GEN_PROGS_x86 += x86/set_sregs_test
 TEST_GEN_PROGS_x86 += x86/smaller_maxphyaddr_emulation_test
 TEST_GEN_PROGS_x86 += x86/smm_test
 TEST_GEN_PROGS_x86 += x86/state_test
+TEST_GEN_PROGS_x86 += x86/save_restore_pf_stress_test
 TEST_GEN_PROGS_x86 += x86/vmx_preemption_timer_test
 TEST_GEN_PROGS_x86 += x86/svm_vmcall_test
 TEST_GEN_PROGS_x86 += x86/svm_int_ctl_test
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 06d9ba1c4df33..2889782b0016b 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -614,6 +614,15 @@ static inline void set_cr0(u64 val)
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
@@ -909,6 +918,11 @@ static inline void write_sse_reg(int reg, const sse128_t *data)
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
diff --git a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
new file mode 100644
index 0000000000000..1f7e142e5cfec
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
@@ -0,0 +1,160 @@
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
+#define PTRS_PER_PTE		512
+#define PXD_INDEX(vaddr, level)	(((vaddr) >> PG_LEVEL_SHIFT(level)) & (PTRS_PER_PTE - 1))
+
+#define TEST_MEM_BASE_GVA	0xc0000000ULL
+#define TEST_PGTABLE_GVA_OFFSET	0xd0000000ULL
+#define PATTERN			0xabcdefabcdefabcdULL
+
+static u64 expected_vaddr;
+static u64 guest_faults;
+
+static u64 *guest_get_pte(u64 vaddr)
+{
+	u64 pgtable_pa, pte;
+	u64 *pgtable;
+	int level;
+
+	level = (get_cr4() & X86_CR4_LA57) ? PG_LEVEL_256T : PG_LEVEL_512G;
+
+	pgtable_pa = get_cr3() & PHYSICAL_PAGE_MASK;
+	for (; level > PG_LEVEL_4K; level--) {
+		pgtable = (u64 *)(pgtable_pa + TEST_PGTABLE_GVA_OFFSET);
+		pte = pgtable[PXD_INDEX(vaddr, level)];
+		GUEST_ASSERT(pte & PTE_PRESENT_MASK(&guest_mmu));
+		GUEST_ASSERT(!(pte & PTE_HUGE_MASK(&guest_mmu)));
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
+	GUEST_ASSERT(!(*ptep & PTE_PRESENT_MASK(&guest_mmu)));
+
+	*ptep |= PTE_PRESENT_MASK(&guest_mmu);
+	guest_faults++;
+}
+
+static void guest_access_memory(void *arg)
+{
+	u64 vaddr, val;
+	int i;
+
+	for (i = 0; ; i++) {
+		vaddr = TEST_MEM_BASE_GVA + (i % PTRS_PER_PTE) * PAGE_SIZE;
+		WRITE_ONCE(expected_vaddr, vaddr);
+
+		/* Read to trigger #PF */
+		val = READ_ONCE(*(u64 *)vaddr);
+		GUEST_ASSERT_EQ(val, PATTERN);
+
+		/* Clear the present bit again so it faults next time */
+		*guest_get_pte(vaddr) &= ~PTE_PRESENT_MASK(&guest_mmu);
+		invlpg(vaddr);
+
+		GUEST_SYNC(guest_faults);
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_x86_state *state;
+	int r, i, level;
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
+	/* Allocate a page and write the pattern to it */
+	gva = vm_alloc_page(vm);
+	*(u64 *)addr_gva2hva(vm, gva) = PATTERN;
+	gpa = addr_gva2gpa(vm, gva);
+
+	/*
+	 * Map all virtual addresses to the pattern page and clear the present
+	 * bit such that guest accesses will cause a #PF.
+	 */
+	for (i = 0; i < PTRS_PER_PTE; i++) {
+		gva = TEST_MEM_BASE_GVA + i * getpagesize();
+		virt_pg_map(vm, gva, gpa);
+		*vm_get_pte(vm, gva) &= ~PTE_PRESENT_MASK(&vm->mmu);
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
+	for (i = 1; i <= NR_ITERATIONS; i++) {
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
+		TEST_ASSERT_EQ(uc.args[1], i);
+
+		state = vcpu_save_state(vcpu);
+
+		kvm_vm_release(vm);
+		vcpu = vm_recreate_with_one_vcpu(vm);
+		vcpu_load_state(vcpu, state);
+		kvm_x86_state_cleanup(state);
+
+		pr_info("\rSave+restore iterations: %d", i);
+	}
+	pr_info("\n");
+
+	sync_global_from_guest(vm, guest_faults);
+	pr_info("Guest page faults: %lu\n", guest_faults);
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.55.0.229.g6434b31f56-goog

