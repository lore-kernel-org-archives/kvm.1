Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9AD3EB10C
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787010252; cv=none; b=rrPMYRHH78OP3/LVD/LdD2ES/wGpRdOBebvoK0LAiH3fv4OQInVcFhxzy18FmKMO5TlUUdr5xRjAMVsBu0hqj9DKqjdUJSqgecMAY1KXGhh1CUShTxtNjBNhfSInTr5wy7c+RHjLfogc890kutyriRvfhkj32nIjcsSGjj8qXuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787010252; c=relaxed/simple;
	bh=rS2eLQ/pZoqQTdIUho4WhV3MopG0mC9jRBdImYwlnjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i/TkQ5hRkEu18knilZPetqjyWcMCOPX1bdc4MwuBTb7C8ioNvl0Zye+me0MD+anlRy24xaX/Sch3MJSkWJj0dFQJ5OQNNl1LnzPtW2CwI5RobmvYlW/rAwYIqeIKtcfl5jaPufdmCsN9N9y4WQ4rCZiy9L6Ya2wahHyHRXDlr+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fy0dGlCp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy0dGlCp"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caea3f742bso67325605ad.0
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 16:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787010251; x=1787615051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SrOBK5cyf8If+OZjZ5TIA8l88FA3SWI+3OzMrqCIVb4=;
        b=fy0dGlCpAsILQbl3DpXClMicEBAlZahrmFthC0NT4xav8T+4TMcZqVJ1wiAXU1y8HQ
         QErnb/enx+fekZtExLDcCnUTv9pbfOadzWFjDFU3+u9d6/aaOdZ9/T3joQtyu/WBCOG2
         vUTarElqZDjhKaQVPhSR+9xElNhU6RMYNPblLb0pnfKZ8P6394Sb4j18aIE+S9zE+gxk
         dPyW16eP4E5Ea5nVYs58Oicx8uznQfoS0eX0Fr5wGb8DnMGnlaGQ+dQb8zABBuePsJND
         c8nb6c4t/Dk6/YFB7O9+qgKXPeGr6fH/nzOFZsNGK6wJ0eZa3d4Su0P5pX9paR9u0rDf
         aIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787010251; x=1787615051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SrOBK5cyf8If+OZjZ5TIA8l88FA3SWI+3OzMrqCIVb4=;
        b=Xjo8EF/ejgYEb9iH6pPNKLF7CuEpDo57WS8sDr8S+qeNYoBrgjlKEq9735Zvh8MicZ
         f85hy+zxllzIVYmI1JSwFvmlY4DCEE3dR1H37/ZRFKqGYJUiu4GsWmo1SjmuyUMgacCV
         QfP1De2ZWEnz7qKsX5F62ew/Cn5XtVlp5dnxuFNlK6BW8oIjDl7P8U2LxicqBq92Vn9I
         X3IBMPGrNxUTGH/kB17RONVqD2c9tERkKhxvj7k9ph50S8jft3qEPCpwc11pVwQ3OQmy
         mKROs+87oyBTl3YrfARyBsraTGVGgYvpN5X6pgwi9Z6qt95RF4CD62FratTqGd2G/rY/
         Mjtg==
X-Forwarded-Encrypted: i=1; AHgh+RogWT2no6cLRSq7KOxCKDKj3SNVDE1R8ojWLwAWLu9fBpMG3DXJx47l/zpWTZBgA4LZSDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqvGC7aNdjiJ0Wc9of6yQkCb7OL8ohyRCSWHigCTqBGx4xJab5
	5X/Uuwf4erX1Z436KzUvjQ3tFTvUamh7a3N3V9sF/vXuQwT+O8corxI+
X-Gm-Gg: AR+sD10bmjSTuoDxkxz2LsnTzDvaeR+2o0HHGf7/pcbFqULH4KpU29bjeK1YsuX+FEk
	dWD4FdNyb4ItL6MAeq66Y9ooheo7+81sEByxa8WekHqOW0sM0ooCPi9Ra9f8mBf2SjYQUFV482V
	NSjCSYE3b5Gf8WBPc5t98rThMIqRZA8GWkwB4Ml2bL7Zpo9qy73zBIYqoa9K7hj1qLiGCKxdBvo
	TTX47yfuyL0f0hw/N4a3SSOUkM0pKDHVwMZIMFg8ckwlxtE6Vao6cN2xI5vDrD3uOJxtAW/P3yT
	7W/mXk1MU/osyOFYfGNb6RpYdwURAfHeD9v5sxNwsbmZM4lpcZGDFw8GVHBCMx8JVRG9DX/kfob
	b/EDnoys2p1CAiqzGDa4FpfDF5fR4py5TnGp3S0uT/FGbV05Bp3yF979php3mr0TNNA4ng6Nh+8
	AQUBqToQxSioA1Wl4a0o8HHjYUZ8YudKWmHIZpQzx6WnyF8rd6wboZclTUSwQtzXhyaL2501mZg
	mFJYPDm39LlyHWQE7FGlTdIqO4hTj2u6k1sk+mjHitbdoHXs0MYRF0PblHfvj/u
X-Received: by 2002:a17:902:cf07:b0:2d3:2e86:647a with SMTP id d9443c01a7336-2d5c4f07dd0mr47333325ad.5.1787010250571;
        Mon, 17 Aug 2026 16:44:10 -0700 (PDT)
Received: from wirene2.c.googlers.com.com (249.65.83.34.bc.googleusercontent.com. [34.83.65.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb499e81sm11077885ad.1.2026.08.17.16.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 16:44:08 -0700 (PDT)
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
Subject: [kvm-unit-tests PATCH v4] x86: pci: Support unaligned register access in PCI config read/write
Date: Mon, 17 Aug 2026 23:43:28 +0000
Message-ID: <20260817234328.196560-1-yiranirenewang@gmail.com>
X-Mailer: git-send-email 2.55.0.699.gb54405d56f-goog
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
Additionally, add an ASSERT_PCI_CONF1_VALID macro to guard against
illegal accesses that cross DWORD boundaries.

Assisted-by: Gemini:gemini-3.6-flash
Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Irene Wang <yiranirenewang@gmail.com>
---
v3 -> v4:
 - Address comment formatting nits (David)

v2 -> v3:
 - Add comment in PCI_CONF1_ADDRESS explicitly explaining that clearing
   bits [1:0] prevents QEMU from double-offsetting accesses (David)
 - Introduce ASSERT_PCI_CONF1_VALID macro checking that access offset
   + access size do not read/write past 4-byte window (David)

v1 -> v2:
 - Enclose macro parameter `dev` in parentheses in PCI_CONF1_ADDRESS
   (Jim)
 - Add assert((reg & 3) != 3) in pci_config_readw() and
   pci_config_writew() to guard against illegal 16-bit accesses
   crossing DWORD boundaries (Jim)

Link to v3: https://lore.kernel.org/kvm/20260813205742.2752510-2-yiranirenewang@gmail.com/
Link to v2: https://lore.kernel.org/kvm/20260804232344.2976694-2-yiranirenewang@gmail.com/
Link to v1: https://lore.kernel.org/kvm/20260730182053.905335-1-yiranirenewang@gmail.com/
---
 lib/x86/asm/pci.h | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/lib/x86/asm/pci.h b/lib/x86/asm/pci.h
index 03e55c27..622d7fd4 100644
--- a/lib/x86/asm/pci.h
+++ b/lib/x86/asm/pci.h
@@ -9,22 +9,33 @@
 #include "pci.h"
 #include "x86/asm/io.h"
 
-#define PCI_CONF1_ADDRESS(dev, reg)	((0x1 << 31) | (dev << 8) | reg)
+/*
+ * Bits [1:0] offset into data port, not address port. Spec compliant host
+ * bridges ignore them in CONFIG_ADDRESS, but QEMU does not; mask them out here
+ * so QEMU doesn't double-offset the access.
+ */
+#define PCI_CONF1_ADDRESS(dev, reg)	((0x1 << 31) | ((dev) << 8) | ((reg) & ~3))
+
+/* Ensure access offset + size stays within the 4-byte (DWORD) boundary. */
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
@@ -33,19 +44,21 @@ static inline void pci_config_writeb(pcidevaddr_t dev, uint8_t reg,
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
2.55.0.699.gb54405d56f-goog

