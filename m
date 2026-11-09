Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258523;
	b=eiPxZ2fTgM2+mdb3lITHVI0Z2uc6PUgshEsOOQdQ4OnYiRiZ6L+DOzrYRtMkqrKftT0Y
	 xKN0SzRwHJJP/rPcwIgDCPipNqYKGHVbr2UaFFz5Nxjbnb4q8pPiyhxqgVw+5LF49TAoL
	 QZHOfehwpfjkbqa8TvwQngFvHWVbHxIEyggZpebovf6N5FcQngQdpE4ppbefaJwLC8gdp
	 kA+i3tfKVgwjmepOCmj0Vx9sR65WK9EbILvqWXc7Bne5rydWd/+Wo9G6fcSWn19emykLk
	 3zZ2M/Vizj4rfL7M95sVUATRGe2a03HF8fa1iCAF8uqTdLsa66IfnoAZwGqhGGl02Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=UIqXWdO+I2nnx9qx72uMZxanfiXwOH1WEBujyHHbfZs=;
	b=nt+XVl+yt6v2hlsvuQQKqZxRrJwH7KlvnFmipopWbjLAKzannj4GwIzp1FdS4CQRWJ/w
	 gdiLMPibvs2MoDkagkYs7Q7qw/vNT86Dz9gWGqbxgvfmLy0zi0tG8Jk5/asGI7nHApRui
	 jdVdDS5TSFkiMlsdTigrSCrugVfBSOH5Ck58Y8Q7+gm2eJcRe2XeJh1OpXg28kDfqQy29
	 mP55okpr7DPm/Ov7h8aHHRgG/CYFsJLQwgX/p4ShOW4NoXN1wlBYXMNrIvaYWmijunqBH
	 OnR18zBTaR6g7tUg5/NkUjN5JF/S2P8LYTCgLUL2/6pmGKydMCJupsBtM9SwmsP6Vgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hkbXBOIG;
	arc=none smtp.remote-ip=209.85.210.72
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F3760A3816
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 21:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5F3760A3816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hkbXBOIG
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-85d502ea62cso1901831a34.3
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 13:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794258522; x=1794863322; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UIqXWdO+I2nnx9qx72uMZxanfiXwOH1WEBujyHHbfZs=;
        b=hkbXBOIG4M1qnb0/2GNe/CufOTHGHbE6yT03pYYW7GDAVIb3u4iYXGgqMK0Clko8f/
         FuawcgxxbK7D4PBzOPBpLjdOkw62PWeU1VxdlliwNmzYUSdd4/5Epmh5JHi9MNUM0aZ5
         CLPWGEd6JtVlnyVb05tmqEVL5JjP8VcGSdDaXfF8qQ94odWoyOASr8c160rvPD5cuwzs
         DArnYzrXYf0nNiuaMdFCxLRH4yBv/KbCV2md97Hg21cOKoiLmNe3BdQLNp9rgdDDxdEM
         Rff7AELXsVMjsaOCQhWl0ODj8sluPsKznJD5DbZiH7xPeKSYRwnZrxwKvYbSBxAhz/LE
         gWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794258522; x=1794863322;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UIqXWdO+I2nnx9qx72uMZxanfiXwOH1WEBujyHHbfZs=;
        b=z6o8Qn6BOvVQGmTESUuMb8X5l1gDrkctfDvK0nIA9xJJikRhsGMO0m5OielLPcAwW4
         P33tqmTNQi4Rbwt4WHBan1v9s8moR4VxUFVtpV5JniNQTS/QgnMccjiXsMVEnaXDROYS
         /pG4mk6cYUzYGtPu0YkAGAWtYks83bruxd/Is9IOFuFXaly7xagkiZptYEswXxXFOAf7
         diY9GVsZBlKq9r3fbAgIj6/tWkYV9zwiC7ObhBcopPmQ/7ItJOALS52HgK2nwTbC1tS/
         v6qBqMV0VixFoBKexgr0oyvVWbdwAQHb7FV+xxAziTVFm0MPkSGKHWTgzUT9R2p+cpXF
         yk3A==
X-Gm-Message-State: APuU4Z/c+lxivwZy46olqdPWpB1W8jfrd4ldMSJZHkfH+a4IHzKIPpHT
	AzYkyc922+lO6mYJN8sePgnA067cgRX5fEHlAv8z2nI+6jyz2VO8xOBKr3rWpRKKNHRTZgUUvQm
	4ff7eQHiAtGUHvmNoLp+bdW24RFJqQg2rpeFvHY6medUACWcYnkV4wmEwPYboVk0E3a285/yQKb
	U4mwlqx58V/SIHpCYUrfzmR8OvYrxh8z5arf5WoLTfAU0=
X-Received: from iozz3.prod.google.com ([2002:a05:6602:43:b0:9c7:b2a6:b165])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:320d:b0:567:e971:200c with SMTP id 5614622812f47-5683cd15a02mr645575b6e.41.1794258521365;
 Mon, 09 Nov 2026 13:08:41 -0800 (PST)
Date: Mon,  9 Nov 2026 21:08:33 +0000
In-Reply-To: <20261109210833.1250548-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109210833.1250548-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261109210833.1250548-6-dmatlack@google.com>
Subject: [PATCH v3 5/5] KVM: selftests: List the IOMMU modes in irq_test's
 help output
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

List the names of all known IOMMU modes, and of the IOMMU modes that are
available on the current system, in the help output for irq_test's -t
option.

The help output currently lists only vfio_type1_iommu and iommufd, even
though the VFIO selftests library supports five IOMMU modes, and the
list would go stale whenever a mode is added. List the available modes
separately so that users can see which modes work on the current system.

Opportunistically refer to the -t option's argument as iommu_mode rather
than iommu_type in the usage line, to match the help text.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 0d6ca1a052c4..9076271cc0dd 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -150,7 +150,7 @@ static void kvm_set_empty_gsi_routing(struct kvm_vm *vm)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-i nr_irqs] [-m] [-n] [-t iommu_type] [-v nr_vcpus] [-x]\n", name);
+	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-i nr_irqs] [-m] [-n] [-t iommu_mode] [-v nr_vcpus] [-x]\n", name);
 	printf("\n");
 	printf("Tests KVM interrupt routing and delivery via irqfd.\n");
 	printf("-a	Affine the device's host IRQ to a random physical CPU\n");
@@ -159,7 +159,9 @@ static void help(const char *name)
 	printf("-i	The number of IRQs to generate during the test\n");
 	printf("-m	Pin target vCPU to random physical CPU before triggering interrupt\n");
 	printf("-n	Deliver 50 percent of IRQs as non-maskable interrupts\n");
-	printf("-t	Override the IOMMU type to use (vfio_type1_iommu or iommufd)\n");
+	printf("-t	Override the IOMMU mode to use\n");
+	printf("	Options: %s\n", iommu_mode_names_all());
+	printf("	Available: %s\n", iommu_mode_names_available());
 	printf("-v	Number of vCPUS to run\n");
 	printf("-x	Use xAPIC mode instead of x2APIC mode in the guest\n");
 	printf("\n");
-- 
2.56.0.506.g506a7eabc5-goog

