Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C573CF058;
	Thu, 30 Apr 2026 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777580886; cv=none; b=job1uWYxAo/D0BbB1RGBxZC+kjdRcIyJFIU0Mibtoc91LKA0gXlH1dCP34huzjgPnk5qh0ExehfIMlx5WFc4bDTem5Ok9m8l/jiumhrRLaSAGtrV+s5Y8ZgJE/UQ2Hzg940CLjsbIf2zX+v4mCCNpwOwt+g9+hb6zEEiOp1Yi6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777580886; c=relaxed/simple;
	bh=VbLJ32Ncrl6JWXs7JHt9AhGT1rBSyUoUB8s+GDb2irY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfMS1Lf6+9RY1HJ2DSkUiUxDm5iXkjEWzmLkE8NtpzgMKwkhl/N1NZpye0eDW9+dPns6YNgXzWiYOXMJcfUnTCINZdKnB8Wo6uSMeTV6sMZt1sM954UQcvJ7XyXSsZOApjUOLJGrB6AmpCwHVNOK1/J587pq2Fjv+peQy068V5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtqAyawc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtqAyawc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D149C2BCC7;
	Thu, 30 Apr 2026 20:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777580885;
	bh=VbLJ32Ncrl6JWXs7JHt9AhGT1rBSyUoUB8s+GDb2irY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZtqAyawcC6Ai2QqIeYiI12/qEBriTGPlyw9D7stg6MmamS8iagQOxcFdhm46we+bR
	 1gZri59BZ7BdrZ5uMp8thtQipa0qd3Cq2PJMKIB2PpF1mZNSUa7o9rsy9gReepUdgG
	 t1NwpvRHP4nrEqK/kpLer/Y24k46AXHxSHNxRb14Op3CugKCBA05AAz40zbGDz0mJG
	 14W38qrAgLannhCrl7V4Wwt/zyoOjhxZNK6T0S28PiwdBJdcT8G4nHySysi44/aN7R
	 9udE6/r8ITC7d4mxRM86wD3TDdR66YugP+lOMnTlnjUDYWnRqyYIuOKbtLn2eWkgxu
	 Tu2zzFdOSExTw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v5 11/13] KVM: selftests: Allocate a dedicated guest page for x86 L2 guest stack
Date: Thu, 30 Apr 2026 20:27:48 +0000
Message-ID: <20260430202750.3924147-12-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260430202750.3924147-1-yosry@kernel.org>
References: <20260430202750.3924147-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of relying on the L1-provided stack for L2, which is usually an
array on L1's own stack, allocate a dedicated page of VM memory for the
L2 stack in vcpu_alloc_{vmx/svm}() and use that as L2's RSP in the
VMCS/VMCB instead of the L1-provided value.

Most L1 guest code does not do anything with the L2 stack other than
stuff it in RSP, so this change is transparent and the L1-provided stack
is silently ignored. The only exception is memstress nested L1 code
which puts the vCPU index on L2's stack, so update this code to use the
newly allocated stack.

L1-provided stacks will be dropped and cleaned up separately.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/include/x86/processor.h | 2 ++
 tools/testing/selftests/kvm/include/x86/svm_util.h  | 3 +++
 tools/testing/selftests/kvm/include/x86/vmx.h       | 2 ++
 tools/testing/selftests/kvm/lib/x86/memstress.c     | 5 ++---
 tools/testing/selftests/kvm/lib/x86/processor.c     | 2 +-
 tools/testing/selftests/kvm/lib/x86/svm.c           | 4 +++-
 tools/testing/selftests/kvm/lib/x86/vmx.c           | 4 +++-
 7 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 77f576ee7789d..36df2cadbc4f6 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1208,6 +1208,8 @@ struct idt_entry {
 void vm_install_exception_handler(struct kvm_vm *vm, int vector,
 			void (*handler)(struct ex_regs *));
 
+gva_t vm_alloc_stack(struct kvm_vm *vm, int nr_pages);
+
 /*
  * Exception fixup morphs #DE to an arbitrary magic vector so that '0' can be
  * used to signal "no expcetion".
diff --git a/tools/testing/selftests/kvm/include/x86/svm_util.h b/tools/testing/selftests/kvm/include/x86/svm_util.h
index 6c013eb838beb..3b1cc484fba1c 100644
--- a/tools/testing/selftests/kvm/include/x86/svm_util.h
+++ b/tools/testing/selftests/kvm/include/x86/svm_util.h
@@ -28,6 +28,9 @@ struct svm_test_data {
 	void *msr_hva;
 	u64 msr_gpa;
 
+	/* Stack */
+	void *stack; /* gva */
+
 	/* NPT */
 	u64 ncr3_gpa;
 };
diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 90fffaf915958..1dcb9b86d33d3 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -524,6 +524,8 @@ struct vmx_pages {
 	u64 apic_access_gpa;
 	void *apic_access;
 
+	void *stack;
+
 	u64 eptp_gpa;
 };
 
diff --git a/tools/testing/selftests/kvm/lib/x86/memstress.c b/tools/testing/selftests/kvm/lib/x86/memstress.c
index 61cf952cd2dc2..fa07ef037cad1 100644
--- a/tools/testing/selftests/kvm/lib/x86/memstress.c
+++ b/tools/testing/selftests/kvm/lib/x86/memstress.c
@@ -43,7 +43,7 @@ static void l1_vmx_code(struct vmx_pages *vmx, u64 vcpu_id)
 	GUEST_ASSERT(ept_1g_pages_supported());
 
 	rsp = &l2_guest_stack[L2_GUEST_STACK_SIZE - 1];
-	*rsp = vcpu_id;
+	*(u64 *)vmx->stack = vcpu_id;
 	prepare_vmcs(vmx, memstress_l2_guest_entry, rsp);
 
 	GUEST_ASSERT(!vmlaunch());
@@ -56,9 +56,8 @@ static void l1_svm_code(struct svm_test_data *svm, u64 vcpu_id)
 	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	unsigned long *rsp;
 
-
 	rsp = &l2_guest_stack[L2_GUEST_STACK_SIZE - 1];
-	*rsp = vcpu_id;
+	*(u64 *)svm->stack = vcpu_id;
 	generic_svm_setup(svm, memstress_l2_guest_entry, rsp);
 
 	run_guest(svm->vmcb, svm->vmcb_gpa);
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 94a1cadb2b26b..cf59ffed45b74 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -778,7 +778,7 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 		REPORT_GUEST_ASSERT(uc);
 }
 
-static gva_t vm_alloc_stack(struct kvm_vm *vm, int nr_pages)
+gva_t vm_alloc_stack(struct kvm_vm *vm, int nr_pages)
 {
 	int size = nr_pages * getpagesize();
 	gva_t stack_gva;
diff --git a/tools/testing/selftests/kvm/lib/x86/svm.c b/tools/testing/selftests/kvm/lib/x86/svm.c
index 3b01605ab016c..4e9c37f8d1a61 100644
--- a/tools/testing/selftests/kvm/lib/x86/svm.c
+++ b/tools/testing/selftests/kvm/lib/x86/svm.c
@@ -46,6 +46,8 @@ vcpu_alloc_svm(struct kvm_vm *vm, gva_t *p_svm_gva)
 	svm->msr_gpa = addr_gva2gpa(vm, (uintptr_t)svm->msr);
 	memset(svm->msr_hva, 0, getpagesize());
 
+	svm->stack = (void *)vm_alloc_stack(vm, 1);
+
 	if (vm->stage2_mmu.pgd_created)
 		svm->ncr3_gpa = vm->stage2_mmu.pgd;
 
@@ -122,7 +124,7 @@ void generic_svm_setup(struct svm_test_data *svm, void *guest_rip, void *guest_r
 	ctrl->msrpm_base_pa = svm->msr_gpa;
 
 	vmcb->save.rip = (u64)guest_rip;
-	vmcb->save.rsp = (u64)guest_rsp;
+	vmcb->save.rsp = (u64)svm->stack;
 	guest_regs.rdi = (u64)svm;
 
 	if (svm->ncr3_gpa) {
diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
index 67642759e4a05..81fe85cf22e8f 100644
--- a/tools/testing/selftests/kvm/lib/x86/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
@@ -116,6 +116,8 @@ vcpu_alloc_vmx(struct kvm_vm *vm, gva_t *p_vmx_gva)
 	vmx->vmwrite_gpa = addr_gva2gpa(vm, (uintptr_t)vmx->vmwrite);
 	memset(vmx->vmwrite_hva, 0, getpagesize());
 
+	vmx->stack = (void *)vm_alloc_stack(vm, 1);
+
 	if (vm->stage2_mmu.pgd_created)
 		vmx->eptp_gpa = vm->stage2_mmu.pgd;
 
@@ -370,7 +372,7 @@ void prepare_vmcs(struct vmx_pages *vmx, void *guest_rip, void *guest_rsp)
 {
 	init_vmcs_control_fields(vmx);
 	init_vmcs_host_state();
-	init_vmcs_guest_state(guest_rip, guest_rsp);
+	init_vmcs_guest_state(guest_rip, vmx->stack);
 }
 
 bool kvm_cpu_has_ept(void)
-- 
2.54.0.545.g6539524ca2-goog

