Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794502641;
	b=hmwi8UVtXlPWHDiWJ3aGATisQNqef6pAc8yTVjIEPyRCVHvGq4LKZggwkdiv4KrYe+Dh
	 h0bAyonv4VOau/9MordejCQtzUc7VGP0LHSolQesaxf+vDM3aQyfys7hl7r6rh3IpBWSN
	 6cMCPEctwYdi3FjFYzOrJjgocj2n7TeyeGHCgjIQ/eemVA3HyOLaUfbCV+U3/Zbthr1qO
	 sZUdJzzHMXDXC7kTaVi6AMU+TzguskdAR/RbprkFlrIflsOgUwPG93Pj8yyPde4DiTsb7
	 kNuVZSqvc1ddbLI8CYa555Gm+afTzFV1DC4EnzV/vPFh5qRl9bdhF4zHS73BduaDN8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502641;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
	b=oh7WljjI1OmYd+1PZ6hjCidQKDvBIyXptLTlSSVYFRauR2IQdsJRPL3W3H6uJYypr2s7
	 VLiACTsPazlfy/FGDbGu3MjnvoyLH+fzCWYpPcWhuh+b5drTvTvjo2j1KV+5iUrIMhapD
	 FZ9cs/VkXJebK3eCHI5dm8+KNtOQgk2LLOa2BsZjOIPa3HEI1nN4Zl0Yb+MeLSAjy2roJ
	 MLkN0YuuA6svNHGhlFwku4wazHiUXnvFjkEp/4hvwwJkgVPS/ApPEN+AA8biYhD958H9O
	 5a/1Qsnl0yWc0mX/9NmMWzcLAi8vn+Cx1Pg43SW3KlwnIb+BXYaBs7nKc+0bLtnbjtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WR0iSL7E;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mfphcUTJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B51606A335
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 16:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7B51606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WR0iSL7E;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mfphcUTJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794502640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
	b=WR0iSL7ERJdv15vokbc34Ew1ggE2lIS9qgOjc2zhvCdoFhuBftBHZtUl8icwUUpw7ytzMC
	oOr+18BDQiYijHq6PtcpItyuYo35cPmk2z5GFLDrdubrAJ/JKeIDKfBGolvWEnRm1GXiwl
	Ghsuq+8o91RragwwPPTh65OyuOcWvWs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-GTyGmaB5MZi-oNPNyuwL6g-1; Thu, 12 Nov 2026 11:57:17 -0500
X-MC-Unique: GTyGmaB5MZi-oNPNyuwL6g-1
X-Mimecast-MFC-AGG-ID: GTyGmaB5MZi-oNPNyuwL6g_1794502636
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91f1b3070f2so45226d6.2
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 08:57:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794502636; cv=none;
        d=google.com; s=arc-20260327;
        b=WXToJVzALPmWo2yNkDPkKAK0yhXsGdOzxg2qNSff5HGUov81ggb7ldkuEftmJCRdqJ
         N0Lm/DK2Tl84ImwffDUZuK2PUBIPk0g2R1cWQzsu0tRPS9hoVIBN9qprmk7Tekiz2a6L
         tI8sKSUb3AIRAwZeMt/25JUhaCgD6+mWwuq25o5mNi5A/vDnkU0BEEmlDjHj6S0ofk0F
         7EiPhjitPKrjTRux0pss7vmui7tGb9hLgd1G/i2GLdoZ4HNqlsPUMfH8eJJI3PI6ey6o
         EnFwUX6w8pqU+vM3Pumipd/uqcDXsj54Q+g/Le/6STrQH/apwwJ4YoRkLeKTF40lT5nX
         uu2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
        fh=y6XsPyfCl+957tHrU5UdcWP2wg7ivZ0lpTlMeYS2b6I=;
        b=o5QNMBd5g0tDuRs+mH6Ue4igUtse4rxV9G3GzZgNr8T1aoXgzp+rfY/JkgeumiG8m8
         yz6vQS2gD0lln6branEneVeOkntrEa+lY2jvJO1C3PgsVeJoHCp3QToo7yg0GlpSH/Ke
         d/sPY7m7ERCF7zeP4vh43DcW9tJ5JZNJSQB/7O8SWLZXlwY5URnUezyB2JiVwik+Ah42
         U9OGtuJoI0OprXnXfvQtfsqvy7CVkLXrZG+nAcf0V28jynokQ053I0bSa+S64yx4TDjc
         +808XKJ//ZH+U1XeFCI/96RwMvJquX1CUa6hhvrXqHpIHeby4/BK1wbu4AZC7fAxpIIs
         fq3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794502636; x=1795107436; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
        b=mfphcUTJmKpNNjKE/vba8sbrm2GA7Y+gcHku8cTk1a+y2dk3EloihtRyKAQeirIvDp
         wvg8gkhJ5lC1AkaK6heaVC6iCZhP3qCeGnLlBSZBpeyaU5rKFLySsduaBj+RJQrdj/E/
         IvWZE44ZUGb6gMSkTITxuIkeJPwmU9i14CTY5gqBw8ihusdtAVkW8q/898LYixqHhZYX
         YqpsLL6HWprFGBwF9Jr3IbUomVpiAGiwrOGlg3zjzrZwjD5T5QVv8bgZRv4HjYSAOgZf
         YjJaZhabEjQq3VWp4hxuQIFQlsqsnhAkHF8n3rCUYqLL+Up6ZKGZVhESekpKQ0IoL+2B
         u0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794502636; x=1795107436;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
        b=VQRjXmuuGp5L68BhHq8CjHBm4QV7K/9nXf/WieY+JbtAD8/y2W91T6u8v68rVLnvoR
         yTkmBPRn7WOYatzxQ7xpGYXMHsqrn3BxwsCuMPosrL+ZOjVX+GaiBY7y0IBUulJ1Hr5Q
         hiBEizgD6NZO96FiqURzeighArmQl+dccpNjWEbugliyL8m8+fUYWIMlhiQfRWNGpW9U
         cF2B93V51CaeTRrPCvNtTJZNZT01hWH5qS/G/U4udiAms+CXd+bYji0eYX7KqsQuUEeC
         Zl6YkJgJwytlRu3hCxYyt6WBwS30SOek0hzXddgnWCv6zAqE49+cIhtOGi5aCkIEIHVa
         NW7g==
X-Forwarded-Encrypted: i=1; AL+hErFfvD2DACqp8MUNPIDhtlWCID7vWAQHviog1g33ieTNnUAaSwyRS/AWD3hnjy/4dp4r9UM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8h8NLrdTGE2El54xSxllaL0Y+6Q+AZIYK9hTd0thg6s42EqRzw
	JVKpzg2xbnKZGhxjYt1UcZZk143aqsI8K28rYcaBriNK3bWQA4w30QHRVdQGsquTt52Fd7Lf2aJ
	P2gsNIO3wQ1iSkg9EIhU/nVOE/58nQSug3wbrL/G+2+qZKvRIfkLnvZX8WUpzD7J+2m8jD2E/kn
	N/0fWP+vVP0jJmVCxkxzjuNPlE2blS
X-Gm-Gg: AYBFou06hshQM2d+f5v/kR3XHrpC/R+X6com7c5S2sKnxYC+6FYiBF7FUDoiCBGFj7y
	ad5sTr6u/J10GVuVUQIIpz6YV8IVXvsQzsgJkfjR9qCCZE2ogVi4bwLhns4j5f/gYGD8oS4/nkW
	/8a9RGnEmVzek0bEJNq+NCGI7YeCSugmRU8Ib7YLsAVlJXoGdO3eN6U2s=
X-Received: by 2002:a05:6214:4907:b0:917:af36:df30 with SMTP id 6a1803df08f44-91f04024a36mr108416536d6.16.1794502636098;
        Thu, 12 Nov 2026 08:57:16 -0800 (PST)
X-Received: by 2002:a05:6214:4907:b0:917:af36:df30 with SMTP id
 6a1803df08f44-91f04024a36mr108415966d6.16.1794502635425; Thu, 12 Nov 2026
 08:57:15 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Nov 2026 10:57:14 -0600
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <aukO0YEZmiMIISaP@devvm29614.prn0.facebook.com>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
 <20261028-vsock-dgram-support-v1-7-e457cf7cee78@sinrega.org> <aukO0YEZmiMIISaP@devvm29614.prn0.facebook.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 10:57:14 -0600
X-Gm-Features: AclHuK97Vbt87h1PiWp1yuLFdgsXXBfxSod9rL7qWx7O4MzdkcMf0Vg2mTyClE4
Message-ID: <CAAiTLFV5g4XV7ZU+TYFboAi3n535murgSjh4SBw_PMnp=oQyww@mail.gmail.com>
Subject: Re: [PATCH RFC 7/8] vsock: preserve host-to-guest datagram boundaries
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	bpf@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Bobby Eshleman <bobbyeshleman@meta.com> writes:

> On Wed, Oct 28, 2026 at 05:04:36PM +0100, Sergio Lopez wrote:
>> Vhost splits large datagrams across guest RX buffers, delivering each
>> fragment as a separate message. Allocate full-size RX buffers with
>> page fragments when datagrams are negotiated, and drop whole datagrams
>> if a guest buffer is too small. Refill empty RX queues even when only
>> one full-size buffer fits in the ring.
>
> I wonder if it might be better to do what seqpacket does, and just split
> the datagram across the buffers (for seqpacket, until the EOM flag is
> seen)? I'd expect that we will get better utilization of our vq buffers
> this way?
>

Yeah, I do like that approach better. I'm going to implement it for v2.

Thanks!
Sergio.

