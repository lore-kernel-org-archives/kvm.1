Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A507B2C21C4
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 00:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052838; cv=none; b=FwcSWK++m3+hN5iUxvK/KXFbmZmBzYJU75l64Ky1R+VhEL+sNxnW6awlxwzk5V21LoCS4aRrnT75yeLaie/kIizuS7wiravb2PpjF0aPABfW4IuADxFfMGiQEABwn+NCRMr89EFTOgSMnL1PwNiuUpCwoVC0YKfHy2cew+YczRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052838; c=relaxed/simple;
	bh=cK0u21533hQOp00QT4x7wZx/zixQd9DS3f8jAIahGlk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r3Wmnkf/mUrSHUEDI2cY1lKN6vCcwLMX4zvklmFSAqAc7yVuGd8XCeBBR9oVk8QyFqyjBa6z7ILSV+BzxkNwS53Rywc+Jt88KAIckR7gIMleTjkgaiDMR8g+4MD0T769O3SbKw45cPQAYETsuBxwZS5HOnDdPXOOhXcyX3yqyp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oDPZ6E/o; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oDPZ6E/o"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2beff6b6e74so61321225ad.1
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 17:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781052836; x=1781657636; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Tqxmpm7d/JaqIgSqRfX3CyBlzjwL6Mz/tL0QEbP+aa4=;
        b=oDPZ6E/oO5v2deA1PepCCxIwWTeeKl64QfMBsOXACodmeBTFU+Rl2Q0awN2ZxW3kPJ
         kAWP6Sf6mCgFnFtSogOGy5r4CX0N8VbYVxpW0YYt815aMFIIaCyqunXbZVm34SK8Z80L
         9Dlg2seY27VAlnT4VkMzNUj6uF2/fh+3dwa3K8tJHnCWuLmCAjB72XlAdQzPV+2Fg1p4
         CSx8xETlHorvmTN4WBzpeUl08zUQndGxk0kG/laH8D2CP1lrJj2P0JNWbNTBvQBIRqRx
         Y3b++Bd93cV0cWcx6gCrIR2VTUgmr8lZItQgrgIShVuzahbbiD3dSaa5TR2zJG4KtceO
         lK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781052836; x=1781657636;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tqxmpm7d/JaqIgSqRfX3CyBlzjwL6Mz/tL0QEbP+aa4=;
        b=rTNpa9J/vtyzRU9SLaRDWAD0HbdbtGfto1xvXJSOP8xJSeEJC32LCVdl1EXm7HnFuI
         69Y6NzCNgpt9eKezVdWC1IZqd8HRWMbYA420XC79CdgqXZjcMVlkMjQSA48aXGuOu3aC
         PE5JHJJigSd+L0mHa33/FpndO9w+9wgYkIuvJ4nN7NxNqIn2n/r4TifhgijS+WdXAoif
         dzusJ6ZRpaY9HlgepAcoJrszq0tq3DV/LhC3pLrr3G+UnX8SrXQkJA+JfPe9QxbneQcf
         ulKR8h3RSn4zX3f+clElt3ujfe7PIH+k07m6O26bWUl9H0IPdzjdl/Aq01tJRFD66+D2
         NrKA==
X-Forwarded-Encrypted: i=1; AFNElJ/XpU2TlnmCifvZVKd7XsucgqYmFHVe+erdgojf3GTwL/b+F7V+lQmH4aWH1HC0OzSa6lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMCxr/4MlhjlHoTvKcCuHfL7/UODlHQxWFK8B3vMcRBx/cYHzf
	AbpSVPkiQu3sUu1XJ7C5ld72Z2BJoXhlRSdu3vfRyoO0ZEpmi2kM7n79QWCdjRwmO5VpNBCBCta
	79Fz0Gg==
X-Received: from plsa5.prod.google.com ([2002:a17:902:b585:b0:2bd:4f41:fbf4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c946:b0:2c2:5446:30dd
 with SMTP id d9443c01a7336-2c254463670mr157005975ad.7.1781052835786; Tue, 09
 Jun 2026 17:53:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jun 2026 17:53:31 -0700
In-Reply-To: <20260610005338.2967132-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610005338.2967132-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610005338.2967132-12-seanjc@google.com>
Subject: [PATCH v6 11/18] KVM: selftests: Make number of IRQs configurable in
 IRQ test
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

Extend the eventfd IRQ test with a '-i' flag to let the user specify the
the number of IRQs to generate (instead of hardcoding the test to always
generate 1000 interrupts).

Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 2ad9efd9abc7..15791ba0a2f9 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -134,12 +134,13 @@ static const char *probe_iommu_type(void)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-t iommu_type]\n", name);
+	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-i nr_irqs] [-t iommu_type]\n", name);
 	printf("\n");
 	printf("Tests KVM interrupt routing and delivery via irqfd.\n");
 	printf("-a	Affine the device's host IRQ to a random physical CPU\n");
 	printf("-d	Use a VFIO device to send MSI-X interrupts instead of manually signaling the eventfd\n");
 	printf("-e	Set empty GSI routing in-between some interrupts\n");
+	printf("-i	The number of IRQs to generate during the test\n");
 	printf("-t	Override the IOMMU type to use (vfio_type1_iommu or iommufd)\n");
 	printf("\n");
 	exit(KSFT_FAIL);
@@ -174,7 +175,7 @@ int main(int argc, char **argv)
 	struct kvm_vm *vm;
 	int irq, irq_cpu;
 
-	while ((c = getopt(argc, argv, "ad:eht:")) != -1) {
+	while ((c = getopt(argc, argv, "ad:ehi:t:")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -185,6 +186,9 @@ int main(int argc, char **argv)
 		case 'e':
 			set_empty_routing = true;
 			break;
+		case 'i':
+			nr_irqs = atoi_positive("Number of IRQs", optarg);
+			break;
 		case 't':
 			iommu_type = optarg;
 			break;
-- 
2.54.0.1099.g489fc7bff1-goog

