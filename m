Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5DF3F54CE
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374326; cv=none; b=To6tvlua4Xc8JC24vwqrSmnuu3s2v9GfPmz8J7NDbV9eABJL3Cbkyr07lJHBrQ7/UrYRmkLfLz5uSmQXK9WiEUI0E7HMcKQKYI6bYKt2bwhQunlFoPbvZn6S8K9EJxtg/BSvZuJNvhudrfk3ZKE+wFkouVBwARoFu5uGiyTYNFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374326; c=relaxed/simple;
	bh=cD9DIH7+ELj6GiyYjRm70PO91o/6JXizcPfqfiteNT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujP4xav3jPOLj0mLgwHz8WW8QQ0NBVo/DxmpJ2zPcKnPvYzipkwEPiRZY3l+RbFLwybD+aJs+oE37l6CISlsznJz98nPdZCaDsAYCbi8yfTc39mBAyqHtC8p93GSizpIbjYWydjCMGpbqd4fbFrULvd+aXLpZs385eTK8uw4HlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Umc3INOG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Umc3INOG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGRofkCiZMBgwi9NrIcS60E9J22RIyMII4UU2DpGcKc=;
	b=Umc3INOG2EGbcmMaxcSVeOkQtfoxkc7Bx/9CCdgM1BLLce7N59rvxs2Vs3NUuasIDP3ICu
	eXraIKSMA8K6QP0yhSmOWEWwHlHGdkayMiF8eefwumjqpfngvS1wwWZE8Lt8pjxPeQYlB0
	DznJSjS/IVaGK6n1sK3WZJ8zuStmAdI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-YHHsoIsmPxGQjrM6mP2Jxw-1; Tue,
 28 Apr 2026 07:05:18 -0400
X-MC-Unique: YHHsoIsmPxGQjrM6mP2Jxw-1
X-Mimecast-MFC-AGG-ID: YHHsoIsmPxGQjrM6mP2Jxw_1777374316
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B38818001F7;
	Tue, 28 Apr 2026 11:05:16 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC465180047F;
	Tue, 28 Apr 2026 11:05:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Binbin Wu <binbin.wu@linux.intel.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 8/8] KVM: VMX: replace vmx_spec_ctrl_restore_host with RESTORE_HOST_SPEC_CTRL_BODY
Date: Tue, 28 Apr 2026 07:05:07 -0400
Message-ID: <20260428110507.11248-9-pbonzini@redhat.com>
In-Reply-To: <20260428110507.11248-1-pbonzini@redhat.com>
References: <20260428110507.11248-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Reuse the same assembly as SVM, just with alternatives instead
of cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS).

Note that Intel does need an LFENCE with eIBRS, unlike AMD's AutoIBRS.
However, it is not needed for X86_FEATURE_KERNEL_IBRS because there
are no conditional branches between FILL_RETURN_BUFFER and ret.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmenter.h     |  9 +++++++--
 arch/x86/kvm/vmx/vmenter.S | 28 ++++++++++++++++++++++------
 arch/x86/kvm/vmx/vmx.c     | 25 -------------------------
 arch/x86/kvm/vmx/vmx.h     |  1 -
 4 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kvm/vmenter.h b/arch/x86/kvm/vmenter.h
index 73f3adc301d9..ba3f71449c62 100644
--- a/arch/x86/kvm/vmenter.h
+++ b/arch/x86/kvm/vmenter.h
@@ -55,7 +55,12 @@
 #ifdef CONFIG_X86_64
 	mov PER_CPU_VAR(x86_spec_ctrl_current), %rdx
 	cmp \guest_spec_ctrl, %rdx
-	je \label
+	/*
+	 * For legacy IBRS, the IBRS bit always needs to be written after
+	 * transitioning from a less privileged predictor mode, regardless of
+	 * whether the guest/host values differ.
+	 */
+	ALTERNATIVE __stringify(je \label), "", X86_FEATURE_KERNEL_IBRS
 	movl %edx, %eax
 	shr $32, %rdx
 #else
@@ -66,7 +71,7 @@
 	mov 4 + \guest_spec_ctrl, %edi
 	xor %edx, %edi
 	or %edi, %esi
-	je \label
+	ALTERNATIVE __stringify(je \label), "", X86_FEATURE_KERNEL_IBRS
 #endif
 	wrmsr
 .endm
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 7dd9bac0e454..0c95dc5bc01d 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -105,9 +105,9 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	 * Unlike AMD there's no V_SPEC_CTRL here, so do not leave the body
 	 * out of line.  Clobbers RAX, RCX, RDX, RSI.
 	 */
-	ALTERNATIVE "jmp .Lspec_ctrl_done", "", X86_FEATURE_MSR_SPEC_CTRL
-	RESTORE_GUEST_SPEC_CTRL_BODY VMX_spec_ctrl(%_ASM_DI), .Lspec_ctrl_done
-.Lspec_ctrl_done:
+	ALTERNATIVE "jmp .Lspec_ctrl_guest_done", "", X86_FEATURE_MSR_SPEC_CTRL
+	RESTORE_GUEST_SPEC_CTRL_BODY VMX_spec_ctrl(%_ASM_DI), .Lspec_ctrl_guest_done
+.Lspec_ctrl_guest_done:
 
 	/*
 	 * Since vmentry is serializing on affected CPUs, there's no need for
@@ -252,16 +252,32 @@ SYM_INNER_LABEL_ALIGN(vmx_vmexit, SYM_L_GLOBAL)
 	FILL_RETURN_BUFFER %_ASM_CX, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_VMEXIT,\
 			   X86_FEATURE_RSB_VMEXIT_LITE
 
-	pop %_ASM_ARG2	/* @flags */
-	pop %_ASM_ARG1	/* @vmx */
+	/* Clobbers RAX, RCX, RDX, RSI.  */
+	ALTERNATIVE "jmp .Lspec_ctrl_host_done", "", X86_FEATURE_MSR_SPEC_CTRL
+	mov WORD_SIZE(%_ASM_SP), %_ASM_DI
+	RESTORE_HOST_SPEC_CTRL_BODY VMX_spec_ctrl(%_ASM_DI), (%_ASM_SP), .Lspec_ctrl_host_done
+.Lspec_ctrl_host_done:
 
-	call vmx_spec_ctrl_restore_host
+	/*
+	 * Halt speculation past a conditional wrmsr.  Intel's eIBRS
+	 * guarantees that the guest cannot control the RSB "once IBRS is
+	 * set", but in the eIBRS case speculative execution past the 'je'
+	 * can go all the way to the RET below while MSR_IA32_SPEC_CTRL
+	 * still holds the guest value.
+	 */
+	ALTERNATIVE_2 "", "lfence", X86_FEATURE_MSR_SPEC_CTRL, \
+		"", X86_FEATURE_KERNEL_IBRS
 
 	CLEAR_BRANCH_HISTORY_VMEXIT
 
 	/* Put return value in AX */
 	mov %_ASM_BX, %_ASM_AX
 
+	/* Pop our saved arguments from the stack */
+	pop %_ASM_BX
+	pop %_ASM_BX
+
+	/* ... and then the callee-save registers */
 	pop %_ASM_BX
 #ifdef CONFIG_X86_64
 	pop %r12
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a8039b0f9392..b033f611fa04 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7388,31 +7388,6 @@ void noinstr vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_rsp)
 	}
 }
 
-void noinstr vmx_spec_ctrl_restore_host(struct vcpu_vmx *vmx,
-					unsigned int flags)
-{
-	u64 hostval = this_cpu_read(x86_spec_ctrl_current);
-
-	if (!cpu_feature_enabled(X86_FEATURE_MSR_SPEC_CTRL))
-		return;
-
-	if (flags & KVM_ENTER_SAVE_SPEC_CTRL)
-		vmx->spec_ctrl = native_rdmsrq(MSR_IA32_SPEC_CTRL);
-
-	/*
-	 * If the guest/host SPEC_CTRL values differ, restore the host value.
-	 *
-	 * For legacy IBRS, the IBRS bit always needs to be written after
-	 * transitioning from a less privileged predictor mode, regardless of
-	 * whether the guest/host values differ.
-	 */
-	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) ||
-	    vmx->spec_ctrl != hostval)
-		native_wrmsrq(MSR_IA32_SPEC_CTRL, hostval);
-
-	barrier_nospec();
-}
-
 static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu,
 					     bool force_immediate_exit)
 {
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index be6a1dc2f69f..f62007a5c2a7 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -367,7 +367,6 @@ void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu);
 struct vmx_uret_msr *vmx_find_uret_msr(struct vcpu_vmx *vmx, u32 msr);
 void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu);
 void vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_rsp);
-void vmx_spec_ctrl_restore_host(struct vcpu_vmx *vmx, unsigned int flags);
 unsigned int __vmx_vcpu_enter_flags(struct vcpu_vmx *vmx);
 bool __vmx_vcpu_run(struct vcpu_vmx *vmx, unsigned int flags);
 void vmx_ept_load_pdptrs(struct kvm_vcpu *vcpu);
-- 
2.52.0

