Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4ED3F44ED
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 22:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884003; cv=none; b=LpJPhaLUGYzzmH+ezMa6LzoYfS50qJbKQEG7ZTApOTQc6A3BMCPWJD8N2/Ob6MGyR0X8YQgNCWDmmky5FoTWFFJ/HgIwAkAa+plw66Z/yyjjZURcdAq0uQCbfCZBpIk2Oi7/P1ayvHjaIQYqi59rCoMu23oIhPUCSNxr4rhvvBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884003; c=relaxed/simple;
	bh=B447E8limPc0QOoSI1DQ4xmk/fkShF7WyRbD147IadQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GkHbV6QIntELLZlb+POSbB0dxtfzduUoXZKwgI9j6XmGwkLX/BmvTX+ic/Xx7nKG73O6WcQmX67OIAaNHXauJtS17VFDVW/mutjBdme0xv2Z/HUPBOCI/8I7CoRrlHCzX9EYOGIb9jmkcxIu4jDCHyQjYHfyHyj3CagAFQueR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pp+JZXs6; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pp+JZXs6"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c828acf7c1dso414203a12.3
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 15:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778884001; x=1779488801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Sk8y2wck2NRyTYqUeGYg8msfOIZSAz1otVEKAu16ZpE=;
        b=pp+JZXs6XKWWdQUX5LI8qeOAbgDpxyh7ry3R+0KpY+inNZXhRtKX8MP1YfuaUfumYR
         HKB0gsGtpdndZTICU8PHQvbbbMP5Xv8D+bwTNgzxo0NNR7WH/L+xfChF+rCnIYto/RBr
         ejkJrsL7WD6KuVWNZX0hmTVhvqCfscxOyKlG9DbfESJrHudZFxUlk2yLXDmVPePOXMwk
         WrpEU//NeuX5nZ7tUJdP4FyB8ffeCcYls2Gsit9XlmoQx2JdY59uLcTZN9ngCFBmz00S
         nd+skQ56BH1Tjakj2DdhZH5girX+vnKV/DU4A0VhCVkaaF86wDoxrgqs3oP1cDcq8T8D
         yVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884001; x=1779488801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sk8y2wck2NRyTYqUeGYg8msfOIZSAz1otVEKAu16ZpE=;
        b=WRV9Wolmdw3vxzBLJvTZLqaC5yMYQ6/SPCAsLaiU5V9hHKmalJdKzjTZlbrz8MmpjD
         SkQm+J+CK0uAMPLFCpEoS+CvCD4YL+yvCFiwwJpPeLOGuiDRW0IoEgMeUhlaQ/UuQ4/i
         ZUZSaOL8GaJot6IKwBwlLqjOqfPuTsBf97djEBhkzEjgtNVi+XBJ34UG/1gwfX0rsrsX
         zXU12vMNOez0If7QZ9vF5mt0whOBQOktkgzcI5RmDlX0O3MXB4YqurxIwYnydIEq4lXr
         98xr9M5ILTEl8wS0IH9Ss+V7e78RcJRg+x57rfONewv2Ln22rpibCdre8Ui0jBJnUwXW
         nHqA==
X-Gm-Message-State: AOJu0YzX0q274zEZui1X6cSrEjU3AWg0yVBwwHsLVDOpIjRGB3tzveIb
	L9lCuLoPEidpJiN1YziRfpnO7cVtr6Z61dNQpB1F+z7xNhhgDcElPDywoQCrSK66VMKY4Gv3ByO
	+XUhQKQ==
X-Received: from pfblg26.prod.google.com ([2002:a05:6a00:709a:b0:82f:6e26:770b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:390f:b0:83a:3135:edbd
 with SMTP id d2e1a72fcca58-83f33aee90amr6423350b3a.7.1778884000868; Fri, 15
 May 2026 15:26:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 15:26:29 -0700
In-Reply-To: <20260515222638.1949982-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515222638.1949982-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515222638.1949982-2-seanjc@google.com>
Subject: [PATCH v3 01/10] KVM: VMX: Refresh GUEST_PENDING_DBG_EXCEPTIONS.BS on
 all injected #DBs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

Move KVM's stuffing of GUEST_PENDING_DBG_EXCEPTIONS.BS when RFLAGS.TF=1 and
MOV/POP SS or STI blocking is active into the exception injection code so
that KVM fixes up the VMCS for all injected #DBs, not only those that are
reflected back into the guest after #DB interception.  E.g. if KVM queues
a #DB in the emulator, or more importantly if userspace does save/restore
exactly on the #DB+shadow boundary, then KVM needs to massage the VMCS to
avoid the VM-Entry consistency check.

Opportunistically update the wording of the comment to describe the
behavior as a workaround of flawed CPU behavior/architecture, to make it
clear that the *only* thing KVM is doing is fudging around a consistency
check.  Per the SDM:

  There are no pending debug exceptions after VM entry if any of the
  following are true:

    * The VM entry is vectoring with one of the following interruption
      types: external interrupt, non-maskable interrupt (NMI), hardware
      exception, or privileged software exception.

I.e. forcing GUEST_PENDING_DBG_EXCEPTIONS.BS does *not* impact guest-
visible behavior.

Fixes: b9bed78e2fa9 ("KVM: VMX: Set vmcs.PENDING_DBG.BS on #DB in STI/MOVSS blocking shadow")
Cc: stable@vger.kernel.org
Reported-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Closes: https://lore.kernel.org/all/b1a294bc9ed4dae532474a5dc6c8cb6e5962de7c.1757416809.git.houwenlong.hwl@antgroup.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 1701db1b2e18..a0a0ccf342d3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1909,6 +1909,24 @@ void vmx_inject_exception(struct kvm_vcpu *vcpu)
 	u32 intr_info = ex->vector | INTR_INFO_VALID_MASK;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
+	/*
+	 * When injecting a #DB, single-stepping is enabled in RFLAGS, and STI
+	 * or MOV-SS blocking is active, set vmcs.PENDING_DBG_EXCEPTIONS.BS to
+	 * prevent a false positive from VM-Entry consistency check.  VM-Entry
+	 * asserts that a single-step #DB _must_ be pending in this scenario,
+	 * as the previous instruction cannot have toggled RFLAGS.TF 0=>1
+	 * (because STI and POP/MOV don't modify RFLAGS), therefore the one
+	 * instruction delay when activating single-step breakpoints must have
+	 * already expired.  However, the CPU isn't smart enough to peek at
+	 * vmcs.VM_ENTRY_INTR_INFO_FIELD and so doesn't realize that yes, there
+	 * is indeed a #DB pending/imminent.
+	 */
+	if (ex->vector == DB_VECTOR &&
+	    (vmx_get_rflags(vcpu) & X86_EFLAGS_TF) &&
+	    vmx_get_interrupt_shadow(vcpu))
+		vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
+			    vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS) | DR6_BS);
+
 	kvm_deliver_exception_payload(vcpu, ex);
 
 	if (ex->has_error_code) {
@@ -5485,26 +5503,9 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 			 * avoid single-step #DB and MTF updates, as ICEBP is
 			 * higher priority.  Note, skipping ICEBP still clears
 			 * STI and MOVSS blocking.
-			 *
-			 * For all other #DBs, set vmcs.PENDING_DBG_EXCEPTIONS.BS
-			 * if single-step is enabled in RFLAGS and STI or MOVSS
-			 * blocking is active, as the CPU doesn't set the bit
-			 * on VM-Exit due to #DB interception.  VM-Entry has a
-			 * consistency check that a single-step #DB is pending
-			 * in this scenario as the previous instruction cannot
-			 * have toggled RFLAGS.TF 0=>1 (because STI and POP/MOV
-			 * don't modify RFLAGS), therefore the one instruction
-			 * delay when activating single-step breakpoints must
-			 * have already expired.  Note, the CPU sets/clears BS
-			 * as appropriate for all other VM-Exits types.
 			 */
 			if (is_icebp(intr_info))
 				WARN_ON(!skip_emulated_instruction(vcpu));
-			else if ((vmx_get_rflags(vcpu) & X86_EFLAGS_TF) &&
-				 (vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) &
-				  (GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS)))
-				vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
-					    vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS) | DR6_BS);
 
 			kvm_queue_exception_p(vcpu, DB_VECTOR, dr6);
 			return 1;
-- 
2.54.0.563.g4f69b47b94-goog

