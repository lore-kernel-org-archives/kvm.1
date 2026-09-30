Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E7852189F
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789866; cv=none; b=Ml05ZuUi8GtrYejLcML5lY+pRN+ppwTNYqQCEelIAzFjQXgPK24qHw3/zTlKJrhvVrtDilsmp1toPvN8u6d7IGwhOxUEuU9c0p3d11HaMxIaR5TOlgZ+TLZcc/ilOpEwfcxlijz368NvZV0YW1KLBXsdKCuIb1MVlT+wLDeqoEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789866; c=relaxed/simple;
	bh=0JOwBc99J9/9qmxWmTiXCeWNmLRggQ1H5uYAvG+hNl0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GAZ4pU+LsVKy0fOsVehHH6+23Iqm3spANaEFAaTcFu901XOXjRJO9D9ZhcL01sWuzmq9IodFwSl/KcPaQ3uxVJ1+LnthrQd2W6a+8/S5tKalfYi5lFJBNMeRsqYz4dsGDaiAq7CrXndBjabXegflgr9rjQl1hZ0HI0U4lWlHoBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mcfqOage; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcfqOage"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e2dc7312e5so10451685ad.1
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 10:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790789864; x=1791394664; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GmNmDWcyjlu/BQcLFlm+7ZVraxBuV3+MA+EDK8nxdQU=;
        b=mcfqOageZNmk1AsR2C9/JwBQ0uHi4qMRWZTMCr5OsQGC/g1HQq658VZ8+jg7rUAWK1
         1NDkFCk+JbvUcXXBWqIWSlP2MndilmylTFIb178Vy5Kctbir3YZg91OGni4MhrAbMuUx
         e2DTCQVfTuT/EzXCpKqBAx1Zff6RxWmU4E2iX6/Ve1fzGcitWZ72lxz/7sBMj5FyHHRV
         A2/8hoZUmRAjodb6+ND1qU3AiHq5Us6jrIR9JkQNrvkv5Kg+NG1Uk1iyKBobPJ0Tjl/z
         EXNa3yOi6dZpikF/WEnWC/6n6wLx4FwqYdRprO31Ni6tsX97Dbhok/RHgTd5ZaYZCpNQ
         mIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790789864; x=1791394664;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GmNmDWcyjlu/BQcLFlm+7ZVraxBuV3+MA+EDK8nxdQU=;
        b=mWIBbRnYrWskKeIv1FsOplJQmKtwpAJ1VoOjDsWU327d6DZhZQNVQ9L22e7wMUh+tB
         OzDYUPAlmU9dyd45pAVOkyfBCdQvKRoma9pAidjL/PwpvHoq+Nyz8iSBXKK5r7d1LgDY
         qJL90bDDogl14rCuZFvmh/PM2RrkfoFxQcbyJRC5RVyWJkZexoA5Aqt2JzICHgnsVdO3
         YaNLynt9iwNDRn/3QXZGAxlXl0s8UyMMs50aPB7/FsrEZUjnh2sPb7DwhDFR95zP17/2
         03WLcjnNVCuk2/fVwI9x5f10R45XFLDvQpX3sscuO77V/jwUTaatKwg8qksZa2ndokO3
         xVTQ==
X-Gm-Message-State: AFq9FYKshfALgkvgqnWpt9K+WjtmrciDZuIt0l7MAYAdvFLcktFesd+m
	xZdzQrHeGCPv43qbnQYVUm3RKI8SO5vM/2dVEt5rSj8TpFy5maUASzHJzRf45+By9Z8UhxccZzB
	zGd/OGA==
X-Received: from plde18.prod.google.com ([2002:a17:902:d392:b0:2e2:b642:f52b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b66:b0:2d8:d4cd:dc8f
 with SMTP id d9443c01a7336-2e2e4a0114bmr16404135ad.18.1790789864215; Wed, 30
 Sep 2026 10:37:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 10:36:20 -0700
In-Reply-To: <20260930173635.3362655-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930173635.3362655-7-seanjc@google.com>
Subject: [PATCH v3 06/21] KVM: selftests: Drop unnecessary use of PRIu64 in
 nested TSC scaling test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Use a plain "lu" instead of "PRIu64" to print u64s in the nested TSC
scaling test, as KVM selftests are 64-bit only (and supporting 32-bit x86
selftest would be an absurdly large lift, for something absolutely no one
cares about).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/x86/nested_tsc_scaling_test.c         | 21 +++++++------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
index 052ddd61482d..b8b2217b9efa 100644
--- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
@@ -41,14 +41,9 @@ static void compare_tsc_freq(u64 actual, u64 expected)
 	thresh_low = expected - tolerance;
 	thresh_high = expected + tolerance;
 
-	TEST_ASSERT(thresh_low < actual,
-		"TSC freq is expected to be between %"PRIu64" and %"PRIu64
-		" but it actually is %"PRIu64,
-		thresh_low, thresh_high, actual);
-	TEST_ASSERT(thresh_high > actual,
-		"TSC freq is expected to be between %"PRIu64" and %"PRIu64
-		" but it actually is %"PRIu64,
-		thresh_low, thresh_high, actual);
+	TEST_ASSERT(thresh_low < actual && thresh_high > actual,
+		    "TSC freq is '%lu', expected to be between %lu and %lu",
+		    actual, thresh_low, thresh_high);
 }
 
 static void check_tsc_freq(int level)
@@ -166,7 +161,7 @@ int main(int argc, char *argv[])
 	 * variable does not work.
 	 */
 	l1_scale_factor = (kvm_random_u32(&kvm_rng) % 9) + 2;
-	printf("L1's scale down factor is: %"PRIu64"\n", l1_scale_factor);
+	printf("L1's scale down factor is: %lu\n", l1_scale_factor);
 	printf("L2's scale up factor is: %llu\n", L2_SCALE_FACTOR);
 
 	tsc_start = rdtsc();
@@ -174,7 +169,7 @@ int main(int argc, char *argv[])
 	tsc_end = rdtsc();
 
 	l0_tsc_freq = tsc_end - tsc_start;
-	printf("real TSC frequency is around: %"PRIu64"\n", l0_tsc_freq);
+	printf("real TSC frequency is around: %lu\n", l0_tsc_freq);
 
 	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 
@@ -207,16 +202,14 @@ int main(int argc, char *argv[])
 				break;
 			case UCHECK_L1:
 				l1_tsc_freq = uc.args[1];
-				printf("L1's TSC frequency is around: %"PRIu64
-				       "\n", l1_tsc_freq);
+				printf("L1's TSC frequency is around: %lu\n", l1_tsc_freq);
 
 				compare_tsc_freq(l1_tsc_freq,
 						 l0_tsc_freq / l1_scale_factor);
 				break;
 			case UCHECK_L2:
 				l2_tsc_freq = uc.args[1];
-				printf("L2's TSC frequency is around: %"PRIu64
-				       "\n", l2_tsc_freq);
+				printf("L2's TSC frequency is around: %lu\n", l2_tsc_freq);
 
 				compare_tsc_freq(l2_tsc_freq,
 						 l1_tsc_freq * L2_SCALE_FACTOR);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

