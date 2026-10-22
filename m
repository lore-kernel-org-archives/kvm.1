Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702914;
	b=Z5zUZUr6B6fn4iG6cwO4Xi3BPtNWnR+hyyELb8heRg4JBanl2qESev8dCD+jdiOU9MFP
	 P5SiyY/O528Vh6GPkSQ16eG6gd5mAqCZ6MXW5jnoROW04Epg/TIqPpeTRl4vegss1QU7S
	 M3hRGYITXVWHhpMwtVcdQQVEw38/kIuVDht+wZPpwTFf3XEftE8U8MfCbyucmTryTMGBQ
	 5L0i+HbbObS0xu2brs/SHsu1PXzCAzJskU1SeiUfpYdV3NirM9j4t+KehMiuFfHc4nfQ2
	 mdSkVbM1NhCszsuia/FYJ+5RgTS/vZe8dzEpJecR64kDRmObagfM929lzf2wh1u+Mhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702914;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=Oq8LnbfxGj58+AMKrtsZJUVrBg8Ev8BIHd1Au12gnbE=;
	b=1mzYHPcdJQMPkAnyBeaDW4Xm+qSpMpLssCbkA5zdS4Q1MZLu1WWXCWJCmaEF+JGmK7va
	 f1J7s4GQCHCQqmRJU+OxNw/LZOkPxAicgc9xnffbT5EG7eMzFnczvLW/oOK4+96ydAczW
	 gj/xj74rHQYGYDWzjy4NouBeJLJi7ca0iQILtd9R3vrsABNXsKtrmFkE/jdcY1JEminU0
	 eyIXakZhZkG/s0ZOwJl+GEaIPeQpm5eUtPrLw1Lft9Kf8qc71Xa4b7x4gh+Gq0ohWmIFC
	 M8Q1cv7rNEwHshOJ25DS+p+5c/Fc7ONvAjavpq1/y+PI2W2vFv8TLLAzkT6VDcmAcow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BIEcK2ED;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C742606A337
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 21:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C742606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BIEcK2ED
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ada8bc8575so372394a91.3
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 14:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792702903; x=1793307703; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Oq8LnbfxGj58+AMKrtsZJUVrBg8Ev8BIHd1Au12gnbE=;
        b=BIEcK2ED6hblV0C/s/+ok0EL/hnreWtMuQk7iF2jyhyu2HBGTE6whWsWahqEZDeBFY
         T7ysN55y1iheD4x0bPF3RNSzTaC+52+NFUiT+Eudg3HVQG38QF9hcDxRE9Ytx+4E2Lrk
         0oter0Qzhcb/7r1wIAuuI4BSUz1D+GBpJ9U1lPMFVguu2PyBwL5TFlDUCyBBH00EF8J3
         4CMz8RHQUxvYYQ4CkZ5r8vNyCfCuAIyUlT2nFj8E73RmSspiznDhQ1UkC8eC5D1oOKSJ
         n0CyySyIlOCPkdBzVEUcZYDpLJ4jQRkxWOO2uDctWy6k/am82H1IaHo8yaROXvWOlQXj
         ZlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792702903; x=1793307703;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oq8LnbfxGj58+AMKrtsZJUVrBg8Ev8BIHd1Au12gnbE=;
        b=AyXmALgs3qAdD+V4iYKdWiWTBUhlW/pG71cvSTZY0Nv+V86OqY1ClCADMs0c6pDfjH
         tiYJTVPttzF5TOpHARdCcGnWvNIbTyEAQxC9le8nbV9E2iWlc3vWlSk+usn8RFfJ9/Vz
         4GliZYcvSMxTNDjY/H6ZEUCndhqkzAhMcG7KCpKXQXdignBHoZ5x2jxXxHuEQtMF8TKy
         EqToHU26BF0b6ynFMtAgYGCJiCqjbenePvINoI6k9qc/LCjCbVCP0fI14koxyLnvNO9O
         ehJnFS6ljeCN9Qm1mlzMmwHiMrVndBw74IJWODgwn16fqSc5GiU8Rv6iJSG2xzotlMQA
         shFA==
X-Forwarded-Encrypted: i=1; AKwUvBxtJ/84sonGRuVnwlGejVVOrHHxbGv0if7A9zeKcC3EFXL+WFgoFOcZnu/qUMfQWkQ17bo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQYDv3v3Y/dJwWvoplcy0waE3asello4Uqr+DMl/hbx/z6C6yQ
	o35kZxNBYug5rnrBMgd70zmijHGwvnphNDXXPYT1KFNRLtgTFl4qtjD+c1BbixNWur2oTqwo8s2
	licapMg==
X-Received: from pgca6-n1.prod.google.com ([2002:a05:6a02:6386:10b0:cd6:9a71:5dac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d40c:b0:3ac:c024:b275
 with SMTP id 98e67ed59e1d1-3adcddb7bb6mr137328a91.9.1792702902649; Thu, 22
 Oct 2026 14:01:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Oct 2026 14:01:33 -0700
In-Reply-To: <20261022210134.612848-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022210134.612848-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022210134.612848-3-seanjc@google.com>
Subject: [PATCH v2 2/3] KVM: TDX: Set SIGNIFCANT_INDEX flag as appropriate
 when filling CPUID entries
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, Binbin Wu <binbin.wu@linux.intel.com>, 
	Changyuan Lyu <changyuanl@google.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Changyuan Lyu <changyuanl@google.com>

Set the KVM_CPUID_FLAG_SIGNIFCANT_INDEX flag in the kvm_cpuid_entry2
structures returned by KVM_TDX_CAPABILITIES if the CPUID is indexed,
otherwise KVM could confuse userspace and induce a configuration error.
This also ensures consistency with the CPUID entries returned by
KVM_GET_SUPPORTED_CPUID.

WARN if KVM and the TDX Module don't align on which functions have
significant indices, e.g. to help ensure the kernel is updated when the
TDX Module learns about new CPUID leaves, and vice versa.

Opportunistically add a comment to call out that zeroing the index when it
isn't significant is ABI that userspace relies on, e.g. QEMU looks for '0'
instead of checking KVM_CPUID_FLAG_SIGNIFCANT_INDEX.

Fixes: 61bb28279623 ("KVM: TDX: Get system-wide info about TDX module on initialization")
Cc: stable@vger.kernel.org
Cc: Binbin Wu <binbin.wu@linux.intel.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
[sean: keep the WARN, don't key off KVM_TDX_CPUID_NO_SUBLEAF, add comment]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 271c2f94b8dd..37d088f6f7a8 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2,6 +2,7 @@
 #include <linux/cleanup.h>
 #include <linux/cpu.h>
 #include <asm/cpufeature.h>
+#include <asm/cpuid/api.h>
 #include <asm/fpu/xcr.h>
 #include <linux/misc_cgroup.h>
 #include <linux/mmu_context.h>
@@ -163,12 +164,23 @@ static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char i
 
 	entry->function = (u32)td_conf->cpuid_config_leaves[idx];
 	entry->index = td_conf->cpuid_config_leaves[idx] >> 32;
+	entry->flags = 0;
 	entry->eax = (u32)td_conf->cpuid_config_values[idx][0];
 	entry->ebx = td_conf->cpuid_config_values[idx][0] >> 32;
 	entry->ecx = (u32)td_conf->cpuid_config_values[idx][1];
 	entry->edx = td_conf->cpuid_config_values[idx][1] >> 32;
 
-	if (entry->index == KVM_TDX_CPUID_NO_SUBLEAF)
+	WARN_ON_ONCE(cpuid_function_is_indexed(entry->function) !=
+		     (entry->index != KVM_TDX_CPUID_NO_SUBLEAF));
+
+	/*
+	 * Explicitly zero the index when it's not significant, even though it
+	 * _should_ be meaningless.  Userspace relies on the index being zero
+	 * (the ABI was inherited from KVM_GET_SUPPORTED_CPUID).
+	 */
+	if (cpuid_function_is_indexed(entry->function))
+		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+	else
 		entry->index = 0;
 
 	/*
-- 
2.56.0.257.gf7497c7d27-goog

