Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708256;
	b=pIojqr9WcWEIi3vPteH276EJ2AMZ6F58mAhfm2kIg+/yZTOxWgeM7+w0NAZOw+agUB4j
	 Fbd2IMPYT2cv9wy6HepSIiVG84ZeX1jEy4CnByzKh5lS4J3IZ+35FMAsqrzhmzeE9ymXM
	 yg9bh89HbN4F4Nwt5bRZn1utxtaEgUDA60BVN8rymALPNQV6cqkCcI66d9lwPgfm8SW4D
	 M850qbCo+WzT3Wj+6ErertXfycptKVP3rLxQJRSPG5wm7wYpVxACnnL8j8LcQ5J/JiBfd
	 a3whWKuWC9FDSSAwgfJsjVAPGIcqcQcCCfd5mZFNzliQ/pnjtV41DvZ34mwcEcOTB9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=c1ICGtebK4PnUz+eTPBqGZS7H61BX5xXk5/xh07UySM=;
	b=WqSFla4yUGm6r2a4xDpS+kWzUZzRkTkE0vdPwCmdmyDlzB6TOts+hGdb8VW6XZCW/U17
	 3SUd5SnrYOQIliocsmRv9U8rDpGfrbAlT/62O2nRzK2oUhbKR51FPBL11D1ELkN1dsTEO
	 /KQ1zXCk1RSmAKPp0idkzp9ZMM7aIdv9It6DMt/YkIOhGhe7lVAN84etoEqRl9L4LY2w8
	 gHg0MkVUR486nBXtyOoIeM7JMomKvvik0B0/ClWAkdRt1cs6X6ag0cHsvEMqT1LCB515C
	 +hW+jVRJeN5Mazv5TvVa+OFoHv8p4VrM2mGoJbgyptzxoteO1dOdi7obon+i5ILFTzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="LUOw/BMB";
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE06606A31D
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 22:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFE06606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LUOw/BMB
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd633da24f8so345214a12.2
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 15:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792708255; x=1793313055; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c1ICGtebK4PnUz+eTPBqGZS7H61BX5xXk5/xh07UySM=;
        b=LUOw/BMBx97hKPKCbPzJRyCiigoIQIZ+/ugNLh/T67HADnNpOk3RvzV1bjpcp7eTSQ
         hyb5KxuWTLj2NA7OA94u7HLh4HTpIzOAibkzyk2EhHkgzQO2NSP+EytuAweWOtVLzz3j
         Lm+MrBknxnPesoOZFnZJDeNGhyXXRKpTh+kq279UJZIKFqEOuGwp1Obt47ybLO8FV5se
         Ne9hUFrxMgDJt82GcnMlKOu6ZmBz9tS277iKK28UoqcB28vfgkgH8LWgiK/m2yZdZRdl
         55tdLbPRI+ptA0kozYZfLPE83b+s3zMaJYkUqzE7E+Eo/oTAqUS7Ayfa/LSI5cp2C6KG
         BwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792708255; x=1793313055;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c1ICGtebK4PnUz+eTPBqGZS7H61BX5xXk5/xh07UySM=;
        b=JvYN9cEl2su4UJF2Ab7kzi3AAJS0Yj3EENU97li5DWCPOtQTsZ17DLhzcMsgpIlVaU
         avYS3gx35CW/fvBTaOCenwrxcqez2yZHXSHBwc5ja4Np3to5T37XbJzx3yn0BHjsDPh2
         F5B7CEo+oto/gGFpnk15eqTnNIMC3Q0dO+4dXd7KNoyx8wcJ1UPKYeCP/LzdIOHkW0ig
         HkNWR+cfBvNfdmzjiUtd9Rg3oqN0l0OkMWYLas5gQ1w0zzMwSg4t+0rZe5z8Tsm0aA6a
         kcQwQXqcrBZ+71KWf/OGxJ396SXL+ZFUoDgaaOsbEkfhflhdLVMW0yoMU7N0sLm2xBd6
         Ckzw==
X-Gm-Message-State: AFq9FYJ3CMxo384mQU0BGyXvtHtz2+rwsOFzDBY9cNC0Xr5MTNqg4X/K
	8ySUr/ebwMZYiLASMmYe6LZyU/eBRkgXhDbgGvNfKi0TB8SMltVstMaLCfbfEhCFPJ20tZf/6dY
	zhSg6xw==
X-Received: from pgca20-n1.prod.google.com ([2002:a05:6a02:6394:10b0:cd8:b213:347])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4393:b0:3e2:1418:aae2
 with SMTP id adf61e73a8af0-3e376759aa3mr305777637.68.1792708255129; Thu, 22
 Oct 2026 15:30:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Oct 2026 15:30:49 -0700
In-Reply-To: <20261022223052.646891-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022223052.646891-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022223052.646891-2-seanjc@google.com>
Subject: [PATCH 1/4] Revert "KVM: x86: Skip EFER vs. guest CPUID checks for
 host-initiated writes"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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
2.56.0.257.gf7497c7d27-goog

