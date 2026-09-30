Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2D656B84A
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789876; cv=none; b=Ho7AkJMX3Ajtfgd6xsYO1RGiASVEWv3Iz4cu9qmR+JFUt477e7vUi3eCiP/W0zsxl0ehvP7R80DPLglNYSZVHpO8LFKi0z7QlJu7VQB1Z+DMpc3wJwP4U0cZaL4tHKjnNRasLlto7KR8RKXuBTlZyJbHhjQSf62rilFtHKeWIw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789876; c=relaxed/simple;
	bh=ODQzTM/Lp5Ou8mKSnys9X5OPCCT1O+hxfzhtWnmXrM8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NaL2PozFOlBPXjkO8uKtoUCm5mik5qJrDPCOGftTJwGCU10E4hmZhVWd5AcZNzW/9xUriyInGsyc3aMNrUo01D4u+YOhbMBss+lpKA0TI2t+XqyKRjm02w33IJ5dPZWxFO2PJvFxsR2gqeNeggGkk9gYKPORB2jTFzW4Q+iOdzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fvd/h88Q; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fvd/h88Q"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc4c1fc9ceaso3412161a12.3
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 10:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790789875; x=1791394675; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=L7MqwP3l8JlymnWxoMAW4dbzNtInkFAMm0xRGZw3mF8=;
        b=Fvd/h88QK6NU460YYcDZcuDOMTg9GBwPaWJOFhT0DC70VGi8TUTa7+PF/PJkO7FnB9
         GHnd7+eDaL3a3vSM3jD8fd/4NTJVXyN7B4863GfJLCqCyC7dSpSEJn3ML523hOuIy1ZG
         ctoZnTq+BQsNsIJuabZBWBgXfC33TDrYmEULY4QagTbWsQjYskODEma/OXC9+RGOOpZy
         z1dhEQJ44ZjQQLgFF46mGcjG8WAyMY+R5yumog/lG4xUvouq+wCvYTR2gUXOkAp6PLFh
         RxSBVbHaKrz5VbnnzhBxldTprYtGy6UXHjdMy7ugLzaQ2lnWXn34vOcIwpCE8LmsNJFh
         7A1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790789875; x=1791394675;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L7MqwP3l8JlymnWxoMAW4dbzNtInkFAMm0xRGZw3mF8=;
        b=JzUCu6pZrDp9sGKCT/Vebtfyoja6PEozF/epPAplgPWU+kE7m9PhvcdihS74xRc1wy
         S42+EQpwSNKMfdykucQfy/iz1KGpZIUOqdyJjXooh6F8miSApuwnMIDaRK/FQh3m7jH5
         E7olZf+o3ZEGiAx5giiWXw/J9xVIV+9nt4AvLkdlSbEp7VHM9l9LJtHaQqpaJoA7OepV
         LYSzYOieEGIsOiTj4pkRTdlnVaIxj0EJH6cb2x8x7faPuUouyshQcCV5oLmU1uPDwtCT
         5l6Xr59A1Krd1pZ1sHCbyZEyDAQBATFXnbY6T3T7jeJTns2byn9IlIm9Gy8Mu9DOaeQ4
         KH8g==
X-Gm-Message-State: AFq9FYJf/ymXtlSABwt/2LZTXqOT1NgRc7bW7pWC07OfuNiJdLc0qHAS
	X/2KrFoEf+trQWL/NggF1wiJB8Gg+Yjkzgy8Yu2vUo40i40tcim1HmfC8lqwaIcfUmo5oRrgo8Z
	NitX/Nw==
X-Received: from plmo18.prod.google.com ([2002:a17:903:18d2:b0:2df:6366:11cc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f90:b0:2dd:c100:4259
 with SMTP id d9443c01a7336-2e2e4bd2142mr15923165ad.61.1790789874364; Wed, 30
 Sep 2026 10:37:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 10:36:28 -0700
In-Reply-To: <20260930173635.3362655-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930173635.3362655-15-seanjc@google.com>
Subject: [PATCH v3 14/21] KVM: selftests: Explicitly pass TSC frequencies to
 guts of TSC scaling test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Explicitly pass the L1 and L2 TSC frequencies, along with the L2 multiplier,
to the main test routine in the nested TSC scaling test.  This will allow
testing both "scale up" and "scale down" scenarios, and that KVM saturates
L2's frequency if it's scale up/down beyond what hardware can support, in
which case the expected frequency will not exactly match the L2 multiplier.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/x86/nested_tsc_scaling_test.c         | 42 ++++++++-----------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
index a78585af0ffd..a8f9307ed2a4 100644
--- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
@@ -8,7 +8,7 @@
  * both L1 and L2 are scaled using different ratios. For this test we scale
  * L1 down and scale L2 up.
  */
-
+#include <linux/math64.h>
 #include <time.h>
 
 #include "kvm_util.h"
@@ -135,21 +135,19 @@ static void l1_guest_code(void *data)
 		l1_svm_code(data);
 }
 
-static void test_tsc_scaling(u64 l0_tsc_freq, u64 l1_scale_factor, u64 l2_scale_factor)
+static void test_tsc_scaling(u64 l0_tsc_freq, u64 l1_tsc_freq, u64 l2_tsc_freq,
+			     u64 __l2_multiplier)
 {
-	u64 l1_tsc_freq, l2_tsc_freq;
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	gva_t guest_gva;
-	u8 frac_bits;
 
-	printf("L1's scale down factor is: %lu\n", l1_scale_factor);
-	printf("L2's scale up factor is: %lu\n", l2_scale_factor);
-
-	frac_bits = kvm_cpu_has(X86_FEATURE_VMX) ? 48 : 32;
-	l2_multiplier = l2_scale_factor << frac_bits;
+	printf("Testing L0 freq = %lu, L1 freq = %lu, L2 freq = %lu, L2 mult = 0x%lx\n",
+	       l0_tsc_freq, l1_tsc_freq, l2_tsc_freq, __l2_multiplier);
 
 	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+
+	l2_multiplier = __l2_multiplier;
 	sync_global_to_guest(vm, l2_multiplier);
 
 	if (kvm_cpu_has(X86_FEATURE_VMX))
@@ -159,11 +157,7 @@ static void test_tsc_scaling(u64 l0_tsc_freq, u64 l1_scale_factor, u64 l2_scale_
 
 	vcpu_args_set(vcpu, 1, guest_gva);
 
-	/* scale down L1's TSC frequency */
-	vcpu_ioctl(vcpu, KVM_SET_TSC_KHZ, (void *) (l0_tsc_freq / l1_scale_factor));
-
-	/* L1 will communicate its frequency before the L2 check.*/
-	l1_tsc_freq = 0;
+	vcpu_ioctl(vcpu, KVM_SET_TSC_KHZ, (void *)(l1_tsc_freq / 1000));
 
 	for (;;) {
 		struct ucall uc;
@@ -180,18 +174,12 @@ static void test_tsc_scaling(u64 l0_tsc_freq, u64 l1_scale_factor, u64 l2_scale_
 				sleep(uc.args[1]);
 				break;
 			case UCHECK_L1:
-				l1_tsc_freq = uc.args[1];
-				printf("L1's TSC frequency is around: %lu\n", l1_tsc_freq);
-
-				host_check_tsc_freq(1, l1_tsc_freq,
-						 l0_tsc_freq / l1_scale_factor);
+				printf("L1's observed TSC frequency: %lu\n", uc.args[1]);
+				host_check_tsc_freq(1, uc.args[1], l1_tsc_freq);
 				break;
 			case UCHECK_L2:
-				l2_tsc_freq = uc.args[1];
-				printf("L2's TSC frequency is around: %lu\n", l2_tsc_freq);
-
-				host_check_tsc_freq(2, l2_tsc_freq,
-						 l1_tsc_freq * l2_scale_factor);
+				printf("L2's observed TSC frequency: %lu\n", uc.args[1]);
+				host_check_tsc_freq(2, uc.args[1], l2_tsc_freq);
 				break;
 			}
 			break;
@@ -209,6 +197,7 @@ static void test_tsc_scaling(u64 l0_tsc_freq, u64 l1_scale_factor, u64 l2_scale_
 int main(int argc, char *argv[])
 {
 	u64 l0_tsc_freq, tsc_start, tsc_end, l1_scale, l2_scale;
+	u8 frac_bits = kvm_cpu_has(X86_FEATURE_VMX) ? 48 : 32;
 	struct kvm_vm *vm;
 
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX) ||
@@ -237,7 +226,10 @@ int main(int argc, char *argv[])
 	/* Scale L1 "down" and L2 "up" at a random factor from 2 to 10. */
 	l1_scale = (kvm_random_u32(&kvm_rng) % 9) + 2;
 	l2_scale = (kvm_random_u32(&kvm_rng) % 9) + 2;
-	test_tsc_scaling(l0_tsc_freq, l1_scale, l2_scale);
+
+	test_tsc_scaling(l0_tsc_freq, l0_tsc_freq / l1_scale,
+			 mul_u64_u64_div64(l0_tsc_freq, l2_scale, l1_scale),
+			 (l2_scale << frac_bits));
 
 	return 0;
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

