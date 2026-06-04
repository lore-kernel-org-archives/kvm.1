Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E4372EF7
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538571; cv=none; b=I87a/QrOPzbqbrQ0Dmnf6pwGGumSjMZ02ORHMdhpadQvlL3LQIT2Xiey8ObbG8+mxL/Z8bRKf6uIXO6QHfxItKeNZB9Ha9p9qA6+epQ3ggNbJhyR6Wziirhtki7AQvXa1iD4ckyT2b/ebdjXhBvi+kk7PcCODcML1yNMgb6gsEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538571; c=relaxed/simple;
	bh=bx+kBbZmgI4IbtQmhvJB2xCtnwutiLWabYcYesx+0gg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S+gb4APamTxx0DNohkh6omoFEF/awuNP0IdPncwiONOYcvY5Q3y1hJnT7FqihYZp6WLfFe4ESEd4Tg+hw5vWC7qghY3nRGAsdOrRusv8t5Ft5K/gc0RO3BNM/9RzdKEpGuJW5C0mdV9IPtOiJuhxSuIjW474DanJmZSDHyVAPvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SHwsNVTk; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SHwsNVTk"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8422ca754d8so152261b3a.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538569; x=1781143369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nuFK0OxqqftqEBZb8lCNkFzmE67/Kll87MP7BwBya34=;
        b=SHwsNVTkZ5cgSKbiQacEzg8QFaPGwiLN6rRSO13IkbMJ3h8NGvyOZQMntl1DPugkEJ
         wYNpMNMjqPjvSuTJNTMR8D9NGxtVcU66ghMI7VbQxt3Pz1pfh+hzv0fPy2Hw5fb6Esdi
         ltqu1DH/r1p8OSFAFz0lsAFJKrkxnbm7Q5hZCODavBaHQPCxZk+4m1zsvLgnEn+qlzR6
         Qlah8ywtx8zA5hzMELS+SnuKI7Ka1iK6GPSmwUk19ENgtXBjZFiJvpTnM5CT57HUqokI
         342rc8J71p4soMshv01smMVBDvAOSsgRl/56mf/O4kPX20vKKsuJ7uFxyWOREW3J20uc
         3K5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538569; x=1781143369;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nuFK0OxqqftqEBZb8lCNkFzmE67/Kll87MP7BwBya34=;
        b=ouh+SJccMRIZgd7uCMOKVBOGFg6bmCjfrecXpTAij8Ml23SJvnSRfoRqSU7Baba7IG
         17lDRbTj1b/XklafKE21DeLFnH/MuAsVDDjFlMDdiLTiRxm9mwUt5pQ79zQc68RBN8F5
         onZjzCs3a6kxaRAR5CAocIHgDcC+AY50wvoxXwymztqtzqrdTLyDdC7jWzEY/r12wk5i
         EXS+qEK1IHYqGjQqJKigKg2rJHPhg4dOXFOT0/Yg9kcLbAG7oP3vnU0tsL+RvliJHwg1
         Ht+3h45SJZuEF7TcG/N1B0C4c/DJph1X9MRLavtIa6ii/GYHBWT3iRGFoR/G81viGq02
         lYeQ==
X-Gm-Message-State: AOJu0YyNBrNJwL/nWkO7nPTjFhpM7gIsNYxFc+KJ6j3ydcS9531DQr/N
	UhLH9X2dh6/jz71w+9mWR9CdqyV//rryLmGZhXrD//lFqNEsy5HeDp+IfbONrdsYgUYSzfTAaY6
	jYiNKBRRL
X-Received: from pfob3.prod.google.com ([2002:aa7:8703:0:b0:842:1ca8:3c1])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1da3:b0:842:4b88:20ee
 with SMTP id d2e1a72fcca58-84284f77fecmr5591778b3a.44.1780538569061; Wed, 03
 Jun 2026 19:02:49 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:43 +0000
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-22-jrhilke@google.com>
Subject: [PATCH v5 21/21] KVM: selftests: Add xAPIC support in IRQ test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add the '-x' flag to tools/testing/selftests/kvm/irq_test.c to configure
the guest to use xAPIC mode instead of the default x2APIC mode. This
expands test coverage to ensure that IRQ injection and routing work
correctly when the guest uses the older xAPIC interface.

Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 28 +++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 41c50caa928e..7e421cb7bc69 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -20,6 +20,7 @@ static bool guest_received_irq[KVM_MAX_VCPUS];
 static bool guest_received_nmi[KVM_MAX_VCPUS];
 static pid_t vcpu_tids[KVM_MAX_VCPUS];
 static bool migrate_vcpus;
+static bool x2apic = true;
 static bool irq_affinity;
 static bool block_vcpus;
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
 
@@ -144,7 +154,7 @@ static void kvm_clear_gsi_routes(struct kvm_vm *vm)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-b] [-c] [-d <segment:bus:device.function>] [-h] [-i nr_irqs] [-m] [-n] [-v nr_vcpus]\n", name);
+	printf("Usage: %s [-a] [-b] [-c] [-d <segment:bus:device.function>] [-h] [-i nr_irqs] [-m] [-n] [-v nr_vcpus] [-x]\n", name);
 	printf("\n");
 	printf("Tests KVM IRQ injection via irqfd using an emulated eventfd.\n");
 	printf("-a	Randomly affinitize the device's host IRQ to different physical CPUs throughout the test\n");
@@ -155,6 +165,7 @@ static void help(const char *name)
 	printf("-m	Pin vCPU threads to random physical CPUs throughout the test\n");
 	printf("-n	Deliver 50 percent of IRQs as non-maskable interrupts\n");
 	printf("-v	Number of vCPUS to run\n");
+	printf("-x	Use xAPIC mode instead of x2APIC mode in the guest\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -191,7 +202,7 @@ int main(int argc, char **argv)
 	unsigned int irq;
 	int irq_cpu;
 
-	while ((c = getopt(argc, argv, "abcd:hi:mnv:")) != -1) {
+	while ((c = getopt(argc, argv, "abcd:hi:mnv:x")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -217,6 +228,9 @@ int main(int argc, char **argv)
 		case 'v':
 			nr_vcpus = atoi_positive("Number of vCPUS", optarg);
 			break;
+		case 'x':
+			x2apic = false;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -229,6 +243,9 @@ int main(int argc, char **argv)
 	vm_install_exception_handler(vm, vector, guest_irq_handler);
 	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
 
+	if (!x2apic)
+		virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+
 	if (device_bdf) {
 		iommu = iommu_init(default_iommu_mode);
 		device = vfio_pci_device_init(device_bdf, iommu);
@@ -250,6 +267,7 @@ int main(int argc, char **argv)
 
 	kvm_assign_irqfd(vm, gsi, eventfd);
 
+	sync_global_to_guest(vm, x2apic);
 	sync_global_to_guest(vm, block_vcpus);
 
 	for (i = 0; i < nr_vcpus; i++)
-- 
2.54.0.1032.g2f8565e1d1-goog

