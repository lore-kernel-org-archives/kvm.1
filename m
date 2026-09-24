Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B603470428
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245044; cv=none; b=gMWF/Yjn083retiFjDkyJowmr2R92ITPV3u7y0iKjHodu/uuQjV7R3TUe3+mGZndVy41zObngWXmY4y441lU9DjPR5p8O/A3H9Q6gzDF+FYdOQPe/UCcBT1gLtww54a+6r6TXd1SAfWv6CAuHDYea/Bx4zXAOCdDx2PcKsXyzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245044; c=relaxed/simple;
	bh=OLQtN8/9/Nf4flz3Kt2BUy4OlOf9PndZym7N2lg6lbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlO0WPGas9kdMDbRSrGmqPPn/IdEKjDAAnTTWXP8U2qQUOOViz3QwE7W2IXCA/AGoxCP8uSYDSTruP+3GcrNcbZyGzRZHb8TafKTvzjiQ8LSwPu8w1cGzuFOiimZKjIIr/bruiKhRf+RCJ24XI3x1iDN+umVMitWr14Mqli2xis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a62eB1VJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SLC4QTgF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a62eB1VJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLC4QTgF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790245034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H6EUUW1m1zoaB7DVxqcfClkBe+yQHGLp6gBbcFMHwFk=;
	b=a62eB1VJw75EktJS75+2xdXvr1XdUTzZGANOZ6VNC2K0i37XkEM8udyTyctf9fc+AKAPln
	XW0baWTvX4xpvYoXgo98WNM1uDEe0X2xP1nFeFFKflB0F6mEu+k2nNaPuqaICwupl8noAZ
	Y1Tvd58bMrb1sEWfEUbSeZJfgEJEcD4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-8CeLE9wOOiq5d5fpcDabfw-1; Thu, 24 Sep 2026 06:17:12 -0400
X-MC-Unique: 8CeLE9wOOiq5d5fpcDabfw-1
X-Mimecast-MFC-AGG-ID: 8CeLE9wOOiq5d5fpcDabfw_1790245031
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-486f768517dso1453345f8f.1
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 03:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790245031; x=1790849831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H6EUUW1m1zoaB7DVxqcfClkBe+yQHGLp6gBbcFMHwFk=;
        b=SLC4QTgFAAmhmFB0lfmX2GhPXUY3bABWcBSfVj+xcAe18+GN19WX5pbtqMUPDVKuOd
         b5EOf+bxKaW+wnvqX0YMlANb0wCPN4K7JS+1xJks1Kc2rbctUkYGOpT6sdevnenxfMJe
         DnhkShpfo94T4Ie/gNC1s9yBQUlOBuqDe4r3zuvvDplxCz4nqa4iQMX+dgCnkWoNXRTQ
         njDHVkAgJOpFzZ29AMlOvMFAOVdzqLavI59ltEFrDcV14ryLvSU93A6mvcYUiv4VXOXb
         hLYxdUFD1R4p1CxxhHWRbTIdTv1fjL22IglA5Wo0GXSAWUSbVqhikZaqk7IOGUiB5iW7
         A4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790245031; x=1790849831;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H6EUUW1m1zoaB7DVxqcfClkBe+yQHGLp6gBbcFMHwFk=;
        b=B4z0YYO1+ce8jn7UuM343tLnJO171D0ZWotEnHSPJCTPmdHvOQ2+b53VeW0eanWtAE
         Wo2cdjlcVd9vSYDQprWpxBpRPpXAq46eYnCK7el2z3VVp0DktjpUxzHAMndIHbaDcAlm
         2K+c7BKBgHa+6MUwX7iFNi4BqmtZJVlz0AHndFyGCt4dStA4MpJmKpLTmdzZCr0p1nog
         uRuwfKcmv7DmaryPQGPnlol3gE7x/ILjNmf3eyy1Q58G8v4x9K2vDRBJ+XSJ70IdE5IG
         sbOabmNyrn+RSOephm8bsrn2b6Z8WxqIcxpOWTeNutP2nEh+ihj0UtgKOnkfjLppatzZ
         ljtQ==
X-Forwarded-Encrypted: i=1; AKwUvBzOezSdgm6VUAYLC+AYXGoyTcN9g61X3GKg3PR79Pm6T2T5Tr1iwr+MvHxq+QLevReu91Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mVO8NWCLxJL58Kt3rwslSYe9XvR8XYw/mn4Zv3Q6IvWB1imKCw
	9tFqjCgjLMR99QRFKUQMDOX8avB5qggA8KohG9XaMAbOzIhcF+0uoPCi3dApiQch7a1B9IQ/Fuo
	BoxXsKqa2/1t16GChFVp9sSMqaQ1xDhHHZveeU7yvSST3ng5EoRv7VA==
X-Gm-Gg: AYBFou1NGwH9F22BBzQJ+fNpKil5iPZk+lX0xBdG9rZ2os6uhoC+7VHOQzMBZSvrTee
	8AzSv1TTFxKPM66Uq0Lf+mckFVtaWIiQg0CquCv5bs/IOuLcY+g2M9RDi/e2BXAUFB7XpmfGBCr
	R+f9GE55OBdkj+ikNltOpp52ZqAORop2bLnWv2DL+Xx5QnYwFyLnoLzDk4iPXpsbYK0QIM9p0h0
	qKik4nkAdz7zBYAuezZIrTqdmi0/NLkVH4jMI3/RORdTZoiF4v7aWks7/6kgr+oc5eUDbCceSYM
	TLJYnBTKukSLNlrrtaiaQIKckJPZL1205b3RZRSvG36GilcOdwxwHaSFhYZOFDxq5VS1NMv8T6b
	es4WBWeSzK00fC8jt0/Ma3dxvZH1gl2Dg29hUr5hsxJclZcys07Y=
X-Received: by 2002:a5d:5e93:0:b0:487:27f9:82a with SMTP id ffacd0b85a97d-488716f74b7mr3255255f8f.31.1790245031491;
        Thu, 24 Sep 2026 03:17:11 -0700 (PDT)
X-Received: by 2002:a5d:5e93:0:b0:487:27f9:82a with SMTP id ffacd0b85a97d-488716f74b7mr3255203f8f.31.1790245030920;
        Thu, 24 Sep 2026 03:17:10 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-131.retail.telecomitalia.it. [82.53.134.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488684863d9sm13714443f8f.12.2026.09.24.03.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:17:10 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:17:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Asias He <asias@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/5] vsock: Enforce no-transport invariant for
 TCP_LISTEN sockets
Message-ID: <arT3jXoS7OaU6Tsc@sgarzare-redhat>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-3-a1d9abb472f7@rbox.co>
 <aqp7CV9DnfsG1GJc@sgarzare-redhat>
 <0bc40e5c-8790-4a36-84bc-80e0bfe6b504@rbox.co>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0bc40e5c-8790-4a36-84bc-80e0bfe6b504@rbox.co>

On Tue, Sep 22, 2026 at 03:18:13PM +0200, Michal Luczaj wrote:
>On 9/16/26 14:30, Stefano Garzarella wrote:
>> On Tue, Sep 15, 2026 at 03:15:14PM +0200, Michal Luczaj wrote:
>>> A non-blocking connect() running in parallel with a blocking connect(),
>>> combined with a racy listen() that hits right after a connect timeout:
>>> TCP_SYN_SENT -> TCP_CLOSE -> TCP_LISTEN, while the connect() loop is still
>>> in progress.
>>>
>>> Enforce the invariant. Prevent a socket from becoming a listener after
>>> acquiring a transport.
>>
>> We should improve this comment; it's not entirely clear to me, TBH.
>
>The race I was thinking about:
>
>sk is CLOSE UNCONNECTED
>non-blocking connect():
>  sk := SYN_SENT CONNECTING
>  enqueue vsock_connect_timeout()
>                                   blocking connect():
>                                     release_sock()
>                                     schedule_timeout()
>vsock_connect_timeout():
>  sk := CLOSE UNCONNECTED
>listen():
>  sk := LISTEN UNCONNECTED
>                                     lock_sock()
>                                     sk is TCP_LISTEN UNCONNECTED
>
>It's not really critical (blocking connect() just timeouts), but I thought
>the invariant should be enforced once and for all.

I see, would it better to do this change in net-next?

>
>>> @@ -1973,13 +1973,13 @@ static int vsock_listen(struct socket *sock, int backlog)
>>> 		goto out;
>>> 	}
>>>
>>> -	if (sock->state != SS_UNCONNECTED) {
>>> +	vsk = vsock_sk(sk);
>>> +
>>> +	if (sock->state != SS_UNCONNECTED || vsk->transport) {
>>
>> Are we changing the behavior when an error occurs?
>>
>> If we call `connect()` on a socket (with no others running in parallel),
>> it fails, and then when we call `listen()`, it now fails, whereas before
>> it didn't. Can this happen? Is that what we want?
>
>Ah, true, I didn't consider that. So yeah, we'd changing the behaviour.
>
>> If so, we should mention it at least in the commit description; if not,
>> perhaps we should unassign the transport in the `connect` call.
>
>Do you mean immediately un-assign on every transition from SYN_SENT to
>CLOSE (failure, timeout, signal)? Then we could also drop the re-assign
>logic. I think that's a nice idea.

yeah, that!

>
>---
>
>I've addressed all your other comments for v2 and went through Ashiko's
>reports (side effects of lockless peer_shutdown write, imperfect
>no-transport TCP_LISTENER enforcement). I've decided to try the
>eager-unassign approach. I think/hope this way we sidestep the lockless
>writes and enforce the invariant without breaking the API, while fixing the
>bugs.
>
>This should probably be RFC, but I'm posting as v3[1] so netdev's LLM can
>have a go (too). Hope I'm not breaking any workflow. Let me know what you
>think.

I think you can add RFC also on a v3 patch, just to make it clear you 
are not sure it's ready to be merged.

That said, thanks for that :-) I'll take a look today or next week 
because I'm off tomorrow.

I'm just worried it's becoming too big for net. Anyway, I'll comment 
there.

Thanks,
Stefano

