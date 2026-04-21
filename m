Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7683A9D9A
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813406; cv=none; b=WWnkFXUx4monHwXoW2L1ZDBnQQj7FySnYzHMbDBgzTd8cs9JLs7c/CZ1/WuRhdeP8qEcxNpabwblv7MVvuN65BhYcb1CWaDMD/YHhbvgHeocjcdSvkYQP9lvMQN8AFNN0WriCbGK4EO735FUIM4eZDhQAMY9az/I06DMn/AKrkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813406; c=relaxed/simple;
	bh=OSpqNv7c7tsqvhzn/NKqgkf4ppV76rQ40rhqgF3pSLE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S8LgREpODh3KW20dSt+RGpf8RrvoF4xsEwnk9v3RMrNI4YJDSTvMRAsn8Cw6aLDQKRtAweulL/7eOq/k8ae0heA6yWn592Fx5a6j78pEhJE3e06gOZz/5sxDEklsdCx4dVQ40DAa5/+RvHcoNM8rNExSblAJNfGDaZXxMfZTfJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L9kQWn4S; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L9kQWn4S"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2e06219cbso60075685ad.3
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776813404; x=1777418204; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3bJkLu+9wa+wbYHgaBNwCC3Sn5u5ygBBEN1BCKJ73vg=;
        b=L9kQWn4SAd8g1kPaTEfkB8QKez5Zrkwni/Ka+R1hC74y9I1HIkwmswfgHqgez3LF01
         nCyAVzwHx3f0JnxuX07atA7jgqo3Gs9k2MZVWe0ed2xhObSMpIq8PY/Vaa2aIMYsO0ye
         hwegtOnkPYDWaMHUoC8eD/04Xczz5xfH8v25TZ3h+vt+9+h2EGpNU4djUSEj16odGYi2
         eF2UM3GLSLggsw08gV+0qGFEdMdWElByUltUzpUOH2VpgkGkAuC4N0Y0xNBH7HYLAFRd
         t+NoKycM4xUVegZbGo2ZLTBt0n4REJs2V5Tal5L/I3JUvneNXRMB/tActQQN+kj+jNvH
         xSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813404; x=1777418204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bJkLu+9wa+wbYHgaBNwCC3Sn5u5ygBBEN1BCKJ73vg=;
        b=GjM3FWO1Ir2o27JH04X6OjG2QM6jDRtgubyUv8wdXdX5kAwt7GlNsMt9prLHMhObCs
         Ql4IuuHB9cErBTpWWir5St4XEnvUcs7hJTc/NSGBC+AzAlafN+zYQokzBUxkNvpjm+UH
         PL94ZATUW8NFhQNoUdYd/fR9VEE/Ityf5Yynvn75OpH0Pvihooolan+N+R8y9qMc0mew
         3zAWS30QqxfIF9zK+BLt8LKDMhNmvu3Pa+7rQJE/CrMdGBcyfkXxdkCQgyN7u7HtA2iM
         WP5CvI2k0UAT72c4VOvwsw4Dz+jHIshVM93kNwmjHXa1EHI4xSzxUJQHYOqTI8T3R27y
         l/8Q==
X-Gm-Message-State: AOJu0YwueFE4tdI5W9FUvoAO9sapKMaerd2hJS473nOuxmZkFyIZ9j+q
	DuOBE6RHNaO9dVe2dOnmYRTsRLrDpcx14yBskgtFNuutHeR+C2Wn3cFUhFhewIzV8KLf+PdB6RN
	2g2lU+b9f
X-Received: from pgab185.prod.google.com ([2002:a63:34c2:0:b0:c79:738f:74ef])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3298:b0:398:b8eb:6716
 with SMTP id adf61e73a8af0-3a08d7ac303mr21933098637.23.1776813404041; Tue, 21
 Apr 2026 16:16:44 -0700 (PDT)
Date: Tue, 21 Apr 2026 23:15:51 +0000
In-Reply-To: <20260421231557.1254270-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421231557.1254270-11-jrhilke@google.com>
Subject: [PATCH v3 10/16] KVM: selftests: Verify dynamic IRQ routing updates
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
index d0a48509b932..3671f5ce4cc8 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -111,13 +111,21 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
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
@@ -147,10 +155,11 @@ int main(int argc, char **argv)
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
@@ -161,6 +170,9 @@ int main(int argc, char **argv)
 		case 'd':
 			device_bdf = optarg;
 			break;
+		case 'c':
+			clear_routes = true;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -207,9 +219,13 @@ int main(int argc, char **argv)
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
2.54.0.rc2.533.g4f5dca5207-goog

