Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619733;
	b=DMBxsD9l3d0hHMrNmT4kEwrmRaoUJKVv/oeDTxB8mLJB20xWz2d6jdO/pxG4+vYjGKct
	 wYZcSLHQWC2OBNDs8CuuhB8SN9/vMoTLYijKc+olgD7v5ZnVeH+RZDyhl/C8NSjoP51os
	 cOVAwCqiOEYKheHPb3Op1ZAgvuiO2R8OwuKsOG8aIq1MieFGBfXdYEi4f82Za6J4bmxAu
	 dfhbARWTsmG6IaDNu3vmOAYaqcshSK/uCDPvdDPGUmIn0SYgSlMYWGZirlXUo/6Obq+jB
	 mfPyVDKC0R09lB0T4Ev6xEergpmK78FjglYtF5hbR4JY4qXCJVcwsUtU6ZjQC9q7DDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619733;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=d+Y6u7PEJRFqOIWKsdKXhTwqPG37On6ycpJokSLmKTg=;
	b=qJmAY2XrkLPALPylt++WnUoKyL+lvG6iv/GepZA6PT1et3pT4fjE8qld1v0I3WE73Bf7
	 1TbZM1iuOMH/HS/a/ZGreVn6AD+V7aqkgQdjtDX8BAiwU3+o9bNYokrtBlEkitqOPtpG4
	 HBOOnj5ZeWAMyFnhDp29kMHxRx5iByKv0BuJ/TimiBk7GsVMn941zhYtF79GrhhSJc4K9
	 //C2rj+2N1DtQ8biPny3ohcVMc4xBYUtsC/5Pn4yz+mkgto5oPzr3WR/ziWCwDLQL4M9r
	 AE55GUw1CO+rHO2kE8EDhHsd8IXNXKNXySb1QNtv9KAj09tp+LMuvTIaqKgmX9v7JhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A8760A2633;
	Mon,  2 Nov 2026 11:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67A8760A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.fritz.box (p200300f6af404a0027ad06761c59e6b3.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:27ad:676:1c59:e6b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 373A3243AE0;
	Mon,  2 Nov 2026 12:42:05 +0100 (CET)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Michael Roth <michael.roth@amd.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Ninad Naik <ninadnaik07@gmail.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	coconut-svsm@lists.linux.dev,
	joro@8bytes.org
Subject: [PATCH v3 8/8] KVM: selftests: Test SNP vCPU state and direct VMSA launch
Date: Mon,  2 Nov 2026 12:41:37 +0100
Message-ID: <20261102114137.1198982-9-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102114137.1198982-1-joro@8bytes.org>
References: <20261102114137.1198982-1-joro@8bytes.org>
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

From: Joerg Roedel <joerg.roedel@amd.com>

Add vCPU-scoped SEV ioctl helpers and exercise the SNP vCPU state get and
set commands.  Enable KVM_CAP_SNP_DIRECT_VMSA before creating vCPUs and
verify that invalid capability arguments and late enable attempts fail.

Boot through a handcrafted BSP VMSA, verify VMSA and GHCB address round
trips and validity bits, rebind to the selected GPA, and verify an extra
unassociated AP remains uninitialized.

Reject multi-page launch updates and VMSAs with nonzero VMPL or mismatched
SEV features.  Also verify the legacy launch path and reject non-SNP use,
bad or reserved arguments, unsafe alignment, absent pages, wrong ordering,
and post-launch SET calls.  Verify that SET accepts both shared and private
guestmemfd-backed VMSA GPAs without consulting memory attributes or the
RMP.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/include/x86/sev.h |  49 ++
 .../kvm/x86/sev_snp_direct_vmsa_test.c        | 421 ++++++++++++++++++
 3 files changed, 471 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/sev_snp_direct_vmsa_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9f2b15250a2a..1131fb0f630d 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -155,6 +155,7 @@ TEST_GEN_PROGS_x86 += x86/sev_dbg_test
 TEST_GEN_PROGS_x86 += x86/sev_init2_tests
 TEST_GEN_PROGS_x86 += x86/sev_migrate_tests
 TEST_GEN_PROGS_x86 += x86/sev_snp_apic_id_test
+TEST_GEN_PROGS_x86 += x86/sev_snp_direct_vmsa_test
 TEST_GEN_PROGS_x86 += x86/sev_smoke_test
 TEST_GEN_PROGS_x86 += x86/amx_test
 TEST_GEN_PROGS_x86 += x86/max_vcpuid_cap_test
diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index dec383e59a47..0f6c92b802ee 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -100,6 +100,30 @@ static inline u64 snp_default_policy(void)
 	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd,	ret, vm);		\
 })
 
+static inline int __vcpu_sev_ioctl(struct kvm_vcpu *vcpu, u32 cmd, void *arg)
+{
+	union {
+		struct kvm_sev_cmd c;
+		unsigned long raw;
+	} sev_cmd = { .c = {
+		.id = cmd,
+		.data = (u64)arg,
+		.sev_fd = vcpu->vm->arch.sev_fd,
+	} };
+	int ret;
+
+	ret = __vcpu_ioctl(vcpu, KVM_MEMORY_ENCRYPT_OP, &sev_cmd.raw);
+	return ret ?: sev_cmd.c.error;
+}
+
+#define vcpu_sev_ioctl(vcpu, cmd, arg)				\
+({								\
+	struct kvm_vcpu *__vcpu = (vcpu);				\
+	int ret = __vcpu_sev_ioctl(__vcpu, cmd, arg);		\
+								\
+	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd, ret, __vcpu->vm);	\
+})
+
 void sev_vm_init(struct kvm_vm *vm);
 void sev_es_vm_init(struct kvm_vm *vm);
 void snp_vm_init(struct kvm_vm *vm);
@@ -144,6 +168,31 @@ static inline void snp_launch_update_data(struct kvm_vm *vm, gpa_t gpa,
 	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
 }
 
+static inline void snp_launch_update_vmsa(struct kvm_vm *vm, gpa_t gpa,
+					  void *vmsa)
+{
+	vm_mem_set_private(vm, gpa, PAGE_SIZE);
+	snp_launch_update_data(vm, gpa, (u64)vmsa, PAGE_SIZE,
+			       KVM_SEV_SNP_PAGE_TYPE_VMSA);
+}
+
+static inline void snp_get_vcpu_state(struct kvm_vcpu *vcpu,
+				      struct kvm_sev_snp_vcpu_state *state)
+{
+	vcpu_sev_ioctl(vcpu, KVM_SEV_SNP_GET_VCPU_STATE, state);
+}
+
+static inline void snp_set_vcpu_state(struct kvm_vcpu *vcpu, gpa_t vmsa_gpa)
+{
+	struct kvm_sev_snp_vcpu_state state = {
+		.vmsa_gpa = vmsa_gpa,
+		.valid_fields = KVM_SEV_SNP_VCPU_STATE_VMSA_VALID |
+				KVM_SEV_SNP_VCPU_STATE_GHCB_VALID,
+	};
+
+	vcpu_sev_ioctl(vcpu, KVM_SEV_SNP_SET_VCPU_STATE, &state);
+}
+
 static inline void sev_dbg_crypt_memory(struct kvm_vm *vm, unsigned int cmd,
 					void *dst, void *src, unsigned int len)
 {
diff --git a/tools/testing/selftests/kvm/x86/sev_snp_direct_vmsa_test.c b/tools/testing/selftests/kvm/x86/sev_snp_direct_vmsa_test.c
new file mode 100644
index 000000000000..63b01d563dc0
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/sev_snp_direct_vmsa_test.c
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <errno.h>
+#include <stdlib.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "sev.h"
+#include "svm_util.h"
+
+#define DIRECT_MARKER	0x444952454354564dULL
+#define LEGACY_MARKER	0x4c4547414359564dULL
+#define SNP_ACTIVE_SEV_FEATURE	BIT_ULL(0)
+#define VMSA_PMD_SIZE	BIT_ULL(21)
+#define VMSA_MIN_GPA	(VMSA_PMD_SIZE + PAGE_SIZE)
+
+struct test_vmsa {
+	struct vmcb_seg es, cs, ss, ds, fs, gs;
+	struct vmcb_seg gdtr, ldtr, idtr, tr;
+	u64 pl0_ssp, pl1_ssp, pl2_ssp, pl3_ssp;
+	u64 u_cet;
+	u8 reserved_0xc8[2];
+	u8 vmpl;
+	u8 cpl;
+	u8 reserved_0xcc[4];
+	u64 efer;
+	u8 reserved_0xd8[104];
+	u64 xss;
+	u64 cr4, cr3, cr0, dr7, dr6, rflags, rip;
+	u64 dr0, dr1, dr2, dr3;
+	u64 dr0_addr_mask, dr1_addr_mask, dr2_addr_mask, dr3_addr_mask;
+	u8 reserved_0x1c0[24];
+	u64 rsp, s_cet, ssp, isst_addr, rax;
+	u64 star, lstar, cstar, sfmask, kernel_gs_base;
+	u64 sysenter_cs, sysenter_esp, sysenter_eip, cr2;
+	u8 reserved_0x248[32];
+	u64 g_pat, dbgctl, br_from, br_to, last_excp_from, last_excp_to;
+	u8 reserved_0x298[80];
+	u32 pkru, tsc_aux;
+	u64 tsc_scale, tsc_offset;
+	u8 reserved_0x300[8];
+	u64 rcx, rdx, rbx, reserved_0x320, rbp, rsi, rdi;
+	u64 r8, r9, r10, r11, r12, r13, r14, r15;
+	u8 reserved_0x380[16];
+	u64 guest_exit_info_1, guest_exit_info_2, guest_exit_int_info, guest_nrip;
+	u64 sev_features, vintr_ctrl, guest_exit_code, virtual_tom, tlb_id, pcpu_id;
+	u64 event_inj, xcr0;
+	u8 reserved_0x3f0[16];
+	u64 x87_dp;
+	u32 mxcsr;
+	u16 x87_ftw, x87_fsw, x87_fcw, x87_fop, x87_ds, x87_cs;
+	u64 x87_rip;
+	u8 fpreg_x87[80];
+	u8 fpreg_xmm[256];
+	u8 fpreg_ymm[256];
+} __packed;
+
+static_assert(offsetof(struct test_vmsa, vmpl) == 0xca);
+static_assert(offsetof(struct test_vmsa, rip) == 0x178);
+static_assert(offsetof(struct test_vmsa, sev_features) == 0x3b0);
+static_assert(offsetof(struct test_vmsa, xcr0) == 0x3e8);
+
+static void guest_direct_entry(u64 *marker)
+{
+	*marker = DIRECT_MARKER;
+	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
+	vmgexit();
+}
+
+static void guest_legacy_entry(u64 *marker)
+{
+	*marker = LEGACY_MARKER;
+	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
+	vmgexit();
+}
+
+static void copy_segment(struct vmcb_seg *dst, const struct kvm_segment *src)
+{
+	dst->selector = src->selector;
+	dst->base = src->base;
+	dst->limit = src->limit;
+	dst->attrib = src->type |
+		(src->s << SVM_SELECTOR_S_SHIFT) |
+		(src->dpl << SVM_SELECTOR_DPL_SHIFT) |
+		((src->present && !src->unusable) << SVM_SELECTOR_P_SHIFT) |
+		(src->avl << SVM_SELECTOR_AVL_SHIFT) |
+		(src->l << SVM_SELECTOR_L_SHIFT) |
+		(src->db << SVM_SELECTOR_DB_SHIFT) |
+		(src->g << SVM_SELECTOR_G_SHIFT);
+}
+
+static void copy_dtable(struct vmcb_seg *dst, const struct kvm_dtable *src)
+{
+	dst->base = src->base;
+	dst->limit = src->limit;
+}
+
+static void prepare_vmsa(struct kvm_vcpu *vcpu, struct test_vmsa *vmsa,
+			 void *entry)
+{
+	struct kvm_sregs sregs;
+	struct kvm_regs regs;
+
+	memset(vmsa, 0, PAGE_SIZE);
+	vcpu_sregs_get(vcpu, &sregs);
+	vcpu_regs_get(vcpu, &regs);
+
+	copy_segment(&vmsa->es, &sregs.es);
+	copy_segment(&vmsa->cs, &sregs.cs);
+	copy_segment(&vmsa->ss, &sregs.ss);
+	copy_segment(&vmsa->ds, &sregs.ds);
+	copy_segment(&vmsa->fs, &sregs.fs);
+	copy_segment(&vmsa->gs, &sregs.gs);
+	copy_dtable(&vmsa->gdtr, &sregs.gdt);
+	copy_segment(&vmsa->ldtr, &sregs.ldt);
+	copy_dtable(&vmsa->idtr, &sregs.idt);
+	copy_segment(&vmsa->tr, &sregs.tr);
+
+	vmsa->cpl = sregs.cs.dpl;
+	/*
+	 * KVM_GET_SREGS exposes the guest-visible EFER and therefore omits
+	 * SVME, which KVM normally adds to the hardware VMSA itself.
+	 */
+	vmsa->efer = sregs.efer | EFER_SVME;
+	vmsa->cr4 = sregs.cr4;
+	vmsa->cr3 = sregs.cr3;
+	vmsa->cr0 = sregs.cr0;
+	vmsa->dr7 = 0x400;
+	vmsa->dr6 = 0xffff0ff0;
+	vmsa->rflags = regs.rflags;
+	vmsa->rip = (u64)entry;
+	vmsa->rsp = regs.rsp;
+	vmsa->rax = regs.rax;
+	vmsa->rcx = regs.rcx;
+	vmsa->rdx = regs.rdx;
+	vmsa->rbx = regs.rbx;
+	vmsa->rbp = regs.rbp;
+	vmsa->rsi = regs.rsi;
+	vmsa->rdi = regs.rdi;
+	vmsa->r8 = regs.r8;
+	vmsa->r9 = regs.r9;
+	vmsa->r10 = regs.r10;
+	vmsa->r11 = regs.r11;
+	vmsa->r12 = regs.r12;
+	vmsa->r13 = regs.r13;
+	vmsa->r14 = regs.r14;
+	vmsa->r15 = regs.r15;
+	vmsa->g_pat = 0x0007040600070406ULL;
+	vmsa->sev_features = SNP_ACTIVE_SEV_FEATURE;
+	vmsa->xcr0 = 1;
+	vmsa->mxcsr = 0x1f80;
+	vmsa->x87_fcw = 0x37f;
+}
+
+static void expect_launch_update_vmsa_error(struct kvm_vm *vm, gpa_t gpa,
+					    void *vmsa, u64 size)
+{
+	struct kvm_sev_snp_launch_update update = {
+		.gfn_start = gpa >> PAGE_SHIFT,
+		.uaddr = (u64)vmsa,
+		.len = size,
+		.type = KVM_SEV_SNP_PAGE_TYPE_VMSA,
+	};
+
+	errno = 0;
+	TEST_ASSERT_EQ(__vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update), -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+}
+
+static void exclude_from_normal_launch(struct kvm_vm *vm, gpa_t gpa,
+				       unsigned int npages)
+{
+	struct userspace_mem_region *region;
+
+	region = memslot2region(vm, vm->memslots[MEM_REGION_TEST_DATA]);
+	sparsebit_clear_num(region->protected_phy_pages, gpa >> PAGE_SHIFT, npages);
+}
+
+static void assert_vcpu_terminated(struct kvm_vcpu *vcpu)
+{
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
+	TEST_ASSERT_EQ(vcpu->run->system_event.type, KVM_SYSTEM_EVENT_SEV_TERM);
+}
+
+static struct kvm_vm *create_direct_vmsa_vm(unsigned int nr_vcpus,
+					    void *guest_code,
+					    struct kvm_vcpu **vcpus)
+{
+	struct vm_shape shape = {
+		.mode = VM_MODE_DEFAULT,
+		.type = KVM_X86_SNP_VM,
+	};
+	struct kvm_vm *vm;
+	unsigned int i;
+
+	vm = __vm_create(shape, nr_vcpus, 0);
+	vm_enable_cap(vm, KVM_CAP_SNP_DIRECT_VMSA, 0);
+	for (i = 0; i < nr_vcpus; i++)
+		vcpus[i] = vm_vcpu_add(vm, i, guest_code);
+	kvm_arch_vm_finalize_vcpus(vm);
+
+	return vm;
+}
+
+static void test_direct_vmsa(void)
+{
+	struct test_vmsa *vmsas, *selected_vmsa;
+	struct kvm_sev_snp_vcpu_state state = {};
+	struct kvm_mp_state mp_state = {
+		.mp_state = KVM_MP_STATE_UNINITIALIZED,
+	};
+	struct kvm_vcpu *vcpus[2];
+	struct kvm_vcpu *vcpu, *ap;
+	struct kvm_vm *vm;
+	gva_t marker_gva;
+	gpa_t vmsa_gpa;
+	u64 *marker;
+
+	vm = create_direct_vmsa_vm(ARRAY_SIZE(vcpus), guest_legacy_entry, vcpus);
+	vcpu = vcpus[0];
+	ap = vcpus[1];
+	/* Restore normal AP state after vm_vcpu_add() makes it runnable. */
+	vcpu_mp_state_set(ap, &mp_state);
+	marker_gva = vm_alloc_shared(vm, PAGE_SIZE, KVM_UTIL_MIN_VADDR,
+				     MEM_REGION_TEST_DATA);
+	marker = addr_gva2hva(vm, marker_gva);
+	vcpu_args_set(vcpu, 1, marker_gva);
+
+	vmsa_gpa = ____vm_phy_pages_alloc(vm, 2, VMSA_MIN_GPA,
+					vm->memslots[MEM_REGION_TEST_DATA], true, false);
+	TEST_ASSERT(vmsa_gpa & (VMSA_PMD_SIZE - 1), "unsafe VMSA GPA");
+	vmsas = aligned_alloc(PAGE_SIZE, 2 * PAGE_SIZE);
+	TEST_ASSERT(vmsas, "Failed to allocate VMSA source pages");
+	selected_vmsa = (void *)vmsas + PAGE_SIZE;
+	prepare_vmsa(vcpu, &vmsas[0], guest_legacy_entry);
+	prepare_vmsa(vcpu, selected_vmsa, guest_direct_entry);
+
+	snp_vm_launch_start(vm, snp_default_policy());
+	vm_mem_set_private(vm, vmsa_gpa, 2 * PAGE_SIZE);
+	expect_launch_update_vmsa_error(vm, vmsa_gpa, vmsas, 2 * PAGE_SIZE);
+
+	vmsas[0].vmpl = 1;
+	expect_launch_update_vmsa_error(vm, vmsa_gpa, vmsas, PAGE_SIZE);
+	vmsas[0].vmpl = 0;
+	vmsas[0].sev_features = 0;
+	expect_launch_update_vmsa_error(vm, vmsa_gpa, vmsas, PAGE_SIZE);
+	vmsas[0].sev_features = SNP_ACTIVE_SEV_FEATURE;
+
+	snp_launch_update_vmsa(vm, vmsa_gpa, vmsas);
+	snp_launch_update_vmsa(vm, vmsa_gpa + PAGE_SIZE, selected_vmsa);
+	exclude_from_normal_launch(vm, vmsa_gpa, 2);
+	snp_vm_launch_update(vm);
+
+	/* Rebinding is allowed; the second, selected VMSA must win. */
+	snp_set_vcpu_state(vcpu, vmsa_gpa);
+	snp_set_vcpu_state(vcpu, vmsa_gpa + PAGE_SIZE);
+	snp_get_vcpu_state(vcpu, &state);
+	TEST_ASSERT_EQ(state.valid_fields,
+		       KVM_SEV_SNP_VCPU_STATE_VMSA_VALID |
+		       KVM_SEV_SNP_VCPU_STATE_GHCB_VALID);
+	TEST_ASSERT_EQ(state.vmsa_gpa, vmsa_gpa + PAGE_SIZE);
+	TEST_ASSERT_EQ(state.ghcb_gpa, 0);
+	snp_vm_launch_finish(vm);
+
+	vcpu_mp_state_get(ap, &mp_state);
+	TEST_ASSERT_EQ(mp_state.mp_state, KVM_MP_STATE_UNINITIALIZED);
+	*marker = 0;
+	assert_vcpu_terminated(vcpu);
+	TEST_ASSERT_EQ(*marker, DIRECT_MARKER);
+
+	state = (struct kvm_sev_snp_vcpu_state) {
+		.vmsa_gpa = vmsa_gpa,
+		.valid_fields = KVM_SEV_SNP_VCPU_STATE_VMSA_VALID,
+	};
+	errno = 0;
+	TEST_ASSERT_EQ(__vcpu_sev_ioctl(vcpu, KVM_SEV_SNP_SET_VCPU_STATE,
+					&state), -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	free(vmsas);
+	kvm_vm_free(vm);
+}
+
+static void expect_set_vcpu_state_error(struct kvm_vcpu *vcpu,
+					struct kvm_sev_snp_vcpu_state *state,
+					int expected_errno)
+{
+	errno = 0;
+	TEST_ASSERT_EQ(__vcpu_sev_ioctl(vcpu, KVM_SEV_SNP_SET_VCPU_STATE, state), -1);
+	TEST_ASSERT_EQ(errno, expected_errno);
+}
+
+static void test_invalid_requests(void)
+{
+	struct kvm_sev_snp_vcpu_state state = {
+		.valid_fields = KVM_SEV_SNP_VCPU_STATE_VMSA_VALID,
+	};
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	gva_t shared_gva;
+	gpa_t private_gpa;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_legacy_entry);
+	expect_set_vcpu_state_error(vcpu, &state, ENOTTY);
+	kvm_vm_free(vm);
+
+	vm = vm_sev_create_with_one_vcpu(KVM_X86_SNP_VM, guest_legacy_entry, &vcpu);
+	expect_set_vcpu_state_error(vcpu, &state, EINVAL);
+	TEST_ASSERT_EQ(__vm_enable_cap(vm, KVM_CAP_SNP_DIRECT_VMSA, 0), -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+	snp_vm_launch_start(vm, snp_default_policy());
+	expect_set_vcpu_state_error(vcpu, &state, EINVAL);
+	kvm_vm_free(vm);
+
+	vm = create_direct_vmsa_vm(1, guest_legacy_entry, &vcpu);
+	expect_set_vcpu_state_error(vcpu, &state, EINVAL);
+	snp_vm_launch_start(vm, snp_default_policy());
+
+	state.pad[4] = 1;
+	expect_set_vcpu_state_error(vcpu, &state, EINVAL);
+	state.pad[4] = 0;
+	state.valid_fields |= BIT_ULL(2);
+	expect_set_vcpu_state_error(vcpu, &state, EINVAL);
+	state.valid_fields &= ~BIT_ULL(2);
+	state.vmsa_gpa = PAGE_SIZE + 1;
+	expect_set_vcpu_state_error(vcpu, &state, EINVAL);
+	state.vmsa_gpa = VMSA_PMD_SIZE;
+	expect_set_vcpu_state_error(vcpu, &state, EINVAL);
+	state.vmsa_gpa = BIT_ULL(40) + PAGE_SIZE;
+	expect_set_vcpu_state_error(vcpu, &state, EINVAL);
+
+	shared_gva = vm_alloc_shared(vm, 2 * PAGE_SIZE, KVM_UTIL_MIN_VADDR,
+				     MEM_REGION_TEST_DATA);
+	state.vmsa_gpa = addr_gva2gpa(vm, shared_gva);
+	if (!(state.vmsa_gpa & (VMSA_PMD_SIZE - 1)))
+		state.vmsa_gpa += PAGE_SIZE;
+	state.ghcb_gpa = BIT_ULL(40);
+	state.valid_fields |= KVM_SEV_SNP_VCPU_STATE_GHCB_VALID;
+	vcpu_sev_ioctl(vcpu, KVM_SEV_SNP_SET_VCPU_STATE, &state);
+
+	private_gpa = ____vm_phy_pages_alloc(vm, 1, VMSA_MIN_GPA,
+					   vm->memslots[MEM_REGION_TEST_DATA], true, false);
+	vm_mem_set_private(vm, private_gpa, PAGE_SIZE);
+	state.vmsa_gpa = private_gpa;
+	vcpu_sev_ioctl(vcpu, KVM_SEV_SNP_SET_VCPU_STATE, &state);
+
+	memset(&state, 0, sizeof(state));
+	snp_get_vcpu_state(vcpu, &state);
+	TEST_ASSERT_EQ(state.valid_fields,
+		       KVM_SEV_SNP_VCPU_STATE_VMSA_VALID |
+		       KVM_SEV_SNP_VCPU_STATE_GHCB_VALID);
+	TEST_ASSERT_EQ(state.vmsa_gpa, private_gpa);
+	TEST_ASSERT_EQ(state.ghcb_gpa, BIT_ULL(40));
+
+	kvm_vm_free(vm);
+}
+
+static void test_direct_vmsa_capability(void)
+{
+	struct kvm_enable_cap cap = {
+		.cap = KVM_CAP_SNP_DIRECT_VMSA,
+	};
+	struct vm_shape shape = {
+		.mode = VM_MODE_DEFAULT,
+		.type = KVM_X86_SNP_VM,
+	};
+	struct kvm_vm *vm;
+
+	vm = vm_create_barebones();
+	TEST_ASSERT_EQ(__vm_enable_cap(vm, KVM_CAP_SNP_DIRECT_VMSA, 0), -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+	kvm_vm_free(vm);
+
+	vm = __vm_create(shape, 1, 0);
+	TEST_ASSERT_EQ(__vm_enable_cap(vm, KVM_CAP_SNP_DIRECT_VMSA, 1), -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+	cap.args[3] = 1;
+	TEST_ASSERT_EQ(__vm_ioctl(vm, KVM_ENABLE_CAP, &cap), -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+	cap.args[3] = 0;
+	cap.flags = 1;
+	TEST_ASSERT_EQ(__vm_ioctl(vm, KVM_ENABLE_CAP, &cap), -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+	vm_enable_cap(vm, KVM_CAP_SNP_DIRECT_VMSA, 0);
+	vm_vcpu_add(vm, 0, guest_legacy_entry);
+	TEST_ASSERT_EQ(__vm_enable_cap(vm, KVM_CAP_SNP_DIRECT_VMSA, 0), -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+	kvm_vm_free(vm);
+}
+
+static void test_legacy_launch(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	gva_t marker_gva;
+	u64 *marker;
+
+	vm = vm_sev_create_with_one_vcpu(KVM_X86_SNP_VM, guest_legacy_entry, &vcpu);
+	marker_gva = vm_alloc_shared(vm, PAGE_SIZE, KVM_UTIL_MIN_VADDR,
+				     MEM_REGION_TEST_DATA);
+	marker = addr_gva2hva(vm, marker_gva);
+	vcpu_args_set(vcpu, 1, marker_gva);
+	vm_sev_launch(vm, snp_default_policy(), NULL);
+	*marker = 0;
+	assert_vcpu_terminated(vcpu);
+	TEST_ASSERT_EQ(*marker, LEGACY_MARKER);
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_SNP_VCPU_STATE));
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_SNP_DIRECT_VMSA));
+	TEST_ASSERT(sizeof(struct test_vmsa) <= PAGE_SIZE, "VMSA structure is too large");
+
+	test_direct_vmsa_capability();
+	test_invalid_requests();
+	test_direct_vmsa();
+	test_legacy_launch();
+	return 0;
+}
-- 
2.53.0

