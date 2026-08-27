Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F8D38AC8A
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 04:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787805965; cv=none; b=X2jY8H/vUkUK0NkVkeS1IJfo0cCyrtKXbvRoAaJU1+D7ihmqMV7ob1i6/15sGIVP3RnZ4ySSGAAyOCenIcYFvhA+lT7NEzHSB8azSA2U/3kEjs3wgx6N67zxVM/ShQ3nTzQlG+clwOXVqO0uK+3Q7wrvWV8j8sIvF9jq9KPHBH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787805965; c=relaxed/simple;
	bh=wni/gdqNYjH6EHVDgouLtJx3/7zkJMxUoU3e/kmIOy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFMrqOXxM1KZbNIfEWQ5HtjnPk2K8Yc6zeib6wvuQB70l9WK0JE+G+W3KuikCahGaG8xjKuAd33xB+vedFwtQlLj7rD9bLbv50qq7m46v9HxogXIOjm4IhY72euedgkXvvTs7LlZQy1UrId9epP+t7LmXBPHgTKHYLBrMCOqbZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MC79qChj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC79qChj"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ce7d2adef4so22863265ad.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787805963; x=1788410763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d1I+EG9o+WscjAZPY2e61wmmiFBvV5FXVeqxFAMLmVA=;
        b=MC79qChj8tH2tSEjzIAUeKlw0q72ksBE1n7gLZNyQa/pXJbvTmLBCrUyDaWLE4ALqu
         bnV8NTgnjqnryheGjT6QYK7eEaI9u0oo6k2g0B1MgUgoix939iUAuLbL3ef6NM2QhVb2
         BzN+vyD3H1iS9qS3rZfxNJhQL/SiEgoLLlvrlsIDwDkMknyUOuCIiXR+h9p6Q3eWhPJg
         kiX3EdyFAdKJcuzYqnUmcr+e1hr+KIjM3jdj9t8Lx/wDv/LsAt9UVx7jJNj6HNcgBTjO
         zkOgh1BQgnfTT4mmZGo33N7F1A+ScFGG4B0TWLW33j3VsrXNhYpr4pFp7ZowzEuSwpnp
         eIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787805963; x=1788410763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d1I+EG9o+WscjAZPY2e61wmmiFBvV5FXVeqxFAMLmVA=;
        b=oaSVtM5kocJRDMFa66CGmOxouLI04B2COBKqmBEuyPeUIqiiVf0f6JZNZm0ZeJ2YBB
         TCQaUfeH7MH5iKuCytpTS9bWFC3nrId9a5lNM5gWh74C0LxKsDxWZdqqz0GJywvdu9ny
         zxY5Q6vnljsHGgatbyECNAZ2ydNvblZOKpsgTm7wvX0KXFVNl3jcgqmfgKsB7gWJYRVL
         gDwol5MLixA7xTiaOxeQw8HsHQYcAUiytKfDdE17kWAJAIs02DZRgFM0yDTWgW8JuzQy
         PkgmDuzpBz+SmfZejzs0d+Q1sb0fKSWckN+rhpUVIstyaIMCXCJI2HYpoAycQwV8YF/w
         uZ8A==
X-Gm-Message-State: AFuF++m4HcRp594ShENF2jcg67g4vQNmtfTQ1e1L/hXn81Ka6Bvypnq5
	4yHHI1ry2fyiqN7d3w+kXiFVyUYnWf1c1PGrpgnHXmwA9rJD8ZUKPjR3
X-Gm-Gg: AR+sD13YgQF451rc/eSye6KVlMjbxZvktsNEv0Vt96ExbZJfyOwWUld6+mU+EXVB5yc
	98LMAtxIlg461KHKHddfMDlskziv4aDBNU6tTdBlFGGwHhXottxgX7VgVrUyfeWpZ7Mgr+mKqDd
	aMzyE/7mp+p/S3O1+HnU1TV64FLf0lF4pi2bw/ymEjxJ800JZteZR/U1GlhdI0OV32KCY+xcQF1
	Xrt8UFoGZcblMXTLASOZQZqS8xUgRsw7bUlUVvLy9cKbwKmVV2IWOlKhJL+559C3ODSZb0RdE9T
	0Xa6SrVmyHfgN4kemaKqWeJSHOFde762DiT+uAVzxmdJKpznCzCr5DUoepizuW9ziDFBECAsGlv
	YDAUfB4r5S4jXdS6Q0UIvENGXuk8NnXHKEQRPOth/8U4WdhmHjjCCfc10I1T1ID11c/89h8Kdyg
	Dz5bHU3uvaZ2bIECnkORefIA+iohs0HLUu6CKWL/NDrmCsJ0dn5Wpt6O1qe3F3mimZgiKjmDpAP
	fUvOzeZAlMk
X-Received: by 2002:a17:90a:d44c:b0:396:5f7f:52f5 with SMTP id 98e67ed59e1d1-3966d366aa3mr25418355a91.3.1787805963458;
        Wed, 26 Aug 2026 21:46:03 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3285a5f96efsm2270583eec.11.2026.08.26.21.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 21:46:03 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] KVM: selftests: Test the PV_UNHALT feature, not just its CPUID bit
Date: Thu, 27 Aug 2026 10:15:34 +0530
Message-ID: <20260827044534.2900285-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260827044534.2900285-1-hemanth.selam@gmail.com>
References: <20260827044534.2900285-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_pv_unhalt() only checks that KVM clears KVM_FEATURE_PV_UNHALT from
guest CPUID when HLT-exiting is disabled.  The feature itself has never
been exercised, hence the FIXME.

Add a two vCPU test for it.  One vCPU halts with interrupts disabled, so
nothing except the KVM_HC_KICK_CPU issued by the other can resume it: KVM
delivers the kick as APIC_DM_REMRD, which sets pv_unhalted and makes the
vCPU runnable without injecting an interrupt.  Reaching the instruction
after HLT is therefore proof that the kick arrived.

Give the halting vCPU a non-zero APIC ID, so that a kick aimed at the
wrong vCPU fails the test instead of hitting the halter by chance, and
enable its APIC as a guest using PV spinlocks would, since KVM only routes
the kick once the vCPU's APIC is in the map.

Wait for the halter's halt_exits to tick before kicking so that the kick
lands on a vCPU that has actually halted, and bound the wait so a vCPU
that never halts fails the test instead of hanging it.

The kicking vCPU runs with KVM_CAP_ENFORCE_PV_FEATURE_CPUID enabled and
PV_UNHALT advertised, so that KVM services the hypercall because the
feature is exposed rather than because enforcement is off.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/testing/selftests/kvm/x86/kvm_pv_test.c | 97 ++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/kvm_pv_test.c b/tools/testing/selftests/kvm/x86/kvm_pv_test.c
index 8ed5fa635021..120d08ac25ce 100644
--- a/tools/testing/selftests/kvm/x86/kvm_pv_test.c
+++ b/tools/testing/selftests/kvm/x86/kvm_pv_test.c
@@ -6,8 +6,10 @@
  */
 #include <asm/kvm_para.h>
 #include <linux/kvm_para.h>
+#include <pthread.h>
 #include <stdint.h>
 
+#include "apic.h"
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
@@ -193,7 +195,99 @@ static void test_pv_unhalt(void)
 	TEST_ASSERT(!vcpu_cpuid_has(vcpu, X86_FEATURE_KVM_PV_UNHALT),
 		    "PV_UNHALT set in guest CPUID when HLT-exiting is disabled");
 
-	/* FIXME: actually test KVM_FEATURE_PV_UNHALT feature */
+	kvm_vm_free(vm);
+}
+
+static void pv_unhalt_halter_guest_code(void)
+{
+	/*
+	 * Enable the local APIC, as a guest that uses PV spinlocks would.  KVM
+	 * only routes the kick to this vCPU once its APIC is in the map.
+	 */
+	xapic_enable();
+
+	/*
+	 * Interrupts are disabled, so nothing except the KVM_HC_KICK_CPU from
+	 * the other vCPU can end the halt, i.e. reaching GUEST_DONE() proves
+	 * the kick was delivered.
+	 */
+	asm volatile("cli; hlt");
+
+	GUEST_DONE();
+}
+
+static void pv_unhalt_kicker_guest_code(u32 halter_apic_id)
+{
+	/* KVM takes flags in a0 and the APIC ID to kick in a1. */
+	GUEST_ASSERT_EQ(kvm_hypercall(KVM_HC_KICK_CPU, 0, halter_apic_id, 0, 0), 0);
+	GUEST_DONE();
+}
+
+static void run_guest_to_done(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+	u64 cmd;
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+	cmd = get_ucall(vcpu, &uc);
+	if (cmd == UCALL_ABORT)
+		REPORT_GUEST_ASSERT(uc);
+	TEST_ASSERT_EQ(cmd, UCALL_DONE);
+}
+
+static void *pv_unhalt_halter_thread(void *vcpu)
+{
+	run_guest_to_done(vcpu);
+	return NULL;
+}
+
+static void test_pv_unhalt_kick(void)
+{
+	struct kvm_vcpu *halter, *kicker;
+	struct timespec start;
+	struct kvm_vm *vm;
+	pthread_t thread;
+	int r;
+
+	pr_info("testing KVM_HC_KICK_CPU\n");
+
+	/*
+	 * Give the halter a non-zero APIC ID, so that a kick sent to the wrong
+	 * vCPU fails the test instead of hitting the halter by chance.
+	 */
+	vm = vm_create_with_one_vcpu(&kicker, pv_unhalt_kicker_guest_code);
+	halter = vm_vcpu_add(vm, 1, pv_unhalt_halter_guest_code);
+	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+
+	/*
+	 * Enforce the PV CPUID so that KVM services the hypercall because
+	 * PV_UNHALT is advertised to the kicker, and not because enforcement
+	 * is off.  KVM advertises PV_UNHALT by default while HLT-exiting is
+	 * enabled; set it explicitly so that the test keeps testing the
+	 * feature if that ever changes.
+	 */
+	vcpu_enable_cap(kicker, KVM_CAP_ENFORCE_PV_FEATURE_CPUID, 1);
+	vcpu_set_cpuid_feature(kicker, X86_FEATURE_KVM_PV_UNHALT);
+	vcpu_args_set(kicker, 1, vcpu_get_apic_id(halter));
+
+	r = pthread_create(&thread, NULL, pv_unhalt_halter_thread, halter);
+	TEST_ASSERT(!r, "pthread_create halter failed, error=%d", r);
+
+	/* Kick only once the halter has taken its HLT exit. */
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	while (!vcpu_get_stat(halter, halt_exits)) {
+		TEST_ASSERT(timespec_elapsed(start).tv_sec < 10,
+			    "vCPU never halted");
+		usleep(100);
+	}
+
+	run_guest_to_done(kicker);
+
+	/* Nothing except the kick can get the halter to GUEST_DONE(). */
+	r = pthread_join(thread, NULL);
+	TEST_ASSERT(!r, "pthread_join halter failed, error=%d", r);
 
 	kvm_vm_free(vm);
 }
@@ -215,4 +309,5 @@ int main(void)
 	kvm_vm_free(vm);
 
 	test_pv_unhalt();
+	test_pv_unhalt_kick();
 }
-- 
2.43.7

