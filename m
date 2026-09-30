Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F433568524
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789876; cv=none; b=q4gmJ+zaT0D3/JqIYRr1otJ0M+MMbgDyIt8j+6ZCyIxOULaFwuXKDmVU/mEvBGjJi4LAQIP0JzURoHl4MZMYm/5fiR6jBan5h9I+gy8eHKE+qZ2Qkp1K1Vvu6HaYljbm6pq9kcUsLx95mgWLqW7QD+nBzAQeJL34d34Q8ZTu+0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789876; c=relaxed/simple;
	bh=GuntnwRXKVkVYMnvmsXDelolcHcx29GtLDky+Ast2Mc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bhDWYr7FR9Mp5rABPC/vWFenji/x1bMcd8LkGuadjfXfh8ubO+8vBkxuwwj2f1PkPctYG1SZHj7HG1USNW7gF3vOV9gEpCyCx0J7e+ivD7KZhaJKKnVbifN4qciK5TNsupSUztoPWbCgCuLT8Ve/gSzd5UJR3poZnAQvsyLpvlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jBqbX7Pz; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jBqbX7Pz"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2db8c152622so37316175ad.2
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 10:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790789873; x=1791394673; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LQqrdCZTBp1fEKTHlVc1Buh/u5nZ1BC5WuNFitW3emg=;
        b=jBqbX7PzC/Oq815bd4IshYJI70RDkOQufZwInG9pClz3djf6lnFFJKiUOftKq7eilY
         WgjFfgKQhJHa1YMFxOwzzcIoCy8HE/aqD5yF4gssc5SEJvZz00y1WJTd5wrKt49JRKj2
         GF8aRJOfflw2tqTY/hRPnZOIyafp5HukZbDXgZyKZ9R6fAlc1MbQOEuLlCun0AYOFxym
         NU1mwcuOZNtUR/9z9dUQKo60KS2SVdzE2YiG+GXW2IaeH3si+hXffXtnFAnJK+px62SX
         FwX2DKV4GEN8uOYLL+SA3uEYkxFm6bIlx5waaIK0fF8+y/8OW5n1p+kNZIweEcvkrrw7
         KkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790789873; x=1791394673;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LQqrdCZTBp1fEKTHlVc1Buh/u5nZ1BC5WuNFitW3emg=;
        b=Fyd29kpJSbba3/0tA19yjEZfS5zANe607aqSr6VVWQB0XVq/BGj6paDGnPOZSnx07z
         UGs2LspmjH9+YrLLii7qHlS3Qvko09/2npELBSuFWoZW7r7jpSyDmQDbKFk7C5ho/s7C
         JDKoTRC345w+Sc+9ZWtN4vCKU7KAoduLi/Toit9MAgJwenJNgNPxNE7yT00jh54xTrW/
         K2quPnczn1ZIVAox0YxNtC4frf9JOEcb12bybOsa4UfAocKfo7aKy2RJs9depWOyFi/4
         2mCs4ULN4NnvVG2/D1nesG75UlFvbQpJvbd+AnJPTaAofSEsS24HwKapa17Qi4SjPXaR
         Sd8A==
X-Gm-Message-State: AFq9FYKfYE8jGCCmzftY5YeFYi9ZaKfSC8cu0Nx+O+KI7VC0dILobqtZ
	2DAfx+adPXuGbRSj+r3NkiXnS8e0tG21VRFZhGuCEKrDkzCsWtbzDgb/h8MK4axOwp63Vi2yD6R
	0zCLppQ==
X-Received: from plov13.prod.google.com ([2002:a17:902:8d8d:b0:2df:6fff:3dad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f603:b0:2bf:7b62:a038
 with SMTP id d9443c01a7336-2e2e4a0066bmr17158235ad.9.1790789873038; Wed, 30
 Sep 2026 10:37:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 10:36:27 -0700
In-Reply-To: <20260930173635.3362655-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930173635.3362655-14-seanjc@google.com>
Subject: [PATCH v3 13/21] KVM: selftests: Use KVM's reported TSC KHz as L0's
 frequency (sanity checked)
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Use KVM's reported default TSC frequency as L0's frequency instead of
calibrating L0's frequency using RDTSC.  Trying to calibrate the frequency
in userspace is all but guaranteed to be wildly inaccurate, e.g. due to
interrupts, preemption, etc, and no known CPU supports TSC scaling without
also having a constant TSC.  I.e. there's no need to calibrate the current
frequency, as it should also be the same as KVM's default frequency.

Opportunistically sanity check KVM's reported frequency against what is
observed via RDTSC, e.g. so that KVM_GET_TSC_KHZ or platform issues show up
much earlier in the test, before VMs get involved.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/x86/nested_tsc_scaling_test.c         | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
index d790ab36a198..a78585af0ffd 100644
--- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
@@ -137,7 +137,7 @@ static void l1_guest_code(void *data)
 
 static void test_tsc_scaling(u64 l0_tsc_freq, u64 l1_scale_factor, u64 l2_scale_factor)
 {
-	u64 tsc_khz, l1_tsc_freq, l2_tsc_freq;
+	u64 l1_tsc_freq, l2_tsc_freq;
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	gva_t guest_gva;
@@ -159,11 +159,8 @@ static void test_tsc_scaling(u64 l0_tsc_freq, u64 l1_scale_factor, u64 l2_scale_
 
 	vcpu_args_set(vcpu, 1, guest_gva);
 
-	tsc_khz = __vcpu_ioctl(vcpu, KVM_GET_TSC_KHZ, NULL);
-	TEST_ASSERT(tsc_khz != -1, "vcpu ioctl KVM_GET_TSC_KHZ failed");
-
 	/* scale down L1's TSC frequency */
-	vcpu_ioctl(vcpu, KVM_SET_TSC_KHZ, (void *) (tsc_khz / l1_scale_factor));
+	vcpu_ioctl(vcpu, KVM_SET_TSC_KHZ, (void *) (l0_tsc_freq / l1_scale_factor));
 
 	/* L1 will communicate its frequency before the L2 check.*/
 	l1_tsc_freq = 0;
@@ -212,18 +209,30 @@ static void test_tsc_scaling(u64 l0_tsc_freq, u64 l1_scale_factor, u64 l2_scale_
 int main(int argc, char *argv[])
 {
 	u64 l0_tsc_freq, tsc_start, tsc_end, l1_scale, l2_scale;
+	struct kvm_vm *vm;
 
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX) ||
 		     kvm_cpu_has(X86_FEATURE_SVM));
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_TSC_CONTROL));
 	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
 
+	/*
+	 * Create a dummy VM to get KVM's default TSC frequency.  All CPUs that
+	 * support TSC scaling should have a constant TSC, i.e. there's no need
+	 * to calibrate the "real" TSC.  But do sanity check that the observed
+	 * TSC is within range of KVM's reported TSC frequency.
+	 */
+	vm = vm_create_barebones();
+	l0_tsc_freq = (u64)__vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL) * 1000;
+	TEST_ASSERT(l0_tsc_freq, "vcpu ioctl KVM_GET_TSC_KHZ failed");
+	kvm_vm_free(vm);
+
+	printf("L0 TSC frequency is: %lu\n", l0_tsc_freq);
+
 	tsc_start = rdtsc();
 	sleep(1);
 	tsc_end = rdtsc();
-
-	l0_tsc_freq = tsc_end - tsc_start;
-	printf("real TSC frequency is around: %lu\n", l0_tsc_freq);
+	host_check_tsc_freq(0, tsc_end - tsc_start, l0_tsc_freq);
 
 	/* Scale L1 "down" and L2 "up" at a random factor from 2 to 10. */
 	l1_scale = (kvm_random_u32(&kvm_rng) % 9) + 2;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

