Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0592B3BB115
	for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359703; cv=none; b=UEukH8j5htgdNQI5eQukLC9iLlpqChm9byyKvfGzASHBRbMh43VNdRn4VxlkKqG0QhUgd7IZnY+8bhxt0YDfzTzJTf3Q9LIaeyPfxINgJjRkzkanXVPO3XPR7w7z4fbyGcEmlwkUZqc98UOxUCSJWDOLjCYRaYBTY+m3jcWFq+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359703; c=relaxed/simple;
	bh=QpgY1mHMPAh+BF52MMdR/jItFN7LZuBUhKsHUTs7ZxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBaXSfQ0y6IEVRPtQ1KX6NrQ96ffoquDcqzRrPUo7atUKE99AKv9HKrg/yuZJPLP5cQMlmR4I6GzX0e9W05HOKSUVwzWQvUtO3yAQYZfulrRGFjm9mernM5WXPUW8K1YPO3OwG8DnROQki7j1V7mIzGm5uKuGUYobFyvCrn4fG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XumI1apw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=okZBJI/E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XumI1apw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="okZBJI/E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792359700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R2sM3UmHiQ62epsC/FE3R8schNmhPjjNgAmVVqxJiF8=;
	b=XumI1apwqSqlUX11ehn7W2ogNgqbcb3Fe3qxlyNDMEnHKbIb7N3EdHGeS11SGT+CL8hQAc
	cKNUtCzd9rxaW8yrM9J18PCZi/2y7ly2yRlnsiaFGOsoIXMjAfTIEFpg+E0uBJ/9kpSLbw
	ZFceHMcJqYc6fF+zDacyZqPbjzgaRiU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-Y_vcSLI3NQq9BoOrafA26A-1; Sun, 18 Oct 2026 21:41:39 +0000
X-MC-Unique: Y_vcSLI3NQq9BoOrafA26A-1
X-Mimecast-MFC-AGG-ID: Y_vcSLI3NQq9BoOrafA26A_1792359698
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a01ba12198so18320585e9.1
        for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 14:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792359698; x=1792964498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R2sM3UmHiQ62epsC/FE3R8schNmhPjjNgAmVVqxJiF8=;
        b=okZBJI/Es/jSsi48kQOtMvp+hrjgpPCUuLiqAZg2lI8YZnCRcpJOc69w5k7FI0sMWx
         cpil5UJKPTGaY9mNLgqs2RJpxWLjOk7p0juNQFK7cwstRrIxSeqmeF+zEVpTQM/V+xqB
         Z+ZdfhTzIbEtxCpuBKHDV0rM2f/8zAdff/ltUuUgAdQ0QuZime02I2RdzsOHTgmCKEsQ
         n7/PqsVU4WpF2GoXhg9Fio+lYK4O2ykbeZ37ug5p8g4d0PLIjrYhDBLDay2xdPfSPWSp
         zlyrwrv6j2PVqZYOkNQA/DubKuM/Ls3+6Eb2/e1xOSCYOB7fp77ofOb6Vl1wLtYLIsEP
         MIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359698; x=1792964498;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R2sM3UmHiQ62epsC/FE3R8schNmhPjjNgAmVVqxJiF8=;
        b=JeP64JVrG7XTpzsghU7cjOVNRHXDy1Q2iX8Ufi7TwLY95Ny1DFh3jeiAcAbK2X4G7O
         a08f8pK/TUXZF4p/nHXjqOTTAhhDf1yfbzS8LWyfeGNNhEwGpFMRN9rTFUdFKu4tZuJM
         xJ/n5HBAPQosFCgHwVVGWkOaLTpo5i56MzJVhnBM/IYHm+tc6uGKhAHFY5TFnlFHXlFu
         T8Cs7XYGuQMD5jFYrzKKpvfZHb+9dlBlQ1NgD1O0ZLeTbMw0yyXraFhzUUte0ZpmBTEK
         Xsi7IUj2Hrli6xB20Sc2nfL9XJUK8SwcdT0J4xWcQSbfBJywI9NS655Rg2dPMoppjffB
         eO8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwk1aqHt5QWakIqurOPmdxA41fOt8jbTLJn86HngInf9w8cgHX7m8rA5oTqeXIvauiEX1c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKx0l9mo4AW1e0A71OnmkYZJb3mtJp+3gP/CO2u+fxGwJnsOUDi
	z8QciwL1g8VUk2u9iNRi/KOGoliSuUPajNzygf9Mwh95KDSS7/RSrg7eYbCvLcijflYkgYmszny
	k7nZo1urxA/9BGP3dhmd+N8S3sYCbZ4h895RQbh6CxO2Vt1wybqqWZA==
X-Gm-Gg: AYBFou2Me8yhq/mspoVgPPVWDOXVck+s8vkkLRPtBmIlu3HmeDE4pHHMeTSRdZ6E4J7
	I6nh9liFcOVDkHRbZaSU8vk/HRom501SpJM75jtClP/rR6BTWXBD1sMZPM3qmkNS/DbvTWao7VE
	u359yASdMHgFuZP4AB0APnSAh+43xUwmXdwE48DDVQ68KrR3cZjkvQAj63O6Y9GHunJMIq56WlG
	5nCkeQOkGYpWy3js6iSsLWkCc7MVTIPKQmLKL0NMd4sQwr5mkcgl2dGmlGS2VLX3MS6HJb9tJXF
	67wtrG4vSJ9OurttxkbKW/h1c5n0n64yIJzvHUdRMXKBnSGL5Becco3T8pr5wU0aherU4g==
X-Received: by 2002:a05:600c:8709:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4a1d760536cmr116501165e9.13.1792359698231;
        Sun, 18 Oct 2026 14:41:38 -0700 (PDT)
X-Received: by 2002:a05:600c:8709:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4a1d760536cmr116500815e9.13.1792359697712;
        Sun, 18 Oct 2026 14:41:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1e9423f20sm12734705e9.7.2026.10.18.14.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:41:37 -0700 (PDT)
Date: Sun, 18 Oct 2026 17:41:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Haoran Wang <haoranwangsec@gmail.com>, jasowangio@gmail.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, eperezma@redhat.com,
	linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261018174010-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <CAHk-=wjxOy24XQnSSGimnHbp9mVjUETBE5HrS+W9E8mRrtxBLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjxOy24XQnSSGimnHbp9mVjUETBE5HrS+W9E8mRrtxBLw@mail.gmail.com>

On Sun, Oct 18, 2026 at 11:11:44AM -1000, Linus Torvalds wrote:
> On Sun, 18 Oct 2026 at 10:34, Linus Torvalds
> <torvalds@linuxfoundation.org> wrote:
> >
> > And __get_user() together with access_ok() is actively wrong and
> > stupid. It's slower, bigger, and more bug-prone than just using
> > "get_user()".
> 
> Btw, if you have *multiple* accesses to the same structure, that was a
> historical reason to use access_ok() with multiple __get_user() calls.
> 
> But it's not a useful pattern today - and hasn't been for years -
> because the real cost is not the access_ok(), but the stac/clac that
> surrounds __get_user() on modern hardware.
> 
> If performance is really crticial, the new "unsafe_get_user()" model
> is the way to go.

Thanks! I'll try to find the time to look into converting vhost to that.
The flood of ai found bugs I am dealing with will abate any day now.
Any... day... now...

> Here's an UNTESTED example patch of how to do a conversion. It
> generates much better code than __get_user() ever did. That patch
> looks good to me, but again: I didn't actually *test* it (and the
> reason this signal.c code has never been updated to the modern pattern
> is that it really doesn't matter for performance - I decided to use it
> as an example not because it matters, but because it's a good example
> code-sequence for the legacy model conversion).
> 
> Somebody should test it.
> 
>                      Linus

>  kernel/signal.c | 56 ++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 30 insertions(+), 26 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index d31ebcb6ed4d..0fd1296e912b 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -4776,12 +4776,12 @@ SYSCALL_DEFINE3(sigaction, int, sig,
>  
>  	if (act) {
>  		old_sigset_t mask;
> -		if (!access_ok(act, sizeof(*act)) ||
> -		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
> -		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer) ||
> -		    __get_user(new_ka.sa.sa_flags, &act->sa_flags) ||
> -		    __get_user(mask, &act->sa_mask))
> -			return -EFAULT;
> +		scoped_user_read_access(act, Efault) {
> +			unsafe_get_user(new_ka.sa.sa_handler, &act->sa_handler, Efault);
> +			unsafe_get_user(new_ka.sa.sa_restorer, &act->sa_restorer, Efault);
> +			unsafe_get_user(new_ka.sa.sa_flags, &act->sa_flags, Efault);
> +			unsafe_get_user(mask, &act->sa_mask, Efault);
> +		}
>  #ifdef __ARCH_HAS_KA_RESTORER
>  		new_ka.ka_restorer = NULL;
>  #endif
> @@ -4791,15 +4791,18 @@ SYSCALL_DEFINE3(sigaction, int, sig,
>  	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>  
>  	if (!ret && oact) {
> -		if (!access_ok(oact, sizeof(*oact)) ||
> -		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
> -		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer) ||
> -		    __put_user(old_ka.sa.sa_flags, &oact->sa_flags) ||
> -		    __put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask))
> -			return -EFAULT;
> +		scoped_user_write_access(act, Efault) {
> +			unsafe_put_user(old_ka.sa.sa_handler, &oact->sa_handler, Efault);
> +			unsafe_put_user(old_ka.sa.sa_restorer, &oact->sa_restorer, Efault);
> +			unsafe_put_user(old_ka.sa.sa_flags, &oact->sa_flags, Efault);
> +			unsafe_put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask, Efault);
> +		}
>  	}
>  
>  	return ret;
> +
> +Efault:
> +	return -EFAULT;
>  }
>  #endif
>  #ifdef CONFIG_COMPAT_OLD_SIGACTION
> @@ -4813,12 +4816,12 @@ COMPAT_SYSCALL_DEFINE3(sigaction, int, sig,
>  	compat_uptr_t handler, restorer;
>  
>  	if (act) {
> -		if (!access_ok(act, sizeof(*act)) ||
> -		    __get_user(handler, &act->sa_handler) ||
> -		    __get_user(restorer, &act->sa_restorer) ||
> -		    __get_user(new_ka.sa.sa_flags, &act->sa_flags) ||
> -		    __get_user(mask, &act->sa_mask))
> -			return -EFAULT;
> +		scoped_user_read_access(act, Efault) {
> +			unsafe_get_user(handler, &act->sa_handler, Efault);
> +			unsafe_get_user(restorer, &act->sa_restorer, Efault);
> +			unsafe_get_user(new_ka.sa.sa_flags, &act->sa_flags, Efault);
> +			unsafe_get_user(mask, &act->sa_mask, Efault);
> +		}
>  
>  #ifdef __ARCH_HAS_KA_RESTORER
>  		new_ka.ka_restorer = NULL;
> @@ -4831,16 +4834,17 @@ COMPAT_SYSCALL_DEFINE3(sigaction, int, sig,
>  	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>  
>  	if (!ret && oact) {
> -		if (!access_ok(oact, sizeof(*oact)) ||
> -		    __put_user(ptr_to_compat(old_ka.sa.sa_handler),
> -			       &oact->sa_handler) ||
> -		    __put_user(ptr_to_compat(old_ka.sa.sa_restorer),
> -			       &oact->sa_restorer) ||
> -		    __put_user(old_ka.sa.sa_flags, &oact->sa_flags) ||
> -		    __put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask))
> -			return -EFAULT;
> +		scoped_user_write_access(act, Efault) {
> +			unsafe_put_user(ptr_to_compat(old_ka.sa.sa_handler), &oact->sa_handler, Efault);
> +			unsafe_put_user(ptr_to_compat(old_ka.sa.sa_restorer), &oact->sa_restorer, Efault);
> +			unsafe_put_user(old_ka.sa.sa_flags, &oact->sa_flags, Efault);
> +			unsafe_put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask, Efault);
> +		}
>  	}
>  	return ret;
> +
> +Efault:
> +	return -EFAULT;
>  }
>  #endif
>  

