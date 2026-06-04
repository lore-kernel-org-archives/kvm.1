Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020536C582
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538570; cv=none; b=h+4xr93kfDvjlLFkpCzUz6u5yf2uaxZTkdq/iwDm9vlftIVLrnJ0xho6H5Wt5g8Wq4xYZyN6FoWd47A1HpqxC+ymckKietXRtMaWkTuSeaq4Hl/qxB7T5bb+LVCDyi5DM/WrnHEeCqta1FbrbK/fKmSFyH4jvEEVFIubAuzYvj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538570; c=relaxed/simple;
	bh=crMle9j802BTtYp3MWSaBHqe2spiu/UwBKtPWyz8ZEk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CJD9eZTYYYWDlCXPyNyXMsUkOjrNKKZeFBrp0qHTn4c8AP5iPqQKlviLaRjvfgOICC5HALvYaDTwAFMwzuj+tPmH/neg4lk3VnZ8i9Fts6mfAImNSkAV1dEJ/lHg8/lZNPSGa/QRik7SpixJoBg0/dKle+f2hfRm5VPXdhp3UCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YaXO5t3h; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YaXO5t3h"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0bfcd629eso2400465ad.2
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538568; x=1781143368; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G3j+8dIDJLDE9oCfttORZmcxZeBh/jFN2elFlpkhO2M=;
        b=YaXO5t3h8GCszjESfB1NapCEZzHOd9Xb07O3FWb5nQp5g9l8IWdm06MaEnHYWyEKgM
         TGCk0e+hTf7v1cVdisHHTSt7i8jQr44kkExpat20xr0DwBho1EZuz6cGPxSLMKqFvZc/
         1V+1GBhoAp1ZPFQWa1CqFHDiPk7WBIg+uREpS4+sy6mFTgMUycjxUfe2xVOYb4m16knu
         wuaw7Dv7bDE7uX4ChlnLLw+UX5E7TYtg+ApLaaE2DOfDF/36mHsNG5Hekp3U/tLqZGxG
         7JlDJpClsJMO9OWhy/GBLIL1gKisZ6S19ci7T5GCFvCnEs8AatM+jrwWLn0pZSevuvFe
         Sgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538568; x=1781143368;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G3j+8dIDJLDE9oCfttORZmcxZeBh/jFN2elFlpkhO2M=;
        b=lrPIrpMcV4Pjwi5uDyVQsJZ+sFW7yIT3171Htm+5LOPu2iAzUhzz9UB/yqLUKEZgov
         n0EvCegqmWNG5RzZEClBQHLWMsvfhMCyF9qYDd4uZHSu5pDK65axLqtnn2GqKr+RF1II
         EiDZFjCHldC9Ih3SNXYA8z1PEnCvJQgzXw6pFW5vQaP6MlLewowBhOrjY6oGe6BqF3Tb
         Sm2l4d8TzoGZcY5ZRc8J5eAuKPg+fvjzl2bQI976NQoAGC+EKxykKeFZMs804/XldxBE
         cGdszP0NpT52unB2ClcAlXVWIWtBC8DlptqLiSZEOjVu6OJ2MbThH8JQjQrulP9he2eB
         uBCg==
X-Gm-Message-State: AOJu0YwDeJsPJGlb/4UB71dVHWbCyLzkdB52REzBXvH0lD+4GlzJnesa
	1AqsZF4ux45c8DlZdquWQYQK7qZYzO9GxAnVWN9sgJf8m1tgfRFe1tanAVfuIEd8JCz/ZmUjgBJ
	k49ufS4qo
X-Received: from plbx13.prod.google.com ([2002:a17:902:ea8d:b0:2ba:3bc2:e980])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce87:b0:2c1:11b8:3c80
 with SMTP id d9443c01a7336-2c1644add47mr59129495ad.30.1780538568115; Wed, 03
 Jun 2026 19:02:48 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:42 +0000
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-21-jrhilke@google.com>
Subject: [PATCH v5 20/21] KVM: selftests: Make number of vCPUs configurable in
 IRQ test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add a '-v' flag to tools/testing/selftests/kvm/irq_test.c to allow users
to configure the number of vCPUs to run in the test.

Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 1d66293b6d0b..41c50caa928e 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -144,7 +144,7 @@ static void kvm_clear_gsi_routes(struct kvm_vm *vm)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-b] [-c] [-d <segment:bus:device.function>] [-h] [-i nr_irqs] [-m] [-n]\n", name);
+	printf("Usage: %s [-a] [-b] [-c] [-d <segment:bus:device.function>] [-h] [-i nr_irqs] [-m] [-n] [-v nr_vcpus]\n", name);
 	printf("\n");
 	printf("Tests KVM IRQ injection via irqfd using an emulated eventfd.\n");
 	printf("-a	Randomly affinitize the device's host IRQ to different physical CPUs throughout the test\n");
@@ -154,6 +154,7 @@ static void help(const char *name)
 	printf("-i	The number of IRQs to generate during the test\n");
 	printf("-m	Pin vCPU threads to random physical CPUs throughout the test\n");
 	printf("-n	Deliver 50 percent of IRQs as non-maskable interrupts\n");
+	printf("-v	Number of vCPUS to run\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -190,7 +191,7 @@ int main(int argc, char **argv)
 	unsigned int irq;
 	int irq_cpu;
 
-	while ((c = getopt(argc, argv, "abcd:hi:mn")) != -1) {
+	while ((c = getopt(argc, argv, "abcd:hi:mnv:")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -213,6 +214,9 @@ int main(int argc, char **argv)
 		case 'n':
 			use_nmi = true;
 			break;
+		case 'v':
+			nr_vcpus = atoi_positive("Number of vCPUS", optarg);
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
-- 
2.54.0.1032.g2f8565e1d1-goog

