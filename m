Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AE2284693
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100604; cv=none; b=WtZwrkIfSI2vAjj0MUzNb8qJHp7YvQ7Szb+HUZgncCIRJmTYyMPjYZ4V1ohQC4ySJ9rWThybMQUo12x2MCtv/0EcSr9JLCAFKc+9IKui/Iu89n7OymCR6xoNadEb43dxDMpA/uEWzAVO7PnCua2LLvxYzlSDdgAMVnAK4mx5xKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100604; c=relaxed/simple;
	bh=CzntHVhYNcZFHIR2nYlkFWCsxwV0/8XdJ0KvkXkba3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uQjl5/u3pCK5DGwfiUIYc4RqIv9EoP5bBWM6vaAd12obHxNSxLd7liuxS+hnH0j0kG1krNNvG/xDjxvCetpktHyJoNa+m3nzr7meshdY44xmkE4tgmsl9ODPxB5emy2uB6RcLP+gU7axLoUttE2OwnE7yjTfHFc9L6LeVYjY62s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RnntGQkL; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RnntGQkL"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd6aeb3637so320423175ad.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780100602; x=1780705402; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lUIxYrcL+WMnprn9yvfqEMt/1FqlOjkjwhMsyvVweJc=;
        b=RnntGQkLq5eXQpz8IFXzAb6GbgkhenJ4j4cW4/oCnDPbucOXIhOFr+Dj3dQFEScq0M
         mIYIcqrplQfs6n1i7zRiCPy35UecEnjTTN2VgIxPBBpCK5DaOQSZxdMWu/LQoAvaNXaw
         pWV4kbnTtFnW54HZbJxRLhx0Gv8xOxycFXgrQyfI/Hp3+U3ZknU9it71OaWZFB3g/MCr
         6gNu/xbCnowkKvx3w9Yn4sdmm5/GgDODcITavoS6kK58y33SaiUu8UD8atMUfeyeVmJ3
         K6/BluOU6aSQfWpVBaJrDQw2acbS8kkJe00K2t04bJjg0g19EqqRDQUApdp2MbfYt+Te
         Wt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100602; x=1780705402;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUIxYrcL+WMnprn9yvfqEMt/1FqlOjkjwhMsyvVweJc=;
        b=Pb9tZgFr1RbrXDXkJfY7jtmREz7bHTlSXVyNh2fxwdNtxxJQGTzhxgiRWZnO2OXn/g
         EsLsXGB8rDmvyKpeZ1D/qdPPL+O2kyEgRFtcB2Tfi/WcOmYJTz2jDnNlUmf9VWhC0+vM
         PNGZywYZapTUyTuSpyH+0SLaIDoiHB3zk24LFf88DFt12qadeuFbANtm64dq2S42/7J0
         Z10cot1s1QbIW08TBQfZX5u4IeRQdS/YqO78lCDsa416kmp+LiZ8t12L/ZS9c02jzFbR
         CGMkW5wj2t/mQAx009JMT5cZB1y1c0MCr7fAxCRbin+Md4YHu+ZaQK7K5I5lQIp/jg4n
         cYUQ==
X-Gm-Message-State: AOJu0Yw8+Zc2TeLy/VVuLDjoA+VyRYgWFdKWwIxwTvNlgoVJNN5rh2lH
	wmnQ79YVQ+dn0dsfbLVHAzdyx4lq1cdML+SpfoXMACB2wr727IaLg8kFfeYQE4ji58jEUWnxyfI
	ObD1T1uJx
X-Received: from plbks11.prod.google.com ([2002:a17:903:84b:b0:2bf:bf7:6205])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e543:b0:2bd:8395:fed8
 with SMTP id d9443c01a7336-2bf36851283mr22803535ad.27.1780100601981; Fri, 29
 May 2026 17:23:21 -0700 (PDT)
Date: Sat, 30 May 2026 00:21:26 +0000
In-Reply-To: <20260530002134.558837-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260530002134.558837-12-jrhilke@google.com>
Subject: [PATCH v4 11/19] KVM: selftests: Make number of IRQs configurable in
 IRQ test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
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
index 72b9106216ed..e79b66c050ff 100644
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
@@ -162,7 +163,7 @@ int main(int argc, char **argv)
 	struct iommu *iommu;
 	struct kvm_vm *vm;
 
-	while ((c = getopt(argc, argv, "abcd:h")) != -1) {
+	while ((c = getopt(argc, argv, "abcd:hi:")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -176,6 +177,9 @@ int main(int argc, char **argv)
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
2.54.0.929.g9b7fa37559-goog

