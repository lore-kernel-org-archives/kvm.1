Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B1D1A23B1
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082574; cv=none; b=RaqSqcAxStA2hWk9pX23/cSpUjh75tQJoRkAc2dtXJ4DLzoA515qWBv3v69otFPq6yH6imZ4I+DKzmiMok+R/0w2+3++Y3dO9EziSm7hYE6RSv8pbA0NNfg/NCn5TVGwbBEbMf5Lf3wJ1LP6I4KzhkvTdHl+DZ2g42XQevbRjvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082574; c=relaxed/simple;
	bh=OFk6u9sPQNb/lVBSlnQi4dTa2C8rYPWBoQllv2zqLfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGrHXTsjDsLbydfHXN6UWmg1p7wdAvIw1TD6gwf7BqvhrLtsq3RACWvJPeBbOP7oWrOrj7jMpbXepOTyIeSsx4S6LnwxLCTJUH7r8bvUQXEXNvNiAOeWFOz+pcmp6nlyqfltiBYbz5XY5bczak8ULLM6nL3GP/cFdlSBmer7fXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=huiQQK4E; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NubWE80K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="huiQQK4E";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NubWE80K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778082570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQK7jK9fWfmI6EGpDkjX16iWpfsGamzwE3Vp7aLO0Yw=;
	b=huiQQK4EJwrzv/BR1ywxW9aTG9xQ4XjBwNGUI1qcsC602mAkc86Hd4sgolcnccWXu8B3XL
	3PwqRFnXQlyLtn395qUagSEtv4ayaptVNy3GsV4t4Rzv0kXQkKtLu6dvtX35gyJJSuCQrC
	E8VIpYbB7p3uRjO0zArcn4Kc2JujIQE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-Lu-mURqDOqO2f20u84cc-w-1; Wed, 06 May 2026 11:49:29 -0400
X-MC-Unique: Lu-mURqDOqO2f20u84cc-w-1
X-Mimecast-MFC-AGG-ID: Lu-mURqDOqO2f20u84cc-w_1778082563
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48d046fac74so22819735e9.3
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 08:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778082563; x=1778687363; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AQK7jK9fWfmI6EGpDkjX16iWpfsGamzwE3Vp7aLO0Yw=;
        b=NubWE80KJ0iw2U4LMjZ+DGnRx7jzzADXYmR8af6aeWZJwyWH3tVs98ZSENOG+QLN2X
         spM1cw1o9xS7QqbhuMKsiW54txf0WT+J2gNd5JIE19aRGZY0ZIN+1TMS9Xxi2JzuD4TI
         8X9msN+J1boiYHWBYag4XilkPX6KRt4Cp9K96TiEBcjjkfnHoY0do19FiwdjgZCcJJBA
         fU2PFcLMo4K0hEpVEXeVRoANNfNlGpv/MwJ58iMr0JeYDsjSGEIDnP07VpJ4OfFeJKeG
         vvDSWZ9Wcrb/GqIGRV6ykHcTuJojzd+lporm4rFhO1IWDhJS6QPn4vuDmfz9IZYxiS14
         z72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778082563; x=1778687363;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQK7jK9fWfmI6EGpDkjX16iWpfsGamzwE3Vp7aLO0Yw=;
        b=b9lTu5ahCk2mJwL7nr8lRzQwQ1Lo976uns4BtvNo+um8xvtBxX84GzRGAC4UeXbtHA
         isgR3oInNary9V0K2ky+LNJ64qCFvCtDqZh/WkLUBY8JHLI78M2/wu8P7sLnR1Qevee6
         1V5ayffvg6abnmO95PvFNglhOclwbJ8B7AHpHusBVUllf97hUy9YQi7KjehIiNgL7jsW
         sQxATbnwjAJw1ZmkdEUaf8ug8OZE4wPwXyPUrpXr9qbZL6GT2iyrcekwnsAq8uhVp6vD
         IEy9m534jh8h9ALir+yrZ0Ggxik5SpimcIMvck4HMIkIGo0MZdHALqEwFMkjAXerRIFI
         H3xg==
X-Forwarded-Encrypted: i=1; AFNElJ8qHGdGpnTMFCtxvovJ72OtqB4xpl4z4WMg50zpWS4q39yAqUk2JpKm6Kha2LpO37Pxk9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkG/IFGL5I6Xc+hKmcKyTxbFmi9u3FPQEuddUB6ValHSTLFO+a
	J99Q5f8OikVdPmRG8pGC2D7XdYzdS35iAyJG2viTKIeDNfDXRUgH5sE5fXtGr9FMLGbozrsR6GS
	1tcORWWVnOMKHHNFjXmM83Wrm7i6T3hwyTn0CgO2/pGiUB7bTZG5pnQ==
X-Gm-Gg: AeBDievO3cqM6DEh6zDriisdEGaVGW1uGFWe14I6TX6cPEavp3IRz8yJrw10LTPkhXu
	RuqtTJLVyCTCVzsMt+JpOupiYNDvIh3pNtuGwOjbs4fT6B5ZPyokmNGIAKRkkPDh5tZBTijOrx+
	GfjcsCsM9mdpma9nKKiC8ievQx1dw11o8/StQI7DIjcYLN1U9fHaOhWnoZG9gHp0k940xTCt59E
	NHM0F2M0ip6oYWrgm7QwBrXF3nYv6dYKG+r3G0QpH0OnA+hTKpWRRZ3Z2sdNdnK3ujEVN63BEHG
	njmgRpobIYUmhW5JQE5YyQ8VaeRg80k3pRhiYXxkFlPGvePYa2/i8NMCrVc+6e2y5r86onpsBs8
	Zb9z/k4BwozCxxGCBetUD3UhnYfgp3rOIL6Bshl2oicVaV6InyHw=
X-Received: by 2002:a05:600c:b8a:b0:48a:5333:811e with SMTP id 5b1f17b1804b1-48e51f2f91cmr68975685e9.15.1778082563112;
        Wed, 06 May 2026 08:49:23 -0700 (PDT)
X-Received: by 2002:a05:600c:b8a:b0:48a:5333:811e with SMTP id 5b1f17b1804b1-48e51f2f91cmr68975055e9.15.1778082562568;
        Wed, 06 May 2026 08:49:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e52f5d299sm31638085e9.0.2026.05.06.08.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:49:22 -0700 (PDT)
Date: Wed, 6 May 2026 11:49:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <20260506114213-mutt-send-email-mst@kernel.org>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <20260506111507-mutt-send-email-mst@kernel.org>
 <CANn89iKWhJp2N-60FC4JpX2Dw0sK8-vk2WrHkDOnkgC_c8nbHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKWhJp2N-60FC4JpX2Dw0sK8-vk2WrHkDOnkgC_c8nbHA@mail.gmail.com>

On Wed, May 06, 2026 at 08:38:39AM -0700, Eric Dumazet wrote:
> On Wed, May 6, 2026 at 8:15 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
> > > There is always a discrepancy between skb->len and skb->truesize.
> > > You will not be able to announce a 1MB window, and accept one milliion
> > > skb of 1-byte each.
> >
> > We can if we copy.
> 
> You mean, ignore VIRTIO_VSOCK_SEQ_EOM?

No I mean saving it in a compact form.
If packet boundaries are the only concern, the overhead
needn't exceed 50% even for 1 byte messages. asn.1 ber, for
an over-engineered example?

