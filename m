Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353231AF1B;
	Wed,  6 May 2026 01:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032689; cv=none; b=Atsk8O4kQo24b8Nk/eP4BAix6CqoX1io8dxTyUS3w/sZ1jfJXqSn3DARX48h5LbBsEbhkSiNcj185XraZQPgm99RX9MawKCcToeRxb6YFYQDlH9nxQFcjLpSGW+5AvPtG9fu1xwaL0nkmUFL3hGzFc+nzvyDcCCSLkNgR3fT2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032689; c=relaxed/simple;
	bh=EXpMS070km2jkmp/gI3DYD1LhoVXg4lpJ6o+o5cUz08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DprVV+VmjoRtBKvFEnWb6s3iN6LjLExiAwrjHaSkqR44MwktdQFm6mNmosZHfIUJhB9EiIdBUqaVLU+pHLX/alZiPijxSgX1oIh1YPhfiRIHTGdT+G01fCFNPSPkn/8Sv73DjyFFYCjY1bWtf6DM4epFkimJCFOTnwMc/OQAy5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8NPpcqs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8NPpcqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D310FC4AF0C;
	Wed,  6 May 2026 01:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778032689;
	bh=EXpMS070km2jkmp/gI3DYD1LhoVXg4lpJ6o+o5cUz08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U8NPpcqsagsDXwDVqNHJ2gn8kZFAEn1e28jJl0ZZKGZUNJ7D5UOgxUYvxplwsrtmS
	 WL/jzaS35ASL6JwFjn0h5A6WCMWeOzemp8LMesJXHkwBZoy2D5VD0ITWomz4ySDYBH
	 ZyMUYaRm7SwBI2B731hvzRTFCuYku5UN8awEQC0obodvAeqZd18vHmicJyfuR7/P/2
	 IYCzSopHGZkFvLFrVqNXiP0VCb0OcsNkxhSNckI26zTLzGuXEEbnn70Ckm01RSck1i
	 aB5Q8s8X82zTH3g3elxIj97tWrWpbmBUZ4Obrvnt3wCcdKfF2tmFeTOko/KzLjnX9X
	 pBwJHTZ99C6yg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v6 15/16] KVM: selftests: Drop L1-provided stacks for L2 guests on x86
Date: Wed,  6 May 2026 01:57:31 +0000
Message-ID: <20260506015733.1671124-16-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260506015733.1671124-1-yosry@kernel.org>
References: <20260506015733.1671124-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that a dedicated page is allocated for L2's stack and stuffed in
RSP, the L1-provided stack is unused. Drop the stacks allocated by L1
guest code for L2 in all x86 tests.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/include/x86/svm_util.h |  2 +-
 tools/testing/selftests/kvm/include/x86/vmx.h      |  2 +-
 tools/testing/selftests/kvm/lib/x86/memstress.c    | 14 ++------------
 tools/testing/selftests/kvm/lib/x86/svm.c          |  2 +-
 tools/testing/selftests/kvm/lib/x86/vmx.c          |  2 +-
 tools/testing/selftests/kvm/x86/aperfmperf_test.c  |  9 ++-------
 .../selftests/kvm/x86/evmcs_smm_controls_test.c    |  5 +----
 tools/testing/selftests/kvm/x86/hyperv_evmcs.c     |  6 +-----
 tools/testing/selftests/kvm/x86/hyperv_svm_test.c  |  6 +-----
 tools/testing/selftests/kvm/x86/kvm_buslock_test.c |  9 ++-------
 .../selftests/kvm/x86/nested_close_kvm_test.c      | 12 ++----------
 .../selftests/kvm/x86/nested_dirty_log_test.c      |  8 ++------
 .../selftests/kvm/x86/nested_emulation_test.c      |  4 ++--
 .../selftests/kvm/x86/nested_exceptions_test.c     |  9 ++-------
 .../selftests/kvm/x86/nested_invalid_cr3_test.c    | 10 ++--------
 .../selftests/kvm/x86/nested_tsc_adjust_test.c     | 10 ++--------
 .../selftests/kvm/x86/nested_tsc_scaling_test.c    | 10 ++--------
 .../selftests/kvm/x86/nested_vmsave_vmload_test.c  |  6 +-----
 tools/testing/selftests/kvm/x86/smm_test.c         |  8 ++------
 tools/testing/selftests/kvm/x86/state_test.c       | 11 ++---------
 tools/testing/selftests/kvm/x86/svm_int_ctl_test.c |  5 +----
 .../selftests/kvm/x86/svm_lbr_nested_state.c       |  6 +-----
 .../selftests/kvm/x86/svm_nested_clear_efer_svme.c |  7 +------
 .../selftests/kvm/x86/svm_nested_shutdown_test.c   |  5 +----
 .../kvm/x86/svm_nested_soft_inject_test.c          |  6 +-----
 .../selftests/kvm/x86/svm_nested_vmcb12_gpa.c      | 13 ++++---------
 tools/testing/selftests/kvm/x86/svm_vmcall_test.c  |  5 +----
 .../selftests/kvm/x86/triple_fault_event_test.c    |  9 ++-------
 .../selftests/kvm/x86/vmx_apic_access_test.c       |  5 +----
 .../selftests/kvm/x86/vmx_apicv_updates_test.c     |  4 +---
 .../kvm/x86/vmx_invalid_nested_guest_state.c       |  6 +-----
 .../selftests/kvm/x86/vmx_nested_la57_state_test.c |  5 +----
 .../selftests/kvm/x86/vmx_preemption_timer_test.c  |  5 +----
 33 files changed, 49 insertions(+), 177 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/svm_util.h b/tools/testing/selftests/kvm/include/x86/svm_util.h
index 3b1cc484fba1c..c201c30485e72 100644
--- a/tools/testing/selftests/kvm/include/x86/svm_util.h
+++ b/tools/testing/selftests/kvm/include/x86/svm_util.h
@@ -60,7 +60,7 @@ static inline void vmmcall(void)
 		)
 
 struct svm_test_data *vcpu_alloc_svm(struct kvm_vm *vm, gva_t *p_svm_gva);
-void generic_svm_setup(struct svm_test_data *svm, void *guest_rip, void *guest_rsp);
+void generic_svm_setup(struct svm_test_data *svm, void *guest_rip);
 void run_guest(struct vmcb *vmcb, u64 vmcb_gpa);
 
 static inline bool kvm_cpu_has_npt(void)
diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 1dcb9b86d33d3..4bcfd60e3aecb 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -554,7 +554,7 @@ union vmx_ctrl_msr {
 
 struct vmx_pages *vcpu_alloc_vmx(struct kvm_vm *vm, gva_t *p_vmx_gva);
 bool prepare_for_vmx_operation(struct vmx_pages *vmx);
-void prepare_vmcs(struct vmx_pages *vmx, void *guest_rip, void *guest_rsp);
+void prepare_vmcs(struct vmx_pages *vmx, void *guest_rip);
 bool load_vmcs(struct vmx_pages *vmx);
 
 bool ept_1g_pages_supported(void);
diff --git a/tools/testing/selftests/kvm/lib/x86/memstress.c b/tools/testing/selftests/kvm/lib/x86/memstress.c
index fa07ef037cad1..e19e8b5a09c5a 100644
--- a/tools/testing/selftests/kvm/lib/x86/memstress.c
+++ b/tools/testing/selftests/kvm/lib/x86/memstress.c
@@ -30,21 +30,15 @@ __asm__(
 "	ud2;"
 );
 
-#define L2_GUEST_STACK_SIZE 64
-
 static void l1_vmx_code(struct vmx_pages *vmx, u64 vcpu_id)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
-	unsigned long *rsp;
-
 	GUEST_ASSERT(vmx->vmcs_gpa);
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx));
 	GUEST_ASSERT(load_vmcs(vmx));
 	GUEST_ASSERT(ept_1g_pages_supported());
 
-	rsp = &l2_guest_stack[L2_GUEST_STACK_SIZE - 1];
 	*(u64 *)vmx->stack = vcpu_id;
-	prepare_vmcs(vmx, memstress_l2_guest_entry, rsp);
+	prepare_vmcs(vmx, memstress_l2_guest_entry);
 
 	GUEST_ASSERT(!vmlaunch());
 	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_VMCALL);
@@ -53,12 +47,8 @@ static void l1_vmx_code(struct vmx_pages *vmx, u64 vcpu_id)
 
 static void l1_svm_code(struct svm_test_data *svm, u64 vcpu_id)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
-	unsigned long *rsp;
-
-	rsp = &l2_guest_stack[L2_GUEST_STACK_SIZE - 1];
 	*(u64 *)svm->stack = vcpu_id;
-	generic_svm_setup(svm, memstress_l2_guest_entry, rsp);
+	generic_svm_setup(svm, memstress_l2_guest_entry);
 
 	run_guest(svm->vmcb, svm->vmcb_gpa);
 	GUEST_ASSERT_EQ(svm->vmcb->control.exit_code, SVM_EXIT_VMMCALL);
diff --git a/tools/testing/selftests/kvm/lib/x86/svm.c b/tools/testing/selftests/kvm/lib/x86/svm.c
index 4e9c37f8d1a61..1445b890986fd 100644
--- a/tools/testing/selftests/kvm/lib/x86/svm.c
+++ b/tools/testing/selftests/kvm/lib/x86/svm.c
@@ -83,7 +83,7 @@ void vm_enable_npt(struct kvm_vm *vm)
 	tdp_mmu_init(vm, vm->mmu.pgtable_levels, &pte_masks);
 }
 
-void generic_svm_setup(struct svm_test_data *svm, void *guest_rip, void *guest_rsp)
+void generic_svm_setup(struct svm_test_data *svm, void *guest_rip)
 {
 	struct vmcb *vmcb = svm->vmcb;
 	u64 vmcb_gpa = svm->vmcb_gpa;
diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
index 81fe85cf22e8f..33c477ce4a58b 100644
--- a/tools/testing/selftests/kvm/lib/x86/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
@@ -368,7 +368,7 @@ static inline void init_vmcs_guest_state(void *rip, void *rsp)
 	vmwrite(GUEST_SYSENTER_EIP, vmreadz(HOST_IA32_SYSENTER_EIP));
 }
 
-void prepare_vmcs(struct vmx_pages *vmx, void *guest_rip, void *guest_rsp)
+void prepare_vmcs(struct vmx_pages *vmx, void *guest_rip)
 {
 	init_vmcs_control_fields(vmx);
 	init_vmcs_host_state();
diff --git a/tools/testing/selftests/kvm/x86/aperfmperf_test.c b/tools/testing/selftests/kvm/x86/aperfmperf_test.c
index c91660103137b..845cb685f1743 100644
--- a/tools/testing/selftests/kvm/x86/aperfmperf_test.c
+++ b/tools/testing/selftests/kvm/x86/aperfmperf_test.c
@@ -54,8 +54,6 @@ static void guest_read_aperf_mperf(void)
 		GUEST_SYNC2(rdmsr(MSR_IA32_APERF), rdmsr(MSR_IA32_MPERF));
 }
 
-#define L2_GUEST_STACK_SIZE	64
-
 static void l2_guest_code(void)
 {
 	guest_read_aperf_mperf();
@@ -64,21 +62,18 @@ static void l2_guest_code(void)
 
 static void l1_svm_code(struct svm_test_data *svm)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	struct vmcb *vmcb = svm->vmcb;
 
-	generic_svm_setup(svm, l2_guest_code, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	generic_svm_setup(svm, l2_guest_code);
 	run_guest(vmcb, svm->vmcb_gpa);
 }
 
 static void l1_vmx_code(struct vmx_pages *vmx)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
-
 	GUEST_ASSERT_EQ(prepare_for_vmx_operation(vmx), true);
 	GUEST_ASSERT_EQ(load_vmcs(vmx), true);
 
-	prepare_vmcs(vmx, NULL, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	prepare_vmcs(vmx, NULL);
 
 	/*
 	 * Enable MSR bitmaps (the bitmap itself is allocated, zeroed, and set
diff --git a/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c b/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c
index 5b3aef109cfc5..77ce87c41a868 100644
--- a/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c
+++ b/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c
@@ -52,8 +52,6 @@ static void l2_guest_code(void)
 static void guest_code(struct vmx_pages *vmx_pages,
 		       struct hyperv_test_pages *hv_pages)
 {
-#define L2_GUEST_STACK_SIZE 64
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 
 	/* Set up Hyper-V enlightenments and eVMCS */
 	wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
@@ -62,8 +60,7 @@ static void guest_code(struct vmx_pages *vmx_pages,
 
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
 	GUEST_ASSERT(load_evmcs(hv_pages));
-	prepare_vmcs(vmx_pages, l2_guest_code,
-		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	prepare_vmcs(vmx_pages, l2_guest_code);
 
 	GUEST_ASSERT(!vmlaunch());
 
diff --git a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
index c7fa114aee20f..1bda2cd3f7396 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
@@ -78,9 +78,6 @@ void l2_guest_code(void)
 void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 		gpa_t hv_hcall_page_gpa)
 {
-#define L2_GUEST_STACK_SIZE 64
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
-
 	wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
 	wrmsr(HV_X64_MSR_HYPERCALL, hv_hcall_page_gpa);
 
@@ -100,8 +97,7 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	GUEST_SYNC(4);
 	GUEST_ASSERT(vmptrstz() == hv_pages->enlightened_vmcs_gpa);
 
-	prepare_vmcs(vmx_pages, l2_guest_code,
-		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	prepare_vmcs(vmx_pages, l2_guest_code);
 
 	GUEST_SYNC(5);
 	GUEST_ASSERT(vmptrstz() == hv_pages->enlightened_vmcs_gpa);
diff --git a/tools/testing/selftests/kvm/x86/hyperv_svm_test.c b/tools/testing/selftests/kvm/x86/hyperv_svm_test.c
index 7a62f6a9d606d..1f74b0fa9b835 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_svm_test.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_svm_test.c
@@ -18,8 +18,6 @@
 #include "svm_util.h"
 #include "hyperv.h"
 
-#define L2_GUEST_STACK_SIZE 256
-
 /* Exit to L1 from L2 with RDMSR instruction */
 static inline void rdmsr_from_l2(u32 msr)
 {
@@ -69,7 +67,6 @@ static void __attribute__((__flatten__)) guest_code(struct svm_test_data *svm,
 						    struct hyperv_test_pages *hv_pages,
 						    gpa_t pgs_gpa)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	struct vmcb *vmcb = svm->vmcb;
 	struct hv_vmcb_enlightenments *hve = &vmcb->control.hv_enlightenments;
 
@@ -81,8 +78,7 @@ static void __attribute__((__flatten__)) guest_code(struct svm_test_data *svm,
 
 	GUEST_ASSERT(svm->vmcb_gpa);
 	/* Prepare for L2 execution. */
-	generic_svm_setup(svm, l2_guest_code,
-			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	generic_svm_setup(svm, l2_guest_code);
 
 	/* L2 TLB flush setup */
 	hve->partition_assist_page = hv_pages->partition_assist_gpa;
diff --git a/tools/testing/selftests/kvm/x86/kvm_buslock_test.c b/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
index 52014a3210c88..25a182be00a97 100644
--- a/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
+++ b/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
@@ -26,8 +26,6 @@ static void guest_generate_buslocks(void)
 		atomic_inc(val);
 }
 
-#define L2_GUEST_STACK_SIZE	64
-
 static void l2_guest_code(void)
 {
 	guest_generate_buslocks();
@@ -36,21 +34,18 @@ static void l2_guest_code(void)
 
 static void l1_svm_code(struct svm_test_data *svm)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	struct vmcb *vmcb = svm->vmcb;
 
-	generic_svm_setup(svm, l2_guest_code, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	generic_svm_setup(svm, l2_guest_code);
 	run_guest(vmcb, svm->vmcb_gpa);
 }
 
 static void l1_vmx_code(struct vmx_pages *vmx)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
-
 	GUEST_ASSERT_EQ(prepare_for_vmx_operation(vmx), true);
 	GUEST_ASSERT_EQ(load_vmcs(vmx), true);
 
-	prepare_vmcs(vmx, NULL, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	prepare_vmcs(vmx, NULL);
 
 	GUEST_ASSERT(!vmwrite(GUEST_RIP, (u64)l2_guest_code));
 	GUEST_ASSERT(!vmlaunch());
diff --git a/tools/testing/selftests/kvm/x86/nested_close_kvm_test.c b/tools/testing/selftests/kvm/x86/nested_close_kvm_test.c
index 761fec2934080..b974cfb347d6e 100644
--- a/tools/testing/selftests/kvm/x86/nested_close_kvm_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_close_kvm_test.c
@@ -21,8 +21,6 @@ enum {
 	PORT_L0_EXIT = 0x2000,
 };
 
-#define L2_GUEST_STACK_SIZE 64
-
 static void l2_guest_code(void)
 {
 	/* Exit to L0 */
@@ -32,14 +30,11 @@ static void l2_guest_code(void)
 
 static void l1_vmx_code(struct vmx_pages *vmx_pages)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
-
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
 	GUEST_ASSERT(load_vmcs(vmx_pages));
 
 	/* Prepare the VMCS for L2 execution. */
-	prepare_vmcs(vmx_pages, l2_guest_code,
-		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	prepare_vmcs(vmx_pages, l2_guest_code);
 
 	GUEST_ASSERT(!vmlaunch());
 	GUEST_ASSERT(0);
@@ -47,11 +42,8 @@ static void l1_vmx_code(struct vmx_pages *vmx_pages)
 
 static void l1_svm_code(struct svm_test_data *svm)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
-
 	/* Prepare the VMCB for L2 execution. */
-	generic_svm_setup(svm, l2_guest_code,
-			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	generic_svm_setup(svm, l2_guest_code);
 
 	run_guest(svm->vmcb, svm->vmcb_gpa);
 	GUEST_ASSERT(0);
diff --git a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c b/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
index 0e67cce835701..26b474bf13535 100644
--- a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
@@ -40,8 +40,6 @@
 
 #define TEST_HVA(vm, idx)		addr_gpa2hva(vm, TEST_GPA(idx))
 
-#define L2_GUEST_STACK_SIZE 64
-
 /* Use the page offset bits to communicate the access+fault type. */
 #define TEST_SYNC_READ_FAULT		BIT(0)
 #define TEST_SYNC_WRITE_FAULT		BIT(1)
@@ -92,7 +90,6 @@ static void l2_guest_code_tdp_disabled(void)
 
 void l1_vmx_code(struct vmx_pages *vmx)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	void *l2_rip;
 
 	GUEST_ASSERT(vmx->vmcs_gpa);
@@ -104,7 +101,7 @@ void l1_vmx_code(struct vmx_pages *vmx)
 	else
 		l2_rip = l2_guest_code_tdp_disabled;
 
-	prepare_vmcs(vmx, l2_rip, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	prepare_vmcs(vmx, l2_rip);
 
 	GUEST_SYNC(TEST_SYNC_NO_FAULT);
 	GUEST_ASSERT(!vmlaunch());
@@ -115,7 +112,6 @@ void l1_vmx_code(struct vmx_pages *vmx)
 
 static void l1_svm_code(struct svm_test_data *svm)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	void *l2_rip;
 
 	if (svm->ncr3_gpa)
@@ -123,7 +119,7 @@ static void l1_svm_code(struct svm_test_data *svm)
 	else
 		l2_rip = l2_guest_code_tdp_disabled;
 
-	generic_svm_setup(svm, l2_rip, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	generic_svm_setup(svm, l2_rip);
 
 	GUEST_SYNC(TEST_SYNC_NO_FAULT);
 	run_guest(svm->vmcb, svm->vmcb_gpa);
diff --git a/tools/testing/selftests/kvm/x86/nested_emulation_test.c b/tools/testing/selftests/kvm/x86/nested_emulation_test.c
index fb7dcbe53ac73..e08c6b0697e50 100644
--- a/tools/testing/selftests/kvm/x86/nested_emulation_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_emulation_test.c
@@ -57,7 +57,7 @@ static void guest_code(void *test_data)
 		struct svm_test_data *svm = test_data;
 		struct vmcb *vmcb = svm->vmcb;
 
-		generic_svm_setup(svm, NULL, NULL);
+		generic_svm_setup(svm, NULL);
 		vmcb->save.idtr.limit = 0;
 		vmcb->save.rip = (u64)l2_guest_code;
 
@@ -69,7 +69,7 @@ static void guest_code(void *test_data)
 		GUEST_ASSERT(prepare_for_vmx_operation(test_data));
 		GUEST_ASSERT(load_vmcs(test_data));
 
-		prepare_vmcs(test_data, NULL, NULL);
+		prepare_vmcs(test_data, NULL);
 		GUEST_ASSERT(!vmwrite(GUEST_IDTR_LIMIT, 0));
 		GUEST_ASSERT(!vmwrite(GUEST_RIP, (u64)l2_guest_code));
 		GUEST_ASSERT(!vmwrite(EXCEPTION_BITMAP, 0));
diff --git a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
index 186e980aa8eee..aeec3121c8e83 100644
--- a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
@@ -5,8 +5,6 @@
 #include "vmx.h"
 #include "svm_util.h"
 
-#define L2_GUEST_STACK_SIZE 256
-
 /*
  * Arbitrary, never shoved into KVM/hardware, just need to avoid conflict with
  * the "real" exceptions used, #SS/#GP/#DF (12/13/8).
@@ -91,9 +89,8 @@ static void svm_run_l2(struct svm_test_data *svm, void *l2_code, int vector,
 static void l1_svm_code(struct svm_test_data *svm)
 {
 	struct vmcb_control_area *ctrl = &svm->vmcb->control;
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 
-	generic_svm_setup(svm, NULL, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	generic_svm_setup(svm, NULL);
 	svm->vmcb->save.idtr.limit = 0;
 	ctrl->intercept |= BIT_ULL(INTERCEPT_SHUTDOWN);
 
@@ -128,13 +125,11 @@ static void vmx_run_l2(void *l2_code, int vector, u32 error_code)
 
 static void l1_vmx_code(struct vmx_pages *vmx)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
-
 	GUEST_ASSERT_EQ(prepare_for_vmx_operation(vmx), true);
 
 	GUEST_ASSERT_EQ(load_vmcs(vmx), true);
 
-	prepare_vmcs(vmx, NULL, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	prepare_vmcs(vmx, NULL);
 	GUEST_ASSERT_EQ(vmwrite(GUEST_IDTR_LIMIT, 0), 0);
 
 	/*
diff --git a/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c b/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c
index 11fd2467d8233..8c2ba9674558e 100644
--- a/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c
@@ -11,8 +11,6 @@
 #include "kselftest.h"
 
 
-#define L2_GUEST_STACK_SIZE 64
-
 static void l2_guest_code(void)
 {
 	vmcall();
@@ -20,11 +18,9 @@ static void l2_guest_code(void)
 
 static void l1_svm_code(struct svm_test_data *svm)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	uintptr_t save_cr3;
 
-	generic_svm_setup(svm, l2_guest_code,
-			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	generic_svm_setup(svm, l2_guest_code);
 
 	/* Try to run L2 with invalid CR3 and make sure it fails */
 	save_cr3 = svm->vmcb->save.cr3;
@@ -42,14 +38,12 @@ static void l1_svm_code(struct svm_test_data *svm)
 
 static void l1_vmx_code(struct vmx_pages *vmx_pages)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	uintptr_t save_cr3;
 
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
 	GUEST_ASSERT(load_vmcs(vmx_pages));
 
-	prepare_vmcs(vmx_pages, l2_guest_code,
-		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	prepare_vmcs(vmx_pages, l2_guest_code);
 
 	/* Try to run L2 with invalid CR3 and make sure it fails */
 	save_cr3 = vmreadz(GUEST_CR3);
diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c
index f0e4adac47510..cb79d7b9619c2 100644
--- a/tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c
@@ -34,8 +34,6 @@
 #define TSC_ADJUST_VALUE (1ll << 32)
 #define TSC_OFFSET_VALUE -(1ll << 48)
 
-#define L2_GUEST_STACK_SIZE 64
-
 enum {
 	PORT_ABORT = 0x1000,
 	PORT_REPORT,
@@ -75,8 +73,6 @@ static void l2_guest_code(void)
 
 static void l1_guest_code(void *data)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
-
 	/* Set TSC from L1 and make sure TSC_ADJUST is updated correctly */
 	GUEST_ASSERT(rdtsc() < TSC_ADJUST_VALUE);
 	wrmsr(MSR_IA32_TSC, rdtsc() - TSC_ADJUST_VALUE);
@@ -93,8 +89,7 @@ static void l1_guest_code(void *data)
 		GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
 		GUEST_ASSERT(load_vmcs(vmx_pages));
 
-		prepare_vmcs(vmx_pages, l2_guest_code,
-			     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+		prepare_vmcs(vmx_pages, l2_guest_code);
 		control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
 		control |= CPU_BASED_USE_MSR_BITMAPS | CPU_BASED_USE_TSC_OFFSETTING;
 		vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
@@ -105,8 +100,7 @@ static void l1_guest_code(void *data)
 	} else {
 		struct svm_test_data *svm = data;
 
-		generic_svm_setup(svm, l2_guest_code,
-				  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+		generic_svm_setup(svm, l2_guest_code);
 
 		svm->vmcb->control.tsc_offset = TSC_OFFSET_VALUE;
 		run_guest(svm->vmcb, svm->vmcb_gpa);
diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
index 190e93af20a14..18f765835bf4c 100644
--- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
@@ -22,8 +22,6 @@
 #define TSC_OFFSET_L2 ((u64)-33125236320908)
 #define TSC_MULTIPLIER_L2 (L2_SCALE_FACTOR << 48)
 
-#define L2_GUEST_STACK_SIZE 64
-
 enum { USLEEP, UCHECK_L1, UCHECK_L2 };
 #define GUEST_SLEEP(sec)         ucall(UCALL_SYNC, 2, USLEEP, sec)
 #define GUEST_CHECK(level, freq) ucall(UCALL_SYNC, 2, level, freq)
@@ -82,13 +80,10 @@ static void l2_guest_code(void)
 
 static void l1_svm_code(struct svm_test_data *svm)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
-
 	/* check that L1's frequency looks alright before launching L2 */
 	check_tsc_freq(UCHECK_L1);
 
-	generic_svm_setup(svm, l2_guest_code,
-			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	generic_svm_setup(svm, l2_guest_code);
 
 	/* enable TSC scaling for L2 */
 	wrmsr(MSR_AMD64_TSC_RATIO, L2_SCALE_FACTOR << 32);
@@ -105,7 +100,6 @@ static void l1_svm_code(struct svm_test_data *svm)
 
 static void l1_vmx_code(struct vmx_pages *vmx_pages)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	u32 control;
 
 	/* check that L1's frequency looks alright before launching L2 */
@@ -115,7 +109,7 @@ static void l1_vmx_code(struct vmx_pages *vmx_pages)
 	GUEST_ASSERT(load_vmcs(vmx_pages));
 
 	/* prepare the VMCS for L2 execution */
-	prepare_vmcs(vmx_pages, l2_guest_code, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	prepare_vmcs(vmx_pages, l2_guest_code);
 
 	/* enable TSC offsetting and TSC scaling for L2 */
 	control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
diff --git a/tools/testing/selftests/kvm/x86/nested_vmsave_vmload_test.c b/tools/testing/selftests/kvm/x86/nested_vmsave_vmload_test.c
index 85d3f4cc76f39..a130759f39a19 100644
--- a/tools/testing/selftests/kvm/x86/nested_vmsave_vmload_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_vmsave_vmload_test.c
@@ -28,8 +28,6 @@
 
 #define TEST_VMCB_L2_GPA		TEST_VMCB_L1_GPA(0)
 
-#define L2_GUEST_STACK_SIZE		64
-
 static void l2_guest_code_vmsave(void)
 {
 	asm volatile("vmsave %0" : : "a"(TEST_VMCB_L2_GPA) : "memory");
@@ -70,10 +68,8 @@ static void l2_guest_code_vmcb1(void)
 
 static void l1_guest_code(struct svm_test_data *svm)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
-
 	/* Each test case initializes the guest RIP below */
-	generic_svm_setup(svm, NULL, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	generic_svm_setup(svm, NULL);
 
 	/* Set VMSAVE/VMLOAD intercepts and make sure they work with.. */
 	svm->vmcb->control.intercept |= (BIT_ULL(INTERCEPT_VMSAVE) |
diff --git a/tools/testing/selftests/kvm/x86/smm_test.c b/tools/testing/selftests/kvm/x86/smm_test.c
index 740051167dbd4..e2542f4ced605 100644
--- a/tools/testing/selftests/kvm/x86/smm_test.c
+++ b/tools/testing/selftests/kvm/x86/smm_test.c
@@ -63,8 +63,6 @@ static void l2_guest_code(void)
 
 static void guest_code(void *arg)
 {
-	#define L2_GUEST_STACK_SIZE 64
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	u64 apicbase = rdmsr(MSR_IA32_APICBASE);
 	struct svm_test_data *svm = arg;
 	struct vmx_pages *vmx_pages = arg;
@@ -81,13 +79,11 @@ static void guest_code(void *arg)
 
 	if (arg) {
 		if (this_cpu_has(X86_FEATURE_SVM)) {
-			generic_svm_setup(svm, l2_guest_code,
-					  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+			generic_svm_setup(svm, l2_guest_code);
 		} else {
 			GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
 			GUEST_ASSERT(load_vmcs(vmx_pages));
-			prepare_vmcs(vmx_pages, l2_guest_code,
-				     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+			prepare_vmcs(vmx_pages, l2_guest_code);
 		}
 
 		sync_with_host(5);
diff --git a/tools/testing/selftests/kvm/x86/state_test.c b/tools/testing/selftests/kvm/x86/state_test.c
index 409c6cc9f9214..4a1056a6cb8dc 100644
--- a/tools/testing/selftests/kvm/x86/state_test.c
+++ b/tools/testing/selftests/kvm/x86/state_test.c
@@ -19,8 +19,6 @@
 #include "vmx.h"
 #include "svm_util.h"
 
-#define L2_GUEST_STACK_SIZE 256
-
 void svm_l2_guest_code(void)
 {
 	GUEST_SYNC(4);
@@ -35,13 +33,11 @@ void svm_l2_guest_code(void)
 
 static void svm_l1_guest_code(struct svm_test_data *svm)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	struct vmcb *vmcb = svm->vmcb;
 
 	GUEST_ASSERT(svm->vmcb_gpa);
 	/* Prepare for L2 execution. */
-	generic_svm_setup(svm, svm_l2_guest_code,
-			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	generic_svm_setup(svm, svm_l2_guest_code);
 
 	vmcb->control.int_ctl |= (V_GIF_ENABLE_MASK | V_GIF_MASK);
 
@@ -78,8 +74,6 @@ void vmx_l2_guest_code(void)
 
 static void vmx_l1_guest_code(struct vmx_pages *vmx_pages)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
-
 	GUEST_ASSERT(vmx_pages->vmcs_gpa);
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
 	GUEST_SYNC(3);
@@ -89,8 +83,7 @@ static void vmx_l1_guest_code(struct vmx_pages *vmx_pages)
 	GUEST_SYNC(4);
 	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
 
-	prepare_vmcs(vmx_pages, vmx_l2_guest_code,
-		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	prepare_vmcs(vmx_pages, vmx_l2_guest_code);
 
 	GUEST_SYNC(5);
 	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
diff --git a/tools/testing/selftests/kvm/x86/svm_int_ctl_test.c b/tools/testing/selftests/kvm/x86/svm_int_ctl_test.c
index d3cc5e4f78831..7b1f4a4818bdd 100644
--- a/tools/testing/selftests/kvm/x86/svm_int_ctl_test.c
+++ b/tools/testing/selftests/kvm/x86/svm_int_ctl_test.c
@@ -54,15 +54,12 @@ static void l2_guest_code(struct svm_test_data *svm)
 
 static void l1_guest_code(struct svm_test_data *svm)
 {
-	#define L2_GUEST_STACK_SIZE 64
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	struct vmcb *vmcb = svm->vmcb;
 
 	x2apic_enable();
 
 	/* Prepare for L2 execution. */
-	generic_svm_setup(svm, l2_guest_code,
-			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	generic_svm_setup(svm, l2_guest_code);
 
 	/* No virtual interrupt masking */
 	vmcb->control.int_ctl &= ~V_INTR_MASKING_MASK;
diff --git a/tools/testing/selftests/kvm/x86/svm_lbr_nested_state.c b/tools/testing/selftests/kvm/x86/svm_lbr_nested_state.c
index 7fbfaa054c952..77c6ce9f45078 100644
--- a/tools/testing/selftests/kvm/x86/svm_lbr_nested_state.c
+++ b/tools/testing/selftests/kvm/x86/svm_lbr_nested_state.c
@@ -9,8 +9,6 @@
 #include "svm_util.h"
 
 
-#define L2_GUEST_STACK_SIZE 64
-
 #define DO_BRANCH() do { asm volatile("jmp 1f\n 1: nop"); } while (0)
 
 struct lbr_branch {
@@ -55,7 +53,6 @@ static void l2_guest_code(struct svm_test_data *svm)
 
 static void l1_guest_code(struct svm_test_data *svm, bool nested_lbrv)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	struct vmcb *vmcb = svm->vmcb;
 	struct lbr_branch l1_branch;
 
@@ -65,8 +62,7 @@ static void l1_guest_code(struct svm_test_data *svm, bool nested_lbrv)
 	CHECK_BRANCH_MSRS(&l1_branch);
 
 	/* Run L2, which will also do the same */
-	generic_svm_setup(svm, l2_guest_code,
-			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	generic_svm_setup(svm, l2_guest_code);
 
 	if (nested_lbrv)
 		vmcb->control.misc_ctl2 = SVM_MISC2_ENABLE_V_LBR;
diff --git a/tools/testing/selftests/kvm/x86/svm_nested_clear_efer_svme.c b/tools/testing/selftests/kvm/x86/svm_nested_clear_efer_svme.c
index 6a89eaffc6578..6bc301207cbcb 100644
--- a/tools/testing/selftests/kvm/x86/svm_nested_clear_efer_svme.c
+++ b/tools/testing/selftests/kvm/x86/svm_nested_clear_efer_svme.c
@@ -8,8 +8,6 @@
 #include "kselftest.h"
 
 
-#define L2_GUEST_STACK_SIZE 64
-
 static void l2_guest_code(void)
 {
 	unsigned long efer = rdmsr(MSR_EFER);
@@ -24,10 +22,7 @@ static void l2_guest_code(void)
 
 static void l1_guest_code(struct svm_test_data *svm)
 {
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
-
-	generic_svm_setup(svm, l2_guest_code,
-			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	generic_svm_setup(svm, l2_guest_code);
 	run_guest(svm->vmcb, svm->vmcb_gpa);
 
 	/* Unreachable, L1 should be shutdown */
diff --git a/tools/testing/selftests/kvm/x86/svm_nested_shutdown_test.c b/tools/testing/selftests/kvm/x86/svm_nested_shutdown_test.c
index c6ea3d609a629..2a4a216954bb3 100644
--- a/tools/testing/selftests/kvm/x86/svm_nested_shutdown_test.c
+++ b/tools/testing/selftests/kvm/x86/svm_nested_shutdown_test.c
@@ -19,12 +19,9 @@ static void l2_guest_code(struct svm_test_data *svm)
 
 static void l1_guest_code(struct svm_test_data *svm, struct idt_entry *idt)
 {
-	#define L2_GUEST_STACK_SIZE 64
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	struct vmcb *vmcb = svm->vmcb;
 
-	generic_svm_setup(svm, l2_guest_code,
-			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	generic_svm_setup(svm, l2_guest_code);
 
 	vmcb->control.intercept &= ~(BIT(INTERCEPT_SHUTDOWN));
 
diff --git a/tools/testing/selftests/kvm/x86/svm_nested_soft_inject_test.c b/tools/testing/selftests/kvm/x86/svm_nested_soft_inject_test.c
index f72f11d4c4f83..0b640d09d1943 100644
--- a/tools/testing/selftests/kvm/x86/svm_nested_soft_inject_test.c
+++ b/tools/testing/selftests/kvm/x86/svm_nested_soft_inject_test.c
@@ -78,17 +78,13 @@ static void l2_guest_code_nmi(void)
 
 static void l1_guest_code(struct svm_test_data *svm, u64 is_nmi, u64 idt_alt)
 {
-	#define L2_GUEST_STACK_SIZE 64
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	struct vmcb *vmcb = svm->vmcb;
 
 	if (is_nmi)
 		x2apic_enable();
 
 	/* Prepare for L2 execution. */
-	generic_svm_setup(svm,
-			  is_nmi ? l2_guest_code_nmi : l2_guest_code_int,
-			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	generic_svm_setup(svm, is_nmi ? l2_guest_code_nmi : l2_guest_code_int);
 
 	vmcb->control.intercept_exceptions |= BIT(PF_VECTOR) | BIT(UD_VECTOR);
 	vmcb->control.intercept |= BIT(INTERCEPT_NMI) | BIT(INTERCEPT_HLT);
diff --git a/tools/testing/selftests/kvm/x86/svm_nested_vmcb12_gpa.c b/tools/testing/selftests/kvm/x86/svm_nested_vmcb12_gpa.c
index a4935ce2fb998..b3f45035745ff 100644
--- a/tools/testing/selftests/kvm/x86/svm_nested_vmcb12_gpa.c
+++ b/tools/testing/selftests/kvm/x86/svm_nested_vmcb12_gpa.c
@@ -9,14 +9,9 @@
 #include "kvm_test_harness.h"
 #include "test_util.h"
 
-
-#define L2_GUEST_STACK_SIZE 64
-
 #define SYNC_GP 101
 #define SYNC_L2_STARTED 102
 
-static unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
-
 static void guest_gp_handler(struct ex_regs *regs)
 {
 	GUEST_SYNC(SYNC_GP);
@@ -30,28 +25,28 @@ static void l2_code(void)
 
 static void l1_vmrun(struct svm_test_data *svm, gpa_t gpa)
 {
-	generic_svm_setup(svm, l2_code, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	generic_svm_setup(svm, l2_code);
 
 	asm volatile ("vmrun %[gpa]" : : [gpa] "a" (gpa) : "memory");
 }
 
 static void l1_vmload(struct svm_test_data *svm, gpa_t gpa)
 {
-	generic_svm_setup(svm, l2_code, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	generic_svm_setup(svm, l2_code);
 
 	asm volatile ("vmload %[gpa]" : : [gpa] "a" (gpa) : "memory");
 }
 
 static void l1_vmsave(struct svm_test_data *svm, gpa_t gpa)
 {
-	generic_svm_setup(svm, l2_code, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	generic_svm_setup(svm, l2_code);
 
 	asm volatile ("vmsave %[gpa]" : : [gpa] "a" (gpa) : "memory");
 }
 
 static void l1_vmexit(struct svm_test_data *svm, gpa_t gpa)
 {
-	generic_svm_setup(svm, l2_code, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	generic_svm_setup(svm, l2_code);
 
 	run_guest(svm->vmcb, svm->vmcb_gpa);
 	GUEST_ASSERT(svm->vmcb->control.exit_code == SVM_EXIT_VMMCALL);
diff --git a/tools/testing/selftests/kvm/x86/svm_vmcall_test.c b/tools/testing/selftests/kvm/x86/svm_vmcall_test.c
index b1887242f3b8e..7c57fb7e64221 100644
--- a/tools/testing/selftests/kvm/x86/svm_vmcall_test.c
+++ b/tools/testing/selftests/kvm/x86/svm_vmcall_test.c
@@ -19,13 +19,10 @@ static void l2_guest_code(struct svm_test_data *svm)
 
 static void l1_guest_code(struct svm_test_data *svm)
 {
-	#define L2_GUEST_STACK_SIZE 64
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	struct vmcb *vmcb = svm->vmcb;
 
 	/* Prepare for L2 execution. */
-	generic_svm_setup(svm, l2_guest_code,
-			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	generic_svm_setup(svm, l2_guest_code);
 
 	run_guest(vmcb, svm->vmcb_gpa);
 
diff --git a/tools/testing/selftests/kvm/x86/triple_fault_event_test.c b/tools/testing/selftests/kvm/x86/triple_fault_event_test.c
index f1c488e0d4975..0d83516f4bd08 100644
--- a/tools/testing/selftests/kvm/x86/triple_fault_event_test.c
+++ b/tools/testing/selftests/kvm/x86/triple_fault_event_test.c
@@ -21,9 +21,6 @@ static void l2_guest_code(void)
 		     : : [port] "d" (ARBITRARY_IO_PORT) : "rax");
 }
 
-#define L2_GUEST_STACK_SIZE 64
-unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
-
 void l1_guest_code_vmx(struct vmx_pages *vmx)
 {
 
@@ -31,8 +28,7 @@ void l1_guest_code_vmx(struct vmx_pages *vmx)
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx));
 	GUEST_ASSERT(load_vmcs(vmx));
 
-	prepare_vmcs(vmx, l2_guest_code,
-		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	prepare_vmcs(vmx, l2_guest_code);
 
 	GUEST_ASSERT(!vmlaunch());
 	/* L2 should triple fault after a triple fault event injected. */
@@ -44,8 +40,7 @@ void l1_guest_code_svm(struct svm_test_data *svm)
 {
 	struct vmcb *vmcb = svm->vmcb;
 
-	generic_svm_setup(svm, l2_guest_code,
-			&l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	generic_svm_setup(svm, l2_guest_code);
 
 	/* don't intercept shutdown to test the case of SVM allowing to do so */
 	vmcb->control.intercept &= ~(BIT(INTERCEPT_SHUTDOWN));
diff --git a/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c b/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c
index 1720113eae799..463f73aa9159a 100644
--- a/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_apic_access_test.c
@@ -36,16 +36,13 @@ static void l2_guest_code(void)
 
 static void l1_guest_code(struct vmx_pages *vmx_pages, unsigned long high_gpa)
 {
-#define L2_GUEST_STACK_SIZE 64
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	u32 control;
 
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
 	GUEST_ASSERT(load_vmcs(vmx_pages));
 
 	/* Prepare the VMCS for L2 execution. */
-	prepare_vmcs(vmx_pages, l2_guest_code,
-		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	prepare_vmcs(vmx_pages, l2_guest_code);
 	control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
 	control |= CPU_BASED_ACTIVATE_SECONDARY_CONTROLS;
 	vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
diff --git a/tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c b/tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c
index 80a4fd1e5bbbe..f9b88a6f6113d 100644
--- a/tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c
@@ -31,15 +31,13 @@ static void l2_guest_code(void)
 
 static void l1_guest_code(struct vmx_pages *vmx_pages)
 {
-#define L2_GUEST_STACK_SIZE 64
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	u32 control;
 
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
 	GUEST_ASSERT(load_vmcs(vmx_pages));
 
 	/* Prepare the VMCS for L2 execution. */
-	prepare_vmcs(vmx_pages, l2_guest_code, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	prepare_vmcs(vmx_pages, l2_guest_code);
 	control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
 	control |= CPU_BASED_USE_MSR_BITMAPS;
 	vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
diff --git a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
index a2eaceed9ad52..6d88c54f69faa 100644
--- a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
+++ b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
@@ -25,15 +25,11 @@ static void l2_guest_code(void)
 
 static void l1_guest_code(struct vmx_pages *vmx_pages)
 {
-#define L2_GUEST_STACK_SIZE 64
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
-
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
 	GUEST_ASSERT(load_vmcs(vmx_pages));
 
 	/* Prepare the VMCS for L2 execution. */
-	prepare_vmcs(vmx_pages, l2_guest_code,
-		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	prepare_vmcs(vmx_pages, l2_guest_code);
 
 	/*
 	 * L2 must be run without unrestricted guest, verify that the selftests
diff --git a/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c b/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c
index f13dee3173837..75073efa926da 100644
--- a/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c
@@ -27,8 +27,6 @@ static void l2_guest_code(void)
 
 static void l1_guest_code(struct vmx_pages *vmx_pages)
 {
-#define L2_GUEST_STACK_SIZE 64
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	u64 guest_cr4;
 	gpa_t pml5_pa, pml4_pa;
 	u64 *pml5;
@@ -42,8 +40,7 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
 	GUEST_ASSERT(load_vmcs(vmx_pages));
 
-	prepare_vmcs(vmx_pages, l2_guest_code,
-		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	prepare_vmcs(vmx_pages, l2_guest_code);
 
 	/*
 	 * Set up L2 with a 4-level page table by pointing its CR3 to
diff --git a/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c b/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
index 1b7b6ba23de76..eb8021c33cd43 100644
--- a/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c
@@ -66,8 +66,6 @@ void l2_guest_code(void)
 
 void l1_guest_code(struct vmx_pages *vmx_pages)
 {
-#define L2_GUEST_STACK_SIZE 64
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	u64 l1_vmx_pt_start;
 	u64 l1_vmx_pt_finish;
 	u64 l1_tsc_deadline, l2_tsc_deadline;
@@ -77,8 +75,7 @@ void l1_guest_code(struct vmx_pages *vmx_pages)
 	GUEST_ASSERT(load_vmcs(vmx_pages));
 	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
 
-	prepare_vmcs(vmx_pages, l2_guest_code,
-		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	prepare_vmcs(vmx_pages, l2_guest_code);
 
 	/*
 	 * Check for Preemption timer support
-- 
2.54.0.545.g6539524ca2-goog

