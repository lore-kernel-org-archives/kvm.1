Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A734E3803EF
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 23:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219283; cv=fail; b=q2w1ApWFUDM/FMIWA1HhvV/dDD/3wPiEug+aXltxiRgSIzKiJ7F5KyltNFYWd/DmTeRUa6+OgkatsMapH/DhIrAxm7V9tW2HNUSZq6ePXMwEr8v2vlrO2ruRUUuRX4hCKbnnaK4WPhXtbsC8gHygg+XBAqJ1basgoeGZCTklAqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219283; c=relaxed/simple;
	bh=Xy3ScJnXdGO1uSMgz2W54lBdlaGYi8w2p6RzwRoDR08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPW4X9EyZ9+7sy/CQn/hft5SkOB8xqZ4Ad6NdAzbnwHQhwiJpCR12qF4ZxEvbuOEYmXeNaDGW7NAiJfbfTBcUP2mJEVCnt1y6DGvRd67ZQXOeiQsZoRZpWPY5tTIZJ6lH6ePjPARKyCnlffarQlE6b7Za3+x9tVpmmiE4KrFxzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=S/OjtqUr; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="S/OjtqUr"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BEdBnY2102993
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 16:08:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=eSd4DfDWKCJhrlk+WFf1HJuCXJjV3yJV405FpCwAOa8=; b=S/OjtqUrfaHy
	U2tzFcZ8mycupW/bmzC0ry9dC6/TLZhsjYUOLx9kRDPB0KY54IyAWb3v/8NCzgIb
	Lo7j7/o2b10gCRzYHkStHM3+46rjVxu480Rw69rpMHhOshrelnhYeaEHIAZWHY2c
	45cn3iSQuWvr09tWHy11Rg98ilzmEcTlYqqh9Q7sHC11wTUiTKCHHmUjQuUuiz+2
	BUzCK5pTcOnMAmuXtXpOjrSB6KpO6VLwRJcO/kgZ1gLYJTGY+KSd+TwJCKLMpmK8
	S3GzefST7H4aOVX962Ewe73xPQFn9Ny/oy+d2hIXiJkNWwIp7UrGbCvYz36QF7sN
	eBQXf3TFYQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe7chd4x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 16:07:59 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6cb279950so781626a34.1
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 16:07:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781219279; cv=none;
        d=google.com; s=arc-20240605;
        b=GTcwSzni6A8ZEc4FksmhIwvKPFlzGac3zc6VAjYi1A+YAPsV0mBcQdp9kNrjZTUe+L
         WZ9KT/C700+vNdxn2RI9FhxhD0xus5aAhj8IyZsZrdajn5QQKlP4bCMMCgcZSuzPDXhE
         8em4EveD6hPT2wgJ6OAoBJEqSC/y6+ppPcz2PQOk0W3vGWVbWOLVQs0bXaoCQi07Cotx
         4PZssukFtHJyvaGBwFKs5xC4RMa1XKiL73X9jB7F4P1r0ctcp3ypwqhSKE/iuyCQYbJw
         6K/aeAC9DSrqnFMLOZTcXYVELt5dX7D5CGvfqB7yOHC3tAHZV3H3fs2Abw4DJfO6Zzet
         4ZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=jKBgDS5EhOCeCGVgkUxAvmWq6B4D8KMNSa2GuVyeKb0=;
        fh=utY7MKqDJlOb+upykaK6mZnKsm6dfESItPcG07a0h4Q=;
        b=kxZ4yB5519dZqD1P6dYYEQCHo4xdjLGU7oFFyNpH8qnCZ9GsiKiTlovubhoyeHKVJ2
         sg0ZkpSm9Q1D3J9Fh/rNuXpTbIX+U92oyt3Vo6hNv7Bs4WkPmru0T0E/MxwwtoltAu9v
         L49f+DVtKYDrJZMvgyCdZoWDIegwhhihMZF5QBB/pY8lVGNz/Kg0IhvmSbNcEZef8H+E
         kjLpaqqFXHxCqdF0bwDarya1iZbdoJxY3nRb5XXS/37Au6cVVLcjjEf+8lejYjbznSrv
         jvZgt6ncUEhsf77EpjJ6Gxdv0jK9MLjIAE2fRJ7cEHfVNq+D6mhaZE2EvyBkdWfuhbSV
         OxkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781219279; x=1781824079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKBgDS5EhOCeCGVgkUxAvmWq6B4D8KMNSa2GuVyeKb0=;
        b=qDLCwxezStDXeuNlrpJE/OzcBD43uKsfKeBYZmSsSwGDCeeYN4m0Q9GyJgCRGWuqNW
         2v0EaxxmEEqlGIZNlM0AGzU7haGFmj2bHPqC2r81EWSfFbYSD3lOzvcf3Owh96tFmV1S
         OHuQmzYtB5DRNCK8LvAf7PLgQOluyawz0I2k3TCjhv0jhmopFO9kOyk2hCoOrhUhrKzX
         jhEHE9ElVJn8Tuf7+PjQhRwnfOEnsPCB5S/D5N8c0BbJWbgTIUR5o6WG/xtZslujyEMt
         bRZ7gOzVuav90WEhwLKvE+OLhTOFgoxF9br5pEPPsvnnM3CRvfzMzERbX4mHk71kb1Ho
         6QdA==
X-Forwarded-Encrypted: i=1; AFNElJ+KuIklzCaD7RWr9fSwzAOV8QSN3dllFNOHFX3Gt9nbZl3OqN+g2XFPHx1e1aaxFWbCefc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjLhAh/JVeo3G6ViHIN66lEgc9yeA5Khvhl2i8vIc+eQaxKE5E
	blzpQC3ZhhHwbxyBb9HDfB379QmbwmneMpMT7Q0QQuFiekKnJhVtMwxcn2Yh0ls0hjEPX5T7vtK
	PwjZKMg/23F0o7n+naLW1z9iyDF0rXDFRXOGeowJdjUcMjjlNCqTkvUYAJZIBPnYaSWmdvGyRoS
	1PO8CJBYVFst7vtk7NmadW9WqtMzs=
X-Gm-Gg: Acq92OGTlr6IXvwNxMmvLnnnKDy+0eotaXabp4RQ9bcRTt0/j4hyHWVMIwKbm9mG8r2
	7fSrslMawUYLBs6h9auqKqam+xphllpcS09qPwoKmqbwjkYH5dbLzGw3w5AT+scpqx/18gsPERi
	VZSTfih1FVbiOEIbCaZtjsNm6/RxAr/peAF06xeW5/c9oDkiUqmrhpYolCO8LHwILkXkc0Rm88n
	9XtbIYkfdFK0Fxv3xR9Rg==
X-Received: by 2002:a05:6830:6810:b0:7db:b7ae:ef0b with SMTP id 46e09a7af769-7e7848a9e26mr96709a34.24.1781219279120;
        Thu, 11 Jun 2026 16:07:59 -0700 (PDT)
X-Received: by 2002:a05:6830:6810:b0:7db:b7ae:ef0b with SMTP id
 46e09a7af769-7e7848a9e26mr96676a34.24.1781219278679; Thu, 11 Jun 2026
 16:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-1-zhipingz@meta.com> <20260610193158.2614209-4-zhipingz@meta.com>
 <98b65e1f-1b5f-47fc-a4fb-0cdfab6725ed@amd.com>
In-Reply-To: <98b65e1f-1b5f-47fc-a4fb-0cdfab6725ed@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 16:07:47 -0700
X-Gm-Features: AVVi8CfN6ELCKVsJhBpTTQfWRh3GrCVI0SUXGM4wH5Fa1maXhiidrAdOyWsdUPU
Message-ID: <CAH3zFs1=CKtS524vU6f2inbX05JcyMi-5FouDxSCZAjNG0OUmQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] dma-buf: add optional get_tph() callback
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzMSBTYWx0ZWRfX7vf/UWU6Xt65
 YhqxkVetxk9jVN25AfXBtdlzIb9E7rhiC+PswINCWqSnnfrQnrUzqCALcIrROUM191oVjUolb8U
 1javyZEDaBlaxgUX7Ur2h/xMm34sf3OVVNGvBTogn/W8n8SxA+v+jKk1Tk8kWU+o6O1b8IKPk9U
 WCkCqkF/g7EV47v89NjQdofqOXMzGxuQxdFbGProNTfbfT8DZipyYFvWhPfKo7n9kwRT53HHx90
 4UBphP7Wr9cjxF64LU/1hx40pQuG682z6q3WBnT1gWSaDuA7R/ORQjQwq4sPKcLCWMVyde9lGwa
 mrO1VHoXaViDrdRjhC3+YA9BRcp23HvkBjwxRmcor6TPY2ed0CwcqsPT3pPmQBBZTWjq6qptaQZ
 aC/kG5M1l2ZmsdyTmYVH5/0VwWGteFNk1MjEID6QVW8bt/HLvYDZ6QbtF+DAmaiIl2+/vyJEbLT
 fwwhKCS4rCyuhVWgNYw==
X-Proofpoint-GUID: Vmjq0AU0G0PVo0OAGJ391zdX992uoaOS
X-Authority-Analysis: v=2.4 cv=U+2iy+ru c=1 sm=1 tr=0 ts=6a2b3fd0 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22
 a=zd2uoN0lAAAA:8 a=VabnemYjAAAA:8 a=Zb6pUuT0p51Zl8jFNtYA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: Vmjq0AU0G0PVo0OAGJ391zdX992uoaOS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzMSBTYWx0ZWRfXx41kWeGpz5mR
 MeEgjqT4+zyy+ExF01zMbJdM3wVFPSJ5zR18a5s2X/leULSRDUt2NF6LLkroYTWbWrRwFuZ5XXN
 XkJyGxYkC/3cco2ufKOZUl3jdMcv5+Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01

On Thu, Jun 11, 2026 at 3:35=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> >
> On 6/10/26 21:31, Zhiping Zhang wrote:
> > Add an optional dma_buf_ops.get_tph callback and a dma_buf_get_tph()
> > wrapper for importers.
> >
> > 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces, so
> > the importer requests the namespace it can emit and the exporter
> > returns the matching ST/PH tuple or -EOPNOTSUPP.
> >
> > dma_buf_get_tph() is the importer entry point. It returns -EOPNOTSUPP
> > when the exporter lacks the callback and requires dmabuf->resv to be
> > held while the callback runs.
> >
> > The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with
> > mlx5 as the first importer.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/dma-buf/dma-buf.c | 25 +++++++++++++++++++++++++
> >  include/linux/dma-buf.h   | 21 +++++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index d504c636dc29..aff79ea12e43 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -1144,6 +1144,31 @@ void dma_buf_unpin(struct dma_buf_attachment *at=
tach)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
> >
> > +/**
> > + * dma_buf_get_tph - Retrieve TPH metadata from an exporter
> > + * @dmabuf: DMA buffer to query
> > + * @extended: false for 8-bit ST, true for 16-bit Extended ST
> > + * @steering_tag: returns the raw steering tag for the requested names=
pace
> > + * @ph: returns the TPH processing hint
> > + *
> > + * Wrapper for the optional &dma_buf_ops.get_tph callback.
> > + *
> > + * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
> > + * exporter does not implement the callback or has no metadata for the
> > + * requested namespace.
> > + */
> > +int dma_buf_get_tph(struct dma_buf *dmabuf, bool extended,
> > +                 u16 *steering_tag, u8 *ph)
>
> That name needs improvement, maybe something like dma_buf_get_pci_tph().
>
> It also needs some brief explanation what TPH is, maybe a reference to th=
e PCIe spec name etc...
>
> And document in the list of functions that this one should be called with=
 the lock held.
>
> > +{
> > +     dma_resv_assert_held(dmabuf->resv);
> > +
> > +     if (!dmabuf->ops->get_tph)
> > +             return -EOPNOTSUPP;
> > +
> > +     return dmabuf->ops->get_tph(dmabuf, extended, steering_tag, ph);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(dma_buf_get_tph, "DMA_BUF");
> > +
> >  /**
> >   * dma_buf_map_attachment - Returns the scatterlist table of the attac=
hment;
> >   * mapped into _device_ address space. Is a wrapper for map_dma_buf() =
of the
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index d1203da56fc5..6a54e0f251a2 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -113,6 +113,25 @@ struct dma_buf_ops {
> >        */
> >       void (*unpin)(struct dma_buf_attachment *attach);
> >
> > +     /**
> > +      * @get_tph:
> > +      * @dmabuf: DMA buffer for which to retrieve TPH metadata
> > +      * @extended: false for 8-bit ST, true for 16-bit Extended ST
> > +      * @steering_tag: Returns the raw TPH steering tag for the reques=
ted
> > +      *                namespace
> > +      * @ph: Returns the TPH processing hint (2-bit value)
> > +      *
> > +      * Return TPH metadata for the namespace selected by @extended. R=
eturn
> > +      * 0 on success, or -EOPNOTSUPP if no metadata is available.
> > +      *
> > +      * This callback is optional. Importers must not call it directly;
> > +      * the dma_buf_get_tph() wrapper is the only entry point and hand=
les
> > +      * the NULL-callback case. The callback is invoked with
> > +      * &dma_buf.resv held.
>
> That most of that should be obvious, we only need that it's optional and =
that the lock should be held. Everything else can be dropped.
>
> And most of the description/documentation should be on the wrapper functi=
on, exporters who implement the callback should know what they are doing.
>
> Regards,
> Christian.
>

sure will do

Thanks,
Zhiping
