Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897156;
	b=l84o0K1ZPMw6H4MAgxDqwTT0LZySLJMA3Q4Purhzf/IHsTlKjloTS83mItzZL7YT/l9G
	 uU6mM9gzGFCvq79sxAXpVPaLeanBgalqG9z6Pnm0H+3wBmTzvxqKH0tWtRbP2eujW6+og
	 o2EMdD950q0utplZPgMqfb08u4XYwWOJs7LnrryWY/kaFzUx9xf6PQHFvLiLWoMmhMrDl
	 GmKsQv7IbV7N3TTbjRT6ejqvzDhIsmDPPh/aU5QPMRTiSsPT9uYyrD7brhkS2vENa/zHh
	 UZfMIRb2CvHVzN5m+JpL2fQ7u9oS1QJLXzx6AcTfDpCa94FKtKj2n/+4TpPOf16seZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897156;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=6cMbNEfCZHCXTYTBYq41QfLsnnhf9JCUZDI2WvPKG2g=;
	b=b+EOfIJNmgKOjRi+drrUAgjvQqyo0YPmdvvly4X3aG39Mw8tj19y1v5riuS3O6/tZ4EB
	 TRKONLtixKYzlw9Ix61LLoir/kSpe3eqdGacVr85hGot13qgQXs3QaUbVxetE83EF12H3
	 kbM+NX/6onNb/p9pSip+TwQI+fMpTJIYWcw4tafyov5gL+6xM49EwcnGFybA0jW1hF+oo
	 a3t0HtEcLhvVKkhCR4whPcSlQ1EiCxnh/sJGTesel3zjc7/D16UkhBGPKiNB+XdT9+B6X
	 WeMarzUgsR4N7V6WASMqEDAByZVI2OocTDWoMFlojWKtonJnCFTuHMgY+xNUReMqCRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fQ5ExafS;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE62606EE86
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 16:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFE62606EE86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fQ5ExafS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793897154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cMbNEfCZHCXTYTBYq41QfLsnnhf9JCUZDI2WvPKG2g=;
	b=fQ5ExafSjIV/m4hBMkUgJslH2gpPYpGO1OAyaAuxt+OTgZ/DJ0y7l1hY4BT4lMauEfZozk
	T7/Jb6UVQiRr5UwhLVIkWpcl0Q7epjqoJxt6IuDXHlyWPC/eBIYpHKR09IIQDCs8XQGyAs
	1MPQkI61xI9q5k05WQPzLJlnv/HydBs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-0h0h2SQ3PpG4-inxMJa1Yg-1; Thu,
 05 Nov 2026 11:45:49 -0500
X-MC-Unique: 0h0h2SQ3PpG4-inxMJa1Yg-1
X-Mimecast-MFC-AGG-ID: 0h0h2SQ3PpG4-inxMJa1Yg_1793897148
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE85A1955D69;
	Thu,  5 Nov 2026 16:45:47 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B49C41956088;
	Thu,  5 Nov 2026 16:45:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Hillf Danton <hdanton@sina.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Harry Yoo <harry@kernel.org>,
	syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com
Subject: [PATCH 5/5] KVM: x86: move asynchronous page fault handling to vcpu_enter_guest()
Date: Thu,  5 Nov 2026 17:45:31 +0100
Message-ID: <20261105164531.313849-6-pbonzini@redhat.com>
In-Reply-To: <20261105164531.313849-1-pbonzini@redhat.com>
References: <20261105164531.313849-1-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Fully handle the PV async #PF in vcpu_enter_guest().  This has several
advantages; first of all nested async #PF code (which has more to do
with host page faults than nested MMU page faults) is moved away from
MMU page fault handling, second host_apf_flags is hidden (though only
partly so, because it is replaced by EXIT_FASTPATH_APF) and the node
put on the stack.

Reported-by: syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com
Link: https://patch.msgid.link/auqAsEk9o6buPNiR@google.com
Co-authored-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  6 +++---
 arch/x86/kvm/mmu.h              | 21 ++++++++++++---------
 arch/x86/kvm/mmu/mmu.c          | 21 ++-------------------
 arch/x86/kvm/svm/nested.c       |  4 ----
 arch/x86/kvm/svm/svm.c          | 14 +++++++-------
 arch/x86/kvm/vmx/main.c         | 20 +++++++++++---------
 arch/x86/kvm/vmx/nested.c       |  3 +--
 arch/x86/kvm/vmx/vmx.c          |  6 +-----
 arch/x86/kvm/x86.c              | 17 +++++++++++++++--
 9 files changed, 52 insertions(+), 60 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 93170c70a17c..f72028efe2ca 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -209,6 +209,7 @@ enum exit_fastpath_completion {
 	EXIT_FASTPATH_REENTER_GUEST,
 	EXIT_FASTPATH_EXIT_HANDLED,
 	EXIT_FASTPATH_EXIT_USERSPACE,
+	EXIT_FASTPATH_APF,
 };
 typedef enum exit_fastpath_completion fastpath_t;
 
@@ -950,8 +951,6 @@ struct kvm_vcpu_arch {
 		u64 msr_int_val; /* MSR_KVM_ASYNC_PF_INT */
 		u16 vec;
 		u32 id;
-		u32 host_apf_flags;
-		struct kvm_task_sleep_node host_apf_node;
 		bool pageready_pending;
 	} apf;
 
@@ -1681,7 +1680,8 @@ struct kvm_x86_ops {
 			       struct x86_instruction_info *info,
 			       enum x86_intercept_stage stage,
 			       struct x86_exception *exception);
-	fastpath_t (*handle_exit_irqoff)(struct kvm_vcpu *vcpu);
+	fastpath_t (*handle_exit_irqoff)(struct kvm_vcpu *vcpu,
+					 struct kvm_task_sleep_node *host_apf_node);
 
 	void (*update_cpu_dirty_logging)(struct kvm_vcpu *vcpu, bool enable);
 
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 3cb2616d88ac..c01a1cf70d77 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -163,17 +163,20 @@ bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu);
 int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 				u64 fault_address, char *insn, int insn_len);
 
-static inline void kvm_handle_host_apf_irqoff(struct kvm_vcpu *vcpu, u32 token)
+static inline fastpath_t kvm_handle_host_apf_irqoff(struct kvm_task_sleep_node *host_apf_node,
+						    u32 token)
 {
-	vcpu->arch.apf.host_apf_flags = kvm_read_and_reset_apf_flags();
-	if ((vcpu->arch.apf.host_apf_flags & KVM_PV_REASON_PAGE_NOT_PRESENT) &&
-	    !kvm_async_pf_queue_task(token, &vcpu->arch.apf.host_apf_node)) {
-		/*
-		 * Nothing to do but regular page fault handling must still
-		 * be suppressed, so leave host_apf_flags nonzero.
-		 */
-		vcpu->arch.apf.host_apf_flags = KVM_PV_REASON_PAGE_READY;
+	u32 host_apf_flags = kvm_read_and_reset_apf_flags();
+
+	if (!host_apf_flags)
+		return EXIT_FASTPATH_NONE;
+
+	if (!WARN_ON_ONCE(!(host_apf_flags & KVM_PV_REASON_PAGE_NOT_PRESENT))) {
+		kvm_async_pf_queue_task(token, host_apf_node);
+		return EXIT_FASTPATH_APF;
 	}
+
+	return EXIT_FASTPATH_NONE;
 }
 
 void __kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 1f2ae73275aa..a8dfbfb83a6f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4948,9 +4948,6 @@ static int nonpaging_page_fault(struct kvm_vcpu *vcpu,
 int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 				u64 fault_address, char *insn, int insn_len)
 {
-	int r = 1;
-	u32 flags = vcpu->arch.apf.host_apf_flags;
-
 #ifndef CONFIG_X86_64
 	/* A 64-bit CR2 should be impossible on 32-bit KVM. */
 	if (KVM_BUG_ON(fault_address >> 32, vcpu->kvm))
@@ -4971,23 +4968,9 @@ int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 	BUILD_BUG_ON(lower_32_bits(PFERR_SYNTHETIC_MASK));
 
 	kvm_request_l1tf_flush_l1d();
-	if (!flags) {
-		trace_kvm_page_fault(vcpu, fault_address, error_code);
+	trace_kvm_page_fault(vcpu, fault_address, error_code);
 
-		r = kvm_mmu_page_fault(vcpu, fault_address, error_code, insn,
-				insn_len);
-	} else if (flags & KVM_PV_REASON_PAGE_NOT_PRESENT) {
-		vcpu->arch.apf.host_apf_flags = 0;
-		local_irq_disable();
-		kvm_async_pf_task_wait_schedule(&vcpu->arch.apf.host_apf_node);
-		local_irq_enable();
-	} else if (flags & KVM_PV_REASON_PAGE_READY) {
-		vcpu->arch.apf.host_apf_flags = 0;
-	} else {
-		WARN_ONCE(1, "Unexpected host async PF flags: %x\n", flags);
-	}
-
-	return r;
+	return kvm_mmu_page_fault(vcpu, fault_address, error_code, insn, insn_len);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_handle_page_fault);
 
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index af0ef678433d..36d9e39af34b 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1818,10 +1818,6 @@ int nested_svm_exit_special(struct vcpu_svm *svm)
 		if (svm->vmcb01.ptr->control.intercepts[INTERCEPT_EXCEPTION] &
 		    excp_bits)
 			return NESTED_EXIT_HOST;
-		else if (exit_code == SVM_EXIT_EXCP_BASE + PF_VECTOR &&
-			 svm->vcpu.arch.apf.host_apf_flags)
-			/* Trap async PF even if not shadowing */
-			return NESTED_EXIT_HOST;
 		break;
 	}
 	case SVM_EXIT_VMMCALL:
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b720c1ff7134..16d6947d981b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3815,7 +3815,6 @@ static void svm_get_entry_info(struct kvm_vcpu *vcpu, u32 *intr_info,
 		*error_code = control->event_inj_err;
 	else
 		*error_code = 0;
-
 }
 
 static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
@@ -3834,7 +3833,7 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	if (unlikely(exit_fastpath == EXIT_FASTPATH_EXIT_USERSPACE))
 		return 0;
 
-	if (is_guest_mode(vcpu)) {
+	if (is_guest_mode(vcpu) && exit_fastpath != EXIT_FASTPATH_APF) {
 		int vmexit;
 
 		trace_kvm_nested_vmexit(vcpu, KVM_ISA_SVM);
@@ -4762,10 +4761,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 			       vcpu_to_pmu(vcpu)->global_ctrl);
 	}
 
-	/* if exit due to PF check for async PF */
-	if (svm->vmcb->control.exit_code == SVM_EXIT_EXCP_BASE + PF_VECTOR)
-		kvm_handle_host_apf_irqoff(vcpu, svm->vmcb->control.exit_info_2);
-
 	kvm_clear_available_registers(vcpu, SVM_REGS_LAZY_LOAD_SET);
 
 	trace_kvm_exit(vcpu, KVM_ISA_SVM);
@@ -5091,9 +5086,14 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
 	return ret;
 }
 
-static fastpath_t svm_handle_exit_irqoff(struct kvm_vcpu *vcpu)
+static fastpath_t svm_handle_exit_irqoff(struct kvm_vcpu *vcpu,
+					 struct kvm_task_sleep_node *host_apf_node)
 {
+	struct vcpu_svm *svm = to_svm(vcpu);
+
 	switch (to_svm(vcpu)->vmcb->control.exit_code) {
+	case SVM_EXIT_EXCP_BASE + PF_VECTOR:
+		return kvm_handle_host_apf_irqoff(host_apf_node, svm->vmcb->control.exit_info_2);
 	case SVM_EXIT_EXCP_BASE + MC_VECTOR:
 		svm_handle_mce(vcpu);
 		break;
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index b742e2370dd6..6efa4e0051b5 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -912,17 +912,18 @@ static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
 		rdmsrq(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
 }
 
-static void handle_exception_irqoff(struct kvm_vcpu *vcpu, u32 intr_info)
+static fastpath_t handle_exception_irqoff(struct kvm_vcpu *vcpu, u32 intr_info,
+					  struct kvm_task_sleep_node *host_apf_node)
 {
-	/* if exit due to PF check for async PF */
 	if (is_page_fault(intr_info))
-		kvm_handle_host_apf_irqoff(vcpu, vt_get_exit_qual(vcpu));
-	/* if exit due to NM, handle before interrupts are enabled */
-	else if (is_nm_fault(intr_info))
+		return kvm_handle_host_apf_irqoff(host_apf_node, vt_get_exit_qual(vcpu));
+
+	if (is_nm_fault(intr_info))
 		handle_nm_fault_irqoff(vcpu);
-	/* Handle machine checks before interrupts are enabled */
 	else if (is_machine_check(intr_info))
 		kvm_machine_check();
+
+	return EXIT_FASTPATH_NONE;
 }
 
 static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu,
@@ -941,7 +942,8 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu,
 	vcpu->arch.at_instruction_boundary = true;
 }
 
-static fastpath_t vt_handle_exit_irqoff(struct kvm_vcpu *vcpu)
+static fastpath_t vt_handle_exit_irqoff(struct kvm_vcpu *vcpu,
+					struct kvm_task_sleep_node *host_apf_node)
 {
 	if (to_vt(vcpu)->emulation_required)
 		return EXIT_FASTPATH_NONE;
@@ -951,8 +953,8 @@ static fastpath_t vt_handle_exit_irqoff(struct kvm_vcpu *vcpu)
 		handle_external_interrupt_irqoff(vcpu, vt_get_intr_info(vcpu));
 		break;
 	case EXIT_REASON_EXCEPTION_NMI:
-		handle_exception_irqoff(vcpu, vt_get_intr_info(vcpu));
-		break;
+		return handle_exception_irqoff(vcpu, vt_get_intr_info(vcpu),
+					       host_apf_node);
 	case EXIT_REASON_MCE_DURING_VMENTRY:
 		kvm_machine_check();
 		break;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 516ba03bf608..b7371c584f5a 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6501,8 +6501,7 @@ static bool nested_vmx_l0_wants_exit(struct kvm_vcpu *vcpu,
 		if (is_nmi(intr_info))
 			return true;
 		else if (is_page_fault(intr_info))
-			return vcpu->arch.apf.host_apf_flags ||
-			       vmx_need_pf_intercept(vcpu);
+			return vmx_need_pf_intercept(vcpu);
 		else if (is_debug(intr_info) &&
 			 vcpu->guest_debug &
 			 (KVM_GUESTDBG_SINGLESTEP | KVM_GUESTDBG_USE_HW_BP))
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 82eb891f684c..3b6ad75ba7e7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5396,9 +5396,6 @@ static int vmx_handle_page_fault(struct kvm_vcpu *vcpu, u32 error_code)
 {
 	unsigned long cr2 = vt_get_exit_qual(vcpu);
 
-	if (vcpu->arch.apf.host_apf_flags)
-		goto handle_pf;
-
 	/* When using EPT, KVM intercepts #PF only to detect illegal GPAs. */
 	WARN_ON_ONCE(enable_ept && !allow_smaller_maxphyaddr);
 
@@ -5429,7 +5426,6 @@ static int vmx_handle_page_fault(struct kvm_vcpu *vcpu, u32 error_code)
 		return 1;
 	}
 
-handle_pf:
 	return kvm_handle_page_fault(vcpu, error_code, cr2, NULL, 0);
 }
 
@@ -6733,7 +6729,7 @@ int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 			return 1;
 		}
 
-		if (nested_vmx_reflect_vmexit(vcpu))
+		if (exit_fastpath != EXIT_FASTPATH_APF && nested_vmx_reflect_vmexit(vcpu))
 			return 1;
 	}
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index af8cdfd81180..37e721bd2372 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8116,6 +8116,16 @@ static void kvm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
 	kvm_x86_call(update_cpu_dirty_logging)(vcpu, enable);
 }
 
+static void kvm_handle_pv_async_pf(struct kvm_task_sleep_node *n)
+{
+	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_KVM_GUEST)))
+		return;
+
+	local_irq_disable();
+	kvm_async_pf_task_wait_schedule(n);
+	local_irq_enable();
+}
+
 /*
  * Called within kvm->srcu read side.
  * Returns 1 to let vcpu_run() continue the guest execution loop without
@@ -8128,9 +8138,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	bool req_int_win =
 		dm_request_for_irq_injection(vcpu) &&
 		kvm_cpu_accept_dm_intr(vcpu);
+	struct kvm_task_sleep_node host_apf_node = {0};
 	fastpath_t exit_fastpath;
 	u64 run_flags, debug_ctl;
-
 	bool req_immediate_exit = false;
 
 	if (kvm_request_pending(vcpu)) {
@@ -8505,7 +8515,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		fpu_sync_guest_vmexit_xfd_state();
 
 	if (exit_fastpath == EXIT_FASTPATH_NONE)
-		exit_fastpath = kvm_x86_call(handle_exit_irqoff)(vcpu);
+		exit_fastpath = kvm_x86_call(handle_exit_irqoff)(vcpu, &host_apf_node);
 
 	if (vcpu->arch.guest_fpu.xfd_err)
 		wrmsrq(MSR_IA32_XFD_ERR, 0);
@@ -8567,6 +8577,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.apic_attention)
 		kvm_lapic_sync_from_vapic(vcpu);
 
+	if (exit_fastpath == EXIT_FASTPATH_APF && host_apf_node.token)
+		kvm_handle_pv_async_pf(&host_apf_node);
+
 	r = kvm_x86_call(handle_exit)(vcpu, exit_fastpath);
 	return r;
 
-- 
2.56.0

