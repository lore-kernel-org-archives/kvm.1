Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC1349219D
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780010; cv=none; b=g36jRp/9ymHtDjRJrSX1HLtVLorlnZzlEAbTq6GdpbmCHHfr/+8wjrQDpjUY68VaKOXauOmMvFR8xSQyYAyKV7Bqi2UxJlSu6Ld4Xu6sz0cTk/tf6E8GLK2cp8qn+77rCgQwHGT3SWvm6d+mJwD9MwLlOlFCT4TZHNJV9GHmWtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780010; c=relaxed/simple;
	bh=UD4V+P+sJ4ggxTSMMhUjRA0kQeqR4BaRSMZh0omtQgI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ptjp3m8/SSwyA3nRm5RWltRwBArgKDMZa0mGMQ7fJvglLVAJiwQwJOVsd9Z3d6kVJR2HyrBiHv3x8Riq53pBBaRH0VNfyTkb/r5V1ot2RJozscVx+8OPj6sDePdv/FSANVYWriO1uiAjkWiWgcElQmt3uK9gJf7gLhhte++u8RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ky8NV/l3; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ky8NV/l3"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbe77d6864dso1979155a12.2
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787780004; x=1788384804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p0wLAh+oBJxC4Mzz9xo11F85UOi0qCTAzexRNcTkKnc=;
        b=Ky8NV/l3iW4/rBJcU5STadFeEPJkraBeUMYurIZsafGa/gDTsbgu5tRbmEUUWjweiV
         7uJiz/KBGDFGTTbwTPAcOYB54j2Thl//10JI9HKmmEJSXL30v9YNk/G2MmW9JGsKxj0q
         pbTwJC9DWZLij/3Hk42NuzpnP9R5RH6BVuvuubNoTtcL2UXhMBNHeikDD1yi43uFKWnw
         8gfLvg0Lbvgk4xvVdMwk8YZJ6PFpZlenkIthBv3VhAMobo0xZ2zYBx6Xv6v8q5R/FSIH
         46+mbGNI84cdq3VJdIkS/0nWCXSOE3hWA85Q09U59BNE/nB5jGT6sdrN2q4r4ro8NxY+
         F0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787780004; x=1788384804;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p0wLAh+oBJxC4Mzz9xo11F85UOi0qCTAzexRNcTkKnc=;
        b=ebpMifHHoWBVF0c58zW7CYKC28OYuqAngSNHDP2g4X6VlQJAobGdOH+XwysPpQkeCu
         4Vp2GsEuyyqFFpT+YY8jXbLgf0m7qwpDzbIJZsccJ89TJHFMXOSh3/wJwG/FOm6UYblP
         ZsKV1j9qTxAhNlNb+eJYjSGDl8Bxlr0hMANm0lP9g9jzI1i7Rg5E77ilHG2bn2b8YlXG
         zwNOUWRz4/z2qNtE6zMLWXd67NVWRfJhZ/G1gSzX9RR5VSLmRrlxkq5nDN66ehxK2qMk
         IJ9LQO3GqHQIlGo9vkdBXfrQ2ojJbhROpqJ1JKFQ4e3GzpM2tETbWwWIXQFH2bU9hyJK
         wYpw==
X-Gm-Message-State: AFuF++nN9nGEgF15AYLDztS/RcywzsGYhP2a9px1BerEBZsm3/ph/6ID
	jdUWWbXM6pXiKuxu6amSgF09QY5tHJY+mEMl0bi8KsoXFGNheZbJQPanBmcXgnyDmhvari7WHVo
	CN6whWg==
X-Received: from pgcl15.prod.google.com ([2002:a63:700f:0:b0:c85:c772:c6a5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4e01:b0:3c4:1493:6822
 with SMTP id adf61e73a8af0-3cf84e51465mr19713083637.18.1787780004107; Wed, 26
 Aug 2026 14:33:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:32:57 -0700
In-Reply-To: <20260826213303.914988-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826213303.914988-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826213303.914988-18-seanjc@google.com>
Subject: [PATCH v10 17/21] KVM: x86: Simplify and comment kvm_get_time_scale()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

The kvm_get_time_scale() function was entirely opaque. Add comments
explaining what it does: compute a fixed-point multiplier and shift for
converting TSC ticks to nanoseconds via pvclock_scale_delta().

Rename the local variables from the cryptic tps64/tps32/scaled64 to
base_hz_u64/base32/scaled_hz_u64 to make the code self-documenting.
The "tps32" name stood for "Ticks Per Second" but was misleading since
it held the shifted base frequency, not a tick count.

No functional change.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 55 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6d9ff7eafa5c..f7d9dfe6046d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -940,32 +940,57 @@ static uint32_t div_frac(uint32_t dividend, uint32_t =
divisor)
 	return dividend;
 }
=20
-static void kvm_get_time_scale(uint64_t scaled_hz, uint64_t base_hz,
+static void kvm_get_time_scale(u64 scaled_hz, u64 base_hz,
 			       s8 *pshift, u32 *pmultiplier)
 {
-	uint64_t scaled64;
-	int32_t  shift =3D 0;
-	uint64_t tps64;
-	uint32_t tps32;
+	u64 scaled_hz_u64 =3D scaled_hz;
+	s32 shift =3D 0;
+	u64 base_hz_u64;
+	u32 base32;
=20
-	tps64 =3D base_hz;
-	scaled64 =3D scaled_hz;
-	while (tps64 > scaled64*2 || tps64 & 0xffffffff00000000ULL) {
-		tps64 >>=3D 1;
+	/*
+	 * This function calculates a fixed-point multiplier and shift such
+	 * that:
+	 *   time_ns =3D (tsc_cycles << shift) * multiplier >> 32
+	 *
+	 * Where tsc_cycles tick at base_hz, and time_ns should count at
+	 * scaled_hz (typically NSEC_PER_SEC for a TSC=E2=86=92nanoseconds conver=
sion).
+	 *
+	 * The multiplier is: (scaled_hz << 32) / base_hz, adjusted by shift
+	 * to keep everything in range.
+	 */
+
+	base_hz_u64 =3D base_hz;
+
+	/*
+	 * Start by shifting base_hz right until it fits in 32 bits, and
+	 * is lower than double the target rate. This introduces a negative
+	 * shift value which would result in pvclock_scale_delta() shifting
+	 * the actual tick count right before performing the multiplication.
+	 */
+	while (base_hz_u64 > scaled_hz_u64 * 2 || base_hz_u64 >> 32) {
+		base_hz_u64 >>=3D 1;
 		shift--;
 	}
=20
-	tps32 =3D (uint32_t)tps64;
-	while (tps32 <=3D scaled64 || scaled64 & 0xffffffff00000000ULL) {
-		if (scaled64 & 0xffffffff00000000ULL || tps32 & 0x80000000)
-			scaled64 >>=3D 1;
+	/* Now the shifted base_hz fits in 32 bits. */
+	base32 =3D (u32)base_hz_u64;
+
+	/*
+	 * Next, shift scaled_hz right until it fits in 32 bits, and ensure
+	 * that the shifted base_hz is strictly larger (so that the result of the
+	 * final division also fits in 32 bits).
+	 */
+	while (base32 <=3D scaled_hz_u64 || scaled_hz_u64 >> 32) {
+		if (scaled_hz_u64 >> 32 || base32 & BIT(31))
+			scaled_hz_u64 >>=3D 1;
 		else
-			tps32 <<=3D 1;
+			base32 <<=3D 1;
 		shift++;
 	}
=20
 	*pshift =3D shift;
-	*pmultiplier =3D div_frac(scaled64, tps32);
+	*pmultiplier =3D div_frac(scaled_hz_u64, base32);
 }
=20
 #ifdef CONFIG_X86_64
--=20
2.55.0.887.g758fc8c411-goog

