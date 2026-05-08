Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539E5346FD2
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778235113; cv=none; b=NOrlubZ5zcuTb0y4sZBAZ7uqCbtQeH7iqrgQ7h8IX+oGu3EQkQ6kfz4Dsf0AEm0gzAXVkMDhbov/a0lR8qs2ilfX+HHl3aLLivwzpAEJMLzUgqNaBzA0ZTWP153emCNBJt8crs+6F9ccwR/OwyF7iX3qFUVYcW8f9WAxvAo2U/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778235113; c=relaxed/simple;
	bh=5elEoYj/5z4XlNxRebDQfE/NWKivBbNLq4gq+S9kA1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiA3Tg0Cy1+ZD09KMHojR4Yty1SmvvLF6gtlJuGPKF6aMtwer5rqC7pDO8Ryp7c34DFckDG8C6jtg/jMTIrd37IopKjGtC5opOCSaIzB7pMysfORsTFKPHr3F2cbxxXYHcpvIPzkwfdM+g/hyMZqMnZ06MpYprswQbBLF/4GaEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWJpfyht; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAT+xl3a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWJpfyht";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAT+xl3a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778235111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fa/C2+f55nR6HMXUZTO/HqGU3IIvZs20T/G6LNckFSc=;
	b=gWJpfyhtTQFeZzNIpL4eqbEsrsbK957PfSj5S4zoaxWlN5OTeYnAS2HPdVszzzilTkWNw5
	8cmT1/6pG7PSVej4lmCNtHYC0bI+wfm0P4YDmBCPSFBmCuW9FSvdIaTY2LD3MbtE7RqPRQ
	XMFzhjwNDVGqU5zFb2zTbjhDKnYdXGg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-CmbNwL6xNFmcQsMOH21ryg-1; Fri, 08 May 2026 06:11:50 -0400
X-MC-Unique: CmbNwL6xNFmcQsMOH21ryg-1
X-Mimecast-MFC-AGG-ID: CmbNwL6xNFmcQsMOH21ryg_1778235109
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488c2cc0cbaso13309345e9.3
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 03:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778235109; x=1778839909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fa/C2+f55nR6HMXUZTO/HqGU3IIvZs20T/G6LNckFSc=;
        b=eAT+xl3auvACwYVDWNQ/a/vXSSWf7cexflo1EFIy+uSrTc8FpxbKEpEqpfuWWVsxxX
         TdliVyhZCqrZUbhqEf8cbaMOzU12zH9lVg7xk7mypnkmmEfsxHsyZKazvvIWtakdDQ6S
         Hs0OHJmYjVubr/7tgAkJzZbirMrDj5GyjLvJqzFOigNw5NaID9jreA52fXtjBBATKqAF
         VzwfU/FMfTu3C76ri+atdwSEYnIIyUUstgc1vGwQQSIy5bbYifTis2bbIMX6nZLR1jT5
         8w1VcjX+PvN/dn6RR16FXKDRxWsJa0v0WtN9z+8lHzGW28UcObahfcfTPbYQ8kLxZoHu
         CTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778235109; x=1778839909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa/C2+f55nR6HMXUZTO/HqGU3IIvZs20T/G6LNckFSc=;
        b=qcBMbJijDur885juZgxvVwos8Bc04VG6e7k0okAeAAfpDn0ld22l4a4xPqVPDTIUyT
         2BbB8EtEYDIQuaGA/dWir5E+qe7MhUYzpFA83iaIM65bRgvQDlxbdY8zXZSYlXyVbCEN
         p7UiZSNErMsQ0bMViuv/hdh8XOEtQRvTMCPEaiWUVOj9HRtV+OItZRA9ST09vvLzK8Cn
         Q4KSHpmrGEIXDdbcMLirl4EMil55dtCLbi6lvEDpmr/EyPPSvnlchKTPLpGbdlevIVMs
         Z9PkK2gRYaq6whi7VZb1GeXRlnvkZTTtwIvJRJpXtsbZmfuR40CwMGq9mfHs9YDeL6x8
         QyUA==
X-Forwarded-Encrypted: i=1; AFNElJ84djhEWbcHrsnbrZmXmJiPeqneWetl3edro7Zzx2wjWgvKJjMZdlK86HXFiEK5uST1sH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJeJHCEwLrn5bM4l1MFgUt4edcM5fknEdx0NX5GomKiPgNm7ph
	OSFGSEIFTqiB9H0M0x+jlpubioA9x9Fv55v/bpTVyMDUy8w4orGYubsZmvwks5coaHw7casJomx
	XRwBBvFPZHCszn9DjFqwLgUBLOUmU0zQLKY5Z8DsK7CUY+MwljuGznQ==
X-Gm-Gg: AeBDiesaxkVrCGhAvOYH35PDsuO7SowXcn5VfN0Ktbhh320Xq4FfOtd8bptlHL/Xd9V
	MEpiBe/aHG1kWfEYxIvhIMo0aXpWJc7yOmjiJCBV+QTPX8DOjLpKxm3fN1oBSaHa599kCpsTvK8
	QvTAi7EmtG4tkRfyMh2FxlSQA00BQ3MIqOnAvLYzC2i/YcVR/fsBNML3KV/m6Q6e9nwWSdvmzxH
	1OUX7l7IplyO5mitHAWPALz8/t2PVK3mD+XS5EqtQYtu0Nfn/87+Mjj1QC48p4mlUc1JGK9buYT
	OTGldiuaQK3r3clwOQunW6BzZBrBx+YPoEbkym6McNA2ioE0I1OuMAEL/N3/lR/j6lIS4CDJDhJ
	M5Wtnqaavtw7XHuMs4NiaXnHz2fdhj+KV9TXdX0ZklMAhQldVkci7/Q5eae3CQBQ=
X-Received: by 2002:a05:600d:8:b0:48a:58ae:993b with SMTP id 5b1f17b1804b1-48e676a4e03mr30602895e9.16.1778235108727;
        Fri, 08 May 2026 03:11:48 -0700 (PDT)
X-Received: by 2002:a05:600d:8:b0:48a:58ae:993b with SMTP id 5b1f17b1804b1-48e676a4e03mr30602315e9.16.1778235108187;
        Fri, 08 May 2026 03:11:48 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a6470sm2848938f8f.7.2026.05.08.03.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:11:47 -0700 (PDT)
Date: Fri, 8 May 2026 12:11:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <af21ZGlANY6UUCKx@sgarzare-redhat>
References: <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat>
 <20260507074113-mutt-send-email-mst@kernel.org>
 <afyMCyBvZpzWrLtO@sgarzare-redhat>
 <20260507163710-mutt-send-email-mst@kernel.org>
 <af2sXvVCBT05XF0D@sgarzare-redhat>
 <20260508055343-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260508055343-mutt-send-email-mst@kernel.org>

On Fri, May 08, 2026 at 05:58:06AM -0400, Michael S. Tsirkin wrote:
>On Fri, May 08, 2026 at 11:41:21AM +0200, Stefano Garzarella wrote:
>> On Thu, May 07, 2026 at 06:48:47PM -0400, Michael S. Tsirkin wrote:
>> > On Thu, May 07, 2026 at 02:59:13PM +0200, Stefano Garzarella wrote:
>> > > On Thu, May 07, 2026 at 07:45:10AM -0400, Michael S. Tsirkin wrote:
>> > > > On Thu, May 07, 2026 at 11:09:47AM +0200, Stefano Garzarella wrote:
>>
>> [...]
>>
>> > > > > For now, we're already doing something:
>> > > > > merging the skuffs if they don't have EOM set.
>> > > >
>> > > >
>> > > > Right that's good. You could go further and merge with EOM too
>> > > > if you stick the info about message boundaries somewhere else.
>> > >
>> > > This adds a lot of complexity IMO, but we can try.
>> > >
>> > > Do you have something in mind?
>> >
>> > BER is clearly overkill but here's a POC that claude made for me,
>> > just to give u an idea. It's clearly has a ton of issues,
>> > for example I dislike how GFP_ATOMIC is handled.
>>
>> Okay, I somewhat understand, but clearly this isn't net material
>
>I doubt we have many other options given reverting the regression was
>ruled out.

As Eric pointed out, we can't revert it.

>
>
>> so for now
>> I think the best thing to do is to merge the fixup I sent (or something
>> similar):
>> https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/
>
>I reviewed that one, problem is it's a spec violation/change that we'll
>have to support forever.

I have a few points to make on this, but let's discuss them there.

>
>> This is a major change that should be merged with more caution.
>> Could this have too much of an impact on performance?
>>
>> Thanks,
>> Stefano
>
>It's really a POC, real patch is left as an excersise for the reader 
>:).

eheh, I see, but honestly, this overcomplication scares me. I'll try to 
think it over.

>The correct approach IMHO is to only start using this
>when we wasted a lot of memory on small packets.
>
>For example, if sum(truesize) >= buf size.
>
>then we'll not see a perf impact unless it's already pathological.

Agree on this, which is similar to what I'm doing in that patch.  
Reducing the advertised buf_alloc only in pathological cases (e.g.  
overhead > buf_alloc).

Stefano

