Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590D632B102
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015963; cv=pass; b=gA3RrUp9wj6OnFkuEtaPeqYtX/K7nhjHpkzxjI8gWLr6Oj5vyo9XluEvkXbMZFosJTkvEYv3f5rAyYINHiLJpA0PCEGt+y+5KoED1jjm5HOyd13ZntULtQxeZiPWe3Q17LZqzqv4Sj78swTIMB/d4wA1pxJef4NqEe2uasfWmq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015963; c=relaxed/simple;
	bh=FbYR/k8DLxlAf8kVof4hhiKT8ECF5Pd8+LC9O69NXFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKiYVSy/0lN2no60hVGryzMHsOa8bmhYS6g5fowyqCIpfVLCb7+LCT/dB0f7x0MGHuHL8li4gTjvbVI7pq5noYAOT9O16awIMtOTrUG6vVBddpw8LgcJl6zoI3c/00EDeCXUPOCrBHGctYO/rgrKd4bE2rIAPH3DskwAqtU+Uj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bofmRsKL; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bofmRsKL"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659CQNB41458505
	for <kvm@vger.kernel.org>; Tue, 9 Jun 2026 07:39:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=kNeH4tXtKNJiFBFWJPRK
	N1EPfU64g+YPkV/H/UdFhBs=; b=bofmRsKLK4osQcAFWiwXbtpr69w36y9aEPuV
	DGBeGSJClR6Iux5v8lxlgpMiVzO5x2Rc7XvV3WDDGERk1A0vudeYRpxUQTgVJ8FP
	Vp24tp6sGkRRtgnEWh5ISlm3X8w10Fv5cHFadx3zazkv3Puh6lk2WAALivP4RcaP
	osrasMZGfR98HjII9TAhAiRWO3neAxrV6MDSF+gSO8eKfKkKXqCwiEoRahlhPycg
	4+6EMm9OA50YdVt23PeVBTNs8CTpAfdAPGVGJTNzDE3Lz+aVd4fRXAzpSV2n29Ro
	DBqbIiI7haSoaEF0q5UsONLcNWq3+7vIqLg83UvH33HJ3kZ2gw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4epju80tqk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 07:39:20 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e74781faaaso2882180a34.2
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 07:39:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781015960; cv=none;
        d=google.com; s=arc-20240605;
        b=hRN4EjZTB0beNWBcu94jtmBMJqjguLFTg4bpuL9JkcpqRdymYyL6/ojM/JK9/QJc+c
         5fj8qWHTTRebRipXdQ8LKiyMeytDG3hmuixhKBjU4uGYlOu561OlTEfxKIlER6gP8mbj
         q4PDNez35033VLa5C7UMdtcUL5Pw2iCLmC3xQOFuecfJmZV6yILrYKy2tSep0mikAW79
         UtRiidf+a2pzReNzDuW7vB7zOQL9Waud0uq/2UPonYRvTcv03LS79ClJpMGcbCTAqatE
         7VhORpVX9k0ClFL2dz8qrQav62M7yAIwQsoxEwm/D3PRR7JCpp2KZsgzMFyWVLl3XJHb
         2ZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=kNeH4tXtKNJiFBFWJPRKN1EPfU64g+YPkV/H/UdFhBs=;
        fh=rzwNU+8nfWHPIHPlWIAhGB/WW0xJ2aJ4e8ByImoj45Q=;
        b=WKmASy3B3Ti4lQTK+ei/RhCn7POaEBaeTJ4/+fiOyBt3/cz2hrzBJU64uMcEeQv683
         yHi4U/NfDSOIaDQVBDA0AOc9qwAtHmtfMfY4JbtCkhJwgeCH7VqCcdEO4F538fF/3P1G
         iWLnYxPKBZFjRMQk6FqPePVGrkBUkvw8F2FSzbd0KQhNzxQgiChCKAyB3WMm31/vp6Lo
         /CfkaHcW4XnUghUpcprKHhpHN4bFuDc4G3R6Z8tmzPR43WMjSfcp/jBb/SSXTHiFJU9n
         DGW6RhQ1Sq9ZwTEJjZXM//wnPwggFOSZyhdbo2I/iL5qIk7UCU3EcPFRVZq16jQNe0vy
         Mldg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015960; x=1781620760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNeH4tXtKNJiFBFWJPRKN1EPfU64g+YPkV/H/UdFhBs=;
        b=E1E+agPWu7U9+VeqJX/hzdwjJDKKFBrvRLFAKajwk5L9kct2nTUpMY2+yH837+57AV
         OCayAPlt7Pmo54z7r2/iSv9fxJXp8gaCRwGoYThK7Es9e6XKSsBHQh7f/ndzTo3HuwrL
         De2P9rUrS0SdIL71/BPEbx03d5bfz2HLkYropfN31VmJ5fdcSb6EjPRl9k9UPkXatj/A
         krpNgpS7PFJGrcRwY4d8WCtJa7T0a85fWCM5SwJnKeHCKlZTkWZ665UjAUjQ0B2afNdv
         nPDK99ru117frsVDe1f3k1LcAGxcX4sdpT4ZhdrD9+52WRzjrY114BstFyYi3cJhwNt+
         VvGQ==
X-Forwarded-Encrypted: i=1; AFNElJ+G9wm6tIjjchkicS1r5bBSPnjWLMOHZUcfPm5l3a4FkhTQjbyGak8M/13sgr2qPDzjc3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy70brid4ciIHO6V07ds0VSIH9KGA9LHmftgPLeSC1V15cud7a8
	8M7EAqkU5kXZ+0P3e4JjiRZl4f5e2XFFssHWuCSN8FXwbYtKQo6YtgJ69T+pwMV3zX9ETE0g4ch
	9f9txmhHoVNCwvVU+TRgSbjMtOUJeI7bYSVj28VmEqGs0baPCdPnfO0bLBaXoOSQ1G7oTd6gox5
	CBpZoaW9eduqiNNqq+XecA7bkDJPE=
X-Gm-Gg: Acq92OHhEguRdCB/bI/rfV1aOwC7d7WK41Wvyu0DLEk1GZ+YjFhiStpZ/gQo4x6aKkp
	vP69YP8GH/P5YGW+XHWWad20p+Oet1YqAWqyLFsbmlKFUHhWhaOXy72MCMOSbzDvHEPoB5dMef/
	4sms/FmVFUWn3jK0c+BWnllj32uE81gNxWOLFANSWbifZdYmsEPfIBtJ16IbK9qKCFDxxoFuX/u
	hP8JI43TUkfUi0g2wpsVZDg3KCe/4aeRw7RNN5RSg/2poCBgt4=
X-Received: by 2002:a05:6830:67f8:b0:7e6:ed97:ce6e with SMTP id 46e09a7af769-7e70ca3ef99mr13168180a34.19.1781015959844;
        Tue, 09 Jun 2026 07:39:19 -0700 (PDT)
X-Received: by 2002:a05:6830:67f8:b0:7e6:ed97:ce6e with SMTP id
 46e09a7af769-7e70ca3ef99mr13168142a34.19.1781015959353; Tue, 09 Jun 2026
 07:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608185646.4085127-1-zhipingz@meta.com> <20260608185646.4085127-5-zhipingz@meta.com>
 <fdf1bb37-7158-46a0-b6a2-6cca0ac7ae20@amd.com>
In-Reply-To: <fdf1bb37-7158-46a0-b6a2-6cca0ac7ae20@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 9 Jun 2026 07:39:08 -0700
X-Gm-Features: AVVi8CcZCg6NF1_DYHadZzneoVcOoxTF9hqIosFI2rLUJBAF8tno0qEb8k4EdV4
Message-ID: <CAH3zFs2FtVN9LZw487ei6cs3AMwh-30jRHenn3X87PAkZ8CmRA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
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
X-Proofpoint-ORIG-GUID: K-KyjvHYBIZv8eCq0Z8UkYdq8kSxVfa-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0MCBTYWx0ZWRfX2Woxw43EFo7T
 wWFjekUG3zCNGY51SsARWDkGFVILPN39OV1c+z00RpPxdOjmnmvx5WZbbMpV2+SohtzB3ccGBlm
 97QnwUv7/Ir+JSzoof69f0XICByyqPLvDCLr7N/fyH1F8PnybeAgmuzBAMQaQJfsM9/E82fjM0R
 MDCMetFt5SdtxFYvt3YK8S3GstnESIKVdY7kTCPnnZ2pnnvKkN1OeUY75cUv7HPL7/Tz5kHB4tS
 03hWu8fxd2RGsYyrUq/Okz7pUe/kejGshXnfp7x6rkmTo1GLCjsuAo8ASA061amBYP1i+zcZ1jf
 ZoY24J7xqiIWm4O8l6FtLv05PQwnvzvBMIXwdloOP2f3Mj217nlHAjCNzrXcRI0FJKQA9/ih3TC
 pjO5y5ce0gk8NL23Fq8iNJYzrk1BLqwEJ+uMupxw9CqTv3FsyLgRDEKKagSU5Job7ZWQGt9vx7K
 Op7FtNav0x+K7ljlZdQ==
X-Proofpoint-GUID: K-KyjvHYBIZv8eCq0Z8UkYdq8kSxVfa-
X-Authority-Analysis: v=2.4 cv=cr+rVV4i c=1 sm=1 tr=0 ts=6a282598 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=zMbl56DWmGmIhi6d5aIA:9 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01

> >  drivers/vfio/pci/vfio_pci_core.c   |  3 +
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 92 +++++++++++++++++++++++++++++-
> >  drivers/vfio/pci/vfio_pci_priv.h   | 12 ++++
> >  include/uapi/linux/vfio.h          | 45 +++++++++++++++
> >  4 files changed, 151 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > index 050e7542952e..4fa36f2f7555 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1569,6 +1569,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
> >               return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
> >       case VFIO_DEVICE_FEATURE_DMA_BUF:
> >               return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
> > +     case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > +             return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> > +                                                      argsz);
> >       default:
> >               return -ENOTTY;
> >       }
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > index 1a177ce7de54..dd11a7db6b41 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -2,7 +2,9 @@
> >  /* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES.
> >   */
> >  #include <linux/dma-buf-mapping.h>
> > +#include <linux/mutex.h>
> >  #include <linux/pci-p2pdma.h>
> > +#include <linux/pci-tph.h>
> >  #include <linux/dma-resv.h>
> >
> >  #include "vfio_pci_priv.h"
> > @@ -19,7 +21,14 @@ struct vfio_pci_dma_buf {
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > -     u8 revoked : 1;
>
> > +     /* @tph_lock serializes TPH SET vs get_tph on the TPH fields below. */
> > +     struct mutex tph_lock;
>
> Clear NO-GO.
>
> When that info is exposed through DMA-buf it must be protected by the DMA-buf resv lock.
>
> Christian.
>

Understood, will fix in next revision.

Thanks,
Zhiping
