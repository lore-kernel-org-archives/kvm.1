Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD93051DE0A
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789861; cv=none; b=QXyivQ5qK74CmuoO+vBV0CUVEGCcZRJPtZI3g/erB/CcbRIPyuHmdBokJxcdw4Wx3O+83dgxSyQnL/FUkJttYgvVDpxu+O0eXqC6wv9+mlgEEiA7tOqZTfZtX3nNqQl8ZarGn43jb7tstwwST4rL3yNNOml1o7nngDhZUOeHtn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789861; c=relaxed/simple;
	bh=XQOAP/D2bikMcyHI7hrJrfNwiYJfgyt2kwzIrVS20bM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NUBTCtL0xci1StukXpp2K3o35Y4g9vDDWKDiAyu2SyP3ADrMMd8ACbBPO+FmLw7nvWiIaiBJpS61X0cwiw8axYntVVgreIRkpPsYFOM6MiVguw6RUdKU1K4wyk/dIDpqzJKsXr/nfsZa0uKVgdTGkFiekn0EALHFsQn4pJsN0Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gpXcDqs0; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gpXcDqs0"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e2d83bb68cso11476405ad.0
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 10:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790789859; x=1791394659; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pR0CmMOwBEixDaGsVspgku93kAEdKXphr/HJk9tqVK8=;
        b=gpXcDqs0I5IY1zAM2Nx+ORRLg2JVRdw3WGMSjk8+NMcf2QLDOrkWSmNIuSDYOOppGq
         n0g9Ip8/Q3ft0uaJs/551iqw+GL+RFX/DoBFj7BFKu08C8GistLZC+JD+yX0q4rWUm+W
         zIUd7R35hMhYDZsPlTjzqb52kFvKO8nc/dntmej80OJpCvQr2i2IX/4quSzH1HJXpfx+
         NRQY8zDPWXcyfFDeg42hDq0D4hHfWceN6mt7YrNRcUrgQcI0bU+lXdvBIyCnI4K54Xr7
         d/0pUf3K0lea3YhnvDX8VsieRHa2leXvepBcYyGU88mspowa3dvw23jssUX7Mdu92Lsf
         75yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790789859; x=1791394659;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pR0CmMOwBEixDaGsVspgku93kAEdKXphr/HJk9tqVK8=;
        b=EYkngs2BnJKBhJL9VfTm2scIWV3f0NcsAxP6gSTAemICQ8tm7D4g07fNLJbmH8RNPz
         T9edKvKsXKRp6aLB548qe/a/c3nTzDNFNzcPPmNOViuYtWWFBF6hU4kkotdcGOYomxwG
         AWPTIt9XBHC92hoEPjQuTvAHLzOkeidd+Y5cFG3clTCfIVgCVTuCWIrhibPd1Ikh7xHT
         0fmoVQJ3QJBp9FNOL9+haNppUTmS6tvzpOXudPfjW5WTuexajMCtXu4QUP8fRkYplsba
         o/37rmpS2N69w/ui6PHSIKrQ4mw1slv0Wc1JWzEfbARS2GLwR5we65rS7nooIOojbcxn
         c5Xg==
X-Gm-Message-State: AFq9FYJJNgi5627ntBTTwbOjyR+fnxk//S+DUlwegvUBYK1EXM10AI8q
	MChl9MPklRyE57FBlcPqxpvsAOjMa3wNG+XG9TMWWGkqW2d3cefSi7Or+6fH5QowGe3jjCbeFPH
	nf/FbFw==
X-Received: from pldu10.prod.google.com ([2002:a17:903:108a:b0:2e2:b3a5:70bb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf0f:b0:2dd:c100:7ccc
 with SMTP id d9443c01a7336-2e2e4b38c84mr14890385ad.72.1790789858404; Wed, 30
 Sep 2026 10:37:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 10:36:15 -0700
In-Reply-To: <20260930173635.3362655-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930173635.3362655-2-seanjc@google.com>
Subject: [PATCH v3 01/21] KVM: x86: Saturate L2's TSC frequency if it exceeds
 hardware supports
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>

When computing the TSC multiplier for L2, use the minimum/maximum frequency
supported by hardware if the resulting multiplier can't be programmed into
hardware, i.e. saturate L2's frequency on both sides.  This can happen if
userspace is running L1 at a low/high frequency relative to L0, and L1 is
doing the same for L2 (relative to L1), because although each of the L1 and
L2 inputs are constrained and validated, the end result can exceed SVM's
and VMX's architectural limits.

Don't bother trying to log an error or do something more sophisticated,
because in practice only a misbehaving L1 (and/or host userspace) will run
afoul of the flaw.  On SVM, which has the smallest "range" by far (8 bits
for the integer multiplier, versus 16 bits on VMX), KVM can still run L2
with a frequency 255x that of L0.  Even assuming a pessimistic L0 TSC
frequency of 1GHz (modern CPUs run TSC at 2GHz+), L2 would need to be
running at a whopping ~255GHz for the limitation to be a problem.  Not to
mention that if L2 is running at a legitimate frequency, then running that
VM on existing hardware is already doomed irrespective of the nested angle.

Open code the mul_u64_u64_shr() if the compiler natively supports 128-bit
integers, mostly to avoid having to do the multiply twice for what should
be a very rare scenario, but also so that there's a slightly more scrutable
sequence that can be read to understand what all is going on.

Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
[sean: optimize for INT128, rewrite comment+changelog to be less AI]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 55 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cf3fcdfd8ad2..037c7ea5c5a7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1190,11 +1190,58 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_calc_nested_tsc_offset);
 
 u64 kvm_calc_nested_tsc_multiplier(u64 l1_multiplier, u64 l2_multiplier)
 {
-	if (l2_multiplier != kvm_caps.default_tsc_scaling_ratio)
-		return mul_u64_u64_shr(l1_multiplier, l2_multiplier,
-				       kvm_caps.tsc_scaling_ratio_frac_bits);
+	u8 frac_bits = kvm_caps.tsc_scaling_ratio_frac_bits;
+	u64 nested_multiplier;
 
-	return l1_multiplier;
+	if (l2_multiplier == kvm_caps.default_tsc_scaling_ratio)
+		return l1_multiplier;
+
+	/*
+	 * The shift is fixed on both AMD and Intel, and operates on a 64-bit
+	 * value.  I.e. a shift greater than 63 is completely nonsensical.
+	 */
+	if (WARN_ON_ONCE(frac_bits > 63))
+		return l1_multiplier;
+
+	/*
+	 * If the resulting multiplier can't be programmed into hardware, run
+	 * L2 at the minimum/maximum frequency supported by hardware, i.e.
+	 * saturate L2's frequency on both sides.  Because L2's frequency needs
+	 * to be distilled down to a single multiplier to get from:
+	 *
+	 *     L2 = (((L0 * L1_mult) >> frac) * L2_mult) >> frac)
+	 *
+	 * to:
+	 *
+	 *     L2 = (L0 * mult) >> frac
+	 *
+	 * very small/large L1 and L2 multipliers can underflow/overflow the
+	 * minimum/maximum multiplier supported by hardware when combined into
+	 * a single value.
+	 *
+	 * Manually check for the case where the result would overflow a u64,
+	 * i.e. if the multiplier would be silently truncated before the "too
+	 * large" check.  Avoid doing the multiply twice in the common case
+	 * where the compiler natively supports 128-bit values.
+	 */
+#ifdef CONFIG_ARCH_SUPPORTS_INT128
+	unsigned __int128 m = (unsigned __int128)l1_multiplier * l2_multiplier;
+
+	if (m >> (64 + frac_bits))
+		return kvm_caps.max_tsc_scaling_ratio;
+
+	nested_multiplier = m >> frac_bits;
+#else
+	if (mul_u64_u64_shr(l1_multiplier, l2_multiplier, 64 + frac_bits))
+		return kvm_caps.max_tsc_scaling_ratio;
+
+	nested_multiplier = mul_u64_u64_shr(l1_multiplier, l2_multiplier, frac_bits);
+#endif
+	if (nested_multiplier > kvm_caps.max_tsc_scaling_ratio)
+		return kvm_caps.max_tsc_scaling_ratio;
+
+	/* The minimum multiplier is '1' on both AMD and Intel. */
+	return nested_multiplier ?: 1;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_calc_nested_tsc_multiplier);
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

