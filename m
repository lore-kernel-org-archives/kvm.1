Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688079;
	b=dKbPdwilrXlIlziNd8wa0YDi3PKYzbbif/VWxcTCf/bCDZblwjzYZoEMqmNIcu7y/Mrt
	 u69pBouAtUSzj7e4tPHOnMljlQJ35gbcEr95LDgNq0HhNPa5UaILyy5gbL0faeLlQpfZ9
	 yzjoRm2XnE4iQKL2gmFHAK0JBpVbwuB8TKF8zor6730iVhkC2U8VS7dLqkyMrIh5smVDy
	 NG9VVUYUnLMmJyFz2F62+Vjol5+cYnuHQcr2qYH0terQzaQWowAFcuoPeIoVK5G9nYXML
	 cgjVpW4L/h/W9FUY6Idbz4j6MEFfOk0nqisWwkHBVX4C6XFkNTMR2sqWaScn5vTxwSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688079;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BnEINIidcy7TeGrgKBkYjEF8byD48m59WTwJN6efYCU=;
	b=LmQqs6wW5O+yjztFO5aLs80FbT7sXyPIMJu3xAqS0nKXBWlZfxyYUYkr/M0Z8BGzvyMG
	 he06p3nAQ2zK0J3aUNyfIsufJNg9HS4DbZjUM4qWQMOW8Mkif9igiIysj6Zk8NDv6tSs6
	 j6HXzjYh0d9+0P5UGZ2NDP4/Alw0X1p78ij2dBtyw/30huoC2GKRwkwypIt2Q9an1TooR
	 IsYzxr3wW42vQ/tLxGoFV/YnSVm7QbIbddQ3Et4+bGNaUnc0GX6UgFoIIa5w/fQU7yfBg
	 3Atx5i+KLQGCbZH66Reiq2PccGTpDBl28ZBPeQG7osIyLxmEwOZ8c83KUK5iAS/6oFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QfhvVOBA;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Novt99Iv;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1BE606A6A2
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 10:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B1BE606A6A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QfhvVOBA;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Novt99Iv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795688077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BnEINIidcy7TeGrgKBkYjEF8byD48m59WTwJN6efYCU=;
	b=QfhvVOBA1Jh5+GzeK/PWLIsk/3l4Hm1FRzShQ0yTqSUFKtfC3ULVr/pzzn3JV7fLOIXdJX
	0vmc38r6FCLGhosgWNclLI2fNSmNFmnkmOqw31D5vcGb4wuSP5fK8GgNkBHagLN9WE2X0H
	29sJQy15kbXHisMGOnRLc6cZu0Vx1Eg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-H1cY5GUQO46Vuiq75QmY-A-1; Thu, 26 Nov 2026 10:14:35 +0000
X-MC-Unique: H1cY5GUQO46Vuiq75QmY-A-1
X-Mimecast-MFC-AGG-ID: H1cY5GUQO46Vuiq75QmY-A_1795688075
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4a3705ea6ccso3790016f8f.2
        for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 02:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795688074; x=1796292874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BnEINIidcy7TeGrgKBkYjEF8byD48m59WTwJN6efYCU=;
        b=Novt99IvoJHBJ/nZbRBzAfBcTol0OkkVsYep/cKsDHWzuCmfRlBwTGAwNzvzTwvikC
         YApTr97ucTzYvzijLm1iSOdclGJ+wewkvaO6tyqb9QvQElDnBHsTbE2XRmb08nib9IS+
         fPYQr18Oxc128/QnVzb8nD/sCMldgYlWBbpamtajFaiZ+cX6HDC4z6pKrk1G2gFwXr4V
         ubbLmJp04FG1V5+nmDmvPcaUD7EghWcpfm9hYqBqgVul0l1Fosfx6FyBsztlzNCGrkFi
         AwQol+biuxYtul+APnDx7r1d5FxyBKErYWbEvZEzKof/CmmjPCnqvpZioPhH1dyPDmB4
         gsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795688074; x=1796292874;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BnEINIidcy7TeGrgKBkYjEF8byD48m59WTwJN6efYCU=;
        b=tHXqMz/9gZwABrgwUzdAP+X2rqbMHOuGaPgrzxouc8PIHCwg3OEhfUG2g71EEDL/qS
         dOGj7uUk1JwUERScVkP8sV4RzDp1zxArfp7Am9ia+drua1s6uxv3dssd7ozCUwpSMn4x
         vr74/ySFb+O5W9NEHZySmi5xO7+V7HjunBjb2/PXAKjlhXj/sa+6JTpd355zcaTFlzRu
         bZ4fER4gTpmIxARHjxvGpkGv+QhprBjC/9Tin70/GkX7Wry7FzmwHb/yWjC/akisej0K
         xtqUaypOCS/hQ5EMgKCJbfa4U8+DS8Gi1zsAEVF7gNqQtS+Ma05IxyHKz9/fuSo5rM+O
         T6SA==
X-Forwarded-Encrypted: i=1; AL+hErGW6YzXoAYdnRPMkLZ03JYhdun78TB5hL2W8g59yObq9Po1P6ONYdqJcC0MKUUnfmYczG8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cVSyQSCaxcnyKqItPwUbx2Q+0a7qw/rX4Iv504mtFEeFXfQsL
	teIIqAuj5RQitttjeunvaY5KbeE2NKzYSs7e+T4+huYZz8+eU7UPlDYXWcCsvNs1KTpGQhLQzmI
	io3WSt/5zXjnekORyOLbpYPt403tCPYh5MP/i02sA98b3AYUGMGjeiw==
X-Gm-Gg: AZFdTZen4PN7+SsEwfiWJJJdJeJsUN8n9BJRAa9vv6zkh2KdSddfpSE6ttrn14uKajq
	NR44hTnmxgbGlMxpcjpAKkPONSs2UBFaPxeiwbZ7r309WmHBS2GLWF28M7DebYVw/FsQpu3dn/p
	cvDgBLu5ntNEJ9Usv8y7XWdH5Stf6W/o3wOKPvzLmDCFUT7K2m9dhKDwklXA+4KvRgrFtgLKG9h
	+YawXhkH9ehIXK8TE4Rv7ybJKCzaW2eEELsn8lTke2/kGgWXWNdvynNCfGQ+dHe6Mpb4vxBW16X
	3HSOaTDm6YIOivcsOZVn4QcJ/0TYNJ3b9AP5GdmFAOvASc/ZXPSKuzUARJSOgGkUE6WVjttdhj4
	A2FkUjFrS1fEVYOtuHOKtv6aYxNbwbFtTxXJCnNBPmy50pyWQwOxX1A==
X-Received: by 2002:a05:600c:1d04:b0:4bb:685e:cc42 with SMTP id 5b1f17b1804b1-4bb88817e4emr429734055e9.18.1795688074524;
        Thu, 26 Nov 2026 02:14:34 -0800 (PST)
X-Received: by 2002:a05:600c:1d04:b0:4bb:685e:cc42 with SMTP id 5b1f17b1804b1-4bb88817e4emr429733645e9.18.1795688074082;
        Thu, 26 Nov 2026 02:14:34 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf680fsm45686158f8f.14.2026.11.26.02.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 02:14:32 -0800 (PST)
Date: Thu, 26 Nov 2026 11:14:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, bobbyeshleman@gmail.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 4/5] vsock/virtio: coalesce native RX
 write-space notifications
Message-ID: <awgGJECGxVi-40Tq@sgarzare-redhat>
References: <20261103041134.33310-1-physicalmtea@gmail.com>
 <20261103041134.33310-5-physicalmtea@gmail.com>
 <auxHe77Kv3tS4hjJ@sgarzare-redhat>
 <CAJwVaMK6UpxOmCbuzGK15h+DhN5H6cj6cy-=gCHtSxoVbLfzwA@mail.gmail.com>
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
In-Reply-To: <CAJwVaMK6UpxOmCbuzGK15h+DhN5H6cj6cy-=gCHtSxoVbLfzwA@mail.gmail.com>

On Fri, Nov 06, 2026 at 08:49:17PM +0800, Jia Jia wrote:
> >
> > On Tue, Nov 03, 2026 at 12:11:33PM +0800, Jia Jia wrote:
> > >Each received packet can update peer credit and call sk_write_space(). A
> > >writer cannot consume that credit while the virtio RX worker retains the
> > >socket lock, so repeated native write-space notifications in one RX batch
> > >are unnecessary.
> > >
> > >This patch coalesces write-space notifications on the native AF_VSOCK path;
> > >data-ready remains per-packet here.
> > >
> > >The batching patch establishes batch ownership before its first packet.
> > >This lets this patch record a pending notification for that packet and
> > >flush it even if the packet immediately ends the batch. Deliver it while
> > >holding the socket lock to preserve the callback context of the existing
> > >receive path. A following patch changes that timing together with
> > >data-ready handling.
> >
> > Can you report performance data related to this patch also here?
> >
> > IIUC this is not giving a lot of advantage, so my question is if this
> > more complexity really add a value for us.
> >
> 
> Sure. The performance tests currently cover patches 4 and 5 together,
> so I will include those results here.
> 
> They do not add another broad throughput improvement. I kept the
> combined notification change because of the cycles/byte results.
> 
> With P1-P3 only, against baseline:
> 
>   Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
>   64B        66.728    61.220  -8.25% [-18.99%, +3.91%]
>   256B       14.363    14.515  +1.06% [ -4.22%, +6.64%]
>   512B        7.792     7.578  -2.74% [ -6.55%, +1.23%]
>   1K          3.988     4.032  +1.09% [ -1.64%, +3.88%]
>   4K          2.063     1.973  -4.38% [ -8.23%, -0.37%]
>   8K          1.702     1.667  -2.06% [ -7.99%, +4.25%]
>   16K         1.473     1.475  +0.17% [ -5.06%, +5.68%]
>   64K         1.385     1.358  -1.96% [-10.61%, +7.53%]
> 
> Only the 4K interval excluded zero. With the full series, against
> baseline:
> 
>   Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
>   64B        65.282    57.843  -11.40% [-13.77%, -8.95%]
>   256B       14.710    13.813   -6.10% [ -7.89%, -4.28%]
>   512B        7.709     7.188   -6.75% [ -8.79%, -4.66%]
>   1K          4.075     3.862   -5.23% [ -6.80%, -3.63%]
>   4K          2.034     1.887   -7.21% [ -8.67%, -5.72%]
>   8K          1.664     1.568   -5.78% [ -7.83%, -3.69%]
>   16K         1.450     1.385   -4.48% [ -6.08%, -2.86%]
>   64K         1.338     1.317   -1.51% [ -3.21%, +0.22%]
> 
> From 64B through 16K those intervals stay below zero. 64B through 1K
> did not show that in the P1-P3 run.
> 
> This is also why I spent the time making this work with sockmap.
> 
> The value I see is lower RX CPU cost, not another large throughput
> gain. I am still unsure the extra code is worth it, and I would like
> your opinion.

Thanks for the numbers!

Both tables are against baseline, but the two baselines are a bit
different (e.g. 66.728 vs 65.282 for 64B), so it's not easy to see the
real contribution of P4/P5. Can you compare the full series directly
against P1-P3?

Anyway, IMO the big win of this series is P1-P3 (throughput), while
P4/P5 add a lot of complexity (saved native callbacks, new af_vsock
helpers, sk_callback_lock, sockmap corner cases) for a ~5% of CPU
cost, without throughput improvement.

So my suggestion is to split the series: send P1-P3 first, so we can
focus the review on them and merge them, and then send P4/P5 (squashed)
as a separate series. That way we can also evaluate the direction
suggested by Bobby (batching in read_skb() + coalesced sk_data_ready(),
like TCP), that may allow us to avoid saving the native callbacks at
all.

WDYT?

Thanks,
Stefano
