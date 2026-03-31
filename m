Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A483AA4E5
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986100; cv=none; b=WulkXl2M81BNkX/g5fTTNS8DfqH+ept/h9Unr30185eG0mLx+Hib0O9A/HrR7IVloqD5XLb14N7qmW+mGco1+Bhd+NCmW1Zs8lx1NnaImsAmQHQ+MyOere9UQ+eRJ5eAtZy4Rim6UITclq+Y2KP/JltUhyU0IYUHdJcn6RSeZMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986100; c=relaxed/simple;
	bh=iZr6rcJ4UrsEZAMPdxFNYdauoyOzmy+tCKoYLmxT+Wg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kjD3SO47qjIdWmuAIebwIRSWJMXjuGI1ev2vIRiqDF05Pezq+QFYrqwRWgc/aatN9GwP46JEdK6gjJMXr27YXpMiuuqzsYZk1QGkxjlZPBBlFL8uaaTt0174th3WIA38XOr48reU0wEYItWiN+AwiDHZgACzDiZqUInmsR53eE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BXCOe/dy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BXCOe/dy"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b0c92ff4ebso63028395ad.2
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986099; x=1775590899; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VfUi4PaAgHVGcBmTDAMbIcbuHJLBGf6NdrBvZsEh6M0=;
        b=BXCOe/dyVMLnvIp9JrQQltpSWzhWfVc5kmgmhPJNMllOHe619Oh34gxpRQbgRL2Zs9
         9egwUnYtYy9U1fex1xZmAkrZBgvUogsm1mUUX+AUnMAolNmmHNnoe9xKNZsCwD7alZwT
         7mRRRcUlXJVm8umKHJr1GEo7nXPD7U2dg0u6Ct525dIAqClpgEZ8MmUDOoAvDl7nzWdh
         3dnAzz3UM6kxXTEecIMIaF44mZm7i7ZR1tDHCEidPUWsEUotjpnXi/iRmiBiKtrzI8Px
         gOgIFwbj8EkwRS68lNAgfQfePMc73DmqD4WZ9HrNVxG2E8Fb2PaQpBJYi86COi3hXEjc
         YQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986099; x=1775590899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfUi4PaAgHVGcBmTDAMbIcbuHJLBGf6NdrBvZsEh6M0=;
        b=FievFLlXkPmtOaFlGRMuWV/uliIw0Eq+7q52cJAg6AyRlfQ5rjjbz3GmgmRI8MIOkB
         5XiO/QNCZmYIiIyz8I9E5ka7RS2FoLR18nW3fZQHjBAKnyXQDk/b7WnviH0K+IiZnbPs
         Yydkfy4M2w7J41nUxz/Hx9tQZ5rTLG4C71w1H5kvTKaZu0dHPZfm7djsMpJ/nvqU3Fge
         J36X6urk3JFWlOZiviHmI47Gv27kZ3/fwhMVeXzxY4v8z/oLD+rIxJ+wknW0VlqWIRTX
         5dbWgVZ29od3oh0k6pRwogIT8Pezu2Cwz87jKyCL2d7pt/fHbowdtnl0/DQ7nASp278e
         qp0w==
X-Gm-Message-State: AOJu0YyJ0naoj4yky/eyMxvAlulZ620SA+WIm7h7BB4DKL786t2juTsh
	f7L2HlkKcc27gzI3AOkkOEk28XRjWBN3Jta+UGRMuZY1DQFZGfypk5q+JPcuiel6MOSRIZsJd+X
	08IsvdZiz
X-Received: from plcr12.prod.google.com ([2002:a17:903:14c:b0:2ae:4702:a100])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e785:b0:2b2:4fc1:f657
 with SMTP id d9443c01a7336-2b269a9ce58mr4482185ad.6.1774986098740; Tue, 31
 Mar 2026 12:41:38 -0700 (PDT)
Date: Tue, 31 Mar 2026 19:40:27 +0000
In-Reply-To: <20260331194033.3890309-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194033.3890309-9-jrhilke@google.com>
Subject: [PATCH v2 08/14] KVM: selftests: Add option to clear GSI routes
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add the '-e' flag to vfio_pci_irq_test to destroy and recreate KVM's GSI
routing table between interrupts. This ensures that KVM correctly
handles dynamic updates to the interrupt routing table while interrupts
are actively being signaled by assigned devices.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
---
 .../testing/selftests/kvm/vfio_pci_irq_test.c | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/vfio_pci_irq_test.c b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
index 0435e8c75dd1..db2dedf4437d 100644
--- a/tools/testing/selftests/kvm/vfio_pci_irq_test.c
+++ b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
@@ -63,6 +63,13 @@ static void *vcpu_thread_main(void *arg)
 	return NULL;
 }
 
+static void kvm_clear_gsi_routes(struct kvm_vm *vm)
+{
+	struct kvm_irq_routing routes = {};
+
+	vm_ioctl(vm, KVM_SET_GSI_ROUTING, &routes);
+}
+
 static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
 			  u8 vector)
 {
@@ -118,7 +125,7 @@ static void send_msi(struct vfio_pci_device *device, bool use_device_msi, int ms
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-b] [-d] [-h] segment:bus:device.function\n",
+	printf("Usage: %s [-a] [-b] [-d] [-e] [-h] segment:bus:device.function\n",
 	       name);
 	printf("\n");
 	printf("  -a: Randomly affinitize the device IRQ to different CPUs\n"
@@ -126,6 +133,8 @@ static void help(const char *name)
 	printf("  -b: Block vCPUs (e.g. HLT) instead of spinning in guest-mode\n");
 	printf("  -d: Use the device to trigger the IRQ instead of emulating\n"
 	       "      it with an eventfd write.\n");
+	printf("  -e: Destroy and recreate KVM's GSI routing table in between\n"
+	       "      some interrupts.\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -149,6 +158,7 @@ int main(int argc, char **argv)
 
 	/* Test configuration (overridable by command line flags). */
 	bool use_device_msi = false, irq_affinity = false;
+	bool empty = false;
 	int nr_irqs = 1000;
 	int nr_vcpus = 1;
 
@@ -166,7 +176,7 @@ int main(int argc, char **argv)
 
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
 
-	while ((c = getopt(argc, argv, "abdh")) != -1) {
+	while ((c = getopt(argc, argv, "abdeh")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -177,6 +187,9 @@ int main(int argc, char **argv)
 		case 'd':
 			use_device_msi = true;
 			break;
+		case 'e':
+			empty = true;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -226,8 +239,12 @@ int main(int argc, char **argv)
 
 	for (i = 0; i < nr_irqs; i++) {
 		struct kvm_vcpu *vcpu = vcpus[i % nr_vcpus];
+		const bool do_empty = empty && (i & BIT(3));
 		struct timespec start;
 
+		if (do_empty)
+			kvm_clear_gsi_routes(vm);
+
 		kvm_route_msi(vm, gsi, vcpu, vector);
 
 		if (irq_affinity && vcpu->id == 0) {
@@ -254,6 +271,7 @@ int main(int argc, char **argv)
 			if (timespec_to_ns(timespec_elapsed(start)) > TIMEOUT_NS) {
 				printf("Timeout waiting for interrupt!\n");
 				printf("  vCPU: %d\n", vcpu->id);
+				printf("  do_empty: %d\n", do_empty);
 				if (irq_affinity)
 					printf("  irq_cpu: %d\n", irq_cpu);
 
-- 
2.53.0.1118.gaef5881109-goog

