Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792664397;
	b=jhXEcMB2vM8r/y9NeOtc3LSjaN2+4nljjKZEvt3J+CCau88q4ROHcR3PMd9yfB9OpiDq
	 FffV1oIOZlaj5821ktBrXDqe7urpoHdpnMxnR40E4KfSs4B++P1bHKJ4+TnD8HGQonHx7
	 OsUHKLI1yca8i7ZiRgrmF/9j1YssWDkSD1rvTbN4p2PcgERL4DSpw34qvOWsQspOkOdsU
	 m0DpvPrd5uzacFIZTSoyf9nmrC7SLn580o1Cy6CmX1FL8M9nviyVFgCEMkwTzGMLKzaWX
	 /1uMeJAbziTeWuRATeZGem8TQq9R7OsYRWBuK8yWDYp2Jn3Cx2t8S02HfYME0L/bkIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=8RseLjNm8lG/7UmlycVln9er/NWi2dNp7MDnl6ITlr8=;
	b=OfKaBE9KPCSffniLhWYiZE7eKS82AFyMJ81/z2j/OaUhIktsudXFI+mZcSApBT8v2Q8+
	 ATFi5BNGwvDNXuhSd3O8sGS9ouHEyo9A2DHz6alTFx1LhpKGBlG5N5D8k8S/xKLntZnP/
	 Xww6Aoj81kAYlF0GFwpD7xe/6s1+WknAkqut50pKZXrjszOit8eyJzJH7Dlctg4srWQNa
	 kocj6vGxPjmXKwoCfnoUwl3dTRouKfrrBo7qMXpffUm90YtJLs6JewoDlIFG8e02H1bvG
	 xyFSddTe7RJ32EZGQFfLBg1zU0yEGBHtWEyzoar++flVqVRy8kf+350gc5CA8JEEooA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aUJzr1v9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EA6606A31A
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 10:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14EA6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aUJzr1v9
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-930c0f9c1b1so166360585a.1
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 03:19:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792664396; cv=none;
        d=google.com; s=arc-20260327;
        b=h3+c2jBaXGrLpFMFwhNbhIFqCWpPA6RgniU1qboMuE9eKNRZd7QcguMljdH4r74Emx
         x9vFa+tCmSVID6z9vtC68gLuXScamQHIktIxfLDeopeCKd1WPz8cOrTjYKtWX1MdBKv3
         xa3FYOqb6DqjERaWK/6VhKu7MTsN1Bmij+vrSsrLPbgfnBlQPi1zKbJhzbVa3IO5Ypgj
         ahTrj74pfH+y0vslxFIsdKXJ7s1CXa6rb+FOVVN3ITbtlUj0yIK56Y+ZRMw4o7R+iCUC
         tx1P7RB1eXLWwT421VTu9oJcL1VWHAKa8NaJy+q70PLwWX0/PIm0Om6ShwlkDg+thyYc
         AaCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8RseLjNm8lG/7UmlycVln9er/NWi2dNp7MDnl6ITlr8=;
        fh=tsNwdeuHNoI237EbgyvwJIyhcGe1l7oo5aZbzF8Y63E=;
        b=YIQiikxI8+y+/1Pud0hUROOqTFBt+OWT4zcEU+KNIDl39GQmsHKJyUjjlQCIlWiOwW
         vosjr8ASi1yjPi5Lzpji/jreFAib7Y+B+JDlcSwW4TzepqJgVYUHRpsHn4t1l4AF8Vxk
         0Dw8Z5RIqoY4Xx63tayXOsar2EocvMumDYJMFc+aWMuNJd/99DWaZgNXHLKYWq2DMQlU
         nxoH4Zkpnhmpg1U3F3HXijAonUZOQzfoaFiph09HFQx7QfyywL/rs789H1yhFcCGWUY4
         kxE0WNOa2xlN1xMB0sE5QwDNAvKkg2Nt1YcMhsSoCusFFfcOXDXcH/AUJv7kOLFnCxJJ
         xhRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792664396; x=1793269196; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8RseLjNm8lG/7UmlycVln9er/NWi2dNp7MDnl6ITlr8=;
        b=aUJzr1v9HCvAKgJ2UTSl8mUeU+wQVplCGtZ0YUMOEGg5oZysXD+REwtONRHf2+MJaZ
         TwbRR8NGkA5aslgmvc+A3rI2NLGykz2FM0Y235FgmMy2pN6yoonoSjsMkmV2qHLsrzrS
         ArykiZlvdF6zdtSVaQuQdjwN0UYexGcAi4UAXOwm2Rq7EYHU6ABZDFMkZb+dXNcPUJbj
         I1ZRscTqYWKBiZM5BvMddh0R4SUTA/SazjdbXcWkdOpBVSA+escj8OFMeCdv2lKxXlsB
         kAhaw/CBDr14ZkanQZgTp0YPRdGdSF7aqYsnAceXTbiW8azyhku13EGgH6W3WZJP3d3e
         dBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792664396; x=1793269196;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8RseLjNm8lG/7UmlycVln9er/NWi2dNp7MDnl6ITlr8=;
        b=XOMgTM021LIbG8FrSEaeyaIVWdrpSSEMOl+Bm2VxXIRCXQxTwT5k0m0qkH37orUy+i
         m9x5m9rYQHVMcbgEpl1o3nR7SidXpOvb43X4RIQa7+IZst121UYVQ9yG3WG1ljUwEJUu
         WHEfZWVr3Ez+EZan/kf19yJpCoaC1UAsNWmjMmTLLRj4hAGDPhphqDUndk/BKLNACb9m
         EyGa1clhwUzvNzjQDnpbjrEw1w6wxAinFJivNADpH8K6qxT5BL7322/aJ7WdpYkrkrdC
         E8hj3y5Idy9QW2xqstLTHHGfBMZ4sVJF1ciK5QvYXBdqSF+jCzK5CKZMMOLJe+17WcUO
         zFuA==
X-Forwarded-Encrypted: i=1; AKwUvBxUoG37ASgCT8h4SCKbJJE1S50AKzVvgQNyHWv/bNU8M8rG1wzrcmgXNAQicOZF6mAX0zo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNfaMRcunhPDeKB3ecFYWlFc6DhikNaxEKXov4Zu/FkhsSQqmV
	WpCRCr2zIe0Nkgljq0919dfa5nGZ+K8x3Y7WbUM9mv1wKOnCUMfXUZaTQYzTne1+xvUNqrzrpTb
	mbDMx5a4ON37Wm/4R9C9Be8aeuubCZ8s=
X-Gm-Gg: AYBFou02SkaJlj9wwEhyLuG6/IFqavtGNzvZPdaEF3ewwxvrntVhMU23hvsmk8zLioa
	X3H51xhji5KDv6ltKIbDkmS8WyQBE1hAM55rN0JdtP4JsW9gaY2Js964zqk8sYi5t5Gtq490Rlk
	q//+9TT7qzDgAMHO8TFDkk4rWLTLmkuud1A46gvMYnELi6ntgajf95O2PA/tsZuQujFTXrwLNvN
	RxNASxLWBdp5KxdBXb5HfLKjKoPOy+9FLhdAExu1SeHC8U8u/lTUW/c5Vm7+jb0a9EDntKezfrn
	T4qDtnNTHtgEiwjogGOsrXOPDH4unqkRTpNxyROxxBTGEZAKr5VmbogbGXce5WC2Fd4Wtn8Dbnh
	fQ8EzzUbXqF3TJTpuyL93l5Ida44+w5uiOERK3Zg=
X-Received: by 2002:a05:620a:6504:b0:93f:277b:313d with SMTP id
 af79cd13be357-93f57e404e7mr834687385a.2.1792664395296; Thu, 22 Oct 2026
 03:19:55 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021085458.196742-1-physicalmtea@gmail.com> <d58ea6de-e17c-4426-afd1-0b67ead16b7c@oracle.com>
In-Reply-To: <d58ea6de-e17c-4426-afd1-0b67ead16b7c@oracle.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Thu, 22 Oct 2026 18:19:19 +0800
X-Gm-Features: AclHuK9FeuqH6i9COjZB1uH64DnGhDow9zmoJpb-bjLKr8MhdWEwBKDQwH0c-T0
Message-ID: <CAJwVaM+nBJ15=XwdV_wefNxd8iyxxSWjd-K8k_VAAc8yoyUZJg@mail.gmail.com>
Subject: Re: [PATCH] vhost-scsi: fix page reference leak in misaligned I/O fallback
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On 10/21/26 3:54 AM, Jia Jia wrote:
> > diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> > index 4f8c0260bc9e..b7e41c0a91d4 100644
> > --- a/drivers/vhost/scsi.c
> > +++ b/drivers/vhost/scsi.c
> > @@ -883,11 +883,16 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
> >       vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg);
> >
> >       iov_iter_revert(iter, bytes);
> > +     /*
> > +      * pages[npages] is the first page not added to the SG list.  The
>
> Just a minor nit. There's an extra space before "The" in the comment.
>

Thanks for pointing this out. I'll remove it and send a v2.

> Patch looks ok otherwise. Thanks.
>
> Reviewed-by: Mike Christie <michael.christie@oracle.com>
>
>
> > +      * remaining data starts at offset in that page.
> > +      */
> >       while (bytes) {
> > -             n = min_t(unsigned int, PAGE_SIZE, bytes);
> > +             n = min_t(unsigned int, PAGE_SIZE - offset, bytes);
> >
> >               put_page(pages[npages++]);
> >               bytes -= n;
> > +             offset = 0;
> >       }
> >
> >       return -EINVAL;
> > --
> > 2.47.0
> >
>
