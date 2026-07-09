Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE99C3E0C42
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630195; cv=none; b=nEpgdesTGch76PZCtFG4A92hJ5BvjiW6eySDdUukOcK21PP7a6t5f77avjBDUDasfbRefdDtjwOcMBrAoC5CX83cFLWjSx0yYLuEhQz1MFCh+a9qPIdu6bUfc489EGxRILA0ns8Cy6XZIyKvta4EnXNErCfmbiEJLTQ2HRFx0F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630195; c=relaxed/simple;
	bh=ck/taze5Kzok79sQ/uAiPa2Qd79N6/tA6gSIoOVNyss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YAbfOdI1HvvIeB5fpwRqTlbqmSm6ewyXMDOvdH+6tXJ9BpKXPfGKoXYDastwOuqmn1CWA79k/iWxct1P9ai4XXlY+tYBehTjg/oX44gH6Tf0RLkMd5Tup6ye60v4AOirOZ455gGuI10mLbnM0p4luGV40NRxLkdwVokET2zX5y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N8Wr8pGj; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N8Wr8pGj"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ccb6f6a3f4so3777325ad.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783630193; x=1784234993; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZoLzDGzm6QoeKTc742PewDuHsvTjn3y5h6+Ju4d7PxE=;
        b=N8Wr8pGjfO5zr0lqEem2uIRpX6PnrEkDcPfM+/3SLG3qnLiyBO/aWA56iHabU9ik63
         Ea1cg6Lp3UH8eDvfneZA03qFJDDC8H6DdEF9oDiNRGR8eBKTtaOCwFSw6fjjBVVvpjqu
         R4BCo07x7KlKPmmDTMjxHZJ2ymCYhhSxpkVzpb18XiIZ7LalrvtubFme5dY/ZEMysAiV
         38Q2pjr7mgvOFXjir7VFwpzo04e86NDf2ASg+SbozKNLU+qKR8xp3pmOes6YVhsYwCUY
         dbvoUOk9unjRk9AZ6ud51MDKBkpk3Ly1rTRvmC3LnDIdp1j/P+T3QMNlNzKw1u/XDDgP
         9dGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630193; x=1784234993;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZoLzDGzm6QoeKTc742PewDuHsvTjn3y5h6+Ju4d7PxE=;
        b=jVyLAfwMfvclZ2LbQlz3fgOOxNj+Lun5ACqgFfRDSvVpPJOLekhzESgRGTeXsp8uxV
         gFySd57Vchz/t0l8INae+WtfbZzYd6jXaZc+EyF6I3CPNAI9EvAEs3t4UOlsLbO0Gf90
         YLyhm0/57i4w72yfHaN8CJ/pasdCM0+QEdNwTbFnyzFh+/IYa9zgQjZBNKt9Q1agYX8N
         O3kvwsJCiinzFBiuEqkttIvooCjZg8tUQxePSHbaNtQooz6M030JbAHu/gOfCLBqUkPE
         5JOilsdo7dOjKtH+PjWkC6cgvpQRGFIGNzqQitFcz5FqL6gqZ7AW16+R1s+gx54fhb5M
         MGyg==
X-Gm-Message-State: AOJu0YzLuhtMN08zHfvSmctG0lGNsGo5bB5poWUHP3OHL5jP7r+FL4X7
	GBn31xEExOBffQrkQ6JRaYodSPKD7iHMrIePzaRUpqFhoiQmbnZkVXpQsIhza2j+62+cDlgH+rl
	18FqxwQ==
X-Received: from plbky8.prod.google.com ([2002:a17:902:f988:b0:2ca:e163:e0c8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2c9:b0:2c9:ed2e:b8c1
 with SMTP id d9443c01a7336-2ce82bbd796mr7840945ad.12.1783630193038; Thu, 09
 Jul 2026 13:49:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Jul 2026 13:49:32 -0700
In-Reply-To: <20260709204948.1988414-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709204948.1988414-3-seanjc@google.com>
Subject: [PATCH v4 02/18] KVM: SEV: Extract loading of guest-provided VMSA to
 a separate helper
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Extract the loading/retrieval of a guest-provided VMSA to a separate helper
so that KVM can reuse the core logic when refreshing the VMSA after an MMU
invalidation from guest_memfd.

No functional change intended.

Cc: stable@vger.kernel.org # 6.12.x
Reviewed-by: Michael Roth <michael.roth@amd.com>
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
2.55.0.795.g602f6c329a-goog

