Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FCF3BFE4D
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509763; cv=none; b=MuQysvEM4ItCi5wb2iSGgRGeTkRFIPuxHHVAHpXs7zn6sygPm0prnMvBbuoKsxIoSj7fVyXwY22JhSQ7X5NotcTOLmCiTJu29TatFqNDJap8BLy+N54cT8H9LZIXq5JVI0FbFdqkycuUv5KHtEkemlglfB41jUZDYm3gfFn0kqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509763; c=relaxed/simple;
	bh=Fs7so+ZJGi3P+jhdmabB+E9ttuV6+nBB8ARPj8KikO0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L+HJE892KRz9Rqw+9K5fOsd/rkwq3k3e35hBrZ/Oj3VjxOAPT7mA3PFCIAJIR8291MfGeyZhHR7gOEZwUosL2Ytc0YlK1nMDzzuV+7WQL7x1adhzuQB6Sm3hNXiyq5at/PVvpLyuCpSjNyyaYO/WvEc1ixUUpjyJqAHPhTAgTms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FZlPWZs7; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZlPWZs7"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-845c296374cso950228b3a.0
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 14:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782509761; x=1783114561; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NsPt5mg15Oj99hJ3f/oZG/2r0/ISQ2OwxSu7NKxi9WQ=;
        b=FZlPWZs7+ozpOQfs7Eh5W5r1YzLpjNBXx3dQl5YqT5wuuM2dmjia7fc2PT/46oOyaU
         e2x7GZsJpxsFNY6QQcUTiXBcDWJTolezQQQkRzyn2iHEnDjQLyUb7CM5ujAn1wwSp38n
         Qx8AIitvFeA0P4aGzhpY7t7xbsHnfyYNVfY7vVHajxhdB3BtJPeLweGsf/nwVmFW/mZk
         3EXMG5t0r0nHmfKh9/D/NEJA/nnyG9ewgJh20NDwCXrqjpfuoNnzoRqY3w2YBMgaVvQe
         1MrSD7whAKazLCt+/tEOX30ynD673UJmOIeDYHcAZvOxSkgLKxfh4BRBT4Spi2t+JcCd
         inLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509761; x=1783114561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsPt5mg15Oj99hJ3f/oZG/2r0/ISQ2OwxSu7NKxi9WQ=;
        b=MIHih+5hMSu32a7pnEIOW9igAzLhqYa4srYcaL/PvP27c0awvOVulE67bnyLw5vs1w
         +6Lcg7eXO4kVAR/ebmcCKwdj9DY96nMMqg31Zf8Md06SB+sozVazWISgDi/oXAjCLN+Z
         sLLCJ+gAxudLh36tZjsjQFh4N1vjbE2FIIBYf84u6vL9vBZPA6pSbXJrjKQP0oP8drzF
         jZpF1DBN0fIbgMbC1+3vmvQpH2DPEQ2o6vc27bfDY2/vpQ/81b7ax442mtNG+QMftFNk
         C7hTq4e2fe9X/6oOj2pS9tNAZdiutvVm7Ia8UnvL6BNUKOHK0GKL7Fg3baRGHUCdcql5
         hCxA==
X-Forwarded-Encrypted: i=1; AHgh+RqYfojbJewvR6C/EMRi51RQt63KZhQkfFRlLbWBBTthSZy4zhIPh5uvYEB42MAF09nyJ+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YybTOSRGcVVQSF8809txk42J7XJbngd0D+m2FgryDcY/ooZM7mC
	b/1vVXUbd6Fk9okzdDv9laj6oSY/yIKrpheANYnBGjH5fU6aDDFkZMtMtBlgCblvIJ4YvG8uMw2
	N8yRMDw==
X-Received: from pfblu3.prod.google.com ([2002:a05:6a00:7483:b0:842:3b3a:5198])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:140d:b0:842:1ffc:55b4
 with SMTP id d2e1a72fcca58-845b3ac63abmr8607670b3a.36.1782509760452; Fri, 26
 Jun 2026 14:36:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 14:35:33 -0700
In-Reply-To: <20260626213534.3866178-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626213534.3866178-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626213534.3866178-21-seanjc@google.com>
Subject: [PATCH v8 20/20] KVM: selftests: Add xAPIC support in eventfd IRQ test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Extend the eventfd IRQ test with a '-x' flag to let the user run the test
in xAPIC mode instead of the default x2APIC mode.  When using xAPIC mode,
sanity check user input to ensure the test is being run with at most 255
vCPUs, as xAPIC can only address IDs 0-254 (255, i.e. 0xff, broadcasts to
all CPUs).

Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
[sean: add sanity check on number of vCPUs]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 31 +++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index d2c745c54960..240f6f0fdbe4 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -18,6 +18,7 @@ static u64 timeout_ns = 2ULL * 1000 * 1000 * 1000;
 static bool guest_ready_for_irqs[KVM_MAX_VCPUS];
 static bool guest_received_irq[KVM_MAX_VCPUS];
 static bool guest_received_nmi[KVM_MAX_VCPUS];
+static bool x2apic = true;
 static bool irq_affinity;
 static bool done;
 
@@ -31,14 +32,20 @@ static bool done;
 
 static u32 guest_get_vcpu_id(void)
 {
-	return x2apic_read_reg(APIC_ID);
+	if (x2apic)
+		return x2apic_read_reg(APIC_ID);
+	else
+		return xapic_read_reg(APIC_ID) >> 24;
 }
 
 static void guest_irq_handler(struct ex_regs *regs)
 {
 	WRITE_ONCE(guest_received_irq[guest_get_vcpu_id()], true);
 
-	x2apic_write_reg(APIC_EOI, 0);
+	if (x2apic)
+		x2apic_write_reg(APIC_EOI, 0);
+	else
+		xapic_write_reg(APIC_EOI, 0);
 }
 
 static void guest_nmi_handler(struct ex_regs *regs)
@@ -48,7 +55,10 @@ static void guest_nmi_handler(struct ex_regs *regs)
 
 static void guest_code(void)
 {
-	x2apic_enable();
+	if (x2apic)
+		x2apic_enable();
+	else
+		xapic_enable();
 
 	sti_nop();
 
@@ -158,7 +168,7 @@ static const char *probe_iommu_type(void)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-i nr_irqs] [-m] [-n] [-t iommu_type] [-v nr_vcpus]\n", name);
+	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-i nr_irqs] [-m] [-n] [-t iommu_type] [-v nr_vcpus] [-x]\n", name);
 	printf("\n");
 	printf("Tests KVM interrupt routing and delivery via irqfd.\n");
 	printf("-a	Affine the device's host IRQ to a random physical CPU\n");
@@ -169,6 +179,7 @@ static void help(const char *name)
 	printf("-n	Deliver 50 percent of IRQs as non-maskable interrupts\n");
 	printf("-t	Override the IOMMU type to use (vfio_type1_iommu or iommufd)\n");
 	printf("-v	Number of vCPUS to run\n");
+	printf("-x	Use xAPIC mode instead of x2APIC mode in the guest\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -205,7 +216,7 @@ int main(int argc, char **argv)
 	struct kvm_vm *vm;
 	int irq, irq_cpu;
 
-	while ((c = getopt(argc, argv, "ad:ehi:mnt:v:")) != -1) {
+	while ((c = getopt(argc, argv, "ad:ehi:mnt:v:x")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -233,6 +244,9 @@ int main(int argc, char **argv)
 			TEST_ASSERT(nr_vcpus <= KVM_MAX_VCPUS,
 				    "KVM selftests support at most %u vCPUs", KVM_MAX_VCPUS);
 			break;
+		case 'x':
+			x2apic = false;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -248,6 +262,11 @@ int main(int argc, char **argv)
 	vm_install_exception_handler(vm, vector, guest_irq_handler);
 	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
 
+	if (!x2apic) {
+		TEST_ASSERT(nr_vcpus < 256, "xAPIC can only target IDs [0-254] (255 vCPUs)");
+		virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+	}
+
 	if (device_bdf) {
 		if (!iommu_type)
 			iommu_type = probe_iommu_type();
@@ -271,6 +290,8 @@ int main(int argc, char **argv)
 
 	kvm_assign_irqfd(vm, gsi, eventfd);
 
+	sync_global_to_guest(vm, x2apic);
+
 	if (migrate_vcpus)
 		kvm_sched_getaffinity(0, sizeof(available_cpus), &available_cpus);
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

