Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D207736C5A1
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619990; cv=none; b=itG9kV9pidKJowi9niMEmrZIG5HNF6g6Wha7XfyQ/5wusbDoH+lC9C+4D8UpVRjNSMDRYF6EX/qu/UXxXltUB/M0I18A/jGBB3LSD/rcwpH+PAA/5xa1w/EOwAJ1Ta5oJ8r4oKjo0KdNNI6yhgI0+qPZeVPXKkIAGL/7MmM0SQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619990; c=relaxed/simple;
	bh=2FtnmkA6sYVjNf1cUAA6sjpblaIDR9OLH/SC1eJdstY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKm47nS0TTsYpgq2f3CJGrDxRKhGac3Maw4CJVxHJLhhCmJdcOR2KVQl9kakIK2ExJMog5vWMqq+Ir4G+/ppUWoVvtRb6cLv+HUZsNlXPkBmLwD9mV4Jip22UB9KYwsfq5xSAAabY0te42XKRIATBYp26+MmvaamDUbxyycEh6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFPLgVWZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNzC7M3Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFPLgVWZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNzC7M3Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781619987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dhl41uHQlhSDcthFJy4ATeZ9aIkqmiVNQn4jmxc+ZZI=;
	b=WFPLgVWZaM5XshKGqaS3O479q/pcyeydlSO2TxXHDyEkhlqLkgTTqw5gHrzx6ZjkrFm445
	lIyFz9CulitOLjzDRiI+o/YJZ+JdZVYJR0Z+VN7G8nz0alG209OJ0L32PYfnuJjPNpXC+5
	NwM5GLIA1GBvBmLW5D7lME6RXuzBuRE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-IwJT2k5TMoi7GaXUdgHpxA-1; Tue, 16 Jun 2026 10:26:25 -0400
X-MC-Unique: IwJT2k5TMoi7GaXUdgHpxA-1
X-Mimecast-MFC-AGG-ID: IwJT2k5TMoi7GaXUdgHpxA_1781619984
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-461a15b1062so577815f8f.2
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781619984; x=1782224784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dhl41uHQlhSDcthFJy4ATeZ9aIkqmiVNQn4jmxc+ZZI=;
        b=FNzC7M3ZEcquH5Fh+MJ5LvOIRbOh4dE3tSW9dISD1vwewkWZt9rSFtYsNCw3n1UINw
         hXnNtzHZhVyuHadmDI6zlIXL0gnPUVmissZE7eaBI4SUbmc6jnga68VkZBt8PaTlKEVE
         oZJ9FIjSos+WB3hOg2FjQ9DS2GqbfshrhBQCVcurjxSnywmoa0OUtAKVTHl/UgCxfnIb
         JYIA4MZCkj+5O3edgfJ7L9xc3wkE5Btg3gGwJOCJRbUwcY4NNcCg785mTz2ItJRd5tb9
         Nq1V4Hx2/zjMZXzwdiQQksnVWmOISsgL1sRuOk3JxwTCGm8hb0WO1HIG2srJmr9GoSev
         MiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781619984; x=1782224784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dhl41uHQlhSDcthFJy4ATeZ9aIkqmiVNQn4jmxc+ZZI=;
        b=Op4ENlRhc4Orbwh36dfbSWKSLVIT8TffYWCnuiVgm0jc7llFeYz9vidyd3ZZAJhIz3
         bbmQyiAxH1OXLyBUp6ACmnoqVQDHyg52JhVIGlwXeS6pT2DKeRmBD0CHtTKxeIQDQjpY
         bMWhc8FLKh8xl6URG4TIKy+cnxpVJnUSL1e7BuYQSGOsKvGh8PX6jcS0wUzyIGf2BtLa
         KWSTRlqzQdfXrG9wwF1JlvA9Q2lE9qNjdShFaAxSCm9+70pUqTPN6MjOn3Spa7W0fdEN
         B2r2bpTvc5W5jdRplCBaQKfeH7WQtQJxH5Z22837ai2CEtU17aA8MZmiJ+2UhWGgKFfb
         L47w==
X-Forwarded-Encrypted: i=1; AFNElJ8XD5FnMTLDn8II9RVzIuoRrb8a2gZRkI2WcmEcfNjmmTx55XBWT/Kfif+0fsLIMox168w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbgqM4MhaXBdD4/gMFo5osaFgp83tGhvA65BLu65lNQl2cAKAF
	taZxuzSpDRPBUI6FTnizzeF2REcMvWVZzVjyvFIFvi9zmHw+2YegmjXpPj/DMVgfzIHpZ3msUxM
	q684JCY9tL8R9YEgfK/cLPTeQXt0/P7e6qDH3eGZWgSOTDGVf52EdUA==
X-Gm-Gg: Acq92OG67IBnnOm0Mv4lbDjzTEaNcWMoXuczNccINm4Zu6uDJiLygRgsUIWC7Q8gGGL
	8y6+VqSw4hcwInUmlmrOhJLh/mhAjw/Uu7qDbnHG3d35gxolIMSvPbb/QN8QIohNzVIEL5efzcz
	OlpIoQ+F76UKMAlzkQ1kEe6zIDKQIZwMir+fYJ+wKzKZ7P3gdgBbMP8RMYXTM8gNwoCtDLisR9S
	JkWPl38inSQdEoSzFyPyRDm3P4NpbIf6W0SV1AQW2Yzjbn7GaLA6G0eR3+oK/ZA2xKCXm05m6l7
	BSQU2ngA/YayPOHAaOgp4ZQqxgBTaWDyR00k2v3UYo/wqHRZEsFjCHXhf6OLeGflk6vdFezagbz
	7e/WeLOOVt2yX7hk6Lf2aI3MYCCdQ+gS1dBHP7e8kcgGM8xSbTr9RuhSy9ll9og+lTEFa8+s=
X-Received: by 2002:a05:6000:1ac9:b0:45e:eaed:afd2 with SMTP id ffacd0b85a97d-4619f33afc1mr6376232f8f.0.1781619984259;
        Tue, 16 Jun 2026 07:26:24 -0700 (PDT)
X-Received: by 2002:a05:6000:1ac9:b0:45e:eaed:afd2 with SMTP id ffacd0b85a97d-4619f33afc1mr6375916f8f.0.1781619981390;
        Tue, 16 Jun 2026 07:26:21 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c5266sm51566784f8f.29.2026.06.16.07.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:26:20 -0700 (PDT)
Date: Tue, 16 Jun 2026 16:26:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 2/4] vhost/vsock: add VHOST_RESET_OWNER ioctl
Message-ID: <ajFcf00nmUcfqofx@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <20260612165718.433546-3-andrey.drobyshev@virtuozzo.com>
 <ajFRRmA9req1muX6@sgarzare-redhat>
 <129f5833-3a7f-4b2d-a965-20903e4e2fb5@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <129f5833-3a7f-4b2d-a965-20903e4e2fb5@virtuozzo.com>

On Tue, Jun 16, 2026 at 05:10:38PM +0300, Andrey Drobyshev wrote:
>On 6/16/26 4:48 PM, Stefano Garzarella wrote:
>> On Fri, Jun 12, 2026 at 07:57:16PM +0300, Andrey Drobyshev wrote:
>>> From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>>>
>>> This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
>>> the guest with vhost-vsock device.  For this to work, we need to reset
>>> the device ownership on the source side by calling RESET_OWNER, and then
>>> claim it on the dest side by calling SET_OWNER.  We expect not to lose any
>>> AF_VSOCK connection while this happens.
>>>
>>> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>>> ---
>>> drivers/vhost/vsock.c | 28 ++++++++++++++++++++++++++++
>>> 1 file changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>>> index b12221ce6faf..e629886e5cf8 100644
>>> --- a/drivers/vhost/vsock.c
>>> +++ b/drivers/vhost/vsock.c
>>> @@ -894,6 +894,32 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>>> 	return -EFAULT;
>>> }
>>>
>>> +static int vhost_vsock_reset_owner(struct vhost_vsock *vsock)
>>> +{
>>> +	struct vhost_iotlb *umem;
>>> +	long err;
>>> +
>>> +	mutex_lock(&vsock->dev.mutex);
>>> +	err = vhost_dev_check_owner(&vsock->dev);
>>> +	if (err)
>>> +		goto done;
>>> +	umem = vhost_dev_reset_owner_prepare();
>>> +	if (!umem) {
>>> +		err = -ENOMEM;
>>> +		goto done;
>>> +	}
>>> +	/* Follows vhost_vsock_dev_release closely except for guest_cid drop */
>>> +	vsock_for_each_connected_socket(&vhost_transport.transport,
>>> +					vhost_vsock_reset_orphans);
>>
>> In vhost_vsock_reset_orphans() we have:
>>
>> 	rcu_read_lock();
>>
>> 	/* If the peer is still valid, no need to reset connection */
>> 	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk))) {
>> 		rcu_read_unlock();
>> 		return;
>> 	}
>>
>> IIUC we are not removing the guest cid from the hash table, so this
>> check will be always true, and nothing is done.
>>
>> So, is this call really useful?
>>
>
>You're right, and it's most probably an artifact from mimicking the
>vhost_vsock_dev_release() implementation, as mentioned in the comment.
>In our case this whole iteration is a no-op, we better remove it.
>
>BTW earlier I received some feedback from Sashiko AI reviewer, which
>also spotted that same issue (and some more interesting races):
>
>https://sashiko.dev/#/patchset/20260612165718.433546-1-andrey.drobyshev@virtuozzo.com

Oh they seems similar to claude comments I included in my comment on 
patch 3.

Yeah, we should takes a look, they seems real issues.

>
>Apparently it only CC's its reviews to kvm@vger.kernel.org so you can't
>see them right away.  Just wanted to let you know to save your time
>here.  I'll send a v2 with respect to Sashiko remarks.  But of course
>would be great if you spot some more issues here.
>

Thanks for pointing that out, but in general I try to do my reviews 
before looking at AI reviews (both sashiko or claude locally) to avoid 
to be too much biased.

Thanks,
Stefano

