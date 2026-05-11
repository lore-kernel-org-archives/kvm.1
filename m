Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1F6402435
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515017; cv=none; b=h24FH7V1EzyqVLB6UVBCLSsosw0V3LZO9kzD5n/LoqdwdNdOk45nC43xa3qO13ceAYYxz7WpHfMQW8nkcpuDODz4ZshLmdKVeNLsbG36B6SecJNqXHCAZ2yj96AFQlYphp6gUCQYf/2F+qmTmZINB/r9S3bvnO2jT0VyMelVbqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515017; c=relaxed/simple;
	bh=t7ET0rqXtYU0UPQXZE9zBjWgK/qB8ssf7YiQJM1pUe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4apDXE96XMQJRIYzeieOTEzseirONIXDTBW3SBX6TDAVWbxfHRHzV3TB1YBHCuukYXd9sqxH/OE04UbXk4Ji5cL3uR1OKFK215eZAPqoD05Hr2XOvzaibC60sZiHyjJ3JHqcqhs+/m8yZqcZDj9tTs1hdLUWKMTARb119+vKas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNnkr7R4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qzW4s5wn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNnkr7R4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qzW4s5wn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778515015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mqh8HANASsg1dE58rfi+aWvc9+OWR8qHCZSV5rhehOc=;
	b=ZNnkr7R4Xv7+hmqGjPhucsvV2xvhDukqZZNPEZ5CZhL/ZPICFTO5btrp9ZOAxjPGzPPo56
	GcoVosrzTZIU/4+H6hr0c6hfaoEg82MQNPaHj0dvzP0FmDcnUet9KVQqr5ckaLQIPXTIiL
	IHjMHfihSF/jNfsWnlxMtDJ5NBoecxE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-GtRDMzQNOeCDLpQfOYm-6Q-1; Mon, 11 May 2026 11:56:53 -0400
X-MC-Unique: GtRDMzQNOeCDLpQfOYm-6Q-1
X-Mimecast-MFC-AGG-ID: GtRDMzQNOeCDLpQfOYm-6Q_1778515013
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48e86e6c6b7so5628985e9.1
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778515013; x=1779119813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mqh8HANASsg1dE58rfi+aWvc9+OWR8qHCZSV5rhehOc=;
        b=qzW4s5wnUwhQ30VLWLHFtq5hINYu6kplsupgMOvEnLS/YYGmWg9P9QbXtnw78pcg6d
         hczTl6HOxC2G4aj1nj1Omq7eOExJzG1f4e6QpwuLcfRFUEWjjEkh2huQd7Bx+KjkH+51
         7KINkTu2nKjDi3C0Il+W6bXlDZQvU18vGP3CcIZcZUtXWv6g5SPTAIYfqAmHSs7yse4R
         M1xdPh3FKDaVYYUULayLN5qc1Oswx3emVQKA2BffDiE3hZAwNbaLDDWoWkkBiBF5llm1
         /dbDlKAG4+kaWU9r55dz/7+8liA5/R8CbaRjhZOOsDleRnocSizCv0CxwwXw+oEPQOyd
         pe6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778515013; x=1779119813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mqh8HANASsg1dE58rfi+aWvc9+OWR8qHCZSV5rhehOc=;
        b=Q0GBXIp/3RuXGBD1MvuaPl3m+vKociA4YpwKFR6jZJRo4dF1MXqHsBvpXyb01V2UfP
         WwovxJsys5QkJn168xbCkwLGnfX99FXx/uRsut3EsYiCftb20hpEb5e5lAovIWrfgWuu
         OApoUWHc92wyD4iowMo+YglF6ha2Bl0vZkuuelyqDun8yA72RZWvc4A5kHKkZDqT9FIx
         BiiOFyJr9u7WuE4oR0XEMMWSNJ726FGmuCa1wHVKR1tZQ27d/scVftogJhjtNOZbZHiH
         svU/GlXq4i48zVNXhd1CyLP5huFpY2skOz+FwcRmAsLwgkEo/VebYFJSxzm9aP0WfbqI
         Q90w==
X-Forwarded-Encrypted: i=1; AFNElJ8B8zTzc7f0LiXlmv4jn/YjttJwRecZR3JT8mU9WIs2ud32QeVbl+9v+vnXEIf4e+gDwBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMNIRAowd36Wk+sQIzXp3x/G0WskKukw9/CAC4UKAa7T9grE7R
	+1GPLi6KeP22Ss7RLLDaBekFP2vFDBgjn58m3JkMdhaaobDstlGFoOXPX8GQWLlxIKV9JpTKABp
	LIrFS8SxOIk+upSBdwu49h15k2bTNDcv910ecABiuyNccUuyWiZB+VA==
X-Gm-Gg: Acq92OHO4p7gnU7eWBOgqAoq29NmxEIYaUjVA1WUo7v1uuz1t3GMm9dF3vVmZvtaRv2
	Fs2k0nJJz8dAKqQ01Fn9bTduPU7iP3aQWDz0eTAiAC+R4z21dp1mwVElOpnu0g0X8UaX8+eYiXL
	UzyOojPKON4tjNQeDTO0ii88XRn1qL5YXC9xIjxzZ2KezIedDvPXhZ8fhYjOB27Sh+dGEZfEafA
	oPNjE94h2anBf7sWFjdZeBGIJgfU5NfnZTGrlwMGldGdu1frl86OkGvkZH48QO6jyn+zF+qbaLz
	rozWq2uha7pkZgDQv79Rfu+7vW2Tfuq9Xn7wQ1UltVNyny5swmWgti6YdVpCIw09/k7UEo073WH
	gV55leCLB9XMwEdkrbAptRxia5WEHTrMLGsG1dB/IhDU8qr6iTZgb83eFNKEywJrirDcZlrH4eY
	iQCUpax5kP
X-Received: by 2002:a05:600c:47d3:b0:48d:c0a:3813 with SMTP id 5b1f17b1804b1-48e51e0bb62mr256258155e9.3.1778515012660;
        Mon, 11 May 2026 08:56:52 -0700 (PDT)
X-Received: by 2002:a05:600c:47d3:b0:48d:c0a:3813 with SMTP id 5b1f17b1804b1-48e51e0bb62mr256257845e9.3.1778515012100;
        Mon, 11 May 2026 08:56:52 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6daf911asm100865105e9.5.2026.05.11.08.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:56:51 -0700 (PDT)
Date: Mon, 11 May 2026 17:56:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Polina Vishneva <polina.vishneva@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Denis V . Lunev" <den@openvz.org>
Subject: Re: [PATCH] vhost/vsock: Refuse the connection immediately when
 guest isn't ready
Message-ID: <agH3WvJtAsQ_5zx4@sgarzare-redhat>
References: <20260511145610.413210-1-polina.vishneva@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260511145610.413210-1-polina.vishneva@virtuozzo.com>

On Mon, May 11, 2026 at 04:56:10PM +0200, Polina Vishneva wrote:
>From: "Denis V. Lunev" <den@openvz.org>
>
>When the host initiates an AF_VSOCK connect() to a guest that has not
>yet loaded the virtio-vsock transport (i.e. still booting), the caller
>blocks for VSOCK_DEFAULT_CONNECT_TIMEOUT (2 seconds), because
>vhost_transport_do_send_pkt() silently exits when
>vhost_vq_get_backend(vq) returns NULL.

Can SO_VM_SOCKETS_CONNECT_TIMEOUT helps on this?

>
>If the guest doesn't start listening within this timeout, connect()
>returns ETIMEDOUT.
>
>This delay is usually pointless and it doesn't well align with our
>behavior at other initialization stages: for example, if a connection is
>attempted when the guest driver is already loaded, but when nothing is
>listening yet, it returns ECONNRESET immediately without any wait.
>
>Fix this by checking the RX virtqueue backend in
>vhost_transport_send_pkt() before queuing. If the backend is NULL,
>return -ECONNREFUSED immediately.
>
>Signed-off-by: Denis V. Lunev <den@openvz.org>
>Co-developed-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
>Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 1d8ec6bed53e..a3f218292c3a 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -302,6 +302,16 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
> 		return -ENODEV;
> 	}
>
>+	/* Fast-fail if the guest hasn't enabled the RX vq yet. Reading
>+	 * private_data without vq->mutex is deliberate: even if the backend becomes
>+	 * NULL right after that check, do_send_pkt() checks it under the mutex.
>+	 */
>+	if (!data_race(READ_ONCE(vsock->vqs[VSOCK_VQ_RX].private_data))) 

Why not using vhost_vq_get_backend() ?

Also is READ_ONCE() okay without WRITE_ONCE() where it is set ?

>{
>+		rcu_read_unlock();
>+		kfree_skb(skb);
>+		return -ECONNREFUSED;

This is a generic send_pkt, is it okay to return ECONNREFUSED in any 
case?

Thanks,
Stefano

>+	}
>+
> 	if (virtio_vsock_skb_reply(skb))
> 		atomic_inc(&vsock->queued_replies);
>
>
>base-commit: 8ab992f815d6736b5c7a6f5fd7bfe7bc106bb3dc
>-- 
>2.53.0
>

