Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604DA2C0298
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277767; cv=pass; b=CFabqy90++CojWzBtbNXrmE9YaJ9GCKatbsPB3ZKdix9zHK46/R3QwtwIL50xIfwoIixxixzw7AcEHPzWmfP2aXe67kN/uavJN3m5+WlqrzgpkoOAjWPmr3E4xeZ/kY4CtMCfBgm7MC+Y80m/PNi1eic7bkl7y6LV8u47IaTh7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277767; c=relaxed/simple;
	bh=PIpaHtQhy1ct/zF6wlpA5f+6+Qs/Xy5/mHEvLvXsGt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sF2bKdT/3elYjToxOZ1grvxmBJ4qwL1eavJkZW+QU8rf+KdK/Cp9ex03QfKIeo9032bC+WcRYd+9iH4XbA9VmmBV3KfTSEIxpTehlU2GkQzTbtqsLrIaOb5NSjbgqzhcTAracJ+01xWqbRpkzeBc5FDxbTCcKLkt8a7ru9zacfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=eLtemJKK; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="eLtemJKK"
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NELmNn928873
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 07:56:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=/SbFMZE76p3gfmGbK12ObrHMOu+elkT4/3PXLPlFc6s=; b=eLtemJKK4Has
	CmgOJDrPyaoCnUKj/6m6pqv7c6rX5uKoNz278WPHV0NiaUJpobtYFO2c/H2u68V6
	rUcPfFnGGMkA1R9FznzGaso1EetXEsib33uPa8YS5DWKk/0H2+KRC5WmKpB4cexD
	WHP7rDQAp69Dwi6aLhiv0mxz/YtBATdPlBxZtCUbBSkgvz/ZWuCH7WY9e+9QunMn
	U71mnXfpBfmdW222Bg4EpE/mrvmdhA8ahhryGTBsBHhUVMfP+BPmcCKkhg/LGSi4
	aPVDqho1R8TPq9TMs70rd1fcR4pcGEwLRzN4l/Xx6Hgq2nJapc1J6r1TnayJIgy3
	wnJnWEn1Dw==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d2fbth1nb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 07:56:03 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-41702ea8343so18908349fac.0
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 07:56:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774277763; cv=none;
        d=google.com; s=arc-20240605;
        b=dGaScF6jnrIWTuYQIb0dPeTYAYf7DLzuDe7SFtl4SJrx0h22csR6w09+tPbi3KRGwf
         BLuUmzLpVPFnZ9Ad4/fUrYr3jzMDtZoPK3FBGWHaW2MrYVoxQM6Y/pHa3VB2vq9+EO0c
         aENIiW+HstCQs4nutONBwT8mfKq49TzlTjTMfL8P1mYGCxWSBhGgzRJVu7YalrONESCO
         6r1wpaQryGE/5GIBL/E8GK/ZPRWyFzJTYl8hF9jXBf4ai67NRudGVAi6qPM+PhU/a9Dr
         whzAiAhYLFYVgQeBGGs6WFmTyVXJuQz4K9d46MtR4yEk9aWtUT5Rt8O+Pb6Cq/7+xYjm
         HcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=/SbFMZE76p3gfmGbK12ObrHMOu+elkT4/3PXLPlFc6s=;
        fh=cdwiNcdNaQ36822Oe/Pib2kllZsojxEV03dNout8kw8=;
        b=iqfn1Yg7LagQMGLuiJDp0BO68jo8Q084KJ+WkZWJcv7SpxhJggb0vzxte8cAeV045T
         OOQXWt7gP3aR3Ux37ma3LWRpjAUUmjk6aOOWwp3l0HCTLmMdofmj3dEw8pvSEAvyoSB6
         M0ZaB/gFNZLag9dW9IHqXZJ+jFb7VOPUc15WEeYIwpTcOmrgQ9Nu0cokx57/iAJjtIy0
         ERWQy700L0eTQFb2quH61ochyoiwM0hYbVu4mkwkGUN9U/i2yW85yGofXEaGkd7i3r+l
         1pC/iFgfuCsa7FqQ6E4oIfAA5Vca2897rfnKzYT+zgsmJkj1FKVLq5PcZx60TXBIDIAC
         HgNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774277763; x=1774882563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/SbFMZE76p3gfmGbK12ObrHMOu+elkT4/3PXLPlFc6s=;
        b=QmTCdcsAGCMjySj9icHiO8tH1d9it43xzeyrakB4+oplAExrGbZqJb//V46fJd6J6e
         v5QYbiviST0iENp+maq3DxSETKQB2NDgRThan+DCDK7kCbn+Qq25hklzamaEUdWdS0sA
         3EufGa5hIlvQZqj/NP8/HqJU7HovZQN11ZTwAJHPYwOmsN48V9KZbGE+TlGA0qTrV+qW
         ClZ32y+sRaSQrRojSacDFHVB83R2keCp5uxdGSP8V4gBSOfZZ6AheTJ0IS919QFwgCe1
         p8lMum4CPszo8Y8qFPSMPJxcGOHxA68JtOBsBS7RWcbP8DpdXPccRZzaRsEsDcoa0qfr
         xCiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFFEZIcnA64nigjzQi+dlg5bg8mQcy+MxRgst8ZuTLd9fu94Z/mNzEetH4+wujbHD94Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YydScGp3o+iZobAbmBjM6JqRRDgE1W1ih2ZMvrEtb4sTaPrjLBZ
	KhXcEc6HvJhgWEFgIQkeeVyrUh5JnPPo4YsBuUyljE+vq5onZCkd42i6QWhM47QuOIlvFsS7DhK
	JaeM7+kwFrGVvCqDIFFq++/unfTDNdQoQJT4XjFyFAd+XHuEUXYnzQdYY4C/EUeh9YRbRRArGDb
	0IdGt8R211t0b7YYYxL+7GknVOsws=
X-Gm-Gg: ATEYQzyXrUjX7wz3gZ2rdvLTs8YKnMo288S1K/Si92jOSnaXYIZOXntPsk6/JTs/ZWm
	gJ7TJEexv5nK8UrSC0woyvRSkWsJ08qxEBa3Usv4t5254zvJ2qmEebwVN1gUKlPNE6rhUtnNnZq
	TQ+cinYrImR2C0t80zeTcPOu4JAFV6sLZbWdEWNYfSpet98SLv1zZJXigqjnOZTN6MedJ63b8hD
	obZDwoyExw9f5hSW3/+9g==
X-Received: by 2002:a05:6870:d694:b0:409:77a9:f951 with SMTP id 586e51a60fabf-41c10eff3demr8062996fac.11.1774277762583;
        Mon, 23 Mar 2026 07:56:02 -0700 (PDT)
X-Received: by 2002:a05:6870:d694:b0:409:77a9:f951 with SMTP id
 586e51a60fabf-41c10eff3demr8062984fac.11.1774277762035; Mon, 23 Mar 2026
 07:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312184613.3710705-1-mattev@meta.com> <20260312184613.3710705-5-mattev@meta.com>
 <20260318140408.4677fff5@shazbot.org>
In-Reply-To: <20260318140408.4677fff5@shazbot.org>
From: Matt Evans <mattev@meta.com>
Date: Mon, 23 Mar 2026 14:55:51 +0000
X-Gm-Features: AaiRm53cK7A_m0KWvttAGgjGrqlnTSfUkM-9VEpOFaKWwlBtmEfLrXJeDgr0v_M
Message-ID: <CAFzAbJGdYpaw0rAwLxLqqzzUiaPjySLXYsnS+hWwF4-GkBmgyQ@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 04/10] vfio/pci: Add a helper to create a DMABUF
 for a BAR-map VMA
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Mastro <amastro@fb.com>, Mahmoud Adam <mngyadam@amazon.de>,
        David Matlack <dmatlack@google.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
        Pranjal Shrivastava <praan@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExNSBTYWx0ZWRfX9n9QDbVQ3Tty
 INDW7cGEfVYS4WifvSjUIn+YNHpmIBtvLwbYP3WEbThPNnUUQsEPTj2s7sKYzzsdKImyP6DdxRI
 3ChVQC2/mTm/zjFIrSfYLpNgfO5rxrSjL8G28windorM7Kyc97uvqLVLn+OEtqeGZcAR3YqTOYm
 MI+Xzxwg9vMEN8BWUq1NvNUPDFW24HnadCGlwP/y337SkeRbr8zcCoOsCpkmUj415okLrQmPx3F
 PSlr1qcMkrHUtgyAEcyQg0+V/4TTnr8XxodJshovGEc6V49qifjseU87CQDWoY8uZqF/lgno4RU
 OMX+kPDEz1jvBZJVgI3Xh+4qva3OsH6obJHZuuKZlDtajEaNzA7HT0lem+lA9OySBa9h8Sk8hUu
 AqD3UyMMP6VNbi2d9+CAc6/bJ9VGABRw880maRPlenth1L9vmLQ0XH1e4r3jCDNSB0I+8zbkZpj
 0SHPKPEEIp7oxkS1zvA==
X-Authority-Analysis: v=2.4 cv=XZWEDY55 c=1 sm=1 tr=0 ts=69c15483 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=Dv35txUGz5gI0hTa:21 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8
 a=cHgMKt-ThCp0vrf1_T8A:9 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: O6n9CNlkMpSk0NLxz4COWMA7vXouel_Y
X-Proofpoint-GUID: O6n9CNlkMpSk0NLxz4COWMA7vXouel_Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01

Hi Alex,

On Wed, Mar 18, 2026 at 8:04=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
> On Thu, 12 Mar 2026 11:46:02 -0700
> Matt Evans <mattev@meta.com> wrote:
>
> > This helper, vfio_pci_core_mmap_prep_dmabuf(), creates a single-range
> > DMABUF for the purpose of mapping a PCI BAR.  This is used in a future
> > commit by VFIO's ordinary mmap() path.
> >
> > This function transfers ownership of the VFIO device fd to the
> > DMABUF, which fput()s when it's released.
> >
> > Refactor the existing vfio_pci_core_feature_dma_buf() to split out
> > export code common to the two paths, VFIO_DEVICE_FEATURE_DMA_BUF and
> > this new VFIO_BAR mmap().
> >
> > Signed-off-by: Matt Evans <mattev@meta.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 131 +++++++++++++++++++++--------
> >  drivers/vfio/pci/vfio_pci_priv.h   |   4 +
> >  2 files changed, 102 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio=
_pci_dmabuf.c
> > index 63140528dbea..76db340ba592 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -82,6 +82,8 @@ static void vfio_pci_dma_buf_release(struct dma_buf *=
dmabuf)
> >               up_write(&priv->vdev->memory_lock);
> >               vfio_device_put_registration(&priv->vdev->vdev);
> >       }
> > +     if (priv->vfile)
> > +             fput(priv->vfile);
> >       kfree(priv->phys_vec);
> >       kfree(priv);
> >  }
> > @@ -182,6 +184,41 @@ int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_=
buf *vpdmabuf,
> >       return -EFAULT;
> >  }
> >
> > +static int vfio_pci_dmabuf_export(struct vfio_pci_core_device *vdev,
> > +                               struct vfio_pci_dma_buf *priv, uint32_t=
 flags,
> > +                               size_t size, bool status_ok)
> > +{
> > +     DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> > +
> > +     if (!vfio_device_try_get_registration(&vdev->vdev))
> > +             return -ENODEV;
> > +
> > +     exp_info.ops =3D &vfio_pci_dmabuf_ops;
> > +     exp_info.size =3D size;
> > +     exp_info.flags =3D flags;
> > +     exp_info.priv =3D priv;
> > +
> > +     priv->dmabuf =3D dma_buf_export(&exp_info);
> > +     if (IS_ERR(priv->dmabuf)) {
> > +             vfio_device_put_registration(&vdev->vdev);
> > +             return PTR_ERR(priv->dmabuf);
> > +     }
> > +
> > +     kref_init(&priv->kref);
> > +     init_completion(&priv->comp);
> > +
> > +     /* dma_buf_put() now frees priv */
> > +     INIT_LIST_HEAD(&priv->dmabufs_elm);
> > +     down_write(&vdev->memory_lock);
> > +     dma_resv_lock(priv->dmabuf->resv, NULL);
> > +     priv->revoked =3D !status_ok;
>
> Testing __vfio_pci_memory_enabled() outside of memory_lock() is
> invalid, so passing it as a parameter outside of the semaphore is
> invalid.  @status_ok is stale here.

So it is, arrrrrgh.  Thank you for that; I've found a couple of other
choice bugs in that RFC, and will resolve all of this in a repost
soon.

[snip]
> > +
> > +     /*
> > +      * The VMA gets the DMABUF file so that other users can locate
> > +      * the DMABUF via a VA.  Ownership of the original VFIO device
> > +      * file being mmap()ed transfers to priv, and is put when the
> > +      * DMABUF is released.
> > +      */
> > +     priv->vfile =3D vma->vm_file;
> > +     vma->vm_file =3D priv->dmabuf->file;
>
> AIUI, this affects what the user sees in /proc/<pid>/maps, right?
> Previously a memory range could be clearly associated with a specific
> vfio device, now, only for vfio-pci devices, I think the range is
> associated to a nondescript dmabuf.  If so, is that an acceptable, user
> visible, debugging friendly change (ex. lsof)?  Thanks,

(Jason, your comment noted with thanks, replying to you both here to
save electrons.)

Great question; a formatting change there is inherent to moving to a
DMABUF (which generates a "/dmabuf:" prefix to a user-defined name).
If we can accept that it changes at all, then I agree this then should
output nice debug: at least the cdev name and resource index, and
we've the opportunity to include the BDF too.  I've added this; an
example line of /proc/<pid>/maps:

    ffffb8070000-ffffbc040000 rw-s 00030000 00:0b 5
      /dmabuf:vfio0:0000:00:03.0/1

Note the file offset used to include the resource index up at
VFIO_PCI_OFFSET_SHIFT but this DMABUF version doesn't do that, so I'm
proposing appending a "/%u" for the index.  Above is a map of BAR1,
offset 0x30000.  If people feel strongly about the existing aesthetic
then we could keep the index encoded in vm_pgoff to retain the same
offset field in /proc/<pid>/maps, but it'd be less neat masking it
back out in a few places.

The default name of a DMABUF acquired through
VFIO_DEVICE_FEATURE_DMA_BUF would still be "/dmabuf:" and I think it
should stay this way since a better name should be supplied by
userspace.  The default at least differentiates them from VFIO device
fd mappings.

Many thanks,


Matt


>
> Alex
>
> > +     vma->vm_private_data =3D priv;
> > +
> > +     return 0;
> > +
> > +err_free_phys:
> > +     kfree(priv->phys_vec);
> > +err_free_priv:
> > +     kfree(priv);
> > +     return ret;
> > +}
> > +
> >  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool rev=
oked)
> >  {
> >       struct vfio_pci_dma_buf *priv;
> > diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_p=
ci_priv.h
> > index 5cc8c85a2153..5fd3a6e00a0e 100644
> > --- a/drivers/vfio/pci/vfio_pci_priv.h
> > +++ b/drivers/vfio/pci/vfio_pci_priv.h
> > @@ -30,6 +30,7 @@ struct vfio_pci_dma_buf {
> >       size_t size;
> >       struct phys_vec *phys_vec;
> >       struct p2pdma_provider *provider;
> > +     struct file *vfile;
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > @@ -128,6 +129,9 @@ int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_b=
uf *vpdmabuf,
> >                             unsigned long address,
> >                             unsigned int order,
> >                             unsigned long *out_pfn);
> > +int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
> > +                                struct vm_area_struct *vma,
> > +                                u64 phys_start, u64 pgoff, u64 req_len=
);
> >
> >  #ifdef CONFIG_VFIO_PCI_DMABUF
> >  int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u=
32 flags,
>
