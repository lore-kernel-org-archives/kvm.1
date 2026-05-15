Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671563D88F1
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778865340; cv=none; b=bfbS9Xra2DKi8dDXsNbhG/zqPWC61yFrLK0DomxYjpYvMPIPbx9WncaUWLZnbA5L3hIXUqCetEaN2FQT7hMUmv78lOio3xU4Yyn2pamkV6qWf//9r1gigyZDHus4DLzzn5tPVDu63G635025TK9Syn0aLvo+YQ4EosG4zyGqM24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778865340; c=relaxed/simple;
	bh=Iy7SrJOHrWMF10VoqMzA4L8S2oZcfVCfMXJj9qvp+U0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kkDvv6plH+MhB5EI8nYFPzm79vXEd2zgMDuxZvZj5kKeAx1PLLKwk/55yaZACcotBEkx++WcG3w0DoNEitBYynrWGvVyBGdp1QDz/zMue64SR+tv5id1/ctkYjyNKfxH9vvRYtFT+n6TdkvzjoXe4T1afoWGIcTx2w+uZVmFYQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bsj4p/0C; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bsj4p/0C"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-365fd467cf6so623a91.0
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 10:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778865338; x=1779470138; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXne7n9YlZuhy/YYik1SkDFKzdHy9NFNuwS5NyaEXnA=;
        b=Bsj4p/0CQQe8A6ynp+XPRGVSfOuK3R7YnbjLkzKwFjc6QzcYAs5g39b5lWW7wotqdI
         JH7e3WobKg4lbAKviGU2R7BjaBY6e+GXE9ycYZhhioFXX0bPrTjabjaMt9c7yPulHljb
         vNwPxzGtIp71IgF0NFAksTWwxjggZFKSVb1NjVEQMoE+yamzZGjfUppFaC7U9vx+MEGJ
         PYIqfoWUc6+I37xRxO7v8OdDGkmlHKqpVJ83ljVDkq94dtaALuHgZS6RpqYwZlOqkV+9
         NRnQzYQ+Ig+VvS/ExT1FWYjD7565f7WvpvzBlSov/CfLT7KKDv0u9igfdMvPRvXnSiyU
         YXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778865338; x=1779470138;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXne7n9YlZuhy/YYik1SkDFKzdHy9NFNuwS5NyaEXnA=;
        b=dUMyUqSy4a6QSkHSOT/hGu8fqqMNT8nZDSKHddWnwQ5lFcEjnI/k50aQi9yNpg+LhB
         laXTxJDIo22+8taLekOgZtCtbJflZpq4jzqbONgb3D4I6KIB7SeMOnRax3OzY25F+OY7
         o+o0+oVMH6RJ6n7FwZsd15d8XTRRS8dwv+FK+XFqyYPz4I1Q7kuDy+MgZfWLz/jgx/sR
         FZIsG2jeEz4Jo8uGkDjTd9z9Jso1JsmdcxeElXskbKsS8BKi/G48wjc6qPzqRKHqKp8s
         dNPEI1i2ydriTih/gLc+KEe4lfmFhouOln/4WcEJ5TTF2nYBgyVNBfb/z9R2MkgRlsSL
         ZiiQ==
X-Gm-Message-State: AOJu0YwRtqo3RrgQhS8FHr78MK6bTsqPo/zt0OdA/4P2vWU6Br5Y6yDI
	NDe3FYPuGrRW//dF9kVGiLdDmyZCfRUEtGok8lp6kLK/ep2Jvx1hQZs6lCBU1y/1K5GngbPxqeL
	/Q/a1VA==
X-Received: from pjvf3.prod.google.com ([2002:a17:90a:da83:b0:369:3fa4:a760])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:568d:b0:367:bf0c:54e9
 with SMTP id 98e67ed59e1d1-36951cbd45emr5849335a91.21.1778865338437; Fri, 15
 May 2026 10:15:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 10:15:36 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515171536.1841645-1-seanjc@google.com>
Subject: [PATCH] KVM: SVM: Flush the current TLB when transitioning from xAVIC
 => x2AVIC
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Flush the current TLB when xAVIC *or* x2AVIC is activated, as KVM is
(apparently) responsible for purging TLB entries when transitioning from
xAVIC to x2AVIC.  The APM says a whole lot of nothing about TLB flushing
with respect to (x2)AVIC, but empirical data strongly suggests hardware
also does a whole lot of nothing.

Failure to flush the TLB when enabling x2AVIC can lead to guest accesses
to the APIC base address getting incorrectly redirected to the virtual
APIC page.  The flaw most visibly manifests as failures in KVM-Unit-Test's
verify_disabled_apic_mmio() testcase when x2APIC is enabled (though for
reasons unknown, the test only reliably fails with EFI builds).

Fixes: 0ccf3e7cb95a ("KVM: SVM: Flush the "current" TLB when activating AVIC")
Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
Cc: stable@vger.kernel.org
Cc: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index adf211860949..e8bd60156941 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -206,6 +206,35 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
 
 	svm_clr_intercept(svm, INTERCEPT_CR8_WRITE);
 
+	/*
+	 * Flush the TLB when enabling (x2)AVIC and when transitioning between
+	 * xAVIC and x2AVIC, as the CPU may have inserted a TLB entry for the
+	 * "wrong" mapping.
+	 *
+	 * KVM uses a per-VM "scratch" page to back the APIC memslot, because
+	 * KVM also uses per-VM page tables *and* maintains the page table (NPT
+	 * or shadow page) mappings for said memslot even if one or more vCPUs
+	 * have their local APIC hardware-disabled or are in x2APIC mode, i.e.
+	 * even if one or more vCPUs' APIC MMIO BAR is effectively disabled.
+	 *
+	 * If xAVIC is fully enabled, hardware ignores the physical address in
+	 * KVM's page tables, i.e. in the leaf SPTE for the APIC memslot, and
+	 * instead redirects the access to the AVIC backing page, i.e. to the
+	 * vCPU's virtual APIC page.  If xAVIC is not enabled (APIC is either
+	 * hardware-disabled or in x2APIC mode), then guest accesses will use
+	 * the page table mapping verbatim, i.e. will access the per-VM scratch
+	 * page, as normal memory.
+	 *
+	 * In both cases, the CPU is allowed to cache TLB entries for the APIC
+	 * base GPA.  So, KVM needs to flush the TLB when enabling xAVIC, as
+	 * accesses need to be redirected to the virtual APIC page, but the TLB
+	 * may contain entries pointing at the scratch page.  KVM also needs to
+	 * flush the TLB when enabling x2AVIC, as accesses need to go to the
+	 * scratch page, but the TLB may contain entries tagged as xAVIC, i.e.
+	 * entries pointing to the vCPU's virtual APIC page.
+	 */
+	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, &svm->vcpu);
+
 	/*
 	 * Note: KVM supports hybrid-AVIC mode, where KVM emulates x2APIC MSR
 	 * accesses, while interrupt injection to a running vCPU can be
@@ -219,12 +248,6 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
 		/* Disabling MSR intercept for x2APIC registers */
 		avic_set_x2apic_msr_interception(svm, false);
 	} else {
-		/*
-		 * Flush the TLB, the guest may have inserted a non-APIC
-		 * mapping into the TLB while AVIC was disabled.
-		 */
-		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, &svm->vcpu);
-
 		/* Enabling MSR intercept for x2APIC registers */
 		avic_set_x2apic_msr_interception(svm, true);
 	}

base-commit: a9512a611bd030088f13477258d1f8103cceaa40
-- 
2.54.0.563.g4f69b47b94-goog

