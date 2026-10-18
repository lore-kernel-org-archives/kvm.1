Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CA441BA69
	for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792352923; cv=none; b=efaOrS6pY+9fnCW+rB75hVaGsKOIq4NQs+Cmr9O7AvlW/xsKtvUBdy+a+oHkcgUpaX9FfNHnoi962DQoWXfaAOYbLBaP1roA1Ig2pNGLselhVZwLAJjoJBBghw3vU0odrTFgHYux8V8J7o6/w6Zmg9iPEDhuDxReVm0ootJ64sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792352923; c=relaxed/simple;
	bh=z8+NKlZVaJg0D1viDndIi21e6QYlTGrfLeaOwjDv2Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8H7qXQMUU2okjtCsL/xfSWWHdhRqK5ec8D0cjP79uo7Mu9cspv4lcC/UA79OhZkffVY0SywonkCqRrZjcwo0zoVQXSxZxsg/pGWxhcNgsICZWnX0J7ClTIg6S0AgQQIdt1DLJuF15+17eOa4nNab7QR9gFSGKRrGxhyaH3M9Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETKAfiMW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETKAfiMW"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so10290965e9.2
        for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 12:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792352920; x=1792957720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nT4NId0U2jiAqaCcS2HDGNFvu8HoNbnVXS9R3IhMNjk=;
        b=ETKAfiMWGZMMjK7jvf+EaLF1zybUc4XOoUGXkkdzOT+59t/NrkQf6gawa07DV3ZO3I
         titJE0Pr86WP9hXNUrXseD5dRyKG/JCU2T2Auzz/SdVKR11XM+Rtqeqse7uVZ441dMWW
         2nO7O1Pv/jQF3jd5uyj73CIq3I7VmG9Uje8TcM+mDAYhpZ4Y+Mz0S6CDfOrCnFLT1wzb
         WEwWqAiZM7DGBXwiyrnfa1zqwgDFgo/+muOr7p3zy8hkfm55HmSTagkrYGealGz7Xmh3
         eCjWOKR4BZBk3KZnVlDN90n8H+I5rDwXnTa6laULzLc6pXGM7j2izhEefpar7jW0tfXn
         Iaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792352920; x=1792957720;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nT4NId0U2jiAqaCcS2HDGNFvu8HoNbnVXS9R3IhMNjk=;
        b=CPftE97ecBT+8LuLD/00ItfFSQ1L++x5x1G5IY5NSy6GfHVBPqdsg/1B181m8geeno
         D7vkxyoomb8jlmyx6txGBGtCVvRMmv5WkmzPt3YousWPcO4I6M2bE7X2tcfaJBpqsFhd
         NcchKycQekiDZfKZztL/kJ5SXrW5z8HLGlLnmzz/9TgJ/htrXL/YqZFaDzvcfBHshnhg
         fv7jM41LsM0YG3RwkgNvy7xEikXp+/xaDEDiQLEqD64ayjYRWzDNAsj5U+guQv1wwmrT
         bOhOvZ5zQmIIGhN5kqCT2zcDvsx56NPT6Skw2vvTAHQstGojVjCJ9Jmd8BTgUAbf++fN
         jLCA==
X-Forwarded-Encrypted: i=1; AKwUvBwG+M5cgIymuXaTPp1TZq332Ctppbi7LijZNDRYX0IyQsNSLrvUe1KRWHbmi79jUjzs9AQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXaRQEhvfpFI0IUec36/49NeVKdPxIooOXdFgm+b4Ly/pAHybn
	0OIB8mrQi5xDH30wy5EKuw6Xa1cK5pEEG8JTiDWtv7ygL/W0Evo9s6go
X-Gm-Gg: AYBFou0i7+niaRAs/JNW2XhDQxVFr2JXHZZiOHVYYasPUYtgxAN2roxe4mqAkDRv/SJ
	/cpUttXndoADxjNy29Vxqm8xGkwGoUWbn/E6uOQ+8+PqDK8S4wcAWA7R7eX2X1AkizSDi48ebfS
	Rvv3IHhGPvFbakld2oJf1JUkDG7fsCghbywugk5+jtnJ2q+Yc80GTiEVbrDxiKkEI7QwaUT0J1k
	y24fG3qrC+0m4OfYqfw8OIczFvSggZFTM9fvJrkfcWWxDd9dIjlTY+A8vKaaGIzvdQFA0iObfVz
	VUabLkql3wmPQ6zIqS7QM+KbWvLn/rUVZmZDHGWGwj1clws6KNeUo+I4xfWmXVH5pfIaTlVYaaX
	07AAaFxX+4LtbbKsG5ysry1a+w1nY0vNM3VqHu2UNeWjiYD7WkQH7n56YtVkXjJTG4ePRlH5xhO
	FNtwDx0CkzrfuwQMf/PdXNe9cXTz9Uztf7MQLQzBnEL4U1URjDUmrr8pnMSLN0P94O8Wirzo8uY
	IP1s0YDUBI0yx9ncLgn6jl8irFRVXgoFPg=
X-Received: by 2002:a05:600d:8488:20b0:4a1:e3e2:93e0 with SMTP id 5b1f17b1804b1-4a1e3e2967dmr30105055e9.32.1792352920294;
        Sun, 18 Oct 2026 12:48:40 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd50d1bcsm18886835f8f.54.2026.10.18.12.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 12:48:39 -0700 (PDT)
Date: Sun, 18 Oct 2026 20:48:38 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Haoran Wang <haoranwangsec@gmail.com>, jasowangio@gmail.com,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, eperezma@redhat.com, linux-kernel@vger.kernel.org,
 security@kernel.org
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261018204838.4080b238@pumpkin>
In-Reply-To: <20261018152358-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
	<20261018152358-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 15:24:41 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Oct 15, 2026 at 03:23:45PM +0800, Haoran Wang wrote:
> > I'd like to report an issue in drivers/vhost/vringh.c:1216 (function
> > getu16_iotlb), found via static analysis of Linux 7.0.11 and verified
> > against the 7.2.10 source tree. I have reproduced the leak on an
> > unmodified 7.2.10 kernel.  
> 
> 
> This should fix it I think? Can you confirm pls?
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/vringh.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 9066f9f12ba1..4b097170bd36 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1213,7 +1213,11 @@ static inline int getu16_iotlb(const struct vringh *vrh,
>  		return ret;
>  
>  	if (vrh->use_va) {
> -		ret = __get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> +		__virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
> +
> +		if (!access_ok(uaddr, sizeof(*p)))
> +			return -EFAULT;
> +		ret = __get_user(tmp, uaddr);

Can't that be a normal get_user() call?

David

>  		if (ret)
>  			return ret;
>  	} else {
> @@ -1251,7 +1255,11 @@ static inline int putu16_iotlb(const struct vringh *vrh,
>  	tmp = cpu_to_vringh16(vrh, val);
>  
>  	if (vrh->use_va) {
> -		ret = __put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> +		__virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
> +
> +		if (!access_ok(uaddr, sizeof(*p)))
> +			return -EFAULT;
> +		ret = __put_user(tmp, uaddr);
>  		if (ret)
>  			return ret;
>  	} else {
> 
> 

