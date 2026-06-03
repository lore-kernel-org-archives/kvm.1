Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9DC4DD6C9
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 23:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528752; cv=none; b=EaK6rBmgkCl0gi6ho1J5jn48JBeXZlW49hGXye91epbYkA7CY/69U8WGzIly1D73f5THQQ38wKkozNVwgvnaF/0N7MZNsAqstuUqjcwfUsrVJ6mZKXA9P+mPfMjI+hDtESFYMH/JwKGJ0vVRsmOtBLGHLKkjHekQ8pRzhy2y9VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528752; c=relaxed/simple;
	bh=JlVNuBH3ZTrsFDPhxWaTdMzb4rxpIfWyCAqBn64489c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H0cTVAKW+vebHY2Gx8/G24gEGld2zxIb7e5wVwFh82IFplpdXBvIfJVD7ROnbyV4FZccCblca/TSpJUTYHcmuWT0DB4E5AfMC2ji0hZW31ynQy2g1mANCiO2qclEU33APl80E+pLzai4VKIX4lsV5/3eWLICMsQWljjCjSGAyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TjiWUoCs; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TjiWUoCs"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c3315d31so880075ad.3
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 16:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780528750; x=1781133550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XkLs+pFHj7cSRYqiRASqlr+WFuql8+seMsgEbvBQP6s=;
        b=TjiWUoCsD/HeR1kAtZMoxmGhImWMaA8YD0oKatFnLLy7tyZjtgyfOtdIzYPU3Xkxau
         A0LU9y6+v9PAoYYW0y595Ikp6jiCe1INeIWMfBc2679mwC8SD3f4TLjlviVticQoyXEg
         Z83DQMOtgcTfZ+1cOT2X3OfYHDlbnisaKR2iBThdfuvwDO2FAp4UdnTES3FWr2/eqq6t
         vzrWPhs8LWZJ+HgD1EqntgjSJd3C6kYcgukPzHkzqj4gjqSrbrMubFc1LLCvXsD2cTE6
         8PRAwo9S/xZkGYN2RzY04UcSu8/HNRTbGlrG2OjS72GiPL0nAPUTpnZ6GmSbSNyPC4KV
         TbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780528750; x=1781133550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XkLs+pFHj7cSRYqiRASqlr+WFuql8+seMsgEbvBQP6s=;
        b=pwOt5NgMLvIl6gmYQYs6kmkDUdlBWg56ixJR8Hi0YxXJcrUVoTS2rvQyuVgjTT0i2s
         BG/+8kOlAAqwkEAFCGzXcVfmxokycImFc85KHwhGoRHIRMseMNYUY1ToonTM6nH3sDTt
         zOJ8rz1vqSgXHK56gGi3N9sBGXdq9TtyXeyEht8xctF1XaSiS7GoGwdQMsM9hWN1MeXW
         tlQYlqTtbIxJcK1Bf7wjCHvelhi9nGEwnxT8wrT8+AM98UXHd2w24MMPN0twI1pJerZZ
         6HAulH181CLKV9hLq5oYvSUW8W7uHNJar6Owg3UHAa6/es/XM9tLMQTJRPd5dsSn5vxH
         Im2w==
X-Gm-Message-State: AOJu0Yw5JNvW5g2oySnErh7SgseO6mxOsq2R53NyHrbBQ+7zu8ULdo7x
	0nnuq7i0TNREH/yAFQ7BBpdOoGif/caIl2qChya9MeBJL2epRyVL1hxZ/e5Jz5vtXjGkDFoyaMJ
	Fo+OzLg==
X-Received: from pjtf7.prod.google.com ([2002:a17:90a:c287:b0:36b:8553:3c3a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d46:b0:36b:218c:719e
 with SMTP id 98e67ed59e1d1-36e32f1667dmr4975212a91.21.1780528749979; Wed, 03
 Jun 2026 16:19:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  3 Jun 2026 16:19:05 -0700
In-Reply-To: <20260603231905.1738487-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603231905.1738487-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260603231905.1738487-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: selftests: Add regression test for mediated PMU
 fixed counter filter bug
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add a regression test where KVM would inadvertently ignore PMU event
filters on writes that change _some_ bits in FIXED_CTR_CTRL, but not the
enable bits for PMCs that are denied to the guest.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/pmu_event_filter_test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86/pmu_event_filter_test.c
index c1232344fda8..84e4c6ca67a3 100644
--- a/tools/testing/selftests/kvm/x86/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_event_filter_test.c
@@ -731,6 +731,8 @@ static void test_filter_ioctl(struct kvm_vcpu *vcpu)
 
 static void intel_run_fixed_counter_guest_code(u8 idx)
 {
+	u8 nr_fixed_counters = this_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
+
 	for (;;) {
 		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
 		wrmsr(MSR_CORE_PERF_FIXED_CTR0 + idx, 0);
@@ -738,6 +740,10 @@ static void intel_run_fixed_counter_guest_code(u8 idx)
 		/* Only OS_EN bit is enabled for fixed counter[idx]. */
 		wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, FIXED_PMC_CTRL(idx, FIXED_PMC_KERNEL));
 		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, FIXED_PMC_GLOBAL_CTRL_ENABLE(idx));
+		if (nr_fixed_counters > 1)
+			wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL,
+			      FIXED_PMC_CTRL(idx, FIXED_PMC_KERNEL) |
+			      FIXED_PMC_CTRL((idx + 1) % nr_fixed_counters, FIXED_PMC_KERNEL));
 		__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
 		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
 
-- 
2.54.0.1032.g2f8565e1d1-goog

