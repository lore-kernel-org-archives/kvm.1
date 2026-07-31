Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34CB232395
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 22:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785538770; cv=pass; b=C88nqywAj2T9KdMHkn2+DAfmbe55vefgZgvWWDHk2mlvC5WTgCa17HHOtKwIqTOXV7sb+PJ3IXaqXle4scT/pa76wpGal/BOhYJQsS2OoKU4QcQT2z0xj3L6+pwyLZoOJX6q60qrIGOzmCMXAF16IkQuHoQb2KDKlvtFFqrmuUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785538770; c=relaxed/simple;
	bh=TWcPtjAG4u7chlP5TyRDKKWblA7wU+NlX2Ibp3AWBks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkFOXoU2Wv8rv+JSd9l9/qPiWFtlIfNQdHVqB2twk1x6hRXrdrz9ixu6EwH61coOaujq8flfj3ql/8hbKDIF+4Yal4KjLZ4luQOsdS+7trj7OubaecdDE3fsNQ2OG6SeeyCVc+uYB+PLw45YwXTuEpJKmJjYhcti4mk+ggJ9jUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FUF2N0Ff; arc=pass smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FUF2N0Ff"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VMWO1f2368776
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 15:59:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=sXFksAHvqmB7jfoZlHKXAtLMdf8uLXt8quqrA
	vj0i34=; b=FUF2N0Ff8bRoI+Jm4n4FqP0UEtfp2ZafABB+ZLlVHxt3/n4mCu9ji
	tmyxKNmYnX02kKgIzt0D6oWqHsCR/pV7Siysc8tevnCjpRyn3Gaj8zpE3MTkzEpi
	JbkNSKFBfbAdcskM38ush7GML4ZLCte0uuKQsbFLbGQfF/KeHa0erD/zloXr2ROI
	2AcS8a6XIy80Em87RsUtY6SWr0zB5JnmeGRZ6C7E8olWq6tpJQAZIvP+Snodglwa
	rjz8oiOujIhbDetPlVi+T3Bdit9GkMDR66Mb5drzUvjTtoqwuDn76UsltmTSxKdb
	FzgJ1fIASoS+LL01Ez+/4cm54Jds0ENhw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fs0v4sc82-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 15:59:27 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e74781faaaso2782483a34.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 15:59:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785538767; cv=none;
        d=google.com; s=arc-20260327;
        b=MSXWpXw6GeaTrBERJG8RZzXmXKVAlJiphpevm7YzrPVHeIrahy6CoT26T5Z5RYc4e0
         UhiGOsRtDCbAMO1F52i0/EgKTp2BBZKgEhKGJneHxEvYshQNRRdH8NKAanl5XEOlrMmE
         9GG2HoRZpNHeSMlzYUFGGOHEKO4fIDTqAW4UX6+5vcB5sDFFJZqbrKx+/v9+WPkFb6VB
         dwzE3L/iPs7aQLWYsV3Q//uLHhGiLPZew5tp9GIuMXnNc/dzrIHSVe+KplqwlmskJigf
         wp0Q4Yp7De/3PwizFXDN0BRq3ap9RGiKuBjqsDXsOKi4JPxuXi40dl08UHCuxIE1yYUu
         5+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=sXFksAHvqmB7jfoZlHKXAtLMdf8uLXt8quqrAvj0i34=;
        fh=pFMaH126fUUxMDPGMBv64/z7mrG5mprcygy6nTE7rd4=;
        b=A6yzlwG3BJz+2g9pGnUzAK7UvGTvcXVk7vdM4t1ExyovmDxTVnOWbn9+HLbvHTMCk8
         fFqbQew+chEN+x2UqKM4P991kBo6+XI0f4M5udeyUQkIpI1Q7NjnIxsh2YQfwSEE5Lm0
         5VNCuZcALD0Is22FYATKJuYtHG3nENT6t04PVsOyQMUsnhKezAKvLOImlJsf7tToLT3H
         GicmHgwWIA0FEoUei1hoSCUoesV2Pw2p8DUijcl1IvkAX+HhcYsTgv1YnmXKrDMBTijN
         a0wZVgWiDYKFkouSCXHsi2XscQvAUlFXqtXEsxt3Vo9Lh1gx7At5W2ybjG3YNJdYvB50
         WROg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785538767; x=1786143567;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sXFksAHvqmB7jfoZlHKXAtLMdf8uLXt8quqrAvj0i34=;
        b=H0MQ1O/waJjyX+45+QiYVh99Rm8Vbm4BaxPEm8YkRbkjPMj72tulqIfDr4c1BkDZVU
         BA3EX/56vvanjRu25nJxr3QgY9OIMhcYNN7NpoDuixuvgSktLZUpNy/XerZJtRECbZn5
         QuaaZW6dnU/NiDx0ZNZTBtqzvKBSYTweeqSso1hGR9bBnf0Cx/Wo+Kh1uS6y0FmCT4Vr
         DYENaDmRa/pIO1j97W83ovCTAn3gxC1sUxUYoMtUyREsijalHyTZTfJ9X77fT/ZLgUK4
         V8HYpi8d32fp1RfRVBJqJvBLELARfR+PeIIhWMIu1urLba1cC290Q0Y7TQ0Wt2GjTpzY
         c2ww==
X-Forwarded-Encrypted: i=1; AHgh+RpsBomgQCLzatSvry+sF3o3dvg2XSnlLFSnyPt52t3DHZF+3GtckK1e1bi+tZVEDubZEo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdbwItOYEzUdpL12LeGRVU5OjLR57zasSIS1M/WmSGVaDFt6Y8
	/OHehfyOKPELbEnIn5QsL4MwlKTlSBXWk1xXipaQkaXMOG8bgsRuYhYHRIF7NNH1NIsph+Wwr20
	t5xdeuo7kztIxBg6Jby1JyhgVksveu8cROq89LrI1lqB/tBo3W/AmWfbLJxzBz0kxYie3ApnVqW
	PWooZ7870sWiaS0vYyJ3dWcFu2J3o=
X-Gm-Gg: AR+sD12h0EERh7aUudb+JxnE8jxlIAtVNhWe69TjW0NdRRHB/bLlN9lt5pT+NeNeW1S
	lgInTXHPKm77qZ3MVqtfjVkwPwZTtHU6yNUTFT+lNjWgYZEfCVcHUYdrZw08750KPEgAL7g47Pa
	EDNlCWwq6/E2fvMEZMVED51ue7glXQzIEmpl4RqOQn2rVDSHXBc3c0uN7C9vYxKeX7dkHR0/dX
X-Received: by 2002:a05:6830:67da:b0:7e7:5e4:ee11 with SMTP id 46e09a7af769-7f196f48db7mr3826367a34.16.1785538766968;
        Fri, 31 Jul 2026 15:59:26 -0700 (PDT)
X-Received: by 2002:a05:6830:67da:b0:7e7:5e4:ee11 with SMTP id
 46e09a7af769-7f196f48db7mr3826328a34.16.1785538766468; Fri, 31 Jul 2026
 15:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com> <20260731211601.3033906-6-zhipingz@meta.com>
 <20260731214821.2A9AA1F00AC4@smtp.kernel.org>
In-Reply-To: <20260731214821.2A9AA1F00AC4@smtp.kernel.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Fri, 31 Jul 2026 15:59:15 -0700
X-Gm-Features: AUfX_myHxlkqFnSLC9MVeO-2eucc1qmrR-J0Lg2UWhuCZpzuHdreSVtFADd0gQo
Message-ID: <CAH3zFs1Nhp2vWnoyDT6RpePRM3=JV9JeMuWz4jZwbnSTx=6PaQ@mail.gmail.com>
Subject: Re: [PATCH v13 5/5] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE3MiBTYWx0ZWRfX7iyxiROZqCJt
 vhG6n1inVaIQuJG2Yi2HydrgOlsUCBJl73gsB8cIFkxuqoW1ZE17/QpVNRfec1mXs3PF+FvSbUY
 TtMrlHwnK2DEq7e/LacqJ6tQYK/2ves=
X-Proofpoint-GUID: zJh7fq-yJCMpv-eOyKEF0my3cyZDKv8F
X-Proofpoint-ORIG-GUID: zJh7fq-yJCMpv-eOyKEF0my3cyZDKv8F
X-Authority-Analysis: v=2.4 cv=HbwkiCE8 c=1 sm=1 tr=0 ts=6a6d28cf cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=VwQbUJbxAAAA:8 a=So9IXvp4ApBoCZzCt-gA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE3MiBTYWx0ZWRfX3FRpS3BQQVHL
 Sm39DoQUTHWFnjPZ/Y/J4D6PEfZJLGdX2tnZ6dMOtvC9Wz8zp7C6LhDUqUaDRQB0eT9hITa0yCC
 1IZyrOe5y42ajd5L9kB1ZdTH1CvJtR7/6UG75YAsC5gJk+1AiL5QdYA9lTyBqiKpXdUXwnugQe9
 cx50+LCnljh+c4aguIDGmo+me7DdgaRblrlA0Tv3UtR7vi9BqXcPs6JbIbHeuZEiwoN9Nef8y6c
 Tv36kduz7WY2AvorkaZhT1Nvtdm2tRr08Kksll6f6EOU4aPrxubQN2XolI0rKgDtHIJ8Y0rXx7d
 9sWPJWZz0hvbRwV36XuDOZG2oTkbI/vk1CTwv1H2/K+Pf3/fuzemnEy1s8S+WZb3ehzOG++czgT
 f07X2AXgdb5ujSDSb0yKxobI97AVfLpzgapup1Q+ycC/Ky8QG16AqBGYj9kUhDSxV+1xxCVzxZW
 PTCWOWFqhc9iTq6/NNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01

On Fri, Jul 31, 2026 at 2:48=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
...
> [Severity: High]
> This is a pre-existing issue, but this patch introduces a new, heavily-ex=
ercised
> reachable path for it.
>
> Does mlx5_st_dealloc_index() leak the mlx5_st_idx_data struct when erasin=
g it
> from the xarray?
>
> When a steering tag's reference count drops to zero, the entry is removed=
 via
> xa_erase():
>
> drivers/net/ethernet/mellanox/mlx5/core/lib/st.c:mlx5_st_dealloc_index() =
{
>     ...
>         if (refcount_dec_and_test(&idx_data->usecount)) {
>                 xa_erase(&st->idx_xa, st_index);
>                 /* We leave PCI config space as was before, no mkey will =
refer to it */
>         }
>     ...
> }
>
> However, the underlying idx_data pointer is not freed with kfree(idx_data=
).
>
> Because the next time the same tag is requested, a new struct is allocate=
d via
> kzalloc_obj() in mlx5_st_alloc_index_by_tag(), won't repeated allocations=
 and
> deallocations lead to an unbounded kernel memory leak?
>

This is the leak fixed by "net/mlx5: free mlx5_st_idx_data on final
dealloc" (df6134b527a8). Sashiko appears to have applied the series to
a tree predating that commit.
