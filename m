Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C581D25B0B4
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100600; cv=none; b=rWG3TsMar3pEBE4tZMxTF7gCGFdIwp8C/uVGdFT4Nb1T7ukHOTFnF0Sywo8APjdTWXYXcSs9EdhnvyiLzvyO8dpL2YVz0F8sRnqq+csyBZ656QAI8/xTlRyjv0bqv7FroJijLYJz6UDv+Jm9bgsjqZMFkOGG/VgsYq76Em4xOvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100600; c=relaxed/simple;
	bh=H7ncH0RzOYzAnvbEgFFJpfICxIyEjpQiv3hqtwy9Qx0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XU2mo4yjZVaIp403g+5EfSZ/I2lrrJKw9QCeE/YKw+d+/H3Day1mPxiLS7dAcEMZ0sssPAHT7+vyNxrEo4qPoE0Bfx6tpK3oyl3FPAkwgsy0gu38kBHVJKIxbrGWrkoYYSNxkVe7LTwPf1ZLwyLFlM7F9LI8cDd5zWyIBsAVfVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tb8Umrtk; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tb8Umrtk"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c828ab3b033so17708373a12.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780100598; x=1780705398; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xvgcKpRJpmTCSpBiZzMNprp4unBpkZcFJd82mVpUF10=;
        b=Tb8UmrtkwH6n0uLy16LrR10k0j2W0t47KQFZ4ep8aZrp9S8P4+9oxu83TtBkYlLf9u
         2ep+SZS90W5erUwWNZMkuwCQB8MscSEueWXS+4+sJbIxZSjBP0cbOsiSuNNgCEtNpJlV
         9Hgb/w8T3pEUVR+ZFO/Iz8AVP7yErhSr2bsirk51BkG8VFR9zgPKFMSXFqSt+CJvMLKy
         WJCdX0KA+bzC7BNCOTMfRhqIrkMJqG1MLwuTa8/gm+2HuDOdBCjPHuLILgiydGO83uX5
         WpmnI482sVNYzsVRLv7cHwxgdvwX9OwjaTrIt0AxzeMKSyONe+VXpEcCnWtRTs8qcHXv
         FPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100598; x=1780705398;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvgcKpRJpmTCSpBiZzMNprp4unBpkZcFJd82mVpUF10=;
        b=QqdMpVV7ppiS/P/TcQjNMnREWFJrx0DUCKzP3m19DM7ikZ+xt/aJzJLcbpz+jfWnYb
         5AOmqJ2dO4eNgu9aqfzTZJaTl2tMTRO5tp6YF1qtgo5fXrhdkpAwlGtvmYGHWwA0YTvo
         a31HMpysZqpTFJjlaZnwf5pajgWHKTva/uEM0facaaZNr5vOy84Ott7ksAurpck93cdc
         SZkr2GuIGytq7wNyNoSI3i2B1rR3foDY3s5+QW2BW1pOsCAfQdNYO5/79fu0gOLhHJmC
         xvHivz61WKNlSXOh1S5WaT2lhcXaz6h56Kd9u+Lm8+prwXws82SlcVMuSw1q+EOdDgLx
         n3+A==
X-Gm-Message-State: AOJu0Yzn7rJUX6Uo41pEiS8wZmlRrf/zmohggoG+r7nWwP35feoPitOh
	xUHDh7FD+vnucdirSkZwlEyvenioPpY8pgu2OV1n/Mw4rbTQ/AB8jtJLrBEfVosHBufqaiEdEQ5
	UptbHiomi
X-Received: from pgh1.prod.google.com ([2002:a05:6a02:4e01:b0:c82:7761:9940])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3a46:b0:3a2:f402:50fb
 with SMTP id adf61e73a8af0-3b4281d8961mr1589744637.34.1780100597979; Fri, 29
 May 2026 17:23:17 -0700 (PDT)
Date: Sat, 30 May 2026 00:21:24 +0000
In-Reply-To: <20260530002134.558837-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260530002134.558837-10-jrhilke@google.com>
Subject: [PATCH v4 09/19] KVM: selftests: Verify IRQs wake up halted vCPUs in
 IRQ test
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
index e76784e0a054..562b9ab187a4 100644
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
@@ -147,11 +153,14 @@ int main(int argc, char **argv)
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
@@ -188,6 +197,8 @@ int main(int argc, char **argv)
 
 	kvm_assign_irqfd(vm, gsi, eventfd);
 
+	sync_global_to_guest(vm, block_vcpus);
+
 	for (i = 0; i < nr_vcpus; i++)
 		pthread_create(&vcpu_threads[i], NULL, vcpu_thread_main, vcpus[i]);
 
@@ -237,8 +248,19 @@ int main(int argc, char **argv)
 
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
2.54.0.929.g9b7fa37559-goog

