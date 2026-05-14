Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B95D3F411B
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 05:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778737972; cv=pass; b=sS8srPh9aAQQum3ZSJ3G+9wlVa5QqrR6U2fqW48CJDpCbolPfsodtFMHZm9cEJwbl20+gq1aB5OLpw+8gcRzIrU9xpK29HDgXQVhMW/RcKS3alSGJj9lZY9QCv5OqSXx6i1qTqD82W0OFxXRjN0dS3RdfBZ+XaZItyFmBKNedzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778737972; c=relaxed/simple;
	bh=jNKZ4zNOiJapN2UCQkJ7YsxiCTXnQMvJQjELnoY502w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjFfnEDxt7FJN2opYJ91JIe7cCeS0mOCtE9OwB3TxsFI5OJj9vgqCRmyJetOMlaWqQFsygq0iCABedXDtsI4CKzcNrjAYz5i7Deu9tAdc9OUjwwPJCDGh1+7I/2djgNHQNK9mx5wU0iDmNLFIx4DzOOoaYH8ch4f+dwm9hLoByQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fsyf2ung; arc=pass smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fsyf2ung"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DLiQcb828510
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 22:52:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=uPcBPEjsltb6cCR8nYMfRID/9nwc2fCBltEgFyYw4tk=; b=fsyf2ungMeq6
	yshHRzeQ4U6BrRrLOw2m5LnpTLwWNRFjtrke7zVSXSFihlkGIGQqF9ZGo3jGgRXv
	2rFeRHThXTMGtORk281jxrE4gu3k+yTDpZgaO0RXgdCq1N5vftBndt64eqJWuKnS
	+qFgwbyeb4nBJPMKSoH2gapTvLOVcXTpgpJbzNuSuxsG6wL6MDQuJFxJqBTW1JNi
	IVV9KnN8WwJIC23O9zBqlSvbZlQqGkv8pX6J8DxJKQRvwoU15pvU+KJVRC+Shz/1
	pdRz08JIRHpjjYq3PaY5+SYfamSp6mY3XF0mgHmyOf5/MBFj0ETZ9P3+2Z1Vr68E
	ax4mD3GJvw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e3nvs5dkj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 22:52:50 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7dca6ecdd85so10594587a34.1
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 22:52:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778737970; cv=none;
        d=google.com; s=arc-20240605;
        b=cL4ASbF5VZFNDm0MAOUeKDS7a88ShHORvaS1rp2YLcd+7N3Uj2SvNmRhUU5B4IuT1p
         l+rXfAqSLKeW/Ze0qMm8Cs9MAPllougixEkg6ggFvWdFR9raAmIJ6Qkj3u1M28uIfKKt
         9sMmaG9zKYW0YDp+YsMtsSie3dNI2G6lmK3eCatOus0CWtIjfmmZKDTgjDFxi6VZY9Hn
         CNnVmExIjGIlOqOGx8BrvOZKACNlM56kskC8p9il10owgIUtdHR20NfGVixeGUEeNqov
         njwdwKQkpf9trbRL5jiR+flAGUElz7aKCIGvBV4GG4QjsXOEXS4r7CiDa7KAAY6/k8W1
         yFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=uPcBPEjsltb6cCR8nYMfRID/9nwc2fCBltEgFyYw4tk=;
        fh=forlvb1riOdpz8heU5NMlmncjdfiZGuVou8nHPPd5tA=;
        b=jQfgPomnbPYeJ258shZBlbzfMwh7hCd7LSZmp43i/ic8sQZdluFdY2j4blWooTEvR6
         4h/ovjU9QZLQ4iP8QIz8nS/+DAS1mCR/DQbHMsUEhKjSNRNXKxXQlLRN7/USEzhWH7lI
         lFKzK4hLzrsSxfpFqqGb4Fnt+0gNWfW1vSjgYodCaCxIf/opvxUiO2uR1EfuvT/Kc5pe
         NNWduuqJrZkXx4QXoMajZn1MigxdOfCXWIJddyfCu5cjMY1rrXnRQ/UqijJiVSJwB1vt
         sdqZswyhZEHJbue1TCRxlaBD1df4+cwv/SlONYTYfhJtZHR9bXmUJuXy6kVBo3MX1wHP
         ZxZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778737970; x=1779342770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uPcBPEjsltb6cCR8nYMfRID/9nwc2fCBltEgFyYw4tk=;
        b=TZkCQ/7EtuUvqNpndhfFEoBSrJxZnt+cYwf4k65zG5YQEOOQLw6SLoeM4iN4VsSn7v
         DU0im3rUNEqFhx1t9c5wMRP2sdqfXRi1lGUQvWlEga8dmEu5rQXlpdLGqmGuQwoME8qY
         AzofDoG9BFxm7ea70CIeuKjDZmqn6oH7xb2f46gABrURwMygxv2YGeZHmgOeRBLd8lZc
         ADiM1kuuQfu11boyFORziQLppYJdyzyDZtAwqsTWS5S2elu4RsWghvnWlWuRDbUJTV05
         fIHwLrB/jvaAKOagZ1cljHdFaNGgx2US/is+w94Hi9kp9vvFWoZNiM3o2j7zJSe788hs
         og0A==
X-Forwarded-Encrypted: i=1; AFNElJ9/Mwv5oJ0+oGDdcV8Wq+PMhpCpJiwJYqk5l1rPUqiaMHhD1IsZrQEveyXEEcdw0uWAw/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxun4ep9I+SB0lugmvwp/QqRZ7nzfuD6aym1iFN4j9UsGEfY0u+
	YEiigwYKI30GDgCc+6gsIgAlO6n2AHVb6ILZM+tbNJkrCWLUF/OMYXqNzPbNL2qvjK9kIsBPBkX
	NlOM7YB2zYTQq8pZB+yomK77x2D2586VO6HMVda7ukSD+hp9wYT2Ip2Jppq6MO1v5ryqwStO1MH
	bxQvyEx/t5NcY4eDpcVCJmApvxyP8=
X-Gm-Gg: Acq92OEO87VNYqQ3x0UWMj/WMxiHuvgWTc4yp4TX9yu6zfgH8tPRcf5WdbjmENnE+Ss
	1Ntzunt+5tNdLCeGLpKwe8FvxNgc9bTTV8rb0KNMnk3zSHEYqOPvLJldY4q8U6zFYoYJuxnoP8n
	H1LNb37oREqGcNS1opzbBBjQntjnXUJP/sIAj2PBV/tWNhfZUvhZas0DaWXl2rX68f6bvXkuyq+
	zmLi4Yk3ujxjgtoaNwRWeB0QeIBVkWOAl1e7gr6zdiYFEWjUXs=
X-Received: by 2002:a05:6830:2a06:b0:7dc:da80:42b8 with SMTP id 46e09a7af769-7e3da47a167mr4289740a34.18.1778737969734;
        Wed, 13 May 2026 22:52:49 -0700 (PDT)
X-Received: by 2002:a05:6830:2a06:b0:7dc:da80:42b8 with SMTP id
 46e09a7af769-7e3da47a167mr4289722a34.18.1778737969331; Wed, 13 May 2026
 22:52:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430200704.352228-1-zhipingz@meta.com> <20260430200704.352228-2-zhipingz@meta.com>
 <09995589-b81d-4cb7-a313-15a943d8b28d@huawei.com> <CAH3zFs2x2QebpqDC0qwQg_GP2FVs-qqNxPupck40cEHNrBMEsA@mail.gmail.com>
 <20260513063141.GC15586@unreal>
In-Reply-To: <20260513063141.GC15586@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 13 May 2026 22:52:38 -0700
X-Gm-Features: AVHnY4L9mpkzt-pRZEvg5JzN0p2zqJY8w2-rDz2pv9D7N-e0Agw9sPJQbQsXATM
Message-ID: <CAH3zFs2XyXxzVwru2gYZn-9ioyvy44HMmfppf7shTn8Qop-4iw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vfio: add dma-buf get_tph callback and DMA_BUF_TPH feature
To: Leon Romanovsky <leon@kernel.org>
Cc: fengchengwen <fengchengwen@huawei.com>, Alex Williamson <alex@shazbot.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=BMKDalQG c=1 sm=1 tr=0 ts=6a056332 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=VwQbUJbxAAAA:8 a=hJXI5Qx6rLfdTxNNxg4A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-GUID: yVSf2HAYdRsxtRT6Utyx5qp71FI6_ESZ
X-Proofpoint-ORIG-GUID: yVSf2HAYdRsxtRT6Utyx5qp71FI6_ESZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA1NiBTYWx0ZWRfX6349GukjYPLp
 gJ+QPIJDKekf4NdpRulVZaAvxR/ps/kQdZeQ5Jx2d50TkDxKkNgqAFj+JMOEazrbAkFnInbgYEj
 hPUPSVRex0GA+Sre2olSHIJZjEkk0MLkWahOFYBXWgyum2HbcrkCN0YCTIFUSq5lQtX5+QxVS9p
 mYKrLTob5oaV2wCSh/Uaqf70tnNMgglcTXiL+nYOq5FMVS0u91OmMOgHOrnOJzXDP9EFxiOakyL
 auYx7qeDMDcmPfm7dHmpal/T/AwZDMI6Xqv1JXzd2eB6jyGllDlR2yUm3pi0XBnvTpmeFmSQdBV
 +8/PnyomGyjq2oaiGBa5Z5EA5ZqGqUs9Xfv+aAiB3qP6sJYRCWtPO34MFo9+qhzwhB9DY4Ok8oq
 Okz0k9aiWCC13OkIF4PMCWwuTpmzO5hj8Z3zvDYJ/5AopLiVt33jgdCRMHrk3v+fuD0YCfiyDtg
 VvnbxPN4tc8rxT3Qyxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01

On Tue, May 12, 2026 at 11:31=E2=80=AFPM Leon Romanovsky <leon@kernel.org> =
wrote:
...
> >   #define VFIO_DMA_BUF_TPH_ST (1 << 0)  /* steering_tag valid */
> >   #define VFIO_DMA_BUF_TPH_ST_EXT (1 << 1)  /* steering_tag_ext valid
> > */
> >   struct vfio_device_feature_dma_buf_tph {
> >       __s32 dmabuf_fd;
> >       __u32 flags;
> >       __u16 steering_tag;       /* 8-bit ST */
> >       __u16 steering_tag_ext;   /* 16-bit Extended ST */
>
> I wonder whether `steering_tag` and `steering_tag_ext` can coexist
> and hold different values at the same time.
>
> BTW, please send your patches with diffstat.
>
> Thanks

Yes, firmware can report both `steering_tag` (8-bit ST) and
`steering_tag_ext` (16-bit Extended ST), they may differ. An importer
can consume only the one matching its width. I=E2=80=99ll clarify that in t=
he
next revision.

I=E2=80=99ll also make sure the next posting is sent with diffstat.

Thanks,
Zhiping
