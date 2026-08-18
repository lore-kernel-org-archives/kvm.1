Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C6223D291
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787060125; cv=none; b=lkNaZ0RbNNZqVxSpiQl5mnztrRE9VlHDsRw6W3esPltAUVIh9v2sBF4nzK4qn4HSOh787zQ21PtVcWpw06SYGqbJpsprehooWFOFnhmtcOspYRFjodHMnso3mc+AymWltj8ugLhnMaJGdR4or4sBfH2YXEPSkbhRAaDRpzLCU+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787060125; c=relaxed/simple;
	bh=WeHr00/McpvtoEaZsDkQRdZCdT6xYlVFAo0MSF3qSP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZmaK71SLEEYhnD1n77X9ppU4Mwc7Is8YlR0JM4PrFFVFOOCAYv3lLTn8rBRjn9H/ci1QWRonkyE4DxarIW30o9WR6YqrwPc/1lhikdd6u4Rn24w68FmdPRfHOtrr+Kfc4eeYr8IPdW1YGqpMXFJvjLjRxYN9YPB+y8Y6gQdQ8rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kd7Xqa3o; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPSQiWOZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kd7Xqa3o";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPSQiWOZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787060123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iwKab0ZG6AeU+AJZG+ZnFWec+B6zx60JcDaMgjFWGn4=;
	b=Kd7Xqa3oEXXLh56uXHsxe0pi/ikRzc+Qc3GYmOjrEu678F4uDGf39EA29UyUv4ApXgFPQl
	hj1PCJfNO05HwkPht/GQUY9T3PsTKV/sMtEE2QEURI2bxZTIZ6FrXC7VJc2YoFJS4XC2mV
	DtCXEA/sqUB3KwcLXGKGQlpd4yVnHuc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-bjdmmdyGNPqtPP61bdjhng-1; Tue, 18 Aug 2026 09:35:16 -0400
X-MC-Unique: bjdmmdyGNPqtPP61bdjhng-1
X-Mimecast-MFC-AGG-ID: bjdmmdyGNPqtPP61bdjhng_1787060115
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cee894b3d8so88719475ad.2
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 06:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787060115; x=1787664915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iwKab0ZG6AeU+AJZG+ZnFWec+B6zx60JcDaMgjFWGn4=;
        b=jPSQiWOZmH8vJW5WdFTJ0u0Uc2yZYGvkQ+ygBrEKFfx2fHP7ObHqLJCvK6UDQrO4jc
         LRKTKDD7Pc2ZwCww6S96Eg8CUlyg3I96+3QAgPTq4jvgukjIxJZxJvNTntRTdpM25OSh
         ZMI/M/MPiLT+JVbGW4QEmq6iesYrXu6XqBckY9+M/r9QgpVdTQKb3nn9d3PpOVMKaY7c
         TeChpnpzGy5NjrrAJxFq2YAHeOfe11u2HB4dzyT7zIbZwENTQ7KEbi6RLNsSN+subo9K
         1uguP6aOgvizexwym6STg6zA1gO+XtSasYgGB5zqiozNSsmV0tBpFDMo1F5CPXdLLoVE
         csLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787060115; x=1787664915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iwKab0ZG6AeU+AJZG+ZnFWec+B6zx60JcDaMgjFWGn4=;
        b=Og+Yf5bizZJ/EjMavMIUcqMlZWktAjCzaDqoyT+ybpwruTUfM3GV9KXKBkYhXbIGvX
         3Dvn10FIXGE+vFu1D2UDItqlQm3/WODj/mcxIb4KGn7Ltbq6ckn0qDYZ1yFaUxuOcPOP
         iGEC2Q97MvBCIFYWdSjt6Eaxv3Uw3z8RIx2lmQkPODv6gafQ9kvIuYJ1sjt9xC0l5DIe
         c0NQxcgifTXtjTrpbZOdyw9xmynv4RRctTrtuYnIbRvtI6VGb6h+km6reeoP9W1madlW
         DfyRwMbtKTbMKU45rK5Rhz1fmD1XUcQ+KjcPiTK6UMZFd3brmUO4iI2wVBHC3wcCd1G2
         L7Lg==
X-Forwarded-Encrypted: i=1; AHgh+Rp5IHv/qgXnRQuPOaO3LPxiqNK9ZO5bvPFPiEeoPUtyHPRuZdbb7j49dXQXMJ6bvH899tI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+dT3+mUFiufLQD4+sra2Fj2FJw2icElu7NBb0NtuH913eS13T
	83496n84JTJWNcDOXB4nKH5od2BiTRZucBmMMxoj2rLf6Mu8XT8p02ptuajRev49Ux4yRHP3iKw
	CNqBK0JN5xzY2KmDkwtE84hGKXfhxj7oqN2P4EMMkibl83JQf9PcVXnFs6Xihew==
X-Gm-Gg: AR+sD1237ZtCMo3KoaPG+uK+RRrTRMB1mFUQaKSzVn5A3GHnrA8TYRXE5YZOIFjIRao
	Q3wptw/oj/ZMCuIihY1NrpkhhMynrMzKan1tLIfInifPs/b6b/HHFqU0LRMspO9Dghue+uq1WoG
	rhm+0RKc+UTGqvLQfowGipYZtt7THXgunPnTiMAF6OJvI67eBCShJEYHbMIamuLXPZyOhX/90G3
	uLWPN63taeDJMkJH1zEj2EbuKEjO5K0GPVy1Q6Fydoj2RUefJjkOqjQrIj8FQm9SBQbphw/9/nK
	Whp/h6T8JzqSC1b+pbycwTbjOkpWYE+xIo4DuQFPEV3bOoKOiRA5jUR/ajfmfnhszkTkQyNiWWs
	Br6FYn96eQaeoStjShTs=
X-Received: by 2002:a17:902:ef43:b0:2d5:e3ce:3988 with SMTP id d9443c01a7336-2d5e3ce3aafmr59356055ad.11.1787060114877;
        Tue, 18 Aug 2026 06:35:14 -0700 (PDT)
X-Received: by 2002:a17:902:ef43:b0:2d5:e3ce:3988 with SMTP id d9443c01a7336-2d5e3ce3aafmr59348685ad.11.1787060112377;
        Tue, 18 Aug 2026 06:35:12 -0700 (PDT)
Received: from ariel (fsda291717.tkyc313.ap.nuro.jp. [218.41.23.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-326794c0c94sm33286280eec.9.2026.08.18.06.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 06:35:11 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: pbonzini@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	kvm@vger.kernel.org
Subject: [kvm-unit-tests PATCH] svm: Add SMI handler for svm_intr_intercept_mix_smi test
Date: Tue, 18 Aug 2026 13:34:40 +0000
Message-ID: <20260818133445.8688-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

L1 intercepts L2's SMI and the SMI is still pending at L0. When L1
re-enables GIF via stgi(), L0 delivers the SMI to L1. Without an SMI
handler, L1 enters SMM and aborts.

Install a trivial RSM handler at the default SMBASE entry point so L1
can return from SMM.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 x86/svm_tests.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/x86/svm_tests.c b/x86/svm_tests.c
index ccbab1d0..11770854 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -3543,8 +3543,28 @@ static void svm_intr_intercept_mix_smi_guest(struct svm_test *test)
 	report(0, "must not reach here");
 }
 
+#define SMBASE	0x30000
+#define SMBASE_ENTRY	(SMBASE + 0x8000)
+#define RSM_OPCODE	0xaa0f
+
+/*
+ * Install a trivial SMI handler that executes RSM at the default SMBASE
+ * entry point. Without this, entering SMM causes an abort.
+ */
+static void install_smi_handler(void)
+{
+	WRITE_ONCE(*(u16 *)SMBASE_ENTRY, RSM_OPCODE);
+}
+
 static void svm_intr_intercept_mix_smi(void)
 {
+	/*
+	 * L1 intercepts L2's SMI. It makes L0 deliver the SMI to L1
+	 * when L1 re-enables GIF via stgi(), so L1 needs an SMI handler
+	 * to avoid aborting.
+	 */
+	install_smi_handler();
+
 	vmcb_set_intercept(INTERCEPT_SMI);
 	vmcb->control.int_ctl &= ~V_INTR_MASKING_MASK;
 	test_set_guest(svm_intr_intercept_mix_smi_guest);
-- 
2.55.0

