Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB30384CFF
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782426157; cv=none; b=SpUprcgG+VDxyC3LhNJW7bpwwyyyQ7vUZ4A1iDpAovzJMHTGHF+O0oyT3EGRUPby4peO7aPJCaj/e49UB1TAEBtw8CNrzwxLj24ZOaYApe8KMuQOCRwXnIyrrqCRrG4SQwBGhj4AvZLp5fJxFmNHYFcyjGYx8kcSeLQcUWN9sF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782426157; c=relaxed/simple;
	bh=LucN5JamRcsprin1wl770Lm4vcTlr9l/UnicWruGxfk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BwqybjD+EXewna04Al3dDM/1WjpzZB4xPO0HuiFfAPb+QA0B64l5oc1Du5gtkx1ns7XaunCVZTdozM89LUT53B6DsJnWMuGZq5y/qbIQzBEdDyDtrzeIfUFdUYKSzFkcpP/joFISYsM/w8FwwqpmPOwWbDCO2x9uyd5e62DlQek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VtsXb7Ua; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VtsXb7Ua"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8c7f6c6069so773366a12.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782426155; x=1783030955; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LVH488ABtKjteCUCpdHkIaXszdc1rhyITIsihNOj+dk=;
        b=VtsXb7UaFauBxQfpVBvetrKqQP9Z5/64eeHJEgI2Tk9QDf0W3bhNdfuDlLbQX8LnPe
         yRS3eqc00FKWxAqcJtlg2BefxZmSa0m+gXWvhCr03xH/YIkknTiNDfyP89H52gwJHJwW
         ABPJ+P5Gsz5f+K3mk2jmJPbTIp3kBF+hGSEEqHBORs/Ls7cOlxiNttqOtq+lVR4BUPH3
         g8w0MLrHlwVZQMd/v88f9Pr36AIDzvXYBg2eDn4h0wq1fQ6ue/VJ/sdzZXstZaMgHpLZ
         0W48Y7rYh+wXDjUrflY5vHiw4b/eoHcBND8nqD+Q2rgQPr3GuLe+GB/G/Yn+D9FVZdwK
         Se9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782426155; x=1783030955;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVH488ABtKjteCUCpdHkIaXszdc1rhyITIsihNOj+dk=;
        b=KEG+zPIKbesKymD4Ik/hD855XGI+H9VryUZmxy2fb7OWKIRjV05/hxo9r8/NAoH+QY
         Y4QvIURNyl3B9+PvOO/ZHy69zVXE//NXJzssDF8pFwJQ4bOYqpai15GFiGB17A0z16+d
         THxr7KU/JA1Z/O6h1lj4+b/Cn2KqizS6a0v2prN2eFIdVEwFcD4332r1eEk+BmWOJXUC
         0PQ5UM0IJiWS5xNKYTnQE2UKmq7uz+wnzQtGaQmCETMZdlUZ0ETG/QsQ5GWjbi0DQSPy
         HaJefsijB5RJ3lxFSZ4pdo4PpqhUCkRteOi4IFn6AFpHA1ZtigoP52SpUiXAtuguTP8J
         g3zA==
X-Gm-Message-State: AOJu0YxZoXpmJGQxXbGGzbV87Sg6WG+/fq+2RU64wbB1uv0nd/ll3vJS
	VaCytz1L9BiEZe7NOKeE6yEirGk23vPf7DPvpPhi0Z2awJYYC74vQlFgBmy++JK5OW5758hqOjP
	DK0rSBw==
X-Received: from pgkc20.prod.google.com ([2002:a63:ef54:0:b0:c88:a076:b3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:920d:b0:3b4:a0c0:6cb7
 with SMTP id adf61e73a8af0-3bd4abaa43emr3649636637.11.1782426154413; Thu, 25
 Jun 2026 15:22:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:22:24 -0700
In-Reply-To: <20260625222229.3367197-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625222229.3367197-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625222229.3367197-3-seanjc@google.com>
Subject: [PATCH 2/7] KVM: SEV: Extract loading of guest-provided VMSA to a
 separate helper
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"

Extract the loading/retrieval of a guest-provided VMSA to a separate helper
so that KVM can reuse the core logic when refreshing the VMSA after an MMU
invalidation from guest_memfd.

No functional change intended.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 52 +++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 827f5dc06102..d8ed00f76aa3 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3979,29 +3979,17 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	return snp_do_psc(svm);
 }
 
-/*
- * Invoked as part of svm_vcpu_reset() processing of an init event.
- */
-static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
+static void sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_memory_slot *slot;
+	gfn_t gfn = gpa_to_gfn(gpa);
 	struct page *page;
 	kvm_pfn_t pfn;
-	gfn_t gfn;
 
-	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
+	lockdep_assert_held(&svm->sev_es.snp_vmsa_mutex);
 
-	if (!svm->sev_es.snp_ap_waiting_for_reset)
-		return;
-
-	svm->sev_es.snp_ap_waiting_for_reset = false;
-
-	/* Mark the vCPU as offline and not runnable */
-	vcpu->arch.pv.pv_unhalted = false;
-	kvm_set_mp_state(vcpu, KVM_MP_STATE_HALTED);
-
-	/* Clear use of the VMSA */
+	/* Clear use of the VMSA. */
 	svm->vmcb->control.vmsa_pa = INVALID_PAGE;
 	svm->sev_es.snp_guest_vmsa_gpa = INVALID_PAGE;
 
@@ -4011,12 +3999,9 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	 */
 	vmcb_mark_all_dirty(svm->vmcb);
 
-	if (!VALID_PAGE(svm->sev_es.snp_pending_vmsa_gpa))
+	if (!VALID_PAGE(gpa))
 		return;
 
-	gfn = gpa_to_gfn(svm->sev_es.snp_pending_vmsa_gpa);
-	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
-
 	slot = gfn_to_memslot(vcpu->kvm, gfn);
 	if (!slot)
 		return;
@@ -4040,7 +4025,7 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	svm->sev_es.snp_has_guest_vmsa = true;
 
 	/* Use the new VMSA */
-	svm->sev_es.snp_guest_vmsa_gpa = gfn_to_gpa(gfn);
+	svm->sev_es.snp_guest_vmsa_gpa = gpa;
 	svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
 
 	/* Mark the vCPU as runnable */
@@ -4054,6 +4039,31 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	kvm_release_page_clean(page);
 }
 
+/*
+ * Invoked as part of svm_vcpu_reset() processing of an init event.
+ */
+static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	gpa_t gpa;
+
+	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
+
+	if (!svm->sev_es.snp_ap_waiting_for_reset)
+		return;
+
+	svm->sev_es.snp_ap_waiting_for_reset = false;
+
+	/* Mark the vCPU as offline and not runnable */
+	vcpu->arch.pv.pv_unhalted = false;
+	kvm_set_mp_state(vcpu, KVM_MP_STATE_HALTED);
+
+	gpa = svm->sev_es.snp_pending_vmsa_gpa;
+	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
+
+	sev_snp_reload_vmsa(vcpu, gpa);
+}
+
 static int sev_snp_ap_creation(struct vcpu_svm *svm)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(svm->vcpu.kvm);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

