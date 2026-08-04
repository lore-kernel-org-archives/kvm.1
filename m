Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E2A47CC89
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886787; cv=none; b=LTk1m8A1BxnGx3SBPkQMK0XKRg316d1cd1n2Gl431rRgHbRr8GjZ7Cm3QZUmvJKlDhxuPqIY/mGLM9Qh1Mrim8S5P/K0Q8hHhJGhsEgJ0HuG2uWKo4VpbpOy5XN1WHQ/qR6WMSJJrOcGRTdDjVzFd1XFTJDRal3XqN6IsVz0SjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886787; c=relaxed/simple;
	bh=jk3Idq6KPZb6fR27iLsTnDj/FNc9cq600wFlmRCKtr0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NDxNjrYZi82T/rztG9x/GA9BLsq/wYUBRiSPc+MBixc595wpR8prryrB8pPBebMM9eZW0KxN04lx+eoSbyxCb/Ixm9mtFJWyLClo2bhPoNUc8czF8DmHZBzcGcfPeXCUKmmXszhhu3Vt5Vi97Xs4K+YDgl4mIYdNDvvJouHTAUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HYo8EkjR; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HYo8EkjR"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb5bdd8450dso204128a12.0
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 16:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785886785; x=1786491585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CKly7uqqnxARIiz4BbR0dueReH+dDjToiMJ3rjYyJts=;
        b=HYo8EkjRtwqv99cUe+tqK61dR6LGGnIupZaA5LOQ0649aU7Oqh7B6Lc8fa1Ms2qCN1
         9Ty6ZvxmMiPBMpLKTZJcIGlJ4wJg7pJ+lDOP87EeMniwCga8JJSayDYyMzvSA5t0KKzw
         slixm8aUkrslrTs6q8RaWHciSYpiczzKV+r0gm3VFK9uAx4m8r2xfzwT7L0Y8JmAma2s
         xmj/M6a9hh+tH5sbl3TWjJjEqERxmrIh+x0KW078nqrAmolXG7dllGlCGkdImTG9pP01
         9kdfGoNlCeXFmyYINsbnFjgB8TJfihiRGyQasHNjcUT9yP8CIejqFZ7f5JBO/933uY67
         tr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886785; x=1786491585;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CKly7uqqnxARIiz4BbR0dueReH+dDjToiMJ3rjYyJts=;
        b=ljZrCYGucJCVsj270gfwZWTno4W12eX4iwMkEcXhT5Z9RzcEC7LfMSbdPJ5WbFaNtI
         k8MBFUXR/gRK3M6yxW81+jc5UNQ+tzQ7/F74lrENEuSE4JYTDGoi5G3NLKBwzEM5ZuVf
         SrVlj3xocIGYNrzu1DksXi98VBXa6tWaevpf8+IIMzDc/xCQkN06r/0XbRLi8XdUtOrD
         sRVOyW7MoG09H6c96i8Pm9cZiGapNFIpsx8+0vJ2+NPQWHT6tPyvyqSJo4EuQ0sPyN0E
         8EX2GqMhIbRLv6izxjSf6jLX1nX81GuCy7JpmPNaGbn9oS8bFNMzMkT1fAJ6jxZVpVgR
         2GQg==
X-Gm-Message-State: AOJu0YzVN3add8RulESKO34CJlKvAW3+elSsoFZ9AX2cC6T/8gXLJtaW
	Kgxe97Al/3uCyn3+/tao3zFAtq1WzLm0danZF3Et83/ksBLsdsfSI/ZcNZ0JrJ0mSnEM1BQu+I5
	TVBOEJw==
X-Received: from pgk13.prod.google.com ([2002:a63:a0d:0:b0:c99:90dc:7b3f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:114c:b0:3c4:3767:adb2
 with SMTP id adf61e73a8af0-3cb85df2783mr2539368637.1.1785886784447; Tue, 04
 Aug 2026 16:39:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 16:39:20 -0700
In-Reply-To: <20260804233923.3504629-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804233923.3504629-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804233923.3504629-17-seanjc@google.com>
Subject: [PATCH v8 16/17] KVM: x86: Simplify and comment kvm_get_time_scale()
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
index cd438d06e4cc..02c389523f52 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -938,32 +938,57 @@ static uint32_t div_frac(uint32_t dividend, uint32_t =
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
2.55.0.571.g244d577d93-goog

