Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4FD2ED860
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100619; cv=none; b=my7WN2pLtjHV3S2C0NXYB0XvS6Go1mEUjGOjh08OwczGUbXvadBjwWfi+SHQIYIYW6waZLdp9YI2oRfO8eBf9uy6MSVCAwZZObPmiR/8lBicbDGHYquMmOlZ13aEFrgQO3tFr0geLR+rLIkjwr42yd9IyHkMIq4aSwZk+a8BB+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100619; c=relaxed/simple;
	bh=YHk8ukGNiO4CYahbZWbONFlefLkTB31ABcvUQFu0I2E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QB6zKiGltNZsDwtTVxYlyxdpcmF3WYC22ianehV5zQcfautxjsWwk7uWfMGkKUF/RGAByh2blOP6GFfP4Zi5mMlIRVLX6XZHumEmXBfEMMrrp+uMqAzDCbN+y04avj6fee+J2ir5NSu2GZ+x11Wo+TrCFZB9hB1NyI4XzcFz0GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GiFhZEUo; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GiFhZEUo"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0a99db8dfso42085ad.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780100617; x=1780705417; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zpKIBxF4TwirmU794bEiVHTfk4L9neuBdaiGjtHF4Ic=;
        b=GiFhZEUo7vw88iNCUHwR9he7YBkbXqngNtNk8vFV1jro+3qWHMxwk9lqS2ZjTYypXG
         2/TW5KzT5/bgZKaNmvlw5ysltEzBFT2YsxyordWA5cWHWdH4HV4blf5Qnjr7p/EusGpo
         JKMP2BcqCK1ji+LjlZYvdJzKP8ar/N6nmy7fCayYbTxI7y9dCDLeNz6/UtAF6bC/Z+c3
         wr6Q8jfEs551qcV+/Ui3LtNUURj7eKe3UFV8+HfkTOWTgHkAIkrAOM4WGaUowhVEV+3e
         rWaP3rh3NKfN3u3EhsG3++tXHoGVtrP9V6t6wQmSdUbrUnC5A3EDOKuDwPB0pDbu1p8t
         JWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100617; x=1780705417;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpKIBxF4TwirmU794bEiVHTfk4L9neuBdaiGjtHF4Ic=;
        b=n8v7mbiTQN5nr2KLDnA1xA/UHI/bJIB5gFtcmd3XxW1NEMtmSLvAgL8SqiAAu4Wbiw
         /AV2eleC0qkhwn6yE2+6TsRUtMkKbZges4As5f0U0AMaSTItkz7P2IMLQXf7KmTqJRL/
         HNTsB6AYdTsL/zds/iWeUangH1VNDWMmWV/JfEXD4QghNwsCJsduvs5OiL8WXc3ew8sW
         m0mPlPstFlZhoUPiz8Fz9Ax2vpCIqQF6AeLa3MHLYq2hb3BMvZkNPN2fbQLlcH+6dO97
         9B80+bELgwMfo9fMPH1riYWUYnPuIDDDwVMUmJNShSa4bBdVs1ubhXTMyS8J92sWzHbn
         AigQ==
X-Gm-Message-State: AOJu0YxhI79ItVamf9dfSIz6U4/N6hMuLrkHMvShSHVfKNO4Ea6FJ4sf
	q81fHYkNfxtVqSUnYyqHEnQHs2ZozF+1IrONQuMTZG+3fvda/8TpN3d7Oej9EEolUGREE+axrYE
	HB7Qz32mX
X-Received: from ploe7.prod.google.com ([2002:a17:903:2407:b0:2bf:a0d:a7e8])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da8d:b0:2bc:ac76:c1cf
 with SMTP id d9443c01a7336-2bf3683bd81mr22990915ad.24.1780100617198; Fri, 29
 May 2026 17:23:37 -0700 (PDT)
Date: Sat, 30 May 2026 00:21:33 +0000
In-Reply-To: <20260530002134.558837-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260530002134.558837-19-jrhilke@google.com>
Subject: [PATCH v4 18/19] KVM: selftests: Make number of vCPUs configurable in
 IRQ test
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
index 0db4ea4eb1ef..967083b8e2ff 100644
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
@@ -187,7 +188,7 @@ int main(int argc, char **argv)
 	struct kvm_vm *vm;
 	cpu_set_t available_cpus;
 
-	while ((c = getopt(argc, argv, "abcd:hi:mn")) != -1) {
+	while ((c = getopt(argc, argv, "abcd:hi:mnv:")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -210,6 +211,9 @@ int main(int argc, char **argv)
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
2.54.0.929.g9b7fa37559-goog

