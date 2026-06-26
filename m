Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523B3C197E
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 21:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509745; cv=none; b=uBgNJ99LFnA3WsybLj+Ktbt9C/+lvpaelVqBLtzvaysBf6ZyglLVt39YoWWjHkHC+59t3ZiWo+FurIYKpRovvFhOXyfEJUF2SOlVtnEZYNluApcF8EyhKNvnZseKIbLBp7XeQ74AZJHwRMHnURdIVVgr2cgSFeKbOoa/6MLrsrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509745; c=relaxed/simple;
	bh=b+6vXwlbFetE4gcCaUQZiIdwXOPNKHYqQd9n96GIV8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cvfYJ7YM5ThE8mP851QldICVtV8vfZuJsCqaWm3GgIU7vT17nRJyScqgs2cO6ooI7gPQfafi4e3CYIQd0mPJJKN2rS4Ibm0hnxh5ZPBUdsXPyXsmNCvtexuPAk8loXQJfQMqG5UIOrJjImn8haA0E7/42Nx4/V71nlBDT8GO3yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EvECgyVm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvECgyVm"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c2c98c1be2so8472915ad.0
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 14:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782509743; x=1783114543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qCGL317mUr/viDiHdvHr/Nh+V34QOpSJDtpLpPCiKc0=;
        b=EvECgyVmooT0my2m+AhG5bg5iJ/w3tp404DJaAGIP2meoZjVwKtyO4nWwJbGR9Xcaz
         nVHA25J3MCYQvDZpxlQA9DPGQ2GVCIGrGDyXlAprNHvD3mgxpt24Ta6vmwZkbTMNHxk7
         87w6cvKWkQDJj/m5VuFlKqwB91xDgBaZpgZ3Y4LM/8sAobSwpZIk4Csk3E9QHl59eTx2
         0A8adFeMQ+3Tivz6G22o5/UtwhQWmoYo9U2+bYhs6lkqyJwAS4tkh5LCHFbZn9wXCOkL
         xWFNUjvBxCDYv6qhQXnljAQjNMWAJBIi6Au78tuF6PtQN5nZ30yD1ZJ5LbkExc7HW7pF
         6jnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509743; x=1783114543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCGL317mUr/viDiHdvHr/Nh+V34QOpSJDtpLpPCiKc0=;
        b=spmE47RH6jV4P/Me6WbXBt1GERnU/FIlgtgsRNGQSQHhKGlbvxT/9rhXsmsPaeX3F3
         AMipL6eJ/CVeqeWycqTo/GbfqQaCi7krSL+Yj/9+x7Ex4n7xzAu3sW+egYoxcolPK4dn
         JqyZbeIcgAl8kVhWUaBv/665eRI1mFtwrq6Z8nS/psWkCPU22qgZyQZefdeBnVEFhzOd
         AMgbp8c0D49E+6awqMH1duA569xCNMLI8YGot+tzYNnqoSEtRiZwcUsfE7M08HHWpnSP
         5A/VoODhkObBq+2qwjZ4pPIIrqJO+3I+WdW3E1ytPIUAtmazD83td2F88FbPdFLFX4ZH
         usLA==
X-Forwarded-Encrypted: i=1; AHgh+RpuCKawOHxlMImplhOlt5TQ6tfVRywpckfCrkvJN4RN4+XvRUQk6n9LgLiK/Yeh8MCTWVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo6miKmWIO4rA22BBNWsJxBUR740viZ0NPh0OWYLQpcYSiKRLq
	5v5XBkLAYtCGjA1vA8uFNcNmTRhCF15sQCetRop2gBbS/Q7fwJJwskE72fGKk4+HqksFidgd7KO
	y8glfqg==
X-Received: from plbv21.prod.google.com ([2002:a17:903:44d5:b0:2c7:f68a:7995])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce87:b0:2c0:3400:5c34
 with SMTP id d9443c01a7336-2c7fc75a558mr80368325ad.3.1782509742779; Fri, 26
 Jun 2026 14:35:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 14:35:18 -0700
In-Reply-To: <20260626213534.3866178-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626213534.3866178-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626213534.3866178-6-seanjc@google.com>
Subject: [PATCH v8 05/20] KVM: selftests: Seed libc's RNG before using it to
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
 tools/testing/selftests/kvm/lib/kvm_util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1016865d3f7a..277166ab1aa9 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -15,6 +15,7 @@
 #include <sys/resource.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <time.h>
 #include <unistd.h>
 #include <linux/kernel.h>
 
@@ -2284,6 +2285,7 @@ void __attribute((constructor)) kvm_selftest_init(void)
 	sigaction(SIGILL, &sig_sa, NULL);
 	sigaction(SIGFPE, &sig_sa, NULL);
 
+	srandom(time(0));
 	kvm_seed_rng(random());
 
 	kvm_selftest_arch_init();
-- 
2.55.0.rc0.799.gd6f94ed593-goog

