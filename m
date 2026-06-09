Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6C13403F7
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015904; cv=pass; b=qm22VPNTJbVVM+vpE5hub/zXRCOmdyIORBZGwvzV3XfhwE0ckmGP2aPlzfJhFIGwEZMYTTMv7MTnDYPm5aNTIEP7TwcbzMaswNEnmhJO7llTB0oJhJD7mWDXlgZqipcivR5a18fLqnsH8fE72MLuqnJfN09P1121LyeEb/j7fyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015904; c=relaxed/simple;
	bh=y3AzoKCQuHgd+PJJX0Ml7tfsX3S9F63aRJW3c7mG6Ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMfOtJQQkWTXEp7duf+sdc9FS3h5AyykelfXiK7Fltv2RD+t4uYBMEfnIlZx40rw8sy9SEOBBBEC4bqxiBnFwol6jqlJO/4aMzUUcNfn/FK5zYBfucX1a1NFiejX04ZX9P6ChGKHRONqZLhUQAEOSFDz5Ad+vL6bxHJvm52VnbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=b+bzFh5l; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="b+bzFh5l"
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658KhJdL2297479
	for <kvm@vger.kernel.org>; Tue, 9 Jun 2026 07:38:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=A9sFQHsXqHrMgAiwxXHw
	qbtJi56QK9Hsrm8AczETl1g=; b=b+bzFh5lZdFG6ZMxUJUlD8Yt1iTFLbUkN44J
	0sEYOv5io+R4jUYJbE8CO/8bzyHasyD/fqldbu1TQANBQ68ej/P1D7bCh0Be/t9t
	77ignPYiVT73nQeplrY12DpT/Cb+rEjERmUU6TVCa6V7eUZ7JLMt94G73fGvajze
	zyUZleQxuZvCbUUSXYPL/gojMV01wKZCDt1r9+IxqZGQ1f29Qp3i37UJwt+6Vg4s
	mCO5U7LHFg4UrHlCu+BS9DH360ffxI9Csawy+GcEYer3nQpVrv42nRoVOUC7IsxZ
	e7IvZ+NUUzgTwRET8EbK90UUlwI9PBNVSniNuv50nJRdR5rglQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4en5a5ne16-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 07:38:21 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6d9be94a2so4365154a34.1
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 07:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781015900; cv=none;
        d=google.com; s=arc-20240605;
        b=aS69kp6A+4z1iEWAwiUww4Si11dfGS3h3O3jIrh1S2NBj6bCv1/MJmPjtp5KvVPfNZ
         CNO976nQ8btFzOinWAemPepzqgYEWC4+uvm/emskvjIPvavEu9jerzQsfwhRZdhFhhYc
         GvMUFLxl26DslCALdNUSuoY0QuNUK7+e6kw/a4Hbt0uMBCAInFApzYct4N3LoqmYSJua
         ZzGzF8/pQiCz42T2A6Z24/7gAyF+6dcKlqYAfvvknxKZ3YyJwg4JlVJ+TbvCxBlUkJJq
         uX4ZUmCDusnXMN6DtpfwZ8DbLhOfiXcL2sCDJ8YO93nKDq2GdHZrS+S8cc8Q1PdVBfoY
         b7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=A9sFQHsXqHrMgAiwxXHwqbtJi56QK9Hsrm8AczETl1g=;
        fh=lAY1h3gUC9j6PzRLiiAb+w6LrvQNJnmhUHMk50x/IQ0=;
        b=R3TpcEUn2Xko6GEuS7juhvNNsgTYy+aqkcTLK0BdgrLraWj67NObSritbqLTc3zhyg
         ZxebHs1xnvkxCVK6jByP4N7nPKPWTbgqu5k7MykFAIPTCSwr41lc3teAQU+o5VCKkB5k
         qhHHaELxhlKFVbH4FXbDyzk66gP1gQ9CnMluBNmLAU4W+7j+BdlOz+Tj/urrCqfDXOe4
         ZKEe5WtEO1veVKoOWlCLzfvYaKzLwxfWkXEkXB9s1ZXGITEr6lCa2uu48LXTGczzpJ1/
         fQLH2ZCS3GW570sg/PiqWxH9QN6qxYHRLhw4qAk5Q+rJJ9nLOC6F4ApZTJHgXNC075+b
         3CZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015900; x=1781620700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9sFQHsXqHrMgAiwxXHwqbtJi56QK9Hsrm8AczETl1g=;
        b=Zu+YBS3AeYM+G1RUOpjxjlr310p56hnVPQRZNGQnoIuOyNZ9LNCR1fr69m8/4qGwCO
         xgs/eEUcZXtOPI2QMoXmiwfoQya7SpMIknakB0hLdySgMXBFLjPgKSnkc8khVO2Aq/nd
         YmgXQRtMqoHJr4W/0fVvFKc5ZaCBSx2mD1TGvaExQTK4MFwijlQHubK5OR7VpsVQNC05
         mqyNg+Sc+3yQY8LKZWSCKJZ3k1v2w04KMRRpUebnesUL051genOz+tzGQa5i2d1hTOyw
         uwUZR+D+3R91DQXMBou5lZ+Q3ydtdxGmznwWHzbtfpteF2Od5CwS5bIzAOftxeBmvTtB
         i9bQ==
X-Forwarded-Encrypted: i=1; AFNElJ+RD8q/I8Wic+VG6EnTRQwZ/oKkU/cZIhjgF3DnbXspWUzC1pJfmzC+N6f3ruRMr6sGePA=@vger.kernel.org
X-Gm-Message-State: AOJu0YytXhwVLitdCxEnBvFMlQO87eadpt9hzuOeIFj83QQvkTbBA4Dq
	hLE/9gGWcjFqCEElB67YC4DsAGTAF8h0BKBCFPe6dZ09ydygRBhbx0UkiDmquM6w/RF330DUg1a
	BFJfKJWLUyK/KXR/HsqdCoariiogmaqomD7KEcRKo8vXkryr8/bj1UKQC9YdvGV46fHL1G/sxMD
	GUoSR0Np1IOxg2wrp0rgSaJtSc3NU=
X-Gm-Gg: Acq92OHQ9DnG1YkkzGr1kPSTQPbVDHgsXHemP462NXkib9/rfXzxorYxVAp8oChe7EC
	mZRiOXRXi0v54kWIyBlzvd9KGUiFfV/XZlfIjaD4jJIgy3X2BjddkTYgT1GyYNvADyjeSJy8EO5
	ZW6OLajiAMwgivT8ullPWB0HmBxOVgQPF8rvAFq6qVbzXj0vIZiPZjneJiUU+Phy9seoqo/PHf3
	f0mAiPmkJRxb/XC+WZh3tXy76mKPjRAv1+EVlmU9zyxXZcBx3U=
X-Received: by 2002:a05:6830:6a96:b0:7d7:fb03:f6ba with SMTP id 46e09a7af769-7e70ca51cc9mr13515115a34.21.1781015900241;
        Tue, 09 Jun 2026 07:38:20 -0700 (PDT)
X-Received: by 2002:a05:6830:6a96:b0:7d7:fb03:f6ba with SMTP id
 46e09a7af769-7e70ca51cc9mr13515095a34.21.1781015899753; Tue, 09 Jun 2026
 07:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608185646.4085127-1-zhipingz@meta.com> <20260608185646.4085127-4-zhipingz@meta.com>
 <40243782-e4ff-435c-ae40-3ac1c7c4815e@amd.com>
In-Reply-To: <40243782-e4ff-435c-ae40-3ac1c7c4815e@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 9 Jun 2026 07:38:07 -0700
X-Gm-Features: AVVi8CfGCq2wYUK9zUjDs8_E_dqHl5wHKtBE7B2eSNCP9pHNCaJrScoAmctUT8I
Message-ID: <CAH3zFs1eE2VrxOZA9FoowJ9AKeBkdZE5P6t1cH0bxXq0iY6AhA@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] dma-buf: add optional get_tph() callback
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
X-Proofpoint-ORIG-GUID: e3H_4rN3ND0c-iq5Mx-9el3WGC60xuES
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEzOSBTYWx0ZWRfXwuL34qhK4m0a
 3KDtLZCbIfYL+S3LDPkCDpB4syCMgLvbg7bCZWVYCOrWni9Js/c2wxlHmE0fHufAY0tK9tUd59U
 hDsXvYOD10IqyEAIxGga8X/k01DfID7FDfsUDVA6xPk/0Fas3TB17cE71MuKgyuNEBfRPbxw6NK
 PCLpkTk5DK2lLkSavE6eOvn+o28VZZk2tammZyb/Lz91/BGRpI2AkWpnmT9HI9214gly8RIuJmz
 EJntnd+TCtvR+9BC3XyHtrVehsGJjpi7rQS5ztPM7p3lA4GeSCKA8NDtjYp00nfgSQ04LpDVryP
 ieJ6R4C7HG4PVv9m3kTwSU5IqEq9taPJD4GbsubO+mpfHOedEKUL4uEADtXkgC4x9nZ+MOmaboA
 lOVTD619foCzf/GDc8EKAIiolvQb+kRTk1S67CWKfaXh5kkDDUF7QNDVmAVvOlRIAkhG9rb99lj
 +8eLtYZoQXe8r8eqtyg==
X-Proofpoint-GUID: e3H_4rN3ND0c-iq5Mx-9el3WGC60xuES
X-Authority-Analysis: v=2.4 cv=ZKLnX37b c=1 sm=1 tr=0 ts=6a28255d cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=KaHoPmoT-FsTecDK8CMA:9 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01

> >  include/linux/dma-buf.h | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index d1203da56fc5..8437dbe4a83e 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -113,6 +113,37 @@ struct dma_buf_ops {
> >        */
> >       void (*unpin)(struct dma_buf_attachment *attach);
> >
> > +     /**
> > +      * @get_tph:
> > +      * @dmabuf: DMA buffer for which to retrieve TPH metadata
> > +      * @extended: false to request the 8-bit ST namespace, true to request
> > +      *            the 16-bit Extended ST namespace
> > +      * @steering_tag: Returns the raw TPH steering tag for the requested
> > +      *                namespace
> > +      * @ph: Returns the TPH processing hint (2-bit value)
> > +      *
> > +      * Return the TPH (TLP Processing Hints) metadata associated with this
> > +      * DMA buffer for the requested steering-tag namespace. 8-bit ST and
> > +      * 16-bit Extended ST are distinct namespaces in the PCIe TPH ST table
> > +      * and may both be present with different values, so the exporter must
> > +      * select the value that matches @extended and must not substitute one
> > +      * for the other.
> > +      *
> > +      * The exporter owns the completing address space for @dmabuf and
> > +      * therefore decides whether it can derive meaningful TPH metadata for
> > +      * that completer. The dma-buf core treats the returned ST/PH tuple as
> > +      * opaque transport metadata; importers that support TPH place it on
> > +      * outbound TLPs, while exporters that cannot derive a useful tuple
> > +      * simply return -EOPNOTSUPP.
> > +      *
> > +      * Return 0 on success, or -EOPNOTSUPP if no metadata is available for
> > +      * the requested namespace.
> > +      *
> > +      * This callback is optional.
> > +      */
> > +     int (*get_tph)(struct dma_buf *dmabuf, bool extended,
> > +                    u16 *steering_tag, u8 *ph);
> > +
>
> That needs a wrapper for importers to call which also handles if the callback isn't present.
>
> Regards,
> Christian.
>
agreed, will use a wrapper in next revision.

Thanks,
Zhiping
