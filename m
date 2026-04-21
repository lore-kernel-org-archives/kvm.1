Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDCF3A3E82
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813403; cv=none; b=SRErT8BM1YJCys6N5zHKACwtouGKcqcG48MYskyjhgYOaHLaN85k+BA9BEqNyjhImII0y39LXCnhcD2XwfH5ioBAqOpb1gjIKnhV9L5oBS0SrCFRARrMBtEU9BYFK+CpmUcJZqmYxI/Nftp/XfuwuZWjVsziD8pmH67Z5d6nvT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813403; c=relaxed/simple;
	bh=MQS1JUvH6U/KfBbJD3iAMkPZWw2WDtinxQ7Bzhwkzyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BVi9lqZJL/cemOVXfKiw+DkqDmPY2/e6i4gOTVoTO6LR512BmbufOdgEKZ4EfDBc3b6+pL+8PjZcIRrXlqJmC+LiPr8swV5HgVXlYHKezvYE3nWMw3p3QL4qDndQ8t43KbLtxU9IPIFkD4fVmcYdSu4P89ahrkVhT7hPt5WlUd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m4OZP3WE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m4OZP3WE"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f460260cfso4986056b3a.2
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776813401; x=1777418201; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iGoinIsRG7ss8NPXz1vUaYQuPD9BQ2TUWRBse6dyLbY=;
        b=m4OZP3WEc1xmXOO+xrG1VjOm7W7T9bzh/Yju0gq0sqHfoMBhw+d6CS9i4uOH0lYXdS
         l/xeq1DDpkYOybjP8FRiO4otzNuDF7/ZVCnQP+cL5rVESBDRX5MNkCOiqLVLwMAdAcSi
         YgHlAsANOsbwC64euPiJo72n7nfN7xrKoeoCG0K4bsvc/wKXGhlanEowd174Lw1+t/o0
         VTV6CKVX1TQtbdbNbzYVULuOITPLKa1sKBA5dE2KDjkB09SO0uuGS1flRPGGxu0u23un
         jPBbxpMrCye2NGN55Fkb+Xq4XW8ANusQw2bwewyeyD8gTg3Qr5XcGtAyfG0Z4+aIzdwe
         w8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813401; x=1777418201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGoinIsRG7ss8NPXz1vUaYQuPD9BQ2TUWRBse6dyLbY=;
        b=fqil0ZRfDnTj9KNiKYrPRuYG3hiqeJWV9SmR9xfHYSCkq3vXEWnTE8K8HZVVBa4AXU
         aAQPe03Gvd5BTL5soAxlTToEpkNwZHODDNzRjp4LGDxFZGAJwcVEtG6mjLXgREsXKDAs
         lwMmM/Y0ryK1ZYfz7eotZz+nyuYEt2ijsIQO9waY9sqiA78xGiydPItJcz0000S2Qjgt
         9cWgHFJOceBQbePxeROHdAmGO5HkpFJfBQoGhDZDtMxbRaVnn3pPurm3yIa5E1dcKrTS
         VcMwISUmr/Z34FbV3zX9CvCk4DLwWAbrKbzRvWMx1eVtwi8xkyL88A0ZkVrnr4EBtRq+
         hYdQ==
X-Gm-Message-State: AOJu0YzqKfG0xphwQF0vaI2wOqAEhoOpR02yPx0BfybMDMgJYTfJpKrV
	4S3Ad4cGM38RzpdieINfmIchgeBYHwwKN3eEqzqqgeDuGxbX7qiGvEydDwnCrR7GnDTciCan9U4
	zzkE1BDw1
X-Received: from pfbhu53.prod.google.com ([2002:a05:6a00:69b5:b0:82f:a59c:f7d3])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6595:b0:82f:964c:e3d0
 with SMTP id d2e1a72fcca58-82f964d0ddemr13183537b3a.39.1776813401078; Tue, 21
 Apr 2026 16:16:41 -0700 (PDT)
Date: Tue, 21 Apr 2026 23:15:50 +0000
In-Reply-To: <20260421231557.1254270-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421231557.1254270-10-jrhilke@google.com>
Subject: [PATCH v3 09/16] KVM: selftests: Verify IRQs wake up halted vCPUs
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
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
index bb124028fb20..d0a48509b932 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -18,6 +18,7 @@ static u64 timeout_ns = 2ULL * 1000 * 1000 * 1000;
 static bool guest_ready_for_irqs[KVM_MAX_VCPUS];
 static bool guest_received_irq[KVM_MAX_VCPUS];
 static bool irq_affinity;
+static bool block_vcpus;
 static bool done;
 
 static u32 guest_get_vcpu_id(void)
@@ -40,8 +41,12 @@ static void guest_code(void)
 
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
@@ -108,10 +113,11 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
 
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
@@ -144,11 +150,14 @@ int main(int argc, char **argv)
 	struct iommu *iommu;
 	struct kvm_vm *vm;
 
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
@@ -185,6 +194,8 @@ int main(int argc, char **argv)
 
 	kvm_assign_irqfd(vm, gsi, eventfd);
 
+	sync_global_to_guest(vm, block_vcpus);
+
 	for (i = 0; i < nr_vcpus; i++)
 		pthread_create(&vcpu_threads[i], NULL, vcpu_thread_main, vcpus[i]);
 
@@ -235,8 +246,19 @@ int main(int argc, char **argv)
 
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
 
 	if (irq_affinity)
 		fclose(irq_affinity_fp);
-- 
2.54.0.rc2.533.g4f5dca5207-goog

