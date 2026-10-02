Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D36447254B
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937554; cv=none; b=lI2zd7D3drsuMhXMxuwh2i7EZp9DSck1bY3Nw7UabhVmvv13+UVZOHXhinJlopD34V7trYWDoycsG4aypmM7XuWPMQCGntQIj/TMiTPcpxGG8engku9vzMKeIhWe4MOY1x+Tx3GrL5IXQfkv8JleVaoMiH+ut4qoZAVaEG5/ziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937554; c=relaxed/simple;
	bh=KtkrCiH2Hb/NMXldy9WUxOKupOTiAB7hAqMQ2sR7Kok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGiKNQRXWAups0ST35A+7C4JxV9KoILRCJrvCrmxmgJXqYn1Bqs2IfAlk2v4x748/r5HrNkpfSCZ1BX7YT5bYaONeNeVeYolUYcuU72fUqfDSjJ8dlIve4BSBNIp1CrcbQvVi8AZbVPll1GYEomZTHAZFEjHKxui6EQ56StF+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqahzRIz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJqBE62V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqahzRIz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJqBE62V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790937552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MJkvDY/VxTHA+7Il1t54O0cGx3YczFz/IeL9Lev4wYw=;
	b=CqahzRIzRE4SK+wsKuhUl3J+4FgM/JaIJzEwtbRntD1DyRJpoWZT4XOQQpHT9QurdpCU3M
	XFsfJBB8i/N0E01WYRF8RDzAvwJLMM5v7NQE8ASlo5HI8rtpO25FmMxRLj4zIdF+XizUPy
	56B+Q7zesrKPcR75lkapffq9UyTrXl8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-cSCyU1QiOmezEUaENjFJ6w-1; Fri, 02 Oct 2026 06:39:10 -0400
X-MC-Unique: cSCyU1QiOmezEUaENjFJ6w-1
X-Mimecast-MFC-AGG-ID: cSCyU1QiOmezEUaENjFJ6w_1790937550
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49fcd86b8d3so65557615e9.3
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 03:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790937550; x=1791542350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MJkvDY/VxTHA+7Il1t54O0cGx3YczFz/IeL9Lev4wYw=;
        b=AJqBE62VG3NaNcJbtjjVm1kFsS0GySltsk+XKNztFhjWMLS9LuoDsk56T5bhJ98r3b
         5GZfOzTO5GyDvMmAL3sto4Zuksrtddnsp3g3nwik4DLLHB8TqA9AV76dlQl0b425AA9H
         mnvDgWXk2WAN76/cZGBoj7/JLDag45GjrJVc/ts9kGQQ9uhxuGqd33+wNBX7e+dRoTSM
         6f8jjk2MkKYaQX2OJyZ7HLQfgEMGnEW6btC8J+UNygdcZvjBMKsegX6mUK5V59unkZTN
         YxiB67hvnZqT/T9sGXkfKVxeNAOdA4sJ5L62ovrmCU1idRBLkWkAeY5GaXDkjekaqQlR
         Ipuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790937550; x=1791542350;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MJkvDY/VxTHA+7Il1t54O0cGx3YczFz/IeL9Lev4wYw=;
        b=k/lsGZ60X/96/UIYv4VTlETMHb7W+ONeuGwDaabWoTaAR066/iQZEnC6XijdrGj12u
         QxMcv8ypJTPsrvJjmF77Q2FVxx7RM0BbG3dHAMy/ZfkKp5i6AjEM8e5DzqfkRPY8bIAb
         LldrtxeYxDymyhk3tbwq7PQ7rz81A6eQ8spoSL1txcnasdurIRwnUcini31B+VRnwkQO
         fbmni222fdti5Xe8fDQ8HXLXu0sC9v9jNeYg4V+9xlckIjt9pPxYOZdWeD292NfD9CKA
         H+7FyqZMXTU0zvJRpdKlOby6RQ9UwNgVuV3uzF3Pb5qRtg2taXsrLurnVoh325jTmJ+V
         2xjA==
X-Forwarded-Encrypted: i=1; AKwUvBxLXR8l/A+pnVjkXZDVritiJNbXfJzV/QOQQchMsGktfnKJFo/hMaLwyTQr4TCZolo3Vcc=@vger.kernel.org
X-Gm-Message-State: AFuF++n5N5qSAIt6cN1+a3iV4o6Tv3ha9HonrH1K0kfneaa6J7RF3l+i
	jkmOFrC7ftcza0LNe5ih9LfnVNz4dij+6E6Pg/YUXfPYdEqx/hBxmWYgEPyNUvozQQhyXBS8Sd1
	LZZewyEEDDs3mGrBw57PMoUSV4KXae7e59SKOiByBdz6OtfLpaMRBEQ==
X-Gm-Gg: AYBFou2pdL993o3Hl3Wb3WtL69x7JGkTFVO7JPK6HIPk2OPir/QnpwUp1eiVIpwS+m1
	H8RhtD6zGz5h8Tibun74EEdZnpsLoWwidtaFnMzZUd0q+4Cp2YaRPanVNMeiffUP1Bfk+g1ZRhc
	j2E+7xFy+/yau4srF/N4J4rB6NL/lVv6VnO6Z/JIVfU6BislRKGNjxcUdjz/elZXyuHaISLYUYs
	YiF6TNn6Tule1zxdSPafiKSB1Tz/lxJgshrfJv6f+yPoaRLMHNdqCCu8/GtMvBJngZjAZbFrMw4
	/lT7+b4vp7Cjuedn+uV1NsxW7xoHEg3ouV2Xi8sm09xtxkfinblk8WJPrAtIsTIjHJ55jAOo0xl
	+PKLl
X-Received: by 2002:a05:600c:4e50:b0:49f:faa3:3ca2 with SMTP id 5b1f17b1804b1-4a0275840aamr42202865e9.13.1790937549474;
        Fri, 02 Oct 2026 03:39:09 -0700 (PDT)
X-Received: by 2002:a05:600c:4e50:b0:49f:faa3:3ca2 with SMTP id 5b1f17b1804b1-4a0275840aamr42202565e9.13.1790937549019;
        Fri, 02 Oct 2026 03:39:09 -0700 (PDT)
Received: from sgarzare-redhat ([178.99.185.246])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03fef174bsm38987125e9.2.2026.10.02.03.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:39:08 -0700 (PDT)
Date: Fri, 2 Oct 2026 12:39:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: physicalmtea@gmail.com
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] vsock: reduce RX per-packet socket overhead
Message-ID: <ar95red76pmfQwvF@sgarzare-redhat>
References: <20261002074551.318789-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261002074551.318789-1-physicalmtea@gmail.com>

On Fri, Oct 02, 2026 at 07:45:46AM +0000, physicalmtea@gmail.com wrote:
>From: Jia Jia <physicalmtea@gmail.com>
>
>This series reduces per-packet socket overhead in the virtio-vsock RX
>worker.

I did a quick look but IMO this is hard to review, please try to keep 
patches as small as possible, e.g. where you are introducing ctx, store 
ctx->net in a net variable, so you don't need to touch the entire 
function, etc.

Please check https://docs.kernel.org/process/coding-assistants.html
and also https://docs.kernel.org/process/submitting-patches.html
ans also https://docs.kernel.org/process/maintainer-netdev.html#git-trees-and-patch-flow
(I guess this is net-next material).

I don't think this series was sent properly, I tried
`b4 am 20261002074551.318789-1-physicalmtea@gmail.com` without success 
and also looking at 
https://lore.kernel.org/virtualization/20261002074551.318789-1-physicalmtea@gmail.com/ 
I can't see the full series, please check your workflow.

Also, is this for vsock core or just virtio-vsock? if it's just 
virtio-vsock transports, please use "vsock/virtio" prefix.


>
>Patch 1: separate socket lookup from locked packet processing.
>
>Patch 2: keep one socket lock across a bounded run of established
>STREAM/RW packets for the same native socket.
>
>Patch 3: reuse the locked socket for later packets with the same
>address tuple.
>
>Patch 4: coalesce default write-space notifications while that
>lock is held.
>
>Patch 5: defer the default readable callback until after the batch
>unlocks. Custom callbacks retain per-packet notification behavior.
>
>Performance:
>
>Tested on single-stream AF_VSOCK (1 reader on Guest CPU0, virtio-vsock IRQ
>on Guest CPU1, fresh QEMU guest per state, 16 balanced AB/BA pairs per
>payload).

What the host is using? vhost-vsock?

>
>End-to-end RX throughput (64K receiver buffer, SO_RCVLOWAT=1):
>
>  payload  baseline RX (G/s)  PATCH RX (G/s)  throughput change (95% CI)

What G is? Gbit? Gbytes?

>  256B     0.5722             1.0286          +79.76% [+75.40%, +84.23%]
>  512B     1.1464             1.9779          +72.53% [+69.50%, +75.63%]
>  1K       2.2714             3.6368          +60.12% [+56.92%, +63.37%]
>  4K       3.9095             7.7160          +97.37% [+92.09%, +102.79%]

Why stop to 4k?

>
>Fixed-syscall stress test (receiver buffer = sender write size; RX in G/s):
>
>  payload baseline RX PATCH RX throughput change (95% CI) recv() base/patch
>  256B     0.2885       0.6737    +133.50% [+123.58%, +143.86%]  1048577/1048577
>  512B     0.5631       1.2091    +114.71% [+104.97%, +124.92%]  1048577/1048577
>  1K       1.5361       2.9678    +93.20% [+80.15%, +107.20%]     1048577/1048577
>  4K       2.8378       6.1878    +118.05% [+109.15%, +127.33%]  538802/525645
>
>Request-response latency (Ping-Pong RTT, 10,000 requests):

What tool did you used for both throughput and latency?

>
>  payload  baseline mean RTT (us)  PATCH mean RTT (us)  change (95% CI)
>  256B     126.968                124.541              -1.91% [-3.35%, -0.45%]
>  4K       130.362                126.664              -2.84% [-5.12%, -0.50%]

Whys only this payload cases? For latency we should use even try small 
payloads IMO like 64 bytes.

Thanks,
Stefano

>
>Diagnostic Guest CPU1 system-wide cycles (fixed-64K receiver, with perf):
>
>  Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
>  256B     15.287            13.630          -10.84% [-12.51%, -9.14%]
>  512B      7.306             6.611           -9.51% [-10.92%, -8.08%]
>  1K        3.811             3.458           -9.25% [-10.96%, -7.50%]
>  4K        1.850             1.669           -9.75% [-11.78%, -7.67%]
>
>Jia Jia (5):
>  vsock: split socket lookup from locked RX processing
>  vsock: amortize RX socket locking for stream packets
>  vsock: reuse same-flow socket lookup in RX batches
>  vsock: coalesce RX write-space notifications in lock batches
>  vsock: defer RX readable notifications until batch unlock
>
> include/linux/virtio_vsock.h            |  14 ++
> include/net/af_vsock.h                  |   3 +
> net/vmw_vsock/af_vsock.c                |   2 +
> net/vmw_vsock/virtio_transport.c        |  48 ++++-
> net/vmw_vsock/virtio_transport_common.c | 341 +++++++++++++++++++++++++++-----
> 5 files changed, 357 insertions(+), 51 deletions(-)
>
>base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
>-- 
>2.53.0
>

