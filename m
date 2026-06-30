Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D70732C302
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858373; cv=none; b=L7a2/ToJ3mi+ukcFeZ3uzhyaL2AIy8CyQ0EAOfZRD+e3D4FbyKUSCYBjklL07wsSzb9YXVsDIVZykXE9Njj5pAd+idGXxAFsWugaDDgWZyCPX9LPE3NarGd2LWH0lUjUGLvkldqtgCZmIhPgjTpWcjaeKrfEKovAwoMByJX/nmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858373; c=relaxed/simple;
	bh=tHbnzj4cCkm92N0N6S0S35TFmZS7KTv9837vIW/+yNE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m55RsJcMD+77YHQJTMGYDYjEm+nHuHpPUv5S3eZtH1P3SgBqyphPdYLatvmKUqtF7syVGmhPGblAQ8CaZGEx/8xOgLpnT75d0cZbCJZhZAiWSDFMzxjcYpmG5CGagh5xhELmak+6yn4D/n2Eh6tCN2LV9VG6r+4kOYQ1UZu6kkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ta3BsUe/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ta3BsUe/"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c8284701c2so241135ad.1
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782858371; x=1783463171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=DSUU9PxKuuir4g3D6jT/rhVPClYQABg9m1OIKu1UhOU=;
        b=Ta3BsUe/lZLrw0uqgNVPyFwscQO7dGffgvofrPnsXka2R4xBFrNOjk7EO3uxz9JN6D
         zuXmarbyfDkuPnSRKpOlmEHzBSFg4yMKQLtqUZXHrzo5bv3jdz6RoCxepHf1uERgGXyj
         w6AoE0tyISASfwmHX6oJSiBvrD2Zwtggg1G2qh44+O9D6AzkqFcgqHmHBnRJd02yt31w
         jQmhj2+jMYvJlIyrr3GJyNZ0YoPZCw8+M2fg9uuybiaCBkjeSE/0jTsp2Qhia5bb2wD5
         3VpVAaNO9VP+9RG6N6PEW5l0qy8QnyFIrVqkZaZR7V9w1qX0us1d8mYM9h1yu8KSi8ck
         xLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782858371; x=1783463171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSUU9PxKuuir4g3D6jT/rhVPClYQABg9m1OIKu1UhOU=;
        b=dtnaQHM+jp1fvbdLEKY1zq2YthSJF+9mD75VNwp+GoyyjFMo5xDmCyj6u5Lv/H/m3C
         SfRa4LYgL8oSisJvLnK5JRsCZZDxzYKD6AuAc1kZvY6gfSl9hQ9XQyHLsIOiiD/JMgxw
         U7TJy5VEop8O2C59motGZsMYX922j4i+Bh7o7vQYaPoWz0SNnHh7csHIr7vhZeHinm5J
         w5kfz1c+A0hp6n41LPlBVkuI11aSQlfxLKaUFxMwhss6klVX0Pje1l+9UpFMhdkS6FY4
         GnAc+x6pdOCvcDNR6dTNVGbfeYplTG26aYQB2As4lC9Y7R+MeQ8m0Wi+OG+4nCwr4r94
         DtrA==
X-Gm-Message-State: AOJu0YzOFIq8kzGBxiqIVDyy28sw561DLzduGfp9KPYTcMrl4el0XWi2
	qBag2thRPottKUEITHRo9EcZRPfY9OgEsDgCaIsYlvJRTL2BPlD4QMkbSKUMLdqVu4dW1842j8I
	acvbYUA==
X-Received: from plcm12.prod.google.com ([2002:a17:902:f20c:b0:2c7:ebf9:97ac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5c8:b0:2c9:ed16:8d8d
 with SMTP id d9443c01a7336-2ca2ea2276dmr46781675ad.38.1782858371005; Tue, 30
 Jun 2026 15:26:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:25:57 -0700
In-Reply-To: <20260630222607.497895-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630222607.497895-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630222607.497895-3-seanjc@google.com>
Subject: [PATCH v3 02/12] KVM: SEV: Extract loading of guest-provided VMSA to
 a separate helper
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Extract the loading/retrieval of a guest-provided VMSA to a separate helper
so that KVM can reuse the core logic when refreshing the VMSA after an MMU
invalidation from guest_memfd.

No functional change intended.

Cc: stable@vger.kernel.org # 6.12.x
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

