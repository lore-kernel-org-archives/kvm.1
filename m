Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F42DC357
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 06:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776837961; cv=none; b=KH52iNkj4e3YQKIXJ+tE4G1H266fMAORaii5kzO5iAlq8Ui92WoLW5QTDHRQUMvwtpomCWEAmhnEBeTSB3VnITTkM88VL7i7QgQ5iwshzsIS7mx6Nz7Cb4Z7HNiXcyEo5LXvE2RVHn5zdeVSlcfFzQyLc0mOoP/n7mLUIsmlD54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776837961; c=relaxed/simple;
	bh=D0IhErlGrKKuMRwPOP4Tlt1GsqbT8xAI/tb1DvR/nwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpbxBHfN5bn0GZM3mQYjJ0Vi/Td8/0PJVNKEwx8/W4JlcIzJERDxSZRJuCWH9IqYQS7SEUGgAmRazotriVYoVJkuZiRbXg5AqNtxYF2jchTb7ck7iVhltynpy3KR82QMr4mZEgt0wt1WB2eMxfDIEjUmmN5JezIUIAOnTHUp3VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kfv5f0JH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hDqYmxVj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kfv5f0JH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDqYmxVj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776837959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ztMyE+ktT7jgxWkcpg5pXckPoWAOQRydQBsfKgsWIR8=;
	b=Kfv5f0JHpqpicGsTAaScc4FnO1qDnV/Qc6jlm8+NuYGhNC0RKJZGAPZOzwJNUc75kDcgO1
	9j/9zv2szVNTHBT0X9Us3478saG06peoqVi+tumso6gUhMYxoBJAMAMvXwS/E6UEyCai+2
	8VE9abcizCMjvzuAyG1Wm+wAubdzFbE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-R281mTHJNmOfzGwo2XmQJg-1; Wed, 22 Apr 2026 02:05:57 -0400
X-MC-Unique: R281mTHJNmOfzGwo2XmQJg-1
X-Mimecast-MFC-AGG-ID: R281mTHJNmOfzGwo2XmQJg_1776837956
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a5adc12ffso2017925e9.0
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776837956; x=1777442756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ztMyE+ktT7jgxWkcpg5pXckPoWAOQRydQBsfKgsWIR8=;
        b=hDqYmxVjaUFNP+JqjAK10rEDyUqPY+VznggUVQe3/btlF51uwQpYbTtb55kBTMTcls
         7ncjTixzlBivWxn4QY3xYORodFD6PN3rFZvNmVghZw6obWOH3h/ZYqP1lhSMTttDZKfb
         J68mkCBHDsd5mCC/o7EiuHZC1TLbErOfBPlmGuV7vqunH5DA+IIDle8okMSUrZSBvm93
         XW4JYjcYTa8hOll4OyAlooTBYbUFLdFVZ9ig3Olts6B1mUOyGUSCd55Z+7LiAdb0vd1d
         bV8dks6QJ5d1hSR85vUW2RqQFnUy84iwTfZiOe34Dfi2Ji6afHrh104HrtwF5eTZkDtn
         1rrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776837956; x=1777442756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztMyE+ktT7jgxWkcpg5pXckPoWAOQRydQBsfKgsWIR8=;
        b=Wfoox4+X6ywzj+7L4fvJKCdwUXtNppPYVW3zZwKJtQt7wbmeV47ZFlZMIzYyW6c/O7
         D+MIFMmgpJQ43ryYJtLSrSW50uWB4UJ5Xgm36adcd708ScnzWcjsgTmQ1NyiZHNhmplp
         72a4azGCDktttbG6b9LbEdTDwn/kT3tj4ofehXBufTKIAKKldvkHgyTqlixhFRBaPAUA
         Thw3IBr0S2NI0X4u55xS7vEcWGO00tCxacaKN0gXJUwUaIcSlXS1cCgNxZ8Ctrr93AiY
         bs/X2rNbLBwBnSiQDapyR9c8H+d3y1oNL7x76nR+tYGVqG1Cqtk7YHnkOeq6UaXXcevQ
         r6kw==
X-Forwarded-Encrypted: i=1; AFNElJ8hTGf3qe60KXStowYXuAouNucGAMCRGSy3nDy/eIAoblUJeMkdBkcTPNopqZwxw5VBT/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD7jtpvaWsr7xHc+mw2bjfOJiukSloc+8BPcGPUkKVpdau38b/
	rhMOD5DXl/GHS0/bQJqKTUqG8vLfus0w7XGuwNuQ53pvf1WgEWvZH3CrGU7GCjGVOgzOe/WUjqg
	Z1Kkk5mmFFjYDe0gwidwzPgtrhdxwidIo+wd9qyh0utrMQQmZ6MnVmQ==
X-Gm-Gg: AeBDievGeObGx6sQxD2bza02HV8Z8yrPHedyRZwK3r3xcHFb5z7UZn3rShTb7G1QxzS
	HpBOh6MIy2cfVgkTopuPSBuxVFtpusjp8DxItUMQwQfh37bmVB056DcPJmWyzekX2NQWhCxZl6P
	t6BLRaai0DNxeF7H9KMpUp95ch+0DducWKzeZEkC7yxo7pw24AYejKwnKak4xllMnML+0gYjlfp
	HRYxi2DYXSs9wkS4z6A5qT6U6YTJSUJk7YtjhzMzH2MFLTFEUL2VZLNOYBUgHsYfotmPn4JXMXK
	Wez+H2/f+NscGODxc7w2zCVVkyeEJ9N4TePxHJkmRNmo/9p1PjZb101piE1NEpvmCbyH2cAK7ji
	92eNR/+yjRiZyPTULv7g7bp/iqcszBx3nfL+1snxLuOI2JI8rB5WBQg==
X-Received: by 2002:a05:600c:470d:b0:48a:52ce:a4b1 with SMTP id 5b1f17b1804b1-48a52cea6d8mr117687655e9.15.1776837955982;
        Tue, 21 Apr 2026 23:05:55 -0700 (PDT)
X-Received: by 2002:a05:600c:470d:b0:48a:52ce:a4b1 with SMTP id 5b1f17b1804b1-48a52cea6d8mr117687235e9.15.1776837955527;
        Tue, 21 Apr 2026 23:05:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc177dafsm520792265e9.4.2026.04.21.23.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 23:05:54 -0700 (PDT)
Date: Wed, 22 Apr 2026 02:05:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kohei Enju <kohei@enjuk.jp>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com
Subject: Re: [PATCH net v1] vhost_net: fix sleeping with preempt-disabled in
 vhost_net_busy_poll()
Message-ID: <20260422020539-mutt-send-email-mst@kernel.org>
References: <20260422023026.81960-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422023026.81960-1-kohei@enjuk.jp>

On Wed, Apr 22, 2026 at 02:30:24AM +0000, Kohei Enju wrote:
> syzbot reported "sleeping function called from invalid context" in
> vhost_net_busy_poll().
> 
> Commit 030881372460 ("vhost_net: basic polling support") introduced a
> busy-poll loop and preempt_{disable,enable}() around it, where each
> iteration calls a sleepable function inside the loop.
> 
> The purpose of disabling preemption was to keep local_clock()-based
> timeout accounting on a single CPU, rather than as a requirement of
> busy-poll itself:
> 
> https://lore.kernel.org/netdev/1448435489-5949-4-git-send-email-jasowang@redhat.com/T/#u
> 
>   Changes from RFC V1:
>   ...
>   - Disable preemption during busy looping to make sure local_clock()
>     was correctly used.
> 
> >From this perspective, migrate_disable() is sufficient here, so replace
> preempt_disable() with migrate_disable(), avoiding sleepable accesses
> from a preempt-disabled context.
> 
> Fixes: 030881372460 ("vhost_net: basic polling support")
> Tested-by: syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com
> Reported-by: syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69e6a414.050a0220.24bfd3.002d.GAE@google.com/T/
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vhost/net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 80965181920c..c6536cad9c4f 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -560,7 +560,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
>  	busyloop_timeout = poll_rx ? rvq->busyloop_timeout:
>  				     tvq->busyloop_timeout;
>  
> -	preempt_disable();
> +	migrate_disable();
>  	endtime = busy_clock() + busyloop_timeout;
>  
>  	while (vhost_can_busy_poll(endtime)) {
> @@ -577,7 +577,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
>  		cpu_relax();
>  	}
>  
> -	preempt_enable();
> +	migrate_enable();
>  
>  	if (poll_rx || sock_has_rx_data(sock))
>  		vhost_net_busy_poll_try_queue(net, vq);
> -- 
> 2.51.0

