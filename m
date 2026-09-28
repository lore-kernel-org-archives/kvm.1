Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A406149C4C4
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790592283; cv=none; b=BrtOggvkv+KYt9teHqmIhusEeS3UaHPZp35y9vNNFZQhGf+W35k5LlXl+jA7O0OwhYjAv/lCKfZmKQGvdEcjBh7jaqvyMgB7FxHgKTqLM6hF+8YmHgXx2a/tNG7aV591v0bk2UcRMqNlGdLs2r3CHggC6lqfSlE50utSTfPGZwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790592283; c=relaxed/simple;
	bh=begHgy37Cc2MAGYroVxkMgS2Nwr117LedfsOcUGpDX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cii5V+SjOmRSgTXvgmxlNvTraS0+FxU1eu2VDILX1/Ha+VF8GS+sh5Hgo+jE6qLBTsGVKTYO4YRrLU/hA5ruoakQaEMn2iglOS/Zcl8pIEFS9z+2NXl3shTSnxQFC97RrFBhyizfwxlM04Q1ialuD6ROSjwjiTUCThSc8S0CSDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P4iltFw1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GCNCKg/C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4iltFw1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCNCKg/C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790592280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWLn1uBdGE8DYyOCQu5LWmiRAP8fdcDmIDx3VaGdBYA=;
	b=P4iltFw19wvua/SbnnpINr9ZwusegOOea/tSPtz55NYh9F8qFiC+tJr6JawGTwQJheOaYt
	DxILCR7loC4ydGjbVPNsIIksNNkWWjEtL/1u4PXsSjCf+GtYL16HM728quKsbO/1HO1DAG
	mu8mdSUwLGCEwVpoKE/Dj8IHGTCrsMo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-lwaTjj4tNIeuhqrbA2zQsg-1; Mon, 28 Sep 2026 06:44:39 -0400
X-MC-Unique: lwaTjj4tNIeuhqrbA2zQsg-1
X-Mimecast-MFC-AGG-ID: lwaTjj4tNIeuhqrbA2zQsg_1790592278
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49fffa5de0fso19011435e9.1
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 03:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790592278; x=1791197078; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NWLn1uBdGE8DYyOCQu5LWmiRAP8fdcDmIDx3VaGdBYA=;
        b=GCNCKg/Cy0ahuEOUZ+M+7O2NQ5CYhBnYlXJQ/mh+l0NfJgYN/tCd9jRuJSIhSbfYpZ
         TQiRQl7I3vk768OzetjaZH8OJJKhQpbcpTcehwQ7DzbySBVE4HYIZKykhZMVDbWtTyAk
         knANuFny2/AmUNgORfYhxlvkwhGvkg3zSpbmv7/8Q4JV5PeyOxSF92SzWME0sCXAZlGf
         tnZL5VNhfuB0LDDas5WYBjosCHnkcOIdH/icDln1q8vM9zdO+duTkQYKhd3qkL6NRKUa
         8jFtZxVCI894u1IvreDunL5f6N4I3TcUfpbPZOEqjEzKbnXtc92MK/x8E/59uahsDRFC
         BdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790592278; x=1791197078;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NWLn1uBdGE8DYyOCQu5LWmiRAP8fdcDmIDx3VaGdBYA=;
        b=VH90+jrKWaMUK7WC5ZpzLq5TYgT/pbZJTVZsfkg/IQJTe/9cwNuOtivnLubp4lsLSc
         g85N3VRiOhSu87VrYLVw8rGDYFpDfO43wi8VGhute3i2peMWL5eXR3xSZSFB41R4jZ4o
         itCHGyXlCX57KzGihz7W8l/lnuEcQamo95g4gxDT0h5vGIN4CrPHvvfUMu9dS/FSdkdt
         0YpBn+UL2vHKX5E878Sz5vFTbSwv30ugB09i89yVz/EnXd2HHOITwQ3z2go8bkQszeXi
         hpD9ga8StGfOmq57JVcO1VhinymD5jPUjGqNhPHr/NNXwsJGuF2cAKzNY1ZRrbbbzT/Q
         Cb2w==
X-Forwarded-Encrypted: i=1; AKwUvBzI+IXWW25ESyyJNKC9M0HBaiL8ni0aUnDCklfjyNSfbTsIonVGS2k7NsUALfSAaKp4bWE=@vger.kernel.org
X-Gm-Message-State: AFuF++l66nWK+WiuXT6TcFiWwj6SGybjolFIh/u2cJipSB/jeY2Dd8rT
	OH6IzZrKojNml/YTgkjQ2mZ25knWDii62NXffnudfJw4/5mYypNWqCB3jwksab/Ztwxj3vZlGlB
	DqDO6ihGvsG46BTd91KTPdOqwabpCfnkBCr2ibXpi8oTLM5QGg7S/mQ==
X-Gm-Gg: AYBFou0IIA3XjB8p6XMxA3fJFuI+30VEjwLgQKZyRO6ehnOk0K+HdCE6AABk1mA8+X5
	qHBY3+qllfBCS3HrewsmoJpsJZSHBsdKU7Hv81EaqfT8Wp+iyG2gZpRbReI37zUjEJjSIh1pXVe
	U2G/770PQW+YG1YLf7sm6HW2WigEzJmwcGcJn6Ff1fTp4Y2N5uVPX9JGABROZcgGAL0VpFOnCpf
	I6wPHZDvk6aFs9+Eaij0JpFbWoyPEa0LaG6BFPb8wSbz4GCn8D2tfS0h+ulV1a+FSYOXlKY+FBh
	w/VGoYDB+ucyszrNWbPo2fIWpXdLvVtQ1danvhZ42EZ4RTymqgwSlYkjWgP3hYck0A1Tg3S17bt
	soqmM
X-Received: by 2002:a05:600c:4754:b0:49c:c96a:d36b with SMTP id 5b1f17b1804b1-49fe66d1663mr228734695e9.12.1790592277745;
        Mon, 28 Sep 2026 03:44:37 -0700 (PDT)
X-Received: by 2002:a05:600c:4754:b0:49c:c96a:d36b with SMTP id 5b1f17b1804b1-49fe66d1663mr228734465e9.12.1790592277287;
        Mon, 28 Sep 2026 03:44:37 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.134.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0018e6ba2sm138576485e9.5.2026.09.28.03.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:44:36 -0700 (PDT)
Date: Mon, 28 Sep 2026 12:44:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Asias He <asias@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 5/5] vsock: Handle sudden TCP_CLOSE during connect
Message-ID: <arpCh0B77HUKe6Tf@sgarzare-redhat>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-5-a1d9abb472f7@rbox.co>
 <aqqIuUadZ_E1skmR@sgarzare-redhat>
 <036cb16f-c3b6-4e94-9c3d-42e40d160833@rbox.co>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <036cb16f-c3b6-4e94-9c3d-42e40d160833@rbox.co>

On Tue, Sep 22, 2026 at 03:18:05PM +0200, Michal Luczaj wrote:
> On 9/16/26 14:31, Stefano Garzarella wrote:
> > On Tue, Sep 15, 2026 at 03:15:16PM +0200, Michal Luczaj wrote:
> >> Virtio/PM events are serviced by virtio_vsock_reset_sock(), which resets
> > 
> > What "PM" means here?
> 
> Power Management, namely virtio_vsock_driver.freeze which is defined under
> CONFIG_PM_SLEEP. I'll generalize this comment, as suggested below.
> 
> >> each connected socket. The reset is done under vsock_table_lock but without
> >> taking lock_sock(), so from the point of view of vsock_connect() -
> >> locklessly. The same pattern exists in VMCI's
> >> vmci_transport_handle_detach() and vhost's vhost_vsock_reset_orphans().
> >>
> >> The complexity of connect() comes from the fact that:
> >> 1. the virtio transport can be reassigned, so the old transport must be
> >>   safely released;
> >> 2. a failed connect can be followed by a retry, so the socket must be
> >>   reverted to a sensible state.
> >> Both cases apply only as long as the socket has not yet established a
> >> connection.
> >>
> >> While connect() waits for TCP_SYN_SENT -> TCP_ESTABLISHED, other
> >> transitions can also occur:
> >>
> >>  TCP_SYN_SENT -> TCP_CLOSE on connection failure, timeout or signal
> >>  TCP_SYN_SENT -> TCP_ESTABLISHED -> TCP_CLOSING on VIRTIO_VSOCK_OP_RST
> >>  TCP_SYN_SENT -> TCP_ESTABLISHED -> [TCP_CLOSING ->] TCP_CLOSE on event
> >>
> >> This further complicates connect(). Rather than making every event handler
> >> drop the socket from connected_table or adapting connect() to handle more
> >> transitions (while missing proper locking), use vsk->peer_shutdown as a
> >> poison flag. Whatever state an event leaves the socket in, the flag bricks
> >> it and prevents suspicious transport reassignments or TCP_SYN_SENT
> >> retransmissions.
> >>
> >> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> >> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> >> ---
> >> net/vmw_vsock/af_vsock.c | 6 ++++++
> >> 1 file changed, 6 insertions(+)
> >>
> >> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >> index adf3f018347e..972952d04a81 100644
> >> --- a/net/vmw_vsock/af_vsock.c
> >> +++ b/net/vmw_vsock/af_vsock.c
> >> @@ -1743,6 +1743,12 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> >> 			goto out;
> >> 		}
> >>
> >> +		/* Virtio/PM events are serviced locklessly. */
> > 
> > IMO we should be generic here (i.e. don't mention virtio or mention it 
> > like one of the transport, but IIUC also VMCI does something similar) 
> > and also we should explain better why we are doing this, like you did in 
> > the commit description.
> 
> Sure, will do.
> 
> > Maybe we should document this behaviour also on top of this file.
> 
> OK, do you mind if I do that as a follow up? I worry top of the file needs
> few more updates.

Sure, as you prefer, I'm fine to postpone this.

> 
> >> +		if (READ_ONCE(vsk->peer_shutdown)) {
> >> +			err = -ECONNRESET;
> > 
> > Is ECONNRESET a valid connect() error to return?
> > 
> >> +			goto out;
> >> +		}
> >> +
> > 
> >  From LLM reviewing, can you check if it's valid? :
> >    - M (net/vmw_vsock/af_vsock.c:1747): VMCI regression.  vmci_transport_handle_detach() sets
> >      peer_shutdown = SHUTDOWN_MASK unconditionally and then special-cases TCP_SYN_SENT with the
> >      comment "we treat the detach event like a reset" — i.e. a connect() retry is the expected
> >      recovery. It is reachable for a non-connected socket via vmci_transport_peer_detach_cb() (which
> >      uses trans->sk, not the connected table). Since vsock_assign_transport() only clears
> >      peer_shutdown when the transport actually changes (af_vsock.c:671-689), the retry now hits the
> >      new check and returns -ECONNRESET forever: the fd is permanently bricked where it previously
> >      reconnected.
> 
> I'm not sure I follow the logic. SHUTDOWN_MASK gets set no matter what's
> the state at vmci_transport_handle_detach(). That means even if vmci's
> reconnect succeeds, all the recvmsg()/sendmsg() at af_vsock layer would
> fail anyway. Am I missing something?

Honestly, it didn't seem right to me either; I think we're fine the way 
we are for now.

Thanks,
Stefano

