Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31893C872F
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986113; cv=none; b=NDQZcZtqcCquvCbs/BFqULP3HkfYqG74fsEky0aBm6VnN+aMrSo8p46+I9omz9rXVKeXA/fPVVGWK6lbYUQxn6fjqCttgBAC3sLEgGkdGuVXsSIm6/1nw4ShPVP5ykMa0R1i9R7UYEC0+TFW/5O6R7ZacdisPsYkG/pYaNWbbVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986113; c=relaxed/simple;
	bh=ygUBfuucnX37gMgIs9R3vZLogUSp7PQvndDS/D25urM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XlBiU557DDo80rN0uWok+RyttgIfqNSyfxAbKL6jmf/pUgNddHCcOoNnw9JFzryikTtH6Cu4ELl+AN1QPyriU92QPiqj5if7e96CVdQuJWJZWvzD6cGllPuIOxD6523bMFm/x8klaKsmuj9mZunDuwiFR/FSpCN0o/xC523TbbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HDPXP/kJ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HDPXP/kJ"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76ad3b732eso2604926a12.1
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986111; x=1775590911; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nYmjsQzRuJVE1bgLHN7Edl/ckRjbUuuJAPqEITm3ILY=;
        b=HDPXP/kJ0rB2309OHKhSUAk2BF3j1yJeZtOKETjFDyExfSYPa/24UyPt4HfzX2fOC6
         /WVO2CxsYioxY3KgvEh6E+H9jPjywpCnll2praBviJKS46mwYr7TBo2kpolsOCt+QqrT
         GJhFc/OOIL7lM3yRpi+grU1CezbG5aUgciNsb8IBj7R+ZaXcjou/fq+eqrMUmUdpVzmo
         heFVQUv878TlX4rpwLOd9AflXbAG5W8nGpHQapgpjfz0kDcJC+a9d5ybBwe+w6DsSi4Z
         DLdCo7b08FI7+yrrkXrmteSmef8gcDf+LEVksxbEdCCYnqfSO9dTRLOkcMOG3kdG/8Hl
         KtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986111; x=1775590911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYmjsQzRuJVE1bgLHN7Edl/ckRjbUuuJAPqEITm3ILY=;
        b=qZJfLNWR8eMxjKM4W6eGQyHe7Tt/AjyEYIJVjcks7YKNraUv4xTmXcTcdjQVRf2WC4
         wD+lNQJnrDxqTVqG/CR6u0RxACcu41Ny6d2WHoDmfi429kpcoacgaZk8Yq7jE/W3zBCN
         m0RNccpDSISV6OJr4fEPxqUarVJvApFpDtkvgD3zXjlh4XHzprXTgAMvDCPyez/BXbF5
         d/mUKbrI4DI2dP+n/EtRlrWmUDPNuRgeclvXG8TsiDKF1M6h0gtU83SrxP516Pu0k3fO
         oixhE0sTiesgFCMh24w5uK7+blY/qscJw77M/VWKYmr+RuB5MJcoOUDBK6AR9C9+cY6Z
         3JaQ==
X-Gm-Message-State: AOJu0YwIgiaUT6SVFOcsTqtpKam4gn1FVmiAVIecctzJWlSYnuAgz5I+
	Z6qV3GCooBaXmTftubm6gC4KbZN9dacyYiM9SRfqiXQrqaoXjgMYzreu011HEU/b0V3BWL9c74y
	CJolwTbZ5
X-Received: from pfbfk3.prod.google.com ([2002:a05:6a00:3a83:b0:82c:213e:7964])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7287:b0:398:98f2:744d
 with SMTP id adf61e73a8af0-39ef7761d80mr446946637.45.1774986110915; Tue, 31
 Mar 2026 12:41:50 -0700 (PDT)
Date: Tue, 31 Mar 2026 19:40:33 +0000
In-Reply-To: <20260331194033.3890309-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194033.3890309-15-jrhilke@google.com>
Subject: [PATCH v2 14/14] KVM: selftests: Make vfio_pci_irq_test timeout configurable
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a '-t' flag to vfio_pci_irq_test to allow configuring the
interrupt timeout. This provides flexibility for running the test in
different environments where interrupt delivery times may vary.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 tools/testing/selftests/kvm/vfio_pci_irq_test.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/vfio_pci_irq_test.c b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
index 2dcac6fbc009..807e9aecc887 100644
--- a/tools/testing/selftests/kvm/vfio_pci_irq_test.c
+++ b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
@@ -25,7 +25,7 @@ static bool guest_received_nmi[KVM_MAX_VCPUS];
 
 static pid_t vcpu_tids[KVM_MAX_VCPUS];
 
-#define TIMEOUT_NS (2ULL * 1000 * 1000 * 1000)
+static u64 timeout_ns = 2ULL * 1000 * 1000 * 1000;
 
 static u32 guest_get_vcpu_id(void)
 {
@@ -196,7 +196,7 @@ static void send_msi(struct vfio_pci_device *device, bool use_device_msi, int ms
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-b] [-d] [-e] [-h] [-i nr_irqs] [-n] [-p] [-v nr_vcpus] [-x] segment:bus:device.function\n",
+	printf("Usage: %s [-a] [-b] [-d] [-e] [-h] [-i nr_irqs] [-n] [-p] [-t timeout] [-v nr_vcpus] [-x] segment:bus:device.function\n",
 	       name);
 	printf("\n");
 	printf("  -a: Randomly affinitize the device IRQ to different CPUs\n"
@@ -210,6 +210,7 @@ static void help(const char *name)
 	printf("  -n: Route some of the device interrupts to be delivered as\n"
 	       "      an NMI into the guest.\n");
 	printf("  -p: Pin vCPU threads to random pCPUs throughout the test.\n");
+	printf("  -t: The timeout in seconds to wait for an interrupt.\n");
 	printf("  -v: Set the number of vCPUs that the test should create.\n"
 	       "      Interrupts will be round-robined among vCPUs.\n");
 	printf("  -x: Use xAPIC mode instead of x2APIC mode in the guest.\n");
@@ -255,7 +256,7 @@ int main(int argc, char **argv)
 
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
 
-	while ((c = getopt(argc, argv, "abdehi:npv:x")) != -1) {
+	while ((c = getopt(argc, argv, "abdehi:npv:xt:")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -278,6 +279,9 @@ int main(int argc, char **argv)
 		case 'p':
 			pin_vcpus = true;
 			break;
+		case 't':
+			timeout_ns = (u64)atoi_positive("Timeout (seconds)", optarg) * 1000ULL * 1000 * 1000;
+			break;
 		case 'v':
 			nr_vcpus = atoi_positive("nr_vcpus", optarg);
 			break;
@@ -387,7 +391,7 @@ int main(int argc, char **argv)
 			if (!do_nmi && READ_FROM_GUEST(vm, guest_received_irq[vcpu->id]))
 				break;
 
-			if (timespec_to_ns(timespec_elapsed(start)) > TIMEOUT_NS) {
+			if (timespec_to_ns(timespec_elapsed(start)) > timeout_ns) {
 				printf("Timeout waiting for interrupt!\n");
 				printf("  vCPU: %d\n", vcpu->id);
 				printf("  do_nmi: %d\n", do_nmi);
-- 
2.53.0.1118.gaef5881109-goog

