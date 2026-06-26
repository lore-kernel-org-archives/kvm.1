Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A78E37269F
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 23:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782515663; cv=none; b=IK9KJvyEKQ8VlUBYaPbyemVizK6iru/hC3KWLqG6cq0GBuJQmVN4hH3gFuWvm17YWwJeCI0On5T080znygggRXUxcKBs/SMoozDtd6p83zjNdXqVIzf8OG/y0UHZ07FRi/tgUq6IzS2uZLZdBnTvS/L1hwqiXBuAmL2/VxHPXuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782515663; c=relaxed/simple;
	bh=tHbnzj4cCkm92N0N6S0S35TFmZS7KTv9837vIW/+yNE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EPPgmuAgYzB1uQ3Jyk22hnPn5A58Qwsm60jO6ylqjrWVmCR8DEnf7v0fRFRzLw6OzNRUYVIXQFq5tt3BVbThlII8jBlYtaClhCayOSP9mX31y8RjF2c6naooM+bmpI6forv+Z5pxCirUhcmKpFa6g9N+9SCFUMsVzYyBlsosOro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=npMyBFCo; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npMyBFCo"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-845ba254a4fso972211b3a.1
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 16:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782515662; x=1783120462; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=DSUU9PxKuuir4g3D6jT/rhVPClYQABg9m1OIKu1UhOU=;
        b=npMyBFCowmcJZhGczpfuEOIzEge6P1m7UzXznX4oMh+r3nKh9BFmavfNI7+w8oKtpu
         yd4hKPXOCbx6PGoAJhTgoyw55JDUJgWlP9nw9AcpmiIk91Wp7zzcPOkIA6R+Q6oXEcXC
         uJ+Lut9EJXbmhYix+5H7qvzVxFbabVN47kGgv0lwFJtEaJU9Bt+/I18BGiSUpAvfIYjB
         lNF6DvIdAEUiqhP8SUJeTraBNFFTKOmOGaSLudyD/1cN2Ls/lW9XgN4pAy3h6jdcsZVc
         5AF+0UnZNBB6fQjS2gcdD3OUNDRbQhfd3QdbWfKdmQGOFuE0HAKDyZ9yz5yYd/4C7jQa
         Q3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782515662; x=1783120462;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSUU9PxKuuir4g3D6jT/rhVPClYQABg9m1OIKu1UhOU=;
        b=WdSW6xmj32ugJjD0yv4w3/eFIS+H8v5DyMKakDlumD+FkseLuWZbROqEWNMF5kPZY6
         fQGGk4Tk3sm67I3Gg04r4+N3p+NJC7dRxB++a42+03fXG7UyPrwcJK1b+x4ALOuqZz+u
         WdNDCNk+GDRIHJzT41G2yoaDxOm19F6RalsDk79xRRhfuAu07DsJS2a62eFxj8hKVzoC
         RxSsrpwGImt2dfoT4XdRRp3LW0X/vRV2Yv2XAlegUffSokq/xcWJfaT/+f+mUh4LpS5b
         Sbzlrg72ZwbSOE60Zs7IC6W8sK0vWPe6V9FJveEClFWIiN0wd3OOmFidFZZAiMcDaIv7
         Eu1Q==
X-Gm-Message-State: AOJu0Yxn/GKO0cVljZKuUIgIsOEZJMezoiw1+2jPEsOG7vsFELJbL4rn
	nCp0g4NlEQzIX/ZNO+NhA/xqU5Zarq2PKTnP5cxOamlSXGDlbWhAcVKTV+qISIgT4ArUH397f6+
	NmWm1bQ==
X-Received: from pgko6.prod.google.com ([2002:a63:f146:0:b0:c82:26d4:bb49])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a08:b0:3bf:76d5:4cf2
 with SMTP id adf61e73a8af0-3bf76d5544fmr273255637.40.1782515661586; Fri, 26
 Jun 2026 16:14:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 16:14:09 -0700
In-Reply-To: <20260626231416.3943216-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626231416.3943216-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626231416.3943216-3-seanjc@google.com>
Subject: [PATCH v2 2/9] KVM: SEV: Extract loading of guest-provided VMSA to a
 separate helper
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
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

