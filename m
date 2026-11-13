Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577906;
	b=yfgggMLEfAD9rXESYoeZ+/xTfDHNEs+nmv9W/nGGzHbZuMpfGwMGlAtOt+FId9ttBala
	 +0UYM0G+P6cy3B69aBf8/6DQr0cpDE1mkQzzS0prRB0K1yZXQbZIVxmI4zyek/024+ny5
	 OxZSdYeAAZUp4vaBKZ4ZFmSZ5EonMMtgJfBbtGgqGpBcCKIP+bWNCdTSUxK7fEi+8tVnF
	 +qyARi7ralKf8afTnlrgXBYVuLro4nmh4tOw6IAhsvxgFX8HYda6Sc7MGqsHEFDcPm+Ie
	 LoGwG/ysHx0uxiIwjZi8MGqcFnL/BOe+bkFerRqtxRlbeMEuZNuawqQuVswwIF90OqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577906;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nzwVW9fNWfGXZUemLc1dTW/hhZ3xpHtCMfznCyx8mPI=;
	b=yVrWhtv2DK5dVC989MBWFvTULAjnDfrI3ECNqWcSJghRG7KIrXA6vObpM+J5+AwOKtRZ
	 FaLpTx+DjAd/DuHvTqaYzWnc/RNDAtBy85gaZm26+6ZC/a2fVq0U4Eiws4S+/qO6uNZrX
	 EEVdtHTgPsMTQuUFFveaRYvSs2YBwfACaCG71KktQKYp9lU0uy/fnM6zkGpGsrgdRZj/4
	 Ic94eYbWKkoK9Rh4DY5QpC8j68Tpyj6kMrclHXTXbtFyejdyPG/c8OozTv59ZMvvtSDli
	 oxKAfl6OSyif9ILNQ8IbD07c+SN3ADMide/mocaoEmEAlR9K8uTVBhbasAUsohQcABw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PquMVjty;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ECIV4Jho;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C040606CA01
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C040606CA01
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PquMVjty;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ECIV4Jho
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794577905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nzwVW9fNWfGXZUemLc1dTW/hhZ3xpHtCMfznCyx8mPI=;
	b=PquMVjtyZGfGYCr47ArvAw10Sx6XB1xjzp0Gz0SxHI8qWIFs80PQfh1xTcp4QHWjyKVu2g
	ysiGasak4ZP6CZkD9riBMfdwJ6fkwRcbc/cmQa9nrDb/CSlWsAJ3FGmmrtlZkFxNO+vfCj
	vjUaX5eIoNlUZBmyfUDOniWrUznGHQE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-kyqZo81JNwaoIp-GCDL_nw-1; Fri, 13 Nov 2026 08:51:44 -0500
X-MC-Unique: kyqZo81JNwaoIp-GCDL_nw-1
X-Mimecast-MFC-AGG-ID: kyqZo81JNwaoIp-GCDL_nw_1794577903
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4915ba023d4so391711f8f.0
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794577903; x=1795182703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nzwVW9fNWfGXZUemLc1dTW/hhZ3xpHtCMfznCyx8mPI=;
        b=ECIV4JhoLU17HxPiNt/9IPbToz1Q9M0ZMdWYEbZF9dgHjBSqYjxBItkMJAdLrPIE/w
         9BaD9t99NeGPTSEuqAjus0I82h25o5EZpJtv8S6OvmXtCHTII9YNlxhqt80ejg7M4lPi
         jZaF+6TL4ftJXcnFmrSq+VQarvnvLHKzO38cnffKeUram4D6URkhgK1jKnUwQTBTzSlU
         VeS7ckUEYdgPXhCeZImkQ00tqQl3oG5kq2SXvcapUP2MG3X/gBOHnnM5VZuw7aMAYeeq
         g3W+5Gi/OaaFPtqtZWWkPntCnpw7El38l8SDggJY8npS4m1ealjIDpCzWcOZ9aj0b6i+
         mx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577903; x=1795182703;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nzwVW9fNWfGXZUemLc1dTW/hhZ3xpHtCMfznCyx8mPI=;
        b=uUBxJRqkgjXQ0XXI80wLeBVIz4xnqWbmIdSPD73R95ZVL3ff83HjJvO1koGrHD0PKo
         vLE/EFH7OjOpBOKTa5xdQvkgTDPFWZ98CkF3kA95QNtyTQ1qzzAm36ZDKMH93iBTrDFW
         QSFzUlaegKSu5jXhqFmNTm0EMj4cfrY2AAMPuNMTyDvHWwdLlRwOSX79FFl3Em7EC5jU
         i829lay0IoC4+N91dNFtyPoeHeW2FhURHIVLkmP3YzAVu0+7peCWzz7L7Zx2SUzx1ETW
         5L2RPvOGmKE1DScEKLpKnwFnceMC50TETzn2AZWHL7L0h/bNf3E6ZSQIMun1dagJk2rI
         6dGA==
X-Forwarded-Encrypted: i=1; AL+hErGLH650ZvImlM9cG/KET48ixdfhPpDHoCJqzamdzu7VqNND7F6WtMhPjb4KWtdum+8erqE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Y8EUbjuGkgvFj+XdLveNjz41NrT9GciguhbZkvysXvE7TPOua
	Hrjm7etOcQyZKm1tvdFi8pIyMp1I8++MmeXnvYukJWIyOIbMVqnOIzqElY1WATY+60Jbvn0n1qP
	ZeWgO9Woc6OIRElEjfDdWJffLTAzvLLuPRkBBmVL5WuR2hX9kZGxxFw==
X-Gm-Gg: AYBFou3Yr7WNw3aeQLRS7l+TXEBmNl/u4sb/BuGaL6xbOxDwYd2ymF5ykg/FR6yQ4+L
	776ya0IjlCEWerej+5k5tRsHmYTWpl+G9bLjfwfvxpS4V5zPlawTNqkLRGQDlkVNhbfnkVzUcLx
	afM/GnGMH8Sem+yAqPAOZibKZopOwhAWJ10FNlBwlWdKC2JoV5LGrfvg4UOCxAYNkQAOdr9Ee4h
	alEtn0IZJh9ggOaTsaO/gFgN+G5oYEzvgryoVYpQ6ECoao1VO6iOL4WTtAfpdvvvx3TYpf88p//
	H8ujAwGJyJZy6YGFzA4O53MT3FL03dJCKLUji1jP0Ei22QyIDL8EA5Y+7ZEeV+l/jkV5oAtsQHs
	0P5nkPXopf8CdHBu/fNmydZaXbOP1pVjB+fPbDTrmQA==
X-Received: by 2002:a05:600c:c16d:b0:4ba:495c:2f5d with SMTP id 5b1f17b1804b1-4bb55a3e3f0mr51424275e9.9.1794577902443;
        Fri, 13 Nov 2026 05:51:42 -0800 (PST)
X-Received: by 2002:a05:600c:c16d:b0:4ba:495c:2f5d with SMTP id 5b1f17b1804b1-4bb55a3e3f0mr51423795e9.9.1794577901867;
        Fri, 13 Nov 2026 05:51:41 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5667a8aesm42328895e9.1.2026.11.13.05.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:51:40 -0800 (PST)
Date: Fri, 13 Nov 2026 08:51:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhaoguohan@kylinos.cn
Cc: bp@alien8.de, dave.hansen@linux.intel.com, eperezma@redhat.com,
	hpa@zytor.com, jasowang@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	netdev@vger.kernel.org, tglx@kernel.org,
	virtualization@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH RFC] vhost: set dirty log bits without pinning pages on
 x86
Message-ID: <20261113083351-mutt-send-email-mst@kernel.org>
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
> No access_ok() here. vhost checks the log range when it is set up and
> I couldn't find a way around that, but GUP used to reject kernel
> addresses by itself. user_access_begin() would keep the check (and the
> nospec barrier) local. Something like this, build-tested on x86_64 and
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


So, you were right, it's better to check access. But I don't like
paying nospec. Let's use the modern scoped accessors?
Like this maybe? Very lightly tested, no time today, sorry.
If you want to use it:

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>



diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a0dd3c2b233e..0bffa43e02179 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -594,6 +594,28 @@ _label:									\
 	__ret;								\
 							})
 
+/* set_bit() on a byte of user memory; returns -EFAULT on fault. */
+#define set_bit_user(nr, addr)					\
+({									\
+	int __err = -EFAULT;						\
+	u8 __user *__p = (addr);					\
+	scoped_user_rw_access(__p, efault) {				\
+		__err = 0;						\
+		asm volatile("\n"					\
+			     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"	\
+			     "2:\n"					\
+			     _ASM_EXTABLE_TYPE_REG(1b, 2b,			\
+						   EX_TYPE_EFAULT_REG,	\
+						   %[errout])		\
+			     : [errout] "+r" (__err),			\
+			       [ptr] "+m" (*__p)			\
+			     : [mask] "q" ((unsigned char)BIT(nr))	\
+			     : "memory", "cc");				\
+	}								\
+efault:									\
+	__err;								\
+})
+
 /*
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.

