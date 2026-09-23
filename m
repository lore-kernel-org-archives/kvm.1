Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7093B3F1640
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178681; cv=none; b=jpi2eRUdXCP/BPZ6Np/RHO/K12HPNcOytLg5KhwT7drJZrd3eyxOWdpG5nAiX+bVSwWF0tNPkhwKbHSzn8IoruG3PU1SCjFHxKhQXM02tpn3szs1SLrqUAgmx4e9cOh7zH5QjIrn3vb8MgRWqSaB/h4EtCzKWoZx8y6sqn5MWRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178681; c=relaxed/simple;
	bh=Vn7Yb/To97gB1mHdv2b7cq0yxSEzkws7zRDQe0LYJQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AyYtbglqaUWnlbj3N5ObE9SQKtuQ+Mliv4nj3CJ26ieXdFhkcUb3rhJyauMscwWEdA2hwXTFWXxFJhjSCerwMlE6cbyYFgo5myB9KbS1vX7NImFvPKsZmyE/z5IkeHwdmZmn+u0ttfHRGmHe10rBzdjTfWeIDOp8sldCf8IF9Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UWFwruHk; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UWFwruHk"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39e3f521346so1027390a91.0
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 08:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790178674; x=1790783474; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cY3L7frn4nkr2uyxD7c5k8nfl5DVj2AlSPH8dpGX6a0=;
        b=UWFwruHkQ/qAbB2J/x/rne+wpQCtUqZurCMJgaa3gFPSgT6Kg9sFbhut9lINPMiYwI
         fZ1ZiijcWIPngKtMy+20RgQMFo5iI80/vSGwPqBhfkMbtIfDhWnHicHZl0PFJe9c6Psh
         VuVeA98KMWZTMOSCQxBRRwA+X7gle7iWd+++Sv6wCR7UYLTpiFhSf0ywCoeMNj6okjfn
         H6WU8n3EAuYeMtEjjahf3DS1rxNc1IsqNtV9tcZiJ+qIPSMxlaSFm8mQprRMoTi8vP5I
         dw2BLrwBNw6wWLT1vDM5bQ31dcAFkNhiXBQQC95V7fZ7tVlaCBTsGn3nIZ46T/kWAaMx
         FR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790178674; x=1790783474;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cY3L7frn4nkr2uyxD7c5k8nfl5DVj2AlSPH8dpGX6a0=;
        b=rfxS40MrozxTKgheldGrziYVaH3FL0+PKZTsPdWO0wkEGQefAInaLErZkrMoMV09Jb
         FRkKWM2twb/LPWNwxBuyDfJSLCV14FfbgEEGc7oty00J8OcPATqwdq6kkhW9y706N7hy
         CQop0BiF6C7RgQ6ydR58saSmerO4a653D6QdizvydkoBMAYHZ5L6OVFfLW0++VcnnmpK
         4lhxoHThfMdMl4ASUhJqNB8HO+1YPWPXjGrUcWuNNGaOtdtKZHhX+MEFWxbwR2NQ2/3e
         v4VQjlWmRTFXv2U0jfW4bNvL+G4XduUTeaDkttErqiJznQLnkNFFVW4jG8Je67RJDGVv
         Q+uw==
X-Gm-Message-State: AFuF++ngx2tXt1M0XtMgJv/LUyJ5pW8+BxJmhiSC+iaYeRpm9b90iYBe
	ibpAm9aPPGfwBWO9RIxaFckEZafcuopCqLtp8IZH7R/s5cil3e3vU6D7MgiZiH9m1GrsLQXCx9I
	4jcJrQw==
X-Received: from pjbbh7.prod.google.com ([2002:a17:90b:487:b0:3a0:8315:fa7b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2fc8:b0:39e:1c03:14c2
 with SMTP id 98e67ed59e1d1-3a07e4e348amr3249729a91.11.1790178673926; Wed, 23
 Sep 2026 08:51:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 23 Sep 2026 08:51:08 -0700
In-Reply-To: <20260923155108.1550622-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923155108.1550622-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923155108.1550622-4-seanjc@google.com>
Subject: [PATCH v2 3/3] KVM: SVM: Clear AVIC Physical ID table entry if vCPU
 creation fails
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Atish Patra <atishp@meta.com>
Content-Type: text/plain; charset="UTF-8"

From: Naveen N Rao <naveen@kernel.org>

If vCPU creation fails after kvm_arch_vcpu_create(), the AVIC Physical
ID table entry corresponding to that vCPU continues to point to the
freed APIC backing page which can result in UAF. Address this by
clearing out the corresponding AVIC Physical ID table entry in the
vcpu_free() callback, similar to the VMX commit b41f2ca6c060 ("KVM: VMX:
Fix stale PID-pointer table entry left after vCPU free").

Though unlikely, it is also possible that svm_vcpu_create() itself fails
after the AVIC Physical ID table entry has been setup if memory
allocation fails in svm_vcpu_alloc_msrpm(). Clear the entry in this path
as well.

Note: this change depends on commit 97d65b544f48 ("KVM: Check for
duplicate vcpu_id as early as possible"), which ensures that a vCPU with
a duplicate ID is never created. Otherwise, a valid AVIC Physical ID
table entry for an existing vCPU will be cleared.

Fixes: 44a95dae1d22 ("KVM: x86: Detect and Initialize AVIC support")
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
Tested-by: Atish Patra <atishp@meta.com>
[sean: use avic_is_addressable_vcpu()]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 8 ++++++++
 arch/x86/kvm/svm/svm.c  | 6 +++++-
 arch/x86/kvm/svm/svm.h  | 1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 4173a30dfe60..96ca39c0045f 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -889,6 +889,14 @@ int avic_init_vcpu(struct vcpu_svm *svm)
 	return ret;
 }
 
+void avic_vcpu_free(struct kvm_vcpu *vcpu)
+{
+	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
+
+	if (kvm_svm->avic_physical_id_table && avic_is_addressable_vcpu(vcpu))
+		WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], 0);
+}
+
 void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu)
 {
 	avic_handle_dfr_update(vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7d59d301e1e5..686e4c560fec 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1337,7 +1337,7 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 	svm->msrpm = svm_vcpu_alloc_msrpm();
 	if (!svm->msrpm) {
 		err = -ENOMEM;
-		goto error_free_sev;
+		goto error_free_avic;
 	}
 
 	svm->x2avic_msrs_intercepted = true;
@@ -1351,6 +1351,8 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 
 	return 0;
 
+error_free_avic:
+	avic_vcpu_free(vcpu);
 error_free_sev:
 	sev_free_vcpu(vcpu);
 error_free_vmcb_page:
@@ -1365,6 +1367,8 @@ static void svm_vcpu_free(struct kvm_vcpu *vcpu)
 
 	WARN_ON_ONCE(!list_empty(&svm->ir_list));
 
+	avic_vcpu_free(vcpu);
+
 	svm_leave_nested(vcpu);
 	svm_free_nested(svm);
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e958943b8162..790bd96a9791 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -954,6 +954,7 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb);
 int avic_incomplete_ipi_interception(struct kvm_vcpu *vcpu);
 int avic_unaccelerated_access_interception(struct kvm_vcpu *vcpu);
 int avic_init_vcpu(struct vcpu_svm *svm);
+void avic_vcpu_free(struct kvm_vcpu *vcpu);
 void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 void avic_vcpu_put(struct kvm_vcpu *vcpu);
 void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu);
-- 
2.55.0.1082.g2b9226bbc0-goog

