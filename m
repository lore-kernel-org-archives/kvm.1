Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A573859EF
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785435716; cv=none; b=J6PhZ7Id+WeXlW633LDgaScAP/Ln9fXW/ljyWjqjQJKnROyiX3+agiS7HiqTBsrSbjRb+D5tzkfWeKVyvbXIKEGnIF6ctIkGiO6r0XahQEMp6fcgrlb1ieRPmtpfP4LAV1KPOAO9CQhJld+taQ7r5nRMLfzPF+c/mBzCPqZaWCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785435716; c=relaxed/simple;
	bh=cnXdVpJqtS6CKYmSYOu5HrZeA6Sexa9Db8fDkVzi/M0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/j4AG4FaxFOk69aTGFC8V2wEnFC4DCoO2+msv49KfkNdlP/Qd/PQ/8Y5C/LpJQxMfhdpU3u4V+z1m4Z7w+C2qesCl+4XLgYN11SIH+fpJ4goU3N425528sgSUD/Hu5Bmz61ORn5xMHYv+wfuYzcARsd3rlmA9Eao2ZVtEjfrU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlBzeBIX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlBzeBIX"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cea3004256so1338895ad.0
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 11:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785435712; x=1786040512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WhUNIqsonkRRMTXAnOyItlVLbQQzWZZfYjEel872m6o=;
        b=SlBzeBIXo0hZ2Dl5gQ30K1c2ImTgSrsFked8QQKKyPW5C10QZA0y1CIvBnMoYU8mTG
         ICIHQsIrYmxEbw4lSs27UEMP7dy63XLEy/d1HERzo1sYVqex3JkfEoQi1otQYD/earJI
         v2AyNKEKDJ50KxijoJa7mekiGTqLJNdR2RKJA/nN63kdJSG/ImI0Qn4OTIQcrfZWDjUD
         22YCXCGG4C9vNwPcab1HgfF+VxqoVX4Yp0FewMy2tcS98BfZjFXBKNO/o1D5O1wT1O+s
         h18M97Lb7ApdsgfEEspS7gQwbRfKfdXKTZjzGBtpqPpKFkI9qLWEUAGSQViy2OiGR1px
         7/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785435712; x=1786040512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WhUNIqsonkRRMTXAnOyItlVLbQQzWZZfYjEel872m6o=;
        b=RQKCSKIZVILOC9gzvAK7nPxj3BrRXml66RDeRnu7tEZFCCm9Eq1mMcxDMnqqsqxP7p
         iMdSVcHnyU0cZxRHQmJwCoOYGvnARRhzZAsBfrN9piLligPiz0Bv+VS/G6IC/JNdY3XL
         2tyVKiTqOY/6VaEOmYHYqEu2w5yRomtASkStoTHoeZKfZxiY5HHFHcklY3HIFav7DtHr
         Qq+3DjM/YWgylQtGpuBOXQ91b+/pUTahj4+XlObrIYS0fTFB13NCYu84NiAIeOUCEqBA
         dfAeoKGx4KPUM3+JKQYTDbil4+/7pjdTU5eXmuimHS+cAjfSnNSIlvjTehRxFPf4ZOQN
         0SVA==
X-Forwarded-Encrypted: i=1; AHgh+Rqlvu/ATMDPfMgweqAg2rgoFMJCIN2PLQsKcfiBFJQYjKES478xu+a4XvSQjP1ecVPyUPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6c6wrZ+VWeTVBF71hjADEdnYufmYAqvqhbVH7nno+SC06JZvK
	mNZ0++2h8bwTNUUHde/eCEQ3kYmbplp16XHNgbj/s6AIWerebdBBKD7G
X-Gm-Gg: AR+sD11npikM1/Ckyuo8GyED92enhYWYiWGKhmslYYlTOuDqRfzDPCx7YDiq3joemc2
	8EHje5yISXo5Kyk5efyiiaWri8m24HdIgX2Fh6eezS4d/50nHLukn9lYX4YBNhRoWOLj+xsP1e+
	eKRJc1SL+tHnk9IOYBnVCiAsHiCkbaR+A1443CV3Bq6307v4YNVT9XVMNutckMOkUK3Ah42PTz2
	Pm5jQc7BChHLAm09gC9QWwt+8IaAm8NedbSsCApTysoyx9RBptxPLXAsbGg58Tt25ZKGgrgw7NE
	sMzuOLX9a/g/9B80X29fuoQOnbdP/qQ8NT08TDbxT3kzQ/CjCJ9aBVljv2UtPJeOF/JiG03OJCg
	MciQpGPmsThTYzg3REMqhL3HAGRpQE6i6hAMAPFFwWh6U85GGVe/+8tvKQad8a0qpjtK0hcbrb+
	EU1jCy2cVjSdwjSmWQ3dMWkzS2C2rewo6pfh9CUyWwRwUGRMG/pymx8Zi/el4B2P3E/5IQE+rWb
	Iq/sliwzkHQIJ1Ru9iR211g0qKonZkzLWWOuTrOWvA0ovZGiKmr
X-Received: by 2002:a17:903:1a2b:b0:2cf:9cf2:3533 with SMTP id d9443c01a7336-2d035be4b51mr35641225ad.18.1785435712288;
        Thu, 30 Jul 2026 11:21:52 -0700 (PDT)
Received: from wirene2.c.googlers.com.com (249.65.83.34.bc.googleusercontent.com. [34.83.65.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bc5afasm30750155ad.46.2026.07.30.11.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:21:51 -0700 (PDT)
From: Irene Wang <yiranirenewang@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Andrew Jones <andrew.jones@linux.dev>,
	Thomas Huth <thuth@redhat.com>,
	kvm@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	David Matlack <dmatlack@google.com>
Subject: [kvm-unit-tests PATCH] x86: pci: Support unaligned register access in PCI config read/write
Date: Thu, 30 Jul 2026 18:20:20 +0000
Message-ID: <20260730182053.905335-1-yiranirenewang@gmail.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
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
accessors, ensuring compatibility across QEMU and other VMMs.

Assisted-by: Gemini:gemini-3.6-flash
Signed-off-by: Irene Wang <yiranirenewang@gmail.com>
---
 lib/x86/asm/pci.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/x86/asm/pci.h b/lib/x86/asm/pci.h
index 03e55c27..09fd2372 100644
--- a/lib/x86/asm/pci.h
+++ b/lib/x86/asm/pci.h
@@ -9,18 +9,18 @@
 #include "pci.h"
 #include "x86/asm/io.h"
 
-#define PCI_CONF1_ADDRESS(dev, reg)	((0x1 << 31) | (dev << 8) | reg)
+#define PCI_CONF1_ADDRESS(dev, reg)	((0x1 << 31) | (dev << 8) | ((reg) & ~3))
 
 static inline uint8_t pci_config_readb(pcidevaddr_t dev, uint8_t reg)
 {
     outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
-    return inb(0xCFC);
+    return inb(0xCFC + (reg & 3));
 }
 
 static inline uint16_t pci_config_readw(pcidevaddr_t dev, uint8_t reg)
 {
     outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
-    return inw(0xCFC);
+    return inw(0xCFC + (reg & 3));
 }
 
 static inline uint32_t pci_config_readl(pcidevaddr_t dev, uint8_t reg)
@@ -33,14 +33,14 @@ static inline void pci_config_writeb(pcidevaddr_t dev, uint8_t reg,
                                      uint8_t val)
 {
     outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
-    outb(val, 0xCFC);
+    outb(val, 0xCFC + (reg & 3));
 }
 
 static inline void pci_config_writew(pcidevaddr_t dev, uint8_t reg,
                                      uint16_t val)
 {
     outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
-    outw(val, 0xCFC);
+    outw(val, 0xCFC + (reg & 3));
 }
 
 static inline void pci_config_writel(pcidevaddr_t dev, uint8_t reg,
-- 
2.55.0.508.g3f0d502094-goog

