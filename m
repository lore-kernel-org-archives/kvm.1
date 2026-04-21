Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180723AE190
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813419; cv=none; b=qzfk7t/jODtdChUXgQSCI5y1GxxI/PP0fJDfJb9SunCPxUig5NtzwJdia/43K1FdiXNrqO0HfxxZbuIIzjCGhajR20EddK/tTq1m6kB2O3Say4bkCa5Dp+u8yvFeyb6lbzmqsbuv2L0WQqU4D8rz2J/Qgj4R4K9btISwoDAlaGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813419; c=relaxed/simple;
	bh=K4oblVxbLsa3ReDelDhoO6oidaGRvwz363e3TzmP1Sg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OocVw5m31pyextuVc9SOM+4QJDYJ/sG77lnDHeu9jJsF8c+BK5P5cn6/sGLceRmtUPbs6Z4vR7mJEt33hQVeVVF+AWT00mwwnrVD3ouLPSO07A5R4RII5FrpJ7yITqqZDGA9/yVnXduyw8qvEF4T2dYCcQXZambWUpxwvcseNEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EIkDv/06; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EIkDv/06"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b24a00d12cso48598195ad.1
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776813417; x=1777418217; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SQJuWQWeKvWQ1t9FOH2/ql11UsyDycLC+YlBZYKm6T4=;
        b=EIkDv/06T3w0FWGFfgXCxfH+p7YgmwVvGBZMLrT3GMHR+ORDO6QHTNqdQ3Gk87MdXT
         y8JC0WNwQHNpZF/kRbP8xDmkeYRifP6VC2tk4ByDZbWVGGHPhD7jRlTRR11B5rfRko/n
         4eB5EmnYaMfBvAPxhoLokEQgegqN64wNCIsW2rzmPQqdTFKZqCZEsscnP7cSv67NYEfw
         M0niRWVZHbbbJmaEBJHiPEDBrYnV2ZjAoMhg0xBS3hs3ZEsXqLbQ9gyoY48c/iNx+wVZ
         foMfKE97ZwP+9IRuHhdQaZhPaacCYsl8DtGTJUNOozlSc0wMOW4ccBNswbPPQilKN+Td
         MYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813417; x=1777418217;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQJuWQWeKvWQ1t9FOH2/ql11UsyDycLC+YlBZYKm6T4=;
        b=RKeOHWmlyKB9qbnjtlawmKValugQBKLvfaF2p4euVgOqznJuvn7saIvSznfW3Wjgav
         5kZiYBZNIWBUKY9r819uKqtMAK7T34sFY0YnsyXn0JWbGECg10MbaOpE+ReVHskEbleP
         uRhP+WjPu2V63oITgw6ZQ8jX5r2Vd8Z6RJ8BatmR2S160+dC452rCg5pAHFe0nG+diBX
         rg9cBnaIefrfake7uc8/vMyFoPS/HUtSVBz57Rdzoxh7qzsC8qSEkTjY+m2KPIYnMrWU
         VvwDbglRI9cnwLJEOJQkE4bw5OWjxmQSCQn3sPY6bPyguJ6T2MyRRFFwnGRAucAPmJVl
         9GOQ==
X-Gm-Message-State: AOJu0Yz+Vf3oVmgy5TBXOPqwhqTToyZnByCldCefzfT5F8JOQAs8pVpF
	iAL4aeMUDk1Y35kyA8O8HF+B2qCBQTrDx9ERi+atpIYRyNOQfEMRZd2M9RFXy+z+iczTM4bH0Db
	0CWTzD7hE
X-Received: from plbll16.prod.google.com ([2002:a17:903:910:b0:2b0:ba5a:1fe])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d30b:b0:2b0:673a:7c90
 with SMTP id d9443c01a7336-2b5f9f50051mr144478315ad.28.1776813417298; Tue, 21
 Apr 2026 16:16:57 -0700 (PDT)
Date: Tue, 21 Apr 2026 23:15:56 +0000
In-Reply-To: <20260421231557.1254270-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421231557.1254270-16-jrhilke@google.com>
Subject: [PATCH v3 15/16] KVM: selftests: Configure number of vCPUs
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
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
index 43338eb3ab41..6fd082d37f9a 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -139,7 +139,7 @@ static void kvm_clear_gsi_routes(struct kvm_vm *vm)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-b] [-c] [-d <segment:bus:device.function>] [-h] [-i nr_irqs] [-m] [-n]\n", name);
+	printf("Usage: %s [-a] [-b] [-c] [-d <segment:bus:device.function>] [-h] [-i nr_irqs] [-m] [-n] [-v nr_vcpus]\n", name);
 	printf("\n");
 	printf("Tests KVM IRQ injection via irqfd using an emulated eventfd.\n");
 	printf("-a	Randomly affinitize the device's host IRQ to different physical CPUs throughout the test\n");
@@ -149,6 +149,7 @@ static void help(const char *name)
 	printf("-i	The number of IRQs to generate during the test\n");
 	printf("-m	Pin vCPU threads to random physical CPUs throughout the test\n");
 	printf("-n	Deliver 50 percent of IRQs as non-maskable interrupts\n");
+	printf("-v	Number of vCPUS to run\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -182,7 +183,7 @@ int main(int argc, char **argv)
 	struct iommu *iommu;
 	struct kvm_vm *vm;
 
-	while ((c = getopt(argc, argv, "abcd:hi:mn")) != -1) {
+	while ((c = getopt(argc, argv, "abcd:hi:mnv:")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -205,6 +206,9 @@ int main(int argc, char **argv)
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
2.54.0.rc2.533.g4f5dca5207-goog

