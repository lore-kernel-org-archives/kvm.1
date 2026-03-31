Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3593A0E84
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986104; cv=none; b=kpnKlgqFtFo5PeKYjHjJRSkoXvIzFFUYpprrYG8VHINeX89c8LdDdmFiTZVFdLehngnWXJEvlHjNq324WhfH13QwS3te0pyz0xn13l+9XMbik7r77qrSwwPrjMI9ZTyLa86zRa/LZ2uy/8fhezGGYPKMnjoQmbJgei0258ntQ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986104; c=relaxed/simple;
	bh=a5b3w2OPP7hzOao97W3YPY2DXnSSOGOh5/gvBFd6kpY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T/CnpdLlbn9anHCSMeDYFgl5pJP6W3G+D3sSUVA2cMeSOcqJpFd/ODYzeGFZ0YgD8RV7HtnZ+8fnowlVJkVRLoeTCoE/JJu+yAiu4tMCni/Q9MPDcr4DCB/ZxufZ++VmArXwDSQ58FShd32WrICrqhe5lWess/XQKFVaELQnYts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EvaiUgwP; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvaiUgwP"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82a6906e35fso182805b3a.0
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986103; x=1775590903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2xZK4BRCDL3oxkM/y+BM9E4+GNsjpa4C9NzT2J0wH0=;
        b=EvaiUgwPkD0fIhnaOvz7xk4iDGZO9eMU6kvJ1M4oxeVO9kAuML/wZGnNfQD3UOFK5M
         JUW6r4JpQf2mF25PyvtNnknneDeI6Jr96cBhYywAlDiFOUhnXTiZBH5R0edUQ8au9So1
         aqgLgsh4soN8HrOj6S43IsYyb67Ryxs9Xv6nxyj7csfVdl2MlWEqqr59wGEpf7nNv65L
         jenbpfSOLUl4P9GhRIoWma8frU/2PrnVXRlb+J+h3ClS7nbGwUZEgxfbBk1USq5wrzBT
         HOI2CvDR1PCr1nVfwZJAaazb7aXAEs7HBEJc/U09ZNmPwGLmDA8nE7wMOyWEoHuKwqLu
         wpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986103; x=1775590903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u2xZK4BRCDL3oxkM/y+BM9E4+GNsjpa4C9NzT2J0wH0=;
        b=bCdn+i2/LTV+GJW23DL07LHUwCFG91EZa880JWjjEi6MIjkSM5B88svJKbD0fSuzDc
         DrL5oO5tQghuVC8uuzLw7kqX/MRhRaZoJPFYjl+3So9nXhVayl9vkAJbgyWZVZkVqWF2
         9SKwrJthqpyqrOEEhSclxy+Mr4uUo9uTVXXL0fIGjwXyMSdUPNHvrunsfsowJNzaflJc
         v8v6qQolcW1amlqThQeLVlIM/P0st9J4GZIZgxYt/1oIdqj9JHulSUbBchywIsQD8+xa
         2ad/snHBNTronR45NC4losC2st2/vozgWNSusHRJ81j1iPQvIUgcM0KyELYIQF0WAJGJ
         75/Q==
X-Gm-Message-State: AOJu0YzPw3ynMBSr/v5TG9aYGntiCkT1IQ7gNcH0+HV6HWokkf0Fldd/
	lpbOMeWZepofyhWqtY8+ouw/UsTQ/mLqsU9yMQVwa3xrYvsZgNG7hbjurrbb351HQ6VLSlYoLFo
	qGv8NhALZ
X-Received: from pfbly3.prod.google.com ([2002:a05:6a00:7583:b0:824:9ab3:ebe8])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4188:b0:82a:7918:7f4b
 with SMTP id d2e1a72fcca58-82cd66c574dmr3869502b3a.34.1774986102738; Tue, 31
 Mar 2026 12:41:42 -0700 (PDT)
Date: Tue, 31 Mar 2026 19:40:28 +0000
In-Reply-To: <20260331194033.3890309-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194033.3890309-10-jrhilke@google.com>
Subject: [PATCH v2 09/14] KVM: selftests: Make test IRQ count configurable
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add the '-i' flag to vfio_pci_irq_test to allow users to specify the
number of IRQs generated during a test run. This provides flexibility
for quick smoke tests or extended stress testing to uncover rare races
in posted-interrupt logic.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
---
 tools/testing/selftests/kvm/vfio_pci_irq_test.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/vfio_pci_irq_test.c b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
index db2dedf4437d..f02d455969bb 100644
--- a/tools/testing/selftests/kvm/vfio_pci_irq_test.c
+++ b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
@@ -125,7 +125,7 @@ static void send_msi(struct vfio_pci_device *device, bool use_device_msi, int ms
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-b] [-d] [-e] [-h] segment:bus:device.function\n",
+	printf("Usage: %s [-a] [-b] [-d] [-e] [-h] [-i nr_irqs] segment:bus:device.function\n",
 	       name);
 	printf("\n");
 	printf("  -a: Randomly affinitize the device IRQ to different CPUs\n"
@@ -135,6 +135,7 @@ static void help(const char *name)
 	       "      it with an eventfd write.\n");
 	printf("  -e: Destroy and recreate KVM's GSI routing table in between\n"
 	       "      some interrupts.\n");
+	printf("  -i: The number of IRQs to generate during the test.\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -176,7 +177,7 @@ int main(int argc, char **argv)
 
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
 
-	while ((c = getopt(argc, argv, "abdeh")) != -1) {
+	while ((c = getopt(argc, argv, "abdehi:")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -190,6 +191,9 @@ int main(int argc, char **argv)
 		case 'e':
 			empty = true;
 			break;
+		case 'i':
+			nr_irqs = atoi_positive("Number of IRQs", optarg);
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
-- 
2.53.0.1118.gaef5881109-goog

