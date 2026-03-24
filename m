Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ADB3DB659
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343563; cv=pass; b=kyziDbgIZ9ZQKSbqwq6x+CsR8ZybqSausYIF1/PP0RflQnhkfI6i3aV97bqLQAByC7JGaFlnmo95LdDDWLerCPpPTnnnFAQq0y6sfNws7qSZ+xRebLQDDp9tKI0fVXb7pMLq23jfIAEsN1nNmAiZUFOr9PrULsW4XrnuiOUGe/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343563; c=relaxed/simple;
	bh=po0GgTJdVB9QB9NPjwdcp7bWtiuP/AIBoTKiY3wESRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPkOR7dd82N+xpRvdJ5eMbMAwfFnSCvNWcA8u8siOz7kUP4oY4Te+2o2AtkwSzk6VJvKcOW3dxun0itl55FAhk297YuaG8SXygOR01wpxOuCmqqQcwbI+HUTtAg9fUbgWcR32azkyzhrn4kLatoIxX44IxqhgogSfh6nm8Yrv8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=deLwcftR; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="deLwcftR"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40ef10ec84cso843536fac.2
        for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 02:12:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774343558; cv=none;
        d=google.com; s=arc-20240605;
        b=DWQkOY5VAy6GgBaeXwpYvIKiNdODbMU6mv48J7kQ4a9WaUvydpmpeeAhZ+jxcCXKbM
         Rf5hpC3EzCyfMQH3aJlEcPXol6RiER/S4+tW7VRJTC1ppQ5nOa3V1TroNrYQefrepSmK
         VacJrJ1rkfvbqu4xoyqjo5DfZUyg3sKjYs9hquCUK/uFMVdUY3oq6OanNIQeW+Rp5Er4
         2oX1b7CuY8ltEFGWHmCawt4Ei3VIutytLe+Om8KOa2Npv0t/QZluR/8w23BvnIVnjAVL
         4wjXlIv9L/i+O+kzaLFOXrbvydUKaIvLVgJ45c1+tiUnQh+t16XFpGthbgtx8sQUOsci
         1SCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=po0GgTJdVB9QB9NPjwdcp7bWtiuP/AIBoTKiY3wESRA=;
        fh=uZRch6AQCKxXvGVVqA0sHaA+4HlQ4LwW1RggHCtft5A=;
        b=Ol/zmFEIxXXDx/0/z6azWuxu6Y9e6MkwiLgmwkAhhKw4FJjQQDgmEIdNHjQtpVW/j1
         7zZfkP/FGDaGEwBZpgJPHVjKNImgxim6TRBiWnME8odboC2LR0aAJKkb9/EPLni/yQEd
         Q0JxSptR7ErqSl5mSZUbOT1PtdMGYJfWn6qNncWEsler6qo5o/04hgdZcGfUJLtefXbM
         mG6TRoEH8iOj+3kt1pyoTxQRHpgMLlqgtiog5TO48QjApT6o5V+ZxLyekAQYfuZBNVqa
         h6/93abiapx/A91GwR5g373O3V56bKo60E8YxSr23TtwhG+g9XjLKCkhKXQYjR91DXpV
         EhCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1774343558; x=1774948358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=po0GgTJdVB9QB9NPjwdcp7bWtiuP/AIBoTKiY3wESRA=;
        b=deLwcftR7BRZth6C1LXkiDy0diFVbAoSWGhIEPTzN+jAJww7sMvwdDjfI04ZE34o6I
         726VWzARKpPm7byz1evCSdl3QawZdERraIZ04P1ItlvZ0p1bdudnA9AO2CBAs9QnNDu9
         lmaEY2qgQpqHkZUdCkYrdco2xcpuDaW1liOwdsS9GW15lM4d/s57GM1d3w9wb2mATpnG
         v88FY7JVp2p9+PJBQW2xeFAiChXYz9McuGBEOYX5B6ZSaNYscAnXrFpaR5zgif/u6H1s
         yrFtU9W/cCNCG+CHPl+IHUb05ib84DCtu3vHTJXPYsvS0v6TI+AalFdAGCXOjitnl05P
         SlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774343558; x=1774948358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=po0GgTJdVB9QB9NPjwdcp7bWtiuP/AIBoTKiY3wESRA=;
        b=JKV2WR03m4JW6Oz3oWolnx8s2NVhEnH8Cbhl5vPix0N1DFc3+pCzx28ioYXGxBsbUg
         d3Q2KqxEpLmH5PtAfv5I3CDD28jJjKT/ONvI1x0RwWDDk9NPTs2/3yFrSOfTUC1TVVNs
         0WbExu0bM9VlKtpzJSb6AkjMgfsX5aQt4wdq27Q/qfRIHkaBTHktE217RemW3Vrtith6
         gikVDKSJvBo0SfteG9h+vfr0YXu3Jak2I5Olzfcm02nqll6nPmpMXLxh/DznrT1h/Hx4
         Z8mJxWQYicrjrtywneAvadYWL7Yk6qTlxYKwkbI8vBifcr7l3xCtVt2Q2ahkFD2Gu+te
         lqHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQNFwdKRNG8we1lMwh9K1HWBou+NDRikFY9wvZsiBK2s/Arr+yomEPyU2XxgLWi+7K2V0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7oRmJ/ej6kfNJR/bbjkEct/DlAaYCdMaT99SagGT5lNLt+c9o
	d/3XG2+cYxs/YubP2Oly3EzMkMP4nsWywAybgfFU7pe1Cy1hiudbkfOY7mzTwCdV+zjCrtqDwoP
	DHZ5x7tlScyRzaB4j7iOfTBdWBqaePVq38ML5nPw8Ng==
X-Gm-Gg: ATEYQzz2XfRBDxvENzQvofPSFPUltl0coJhdGV/WyCQO3f7tH8gJyr8WSwJOBCyfXPX
	wBjDYeFJjrnK2IILrng9ExEqMEXyOsdf5fxRATpHXFD9ERNVP1AEx+Jqxwsf6lgDhJaTintsa98
	MuWF88xVEctbCCd2V2nSVYxkM5h88mA0xfu1KYYwn2vHs4Ny3W/MO/+hkNbrvOmlgGdfaPxLwaH
	cq7wiKJuCL8H4SkeyF4A5RIqFHwQiVnkNKcQvzrmt3+axoauga1dtib6e1sSlD1MJmBSEW7iroR
	0j0CSMO7lQ==
X-Received: by 2002:a05:6870:e8d:b0:404:1250:1c1f with SMTP id
 586e51a60fabf-41c10f8df08mr9671520fac.5.1774343557584; Tue, 24 Mar 2026
 02:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920203851.2205115-28-ajones@ventanamicro.com>
 <20250922184336.GD1391379@nvidia.com> <20250922-50372a07397db3155fec49c9@orel>
 <20250922235651.GG1391379@nvidia.com> <87ecrx4guz.ffs@tglx>
 <20250923140646.GM1391379@nvidia.com> <20250923-b85e3309c54eaff1cdfddcf9@orel>
 <20250923152702.GB2608121@nvidia.com> <20250923-e459316700c55d661c060b08@orel>
 <20250923162302.GC2608121@nvidia.com> <20250923-b2caf55f4f87f05aaa619e0b@orel>
In-Reply-To: <20250923-b2caf55f4f87f05aaa619e0b@orel>
From: Vincent Chen <vincent.chen@sifive.com>
Date: Tue, 24 Mar 2026 17:12:26 +0800
X-Gm-Features: AaiRm51YfU_yNPx_PEn26PHbdMYezrFLe21xvA7oPwXPoXNN6d2xjsb4N-4LCyk
Message-ID: <CABvJ_xjnVJjV2GnYr=1WuXqo9VivNXniq8BJ39LQNwaT6vUiQQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/18] iommu/riscv: Use MSI table to enable IMSIC access
To: Andrew Jones <andrew.jones@oss.qualcomm.com>, Andrew Jones <ajones@ventanamicro.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>, iommu@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	zong.li@sifive.com, tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, anup@brainfault.org, atish.patra@linux.dev, 
	alex.williamson@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	alex@ghiti.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 12:34=E2=80=AFAM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> On Tue, Sep 23, 2025 at 01:23:02PM -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 23, 2025 at 10:50:56AM -0500, Andrew Jones wrote:
> > > Yes, this is the part that I'd like to lean on you for, since I under=
stand
> > > we want to avoid too much KVM/virt special casing for VFIO/IOMMUFD. I=
 was
> > > thinking that if I bit the bullet and implemented nested support than=
 when
> > > nesting was selected it would be apparent we're in virt context. Howe=
ver,
> > > I was hoping to pull together a solution that works with current QEMU=
 and
> > > VFIO too.
> >
> > You probably do have to make nested part of this, but I don't have a
> > clear picture how you'd tie all the parts together through the nested
> > API..
> >
> > Somehow you have to load a msiptp that is effectively linked to the
> > KVM reliably into the DC for the iommufd controlled devices that are
> > linked to that KVM. Then synchronize with VFIO that this is done and
> > it can setup KVM only interrupts somehow. This kvm entanglement is the
> > "virt" you have mentioned many times.
>
> Yes, the VFIO+KVM irqbypass framework currently provides much of this
> support (which patches 10-17 of this series leverage). But, if using
> nested is necessary in order to "signal" to the relevant subsystems that
> the device's irqs will truly be isolated, then I'll need to start figurin=
g
> out how iommufd can fit into the mix (or if we'll need an iommufd-specifi=
c
> implementation for a new mix).
>

Hi Andrew and Jason,

I just noticed this thread, so apologies if I missed any prior context
or if this has already been discussed.

If I understand correctly, the current discussion revolves around
using nested translation to identify a safe "Virt Context" for VFIO,
largely because the base RISC-V IOMMU/IMSIC doesn't validate MSI data,
leaving non-virt cases vulnerable to MSI spoofing.

I'd like to share an alternative idea and see if it might be a viable
direction for this scenario.

As Andrew mentioned, sharing the same IMSIC file without data
validation makes it difficult to prevent spoofing. However, what if we
consider utilizing the MRIF (Message Request Interface File) feature
for VFIO passthrough devices?

While MRIF is primarily designed to extend the number of guest IMSICs,
the specification doesn't seem to limit its usage strictly to the Virt
Context. If we assign a dedicated MRIF to a passthrough device (even
for non-virt/userspace cases), the device would only be able to send
MSIs to its own isolated MRIF via the IOMMU MSI table.

In this setup, the actual interrupt delivered to the physical CPU
would be the Notice MSI generated by the IOMMU hardware itself. Since
the address and data of this Notice MSI are strictly configured by the
Host OS, the device wouldn't be able to spoof MSIs to the Host or
other devices.

If my understanding is correct, this approach might naturally provide
the isolation needed for IRQ_DOMAIN_FLAG_ISOLATED_MSI across both virt
and non-virt contexts, potentially simplifying the need for KVM/VFIO
special casing.

I wonder if this approach would be acceptable, or if there are any
hardware/software constraints I might have overlooked?

> >
> > The direct injection interrupt path is already quite a confusing
> > thing..
>
> No argument there :-)
>
> Thanks,
> drew
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
