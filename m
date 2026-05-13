Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F023AC0CB
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 21:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778706990; cv=none; b=XOzoIdGzN5tggsS+y0NPmY5Z30awMQL4250kPvDW7THQMNDz00qxGo31jmcFHu7IYryUBXrR7hZqIaeCgrdBTYQLBPzFG4WWvWzX9NdZV625hjZ2r0JmxprJ+/5SDzEBPxKtaV8+hBC7c0jp4yM58ZGLcqocPW8pI8T+ws1Zwq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778706990; c=relaxed/simple;
	bh=jKQ8iuhXGvRDVAnzj1gC6DLK91R18lf4SB4H8czhV5A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Sh6AgrHmnsNewQoYbpZEa8cvMfl40BuwMZYbhlmAOrKh5uGBcH+8ED2kq50IZobzMjzcnxU0mcQqhfgmWUqehbSItO2BQpVrkprRC2rAxkRot55HXqduSc4Hmgndc6a3XzoNJXG9BzkM2efb+0f8RjJhu72ujIEApkksXnzayoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KmFDD/4X; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KmFDD/4X"
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-6966f1f4490so16575675eaf.1
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 14:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778706985; x=1779311785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6JXnGk6v8vsVrC7dHkuW3HoXav5Obr9bfPUm82eBukk=;
        b=KmFDD/4XuyzgwaOH+WPWLxh0bVjCL92UIfskkaJr4zM0F8YeYsaYLPLbtCNmTULWec
         yfa3W+eowHMCIjMJ4ml/YUygFG98EytKLbIx1sXcsMt/WkCVgOz9ujdyd86xcqs0s2Qn
         ykrSzVa+JVlnBUj3okfcLpwi+eR6mxgAAaQnLx/fEk51rHDGIBcUm8lOzM2cwYwjiqZ6
         60GzNQ41B2mZWM7ma3VztPLjo+7TJZlfldNwbjNtp819/FsKKEvN91SMQhLLnWAWs80m
         obxq4tFXxiMqczlfMssT9NOeV1jzvqSoltDi5sPITLiG3x/om6V2ON6C1hgLPjM5YMSB
         3MtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778706985; x=1779311785;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6JXnGk6v8vsVrC7dHkuW3HoXav5Obr9bfPUm82eBukk=;
        b=rG2SwmTQPepkPfcwOSNK1G6JtqOTMofbbSrHIdp0MxM1QvHiR57iwMJKRmk4HzshbY
         n7errWKqUlxx0qRE/Ao5Bx5IJiYRwN6y13bt4/PGfoYTP9czZFVbAtHVmj2De44II8Va
         vtESZCsnfbWkg9XOpvI+fDLJEDKr7VU18n3gRLifoMIemNVLJ1fs41soA8kkU6TqmYQy
         v70ocKzvlYiFvfkhHvRaGXcCZWie2qCGBJ4y5EPFfSVBT7PC29FKeX8D4Bd4pPT9ogX4
         aI4kAOF7iOWysLzraGE7QQm8w9F+5GJSd/8hESsnLC0ttUiYPta2cdwVWbsNL/5ogJwT
         pqdg==
X-Forwarded-Encrypted: i=1; AFNElJ+pe874fqM/GGHNqwhwEqY9gPvrQnqG952UhO4mcFIOjadn3+o5ZrO/mPErKhuMERqt+4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR80+7tMbTIqxtkaux5Ce1yRXENOihDJdXZVTK4dfOg+SZhJXj
	2VjlozIiZxon08dPPpUnhttbRUFDI47H/tCEoDJPvDTT+w6hRNrPABYfeQ9pLOlC+iHNswFM9+X
	Hy9eX9tDODrZ0I6n0i//3p5kPLw==
X-Received: from iln3.prod.google.com ([2002:a92:d03:0:b0:4fb:4caf:c442])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a4a:da01:0:b0:694:95ae:c546 with SMTP id 006d021491bc7-69b87d2fec1mr592304eaf.2.1778706985183;
 Wed, 13 May 2026 14:16:25 -0700 (PDT)
Date: Wed, 13 May 2026 21:16:24 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513211624.2416284-1-coltonlewis@google.com>
Subject: [kvm-unit-tests PATCH] arm: io: Set is_pl011_uart flag in ACPI initialization
From: Colton Lewis <coltonlewis@google.com>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Eric Auger <eric.auger@redhat.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

When booting via ACPI on ARM64, the SPCR table is parsed to initialize
the console UART. However, the code was neglecting to set the
is_pl011_uart flag. This caused __getchar() to fall back to treating
the UART as a 16550A device, which fails on systems with a PL011.

Tests that wait for serial input (like its-migration) would hang
indefinitely because __getchar() would always return -1.

Update uart0_init_acpi() to inspect the SPCR interface_type and set
is_pl011_uart accordingly. Also define macros for the first four SPCR
interface types in lib/acpi.h based on the Microsoft specification.

Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/acpi-debug-port-table#table-3-debug-port-types-and-subtypes
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 lib/acpi.h   | 6 ++++++
 lib/arm/io.c | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/lib/acpi.h b/lib/acpi.h
index 66e3062d..29b3edd5 100644
--- a/lib/acpi.h
+++ b/lib/acpi.h
@@ -251,6 +251,12 @@ enum acpi_madt_type {
 /* MADT Local APIC flags */
 #define ACPI_MADT_ENABLED		(1)	/* 00: Processor is usable if set */
 
+/* Values for interface_type field in struct spcr_descriptor */
+#define ACPI_SPCR_INTERFACE_TYPE_16550		0x0000
+#define ACPI_SPCR_INTERFACE_TYPE_16450		0x0001
+#define ACPI_SPCR_INTERFACE_TYPE_16550_32BIT	0x0002
+#define ACPI_SPCR_INTERFACE_TYPE_ARM_PL011	0x0003
+
 struct spcr_descriptor {
 	ACPI_TABLE_HEADER_DEF	/* ACPI common table header */
 	u8 interface_type;	/* 0=full 16550, 1=subset of 16550 */
diff --git a/lib/arm/io.c b/lib/arm/io.c
index 836fa854..55102bd7 100644
--- a/lib/arm/io.c
+++ b/lib/arm/io.c
@@ -81,6 +81,9 @@ static void uart0_init_acpi(void)
 
 	assert_msg(spcr, "Unable to find ACPI SPCR");
 	uart0_base = ioremap(spcr->serial_port.address, spcr->serial_port.bit_width);
+
+	if (spcr->interface_type == ACPI_SPCR_INTERFACE_TYPE_ARM_PL011)
+		is_pl011_uart = true;
 }
 #else
 
-- 
2.54.0.563.g4f69b47b94-goog

