Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395645;
	b=dsK9iqfTdYMAgMPSg3y6uTA6PxVEUK0C55LeyrAJPG44P+RWwQQQG0OVMVe8pDoKP8RZ
	 YXoNUMeRlzCNlmz4fPKfCVmyps4yndqYnQMVCuatKB81pMWJK/JLvh/eXzU9DkZBsyNyo
	 rFjGqgZElBb+aJrU9MaKEYgUQzwdJ3KaixLeaa2DKmIIpIUZsgK7zxchyY45YlHsvTXpg
	 PHwawVYtA5OPfduubVAIDwaCWmrO2WFxMnP9uv1GttjLA1OGV5QPcmsUsXVWfggbDyQAg
	 RgQv1XknA3MVx2dBkHIDcaPW5pSButIteMUV2nPLQtllKiEMJzeWDeuG8RdCVBhdAeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395645;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=hkp5qs0Xl0GwSlkqXL2hIPnMMlQxkKMz2tez2uhZA7U=;
	b=dtp5r5OCGOaw5VqG4LLbMuGhWjDDsTs0emGdE9wxowhrgezq3LuMuqZtzkbR9D0DORO6
	 Yyv/JjmLdwMhNqlxlK031xtaMpX5b9exTMF5ZtICh/e5lbP11L3K2Y+mkXsOvtPAnl8CT
	 /1EEk0CrEbAws965olOmAVXHWw8iuYAA3VLAx6GungkIkj1IRUA/zyy1fsp2XAwBejxkG
	 /3ovbsRGqBZcODxWrxgYfTu16Tyw0Cp2nTJFw6JjIkF/jamOhKXHmnMXzYvPj51yKoz1x
	 obdVhyATwOTaBrD4cHdzfzjhlC9D6Ni+ahtXFrcg35uVlDrDgenSAbNGfeIlXXAt9Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M0QGiDTy;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32DD606A325
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D32DD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M0QGiDTy
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e9821ca96fso18384245ad.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395644; x=1794000444; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hkp5qs0Xl0GwSlkqXL2hIPnMMlQxkKMz2tez2uhZA7U=;
        b=M0QGiDTyrpmo+KZWFCT8zegoxT7pNNKYk1d973zXxisTSWgjpMI/BykiL2oeA1mI4x
         SUe3LKk8NjgnAN0W3TsAnjcyS7rPfDUARgayYcm9pvcSUcEnPbpTzyPNe54dRwddx2Al
         rw9dnxBCnKuENnxo2z5a2vkZuMAbv7cFXGiyMHqoWxXZbLIy1IBqS4XSb+AHT1Hpk+Sm
         inZ/FmcjoYilDjSxyXjMwjnwl5ke+il/+cL+qpapCixXvMSev2boBcDkQ/FElRiDWqJq
         qhYI4LqgM0tnzLP4EvnSfEd8yrwAT7fHzj9gjV/XGO/uhcX1G7QdHMu4W1Sueg3s0wvQ
         5CsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395644; x=1794000444;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hkp5qs0Xl0GwSlkqXL2hIPnMMlQxkKMz2tez2uhZA7U=;
        b=Ao3EhsaA01vc0U7omzyBJVP2pM8qhU6xB+BzG0K2TS4iVB+yYQvKzwhoII8v44bR/O
         mgfMWcdr1ch82GAOJSgeaTLA2Ou7iEgps6llaOVb2KsXZsKairNeAWg5JwvBqJGTxoBx
         Ev3CEuh5MUz1QtdkbldRhW3DdKgthRJTmMqocFvSXgRoLwp9Y/Q6/k6gvE6SRh+FoFJ0
         SLw1DvTNiYQp+4QmkuVfvIpnzEckChBQ3e9GUu6Wd9zvne7Y34diJWz771YClpayo1Ej
         4j4g7kWPx6wm0uDe8cnOo3FJXZ69kQNIlDTNkwYNHuYpS/w+FVczyf/OBrrE5os9PU+8
         peSg==
X-Gm-Message-State: AFq9FYI7dSPYXKnQYe8Q2bkkQST/BmP2duXrZv4C9lGhLQkvgh4L/3ve
	NoUTF20rrf68WhWSizWetXuvgCh2X5537ZzUVLqPh7OY3cBab8KWkDhw+PHRs8er5kkKH2DG3qW
	dAHD5Ug==
X-Received: from pjbcq4.prod.google.com ([2002:a17:90a:f984:b0:3ad:ce09:ff3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e4f:b0:3ac:9a5e:9ce9
 with SMTP id 98e67ed59e1d1-3ae897f3440mr2987534a91.29.1793395643960; Fri, 30
 Oct 2026 14:27:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:27:15 -0700
In-Reply-To: <20261030212721.2606393-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212721.2606393-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212721.2606393-2-seanjc@google.com>
Subject: [PATCH v3 1/7] Revert "KVM: x86: Skip EFER vs. guest CPUID checks for
 host-initiated writes"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Revert the misguided-in-hindsight decision to allow userspace to violate
architectural consistency when setting EFER as it has since been solidified
that userspace is required to configure guest CPUID prior to setting MSRs,
and skipping the CR0.PG vs. EFER.LME check in allows userspace to load an
end state of EFER.LMA=1 && EFER.LME=0, which is supposed to be impossible
and trips a variety of KVM_BUG_ON()s in the MMU.

This reverts commit 11988499e62b310f3bf6f6d0a807a06d3f9ccc96.

Fixes: 11988499e62b ("KVM: x86: Skip EFER vs. guest CPUID checks for host-initiated writes")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/msrs.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index e91650af44c2..2df42276fd82 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -580,8 +580,11 @@ static int do_get_feature_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 				 kvm_get_feature_msr);
 }
 
-static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
+bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
+	if (efer & ~kvm_caps.supported_efer_bits)
+		return false;
+
 	if (efer & EFER_AUTOIBRS && !guest_cpu_cap_has(vcpu, X86_FEATURE_AUTOIBRS))
 		return false;
 
@@ -610,33 +613,18 @@ static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 
 	return true;
 }
-
-bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
-{
-	if (efer & ~kvm_caps.supported_efer_bits)
-		return false;
-
-	return __kvm_valid_efer(vcpu, efer);
-}
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_valid_efer);
 
-static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+static int set_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
 	u64 old_efer = vcpu->arch.efer;
-	u64 efer = msr_info->data;
 	int r;
 
-	if (efer & ~kvm_caps.supported_efer_bits)
+	if (!kvm_valid_efer(vcpu, efer))
 		return 1;
 
-	if (!msr_info->host_initiated) {
-		if (!__kvm_valid_efer(vcpu, efer))
-			return 1;
-
-		if (is_paging(vcpu) &&
-		    (vcpu->arch.efer & EFER_LME) != (efer & EFER_LME))
-			return 1;
-	}
+	if (is_paging(vcpu) && (vcpu->arch.efer & EFER_LME) != (efer & EFER_LME))
+		return 1;
 
 	efer &= ~EFER_LMA;
 	efer |= vcpu->arch.efer & EFER_LMA;
@@ -1547,7 +1535,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		wrmsrq(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
 		break;
 	case MSR_EFER:
-		return set_efer(vcpu, msr_info);
+		return set_efer(vcpu, msr_info->data);
 	case MSR_K7_HWCR: {
 		/*
 		 * Allow McStatusWrEn and TscFreqSel. (Linux guests from v3.2
-- 
2.56.0.385.gac671c819a-goog

