Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224255632B7
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789870; cv=none; b=oquWzOFBgRH2oqwsQ7Gon787dcW7NY8PLkIykNGU7m+MWsO7cXk7NJ+KF2kmDNF64VaphucGYMH35lV4cQiXqhYegQ0NK2FD5i2ny8M1UDO799gqgloJ+46HZDtZmjFCyQ7i4da4PQi/1+qGWTzpqeIc3Ro8GGSF317RzHoZ10A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789870; c=relaxed/simple;
	bh=XTd0Kx6LOqbTehDY3ErUvoQmzE0XekZU68EvDSG455E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qjo80UXEiA8abHtrBHV8DJAOkTDdqMuSAlepLXJCBWKArp2honMB/SAjYJICKgNAWlZonMpFTCO+vZia/wLt8oOthzMcJkbjTOJiPwJ5l+qDGpt/LQ7YcVtq4M39l998tdpzIj9Uqko1Xh1FjS+7ONy8RmUB41CAWhZp5pB2Cqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wM6hU0rz; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wM6hU0rz"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e2d3a3ff86so22280245ad.0
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 10:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790789868; x=1791394668; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=f+4Z+dsXZ2XxEfHbOaRp/dthvQimfCN+wA79g9lhf48=;
        b=wM6hU0rzbxIlIlv6rGehT09QaK2nGXc0W3tPYw/k8YWIH1p/CzPwBC4PkPogypi7VM
         AXLFFu7XhFe2gH8HLn8DqZuC0jReV4oipePAfbsNh3tTDUM+Lb0SpHGxycB6mWPWrELu
         QIZheKFETLslE4AbUTDk3cLLOdj9/lxfnPDnKF5cY71sRq2jdEGL4xf4N5cVfZ6qglWL
         W+gXHnV0fg+1xiYEyqD3Kz7XR7u8rsPIrgsJS+pLOfA/kaYJHcljhnZbZ5scwaOdgf8u
         lNbNH8bsojtxk6tI7rv40nYEXHFixh/li0usiorfmrU5gm+xaLBJNAL+sCj6MhajYraK
         HU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790789868; x=1791394668;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f+4Z+dsXZ2XxEfHbOaRp/dthvQimfCN+wA79g9lhf48=;
        b=bBS0wmcI9O5912jyGyIdseFl5epjSaDp0B4mjWbreyLTXRaWKJDfIXLPOPVjc3Z0sC
         0N1nTSrk3FTm3s3jTIszH4UrTgbUHnYoDafjwFp3vzYgxUZRfcxYLlQnpI6602OOZGRk
         ONNwRVVCjRmu4gwqmOOPXfi1RHfUO3tBpGexR5hs+wk0+pVUYQiPAmTW1ivv64/0GGBH
         EHDprNcqcVCN3S1sC3tCgz4Q6J9Pg/ErzrZng8/OC09i4erPkGpFeSaehtfk+UPyBXeu
         YZBc9Llp/HuRhu7MoQP337psJdFlpDno9B9Y4n5nPV4ly7/86UD23YJSa8lstvSSJzXe
         m3Pg==
X-Gm-Message-State: AFq9FYJeRc3+rtZGK4TTBwyRpDPIRjncRd6Y5tV+9QR9MyEovxoTMDOW
	+mBLHE29hBJPtsdN/VLty0m4ePLX0q/mH/XY7qCfebkAnTgpkmWDh2Mr/0z78E87fPvskojr5nh
	8LGL85A==
X-Received: from pldu10.prod.google.com ([2002:a17:903:108a:b0:2e2:b3a5:70bb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c951:b0:2dd:c100:4b81
 with SMTP id d9443c01a7336-2e2e4bf78d6mr16773395ad.56.1790789868190; Wed, 30
 Sep 2026 10:37:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 10:36:23 -0700
In-Reply-To: <20260930173635.3362655-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930173635.3362655-10-seanjc@google.com>
Subject: [PATCH v3 09/21] KVM: selftests: Extract guts of nested TSC scaling
 test to helper function
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Extract the guts of the nested TSC scaling test to a separate helper in
anticipation of extending the test beyond its single "scale L1 up, L2 down"
testcase.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/x86/nested_tsc_scaling_test.c         | 54 ++++++++++---------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
index e5fc4c9bb9f9..d3208b57eafc 100644
--- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
@@ -135,38 +135,18 @@ static void l1_guest_code(void *data)
 		l1_svm_code(data);
 }
 
-int main(int argc, char *argv[])
+static void test_tsc_scaling(u64 l0_tsc_freq, u64 l1_scale_factor, u64 l2_scale)
 {
+	u64 tsc_khz, l1_tsc_freq, l2_tsc_freq;
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
-	gva_t guest_gva = 0;
+	gva_t guest_gva;
 
-	u64 tsc_start, tsc_end;
-	u64 tsc_khz;
-	u64 l1_scale_factor;
-	u64 l0_tsc_freq = 0;
-	u64 l1_tsc_freq = 0;
-	u64 l2_tsc_freq = 0;
+	l2_scale_factor = l2_scale;
 
-	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX) ||
-		     kvm_cpu_has(X86_FEATURE_SVM));
-	TEST_REQUIRE(kvm_has_cap(KVM_CAP_TSC_CONTROL));
-	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
-
-	/* Scale L1 "down" and L2 "up" at a random factor from 2 to 10. */
-	l1_scale_factor = (kvm_random_u32(&kvm_rng) % 9) + 2;
 	printf("L1's scale down factor is: %lu\n", l1_scale_factor);
-
-	l2_scale_factor = (kvm_random_u32(&kvm_rng) % 9) + 2;
 	printf("L2's scale up factor is: %lu\n", l2_scale_factor);
 
-	tsc_start = rdtsc();
-	sleep(1);
-	tsc_end = rdtsc();
-
-	l0_tsc_freq = tsc_end - tsc_start;
-	printf("real TSC frequency is around: %lu\n", l0_tsc_freq);
-
 	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 	sync_global_to_guest(vm, l2_scale_factor);
 
@@ -183,6 +163,9 @@ int main(int argc, char *argv[])
 	/* scale down L1's TSC frequency */
 	vcpu_ioctl(vcpu, KVM_SET_TSC_KHZ, (void *) (tsc_khz / l1_scale_factor));
 
+	/* L1 will communicate its frequency before the L2 check.*/
+	l1_tsc_freq = 0;
+
 	for (;;) {
 		struct ucall uc;
 
@@ -222,5 +205,28 @@ int main(int argc, char *argv[])
 
 done:
 	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	u64 l0_tsc_freq, tsc_start, tsc_end, l1_scale, l2_scale;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX) ||
+		     kvm_cpu_has(X86_FEATURE_SVM));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_TSC_CONTROL));
+	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
+
+	tsc_start = rdtsc();
+	sleep(1);
+	tsc_end = rdtsc();
+
+	l0_tsc_freq = tsc_end - tsc_start;
+	printf("real TSC frequency is around: %lu\n", l0_tsc_freq);
+
+	/* Scale L1 "down" and L2 "up" at a random factor from 2 to 10. */
+	l1_scale = (kvm_random_u32(&kvm_rng) % 9) + 2;
+	l2_scale = (kvm_random_u32(&kvm_rng) % 9) + 2;
+	test_tsc_scaling(l0_tsc_freq, l1_scale, l2_scale);
+
 	return 0;
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

