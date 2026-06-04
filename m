Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B1031715F
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538565; cv=none; b=ouc+Jn7aNtykQCY0SQ4I6a4+MRUOdhbVx6RgxI2LlEzGdydVh1QT16eUhwNUVwWkFulDhwqkNCp2fbHlHic3BBj2BNKMnLLaD2gzBKpMfmf3s/UputzswxuN2ijiWubIVaZAl2Ifw8P/puhJAlZNEeg7BPdpkvUjykkedat7LTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538565; c=relaxed/simple;
	bh=dafLdLWgdXnx6V1IXIlCD6pLVM3B3uy7mgOFoWSI8Q0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gZ4Tkz162Gpd6D/co4Kaf1y8ibREoEhq72XBnjj6wPJAff23yYKcR9HONQ72X4vT81E0prfqkD/5x2KS8R02Q90+oFEwYf53vB95np821sN+o4h5U5J+0Ne3KJweNNQmX3ADfzBMRxdex1OaUrPy9chX2IzcwWF9audDsFpPvvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vm6oCVBm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vm6oCVBm"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0a81c1738so1314045ad.2
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538562; x=1781143362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nxNows63/pttd4Lw3zcWQn2ehHsMc8vxDlx8tQK6YAk=;
        b=vm6oCVBm0GQhlv8TrWXcG/OJUZQ6AYLIt+341topHvO3bLqK5zXpvbn5Cm9blVYL3w
         iC1qzWSH00kkgY1TOdeD7JvKiLefqBS9hDR7oJErDGmS7yIXhifkVRt3MbTbd6BqNkTH
         1UGyISZiRQJRB2t91zH0W1GGESiBVkb9SLYtr+q3Qao2oT1s7DyKKT+JSUlaP0my/TYg
         Tbd/z+EEWRuQGpdhgFvB8XS5FC005h/PMwQc7HQB/jKbhEeavWnAsK8UBxLiPWA83Twd
         iQ+UzvzqegqfCGwhPPJ21+zS4Bp42cKydQkPUw4dCY29/9IKjEHxXJVuu35Bt+2Za5hC
         kGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538562; x=1781143362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxNows63/pttd4Lw3zcWQn2ehHsMc8vxDlx8tQK6YAk=;
        b=dZ6dCHCnBT7F4iaa51RYpzUy73uYn2m336JZPrxwxFOj/9LxIGNG5yEtGDzK7moa/7
         gwmhu0K2AhqR/0hQGGSOoljd1McN/oUMo82gO/zwuTinPYp11Zkq2ZBd/8Yngty/s3vi
         O0kkVr6GVNEQEVeZVNqGtWwlTWeVsDyIXqZvWYkYrPNCMjT5eXQDaWot2gW39apvyePt
         fc8A3Q1kbzWmo4AO4WaNd5s681iM9BfK39jan2gsTdb15RptdjDxQRTYbnfDP8sXwgFA
         d2eGDZKEfjhsHeIXAeh/vE1rmTv+pGdn0/bV18e1rZi0CVCOoNPHRKOaWbk+aTEjixg4
         gWKg==
X-Gm-Message-State: AOJu0YxhxvZ4jP7DWfFkDQv2YcKJZ3IQgj1V3bKGfhaGMaFgjN7FPlc5
	DXOP38KkLlr23qGwcS4/KuReVYRhavioIGdUn1VoEJA6yTyfaMZy2X974M/5y1ho1CJLwz5GMXt
	hvtjIZ3al
X-Received: from plbjy14.prod.google.com ([2002:a17:903:42ce:b0:2bf:3684:64d2])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3888:b0:2c0:ab82:6b9d
 with SMTP id d9443c01a7336-2c163fb26ebmr66553025ad.29.1780538562124; Wed, 03
 Jun 2026 19:02:42 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:35 +0000
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-14-jrhilke@google.com>
Subject: [PATCH v5 13/21] KVM: selftests: Make number of IRQs configurable in
 IRQ test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add a '-i' flag to tools/testing/selftests/kvm/irq_test.c to allow users
to specify the number of IRQs generated during a test run.

Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index b0c4547a7f14..de8c29baa2b0 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -123,13 +123,14 @@ static void kvm_clear_gsi_routes(struct kvm_vm *vm)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-b] [-c] [-d <segment:bus:device.function>] [-h]\n", name);
+	printf("Usage: %s [-a] [-b] [-c] [-d <segment:bus:device.function>] [-h] [-i nr_irqs]\n", name);
 	printf("\n");
 	printf("Tests KVM IRQ injection via irqfd using an emulated eventfd.\n");
 	printf("-a	Randomly affinitize the device's host IRQ to different physical CPUs throughout the test\n");
 	printf("-b	Block vCPUs (e.g. HLT) instead of spinning in guest-mode\n");
 	printf("-c	Destroy and recreate KVM's GSI routing table in between some interrupts\n");
 	printf("-d	Use a VFIO device to send MSI-X interrupts instead of using an emulated eventfd\n");
+	printf("-i	The number of IRQs to generate during the test\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -164,7 +165,7 @@ int main(int argc, char **argv)
 	unsigned int irq;
 	int irq_cpu;
 
-	while ((c = getopt(argc, argv, "abcd:h")) != -1) {
+	while ((c = getopt(argc, argv, "abcd:hi:")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -178,6 +179,9 @@ int main(int argc, char **argv)
 		case 'c':
 			clear_routes = true;
 			break;
+		case 'i':
+			nr_irqs = atoi_positive("Number of IRQs", optarg);
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
-- 
2.54.0.1032.g2f8565e1d1-goog

