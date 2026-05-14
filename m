Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A043C3D47D4
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795655; cv=none; b=U7jm2O3NO4eg3a37WftCQ7H4wxLOonf1UYQlMwiwG7aorKCFrMYqgDb6y9iW8xrLZtpzlVEKGU0wEcES0n/IA8DIUpWrrkV+1ThSQgPohsXpNz2w/kAmuQ1re1IxvhOOTLCGK7WwJ8kmdkdXGrlFpWM0XsGzJtXElvqXaX3Zh7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795655; c=relaxed/simple;
	bh=DkYUZVCFxypYvjE+ECVjC8MTu+dU12DtdKyLPawOsdk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NRidlvpBfIszKcNPKY/Ok0yXHF20INnmOYz6yiU4GwvV/fiDzvmIXsbUC2OtgH8eufXRFb9nmF4z6W2gPRBJs2+9INO9PKu0FyCHmsTYVlcp5rsMSSLZSyF2opTk0NnxS2dAeoJlv7lqt67LhlOabHerNJrCN+xh7kl88bp0D9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PH8qIL3C; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PH8qIL3C"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83f24cd00f8so675189b3a.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778795653; x=1779400453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=brzyKoCEspwI0RWW9AziHqTrLPrrZVq/O92aCbmnfFc=;
        b=PH8qIL3CLryxPTb8Mv/w0e4IyPfIyUjFd5EoOPinf95d/zvvnNSDu5m4PRcAgva5Gn
         D6LKHngyMjGvLARykoqlTl+YdJHW2qzqCQt4ntaAtPTqgbstFXn481iPXUTI4xL4Jk8+
         1BFMiQkqR2lrL6B2TETYK53MnVaeODOh+0HqhLQkJ8yjj67sG+n1k5/RX+k3WVZ5EHGH
         EW09wm+UScPMndYzCTHE6+d69RmaVuf5uBqLa3V5B+4F2AvgYdpJ2UHBoSLeYXM756wX
         k4dUV/nWTQeaINvjN6LOYj+NAO2zWcovLix5c7fnItCOPWHtlnQvJWhrW7gHt07HLRC1
         y0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778795653; x=1779400453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brzyKoCEspwI0RWW9AziHqTrLPrrZVq/O92aCbmnfFc=;
        b=IW/CtJkxG7Swa3OpsPreS0hmbrnm7PeCmWRIRXlsXBDfpLsb3irG40sKPfN+LAA+oI
         Dn38AAmFAaPBXDXpCRIvtrAkQwE1k0bfPVWxVO6l2h1mEg3B30TC98iAQEdGbF8+y71K
         /5vMNwue031KR7lCc/aIb8COLbYaGPa1snpkzEcN2xl9y7tH8JGtOVuUf0xPgIp68CEZ
         lM8GrdAriYxuLvrpJl4/nI3Ng+MOERsnSANhmFg9dQNz7oBQQzb7y6hZjH7idVvKGJ+K
         ec5BfYyTAMRFOYIHw0/W95/OuZDW09UQOW6yu1gUKnK9Y25jm2IdyvFuysg5E3j8lby2
         rwcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+GuQYrz1UokIv8ENocgV2BVVK70ga+HtMm3G+33VG3/9nSdUm/GzHmydU8fRfeIklBsuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6/PjwvqjwRfv1bez3k5uWRV/tNMs2SZVfbXwlLX0qYuudsZrv
	NvxAwPKrmYvKRE+XX/jGaGvexVAOu9hu4WuJTWbHZ7oka/sXh00EHpTs2CVipe4CpI8xAkyr7Gq
	hsq6mdg==
X-Received: from pfoo22.prod.google.com ([2002:a05:6a00:1a16:b0:836:d115:1e44])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94c4:b0:82c:212a:a9b5
 with SMTP id d2e1a72fcca58-83f33d52d3cmr1204761b3a.36.1778795652618; Thu, 14
 May 2026 14:54:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:53:54 -0700
In-Reply-To: <20260514215355.1648463-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514215355.1648463-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514215355.1648463-15-seanjc@google.com>
Subject: [PATCH v2 14/15] KVM: x86: Move kvm_pv_async_pf_enabled() to x86.h
 (as an inline)
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Move kvm_pv_async_pf_enabled() in anticipation of extracting the majority
of register specific code out of x86.c.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 12 ------------
 arch/x86/kvm/x86.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1113a31978dd..e664e874973b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1042,18 +1042,6 @@ bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_require_dr);
 
-static bool __kvm_pv_async_pf_enabled(u64 data)
-{
-	u64 mask = KVM_ASYNC_PF_ENABLED | KVM_ASYNC_PF_DELIVERY_AS_INT;
-
-	return (data & mask) == mask;
-}
-
-static bool kvm_pv_async_pf_enabled(struct kvm_vcpu *vcpu)
-{
-	return __kvm_pv_async_pf_enabled(vcpu->arch.apf.msr_en_val);
-}
-
 static inline u64 pdptr_rsvd_bits(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.reserved_gpa_bits | rsvd_bits(5, 8) | rsvd_bits(1, 2);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index bd4423e82b02..185062a26924 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -570,6 +570,18 @@ static inline bool kvm_pat_valid(u64 data)
 	return (data | ((data & 0x0202020202020202ull) << 1)) == data;
 }
 
+static inline bool __kvm_pv_async_pf_enabled(u64 data)
+{
+	u64 mask = KVM_ASYNC_PF_ENABLED | KVM_ASYNC_PF_DELIVERY_AS_INT;
+
+	return (data & mask) == mask;
+}
+
+static inline bool kvm_pv_async_pf_enabled(struct kvm_vcpu *vcpu)
+{
+	return __kvm_pv_async_pf_enabled(vcpu->arch.apf.msr_en_val);
+}
+
 /*
  * Trigger machine check on the host. We assume all the MSRs are already set up
  * by the CPU and that we still run on the same CPU as the MCE occurred on.
-- 
2.54.0.563.g4f69b47b94-goog

