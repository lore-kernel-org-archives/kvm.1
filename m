Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F473345CC9
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784232672; cv=fail; b=KQJq1FYMSTKqCGIGGiQQP/n6BzRfWUtr00aT0SAhpkXDtFsy8Nc2/JnVykJBv2Qp7ozvUHxvq+Frx+OZRni4y4PwM4s6GaWuXKNGibHFbtDuYVRAYTeIoMN/eVRSOHwWOXQnv23k6bS+lBtxrW7tU7d947a95CmCwap5KWOmNK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784232672; c=relaxed/simple;
	bh=FmELQBnFhyva8tqlkEZm6vsX9KbwpXPdoDW/5vArsKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3gjL49VjPGNNFu1HbrVRg/Fgs+dMaduSTsGisYqm02R2ETau7HrO1kuWkPvF9jz9rEFx1Mw0+J7ryG2+sQymhyjNUVtgWWmVw3ZPWwD51qFBC87v0AjD1JQxrCQ/tV9zJVQqlifzi47UWCGjF4lc2pbm+GkPfrx2B/Sh1IOXoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=BeR11qvm; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="BeR11qvm"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GJoxBq4044233
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 13:11:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=FmELQBnFhyva8tqlkEZm6vsX9KbwpXPdoDW/5vArsKs=; b=BeR11qvmnnNI
	DzI/KcfGXkxY1JZELI8FYHdPO9IXUhqdHYrWC8lX59Hu2MJ0ZHd4AsNG2hgDGQpG
	IHT6XH5Qlfcp5OP6jzCLd5FvYJglbau8ApcPoD8Xz8kK/fSxfdjJ8AN8toSgqmVe
	v5wge45nB//G/3uFGquRWqSQUTJvOt53gIka1wnS/2dOzX9ajVcld2KKhTTJDgb2
	HLYpsvHpWstKTDtQXwYKzP+utDzERk+q65fDYWCP+ttjXMpPWN/GGjFizYxN52+n
	0G14OHlgtzgd5o2++cURe6sCIkND9KFf2CJXFvIJACRpxYjoKeFIkldXMd9VvGym
	8BWJjHisZA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fewap3d4e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 13:11:10 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e9f686e18cso4033739a34.0
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 13:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784232670; cv=none;
        d=google.com; s=arc-20260327;
        b=SruYmIt2a91E5QkezsebQKFlHb4J6lbuxZaFovE46LrCN+QUHS2sBO7HyUkkt+Qs5b
         WvutIFdaRNZeHG/zG4qBylLXig9q27xJSAYnKZ9wKCUTcU1v/OP99ttpDjkVesb3jWlW
         HrwrtJPXw3u1xExcGRzvXYN2nv4a0LNmW2I0Fquy3YIVHFjTpdmgzVPBNzDA2sAWuDUA
         u/0YpSQ2t6QSk87MGc5QtMpvCIj8TGHibjP81a+ZnamQEt1gSLmQsCA49VTmjIxQjZyD
         zt0kk4lpE4WCy6u0IP5CA7CIYkJqhNcn7mJKzYFKn6Q8sxfVQU8YRZKbbwWxFI2ozoOG
         soZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=h9z4CHpNCAe01AgBaapdbFFT33ePTDg6qz9BNy0e+IE=;
        fh=ozD0oJSq5G050lBNupBhubTJ2K9W43k+/k4kJyXoy/g=;
        b=SZsNtMeLgV2dnJjHeCdMh1yPdLi23LxAvZmrC6Eevc8yBgVXF0ivRkVrIDcZ5KFtAQ
         sYxLWoTBK+bUQ1v1UFUGQeps0OPMRQRP2bjy4j4XfBsajbcRWNpYg2sh6y6WgpXtMp60
         4IN5rOwdRDkjnA80Vc37QWmy+NR4156sieMDCw/K/GWEIlzBFRjZ7lbE4hlpx3mPTR4r
         gwhEc1f0+l7R/MORTmnk0dTkIpJIiV8jrDMY/vhDjHoeXTZqYEzi2nK/GHMXkAw4Qdsq
         Lj1YX9X2NG9MjKVchY7DWA3DpaVzdzoLIYfrsAFwDPE4KSxYn3sSF8+C8Z/8jn2zM6ZQ
         wWZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784232670; x=1784837470;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h9z4CHpNCAe01AgBaapdbFFT33ePTDg6qz9BNy0e+IE=;
        b=FQ6754A72CFsY5oT0aCzrGelEXB7Piaxq+72oHzG0PSepnA+RCRkfnk/H2b14fb5jw
         ZI0HkwTli91STmISXAf7nMNB4jJyv/Y6WLqiV9YfQg48xxMoTLup9cEpwXgaVvti3VJI
         UohB8e/ciSXtMz47DO2WOcLDhhEECi95FZm7nD+7Qhi6U10F/dLxa6f9bMzgYxg9NQMo
         RTpiH3LbyyU8Z9Z/hSXBjW5X/RNSmrxwRN+qfyfYlKedKzt5QS7sHZYJB0GybX6P2HB4
         F/u/b8l3dquLzPEJcXt38BsghlyHs1N8Rryq5DXDGokJM76OXRKtP7G8lM8/Ng4tb65h
         BUuw==
X-Forwarded-Encrypted: i=1; AHgh+RpmE0SOjFNAAMs3cHowYbki/LXpvtjrrFHljiycWH+8EOdmqxbBSzxp5lgIc8lJREW/JVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzpWAspmt9dj94EKqQPxGSU7/2MDKdOJQ+SWwmZhoZvL6U6NKV
	rd88Rh7aONtiUCPElHaE5qrUie9cFokLxvazSPQRVfNHNlGb8OPry9Hr0rJ7eLk7V3r2vh2VFmB
	nUoNcFB+isfT0+pNBXKLjX6YrzmLdFuyIJ3TV29ICoBUjs751fovtFH7c45/g20IScpxXTD7Cl/
	I4zwb/gjqKClQiNBbOBgj1OCq1K9I=
X-Gm-Gg: AfdE7ckDP2WSmHvybhyma88RelSQvVFOsxMEPVwKZJ16GXFi1t/8XFzqlAuDSidJUu5
	T4BAk4HqXQN9Y0QjRCpIcEec2TovvBHKKGss7b096cRAzz8/1f37BBv4e3bA6PTyzMh3L5bKjSo
	0qTzlsSglmCtdmZYbZzHZDWTD/QqwsrIXFPZHSbVh0U00gJ6hzF6kaXOzDzjpwCibc0Lhfc2QHi
	N6o5G8JRgOkEFgPxUk=
X-Received: by 2002:a05:6830:6aaf:b0:7e6:e162:915 with SMTP id 46e09a7af769-7ec97340ddamr801704a34.5.1784232670073;
        Thu, 16 Jul 2026 13:11:10 -0700 (PDT)
X-Received: by 2002:a05:6830:6aaf:b0:7e6:e162:915 with SMTP id
 46e09a7af769-7ec97340ddamr801684a34.5.1784232669654; Thu, 16 Jul 2026
 13:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715204008.3911275-1-zhipingz@meta.com> <7dd5c995-a23c-4d3a-9ba0-7fc77972339f@huawei.com>
 <20260716144708.GD210048@ziepe.ca>
In-Reply-To: <20260716144708.GD210048@ziepe.ca>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 16 Jul 2026 13:10:58 -0700
X-Gm-Features: AUfX_myheEIlUGdSHFK_vqkE1hm0qjp53c8YkJwDa1cVW2p7StXgd-p-wIuQhRA
Message-ID: <CAH3zFs2fLC5GodysR9_QhFMb169DjtsNFnfBeO9MPk9S=DLcfA@mail.gmail.com>
Subject: Re: [PATCH v12 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: fengchengwen <fengchengwen@huawei.com>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: SfYv3oHYuyZ6E_9M3UdbS1-Nne3_2KJo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX6U2+JrRIS3/f
 A3ekqQliRSha2CbWZkCK90/wMJxDG3C8LZ9eh5WBBiErRIgcKTKxxvoUUilagkPeOtkpkFQmae3
 9gMiUgqi1kli5b/AmggNcBWjcCF0NjU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX/diUQ/ObQaTk
 pFFk29KdgK4aEJtWcOStWi9JgVAhtgq9+e+LjMo95lYHEit4iVcdksTsIKNw7XuMtIfctr/ohiF
 uYnTkR/Xlda0lxQ+3E8YsI1YeNbV1YtkhBaxfgoCYvkZvoSiasxzhraTfSmudD5Ici4JbYMXFDx
 m8a6gi+FXbX2XPx9PFRAM9H0sED5/OxR9JK0lbNAUUwHNRgf5QBnx6rdnFCuPH31Jdpkxyyobar
 XRZV4WCNcVB6Jbzd5b00By+3CkbSLR2WOtKqmebpdYgPUT1wolBzNrffNvXmSaJfmNlypkdI4X2
 SzmT2HAjfCpYAeFRJ8y4XN8pTcP/rFx6V3lZVKIVo3tpK43pZJjcXfO6BlAMX6+HOTyAQoy5za8
 o+ytEwjY5R/8qi3Lc92vqoZCSNT9aCWju/i2u+zS6DeFWjgpfkrdZOHxntsRSlEaaLhgglVxQ0h
 fJ3c5RHnCqRlYo4ccDQ==
X-Authority-Analysis: v=2.4 cv=D9t37PRj c=1 sm=1 tr=0 ts=6a593ade cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=9jRdOu3wAAAA:8 a=AMAE7NpZmBqY-1WNrTMA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-GUID: SfYv3oHYuyZ6E_9M3UdbS1-Nne3_2KJo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01

On Thu, Jul 16, 2026 at 7:47=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> >
> On Thu, Jul 16, 2026 at 09:07:35AM +0800, fengchengwen wrote:
> > Because cross-Root-Port P2P traffic with ST does not affect the host, b=
ut
> > merely the completer may experience some performance degradation because
> > it lacks the TPH hint. In this case, I suggest adding restrictions in t=
he
> > uAPI.
>
> I don't think this is complexity is worth doing for something that has
> no functional impact.
>
> There is no difference between supplying the TPH and not supplying it,
> so may as well supply it.
>
> Jason

Agreed, thanks -- that's the intended model. The ST is an advisory
hint; when it can't reach the completer the traffic just behaves as
the non-TPH baseline, so there's nothing to gate in the uAPI.

Thanks,
Zhiping
