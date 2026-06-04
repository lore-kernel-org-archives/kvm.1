Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E6A30E83F
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538564; cv=none; b=oG7xfJKdhSigHKCNmYXR6gERAHT7BJ9lSSaCUVW2mCyYCa9BkErUdgy65csDPd41TUsHRcch4uHR+4iWArhWIge/o+YAhi9nY8B2E6GqeUmQWKDBF3QiYNayZuv5VmGLjV1iQyocxubhvVycBOQls73T+6Bit869rb6iwJ8LhAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538564; c=relaxed/simple;
	bh=6pY+TjgfgssKaHsPAOt61oAMqoFK8eMNXVXJ63J4T+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gV2mipIFneS1kzBIXFPvCzji8KNAfOF1AptEWogtNsexXjfCW4/XCmf0aR0aBeIJF8umZqavvYoL2M8y9JnOgWiEfqHbzr9WI84jInfzDCPaGTn9x9bAiij9NhRAmW4DmoE8spAS6fSub9KMGGwMHfmzXjBWxL1Q0muVeKKSs4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L+kq6P/u; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+kq6P/u"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8423f24dcedso247367b3a.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538561; x=1781143361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sb3P0p4SrvcVWMWS5X9HlHDW6xjjIovVXgKDqrW/UJ8=;
        b=L+kq6P/ul9t3/T1vEFDF1tC1db1NknDpmANfE5sEOENDrKMVC5tCp1ax2yhkk4H63T
         Mo9zOAnQ9EE5ZXfQ6flPRKoYKgj33brZy6R1GazM0wWttepp7CcI0UY0KamitexCi/Tp
         XbId1VUpEOb2ArJlQJlAuFLWCqm8zAAcUA329rZxqQCXNRCTL2YA7j/QGlRc6uUYuBx2
         yZPHw2BcqeOX/M9YDP2bGPCixsNGZJhNOgap7hin5aYaLt2rfTcar3KVnYMjTanJgPTL
         kqxHmSnqdIfLNpu/3nJL0pPblrMLXDfYGV7VJUlJIOZwpzaiTy69RqnFoU/p2ycmgKtc
         rnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538561; x=1781143361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sb3P0p4SrvcVWMWS5X9HlHDW6xjjIovVXgKDqrW/UJ8=;
        b=gpXLEvT6KgBFGRrnzft/SJJgkvfcUdaNHsf5AHnNe7nkHJS58h66gQ9BX9Araar5y6
         +japH9DL3VjpHQYPPAeOEjbN+tdPF5m3gntnBD+RxEsUykNDm5TdPEukeuYLPb8bEl21
         yyqUaQpdbZvICnAwIQkAQ7e0oq0/+uV4xuhr0161fHqqx0Im42VaDsEYRwyV7XZBBC76
         Nk9S4hqajlvE7xpuumGV9oOKZBnKhzZEAnYWk6Z1Mkw+NoLJjXdXd+B3vfqBhZchAQri
         +qdFVJs+hhcc/MaNiP1OQjzPDYgvo9MMDhwO4PCTcTzpK7v4Z2EdA89rxZP9v5ifISuQ
         fO2w==
X-Gm-Message-State: AOJu0YziGGR1XIQDfOOYECUmGaoYYc7/Rv8dRd92jLcD/Bw1lgyptiZB
	3WUcttwyo/MbldoQbn9rGPKEsJvJLm18iivuCDlo/uY1UVA5QTuUdGcyG9GPYuDLnarta+eDwt0
	L3RrTuNij
X-Received: from pfaz8.prod.google.com ([2002:aa7:91c8:0:b0:842:4d1f:7750])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3288:b0:839:44c5:c321
 with SMTP id d2e1a72fcca58-84284f128e3mr5571143b3a.44.1780538561215; Wed, 03
 Jun 2026 19:02:41 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:34 +0000
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-13-jrhilke@google.com>
Subject: [PATCH v5 12/21] KVM: selftests: Verify interrupts are received after
 modifying IRQ routes in IRQ test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
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
index 671338f0e612..b0c4547a7f14 100644
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
@@ -150,12 +158,13 @@ int main(int argc, char **argv)
 	const char *device_bdf = NULL;
 	FILE *irq_affinity_fp = NULL;
 	int i, j, c, msix, eventfd;
+	bool clear_routes = false;
 	struct iommu *iommu;
 	struct kvm_vm *vm;
 	unsigned int irq;
 	int irq_cpu;
 
-	while ((c = getopt(argc, argv, "abd:h")) != -1) {
+	while ((c = getopt(argc, argv, "abcd:h")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -166,6 +175,9 @@ int main(int argc, char **argv)
 		case 'd':
 			device_bdf = optarg;
 			break;
+		case 'c':
+			clear_routes = true;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -217,9 +229,13 @@ int main(int argc, char **argv)
 	irq_cpu = -1;
 
 	for (i = 0; i < nr_irqs; i++) {
+		const bool do_clear_routes = clear_routes && (i & BIT(3));
 		struct kvm_vcpu *vcpu = vcpus[i % nr_vcpus];
 		struct timespec start;
 
+		if (do_clear_routes)
+			kvm_clear_gsi_routes(vm);
+
 		kvm_route_msi(vm, gsi, vcpu, vector);
 
 		if (irq_affinity_fp) {
-- 
2.54.0.1032.g2f8565e1d1-goog

