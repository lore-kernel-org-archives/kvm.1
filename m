Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619732;
	b=GJ1RXMaFesVuHWWMmvXvpx1+zJVCkv4/zcHXJnR3py939kpNl1SC+EWFQDaeO1QdSDh3
	 gpt11YWDbO3hH4yvV//3TYLAdnJ1/QPErtW1atb7UfR1h5xXneNcHjzsX59erv9aRhsV2
	 jVqLV6icKUw+spBbJgeBJgsR7dOZJnTMj/rW21xI37TuQyxepKsSnq1mNHNuOejhjtQ1l
	 q5MqhRkgY28Uh6zlW7gShoBEUOo7gHB39fi2GN1FipwxnUHiWNdWgdDBtIKvTEHfyxlfT
	 qvctzBuA4fs7yp3WRWWPi8qFHi32Zn/Ic+pUO/cKbN7KpswHNOb/9+93y0iW9jYU39g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619732;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Wg/9BkvVbzjYLnmge/yC5tcnzeQaEmaT35H+5c8S5lU=;
	b=VCR9jfDYCEuXhCvXTwUIUXjq4nm2U43r8jM475/gc39Yv1xDd86saf9nxfeEr+nYb/th
	 zPqbije0vAfYbqZmZrcVufGVSp13PkPIm+1ZXO8BWxN8bY7TFkZLyz9q83JrQ3Jsgwbh1
	 2VT6fUo+p7gkLEsB30vDd6N2+5NbsiJTAI5fCSU5ghu4nw6JfVCWoNR6BxQUQN8cp4uFw
	 ZifGhzl6ZiRIT7CTq2PBM/Izn97+trnsFBVopKWzb5Ig2K/uzs+kpUt+VU9hfLKfuIC5A
	 cPtPqqrPviRQpb0x+Kl6GmMKr35O9KOeJvwVNeVi+x1E8uzGH4MtPYpfmNogJRgeFuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EFA606A32C;
	Mon,  2 Nov 2026 11:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7EFA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.fritz.box (p200300f6af404a0027ad06761c59e6b3.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:27ad:676:1c59:e6b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5CE3E243AD4;
	Mon,  2 Nov 2026 12:42:04 +0100 (CET)
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
	coconut-svsm@lists.linux.dev,
	joro@8bytes.org
Subject: [PATCH v3 3/8] KVM: SVM: Hold SRCU while reloading guest-owned VMSAs
Date: Mon,  2 Nov 2026 12:41:32 +0100
Message-ID: <20261102114137.1198982-4-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102114137.1198982-1-joro@8bytes.org>
References: <20261102114137.1198982-1-joro@8bytes.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

Take a dedicated KVM SRCU read lock around the guest-owned VMSA memslot
and guest_memfd lookup.  This makes the reload path self-contained and
prevents it from racing a userspace memslot replacement.

Keep the lock through VMCB installation, and release it on all lookup
failure paths.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/kvm/svm/sev.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index f690edaf8b69..9681ff0aa5d3 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4059,6 +4059,7 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	gfn_t gfn = gpa_to_gfn(gpa);
 	unsigned long mmu_seq;
 	kvm_pfn_t pfn;
+	int idx;
 
 	lockdep_assert_held(&svm->sev_es.snp_vmsa_mutex);
 
@@ -4090,9 +4091,10 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
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
@@ -4101,8 +4103,8 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	 * The new VMSA will be private memory guest memory, so retrieve the
 	 * PFN from the gmem backend.
 	 */
-	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, NULL))
-		return;
+	if (kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, NULL))
+		goto out_unlock;
 
 	read_lock(&kvm->mmu_lock);
 	/*
@@ -4117,6 +4119,9 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	else
 		svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
 	read_unlock(&kvm->mmu_lock);
+
+out_unlock:
+	srcu_read_unlock(&kvm->srcu, idx);
 }
 
 /*
-- 
2.53.0

