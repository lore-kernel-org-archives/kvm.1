Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882313F0765
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630204; cv=none; b=lJs3NBWp92gXGMIQCm4QdT2b6q2pNsKk9Xe9MA/tyNXMTXwUC5Pt8n3GbATHAAa0tdA1DY3JD0YGfxjj5zpVYAae0uaSNqzTZGfNZ6Jg+Nbd6yRdWzl++MsfCtB+8vsrsj7zvfXfJy3baZ6OWfd5/kVXX5RbjpPtATS7kTqCfzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630204; c=relaxed/simple;
	bh=J0O80xbFC+OETUeCXtw9boUGnKSARUcqkFKKMC98+uk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z3J3BnoPZ6dZ3W4w6fIYXCgqh+fqmq1iekNb5rTaDc1MHswH4zxwShm77ysqqh/UMaZMKmPJTMLBwTF54OWbRVXLENRAd2P8D07jlCMsxlMOZ9miJVzEujJKcNNUk/ZzM34Pl5aPER9pkbiGdqo2MkIrhqkB6bQC8yBwUmOowPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pUlh6ru6; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pUlh6ru6"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8485b7e18b4so317265b3a.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783630203; x=1784235003; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K1YD2mNgcPaJeEQABB4dlvbbHc5XiXFBZEcL0TEjEKI=;
        b=pUlh6ru6e5+RHOzxFpNRwiH8YMlW6UekhFBgu7XAifS4DAMCW9FcEn0zI0Ft+Liof0
         /Xvw3dcqbaXi3YAkiqxTLVqvPjFwp801O6x4AIXzazs/3icgkFIHlXXGuss87mBN4+q/
         vth3puqsikJqdyr9KIhmNKZCE8o6cWJiOfMTr3zWpwa+iVb2s6UI3aS+A4lsQADmrNeX
         FGcWKVw/rr6Mh7Q7UbV7LVyNy7cb+WEHq0uMiAGhS8NSQ2rp1UkGU98tXTecj7I/AQbT
         Z7574k/B+G5jUMdNuFU6wVqo4OVV2cc0N2umNmp/+LaAsqYoRZ4RinFkRaVDsslyJzjc
         0fOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630203; x=1784235003;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K1YD2mNgcPaJeEQABB4dlvbbHc5XiXFBZEcL0TEjEKI=;
        b=lHQfSMCpGau2ZJyIMpzKvbdCiz7txx1pdOaIJEUtrST8vp8o5LD8Jn8988SwX6r1j/
         pGOqtqwiOy1cTTfdJgr/f/MIohsQhZimZSVmMxQSbFS5W4B1GHsBg5dvaX7D4SSqoxP+
         EWkn/lI4cAhps4kicJx9ygeDox1XzBZj14+G/LZNq+WlJ/WN83vQv5OJdRwQSTH4wSXT
         1CNO/iYIn0vJkApacvYoUaiC75Er/a04PLny7/eiUEBPK7j3d67fN/sQ74b4E7WUWOC8
         kGXuYwWSMWu+flTUtpqUTBGjQup04fvleG7SgSkDIyjqMUvmrs4svU5pdh1y5l3168nO
         leyw==
X-Gm-Message-State: AOJu0YxOyahwf5UyC35TBnrwZfYLxzF7Y02WNbge9KP9UILHiCJugBRP
	SA3tn2iRu2v5aI9BkXSv9GaXXWrzyfZP8T9dxvfhS+4Lub5U2iBV0waQVb1AdUm1t06uhbR9zFI
	8hZTCzg==
X-Received: from pfbmu20.prod.google.com ([2002:a05:6a00:6e94:b0:847:926b:dc16])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:338b:b0:848:2f84:f42f
 with SMTP id d2e1a72fcca58-848432a96a5mr8422612b3a.72.1783630202786; Thu, 09
 Jul 2026 13:50:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Jul 2026 13:49:41 -0700
In-Reply-To: <20260709204948.1988414-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709204948.1988414-12-seanjc@google.com>
Subject: [PATCH v4 11/18] KVM: SEV: Mark vCPU has having guest-provided VMSA
 even if its invalid
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Track the guest as having a guest-provided VMSA as soon as control.vmsa_pa
is invalidated, instead of waiting to see if the guest-provided VMSA is
usable, so that KVM doesn't switch back to the original VMSA instead of
exiting to userspace (due to an invalid VMSA).  By the time a vCPU tries
to load a guest-provided VMSA, KVM has already communicated "success" for
AP creation, i.e. KVM has committed to using the guest-provided VMSA.

Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 62c6126d52c0..a7584b7ed6dc 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4005,23 +4005,6 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	 */
 	vmcb_mark_all_dirty(svm->vmcb);
 
-	if (!VALID_PAGE(gpa))
-		return;
-
-	slot = gfn_to_memslot(vcpu->kvm, gfn);
-	if (!slot)
-		return;
-
-	mmu_seq = kvm->mmu_invalidate_seq;
-	smp_rmb();
-
-	/*
-	 * The new VMSA will be private memory guest memory, so retrieve the
-	 * PFN from the gmem backend.
-	 */
-	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
-		return;
-
 	/*
 	 * From this point forward, the VMSA will always be a guest-mapped page
 	 * rather than the initial one allocated by KVM in svm->sev_es.vmsa. In
@@ -4033,6 +4016,23 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	 */
 	svm->sev_es.snp_has_guest_vmsa = true;
 
+	if (!VALID_PAGE(gpa))
+		return;
+
+	slot = gfn_to_memslot(vcpu->kvm, gfn);
+	if (!slot)
+		return;
+
+	mmu_seq = kvm->mmu_invalidate_seq;
+	smp_rmb();
+
+	/*
+	 * The new VMSA will be private memory guest memory, so retrieve the
+	 * PFN from the gmem backend.
+	 */
+	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
+		return;
+
 	read_lock(&kvm->mmu_lock);
 	/*
 	 * Save the guest-provided GPA.  If retry is needed, then KVM will try
-- 
2.55.0.795.g602f6c329a-goog

