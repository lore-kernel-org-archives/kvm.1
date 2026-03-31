Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707FB3A3E9F
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986109; cv=none; b=PQ9+XgmFw0+Ge5lEg5zC1p+r9ZcvNKzoM9E/DgZYD0Glst5xZ4kGp6YypkNHFJMmqNr3wPIRMjaW9SQkdZoFLJU5ppcYiKt0ubldTEjKX5O2N1hRNqpnmDszM+Npt+oviX33ZK66IeZ+ttcIDWTBsN0mulKi666j1KAWM4Piyyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986109; c=relaxed/simple;
	bh=WAoNQpKZ+qoZvBdMBMQC6ydat6g+QHelvGFhMbYBdyg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C6fyI0TFPC7mTLQxB+RVcPOgWGMPbDNM5/Lwr9aEQmMAPkxfrYI6Cv2OUFsw+CdIzrO0PqynowRhaBnY5GX4hfEloBD5wdgyOlrNr4jRdnZSukGmy8AhTogtpYknJ5Fca7D/KdHS8yBWytEdYInzTEOb3gz1vVR7mzOBZUPOD5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dUGcBJii; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dUGcBJii"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c6dd66f6dso10105859b3a.1
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986108; x=1775590908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4339GOoSx589M8mPG8nNtfcJAH8OWZ8rjyiPF0BByHw=;
        b=dUGcBJiiogZ7p0qIgbZE6mnX/ZLaWUqACg59JGvHrrIyeIYo6SsJllPH7EGOSte3I6
         WzhvKGdjlngzwwVu1A6A7XqS71GCo/BsuR8mTSF+WNGGvgKrtQaOO9ad8B4k7fDDB10z
         zr2TlBIy8amleNiUgJxItpLBGngCvdOJo8JZ/JZXdIBz2WdlKIT4YPDjPM9WKa3ZQzGh
         4zMEeXvt+9CrC9woHLeShzgAPPXqAjAzWVAnguT3co+GzXIybX6eBJ3x+vR360oGOIYL
         7T+X3hyU8eapIN/mfMCEH+dru52D9mu+fITOwuNQsCSibc1S0mCr9IF4mHfmCNos3+uG
         ix4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986108; x=1775590908;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4339GOoSx589M8mPG8nNtfcJAH8OWZ8rjyiPF0BByHw=;
        b=hFsRIcLBxnO4H6oHC1tmscCnNmPOFx9OULv21cQNi4eJoqADvGoht3P/wIC7FWrBDd
         rzIGFwv/+iYy7jhyDx1RJw6pp1dvFBi6MNzkiRN70+Puri/pFyPA5CyGw5R3X1YtvSdt
         Z0v+R6QY4BCG57IvMp6MkDIhSZhAS2JL/ZdaPnvvqoHVUoYDEsBiI36eIK/V91UoTWOk
         zcR/pGSb42Y97Tqgb0yZsCD1NgcY1f+TLB0PeISirWdCNIUlvHwqlaVnLUCYb+w2tsoR
         pcOe5EG84PBdKKsJdoUFoUqZKGCYAdSG1+OIyr9O3eS5qPEpqviK7QidCDHID5xoSqqq
         cB+A==
X-Gm-Message-State: AOJu0Ywh076eda8vJnmVboqlwG66SxnjQwyIC8qtLi1XaE91l4JmiqAf
	oKUbTZGkxOrb1YEiPKj+/Rw8pttnmg2npEZ99zRKdHvefrc7paix/5wbF6bzT159McFEG0ZrRS2
	pxg6XJxpI
X-Received: from pfbay26.prod.google.com ([2002:a05:6a00:301a:b0:829:a3ad:9925])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a228:b0:82a:17b6:53ca
 with SMTP id d2e1a72fcca58-82ce8ad21c2mr843746b3a.38.1774986107824; Tue, 31
 Mar 2026 12:41:47 -0700 (PDT)
Date: Tue, 31 Mar 2026 19:40:31 +0000
In-Reply-To: <20260331194033.3890309-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194033.3890309-13-jrhilke@google.com>
Subject: [PATCH v2 12/14] KVM: selftests: Support testing with multiple vCPUs
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add the '-v' flag to vfio_pci_irq_test to support testing with multiple
vCPUs. The test will round-robin the device's interrupt across all
active vCPUs, ensuring that multi-processor interrupt routing and load
balancing are working correctly within the guest.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
---
 tools/testing/selftests/kvm/vfio_pci_irq_test.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/vfio_pci_irq_test.c b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
index c2f48c6710dd..8c6c7c424b92 100644
--- a/tools/testing/selftests/kvm/vfio_pci_irq_test.c
+++ b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
@@ -186,7 +186,7 @@ static void send_msi(struct vfio_pci_device *device, bool use_device_msi, int ms
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-b] [-d] [-e] [-h] [-i nr_irqs] [-n] [-p] segment:bus:device.function\n",
+	printf("Usage: %s [-a] [-b] [-d] [-e] [-h] [-i nr_irqs] [-n] [-p] [-v nr_vcpus] segment:bus:device.function\n",
 	       name);
 	printf("\n");
 	printf("  -a: Randomly affinitize the device IRQ to different CPUs\n"
@@ -200,6 +200,8 @@ static void help(const char *name)
 	printf("  -n: Route some of the device interrupts to be delivered as\n"
 	       "      an NMI into the guest.\n");
 	printf("  -p: Pin vCPU threads to random pCPUs throughout the test.\n");
+	printf("  -v: Set the number of vCPUs that the test should create.\n"
+	       "      Interrupts will be round-robined among vCPUs.\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -242,7 +244,7 @@ int main(int argc, char **argv)
 
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
 
-	while ((c = getopt(argc, argv, "abdehi:np")) != -1) {
+	while ((c = getopt(argc, argv, "abdehi:npv:")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -265,6 +267,9 @@ int main(int argc, char **argv)
 		case 'p':
 			pin_vcpus = true;
 			break;
+		case 'v':
+			nr_vcpus = atoi_positive("nr_vcpus", optarg);
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
-- 
2.53.0.1118.gaef5881109-goog

