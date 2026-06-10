Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E96E31F99B
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052848; cv=none; b=tpt5GIv68m8s0gtc6xtJ0vOvekQxm4DRKLivWcXYPHjMI64RpwZVRBiirlxqXWB/FT+YafvNabDI1QKH/afr9ERbI/qCtvV5cU0/fzOK8Tp3u8iHwtudSSbUday8ZrEqfIur9/ZRMheOEk9vwOsdKbZYsJX2fbtK9ztAIGh4AzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052848; c=relaxed/simple;
	bh=AiUuBRIX0kUa2VEzwQ/KiwLXhNWB6Ni7nPHSHxTzQ78=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X7K+aHxwLsVYOqUCLQyzatvXBR0BxjDGMQNkKyIQaSsAgo5L8txt05YMJ7d8pG7VsP6S19NRG5VkG28BBv+ydWMtx4rz4R1joghcOS+KEL4U8ZLWhkPqqJas1rf4EyaL/a4Qpjbh6q57JuC1NtctFzG84NPpQpGLhBYa7cgv6PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kG7r4dwu; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kG7r4dwu"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d99333358so5874253a91.3
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 17:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781052847; x=1781657647; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=q4JpkxXanGmrcDhm8+OuLX2LEo2GMxbk1wO2svPpVp4=;
        b=kG7r4dwuSRT+jwJDK2whDu8ggZMSDWUVDE5Z/XG8N2/HKTLTaw/rN1Q5iCeh07jEc7
         z6kaCrzTMdWHt5/OJt0kkjeRMmstzkvmkdQaTCRhSfElUfqCqGlHU55vkCxZQRv8ULyD
         npHFpOR40TYQmKkE54UO2a+zTHZvCI2YHXqPWJikbskF/0Cc2CF5bg6ZI45wOClIiLo3
         7JGFGYeuPkLv6iFyL6Vm5zW+m55s0B/D4+0pkWXox76l6W+PV4ZsFwp7r+DllPt8cKqd
         1ukdm+8jwVxOnn+a9ichGWvytLlqzQFAyxA69EuAefqFiCeRED9s5S5gpzXXQWbppf43
         8ihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781052847; x=1781657647;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4JpkxXanGmrcDhm8+OuLX2LEo2GMxbk1wO2svPpVp4=;
        b=Y+s3U36N6rcrQtCAO8vj6ezC389s+4t8GCH53cXrkQkaVnTEnfDQ3bNxfOoFoJke4g
         bZkZ+u4aXs3qlAqknpiNEiPis/8CkLgnk6gVunayJcvWlCoLm5BwcigJKrt78t2jcazB
         zUnAvEZL5mz9cravnYW7kUWLccqjHlgUwghTpBCtbwFlvDbqfkkvxDnQeVvcZKfibWeQ
         dsrri/uHF9n4kBYVrS6IG5fGrxbAFQrjCA7ZmDJp71SyT+w0Chc3EgJjQYFnhhmXK6Gt
         9KQ/u2LcGWLT/0SQoIDfyVcAba8WMqi2i2PbHpQ8i5lyKNDJe3w6lgPQ/ghu4aH2apGw
         czTw==
X-Forwarded-Encrypted: i=1; AFNElJ/5E7gTJPWNdQXfK0TEWcOVCGoHkjdPdgnv8sFzVTnFGk82kip0ZLpSV28dC8fBY+EjQsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YziIbrjlt4PZuGA80tO5hiYp+rkaALJ4sw3NDjTxjLcA7DxLdWG
	oGZRf5kFkCeqUC1YwFFrHRXNGrS2efXrvRaX0QklHvgCQfBed7IhEz2cIQl52QFCdB2baIB7zae
	TFjs2GA==
X-Received: from pjbiq21.prod.google.com ([2002:a17:90a:fb55:b0:36b:7f07:6fcd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dc7:b0:36d:cf58:b79
 with SMTP id 98e67ed59e1d1-375211ae901mr6245033a91.19.1781052846605; Tue, 09
 Jun 2026 17:54:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jun 2026 17:53:38 -0700
In-Reply-To: <20260610005338.2967132-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610005338.2967132-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610005338.2967132-19-seanjc@google.com>
Subject: [PATCH v6 18/18] KVM: selftests: Add xAPIC support in eventfd IRQ test
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
index 7d64fd29ea8b..2b6fc0335d38 100644
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
 
@@ -146,7 +156,7 @@ static const char *probe_iommu_type(void)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-i nr_irqs] [-m] [-n] [-t iommu_type] [-v nr_vcpus]\n", name);
+	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-i nr_irqs] [-m] [-n] [-t iommu_type] [-v nr_vcpus] [-x]\n", name);
 	printf("\n");
 	printf("Tests KVM interrupt routing and delivery via irqfd.\n");
 	printf("-a	Affine the device's host IRQ to a random physical CPU\n");
@@ -157,6 +167,7 @@ static void help(const char *name)
 	printf("-n	Deliver 50 percent of IRQs as non-maskable interrupts\n");
 	printf("-t	Override the IOMMU type to use (vfio_type1_iommu or iommufd)\n");
 	printf("-v	Number of vCPUS to run\n");
+	printf("-x	Use xAPIC mode instead of x2APIC mode in the guest\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -193,7 +204,7 @@ int main(int argc, char **argv)
 	struct kvm_vm *vm;
 	int irq, irq_cpu;
 
-	while ((c = getopt(argc, argv, "ad:ehi:mnt:v:")) != -1) {
+	while ((c = getopt(argc, argv, "ad:ehi:mnt:v:x")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -221,6 +232,9 @@ int main(int argc, char **argv)
 			TEST_ASSERT(nr_vcpus <= KVM_MAX_VCPUS,
 				    "KVM selftests support at most %u vCPUs", KVM_MAX_VCPUS);
 			break;
+		case 'x':
+			x2apic = false;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -236,6 +250,11 @@ int main(int argc, char **argv)
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
@@ -260,6 +279,8 @@ int main(int argc, char **argv)
 
 	kvm_assign_irqfd(vm, gsi, eventfd);
 
+	sync_global_to_guest(vm, x2apic);
+
 	if (migrate_vcpus)
 		kvm_sched_getaffinity(0, sizeof(available_cpus), &available_cpus);
 
-- 
2.54.0.1099.g489fc7bff1-goog

