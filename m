Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBD83A872A
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986111; cv=none; b=AeuYUlSJ2AEa/gH2dVKLlnJwQ95ZttkOWIYAgiXFF3Fc+XTllJn3PjwZk9ffDrmNO/hWhlsVRHtjG4qBOSgp5nf/2kwmuwBi49RYN880lI9dy7Kn48wQnfNMsEdheHmAOAihb9nKaK6LupcX3ayBfCXyxYvjpYi4WE930Ryqf1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986111; c=relaxed/simple;
	bh=P4QrZ6iBlp0WSADdpmIS8D4np8J7E0ei9W07xCJWxX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uHwcywxcYjpHKqGv2awra7qkrzwwN5c2WQTPXT5JD6ZFo4ofBGL4UQ9W1Yt3kIEV+W31Bhs5EZ6/TMznDVmxPimUWFD39vDDENvdq65YPpIzuI1CJOnor548LOsYIkLA5bcwF6nD0pwSA2VqhW4z273OXhA6qe6U98LZfu0Y4Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=avq+f88C; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="avq+f88C"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c6929bd26so10025383b3a.3
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986109; x=1775590909; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bOIjxDZ+8P3srB1/ihVvJJjCQWIf21JptIqBnpZHmmg=;
        b=avq+f88CQTODZ31Hlg/9i1iQNmMgLVbs50TrKjYY/szHQo/i2Gk+pHvcqwArWNl5gL
         fhlVBf3EFJAggtmSH7Jyxt21rEjROSXMLCW3GXNGIwOO3h75v6GjCqMIiThPzYvxCOvW
         ZbsACyOIjsE8eS+m4wx2hXnvVhHtNXyBA36w2kouF5tWbPqHgUurMGItv+M6QsI2bciq
         eJauhh4vQIFoyocgCOZG0bIXBR5qGReE5TTbfjrvw/JlfP4N4cxrdVPscrIg4rzde8T9
         j71xvrLkaYOEbsOtGBMGaa7CPZvcivANazqqoc/Z0OvXqq07e0AbBfqYVD3lqRW+4JRZ
         9taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986109; x=1775590909;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOIjxDZ+8P3srB1/ihVvJJjCQWIf21JptIqBnpZHmmg=;
        b=gaH8uLooGo3Q4Uivt0B76X7OqNdE6QMZe8PrXYb8eVscqtWo2ZSFM2q5KFR6eprSAl
         QvGB+8PIPP5X2fvBxuTa95JwEQcMi5pmAhNuD/sSWfoaxMJvOV18RRDJgTOHeGm77CA2
         Dg3kFY5/JyN493Uomg3Xwbzz8T1A0LwlBM6lBooe68Poen26atXDs9iX0aY1ZOJdYDvh
         KnWI7/eNqwP46PZLcxFC6WVuf0eRpfmcm+CMi7S3i97KaCQDU+pNSh6w/ELSWasHzQ2n
         laCdF5FsZiaGC5Go+Wo3urwgfMBwi+duw2vPnhO0CFyIIFgStl7hSK+I3iJdDpniEDDw
         v5Kw==
X-Gm-Message-State: AOJu0YyjrFc9vDKzFCIgd6qR0NXMcs1c1wQYIRjddB+9OX0K2hPgzMRI
	zWMsjnIa2HjZrnArVjDNyAqLF+ulwbwe2gwvZQSOCyx5dBdvFqX/qbXRaULHIULzYQzsgO8wVTf
	GCn65lsj3
X-Received: from pfbhh5.prod.google.com ([2002:a05:6a00:8685:b0:829:8ad6:fe7f])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:908a:b0:823:1252:9428
 with SMTP id d2e1a72fcca58-82ce88f596bmr879625b3a.9.1774986109404; Tue, 31
 Mar 2026 12:41:49 -0700 (PDT)
Date: Tue, 31 Mar 2026 19:40:32 +0000
In-Reply-To: <20260331194033.3890309-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194033.3890309-14-jrhilke@google.com>
Subject: [PATCH v2 13/14] KVM: selftests: Add xAPIC mode support
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add the '-x' flag to vfio_pci_irq_test to allow the guest to use legacy
xAPIC mode instead of the default x2APIC mode. This ensures the test
verifies the interrupt delivery paths for both generations of APIC
architecture in the KVM selftest environment.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
---
 .../testing/selftests/kvm/vfio_pci_irq_test.c | 28 +++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/vfio_pci_irq_test.c b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
index 8c6c7c424b92..2dcac6fbc009 100644
--- a/tools/testing/selftests/kvm/vfio_pci_irq_test.c
+++ b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
@@ -15,6 +15,7 @@
 
 #include <libvfio.h>
 
+static bool x2apic = true;
 static bool done;
 static bool block;
 
@@ -28,14 +29,20 @@ static pid_t vcpu_tids[KVM_MAX_VCPUS];
 
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
@@ -45,7 +52,10 @@ static void guest_nmi_handler(struct ex_regs *regs)
 
 static void guest_code(void)
 {
-	x2apic_enable();
+	if (x2apic)
+		x2apic_enable();
+	else
+		xapic_enable();
 
 	sti_nop();
 
@@ -186,7 +196,7 @@ static void send_msi(struct vfio_pci_device *device, bool use_device_msi, int ms
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-b] [-d] [-e] [-h] [-i nr_irqs] [-n] [-p] [-v nr_vcpus] segment:bus:device.function\n",
+	printf("Usage: %s [-a] [-b] [-d] [-e] [-h] [-i nr_irqs] [-n] [-p] [-v nr_vcpus] [-x] segment:bus:device.function\n",
 	       name);
 	printf("\n");
 	printf("  -a: Randomly affinitize the device IRQ to different CPUs\n"
@@ -202,6 +212,7 @@ static void help(const char *name)
 	printf("  -p: Pin vCPU threads to random pCPUs throughout the test.\n");
 	printf("  -v: Set the number of vCPUs that the test should create.\n"
 	       "      Interrupts will be round-robined among vCPUs.\n");
+	printf("  -x: Use xAPIC mode instead of x2APIC mode in the guest.\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -244,7 +255,7 @@ int main(int argc, char **argv)
 
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
 
-	while ((c = getopt(argc, argv, "abdehi:npv:")) != -1) {
+	while ((c = getopt(argc, argv, "abdehi:npv:x")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -270,6 +281,9 @@ int main(int argc, char **argv)
 		case 'v':
 			nr_vcpus = atoi_positive("nr_vcpus", optarg);
 			break;
+		case 'x':
+			x2apic = false;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -280,6 +294,9 @@ int main(int argc, char **argv)
 	vm_install_exception_handler(vm, vector, guest_irq_handler);
 	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
 
+	if (!x2apic)
+		virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+
 	iommu = iommu_init(default_iommu_mode);
 	device = vfio_pci_device_init(device_bdf, iommu);
 	msi = setup_msi(device, use_device_msi);
@@ -295,6 +312,7 @@ int main(int argc, char **argv)
 
 	kvm_assign_irqfd(vm, gsi, device->msi_eventfds[msi]);
 
+	sync_global_to_guest(vm, x2apic);
 	sync_global_to_guest(vm, block);
 
 	for (i = 0; i < nr_vcpus; i++)
-- 
2.53.0.1118.gaef5881109-goog

