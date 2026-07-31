Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A422BEFF5
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490694; cv=none; b=bgHcciMP1n7HJM7cqHLmpQe+CJDx8Evdi2TG8dLs7g78/2/txVEQzosXAl35HIX4MngOYD0gbpVktJrC+UVgHvcUQu9verV13Imk2NKZplgEXBEJuD4k6wVo1WD7MTor/dPuC+LuUi/Lfp6VZQwjBK2TDplj6VlU8ielwJenMKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490694; c=relaxed/simple;
	bh=2JVB5NHlGcJkRbxyYTYM1W0SpjpRQTNPaqgefsqMK44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5pTrof+issGIsB1wkNyvRwUZ0unXR9rYbJpicLRuKBNAJfh1/95TxZpd/swtjIWTWdsNB8Qbv17aCw34RoO+YBnOYc9bd9OfkubVbIsMHvaYExECFQe7Syzs3S+15eKjuhmpFWf1x99MdgihuEDF2dpG8dmL5/dKjxUGUxu4cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LoOKlSMf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tvw5rzR3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoOKlSMf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tvw5rzR3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785490691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XynOkVOU0Sg6QSEg62BZ8juSeRUPNKjmdjv0kL5gaaM=;
	b=LoOKlSMfxhVPbdfhN0l2DOnpFF7eolzpR1/XfJmqOrcmmPpaZIUTRTUKj2Ck4RS9q2+xLs
	c0PClRvMujK0Wp2s7OLNRm74ak/LomLtWLrMmOEG0i7lQx4tL66EPsGnruKJYnI8F6P44T
	D27lwPmRjJny8fEFaxxD95KHcvEg4sQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-iyiCSDRvMu28TjWVV0sC5w-1; Fri, 31 Jul 2026 05:38:10 -0400
X-MC-Unique: iyiCSDRvMu28TjWVV0sC5w-1
X-Mimecast-MFC-AGG-ID: iyiCSDRvMu28TjWVV0sC5w_1785490689
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6984787eeddso722733a12.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 02:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785490689; x=1786095489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XynOkVOU0Sg6QSEg62BZ8juSeRUPNKjmdjv0kL5gaaM=;
        b=Tvw5rzR3YqVSd23egUPUIU/s1JCuFitZbI7iV9s+euhiKc/0fhvVs8yB0brHvU315I
         b7cMRFCOaHJ7g2z+JjxgF8isZxYk8VXT4Fed8sqztuX9CHq7R0defCkoaq9n2MBBiI3x
         TLXoJYSu7Em7A7W06uS5ThO73d4hTLuneV/hTqh6YwSTJdyeYlS4xyC1zPLkWWxVSJKx
         8Om7IMjxhPFVAX6ETV1VhdD2p+9MUKThZoAnmPUMTwE/siOGvFGmvNyn84clYVdILcfT
         Bg7dGkFb4YlMs1mbHfO0sbENNLXYl3T2aNWr+U3xRzKFbY+PCkWHT4CXWOjNxRz5nN3n
         7nNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785490689; x=1786095489;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XynOkVOU0Sg6QSEg62BZ8juSeRUPNKjmdjv0kL5gaaM=;
        b=bnjHbDeV4d2jkT4JBMDpGELMmvKXU1iQ4Fz1uT69sRkk0au/KgbEkJG0mWPKeUuCqw
         x7oWlRCyazP84YKlq4zI3U1QdK9KB4sOctwcCZl2wR4xycdlOy7MenwIMZUQzu7Rf6+d
         CKZa0h7Pp24V7LF9jzuNw56+Why4RqU2cgT/WghCo38o60bo3qvOjvaAs290piNvSHSN
         JASZ0zaY9S69UaZaBfXHW3OmEz62cGGqa0JNbYj7Ff9vFEwD3AdEmANdHz61goVh6r8E
         xcm5gQC9nL0NdORmKKzKcjkwDjoM1p4o4ZdDqIzie5aBizqC8bZOUSC4B1qzb584BUkp
         oP9A==
X-Forwarded-Encrypted: i=1; AHgh+RoE1s7YLBfKeyn+9fM/fy5MNkomCAfne4Raf/G8qAztIyj8BKO0RapeFVs3M3TlEdpmQ18=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoHKCpIF6MIt0keo8F6oM0heYuPkQgSNJzLTK/nDOPgv+4Qj/5
	pBj/LNWM+ys7BsoPDwzYYnrhOZwSVemsi4c8xup0XyC4Hmlk6HdOaRGrJQWQedXl+uYUu0wdMOX
	wlkS4yP9BnCRTcskNWWIyEhAISW4eZ80FrizKCsacSnOqSbzkc70fAA==
X-Gm-Gg: AR+sD13MV+YBCt5unk4/xk1x1UJfiaWH1BMFuEzMPquhWS2QWiVkgzg4+KZwGAjZYLc
	zVzntuJFnZ4zMr5kPNp+btmOco4thPHLy49/xnVxjS0M5cd+WdW6n+VvH+gho+RTEBsKhK5ilkB
	gSfWpGxsDRV4KyvpTeSznzq/BDcWhevwdp+IdqgQ/KQGUpfyMHk6CqQkwuhv0D3GYmn4SQklnQx
	8kauwjaKYWMkkTvdfueJIHOudvNqbVOnqMUehsk+BQESRKKqNEms8OKrG5Scd7hIjjdTUU4+aLm
	/hdmhqNlhsrWRM8lrY8eUKY2aKlSKNiLXQcXQsB+U5CXtOdkk9aHgatWwd/ceD3co/z2/Op5if2
	m/IEalJO2emejKV2t20/zM8U=
X-Received: by 2002:a17:907:b046:20b0:c16:16b9:9907 with SMTP id a640c23a62f3a-c1fd1e9acdfmr50313266b.15.1785490688994;
        Fri, 31 Jul 2026 02:38:08 -0700 (PDT)
X-Received: by 2002:a17:907:b046:20b0:c16:16b9:9907 with SMTP id a640c23a62f3a-c1fd1e9acdfmr50311166b.15.1785490688444;
        Fri, 31 Jul 2026 02:38:08 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c5b8c7sm92699366b.9.2026.07.31.02.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 02:38:07 -0700 (PDT)
Date: Fri, 31 Jul 2026 05:38:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: prevent stale IOTLB after ACCESS_PLATFORM
 changes
Message-ID: <20260731053736-mutt-send-email-mst@kernel.org>
References: <20260730104857-mutt-send-email-mst@kernel.org>
 <20260731044145.1734317-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731044145.1734317-1-physicalmtea@gmail.com>

On Fri, Jul 31, 2026 at 12:41:45PM +0800, Jia Jia wrote:
> On Thu, Jul 30, 2026 at 10:51:15AM -0400, Michael S. Tsirkin wrote:
> > I don't know if this will break anything. Why not just blow
> > out the iotlb? kernel will rebuild it if it needs it afterwards
> > for some reason.
> >
> > This part you are fixing is harmless. Let's make it a separate patch
> > and document the motivation.
> 
> Thanks.
> 
> Yes, I considered discarding the IOTLB before choosing -EBUSY. My
> hesitation was not about whether it could eventually be rebuilt, but
> that doing so would no longer be only a control-plane validation
> change. It would modify translation state directly used by running
> virtqueues.
> 
> The minimum synchronization I had in mind was roughly:
> 
>   vhost_vsock_set_features(features):
>       mutex_lock(dev.mutex)
> 
>       if (!(features & ACCESS_PLATFORM) && dev.iotlb):
>           lock all vq.mutex in index order
> 
>           old = dev.iotlb
>           dev.iotlb = NULL
> 
>           for each vq:
>               vq.iotlb = NULL
>               reset vq.meta_iotlb
>               vq.acked_features = features
> 
>           unlock all vq.mutex
>           vhost_iotlb_free(old)
> 
>       ...
> 
>       mutex_unlock(dev.mutex)
> 
> The switch has to be serialized against all active VQs. My hesitation
> was that this turns VHOST_SET_FEATURES into a datapath synchronization
> point: the ioctl may wait for in-flight kick handlers, and rebuilding
> an empty IOTLB may stall queues on misses until the translations are
> restored. If stopping or flushing the device is also required, the
> disruption is larger than a normal feature update.
> 
> I was not sure whether VHOST_SET_FEATURES is expected to impose that
> cost on a running device, or whether userspace should quiesce it first.
> That is why I chose -EBUSY for v1. If synchronization with active VQs is
> the intended behavior here, I can rework the patch accordingly.
> 
> I will also split the existing-IOTLB preservation change into a
> separate patch and document its motivation.

thanks

