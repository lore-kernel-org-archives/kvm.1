Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA099386578
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782426165; cv=none; b=HVBY+r/GGlWjyUqoamnt+6P9kx6yMG9PMWwC4bQUHhSqHs1i5qpZW+iaUOzyo9MmDi3dVV9S8ik8gXhy1Uim/uThYawAvktS/jBX729PVaChJU6IyTZfAvZtQdsaHLuTSeJrppbYGys809hN8mVEDDNFu0sy2LdPEYODp+0+QjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782426165; c=relaxed/simple;
	bh=DBIf3+VFDZYptvruqD6ltoPaucEpf3ClGhtQ8Sb8YIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DgIYcMB3TPuECCPoBJiGDPCdT15Aa0wuR4NBVHPp+OyILA3JanF2JHG4TjgLGhHoObOCPh4wKKZb+4m1lT6+Wrbv38IWy7ZHRJQkugNQk3LlxIa0JuVgTXKV/FaZEDdGA0BxYHKuuM1jAs23lEZzuKEkB78dMaEE2oj2DyhDtZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eILZsB5l; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eILZsB5l"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8bad49b171so155876a12.3
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782426160; x=1783030960; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=23IT/I8BFI3FVtFLLsXh6XFyUDIWbMpHRUduaQab4Hg=;
        b=eILZsB5lOECd/9JtJne1k04XeD+jttljk+s4kjHgDheMQ20aoaEVtpf2RAL1j20+CJ
         zCD7MSQlscKZZH9hsRdvPkvRcvBgXNYS38cYDe0YB5sJBdYiRFVYQuyjXnKtZbKlaYaM
         x+Y54EFq/mkb2zN3qtexs9taq+k05tACrmSADi6ned9p1we/ZaFOEpSgtnPu7A1jJily
         eaSRtOzi2BcXfDnrQ1H3fJ2xJNGsSczlnTf4QjL7rG7SevxkycPEHmyVz8HjwlNZRVM3
         rwwdKv3q+TDduscCJQ5UnQRY27+EES9S/r/UMyY17k6LJ6Sqe33RKDrFI16HpA3aVjRb
         mG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782426160; x=1783030960;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23IT/I8BFI3FVtFLLsXh6XFyUDIWbMpHRUduaQab4Hg=;
        b=Wkwu0lAIMYJEUegb4zxYTij5sKmqJw7+O8CyQ6Vr46RAeMLkqY4HKjoaCAVWq9xZGn
         u3X4jWTo/Em5GGylpyJ/c3tS5nJGoAGAyl3OkLpfQHH3U4tIzdTAUPbTZ0ZLNqD/6aAM
         k7JOwvISKO+Z3mngG0ZUBnJO/31nzo7MrH8VosFJ3O5oTGfRjyn9mp7M3Z35vocad44i
         O/6ZC29Q44s/pcewIb7u266ciNEqW32/GwBdmLVMBri8z6pBRnRY0YOBchzY2gkXGonc
         00Jr79RtxIkGAjuia7Crl1jETCUHg+4uknep2iN2VRKqKdfbkX+a5nuYBxH77BH6JW0J
         s9Vw==
X-Gm-Message-State: AOJu0YzsC1sjj3mYYsfr8Fph+ytuP/mBU5RdCVLpJv8X4cB/MFvaYBOx
	j3zRZdOOx3fTHYMlfLNZV8Wh5GHMA6HLza0XbqlrtxUgY72PFp8P7u7i6S8yiTKj9SHhze6EH3b
	7bJ2EzQ==
X-Received: from pgeu26.prod.google.com ([2002:a63:a91a:0:b0:c92:29d5:1f29])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f8d:b0:3b2:a8cd:ef4a
 with SMTP id adf61e73a8af0-3bd4ae7b32amr4819622637.30.1782426159831; Thu, 25
 Jun 2026 15:22:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:22:29 -0700
In-Reply-To: <20260625222229.3367197-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625222229.3367197-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625222229.3367197-8-seanjc@google.com>
Subject: [PATCH 7/7] KVM: SEV: Mark vCPU has having guest-provided VMSA even
 if its invalid
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"

Track the guest as having a guest-provided VMSA as soon as control.vmsa_pa
is invalidated, instead of waiting to see if the guest-provided VMSA is
usable, so that KVM doesn't switch back to the original VMSA instead of
exiting to userspace (due to an invalid VMSA).  By the time a vCPU tries
to load a guest-provided VMSA, KVM has already communicated "success" for
AP creation, i.e. KVM has committed to using the guest-provided VMSA.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 04be49b1af57..7e06ed16f474 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4001,23 +4001,6 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
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
@@ -4029,6 +4012,23 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
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
2.55.0.rc0.799.gd6f94ed593-goog

