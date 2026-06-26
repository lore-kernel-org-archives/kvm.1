Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE313CA497
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509756; cv=none; b=iwON8FbdbqVE2YYUmTQuxJFf8iIMEmQQ0XJ8YInLmW3enrVLnf/FF3s6QAM99+koJsr7P4MVH/r4iRah5dtSRaqAK+uolH6e5rJx5SCF8s95VPH7VInE6lnRjo7TalA5uqL2hS23omFovMatheHBvb4zaSWMHJzLN25MyirrW60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509756; c=relaxed/simple;
	bh=2uyOYEokTiVVIUDBjPDyg1aZa20yup9XuSi/76mLVaY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YgO3YsGkIlXBuTsGjUsj9sDN4dnucXpg9qbUydufYvfCnJ9hSyCHWH6udMMFUhlfIYwG3KC3j64uyCFhk7kX5W6MMSJM1L5IyfWOq6MU0VVp1xSzvDx/Wi1tmxeOHL/hXd8UhXXH3VBbOPK7fAFCCFxo2K/kbPc/AuxOXm39g8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+lk3XFi; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+lk3XFi"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37d4eede8ccso871544a91.0
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 14:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782509752; x=1783114552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MgDHYDGdp3s1Dejk8hKBifIQkaWCPHBgxY5F3+CDVvM=;
        b=K+lk3XFi3uN70/4XiMqoQWgSHPeZxkUpe0mYDVD45J+G2BhqZaXHuYzgQJvJekQ+OR
         EwUQHwTxOf6gUVtUnAutb/fEZS9up7IYqFQP8sCsOc3wqCOPvKm5kLcYOwi/v26kIOsF
         M0Cv0UtrgMt18i7I3zb9pnCubJnJnLlxr+OweCq9kZkeGGmXT5UHPyrJVzkI5XzgaigK
         krNkCP8vc8t/5BpP+5jOLF5mAk86wMgXWe7Wm7VDVpROYq+FQbyelkyvL5AqXUsHb+MH
         R7QoIbuLVD1vXM9U4yii+nINzf0Ky2BcKCjaOBqkriP3cjHXYLVjTkG+c7LGO4HL3wVK
         YBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509752; x=1783114552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgDHYDGdp3s1Dejk8hKBifIQkaWCPHBgxY5F3+CDVvM=;
        b=fw80XiVH37gJPXZ7pQ8hRN7vnt6ZYUbSVH1asLk0MPY8FYnxR6zg77s3RSQYvcOxVk
         odgAKmjBdxTrTG6bZQUAVzW0S4Y3etLqQESgWH1F7bVDAUUVZgqdcHqJUpBuwp+4br+0
         +3dHYIQsxnOwLAN+KQjLRV62cBG4yO3AgwIW+5H1r7glDVnAUmmTkKDkG0aO1UKcuke2
         oAAIZqX8AfmUSZ9Ez6GuajsrvFlMMkbBoJOi6yyPTXY/TmVLqgqvW4Q3v9Emyu5Y+ERn
         0DTPCbh0X04FnGkB/t64Xgbse1FGE4x9cOa8l1XqWc+O12vh4yhwqsYjbpzy7/7hg9kx
         pD0A==
X-Forwarded-Encrypted: i=1; AHgh+RpKhdec0BsuY2O934qoJfZk0RiazK477caltgJio/8DqFIQUM7WIjamVW/ZgVIatp5XgAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySRvVxUWMmi0L90S7pQpuRX1lN+Mr50Hrsxfr9dirGSCb/JirX
	msgHf3p/bZTj1Tq3ww+fA0qEKHGsv96UX9OBs8Argx+Ufguux8U8NQ/8O9lrAbM+xdJ5/Bkm8fu
	9FBrjpQ==
X-Received: from pjbch13.prod.google.com ([2002:a17:90a:f40d:b0:37d:c9ac:4621])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:46:b0:37e:1ff4:44c0
 with SMTP id 98e67ed59e1d1-37e1ff4463cmr2659910a91.12.1782509751839; Fri, 26
 Jun 2026 14:35:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 14:35:26 -0700
In-Reply-To: <20260626213534.3866178-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626213534.3866178-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626213534.3866178-14-seanjc@google.com>
Subject: [PATCH v8 13/20] KVM: selftests: Make number of IRQs configurable in
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
index fd03ec940362..bb20bb81e930 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -146,12 +146,13 @@ static const char *probe_iommu_type(void)
 
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
@@ -186,7 +187,7 @@ int main(int argc, char **argv)
 	struct kvm_vm *vm;
 	int irq, irq_cpu;
 
-	while ((c = getopt(argc, argv, "ad:eht:")) != -1) {
+	while ((c = getopt(argc, argv, "ad:ehi:t:")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -197,6 +198,9 @@ int main(int argc, char **argv)
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
2.55.0.rc0.799.gd6f94ed593-goog

