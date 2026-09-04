Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D814725E469
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481486; cv=none; b=FQsaNpsdZSySSRov56qot0U8LAYxh/VOHafCX3icGIL7aQcZPDIN3OVvr1LBQK5GVvoLXQP/trbr2qT5hRnnVd+XY0WvX1NDdTjuCuGT2Uuj0qKx7IZ1gEnr8Z8/hmh5Tn9irtMiBavOYN9X0qxv7gDaojbfM66Huogj5jeF++Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481486; c=relaxed/simple;
	bh=vgXQFuBJ0c3qC6re8no35X7E/n7kKg/3QaAVG1RR6lM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pSy5Tm9BYhhb4wo6p0rILWeVq+f8/PsmnQxkok0Zw+IFDNfqgKGQB1TNx8UfY6lz/BKUG9vmeTW5ktv3ivlIccfH9cmVnxiCZCGTDHi89cFd+64cqppJ6yUBfRlW0Lvr2L9aTU+W4mjpYqytwKW6W84hwi1nFlAV6NvXwOKvljQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q3J+wWjs; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3J+wWjs"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-85599cf98e5so694767b3a.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788481483; x=1789086283; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8ag8bpeoUZOOSbjWNaS/zDOOv3tyyAmOLhY6BO17Mks=;
        b=q3J+wWjs3H40orhptjf8giQ6V7S/F2L8+QfTR9QUSKDPmYvlZJMVKJJYv+aSDaubsc
         702Dlaj7DADOwQsDzmKFFARrmh9q8u2U9rPF5ehRk+FNSuPh5x+3/sIMG+CKJCKONCIC
         lEWYcS4J5f58w6YrORmxDHIXLFgwrij8hIRThG46HYJuas3Sbj4duRq2VQqF28b5TzEz
         dZpQDRABg52LN6aImNzRPJiNGru7LsQWvWlcv46pclwZkWGtonZAofrPwlu6hVGKAPvt
         qB1/iOe0lymf10vZUsDKYzX/AvG23Z7cpA6SQbpzFWEiTiKqijUURIs5/DiF7CX9J02n
         KNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788481483; x=1789086283;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8ag8bpeoUZOOSbjWNaS/zDOOv3tyyAmOLhY6BO17Mks=;
        b=Zoiv+86FrcTmL1SHsExr78nahyXjau4/aWAJ0r1ux5fn0XB4/WBg+T4lwRBqp0V3+f
         7NOAEB8yFWZwdo+9AAX4oC52XQSjCeb8sAudFnOp6WKcP4ydYANe/JUVf2DatlIinpky
         7vzk6e7pLUZ2BVr9WlcuXQjdia3LAm6pVhWkljzoJOtgJEflxCfOhE+EhSJu6YsXWQjt
         OSbGraHn/8phx84trU+EI6WCHVqpqJpxanDldb1AFHdhjzkNXUeMDFHKY2btZoSk90Hw
         v0a2cY3uJLqP02yu7nqc2IcCSn3JvcyXkt+kfpk1VJN0nKM/EGZF23BkCf+/5QenECdy
         dxTQ==
X-Gm-Message-State: AFuF++mLzapBOGEU8HafdoGR71/bm1GIBfMy1XIEoYzDE48x+gN3v0LR
	XA8cHv+TRd1mKKymaVIBblVCj9KAoCJRrJtS+IuBYfd/ICBYlPeq6IQIEXzh+fZLeBEar+U15G9
	jHinz3g==
X-Received: from pfcg1.prod.google.com ([2002:a05:6a00:23c1:b0:848:7fd6:7dec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8d8d:b0:855:eb7b:5804
 with SMTP id d2e1a72fcca58-861662d4c0fmr3948705b3a.4.1788481483050; Thu, 03
 Sep 2026 17:24:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 17:24:21 -0700
In-Reply-To: <20260904002423.3154436-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904002423.3154436-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904002423.3154436-16-seanjc@google.com>
Subject: [PATCH v4 15/17] KVM: selftests: Add __vmwrite() and use it when
 initializing optional fields.
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add __vmwrite() in anticipation of having vmwrite() assert success, and use
the "failure allowed" version in the common VMCS setup code, which is the
only code that wants to write fields that may or may not exist (although
arguably the code should check if the field exists instead of blindly
writing).

E.g. When doing initial configuration of a VMCS, the core library doesn't
want to assume secondary controls are supported, and so blindly does a
VMWRITE and pivots on success/failure.

All usage of vmwrite() outside of common setup already asserts success, or
100% relies on VMWRITE succeeding in order for the test to function
correctly.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86/vmx.h |  7 ++++++-
 tools/testing/selftests/kvm/lib/x86/vmx.c     | 18 +++++++++---------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 1419043b41dd..40111db580a8 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -414,7 +414,7 @@ static inline u64 vmreadz(u64 encoding)
 	return value;
 }
 
-static inline int vmwrite(u64 encoding, u64 value)
+static __always_inline int __vmwrite(u64 encoding, u64 value)
 {
 	u8 ret;
 
@@ -429,6 +429,11 @@ static inline int vmwrite(u64 encoding, u64 value)
 	return ret;
 }
 
+static inline int vmwrite(u64 encoding, u64 value)
+{
+	return __vmwrite(encoding, value);
+}
+
 static inline u32 vmcs_revision(void)
 {
 	return rdmsr(MSR_IA32_VMX_BASIC);
diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
index 1a8515de42b0..b6bd9423e676 100644
--- a/tools/testing/selftests/kvm/lib/x86/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
@@ -252,7 +252,7 @@ static inline void init_vmcs_control_fields(struct vmx_pages *vmx)
 	u32 sec_exec_ctl = 0;
 
 	vmwrite(VIRTUAL_PROCESSOR_ID, 0);
-	vmwrite(POSTED_INTR_NV, 0);
+	__vmwrite(POSTED_INTR_NV, 0);
 
 	vmwrite(PIN_BASED_VM_EXEC_CONTROL, rdmsr(MSR_IA32_VMX_TRUE_PINBASED_CTLS));
 
@@ -269,7 +269,7 @@ static inline void init_vmcs_control_fields(struct vmx_pages *vmx)
 		sec_exec_ctl |= SECONDARY_EXEC_ENABLE_EPT;
 	}
 
-	if (!vmwrite(SECONDARY_VM_EXEC_CONTROL, sec_exec_ctl))
+	if (!__vmwrite(SECONDARY_VM_EXEC_CONTROL, sec_exec_ctl))
 		vmwrite(CPU_BASED_VM_EXEC_CONTROL,
 			rdmsr(MSR_IA32_VMX_TRUE_PROCBASED_CTLS) | CPU_BASED_ACTIVATE_SECONDARY_CONTROLS);
 	else {
@@ -289,16 +289,16 @@ static inline void init_vmcs_control_fields(struct vmx_pages *vmx)
 		VM_ENTRY_IA32E_MODE);		  /* 64-bit guest */
 	vmwrite(VM_ENTRY_MSR_LOAD_COUNT, 0);
 	vmwrite(VM_ENTRY_INTR_INFO_FIELD, 0);
-	vmwrite(TPR_THRESHOLD, 0);
+	__vmwrite(TPR_THRESHOLD, 0);
 
 	vmwrite(CR0_GUEST_HOST_MASK, 0);
 	vmwrite(CR4_GUEST_HOST_MASK, 0);
 	vmwrite(CR0_READ_SHADOW, get_cr0());
 	vmwrite(CR4_READ_SHADOW, get_cr4());
 
-	vmwrite(MSR_BITMAP, vmx->msr_gpa);
-	vmwrite(VMREAD_BITMAP, vmx->vmread_gpa);
-	vmwrite(VMWRITE_BITMAP, vmx->vmwrite_gpa);
+	__vmwrite(MSR_BITMAP, vmx->msr_gpa);
+	__vmwrite(VMREAD_BITMAP, vmx->vmread_gpa);
+	__vmwrite(VMWRITE_BITMAP, vmx->vmwrite_gpa);
 }
 
 /*
@@ -356,8 +356,8 @@ static inline void init_vmcs_guest_state(void *rip, void *rsp)
 	vmwrite(GUEST_GS_SELECTOR, vmreadz(HOST_GS_SELECTOR));
 	vmwrite(GUEST_LDTR_SELECTOR, 0);
 	vmwrite(GUEST_TR_SELECTOR, vmreadz(HOST_TR_SELECTOR));
-	vmwrite(GUEST_INTR_STATUS, 0);
-	vmwrite(GUEST_PML_INDEX, 0);
+	__vmwrite(GUEST_INTR_STATUS, 0);
+	__vmwrite(GUEST_PML_INDEX, 0);
 
 	vmwrite(VMCS_LINK_POINTER, -1ll);
 	vmwrite(GUEST_IA32_DEBUGCTL, 0);
@@ -391,7 +391,7 @@ static inline void init_vmcs_guest_state(void *rip, void *rsp)
 	vmwrite(GUEST_INTERRUPTIBILITY_INFO, 0);
 	vmwrite(GUEST_ACTIVITY_STATE, 0);
 	vmwrite(GUEST_SYSENTER_CS, vmreadz(HOST_IA32_SYSENTER_CS));
-	vmwrite(VMX_PREEMPTION_TIMER_VALUE, 0);
+	__vmwrite(VMX_PREEMPTION_TIMER_VALUE, 0);
 
 	vmwrite(GUEST_CR0, vmreadz(HOST_CR0));
 	vmwrite(GUEST_CR3, vmreadz(HOST_CR3));
-- 
2.55.0.979.g7e5102b832-goog

