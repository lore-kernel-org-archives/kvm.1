Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A742BE035
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338385; cv=none; b=jQ7JeSEuuPKgtFl3cmfaz78w0mb0YKrTvJcy19yH0lI/zFBWb9eZWJxokeTPLgf4ZMUXS6e/QZRToLBL8jut/POqMZpU/x/EWGj/JhM0u7ttF5gnRFAXLrreLcmJjYNi+dtiAEywwKn6GNNSS6/ULIknXVf242oRylNdqJyiOl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338385; c=relaxed/simple;
	bh=1XTIFRs028W9ICgbgP9xwvBCqmmM/TabDzaJ5qzi1VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V92Difru7H0XQq8alLBp10igsiHdPs8YJtJephrMfgiop7THHf1UeMP6uz2ny3I8ZzGAG6+RKd/HRoPfbuClUzOjYhQA32O5FNx3PUWJ4MIIeePmZcKWl9aybkpHvjbgVHAZLlu8sjV5bfS6HiftPdI99GqGhSYeNXB2CKYMOcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JFh2/LLl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGFDqDwr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFh2/LLl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGFDqDwr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782338383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6VcXuaFqUMqouxDur1YGdBLHaZZe+1Bi3XCCiBAengQ=;
	b=JFh2/LLlgFoOA3YaRds0/vXw44PzwwgF5i6ykQfJFX8c0bW8+yaC4hA/Q5u1RYV38S+M2x
	nDz+twHX3q/5D8tA77HFT8FYixSrSBCT4fEdC219FtX5ZIhbWX6w82Wv8W193B5GWI/3Kl
	C2isOo+5tuo5is6Tjre5qDKbM7Xm7Aw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-I4r9xt8zNs-GvsYIpbj38w-1; Wed, 24 Jun 2026 17:59:42 -0400
X-MC-Unique: I4r9xt8zNs-GvsYIpbj38w-1
X-Mimecast-MFC-AGG-ID: I4r9xt8zNs-GvsYIpbj38w_1782338381
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490ace40f13so5660505e9.3
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 14:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782338381; x=1782943181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6VcXuaFqUMqouxDur1YGdBLHaZZe+1Bi3XCCiBAengQ=;
        b=FGFDqDwr8km9wVYze3EShtzYHiLy62CuxxdmKXO4KSIJsPjw7PrCEEaFlg7VL4mG9z
         ogSuPNuYIdNKiK7IEq692zTZ+5rHx07V65cDO2JbXVdQRjKUoRRSyXwrEIt6Zr0MJPGi
         maSRifXJpJC8AqyPOF2FQ9pLTKxI4GOD74DzX5k3Y4TdE+5DHj/2Q55xJ4+YVyowHKp2
         JIF8HB3DCgVgc3NJyOynm1e01KrqfeVdpev6L3Su/PF0u1mXp6xJbiul6nH3s1Ri8BoS
         4yH/3sIWBWH3egtrq0hG3cpU66+6m9MSs9uPIkqSz8SxVftqzFXUgkr9Zc9Zfpf2km6C
         4aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338381; x=1782943181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VcXuaFqUMqouxDur1YGdBLHaZZe+1Bi3XCCiBAengQ=;
        b=bNw56te6qWgYoW8PLFBD+iHwxw/IYMRXKd4tuZ0qm9pAyB2SLCelGXZIisNrDNpN75
         XeaVYsq8yhl9rG6fYAXRO+L9s1OnTlH101/8I3azvmqTnWnmnaNyEGs+RXDWbwiseSJ8
         PX4U+VtMyzxyygk6z4sCGQoOESqaMUnNU/YAapOplUU97Gm6VlnxhL73g82lbbndMkWe
         yXnCp/EK6yZEVeHrhkwGj1bFXzUlaoI2RoD6wT2aZ28/2g+s3QNuKGHFbfixWIoSanqM
         pqk/QkoZtjWQbBP2pLNPUo8Ljx62y53Tty1qG3VlVZMAMbTFAUDPu390q/5qfuPekqM4
         Kacw==
X-Forwarded-Encrypted: i=1; AFNElJ/zGF6yL/NEvq3o93ylBw4WrC3q3FobrmQ/UZCH53eqCBnK1delOgCElOrB25allrUUdmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwI28+SYgwRZR2LGOeLDpMYM1Rvt6qzI4J4Y7m82zm/vz34IOD
	XDwYjdQRi2Rem11a5N12xKN0oOamkbNkoE1Og65TwSR24I2g4qbxWgcduNqeBKk3pkyymr2z9Uk
	XCvbe+NMts4Zr6wq9IJTc7L9qWDHmY566o2moGMjFBqjzULXmHSZDTA==
X-Gm-Gg: AfdE7cl2E6zvoowaUI+dWSzJwStoek/h2RRsteLp6JMAPfNeHDpEMZYxTpvktrVhqgT
	m30+ONyoc+2RYlxGciuUXlodlh7P3kKoMd90+uHPZjRXYHJ/L/cYxWGtQ3Osbr6h9vaJQLwaSHO
	0um5fcxJKXZeX1gk8889Lxx1EkU7L42evcX1qMxASKzYD04sZvP+ZqtS4kf4Fsj7OkXq47yF+lU
	jYyTIAdScEoA2fQQeMgTz7WsYnfz/sbVV+/WgWgmkTjTFqU/CCH9Xzn3blKcYzAosOad+T1XbXC
	SNp9ViDddHF2PvFvnzEvkLIGlMH2qH8kXmmMG0pcj4gFKCvCjtnomZagRG3eYmB0KK5Djl8VSuY
	ZT2em7Ra2wcJpVKCfxCv+Yd6lzRojNyqf
X-Received: by 2002:a7b:c8d1:0:b0:492:48dc:3d0d with SMTP id 5b1f17b1804b1-492608480aamr49420635e9.12.1782338381032;
        Wed, 24 Jun 2026 14:59:41 -0700 (PDT)
X-Received: by 2002:a7b:c8d1:0:b0:492:48dc:3d0d with SMTP id 5b1f17b1804b1-492608480aamr49420405e9.12.1782338380511;
        Wed, 24 Jun 2026 14:59:40 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926543be74sm5120715e9.1.2026.06.24.14.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:59:40 -0700 (PDT)
Date: Wed, 24 Jun 2026 17:59:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vhost/vdpa: reject overflowing PA map page counts on
 32-bit
Message-ID: <20260624175855-mutt-send-email-mst@kernel.org>
References: <CAMuQ4bV8OeSTOVnAPRh6ygKdogFjqEiDNj1Vbh623KBBkZgxiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuQ4bV8OeSTOVnAPRh6ygKdogFjqEiDNj1Vbh623KBBkZgxiw@mail.gmail.com>

On Wed, Jun 24, 2026 at 02:56:20PM -0700, Yousef Alhouseen wrote:
> vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
> size before computing the number of pages to pin. On 32-bit systems,
> where unsigned long is narrower than u64, that addition can overflow and
> the code can pin and map fewer pages than the requested IOTLB range.
> 
> Reject sizes that overflow the unsigned long page-count calculation.
> 
> Fixes: 22af48cf91aa ("vdpa: factor out vhost_vdpa_pa_map() and
> vhost_vdpa_pa_unmap()")

weirdly wrapped. will likely break some tools.

> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Changes in v3:
> - Add the Fixes tag.
> 
> Changes in v2:
> - Clarify that the overflow is on 32-bit systems.
> - Drop the unrelated memlock check change.
> 
>  drivers/vhost/vdpa.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ac55275fa..38b28ed3d 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1102,6 +1102,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	unsigned int gup_flags = FOLL_LONGTERM;
>  	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
>  	unsigned long lock_limit, sz2pin, nchunks, i;
> +	unsigned long page_offset;
>  	u64 start = iova;
>  	long pinned;
>  	int ret = 0;
> @@ -1114,7 +1115,13 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	if (perm & VHOST_ACCESS_WO)
>  		gup_flags |= FOLL_WRITE;
> 
> -	npages = PFN_UP(size + (iova & ~PAGE_MASK));
> +	page_offset = iova & ~PAGE_MASK;
> +	if (size > ULONG_MAX - page_offset) {
> +		ret = -EINVAL;
> +		goto free;
> +	}
> +
> +	npages = PFN_UP(size + page_offset);
>  	if (!npages) {
>  		ret = -EINVAL;
>  		goto free;
> -- 
> 2.54.0

