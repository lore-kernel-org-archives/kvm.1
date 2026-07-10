Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1843B3880
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 21:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718026; cv=fail; b=AeHNYlkiamAc+aYNZa//bKDh6S1OnmR0+DcUmpPoqaYdb5+bdBsl24BvMWn1/RnuacChqqoQWkGUzU5YSN/p8cGifSpjyaGroFsp9Vjn2zJ2umtlGh+SzXL/9PzlDSGJYAa2rm12hE6Z1fxad6tqSZigVaP0/mzJ2jDXFW8c/I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718026; c=relaxed/simple;
	bh=qTGJ1qCsNSroWoULGPtpQMjb5UjkQ/i1Jx9oQeZCKyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQqNi4g7ygAE8g17Oi43VDfsyklKz1lycObaRMXzBN3CPu6nCTJ0xVW8DB1LM5fy3MynWcJfjoTolkDWwim9zm67ghteKbo183G/MVnFFDHvbgCPJsNGvubWX5yCaL5KR/ulHc9aY+5Jt/vqQemtlICEExwy90gnNOjPpmRghZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RYK35fQ/; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RYK35fQ/"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AK3adm2602474
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 14:13:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=RF8cFAwOnRSkhH9D0DDvmvcNKGy8nfBCbBtEkVfL0v4=; b=RYK35fQ/CwFt
	9Y6liH/+T+e8GjLaxejo6rcLnWNoms5TDAneieLNEs3hl1aa2PsrH/U24euiowpl
	9luuMEPbfvWzkjV6f+XoTtHYas77VVD5ZWtxfcDX+6WYOimoCorso3lVvOn7BFr8
	jgFGWDg5+s368ZiJ1y+Idu0Hy9dtSy4mLqOl1ApPtN0Q4jAwmaMMJYd/7GaIeqHq
	hRwsF7KvtNf+HLABfW3TP0f6XjwilIPxO1af7LFe+Aa3IMnPKCrPiujbH+hMKUIf
	QrfNgj7RQdzrvELzpA8rSXxe86AHthCE8wer5/AyftFWjSgImjzNasXhC8aOsEav
	+4nOGAwTFw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fagek85td-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 14:13:43 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e9fdc2870fso784295a34.2
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 14:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783718023; cv=none;
        d=google.com; s=arc-20260327;
        b=CglviF25gHIthc/8tSPrhBqNh5qdHP7oCdQJEpmoSwzqmlP8yNfP1Vbthtikjyvdwo
         B9vG4YRuYNceGa7EHoejslXKB30eyfScE1swbFZKPS+tNxTtCR7qRRkN6TawQacg8wa0
         5u0FAkDPe7myIwrcIpbdzuTyUryMMcQE6c7DTziJ3hiNtKdPDH0hZ8EUSl6U9y/2ZUtd
         TzrSOyVmWWjGRGh2QP/KtIUv4LQ5w0+oAmD5QdzkTCbsBMyZInFyxowspADy1og/CB7t
         5mzVkh90cp/uAxnHknJIU1LvCRf5k7rrILvx8uSB+REa4o8GMG5J1exG37xPQom1BhmJ
         t4Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=dzINuCyV1AjhEQXZagg0c3klT12KrUQB8e556Tlb738=;
        fh=lItsPIsUWMm2jI/ZCrhAvW1/9MD/N8TbnY4SwW02tAo=;
        b=jsuwodib5rWKmh1TI+Yxcdg7AP7k62d0CTlJitrOlkuz1hmGqM0+bkcfOinjaq/6sE
         SxVhGnsRbcQTHtqOHDDQVhm6lsK89XXJUTSbJZLSciyBh3FXWNt4C8vDX6D8wOBjSX6S
         IvflhEEv0Z76c6XC5QScAn2khqdlPMVwfS5ZdBHv0RbRwR3b4GaECAY4WmM3mz0RrAwo
         lwrzIas5D57pLTkoayL2qbxz8C8qnwm7vT1vsC5cuzCdM/QJnAPDRRve1oZTyA789/F7
         cEykq5lDZ8zBDQpywWAr9Ue/LQ3vqZjbmBqgmtxHTYobMKn+SnlRb5vb/mDqsCaa/tln
         Yn6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718023; x=1784322823;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dzINuCyV1AjhEQXZagg0c3klT12KrUQB8e556Tlb738=;
        b=YDCRAJF+nW579oUqUitis/WSKGG96mQTqKeCyBuSK7MDEQhgX7IIV/d0ckXI6IbXJm
         YngS/D3vsW1RR3awUq+OuZ5Rk7TmkStTdKsR/uZ5W4PktEVte4sEF0+hikheLqKAQmm8
         SREStnyRZHhO7PMf9eV9cjtgfvw8Qr+OC3s49nxNos/Pm/tV6P+vf0lOf5cQNM80bam0
         yjC8X1+2KcxYwzgSXbRALKahtqZ7nFh12Ct6nqN9t8Q8HQx1IKmGuFRk7zAY2hcVqFU9
         XC9YYM0Y2UVdTMY6dAiuM7X7TPIGM7tta2owypedUY/JOxSLexVQtwXqaqid7SnD3iHA
         OqWg==
X-Forwarded-Encrypted: i=1; AFNElJ/8X6rmLjJ3iomttC/iI55PhWJtYLwyCVs+rBifiiIe1NDpnoYWasDJn8qyd5ZLpaGSW5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkGqKkLcnmB0yNYcIFugLu0ukg/BrtC8+j2FuTFXX34Lv6v11l
	z7fWdUS8tAen/b4lSsZjCazLKe7gDzyAKpT0FJn2x2Pa6FDnVtRcfaCDJZ1/FCnoLNdfomD/oS6
	H8p1JQh53L4B/FPtTVhSb0IH/TRRP9eb2mraCsU0+xZvYmHb0wRIvVYC6c9iUiAnsSWXR/8KHZ0
	6jmutUy3Gd2gbI1WntMZcVEZ5uyiQ=
X-Gm-Gg: AfdE7cklEA9mnhKH+BP6wbFX8BDU7LXawjYRCLXjKpTwHY2Bvwqm/v2Obi6KRAG5Ol2
	oV6X5p3SU19srGOAvo8DqadLVHeX/foVP3gAs554akCQ+gCWdYclcUN083v0fbgXCdG5wXeTyiQ
	MM3I43JyaOM2WJJBcGd5qGALursceU+XaT2vIw60pKu0T8PLHg6pLzo/j33OtQiiE+hyGxDCtPq
	WtD3z2xYzI=
X-Received: by 2002:a05:6830:6c11:b0:7e9:b772:9aae with SMTP id 46e09a7af769-7ec0981c52amr316857a34.23.1783718022913;
        Fri, 10 Jul 2026 14:13:42 -0700 (PDT)
X-Received: by 2002:a05:6830:6c11:b0:7e9:b772:9aae with SMTP id
 46e09a7af769-7ec0981c52amr316843a34.23.1783718022507; Fri, 10 Jul 2026
 14:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702181025.2694961-1-zhipingz@meta.com> <20260709132602.6a3fb084@shazbot.org>
In-Reply-To: <20260709132602.6a3fb084@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Fri, 10 Jul 2026 14:13:31 -0700
X-Gm-Features: AVVi8CfXe8KvJ5Z7sUtkIYqefn9JRiYpvw-OvxoKOz-vRkAAzCUP8YaHHQIwWXo
Message-ID: <CAH3zFs3OwPyTrWk7oaMYETq7sBEQ7VRfDtzWWamhiE3AJzVShw@mail.gmail.com>
Subject: Re: [PATCH v11 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: tJaFwjF7Cuha_2cj5vlaAH-beALbGguj
X-Authority-Analysis: v=2.4 cv=W8UIkxWk c=1 sm=1 tr=0 ts=6a516087 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=c92rfblmAAAA:8 a=VabnemYjAAAA:8 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8
 a=FfEKJDObtavKmf3ECVgA:9 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=gKebqoRLp9LExxC7YDUY:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxMyBTYWx0ZWRfX1+oDzhwt/ZVe
 ADTd7e1L3bFbxotqNiA/7BdVjbxytLdZMXID6Xq7XvMQB71vrFGRYQoOIQR2srMPEZuW5TggN7V
 39VdztbOWtKwKeF8k3fVdKn7VHj0PL/ljujxKYSh1Xp2TwrZTVvTIn9lSJpA07G9y2aJ4Tohm1+
 VV8lbinF31QcHUe8RY9p93EfzkfUhFc9189ZbOtMv7Z+iufGs76wjtcPL5ooHDl5IZEVO4glpgC
 gU0Vx8FsfppzBZ1P9Ngm2pdwLtSMQ/cwgijPiZ4WqAg96ka90aBTXCP3A2Ll41qsoOMRCDSGClv
 xCrbu6OeIIlPa4A0JLTW8gKB0WUkFMeM3t9ALXO5/ye0u7pOxuJyd2cilMzwYwecDG8lIqZ2Cs5
 8s/hKJLu80t+lV6mrlKpQ8Y/0G4PcAMo8jHgljQaL0ulFRdScKznDLj21sxGMM/lziez2oUjXs9
 XOUlFsmWrsncjPpY68A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxMyBTYWx0ZWRfX0iGibtFm3zj3
 O5q+cm/WFg6OTuQcidjCbTUj0EX0bEKQZob1gqNYqTLUf/yAAxdoRld1R91A+YZZx5e9LY3BPQG
 kMpH6KLTwmJX+/8WT3NXiHWmp7LTaEs=
X-Proofpoint-ORIG-GUID: tJaFwjF7Cuha_2cj5vlaAH-beALbGguj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01

On Thu, Jul 9, 2026 at 12:26=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Thu, 2 Jul 2026 11:10:13 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Changes since v10:
> >   Patch 2 (dma-buf): Per Christian K=C3=B6nig, document that the ST/PH
> >   returned by dma_buf_get_pci_tph() is only valid until the exporter
> >   invalidates the current mapping and must be re-queried afterwards;
> >   note added to the wrapper kernel-doc and referenced from the callback
> >   kernel-doc. Also add dma_buf_get_pci_tph() and dma_buf_ops.get_pci_tp=
h()
> >   to the central dma-buf locking convention.
> >
> >   Patch 3 (vfio/pci): Per Alex Williamson, update the vfio_pci_dma_buf
> >   comment to note that @revoked is additionally protected by memory_loc=
k,
> >   and describe the READ_ONCE() rationale in the commit log. No behavior
> >   change.
>
> Sashiko has valid comments[1] across most of the series.
>
>  - Passing through 0b10 seems mis-categorized as High in patch 1, but
>    is valid hardening if tph_req_type can ever hold an invalid value.
>

agreed, not High and pre-existing: get_rp_completer_type() is from the
original TPH
support and untouched here. I can send the hardening change in a separate p=
atch.

>  - The documentation error in patch 2 is real.
>

will fix!

>  - Patch 4 ironically fails to re-validate according to the lifecycle
>    requirements that patch 2 specifies.  This is a significant gap in
>    the implementation proof for a real requester.
>

Got it, I'll re-query ma_buf_get_pci_tph() there and reprogram the
mkey's steering tag,
so the lifecycle is honored.

>  - The broadened scope of the existing memory leak in patch 4 is
>    already addressed in [2], ok.  Maybe should be folded into this
>    series if mlx5 isn't going to pick it up separately.
>

 [2] is already accepted and landing through the mlx5/RDMA tree.

I plan to keep it as a standalone dependency.

> Thanks,
> Alex
>
> [1]https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260702181=
025.2694961-1-zhipingz@meta.com__;Iw!!Bt8RZUm9aw!5x8TPHfbpTXQJ872nmZaHsPIXH=
7HsL9ICbZR3G37yKkHgB-RukCDOy3XiLIOhfhP-yTczTyWQmud$
> [2]https://lore.kernel.org/linux-rdma/20260612170406.3339093-1-zhipingz@m=
eta.com

Thanks,
Zhiping
