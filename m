Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE414A3418
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780526068; cv=none; b=pUEbYmfHIGJvgz3H4gwx6ZKQzLIpfyCZ9gkc7k2fpSJTB23PjmriwMLrI9Mzp/CPvWgbHeFyeCc4Y58QuN68mKzue/cBxaPL2z9AYJQK/TuJnsEC8JVgUpipFo8YsaFHYPA6x2rTqd5KUfqGjwbcXEDTv04jpxuz7HmvqldMPAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780526068; c=relaxed/simple;
	bh=KtdlDyfbm3TdN3Bu5jvCzKeLtKQzA5ao31bl8Pxom84=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S+hiAXfenwSS9LJHxFNLsGIYyLJkmJeHvaQ0w6X26OsYu6IRtixtfSKDattXVkhP4h0I84r66zhqXdWQyJD0cAuN6Ijn/fp2G/BV4Ts/SVF0taHntPWpWoQyUyjsUClhklNLmOUSxYN2ZugssCiqyqbjmlPYl9YwAi2s5rO87T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tyvlDC+Y; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tyvlDC+Y"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8422f987f2eso60922b3a.3
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 15:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780526063; x=1781130863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YT22xFPe+uvBINsx4QHwFFDf4DhD63vVETjx/ZAWt2E=;
        b=tyvlDC+Y99qjHpEnqftZV/RRwHqb8Q9tEauYZvCGXZzV17cGV7f0HOatReGEsRGUNm
         gEZxmwcsxQyhnwKWsBgQRO1iBk4RkEV4KW/MpGu5Srolxl/5huAkzLkhgU7MNIIAgcXL
         OCmzamR2LHvzmdxkwoErfXIT3IAgvSOzOdb0rGdncLiUIeju5/IVcbLue1022R7B3HnW
         599Z5fsRgqr36q74aD0Vl6xq8JcmkWmfbjHFaUAVXBMx0vPo7HmWK/V67vi1g3mRn9j3
         o5TybdGV9snAgIlQostN4TYsTPQhKBNvWrC7DUAAUyq2yfKSGHD5bSHk0Xa6m0fZxVTy
         hvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780526063; x=1781130863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YT22xFPe+uvBINsx4QHwFFDf4DhD63vVETjx/ZAWt2E=;
        b=OkFrgXpOoW+y/L4OD/QKL7Rjli/z9bF7OoDYX1rE58jHBjGCoi/cLJ3TfhwtRQHc2d
         lYuM8ThEO+sw1wiwHJRaddHVyMdiv1tlQStKyYwQk8II+og/7362K9SHzvzqZEwSgoUF
         ad8aT+hdBr4f8q4rXMwzliY9AHKClXUv4ZX+CyKnQxcsR2jRyMmhsSln55IUsEo+M2bq
         jXUryRs1zo68OV0+2cgEpeON52Mf+uwEwnsSDu/QBd6IcnnDCquXH6hMi33PoxDu/Gxk
         BLX2P7f7SD0xyYoiVVgYJd2Afnt6hUPKT1NTCt5Hi0xurVZBTrmDtw8WM/j0psnoqzlV
         kqDA==
X-Gm-Message-State: AOJu0YzTY9FjhJ1FBkF35YEgMJUWtJamYhJD4IxOwzPiTy1jNl5f6K+/
	L1EC4Tg9RhoWcebaqCbDpZlLjz6T6W/zmDrLBWcbOdUk+JG8LvxwzT+GzFrHH01VaKjhFGtVL4/
	4Im/y8A==
X-Received: from pfm4.prod.google.com ([2002:a05:6a00:724:b0:842:2c74:b8ce])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b483:b0:842:2ddb:e303
 with SMTP id d2e1a72fcca58-84284da5a08mr5238397b3a.12.1780526063099; Wed, 03
 Jun 2026 15:34:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  3 Jun 2026 15:34:18 -0700
In-Reply-To: <20260603223418.1720035-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603223418.1720035-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260603223418.1720035-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: nVMX: Don't use vmcs01.GUEST_CR3 to snapshot L1's
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
index 039e234e7d2b..772b8090d06a 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3668,19 +3668,14 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
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
+	vmx->nested.pre_vmenter_cr3 = vcpu->arch.cr3;
 
 	vmx_switch_vmcs(vcpu, &vmx->nested.vmcs02);
 
@@ -4992,7 +4987,7 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
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
2.54.0.1032.g2f8565e1d1-goog

