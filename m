Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAA5367B8E
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786654866; cv=none; b=ugZYerKRr4jAoXI91FRomVVTQYEL7R3y6iKRcyzzvbCnVfRlgUt5BEb7qZTn45eLoEu92No5DueSVqWX596L5nOhss1N01KfzOVxruG95QeABoe8kRmKVrbxFRK4AJAlG3xSHMzSDqlpFQ8vFldepmoIz2I/WAnwU2MZMI5EjWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786654866; c=relaxed/simple;
	bh=oiqsbWXWAPIsOSM2CC2ojFZbDfER351WH8zqslKT8RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8/GHgHchHdeYcKUEA44qvIVL4a0T0+cLq+m8aQdq/NVdcvOGMBGPYEJ6TcdAV3cSN774KnKKYXpUa6xQt7zbyaFNfpAjDVJhrNdfVvIMxXJuJ573M89feMfmogNON2gpDCPMJ7pqIalVmti3S9cL0pp5naH+NNSr6x6b2Eei9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXomZ6au; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXomZ6au"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d0407aedd6so4820865ad.0
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 14:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786654859; x=1787259659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/d852yyPhxd/oSRf58riaJn3KKS40lJ11FcG1X00qZI=;
        b=PXomZ6auBOvt8P/nrdxRoBnZSmQsn99R9M3DSvQWLHNCVBwdp2kGxe4UX2o0G4MJ0k
         05YsRqUuYU3Nxq1ThAzLJZLM6pOCT8rRkPVkn8uRCO4XBH7zFYDetkXR/5VsEmC0I0ao
         maHVrRYbRtU3V7iPnyEEPXwEGqMLSjGtFU6vNrjMkTdFLeCl4ZMJDrkODkOD4mNrNPRB
         aeIoNOoduwMfQE+Y3FN7USRxkpjMVpP3Ma8OeqUI2N4ZqHf2TFTjnT4pcMzg2WS7iKxd
         XULO8AkuNP25ivcMkwIzYTkVmjlW/eSWrUksJXDKfmB58H9IBT1CPddi04rz/HjX0WZ2
         xkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786654859; x=1787259659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/d852yyPhxd/oSRf58riaJn3KKS40lJ11FcG1X00qZI=;
        b=a40LafJ3UA8aDRR4riAzAJYY/iII9NIUVzD0OGf33Ujgp4efeFXXYT8qTILMwjclfl
         2l/hzZPEocy1l6aczjqJDhZSeKMR1txJ0qn2QR/Zf2yZyUBq5rMz9b7SmqXRjuKwgmiU
         fAvg8yz7kY54tnP7NjH5J9DfOv4GeHL4fA9M5Ksi0dyuBi02WciT6UOv3QCygHUagjhS
         LYMo7dN1JUYgPmj9h2e22DBhMS1a3U/ur2Iaa8uUrwutBeJtmmIrIrbuFQKFUw0v5NlT
         bSlg7g/RH1MyKtFXY8X5RHVQXFVlbzgFp4PTnJWw/AAfko+yotlN0pG7xdufFlGg8nU0
         ostg==
X-Forwarded-Encrypted: i=1; AHgh+RplKqDu1NhiiL5kDkZPDp/eyKAM9flwzciz2M+VuFETNY/V47JaU9GjipL+19FMSzhaL2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSI1AJRQEN1qyXVarxoqw8djwfTODKmBGeqOFAzag9aGs/Porm
	z9YIC39khpMwEvtZ2/WZ6bx5wK/Md93ZeS0C0B1LNh+HVEhC+HNkZspF
X-Gm-Gg: AR+sD13Z50Lf13FKDBZ6LO0LpG9TxP19EFSltzKdJomeH3RliQTAgcfouTuym6m6GsD
	00QC0n240EKLuptywqt4h8G/6qr8EGYWlTKXcXxZIo9NhgbPMnEsisbuDFk5Q1OlR1pH8Un5UlJ
	ajRfaYqUivYfO/P//kcHwv64EF84pr7Wx0cq5dyc7WzldpDtHE+Mn5TyQkkTMKwZlLqj/wq+HJF
	WACn/n6wQ+yKZjIgTj8XSZoSwTKjtZPB3YdmbgK/MF6bpqcKT0vZukchg9tbCQ5K4GEalDf6fpi
	OYxKWfadgTBEZbVSk28cZpSEF2+ZQIt1jAgKOWnK4XF9gZlRE0zwDkF3Jhzr23I9SL5WrTL4HNO
	Dgns5qa0oLXIsDeNWwkSy3ZEvo2wSU0RQPGMe3MthekCijO7plut3OrgFJmNNnZugiptL4M+/Ht
	YkpBxS3Rq6EXdPNquVTybzCkER9zXp11O6F0aU/QPLRcUvCtBapxCH7Nog/L50RQeReA+4ReJoS
	qYBIbVPmSiseH43rVIP9VawfzaLoBD0JrGVHRultrw2RIrH+P5W
X-Received: by 2002:a17:902:f610:b0:2d3:2b8a:5007 with SMTP id d9443c01a7336-2d3b0e4378emr9023655ad.15.1786654858602;
        Thu, 13 Aug 2026 14:00:58 -0700 (PDT)
Received: from wirene2.c.googlers.com.com (249.65.83.34.bc.googleusercontent.com. [34.83.65.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aeb27e33sm2017045ad.46.2026.08.13.14.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 14:00:57 -0700 (PDT)
From: Irene Wang <yiranirenewang@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Andrew Jones <andrew.jones@linux.dev>,
	Thomas Huth <thuth@redhat.com>,
	kvm@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Jim Mattson <jmattson@google.com>,
	Irene Wang <yiranirenewang@gmail.com>
Subject: [kvm-unit-tests PATCH v3] x86: pci: Support unaligned register access in PCI config read/write
Date: Thu, 13 Aug 2026 20:57:43 +0000
Message-ID: <20260813205742.2752510-2-yiranirenewang@gmail.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
In-Reply-To: <anZgkSwhjHDG3dWy@google.com>
References: <anZgkSwhjHDG3dWy@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per the PCI Local Bus Specification (Section 3.2.2.3.2, "Configuration
Mechanism #1"), port 0xCF8 (CONFIG_ADDRESS) requires a DWORD-aligned
register offset (bits [1:0] = 00b), while byte and word offsets within
the DWORD must be selected via data port 0xCFC + (reg & 3).

Previously, PCI_CONF1_ADDRESS did not clear bits [1:0], and 8-bit /
16-bit helpers always accessed base port 0xCFC directly. This worked
in QEMU because its PCI host bridge emulation preserves unaligned bits
in CONFIG_ADDRESS and uses them during CONFIG_DATA accesses. However,
in strictly spec-compliant VMMs (and potentially real hardware), bits
[1:0] of 0xCF8 are ignored, causing non-aligned reads/writes at port
0xCFC to erroneously target byte 0 of the DWORD. In practice, this
causes pci_find_dev() to read the vendor ID twice instead of reading
the vendor ID and device ID.

Fix this by masking `reg` with `~3` in PCI_CONF1_ADDRESS and adding
the `(reg & 3)` offset to the CONFIG_DATA port for 8-bit and 16-bit
accessors, ensuring compatibility across QEMU and other VMMs. Additionally,
add an ASSERT_PCI_CONF1_VALID macro to guard against illegal accesses that
cross DWORD boundaries.

Assisted-by: Gemini:gemini-3.6-flash
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Irene Wang <yiranirenewang@gmail.com>
---
v2 -> v3:
 - Add comment in PCI_CONF1_ADDRESS explicitly explaining that clearing
   bits [1:0] prevents QEMU from double-offsetting accesses (David)
 - Introduce ASSERT_PCI_CONF1_VALID macro checking that access offset +
   access size do not read/write past 4-byte window (David)

Link to v2: https://lore.kernel.org/kvm/20260804232344.2976694-2-yiranirenewang@gmail.com/
Link to v1: https://lore.kernel.org/kvm/20260730182053.905335-1-yiranirenewang@gmail.com/
---
 lib/x86/asm/pci.h | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/lib/x86/asm/pci.h b/lib/x86/asm/pci.h
index 03e55c27..144a4459 100644
--- a/lib/x86/asm/pci.h
+++ b/lib/x86/asm/pci.h
@@ -9,22 +9,35 @@
 #include "pci.h"
 #include "x86/asm/io.h"
 
-#define PCI_CONF1_ADDRESS(dev, reg)	((0x1 << 31) | (dev << 8) | reg)
+/*
+ * Bits [1:0] offset into data port, not address port. Spec compliant
+ * host bridges ignore them in CONFIG_ADDRESS, but QEMU does not; mask them out
+ * here so QEMU doesn't double-offset the access.
+ */
+#define PCI_CONF1_ADDRESS(dev, reg)	((0x1 << 31) | ((dev) << 8) | ((reg) & ~3))
+
+/*
+ * Ensure access offset + size stays within the 4-byte (DWORD) boundary.
+ */
+#define ASSERT_PCI_CONF1_VALID(reg, type) \
+	assert(((reg) & 3) + sizeof(type) <= 4)
 
 static inline uint8_t pci_config_readb(pcidevaddr_t dev, uint8_t reg)
 {
     outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
-    return inb(0xCFC);
+    return inb(0xCFC + (reg & 3));
 }
 
 static inline uint16_t pci_config_readw(pcidevaddr_t dev, uint8_t reg)
 {
+    ASSERT_PCI_CONF1_VALID(reg, uint16_t);
     outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
-    return inw(0xCFC);
+    return inw(0xCFC + (reg & 3));
 }
 
 static inline uint32_t pci_config_readl(pcidevaddr_t dev, uint8_t reg)
 {
+    ASSERT_PCI_CONF1_VALID(reg, uint32_t);
     outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
     return inl(0xCFC);
 }
@@ -33,19 +46,21 @@ static inline void pci_config_writeb(pcidevaddr_t dev, uint8_t reg,
                                      uint8_t val)
 {
     outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
-    outb(val, 0xCFC);
+    outb(val, 0xCFC + (reg & 3));
 }
 
 static inline void pci_config_writew(pcidevaddr_t dev, uint8_t reg,
                                      uint16_t val)
 {
+    ASSERT_PCI_CONF1_VALID(reg, uint16_t);
     outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
-    outw(val, 0xCFC);
+    outw(val, 0xCFC + (reg & 3));
 }
 
 static inline void pci_config_writel(pcidevaddr_t dev, uint8_t reg,
                                      uint32_t val)
 {
+    ASSERT_PCI_CONF1_VALID(reg, uint32_t);
     outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
     outl(val, 0xCFC);
 }
-- 
2.55.0.691.gc56d675ccc-goog

