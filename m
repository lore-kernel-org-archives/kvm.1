Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A31B1CAA65
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310042; cv=none; b=kNfRFr+bCG9AjTlTmvZe4xD0CMXqz1g7gbt1JQP93HinS6MiGPTZi6qi7jEedOjUXZQWFZnbRDpzWBtO7itCinnzay9u9eBfWjB0GLkCqy2yubs0rRx0XrQHhgahLzel9TnPxA6m00iFxs8CaWiB6FLMzERe4KIwqjUqM7WUXHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310042; c=relaxed/simple;
	bh=BGbTT4pl8yUU48pWeQdBQ3HUUQ+YTavKqvYo/o9BJDo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oqHQuQO/K51s3+6sBT8PlHRqMPJFPexc9P6H78azOySgsTQ2d1eqpaukAwaU9+eawmekS31EVdIupwSmnWQ9nSyYQxTnUZsukBsR3ZNFPajLZ2Sz/GggR9Zxz4HLD/aodr3EaPXw4jQlnWnZoyU0VewxHyigKE/8Ok9g/+CsQzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NJJPLQH0; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NJJPLQH0"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36db995d083so1046713a91.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781310040; x=1781914840; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5Gdhr42TK7HaiENwXEe169i/UA5JDaTAaZr1cyLBuko=;
        b=NJJPLQH0mCM+Rz9zv7YLrjWr4O3wvAFrQANctPo0W7S3pzQ6GLTJDAT/xVBCVWHLnP
         lKopncWq7GTRR5Pswia5vRrLqz9owtb64vswlr9zH/J9g8AmMns7VcE6ZYM4Ih1TTxJs
         P2hBASgd0qza9e1dzdOmd8mFaKSqMXpQCUgPxbzPUIBMgLIUb4p8vteYrkoo/fv+844K
         OVFIGXET8Wnyb/Vomh6r3RvPsCb7NBM6hrLkMftp4noNR30p/LNC/br2q4QSkhZvd4lb
         3V9a26iAmxbEDahd0Y/WvPfKbubbbVGH1mm6TyJDTZsu/N79oH4rGpz7E4K07d3L7OtG
         4e0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781310040; x=1781914840;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Gdhr42TK7HaiENwXEe169i/UA5JDaTAaZr1cyLBuko=;
        b=cohZuVgodY9GYEKrKS5S6iXK4AiuKe3yawXHmARk3Z9khwdOFngDr3i6usIrT9CG3T
         qmdV+YAYrxgQ9G4rQ7sDeWS6wEPcughfuUsV5krvHEE8fVX8nQnosl8VD5Lf3ZWUzFkL
         UkEZwEodgRFzALHrDy/dC6E1OIinEQVPb+qdC48MGnLuWqf1ByWVUrUXremQU/nAE05s
         Zi2U+pJQh9TeTwIJr16E/sb1l09lCOJMRZzMt5bNAyZ3eGOt6SRv4KCvbL1Y7U5GNaoh
         974GcKbtjs2jpYiTjkA20ifuOvyeIVQ806Zk4bjL6v+5g/JGWCZWERhUUL/Z/824PU8d
         aiPA==
X-Forwarded-Encrypted: i=1; AFNElJ/2oRTQEmbLKy4qw3OAPeza92XfCHheR1h1fyuydnAaNH5wDa7tsWqEpKy9iW9quhzmlh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsOsFQvmUkgFl3RhqdD1mTVt2gjS5cv95BgIB3jWye9FxvQMNn
	HcqRSPR5+777GXPyeNk+VE+eGMVoqxGt4tRVYLRR0exP/U/Nng3HOiA92tq9BaC804+jAWoTuhJ
	6pKBHPg==
X-Received: from pggg6.prod.google.com ([2002:a63:2006:0:b0:c82:798f:628b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:dfd0:b0:369:2e00:1ff0
 with SMTP id 98e67ed59e1d1-37a024176dbmr5248980a91.6.1781310039710; Fri, 12
 Jun 2026 17:20:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:20:16 -0700
In-Reply-To: <20260613002031.745413-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613002031.745413-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613002031.745413-6-seanjc@google.com>
Subject: [PATCH v7 05/20] KVM: selftests: Seed libc's RNG before using it to
 generate a seed for KVM's pRNG
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Seed the RNG used by random() using the de facto standard method of
srand(time(0)), so that a different seed is actually used in each test run.
E.g. without seeding the RNG, literally every test on x86 will use
0x6b8b4567 to seed the KVM RNG.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1016865d3f7a..2e08d9fcefc7 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2284,6 +2284,7 @@ void __attribute((constructor)) kvm_selftest_init(void)
 	sigaction(SIGILL, &sig_sa, NULL);
 	sigaction(SIGFPE, &sig_sa, NULL);
 
+	srandom(time(0));
 	kvm_seed_rng(random());
 
 	kvm_selftest_arch_init();
-- 
2.54.0.1136.gdb2ca164c4-goog

