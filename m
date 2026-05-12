Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C9A388876
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600399; cv=none; b=Ns+4qKaqE00tZ3rXaDKztUF2mRVnlghlkoEhn6Jk1qL6Ne1HaOmXLrJ3M8mDgpUM7SJWhBBUYmmxWcu3hRf8jW5bqcy2l+P9CdjTTRLIakJ99vTwVHvjEvHL8pGEg3DaqedcmuolYU6ynPf2fLP5GugRUPN+cKdWVy489gCVbuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600399; c=relaxed/simple;
	bh=KglCHTuNm3x37ez9MagfZauxo69r9aH1IwV/+zMyGZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MH1LTcxA876Y+AZ4XkDzCQOXLp1fNvLpLTXTMtdY6piYq3zLkTeQPpstbebkVgM8kyW3kKqmVzjFCUhDVKryLnEVkT+EKS4+duALuwyyvGeOxKflA0HWpDRNqRYDX/8B15T6jSdL0oBwcs6D/+R8JM/ungq6U0lwO4lj7GbkpqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HaGFRURu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gx8LZy0A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaGFRURu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gx8LZy0A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778600397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LsdZjZ26kSZ8u0NFCo8P+xxqj1x4mfPz9ccyxXizpko=;
	b=HaGFRURu15nLJFMO1lYQHNUQuPLLZ7nPjaZoWohAFsSGxvbKUlOItQq5zHdY/JhxRtzDRr
	0XudZvAwjMjKjGZQqPCRSTB/DdPH3QYrndxswdT8IE37pyZk3yPpIbHLtI2wr5ljNHzNYQ
	jbcV537sr04hsZKgimRsvnOxaIXa8s8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-i9oxRNUXO-KoDRml6a-gCg-1; Tue, 12 May 2026 11:39:55 -0400
X-MC-Unique: i9oxRNUXO-KoDRml6a-gCg-1
X-Mimecast-MFC-AGG-ID: i9oxRNUXO-KoDRml6a-gCg_1778600394
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48d0677b5f7so32151925e9.1
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778600394; x=1779205194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LsdZjZ26kSZ8u0NFCo8P+xxqj1x4mfPz9ccyxXizpko=;
        b=gx8LZy0AQWXtWli29riSYzatxdUFLb69mWrRWWMVgiUbVeMBTMo67jQDV+8wadk0nQ
         G1EA9RLBmI39XYxQ6ltucZ9QyE9/Lh12WqDWqx0bqNvho7C0wVlUuD0djBgXvRywJZQ1
         VbKVqR+Gl0+Ow8bXEIdKwNrIOLajygTg+r6qNGblYv12YG/KPXNnRHHmfRgT5jPel8AI
         brX9n/sElEaD5n//TVqz2bAxdFUZNfIUM6lRgUa8F7uV3jbYlN00nLIj7KtVgZJuAKCK
         Anm0cj0UuSEIyPNqzb9EMbWiUKMS12qiDRnX+l7p4dvXnSUF80BgFBiXlrhUwxmC7tQz
         e3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778600394; x=1779205194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsdZjZ26kSZ8u0NFCo8P+xxqj1x4mfPz9ccyxXizpko=;
        b=cGI0wWxOKxczjcdJlEUJT+nQGTkvmuJZkAw5GYmkXnvhF6arEdhlwagjLjbh7QqyjW
         EwR6rVt4sT98hcGk05fhS1YeWOczFJJAB9tnXwVRbr4YsmAWQmj6MnjAbMPTWvNo5/XG
         bYMnMedI4zzPJKGl4BfL8lRW7+QwoY43bKWMuUESR5ogCiMK4ow5A+eHSYbaTmfr4BEg
         pvM1RVU4M60o8BopIhoU0Yq2fTfUYZ+/6urk0/pLSbzBAUhH7asBBczyawwLeYbCmCli
         kHqvGkLj77+ca7MAzB9Eeg2HSiUI8LykdnpZnkiBstUyDkWzd4lP8ynetoO2zU1s8wAQ
         8/bg==
X-Forwarded-Encrypted: i=1; AFNElJ9o6YvWKUNrvUZki88bSUIAeGv8VUDBuQXkbTuVzHDrKsEjD5eOMsrVuZtPXk1pHJxOmFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFOV4PYeWoPZdKfhiOpmFY9qm+PzRGGm3TOmXp2bxj5hkW4Tt7
	Lj7kka0HjJ6sr5KaczPsxjwHGrB7dlxGTH4Ikri6a9hh7ZEJrpku+YZbbSBqUigv7E5iZuIuBRe
	hxdBBFv0U8KhUDPyM/B8yIeruKspLR5F5SolmMzSrPRE+sZQgrvIy7g==
X-Gm-Gg: Acq92OHwi11cdZDTKFPrqn4l0QzN0hKw0mGKUwDV3GE/F1Ye9sjL33uOVYmmmPzCbHH
	grllMNk04XW1o6SUv7oXLsWbudNCjKBfSDMnrb3tgKaCX0LQzGkdeOqYwOLCWa1UsUkf6EVSyX1
	xKI0/kzZbFzryHmukA7DAStLnqZg+mLfHK1degvifBMaHmGCKd/2y/vJZDNg7g7Qa9STX4orBsU
	sMX17TPfyGmzSijeV8a5ME5t8I/Uys50PzN2Jo9XEBpRwIKBn2ao16xfGzSzcY0Vx0bzk/8mZPb
	KKiW8gI/VkRn2MjztXa4jYodeuoiOrHkLxXAvLstD3+eXZU09jCtXu6aW4eSPiCACVoDoROmYer
	dvWrkUkY944F6z2ntWURTL+61F9p1tcbSyW49Xd6n1WgXkCLzWbcv26zENu5H7kDZLVsVzB2pqg
	==
X-Received: by 2002:a05:600c:621a:b0:48d:35e:849d with SMTP id 5b1f17b1804b1-48e8fe4dca6mr55140335e9.6.1778600394435;
        Tue, 12 May 2026 08:39:54 -0700 (PDT)
X-Received: by 2002:a05:600c:621a:b0:48d:35e:849d with SMTP id 5b1f17b1804b1-48e8fe4dca6mr55139695e9.6.1778600393794;
        Tue, 12 May 2026 08:39:53 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f41a8b1sm31709705e9.7.2026.05.12.08.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 08:39:53 -0700 (PDT)
Date: Tue, 12 May 2026 17:39:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Polina Vishneva <polina.vishneva@virtuozzo.com>
Cc: "den@openvz.org" <den@openvz.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "stefanha@redhat.com" <stefanha@redhat.com>, 
	"eperezma@redhat.com" <eperezma@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH] vhost/vsock: Refuse the connection immediately when
 guest isn't ready
Message-ID: <agM8cxqUCJNjBDlm@sgarzare-redhat>
References: <20260511145610.413210-1-polina.vishneva@virtuozzo.com>
 <agH3WvJtAsQ_5zx4@sgarzare-redhat>
 <962b26d2d1daa9411fb71efab6af2c75d1c5f0d0.camel@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <962b26d2d1daa9411fb71efab6af2c75d1c5f0d0.camel@virtuozzo.com>

On Tue, May 12, 2026 at 02:32:14PM +0000, Polina Vishneva wrote:
>On Mon, 2026-05-11 at 17:56 +0200, Stefano Garzarella wrote:
>> On Mon, May 11, 2026 at 04:56:10PM +0200, Polina Vishneva wrote:
>> > From: "Denis V. Lunev" <den@openvz.org>
>> >
>> > When the host initiates an AF_VSOCK connect() to a guest that has not
>> > yet loaded the virtio-vsock transport (i.e. still booting), the caller
>> > blocks for VSOCK_DEFAULT_CONNECT_TIMEOUT (2 seconds), because
>> > vhost_transport_do_send_pkt() silently exits when
>> > vhost_vq_get_backend(vq) returns NULL.
>>
>> Can SO_VM_SOCKETS_CONNECT_TIMEOUT helps on this?
>
>It can, but it might be difficult to find a correct timeout.
>
>And, generally, there's no way to distinguish "the guest hasn't yet initialized
>the vq" from "the guest is up and running, but didn't reply to connect() in
>time". That's exactly what this patch is attempting to fix.

Okay, so please mention this in the commit message, I mean why 
SO_VM_SOCKETS_CONNECT_TIMEOUT can't really help.

>
>>
>> >
>> > If the guest doesn't start listening within this timeout, connect()
>> > returns ETIMEDOUT.
>> >
>> > This delay is usually pointless and it doesn't well align with our

I still don't understand why this is pointless. If an application wants 
to wait while sleeping, it can simply increase the timeout long enough 
to wait for the VM to start up and use a single `connect()` call, 
instead of continuing to try and wasting CPU cycles unnecessarily.

Hmm, or maybe not, because the driver will definitely be initialized 
before the application that wants to listen on that port, so it will 
respond that no one is listening, and the `connect()` call will fail 
with an `ECONNRESET` error in any case. Right?

If it is the case, is the following line in the commit description 
correct?

     If the guest doesn't start listening within this timeout, connect()
     returns ETIMEDOUT.

I mean, also if the application starts to listen within the timeout, I 
think the connect() will fail in any case as I pointed out above (this 
should be another point in favour of this change)


BTW, I think we should explain this more clearly both here and briefly 
in the code as well.

>> > behavior at other initialization stages: for example, if a connection is
>> > attempted when the guest driver is already loaded, but when nothing is
>> > listening yet, it returns ECONNRESET immediately without any wait.
>> >
>> > Fix this by checking the RX virtqueue backend in
>> > vhost_transport_send_pkt() before queuing. If the backend is NULL,
>> > return -ECONNREFUSED immediately.
>> >
>> > Signed-off-by: Denis V. Lunev <den@openvz.org>
>> > Co-developed-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
>> > Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
>> > ---
>> > drivers/vhost/vsock.c | 10 ++++++++++
>> > 1 file changed, 10 insertions(+)
>> >
>> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> > index 1d8ec6bed53e..a3f218292c3a 100644
>> > --- a/drivers/vhost/vsock.c
>> > +++ b/drivers/vhost/vsock.c
>> > @@ -302,6 +302,16 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
>> > 		return -ENODEV;
>> > 	}
>> >
>> > +	/* Fast-fail if the guest hasn't enabled the RX vq yet. Reading
>> > +	 * private_data without vq->mutex is deliberate: even if the backend becomes
>> > +	 * NULL right after that check, do_send_pkt() checks it under the mutex.
>> > +	 */
>> > +	if (!data_race(READ_ONCE(vsock->vqs[VSOCK_VQ_RX].private_data)))
>>
>> Why not using vhost_vq_get_backend() ?
>
>Because it locks the mutex, which is slow and unacceptable in this hot 
>path.

ehm, sorry, which mutex are you talking about?

I see just a comment about the mutex to be acquired by the caller, but I 
don't see any lock there.

>
>>
>> Also is READ_ONCE() okay without WRITE_ONCE() where it is set ?
>
>It's racy, but as described here in the comment and in the commit message,
>any possible race outcome is covered by the subsequent checks.

Okay, so what is the point to call READ_ONCE()?

>
>> > {
>> > +		rcu_read_unlock();
>> > +		kfree_skb(skb);
>> > +		return -ECONNREFUSED;
>>
>> This is a generic send_pkt, is it okay to return ECONNREFUSED in any
>> case?
>
>EHOSTUNREACH would probably be better.
>All the current send_pkt functions only return ENODEV, but it has different
>semantics: they mean that the local device isn't yet ready, while there we're
>dealing with the opposite end not being ready.

In the AF_VSOCK prespective, I see ENODEV like the transport is not 
ready, so I think it can eventually fit here too, but also EHOSTUNREACH 
is fine, for sure better than ECONNREFUSED.

Thanks,
Stefano

>
>Best regards, Polina.
>
>>
>> Thanks,
>> Stefano
>>
>> > +	}
>> > +
>> > 	if (virtio_vsock_skb_reply(skb))
>> > 		atomic_inc(&vsock->queued_replies);
>> >
>> >
>> > base-commit: 8ab992f815d6736b5c7a6f5fd7bfe7bc106bb3dc
>> > --
>> > 2.53.0
>> >

