Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEF9248F57
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 23:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781048896; cv=pass; b=rxVKC7X3Jj18HZyMHiskZDCWr5qP8LVGiFt0tPfI8/y//MXyvSF/+720bYdMc0ltkycQvecVa1vhw8xsV/E+7hQVF+GE5Q1GbYEmlzAfsggedeHgewRmQGWQF3jLhk8C8Ub4KOJo3xi9kSHlDLcYD1wO8q2ni+OL86/s1RziS+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781048896; c=relaxed/simple;
	bh=rzFi8rHbjUN/4EV94L92+v7yzItUHCmPw4oD5yP0uJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEn6cAs5v2DhW8sEItyf3npfBn3GE/4z354BbOKlBKFB6Hf+NqpwotIczpleiBmDCE0mzRdfSEAt8JfT0PmMUCkV4U2qQHCuq6ABSgZRYqBQtdpw0uziDbxWlcr4kQ04FkQxUjbvVU4CBPFzMH3dDpotkyKgFfdW/tiJEJn1zs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=OZKBis2V; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="OZKBis2V"
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659M0Ts93691285
	for <kvm@vger.kernel.org>; Tue, 9 Jun 2026 16:48:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=2oke7nd3qgzSpwUghUx6
	5sQAoKy1HMHaETHva/Kk8Jw=; b=OZKBis2ViNPY7hO90BNGQapT/XbUSMHitxwk
	n9XV/Gazcj+2wD9m1KqBMuPmB9/KzpVT1nBJ6WPualsEDo7qL0Vtzy+VzpzOy4WO
	VJIhhmj08GYtZwFIjFfi83tEXNicBAxgVk0RaCm2kYxY8pYZ7r7p0XmODAFwWTKL
	TQm2udjgflTsDrm3B3obBvMx4aAmTTMePMUsDel0/p/JTzF3k6rH2qDUyVCJv8XZ
	rvlRdpBmF/Gt6Ek/OaG5ScR5kK8TQn1MNMSEQ16qjRMigOILwgvGGUt7t+zhrnYT
	ox3vb1WsVoPy1SXQ5ySWLbIoP0woSdDUhL2pkCkc2mLTW+2m1A==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4epu89gp49-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 16:48:14 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e6ed99d4dbso5552820a34.0
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 16:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781048893; cv=none;
        d=google.com; s=arc-20240605;
        b=ORD53Kis3nAJzMba7iYyVpP7ZR7suvtYYVNQOFdwnNwUMDt7Li6BWu+qSodbauZDTT
         abG4UhUJK9zR7vAAAYdyOs5oCNJTg/TPtKUxh9FMf5ISaqXCwas7+G2wdNmxbB97SKBP
         7FMkIPvIyUoc3TOb8ZuCr/jUTdHjxe9Q1rND3XcYnJOxdMtSPBjPMXOZYcXtJxcgGhQ4
         YKWIXf41zm4DCt97V5yHY8W+RNvNDdvrJC1gGugoPAp+zWw/BM7ctTH//sM0d5Maejci
         Nth8zcITLaBNHk2glrfiG80/8jDLGjQogSWelzxctDY2ne8nyfLzKskVvllbbEm8KE0I
         H8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=2oke7nd3qgzSpwUghUx65sQAoKy1HMHaETHva/Kk8Jw=;
        fh=MYTgycGetxTG65XrLe6IDtC+34qTWyeeiAB8HodNhzw=;
        b=Noz2lsIkrBe/hlvafZJCEYEf+ywUE9o7ikW6pvxfaMALdH5/rdruC0fYysMWZxdhUz
         QuKIyUxKS5ljvpwUXpGQSlmXRnJTpzlViGxPvqH8v0DiPpfAm6i7qP0mD/lLnz5ZqAif
         lx34k0OPmY7u78H+gXwFG12uHGpip3ZUYcVj7NZzVFxzL1uAqN4N5kFjXOVAHumE7pbR
         wLuXprJSCHmLB9usXqxGkpNl3pedp97JI5VSTgOW1lOMi0I+mlVj56apBCc0enqvXNTP
         pTWyjIoZdFoLz3TC4iR6WE3qUMLc74CEDHRWTOUupf9sZh0DZflWE9jgqJjJBXTcsHUm
         5H7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781048893; x=1781653693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oke7nd3qgzSpwUghUx65sQAoKy1HMHaETHva/Kk8Jw=;
        b=tPlGaIf4Ofr/F5RsjayGh6pJNGals5eJ9tim8GlRNKWLGELphlrmoUHrlYOnnBwz5p
         EQ+iFoBeG05dNQbhiwyQwbOkQr+DK78BlUo/N3yzHJJe6m7m+7q6FYXPHOXZCmXvBH/u
         VopA9Z33N2mbXOdYpWi/THfiG5SN5IUsVRF9vJxr7q53jnlOnkOjxc8z/7ijBCnsmiMk
         ySKL1xZNwQLU7jYqw6KXQOms30qRx0GqrFdZlCtPBIdmO01NMdVSUAyMibFUfrQlPLDI
         552CNy8fi6xsgNjer4dI452xtYWa/D1jCF2qZlsFxa9LoXTWRQcsFq1K4TQ2+jYMPXM4
         J4ww==
X-Forwarded-Encrypted: i=1; AFNElJ+IXE+XuKcS/7V2dnbNrjql0LaT2S5Mnebi+dWrLxdvhBgWQ3k2nnTAhVIxvl3RGfKKpVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC5OwEhBA8LmElAqr/ZYIkFHI35oHD+I4iE4TB5isLpt/qiEI+
	/ps5/L2hqm6xSWEoWNE5cqAKL8dVyJqN45PCVp3hX1847DfoCTG4QaLDCE7kh7+9oZxU2vWCvxG
	YnjYirbx5SU0WjvTEQbpQFabTt15mZAjjC6cbr2+HdhVVykLq58LwxnNrSKfoFFL0DmlRIyIz/W
	bi7ILllgeYQSatC8TLt76/U1LT8/EdquTxWPVPrQ==
X-Gm-Gg: Acq92OE6+vbiBOy/xE0nHM6zxW5OS8awe7AY6OA6fYlr95uYw5mWUYNfj+wxz0rLrBd
	m0bEvXYc2f3HV1gyGU9Wiw1PH7sZDZ7AEC82tFj5nxUuzfTbG2T3Hxh3Jw+Kl/FbSvDy/VCUzZW
	i3ryagr5QCl4KppWb8ELgOehPa72tK45B+udAAajd9ZeytrBcBnPbfklYsaJRxMS9AjjbPeWuM8
	dnPXouSoFAFAvDxLqAucJaPKiAceQ==
X-Received: by 2002:a05:6830:4990:b0:7e6:fdea:7aee with SMTP id 46e09a7af769-7e70ca37187mr16012141a34.24.1781048893444;
        Tue, 09 Jun 2026 16:48:13 -0700 (PDT)
X-Received: by 2002:a05:6830:4990:b0:7e6:fdea:7aee with SMTP id
 46e09a7af769-7e70ca37187mr16012114a34.24.1781048892924; Tue, 09 Jun 2026
 16:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608185646.4085127-1-zhipingz@meta.com> <20260608185646.4085127-5-zhipingz@meta.com>
 <20260609154634.46ee8328@shazbot.org>
In-Reply-To: <20260609154634.46ee8328@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 9 Jun 2026 16:48:00 -0700
X-Gm-Features: AVVi8Ccv--t4yFPwVmIF6GS96siJpbic6hR37JvTtMZG4eYFQdBVvAgfn5CrAeU
Message-ID: <CAH3zFs2UEpVV2MDkPvd5qW=OAFZ=MFMn1FTTpGa=sM-Kc8vcXw@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: IvedbGgiPXKN5BjOzDko9eh1jrXC6ah5
X-Proofpoint-ORIG-GUID: IvedbGgiPXKN5BjOzDko9eh1jrXC6ah5
X-Authority-Analysis: v=2.4 cv=Q6HiJY2a c=1 sm=1 tr=0 ts=6a28a63e cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=Udk1dkG43rCpktSCSPQA:9 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIyNCBTYWx0ZWRfX/eOIHXym507d
 6JF5F0FEl5Bm81bzZAl6iC3l75qTz7daMm/NVlwjf7G3WfGUe4nz4HruTbuYbxgwbjnD7sG36ah
 okt/YSwpxCr04CGAgm6klW+IoqpAsODm+8mWSYcpxy6IY8jJUglbn4t8B9p8AxLlDn+Bbi6zARh
 qfTesPwZYjoIyDbgBld0uybJYHEAIQix9EshM7ktfzWlj9EqL7lrQpvAJ27aEqVj5qxga+H2jXh
 LSQQDJeI9lpjjMF2Drkbkt33nGmxZwmSDc0/RF7zsnbJYKZdlpBWYXsDZAe1su+Jq/Kg5lKn9qc
 BDLyZjw5zHFHBi19tI95Zca2L05sIFR25QciNCIk8Pbf4JCZH1hP9plQeQA+ZJf+/O+kQ+f/uWC
 cRUxMW2LSIeElV5dXAAb2TsimnLVsb06l/d1gsFsp6VzkaE5m0yA4Aceu6fKguIRa5JB6zWNSAr
 gOt9LykLAjK+DCprTpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01

> > +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
> > +                                   u32 flags,
> > +                                   struct vfio_device_feature_dma_buf_tph __user *arg,
> > +                                   size_t argsz)
> > +{
> > +     struct vfio_device_feature_dma_buf_tph set_tph;
> > +     struct vfio_pci_dma_buf *priv;
> > +     struct dma_buf *dmabuf;
> > +     int ret;
> > +
> > +     if (!pcie_tph_supported(vdev->pdev))
> > +             return -EOPNOTSUPP;
>
> This tests for the TPH capability, but the TPH capability is only a
> requirement for functions that generate TLPs with TPH, ie. a requester.
> This feature is about providing TPH steering tags when the device is a
> completer.  Bits 13:12 of the Device Capabilities 2 register indicate
> if the device is supported as a TPH completer.
>
> Additionally these bits indicate if the device supports standard and
> extended TPH, which means we should not only fail if the device reports
> 00b, but should reject extended steering tags unless the device reports
> 11b.
>

You are right: pcie_tph_supported is not correct here.
Let me use a helper function to return something like this:
PCI_TPH_COMP_{NONE, TPH_ONLY, EXT_TPH}.

> > +
> > +     ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> > +                              sizeof(set_tph));
> > +     if (ret != 1)
> > +             return ret;
> > +
> > +     if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> > +             return -EFAULT;
> > +
> > +     if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_EXT))
> > +             return -EINVAL;
> > +
> > +     /* PCIe TLP Processing Hint is a 2-bit field. */
> > +     if (set_tph.ph & ~0x3)
> > +             return -EINVAL;
>
> Sashiko notes what appears to be a false positive here, the uAPI states
> ph is to be in the range [0, 3] and nowhere else says that it's allowed
> to be garbage for a clear operation.
>

Agreed - i will leave it as is.

> > +
> > +     dmabuf = dma_buf_get(set_tph.dmabuf_fd);
> > +     if (IS_ERR(dmabuf))
> > +             return PTR_ERR(dmabuf);
> > +
> > +     if (dmabuf->ops != &vfio_pci_dmabuf_ops) {
> > +             ret = -EINVAL;
> > +             goto out_put;
> > +     }
> > +
> > +     priv = dmabuf->priv;
> > +     if (priv->vdev != vdev) {
> > +             ret = -EINVAL;
> > +             goto out_put;
> > +     }
>
> Sashiko notes this may need READ_ONCE()/WRITE_ONCE() semantics, but
> that may get fixed as part of the resv lock usage.
>

Ack.

> > +
> > +     scoped_guard(mutex, &priv->tph_lock) {
> > +             priv->tph_st = set_tph.steering_tag;
> > +             priv->tph_st_ext = set_tph.steering_tag_ext;
> > +             priv->tph_ph = set_tph.ph;
> > +             priv->tph_st_valid = !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST);
> > +             priv->tph_st_ext_valid =
> > +                     !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT);
> > +     }
> > +     ret = 0;
> > +
> > +out_put:
> > +     dma_buf_put(dmabuf);
> > +     return ret;
> > +}
> > +
> >  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
> >  {
> >       struct vfio_pci_dma_buf *priv;
> ...
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 5de618a3a5ee..0ca26721849b 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1534,6 +1534,51 @@ struct vfio_device_feature_dma_buf {
> >   */
> >  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
> >
> > +/**
> > + * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) metadata
> > + * with a vfio-exported dma-buf. The dma-buf must have been created by
> > + * VFIO_DEVICE_FEATURE_DMA_BUF on this device, and the device must expose the
> > + * TPH Extended Capability (otherwise the ioctl returns -EOPNOTSUPP).
> > + *
> > + * dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DMA_BUF.
> > + *
> > + * 8-bit ST (steering_tag) and 16-bit Extended ST (steering_tag_ext) are
> > + * distinct namespaces in the PCIe TPH ST table and may both be present with
> > + * different values. Userspace should populate the value(s) it has from the
> > + * firmware ST table for this device and set the matching VFIO_DMA_BUF_TPH_ST /
> > + * VFIO_DMA_BUF_TPH_ST_EXT bit in @flags. An importer requests a specific
> > + * width and receives the matching value; if the requested width is not
> > + * present, the importer is told TPH is unavailable for this dma-buf.
> > + *
> > + * This publishes the PCI SIG-defined ST/PH tuple for a VFIO-owned PCIe
> > + * completer. The dma-buf core treats the tuple as opaque completer-owned
> > + * metadata; an importer simply requests the namespace it supports and places
> > + * the returned value on generated TLPs.
> > + *
> > + * @flags == 0 clears any previously published metadata.
>
> This is overselling the invalidation.  It only flags the fields as
> invalid for future get_tph() requests, it does nothing to clear
> previously published metadata from importers.  Thanks,
>
> Alex
>

Good catch, let me re-word.

Thanks,
Zhiping
