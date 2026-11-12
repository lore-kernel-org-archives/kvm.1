Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794477062;
	b=3Tdt3P09qPikbGRMAWtjaDpknsjrcno2cZupJ4fLI+pUXSDyJIJ5uUKu1d8NV5fWiXNg
	 yI2pEqYjN16Cf6dKHsEiVDX9kFRY9etcqOfd3aCQg93m5SvKiyzE6B9w7gLg8lvWV5lCK
	 7WO7WjK5cFiPcKgo7q/usyHqJrKOmUpuxkLLUVqsSPjkGQSLUy+aqbL8LdXbD+GVKWPfp
	 B6rPCRg2xyzXqo24GXBZY4OXHreRRLKdc+QCEs6PTs7TMLdw5APrCzKsQtFbdyQpOlJjx
	 WwklIqCUkzN7Wb9KJxdV4aVTGOiTFs7YlAr8rRz9M3Cd5jCHo15ApMvbpzIieQCcCYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477062;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PWjpZTISxAW1ioWo7zAlKfMSm3zMo7GsaFnXjvMiMuw=;
	b=II1L6/wy1HUJ4jqNi2vApzKvAZOC/bmGQenPAUTEZv1iIVoCfwlTooXQB6TLZdf4YepU
	 Lve5N7Uub013UZwJ/APjGemz8HOiPCAWMWT/LeOBJpiDIEbwCR75rBkKJpvUqnowK5w+o
	 06VSpm1XsULg+2xLXJ3cj5pGlfKg6rqvfw6Q/r7/tS+d3TTWFt25N2aRfpzj6z7pkP4UM
	 7ycJtBtQ47In7wG3Qdg9TtIZrMjVEX6ziEP/shNOdHkCXe4LtVuUF4n59D8h9a+zy+/3K
	 goQL312AX3MkC1SiCa/i1HwYyF6nwRggsN5Kj17CxCCv1FSip8x+cf17CfiTxtFYS0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RXWiPM9g;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HvSQNiof;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0B6606A32D
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 09:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD0B6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RXWiPM9g;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HvSQNiof
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794477060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PWjpZTISxAW1ioWo7zAlKfMSm3zMo7GsaFnXjvMiMuw=;
	b=RXWiPM9glKt8c84teQV76D3GrDKVCOBLB6mn2I1ijFJCQb4OMmrlLDFWCcFqryVtl+9qRw
	S3cfhJCt406aNjQazTVjoMN1ShBkX16QufH020lkNxDnsh6+qRCYZrayYpANo3TONKVu6z
	RBoTMv3PIYpNxhWQR2LTSjOAj9vwT1o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-ZEVWKeifMHueMiQ1lsCgrw-1; Thu, 12 Nov 2026 04:50:59 -0500
X-MC-Unique: ZEVWKeifMHueMiQ1lsCgrw-1
X-Mimecast-MFC-AGG-ID: ZEVWKeifMHueMiQ1lsCgrw_1794477058
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e0389d6f9so3028030f8f.1
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 01:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794477058; x=1795081858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PWjpZTISxAW1ioWo7zAlKfMSm3zMo7GsaFnXjvMiMuw=;
        b=HvSQNiofO5MTaoGZNkYzRuRHopzkuvp3+GS2bTyrBYNyU2XApZTbnO9dVYsmw9pQEO
         u7wzQ2aWtdtRFTIztMJJsgTx39/POVQP9dyZ5IM6G/ETYMaKmspp9H3yuTMRgKIHrJGO
         96KMkkavkEelnK6PmoP9pWug6pG/eKsHqujIiZkGdhHQA4Jb4gEwhkXw1JRSEJXl6REc
         n/2kpSwt25FOrDU9jmi5GCBG/u8KUGhCJMUWQbmdcmqnQsWmAkQORYz7MmKxBe+tfhmC
         OsFsYaRyx66zHQXoGMycSYhZA/ZA/dKS9NrqTLOyqAXu5vUG8wRd5Y/IX+9s4sXfbUEw
         VNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794477058; x=1795081858;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PWjpZTISxAW1ioWo7zAlKfMSm3zMo7GsaFnXjvMiMuw=;
        b=K/eV+UErvfiKFEFFl4Q2TwRvjsC/bSUyh27hDoM3wO4/cjDK9x43UFKmDiWCQCSuqa
         EsBW0XwOWWnoKtRARHsjhR5wmqMhYud4FvOU5cL24tBiS7og+OKWsZtmq4OQ5AjeIAl/
         x3nzXz99fPC8regI12QXxDhaRcfXP6pEATzB52xqHGK1flGUqGvjdf9OJvYFuNqP2Ri1
         AKCSkWV0GN/M3eA/YLxxhgftwSe0JeSxeQu0+mYpSMuwathBiqKGo6cNr0J4AIJC/Y/k
         VUcSoVOWuCrD4qtIC8qknYSp2adPyl5h+hc5I+SiOgNTk6uwClWHHq+EncSdh29v9v4l
         h7mg==
X-Forwarded-Encrypted: i=1; AL+hErE/4GzlGz9BYmDrYmKw1bPhWdW60YwhDkiFi8IX7qwU50SSHk7P4Erv9i+vd2IwJ9oVun4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8flPGMENBU86lxXqhmxE58mlrIoQGA0jfQXe28LVS6Hn6FfDNQ
	Qtf06I4QYI9AZy4BrUBt5ox35wjnd+xW792c4DQZWnztI8Zd2GAfnjKck0/j4UyrSuFDJWmtamd
	MJKUmo1tKmAbpjQT3WBTJLs4LhFXpmBzDuHtVpxmqluSBQ4VHcZF/Mw==
X-Gm-Gg: AYBFou0fYefsN/gi42smMwbpsauNuSdTKtgJK9IYbp+FcvdTa+FRLXoVCaeMhUHYemr
	7oOk7xCDBcmRPhymC39HRA35RLSBvxqc3NJ+MKztwD82PsUSzRIQDVX7F0t4uAL6KbY6CYvSghj
	EO5Ebk6QYpOiOdCWjcMncYZ4hCj/iXtcv9XN/b+o0KVALwCuOHDbiDkT6cx9ZQI+F/3KT3XEF6I
	rRA9hyGH8vI6P4XCUErrca5uyo4XyuDfOKFcesgyrYQO4qfvAM7jlkI/sk7cNLQm8wZIeFxW1r6
	NXka0rbJSAxxOzEitfhR4uwnpWAA2hcmqj5HvS8czsPLMFJFwqLrYVQ3kiYQqN4YF2c++Nmzrcb
	6mI2pnDLoDc+m5G+tqp52tDkgbVSY1OHq2f2b0LKOCg==
X-Received: by 2002:a5d:5f91:0:b0:48d:f9a4:bd68 with SMTP id ffacd0b85a97d-499c7dfe760mr9013244f8f.27.1794477057314;
        Thu, 12 Nov 2026 01:50:57 -0800 (PST)
X-Received: by 2002:a5d:5f91:0:b0:48d:f9a4:bd68 with SMTP id ffacd0b85a97d-499c7dfe760mr9013178f8f.27.1794477056650;
        Thu, 12 Nov 2026 01:50:56 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-499823761f5sm10614988f8f.2.2026.11.12.01.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 01:50:55 -0800 (PST)
Date: Thu, 12 Nov 2026 04:50:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhaoguohan@kylinos.cn
Cc: jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vhost: set dirty log bits without pinning pages on
 x86
Message-ID: <20261112044557-mutt-send-email-mst@kernel.org>
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
> +static bool set_bit_to_user_fast(int nr, void __user *addr)
> +{
> +	u8 __user *p = addr;
> +	u8 old;
> +	int retries = 4;
> +	bool success = false;
> +
> +	/*
> +	 * log_write() passes a byte address and a bit number in [0, 7].
> +	 * On x86, update just that byte to avoid crossing a page boundary.
> +	 * Bound retries so a contended byte cannot hold up the worker.
> +	 */
> +	pagefault_disable();
> +	if (!user_access_begin(p, sizeof(*p)))
> +		goto out;
> +	unsafe_get_user(old, p, fault);
> +	do {
> +		if (unsafe_try_cmpxchg_user(p, &old, old | BIT(nr), fault)) {
> +			success = true;
> +			break;
> +		}
> +	} while (--retries);
> +fault:
> +	user_access_end();
> +out:
> +	pagefault_enable();
> +	return success;
> +}
> +#else
> +static bool set_bit_to_user_fast(int nr, void __user *addr)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_X86 */
> +
> +static int set_bit_to_user(int nr, void __user *addr)
> +{
> +	if (set_bit_to_user_fast(nr, addr))
> +		return 0;
> +	/* Resolve faults, or use the native bit layout on other architectures. */
> +	return set_bit_to_user_slow(nr, addr);
> +}
> +
>  static int log_write(void __user *log_base,
>  		     u64 write_address, u64 write_length)
>  {


Actually why do we need all the unsafe trickery, is there
a reason? below seems way simpler?

+static int set_bit_to_user(int nr, void __user *addr)
+{
+       u8 __user *p = addr;
+       u8 old;
+       int i, ret;
+
+       if (get_user(old, p))
+               return set_bit_to_user_slow(nr, addr);
+       for (i = 0; i < 4; i++) {
+               ret = __try_cmpxchg_user(p, &old, old | BIT(nr), fault);
+               if (!ret)
+                       return 0;
+       }
+       return set_bit_to_user_slow(nr, addr);
+}








> -- 
> 2.43.0

