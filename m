Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97A13A2544
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813410; cv=none; b=GuWBhUvJLUV1+MyVUDVa/QSzTSTeVPcRBlWAUOTsa/fLyNLg1FUnNarmIhHQaiT2uw8ef4udPBz2CQwVotbOImm5Gsc3K4ijohjmmrlVxoYtxNFUoVDJdVA1ZR38F4VT2dLZjaQUtKu09Xq29GohBSmaenmvYmWkQ5yud+tCPvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813410; c=relaxed/simple;
	bh=z4KA4UWM92jjfxtHQPN575snD6HXnmh/mKbX6lBYV2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oNoN7j3LY7TaYEoGkujQmmKObHIBonp/ybaJfu7DIg5bO4C7vyZDMyQTYoakF+3CECbJGUdJ7lGplj6I2dKhZuW4/qE1ywEPsAvUi5m22s7u25PTz8MhbOZJTi0Ou4QosTFVbbvFXX4X2F2rwWCmo2Wxx7Z97e+tKU+NOx0dl1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qBJpFOAT; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qBJpFOAT"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c798e905c29so1335788a12.3
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776813408; x=1777418208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Rl3LVSl1i629teB1CXV9HY8yLMHHbg5TN8orqOqz/c=;
        b=qBJpFOATL8hHmLt6GiC3Zn7LRQrExtnFceIOkbGKYJJvrjNQ7YT0tvUkLHQUCLCGcz
         trBw6q6vLOvuMvPGakLjtjGfYCykuygn5WwuDkkl1EjF9dShRmGI6d4U4MhrAuwAwcZO
         DqX2QMveEz+oWLtFc3a3jAnfSmca2Mp5ElRlTKpYzar0EpVcOPnu5MGNOdq4g/MmJMMk
         CWMZ8aeYWeNI5meeud6+D67j4JmID5Eyf4+k0LvlnfHYjXJA2rt79BlHIZuMuUdw+lIm
         xDUqLz3rI1UFz2XBg6Riei36aXr3HGfw3DcgouVAiOi3Lqyytwl5N4aSLraPDJTii/Kl
         9G8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813408; x=1777418208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Rl3LVSl1i629teB1CXV9HY8yLMHHbg5TN8orqOqz/c=;
        b=KPA8KKap/2YqjQoa4P1KmzCHHeWHajLLpg/AMtDKhFm8XzQ94g4mPog2068eWSeQdC
         KJQ7THFvROOQ5tPIhMZHNAMXF7lKA3eoorRJQcF2HNCAbMv7wBjFR8jSb5uLzQnpzW1k
         ynOtfepjQCUyMYSkD1A4FS3gcCPzR60GxPj1r7R1lAAa/lXO+v+kmpTbmI40Y4xCR1hU
         73wEzy6QfGEDYnNPybN9bl/WyFqZQIfaFoUDxAMa6z76+/FzwHj5RfhOHdNkJT2CAiZJ
         nWkBCPk/VD9QiWP3j/4EnJonX7udE34dD5pxA5xGLYOyfWB08HV0viW+n1ooZlNSenhc
         +VFw==
X-Gm-Message-State: AOJu0Yym4jadBFaSb87TesAVy9SQJF9f+hmsfc/OOtSNtLfA9Zg1a+N2
	w2BGu3EQpip1fITyT+mrXkP2Ldt3/MESM9d0PzD0g3pJgZtpQXavELiM4AbziW50S34x9FsizHa
	Dx6+0d4se
X-Received: from pffx16.prod.google.com ([2002:aa7:93b0:0:b0:82f:af01:3a8e])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:158a:b0:39b:abdc:4215
 with SMTP id adf61e73a8af0-3a08d68e0e4mr22152147637.10.1776813408030; Tue, 21
 Apr 2026 16:16:48 -0700 (PDT)
Date: Tue, 21 Apr 2026 23:15:52 +0000
In-Reply-To: <20260421231557.1254270-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421231557.1254270-12-jrhilke@google.com>
Subject: [PATCH v3 11/16] KVM: selftests: Configure number of IRQs
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
index 3671f5ce4cc8..9efb7e655623 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -120,13 +120,14 @@ static void kvm_clear_gsi_routes(struct kvm_vm *vm)
 
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
@@ -159,7 +160,7 @@ int main(int argc, char **argv)
 	struct iommu *iommu;
 	struct kvm_vm *vm;
 
-	while ((c = getopt(argc, argv, "abcd:h")) != -1) {
+	while ((c = getopt(argc, argv, "abcd:hi:")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -173,6 +174,9 @@ int main(int argc, char **argv)
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
2.54.0.rc2.533.g4f5dca5207-goog

