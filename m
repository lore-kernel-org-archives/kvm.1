Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E473890E8
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781276221; cv=none; b=gtLCcyq19+FfFWOkkcz8+XW3X0o+TwH0hXkeHfc4ZB2XUKeoC2Hz7qUXzhmr12992UvATWUhHpzhH2ixBssbUccLhgJyoEPqrFrDgY8U6BrH4I0AEbvSZqoJTwIymCOnATerzUnpvSBrTJgH4W9aE+Fulaas3iEsKFrlGeKhx2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781276221; c=relaxed/simple;
	bh=203X/VlYA8xGp7MXFq8vIcezkh0KgyndUoATdW/PFuI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QiEovBAz53u5gb5V96sxM6Codqi2Os6F1V5hnKNFrCQ7KNreiv5ZxerPbLH23SKvOucNbHEk3I3PJjgBz670abmuBxAJpiivHMnx8SGlMNylnRjPoIiVeAlE7DbfB8vq/eh96t4iiOZ5UegBuUUBfF4+mCxdIBp4ov/fjUvVDvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rLhT18yO; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rLhT18yO"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d97415004so1902517a91.2
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 07:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781276209; x=1781881009; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLV51C4RXNpxy1DRD8Tmh+6Z3/ST7Qn1kg/8EOZ6FU8=;
        b=rLhT18yOxGCQYbJ/1DvlMuyxg2UiMEzPTBZU070vaKut36AeZqmOauG+XJVvohyjkP
         TaQlPHsZJWd9Cuz/hUmlRGuRBb1Ry01CF/Ki8MYRZeyzbNn97YaNnCpFpgqZf9mo9w+X
         3M7CdpeYJJwTjPMzX0+IrRHtxp7+6RBgwlzNjHJnLX+KzU5k3789A2bqLS/osH8IQrYr
         CzRS/CTmLf2qWqC44Vr/3m0wYs4pEGKr7GUfiemNm+BUikKl8/P15eEn6VNFmJWvEhtZ
         RNETxF9c/d6VG/ZSl4ea75zd12HJA8PkkjiaS+lfedDjLpf7PjuwmYT/gbXezDOOTtXY
         n0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781276209; x=1781881009;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLV51C4RXNpxy1DRD8Tmh+6Z3/ST7Qn1kg/8EOZ6FU8=;
        b=iS6VQbXdV4kTTc39bEeGd0fZQpbqNVACV83OG0KBuXvx8jcW9tLcZKz9M+uG+QLalO
         IzqLTYv3ah9GCxJQOH2xyCxJJ2BJLSVij16E7eH3XN5n/hTOqgU055hFR+bkYRvgiDjD
         DV9wJLOq6mXNAII0O97A2a/3rasWF0kmIF6j7dawOBB3gckxOd0XG+Csm4KjrkT7HpxC
         bdKO0SohIbE/p8OxBj/Z00M+yNrdmLat/qEusXtyORm09P+2L8n0SM8RTlaxOnfx7dnc
         Je0czJQcNE3okvY6NiCSi3UL0CQKfhNqlH+p3eBH9gsGKtrGo/e1AuKvZ4ntRVixxdzI
         CuSw==
X-Gm-Message-State: AOJu0YwB+6plhputXBB3th1PUDCB2lYcEqhBPevhg3JfkdPe7jRgL/CF
	g0r1TZNroZio/owahb3ZyYrGZa8vNaPFnjs3ogG9miaHDwd3rpXgBJ3XOXPrvfnthIsvYcr40+w
	x7sswOg==
X-Received: from pjbmj16.prod.google.com ([2002:a17:90b:3690:b0:373:40c6:a8c9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:7309:b0:37c:18e0:90ed
 with SMTP id 98e67ed59e1d1-37c18e09300mr870508a91.4.1781276208528; Fri, 12
 Jun 2026 07:56:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 07:56:42 -0700
In-Reply-To: <20260612145642.452392-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612145642.452392-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612145642.452392-3-seanjc@google.com>
Subject: [PATCH v2 2/2] KVM: nVMX: Don't use vmcs01.GUEST_CR3 to snapshot L1's
 CR3 when EPT is disabled
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a dedicated field in "struct nested_vmx" to track L1's pre-VM-Enter CR3
instead of using vmcs01.GUEST_CR3, which isn't anywhere near as safe as the
comment purports it to be.  E.g. in addition to the warn_on_missed_cc bug
(that was fixed by relocating the consistency check), if getting vmcs12
pages (during actual nested VM-Entry) fails and EPT is disabled (in KVM),
KVM will return control to userspace with vmcs01.GUEST_CR3 holding a guest-
controlled value.

Alternatively, KVM could force a reload of vmcs01.GUEST_CR3 by resetting
the MMU context in the error path, but as above, the safety of the vmcs01
approach is extremely questionable, e.g. it took all of ~4 months for the
code to break.

Fixes: 671ddc700fd0 ("KVM: nVMX: Don't leak L1 MMIO regions to L2")
Cc: stable@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 21 ++++++++-------------
 arch/x86/kvm/vmx/vmx.h    |  7 +++++++
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 199b866072c0..7a2251061bfa 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3669,19 +3669,14 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 				    &vmx->nested.pre_vmenter_ssp_tbl);
 
 	/*
-	 * Overwrite vmcs01.GUEST_CR3 with L1's CR3 if EPT is disabled.  In the
-	 * event of a "late" VM-Fail, i.e. a VM-Fail detected by hardware but
-	 * not KVM, KVM must unwind its software model to the pre-VM-Entry host
-	 * state.  When EPT is disabled, GUEST_CR3 holds KVM's shadow CR3, not
-	 * L1's "real" CR3, which causes nested_vmx_restore_host_state() to
-	 * corrupt vcpu->arch.cr3.  Stuffing vmcs01.GUEST_CR3 results in the
-	 * unwind naturally setting arch.cr3 to the correct value.  Smashing
-	 * vmcs01.GUEST_CR3 is safe because nested VM-Exits, and the unwind,
-	 * reset KVM's MMU, i.e. vmcs01.GUEST_CR3 is guaranteed to be
-	 * overwritten with a shadow CR3 prior to re-entering L1.
+	 * Stash L1's CR3, so that in the event of a "late" VM-Fail, i.e. a
+	 * VM-Fail detected by hardware but not KVM, KVM can unwind its
+	 * software model to the pre-VM-Entry host state.  When EPT is
+	 * disabled, GUEST_CR3 holds KVM's shadow CR3, not L1's "real" CR3,
+	 * and so simply restoring from vmcs01.GUEST_CR3 would corrupt
+	 * vcpu->arch.cr3.
 	 */
-	if (!enable_ept)
-		vmcs_writel(GUEST_CR3, vcpu->arch.cr3);
+	vmx->nested.pre_vmenter_cr3 = kvm_read_cr3(vcpu);
 
 	vmx_switch_vmcs(vcpu, &vmx->nested.vmcs02);
 
@@ -4993,7 +4988,7 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
 	vmx_set_cr4(vcpu, vmcs_readl(CR4_READ_SHADOW));
 
 	nested_ept_uninit_mmu_context(vcpu);
-	vcpu->arch.cr3 = vmcs_readl(GUEST_CR3);
+	vcpu->arch.cr3 = vmx->nested.pre_vmenter_cr3;
 	kvm_register_mark_available(vcpu, VCPU_REG_CR3);
 
 	/*
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index de9de0d2016c..dc8517f15bc4 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -159,6 +159,13 @@ struct nested_vmx {
 	bool has_preemption_timer_deadline;
 	bool preemption_timer_expired;
 
+	/*
+	 * Used to restore L1's CR3 if hardware detects a VM-Fail Consistency
+	 * Check that KVM does not, in which case KVM needs to unwind CR3 back
+	 * to its pre-VM-Enter state, NOT to vmcs01.HOST_CR3.
+	 */
+	unsigned long pre_vmenter_cr3;
+
 	/*
 	 * Used to snapshot MSRs that are conditionally loaded on VM-Enter in
 	 * order to propagate the guest's pre-VM-Enter value into vmcs02.  For
-- 
2.54.0.1136.gdb2ca164c4-goog

