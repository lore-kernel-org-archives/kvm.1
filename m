Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A222625B0A3
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100601; cv=none; b=g+KQuHEmWfhYjXrnQ4zYDUL8/Os4In8aQwILRd+Eg94JlExol3WSydvmbtbalotVOaaCMliCHgM6Eix3xChL/r0O5TbBXN6DIaxg6+hjZZQghX7ePxHjYFk5hJ4zXmpur8S6o1SMbYeuNqhbfcQOHvP0h/omi44WczR8ndRILws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100601; c=relaxed/simple;
	bh=ab3K8FPCthYQkIyTJarkDDuRL7Mps2jwq7cT7gNX/SM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LO+dvC9ZIdw+fgzTsT8srsduEHjb/gBHxOXYcFqbT+SGgm4yU4NcbGM0QFka8kHEDaJjk1HPAotNK8uDYgqB/p83VPxXkMQ9I1NWtUNQtFEo6wGEJv2k60WooFqmG2knGqpaiNrvQD/6AWwmNcpSgd5H6vAn93pmPmp0mQVp+sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cmtRaj4C; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cmtRaj4C"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c857ebbb0easo434640a12.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780100600; x=1780705400; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NMBxpjOSalzemU/ZQuYbqkgWo21WSyDLVg2ebWgM+bg=;
        b=cmtRaj4CIyFM6pNZ4vkYrMKhGEAKRTpiyJZ3yb8rYBdvxbeZb/rPdn/DdfMd/KxJcd
         NfnexYzZzLELvJO39WHFEHunP40OrPiSvD1VfRrgjlTbGhVxTriJTnxV3/p0Dotll8g/
         cSGrie+PsFPFtUmdWxStW8rhp1Rtvng9ufd055Zf4WVYIfICqg2fy1SClSyUJLNH9x3K
         nJZ2dj3ChPyljeJ6kDKU9H48BeTt+kEegaoZlJ6/7iqAta1M8MX2pQAuHPrWCtxwk1/q
         3GGNPx1gvumay1I8D8jG9gNgMcRsNub6up4DVkw0nbpUrLzq6lmtjb9NK8H2AvZZo6pH
         IEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100600; x=1780705400;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NMBxpjOSalzemU/ZQuYbqkgWo21WSyDLVg2ebWgM+bg=;
        b=ZyhNE2gC2CngVgQcfzwQNy1xtnYQxoZI9rsE+aNPvg7Ygh0zUNkihFF/Kyp/DqXiTo
         Tdv+mUDnggaBYQL7/3fz8lhqDZbcDvJlXUsu2gYKY9pepQ7/Gc6q0OMHn7NghHdzzXol
         XJDYLZB1Kdd0Dx0NHNrwAKTFrJnOvMQKunML29l4PtNcQY7Lny9zu+WWOTN71+inFO1A
         l8geeAoO5VJ3jDHnpMW8NweYK+xQtktmhp5ltwJPEb/lvpN8miiexz7zBGd4/GhCZDx9
         TjUgXgCRiGsmedi8NGoe5XzsZsNW2l/hXB6bjlUSiQ/TgYYQEL4Dq4FDpLNxY3gDWME7
         MpZA==
X-Gm-Message-State: AOJu0Yw5/GYrrnCWR4ongc2jRp9EUmUlXbnnA3+0DC9icPcXQ08JufHq
	v3HIVY8xXpustBJKeE7OhREECPLpJgwb58Tlwg6RGJe/2eFE7SgE/21+82VceIyoLQKKQS2IxOU
	URbilYK2X
X-Received: from pln12.prod.google.com ([2002:a17:903:360c:b0:2bd:5ced:c1c0])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c402:b0:2b0:6068:4c5f
 with SMTP id d9443c01a7336-2bf2048b983mr57943065ad.8.1780100599778; Fri, 29
 May 2026 17:23:19 -0700 (PDT)
Date: Sat, 30 May 2026 00:21:25 +0000
In-Reply-To: <20260530002134.558837-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260530002134.558837-11-jrhilke@google.com>
Subject: [PATCH v4 10/19] KVM: selftests: Verify interrupts are received after
 modifying IRQ routes in IRQ test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add the '-c' flag to tools/testing/selftests/kvm/irq_test.c to destroy
and recreate KVM's GSI routing table between interrupts. This ensures
that KVM correctly handles dynamic updates to the interrupt routing
table while interrupts are actively being signaled by assigned devices.

Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 562b9ab187a4..72b9106216ed 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -114,13 +114,21 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
 	vm_ioctl(vm, KVM_SET_GSI_ROUTING, routes);
 }
 
+static void kvm_clear_gsi_routes(struct kvm_vm *vm)
+{
+	struct kvm_irq_routing routes = {};
+
+	vm_ioctl(vm, KVM_SET_GSI_ROUTING, &routes);
+}
+
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-b] [-d <segment:bus:device.function>] [-h]\n", name);
+	printf("Usage: %s [-a] [-b] [-c] [-d <segment:bus:device.function>] [-h]\n", name);
 	printf("\n");
 	printf("Tests KVM IRQ injection via irqfd using an emulated eventfd.\n");
 	printf("-a	Randomly affinitize the device's host IRQ to different physical CPUs throughout the test\n");
 	printf("-b	Block vCPUs (e.g. HLT) instead of spinning in guest-mode\n");
+	printf("-c	Destroy and recreate KVM's GSI routing table in between some interrupts\n");
 	printf("-d	Use a VFIO device to send MSI-X interrupts instead of using an emulated eventfd\n");
 	printf("\n");
 	exit(KSFT_FAIL);
@@ -150,10 +158,11 @@ int main(int argc, char **argv)
 	int nr_irqs = 1000, nr_vcpus = 1;
 	const char *device_bdf = NULL;
 	FILE *irq_affinity_fp = NULL;
+	bool clear_routes = false;
 	struct iommu *iommu;
 	struct kvm_vm *vm;
 
-	while ((c = getopt(argc, argv, "abd:h")) != -1) {
+	while ((c = getopt(argc, argv, "abcd:h")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -164,6 +173,9 @@ int main(int argc, char **argv)
 		case 'd':
 			device_bdf = optarg;
 			break;
+		case 'c':
+			clear_routes = true;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -210,9 +222,13 @@ int main(int argc, char **argv)
 	}
 
 	for (i = 0; i < nr_irqs; i++) {
+		const bool do_clear_routes = clear_routes && (i & BIT(3));
 		struct kvm_vcpu *vcpu = vcpus[i % nr_vcpus];
 		struct timespec start;
 
+		if (do_clear_routes)
+			kvm_clear_gsi_routes(vm);
+
 		kvm_route_msi(vm, gsi, vcpu, vector);
 
 		if (irq_affinity && vcpu->id == 0) {
-- 
2.54.0.929.g9b7fa37559-goog

