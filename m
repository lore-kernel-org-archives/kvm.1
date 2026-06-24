Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7DC2AE7A
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782339032; cv=none; b=N2UOQbHefjM17LDUDpmaBI1jhx37Xv9IvNzGlefC4+QKbUK3cq+lgJK6EnQXqg0OuNPzz+UNvKywhd9whrAp9l/MahnMv+cJQdA9DT2JueYjVFva4fa59nFZX2yp5FwaWySYLPAERYApRuOsRKKQ2B7cQdhggw1jsi9op/nlZMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782339032; c=relaxed/simple;
	bh=SctI5nL9w6nD1CkeTPygc0eg5Cq42shMYT/8E3NzTw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8LZ2i64uMpxq6mmIMiIjwJRQcNPMe49Y+54LLJ/Hp5de89+7clYnbdpe+V7sLspP0SUzGKKuSD/L1czaXMeNV/S8h/NhQyJsdcGo0RvEg6VMIP/4l2RQpxRD3RmBNe9pW19Y6XHTJaNH0Zr6OhuQU2NHMUpOLqMNEe8GTBvcCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJj+dsGe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDQYGdeo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJj+dsGe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDQYGdeo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782339030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rLK07udfOGaPeFwrW6OYgWQxt14q957X4zDxurj3Eis=;
	b=eJj+dsGeZ4n/4+C8HMMbzG6z5mqxZbhACGe21nACm3qqMC92BikdcD2zoL6ujoy1h6pfRq
	xGQIrBiMxA1n+CqUEFB5l4y1b9vKCJwPpIpZ0r0hAN5NqCsrFQYC7Oa79TSYnbLIiUrlCi
	8Uz5OIRj6qv4CNuxjgNdMYnvwFwdBVE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-gb498R2mM1Oh3bGXPDUFLg-1; Wed, 24 Jun 2026 18:10:28 -0400
X-MC-Unique: gb498R2mM1Oh3bGXPDUFLg-1
X-Mimecast-MFC-AGG-ID: gb498R2mM1Oh3bGXPDUFLg_1782339027
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-46cffa7200bso306622f8f.1
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 15:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782339027; x=1782943827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rLK07udfOGaPeFwrW6OYgWQxt14q957X4zDxurj3Eis=;
        b=CDQYGdeolXbwC8tN8EF+YbxP5RCPddjmgJFYuMmNthUwOAMGTiXcX55MwPW7IheIcX
         w9MYGRENHhAE3IQUIiBaDKrOTStu1EjhTNxaoiNbmEaH1uzSh/KNXz2n5YKk7UTYfZME
         VbLb0YOXs1w1+Jqt8U4ZCQnClYc9cxyrrAFj4cIN7hu5iHL9Ffytl1R1kshonSGlR0Qb
         C7lKnswrmf/dwcQZz3LCYhJD+bLXTQzGlr1RQ0mOGVn8HUJk4KzRnTE7PaFnZlq0YYSg
         LHS7pCuKmrgUKHcdp7+pvhorMDlxz+e+znSNSI3rT3HsR4UI+Q8m219UnakFnOpnlId2
         prCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782339027; x=1782943827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLK07udfOGaPeFwrW6OYgWQxt14q957X4zDxurj3Eis=;
        b=tSHb1YzlFweI8D5PGCamlbL7AkzGi67Vv94m9mmzRvLjUVYdaVVk41uq34MLeQTiIO
         A8lXy0tcpm2xviYW+lvMwUOVuyfteYQECNTGJ0ivzG6So9qgeqP9aomxQYEQL+aXfRCx
         659+k+zUHbbUsuveTty9o2kKL45NESeHkGuiMUrrh4FSDJx1U/oNMepocagF/E4ZdzvN
         tLM6F9vOID39r9mKblThZ3ojTcS04HEbLSPvK4YbcJMGSXzcBKUF9o2C1n6RYjYFSBam
         fDD+ntKfsuYTZhbsWEjrRqcck0wCzTWmkE1Xrp7emcfcDOAtz4nnl3lalTzRI8GHYGMN
         x9gQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq9liJiW8uWeI4XEWogk3bTpiyCAAMdEo6hyShO2d06XcBVC0h86DSOeL+xTdjGgPbksJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs1JNLoY/Qr+PT/bTkEus5WVXRKW7zDNfMAygLfZn7JxXXVizQ
	mYCE2U1pPFF1SkEXh+BwIIF1tUCcpz7oh0lD5QIaDOYYr4/iJMTLb1lMMZ2rljLzLQckN1r5m7p
	ffIpODHpuUrgwZ+BMVdkwYdfp4WdeF4SV2nxHIIDn0AQ2I7PRNXXXTQ==
X-Gm-Gg: AfdE7ckC2twjtL3dzO4QevaCiPa4QgavHwb5IT+f1ykhltB7z+7d0kjEmM05WzOYJ8a
	19KsYj/dOagFl6rJYsfe4oish6Qj+SuTMwlV6NaCkH0u/gRAlmTZ8pxW5ZmO8z1w1kgQR7k8yH6
	3yOdjsckM2L7SuDta7ivmUmcPhl/4OfEOnCaR1pNptaI+PcQ7l4jOZneYn65QGmKVp7yd6ElkfB
	7SrZekg2JOkUYZNqTxEvV2hUB+05Tlj31q15GNogusyegNJGG9Eqo5EkCYVSQ/1UbAhKkzee5BY
	72fmGUyqSZ5bg8b/tjUekGHJUgDDJ2nYUbnZs8EfPK0Fc9lzIwskMPsKir4bTz6LW/yqEMdfHHU
	xZCVlsetDxPwsVzz/AxhqsS5GxbfE9Wst
X-Received: by 2002:a05:6000:2887:b0:463:1d06:ab33 with SMTP id ffacd0b85a97d-46a80f5c6edmr17065687f8f.27.1782339027402;
        Wed, 24 Jun 2026 15:10:27 -0700 (PDT)
X-Received: by 2002:a05:6000:2887:b0:463:1d06:ab33 with SMTP id ffacd0b85a97d-46a80f5c6edmr17065639f8f.27.1782339026847;
        Wed, 24 Jun 2026 15:10:26 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c22c680fasm10122841f8f.34.2026.06.24.15.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 15:10:26 -0700 (PDT)
Date: Wed, 24 Jun 2026 18:10:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] vhost/vdpa: reject overflowing PA map page counts on
 32-bit
Message-ID: <20260624181012-mutt-send-email-mst@kernel.org>
References: <CAMuQ4bX-iDvcUOPPY+NLz95tkRJYwWqvzAr=U48uNaub_HZLGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuQ4bX-iDvcUOPPY+NLz95tkRJYwWqvzAr=U48uNaub_HZLGw@mail.gmail.com>

On Wed, Jun 24, 2026 at 03:02:02PM -0700, Yousef Alhouseen wrote:
> vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
> size before computing the number of pages to pin. On 32-bit systems,
> where unsigned long is narrower than u64, that addition can overflow and
> the code can pin and map fewer pages than the requested IOTLB range.
> 
> Reject sizes that overflow the unsigned long page-count calculation.
> 
> Fixes: 22af48cf91aa ("vdpa: factor out vhost_vdpa_pa_map() and
> vhost_vdpa_pa_unmap()")

still 2 lines?

> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
> Changes in v4:
> - Keep the Fixes tag on one line.
> - Add Michael's Acked-by tag.
> 
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

