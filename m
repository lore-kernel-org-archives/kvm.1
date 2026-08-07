Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A952F30
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142872; cv=none; b=rQxqGQt7OOpLwpqbqbSs5jjroFV03eetvJhVta8abWEYgLExQ23lzPjhYLVssTXcBIeepWoXYy3gobY4xhI4415Vhc+5Z7kSGevrfOKo9r1qihDi53+buxOkIyYf+gMP61JYH9QzUt5iQ6nrqzn14FHILFfQMgXNSmBwuxnw9+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142872; c=relaxed/simple;
	bh=LclLPhGt30t9ZVCFvT/xBl1im3zGIFqwjLIwgoDPi10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ik6lo9gvOeF0chTiGAwSm5YD9Y2fEmEM0LUmDQZnprHyMIRP7pKqnWBkawIqTYpAjWUykbloBLPYTWySUrtzWXBp+hdurnAFBsuNrjJy8Y8B+xNavPtBJMNf5Nk2ZUvFjLI6f+XeemdJTP4hgiCJE05Drccna3Ly6SJ/2oTJ6DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rJolN3C2; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rJolN3C2"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-381b831d535so95213a91.0
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 15:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786142870; x=1786747670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c5pvQbC5/OCZ694tbRRS1Pawgp+evfJsZVleX3urR/8=;
        b=rJolN3C2PL6EcHLLCnM1NgaIw49s5jniADdzXCvEcFzaEcdN1sifHsjzbl1oeoZVJx
         Kt1O+1X8zoBQ4ATds8loki5HzUHM46OAei/jc3qCLjekMLSU2Kx9ZAhrl1OQ8hCzbyHh
         meje6T56HfL85IyMUhArAje3dfAR3ZAHXH4UaKXb1HKCHqMUHXJVabu3mdoApfPwOdCv
         u2wqNeo5wL9dkwcEYbuJxgQ6olIpcL8AHh3y0LX69Ik5YqCMHvZDH9hAKQ7YypTQZ9q8
         m95wui/Q6iwQosRpORJjEsAfjvfOf5MYk6TtzFNj4cb0Cma7yyrcaDLsiBtZSMuqy7QF
         cT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786142870; x=1786747670;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c5pvQbC5/OCZ694tbRRS1Pawgp+evfJsZVleX3urR/8=;
        b=kyqOZiO7i2Hkcob/iYiNvCsCdZ3cSI2Wrbm/HyBFP8AGjonBZrkI5HmK3iU6dFO/ZO
         9e5EUAI2YLhOjfSJLz0lTutOEJHAphytDqe2LjZVv4XLkYEHnST3+j65agdt/oLP1j+G
         jZGLjUSJZCD6ABbi82n+RrMStJvD7KIstmTktAInbaM+ESfc5qfrzXpF25mDjLb1MFbu
         uWMaG+9u8/UGtFXZVa5dw43wO0cu/GOGfvmrmSpg0ywECHUhfpEG94FhHWNTLkJWSZCk
         fTCHM+62MIW30md+ztVvJw+Tq+edm/UYSx1Wgyrwob2e4E37qtu7Bzl32MNtEtWGyhUb
         l+9Q==
X-Forwarded-Encrypted: i=1; AHgh+RrxUlf7fnrLti3Nmn9p4e8jb1HAta/Bc1+6Eqwn4pC5nCENmGLk40una0qohuxHvo+H8no=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwbpWF1mXriRV+1HIa+nWm3S+a3fD/Jv/MxfcIsclutcZEBsmx
	yFYE62xTggz3hSpCTAU9amlv8OaN8VSJFyLQ5nAGTsKVa5KGkPr2yqVMibBhsEDFWg==
X-Gm-Gg: AR+sD10P5FJlAEVfV0bV8SLPU/KU2WcleLPYM7pnecBU2+KtMEHvAXm3dbiT+0y54wI
	GpLDs+SZRX1JcE7i03/Dehr67+DH0WXnSTuEqt/1TH6lbm/09MfdSxRT1napiXh8E77ngq2f6mq
	atGyLQ9hHxdTdMZVvfs/QAQON061JhiMHuooKM2x1r+EbCZoxU0vp+Eudi8Vb3t1OzFCI9NQ+ke
	SCCAS/s3qbnDHDGzVJw33rjlK7CQkJdUuMHmIa7DDJEIw0IqXOgYAkL8P2KPXJROQo2pmIjorxD
	q5JZVEXyaynzhPFYHn8sz2YmVy+jploN3YWKFv3yaA+/DuoUovEEfA+NpN29TfN5moXUEFZdKrV
	1RvDL6/ma/HxArqw14yAkbrZRrjyBrdXdq62Dz68P5b8447Yfn9MO+Y6nUWepglRzfKk9voRyKt
	kcmpp+b9MVVV7SazBYYJ7JIu6DXvVWj/pZjYh66g0hU0eXIGIMzvkRyBMyKT43fDbiMKI+65NlF
	0AqlsJsoS4/Qwe3KOJCycnC5b+Olg==
X-Received: by 2002:a17:90b:2dc7:b0:380:fead:448d with SMTP id 98e67ed59e1d1-392620e6e25mr8243554a91.13.1786142869650;
        Fri, 07 Aug 2026 15:47:49 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3908616d21esm6713754a91.17.2026.08.07.15.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 15:47:49 -0700 (PDT)
Date: Fri, 7 Aug 2026 22:47:45 +0000
From: David Matlack <dmatlack@google.com>
To: Irene Wang <yiranirenewang@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Jones <andrew.jones@linux.dev>,
	Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
	Yosry Ahmed <yosryahmed@google.com>,
	Jim Mattson <jmattson@google.com>
Subject: Re: [kvm-unit-tests PATCH v2] x86: pci: Support unaligned register
 access in PCI config read/write
Message-ID: <anZgkSwhjHDG3dWy@google.com>
References: <20260804232344.2976694-2-yiranirenewang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804232344.2976694-2-yiranirenewang@gmail.com>

On 2026-08-04 11:23 PM, Irene Wang wrote:
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
> assert that 16-bit accesses do not use an offset of 3, as reading/writing a
> word across DWORD boundaries (port 0xCFC + 3) is invalid per spec.
> 
> Assisted-by: Gemini:gemini-3.6-flash
> Signed-off-by: Irene Wang <yiranirenewang@gmail.com>
> ---
> v1 -> v2:
>  - Enclose macro parameter `dev` in parentheses in PCI_CONF1_ADDRESS.
>  - Add assert((reg & 3) != 3) in pci_config_readw() and pci_config_writew()
>    to guard against illegal 16-bit accesses crossing DWORD boundaries.
> 
> Link to v1: https://lore.kernel.org/kvm/20260730182053.905335-1-yiranirenewang@gmail.com/
> 
>  lib/x86/asm/pci.h | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/x86/asm/pci.h b/lib/x86/asm/pci.h
> index 03e55c27..da0b59a3 100644
> --- a/lib/x86/asm/pci.h
> +++ b/lib/x86/asm/pci.h
> @@ -9,18 +9,19 @@
>  #include "pci.h"
>  #include "x86/asm/io.h"
>  
> -#define PCI_CONF1_ADDRESS(dev, reg)	((0x1 << 31) | (dev << 8) | reg)
> +#define PCI_CONF1_ADDRESS(dev, reg)	((0x1 << 31) | ((dev) << 8) | ((reg) & ~3))

A comment here would be useful. Spec-compliant host bridges (including
emulations) should ignore the lower 2 bits so clearing it should
technically be unnecessary. The reason we have to clear it is because
QEMU is not spec-compliant and will consume those 2 bits.

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
> +    assert((reg & 3) != 3);
>      outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
> -    return inw(0xCFC);
> +    return inw(0xCFC + (reg & 3));
>  }
>  
>  static inline uint32_t pci_config_readl(pcidevaddr_t dev, uint8_t reg)
> @@ -33,14 +34,15 @@ static inline void pci_config_writeb(pcidevaddr_t dev, uint8_t reg,
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
> +    assert((reg & 3) != 3);

Should assert((reg & 3) == 0) be added to the readl/writel routines as
well?

>      outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
> -    outw(val, 0xCFC);
> +    outw(val, 0xCFC + (reg & 3));
>  }
>  
>  static inline void pci_config_writel(pcidevaddr_t dev, uint8_t reg,
> -- 
> 2.55.0.571.g244d577d93-goog
> 
