Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F2E3090D9
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538564; cv=none; b=GTMN/rSz1AOgSFMfxfIfFpRfpFF9jxEsBO2/rpoP/dijb3Y8bd9V1YVLfeL4/OFv0TqZeGbWLseAkEYNvVUpd4Y6HeQSjlgeR+f26ghaknGdjCANHlFjiWTLFiTRdiQpE8APfhSljL95rnYHNR6e7ZwvQ5+778AhqLDqYev5gaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538564; c=relaxed/simple;
	bh=Tb1R8hwuQeOGJxffwS4UIjMZE/aEURFAC4KNqncaAaQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VuNsHUTN0W34NiE2g4oMcJQ7JjD+07AZVdDHBz9UuKYSDcTDALRS9QPy/oeeFbjN0P1iEpiDkHYmS7gS0p2W7W30iNlbaXaBZ21ONvo3DrTwu2heDZPwdz4rm0wWke2V2kj5YATlIdM+Y60kUeV5+FEP+n+8VNT39AvIYGqBtFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZLFauFo; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZLFauFo"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84233efcaadso154949b3a.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538560; x=1781143360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=itG+D7AxupPQwpNksfcEcO1SGnYBQBG/etMeZBVU8Kw=;
        b=wZLFauForo+x25pWpCwmLdafpid+ULgvIPEVXGtRNFdQBjUKhJCzqqWxSJN/ZhU/i0
         9NfeE2YqB4VUNqHfBJWySplqC4f4CypLwL9YZXhBRrTkRxWEo/hDEyheLLBH0bUKRLrf
         q6WYZ0VDsEuboCRPVE1cQNWpHHCNt0RxZOITRRAX56bzqpFNAXEe3cWUFSx4RubS5blQ
         NjKDsCfDr79BLFBf/9igfSEB+uxl13WUWb3cmFk8bR4XONc7Cj/AjyeLUGYtJ1b+xoW3
         YmrKXG+pxj+12yv3cZW0O9HdwRZmtJCURoXxJHaLZh46wlQAfTybqoiAqWYRLhbQA70B
         E7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538560; x=1781143360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itG+D7AxupPQwpNksfcEcO1SGnYBQBG/etMeZBVU8Kw=;
        b=mgbNSFZjo5mKBuoJnxHWqQEcz+b3q3PykwxpuvVGG9oBHSLTpJ8MtDrgVIDI1dRNfR
         paNewhV/zKgxjwsDWu4uTN2XzeOD2VPksYAxOwGjBkz1AgRpE8epsJtPujYJVj++xzK5
         Vc6SZ/2PFL0r9+SwGc+iLhPQFTeR741KLr9LKEbmXTq2Cr8HvMh+DAFdJq5ZnhjiacXK
         jKYmmQg+sh6M6sMFCEo6/yvkekHtTWfEVgx0Fj4Efq/mLwxLJRN7DGhyoU09vODDqa0C
         2ZH8bljZG1hjY0kfgfQb2k0lK7aS9bIEGSgXvQkEQsfr4puf6iGfDYZXLITxXUKt6Wuf
         zb9w==
X-Gm-Message-State: AOJu0Yw7T4IkAYwocG6DK5ByGfIvwDJXKQ40wWijZQ72fowDOpVmKdVm
	q0Mwu/F2zfwqmiPOAGIT/pw++1aiQHAX+G1hfVGOL4ADVOf793ecTycM+3K7aTONCI/aUPQNMEq
	r30kSn9x2
X-Received: from pfbgg3.prod.google.com ([2002:a05:6a00:6303:b0:83a:68c:e1c6])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:288c:b0:842:4b28:d941
 with SMTP id d2e1a72fcca58-84284fac281mr5498115b3a.49.1780538560370; Wed, 03
 Jun 2026 19:02:40 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:33 +0000
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-12-jrhilke@google.com>
Subject: [PATCH v5 11/21] KVM: selftests: Verify IRQs wake up halted vCPUs in
 IRQ test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add the '-b' flag to tools/testing/selftests/kvm/irq_test.c to verify
that interrupts successfully wake up vCPUs that are in a halted state.

By default, the guest code spins using cpu_relax() while waiting for
interrupts. With the '-b' flag, the guest executes the HLT instruction
instead. At the end of the test, the host explicitly routes and triggers
a final interrupt for each vCPU. If the interrupt fails to wake the
halted vCPU, the guest will never exit its loop, and the host's call to
pthread_join() will hang, causing the test to time out and fail.

Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 32 ++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 90cff165c351..671338f0e612 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -18,6 +18,7 @@ static u64 timeout_ns = 2ULL * 1000 * 1000 * 1000;
 static bool guest_ready_for_irqs[KVM_MAX_VCPUS];
 static bool guest_received_irq[KVM_MAX_VCPUS];
 static bool irq_affinity;
+static bool block_vcpus;
 static bool done;
 
 #define GUEST_RECEIVED_IRQ(__vcpu)	\
@@ -43,8 +44,12 @@ static void guest_code(void)
 
 	WRITE_ONCE(guest_ready_for_irqs[guest_get_vcpu_id()], true);
 
-	while (!READ_ONCE(done))
-		cpu_relax();
+	while (!READ_ONCE(done)) {
+		if (block_vcpus)
+			hlt();
+		else
+			cpu_relax();
+	}
 
 	GUEST_DONE();
 }
@@ -111,10 +116,11 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-h]\n", name);
+	printf("Usage: %s [-a] [-b] [-d <segment:bus:device.function>] [-h]\n", name);
 	printf("\n");
 	printf("Tests KVM IRQ injection via irqfd using an emulated eventfd.\n");
 	printf("-a	Randomly affinitize the device's host IRQ to different physical CPUs throughout the test\n");
+	printf("-b	Block vCPUs (e.g. HLT) instead of spinning in guest-mode\n");
 	printf("-d	Use a VFIO device to send MSI-X interrupts instead of using an emulated eventfd\n");
 	printf("\n");
 	exit(KSFT_FAIL);
@@ -149,11 +155,14 @@ int main(int argc, char **argv)
 	unsigned int irq;
 	int irq_cpu;
 
-	while ((c = getopt(argc, argv, "ad:h")) != -1) {
+	while ((c = getopt(argc, argv, "abd:h")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
 			break;
+		case 'b':
+			block_vcpus = true;
+			break;
 		case 'd':
 			device_bdf = optarg;
 			break;
@@ -189,6 +198,8 @@ int main(int argc, char **argv)
 
 	kvm_assign_irqfd(vm, gsi, eventfd);
 
+	sync_global_to_guest(vm, block_vcpus);
+
 	for (i = 0; i < nr_vcpus; i++)
 		pthread_create(&vcpu_threads[i], NULL, vcpu_thread_main, vcpus[i]);
 
@@ -247,8 +258,19 @@ int main(int argc, char **argv)
 
 	WRITE_AND_SYNC_TO_GUEST(vm, done, true);
 
-	for (i = 0; i < nr_vcpus; i++)
+	for (i = 0; i < nr_vcpus; i++) {
+		/*
+		 * Verify that sending an interrupt to a halted vCPU wakes it
+		 * up. If the vCPU does not wake up, the call to pthread_join(),
+		 * below, will hang.
+		 */
+		if (block_vcpus) {
+			kvm_route_msi(vm, gsi, vcpus[i], vector);
+			trigger_interrupt(device, eventfd);
+		}
+
 		pthread_join(vcpu_threads[i], NULL);
+	}
 
 	if (irq_affinity_fp)
 		fclose(irq_affinity_fp);
-- 
2.54.0.1032.g2f8565e1d1-goog

