Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479566;
	b=dgZtZCmALQGrOkEJcEET4wEufwqQVi1OyFCvLMsIXFI5g0B2Kef4QwNEaxdzfCcrS1/Z
	 JbdLeEujZ+8u2s2CPt+Ac0jQthjiz8LEwFVhYGxargfTi+xPjarS6/9+CcOwzJ+Jgd3sT
	 Y1T4v5L2hILCJcvDexp2jyNnxgx+D0rSO6I/Z0xgeXdkUHQ5oQu0pVWMgB1xf+B+r9Ijg
	 MZV4Qy2NVRASp77LiCkqnVynI9h5qxkCquRdyt7s1XM2iW9ZCuoSdyt8VyqPgJoXRcJoj
	 nCdwzIoqCYac4oafRlZgtQmNC4B4oDtYjfaUzp9C7r6Pyg4JHVytrjACmULO1a/gtZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479566;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UL9CkfGicYHskzbB7QLYGJW2B+YLZ3fPF5rU/gdSK84=;
	b=PhiDvwZrmnBUhnzBTvOb+eHGp+tkK8w8EHTRnX5w921zInM2n2ihIi6lSkDAN1SM73ig
	 bPzTenqgQcRDhaOddlZkv93nx73sML28rxCYRDUISHSzQ8l24Grni0xPVP8Wl4joggiZ+
	 /nGOqAY2jSbHWzYFfMxmA8HxjhoWbgMOnc64Rm00Q3xcryN9pTESz6aCNtHJ/crjjsbJu
	 X32Lm7BhkC0o8edeJdsZnblUJpyIi32u/04hIbT5t3mBg11Bt6G9h3ulyqWLNTQZdTzGc
	 9bSxuEKK68UoEXESszJF67IiQkyQmxn58KMvgzCafho/gp0WOI/s2k4qMbvLP7LnyaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cdEzfYw1;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kPOjEmLx;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F973606A327
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 10:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F973606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cdEzfYw1;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kPOjEmLx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794479565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UL9CkfGicYHskzbB7QLYGJW2B+YLZ3fPF5rU/gdSK84=;
	b=cdEzfYw1VUzLGvgGdms1nkD9tnISOzvflFYrstudLcHJ0G4Th/F/EKDBBCyNyuVvQANJWq
	G8SUDyubBI3/S16/7sLuUena3i8eofeaQq4rIm8xUAdGWCNFlo0ULDMvo6sd8FYALN9oEs
	YpdxE6k0WLJPEZZS9fCBIZIyjwlNzT4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-3OuRooe5NoSgepauf2ofwg-1; Thu, 12 Nov 2026 05:32:43 -0500
X-MC-Unique: 3OuRooe5NoSgepauf2ofwg-1
X-Mimecast-MFC-AGG-ID: 3OuRooe5NoSgepauf2ofwg_1794479562
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4902ce85f72so3193632f8f.2
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 02:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794479562; x=1795084362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UL9CkfGicYHskzbB7QLYGJW2B+YLZ3fPF5rU/gdSK84=;
        b=kPOjEmLxu7gi1CdtO0vcG03qXrRfY2c3j4RfSnB3JcoexUEtKw6J/cjWCsKeek+/pj
         9FAUM5+s+khOQf2DfEPj2jWuf/AZ/Kx8fp2BYUITwTTKoF7eVsgjwYWVtNy7EU3fN9hg
         1uMPIfwiNvHYrV4P9ijjxgTqU+kjvRfEhlPOdb/j3sSUg6Dk0sGLKsaezUlUKCMldtvs
         Ozl+6fFKZA7upZ+XQOK4R59KSOuF7oNEwVLFPH3GQ83Grf3fRUPWzdemsTvTBPpQiwjb
         MjcyMo3oyLUebQrWht++6K1Ypqik1PWFh2yHGU6fHC5xUtl/r0GIRfyE7wZ+bEpufXjK
         GU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794479562; x=1795084362;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UL9CkfGicYHskzbB7QLYGJW2B+YLZ3fPF5rU/gdSK84=;
        b=dMxraC60eX0WC2d0JKJJxwRxjMD88JAQfaXn+g+VpX9gib8bffxjfKcePVPs3yeUnC
         yNOxK+xIBcA2mV0nsd64S5lLNxlxdIAtdxcfUnliOdFdGMbt27YgtO0wyCbtzgLWKqCQ
         /BKwIsfF7R2CGtsBJOy2qigGCRgf/mhlKoHLJVsOZEw1B0aN/RXwHdGx54wps0b2BYFk
         X8THwlZIRn4jrcx3sjIhM1YbfWeWagbAk85J+4aWkmZrzHqabbdYaG7VuwfFvcg3msrg
         fswVgM3KE3pjsAPOeLk4CFxpliNiOffYoPB+Znpncpd2abO8fpLD1+sSz36aBcma+/Pw
         mnfA==
X-Forwarded-Encrypted: i=1; AL+hErFh/4ps2Zm2hpZEn04Ok/8pPYSJB/QtMFDUtLbhor8E8xbkxCHzT7058YRu9wPhVKmxk9Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QBEmmcUwEfifMy1Al54opPXcq7fSy45pztdxjMjhxN9YcARKW
	yrmVUr6XEXHL4Ia0l/0V9PGfg4TALJK19vYbuOPwhow1BvG3ReVau+NtJudsckoSDrICXiM+QQc
	Yx9MK+WFEoprhJ3Y58Vll+vo7/2Axe4afpt6iRxycWKaTlV6EGjZ22Q==
X-Gm-Gg: AYBFou2IrChxkvkZeu7X53sM+J4yXhF5bU6XXNSJJNpPKvKeZabmQVFMhmlKYTWTyQd
	5gVU6M/Y6EatIM8rqhKQou3VebSXUzU/pubLH5Aql2QlHAFtO8A4TDDgQsFdcGfIkWQscbBBnN8
	DzenqgilMxOxhU6Juphnv1NSwryx8Lmt7V8VisSyj7mfJXjk6+ET2JGrONCbrxGBdCcUmt5Kvfn
	2YUe7N7ti9IQ/RG+Ox6ls9whULr0B0VspwzcE+o1HM5zS+kKsgEpR/AS/6Ek3IBcORZ+r3QWNT0
	Drxe9My24QGWsowclsHkwWcQa0UBhsYrB4CXlDGXwejO8SgQcGxvAx5F4/ncLuHIb6z+CwTiTW/
	JSGhfGihZAhpfGbmqXPnumsy9RXuwubNL75NsVP959w==
X-Received: by 2002:a05:6000:1861:b0:48b:1296:52ec with SMTP id ffacd0b85a97d-499c68d2bf7mr10244189f8f.18.1794479561875;
        Thu, 12 Nov 2026 02:32:41 -0800 (PST)
X-Received: by 2002:a05:6000:1861:b0:48b:1296:52ec with SMTP id ffacd0b85a97d-499c68d2bf7mr10244096f8f.18.1794479561175;
        Thu, 12 Nov 2026 02:32:41 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bd6esm16325613f8f.28.2026.11.12.02.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:32:40 -0800 (PST)
Date: Thu, 12 Nov 2026 05:32:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhaoguohan@kylinos.cn
Cc: jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vhost: set dirty log bits without pinning pages on
 x86
Message-ID: <20261112051259-mutt-send-email-mst@kernel.org>
References: <20261112085631.128819-1-zhaoguohan@kylinos.cn>
 <20261112085631.128819-2-zhaoguohan@kylinos.cn>
 <20261112045853-mutt-send-email-mst@kernel.org>
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
In-Reply-To: <20261112045853-mutt-send-email-mst@kernel.org>

On Thu, Nov 12, 2026 at 05:10:10AM -0500, Michael S. Tsirkin wrote:
> On Thu, Nov 12, 2026 at 04:56:30PM +0800, zhaoguohan@kylinos.cn wrote:
> > From: Khan Zhao <zhaoguohan@kylinos.cn>
> > 
> > set_bit_to_user() pins the log page with pin_user_pages_fast(), maps it
> > with kmap_atomic(), sets one bit and then unpins the page and marks it
> > dirty. This runs for every bit set in the dirty log, e.g. on each used
> > ring update while logging is enabled for live migration.
> > 
> > log_write() always passes a byte address and a bit number in [0, 7], so
> > the update can be done as a byte-sized cmpxchg on the user address. On
> > x86, try that first using unsafe_try_cmpxchg_user() inside a
> > user_access_begin()/user_access_end() section with page faults disabled.
> > If the access faults (page not present, read-only or needing COW), or
> > the cmpxchg loses to concurrent updates of the same byte four times in
> > a row, fall back to the existing pin/kmap/set_bit path, which can fault
> > the page in.
> > 
> > unsafe_try_cmpxchg_user() is only implemented on x86, so other
> > architectures keep using the existing path.
> > 
> > On an x86_64 KVM guest (i7-12800HX host), a synthetic used-ring
> > workload with logging enabled went from 243.60 to 171.11 ns per
> > descriptor, averaged over five alternating runs. This is the
> > end-to-end cost per descriptor, not live migration performance.
> > 
> > Signed-off-by: Khan Zhao <zhaoguohan@kylinos.cn>
> > ---
> >  drivers/vhost/vhost.c | 50 ++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 45 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index e29f154706da..9c3045504709 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2527,11 +2527,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_dev_ioctl);
> >  
> > -/* TODO: This is really inefficient.  We need something like get_user()
> > - * (instruction directly accesses the data, with an exception table entry
> > - * returning -EFAULT). See Documentation/arch/x86/exception-tables.rst.
> > - */
> > -static int set_bit_to_user(int nr, void __user *addr)
> > +static int set_bit_to_user_slow(int nr, void __user *addr)
> >  {
> >  	unsigned long log = (unsigned long)addr;
> >  	struct page *page;
> > @@ -2550,6 +2546,50 @@ static int set_bit_to_user(int nr, void __user *addr)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_X86
> 
> Wait this is x86 specific anyway? So let's just implement it
> properly, why do we need all these hacks?
> 
> I run a quick test on this in a VM, feel free to reuse:
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 

sorry fat fingers. wrong file. this one seems to work.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a0dd3c2b233e..ba1e7c3f83c8e 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -594,6 +594,24 @@ _label:									\
 	__ret;								\
 							})
 
+/* set_bit() on a byte of user memory; returns -EFAULT on fault. */
+#define set_bit_user(nr, addr)					\
+({									\
+	int __err = 0;							\
+	__uaccess_begin();						\
+	asm volatile("\n"						\
+		     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"		\
+		     "2:\n"						\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
+					   %[errout])			\
+		     : [errout] "=r" (__err),				\
+		       [ptr] "+m" (*(u8 __user *)(addr))		\
+		     : [mask] "q" ((unsigned char)BIT(nr))		\
+		     : "memory", "cc");				\
+	__uaccess_end();						\
+	__err ? -EFAULT : 0;						\
+})
+
 /*
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.

