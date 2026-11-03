Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793665333;
	b=kpwKYnQB+wEoyUaTd1dXFoLVkNjZ2168+V68e0RZyJVHr+Rj0/uUIPKIITv8kAP+/TLd
	 Pa9EY1S7/Pprq3dD96oeMOr2ki6nNyfSqYyEH9zExL2D4gqzuHVvEHMFMpWmgt8pU/Rc0
	 /oEX2b5CE2qVqGvCeUlTeC7gx6DR99MI8SpmhIfpDXYCDSMiqMMC1sBzmcuoUIF6fUOc8
	 pRz7MB8LRTaNHouwsy8N1EF4jz3ADB3tOAVMhrgLtIDCjr9f5o8++dBIjWHbTR6GdoOjY
	 lrYaq+z1ljmHyUMVGv8RKtpA2rI2YmIZww8f8hCscH5ca4B5WoN2gYTqk8ka2OQ6Dkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793665333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=54IhsnyP2g3Jiy+S3uqB1XalWVHCL//tyTGoAcklP/U=;
	b=n5IXx/w+G+jatazFlu2CAqN69TUwuN2oNmoacrZI/NwAzopNewMsSnwnOdJCJGyTwx6B
	 3aSjj/NZqgRKogA0sGd4LAozM5hpau3c4n/sKNcPypF9u3chWbItuZA9LYaXEH9oGcyjE
	 yLrYZHs7+CrFnXUJeFeteYdlKdMoCU4oMqust9Ej+B1I6XAQaiBe+4tRs0C4r4FINt49d
	 dFIjOHJditzbmNTQjd/x3imQ/s4xXRY8iyZE3ZJWDoUkaGghL4u0Al0hBqvGor8C20/eQ
	 423QTdB/oZTsOLgMowS/YimMOG+NyTv9wmxFHCGw4w1ZIXDAWT+WDJwOYV9e6hf4QIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l6zDArSo;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3672606D808
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 00:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3672606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l6zDArSo
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e93e2f72bfso59690755ad.3
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 16:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793665332; x=1794270132; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=54IhsnyP2g3Jiy+S3uqB1XalWVHCL//tyTGoAcklP/U=;
        b=l6zDArSo/3FNlYvlM7lmevOJSRFO+72jBOx4bQycjDIqzmlsrt2iyJ5ujUwnhn3nID
         m6ZaUF1TTQhCJDh5ZX31ZY3gbCpmwDT5IVFRSThjYgwHL9UwOFWL3aLb28IKhb1QprCn
         bZJSY3+BSUXJWA+CVWpXWFVTr+zBc/mfP0M311SUXnPleXq28HbF3smQVZrU/k3zUiBB
         fMJ2T/fY3attgyUrywOGXbfTc1YUucT3fxsxDYB6wGVwbCvjG+N629kJeQMc3XT3T+b9
         IRFTwKIUo78YHS50O+/ol64sYpMob1KxcewgJYbnw7umaXfjAEMXHl6yzY+PEfNSQJbY
         LihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793665332; x=1794270132;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=54IhsnyP2g3Jiy+S3uqB1XalWVHCL//tyTGoAcklP/U=;
        b=WgAd5BScbgVT1QNrY3wRXIU8G+jGTI4+MypHh9RaXLOjkY8dcaVkBNSxzvRhm39EFU
         4P/Au8Op9oPtt7q7brlLAAx1RL8qRMhSrx1Hlp6p7HW3nmhYHigEt+p8IxIML0FswKUG
         MP8I/GOgG993hlszOPQzzp626DnniXkUIr4R9bBXABsnl55nNqFDGTlbUyRReKR+ggku
         xr6zNsK1Bo9Aca3+VZFaUton9jNlkTkFAZ20mntFQfSNnfCS8kPeAP1KUThvCQYQT+Jd
         eBRMFfjUKLXjMAW4lCZJutDpjo24gXkgYc5M2EJrO9RjrkRgPUBogN+3pr8hxvC9PpKk
         NWeA==
X-Gm-Message-State: APuU4Z881tHuPiEkhVn7W+50tPfQ+qdqLqVRef3CppEsb6r+w+txjGzn
	ELoFaU9LrwLflEYGGw0MeZMoVG3mlv9XBbNrGuhapTBxF4tuIi5PSz7PJsDD52cMKWRH4uTvV7r
	VBQGrAcPxLyPqN/EkXlP6FC1JUdUjehxxcuR0Xy0YHBG9+yurd6kBc4/irEwAuZhPqWGCfxowQg
	H9Ih/8q8LoxodfoEjv5BYIVpBUOgwolKZo5bRG9AD0Uzg=
X-Received: from plgi6.prod.google.com ([2002:a17:902:cf06:b0:2e9:b079:3771])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3247:b0:2ea:1b9b:b946 with SMTP id d9443c01a7336-2eb3649bbf6mr114233985ad.14.1793665332121;
 Mon, 02 Nov 2026 16:22:12 -0800 (PST)
Date: Tue,  3 Nov 2026 00:22:05 +0000
In-Reply-To: <20261103002205.3348519-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103002205.3348519-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103002205.3348519-6-dmatlack@google.com>
Subject: [PATCH v2 5/5] KVM: selftests: List the known IOMMU modes in
 irq_test's help output
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

List the names of all known IOMMU modes in the help output for irq_test's
-t option, using iommu_mode_names() from the VFIO selftests library, and
clarify that the IOMMU mode is auto-detected by default.

The help output currently claims that the only valid modes are
vfio_type1_iommu and iommufd, which was never true, and would get stale
any time a mode is added to the VFIO selftests library.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 8a345472df5f..ef69f9d7ac3d 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -159,7 +159,8 @@ static void help(const char *name)
 	printf("-i	The number of IRQs to generate during the test\n");
 	printf("-m	Pin target vCPU to random physical CPU before triggering interrupt\n");
 	printf("-n	Deliver 50 percent of IRQs as non-maskable interrupts\n");
-	printf("-t	Override the IOMMU type to use (vfio_type1_iommu or iommufd)\n");
+	printf("-t	Override the IOMMU mode to use instead of auto-detecting it (%s)\n",
+	       iommu_mode_names());
 	printf("-v	Number of vCPUS to run\n");
 	printf("-x	Use xAPIC mode instead of x2APIC mode in the guest\n");
 	printf("\n");
-- 
2.56.0.385.gac671c819a-goog

