Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAD04EA371
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561852; cv=none; b=IFophRJ9qflNOxYWJ+XGXq2T/LnVXqbqu1od/iRCkvz+/0XUQ3L3UygxXdtAATrgbwMNl6kuRqUWMHXGst42KEnXDPqPvm2CaKf/DPj8loKgDOdZpSyJLOUpvlfTzIMkyuNGhy3b9pDW493xNk6gRGffXWjN3K+dztk/kERFwkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561852; c=relaxed/simple;
	bh=FrcWMoDVbMbpzp4CIH1n1Jf3KfV7MxTjfsHaS9A0FCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiGJe7LtnMWSzkR5Z99nfmns36ZcoV8seknzMk+XvfLDGzYVg/412sI4h3EL0SiFVShcpaQL9sqYTToSPBPtREu34tZMAwNofqXMtlehSPqFN5qPKzK3TMnlsS1JAhR/3Ghou/KGQAUuA1E6FOT3jRY+LvX4vMHN3ZwoVAw6TZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GH8sI7q8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAWmEGsM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GH8sI7q8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAWmEGsM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789561846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/lsJ0PSjJUTTQP4j3h3/faX0ng/XvkH6X4rWSQ3RUA=;
	b=GH8sI7q8u3uXlnWzND6MTU+GX3dpATMJ16Einyab2uHbiMpC1f/vlwGZAuuga5SylKCOXr
	Q0qReBxRQNggTcIk7SuonRHNMuaL+IQzNvQneX1L6VZOH0Eqg1ThtXmVmntxSk4F4FjSE/
	wxazINgjaWGHdo2v+mJ8XnPCgG2jrJk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-oetMqHdMPYGBtBMxoqlSKA-1; Wed, 16 Sep 2026 08:30:45 -0400
X-MC-Unique: oetMqHdMPYGBtBMxoqlSKA-1
X-Mimecast-MFC-AGG-ID: oetMqHdMPYGBtBMxoqlSKA_1789561844
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e65f2f1baso44388275e9.3
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 05:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789561844; x=1790166644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y/lsJ0PSjJUTTQP4j3h3/faX0ng/XvkH6X4rWSQ3RUA=;
        b=XAWmEGsMHw35Ajbokq2rmA08Ye2RzOdlWs1wrp2KWaobTHRosLAizxaEU1QtEgTll3
         IXKvXHL9eZ426KSEI3YaDhH2NXCxT9JlH+3tv2vQqVUv54hzGm2gtMo9w+ThT4ivQyLh
         LkXT99FovFTqb5uGpOM53UirHN1djK7HvN+mtqf/EhT6dtpd0PQ86TPfPcWMSEdWBS2n
         FbJ0Rw8gqME96qAH8E2NVzUhOd9Dsnn7J/QldkzED48MgI5tXEK4E7Kj+aKj8ICcniRP
         dtmCP2i8dyNdVZ5ugB2/3FAVU5KbwuvGQ2uMgTbvJMTf7w+9MLmVGoArq2eels6mBr/R
         z8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561844; x=1790166644;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y/lsJ0PSjJUTTQP4j3h3/faX0ng/XvkH6X4rWSQ3RUA=;
        b=bYqD0suNdawXf0VR7CfbXvqYwpRiUcbzn3q3w83rr1mF6kR3Xrxlpb7hWEANrvvbIb
         1H1B2Shuokj1JsEkrDBqHmmhFYXikFuwtQzIKQfIggUs6/aV7O/ZzF6+34eTMPDxDnuI
         F2rrR5BVwwJqprJIyA5JH+I8wx7ik9FDwU7AJ/zv8hY4RlsSFsLqMXjYjZW72o5WNyi2
         yayPL+I9X1x+g2jND3davfiaFufsznQmJj4Ax44VKmyQXPg5GxZpjwbriB4EjnSez6In
         nMbsST9ZSOn85SZemr2UbLUFfn1oPbY0eTgfKei09sMPM+p3R1LybxTo8JlX+y8cBXIQ
         sEGw==
X-Forwarded-Encrypted: i=1; AKwUvBynnN3hD2JQFHM0So2ShgG8jeknzqc7xhL+yHmeHbjSuuPSDS2GrXe5K5mUzrEx3bwF7AY=@vger.kernel.org
X-Gm-Message-State: AFuF++kJarveVaRkioVoRos6KfjxXjJijO+xzjJeu0fMbzLC066yIPi7
	ndTK+iOai5YHp0HqjIU9EtTwMPp8wGa34g4u835Lq5x0NWixA7HEGMofZcw2mHw2vDYa+z6nLpE
	hmCGF5GcQtU48eyn9hPT6mfylJfyNsPAaS+ejzkToh0QjcuKGlrWh+w==
X-Gm-Gg: AYBFou2MWyUzrjKoXCseWHklE406Y3UlJ3hSkPol+GDu5A0vXV/t4m8p+WOrvaHnT/k
	BvSBAW+epCUdIvvkGRo15U18T3/mzC0rA/F8ZQkSfdWdg6isfY4rn10wDEmZzMTABj2+QK/ojdE
	z3UIjZKBCSvdeVpSXCQ1se+cLcmSkbKO59dP7wtK0GhpNcdsdDLrQb9Zr8aKiELmYvSWBHvlIH8
	7eJTpyRLN16VS0ZRmEbIx3SXJuNRh7v1NJtjFRAHX99VEqfKLeLikrub0kPhLYdK8PQv7HOlq/6
	BIfSl3f09gQVGncQ2tz7beKMY6RJFoN6z/75bnV9AFFh6W5KIgQNeudAyW2ZM615+SR9WmVPCsd
	qnkN0QLGjiNXDNcka3sltpdscAUIqS865NHuku3Q86eo1QA==
X-Received: by 2002:a05:600c:19c6:b0:49e:645e:2616 with SMTP id 5b1f17b1804b1-49eac463955mr25967155e9.5.1789561843694;
        Wed, 16 Sep 2026 05:30:43 -0700 (PDT)
X-Received: by 2002:a05:600c:19c6:b0:49e:645e:2616 with SMTP id 5b1f17b1804b1-49eac463955mr25966565e9.5.1789561843075;
        Wed, 16 Sep 2026 05:30:43 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83addf36sm76621175e9.5.2026.09.16.05.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:30:42 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:30:39 +0200
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
Message-ID: <aqp7CV9DnfsG1GJc@sgarzare-redhat>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-3-a1d9abb472f7@rbox.co>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-3-a1d9abb472f7@rbox.co>

On Tue, Sep 15, 2026 at 03:15:14PM +0200, Michal Luczaj wrote:
>A non-blocking connect() running in parallel with a blocking connect(),
>combined with a racy listen() that hits right after a connect timeout:
>TCP_SYN_SENT -> TCP_CLOSE -> TCP_LISTEN, while the connect() loop is still
>in progress.
>
>Enforce the invariant. Prevent a socket from becoming a listener after
>acquiring a transport.

We should improve this comment; it's not entirely clear to me, TBH.

>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index f840498b58af..499e902becfa 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1973,13 +1973,13 @@ static int vsock_listen(struct socket *sock, int backlog)
> 		goto out;
> 	}
>
>-	if (sock->state != SS_UNCONNECTED) {
>+	vsk = vsock_sk(sk);
>+
>+	if (sock->state != SS_UNCONNECTED || vsk->transport) {

Are we changing the behavior when an error occurs?

If we call `connect()` on a socket (with no others running in parallel), 
it fails, and then when we call `listen()`, it now fails, whereas before 
it didn't. Can this happen? Is that what we want?

If so, we should mention it at least in the commit description; if not, 
perhaps we should unassign the transport in the `connect` call.

Thanks,
Stefano

> 		err = -EINVAL;
> 		goto out;
> 	}
>
>-	vsk = vsock_sk(sk);
>-
> 	if (!vsock_addr_bound(&vsk->local_addr)) {
> 		err = -EINVAL;
> 		goto out;
>
>-- 
>2.55.0
>

