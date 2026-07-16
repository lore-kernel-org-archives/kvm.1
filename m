Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FA43B27F3
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196295; cv=pass; b=aNtbi3Eq8aBwyPAXLiGXAn9ngdMyZOqLsv0uNSlXudmy4hU18ZBO1qepdM9mMrAK3Xf3YTr4DPWusj8sjKSiNcHTS4h5Ktioqd5di68IYqO6bR4b+8phwhUe6aD2nsg97pa9qwZAPL7oKOdL0A6G4Fv9PA+4VCygdWCzk+X2+cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196295; c=relaxed/simple;
	bh=BCB33d83n81ftt+P6iijBAgJ18dpo1QXcSXfEldMbso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fR3U+vyyRtWEa7VbJoltqx+SJwHjNME8eJ/aLEavLmMr+aXFyMv9WbmEQLQr1dQ2nlBKt8Ofq7BM2vPrQh8ZiEgKj2OWSS5jFcYmNkjYgWsIQVkJQcU9l7+r7Z5Uf4A8PdpLFsdQ9rRfCCLdATGPqxIQrjqyCT8yevaB6LWarOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEHaN+zJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=acLK9BTp; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEHaN+zJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="acLK9BTp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784196293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQt8yS/PdstDJXEvnchALJjULr9f9l02ImmRKvduirw=;
	b=XEHaN+zJOgzogYfvfV6KCilGkV5fNoXzFqa5mSozY3cq624mYvR21rA9+RWVXMWTwX4IRv
	FmnSlBZSi36sKPiiIxBtBhGDQyawAbmH0UqWlPhcEbkwgQ5UHdp6lN6DGYc/Bkgzzecb+4
	/PzmRkNh3F/ljSoY0Ux21bxZxHjeIq0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-XwNdKX5PMn-bl1vkRswfLw-1; Thu, 16 Jul 2026 06:04:51 -0400
X-MC-Unique: XwNdKX5PMn-bl1vkRswfLw-1
X-Mimecast-MFC-AGG-ID: XwNdKX5PMn-bl1vkRswfLw_1784196291
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8099ed7adc6so123537407b3.3
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 03:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784196291; cv=none;
        d=google.com; s=arc-20260327;
        b=nkPMwRq+gmeZbTZlDQcEaQzHoeJv6a18v5NK1p5yR6wO7f6EjXGS5QNdLRt0LZlgYX
         QnvE5CbDhEjJtn01xIRD7vrziWjQ5iqfkFSTpIhtTWqqUsqeD87fmQWo5FkgFNd/VoAg
         oA65N94Rt22o7Rv0ab4n0lVXF19NLaduIvrFRRN3ZTDmfUMw3VWMz+bg4NnvFtwUD0cL
         dvtKL0H/Op1PFvuH8F+hwy1u0cdwk2zAMICA0CJfNSFIG8yfj+1EjOZmVod1DqkxSi1Q
         610o8Pzh4G57yMbintuzi3byhAor95CJ8vL4hoQMRii46oU2tsswj2ckulgG/xg64Nus
         T8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rQt8yS/PdstDJXEvnchALJjULr9f9l02ImmRKvduirw=;
        fh=fOm1TfVtvVqfSQ8Vd7Mmg6QCZHusngvXLGorQpsaND0=;
        b=RrF41xKCQsMni+oV5hldutOKaNOZBtqdYkC/ynzMljJ8h5QYIGpiuoTvU47moKy5ve
         yMROc/SSZePLwD6Mkfm4cXpu3obdKr4o5zM2hnnqEq0Lbl3n56r7oL9vgTshJarjrk/z
         +4ZJPJT5JAZ2lm+t6XgnnkCflPkI55ADBuN/xFzH9IIiMT1BbetYW7+txLAGbfQoI7SZ
         dm9XyGJRFrSJ0wMvsOYZiHc2xuS3LZvXXJlW/dwhu9JSOvlHOemsCk3P82DXGmpq/DRY
         GHuHjxOTL3QZYSlRMZ6o1GJOEndD12PX75B/wCFF6PcZUIOcUbUUfNLj8BhmPHRjeCKO
         ejpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784196291; x=1784801091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rQt8yS/PdstDJXEvnchALJjULr9f9l02ImmRKvduirw=;
        b=acLK9BTp77Te5vOQDrek787iyM8AKN+jEdAT+OULFHLdw1h4abSfyivduFNrTiZVwl
         KHjtd2p4OKGPe96YCAMMLXDNA/abq1CIHUEMlr6lCPzlBDCQ1IZ39aLiEK0QfkEBuFKO
         b6aEBQdT8OTWWCkAe5D7vwa0W5wCPIAO862C5uFOJ0YRRsLn81aODGa+n0s1pegfWPU/
         RjIXy6/pyONIGdRk3vp3k+ld4ShhWObdHeR1lQaDC07PktG/N2ccL2PPUcKI8J+5g4UW
         6PpjSWGsvTnROE10+xw6Ce7CEcoTpF8IMSqB34vAqjxpZ2yy2kX08Ye6c8+Uu/eDetlS
         KfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784196291; x=1784801091;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rQt8yS/PdstDJXEvnchALJjULr9f9l02ImmRKvduirw=;
        b=Odhvu0a9SjW3JCJBOqhUWyB78M8LTexqutTrBN1yX0HBikmdB3D/bHRAPJBoOhFv59
         9Ux0NZvw0VfuJ/IJkWj4Wfqck9+Ku/OeHw4L6S3qlZIZMWECatdDvoPD/GyhUw0KQxH2
         JK8vT5pTBuWcbAOgufLJui/Ll3jn9B6sxlfQvEiIbDbx1NyU0lc4mFswALzP3Qz30gsT
         YEisUFUD/PS1Ccivg6LAzxkWvHcGPgdZKUhSZ4hOimMUXJmohvgId49QnrS5CZ1ubub2
         W3ifPZ1VaWKszjGjg+Rkzw3E4p5PwLDqRSG3AdUZAfNADyggWva2w34rZP3PIcDLsqpo
         NKxg==
X-Forwarded-Encrypted: i=1; AHgh+RomcLcQveTGThe/g8ILzGPRvWgK1jn0EACS/S51x+jxQ/4EVdR9Sq8sTJHUpOt+IYfBCu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFCN91A5R1mGSeLnQVhRZUtirnhADyQF1VzybJ3WqbjjSbddlX
	cHTY9G96N4izBkZmS/MW5QO40VnIoPUt3nBCDd/dacawQB9+mouKRt7PIqz8KM5Ms4issmxTuFe
	XO6d4MzlYX+KyC6+KIJUatu1a2LIhvZ+KxBLGN2f8HuLYYPD9TO+sbDx9UcdL5mwfjJHHeUHzk8
	9yAvCfyiPT3KdyoLHBo91snWJEPCLn
X-Gm-Gg: AfdE7clN49RXhVmw/6YUsKWalp5IJbSgMIcFF4R3BifDAMbwJOI70SFRLad7XZg+17R
	MBi8ml3Ld8lZTFbk2Eg68R86don1A1HUx0tT+GDoB0vPYBFWt2Wnu5733pUK/STGxh2YcGNTMpZ
	SQFarSRDHjwjDnWI+QMVNmlwCbEPF2oGUT9Yu890RjHKJClyHiytWrPxUL1Y/M4zjYPl16s4N5r
	CGda9v5UMjg/ToSiPEVMkk1ksMRZr2yFZIQTfxFX1+qQM/LvnT8NoMVn7OjJF81nLEZgovU0PbU
	yGvWNyK9V4mnBxc=
X-Received: by 2002:a05:690c:6a0c:b0:81e:69fe:a594 with SMTP id 00721157ae682-81ecfa37cf0mr48094007b3.42.1784196291310;
        Thu, 16 Jul 2026 03:04:51 -0700 (PDT)
X-Received: by 2002:a05:690c:6a0c:b0:81e:69fe:a594 with SMTP id
 00721157ae682-81ecfa37cf0mr48093747b3.42.1784196290871; Thu, 16 Jul 2026
 03:04:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716030238.124368-1-xiongwm2026@163.com>
In-Reply-To: <20260716030238.124368-1-xiongwm2026@163.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 16 Jul 2026 12:04:14 +0200
X-Gm-Features: AUfX_my1PDjF2_brAd_JA5jz3TnFGBqbcce5MlVt-5iITb1GzEuz4iCkoFmeE4U
Message-ID: <CAJaqyWdXReDxp-nbz2ydHrNHegEFjm4eGoKYQGYmmdt5e_gjaQ@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: reject zero-size unmap
To: Weimin Xiong <xiongwm2026@163.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowangio@gmail.com, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	xiongweimin <xiongweimin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 5:02=E2=80=AFAM Weimin Xiong <xiongwm2026@163.com> =
wrote:
>
> From: xiongweimin <xiongweimin@kylinos.cn>
>
> Reject unmap requests with size =3D=3D 0 to prevent iova + size - 1
> from underflowing to U64_MAX, which would incorrectly unmap the
> entire IOTLB range.
>
> This fix also covers the error rollback path in vhost_vdpa_va_map:
> when the first VMA lookup fails, map_iova equals iova, resulting
> in a zero-size unmap that would otherwise clear the whole IOTLB.
>
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  drivers/vhost/vdpa.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bb96b1aa5..f49bf1cfb 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1035,6 +1035,9 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v,
>         const struct vdpa_config_ops *ops =3D vdpa->config;
>         u32 asid =3D iotlb_to_asid(iotlb);
>
> +       if (!size)
> +               return;
> +
>         vhost_vdpa_iotlb_unmap(v, iotlb, iova, iova + size - 1, asid);
>
>         if (ops->set_map) {
> --
> 2.39.3
>

