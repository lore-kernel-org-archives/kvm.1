Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D850642DA39
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402527; cv=none; b=AqyMnwspxKyTRIPsBLTU//IkW7uuZ14mP0wM4Gn0155SBDw8kGg68by1K0jHVpDHMpYqMu9ilqxMa29V7Jh7iqEGDqMONI2VzqujPlVpCsgsq3d0I5c3baqPjGqFZQU+MXlq2WDd+KpNxi0rZTomL/uMO/riNzFKj8rD5gycgkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402527; c=relaxed/simple;
	bh=8stmInZqKeF+zWzG+qsqlrTvQz23kM/mBIRU+hqbvBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rp5zJPtKz/SF7lab+f9aqmIxK/zicirn+9tv7y3bFiQ4RHxfFII3pxdfxEbZhjDo54dG5xrT9nIeW2E1pr7MEr3nvanneQOnlmR6ysyy+h/bvzDvCMGDu6DuVN6VXSLP6/6493qNok4M+M0t7yh2CcG5k+Zj7Ee0YHGxMQUADcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rBBn9xMs; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rBBn9xMs"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84eccf9d899so3425781b3a.2
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402524; x=1787007324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ae4gt5HyKD0FAFiH5hYPOm4wz/iCyBWNSwEKCKCHkvQ=;
        b=rBBn9xMsptu5bnsVILWh8PdFKFbWpMzrsQjBsAkT+Zjd4xp7I5fYanL5bQV38MzK9U
         Wx43m7RJ6VruwBIJkIs9dgFmaf2I7RoPZeOBDDub/5z+TWSbfp0pee6hPElHsfbaePRT
         Q3wL3ZjNrpFVm1Fe+pyj0BUp4tquxn1viIQ4y8Qjdnou6L05PCSFkvK3TgjyjG6CSrOj
         mKiTQeIGS/O39Qunu+7G9OGOZ+m8JLkvNDEALsJHAIhnRQNFhe7HgQTKCiUottgyHDlP
         5SSojFfi+R04T4CprTIb1iQoQY/qyEQkW9HY2UyiTpc4Z2E07jw7crZbp5fJhRI9uDhr
         xpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402524; x=1787007324;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ae4gt5HyKD0FAFiH5hYPOm4wz/iCyBWNSwEKCKCHkvQ=;
        b=YlDt24d1C4nJwUTo56bi3p+27zXlSghhn9D7JnWjl8b7OuNsyOqRTT5CT4yoiyp8GG
         msDMRDoHxShMFjJKO4LH9kYzjRSi3eIs5znKLCzA6hCnzgXexsR4iPXxiO8eozroSoeo
         wm8dPudclla6XOnf8FTBPMdPMqf+g4OK2XOBRWkPmhMqN7fSvWbOfvYrFITMMpWG103F
         meQl7HBElUZIETQ81s6NT3reQkP1+XKRc9R8ZDIABE1nfC6cK0QyvqV/cuF4AJPT3MNv
         FReXeDi1kgnRlvlS3H0hEKSBqTol3srMjnp5fGUTzr+9n5MamTBVnldWvbhP38DTIK/G
         BdAw==
X-Gm-Message-State: AOJu0Yy0NYDOsxIICyhEP+oIDRYcDyZq+SsNo1/z1/QMXM1H9cjpo8O3
	dZOt+e4dYCV+KgVTaB5L16OJZ+Y5v2aXGiO4Tjh/doa9dUv2XKMas49dt1qrQWVmoliQDFMnjkN
	MX9mNMw==
X-Received: from pgbeu25.prod.google.com ([2002:a05:6a02:4799:b0:cb3:9a4d:501])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4287:b0:846:bc60:5bf7
 with SMTP id d2e1a72fcca58-84f9c8d86d9mr6120918b3a.6.1786402524047; Mon, 10
 Aug 2026 15:55:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:55 -0700
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-18-seanjc@google.com>
Subject: [PATCH v9 17/21] KVM: x86: Simplify and comment kvm_get_time_scale()
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
index 56c2fe11d866..7661c49ccaed 100644
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
2.55.0.679.g6767b8d81c-goog

