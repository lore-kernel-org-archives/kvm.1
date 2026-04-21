Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA463AF65A
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813422; cv=none; b=QPh07X0PoDogk5jXmabOI65jRrnOgNwqvauMTAJOF3QjYG4wnd+I1tckHvoFEK6MCxK086LBNagAw6fjqjnS0Y9muqa8hBRYlSs3ernXODwZihg7iUApGHvlqrt4UpiD+SDkRAPyXAiRZJpm/v2KFlQfP6uxpa4vmfROPRucHZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813422; c=relaxed/simple;
	bh=fj7JUx1AwMGW7mIKH0BhadVvQ5Y5pYoHLkslfo3qCQw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D60Kqed7Qnz0Z2PEUkn2qzEMoBUkK/XpCdxu85H1HFU4O05Z5Rl/XWMDk8/j2S+2/MHIARpeTrqnp+OWlwXK9oioarz48I8hGb/I3ajt2umZ61QYb4NBdazVLm3z+9ws4ErShOpEfrvCw58Rotba2AOH/WTil6fq6zlj5Qwg1M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y28cWqv+; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y28cWqv+"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c7973e22399so1762275a12.0
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776813420; x=1777418220; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l9nBhlqR+0aAnoMpV5TVq1zZN0Z8CLajwssRZVTrrkI=;
        b=Y28cWqv+yKbtfsQFonSgzpNUixq9kRveNf6siv4WgN1BiaYvLPLabCudFvLi32y6LX
         k5ecpgvDC3pNWFQTvS59myDRnRVinaQ55/JOs5Rxw5agcb8P+9saXmVZPKpZn/QGvskC
         xAASMO4Uq9jNZCWSqHK4hVCvrJmNTDtWPfckyhwpHU/ApmnfFhOssdk6/pm6E24ZWxRk
         NiFo7kZ1Xu12uQ/bJ2vt++d18AnWcj0swxGmP/zoHPo/ngDvDSCUBavHalHmIXVMg9L5
         T5As0fAYVahokL4Fk/eTzVlCNJiEfauY2/YZCKICcmrkXcSjNObTmCuu/uEyTbtZzf7R
         2pRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813420; x=1777418220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9nBhlqR+0aAnoMpV5TVq1zZN0Z8CLajwssRZVTrrkI=;
        b=NBFySTf+e73GgfXD/TqnU7TeeeVWlpIsMhKGuzmR+JAo74Jua1/Fd3nOEplyJ3yNoO
         UJ1xApNeV9Fm9l2pW05iMpFpa6XBtsz6SwIOBif9D635d0Gn0MbslHzvsmvYEp3XToj+
         IXlBcpgnBBMc4y91lffKioTORuAeaLXeGZLp+m6Ce8abrSz21oy/oy+BaYVnT/mq1TpP
         F2XfmNe01FKz59Fn07/BVpTUwpYtXGR1YSqwmAx9ZqbFK1WNp6KYWRsGdL0N/25txpNd
         IK8p50UHh0YFqL54f5WvpGHl4f2GIP4zJhrRWPwdeC/iSgjJT2gJ6RhQIz5rwN3T1aV4
         U6PQ==
X-Gm-Message-State: AOJu0Yw2nOcLuaFC/pji2TzGqrNfrEO49ZIeE8VcEVV/t6IqrJ7R+msY
	ZPh7uLS2snXjjSAYXwnd7flIPItOGs4A/64JdVAA+Jf9KvSG+Rjuo0ofZ+7ySfMPPRg/MIjznj5
	bXbNzXMyM
X-Received: from pgkk7.prod.google.com ([2002:a63:2407:0:b0:c74:42:8984])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0c:b0:3a2:e59a:7a46
 with SMTP id adf61e73a8af0-3a2e59a83femr6744428637.24.1776813419838; Tue, 21
 Apr 2026 16:16:59 -0700 (PDT)
Date: Tue, 21 Apr 2026 23:15:57 +0000
In-Reply-To: <20260421231557.1254270-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421231557.1254270-17-jrhilke@google.com>
Subject: [PATCH v3 16/16] KVM: selftests: Add xAPIC support
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
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
index 6fd082d37f9a..99698cf143fe 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -20,20 +20,27 @@ static bool guest_received_irq[KVM_MAX_VCPUS];
 static bool guest_received_nmi[KVM_MAX_VCPUS];
 static pid_t vcpu_tids[KVM_MAX_VCPUS];
 static bool migrate_vcpus;
+static bool x2apic = true;
 static bool irq_affinity;
 static bool block_vcpus;
 static bool done;
 
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
@@ -43,7 +50,10 @@ static void guest_nmi_handler(struct ex_regs *regs)
 
 static void guest_code(void)
 {
-	x2apic_enable();
+	if (x2apic)
+		x2apic_enable();
+	else
+		xapic_enable();
 
 	sti_nop();
 
@@ -139,7 +149,7 @@ static void kvm_clear_gsi_routes(struct kvm_vm *vm)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-b] [-c] [-d <segment:bus:device.function>] [-h] [-i nr_irqs] [-m] [-n] [-v nr_vcpus]\n", name);
+	printf("Usage: %s [-a] [-b] [-c] [-d <segment:bus:device.function>] [-h] [-i nr_irqs] [-m] [-n] [-v nr_vcpus] [-x]\n", name);
 	printf("\n");
 	printf("Tests KVM IRQ injection via irqfd using an emulated eventfd.\n");
 	printf("-a	Randomly affinitize the device's host IRQ to different physical CPUs throughout the test\n");
@@ -150,6 +160,7 @@ static void help(const char *name)
 	printf("-m	Pin vCPU threads to random physical CPUs throughout the test\n");
 	printf("-n	Deliver 50 percent of IRQs as non-maskable interrupts\n");
 	printf("-v	Number of vCPUS to run\n");
+	printf("-x	Use xAPIC mode instead of x2APIC mode in the guest\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -183,7 +194,7 @@ int main(int argc, char **argv)
 	struct iommu *iommu;
 	struct kvm_vm *vm;
 
-	while ((c = getopt(argc, argv, "abcd:hi:mnv:")) != -1) {
+	while ((c = getopt(argc, argv, "abcd:hi:mnv:x")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -209,6 +220,9 @@ int main(int argc, char **argv)
 		case 'v':
 			nr_vcpus = atoi_positive("Number of vCPUS", optarg);
 			break;
+		case 'x':
+			x2apic = false;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -221,6 +235,9 @@ int main(int argc, char **argv)
 	vm_install_exception_handler(vm, vector, guest_irq_handler);
 	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
 
+	if (!x2apic)
+		virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+
 	if (device_bdf) {
 		iommu = iommu_init(default_iommu_mode);
 		device = vfio_pci_device_init(device_bdf, iommu);
@@ -243,6 +260,7 @@ int main(int argc, char **argv)
 
 	kvm_assign_irqfd(vm, gsi, eventfd);
 
+	sync_global_to_guest(vm, x2apic);
 	sync_global_to_guest(vm, block_vcpus);
 
 	for (i = 0; i < nr_vcpus; i++)
-- 
2.54.0.rc2.533.g4f5dca5207-goog

