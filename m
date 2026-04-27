Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09383B8BCC
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287546; cv=none; b=JJ6jrufq6EOTyZmbhEdiM+Nk5C1g0grKejU1TkgnKU4q7F9k3YoGTkqFHKiC8lStqee86DbtPWsr9rbfwkEHE08GC2ONcqJHD0SKQg2EXzUWC85x1er/MExD/42klA85F/+C9rJTK3qs2F8MnIs0TKG3iS1BTdNdCp2B2ZyVYd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287546; c=relaxed/simple;
	bh=gUxbtYpLBqTi6jkQst+W2GlQD+knnq5rafYXDm4qv6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lUX/1TfoxVDdGur0/HBCtnvFZYq66eq3j874KpfHbSwrYYzSmw4BwfUZ2ergt+c83e4zXBPPR7G/76ey4Q8L/QkTd6x+0j5fzRKubQrRd3kP0pCzwy1oJocG5iay28rWRLHm3n8MV+dJa2HgqAusvoSd+AzW5bz7kb0wgjBeT8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7jCFz/n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7jCFz/n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777287544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LtX7Uz7fsFbBT4eg9fqV4rJbkrEVsBdTPv6NkY0evF4=;
	b=S7jCFz/nE9zgCeMUT1tC5KW1Cp9Q1XNzVcoRCcj9klAHdF+txgiScz3d3d5Ar4AFfRKUud
	7PhG0xls8SctG9kDmOKsID+4UeVdWhrXGQdQxRXH990yDGyqZWZz522R6D41ibbLBN6V4q
	kRTNe45Zn4tdPTGeTA3F0x6If+KfBgQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-PE3EMn8mPxmTC5jH0nwL3A-1; Mon,
 27 Apr 2026 06:58:58 -0400
X-MC-Unique: PE3EMn8mPxmTC5jH0nwL3A-1
X-Mimecast-MFC-AGG-ID: PE3EMn8mPxmTC5jH0nwL3A_1777287537
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DC7D1956089;
	Mon, 27 Apr 2026 10:58:57 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5862B180047F;
	Mon, 27 Apr 2026 10:58:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Binbin Wu <binbin.wu@linux.intel.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH v2 7/7] KVM: VMX: replace vmx_spec_ctrl_restore_host with RESTORE_HOST_SPEC_CTRL_BODY
Date: Mon, 27 Apr 2026 06:58:48 -0400
Message-ID: <20260427105848.44865-8-pbonzini@redhat.com>
In-Reply-To: <20260427105848.44865-1-pbonzini@redhat.com>
References: <20260427105848.44865-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmenter.h     |  9 +++++++--
 arch/x86/kvm/vmx/vmenter.S | 20 +++++++++++++-------
 arch/x86/kvm/vmx/vmx.c     | 25 -------------------------
 arch/x86/kvm/vmx/vmx.h     |  1 -
 4 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kvm/vmenter.h b/arch/x86/kvm/vmenter.h
index 84951e186859..93db912eef44 100644
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
index 7dd9bac0e454..294407dfc24f 100644
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
@@ -252,16 +252,22 @@ SYM_INNER_LABEL_ALIGN(vmx_vmexit, SYM_L_GLOBAL)
 	FILL_RETURN_BUFFER %_ASM_CX, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_VMEXIT,\
 			   X86_FEATURE_RSB_VMEXIT_LITE
 
-	pop %_ASM_ARG2	/* @flags */
-	pop %_ASM_ARG1	/* @vmx */
-
-	call vmx_spec_ctrl_restore_host
+	/* Clobbers RAX, RCX, RDX, RSI.  */
+	ALTERNATIVE "jmp .Lspec_ctrl_host_done", "", X86_FEATURE_MSR_SPEC_CTRL
+	mov WORD_SIZE(%_ASM_SP), %_ASM_DI
+	RESTORE_HOST_SPEC_CTRL_BODY VMX_spec_ctrl(%_ASM_DI), (%_ASM_SP), .Lspec_ctrl_host_done
+.Lspec_ctrl_host_done:
 
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

