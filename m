Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E681917CD
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338062; cv=none; b=Ji/jLPfW1DxdXPdTepl4T9PmfRvs7QEfiATTq1mGYbeNxa3xgSjOYXhrkQ7vvO6+Hi2Udr4W+FMsA3PW4TBx+t2aL/PK0N052lDK/W4f4COaVgoJKSffu49zXCAVXvKOdNA6CRxWVd3EQV7aa2YDUdj5sGAcd2OJk/hLq0GW9FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338062; c=relaxed/simple;
	bh=YEH0ivn6OIsDyjtX0rImX+2K0Q3ZGkW8hP4mvHsm9Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V31R8VB+1+grOWRHczMKDJwwEX2eehebKzBnYOBbt7g4fv1O1bFZgxucTnYtmizx2W+5wUqOJtQ3Lg6mfjHsDyiMrX4ykKw3WXD4fnbsDvBJ5+KzbjBz/K/Wuu11ZpSSSj4vitUxjBAZ5Ii1HjDMYa6MYkWrJC0DueMQN7AeQ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FRQ6UBDJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l3GdObX1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRQ6UBDJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l3GdObX1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782338059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BDvcN2LNdN+d8LE14HUcEEpxSiVmThGnJVY9yWwMAdc=;
	b=FRQ6UBDJye1UsaXQoZdBBv1Tj3gEI1GXvWtAFjvTq35RjnUCOGyRPmm9LfMYoj3q6LUMDa
	zjHYoCQC8NLcg3gWlaID/jUAyVfwMqRyA602HBhSq7iDmCWHekc1vTktHOMkE+UPxnYbCy
	paDWkf4Nu0fg4Hx1sfwem0ck4QX3iV8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-xNftbdRaPXGq0BAxuWStVw-1; Wed, 24 Jun 2026 17:54:18 -0400
X-MC-Unique: xNftbdRaPXGq0BAxuWStVw-1
X-Mimecast-MFC-AGG-ID: xNftbdRaPXGq0BAxuWStVw_1782338057
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49245e10b73so8706075e9.3
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 14:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782338057; x=1782942857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BDvcN2LNdN+d8LE14HUcEEpxSiVmThGnJVY9yWwMAdc=;
        b=l3GdObX1EoUvKKOs4VWNHMbRfzft0eV/O+13SRmEQ1UA9hWg+G0WUScPOtLbhJczef
         z+kXkHDFROjMZcatGd/skN9y5ztfJ5a3x4OtNoPHnpwr/yc//QUzLQgP/M46hkpYgkN0
         fj1Ui0MaLep3jsDkffnwbfSnOs6Xz/7Bnr4ddT7HZPBYGtF+MIsGUvDY+ZVnN9d7+tSU
         v6Ct6s6MHylyXXzmj5Meg9csElVc34ZIQaZF8GGud1UbLFLq7156s9FsVIQEARv1HFGp
         hwZ6MeBk8ZW62J/kid/KF2+/jNCTvHlU9RjBGn0JIA5shgkIHRFMiGAH7h9B4JWDzmIF
         eYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338057; x=1782942857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDvcN2LNdN+d8LE14HUcEEpxSiVmThGnJVY9yWwMAdc=;
        b=ZyKXykP4KgZczjckH7p0dhxsSpKCwgLNEaRRxSXSYxvTto9G74nsCpXM+J2RTX5PFQ
         r/CS75Zu4e7ZBVYOQgwvL0Z43wctl/H4revk8+jfxRBwE+Y535WTbI/PNlwGIOhyMzmT
         5aJk/RGkndaN+C25gNo1uFGyRx4EMOnTjm4MNJUh6DI8imsj76jEq1XtsYgt2sM4ufub
         4t6fPdnYu5RPBWC+hm3kmAA064aGJoqA+hcS4v77UqwfCu3tXRJwydK7sZ4WQpUl6vQw
         crQQRD6mIECBlzZNd9VkU+qCokPTgYOHY4H+ZfmahQL70l7wsdxMjCjxSdrqFmGUlfDY
         0fuA==
X-Forwarded-Encrypted: i=1; AFNElJ/wwL1sD8KMC7vGl0MYV5GFYxLXVlSrSPTmUugXFSfgUe1NwDxtgmVRTENDvpMgcxv5LC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCLk44pfONdVfQc7kVWR8MEqSE+kdsYgrn3apRaZd+j0y/LMXG
	GhxIjyGzHWsuAdV0Vk5E8TBZg7GN1j/BVP9VBx94F0oI0ZZbdSQTATceBGPNs56DARQA01D29Nf
	JqFmt/y6UHMoU08jtWx1jw6AWprejjSDJFtGmoE4vMpz5B96Mk/G9xg==
X-Gm-Gg: AfdE7cnSQ9VECFJ0zfOjIndOsia406fs2fgEp+jZ4p8JZQWY/2SJ0fJDkg7YtxVzSUf
	QhxWJZr3GHJgmN+SRJE253b3IeqAwx/mpF09kxlErvvoJqvdsRVzXuHI5B+gFIgUdCHvHHByE4y
	ty+AZLL4fOecPh/RyykDfCHhlqyfer6QKBQLJ7+28cAnL2PjQ3v1p9vwdbdjBwvF6M1jyBzKTlS
	ihUupbDYk1wqk6IsCuSuUGJrvyajCIxorNcgvZ7DphCP1Q6zT6jOkDOyszx1EYJj9yIkbdta64O
	P9+saFGKMJeQKXL4n377vfO6C0DH4ChV3/HRfG2o38rZ9HOZorpT8ppZp9ebJRgIMjIBZ+Q0PWj
	qlJvr1qYbOa2e2dSLgVDubPK3ZdRWPAp8
X-Received: by 2002:a05:600c:c118:b0:492:63ff:d577 with SMTP id 5b1f17b1804b1-49263ffd59bmr15123295e9.27.1782338057076;
        Wed, 24 Jun 2026 14:54:17 -0700 (PDT)
X-Received: by 2002:a05:600c:c118:b0:492:63ff:d577 with SMTP id 5b1f17b1804b1-49263ffd59bmr15123165e9.27.1782338056620;
        Wed, 24 Jun 2026 14:54:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d93d8sm17353516f8f.23.2026.06.24.14.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:54:15 -0700 (PDT)
Date: Wed, 24 Jun 2026 17:54:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vhost/vdpa: reject overflowing PA map page counts on
 32-bit
Message-ID: <20260624175356-mutt-send-email-mst@kernel.org>
References: <CAMuQ4bURwyoJtKUskzXpbUtrxXT1vBZZxpKpnnJY6qWsLtTBMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuQ4bURwyoJtKUskzXpbUtrxXT1vBZZxpKpnnJY6qWsLtTBMA@mail.gmail.com>

On Wed, Jun 24, 2026 at 02:51:53PM -0700, Yousef Alhouseen wrote:
> vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
> size before computing the number of pages to pin. On 32-bit systems,
> where unsigned long is narrower than u64, that addition can overflow and
> the code can pin and map fewer pages than the requested IOTLB range.
> 
> Reject sizes that overflow the unsigned long page-count calculation.
> 


And a Fixes: tag, please.

> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
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

