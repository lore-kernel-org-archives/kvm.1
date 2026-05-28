Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5121A680F
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 05:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779946524; cv=fail; b=k5tcVBgI/Q0nbc/mcFQ8Sg93kRdALObC+qQno0nBzltWkehbE/1Wl949uYgTkhzBULMZsRaKHyTjQ9QF6QIE5mNbvtvtgCOuPiFPw3YkCTMRCFyoD+2daIEvlBbMn2UkMk4yuEm/OGRY6ThpgIt/8suuMjAt+EtI5T0k/C9WH8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779946524; c=relaxed/simple;
	bh=EnANVMnjWO2e/TF4qUwEkpjdrKKtkAxRlIBS/3wsNFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pni6xC65thRQ/QfgtwGKX2TIleSBC5aO3W6WrhnHuCM+iAGVePxcE3sRix7/Z4uZ1/oi79YwQGKLmPZ47ejU+SiWTYo9cb5laeK3u7JFSMyEgTTanAvoTAqr1FCry/ALkwMZYJ01Y1lC1JfqFpOr9OWM6/RN5OGKOiiD49veU+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bg3I3NDv; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bg3I3NDv"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKjHxm4094134
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 22:35:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=4PCAVqJEOIY16WjmmTqer3R+L0JDJr0Ts1ek/LWm3fc=; b=bg3I3NDvy6FE
	iPpy9G16MrgkS7tjdaK4pTBSzqZEYYkSr5lSf8zBn87x/6ztIBfNAOzJnXbkITnP
	VFaM/GIefnYWYt6TOhjePYUTwpWHC8tb9G94iars8MRPC0B3+3Bv1ehGIH2uF3r9
	X+cCM1mir88Ht7erbVTrSkMQLajLsqaX4Ka+CzlrYNI/+3xJEgpfsUb0R2FOT8oP
	C+oZphQuk8kWYB+GKsZEiR3QK1YcNTIkHoPt45gLIQZGmdCOi/qzknAC5w6RIfgQ
	ucUNMGl3JC8eLuPUn4MPOudkHIaVMon2NrKpJ0qR7sanUhqV/uTqc+2Jx6QeO705
	BV/ccfW4zw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x6ac6e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 22:35:21 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7dcda4880efso15427514a34.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 22:35:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779946521; cv=none;
        d=google.com; s=arc-20240605;
        b=YrzK5wTRCnpFD/Gzygkt/D6+W3c/7VawhxiVXxDlxsJfQoPf91d+RKGhZs9uxb712o
         VP6+bTEF/OkK3KuvLw6+ZZizdCy/aNeUscL5bJEJ9Dvb2vXZiPYVY1yu/xW6AJzZBE+Y
         fDZr61pwTTd6uG8K3UeHMKgV6nZBA/8oYFfETWZ1E7yOBQzmWIcRTwxOmISelxRn4xwr
         9E6D165Ct642pzXk9G1hIk3vswfVqIk0nSQC8U9G/1iaWeSF7XbQ/YDoeS7CQONFDn2F
         acxozl47jzCRQm4R/Rqg2pzpMgP+yiRSEbxrtzC0CnHu2BxeUf6Adm0jyDPvgv8aTGKk
         HIXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=pJ6Y774MTUFrTACHvD9ZqjUGy6Y+0XLmHrPjxlbHslg=;
        fh=d+6lejwsbfhhedGadb+GxHE/Fx7pKvMkXIt3lz87ZlM=;
        b=KINQaQbjQLAjwVFx96ij+60nNzo6/tHFgXkrHvLSu4UerhSHpGiG0NxXiSdK7vGpfD
         DfD4lMAbJYha9zQgiaUsp2lS/vDn9l6AmQYCrQrrliZ/nc1idkmLAn3pxHbHoBIZtAXQ
         ki1K7/FIehBcyUfArLL8qh5WrM5SPaNtt1izd9I/7u4I/Gz2xn0kwM6mwz6xV8WSZKzc
         1/gy+NCfObYQZRVjF86lgizTl0CE2FSasSJZvs+CNaUePOU5YTGw890HoE786pS4XyEo
         uPPFJguhn/I46RJH5fnnzHJj/ExVXnonmrvwdpqWtuq88fakXshU/TFv65Mlrn+mQDOg
         raSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779946521; x=1780551321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pJ6Y774MTUFrTACHvD9ZqjUGy6Y+0XLmHrPjxlbHslg=;
        b=ijRnxgAlFIdjcFktPLYbqDv1S5uDkfD+N6lO6lHuuTU5PcLf+Sl2nBs2pXi3mmBe0h
         sjFQz/4y6+V6N7mxtttM04BeGxHDgaU4K7JH3+KfjWmBWrTZxZLXkgxJXF0LfoJ97zfJ
         QpjWD1Fo9aWAAQd40w+5o0g6ZhnhefoxUO4BOAtvbG0EpWnsm/iirdy9neTtxf5Dkl3c
         Zr/l8FgabbvNdAeDR25ANHsYOVLsbbx9apSRbJRp/oUYWFqFdP3e4+Q/A/0NvNIQazVH
         m7TuQaE3P8dhXskrb4V4849GlqpWZhwb0qD01PqvZofju/vmiaIkhSYSWDBlAfLQ+24O
         HyLg==
X-Forwarded-Encrypted: i=1; AFNElJ+GxEU0QWLR3EBj5p5E34BItQ+yBwgV2EZwJo+68PtNiBmYT+tXOBk0mu3In2wzfPNW8Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgdA6jBkFCYrzMwkMbtMS3dM97zBoHIieO2O0/JEqDd4QHCjQJ
	XlfcGMCFckUcjiBlkt9ICJ3FjFo9DaoUWP0FNK6ZvMrDWmpWoxOPvApXHVcJfml4tbym8ByDVnX
	0K33PyekKZ51x7uc6avGzpVEDh3rXVbY4KG5Uyc1RONGp+I+Z+qYaO0Bkt9nomtQG1WXy8ynS1z
	9jcXhs1dfpwALiisG25pNbexcGfJJFFl2Aa2k=
X-Gm-Gg: Acq92OHn6A1oYxH6tJD/LnMlneb9e1/GSpv++lXQ8uwMrRQcSvobhWYpQDUD3HT3Dcl
	mlaSNAnVJUSrpV8brY7O9mvTehZAk5A8lmaYz9IWQsVxkVHZVoxnU8hV/YXb82n6Cup4fEbF9m9
	gsK5SxyZyC8BN+MMF30DGZp/K+61hDFsPgi05XBN9Xf6g+rdQJm+LSsqdrmF8cLgMhH9SURX17/
	GHy+gHuqSBkJGndDw7tdUKMwcLORzDbsXQdSsUGPABZ9TV8Ftk=
X-Received: by 2002:a05:6830:6d47:b0:7db:b68f:b819 with SMTP id 46e09a7af769-7e5feeada60mr15174373a34.6.1779946521031;
        Wed, 27 May 2026 22:35:21 -0700 (PDT)
X-Received: by 2002:a05:6830:6d47:b0:7db:b68f:b819 with SMTP id
 46e09a7af769-7e5feeada60mr15174366a34.6.1779946520637; Wed, 27 May 2026
 22:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com> <20260526144401.1485788-2-zhipingz@meta.com>
 <20260527145332.30412ea4@shazbot.org>
In-Reply-To: <20260527145332.30412ea4@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 27 May 2026 22:35:09 -0700
X-Gm-Features: AVHnY4KV2jkBImuet_2z0_HzyoNlAKuwWC1jyQGu9hjYNIH-m9ItRdizP-UfkeA
Message-ID: <CAH3zFs3Yv2G0rQNE7x8DjBWPE+3sFC_3X6ZtF4x-mPp==h0BQA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] PCI/TPH: expose the enabled TPH requester type
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
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: PCbOPOSbgG45ddWImfWJOUvn3hnqxQC3
X-Authority-Analysis: v=2.4 cv=TdymcxQh c=1 sm=1 tr=0 ts=6a17d419 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=Yn1Yo9TDUEbBsc1NC8sA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: PCbOPOSbgG45ddWImfWJOUvn3hnqxQC3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA1MyBTYWx0ZWRfX9wtAyX52nVrh
 YFr1rBvYVj3syd6C/Q+VWlhLfxlQ2Dg1fjTz9a+dyj0bYS6cQaxjJzvAF/aRvuzz5jf3ubDEOR4
 jiSypHYC6QVeqdbwzy3ED0RFRTVyAB4OCDfAaaCMkGYi04SNFxJBZr3ltJxRXpsVYCI+0+yGlwm
 xFoBI78BrpxkujMWNeosAVTNm767KWovwC+ccmEH5qeu2s7Uq+eqGpyst3BZmWJlx3K6KjmURHO
 fzRXkydqWdd2hN5T02FJILFXZPr8S6kpOCySVlX/HCWcQio4pZibBviwZgbWyU1TciRLAUnqJCL
 pMuYD4lmUi+RfOs3jd4LPexZsHAY93rvaauTY0JzVpSHs6azOMyf0cW+URphuTKwOGV2wsAxzsA
 tfUbng8L72+HBI+nDasbEwWw4/qXgyyQ1WyafBCvC+Q26IBbKD/Vz6HLkxteCj8W+6BNGOPIX7L
 vQ00SI41N1zqcpOrlRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01

On Wed, May 27, 2026 at 1:53=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Tue, 26 May 2026 07:43:53 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> > requester mode without reaching into pci_dev internals.
> >
> > This keeps pci_dev::tph_req_type inside the PCI/TPH code and provides a
> > !CONFIG_PCIE_TPH stub for callers.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/pci/tph.c       | 12 ++++++++++++
> >  include/linux/pci-tph.h |  2 ++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> > index 91145e8d9d95..6c4492075ae9 100644
> > --- a/drivers/pci/tph.c
> > +++ b/drivers/pci/tph.c
> > @@ -174,6 +174,18 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
> >  }
> >  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
> >
> > +/**
> > + * pcie_tph_enabled_req_type - Return the device's enabled TPH request=
er type
> > + * @pdev: PCI device to query
> > + *
> > + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EX=
T_TPH.
> > + */
> > +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> > +{
> > +     return pdev->tph_req_type;
> > +}
> > +EXPORT_SYMBOL(pcie_tph_enabled_req_type);
> > +
> >  /*
> >   * Return the size of ST table. If ST table is not in TPH Requester Ex=
tended
> >   * Capability space, return 0. Otherwise return the ST Table Size + 1.
> > diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> > index be68cd17f2f8..fe572737b409 100644
> > --- a/include/linux/pci-tph.h
> > +++ b/include/linux/pci-tph.h
> > @@ -30,6 +30,7 @@ void pcie_disable_tph(struct pci_dev *pdev);
> >  int pcie_enable_tph(struct pci_dev *pdev, int mode);
> >  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
> >  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
> > +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
> >  #else
> >  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
> >                                       unsigned int index, u16 tag)
> > @@ -41,6 +42,7 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev =
*dev,
> >  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
> >  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
> >  { return -EINVAL; }
> > +static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev) { ret=
urn 0; }
>
> nit, s/0/PCI_TPH_REQ_DISABLE/ for consistency.  Thanks,
>
> Alex
>
ack, will do.

Thanks,
Zhiping
