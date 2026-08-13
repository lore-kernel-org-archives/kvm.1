Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB613B6C1C
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786656638; cv=none; b=AIMgZHz81yvrd/VJmWdq1nmwF6TsTQgtWPD6SiparAbAL4XhpZMDQOeSEmUgT36AE6wu6oXh8rxpyEt/zZC++qdK/MRmuyZoWfZYfAcMYqYIYgHIS/IndRTx2r039IqPaGeF/yGlDxAHlgnzdra1OTxxbZvr7p/gW2ohX+WZhVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786656638; c=relaxed/simple;
	bh=nVAxZUkvlVp9dhvAZrx6Ys9jgAnC+0z5dRPztAZgc3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqmKFsWuNvxLgqaQ9GERyeJft4PSR1Yrc7Zg3+ymIMiFTkmCjWNvgOar2PxUf4phdqk//emBRsvj+8RlHImeU61EeC6YPBlUUuTHwVUiq7h4OFh6ojlCLb5jR7ohvyTuPoHbEVIaWXMRYJ3nciCk0Lcrl9zbwDw4qZhkCvwWJFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O0+bVkuN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O0+bVkuN"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cedda2ce6fso3037975ad.1
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 14:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786656626; x=1787261426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dWSuePOKYwlsV5LOPEAbGHpXrrAUcnGt3ey9OMumPFM=;
        b=O0+bVkuN5iDiRGXqBUE92Rn5MM+7Btja9Daw4DV9/HD3ZK3BGIVppaZgA2RmIqoe/q
         1muKtcVfW1OYKpfRrHP3aVUa9jbL336AqSKfZ9XUXFe/pqr39X/VIs/oWlvBxXrUX7/P
         hJqPcYyVHJtZeL2E3IQwhHzvARge2KaTl+2YJcRP2u0TpD/7FvaXduLbqiGjRAYTMc3U
         0fHcg5oB6xZcsfGKvTGh/WcQJIIhY1olXtMtJOX+SrZeeRZr3nvv9ZBVnDSRtx7254rX
         csiqg6X2QvhFHI1zPCdD0OqCX9mDzqFBo4Wo4nRWC/jn//JF5vYRI88isDeiz68TpG88
         hk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786656626; x=1787261426;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dWSuePOKYwlsV5LOPEAbGHpXrrAUcnGt3ey9OMumPFM=;
        b=WxWlgmGZxGU86BAkYedZNnoy1N/zLJX2GkSaXq7nFIVNPJ2D8+qDjx4ui9va5wOGHS
         u7pPRnOVZeqV9OWKVUvVCDT0wOxnJzA6Rvk74oc/xEoCiqQV12s67CM6cvT8o/5+1J/x
         c/QDFwqKp37/bikw2fRG07059lel0BNy/sT1qgVOUKf4TrIX3PjH0USgye5mtVaciOM9
         x9aE7OgILZ3RDOx6C7aoraBIOkVvVnYFDwVHnA/VGWANoIqOJidExRxPWfx25jzN5zuV
         tW61y2xaXV48snPxCrtfTVNoIBH4gLk503l5sUd+fqu5+/CB4MHFb+Vb1lsmL5Sv7W12
         RDRg==
X-Forwarded-Encrypted: i=1; AHgh+RqaVL8hW/DHRPpfpcFjdNgowx267Wyq7MCFZ5dTdGGUTtU2pIHJvXygZM0ZfpNVuGNOIvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK+n4KwXaHsJyYQwLl3hqYBSG7esamZ10wpjh8vLUaNYw8Jm+r
	pW/xsPBqVtwYgI3DDey1iwaDHAesAaLVQSYzazS+Dqg5BZdYhqEPQgfjx5yUxBQ5Pg==
X-Gm-Gg: AR+sD10UG/zncZSFGsXSdHZ9wTmVGiEmo+Z2DnwCXLYxXJNNbteB/iEW0qqnTzWAJny
	1+fko7OOcsPp1pWFIneE1enHC9NgBcdZDFoRqZiPqnxqMp2WVEJ+5SVhIw9vaYuwJ9odxTiFmCz
	Lsiaijv4oaWeLxGpZy0DKU6xPy9Xynz3AeK1efx6wzJwsf5LT94bo+IrTOap4hs7E7fpsC1nrD1
	pG8nEFrpBvcQ15DMxKhBGrJo9gd74HxxAQejGVekdkwAnmIDuRKvXjHi4Ed9OHJi14mQK6kp5/c
	yzVOa0YcuzB35osemaDGfewq0zpSAXyT9am2CpG9anUA2O2GkI+2qJJ26LA/doNtcH29Hfp0j8D
	9qpgxkuxZUGmgM4C5A8QgWV+DPXV7UYZB2a4K/dcgXxN52hFdE2JDgLDdky/a87BuoJsncSWoWF
	5DG13uvIc0p18frOMWPdy3cQuvgMaPmRlmLpj2D5CXOKVOvKZELdrMHu7XLTfhj4KJTHscAKnoJ
	/diEwVSrY4JL5nS7Xi0/Bg+VpwqCA==
X-Received: by 2002:a17:90b:254d:b0:38e:e9b:ffa4 with SMTP id 98e67ed59e1d1-3933b75bc6fmr1028096a91.6.1786656625764;
        Thu, 13 Aug 2026 14:30:25 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931cce323fsm4938361a91.3.2026.08.13.14.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 14:30:25 -0700 (PDT)
Date: Thu, 13 Aug 2026 21:30:22 +0000
From: David Matlack <dmatlack@google.com>
To: Irene Wang <yiranirenewang@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Jones <andrew.jones@linux.dev>,
	Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>, Jim Mattson <jmattson@google.com>
Subject: Re: [kvm-unit-tests PATCH v3] x86: pci: Support unaligned register
 access in PCI config read/write
Message-ID: <an43bksYniPqk8mp@google.com>
References: <anZgkSwhjHDG3dWy@google.com>
 <20260813205742.2752510-2-yiranirenewang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813205742.2752510-2-yiranirenewang@gmail.com>

On 2026-08-13 08:57 PM, Irene Wang wrote:
> Per the PCI Local Bus Specification (Section 3.2.2.3.2, "Configuration
> Mechanism #1"), port 0xCF8 (CONFIG_ADDRESS) requires a DWORD-aligned
> register offset (bits [1:0] = 00b), while byte and word offsets within
> the DWORD must be selected via data port 0xCFC + (reg & 3).
> 
> Previously, PCI_CONF1_ADDRESS did not clear bits [1:0], and 8-bit /
> 16-bit helpers always accessed base port 0xCFC directly. This worked
> in QEMU because its PCI host bridge emulation preserves unaligned bits
> in CONFIG_ADDRESS and uses them during CONFIG_DATA accesses. However,
> in strictly spec-compliant VMMs (and potentially real hardware), bits
> [1:0] of 0xCF8 are ignored, causing non-aligned reads/writes at port
> 0xCFC to erroneously target byte 0 of the DWORD. In practice, this
> causes pci_find_dev() to read the vendor ID twice instead of reading
> the vendor ID and device ID.
> 
> Fix this by masking `reg` with `~3` in PCI_CONF1_ADDRESS and adding
> the `(reg & 3)` offset to the CONFIG_DATA port for 8-bit and 16-bit
> accessors, ensuring compatibility across QEMU and other VMMs. Additionally,
> add an ASSERT_PCI_CONF1_VALID macro to guard against illegal accesses that
> cross DWORD boundaries.
> 
> Assisted-by: Gemini:gemini-3.6-flash
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Irene Wang <yiranirenewang@gmail.com>

Looks good aside from the comment nits.

Reviewed-by: David Matlack <dmatlack@google.com>

> ---
> v2 -> v3:
>  - Add comment in PCI_CONF1_ADDRESS explicitly explaining that clearing
>    bits [1:0] prevents QEMU from double-offsetting accesses (David)
>  - Introduce ASSERT_PCI_CONF1_VALID macro checking that access offset +
>    access size do not read/write past 4-byte window (David)
> 
> Link to v2: https://lore.kernel.org/kvm/20260804232344.2976694-2-yiranirenewang@gmail.com/
> Link to v1: https://lore.kernel.org/kvm/20260730182053.905335-1-yiranirenewang@gmail.com/
> ---
>  lib/x86/asm/pci.h | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/x86/asm/pci.h b/lib/x86/asm/pci.h
> index 03e55c27..144a4459 100644
> --- a/lib/x86/asm/pci.h
> +++ b/lib/x86/asm/pci.h
> @@ -9,22 +9,35 @@
>  #include "pci.h"
>  #include "x86/asm/io.h"
>  
> -#define PCI_CONF1_ADDRESS(dev, reg)	((0x1 << 31) | (dev << 8) | reg)
> +/*
> + * Bits [1:0] offset into data port, not address port. Spec compliant
> + * host bridges ignore them in CONFIG_ADDRESS, but QEMU does not; mask them out
> + * here so QEMU doesn't double-offset the access.
> + */

nit: Wrap at 80 chars.

/*
 * Bits [1:0] offset into data port, not address port. Spec compliant host
 * bridges ignore them in CONFIG_ADDRESS, but QEMU does not; mask them out here
 * so QEMU doesn't double-offset the access.
 */

> +#define PCI_CONF1_ADDRESS(dev, reg)	((0x1 << 31) | ((dev) << 8) | ((reg) & ~3))
> +
> +/*
> + * Ensure access offset + size stays within the 4-byte (DWORD) boundary.
> + */

nit: Use /* ... */ style for one-line comments.

/* Ensure access offset + size stays within the 4-byte (DWORD) boundary. */

> +#define ASSERT_PCI_CONF1_VALID(reg, type) \
> +	assert(((reg) & 3) + sizeof(type) <= 4)
>  
>  static inline uint8_t pci_config_readb(pcidevaddr_t dev, uint8_t reg)
>  {
>      outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
> -    return inb(0xCFC);
> +    return inb(0xCFC + (reg & 3));
>  }
>  
>  static inline uint16_t pci_config_readw(pcidevaddr_t dev, uint8_t reg)
>  {
> +    ASSERT_PCI_CONF1_VALID(reg, uint16_t);
>      outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
> -    return inw(0xCFC);
> +    return inw(0xCFC + (reg & 3));
>  }
>  
>  static inline uint32_t pci_config_readl(pcidevaddr_t dev, uint8_t reg)
>  {
> +    ASSERT_PCI_CONF1_VALID(reg, uint32_t);
>      outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
>      return inl(0xCFC);
>  }
> @@ -33,19 +46,21 @@ static inline void pci_config_writeb(pcidevaddr_t dev, uint8_t reg,
>                                       uint8_t val)
>  {
>      outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
> -    outb(val, 0xCFC);
> +    outb(val, 0xCFC + (reg & 3));
>  }
>  
>  static inline void pci_config_writew(pcidevaddr_t dev, uint8_t reg,
>                                       uint16_t val)
>  {
> +    ASSERT_PCI_CONF1_VALID(reg, uint16_t);
>      outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
> -    outw(val, 0xCFC);
> +    outw(val, 0xCFC + (reg & 3));
>  }
>  
>  static inline void pci_config_writel(pcidevaddr_t dev, uint8_t reg,
>                                       uint32_t val)
>  {
> +    ASSERT_PCI_CONF1_VALID(reg, uint32_t);
>      outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
>      outl(val, 0xCFC);
>  }
> -- 
> 2.55.0.691.gc56d675ccc-goog
> 
