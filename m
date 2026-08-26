Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDA13F824D
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 11:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787745586; cv=none; b=kdKxvqyevOCTPzLJgQHS69P0NluxXg2wYUrjShpYYfWr0gkr0TpFjMYGrmJ2naJGPXHLYqbBqvqGuVVrvyNW8xG/9P7gB5JAHTzAU9EuHiKilr2kFvtlAxQbFLcURzq/IG8E313DbLw0+XRFlRrR3uHYUHGEXSFYDXyD3uVZsAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787745586; c=relaxed/simple;
	bh=h7J/RvhiciDfKZ1jOUjzZ+MzCgM78+0aQDx6a2MtWZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LG8lCe8frpAG5/9O5PLJby+ohNXJFtZD7tKBSnrSC/lUEM3l0Zm9OZjkXrq0eBxtf85Mb3f/gX+tEvIHmtlwF7XESQV/8pRqgb2zSmtCIGSG7yXTItz7B4VYX0i3PquQrqo3SWOTyxn7Zh9DYMM1IkArTSQKDcRVcFPOFDvWCec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MF9USS49; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MF9USS49"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca12086c06eso654170a12.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 04:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787745585; x=1788350385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RVWnW3XTZgLAyxYR/1hSOMx1kfYP5ttpGeKsRvGDajg=;
        b=MF9USS49aExD2Sr1D0cEP6BgcQJUA6OOdO97tT5iTi5Y3sTZgTV/aLNFptQLoyTEHY
         Dy1e5go8qqEo8sXUCz2QYHoPBsosB2hgFI8bhfEHBuTULLXOddtq5WJkKAwmcTf8Lcjp
         CVVnWWhmea9P0x0KkWjQXOQiuPPmuseDWqv+qyEUTXZ0dnp+FyxZzJvCawr6w7fUDnfz
         I7hzsuFnYsayT5t/wZ6tLVbb7tk3/Uyf+Gy7sCUhf68pFR2yO77gPGTqITswTW3ybVaf
         IOOtLXTnAaD1hbwsCDG1d3DEbqhvEtfQODtKPI2XvFlSTPxxCzQc04WaaTKxl85TUQsm
         8Viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787745585; x=1788350385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RVWnW3XTZgLAyxYR/1hSOMx1kfYP5ttpGeKsRvGDajg=;
        b=g8mGORZxPbQCyDxFLjLkAFXVSR/MTyUY+AY8wvO9dECy6EH28GlmDYuYRWqWJAwr+K
         YXvIPa7CxRuaK7L/HCtKUjAmtGbTUJeKusShOqANDmkD9LPVbC4NZAUsGa5xCSXLLZbz
         mj/43Q3iH5hRBTt9YL5pOa+YrhCnKYEhTgGKNAyN2gaSZ5LWcZ6DREoIiB5dN/YnMg84
         SABbnBkmfVru8hvM9b4b1joXn8FW2GObYkrMXYpeZ7YOn/ijimBJp52/debVGfyOg4F7
         amdXw7u8OR3zey1JmoZCqiY83qCb22U6IiO81aS4lhGLMv39NS8mYB4Tda2yEO7VNnGT
         9z2A==
X-Gm-Message-State: AFuF++l346Lmn9p2uFfdzhu28u3WVgz0BtRLpWeiPOaDtLb5EGM0a4mD
	4z8TlDcsxtXZHhIeUJOJIyCeohL8RER3QMGXKbmKvPacOdBEL3RrXhuS
X-Gm-Gg: AR+sD12anzqvICVJxLSsD3WA+EHQ2D4XCJnj+Yrm2jyeLbqz7spnU1vbeOkoVyhDKS0
	bu/QyhZAOJbg1wRN9y9vMvGUagNjNnvepWdnvPENLuSfRTUhYYSzKHA0LyGgKhtFA58/wrgP0uD
	ir1taho0dHUbtHBNGYNpcycNf9PhMNi0aqivqh4ltulQfsSQzgy8ZW+T7XWcu6/gfgnl2I3a4T/
	N2P+IUvw5U5lKz3fRD8xm5OupMgQ8KvIg5OuoBz39xYm2/c1T8C4xMAf06P/FPrqkrw7g3v37Uc
	cXzekZTpASJk6Ccsx+5aB6JhUnwCwjv1sMj4uXh6q4adv+JMVhfGkRkHtbFiLKbCxoVGMR0+JAq
	Bnj0+l6mqLIR4lyPPyyzlcVK2ue9Gh0uHRxoQgIV0A1lTYit9snpXuCW7iLYMoq56HIXiByG28O
	WK/KQ9PifoCfHU2OFt4KhMVZYPx7aHhLxwPRol0aWi8vsBar2ezITagJIHa5L/zCVsTawjBNgcB
	/KuC5XYvEI=
X-Received: by 2002:a17:90b:3fc4:b0:38f:dec8:f7e9 with SMTP id 98e67ed59e1d1-3966d443146mr14053031a91.12.1787745584436;
        Wed, 26 Aug 2026 04:59:44 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eefd98sm14607883c88.3.2026.08.26.04.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 04:59:44 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] KVM: selftests: Test the PV_UNHALT feature, not just its CPUID bit
Date: Wed, 26 Aug 2026 17:29:15 +0530
Message-ID: <20260826115915.2882221-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260826115915.2882221-1-hemanth.selam@gmail.com>
References: <20260826115915.2882221-1-hemanth.selam@gmail.com>
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

Add a two vCPU test for it.  The first vCPU halts with interrupts
disabled, so nothing except the KVM_HC_KICK_CPU issued by the second can
resume it: KVM delivers the kick as APIC_DM_REMRD, which sets pv_unhalted
and makes the vCPU runnable without injecting an interrupt.  Reaching the
instruction after HLT is therefore proof that the kick arrived.

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

