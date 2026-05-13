Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1CF38C2D1
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666596; cv=none; b=jLymt2r0I86dhykrPWteCQWKeRirUcVy8/qdKHm/WJs8/AUd9xp1oknFdLODFN8r8V1MUfC+RhpJA9rWlOU+ykjY1idPvSTLISnRlWvMZFqPZFaXtaaA/gNebNrJ9jVrwqwW+oqvTURs1sBwivXsS+qKNPSaF0s4DRhn2nnuwNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666596; c=relaxed/simple;
	bh=Exx69UliEats+vm276UOMHgD4bfAdRTp7+mcrKpptDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAGGI2XOlbkIJgmTv8NHAUwQH342yGf7VwIioUKOPGeuablog00A+vJgmKa3j28cLeFtaLprquuB5GYh2v9TO+4Rtg6tOSUb97qB/RtnXahf1Lg5FKJqdj79IXmnMtVrqhW9JHxPi3gbLrBG/bkP/L663kzaSpEYgQnH79vgnJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fHxcSLtM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLhqRy8y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHxcSLtM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLhqRy8y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778666593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xzQE32mx93ylvQsX4/nZCp5JUmWcvqaEWi0cOhGyU/Q=;
	b=fHxcSLtMR/1SVEYJoly6h0z6yopwDk9qI2ewkAJLOfQkmktNLjKYc/mZOMcOlZVeh3FV+z
	ISnaKXfOhJ9P925C8hin4JpYVeh96JZ9LHcL3eEO+kqgfUpwZreKLgVDdWOQ6fm/f8APtf
	qRr6z67BbKJMqYPISlYs03TYnUDMTu8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-zYT_lV4XO_qUyc2MAZUbXA-1; Wed, 13 May 2026 06:03:09 -0400
X-MC-Unique: zYT_lV4XO_qUyc2MAZUbXA-1
X-Mimecast-MFC-AGG-ID: zYT_lV4XO_qUyc2MAZUbXA_1778666589
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a589c7879so57282235e9.1
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778666588; x=1779271388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xzQE32mx93ylvQsX4/nZCp5JUmWcvqaEWi0cOhGyU/Q=;
        b=MLhqRy8yoI900fZzXwFq6bh8VD+hqdk8luL7JyJ7d64Bu8jfNT6dhUZ/yJAlbK0A87
         7Z4B/mW9dBH2u7p1xOEp0H8d+E9Q9FZCN4gtQY0YTFcB4z4gFyAH4Rd85KO33vVyy+Fm
         VZvfUCakYrtnmVMopO752vSL/ZiIw5dMsRIKsvSK0v3IsFilR6Blyg/p4fqJAZzhU7vd
         CJaLw9NfB9O3nuLgNlILpj2LNc3kKQXTVWuFf9HUNKXikBMNXUUBVJ+GG3zlDJ0vF7TS
         o2oVvaP0poscuwoRq5hAs8rr1H1WjcFdSghKsrcIy2vhaFeSOWKDNwiR+K4yy29Mh4kv
         VTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778666588; x=1779271388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzQE32mx93ylvQsX4/nZCp5JUmWcvqaEWi0cOhGyU/Q=;
        b=Vwka8uhJyZ0TOV75CszD0j5qTxRdcnNuNOKtaRbiGaTqa44iQjo5CJ2ZroBRx7Vjii
         cDRvk38Px1FtKS6/hLQ8r4dsTJaQo5geyTs4eGpcn57rBmZk3trJ/ZxANDH3LHwF8xJR
         A5+M9JCR/8RdYFHcem3WWx0XDSGX208+InAdOOojVbSuwk+c7vSI1yHQ8FhfUIUNe611
         Vw4UP9IIP4hABZt78QtTmD5ShhfI5O1AajoyFbSjbLx2Gs871G4jVD7JMKhFp3EnOyXE
         O3V/NmG9TpCuj2hoFNQ7Xf8Nq8du3yI7rG8WgKNL2aokxVI27M7siHHqcZGos30NURu0
         keJw==
X-Forwarded-Encrypted: i=1; AFNElJ+8r3+XnirxbZ8ECbSnCvTAIlPwud3XPUyfTzv3bfiZKcDRrECKBXVjDo+MZbxFiShUQno=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz3gbbs8gkogecKPIMB8JzEFYV6A1HYwkHaL+1MafHLObd8T6k
	kqCLJENXBb/UeEGRZupnbeafwHhk0WPgo3kpYd0Qz+yOw8rywkuPLwhXV9KMtumMu+X2PftpAs/
	mk/QczGxuVEL6HZ6Bqvpop6U6zDUGvcJZbbnuBD/nMiOi2FN3LkaG2g==
X-Gm-Gg: Acq92OEEY6t+f8F1Ngm1LAJYkOszhx+ViJPabcTivZy4n6EymVCAThEahP46zCG8d7U
	3ATV7naXoezv/KeEyqrpUFw1b7V3fC/xcuREjRFD8fiq32X3PN9HeOeHv2wn4F7s9TESbmjubfZ
	WrD9OVMPnhbSUN4puAYm3ruPvf+vLQRWZ3K2yVkeiqhL8Lqqk6IjvUQ4mvnkumGvNZvVzPAAlen
	32pbPOoNDRhqmHYDmYpfD3ldFOETypIDk6Hpx7OVqzHIW2puEEP+CMe3t5xc071jouG4E//X/u/
	l+zyGr1OSoRJN8AQF7tYf3izH2Abp0CxP+aONHh/mPPdIhodOSLOet9/vkkc3xLy2vcq+/Omsr3
	32hWDsD5kiMUR34xC1bX1hIpnxMyqjo8pQ/GGomQB
X-Received: by 2002:a05:600c:4ed1:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-48fc95a5989mr35259075e9.0.1778666588291;
        Wed, 13 May 2026 03:03:08 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed1:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-48fc95a5989mr35258125e9.0.1778666587521;
        Wed, 13 May 2026 03:03:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3e174fsm59587075e9.3.2026.05.13.03.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:03:06 -0700 (PDT)
Date: Wed, 13 May 2026 06:03:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Polina Vishneva <polina.vishneva@virtuozzo.com>
Cc: "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"den@openvz.org" <den@openvz.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH] vhost/vsock: Refuse the connection immediately when
 guest isn't ready
Message-ID: <20260513060124-mutt-send-email-mst@kernel.org>
References: <20260511145610.413210-1-polina.vishneva@virtuozzo.com>
 <agH3WvJtAsQ_5zx4@sgarzare-redhat>
 <962b26d2d1daa9411fb71efab6af2c75d1c5f0d0.camel@virtuozzo.com>
 <agM8cxqUCJNjBDlm@sgarzare-redhat>
 <20260512120019-mutt-send-email-mst@kernel.org>
 <8ae7e443034026eda016322d22da52700e432f09.camel@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ae7e443034026eda016322d22da52700e432f09.camel@virtuozzo.com>

On Wed, May 13, 2026 at 09:44:49AM +0000, Polina Vishneva wrote:
> On Tue, 2026-05-12 at 12:02 -0400, Michael S. Tsirkin wrote:
> > On Tue, May 12, 2026 at 05:39:48PM +0200, Stefano Garzarella wrote:
> > > On Tue, May 12, 2026 at 02:32:14PM +0000, Polina Vishneva wrote:
> > > > On Mon, 2026-05-11 at 17:56 +0200, Stefano Garzarella wrote:
> > > > > On Mon, May 11, 2026 at 04:56:10PM +0200, Polina Vishneva wrote:
> > > > > > From: "Denis V. Lunev" <den@openvz.org>
> > > > > > 
> > > > > > When the host initiates an AF_VSOCK connect() to a guest that has not
> > > > > > yet loaded the virtio-vsock transport (i.e. still booting), the caller
> > > > > > blocks for VSOCK_DEFAULT_CONNECT_TIMEOUT (2 seconds), because
> > > > > > vhost_transport_do_send_pkt() silently exits when
> > > > > > vhost_vq_get_backend(vq) returns NULL.
> > > > > 
> > > > > Can SO_VM_SOCKETS_CONNECT_TIMEOUT helps on this?
> > > > 
> > > > It can, but it might be difficult to find a correct timeout.
> > > > 
> > > > And, generally, there's no way to distinguish "the guest hasn't yet initialized
> > > > the vq" from "the guest is up and running, but didn't reply to connect() in
> > > > time". That's exactly what this patch is attempting to fix.
> > > 
> > > Okay, so please mention this in the commit message, I mean why
> > > SO_VM_SOCKETS_CONNECT_TIMEOUT can't really help.
> > > 
> > > > 
> > > > > 
> > > > > > 
> > > > > > If the guest doesn't start listening within this timeout, connect()
> > > > > > returns ETIMEDOUT.
> > > > > > 
> > > > > > This delay is usually pointless and it doesn't well align with our
> > > 
> > > I still don't understand why this is pointless. If an application wants to
> > > wait while sleeping, it can simply increase the timeout long enough to wait
> > > for the VM to start up and use a single `connect()` call, instead of
> > > continuing to try and wasting CPU cycles unnecessarily.
> > > 
> > > Hmm, or maybe not, because the driver will definitely be initialized before
> > > the application that wants to listen on that port, so it will respond that
> > > no one is listening, and the `connect()` call will fail with an `ECONNRESET`
> > > error in any case. Right?
> > > 
> > > If it is the case, is the following line in the commit description correct?
> > > 
> > >     If the guest doesn't start listening within this timeout, connect()
> > >     returns ETIMEDOUT.
> > > 
> > > I mean, also if the application starts to listen within the timeout, I think
> > > the connect() will fail in any case as I pointed out above (this should be
> > > another point in favour of this change)
> > > 
> > > 
> > > BTW, I think we should explain this more clearly both here and briefly in
> > > the code as well.
> > > 
> > > > > > behavior at other initialization stages: for example, if a connection is
> > > > > > attempted when the guest driver is already loaded, but when nothing is
> > > > > > listening yet, it returns ECONNRESET immediately without any wait.
> > > > > > 
> > > > > > Fix this by checking the RX virtqueue backend in
> > > > > > vhost_transport_send_pkt() before queuing. If the backend is NULL,
> > > > > > return -ECONNREFUSED immediately.
> > > > > > 
> > > > > > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > > > > > Co-developed-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
> > > > > > Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
> > > > > > ---
> > > > > > drivers/vhost/vsock.c | 10 ++++++++++
> > > > > > 1 file changed, 10 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > > > > > index 1d8ec6bed53e..a3f218292c3a 100644
> > > > > > --- a/drivers/vhost/vsock.c
> > > > > > +++ b/drivers/vhost/vsock.c
> > > > > > @@ -302,6 +302,16 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
> > > > > > 		return -ENODEV;
> > > > > > 	}
> > > > > > 
> > > > > > +	/* Fast-fail if the guest hasn't enabled the RX vq yet. Reading
> > > > > > +	 * private_data without vq->mutex is deliberate: even if the backend becomes
> > > > > > +	 * NULL right after that check, do_send_pkt() checks it under the mutex.
> > > > > > +	 */
> > > > > > +	if (!data_race(READ_ONCE(vsock->vqs[VSOCK_VQ_RX].private_data)))
> > > > > 
> > > > > Why not using vhost_vq_get_backend() ?
> > > > 
> > > > Because it locks the mutex, which is slow and unacceptable in this hot
> > > > path.
> > > 
> > > ehm, sorry, which mutex are you talking about?
> > > 
> > > I see just a comment about the mutex to be acquired by the caller, but I
> > > don't see any lock there.
> > > 
> > > > 
> > > > > 
> > > > > Also is READ_ONCE() okay without WRITE_ONCE() where it is set ?
> > > > 
> > > > It's racy, but as described here in the comment and in the commit message,
> > > > any possible race outcome is covered by the subsequent checks.
> > > 
> > > Okay, so what is the point to call READ_ONCE()?
> > > 
> > > > 
> > > > > > {
> > > > > > +		rcu_read_unlock();
> > > > > > +		kfree_skb(skb);
> > > > > > +		return -ECONNREFUSED;
> > > > > 
> > > > > This is a generic send_pkt, is it okay to return ECONNREFUSED in any
> > > > > case?
> > > > 
> > > > EHOSTUNREACH would probably be better.
> > > > All the current send_pkt functions only return ENODEV, but it has different
> > > > semantics: they mean that the local device isn't yet ready, while there we're
> > > > dealing with the opposite end not being ready.
> > > 
> > > In the AF_VSOCK prespective, I see ENODEV like the transport is not ready,
> > > so I think it can eventually fit here too, but also EHOSTUNREACH is fine,
> > > for sure better than ECONNREFUSED.
> > > 
> > > Thanks,
> > > Stefano
> > 
> > I think it's worth trying to do the same thing with e.g. TCP
> > and see what error, if any, we get. Match that.
> 
> This case is not directly applicable to TCP: in TCP, there's no out-of-band way
> to detect the "host up, but not initialized yet and not ready for connections"
> state: this could theoretically be ENOPROTOOPT, but no real TCP stack implement
> this, because replying with ICMP_PROT_UNREACH requires a TCP stack, which is
> exactly the thing that isn't up.
> 
> So, in real world, a similar situation with TCP would result in ETIMEDOUT.

Then it just might be best to keep the current behaviour which seems
to match that pretty closely?


> > 
> > 
> > > > 
> > > > Best regards, Polina.
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > Stefano
> > > > > 
> > > > > > +	}
> > > > > > +
> > > > > > 	if (virtio_vsock_skb_reply(skb))
> > > > > > 		atomic_inc(&vsock->queued_replies);
> > > > > > 
> > > > > > 
> > > > > > base-commit: 8ab992f815d6736b5c7a6f5fd7bfe7bc106bb3dc
> > > > > > --
> > > > > > 2.53.0
> > > > > > 

