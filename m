Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFA3489880
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533994; cv=pass; b=jzN678os4p814fugrv9bFKveTAto2/GM8l3Iu4wlnpmpFakKUF4ozdObP2hdrW3axwDIs2u3PFY+nbspU1vNkGKXYIv06Rhx/2DBRvtbiiW+vGSqIhFs7NQ3QmZ2fJa7qdx85YJTkmzgdO5/vGBJ9GtJDuKmh8KMajuLEALR/+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533994; c=relaxed/simple;
	bh=Lloga5lpU9OxdHg1OoyYp/XQLevv/y9lS1wDVfQ3+3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqG72I7OrQ8jo046oDBsAD3rc1ut2wbNsKfERQzHe5NyC/Pkz85Z5uHKGJfLJhTVIYoklfCOnZ8J97r+GKjIcfTJn0fPHSzYJ7TAJkFNvCYRsGT/grm6U47vVZvK6rFAxnnhKSNtf6e1LWArT6vwVVHF49+5xPVsK3YVXCJVLRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nm471lzl; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nm471lzl"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c1677c91969so185883666b.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 14:39:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785533991; cv=none;
        d=google.com; s=arc-20260327;
        b=JcZA/lE8SBZHe9siOuq62JA2hT6HI5lPid+bDgPc7Fk/aPp969WvXn/84DbquFiYhw
         OX/XQGgAMxK4a7yU1tveePN3VwQ5ncImfd2RKAGU+X9UyalWASVn3zoEJ4FpyhwYGxB0
         zh4Nkwrp1RpcyxRlgl65PaPXIbivnAS9kcfdAVJ0X4twhU//IcW5t9n4/O4ClabqirL8
         CmkvKu0ZdmPkge48XyXl9kMCZojnFynlhrj/Ljles7KDx0LqtZR0t8cTmfr96h2rUQOB
         M4A88hqLLiuzjYopUGybdTX70hIsbMBpcTds/tTXGBqla9ph8YDKSsIRG+YRbvm5+eDq
         wlcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1W9thR5gGow3ZaYxDGEOJVmU5NUyuWi4NTpuzqffuGU=;
        fh=+BlsVl3U5YU1r07jyU6Pk8RLCT239zUEXeIwpLXkAC4=;
        b=eL8obLC6Ncu95O5X6v1O11tcco018s/wbAx6c4btL6lkhi8Kvc2cUYu6LG9rDZK/TJ
         7aC7r8bitrqktWBlw+YT6uJSG59nId+b0KAn4lPDHKO6kNL+vb13FsyVpXnP64qEBA86
         rv7NdjgllSzkMP8QR3LIxwzilyK5QtDZ9PbSYfNAOsJQw0nwxVquqMkuF54VQ97jR+Yc
         1qcvmN7JTRAcydqeSFulyv0MZk0nCsEur9aP4HEkrF2EUSD5+iQ/1OutemFN4NZNGFq3
         EAejN09O1NHmnCJvilSpKgJAsVJ1plJKCVrIoY999Ply7X0on2+CtgZC2jkrs0Ss+OoO
         VGpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785533991; x=1786138791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1W9thR5gGow3ZaYxDGEOJVmU5NUyuWi4NTpuzqffuGU=;
        b=nm471lzlckV4hLaDqnQ/5ev96YnQFeXmFtCB0mhw9FNIR1RbTBggzA+mnnbGwpsLU5
         DThWgv6pV0YjwU8RneTYlVCMRQpnEWaAAIARM9GIUH2YOeHPXU7z1qsvbI8ejRFgRtOF
         ETWkxiK6pcXLuwjOhIInWluY5NGszCpwCQ1ZiB71RT4+xCs9l7d8hF5RZJfSMqJaZ4jP
         1SkIimmkxxmrqC5bx0zSe/wMEBi3NHlsLKeqis5bevALS/8kvR9Fdepd7ePWoFQLjYMk
         FTCONyEvPG2oX1BFHCcXNL7RogxiINnbAdReP1qXP9kutnTmU7Xt6X0pz4MSDpYLhC3X
         joHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785533991; x=1786138791;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1W9thR5gGow3ZaYxDGEOJVmU5NUyuWi4NTpuzqffuGU=;
        b=T2qlcZ/wtOZZcoq8LsoHwYOQdH3mJqMdP4hHd94Uwoeq843Lx4HCSW54lBjM27kPve
         DE1Q7lpsPvf+EeFOxArfotfnyMd5CiORFHk/IxvDPzLPGYaBUdK0pHUsILeIMUHECz6P
         y2K6rhWUBu1L/QO5FExrkIL+pfmJcSMG2/ahpf/xUcH/5mm4orz+CcCQFW82P+2ifF+k
         cmtHFLB1sWGk9d8GeRh8t31obS8lu0/D2cSstnZYbxM4JFxTlXd+3VDVEjVF5dCKMBWw
         Z54rylzkOH2BSyYxvP9oyZnqqSP7Zf4hPUFlEV5N/UfPc/jb/aB2oErGppEIjl/3hpsv
         NYRg==
X-Forwarded-Encrypted: i=1; AHgh+RqIG+GSOAuJGtrHzYXdMvr9sNJhRq1ZC69aC5IixIVwmyStAjJesmc1u4Fh6GQ71IY8O1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8XFMp7ijmwdDJnGAua5c3KJpOJNyDjl79un/wzzJxuDL8uk9/
	DYuAAqHgeeIrD3zWmoVyThTS4KGx7iRfyk9F/CK2J5xPkKd8RdYbh7Ym7bIvtLb0+kKGnzd0t1c
	l9vJobEQOC48F481yW35tZkoC/AwjpXU=
X-Gm-Gg: AR+sD12SrsABhZMqnzkTWOttCHshSSFXlOMSJzCTgYhjXnWBItIWY8no8R/C7L/+qph
	+zSijmAx0d3zj9LJokU1RQd1VydjQUlcI6rM5Ikx9m8Ff8rtkdAGH3PP5JXsnVXOSfmS+TBvkif
	qGPJvwijMMG+wSConC9ms0UG20ej5fcrv/CcVme93XDW4jScnyIqpSDGLIz8evy8q4Kt9/2824b
	CKKyxwupaYl2lVMefyJcOZhzvUo8bgPh/KG8hqrCxK5zW90Jpai4fGD6CZjyqPa7i6+X8IxnBbt
	n2773ilZ1jR3Mp8rtxQzLZZxO+iy8te/Bf5DFcUsDsHGvFL1dAfPpKvqMqHIR1TQmeB+0q9Q1Q=
	=
X-Received: by 2002:a17:907:c05:b0:c16:6669:a4fd with SMTP id
 a640c23a62f3a-c1fe8103ebcmr64649266b.16.1785533990767; Fri, 31 Jul 2026
 14:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730182053.905335-1-yiranirenewang@gmail.com> <CALMp9eSJ__HL3jqaYOEn57cYER7M6NOWvge=CULcHjtqSH6+MQ@mail.gmail.com>
In-Reply-To: <CALMp9eSJ__HL3jqaYOEn57cYER7M6NOWvge=CULcHjtqSH6+MQ@mail.gmail.com>
From: Irene Wang <yiranirenewang@gmail.com>
Date: Fri, 31 Jul 2026 14:39:14 -0700
X-Gm-Features: AUfX_mwPn4UE3TfbS1oL-Zld-bUyX7zYy3Ht5m6MSgEOpJY3L6kF5SU0NN5Og8Y
Message-ID: <CAD26vaTMHGDho-APBMqTpk--JQGZxBnoC8SM6qEErcy-9Oqobg@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH] x86: pci: Support unaligned register
 access in PCI config read/write
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Andrew Jones <andrew.jones@linux.dev>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 1:54=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Thu, Jul 30, 2026 at 11:31=E2=80=AFAM Irene Wang <yiranirenewang@gmail=
.com> wrote:
> >
> > Per the PCI Local Bus Specification (Section 3.2.2.3.2, "Configuration
> > Mechanism #1"), port 0xCF8 (CONFIG_ADDRESS) requires a DWORD-aligned
> > register offset (bits [1:0] =3D 00b), while byte and word offsets withi=
n
> > the DWORD must be selected via data port 0xCFC + (reg & 3).
> >
> > Previously, PCI_CONF1_ADDRESS did not clear bits [1:0], and 8-bit /
> > 16-bit helpers always accessed base port 0xCFC directly. This worked
> > in QEMU because its PCI host bridge emulation preserves unaligned bits
> > in CONFIG_ADDRESS and uses them during CONFIG_DATA accesses. However,
> > in strictly spec-compliant VMMs (and potentially real hardware), bits
> > [1:0] of 0xCF8 are ignored, causing non-aligned reads/writes at port
> > 0xCFC to erroneously target byte 0 of the DWORD. In practice, this
> > causes pci_find_dev() to read the vendor ID twice instead of reading
> > the vendor ID and device ID.
> >
> > Fix this by masking `reg` with `~3` in PCI_CONF1_ADDRESS and adding
> > the `(reg & 3)` offset to the CONFIG_DATA port for 8-bit and 16-bit
> > accessors, ensuring compatibility across QEMU and other VMMs.
> >
> > Assisted-by: Gemini:gemini-3.6-flash
> > Signed-off-by: Irene Wang <yiranirenewang@gmail.com>
> > ---
> >  lib/x86/asm/pci.h | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/x86/asm/pci.h b/lib/x86/asm/pci.h
> > index 03e55c27..09fd2372 100644
> > --- a/lib/x86/asm/pci.h
> > +++ b/lib/x86/asm/pci.h
> > @@ -9,18 +9,18 @@
> >  #include "pci.h"
> >  #include "x86/asm/io.h"
> >
> > -#define PCI_CONF1_ADDRESS(dev, reg)    ((0x1 << 31) | (dev << 8) | reg=
)
> > +#define PCI_CONF1_ADDRESS(dev, reg)    ((0x1 << 31) | (dev << 8) | ((r=
eg) & ~3))
>
> Nit: ((0x1 << 31) | ((dev) << 8) | ((reg) & ~3)) is more future-proof.

Will fix in v2, thanks for the catch!

>
> >  static inline uint8_t pci_config_readb(pcidevaddr_t dev, uint8_t reg)
> >  {
> >      outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
> > -    return inb(0xCFC);
> > +    return inb(0xCFC + (reg & 3));
> >  }
> >
> >  static inline uint16_t pci_config_readw(pcidevaddr_t dev, uint8_t reg)
> >  {
> >      outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
> > -    return inw(0xCFC);
> > +    return inw(0xCFC + (reg & 3));
>
> What happens here if (reg & 3) =3D=3D 3? I don't think inw(0xCFF) is lega=
l.

Yes, you are right that inw(0xCFF) is invalid since it would attempt a 16-b=
it
access spanning 0xCFF and 0xD00, which falls outside the CONFIG_DATA
(0xCFC=E2=80=930xCFF) window and would return corrupted data.

Looking through current kvm-unit-tests, existing usages of 16-bit PCI
accesses use naturally aligned offsets (PCI_VENDOR_ID, PCI_DEVICE_ID,
PCI_COMMAND, PCI_MSI_FLAGS), where `(reg & 3)` is always 0 or 2, so this
condition is currently never triggered.

Since crossing DWORD boundaries is also not spec-compliant (PCI Local
Bus Spec Section 6.1 requires registers to be naturally aligned), I'm
thinking it makes sense to add an assertion here (e.g.,
`assert((reg & 3) !=3D 3)`) to catch any invalid test cases added in the
future. What do you think?

>
> >  }
> >
> >  static inline uint32_t pci_config_readl(pcidevaddr_t dev, uint8_t reg)
> > @@ -33,14 +33,14 @@ static inline void pci_config_writeb(pcidevaddr_t d=
ev, uint8_t reg,
> >                                       uint8_t val)
> >  {
> >      outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
> > -    outb(val, 0xCFC);
> > +    outb(val, 0xCFC + (reg & 3));
> >  }
> >
> >  static inline void pci_config_writew(pcidevaddr_t dev, uint8_t reg,
> >                                       uint16_t val)
> >  {
> >      outl(PCI_CONF1_ADDRESS(dev, reg), 0xCF8);
> > -    outw(val, 0xCFC);
> > +    outw(val, 0xCFC + (reg & 3));
>
> Same as above. I don't think outw(val, 0XCFF) is legal.
>
> >  }
> >
> >  static inline void pci_config_writel(pcidevaddr_t dev, uint8_t reg,
> > --
> > 2.55.0.508.g3f0d502094-goog
> >
> >
