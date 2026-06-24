Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420663CB2F8
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782330827; cv=none; b=qeB2W2J95Ujzj2nPM8ulTnSJz9WqVthC6hUK19EoDvO0i15NhviHrpy74ld+BHwoFJhkVxlrUA6dy6RaJp+/OsUOCq53EMIBCvuNh0aMT5u0rUsB1SToHmOU8JC5sUCu0iq58q8He2C22R6p1PAxDFaNugspZOQDjQ9HwCL8V3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782330827; c=relaxed/simple;
	bh=0sw9vdmmHIrg289S7LBhBP3TAeh5HlhPIfC0XvwKSeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1Pr/MmvwyD1vzLRaV6k1yIlTykrcLmP+sy47LwIgGBJ64GCPIcfHTBfI7TMnu3pFLuP2ZyKyegJAbwTNW0ynC3B1Rg7I0zmwFSRrJNMOVAjg81eUqfxnlmnoRfkzny+skLC6XMQiXsuPLbxhbNTDqZCUFvf7HBIiS/O7f9MJWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V8WVZRMs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=swPeArCF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8WVZRMs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="swPeArCF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782330825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQwXPDQFNRwXTCwtbeb7bS0lb7BdO0SS5von3s4mxo4=;
	b=V8WVZRMspSKhnefhPoUpqtBnZ3POvCSRgOVMjFHCc1k+uHuVZUoq7o7XA2GYAXFBYQdiCr
	FK8g+Z0W79mHAZwVIeAnGQhJ6HUhmSQNbut6jwjgZmKiebSZin9qYP9t4jyw1+XVi7oBk7
	Ma0PbMf65Ip4vuVTxboxQfSkT91yM6k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-SG89pnrOPPOAyxwJXRVXqQ-1; Wed, 24 Jun 2026 15:53:43 -0400
X-MC-Unique: SG89pnrOPPOAyxwJXRVXqQ-1
X-Mimecast-MFC-AGG-ID: SG89pnrOPPOAyxwJXRVXqQ_1782330823
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49244130073so9229845e9.1
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 12:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782330823; x=1782935623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQwXPDQFNRwXTCwtbeb7bS0lb7BdO0SS5von3s4mxo4=;
        b=swPeArCF1ipP67Vhjm78dHJ970rMBZ00ss9gJc1WKGlq5puf4NXjOqoPkHLB83YXLK
         vRtIHq0X3w1xngyrq6fRW78+AG1y+V7X2m7s4Jw0e8PMnYwA5ccU66wzziJVV4KyLCYT
         iZYxwZpUkVrvd/koVWHs7CAaZBFsPNRXAafDiF/tcEZF24zSV+eGADhi8eGm8fjgXW9L
         OHfa2E/rbmcUu0EySMu6AOdWwV1DQI8+Sl+XFpBXi6gSlnK4pd2Vhf6EsRbDdMXFoIwR
         oHQVdeHLHTxeX49D6ZvXIwl6W8bJ2JCX3Jg/LxtraEO386fWmKRWLPyWDYBNWsc3mKdU
         K8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782330823; x=1782935623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQwXPDQFNRwXTCwtbeb7bS0lb7BdO0SS5von3s4mxo4=;
        b=On8bKJXHMzuRGb92lQsEb62OJmjGmYA+g9URZyi4/Kfp9SJrXvQIzTBjuIT7rlzRHB
         XpxYX67JQ7ZTZOWBQUpI8RAmTvOFzTOnrAr9A7PL5WHHbsLZZeE8a/2NUXqBilo7oxfq
         xD7+kY6wmuU9y3+eaLVw5FsmUXJx/cPOBVzxUVcL7Z5OhuoBKsFFScQhinKRWnvTnVoe
         Rh2O+9zqqxT6vjTSHOyKVSdqWhbJof519ZwaGvnBSxAgka3vvxtpeMjhJq0tXpDKOH2P
         mXt1+7/7YzMMjodCCBaLe5jLxgWF7toRw1LTwCk0KEt/3KUx5bkjYJFbSpiEGG7REYv0
         7Atw==
X-Forwarded-Encrypted: i=1; AFNElJ8nZ8ifjgEqDvGXAEdC5SO/c+oFFqDbr+0sDsjhNSxgQplb0vuwa+hm+HvivEIaVdUDfjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPdS9W2R9HlXV+lDDXxPoimnEqqxxcgq5wMF7sFjUmyQIHYN92
	5hUpu6KVnVYMa5pKQbfpWMhmrPQMqe9MShRsbXKNTUFFutqRikpaHo9QL8hqliDzE51xmdBo3rv
	xL6T/PjkaXJpS34z5Re3EiAPRCmexuodmIu32vdyTIUhAW8aNJIJWeg==
X-Gm-Gg: AfdE7cm2PrhJjftBYrRA4PBjLkc8cw2AH6ZeWYCif+gitphlk4Om2SZ8zk+plCs/O9j
	oaPWj92KYxPUdEXM1DKDd/CKRn8Wuw8kWXjjR7tBYAyFQSsRWjKd43dSsZV3yjvQRZg1NH+5MgF
	fBYsXv136T0/wmheY4BmgLj/HwCTh6Mem0tJHxKjvdkPVEAhS0zSZIKNP/ptnqNu/2ZEO1Pio0d
	cSw6ZDp5P1kplcZ/qWEqLnNtpGmuYQCDVB7vCxw7E/P5a4FXVvgGFu1f/bNT9ET/mCx3Govvrpu
	lyD+OsVv3TthdXPntG1R/vJAmc+4XaFJDuejmOsSoYIySiE1R/juCOIzmtu4fsRra5C+WAkfecF
	Aqpmi2w8iRS6wZZ33eg16dsdtmAwEhYCN
X-Received: by 2002:a05:600c:8716:b0:490:e196:eaee with SMTP id 5b1f17b1804b1-4925b359af6mr134950035e9.10.1782330822582;
        Wed, 24 Jun 2026 12:53:42 -0700 (PDT)
X-Received: by 2002:a05:600c:8716:b0:490:e196:eaee with SMTP id 5b1f17b1804b1-4925b359af6mr134949745e9.10.1782330822030;
        Wed, 24 Jun 2026 12:53:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49264011d5fsm16636315e9.1.2026.06.24.12.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 12:53:41 -0700 (PDT)
Date: Wed, 24 Jun 2026 15:53:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/vdpa: reject overflowing PA map page counts
Message-ID: <20260624153850-mutt-send-email-mst@kernel.org>
References: <20260624190653.2893-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624190653.2893-1-alhouseenyousef@gmail.com>

On Wed, Jun 24, 2026 at 09:06:53PM +0200, Yousef Alhouseen wrote:
> vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
> size before computing the number of pages to pin. If that addition wraps,
> the code can pin and map fewer pages than the requested IOTLB range.
> 
> Reject sizes that overflow the page-count calculation.

You should add "on 32 bit systems" - I do not see how it can
overflow on 64 bit.

> Also make the
> memlock check subtraction-based so a large page count cannot wrap the
> pinned page total.

I don't see how this can happen at all - pinned_vm is in units of pages.

> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  drivers/vhost/vdpa.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ac55275fa..090cb8693 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1102,6 +1102,8 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	unsigned int gup_flags = FOLL_LONGTERM;
>  	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
>  	unsigned long lock_limit, sz2pin, nchunks, i;
> +	unsigned long page_offset;
> +	u64 pinned_vm;
>  	u64 start = iova;
>  	long pinned;
>  	int ret = 0;
> @@ -1114,7 +1116,12 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	if (perm & VHOST_ACCESS_WO)
>  		gup_flags |= FOLL_WRITE;
>  
> -	npages = PFN_UP(size + (iova & ~PAGE_MASK));
> +	page_offset = iova & ~PAGE_MASK;
> +	if (size > ULONG_MAX - page_offset) {
> +		ret = -EINVAL;
> +		goto free;
> +	}
> +	npages = PFN_UP(size + page_offset);
>  	if (!npages) {
>  		ret = -EINVAL;
>  		goto free;
> @@ -1123,7 +1130,8 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	mmap_read_lock(dev->mm);
>  
>  	lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> -	if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
> +	pinned_vm = atomic64_read(&dev->mm->pinned_vm);
> +	if (npages > lock_limit || pinned_vm > lock_limit - npages) {
>  		ret = -ENOMEM;
>  		goto unlock;
>  	}
> -- 
> 2.54.0

