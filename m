Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42C3A75A8
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986095; cv=none; b=ldc864QUUrQawEQrPObY2JN2anKhH+Jpvlbfj8uPp/x0zvFi+Y/PN2o6Dwyy5eeW+G0kaQHsNbDxRIbJxTQrinXIrWaSvgyS7T6PgAkK8X7UMT795znuy1vPEngS033hUjgcckH8jjRDNREMn7r2pBza3VJQTawE7atV4ZjyG0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986095; c=relaxed/simple;
	bh=Q6tKwqG75/2Nso99cogxl8nqEUCuWw9K6h1ZRxlNLsA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WQQ0j1o0tI1L4WvcdM+tSwxdKVAl5tZ9rGOlHozFmaUFE4US0csSqAEBAJQnuPzBInhP+Rg19ShFT+RJVo/9LF+s8p7xH+4U+crJAZAi3cF9NrQ3IHr6CEQd2xf340O0BIxS1ayOwBw1B9cjJ3diK7hPT9q7WtSvKcOyw1j1eUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OCz5IUi8; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OCz5IUi8"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c1e1a6cfbso4460020b3a.0
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986094; x=1775590894; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dSekHtjObZUzAoWl4snvwsD79wmyoH1yZzVr5SPZq0Q=;
        b=OCz5IUi8Q1qL11zyoDEfAlPUfkBqwgNq7rjC27XXFfD4maQdwMPZMLW+2QFy+3BJxz
         tbfvwpezNeR2uYSJPVUNtHKJuov8etqXWdBgITgICZvLehk2rormcP9gz/Ld75g3QWcI
         61gCLbfln/edJ1Iy6qcVpW7b1dKazRHK8txhA5Q0uHj4wcfL/8+tCV8aG80KB8r8Vb0+
         wM6JVorxOx5o4xRTwGr1Cl1fAitBFjTtsxFofgopb317dFz7jM+X9RoGMzDxjqA+Luoj
         lr5SaDLSel0wQyO6Vk0S0NCo98vajrvgK8cErra6DQNXEpfWoTE42slnW0Owmng2xRXt
         LDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986094; x=1775590894;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSekHtjObZUzAoWl4snvwsD79wmyoH1yZzVr5SPZq0Q=;
        b=iihY4sjn63kAwYcwbQWb+yygtEe/ge1qXa8qtXUkz0vOgMhEYU/vB6/9mrpPbJ1WNW
         yXkNoKdVYtLD59RZo0CzdPPHSNn5IFZCxA8vXMlXEcydUneMu6NIASXem6wGTk3HxP9+
         7szhZvbVmXj5TU/Nh1MfUP/mEXVWogrezONdA771aIokbhCqWZ4OUX9peexxygEPGqpX
         cUtBuiq0WZbqib1TEqXJ5tSxLg+TZNqiHsUd64xEgQe+nLXezR5vmkR8ZaA4VfeeK+qx
         NK1SnUbjtUTIdNw7kUnZWAqD2Htn0ISizvYBd2WrkM0Go5Oj65fjzclmJAoVmPWKgbpq
         2Z4Q==
X-Gm-Message-State: AOJu0Yw0p//KESbW5eeJp3xAY8DFo6aaGW3StnL8fe9B5yEn+tyLocKN
	FTYmNGHN3u3Sa8EZnQzAFfRGgt0PI8hHJDx0WA1T/pA19ErkiRDBvdltZDkGJrBoxCHtJAAFNYE
	oUtL+U0WB
X-Received: from pfbdo1.prod.google.com ([2002:a05:6a00:4a01:b0:829:7f86:623])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3c95:b0:82c:e1a0:3445
 with SMTP id d2e1a72fcca58-82ce8ac8cebmr863602b3a.27.1774986093604; Tue, 31
 Mar 2026 12:41:33 -0700 (PDT)
Date: Tue, 31 Mar 2026 19:40:25 +0000
In-Reply-To: <20260331194033.3890309-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194033.3890309-7-jrhilke@google.com>
Subject: [PATCH v2 06/14] KVM: selftests: Allow blocking vCPUs via HLT
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add the '-b' flag to vfio_pci_irq_test to test IRQ delivery while
vCPUs are in a halted state. This verifies that interrupts correctly
wake vCPUs from HLT, which is a critical path for both power
management and correct architectural behavior during asynchronous events.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
---
 .../testing/selftests/kvm/vfio_pci_irq_test.c | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/vfio_pci_irq_test.c b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
index 1957d1b7bbf2..98dc1f4a7836 100644
--- a/tools/testing/selftests/kvm/vfio_pci_irq_test.c
+++ b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
@@ -16,6 +16,7 @@
 #include <libvfio.h>
 
 static bool done;
+static bool block;
 
 static bool guest_ready_for_irqs[KVM_MAX_VCPUS];
 static bool guest_received_irq[KVM_MAX_VCPUS];
@@ -42,7 +43,10 @@ static void guest_code(void)
 	WRITE_ONCE(guest_ready_for_irqs[guest_get_vcpu_id()], true);
 
 	while (!READ_ONCE(done)) {
-		cpu_relax();
+		if (block)
+			hlt();
+		else
+			cpu_relax();
 	}
 
 	GUEST_DONE();
@@ -88,11 +92,12 @@ static void send_msi(struct vfio_pci_device *device, int msi)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-h] segment:bus:device.function\n",
+	printf("Usage: %s [-a] [-b] [-h] segment:bus:device.function\n",
 	       name);
 	printf("\n");
 	printf("  -a: Randomly affinitize the device IRQ to different CPUs\n"
 	       "      throughout the test.\n");
+	printf("  -b: Block vCPUs (e.g. HLT) instead of spinning in guest-mode\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -133,11 +138,14 @@ int main(int argc, char **argv)
 
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
 
-	while ((c = getopt(argc, argv, "ah")) != -1) {
+	while ((c = getopt(argc, argv, "abh")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
 			break;
+		case 'b':
+			block = true;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -162,6 +170,8 @@ int main(int argc, char **argv)
 
 	kvm_assign_irqfd(vm, gsi, device->msi_eventfds[msi]);
 
+	sync_global_to_guest(vm, block);
+
 	for (i = 0; i < nr_vcpus; i++)
 		pthread_create(&vcpu_threads[i], NULL, vcpu_thread_main, vcpus[i]);
 
@@ -226,6 +236,11 @@ int main(int argc, char **argv)
 	WRITE_TO_GUEST(vm, done, true);
 
 	for (i = 0; i < nr_vcpus; i++) {
+		if (block) {
+			kvm_route_msi(vm, gsi, vcpus[i], vector);
+			send_msi(device, msi);
+		}
+
 		pthread_join(vcpu_threads[i], NULL);
 	}
 
-- 
2.53.0.1118.gaef5881109-goog

