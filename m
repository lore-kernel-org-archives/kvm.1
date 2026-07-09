Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080572AEF5
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637318; cv=pass; b=uWCxJLQu8fCy9hUBpFep34X6b5JlQAI3bRXDYJhCKc+hKNv+A/Iulg1cEyZ2W45cw7uK5Y/f4GztW7kON4i9cPdf/8gZj2L6t8KNUiGnMd0vMwYRvwwodXuH2g5TA3KrxNcr1OmXfKl8reck4wnfGea/KQqWj3VP5KdHsdy7OQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637318; c=relaxed/simple;
	bh=zRp/I/8neDSIoOEJkaMLrRzcN+q40Ef5gSFoTmd5P60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfKC7pfmrNJAoGFd8P1bMb8RJFEIowDS5QSznBwAaWV7jIyLTRbQLsbQxxNO5t/pZXPewJJ7hLVTxrMEkUeOlrwIb25y1966TYqdaiKotkdmpV0AAFaT0V6bO7wQj1i4nyaqf9B44StPRybAF8Z4WXb74pWZ6oNkPG/ehNHmUh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UbXUEOGT; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UbXUEOGT"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b0129cf6ffso2929e87.0
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 15:48:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783637315; cv=none;
        d=google.com; s=arc-20260327;
        b=iOo6qLKGNvKEcxUymVACwWSbH93GN2DVAvJHbpUzt4xKBpajofZpfeLICeKxozYAtw
         M3A8o1LP4gl/ukGI2n7EGZSKYMFhFedJphDCaNwd6EqfDgvBHlQe698S1o7QN3S0u0nj
         lbnuL3vdhWa5ZCEjCXdJgkeOzTbWOuD4QFXP0NJTlzDhU6ovjDSca+Kh46qLC08df9YV
         b2X5fDlz9fTBno7Omdr4VbSShgGgfV2yyyJ3d/1dUKvIpVWfDJjh4mrQjWOSaGGQW4/Y
         qsNnDyh3aeuKC2niS6A7cm8S+9nJALnadLQ1MY3BOd9AKFNiDj5Jc7AzvMs8OD9Fcm1N
         uWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SY7xyhWtcEw02NKdEe3OAZxo7Ixy9y453ZhOAn8j2lo=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=BhE9fIIevCjY/Jx8rxkY1BfnCJ6EBTpmRBaWUg5qxRD+JaWKS80nNQaH/FjsY7Oag9
         BgMsPFZwVH/Z862WfeVF54+k1nda5k7s8fVTgOGTyqbfmUdoO/576336i8V2T0TFGfAc
         4YCYghRQE/RbwPcNgF+Lbu6Yh6u//bEkof8p8dXajZgeKq/aPWrSMSaRwaoHGZB9wg5i
         9aIt7qJtHE9yQC0JyZGB58P84B0BvFO2nPyLWSE2wdvVSe5vEVUdhWb0C+MQeQM109ER
         IKI+3Qf5H8sf9/qRuC92CX5sWl5H5i6yhTUqS8/V3RL2IbI2l/f631sdjubJNhz4ma3y
         ymlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783637315; x=1784242115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SY7xyhWtcEw02NKdEe3OAZxo7Ixy9y453ZhOAn8j2lo=;
        b=UbXUEOGTEGc19rBr3HAjBhtIJ6Pt/C9Utv0MSnuLx8TBkM+nZmlXnrR2+S3u8MnX/E
         VHnrz8AI8JKSqLlw36gfB46X12ruCu2q6aUXMiRC79T3IobwV/+RuIQm5y6e3MpdKkVx
         quj2KojjrAcUeQcd2PL+DYWXiDzfY+toH4MNeQTOSQ21kLVSchBFddoTLuCmBYuSjcsw
         ojZFuZJv8/8dIcoSUHRsyw76fJT/FNX42WlaNl2xS6ZbI05GeRTDq6qGjk2j4W3KFpgY
         pSv52pOZeljeoptgQZaMsRYI21nlp9c02HotJGvIgOJXhe1lxabRzYjIyW3wiWhyAa4Q
         TOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783637315; x=1784242115;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SY7xyhWtcEw02NKdEe3OAZxo7Ixy9y453ZhOAn8j2lo=;
        b=sVth4AJGkGxRngM5piz9apkVfRGRDShJArwxEwuIGcfpTX7HCqCeT4HelKUwyO3Pf4
         CI3/jFSfyIrD4cvdWeckBS1YFd07seZSyOi8m8E5fmmGKkK31gCPwMFyAfBaEkPpb8vg
         FYWv5b54oiv+ELebFsRXjaJzZ2LRS8JV7BdQ6eokhbaK4LVQd55OrFscu+3h1Rw/oPnk
         a/AZvNgXDXTnHIf6J0+I66F0tKjTgeyjCqQ3ttF3BSV7K1+DyGHqCxk0r5koKfTn3Eqt
         a3wbB1Lqmu08xsXWix6MVC0fwXyioH4cLcf5MBj/vd0ojMsxGFImHTqsIgzhe4zGbce8
         xFUQ==
X-Gm-Message-State: AOJu0Yz33xuqDvzaz8HrsZ0KitcyuE1rWZ67P6L2mKA69l3COuKKQiXQ
	NNWZQkgjrToaKag03bfmyK3Tpmu/g/MVGRN3AnLKKFpRPD4EKOQTdrOHb6DV9sTg5v6Pj9FQm4X
	nRaAm0t/HxR7lHAwzujjk3jCTFnU25TXPjF0e81+Y0cqdwW4IVyCybBA=
X-Gm-Gg: AfdE7cn/qw13ZH+Um31m/dBnZjgi4tQzDnG3gX29bd0O8vi8SFEm6Rm9a65uC8DXIoV
	at6sSlxVT7PaE0rvlva3i9w2FgX8FYz2r5oBWyEyYu6p+YOGfINrz0voEGyntfLFbROcBx/X35F
	WPxUoLIg7/IAcWdgNeVKsKQFDEn5husoSF6AUsBglAIAEZlUfyff+4Bzrm3ig9gh+O9G7fitQER
	ygdBELWvShZeJWodp/5FKcLRLBpl0N/9kimkgsUAuJMqzukVrdfJsOEr0/k/cVv4Hif
X-Received: by 2002:a05:6512:158f:b0:5ae:b7a3:6dbc with SMTP id
 2adb3069b0e04-5b01cd3d59dmr27701e87.3.1783637314841; Thu, 09 Jul 2026
 15:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
 <20260708-igb_v3_b4-v3-6-1272650ca614@google.com> <20260708233123.F2EEC1F000E9@smtp.kernel.org>
In-Reply-To: <20260708233123.F2EEC1F000E9@smtp.kernel.org>
From: Josh Hilke <jrhilke@google.com>
Date: Thu, 9 Jul 2026 15:48:23 -0700
X-Gm-Features: AVVi8CdyHq0ad48N0jZUiqGuwL-IA5tEvvsKNT1F6W7hvplFSut8SBR-ACjsbMI
Message-ID: <CAAdrzjuyWgODnZR=OiRBxOcbEDdsBRN777hzo_dm4R+s2i23xA@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] vfio: selftests: igb: Disable PCIe completion
 timeout retries
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 4:31=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] Missing SW/FW synchronization semaphore when accessing PHY reg=
isters via MDIO.
> - [Medium] Missing DMA read memory barrier (dma_rmb) after descriptor com=
pletion polling.
> --
>
> --- Patch [6]: [PATCH v3 6/9] vfio: selftests: igb: Disable PCIe completi=
on timeout retries ---
> commit b47012b45a463be841715f383fb27408df2c020e
> Author: Alex Williamson <alex.williamson@nvidia.com>
>
> vfio: selftests: igb: Disable PCIe completion timeout retries
>
> The mix_and_match test intentionally submits TX descriptors with an
> unmapped source IOVA so that the DMA read fails.  By default the 82576
> re-sends the request after a PCIe completion timeout (datasheet section
> 8.6.1, GCR.Completion_Timeout_Resend, bit 16, initial value 1b).  On
> real hardware this turns a single fault into a stream of retried reads,
> keeping PCIe AER and IOMMU error handling busy and interfering with
> reset recovery.
>
> Clear GCR.Completion_Timeout_Resend during device initialization so a
> failed read fails once and stays failed.
>
> > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools=
/testing/selftests/vfio/lib/drivers/igb/igb.c
> > index 1848be6cd46c9..a7a30660b23ed 100644
> > --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > @@ -219,6 +219,18 @@ static void igb_init(struct vfio_pci_device *devic=
e)
> >               vfio_pci_config_writew(device, PCI_COMMAND, cmd_reg);
> >       }
> >
> > +     /*
> > +      * Disable DMA re-send on PCIe completion timeout (82576 datashee=
t
> > +      * section 8.6.1, GCR.Completion_Timeout_Resend, bit 16).  The
> > +      * mix_and_match test intentionally submits descriptors targeting
> > +      * unmapped IOVAs; with the default (set) value, the device keeps
> > +      * retrying the failed read indefinitely, which keeps PCIe AER an=
d
> > +      * IOMMU error handling busy and interferes with reset recovery.
> > +      */
> > +     ctrl =3D igb_read32(igb, E1000_GCR);
> > +     ctrl &=3D ~E1000_GCR_CMPL_TMOUT_RESEND;
> > +     igb_write32(igb, E1000_GCR, ctrl);
> > +
> >       /* Configure PHY internal loopback for testing. */
> >       igb_setup_loopback(igb);
>
> [Severity: Medium]
> Does writing directly to the MDIC register on real 82576 hardware risk
> colliding with the firmware or BMC management engine?
>
> When running tests on physical devices, accessing PHY registers without
> acquiring the E1000_SW_FW_SYNC semaphore can cause corrupted MDIO
> transactions or hardware hangs.  For example, in igb_write_phy():
>
>         mdic =3D (((u32)data) |
>                 (offset << E1000_MDIC_REG_SHIFT) |
>                 (1 << E1000_MDIC_PHY_SHIFT) |
>                 E1000_MDIC_OP_WRITE);
>
>         igb_write32(igb, E1000_MDIC, mdic);

The risk of this happening is low for physical hardware, and for QEMU,
it isn't even possible because writes to MDIC are synchronous.

There's a couple of ways to address this:
1) Do nothing and add a comment stating the risk.
2) Add a simple retry loop that checks MDIC ready and error bits.
Technically data corruption is still possible because the MDIO
protocol doesn't have a CRC, parity check, or checksum.
3) Implement the full semaphore acquisition which requires about 60
more lines of code.

> [Severity: Medium]
> Can the CPU speculatively read the destination DMA buffer before the hard=
ware
> descriptor writeback is architecturally complete?
>
> In igb_memcpy_wait(), the code polls the status bit via READ_ONCE() but
> returns without issuing a dma_rmb():
>
>                 status =3D le32_to_cpu(READ_ONCE(rx->wb.status_error));
>                 if (status & 1)
>                         break;
>                 usleep(1000);
>         }
>
>         igb_irq_clear(igb);
>
> On weakly-ordered architectures like ARM64, the test runner's subsequent
> memcmp() reads on the DMA destination buffer could be speculatively
> reordered before the loop's status poll finishes, resulting in stale
> data reads and sporadic test failures.

Will fix in v4.
