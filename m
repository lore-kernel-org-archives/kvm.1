Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356413BD653
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784155239; cv=none; b=s22trgjBcn67+YgxkapsH4Bg9fHHegJLD+JouC3kR7leSYCVNJMjoYLJ6ZlqD6A4rH8CWzM/W9sk0MmGUfgsS41O+XE6cQ6HEXLsQtAE/UeHkExPonbRpEdHxiBtM5jTJwDPEi2+V6SxMr8NwhrvK2IEUJxh0/nZf1IhKbItjZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784155239; c=relaxed/simple;
	bh=xAkfpEdvUgkCdVqkyVz40Xzle18wJ1ItBzFFye8jmmY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QXFR1Ipy+Sv/hLQ6UUUPdCVYhxk5g/TEYtbU+Ef9nt+vsnBfTSpsuQVe6rwSSY/tKqtEZKl8LJ6FWYW1hfus8pyk4VoPhNu3e3vtCffwy8phVHJFRvmeGZxU8gI2gybpyh3x2ijssCuRCtYKU0bd8I6+JNt7oKsjtS+nHyglCsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aYD63SqY; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aYD63SqY"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-38dad28e86eso5818486a91.0
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 15:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784155236; x=1784760036; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qJyOrMgYRrGuIFIsQ5A5wPlvhyj4P3BpMK0WEUbzRfY=;
        b=aYD63SqYMYYwoK5WCr1JGa4FA4WY48Oia87lGsPdM7Ej1tcwSCvHsrCHNZ9rVL2aPi
         /Z3YhTLF5uzuBofvdrzHuM92YQaPV32JBF+KjQBwS2VFi0jAB/0iK3lS8UOIg5q0oYfO
         mtpSu0ZgQ8SLgWKXsz4W5llTgJb8uADHvH7Q7JkXJ61hheWLqEs4XX8W7kKz124+ankY
         WsH9gsYpB4XEGs1A6wMULNdR08zZcMlPph8FSf8RY2oneo+XoPyPS/8jy9fGVjoGmxnM
         5nrEJHJeNUBqPybaN+YrzKm09MGtWFRFI9LT4SbgKiabeLKwJZSU+zH840uEmvFXAySG
         cqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784155236; x=1784760036;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qJyOrMgYRrGuIFIsQ5A5wPlvhyj4P3BpMK0WEUbzRfY=;
        b=r+GWeS6MzDnDh5UNUoWfzuTwmjCwaJnioDGPN5x/OrpipUuYiz2ck0rl330jFYuU1m
         M4s2Rdg4lFw6XqvkDWjEeCCBZ3KHdmm0e4TeaaH2/rq4pvvhbfL9IQvG1/EwEi9hJtda
         6AESYcAFZBSMp0EAGI2XwFqWsLajug+m1BrLZRjTxIKCnQ+QWYSrCI2j4oJqCRndyywi
         NOraj6vIgFGmIiLWretZ9B8PMrtFMkfCFXX0UFys28cgrdEQIdK5C6qYs76h3e7udnzM
         FyAjcryH/Gzu4XuYmxyBErWtQOw31PhhnfAgkLWf8dKKtCxWO2WQBtPJ1C70N+ab5w2j
         Yx1w==
X-Forwarded-Encrypted: i=1; AHgh+RqKwnLzuT4hBjt6RLCsWoq7e/w54uv18wU5tA6rN0yQgYHiSLYclUQ2Se5RUzjCTUo8QsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywacsxju/AmcmR0NPJS6jY2mcVtHRn0TS1R9Z12mVvxfcWuSMz4
	YYr2qx/2ZThIdgCxE0OekavAaQFiKI3qnwfvQAsvJ/ZQgNpcGhEk5Dsj5jhEuRDYBGxZE7Pp6xi
	ug9bewmoMjm+PXw==
X-Received: from pjbsn5.prod.google.com ([2002:a17:90b:2e85:b0:389:56ef:75f8])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c4d:b0:37f:d70a:9605 with SMTP id 98e67ed59e1d1-38dc73bccedmr17829702a91.9.1784155236276;
 Wed, 15 Jul 2026 15:40:36 -0700 (PDT)
Date: Wed, 15 Jul 2026 15:40:30 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260715224030.3772948-1-jmattson@google.com>
Subject: [PATCH] x86/cpufeatures: Make AVX512_BMM depend on AVX512F
From: Jim Mattson <jmattson@google.com>
To: x86@kernel.org, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Nikunj A Dadhania <nikunj@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Add an explicit dependency between X86_FEATURE_AVX512_BMM and
X86_FEATURE_AVX512F in the CPUID dependency table.

AVX512 Bit Matrix Multiply (BMM) instructions operate on vector registers
and require AVX512 Foundation support. Declaring this dependency ensures
that if AVX512F is disabled (e.g. via clearcpuid or host capabilities),
AVX512_BMM will be automatically cleared as well.

Fixes: de0bfdc7137d ("KVM: x86: Advertise AVX512 Bit Matrix Multiply (BMM) to userspace")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kernel/cpu/cpuid-deps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 99801e844b30..e9fdf944633b 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -75,6 +75,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_SDCIAE,			X86_FEATURE_CAT_L3    },
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_AVX512_FP16,		X86_FEATURE_AVX512BW  },
+	{ X86_FEATURE_AVX512_BMM,		X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_PER_THREAD_MBA,		X86_FEATURE_MBA       },
 	{ X86_FEATURE_SGX_LC,			X86_FEATURE_SGX	      },
-- 
2.55.0.141.g00534a21ce-goog

