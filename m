Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478215;
	b=GbCPJWL0ZWq3lLWT5YLHA5ZueZx6duPnXqqK50vEq0DatCV9yjWzG+B/1o9Hfsm+efiT
	 u676HKoNKHI9zVCucPDmXi6LE4U51DCo6pGg5UDKtHGErxRSIF8RHPydEvJ5DDZ869LRc
	 MxsIgxe4v8iFyrJ8B/cLKMK8DvcNzeuqG3o0P/bPiTq/lvIzlHf39W7Efa4ByZBoD1d/0
	 3LC+tcZyyTGOtnNcYGTN7xaIdZDInGk917T0L4YjPiA0rd3GPR5N5GaWAGiF5DTNlHwTW
	 qtZkHPmhX6MRki/9eAAA6Y5wrpwkFfqJUXEhz7tK8+A1i6cDymkZU4ordTFalckcO2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478215;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dZQUAiljUbxO/eu4TRCEfrOqVOK81+mbOuXnFblvr+8=;
	b=OxGruEaU7fawluxITkjT480g0eSwXOFqr2ovqY25pDW5X9jz2fKaUzub95vm5WUAaCi7
	 1fZT9+Wzd00Kl0Hp5d/sogPAGZYbmGkvJuyhyjp6bd7VDsoVa0kZMH1rfFHjFPR3QTxjy
	 0fX7mw75AA3VM3zSItOvIVxiYapFzfmHMscRpJ1UR0V1YgL5TauBEV8K0LgJZe2mf+1Lm
	 +SG+FE6PgV+ll04weavKA6SPilK6QwdmjEVVJf3bu01ypjTwGQQj933KFRaK8TzZECBUS
	 TYk04px6eZzg3GyqTh6nenkR1MQtwWRUEYChR4xo90OI/JUFE2XhQJqHqEa50w1QNvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QQrBqtsI;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="ZZS/98e7";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77BD606A321
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 10:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A77BD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QQrBqtsI;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ZZS/98e7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794478213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZQUAiljUbxO/eu4TRCEfrOqVOK81+mbOuXnFblvr+8=;
	b=QQrBqtsIUCFfSxE0LtH6ciVAJuzh0yx3iXtu8OdcCyy1Z4D726B6PeM2lDMXz39IkHIR0q
	eHK/mfbPfh0/rD6JBOoMBU2VVnpk871lVkAUWF8ZSnKASb69cU8eAmdRZhMxXt0yb+24pG
	Ofk5HGFZkwh9G3llc/8kaWQoSmKMYZo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-VGGZlsoNNuqvW_65NUuPhA-1; Thu, 12 Nov 2026 05:10:12 -0500
X-MC-Unique: VGGZlsoNNuqvW_65NUuPhA-1
X-Mimecast-MFC-AGG-ID: VGGZlsoNNuqvW_65NUuPhA_1794478211
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a77c1cbd15so32890395e9.0
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 02:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794478211; x=1795083011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dZQUAiljUbxO/eu4TRCEfrOqVOK81+mbOuXnFblvr+8=;
        b=ZZS/98e7hTzHTSGfkOQMtdtVMwRHf5R7ryuR7PCPA2eB8uSBpyDzPAsYTDUrE8c1s7
         6Bbcw7gA0UnCboWXBGHyBwOAEpWX7QNbRNZKReLPknfCZLjPGuvHRe/GlpozugwnC4r+
         ckxIBN40YsOOfEKk9gs+W21PqXpi5M0XTINP/tW0/SGXqbDKWTDy1Yv2u25fvFiBXzqL
         ZauUIgbHEEHf3ys0/Hr37zfwpFJu4rue8u3BAwHjL+wS6nMjReXaWeWspg7NzFyHeZas
         dKncXM1E+AtVPk9wxpke/tfyEod4k7XIGOfYDxW7wVQ2XtDXCAvM8gSCxGQyHWvT6f5n
         RR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794478211; x=1795083011;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dZQUAiljUbxO/eu4TRCEfrOqVOK81+mbOuXnFblvr+8=;
        b=kWEZv/xVSI80IBRn1kL6hKhPKdgTOsnESptkszSUKgh5vi5il/6Xvq1zxY5++mJY+L
         GZvU+u4tvUicdSwoin/V1yzoHryDmRJLnq7I2s5JDw5Q66BVpdda5JArNSaOvgV0EV4R
         FP3d8XAws56Wv7nfyJZY+0SgUR8WjtAiTk5Nug4sfh0RSiyrH32f7NZZbeHMAFcJluKB
         02iU+dB6El5Ul2RbNP52VHR+dU4+mLrk19ZIFyNT/Qo2cEdWuOTJd/Ga4wwUYrrEpYF5
         njoGOjP4KZuHzYpsvk2W/0yx4CExiktsvgFDAYrxzYseazC/EPpCM6jnP7F7no+axOdu
         AQVA==
X-Forwarded-Encrypted: i=1; AL+hErHorywVYCjdLKDlDavQq5Xghd8zKuUz7yW7epd2OQ84eOh2IFDfMwz55P88tR5qxIU9ZeU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Zd7EQhnXlWIsnMGQyUiTemLttKIGy22ZrO5W56ZoQ17vtAklo
	viXd9RLIwatuzMyrKKaTcbFWgRyIMou8VZumw9KUAnohxfhxwnnyLx9f9FVR/JpeYd3ICSzHN1A
	+e1MFqasxwqPKTdRY38B5g/1Mq1j78NkzO+wonhUBLiI74Od8hOzrNw==
X-Gm-Gg: AYBFou3Lcp2RtApxCy3MqrOzyVMc/fTq92EToOItwb5TjWOvptjEERt5QLrMSJ29Cix
	/iWDPmd0KlQa+8Lj0MVqE/itIvhsYT+vT7AfNGmdfafAPIC+eHGs7EkQn30L12OSjIDOYZCR4BE
	Sww2pMPbQBPOxBnfzHJxaJqZj98q6a+vp1IPiw9sGJJv7a5cyVnYrAi9cLLlTpOxZCETMWkBfLL
	rtVMlgkIo4prkyxYrLNGX95wzHXGs/vuxG58C0OpJW8irFqrOmccedHGJiUzXO8Qv8N95GnGjHY
	DL9JjnxfX+QeHnrV5Rx7QOD4a8pfjb6w+5T0Z8gxvXjzZUFxgXR1WXA3fSEf8Dc2z4rPN6+tveY
	GgytVjwk6eufG5C4+iidd+QJqPgoSKl9uJv7TU/0AJQ==
X-Received: by 2002:a05:600c:6214:b0:4b5:d95c:2378 with SMTP id 5b1f17b1804b1-4ba0939815cmr87754455e9.34.1794478210580;
        Thu, 12 Nov 2026 02:10:10 -0800 (PST)
X-Received: by 2002:a05:600c:6214:b0:4b5:d95c:2378 with SMTP id 5b1f17b1804b1-4ba0939815cmr87753625e9.34.1794478209938;
        Thu, 12 Nov 2026 02:10:09 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365cbfc6sm16943454f8f.41.2026.11.12.02.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:10:08 -0800 (PST)
Date: Thu, 12 Nov 2026 05:10:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhaoguohan@kylinos.cn
Cc: jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vhost: set dirty log bits without pinning pages on
 x86
Message-ID: <20261112045853-mutt-send-email-mst@kernel.org>
References: <20261112085631.128819-1-zhaoguohan@kylinos.cn>
 <20261112085631.128819-2-zhaoguohan@kylinos.cn>
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
In-Reply-To: <20261112085631.128819-2-zhaoguohan@kylinos.cn>

On Thu, Nov 12, 2026 at 04:56:30PM +0800, zhaoguohan@kylinos.cn wrote:
> From: Khan Zhao <zhaoguohan@kylinos.cn>
> 
> set_bit_to_user() pins the log page with pin_user_pages_fast(), maps it
> with kmap_atomic(), sets one bit and then unpins the page and marks it
> dirty. This runs for every bit set in the dirty log, e.g. on each used
> ring update while logging is enabled for live migration.
> 
> log_write() always passes a byte address and a bit number in [0, 7], so
> the update can be done as a byte-sized cmpxchg on the user address. On
> x86, try that first using unsafe_try_cmpxchg_user() inside a
> user_access_begin()/user_access_end() section with page faults disabled.
> If the access faults (page not present, read-only or needing COW), or
> the cmpxchg loses to concurrent updates of the same byte four times in
> a row, fall back to the existing pin/kmap/set_bit path, which can fault
> the page in.
> 
> unsafe_try_cmpxchg_user() is only implemented on x86, so other
> architectures keep using the existing path.
> 
> On an x86_64 KVM guest (i7-12800HX host), a synthetic used-ring
> workload with logging enabled went from 243.60 to 171.11 ns per
> descriptor, averaged over five alternating runs. This is the
> end-to-end cost per descriptor, not live migration performance.
> 
> Signed-off-by: Khan Zhao <zhaoguohan@kylinos.cn>
> ---
>  drivers/vhost/vhost.c | 50 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index e29f154706da..9c3045504709 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2527,11 +2527,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_ioctl);
>  
> -/* TODO: This is really inefficient.  We need something like get_user()
> - * (instruction directly accesses the data, with an exception table entry
> - * returning -EFAULT). See Documentation/arch/x86/exception-tables.rst.
> - */
> -static int set_bit_to_user(int nr, void __user *addr)
> +static int set_bit_to_user_slow(int nr, void __user *addr)
>  {
>  	unsigned long log = (unsigned long)addr;
>  	struct page *page;
> @@ -2550,6 +2546,50 @@ static int set_bit_to_user(int nr, void __user *addr)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_X86

Wait this is x86 specific anyway? So let's just implement it
properly, why do we need all these hacks?

I run a quick test on this in a VM, feel free to reuse:

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>



diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a0dd3c2b233e..3ed49c91a7434 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -594,6 +594,23 @@ _label:									\
 	__ret;								\
 							})
 
+#define set_bit_user(nr, addr)					\
+({									\
+	int __err = 0;							\
+	__uaccess_begin();						\
+	asm volatile("\n"						\
+		     "1: " LOCK_PREFIX "btsb %[bit], %[ptr]\n"		\
+		     "2:\n"						\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
+					   %[errout])			\
+		     : [errout] "=r" (__err),				\
+		       [ptr] "+m" (*(u8 __user *)(addr))		\
+		     : [bit] "r" ((unsigned int)(nr))			\
+		     : "memory", "cc");				\
+	__uaccess_end();						\
+	__err ? -EFAULT : 0;						\
+})
+
 /*
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.

