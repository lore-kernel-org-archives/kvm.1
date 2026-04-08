Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C17A3DA5B4
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672549; cv=none; b=g8A69prP8VkjPDNtOgs26WksvabxqgHsDzw1jtIlFvXg/jJ9uEsErLfqzPT4Q7BHAS65Wii0BjcVd2A7k2f6esZRb4LfF4Y04brYvEhjypl6QgamqJN4wLf7dpe1y6X1zADYQKmkprnT48Et3vq1i7I6b308jrAHCidLL+gwxXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672549; c=relaxed/simple;
	bh=VjZ55oAqC42wXWGnGBHq1RQ1LIgCSsaaM7DWAn/XvmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qk9HCxui9RS4vP+LzWBbmFDJt65BebWgIau0GaPzH/4YK7+mrJ0znOsdre4LZ+mthjd9TSxqRVfbYSipK3bpevpBWRMomfYBVQDPWwCucKId+IEOalCodjPeBo1ez27nLBVTLcdjVp6cN8+93qXfOYhhqWQM9A02NiKXcjfmOfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EydX41j5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EydX41j5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775672547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBs0Xwd63Gm3Mbj4g9Q5otR64g/nA9BtUBYKmO4Lh2s=;
	b=EydX41j5msyFcYG6/TNagGIVv1Zzzke1yWwIrcMFnEPzdGvsXfUa/gqyn1RbgpTSYS2Txy
	ez45nIGzjJ1QYSuOmH0uZtK5eP9/MzQefxEQJeEnGdfZKbhjI+RC5kfZznJsDsl8LQ4/mN
	7dKDPZuDxVIaGu91FS2x7/+uGPfwSmo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-5P5W8TevOgGn84fv3KjWqw-1; Wed,
 08 Apr 2026 14:22:22 -0400
X-MC-Unique: 5P5W8TevOgGn84fv3KjWqw-1
X-Mimecast-MFC-AGG-ID: 5P5W8TevOgGn84fv3KjWqw_1775672540
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AF9D1956053;
	Wed,  8 Apr 2026 18:22:20 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D82751955D6B;
	Wed,  8 Apr 2026 18:22:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	chang.seok.bae@intel.com
Subject: [PATCH 7/7] KVM: VMX: replace vmx_spec_ctrl_restore_host with RESTORE_HOST_SPEC_CTRL_BODY
Date: Wed,  8 Apr 2026 14:22:13 -0400
Message-ID: <20260408182213.522713-8-pbonzini@redhat.com>
In-Reply-To: <20260408182213.522713-1-pbonzini@redhat.com>
References: <20260408182213.522713-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Reuse the same assembly as SVM, just with alternatives instead
of cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS).

Due to the dearth of registers in 32-bit x86, save/restore %eax
across the restoring sequence, keeping it simple; the main alternative
would be to leave vmx and flags on the stack, avoiding the need to read
flags from %ebx.  It's not really measurable difference.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmenter.h     |  4 ++--
 arch/x86/kvm/vmx/vmenter.S | 25 +++++++++++++++----------
 arch/x86/kvm/vmx/vmx.c     | 25 -------------------------
 arch/x86/kvm/vmx/vmx.h     |  1 -
 4 files changed, 17 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kvm/vmenter.h b/arch/x86/kvm/vmenter.h
index e746e1328d3f..d822dafc75f7 100644
--- a/arch/x86/kvm/vmenter.h
+++ b/arch/x86/kvm/vmenter.h
@@ -55,7 +55,7 @@
 #ifdef CONFIG_X86_64
 	mov PER_CPU_VAR(x86_spec_ctrl_current), %rdx
 	cmp \guest_spec_ctrl, %rdx
-	je \label
+	ALTERNATIVE "", __stringify(je \label), X86_FEATURE_KERNEL_IBRS
 	movl %edx, %eax
 	shr $32, %rdx
 #else
@@ -66,7 +66,7 @@
 	mov 4 + \guest_spec_ctrl, %edi
 	xor %edx, %edi
 	or %edi, %esi
-	je \label
+	ALTERNATIVE "", __stringify(je \label), X86_FEATURE_KERNEL_IBRS
 #endif
 	wrmsr
 .endm
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index f3240a3ff8f5..c0574d68ff45 100644
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
@@ -252,16 +252,21 @@ SYM_INNER_LABEL_ALIGN(vmx_vmexit, SYM_L_GLOBAL)
 	FILL_RETURN_BUFFER %_ASM_CX, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_VMEXIT,\
 			   X86_FEATURE_RSB_VMEXIT_LITE
 
-	pop %_ASM_ARG2	/* @flags */
-	pop %_ASM_ARG1	/* @vmx */
-
-	call vmx_spec_ctrl_restore_host
-
-	CLEAR_BRANCH_HISTORY_VMEXIT
-
 	/* Put return value in AX */
 	mov %_ASM_BX, %_ASM_AX
 
+	pop %_ASM_BX	/* @flags */
+	pop %_ASM_DI	/* @vmx */
+
+        /* Clobbers RAX, RCX, RDX, RSI.  */
+	ALTERNATIVE "jmp .Lspec_ctrl_host_done", "", X86_FEATURE_MSR_SPEC_CTRL
+	push %_ASM_AX
+	RESTORE_HOST_SPEC_CTRL_BODY VMX_spec_ctrl(%_ASM_DI), %ebx, .Lspec_ctrl_host_done
+	pop %_ASM_AX
+.Lspec_ctrl_host_done:
+
+	CLEAR_BRANCH_HISTORY_VMEXIT
+
 	pop %_ASM_BX
 #ifdef CONFIG_X86_64
 	pop %r12
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ef0de3cc0bc2..84a5441142fc 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7497,31 +7497,6 @@ void noinstr vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_rsp)
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
index 9cb5a205f19d..fec85c739fad 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -370,7 +370,6 @@ void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu);
 struct vmx_uret_msr *vmx_find_uret_msr(struct vcpu_vmx *vmx, u32 msr);
 void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu);
 void vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_rsp);
-void vmx_spec_ctrl_restore_host(struct vcpu_vmx *vmx, unsigned int flags);
 unsigned int __vmx_vcpu_enter_flags(struct vcpu_vmx *vmx);
 bool __vmx_vcpu_run(struct vcpu_vmx *vmx, unsigned int flags);
 void vmx_ept_load_pdptrs(struct kvm_vcpu *vcpu);
-- 
2.52.0

