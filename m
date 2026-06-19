Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6BC40D569
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 00:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781828708; cv=none; b=UpTtbLWYStBlHVEQekf5TWorfeql0ngMhE9VSnv0tCB0OwE/nY01erZAJAE/+RTok0XNZb5Soie2W4/6hHrvRiCOgYxNXUGbfHdBVn9c7kYCZsqfdgDBw8f7Dv/V6BoIqi1SCLF2mCzcXAKq6CaJJvgD5yBeg8eluCqktviwI4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781828708; c=relaxed/simple;
	bh=RPXSsttVAkMEksbd77IMhfomIYWZCZUd21zu7CbOms0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RqEW+6EJcXZfektB2gMJc4lVN3Ke6cCiaJVDaQ9JQrO5wd92/c7k3CrMbSVo8wPmrPjFM/Oq8CyNfXf+zQI31SluzsdK8jqe0T2LU+a02BUJBKOWrXz+z8GxpzE58tGyv1Y1ky5y07AKLfgDPCpOoSO72NhGCIXV3eSvI7Ti2oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NqA8ZE1C; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NqA8ZE1C"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-48638069322so2664774b6e.1
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 17:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781828706; x=1782433506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d7YtaVIciY7JBc+dcHSLni4bpGNmZyFq+9y/1OTHJV4=;
        b=NqA8ZE1Cx4ZWrpUAVFEg+bdMSbv0jBJ6JrL7Of+Zv0g3ylms96sZ3Cm2J5Ha4V655X
         p9cMxrdofmuM9HsOgFkqA3j9rN3RcbI4vCcNn8pS2lMn8RoOX9HJ2NAEJx6uu95UHii0
         KchAM0HbAuhX3JLwp2ljFAPS2mWkwe2DVTE80bM9522Gh7ozazQkWxkAy8uHBgSsgDhd
         kzBrrEtzcsHWgYXhPsd40GnjMrQ9KKKQIM3dPojGO46yPMlICm1dAIn1nm+O5nghpTNL
         pTQJ9t5Vfn5o/H0XznOJnPHX8yWZrSMerOFEbGW2pas4So7pPrJD0RP+P/LLJMcXEG/u
         5WSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781828706; x=1782433506;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d7YtaVIciY7JBc+dcHSLni4bpGNmZyFq+9y/1OTHJV4=;
        b=XMwCNAW1Nqhke/LVrhgPIEwsaJX1SbUN2p5dUSHbrGkGg9AE/qRzY1SakC6uQbdX4K
         haRKatLZeqyhK1ZkAroaZ3eFhuDpaTOVIqMEq7J8YH+smMvUF0vFVks6062tLIh5xTBb
         storrpK9uXKyOBfC2ao2y2sK2lwqaXLKaDPTLSiZSuJbqkFOB4Azk1J1LVbH4jUg6L/b
         lOaYd428W4J8kvLYaQrX3kxJ4xaQ0LMIGDsG3mtOHOj77KxTg12SFZCHd9E5Ae7FPFiX
         b9pz6/clxpnrW73cx6PJkcmFG8NfDGxcwMIMlgDpJOQbfNrE0Krk6/2Mo/HHfyy5HoN4
         8tnA==
X-Forwarded-Encrypted: i=1; AFNElJ+QfiJepFx0rKPTUAvQ1HmzSHYgMSVDpM9rmO/Y8Nyq8p7LL68eQ9SLzTaaRPlasCeXg0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK09bCjyosPAbJCb2c/xGqVelv+B8WdcV38oli1vMHTgikZAjk
	kgHKFrqLSfNP985uUJHJDjZPZ6BKR7Djp8N0AiLBKNhZ7MDFo5e367iy3JI/IcuwX1V5KAP2M+3
	4BJeDYI7y7OUHJ+uYi48b/7pSQQ==
X-Received: from ilef13-n1.prod.google.com ([2002:a05:6e02:618d:10b0:502:2ae7:6d85])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:448d:b0:486:7c50:6f9d with SMTP id 5614622812f47-489ae7a3190mr318878b6e.8.1781828705607;
 Thu, 18 Jun 2026 17:25:05 -0700 (PDT)
Date: Fri, 19 Jun 2026 00:25:04 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260619002505.669698-1-coltonlewis@google.com>
Subject: [kvm-unit-tests PATCH v2] arm: io: Set is_pl011_uart flag in ACPI initialization
From: Colton Lewis <coltonlewis@google.com>
To: andrew.jones@linux.dev
Cc: alexandru.elisei@arm.com, eric.auger@redhat.com, joey.gouly@arm.com, 
	maz@kernel.org, thuth@redhat.com, pbonzini@redhat.com, nrb@linux.ibm.com, 
	imbrenda@linux.ibm.com, marcorr@google.com, oliver.upton@linux.dev, 
	kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

When booting via ACPI on ARM64, the SPCR table is parsed to initialize
the console UART. However, the code was neglecting to set the
is_pl011_uart flag. This caused __getchar() to fall back to treating
the UART as a 16550A device, which fails on systems with a PL011.

Tests that wait for serial input (like its-migration) would hang
indefinitely because __getchar() would always return -1.

Update uart0_init_acpi() to inspect the SPCR interface_type and set
is_pl011_uart accordingly. Also define DBG2 macros for SPCR
interface types in lib/acpi.h.

Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/acpi-debug-port-table#table-3-debug-port-types-and-subtypes
Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
v2:
 - Align macro names with Linux kernel DBG2 definitions (Alexandru Elisei).

v1:
 https://lore.kernel.org/r/20260513211624.2416284-1-coltonlewis@google.com

 lib/acpi.h   | 6 ++++++
 lib/arm/io.c | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/lib/acpi.h b/lib/acpi.h
index 66e3062d..a62cd3a9 100644
--- a/lib/acpi.h
+++ b/lib/acpi.h
@@ -251,6 +251,12 @@ enum acpi_madt_type {
 /* MADT Local APIC flags */
 #define ACPI_MADT_ENABLED		(1)	/* 00: Processor is usable if set */
 
+/* Values for interface_type field in struct spcr_descriptor */
+#define ACPI_DBG2_16550_COMPATIBLE	0x0000
+#define ACPI_DBG2_16550_SUBSET		0x0001
+#define ACPI_DBG2_MAX311XE_SPI		0x0002
+#define ACPI_DBG2_ARM_PL011		0x0003
+
 struct spcr_descriptor {
 	ACPI_TABLE_HEADER_DEF	/* ACPI common table header */
 	u8 interface_type;	/* 0=full 16550, 1=subset of 16550 */
diff --git a/lib/arm/io.c b/lib/arm/io.c
index 836fa854..9c07fa3d 100644
--- a/lib/arm/io.c
+++ b/lib/arm/io.c
@@ -81,6 +81,9 @@ static void uart0_init_acpi(void)
 
 	assert_msg(spcr, "Unable to find ACPI SPCR");
 	uart0_base = ioremap(spcr->serial_port.address, spcr->serial_port.bit_width);
+
+	if (spcr->interface_type == ACPI_DBG2_ARM_PL011)
+		is_pl011_uart = true;
 }
 #else
 
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog

