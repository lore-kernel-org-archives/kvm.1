Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58F23E4C92
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970666; cv=pass; b=RjKpyoJvsk8jDjuHX+5eSCXBneqca6w5tyzX8cobdk7RWcwRODBVGakTxl07kpU8G4ltQz8sAXxUeOc9ESuq992BW34ebLuG2+dllI4V4bpzb5BVuAd8tWc85WzgdsvhbKKKhOKvYaCtJnh702C1XAOfT1I0vfa4USRQKBbDA2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970666; c=relaxed/simple;
	bh=rVzD9RZ8DOj+OZScnURt3JaaKOoh5Y6w5keNNJrEDEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fp73X3Fkc5YcJ9keqxATiwwXskIdm9ezvcFVAkL+gtwz7laME6Q/EfecUmtwXZrBvlW4TQ/jXZZZPhLbfnKvqlyHVr8JYOkL2ZMlHkut9/aN66rsUqCwNYYQDFm+9qod7RlSEhBYxV+CmMhtx082/fR6Cnot4mspDZ8VTBThTc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NgpBhtFm; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NgpBhtFm"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VFOBH13120450
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 08:24:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=rVzD9RZ8DOj+OZScnURt3JaaKOoh5Y6w5keNNJrEDEk=; b=NgpBhtFmItDM
	CNbcwb/E9DkdCKHJ/+HXG5nYnUCSAGdnK0J1DywzsfubqT3zoyDOiorROwlve6f5
	Fabj2p7OS4l9/vDda/nt1iaWFhmj/dD7ikbmlCSU9C3dxHoD/BW1829WKG1gSNUo
	bvhspgCJNM7QlFoJ6rz3LBSz57IF68o48IZ5V4B4vXaE0cFVG0Wx1twzhAphguZA
	x2QO4KynACOL7v8zMEgjTg34ybae8h4kqqcSIVWunaNwvXNvzVjB0rqBMikZSh7r
	g5YEFzd1SPUtzJOBJK+aZ0ehLdWWfxZnd/kXQFeHL1MALxrPKcsgO9HqIAQQZ7ex
	Zwkn3t7Umw==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d6xrcndvt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 08:24:23 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-415583a6862so14950051fac.1
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 08:24:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774970663; cv=none;
        d=google.com; s=arc-20240605;
        b=BIQZA2HcWFKuFd0ZDWl8PMKIZC+8nhnS1W9DyXSTEeJySts151EDMrFgiu9Fg/+MiK
         IlF8Q7JH0LK/7ncwiii0k12Zd6MFo3M3yx//S6t51dCUSydK44ezZY8I2WXkaM7yNRaf
         MLfUEPj+cIbAIxnz2mblufD+uZ4snrP0Xyiq5wy11n7q6f4PcWUEMIADoO4RPx5RXS5B
         2vlcDOsYAn0KxSzehUYYBJRdXO+XTmOOsAkZ/IxxcZlilgUrBEt1rJ/mv2Ll5ETHRJr+
         66ffkuP2QuyhGkrJUpUo1hksD+CcQipNndbP6GjxpPphGe9qGPPI87zOdZInb0PnY9yb
         cHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=rVzD9RZ8DOj+OZScnURt3JaaKOoh5Y6w5keNNJrEDEk=;
        fh=gx576K/+qk6ONBsangW9IeaArAi819pfU7RepzgRJHE=;
        b=F+IzM1dvArkTVOkHfHqGDnrD1OqA7/poEjL89QXLHmRmewuwTRNbHPvlp3q08fibqa
         yU7Cn2no8u362c81lZAms8IYLVMulQuuDcLm2JUKPHxDkFQlF6RpoMiBJ6N+OXuCJKxH
         5tZUQUEUsQsHBMcmwnO8WSGi6JaQiuP/tzz71/czNhMJLCvF9cEbnV9mt23cDiC3w9k1
         0wK1QgipZYoWqH19LHRO0i6JFblDNOGuYipcyUoPguYulsh5Ww7WV78pn5mPJ3MMydZV
         cSD5n8ovUgcafq4ROayGFCphLr7QMmHoRQGkLusCy6iaH2W1CEfvO/oSXuWOSm5uTeGG
         3hyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774970663; x=1775575463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rVzD9RZ8DOj+OZScnURt3JaaKOoh5Y6w5keNNJrEDEk=;
        b=CTKEbuktcP3LMSv4bmQ0NHcuwnJF6hpsgymw1RxcF2otQqL8JxuFcRYZFoSc9cX8Sa
         lItBgMLh8Bk3KNiSYHI6HOT7IOyDNNu5H5PSxUs8B933zQx6fRlO36H10qaF3kscoNou
         fadumuOl4mJ6SkK2t/r3r7pvBE2KcEEMFcASgVAH9OhUuNj6dkWTuvY36TPFWDUM3/6+
         ZadPisrY1hsPThJV6N7w0zIXw+oXVivQLLqeVdGA2hISiLkYL46FM4hbA5erCQqa/P5Z
         03I6vEboRMJJH/dwLL3CwXlPIBZG0zXPbTrr3r3jZwfThTUXcVEze4knmU7UtsAZWT45
         kr5A==
X-Forwarded-Encrypted: i=1; AJvYcCXkA6+njPgbmZukTPnQ4UimcSrNtjA9hVF/ZptZq7n622u0tm180l9W1IhDSmk+UJsRtGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFBm3g9DTIdJVytwy4EAVNZQkqhLEX19UCA92qh6XqpyyPwZmy
	HO3MEvk8XC3h1wwNy+V23URPgDIFCOvC4vDJNE3NyGYW+7VLsKUfctl3STTGY8AhmBi6MYA9yKd
	X74NQWVPGVePomAgb56dRlO2mjJIv5Ew4K/jRmk15oH9LH+IzM9fyk+sVG9HCDU+ebsDD7+s6J6
	/5TCaVv7rZRPw7BOT+89F9nt/vDpo=
X-Gm-Gg: ATEYQzyQ0ufXoZrnYUqVtOkskehBiBf4U1Hktg4/QdtbZ2XQHre5PE5YFEyi7i2ppRi
	56trIwqG24h1YqTYb0YH6ciktai1HCKtlBdXyxU2/Dzo/DVI3y2tE+toUYn8SPyAhtC8TcIZWV3
	xwVEjdilBdMwiyzWacDiA1E7mT3CUHVuCxl/1XZod5J/qsQYeyUfy7df8Wh3x44T20LXYS8GDLX
	9uc
X-Received: by 2002:a05:6820:2901:b0:67f:31e3:81a with SMTP id 006d021491bc7-67f31e31008mr367462eaf.2.1774970662742;
        Tue, 31 Mar 2026 08:24:22 -0700 (PDT)
X-Received: by 2002:a05:6820:2901:b0:67f:31e3:81a with SMTP id
 006d021491bc7-67f31e31008mr367434eaf.2.1774970662327; Tue, 31 Mar 2026
 08:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312184613.3710705-1-mattev@meta.com> <20260312184613.3710705-10-mattev@meta.com>
 <20260330133336.GT310919@nvidia.com>
In-Reply-To: <20260330133336.GT310919@nvidia.com>
From: Matt Evans <mattev@meta.com>
Date: Tue, 31 Mar 2026 16:24:11 +0100
X-Gm-Features: AQROBzBjz_Oa24Ou_FBmQkKdtClzBrzQA9IDx3XIRw5UCOwDpX9lbYyqY3Y5W8c
Message-ID: <CAFzAbJHqnuV2vA-LPQy3xo1KesLUxJOCtS4FigsaZtaZEi19jQ@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 09/10] vfio/pci: Add mmap() attributes to DMABUF feature
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
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
X-Proofpoint-GUID: ZrH698zj9NQ6tRbIk58M9ughKPl4KloA
X-Proofpoint-ORIG-GUID: ZrH698zj9NQ6tRbIk58M9ughKPl4KloA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE0OCBTYWx0ZWRfX9ANc2dc1UXIj
 MZUQbPO2BGSgKzcx/bBWnLbfcFZqXOFH0H+c+tYwNJPSiXsatz4wm9SvjcL0ONWVzlAAT0TwBbb
 9zv5Jn8mP3OD73TeaDPx0fK3t0FLmRmamQO1zdgUHQOnJNWjPDtET1evjuAZ6mSpNa2quZWGIDb
 uayRnS8w1JzexRbYWpqEnfJBzeK+Yxh5RFcHQE38zrDwyYEbZa/4doRO58OA2QP3swp3RaVX24/
 mmzG/iZeK00aoPuNGeFhV7XtDiaP4T1Wrp3chM77wFkURSPBRNdxs5jJMHvuHw0Oo4Umw8sCGCW
 6RRFmGdT5bqavwuJDEyxASwo12dYKacKimJjpeqctMKp6Cb2ymhj6mk8TLQ8IfSyos9X9Um2FWJ
 KDDWirL6VD4v/MoPQl3YLjS1hV011DzxzhQX4vGZf5d3ViSWV3vTNV6hcMNzvW1vZZv0GdU5w7g
 7MpM4IQ9IUZZ5d9gLEA==
X-Authority-Analysis: v=2.4 cv=MKZtWcZl c=1 sm=1 tr=0 ts=69cbe727 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=Ikd4Dj_1AAAA:8 a=scxTcjKw9OI2Du0FDOwA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01

HI Jason,

On Mon, Mar 30, 2026 at 2:33=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Mar 12, 2026 at 11:46:07AM -0700, Matt Evans wrote:
> > A new field is reserved in vfio_device_feature_dma_buf.flags to
> > request CPU-facing memory type attributes for mmap()s of the buffer.
> > Add a flag VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC, which results in WC
> > PTEs for the DMABUF's BAR region.
>
> This seems very straightforward, I like it
>
> Did I get it right that the idea is the user would request a dmabuf
> with these flags and then mmap the dmabuf?

Right, export it with a requested attribute (as possibly some
sub-slice(s) of a larger BAR if you like) and then map it (no
attributes need to be specified at mmap() time).

Thanks,

Matt
