Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E22A38C426
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407121; cv=none; b=T1Vglu9OZ3pyg4NCDKblzpNcArbzy7yaTCt3xhmRNsoTONZtEoN5r6IKOvdtY/sk0Mu5Y87L8lTLZG98/bEM+nnBL4jr2KLx2s/s57nliamnSmaNz7vuUnBNl89hD38dt0tPMYPnnz2o1ecAUsBk6yBgV+K32MYxjKW+zAPBgzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407121; c=relaxed/simple;
	bh=JwevNyHYbaNoDprDNW/6BYYYdADmxn2qXSN0ViYC+kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbWQkLWHY1BakT4CQofKFRN+suW19UD3jWRZga62eHf4Ktfn3SLpVvlTOa5V6SWiJRFGePwPdq6JnO4GMfmtBRkufKKZdVaDzIDoF5lP7EBYn1Ga3Prrb2SE564qdJ8KZdt73acyoSi92xZOrjZ9zr4N+qHBcp1aTSLhwzY8T+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGyb1rQk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaXqpxG/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGyb1rQk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaXqpxG/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773407119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVUiSQYXrtk6jqAcf5Jll8gGaAk63hJ5yi2OD/kWLXI=;
	b=ZGyb1rQksvAB7h/bDEgJItNByol47JvezdGj35Xqv1SaSefj8UdptljTgmFXV42W3dhG/W
	cVOwUSexv2AcLtbjvv4NRj5O70WOcLMOs2U/+eJ1a1JqNxOBtyDE0HU04waIfL721Bizf4
	yIM9jVDxQu+tXAPdjpGAbnjUyWNSWsU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-9dTZd1FsNhekzFmSuSqnCQ-1; Fri, 13 Mar 2026 09:05:18 -0400
X-MC-Unique: 9dTZd1FsNhekzFmSuSqnCQ-1
X-Mimecast-MFC-AGG-ID: 9dTZd1FsNhekzFmSuSqnCQ_1773407117
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48542d5aa9eso16392075e9.0
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 06:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773407117; x=1774011917; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KVUiSQYXrtk6jqAcf5Jll8gGaAk63hJ5yi2OD/kWLXI=;
        b=FaXqpxG/C6nYm68Z6VoUTbrcZMvIkHuy4lOPQNlkmgDmRGYwWykErfi2MVxehCYLas
         ouFhrE+9W9yl+jneBItOB+Yp4rpEWOj8t7FemRxFuJnX7a716Lxy1gWyR6XVRE5w2k3m
         UCOvSHIR/2zVDs7tStd5uYoFTGZ5GKjpW5Rt7evO/sQ3wfwfXvqLmAG/qRQXva+LPqYv
         lLeczSNwdWV7xHX6BGoV2EFoxNvu/nCUaGXc1dbDOldpOe9/+PzE8fpm8Aj2Ig2dCEtj
         SH9pXHS7vKBUIdMU6TbaYerGH2dNjrJ3ezEe1hRh2UMhe1Q5Czl8OmuRQOSuVwC2cosD
         A0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773407117; x=1774011917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVUiSQYXrtk6jqAcf5Jll8gGaAk63hJ5yi2OD/kWLXI=;
        b=k9S4qvl24jiv0DF9O8xoiuSsOzr7VEcmiV/Q0ARmbY8szB0jfI5zNY2hLtxFM80MBX
         iED8J+dbMEOAiF70ywSIhIiLS6Pnn/YEBqzFLUz98Y9fUAUFe4mNKI8PFog9d0xfIbxG
         t6LKi9hUsdqGw682GNn+seUhoiH4NWxc5WGazHLmRaXKa767fF1kydpQdEEUoI6lcR6Q
         vn35x0lFOmpAYIv2epGLjQk8ZzFb9s9BbzwnZc0wdgyxi4+JOCcue6DT0G+GoLHhYnS7
         ymtU2x0VjTtsRdyLH9H7JVQ/hsBh6xqV/Oykh2HSkVp1NYtAsTnqiA4W4Dh0V0PWbVAE
         Go4g==
X-Forwarded-Encrypted: i=1; AJvYcCW1FvzBCkNDxxm6MDWpmTSBfSRsvQugSCm94sUmGn8RsFa2X++znESvUq7MVSGy5aeHZKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxvk2jYAkhD470q84Ubbhh5J/QtgveT1vdQCMd/XnDkncAW5HD
	nttN42FuFVfKP6xls7oNFPWDTd6iYH4J62bmEKSKNMmi7k2pp+2OheVu50YZNbnbMzj+4QykHWl
	12pNFZ3BMCcQPDjobTmJVGvIBbV3caOs4GdxYwXBlIYWiyIm5Se3QpQ==
X-Gm-Gg: ATEYQzwE2mE/+8n5lrQ8Y30Er0lHOSxshQlWIw4sCw2BAwhnFSWGdCb6MIyHa8VnfDX
	eHBOR0aoRsATjmFYKRfb+v6/cpQhUzwtyCIkv5Sg31RtTjx4GE36v6NK86czggyCt6r9bqVl/Jx
	r0Q28ymCv/tCUsR9u2V5WTuvB76xzZwTDlc3KQ7g2Y91DXhzWVTqXpCE+zGEiFIkM9OoOVez0MY
	U4peoqs4AzJRBYCgGgdmHja9W2Gh1oy7RkQIFQxPq0TdKv/69lV3UQPY7eD1iG4Y4KNiAvYKSOG
	tKqT9Ynrele+MtQMucbAy9iosqEsyO5SYqVQizQsEdnjKGgOthLCAHTDMnQfS+qc3uo05N4yqaJ
	noRXSaeLL/y8zJt/fjJxbxZhiDFCJ9xmkAFmQWn5vu1rEDg==
X-Received: by 2002:a05:600c:8b6f:b0:485:3dfc:57c with SMTP id 5b1f17b1804b1-48556700bcemr49507105e9.21.1773407116406;
        Fri, 13 Mar 2026 06:05:16 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6f:b0:485:3dfc:57c with SMTP id 5b1f17b1804b1-48556700bcemr49506425e9.21.1773407115789;
        Fri, 13 Mar 2026 06:05:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b47145dsm207011475e9.0.2026.03.13.06.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:05:14 -0700 (PDT)
Date: Fri, 13 Mar 2026 09:05:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: hbuxiaofei <hbuxiaofei@gmail.com>, kvm@vger.kernel.org,
	julien.thierry.kdev@gmail.com
Subject: Re: [PATCH kvmtool 1/1] linux/virtio_pci.h: Include kernel.h to
 provide the __KERNEL_DIV_ROUND_UP define
Message-ID: <20260313090427-mutt-send-email-mst@kernel.org>
References: <20260227004224.269441-1-hbuxiaofei@gmail.com>
 <abQIsndYnBk3VC1c@willie-the-truck>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abQIsndYnBk3VC1c@willie-the-truck>

On Fri, Mar 13, 2026 at 12:53:06PM +0000, Will Deacon wrote:
> [+mst]
> 
> On Fri, Feb 27, 2026 at 08:42:24AM +0800, hbuxiaofei wrote:
> > GCC Version:
> >   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-44)
> > 
> > CC       builtin-balloon.o
> > In file included from include/kvm/pci.h:7:0,
> >                  from include/kvm/vfio.h:6,
> >                  from include/kvm/kvm-config.h:5,
> >                  from include/kvm/kvm.h:6,
> >                  from builtin-balloon.c:9:
> > include/linux/virtio_pci.h:326:2: error: implicit declaration of function ‘__KERNEL_DIV_ROUND_UP’ [-Werror=implicit-function-declaration]
> >   __le64 supported_caps[MAX_CAP_ID];
> >   ^
> > include/linux/virtio_pci.h:326:9: error: variably modified ‘supported_caps’ at file scope
> >   __le64 supported_caps[MAX_CAP_ID];
> >          ^
> > cc1: all warnings being treated as errors
> > make: *** [builtin-balloon.o] Error 1
> > 
> > Signed-off-by: hbuxiaofei <hbuxiaofei@gmail.com>
> > ---
> >  include/linux/virtio_pci.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/virtio_pci.h b/include/linux/virtio_pci.h
> > index e732e34..fb2f66a 100644
> > --- a/include/linux/virtio_pci.h
> > +++ b/include/linux/virtio_pci.h
> > @@ -39,6 +39,7 @@
> >  #ifndef _LINUX_VIRTIO_PCI_H
> >  #define _LINUX_VIRTIO_PCI_H
> >  
> > +#include <linux/kernel.h>
> >  #include <linux/types.h>
> >  #include <linux/const.h>
> 
> Hmm. This header is imported directly from the kernel sources, so it
> doesn't make sense to patch it by hand as changes will be overwritten
> next time we run util/update_headers.sh.
> 
> Looking at the kernel history, 205dd7a5d6ad ("virtio_pci: drop kernel.h")
> suggests that linux/const.h is sufficient for __KERNEL_DIV_ROUND_UP, so
> we probably just want to copy that header over (e.g. like the diff below).
> 
> Will
> 

Exactly.

> --->8
> 
> diff --git a/include/linux/const.h b/include/linux/const.h
> new file mode 100644
> index 0000000..b8f629e
> --- /dev/null
> +++ b/include/linux/const.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* const.h: Macros for dealing with constants.  */
> +
> +#ifndef _UAPI_LINUX_CONST_H
> +#define _UAPI_LINUX_CONST_H
> +
> +/* Some constant macros are used in both assembler and
> + * C code.  Therefore we cannot annotate them always with
> + * 'UL' and other type specifiers unilaterally.  We
> + * use the following macros to deal with this.
> + *
> + * Similarly, _AT() will cast an expression with a type in C, but
> + * leave it unchanged in asm.
> + */
> +
> +#ifdef __ASSEMBLY__
> +#define _AC(X,Y)	X
> +#define _AT(T,X)	X
> +#else
> +#define __AC(X,Y)	(X##Y)
> +#define _AC(X,Y)	__AC(X,Y)
> +#define _AT(T,X)	((T)(X))
> +#endif
> +
> +#define _UL(x)		(_AC(x, UL))
> +#define _ULL(x)		(_AC(x, ULL))
> +
> +#define _BITUL(x)	(_UL(1) << (x))
> +#define _BITULL(x)	(_ULL(1) << (x))
> +
> +#if !defined(__ASSEMBLY__)
> +/*
> + * Missing asm support
> + *
> + * __BIT128() would not work in the asm code, as it shifts an
> + * 'unsigned __int128' data type as direct representation of
> + * 128 bit constants is not supported in the gcc compiler, as
> + * they get silently truncated.
> + *
> + * TODO: Please revisit this implementation when gcc compiler
> + * starts representing 128 bit constants directly like long
> + * and unsigned long etc. Subsequently drop the comment for
> + * GENMASK_U128() which would then start supporting asm code.
> + */
> +#define _BIT128(x)	((unsigned __int128)(1) << (x))
> +#endif
> +
> +#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
> +#define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
> +
> +#define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
> +
> +#endif /* _UAPI_LINUX_CONST_H */
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index df42d63..6c22f1c 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -8,9 +8,6 @@
>  #define round_down(x, y)	((x) & ~__round_mask(x, y))
>  
>  #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
> -#ifndef __KERNEL_DIV_ROUND_UP
> -#define __KERNEL_DIV_ROUND_UP(n,d)	DIV_ROUND_UP(n,d)
> -#endif
>  
>  #define ALIGN(x,a)		__ALIGN_MASK(x,(typeof(x))(a)-1)
>  #define __ALIGN_MASK(x,mask)	(((x)+(mask))&~(mask))

