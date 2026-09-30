Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D9577E27
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789885; cv=none; b=eSt7PNRf6OZ9MeK7v/LXXOwAUCkQAxI/JXrYqfcd7qRo33l3enJlPcKrGIumy0OPmkuche4INZpb4j3NqJKhs56wwBjBTbrgddllZ5hk920CqIzkICNReHCs4LT3xeKUlMnPk75mjWVTHqTbeorQfJV9K7O8Em1S4U8cknKwNQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789885; c=relaxed/simple;
	bh=g2BA+vl0utX3S9H1OAahngfqYLulsVSCmy7FzWN9LWQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IOIx8HVjbB4yKis/qGkhtcVKHRUmYLjCLGZjsONXYPaDfSJEtSQ92lOlK0lWR2N6EedHAPyGk6Y7qWTNJNrrVImcaL+fR+HVGf++iHXWMwCmjmTUlk3hSVp5ai1gPK9UkAiEXQNzNHPCWXel37kZLPgZy4x45AZf/uMhyeYGB94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qgsE0k+0; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qgsE0k+0"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e2e0bc619fso9240875ad.0
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 10:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790789883; x=1791394683; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+KSR5jfW+XsgFGPTweoWflcNEAQOrH3D7IR4fXAZB1w=;
        b=qgsE0k+0TNtvn2ryiN3nxaWsnGWFg/3HO7iawAj3Nbt6iICTC7JO+KgWgI0PA+/qb5
         R9ZPjvCTqorG/suTbcFNGyPVH9I9vBz6yXgD7QVwDCmNBqgIQLQLgaPipIHkG73kvG6o
         jhxa+M4yFp/hx4MWu2xcX8W4QJGxFailsnFPbNidu9x8WCqK7UqG6AjkHWZFgz5Km+TH
         qYtX24Jy9N+8Sp/GEW0YaiDiiuZD6RNa22t3gOYVLCmm9LBcJlm8OoT2upEGAALonduY
         SGyUjuZAN2nMf+qDZ4jQOwoZ/MXC1wFZpYqsfPnlQ6Q6bB7uwpE1pHK+8qPvU0Oll1Nd
         OyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790789883; x=1791394683;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+KSR5jfW+XsgFGPTweoWflcNEAQOrH3D7IR4fXAZB1w=;
        b=mEZZqzZi22k7Y9FkoEh/3Fw8GivcNfXmXKziwiZ2N723UsXI1EVSXaYQxFP0Hxgjrl
         MfN+QEsZuAvZoXpfZT6B2UI6d8D9A58T95E+lwcx7+98JKEZ1QzSvHOIVwhcMSbaywHg
         jJdctT3KoR8L0abLHVSTj+DGP/uEMdxzR1hRDMoyzmZN3HKOixMCvz/wumJkczNU2duI
         cm2t6FuTfVKaFgYK6FS2cS971awhSAIXmOFUn5a2R5kvbhhkXcxDDWzikoR6UP7b8hxR
         mlcoqGYb82UhWnbOoHG/wACJqQJrRBP1YwaMmjwMiLItlv1yHaqHItepWVsSPBT06Lmi
         I9Yg==
X-Gm-Message-State: AFq9FYJ3DnPpTRWiTrXhrKksNeoREjHF5Um/Klx2Jn7gq+dnJBPQ6ZFL
	1C/r8c9reVgnbRYDyFwJrmEKbozwuor+KivQrsHo14YrXNPzz1YlyE7rGjGJ94e76dYrcuXlT89
	TQwujVw==
X-Received: from plda10.prod.google.com ([2002:a17:902:ee8a:b0:2e2:cbb6:3b7d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf0f:b0:2dd:c100:424f
 with SMTP id d9443c01a7336-2e2e4ba6c68mr15266605ad.51.1790789882426; Wed, 30
 Sep 2026 10:38:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 10:36:33 -0700
In-Reply-To: <20260930173635.3362655-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930173635.3362655-20-seanjc@google.com>
Subject: [PATCH v3 19/21] KVM: selftests: Randomize L2's TSC offset in the
 nested TSC scaling test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Randomize L2's TSC offset in the nested TSC scaling test, not because it's
all that interesting, but because hardcoding a copmletely arbitrary value
is all kinds of silly.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86/nested_tsc_scaling_test.c      | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
index 571fc214c925..be6246c20d7b 100644
--- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
@@ -13,10 +13,9 @@
 #include "svm_util.h"
 #include "kselftest.h"
 
-/* L2's TSC multiplier, relative to L1. */
+/* L2's TSC multiplier and offset, relative to L1. */
 static u64 l2_multiplier;
-
-#define TSC_OFFSET_L2 ((u64)-33125236320908)
+static u64 l2_offset;
 
 enum { USLEEP, UCHECK_L1, UCHECK_L2 };
 #define GUEST_SLEEP(sec)         ucall(UCALL_SYNC, 2, USLEEP, sec)
@@ -75,7 +74,7 @@ static void l1_svm_code(struct svm_test_data *svm)
 	guest_check_tsc_freq(UCHECK_L1);
 
 	generic_svm_setup(svm, l2_guest_code);
-	svm->vmcb->control.tsc_offset = TSC_OFFSET_L2;
+	svm->vmcb->control.tsc_offset = l2_offset;
 
 	/* enable TSC scaling for L2 */
 	wrmsr(MSR_AMD64_TSC_RATIO, l2_multiplier);
@@ -112,7 +111,7 @@ static void l1_vmx_code(struct vmx_pages *vmx_pages)
 	control |= SECONDARY_EXEC_TSC_SCALING;
 	vmwrite(SECONDARY_VM_EXEC_CONTROL, control);
 
-	vmwrite(TSC_OFFSET, TSC_OFFSET_L2);
+	vmwrite(TSC_OFFSET, l2_offset);
 	vmwrite(TSC_MULTIPLIER, l2_multiplier);
 
 	/* launch L2 */
@@ -145,6 +144,9 @@ static void test_tsc_scaling(u64 l0_tsc_freq, u64 l1_tsc_freq, u64 l2_tsc_freq,
 
 	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 
+	l2_offset = kvm_random_u64(&kvm_rng);
+	sync_global_to_guest(vm, l2_offset);
+
 	l2_multiplier = __l2_multiplier;
 	sync_global_to_guest(vm, l2_multiplier);
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

