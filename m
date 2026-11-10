Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328467;
	b=efKh+/HBbLEdPBEjQ4k5G7JM0r3tFEHSHxNLLyWYtcJWGSJy79BQ2CVZRMOJGrp21XLt
	 9T9lRAtiw8jHM5oFrUC7rbvKj3G8ge3Bwv49zTJ/51qRD751iZ56iCqS0X7weZLAypqPh
	 mHlubQTJebM6pzqx7W2zvAkq5gL7iTXeJsRcsVFFN98yf1gZ9MTLKKvkgn8kMmWenrdym
	 rF0+Fw94GRzljX7ioTFf5xolGha8ZkXLljKgTwGQs/Y1jB3NKWoghaJHyM2EDetH2SZ6N
	 rU2gzWAsAcNRor+mrWHKl2dfzr0Y1LPlJ2AO/V2qqODfYWPCJ821TGcT1Jnj3aMt31A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=y+V2JxIlVOChITFgo1z9lTreH4E5kp3RpfFu+UewLVo=;
	b=SefXVyDJbpQCli24gtaG9miYUt27DGMW2/1ry0HfrECbBlZshLe8TfQW1gTzCzbO4eTY
	 rsrSblKMx+fcBgiiwfljAGSYf8kiK2/LdML6Lbfd7yNb6TZQlBKP1faofo2PZNzZ0iStB
	 GsPaoUj8NRrf/wJsi6GyAlusoyH0/k68khrfEucw2mn+JiEsB+5hQi6lReIy5nSkK1vRM
	 q1igmG3GAnqUUqb5vqGrWMfnvi02nIElLN8QDjLF/t7ylHufzthi31a8UfCx8tjHNLmCu
	 WEuj0WG7NutS6x/Qtog7rwMgM+sp49EscdEcZ5PpboHOQKZKvF9XpuYtago6aZOmGcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fSy8tcC5;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E847606A8A5
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 16:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E847606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fSy8tcC5
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-998d151f441so573438241.2
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 08:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794328466; x=1794933266; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y+V2JxIlVOChITFgo1z9lTreH4E5kp3RpfFu+UewLVo=;
        b=fSy8tcC5IqRPJ8T9YRj22z1qFAkPgpRi2kcT3apWfgMEplaE1W0onrcdvaL/BL/ywE
         rOSS0ydfaat3r8gteyf5+yftpLD+2I78ebj6isd5tSmAO9uXKA6drfZE2fPbEDLgB8tv
         4nj5eU6BbFuMME+jx7QiJhMbdOwnH56XkB3/HT/fr1ZGQooLEtuVaD6KLZUnJ4xbTN5H
         VkTk3pY/yOZ/w9fPvBKK5wNUDrb1f6zcpKrwD0C4hM87Oys5nnQ81EVXkI7GaiyDb9rK
         5iOj/aarsL/qQFbE1WK3Ho0Kl6BxOfVqScOWNlF4Xqlcyi87wAdVUnIdMg2NDVulzXnv
         hkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328466; x=1794933266;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y+V2JxIlVOChITFgo1z9lTreH4E5kp3RpfFu+UewLVo=;
        b=E9b0Yo9/ieb30iODBquY7WA3ws8vBnoYgMVAX0AgzPhypU2kHa9RzlxUcFnl+Xb8Ct
         4u5hwixsuAm2mI4vqXtdjlJtYGDrMYLsvDf+3z6lakQhuEIx5CZQQhLPJgSlikBWolPD
         5un8tRbZACtOt3Fg/4CRLtvSX3vWc/vNwvA/xjGDy482R6QeX3/Id9FL+I7t1sLfnDBG
         lJwX76oPW0KL49V04jN9INceNg7I5wzbB5wHEVVmmB7XArAwn3BemmcZqoO8XL9s6lhc
         6iUD7vkcB6C/fMakOpHBuuQE0wijTFES7BvhWSDVi9todNkoeDTiNg9D7Dd98Vpn+ru/
         geUQ==
X-Forwarded-Encrypted: i=1; AL+hErHSm5N7/Dh32/UcR67POqG8PXxC50Q0qd3I4uAam4HJqhkAFmGCHNdjo+O61QrgY8/3tJo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yZVvgoJvzkgnxG991X4lmwvwUc/JKkwopccbQiN/qhzenRB2z
	mcXK6VzVA7EX7Icd3Z5RCq7Ose8uBUzwVgUmoATvUoAaiYKrkNC1vxcrHmbn6Q==
X-Gm-Gg: AYBFou1QiM+Eh4obJRqirJ/+n+LdrLnQqzMKL/G8xkzEAPd0sLPiMuj/l8MwJjrNLQN
	msuxBybdJnZkvhxZ7+xv0IhRTlp2HTSi6dbKGZCvlQbkloL1lgrw6r49n/V4Kq6bpTzlmcBUm/0
	gC9+VKCsWZptyec8LvA3R4PUOGohT6tYS0CqXfenvKs0dLcz98xNKX9IHpQxxSO5mfbjB5sgihn
	j1gDM9Onh45GDR2g4YYCLzVjz339vs/elBTddEzKBmikSyknXSEXHRKc8rnx9DXw9rnb++MGXJ+
	fzMW2iC2eQLn9hUjR4l2XNNLYxcfOtS17/yzqTLkkibVWs/CDJMghNjgrNrFsGeDzUTExE6q0L2
	rZaZSJ0rpWq3xFG+cnBhrWjMlc3gi3PclsmokiGatL4O2fdUEzFG+g8ILhreZXs9ydGZNhZTHsN
	qBThvCJ2oeLhxP2nQZ1mhx5xu5enEtyeTUtcd3ScyH5rBrkXiT2+dDHVF8fGrMlBhY8EbDMmkI0
	xwQlZ9HdcutI6Q2q407TYI7v9Sh4jM/9MKLcq2+3Ann/pMFMs2yTdiy34Gdh83i7PZrxuiaTnv7
	9c0fPNcAICMMoTQUn0ieaa0wBBmOamhyraQ8EVniqCKDbPqXimQf+/d7KpKw2ORekeotrhZo7Nn
	XaNmwOxhFChk1xSux0A3ThhKn0JqF3ji+PMalg0G/oPeUN7uPcRxQeiaNk6XpggQY7gFBZ1X/ax
	dR6+r+8MqRTSbDaDvE
X-Received: by 2002:a05:6102:c54:b0:7b5:7cd5:2a1b with SMTP id ada2fe7eead31-7d301b9d79fmr866580137.10.1794328466169;
        Tue, 10 Nov 2026 08:34:26 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200838f0sm2147394241.9.2026.11.10.08.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:34:25 -0800 (PST)
Date: Tue, 10 Nov 2026 11:34:25 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 kuba@kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Eric Dumazet <edumazet@kernel.org>, 
 virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 kvm@vger.kernel.org, 
 namangulati@google.com
Message-ID: <willemdebruijn.kernel.4096b48e9e59@gmail.com>
In-Reply-To: <874ido29iy.fsf@pengutronix.de>
References: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
 <willemdebruijn.kernel.1d6388f036c46@gmail.com>
 <874ido29iy.fsf@pengutronix.de>
Subject: Re: [PATCH RFC v4 0/6] virtio-net: add receive timestamp support
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Steffen Trumtrar wrote:
> 
> Hi Willem,
> 
> On 2026-11-01 at 09:57 -05, Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> 
> > Steffen Trumtrar wrote:
> > > This series picks up Willem de Bruijn's work on a virtio-net receive
> > > timestamp. The device puts the time of arrival (TAI, ns) into the
> > > virtio-net header so the guest can use it for PTP and RTT estimation
> > > without taking the timestamp itself after the host-to-guest latency.
> > > 
> > > The series is an RFC. I am mostly interested in feedback on the
> > > approach and on the wire format:
> > 
> > At a high level +1 from me.
> 
> Thanks!
> 
> > 
> > Some comments inline.
> > > 
> > >  - The timestamp is a new field at the end of virtio_net_common_hdr
> > >    after outer_nh_offset and ipsec, offset 32 (see virtio spec),
> > >    negotiated with VIRTIO_NET_F_RX_TSTAMP (bit 49). Header size now 40
> > >    bytes.
> > >    Willem noted on v3 that virtio_net_common_hdr was not meant to be
> > >    extended this way; I kept it as the simplest approach, but a
> > >    separate struct for the timestamp header is an option.
> > >  - Timestamping is enabled at runtime with SIOCSHWTSTAMP; all
> > >    supported rx filters behave the same for now.
> > >  - XDP programs can read the timestamp with
> > >    bpf_xdp_metadata_rx_timestamp().
> > >  - vhost-net passes the feature through; the timestamp itself is
> > >    written by tun. The tun patch is only meant as a reference
> > >    implementation for the device side.
> > >  - The timestamp is in TAI.
> > 
> > Is this a requirement? It is common for PHCs to be synced to TAI,
> > but not 100% the case. Does virtio need to specify this.
> >
> 
> No, I don't think it has to be TAI. TAI is only what the tun reference
> implementation does (ktime_get_clocktai_ns()). What the guest really
> needs is to know which clock the timestamp comes from, so it can compare
> it with something.
> 
> One idea for the spec change: don't fix the time base in virtio-net at
> all, only say the timestamp is in nanoseconds of some device clock, and
> let the device tell the driver which clock that is. virtio_rtc already
> has clock ids with a type (UTC, TAI, monotonic, ...), and the Linux
> driver registers a PHC for each of them (with VIRTIO_RTC_PTP).
> virtio-net could carry the virtio_rtc clock id in its config space, and
> the driver reports the index of that PHC in get_ts_info. That would also
> fix the phc_index == -1 problem you pointed out in 2/6.
> 
> What I don't like about it: virtio-net then depends on a second device
> being there, and with more than one virtio_rtc device the clock id alone
> is not enough to find the right one. Without virtio_rtc the driver would
> not offer hardware timestamps at all.
> 
> The alternative is a PHC in virtio-net itself (gettime over the control
> vq), which is a lot more spec for one timestamp field.
> 
> Do you think the virtio_rtc way is reasonable, or is there something
> simpler I'm missing?

I don't have an obvious answer. This needs consensus.

Hardcoding clock base to TAI is definitely easiest.

Outside of virtio, the relationship between PHY RX timestamps and PHC
is well understood. It would make some sense for virtio to follow that
model.

But indeed when having multiple NICs and multiple PHCs, how to map them
I think is an unresolved issue in general? Of course, aslo moot if they
are all synced, which I think may be an implicit assumption especially
in the world of spec compliant PTP.

And, if virtualizing anyway, it is feasible to do the clock conversion
in the software device, not having to bother with all this complexity
inside the VM. Though maybe not for direct HW virtio-net queues.

