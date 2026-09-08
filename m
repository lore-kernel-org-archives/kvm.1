Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2FA51356F;
	Tue,  8 Sep 2026 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863625; cv=none; b=S6KY2y9LLAu873rty0hZb6p8YClYW70GDP4edqfMVh0Jon75gBkLQQdqJGL0Wv/GpP3H0FJNig5HoSt5/Pd/gKSwcgPOWsUHSc6DJLN3LM2R8C11HNH11bVdqds7sOxcWpeRcVCqt/zQYCjnV0DNUD1bsbB0OjrSYVTVS1YvLOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863625; c=relaxed/simple;
	bh=RkXapPFgSlryurKpOlWh4872DC41mH87gAnzbVVgZlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8/GUwgtg7aBsELR8zAYJloDlzBs7w+dHBN93aBWyNmRo+3vPB0/SZ/M2m4qc+VKaGW/G/lmRrp8BLC8P8eWqMjWwgSTYjXJ5ZBZN417s0kH/pdc9O9xBarjjm6zS2Rc7ScwQmvwKX6eaCyNOu2yArRF5KVEZgplSywnz1P2A1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.fritz.box (p200300f6af085a00d84fb33a51badfd9.dip0.t-ipconnect.de [IPv6:2003:f6:af08:5a00:d84f:b33a:51ba:dfd9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5830B20A1DD;
	Tue,  8 Sep 2026 12:33:41 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Michael Roth <michael.roth@amd.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Ninad Naik <ninadnaik07@gmail.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	coconut-svsm@lists.linux.dev
Subject: [PATCH v2 3/8] KVM: SVM: Hold SRCU while reloading guest-owned VMSAs
Date: Tue,  8 Sep 2026 12:33:33 +0200
Message-ID: <20260908103338.427254-4-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908103338.427254-1-joro@8bytes.org>
References: <20260908103338.427254-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

Take a dedicated KVM SRCU read lock around the guest-owned VMSA memslot
and guest_memfd lookup.  This makes the reload path self-contained and
prevents it from racing a userspace memslot replacement.

Keep the lock through VMCB installation, and release it on all lookup
failure paths.

Assisted-by: LLM
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/kvm/svm/sev.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c16eca9983f3..ee1bf9b4cc53 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4037,6 +4037,7 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	unsigned long mmu_seq;
 	struct page *page;
 	kvm_pfn_t pfn;
+	int idx;
 
 	lockdep_assert_held(&svm->sev_es.snp_vmsa_mutex);
 
@@ -4068,9 +4069,10 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	if (!VALID_PAGE(gpa))
 		return;
 
-	slot = gfn_to_memslot(vcpu->kvm, gfn);
+	idx = srcu_read_lock(&kvm->srcu);
+	slot = gfn_to_memslot(kvm, gfn);
 	if (!slot)
-		return;
+		goto out_unlock;
 
 	mmu_seq = kvm->mmu_invalidate_seq;
 	smp_rmb();
@@ -4079,8 +4081,8 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	 * The new VMSA will be private memory guest memory, so retrieve the
 	 * PFN from the gmem backend.
 	 */
-	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
-		return;
+	if (kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, &page, NULL))
+		goto out_unlock;
 
 	read_lock(&kvm->mmu_lock);
 	/*
@@ -4097,6 +4099,8 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	read_unlock(&kvm->mmu_lock);
 
 	kvm_release_page_clean(page);
+out_unlock:
+	srcu_read_unlock(&kvm->srcu, idx);
 }
 
 /*
-- 
2.53.0

