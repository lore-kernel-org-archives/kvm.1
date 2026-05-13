Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B103EAC9B
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665011; cv=none; b=qz+ttcIlKxjmGcgfix6mxvrfXfJxRisxzliis4jp8ECqWYJOUZLwXAXFUvSVxnXp3SOd+fsx5M28Tm3jz7sGTvdcNDZiJzcPo8On8BEI730bFmczn5//mD0H31oGxSMQOjXYz851eDFremKCoOjOLetwzGIutZsxsgxEB4auXwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665011; c=relaxed/simple;
	bh=wZJWjnqIbm8WDtqhSpFj+q2nylcM9L473xSd9G+0pUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DzWCkIVQqvn/Ia6EaUx7+3gAioUAQ1QL4Pr/yyc2UQnMDmhN0/rs/W9d6XFuYWsLxmOQOGBoptl1OMUnO3N32HrsBmxrcOUbC8ENq6z8WfGtjgBIqOJtOOI2ivsI0ASvGnkZzRhms+O+imDibbNgl3ZlZJBKpVuE/l7LBawUVqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaHrVgqv; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaHrVgqv"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c8f9846c8so9601598c88.0
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 02:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778665009; x=1779269809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMLcF3QpmorqUOiR9XBa4GuV1rXFYpYVsToIbq6Xxoo=;
        b=IaHrVgqvHRLEcqd/mh1pC17ScnAtyic1Sse8spo84EYjUy1fMn0HeHB/BetVEG+ojL
         PptDRhwvUjSbBLJqxpDjpI/TNbdWTfTa5DuU8tJa8nD7CGfMwfhspEicixYj2jlWw/Co
         U1ilxOEdaamE/k4d9XrvXsXH3BuIAATlfYBq9tP6wTof8E1o58dgyVdTp8uc10YyQQhW
         tNumKX1ViJMDOubN2MExKBsrnSs1SKR+LgAV2d3LnfcyEUK0eO3B16tqEsLbKn0Rc1ol
         QOmfObvX48RqkAAj794euS0VcF7jFarKm/xwyTuTkc/dNw2yb+qu4IVBhZgo2RfSVHxP
         +bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778665009; x=1779269809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oMLcF3QpmorqUOiR9XBa4GuV1rXFYpYVsToIbq6Xxoo=;
        b=Eb5rSFv15fhQmzDfGjFTEY3BqUxrvgKQEnoQggWySVLa0oSDXoywoCPvPtDLhQ+nEw
         JSQKMsLwhK+Rd87pj+l3XoKIXQi+tjmDGBDxAnadDYmJgFa9zWCd7386hVW//cRzGN3a
         cRvE/ABSN9n2cyquKeiI586exSzJwRaOMkimiCnVJsJbIN4gU6kzWRLin10rWx/Ps4uR
         8i7gcpTpGKruHWQ//Q43Lgx90yaaEWulJ6GjXYbA2d+FMPa+Hvtojcmhe50W0P7uvkQP
         I2znQ+WwGssIZj1sRK87OfR5oRC0ax1q7vBbGaLLvj5vZcX//byvITPJ42BSdXxr7M09
         ZSiA==
X-Forwarded-Encrypted: i=1; AFNElJ9D8kGEIzTtx9Jw9+j6vK09yOL604/Kfkor+m4mTX9ATNSKlziLmNhYl4Ru66T+j4R6wdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk8h6RIfj5lYvMvfwdR89SiV4IL7wANErM8IzMugZeGAd3Tn7w
	do9FD8K8miEFCH9sjz3Qp/soA6ozPh8Lo7bLpNtgv8OgIdbMy6QGtps0
X-Gm-Gg: Acq92OFFzgr9pZ1SH3N2dDG7tjfNkx3Hdvk+CpUAlEFz+dn0YrBHaYmulkG0irki47p
	V6j6KIdRqq6H6eB8KMYy0z+NPfhTzf6zRS3WfnYeOBUm4Ji+5F6+eO/Jc4ywZ8iH1f6HrX4mAIe
	CU/Y/t0z8ZHFb7OJLuPpbUwm3Gx1FenHoqbN1tfF1VADOO7ohLaaq/UUaWYdQ5TlLK8SLq9aaDO
	bGxxoQ98Ed9Phw3xCz2NZjVkPDBt3nA0wJW4Rk8hzDeMXpU2+d+eQqnLMWb6nGSU4mFWrdUs4VK
	X7EaUzcBvT1vaK1BSxdCW/SURhkVXhhcZr4kaaQidvQeqF37PcD7TaT48Be4d+7JstPg8wzHIpX
	T3N0fbgV0xLp9H5ZAowmIblryXscVkZ23bSlGuFmOrParp6+hs0RKkqGwJ6ikfalrmjoIBx63WH
	u0UU/chB8QV1VoihDeMgE4jjTZCHYBS+OczKb79Y4O
X-Received: by 2002:a05:7022:61a9:b0:12a:6fb7:8801 with SMTP id a92af1059eb24-1342ef46646mr1347803c88.14.1778665008685;
        Wed, 13 May 2026 02:36:48 -0700 (PDT)
Received: from ewan-server.zhaoxin.com ([154.26.185.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eb4b7sm22100439eec.2.2026.05.13.02.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:36:48 -0700 (PDT)
From: Ewan Hai <ewandevelop@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: cobechen@zhaoxin.com,
	tonywwang@zhaoxin.com
Subject: [PATCH 3/5] KVM: x86: Expose Zhaoxin RNG2 CPUID feature
Date: Wed, 13 May 2026 17:36:31 +0800
Message-Id: <20260513093633.1608334-4-ewandevelop@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513093633.1608334-1-ewandevelop@gmail.com>
References: <20260513093633.1608334-1-ewandevelop@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Advertise the Zhaoxin second-generation hardware RNG to guests via
CPUID 0xC0000001 EDX bits 22 (RNG2) and 23 (RNG2_EN).

RNG2 is exposed by the REP XRNG2 instruction (encoding F3 0F A7 F8),
documented in the Zhaoxin PadLock Instruction Reference, subsection 1.3
("REP XRNG2"). It produces random bytes from two on-die RNG sources
selectable via RAX bits[10:9] and an output mode (raw vs post-processed)
controlled by RDX bits[1:0], providing high-quality entropy intended
for cryptographic operations.

REP XRNG2 is user-mode and available in all CPU modes, with no
associated MSR control. The RNG2 and RNG2_EN bits are redundant by
hardware design (set or cleared together) and both serve purely as
CPUID-level feature-presence reporting flags requiring no KVM
emulation. Both bits are advertised because different software may
probe either one when checking for RNG2 availability.

Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
---
 arch/x86/kvm/cpuid.c         | 2 ++
 arch/x86/kvm/reverse_cpuid.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 8aaa3f20670e..087c41341240 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1286,6 +1286,8 @@ void kvm_initialize_cpu_caps(void)
 		F(PHE_EN),
 		F(PMM),
 		F(PMM_EN),
+		F(RNG2),
+		F(RNG2_EN),
 	);
 
 	/*
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index a1cd9116ef63..859ba43126d8 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -81,6 +81,8 @@
 #define X86_FEATURE_SM2_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 1)
 #define X86_FEATURE_CCS			KVM_X86_FEATURE(CPUID_C000_0001_EDX, 4)
 #define X86_FEATURE_CCS_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 5)
+#define X86_FEATURE_RNG2		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 22)
+#define X86_FEATURE_RNG2_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 23)
 
 struct cpuid_reg {
 	u32 function;
-- 
2.34.1

