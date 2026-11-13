Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794548835;
	b=MrFgVWEfd9Cv82P+wY9XbnFmTOKhwwT5yCVQbjyi/eLgbIAa2+14Q5ebkHauCf+e4nQU
	 rl2OFDhA67pNldGGxVUcOdm9Ijc80CYAgKqn2xWi9C0QvD+dfuCQC71k+cEehxDRc4Mie
	 BTs1RL3j4DU1QbiuTyU3OczVdSH8S5lF41GqUiNO7S35ovXdlrWA4ZAp6Npg2BdqEFC1f
	 P7zZOnU8Qkhvb2t7k2EVmDNutOGUDv977Fu9ZcbvyrLyQsKWAxxiepo5LCpHCg98xBgAN
	 2uJqoOluOxzcLrtaX1vgzrEVFd0gIWTvwYRTRA/dEqUf4LHYkTDMYEk5pFx6/KKZaOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548835;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zv2dwLznTDzlBwaiBmqu3E6e2BGNnEevgfuztfawCII=;
	b=LjFxNX1n6ANTTke3YL3eG6kb9Mo+eO92NE3GkT/u7Lm5f2HL6Eaa6XnSTbVDkpxt2y8w
	 B48cIDUd2yoQCPyasRJNIgYoXP6jKB2wSg1t/+fOOnsnJUccbocIRNDf+KTUFF/kbdJ+u
	 VCipu6KfQJj8L2runRSQVw6kCLFiUINdtZzJsG3p29+A6vjcsTEWyeX515e1n9cInaIRK
	 /om8r3hKOzgSaVFV5zIbtTiFbtuzbug7CdLTHhux2u2q79gIxjnRDgrzWzQfchj2OusJi
	 UXW6t1PVx3tSrZlU/sw+giEy7HiiyTAggF7sjg+ibh7999Br/du51eqzWUqndeoVySA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VRUCH7A5;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JfUOyYiS;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099DE606A323
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 099DE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VRUCH7A5;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JfUOyYiS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794548834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zv2dwLznTDzlBwaiBmqu3E6e2BGNnEevgfuztfawCII=;
	b=VRUCH7A5X78vBeGc4sinXweIdZJAKlJNpCa8Q5iygIZvcOEPjsSKMqHjuxZ6yboEcksUdh
	OXrtExEugR2k++cly4qmaSRDbnib4bWwCkvhyge9NN3NY5KrlYwh20lMTQ2zvayYTHCGnv
	QWNa+h+tPcYgmKhmd8Y0i7haQUgzCVw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-R7HFFKtxM3a0NZ6zM33zPA-1; Fri, 13 Nov 2026 00:47:12 -0500
X-MC-Unique: R7HFFKtxM3a0NZ6zM33zPA-1
X-Mimecast-MFC-AGG-ID: R7HFFKtxM3a0NZ6zM33zPA_1794548831
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1f03f2e8aso4330445e9.1
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 21:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794548831; x=1795153631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zv2dwLznTDzlBwaiBmqu3E6e2BGNnEevgfuztfawCII=;
        b=JfUOyYiSFNAkKuUFsUiQe1CGXr2c3K4vM4qqbt3dQPBnGSzzXLdUKrp1mpVAKildnV
         8O/Ra2Jx33hgzfmUqKnHfOYFnvvNFSKDPL1eN2EdXwphs694bU2gobCu+MT/X1wuOK09
         IUWwh8G3Si/Z3Sc46WLe1ESWY1Ol0jFT+B6cK2DfK1rXbJog+7bMCIx5dF1cXyKCrbT6
         wnpXj6Bm/SJzw9H75b1NS9IRpzgagvAaJDEcjWKFMzzowRsIVUrPVysVDhpMUsx/U76Z
         FQTRW8wI68uXooKcaTa2EKUyoyFuQe2WsgQeRr4kpui9C/F0ajXpU02M99fbsN6xn1zX
         d4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794548831; x=1795153631;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zv2dwLznTDzlBwaiBmqu3E6e2BGNnEevgfuztfawCII=;
        b=rqbNh4PWPEEJ7hPNEBjrxoQkgFLKjr0uKRd6kabw1JKWzqd0DD0eCfZ+nlkeNvMpfD
         NwV5J9y9jFmsQLVK/uqRW+6YbjE0MdcsdlWpMoaCNSepO8FPj8JsgIMw3LyBtNcBmASk
         9tm1IjGj3f+pKDMmBgA/D+HnAqbuQZtfN9GULE3uL9nwjsBrJQkbvkvRxx/XJRoBEGv4
         tgM47yKZ5QFS1dOSb5Mn+cJ2ySSEQCFp2jbv/I/h9NtpAbHtbZWw0oeUPvj5SHLpMcjM
         Aoz5xlx9aZZ5jb8nExGN1NuBAaYqt2Id80D/Ax9unejJsxjX4YV4KdYMb2IsYbWdHld+
         JhNQ==
X-Forwarded-Encrypted: i=1; AL+hErHP3wznZB9hGiv/VSLtbvVhbh8SAgIUyfoz4AzB3aP84ZN9tQ2VNGuiBgzcrVesIr68c74=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+BdjOM7DF3G0sYCtrD6ymyu7Z19jvuN3bCHOy0dDuacqH0DKL
	I778LhVqurZM4tie05Jo9vK8lmvelBwIQeFS49qyBj483QzWzXlPrzdudl/ImhfC4UzZa6kMeGS
	+r6ALF3KtWzqVs8xdB6vIPMk/FIfLJZ7QHrMk0eGSQlH18mSu8m0KzQ==
X-Gm-Gg: AYBFou2Ml783rVBhhjoE2wu8UelnhKLi3yNa5mn+/z8c6ThiBbe2YiNloCdijFTP04X
	uMHxtqGIVcJ/l6pxLr93ZwxWsk+MCMxaKXAHaUIVGq6WoTZiPP+bX6nNglS3q9EtXr/HAOk7Qod
	PCksahXFnEQ9slm4Ehs2x46kpj7pHI39/VMbAPF8m/R7m0Rzj1xkoEeAM2YYUlMCcJma7RUdnqd
	/KPkiUaHhWVXy5JroJ7fassd5Unix/4Hex5Q1lpuV7Skc1uYj9ona+u9MVDubP167kc+t0en+aH
	XoW7RdbZmklWEqROed2xSCE5FaGr1bUandjbuddAd+ikR2kaxyZgbHn0visgmUrWADc5sxlG0mr
	mr+vSj5fQKTsb3pwSbQr9xJwrelwqK/lK0/JI4eMGZQ==
X-Received: by 2002:a05:600c:4685:b0:4a6:eca1:7d5c with SMTP id 5b1f17b1804b1-4bb55a91e31mr25254775e9.32.1794548830553;
        Thu, 12 Nov 2026 21:47:10 -0800 (PST)
X-Received: by 2002:a05:600c:4685:b0:4a6:eca1:7d5c with SMTP id 5b1f17b1804b1-4bb55a91e31mr25254505e9.32.1794548829900;
        Thu, 12 Nov 2026 21:47:09 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm122130755e9.15.2026.11.12.21.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:47:09 -0800 (PST)
Date: Fri, 13 Nov 2026 00:47:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhaoguohan@kylinos.cn
Cc: bp@alien8.de, dave.hansen@linux.intel.com, eperezma@redhat.com,
	hpa@zytor.com, jasowang@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	netdev@vger.kernel.org, tglx@kernel.org,
	virtualization@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH RFC] vhost: set dirty log bits without pinning pages on
 x86
Message-ID: <20261113004435-mutt-send-email-mst@kernel.org>
References: <af7f05bf637337d35fdd10f3e0dbb5e39d7780e7.1794480795.git.mst@redhat.com>
 <20261113012937.40818-1-zhaoguohan@kylinos.cn>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113012937.40818-1-zhaoguohan@kylinos.cn>

On Fri, Nov 13, 2026 at 09:29:37AM +0800, zhaoguohan@kylinos.cn wrote:
> On Thu, Nov 12, 2026 at 05:53:47AM -0500, Michael S. Tsirkin wrote:
> > vhost had a TODO to replace page pinning with a version
> > of set_bit that works on userspace memory, since forever.
> >
> > It is really best to avoid GUP on fast path entirely.
> > Implement set_user_bit and use it in vhost, to do just that.
> [...]
> > lightly tested. pls test and resubmit with your tool.
> 
> Thanks, this is much simpler than my version. Two comments on
> set_bit_user() before I resubmit:
> 
> > +	int __err = 0;							\
> > +	__uaccess_begin();						\
> > +	asm volatile("\n"						\
> > +		     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"		\
> > +		     "2:\n"						\
> > +		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
> > +					   %[errout])			\
> > +		     : [errout] "=r" (__err),				\
> > +		       [ptr] "+m" (*(u8 __user *)(addr))		\
> 
> errout is only written on the fixup path, so it needs "+r", as in
> __try_cmpxchg_user_asm(). With "=r" gcc drops the initialisation; here
> (gcc 13.3, x86_64_defconfig) it even shares a register with mask:
> 
>      1a3:	lock or %dl,(%rax)
>      1a9:	test   %edx,%edx
>      1ab:	jne    1bd <log_write+0x5d>
>      ...
>      1bd:	mov    $0xfffffff2,%eax
> 
> so every call returns -EFAULT, and log_write() stops after the first
> page.
> 
> > +	__uaccess_begin();						\
> 
> No access_ok() here. vhost checks the log range when it is set up

exactly

> and
> I couldn't find a way around that, but GUP used to reject kernel
> addresses by itself. user_access_begin() would keep the check (and the
> nospec barrier) local.

What we *definitely* don't want is nospec on fast path.

> Something like this, build-tested on x86_64 and
> i386 only:
> 
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -597,19 +597,23 @@ _label:									\
>  /* set_bit() on a byte of user memory; returns -EFAULT on fault. */
>  #define set_bit_user(nr, addr)					\
>  ({									\
> -	int __err = 0;							\
> -	__uaccess_begin();						\
> -	asm volatile("\n"						\
> -		     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"		\
> -		     "2:\n"						\
> -		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
> -					   %[errout])			\
> -		     : [errout] "=r" (__err),				\
> -		       [ptr] "+m" (*(u8 __user *)(addr))		\
> -		     : [mask] "q" ((unsigned char)BIT(nr))		\
> -		     : "memory", "cc");				\
> -	__uaccess_end();						\
> -	__err ? -EFAULT : 0;						\
> +	u8 __user *__p = (addr);					\
> +	int __err = -EFAULT;						\
> +	if (user_access_begin(__p, sizeof(*__p))) {			\
> +		__err = 0;						\
> +		asm volatile("\n"					\
> +			     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"	\
> +			     "2:\n"					\
> +			     _ASM_EXTABLE_TYPE_REG(1b, 2b,		\
> +						   EX_TYPE_EFAULT_REG,	\
> +						   %[errout])		\
> +			     : [errout] "+r" (__err),			\
> +			       [ptr] "+m" (*__p)			\
> +			     : [mask] "q" ((unsigned char)BIT(nr))	\
> +			     : "memory", "cc");			\
> +		user_access_end();					\
> +	}								\
> +	__err;								\
>  })
>  
>  /*
> 
> If this looks right, I'll fold it in, run my test in a VM and resubmit
> with the test as a second patch.
> 
> Thanks,
> Khan


Given the point is to optimize this code, let's optimize.
vhost pre-validates addresses so accesses are safe without
re-checking later.


-- 
MST

