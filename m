Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B51C388393
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825448; cv=none; b=FI6Oja9h/PRbEsnsJEX7K5DXr4wsXyviPALl/m319FMKRY80y0dFsuzaWBTcZCCf94uPTKq90wJZrZVeL1wJVsaXWnxTvI/RF3qSxiftiB3tH4PQ6/1zouLQGJGzU1y4dmS5Vm1DLRnyMBb/u24PBQMY4/Cl1yCtgaRk50elu0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825448; c=relaxed/simple;
	bh=HVzEoDIUOtKuu1wfn87SZ/HEqRdQyUU7D8rY8b4wr/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LH07A2MTwFeD/Ey2GmpSv3716T0pv9nIaV5BvJEHV7a9WXTq1MQ0C0v8hWQrYBMqYhJa7EBwHeF4mXyB8JnNWNPschAVBBcNy5Cmgyi1lqxnx78X64Z++sWE/oNcqtVuMKz72SlFTnsBzZVoWxNw18oUieZ9P5up1cN8RmZ8ZtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjSfeZ6p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmlQH47i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjSfeZ6p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmlQH47i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784825446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=skv50H0aRdZe1+yzOYqLWkWcMMVGnxgMC07zr3GCyxM=;
	b=TjSfeZ6pu5R8DPjQuuTY4xDpXprvKssADW8j7hARr9DqlmkCzOHyBZ55ey0Axw2CicRtGP
	XW9+Z8D6ofDT6Wv+2wuUjdHo1gad7BUUtqI85ngb6eGT+nghtrP7JwPjaoLTZ0L4EhFz11
	OPf31VtPVILbv9cAt40a615RnshLfh0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-3keJVfTANLOfLhRePfJwJg-1; Thu, 23 Jul 2026 12:50:45 -0400
X-MC-Unique: 3keJVfTANLOfLhRePfJwJg-1
X-Mimecast-MFC-AGG-ID: 3keJVfTANLOfLhRePfJwJg_1784825444
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a767b782so7191355e9.2
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 09:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784825444; x=1785430244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=skv50H0aRdZe1+yzOYqLWkWcMMVGnxgMC07zr3GCyxM=;
        b=PmlQH47iXzx8Dp+yvaKQPhyPR03ooN4skoNw+INVlu+jl7dP3mSWuzh+ZUyLMDqYJh
         3WP2xFjDptuTn0Z0WctOYFtaZZvpw8iJwV8VUDDdRDMc+8W6hl0zYgGqEejQNzmsQrld
         xw+ru70kgD9/iuzhCWGBfrmh4QxRv5icMomCc3rQh6kg1XmzLBpGUe8HtziHOXp1ozuW
         sNU2bKf7VWN+CtEb8NkFCgxHTVI9ti2jb6LGYpZTOEe1o25+cl/TNE2RSBMfxQyijasf
         vb96pNuBH0RfYeOrs5b2e2KfIZHr/2GHvgIZrbC7J6wHa39Cw2uW/yICfGlBVgvY2Wqa
         vYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784825444; x=1785430244;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=skv50H0aRdZe1+yzOYqLWkWcMMVGnxgMC07zr3GCyxM=;
        b=O+P6+F0fDVKo5ySyTIf7fGOCNGPwWSijGYQsoU45N1UIGNA7ZuXcez7cTXMDv0+Zq8
         lnQrKZsi4V6qukubVhvB1qyA7HrWvms+gqqzlCpZyJQ7r9lUfMO0/13HV4xdpzJmL4OI
         l0Ks0dxB4hWnrf9D6rXuLvDmNKNeyoDp540gHJUc7BsNOniV6IGUWi7zRSq9zXgY3HL9
         W/TOR/cLiZjHyTDobOsWajjfENVUkmKrxvIkxpiExAoh+3fZINIRmMCNGRb0+PAO8E5Z
         RNsTl2e3r9VcPVSVXXl75WysExj22lR9jlgAHfx7u+iw+fwF6oNC6qvldvsrHb49vG7V
         OcPw==
X-Forwarded-Encrypted: i=1; AHgh+Ro/JrvCLjT/m1CJrOq4LIjjHzjjjjcREsibuIdZ4M1EG3WD6lZk/9fylyL9wKpDAUfv3Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5x1N9DypyXK/hiweRIy62/m+Q3cdGnELHZcNqSTn8MoaFx2F8
	vgiYuA9GVK9Mlsbvcd2phAyeNJe7xunmZcAYZd1vVznVKyegZZDKibDPS5tHbZPFeqjWe1jv2oZ
	HwHPgxrAUlm/s/Er0GJywM/J6nu03ByBBGxdjanyrhgmhUNBNPl0uvg==
X-Gm-Gg: AR+sD11dOILZB3ktD9CIcV4muKferNAIP33B7MCXwj34wseO83tzyKe0zbjTJrshS4g
	7Zv4azNQ1hDKZEc2QQFAvTEgv+gqJHXc0mg3VTgQ/S7N5MCaLV6nSzGx+JPsMtuTttaqfWTz2Lw
	gUpKozQbc3Wz0Vc5ymLQOniRBEOYj3Xd5pPOTFDePbF5AOLsbX8x5El0i6NgkJBYOjOgqjdAboN
	gD354pb62rq1VXy3jEZ6QdM6CH7e3c+USKZNYtmg7t28RRQUTO6tO/QnJ2wO8c/B14hKEw9Mfu4
	58XbpmRvgeufSyQHcCHiZeQ1HCW15SnzSbf8gNj0j70UYgsHVWGiNmrp6oLPgfyppgEPKuz4x+m
	vSdoiB2HqJSgKMANfvfBIAA==
X-Received: by 2002:a05:600c:350a:b0:495:441a:39d2 with SMTP id 5b1f17b1804b1-49573cd8932mr43271905e9.21.1784825443872;
        Thu, 23 Jul 2026 09:50:43 -0700 (PDT)
X-Received: by 2002:a05:600c:350a:b0:495:441a:39d2 with SMTP id 5b1f17b1804b1-49573cd8932mr43270805e9.21.1784825442214;
        Thu, 23 Jul 2026 09:50:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957af5d910sm6009915e9.3.2026.07.23.09.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:50:41 -0700 (PDT)
Date: Thu, 23 Jul 2026 12:50:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	sgarzare@redhat.com, stefanha@redhat.com, dongli.zhang@oracle.com,
	maciej.szmigiero@oracle.com, bchaney@akamai.com,
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <20260723124908-mutt-send-email-mst@kernel.org>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
 <20260723111557-mutt-send-email-mst@kernel.org>
 <0c7172c4-0dc4-4d7e-9310-4f045e27efb9@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c7172c4-0dc4-4d7e-9310-4f045e27efb9@virtuozzo.com>

On Thu, Jul 23, 2026 at 07:46:58PM +0300, Andrey Drobyshev wrote:
> On 7/23/26 6:18 PM, Michael S. Tsirkin wrote:
> > On Mon, Jul 20, 2026 at 01:22:40PM +0300, Andrey Drobyshev wrote:
> >> vhost_vq_work_queue() only holds the RCU read lock while it dereferences
> >> vq->worker and queues work on it.  vhost_workers_free() however clears
> >> the vq->worker pointers and immediately frees the workers, without
> >> waiting for a grace period.  A caller that fetched the worker right
> >> before the pointer was cleared can therefore still be queueing work on
> >> it while it is freed.  And even when the queueing itself wins the race,
> >> the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
> >> future attempts to queue it are silently skipped.
> >>
> >> None of the current callers can actually hit this: net and scsi stop
> >> their virtqueues before the workers are freed, and vsock unhashes the
> >> device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
> >> before the workers go away.  But the upcoming VHOST_RESET_OWNER support
> >> in vhost-vsock keeps the device hashed while its workers are freed, so
> >> the lockless send/cancel paths become able to race with the teardown.
> >>
> >> Fix this by clearing the vq->worker pointers, waiting for a grace
> >> period, and then flushing the workers so any work the last readers
> >> queued runs before the workers are freed.
> > 
> > 
> > 
> > 
> >> Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
> >> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> >> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> >> ---
> >>  drivers/vhost/vhost.c | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >> index 4c525b3e16ea..d6e235c25254 100644
> >> --- a/drivers/vhost/vhost.c
> >> +++ b/drivers/vhost/vhost.c
> >> @@ -729,6 +729,17 @@ static void vhost_workers_free(struct vhost_dev *dev)
> >>  
> >>  	for (i = 0; i < dev->nvqs; i++)
> >>  		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
> >> +
> >> +	/*
> >> +	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
> >> +	 * reader that fetched a worker before we cleared the pointers above
> >> +	 * may still be queueing work on it.  Wait for those readers to
> >> +	 * finish, then flush so any work they queued runs (clearing
> >> +	 * VHOST_WORK_QUEUED) before the workers are freed.
> >> +	 */
> >> +	synchronize_rcu();
> > 
> > 
> > 
> > Any way not to add this for all devices that don't need it?
> > Or preferably, even for vsock in absense of the new ioctl?
> >
> 
> This code was initially local to vsock, and was moved here in v3->v4
> after we discussed with Stefano that the issue looks more generic and
> should probably be fixed in vhost.c (see
> https://lore.kernel.org/virtualization/akO6tps94iFxCAWv@sgarzare-redhat).
> 
> As a compromise, we can keep this code here, but only call it
> conditionally.  Namely, create a bool flag on 'struct vhost_dev' which
> is always false, only set it to true on RESET_OWNER, and only call this
> code once it's set.  Clumsy, but this way no other code path would have
> to wait the full grace period.
> 
> What are your thoughts on that?
> 
> Thanks,
> Andrey

Or just thread a bool parameter to it?

> > 
> >> +	vhost_dev_flush(dev);
> >> +
> >>  	/*
> >>  	 * Free the default worker we created and cleanup workers userspace
> >>  	 * created but couldn't clean up (it forgot or crashed).
> >> -- 
> >> 2.47.1
> > 

