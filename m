Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D55C43786C;
	Tue, 28 Jul 2026 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260564; cv=none; b=m1PWwYnrYirJzfFSaoK3tth/wQH60K8+vGIR5AvBD/D7rlY+rMhoXg26bZT0aQlU3XTZRgkTNhWjsJeiQmFAHTLmc/g65yvl7JId8Dy34iXiAbauMM4MejPEoxeR1oDfIoLcBoHvsJArLcOITCPE8jGdRqhPpAZ7EhS2yMNezY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260564; c=relaxed/simple;
	bh=PfFBi3Qpbh2CSw+xAmhkor3apeJRp8N24eWm3GwDQgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVbGkFylgKArCopUsHaWRx6uIIUuLfTaoGCE7DBgUAsk8Imh4llAeq/y+s4XlgAzALY3tP9Tgzng5fuu0Aczc6dCJHN1H0vOQYXWI+KWIvYvNk9OEUJiaTgS8enJLhp2z2t/3ll0/+BP1UgKcjlZ4ennWJ99Fp7lPVMMo9nYucQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJnhVFbw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJnhVFbw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548311F00A3A;
	Tue, 28 Jul 2026 17:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260562;
	bh=6kG8M481V3FsqntH69pFwOIdzvJMP1Xm41S7ZargjTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XJnhVFbwJUC2yL9W/9+HycW53lW5GP2FGReuvBX9AQ7B/tFiERyJKgqWbicxbkT2D
	 TcQA3y84v80VxxaG2YTzyXTw5o/JAUMW9TLR9qBSLDHY3mG0xRUTeB4Tvphmkx8zgd
	 qZCh9yaDqD3TxpYMRsiI3rFHsbTuctfxElrcWd8Unw70qHikTuDnhzx7ZsxwRnfYWo
	 8D6LUsGz4Or6clBrsioU1BzaE1DkoM7nGqMH+uGAPxH7K9w4aYHVclJmaUze1zWUVM
	 /jy48upQ+uhE4AaCs7oBdd4sGt0lHyGRQ4a4yyFr+wtP4BRQyZDtYTWTRw71JTj3VC
	 fbSvXVq91o2Vw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v5 10/13] KVM: selftests: Add basic stress test for save+restore and #PF handling
Date: Tue, 28 Jul 2026 17:42:29 +0000
Message-ID: <20260728174232.2423257-11-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
In-Reply-To: <20260728174232.2423257-1-yosry@kernel.org>
References: <20260728174232.2423257-1-yosry@kernel.org>
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
 .../selftests/kvm/include/x86/processor.h     |  13 ++
 .../kvm/x86/save_restore_pf_stress_test.c     | 160 ++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 88c6c8046ddec..d94f56c630fd5 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -107,6 +107,7 @@ TEST_GEN_PROGS_x86 += x86/pmu_counters_test
 TEST_GEN_PROGS_x86 += x86/pmu_event_filter_test
 TEST_GEN_PROGS_x86 += x86/private_mem_conversions_test
 TEST_GEN_PROGS_x86 += x86/private_mem_kvm_exits_test
+TEST_GEN_PROGS_x86 += x86/save_restore_pf_stress_test
 TEST_GEN_PROGS_x86 += x86/set_boot_cpu_id
 TEST_GEN_PROGS_x86 += x86/set_sregs_test
 TEST_GEN_PROGS_x86 += x86/smaller_maxphyaddr_emulation_test
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 06d9ba1c4df33..5979d70f49147 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -614,6 +614,14 @@ static inline void set_cr0(u64 val)
 	__asm__ __volatile__("mov %0, %%cr0" : : "r" (val) : "memory");
 }
 
+static inline u64 get_cr2(void)
+{
+	u64 cr2;
+
+	__asm__ __volatile__("mov %%cr2, %[cr2]" : [cr2]"=r"(cr2));
+	return cr2;
+}
+
 static inline u64 get_cr3(void)
 {
 	u64 cr3;
@@ -909,6 +917,11 @@ static inline void write_sse_reg(int reg, const sse128_t *data)
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
2.55.0.487.gaf234c4eb3-goog

