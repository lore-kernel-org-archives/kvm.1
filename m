Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6D83876A1
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061847; cv=pass; b=Lee3ThtOtRyy6zgLFG6Z0OOujAh+4lMi1Gbjz5x6jKACXgWU1AcHHjNKUrJvmKUtdsYI2u5dHEaGK3vGDqjzKPiLCjTZdWJh/nN48p0JIA4piZ9iKm3pMiw0WQxiXr1WgsqduYZcpv6vb0v3V05skngjLiLb3EgGXwEjTh/A0lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061847; c=relaxed/simple;
	bh=dSdsH9dksi+uHV/fTw6nPqI8igLABzvcuyiyNSlvbvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvkoqIKa0cGhFU2HZFPlssauwdXSyEvYVpH4aFglg5ySnxusZfk5WbjSslAW73kF//tlvzXoMo8HuQ3cGszBLaES/chD04mlHN/U4Mev8Sk/Qwg5oRwfPuNybhgDMayUIXA7bzEFVhjMkv7BbIG3adq4LPlCV0Ag8KzchXfUscE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=C0z5ENmq; arc=pass smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="C0z5ENmq"
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635tMNH1120261
	for <kvm@vger.kernel.org>; Thu, 2 Jul 2026 23:57:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=1ooYXEhr8R5Avu36PkA1
	fDBaUkP8RkT4tBNox1TcVoA=; b=C0z5ENmqDzbJ1NLEJsUJo9CQ3N/uTO7VUwp4
	kfTj0sxCwlKtZcFAbfH5EzA4i/QyE7hzmnXKp60uoJGQ6MOgjGVYxymZs1LzEGgR
	KK/MabO62rFu7yFaRhdUXbWVs6RszHi4Llfrvj+O2Ur3DURJFa0bbiYbtGGtmf1S
	48+CP9y9ZSyGN4WLNaqbVQgnwIsdkrlxGhdYdoaiAHm7xF2MwkQzJeva9fd6d3Yw
	oQ3EMU2riwO6WaSrWDjGw+BApAFcAp1tWa/vlThjMXh9zmTVaUOIm+H2kTLvSMGL
	86M/qI56en4xsmMLOVp5WIYEay69OIWSI0Mz0mScKxmp2zYwIw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f65u9rns4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 02 Jul 2026 23:57:24 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e74781faaaso333122a34.2
        for <kvm@vger.kernel.org>; Thu, 02 Jul 2026 23:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783061843; cv=none;
        d=google.com; s=arc-20260327;
        b=qSdZnHhgKYluWOL7qYqc0q6kjuG1a5L08cZsmXhFlYnBfPCYSbqRpk7VxcnVzDBrTk
         QqYVJ+iGB85yLh4nsUM6Bb9odRxdw81LFicNxLsVX/bldiyzJIgiJ3PPFQ0LynfkLAtC
         yfo9QP7qA7Eh54cSq5AiSS5mhTSWeSWBGc2Wx5MLduZrmI0aeNVDRWEp4L9WVWjdhdrg
         qV+mTFPezM20NbERNUMDpAi9Zpliq622NQqc1sisckMdtlxlMb/zG5c+EEswGCS/4jlm
         V/Spo42eaIu2Lfzxp9V/URqTyP0rwn0Tdhufb429dCCcUmT+Xlm8XsGRqdfrhUFAoZpZ
         kp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=1ooYXEhr8R5Avu36PkA1fDBaUkP8RkT4tBNox1TcVoA=;
        fh=z2hrDkzt3AWqqmTfMl9+aKdJo0yhqhbt9jauncZdKkc=;
        b=LlKmu8GGFJblbXl6lM/9PgfNfKLH9dxcwu3q1NcGkiHZ0kzqZNhSo0cWabsJkP6V3q
         6+uxbvEumoHhXuDHggtXSPBVKZAtoSAv0dDS80iUTgLQIaXPtHLJ76uxP5JUaMJFgVHw
         7a3vBuS0O6lNkhIMX/VjRLwccQOITAPbnMEmf54rLtzRSX122j/MTp7Pqfp4T9R+4Tto
         Fq17maMTWn/n5Rv9bjmq5MQeHdDRik0qqFf0DXzNieHaPL2j7ekJ1ZzRsuM88sV7HHur
         Qti0+VnwRUl7RgecX/hKQWctmYkNfThFOLi8hXWrSldyXaLZqn3nxu7OulwM8EJo1Mvj
         yveA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783061843; x=1783666643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ooYXEhr8R5Avu36PkA1fDBaUkP8RkT4tBNox1TcVoA=;
        b=Zsene/rREuPzPIaOh9SlDYjpOD4EJWtkds0TxdPSbE+3rIAPOoxOX1EnnIsk8gUQ68
         2Q9ycTwPMeKEzAiTQG+jaglqcITHMnWU6RARc3fRl6X9iIePfYKRxkBAXpdQl+g9nqBL
         OLyAX380ZPrx9ieU3I/7nYMn6MoVeg0w34er1kpylX5xvCkfeAPjgtn0ZzqJ+Hi20PUw
         bEXdV4ju3RwnLyrsTAO1R40Tr1dU8si+0CSZ45cM1C92Q0cqGgmeq1gyBPQiMok15plz
         wiGbwYhm/bSi6OU5l+oiIi+Z7kSWq16I3b18MjrNfGo1lnQilN5AlPOMxyndVmJNFSV6
         f1ww==
X-Forwarded-Encrypted: i=1; AFNElJ9R0FsYhquxhpBgPwBnaim70Cqr26Ff6T/jCcQP2Jg3w2FntVOpxJejVnjfFfffPE2QEAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc3iDejx8fJLt7CKJSN1hSwxySWnrECVL8tiBgWZYDwckwt/j9
	SVZpwbjduFCqpWsxeGDKYALsft6MFvRxRVdilrYdiJwN87iS4W4/vr9PyieYfqXi9kMGRREqVqw
	K23Lku/pIKeXNQLppTFJsGLbmik9DLjPID/HMvz1+bK2VsbsKsck3IImEv4J0Yh0JU5RxodfMtO
	FhBciMRBdYrp048EZ+0Johi3iq420=
X-Gm-Gg: AfdE7cl2HqqAinpgjG0sW1i7iAhA2UjXQBSVN+qo8unvdwa9rQ01lPxBW/lQ8ZddM4B
	7ENfO0A7VlYRl2eSydyvSSsv6JIQXWkX7EpX/T8Cwv23kewXVjTMvvJXE/Hz5OhQluqnw2FabKl
	sK/Dw01fjQZFG5JeNb4Kh6xwckCYc3fe0H0nGeqf6fiy9Fjgf/QVBO2WUW56MSOIAvYce57kbCZ
	d049skfIql6AAYRhU+BoKNFXC+8vg==
X-Received: by 2002:a05:6830:82c8:b0:7d9:d2b6:1568 with SMTP id 46e09a7af769-7eb4cc26248mr5970985a34.17.1783061843333;
        Thu, 02 Jul 2026 23:57:23 -0700 (PDT)
X-Received: by 2002:a05:6830:82c8:b0:7d9:d2b6:1568 with SMTP id
 46e09a7af769-7eb4cc26248mr5970963a34.17.1783061842839; Thu, 02 Jul 2026
 23:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702181025.2694961-1-zhipingz@meta.com> <20260702181025.2694961-4-zhipingz@meta.com>
 <6ab4c781-2409-4015-aac1-01d5cc1b9f6f@huawei.com>
In-Reply-To: <6ab4c781-2409-4015-aac1-01d5cc1b9f6f@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 2 Jul 2026 23:57:10 -0700
X-Gm-Features: AVVi8Ccw8yAXcsgDvWHGsVO2xij76p-6UW92x4FC6KeN1aOXDWOhO-jLzIpoK30
Message-ID: <CAH3zFs31yd9uyo3waOT=SxCGaKGBfxdAv2XDQ+9dQyuo-cCV3g@mail.gmail.com>
Subject: Re: [PATCH v11 3/4] vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature
To: fengchengwen <fengchengwen@huawei.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA2NCBTYWx0ZWRfX3Yy5rvSUYYQV
 SugKQ6dJid/q+6vMZ9VCwA8kDhRWpkwTNADGicd/weR0p5ZwM8Jwhnpy4vmw/hqNgfCszN4V20Z
 LteiFYpTuggS5W/BZM3Eo/yuuFaP5RM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA2NCBTYWx0ZWRfX+Uyxh4qzuCjZ
 p0KFmwjU0V6GU3jwE9iBWT85RO11/6NpRi7q/PlS5cgYqVa/RcwUOKGJfznev96ZSXgn1U4i/5D
 tOhUjE3gftQY2H3bB/dk2oYK8M6LDQJRUM/0qsO17GzIHOY45ze69yWPANNiP6GBI0cUxPaF+yi
 HAco0aEcAqhfdGh2HwcKvVPSGWDaNGYVm1D5iTBAHrKqgn+mjcyyEN/HanHe1BowBJPXQgiX2eF
 fl/9QyIW2211rik8h8VLk6LIzA3PNeD6UQymb2k7l3XCACauu8l3FNiC4YxlC5TjYkA6vlG369w
 hmKUjVA0155T0kQPad1Xq8WGrNL8aE4VK22Pvywv76VXjLhQBwniPCnYtiEeHG0gXvUuDxYtWEM
 Fpi11/yMaCnDrUhlaTKxWDIfgzbCsKiazA0PIcyKPuhbZwYq+Zb6HpDJPYlbYHvxOPSk1JSWGuO
 RdajD+x4rKTF2DAQvvg==
X-Authority-Analysis: v=2.4 cv=bexbluPB c=1 sm=1 tr=0 ts=6a475d54 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22
 a=wlcL9-RM8ybxaKpgEcQA:9 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-ORIG-GUID: lG5R0Gr3e0TQNO5_yPB9qghVWCpmTpx3
X-Proofpoint-GUID: lG5R0Gr3e0TQNO5_yPB9qghVWCpmTpx3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01

...
> > The attach path reads @revoked without holding memory_lock. Annotate it
> > with READ_ONCE() to document this intentional lockless access: the read
> > is a benign early-out, and a racing revocation is re-checked under
> > dmabuf->resv in vfio_pci_dma_buf_map() before any mapping is handed out.
>
> I believe this modification (@revoked) might be related to resetting the
> bit field segment and subsequently identifying a concurrency issue. It is
> recommended to submit this as an independent commit.
>

Thanks, I think the @revoked part is still closely related here. The lockless
attach-path read existed before this patch; this only annotates it
with READ_ONCE().
The bitfield-to-bool change is needed because READ_ONCE() cannot be used on a
bitfield. The real check remains the dmabuf->resv recheck in
vfio_pci_dma_buf_map(),
so I'd prefer to keep it in this patch.

...
> > +
> > +     /*
> > +      * Updates protected by dmabuf->resv, @revoked additionally
> > +      * protected by memory_lock.
> > +      */
> > +     u16 tph_st_ext;
> > +     u8 tph_st;
>
> how about: u16 tph_xst;
>            u16 tph_st;
>

I'd prefer to keep tph_st/tph_st_ext if that works for you. They map directly to
ST and Extended ST, and non-Extended ST is 8-bit, so u8 tph_st reflects the
actual width.

> > +     bool revoked;
>
> why not move revoked before or after tph fields if it don't take one bit field?
>

I kept @revoked there because the comment documents the locking for these
dma-buf state fields: TPH under dmabuf->resv, and @revoked under dmabuf->resv
plus memory_lock.

> > +     u8 tph_st_valid:1;
> > +     u8 tph_st_ext_valid:1;
>
> how about: u8 tph_xst_valid
>

I'd prefer tph_st_ext_valid since it matches VFIO_DMA_BUF_TPH_ST_EXT and the
"Extended ST" wording used in the documentation.

> > +     u8 tph_ph:2;
> >  };
>
> ...
>
> > +#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
> > +
> > +#define VFIO_DMA_BUF_TPH_ST          (1 << 0)
> > +#define VFIO_DMA_BUF_TPH_ST_EXT              (1 << 1)
> > +
> > +struct vfio_device_feature_dma_buf_tph {
> > +     __s32   dmabuf_fd;
> > +     __u32   flags;
> > +     __u16   steering_tag_ext;
> > +     __u8    steering_tag;
>
> how about:
>         __u16 xst;
>         __u8 st;
> and it corresponding to VFIO_DMA_BUF_TPH_ST/ST_EXT
>
> Thanks
>

If that's OK, I'd prefer steering_tag/steering_tag_ext in the uAPI. They
match the PCIe "Steering Tag" term and seem clearer for userspace than
st/xst.

Thanks a lot!
Zhiping
