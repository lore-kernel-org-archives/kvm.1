Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEB13AEB26
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785444850; cv=pass; b=P3oYmoHbOtzV/qyMQt3+pCtgHIiqdCXl0Ezt1pPgqnYqQqwv9VPnOiRzTBI01WtyjGURrsWit6l6I47tD6jHEmmVBfaaShBc9vIznCdKXsPKiu/yCbdWTFb5g4XZaIVOerpRUWb0mzlJ9N+254sqj7tzEM/4E5VgQwChVWNIxS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785444850; c=relaxed/simple;
	bh=8Sy6N/FPMWyV68WdC4FpVq8IfaF9RIqsw3m25K2J0lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwY7AcQoXkXGNJ7n5DwHkmM3E5qth+IZMg0X66UsQ8LxeI+TciswP+OwFzWvz1sMG4Oi/Q+c1aOzb1CGHKOqGluPUm7GNYsM3AKaXY2n8XVjgRdIXRNqiJJ+ttDZyklcTUwy+RTnIdpskYtI2PGolfBaTbAbTODfcSD+5x+ECbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=os+EKOZR; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="os+EKOZR"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so1030a12.1
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 13:54:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785444847; cv=none;
        d=google.com; s=arc-20260327;
        b=Z8Wk2BCpk5SqJao3CLA4w/plKpGbPF2j8xJznnDPDbltFO+w4FDkBMSDCIQWANxIj8
         RF9PmywTdXYO4F9MPVjSgFkwDriOK7Puf/a7V4fO5qnLKY0x/M5RiCpAce91eSV7t0/M
         J50CIVcTYgF8w+MH0xySa4SHVn5mxyp4zzImfd1jMa+13CHncrjLGSefEYz7n3Hlw2Y2
         3fDagg6Y2hUuIGCWUACCJAX4p8zHawlRKO/B5y7As1M5k+ZS9BmZzCoH6Yz+Qj/x4hZx
         2uqNMGlbfRIbFye65EJ9ohj+4zlan6uCxjH2r3erDXohqAB8LyuNYNaT4aUEVM99bQ9V
         Avgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dd1rWgTdokLZNBjdKW0vxlxfqezHLCpaEhueuQxAFxY=;
        fh=SSW8VhxvxHDTXLhFtBTgEHo2Py/mYybSvLpfWEYV+FI=;
        b=dGRKJnptIrZ5G/B+36UkDFfdO6XWST1dhbHEHSOc1Ti6lWOof4M27WahD2sbUSH0/v
         W0y70YinvwNK1WuMnwCMvt0gDdVORinunYDgoWPFRd5+PFDP/gHWWDoAIY+1a02BVmV9
         vd+jJjCurcDndw/E8q4pvqa9lEo1oU8Kwqdyys6xMoAKFrYIB8HPMcJMUR3Mia1gjYPP
         wUHvzbblPLZ1jLtTpy7pINhJ3dJlycI1/nxcjOpG+i7L4JR8N5UT998d8aZeWjhfgk4L
         qxlaXV6P0OuXLDLBYq9cqrm8zCa1IUaZpksKzXC07EAPnZ+JQVoQtkvwpZUjpTJgUK9Q
         X5ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785444847; x=1786049647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dd1rWgTdokLZNBjdKW0vxlxfqezHLCpaEhueuQxAFxY=;
        b=os+EKOZRlChP9jWazaZ4NXbtncBpa8NSbVISdW386GgISolF0LzKXZpr6aUjCQCVz2
         H610DnkAQPK0Ld0cyVsCbec9pVdA6GQp055h4vv760xATBlkDj5o7NGdosUNNqLOPRZ6
         dpopLFx5HxAsFvuym6Lnm0EofWgxGbQPG+8IqT6c8PdneZz0X1mCyZCTE71tAyJaqKPV
         NtfMZ6Lh/a/fbtQNFFIyIXjpr+SzNCPqm6EFgqyc2iTYpQgIDdasxdeiJ/alYVzSU9vJ
         W4k9u88I3c9Tk3lxIN/vhxG6JDgcv0YJtBnEGVI3btW4NBeD0u7Hy/SoTzk2FUUUv9+5
         T1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785444847; x=1786049647;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dd1rWgTdokLZNBjdKW0vxlxfqezHLCpaEhueuQxAFxY=;
        b=Vc8yD/dCSV5fVpRbaGEJXTrN2Adk66k3CdMAf7uUSBH4CWtbRpXFhLF4nnbrBbJuTU
         xUms9dOfCkiUGLk0xWRt+sovtsgGl7zfwDku3tp/yvKVPT3iJVa5ZQqRvItA6w3xugqB
         DDDzT2sswD/xVc/yRShTXB3bAogKWycHd7BV2HPB0vGitseLVysH5iU3qcbbw7WPiUeI
         f4m8PPLDLGOZDxWDoZaB0jJs/DTZqjypkkcmhWxhQNpBBiwe0xdOLBgQzYDPVtqixtiP
         MFl9nVHjxN/GzsfMdaRMXJ5qEMVJO20Zk+AhsWA2hWMpA53ljgqTmddINfjoekfNd2Fn
         y5ww==
X-Forwarded-Encrypted: i=1; AHgh+Rp7W3bvRwecsVoMvbIv8v0kfR8VSgtQfwI4qrzgJNgoX/Qb2YS/rcWlRTodrFRgtYodsRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YztLnP0EeBMX+PzL21O/FDA2PZyY0/sA6isF3UU+ZMBV2dhN/Fc
	Cg3xroMN/bJtP7o9b+TjCVF1L45Z1U5fpU3H6kxQODjTA8SZvg+v5yunqHeuYVM1EK2wm3Ij4EU
	aHgsJiIay+/KFeuyXQy3vK4ZRsotYU1t18sMMfrtW
X-Gm-Gg: AR+sD119KA7U1M61q7ITuSBYSIvfXzWFQsbvggydkkCjItJFFvxMXWWmuGEileqvTgl
	51OtVk7b4PbiLcxmwTp/fmBEi7bNEQSS+BjjboXYpEtua9mMEgfBooSLtI1xeDLNTJKhvv/aOxz
	oyfHHTgoy3u0SPOoaAhGKD5YRGBmjpxebz31Lv1LMHJ2Czlj19jSZNRVeG8A+EUbIOhrwWQXjmP
	jc7YMuZ9TX04ooMBDBRdIKPun40JQsQTasiZuW4pa0s3HCZwoh7a8ejcYXy1F346XRV2GJcQL3M
	3yMSWG6wcqHjpYVXSgCrIBV/0+M7G1t5rzkSuP47OghSxvNKHpms00zAGaYh3d3CGZ4=
X-Received: by 2002:aa7:d498:0:b0:6a0:11d7:ada3 with SMTP id
 4fb4d7f45d1cf-6a09636b0f0mr3795a12.5.1785444846230; Thu, 30 Jul 2026 13:54:06
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730182053.905335-1-yiranirenewang@gmail.com>
In-Reply-To: <20260730182053.905335-1-yiranirenewang@gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 30 Jul 2026 13:53:53 -0700
X-Gm-Features: AUfX_mxgXEY5UuXJ0qadWpqPq8gsH-tAqJG6sLeqmOeDEf76KQLr4Q91m2V_Iz0
Message-ID: <CALMp9eSJ__HL3jqaYOEn57cYER7M6NOWvge=CULcHjtqSH6+MQ@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH] x86: pci: Support unaligned register
 access in PCI config read/write
To: Irene Wang <yiranirenewang@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Andrew Jones <andrew.jones@linux.dev>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 11:31=E2=80=AFAM Irene Wang <yiranirenewang@gmail.c=
om> wrote:
>
> Per the PCI Local Bus Specification (Section 3.2.2.3.2, "Configuration
> Mechanism #1"), port 0xCF8 (CONFIG_ADDRESS) requires a DWORD-aligned
> register offset (bits [1:0] =3D 00b), while byte and word offsets within
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
> accessors, ensuring compatibility across QEMU and other VMMs.
>
> Assisted-by: Gemini:gemini-3.6-flash
> Signed-off-by: Irene Wang <yiranirenewang@gmail.com>
> ---
>  lib/x86/asm/pci.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/lib/x86/asm/pci.h b/lib/x86/asm/pci.h
> index 03e55c27..09fd2372 100644
> --- a/lib/x86/asm/pci.h
> +++ b/lib/x86/asm/pci.h
> @@ -9,18 +9,18 @@
>  #include "pci.h"
>  #include "x86/asm/io.h"
>
> -#define PCI_CONF1_ADDRESS(dev, reg)    ((0x1 << 31) | (dev << 8) | reg)
> +#define PCI_CONF1_ADDRESS(dev, reg)    ((0x1 << 31) | (dev << 8) | ((reg=
) & ~3))

Nit: ((0x1 << 31) | ((dev) << 8) | ((reg) & ~3)) is more future-proof.

>  static inline uint8_t pci_config_readb(pcidevaddr_t dev, uint8_t reg)
>  {
>      outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
> -    return inb(0xCFC);
> +    return inb(0xCFC + (reg & 3));
>  }
>
>  static inline uint16_t pci_config_readw(pcidevaddr_t dev, uint8_t reg)
>  {
>      outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
> -    return inw(0xCFC);
> +    return inw(0xCFC + (reg & 3));

What happens here if (reg & 3) =3D=3D 3? I don't think inw(0xCFF) is legal.

>  }
>
>  static inline uint32_t pci_config_readl(pcidevaddr_t dev, uint8_t reg)
> @@ -33,14 +33,14 @@ static inline void pci_config_writeb(pcidevaddr_t dev=
, uint8_t reg,
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
>      outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
> -    outw(val, 0xCFC);
> +    outw(val, 0xCFC + (reg & 3));

Same as above. I don't think outw(val, 0XCFF) is legal.

>  }
>
>  static inline void pci_config_writel(pcidevaddr_t dev, uint8_t reg,
> --
> 2.55.0.508.g3f0d502094-goog
>
>
