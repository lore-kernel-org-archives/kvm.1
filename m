Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABD912AAF1
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886097; cv=none; b=gEGV2yij/ZE/3ExC+WApI1vPUBgGNeorAKr6rjrr5p0jujxIT0xe4eUHAwvn6IpIQU5PzEE5lxpYVVsAr/XqpHcLd/ld/22vIh+x7/baSZ9hDmC2Cc3CXVUf+fkkdiHxvSBkpOgPZd19Ai6o//njRSmUe2uZ1CsTNhBygRSt3Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886097; c=relaxed/simple;
	bh=bRKWIbhNYdwmAFYmKHvye5PuRCrv87WRltgXxMkhN9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0bMLc0CbB6ezfp0zpZal12C1F8UneG/OhOeSzhUvtGY6/22bHo5HVYGoCd6TmdRSDXI9re2HrRehOBzcTOhdOvYvNjiYHGmkB+5Vj96Xs2iYUgQaA9UlolD0P4oGlx2db5+Dk8Btt9FrFTVsKKIaXhIBpVJCFTGxzCZshljJFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUFzjoU8; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUFzjoU8"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso300674a91.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 16:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785886095; x=1786490895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l1HEt2MlnAKEQcc35vhcOoSq1clh52IV3hDEk9ryVXg=;
        b=HUFzjoU8z2lwgONLhaiKkkYtxTjRTuaoOAcvdB78vpYfVKZhg+Vw+88zUgeO/wwBqb
         QgzeLVEQHFr1EPAVAS6P1XrOkTwiBJ7hN/9v9FuJFViGZCsmvBhF3SxteICheWj50F2q
         /tKPloLgKzULz2rb1ydeKBx1EkzexqMu/HprmA7bP9wMbdhjGIssUxU/Za5qCNO6rhWR
         b+bZuV4DzUchov69JIgZOHnJbbRUieiYXxKL+g2nr4hN6TYur0ikwbQmlRfXlwkkrGix
         W3y4hg8hOI0zNQmBZFIZASobgn2q+RVQSqN+f8cOaE700CkQQcA9DniFN5wtEhVyYWry
         r3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886095; x=1786490895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l1HEt2MlnAKEQcc35vhcOoSq1clh52IV3hDEk9ryVXg=;
        b=QDWaJkj4phKuQQhYBZzSxHXyqIKNFyy/5I0/weiqZ/dWFyzX2tTc0dYuVwha9riVCz
         KEN8S+F2JzFv5EtrbUaAesawdtPZ55JszHU3AYhkUHMpTEDdrhX+MkCtldQW5Knz6qZh
         1kxY0cm/P+Mk+ZAoCyiDGRmQr4UK17HwlMUTe4zG6o29Bn7YLY3GShioCk7ELAY4SSRg
         9a8s1d6ecBYEmEjvAWxLxieDJLiCVzSdi/vLnsA1ymWwDNEKE/Gqh/XLIWH2VPOikrKP
         CBM8S4baPNM9p6JN4l8FNP2nkrzWRqtc1JvpPRqZsxG2gMBduFuScdncsIqxF1SxcTkA
         2joQ==
X-Forwarded-Encrypted: i=1; AHgh+RqkkJ9QHbXilGdh2kjYxvK2+bfAf6WcUGU6qC2IsP1kKEeXXdsf3WpvlNlOu9/5hycyzbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsRN29CR5YGhmjQ1tQRmYjsRheR+IBDsyCXsAG+6u569maeo3v
	GBwM58vZ3kjTL4K9PtK73PI8k9OJQpnOW8UlnIgntL7k201hzw0rPnv5
X-Gm-Gg: AR+sD10ShjyhyfFc736wqNPSPNGnX2hKwfZlXlVNkWUbU2qTeUybtw0KFdZqDLrDltm
	Xim4iVVaHGxDsdVCyUlxWYTTgMpr5ZNmkbEX545uQD1z+vCSTMgq7yUrqW9KLMrO8O30nQnJUUi
	78h9iNmFeQRPkqSZql0Qvvlkc6GnaywlKSvYvWg68VO1OYwlZhZrynDPgllMnbG4I1Kjr6qHdjD
	CyvcZWey0hV24MpnNsrgn7as+2yscRiwcZgX+VFq53a2W+RXgfzVSXrTEj0ubxfeXWzR/18WJqn
	T5TtrOJHjL03mSxvGFjsvK7n+7ClpL7PaWgTkuJO71bR3Pbl0m2GZygNux1gZLRGRmM0wFWaxW+
	j0dvTNOuS/bNYUIO1N+Aea0E9BRpqq9LlLCc2kQuXOo+eQLh7nZVtguu8P8YsUVSDYxbcnmOO3k
	oZcRH1rau2QAMJ9SbWIy+QwbPVT1f0HyA8uMUqUyDezC7hRSFGBh4bmCQ0a8JyWdxfJWaPG7z8q
	v1qEF1+I0Mjj/hMfj8Q9Lxd5Yg5wCMaXmUnN97rv7K4TeDOP8lZ
X-Received: by 2002:a17:90b:524c:b0:38e:5ac1:9517 with SMTP id 98e67ed59e1d1-3903c54b386mr2203679a91.3.1785886095421;
        Tue, 04 Aug 2026 16:28:15 -0700 (PDT)
Received: from wirene2.c.googlers.com.com (249.65.83.34.bc.googleusercontent.com. [34.83.65.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38feda51060sm2302698a91.10.2026.08.04.16.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 16:28:15 -0700 (PDT)
From: Irene Wang <yiranirenewang@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Andrew Jones <andrew.jones@linux.dev>,
	Thomas Huth <thuth@redhat.com>,
	kvm@vger.kernel.org,
	Yosry Ahmed <yosryahmed@google.com>,
	David Matlack <dmatlack@google.com>,
	Jim Mattson <jmattson@google.com>,
	Irene Wang <yiranirenewang@gmail.com>
Subject: [kvm-unit-tests PATCH v2] x86: pci: Support unaligned register access in PCI config read/write
Date: Tue,  4 Aug 2026 23:23:45 +0000
Message-ID: <20260804232344.2976694-2-yiranirenewang@gmail.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
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
assert that 16-bit accesses do not use an offset of 3, as reading/writing a
word across DWORD boundaries (port 0xCFC + 3) is invalid per spec.

Assisted-by: Gemini:gemini-3.6-flash
Signed-off-by: Irene Wang <yiranirenewang@gmail.com>
---
v1 -> v2:
 - Enclose macro parameter `dev` in parentheses in PCI_CONF1_ADDRESS.
 - Add assert((reg & 3) != 3) in pci_config_readw() and pci_config_writew()
   to guard against illegal 16-bit accesses crossing DWORD boundaries.

Link to v1: https://lore.kernel.org/kvm/20260730182053.905335-1-yiranirenewang@gmail.com/

 lib/x86/asm/pci.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/x86/asm/pci.h b/lib/x86/asm/pci.h
index 03e55c27..da0b59a3 100644
--- a/lib/x86/asm/pci.h
+++ b/lib/x86/asm/pci.h
@@ -9,18 +9,19 @@
 #include "pci.h"
 #include "x86/asm/io.h"
 
-#define PCI_CONF1_ADDRESS(dev, reg)	((0x1 << 31) | (dev << 8) | reg)
+#define PCI_CONF1_ADDRESS(dev, reg)	((0x1 << 31) | ((dev) << 8) | ((reg) & ~3))
 
 static inline uint8_t pci_config_readb(pcidevaddr_t dev, uint8_t reg)
 {
     outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
-    return inb(0xCFC);
+    return inb(0xCFC + (reg & 3));
 }
 
 static inline uint16_t pci_config_readw(pcidevaddr_t dev, uint8_t reg)
 {
+    assert((reg & 3) != 3);
     outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
-    return inw(0xCFC);
+    return inw(0xCFC + (reg & 3));
 }
 
 static inline uint32_t pci_config_readl(pcidevaddr_t dev, uint8_t reg)
@@ -33,14 +34,15 @@ static inline void pci_config_writeb(pcidevaddr_t dev, uint8_t reg,
                                      uint8_t val)
 {
     outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
-    outb(val, 0xCFC);
+    outb(val, 0xCFC + (reg & 3));
 }
 
 static inline void pci_config_writew(pcidevaddr_t dev, uint8_t reg,
                                      uint16_t val)
 {
+    assert((reg & 3) != 3);
     outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
-    outw(val, 0xCFC);
+    outw(val, 0xCFC + (reg & 3));
 }
 
 static inline void pci_config_writel(pcidevaddr_t dev, uint8_t reg,
-- 
2.55.0.571.g244d577d93-goog

