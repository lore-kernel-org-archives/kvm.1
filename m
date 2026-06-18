Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC2F331A7E
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 06:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781763055; cv=fail; b=X0QXV+/IFzkDiajSJrIMpiPUfbjCZjcupU9bgcQoSAwlNv2tfuuwr+9y7jvk95MW1ufTkAN82KZV7S5Fq7Pdr3SUkXKewKQAPw1IL9Yh08E0Qtw+D7G+XzkpbBJLf3bWFNfmBzBjbEA0vvZ0YHb3ENaQq/xPnhK1McvvG7GkCkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781763055; c=relaxed/simple;
	bh=aoNXmADJPkDhnZOjZgCi5nKSSN+hSwva5gE5EhTFdSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHXSHstKJjmoVt3JRQYbdcTk2kLtkARVIYHRllppzy2Bbv7HPjlIDUzrzsyib9pVgMo1RzFEQBz8NXv8sceG5yASEijmff/T8EPhGIQQd3fOcOo3bJg1Ga3ySi+JFTscYPbPwurQ7ZViGeTlQXrmaRXU75bDB23E7jbLLCpNaRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hEbHoDIc; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hEbHoDIc"
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I387AJ1835251
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 23:10:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=g5sz6xIN2DOx/R49RD/V8A7DarhSxstt7fwwKkQBLVw=; b=hEbHoDIcNNBH
	sZQV9mk7PiiboxdNzb2rNmI7KBN6NuhX/NwRqSVyxP5vjpQuiVqvYgDlAsy9Zdkh
	Tgcyc7uRW8eAc3fozG8JcWlf9hfVD+uBtdLV8+caTR1qKSIE+88Ezoo/MJ3rmGyC
	jcejquyAHng7TfyGE3Z4rqdgnkiroTqWLpuu8qmFQoHaV8tG9ZP9WEMDZVWQKBJm
	bFqMqdhR2XWBGl2F6B6sIHCBRl+9WgPa7bchX/8lF9rfzbPAYunO2eH7BQStVytC
	3EGL5UOGoab/Pt1Tfkhveb6OOhzXos1WVdxlfCazGkh3Yrd5JWZz6c9LG9zbg7pd
	DI7ZUVO+Iw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4euegc9xdv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 23:10:53 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e6fed63fe5so894090a34.0
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 23:10:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781763053; cv=none;
        d=google.com; s=arc-20240605;
        b=ijPv55/eq57Jglv9mVEGImgEQamfZJfJkjXVTlY/hP93e95mE2uEs3xkJGNsxThN1y
         tW9Z8hvVgrxqW6K5NolVYOVuBeA21Wk8b/aEi3s7kTTvbIrETdODAU3KOMfeW+Dp6zQe
         I39blQNTktp9R0VXKD76OBH56pSZSUEQfTVyeU1qeL5Q94FQkhMM/34sHjZ/JOTEGHdP
         PvEi330QENZDOWmhZTVM4f9jXYJJIHpyFnloxoGExV7KWE54D9rcmwr+QOB4wZx6oQUE
         Fj046/RLS0sBgf11MEPSr5PvLzJptqHPoxgKdkU1U8KTTevvvb2wBGppyXgMZKL1hqKw
         XddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=9Eq8HAHlBMSmfq0hKVbVZbpTCPzs57KvCvKHerONY4Q=;
        fh=eYr3MWKM0ktV1KKnYdSbm0Pi53yKcXeCTo0lZxuUUd0=;
        b=Z02fmWEmgIIscXmgSmF9lPrPlBWlFV/d+w9nJLUg/q+8euVUZSz7uiRm/UPk2AlJ9O
         u85VcNpYwkqfoBhPomCgpFzP/nuqsoVb2p9vzDE8vsnamwbodiHIS9Jn+i/t3FVnILHW
         bgoaLZna6UME8TkHzVXC4SecJddBtK/pgEKmOst+/BJ/rCMwYTicC081UUGoZlhqOc2g
         7hxwfBCZY9wlU1/1BfFK8gomm88EiqcAEYSrmcn/L4tyQWMn0uoXvfro23lWu4kWNfIv
         10N0VwQ/lElLQQNS+CAV0sAk3TJoKmzhqEbaBs0CQJmwaEIQAEehvfRw5mjbbFvFM+mb
         PMhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781763053; x=1782367853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Eq8HAHlBMSmfq0hKVbVZbpTCPzs57KvCvKHerONY4Q=;
        b=lsH23KVcZHxbySw3D9xf3ktMqE8+qDZP4ntteS5r3Gy572aocib3CpVFTUzX6Dicrp
         Xyntzjpqh8xX4+g1gElxGqyhVtuxvRLuBU3hKI5YkkwC8+qNPNPUSjQB1c/oocnbKKxh
         5NmkIAzBmz8EKpQP0QApdWx0SyRGf4qegJE4xIbyHAdX8jMXbnV1MtNUtJf0zh0zV5l4
         mJq5+WGl1Zm+2gJE+7na8rgvc4fO9PHKRDnq86ldaIIb6tzLLl2W3CpMv+yaOrjbhxXI
         VDdTivip4rjDtiLcUqDsXIO03317g1sNZPOGQmZikeqHE6gcXBvYBeqSk2Xh8jTO+coC
         qeGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/WbfkYCOGw+BfUqTF0PgxBTrFqi2tVhHmzq5rtMACnmqPXxiFBkYhyd9vusF0wjibayac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtaWhICA/KIRQB8F7g4fHkpSjlZHB6IMsDBYdlDoKy/yv+wAKj
	Bs7xVCQBWTn+4aLRiDLyepkXE1AJwFHMBtOuxn+LEg/7bt5Q8jLdf165PIw0dlv1WnusgCeZIgd
	N1bLOHv85DOq7URzMwondu4CBsULFaMFnoRyT6refQdOCvwl2LgmKOIRQSbJyHG6u95wwHRPAB/
	u4cXQmt4pgqlUpOVJD/SQixjj65eA=
X-Gm-Gg: Acq92OEIMmczo/Ievhjfba0Gcbcf1FQQRRdbaeOlPv8zJGKsVyY8EY37J/rmdNJdEvR
	nGdhBWtt9N9VI3zMPd3/dGEATFHBMWOed7PkcjsAL5s9iHSMSyY+tu/E45o4Omo+TWeiOzddYd7
	J/Sz1dA/zwqqCATe7i76x6/x66aCnoRpCrI1YoH1eYEvGzw6blKXhdO+TM7xjN61ojJdnzU8Rh/
	6g/6+Fv8ppOM7M0FvYWLG9vLWTjMw==
X-Received: by 2002:a05:6830:4119:b0:7dc:d725:fdb with SMTP id 46e09a7af769-7e91ac6d2b6mr2060568a34.8.1781763052707;
        Wed, 17 Jun 2026 23:10:52 -0700 (PDT)
X-Received: by 2002:a05:6830:4119:b0:7dc:d725:fdb with SMTP id
 46e09a7af769-7e91ac6d2b6mr2060543a34.8.1781763051390; Wed, 17 Jun 2026
 23:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615065912.2177918-1-zhipingz@meta.com> <20260615065912.2177918-3-zhipingz@meta.com>
 <20260617094113.GU327369@unreal>
In-Reply-To: <20260617094113.GU327369@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 17 Jun 2026 23:10:40 -0700
X-Gm-Features: AVVi8CdOrBaOwYRxFRdDVRsJhHRei-ObhsXGhIoQfKNO7YbBBbYe7t0f7TbFl64
Message-ID: <CAH3zFs3wBwbmvEMp498LTdbrSt4Y5w7PNpqtcN_L_vHdqsvnxw@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] dma-buf: add optional get_pci_tph() callback
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1NCBTYWx0ZWRfX/uVIPYAQk0Ev
 zWeesjFPTDdKXigtjuF/WR7re0EB1Fjf49upcXbfD9tB4ec6FoZDJsHimKQEgGHMYQL8YpU7TPA
 YLcwIxpboFK3wR5Oz8P47kLuvgLuW9Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1NCBTYWx0ZWRfX9TPB32ysvw8s
 NCUfib7/Dggdazp25nC/UYomaUvRaJYps/+2NbCGyzHSNaECLTOiJgBipMqSXUxBgj+Qo0rk4NA
 WMupdyxnLRq/WdFE1S2hhpPloe7iXKeyKiUbmo6SxITeUYYVCUPK5uO3S0IEieW6FRY1/10VtuQ
 /tbQ6NvVGM53Y9wKd55R2G19ERAh8BtgsN263g3ZFeBdRyM5ZwDlySxJaEpCk2aIFZlilaCOV1C
 TM8XpOOtxOzTC0h64UCGXSsktA46EM5FpXy0ZDzOLMyNyKv4St2zWihlEha3Yr+FbGF098X2kCf
 ka1QDrnDa4hNMgNIU4vgOUXVrcsdF6A/JvnFQ7qHnzjeUJIPZWGuVfccJ437hy8479QdA30cCjH
 iF9MlF+6E64yKukNtfbKYyT9RVLIqqP7V1awUx7/6Ko7ioibouTmX/YZyLYIPi0uQuD0DfP4IcX
 GZXyhAlUPQNRpULUomA==
X-Authority-Analysis: v=2.4 cv=cMHQdFeN c=1 sm=1 tr=0 ts=6a338bed cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=IaYQQxp-055UKQrtbooA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: uglA44xk5Vd1BlHUQef0AWOD8LSjelUS
X-Proofpoint-GUID: uglA44xk5Vd1BlHUQef0AWOD8LSjelUS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01

On Wed, Jun 17, 2026 at 2:41=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> >
> On Sun, Jun 14, 2026 at 11:58:59PM -0700, Zhiping Zhang wrote:
> > Add an optional dma_buf_ops.get_pci_tph callback and a
> > DMA-buf importer wrapper, dma_buf_get_pci_tph().
> >
> > TPH is PCIe TLP Processing Hint. 8-bit ST and 16-bit Extended ST are
> > distinct PCIe TPH namespaces, so the importer requests the namespace it
> > can emit and the exporter returns the matching ST/PH tuple or
> > -EOPNOTSUPP.
> >
> > dma_buf_get_pci_tph() is the importer entry point. It requires
> > &dmabuf->resv to be held while the callback runs and returns
> > -EOPNOTSUPP when the exporter does not provide PCI TPH metadata.
> >
> > The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with
> > mlx5 as the first importer.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/dma-buf/dma-buf.c | 25 +++++++++++++++++++++++++
> >  include/linux/dma-buf.h   | 16 ++++++++++++++++
> >  2 files changed, 41 insertions(+)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index d504c636dc29..7a4c9b0d5dab 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -1144,6 +1144,31 @@ void dma_buf_unpin(struct dma_buf_attachment *at=
tach)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
> >
> > +/**
> > + * dma_buf_get_pci_tph - Retrieve PCIe TLP Processing Hint (TPH) metad=
ata
> > + * @dmabuf: DMA buffer to query
> > + * @extended: false for 8-bit ST, true for 16-bit Extended ST
> > + * @steering_tag: returns the raw steering tag for the requested names=
pace
> > + * @ph: returns the TPH processing hint
> > + *
> > + * Wrapper for the optional &dma_buf_ops.get_pci_tph callback.
> > + *
> > + * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
> > + * exporter does not implement the callback or has no metadata for the
> > + * requested namespace.
> > + */
> > +int dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
> > +                     u16 *steering_tag, u8 *ph)
> > +{
> > +     dma_resv_assert_held(dmabuf->resv);
> > +
> > +     if (!dmabuf->ops->get_pci_tph)
> > +             return -EOPNOTSUPP;
> > +
> > +     return dmabuf->ops->get_pci_tph(dmabuf, extended, steering_tag, p=
h);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(dma_buf_get_pci_tph, "DMA_BUF");
> > +
> >  /**
> >   * dma_buf_map_attachment - Returns the scatterlist table of the attac=
hment;
> >   * mapped into _device_ address space. Is a wrapper for map_dma_buf() =
of the
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index d1203da56fc5..5e7b69a40f3d 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -113,6 +113,20 @@ struct dma_buf_ops {
> >        */
> >       void (*unpin)(struct dma_buf_attachment *attach);
> >
> > +     /**
> > +      * @get_pci_tph:
>
> There should be a blank line after the line above, along with a clear and
> concise description of what this callback does.
>
> Thanks
>
Sure, will change!

Thanks,
Zhiping
