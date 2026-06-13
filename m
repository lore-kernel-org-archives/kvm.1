Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBCD233939
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310053; cv=none; b=hbSPhVDMR7KVm41XACtlsZKL5gnboGfrC6n+lP2YVInbnlo4fcSRYNfjnh966csAK++5uGINxkwP6oMc7IS9g5x5BlOzvlBPyct+kzEqUBIOZ7ZqN636BkeFx8YLIaOMVJHwMbzL3wUZKS+TSalNR9lkg6OiY20TnPrjKSn9poM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310053; c=relaxed/simple;
	bh=M/n+s2ScTJoVUw7uG6hi9PjTyqlDpaI5PqGjdNus3Rg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pAE5fuXESXoHuTj+X8bueCsnYkueqIOeQzh/98uwfelaWIyg09HxkrQjZQkNVntCc0KowbehWKhuwysphv2Tu4dWuOCW3cTZ+H9gTq9D7+icPAOLKIO7dfnZuWy002pFKjlyrybHMSO+B10FWcKVOUWQUS1xe16abZ+Fg2pdZoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SN2Rs8rT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SN2Rs8rT"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8424aac207eso1624416b3a.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781310050; x=1781914850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rIJ8Uf8PcJidyyeBqiFcFwTrdNm0vIWb+NN/Ok5zc0s=;
        b=SN2Rs8rTXwMHDyrUXHNfefJxos7FcpiIZC5wehp1q7Bl+/1mi3GbBBq5QkupY+Jt20
         NY7l7l/dypSpJrdP/rxTAQkHwHL4A5ncwaCx1LTiZjzGg6+LYkMde26MmqY9uQFzk7WK
         Xj+g+Q04R+yqIR+FjUG08xHAuScmVEV3F93ko3itY2ycaukqSxEYuVDt5FKJ7LJd5EdL
         rx5H26MGe1c/7eG5JKpZ1CoWbbwSeMMsgPhjlhoRb8nMELwt06KKltHUykTZqcHIARyL
         koHloXyGsNSMspVi82TKwMhm4e42HTKG59ebyMu3uY92F5TsmBB6VPuBeQjmjbgUCNtz
         ar/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781310050; x=1781914850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIJ8Uf8PcJidyyeBqiFcFwTrdNm0vIWb+NN/Ok5zc0s=;
        b=k2Wv3WNcFjPhfmTvl6KwuT5/aBRfxw48nSiA/7lq5DZeN+zCFQpnzmpMcZy1EtkZAN
         b19KQ7EwibJVGeWBSniYgUXc2LidPhZvm7i70K+M6XZltFFxw+XSdHPeOzINRHVkE39Z
         08MLIUEbeZ8FUVTYpKSHLhCOZlvQAXsrIwSUghyIBYS2ELuliPwVUshha6MmPVQZMW95
         hXGdMyWveRHHMJqIO4RgO9KMYPJk2RKbZNsnUXw4H4MAXTFOYH5sfycpqENN+tLLDQL+
         +GDovaNP9zLl3X2fGO0SH1LXopiqacS87GERTNqKr2tICPWG74hD/KZkRTOT6b7DojY5
         565A==
X-Forwarded-Encrypted: i=1; AFNElJ/9CMZ5WkSgSeiefoQX3Z+1XOv2BiVeBpDc50Vf2JoBtG8SLbCojJbMNQ3wwMUTHL3uS4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd2K0ewQFCtwQYMLlqTZa/d/dWgPe8EkW3gjozA2OHyL4f6s43
	sPORQ5Q1m+cMTfip+3zzZyvYXcAjf5uX0EWpz65R6Jk0qV1l0zY0iDCsLWOJWlwJejg/v0ao1Xv
	kMLH4jQ==
X-Received: from pghm14.prod.google.com ([2002:a63:f60e:0:b0:c79:87d6:650a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:486:b0:39f:a8fb:3354
 with SMTP id adf61e73a8af0-3b783b9cceemr6105295637.17.1781310050361; Fri, 12
 Jun 2026 17:20:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:20:23 -0700
In-Reply-To: <20260613002031.745413-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613002031.745413-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613002031.745413-13-seanjc@google.com>
Subject: [PATCH v7 12/20] KVM: selftests: Add option to set empty routing
 between IRQs in eventfd IRQ test
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

Extend the eventfd IRQ test with an '-e' flag to set empty GSI routing
between interrupts.  Clobbering the GSI routing table verifies that KVM
correctly handles CPUx => NULL => CPUy transitions, not just CPUx => CPUy
transitions, and verifies that KVM can "rebuild" an entire routing setup.

Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
[sean: '-e' for "empty" instead of '-c' for "clear", massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index c01aa313f719..2356912e2272 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -109,6 +109,13 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
 	vm_ioctl(vm, KVM_SET_GSI_ROUTING, &routing.header);
 }
 
+static void kvm_set_empty_gsi_routing(struct kvm_vm *vm)
+{
+	struct kvm_irq_routing routing = {};
+
+	vm_ioctl(vm, KVM_SET_GSI_ROUTING, &routing);
+}
+
 static const char *probe_iommu_type(void)
 {
 	int io_fd;
@@ -127,11 +134,12 @@ static const char *probe_iommu_type(void)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-h] [-t iommu_type]\n", name);
+	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-t iommu_type]\n", name);
 	printf("\n");
 	printf("Tests KVM interrupt routing and delivery via irqfd.\n");
 	printf("-a	Affine the device's host IRQ to a random physical CPU\n");
 	printf("-d	Use a VFIO device to send MSI-X interrupts instead of manually signaling the eventfd\n");
+	printf("-e	Set empty GSI routing in-between some interrupts\n");
 	printf("-t	Override the IOMMU type to use (vfio_type1_iommu or iommufd)\n");
 	printf("\n");
 	exit(KSFT_FAIL);
@@ -158,6 +166,7 @@ int main(int argc, char **argv)
 	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
 	struct vfio_pci_device *device = NULL;
 	int nr_irqs = 1000, nr_vcpus = 1;
+	bool set_empty_routing = false;
 	const char *device_bdf = NULL;
 	const char *iommu_type = NULL;
 	int i, j, c, msix, eventfd;
@@ -165,7 +174,7 @@ int main(int argc, char **argv)
 	struct kvm_vm *vm;
 	int irq, irq_cpu;
 
-	while ((c = getopt(argc, argv, "ad:ht:")) != -1) {
+	while ((c = getopt(argc, argv, "ad:eht:")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -173,6 +182,9 @@ int main(int argc, char **argv)
 		case 'd':
 			device_bdf = optarg;
 			break;
+		case 'e':
+			set_empty_routing = true;
+			break;
 		case 't':
 			iommu_type = optarg;
 			break;
@@ -223,9 +235,13 @@ int main(int argc, char **argv)
 	irq_cpu = -1;
 
 	for (i = 0; i < nr_irqs; i++) {
+		const bool do_set_empty_routing = set_empty_routing && (i & BIT(3));
 		struct kvm_vcpu *vcpu = vcpus[i % nr_vcpus];
 		struct timespec start;
 
+		if (do_set_empty_routing)
+			kvm_set_empty_gsi_routing(vm);
+
 		kvm_route_msi(vm, gsi, vcpu, vector);
 
 		if (irq_affinity) {
-- 
2.54.0.1136.gdb2ca164c4-goog

