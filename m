Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EABC3EFD15
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402512; cv=none; b=iSQDd0oBaQ/gf5X/UxGKAsYOdCEjGZ1KGhhIFw3C67+rU6lyGORMCqyIlU2y7RPJojOobCj3+9XEXWQ1jmtPi+TVc6WSY0K8Y89KZzreWfMbD0qVWaRpL5oxyfWj3z7NR1EHK80nZ7D1l4MjA+hiQP372v8WVuRvFDHgvptU5QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402512; c=relaxed/simple;
	bh=DBhEkQVI9NQRI1+LTosIl2HwXc4QsiNCRGdrxKptqFM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ig86czt2pRiQ3fnrIYvimZr2GRvN/G8A57wGud4fabw2xUk/mw+4EDHvREUoYdtLbOMCd0WgRBbpnku87yi7giHv8DZ7FPS2z3oXFrIuS/Ncg9cuAmJmQvxciMz9qOBJ+vxT7+JADzST88PK9/h7uSB5pMlNvMYZGQ8bXN9NkLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rbnG8I8z; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rbnG8I8z"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfa4e4684bso70383985ad.2
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402510; x=1787007310; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MCnLQXakLIHuM72bNNk8nqJeDhUwND5FLiRLpavLCaA=;
        b=rbnG8I8z2Mnhbe5Cla7pA4L3CKaELwImMjErJmSJxvzMmIxLgjvreR5b/oLKfSFKyI
         P8yjqn4ng5P2sGR+qy1DnuSEikYNywkYswXbRO0LlGrAyfRP7h1uDTPNJUnB6WYfkGo4
         B64Rcs/0BmNFXgEop1fK0jR/CaCAb0vyZSs1xAf8sMj8BG16XYy8odGEomqASwM462Tl
         PcrFMZ+HmrPayu58wJgXWL20vIwPwqRQd31w/0cMFTmM0IgZktPo4cot0Mjod3c5IUSJ
         WOTUEmqH5JHHn0b3dN8nEi4O3i/naIfj1T/QsHfoZHouMVSadWfyv/KU/vnxj+CXCAfQ
         /ZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402510; x=1787007310;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MCnLQXakLIHuM72bNNk8nqJeDhUwND5FLiRLpavLCaA=;
        b=B70owDv9lTAER/8jpzjr0f0cCdBpIOBwkjd9Rcqs1gok6rDCPXCqEPlO2QWLnmsmj3
         ONjXgGQPuI4UV1GJY3LRgEalOjo4CodxS92dq8JxQVh7pDUa4DCIVcNNXDxrH9FUVath
         qVZCZzJo4wVoPkf2XJ7hAdGg+tmGj2ZdQ73hapVbfEZ6hZ2glmtLWB/Xh3DFvnSEn4gw
         x6fMAQKoWyjcxz+piqkVvcuvnJM9BndP4d3c+galCRt+qnpL4Sg+5MCOSiXqQMxha8YD
         sP5IG2F9EUkyDAxKPED5FjdSTk4/w07hvDzbni2iWlenE9z3kXUCsYk6XzD5R/pgm52q
         90BA==
X-Gm-Message-State: AOJu0YxwVhV14oqrY4CEcM29jciJWNR5UiZ2xWD1ae7Yv50Wv+sZv/Js
	3Cc9S4iZROnIoDUVuQDc3Io+KCDAPkSVIf+zwxPOEpcmC4uv8Wey2gXGUIxJreaAQzCf/as3/5k
	141sC4Q==
X-Received: from pgly34.prod.google.com ([2002:a63:1822:0:b0:c96:acc6:54d6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d38f:b0:3b4:8bc6:138
 with SMTP id adf61e73a8af0-3cbc03b5526mr32318219637.23.1786402509474; Mon, 10
 Aug 2026 15:55:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:43 -0700
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-6-seanjc@google.com>
Subject: [PATCH v9 05/21] KVM: x86: Compute kvmclock base without pvclock_gtod_data
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

get_kvmclock_base_ns() needs CLOCK_MONOTONIC_RAW + offs_boot. Compute
this directly rather than reading offs_boot from the pvclock_gtod_data
private copy. offs_boot only changes at suspend/resume so does not
need to be atomically paired with the raw clock read.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro:claude-opus-4.6-1m
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 137a1dd2b85a..67c762b3bf28 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -930,7 +930,7 @@ static void update_pvclock_gtod(struct timekeeper *tk)
 static s64 get_kvmclock_base_ns(void)
 {
 	/* Count up from boot time, but with the frequency of the raw clock.  */
-	return ktime_to_ns(ktime_add(ktime_get_raw(), pvclock_gtod_data.offs_boot));
+	return ktime_to_ns(ktime_mono_to_any(ktime_get_raw(), TK_OFFS_BOOT));
 }
 #else
 static s64 get_kvmclock_base_ns(void)
-- 
2.55.0.679.g6767b8d81c-goog

