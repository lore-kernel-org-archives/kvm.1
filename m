Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502B132B104
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787739415; cv=none; b=M4/djQet7EDFKX1Z8WruRYsnxLa9r6g/n0fYLAA2c2sOYFCz97ABZsc8HWLr0+9KwP8detC2L1yotkx48NEZGC31IwqL7o3ZekMe9zcmERWLuqRXUPHgvRtn1a+I5/YAt2F0dkz+j7o6wTkX9f7znrkORuXiK6zW7ZNno480rN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787739415; c=relaxed/simple;
	bh=59vTpxxWEv1HtJfPmZuk8ygZ5wZi/hyyb/b5qluJ0jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D3fs90wHGYg53FDVTgILhiSs5nMGx/65C+UNzTCZJYFIes58XnvlYG9MY4m+NvJVzH+R2wXgxiu8ZcZd9GB3INW/Wn1G7TaoGKWk4mIAGxmLmTYDQ0Lcv/9qteQLX5clcZtM5uF3utbG35WbBWLuPiMCWWNAG0kYcBPJopAoH/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6pnBiX2; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6pnBiX2"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so898742a91.2
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 03:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787739411; x=1788344211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CktsvTeO7UFrmo4k4+hz7ck5sXhdCkmKXB1FCIhVdHE=;
        b=T6pnBiX2IFwNb055FqJdoNpF0Y9uAyKkwupTejeNQQda0g7nTV8x7G/RRM4Lo7dCIH
         O2rkROcqHHzWH/CoTrnfaWnMV+QdM/KoCSqkyXk6c8Y14CImQgeq1QGJiOeR91M2oWQU
         RtXgJViVUk/VaL0VPuTGE6LjcbdIA0mTw3UKChIuZ1Eq10lOULwzVs4QK9b0ykuUosBc
         DlsWEG0ju5794b2+adub3jjbE23/Rlmk1cynNny+Z8/8T2M1acQr+c7ZVgxcv0uExvkH
         L5CvdBxfHlrKQdHjkmCW/ayllG/2SidF3BP4WiO1KfAdiHrftLBLbVXoVR5CFzM0YMx/
         ASRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787739411; x=1788344211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CktsvTeO7UFrmo4k4+hz7ck5sXhdCkmKXB1FCIhVdHE=;
        b=T2Ds1jRZFj8bhhYpGVRIqkFamASSbQSaz0XEak6MiQxkzy6z1T+5dc+DJ6nc3eK/qI
         v51K4AfkClQ8SN5q0cpZXYJ+EDWu1ni550kEb7liM0o60Z205XvFgLziRt48lSkQPiK9
         7v1hC47MDEVeA/PUlbSciyczLYF/Q+sAxXFlTv3cra6lFo/wGtVe5F/pQSDHWvcSMlyl
         VhEnLXQ55LGAxslUjX6eEreLmQApUtH6t+zHw8sJ4urKvhKltvqUR7vxcGCNbuk9cdFO
         EyYWcalQu0/eXh1dZ0soBnD44oFsPUhbPzbfYm49DDnIZ4cqF+DscywrH/1hGnD6K1Qk
         moMQ==
X-Gm-Message-State: AFuF++ld+JDNTWiKs+SbHxrofDW3cOGoL+aGVJNXtNKso0zDb8P2h5kN
	9FXE8rmBft0caVvjrCG2lzX9G9XO5pnJmTyqoJP9hxX7EUz71hcpJ+Jy
X-Gm-Gg: AR+sD11n0CZfAIB9DdVqt1b3dixAy4uT9qV6cb81twv8MCCRWwxCJQ5Fp3kxiJiOLyZ
	O65xSS6+PcuqkS1uJOKJRzNtn7tyT2q5iBTRvPT5yc3mvq3ahYI3aBTzoHI0Zu/xoHuEBTG78L+
	fxCijylUpdiw7fHP60CGPqVCW1+1j8ruuIpl24YH9RxkCemwZOfk1tVUSB3FCFJ0HjKzhGGtkjF
	EYJRLqezJg1IyeBUFnyTYjzA1KK5efC7bai4Ps1ihSNJ9Q06zrFWNrApAtIWdeLKAZGW/LDctAy
	UuY7sVqXbxyGwZWTOFb4clME21EPVxW09XcBIROzbouShQSpqu3WGyUEHK8OJ36oeEszNBEBuqK
	lROYRu2EyZHl9iIw6HJk4/zupOurFO7ht+HYGz18DLkPcr5NuNVi73N76jKhDbfEeG0SOTqiZpU
	s+gxBh9Dgg/6SypzZFF+s7G38+gUn+rbEuLeatJL1jmbpj1zXMUx1IWl18271aXs+pUA7okaXjz
	cd7qboAGcU=
X-Received: by 2002:a17:90b:1fc3:b0:38e:485c:ebd3 with SMTP id 98e67ed59e1d1-3966d48f861mr12753264a91.15.1787739410488;
        Wed, 26 Aug 2026 03:16:50 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eefd98sm12974385c88.3.2026.08.26.03.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 03:16:49 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Test the PV_UNHALT feature, not just its CPUID bit
Date: Wed, 26 Aug 2026 15:46:27 +0530
Message-ID: <20260826101627.2873660-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
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

Wait for the halter's halt_exits to tick before kicking so that the kick
lands on a vCPU that has actually halted, and bound the wait so a vCPU
that never halts fails the test instead of hanging it.

The kicking vCPU runs with KVM_CAP_ENFORCE_PV_FEATURE_CPUID enabled and
PV_UNHALT advertised, so that KVM services the hypercall because the
feature is exposed rather than because enforcement is off.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
Built and run on x86_64 (AMD).  Untested on Intel, though the kick is
handled in common code and delivered through the generic LAPIC path.

 - On kvm-x86/next, built warning-free and passed 10 of 10 runs, and 20 of
   20 runs on a mainline build.

 - Also run inside a VM booted on a kernel built from kvm-x86/next, so
   against the KVM this targets rather than the host's: 6 of 6 runs passed,
   which also exercises the halt/kick ordering under much slower timing.

 - Whole x86 selftest suite with this applied: 61 passed, 24 skipped, and
   set_sregs_test failed with "KVM allowed invalid efer bit (0x100)".  That
   one fails identically with this patch reverted, i.e. it is the host
   kernel, not this change.

The test was checked against three deliberate breakages, to make sure it
can only pass when the kick really works:

 - drop the KVM_HC_KICK_CPU call from the kicking vCPU: the halted vCPU is
   never resumed and the test times out, i.e. nothing else wakes it;

 - clear PV_UNHALT from the kicking vCPU's CPUID while enforcement is on:
   the hypercall returns -KVM_ENOSYS and the test fails with

     0xfffffffffffffc18 != 0x0 (kvm_hypercall(KVM_HC_KICK_CPU, ...) != 0)

 - remove the halt from the halting vCPU: the bounded wait trips and the
   test fails with "vCPU never halted" rather than hanging.

The explicit vcpu_set_cpuid_feature() is redundant today, since KVM
advertises PV_UNHALT by default while HLT-exiting is enabled - verified by
asserting on it - but it keeps the test honest if that ever changes.

 tools/testing/selftests/kvm/x86/kvm_pv_test.c | 93 ++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/kvm_pv_test.c b/tools/testing/selftests/kvm/x86/kvm_pv_test.c
index 8ed5fa635021..d14d55d3a9ba 100644
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
@@ -193,7 +195,95 @@ static void test_pv_unhalt(void)
 	TEST_ASSERT(!vcpu_cpuid_has(vcpu, X86_FEATURE_KVM_PV_UNHALT),
 		    "PV_UNHALT set in guest CPUID when HLT-exiting is disabled");
 
-	/* FIXME: actually test KVM_FEATURE_PV_UNHALT feature */
+	kvm_vm_free(vm);
+}
+
+static void pv_unhalt_halter_guest_code(void)
+{
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
+	GUEST_ASSERT_EQ(kvm_hypercall(KVM_HC_KICK_CPU, halter_apic_id, 0, 0, 0), 0);
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
+static u32 vcpu_get_apic_id(struct kvm_vcpu *vcpu)
+{
+	struct kvm_lapic_state lapic;
+
+	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &lapic);
+	return GET_APIC_ID_FIELD(*(u32 *)&lapic.regs[APIC_ID]);
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
+	vm = vm_create_with_one_vcpu(&halter, pv_unhalt_halter_guest_code);
+	kicker = vm_vcpu_add(vm, 1, pv_unhalt_kicker_guest_code);
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
+	TEST_ASSERT(!r, "pthread_create halter failed, errno=%d", errno);
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
+	TEST_ASSERT(!r, "pthread_join halter failed, errno=%d", errno);
 
 	kvm_vm_free(vm);
 }
@@ -215,4 +305,5 @@ int main(void)
 	kvm_vm_free(vm);
 
 	test_pv_unhalt();
+	test_pv_unhalt_kick();
 }
-- 
2.43.7

