Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E591136AB7C
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 22:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781389517; cv=fail; b=SJVkBObvNgXQ47kRko0fl4YdnlMp7OD4/n7frFUtPVT1uXk1Yu7tVoQNcZWwEwVDkIQCen7eTpKtN7I0HAz3gYS9j3Z2cNh+attRFFvL6UfJguylKZ3zFUK9lYussISwW+fhVEw07mZ2R5CAZLf9F3GkBrbcl/+F8Pll59OfntU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781389517; c=relaxed/simple;
	bh=1bdEY5yxv5t9XP5TtCJFWuEDTtBiQLjm4/B3JBKM7qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fq9NfQxl0FaBllYzskWHHDefh7i+xs126aE0NBDPjKoIJG4HLLRd30CBwmF1s5lUM6TF36WqQHuo7oEzu0tjhDGZKfVs72D7sezF+Y4gJnD7pYmVobOeNlUmNP1JU0Ue7lJjBEMb1WpfFDSa24yzMwzfzD0Uc/Odv6+UE2PB3Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=igpbZWWh; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="igpbZWWh"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DKugFP1618743
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 15:25:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=GRdIE6LSM1bH8RC9lncAbOJ2JdACIXbSk43KFW5xUf4=; b=igpbZWWhgcAG
	UQRhHeAkQUcQT9YS1C1yizMLyYubisFvGTIHjvXAP5Yq4zFuMdy0J6izagbAVYGE
	Oh4Rla1pSyswX57EwIqs6wjhCDpr7SSai2oeugc/TSvmNQ5+HA4Puhr8hB2sZfKm
	K24vuXIvlgHEIVuujAPmgQN4D9olXWM87UFrSbGJUSfPnONyzsT6/QOd4nUKplB6
	+eaVfmM5zaV0rySMY0pM1OEcco2PwpNZ4z+evfY3ySdK+6zvdWUdR9NvkMhTpJgz
	2PddCQmkEQIS46pCY7lwRWXYNf7regn3XsKqdJFxiGmJlAP+qmzk4l0OhsbMgxA/
	LQsjKjm8TQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4es4vy1ymq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 15:25:15 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6b5976d74so4175445a34.3
        for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 15:25:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781389514; cv=none;
        d=google.com; s=arc-20240605;
        b=bNfcm2M32xVtzcTBWOS98sPlsiLD96Jz/Xd+Q+A2ZMn3ETrxvkR6OnKPVD+aeZ8lij
         fdQwCiYS9K2JGeJy3LKUWP6JfSx5Hhaal+6qzrrvEWsH8fwKbPp8QTQ0LcBWG+siAi3M
         ru6S9iEScLRpj84Z3GNQxvsq6BhpOJBVwERDocAPzX6YRrhaAr9ACBz8rNrpJVja6HgJ
         Wtmj2jLyBrmHwde7gem3v1Q0S3o1zc8/9klqB3AA4tnVgf5LG2u8lE1CRqa8nQIlQNn+
         kQuPL1w+rua5bJKRNtFJ8haztDOhhj8vtFpdNunS64Gnto6N0kKt6AhjrNQYs3CepOAb
         ahFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=6/EAQqigRSI18sLOr5BrBLiEKIx0cvrRCkfg6C7SoSw=;
        fh=5lJ6RAhhJDFxHCx+Juh0UxP+3yr5Jw0XdtYukuUH2kk=;
        b=HmsdWwAY35TfjZO0CiG3Cke2J7SxuOi8n0YPPfo2xttZN1IFbLx+KNawWo+Q3uCIqj
         mibmYymrGpd/tz76vd8m8DAYMcssFvNiR6ifv8W1Y7XQDgXi57TDPW9o0VmeRPuprfNS
         RonfWSF8Ah9+v1CdcPcNmQnVTYLOrSmk5huSVOby9PjvDaVHsnlzQFdF62uKjMixT9DB
         Aq+cAkMdqG3CzCdwg4uA65rRxaFGsaMwomOk3lGdpEP5sczMXf0Bf7OpMalz/8NZfMKo
         IFrUjFjQ/YUsopQcQ7+GYTDy5R7AsnrrDPKy4IG2fZIsr/4OyHmGAyWNEYF71rijDDVV
         qCZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781389514; x=1781994314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6/EAQqigRSI18sLOr5BrBLiEKIx0cvrRCkfg6C7SoSw=;
        b=m6cg1JjKsqt2ZTSFgOkl0YtnTelEJgPeSZcp8pMHPcWdVFqDhwMcP8gDLjj1lvj26b
         vVjwrS3+uRpH1A8SBvvoXft01psziMfy/1g75azOXURoG1FBX52VemP6XOCbA6ZT6Xh7
         uZiNP0hXf4qSHIMZT82ccsLDc/5gO/xj06CHzWBAoZG1p7paRu0ZCBPLD3kMyIvMfR7R
         qKqloSIGjMRmTnuI4uD0maNq185P2dh/MFhldjved+7JDSnF2uHvZ+UnYE3/mN9Iz0MB
         KxgzjtagvKMSwipai/mdkHkl/0XtrA5eT+zw5Rfwx2zrAbQEo9eyVkQBNKVhRjKNdrhL
         WZMw==
X-Forwarded-Encrypted: i=1; AFNElJ8HpfJ/XWwuk3bVPbFTftzZwErXxxuYQfntXI/HxwWZ3U2f1cPfnErJcNrxcPrPLeUOimg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbneOqRX7yb495mCF3kaKw543tM4ce9NW9aU3sTCQRub2tpKxB
	y3k8Td17g0m3EpjKvxvbIcjKocvWY8VQgJMJKaeyer6+xHXL1dZR4MTNONqUoJbTCcu2Y3CDxUE
	HGqy/SM26+QV5trbmygIueiBik1Pgf5db1LG+mQ/T0HGMLftZd7AsdtUyR8kUFy/NNe40PhWgRp
	72OcPENal/OBQJWWLE7ihPpnXkgMA=
X-Gm-Gg: Acq92OFn/LgURkR8oigA63ZcIr6yulwMQqlzDEsi2bf1nbEn1nQQPhf08nwJg/Jjyir
	iLwwhBA5AyMQKGxDHYMQGYrynOnc4QFgrmdK13tDVwrZghqifRPC1uy+n0llWNh1W63Wm9ox0pC
	+3N6/CjAO00/IRXGhuF4rOjxrbR963t4PE7JMgdfrV1myQGjihIkSMn4icL2VbLIiK4TU3jza2d
	k3pGUm2FEZgzCBai8dvxA==
X-Received: by 2002:a05:6830:6187:b0:7d7:fd71:f2e4 with SMTP id 46e09a7af769-7e78e75e354mr3483171a34.14.1781389514258;
        Sat, 13 Jun 2026 15:25:14 -0700 (PDT)
X-Received: by 2002:a05:6830:6187:b0:7d7:fd71:f2e4 with SMTP id
 46e09a7af769-7e78e75e354mr3483152a34.14.1781389513778; Sat, 13 Jun 2026
 15:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611161546.4075580-1-zhipingz@meta.com> <20260611161546.4075580-5-zhipingz@meta.com>
 <20260612111001.5b7206eb@shazbot.org>
In-Reply-To: <20260612111001.5b7206eb@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Sat, 13 Jun 2026 15:25:02 -0700
X-Gm-Features: AVVi8CexW_WJJGnDTI4HN0FLeTaWayUrCy_spJuvDIJixjLtGyyKLpDTD_UhDYM
Message-ID: <CAH3zFs0Nr6PCEVj0+iyAt6bdOVdQCnmNOCVuJ-5v7xAtKFuXMg@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
To: Alex Williamson <alex@shazbot.org>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=ef0NubEH c=1 sm=1 tr=0 ts=6a2dd8cb cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8
 a=e6IX7qM6bnzC-tgAjTwA:9 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: FOLZNhI9UdH5TIEgv9Gds-eg8wXIKhev
X-Proofpoint-ORIG-GUID: FOLZNhI9UdH5TIEgv9Gds-eg8wXIKhev
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDIzNCBTYWx0ZWRfX09uUzQK3Rzae
 0Gunlx3vPFQSWfs5spTU7yp+3ZRg/XMsXYnt1sT0kHpbNsfZOuhwTy7uZU+les1eeWmz3rd/dxP
 tUR+8MvbGRZnJXjaTPL9jv4dd1ySGj4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDIzNCBTYWx0ZWRfX8YCpMGQuiOi2
 wz+u9jKcHPPt4NnAoAaTY/1hXt2SuLYXRq1MHTy/OMky/XAoobBnOwiQkykCp0f5iuTviuRsDrz
 WoqDE1TNC43Jb3oHUxcqTXYINVZmzOkExsRVfp90o1S08Z+ljLJPxQmRt3B4u6F5MRslxKR2ud0
 Llp8Jm8PxnTK3xLG4a2otUIAQVE+HMLGyrI8EqBJxJ7U4d2VqrEZOlS9UkL3+tTnkgduoOysnf/
 b3WfgDF/sF9q51whiPhWmUIA9axlHqKoJu7QAaHn72On+AcoprFsQm0j0bwg38mFHh7mjiUB5+Y
 GdiYqIefAZgdeSOAR8UmA0uITqbl3k3ZumcbZ+KKxAAhBbradaPUJuIrkvZ+gkJWDq5pk24FikP
 O6IGvS5yykp2wfBQKMAxrtzJ1amr342KysBKXBhM/uQUAsKQTJBty75ojfArxDrU+p02l4uNuE5
 tdH8pkJeEJgAQIcxxxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_04,2026-06-12_03,2025-10-01_01

On Fri, Jun 12, 2026 at 10:10=E2=80=AFAM Alex Williamson <alex@shazbot.org>=
 wrote:
>
> >
> On Thu, 11 Jun 2026 09:11:19 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Implement dma-buf get_tph for vfio-pci exported dma-bufs and add
> > VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can publish TPH metadata
> > for a VFIO-owned device.
> >
> > 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> > uAPI carries both with explicit validity flags, and get_tph() returns
> > the value matching the importer's requested namespace or -EOPNOTSUPP.
> >
> > Publish and read the TPH descriptor under dmabuf->resv, matching the
> > locking used for other importer-visible dma-buf state. The SET ioctl
> > takes dma_resv_lock_interruptible(), while the callback runs under
> > DMA-buf's asserted resv lock.
> >
> > Reject requests the device cannot consume as a completer:
> > pcie_tph_completer_type() must report at least
> > PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY, and Extended ST requires
> > PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH. Validate fields before the completer
> > check so userspace gets the narrowest errno.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c   |  3 +
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 94 +++++++++++++++++++++++++++++-
> >  drivers/vfio/pci/vfio_pci_priv.h   | 12 ++++
> >  include/uapi/linux/vfio.h          | 37 ++++++++++++
> >  4 files changed, 145 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_p=
ci_core.c
> > index 050e7542952e..4fa36f2f7555 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1569,6 +1569,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_devic=
e *device, u32 flags,
> >               return vfio_pci_core_feature_token(vdev, flags, arg, args=
z);
> >       case VFIO_DEVICE_FEATURE_DMA_BUF:
> >               return vfio_pci_core_feature_dma_buf(vdev, flags, arg, ar=
gsz);
> > +     case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > +             return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> > +                                                      argsz);
> >       default:
> >               return -ENOTTY;
> >       }
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio=
_pci_dmabuf.c
> > index 1a177ce7de54..0a0705c8dbea 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -3,6 +3,7 @@
> >   */
> >  #include <linux/dma-buf-mapping.h>
> >  #include <linux/pci-p2pdma.h>
> > +#include <linux/pci-tph.h>
> >  #include <linux/dma-resv.h>
> >
> >  #include "vfio_pci_priv.h"
> > @@ -19,7 +20,12 @@ struct vfio_pci_dma_buf {
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > -     u8 revoked : 1;
> > +     u8 tph_st_valid:1;
> > +     u8 tph_st_ext_valid:1;
> > +     u8 tph_ph:2;
> > +     u8 tph_st;
> > +     u16 tph_st_ext;
> > +     u8 revoked:1;
>
> If these bitfields are now all protected under dma_resv_lock they
> should be grouped together with a comment to that effect, no need for
> revoked to get kicked out to its own storage unit.  In [1] I'm
> proposing runtime modified flags each get their own storage unit, but
> for more isolated cases, so long as we keep track and enforce serialized
> updates, I'm ok with runtime bitfields.  Thanks,
>
> Alex
>
> [1]https://lore.kernel.org/all/20260611213539.4100590-1-alex.williamson@n=
vidia.com/

Sure, will group them under one comment.

Thanks,
Zhiping
