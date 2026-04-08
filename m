Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F363538E5CE
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635967; cv=none; b=GYY2DVeNiQm/4belaleLwWfQahvR3EeuJsMCP+PNL6tNvAMY23iSmQ6E918YrLqoCefQGFJX5RhBeUTZIFzHstGy65k+9eqHQqegT6r5o9BDfRZEmcJVJ00LVmPjE2wix8UzRw9+kxow58m9qpKZ7IzvZu+SlkDSnohUXUnPN2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635967; c=relaxed/simple;
	bh=RiCBBjqJ6U8+nG7CHcXztQnXvaUlmfGwoy/fj7EupJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFA2bIfZvSgF25RdxPS7lBLKvQY9v0E38G9RMsFce+AhCLrEhmTPtPBAbEETUL9/SktTN6LdyTMx1xVkDyx3DfwzHEieJnfYWM7fNiEXKg/u1NlIxWEKv4Jo3XXvGL9tcXppa2zFNFYf2GFSXQP/RthpRbCo0qClqnP/IFMqYoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZekJZRM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYAyfwzY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZekJZRM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYAyfwzY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775635963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J3Abwh6EeEcrZMTQmkJv8CKYZpVXeikipJN0c4fSKWE=;
	b=iZekJZRM3zKNAIIaSBRoy376AIUXEWZToNvK8/doUu8Q+TNZWNFgu2jflWbgtfqi8C1/DN
	QVQxf7MNwz9rzutsF8gSkcI8GqdyjD99Q7TeWoc7w1kAk7oSZmaXnsSqHHomhsqjNGXe4j
	p4ym3uI7FHj1/j/nirrk3TC54vRT+jU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-snsyaYeUM1iKyyXHqscUpg-1; Wed, 08 Apr 2026 04:12:42 -0400
X-MC-Unique: snsyaYeUM1iKyyXHqscUpg-1
X-Mimecast-MFC-AGG-ID: snsyaYeUM1iKyyXHqscUpg_1775635961
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43cfbe041b2so388271f8f.1
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 01:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775635961; x=1776240761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J3Abwh6EeEcrZMTQmkJv8CKYZpVXeikipJN0c4fSKWE=;
        b=LYAyfwzYzM4jrthJZ/lY7ufkbH5zV9GFY2vZ4YcPwwy6Pd7qfBP6gt/sbkZ5FlDMvD
         unULd31vEeE+nSPhaamL5XiN1mIVnKQYpdNOpLmQtI/qdC1ptA2RxY97bxVCHvj9h3uf
         jC/dDfE+Y1tBaPpkH/pl7cmFvv8dOH20uzptHKcqAIu3DtR2RP4bkZpE9WwX6+h431m8
         kr6Jq3lVE7Z/0wV2R1H/15yhzRQXHNswl/ymF05c2V7RgV2/dS9H2WJ0VRMtb7nCniO7
         c33NOftGYvVmJy09enFLeODEuAvl0jkif6DEsK0pyrA+79wEIvjhJu2Eo6OQFJPAVkjd
         B1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775635961; x=1776240761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3Abwh6EeEcrZMTQmkJv8CKYZpVXeikipJN0c4fSKWE=;
        b=dsMK3FNrqaDNDhueLJLW/kwZdPp1OHxLqz4ufkeF/4j7hwQcaqm+meQUMRauJD+0fA
         v/XOBbIeDLf1ZWroV7AkDhh/9RUfCmAqX1cLowcjHN5i3UR/EQsJbmdu8NPxJdRl+/4P
         3peZ9NwYVAVoNIs6hZDStDhANZdoP1yL4vQfJm5tNcxilYHPoE5rkEsFvx0j0brQEigH
         nyyT2inBWbwE4jiQc4JInRatfyaydJXM7AAXps5fIPL41nBi+/JFNWJ78GszpCBKlTmU
         QEcWCYqxd0pPjXC4/iIImMWO7/yChyy0xFqDeGHWnyIlTx84anKY4AKH3QoN8atTIFke
         Hxng==
X-Forwarded-Encrypted: i=1; AJvYcCUrBr/wRSr1P2AwfhFzbDpBQz+viDGh9jrAMqoeZRGA7MhsCbed3lHrBMwVLIJBTaZtKfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZac3R4oWLHxJqRSJU7jfYNDAWZ6f8HD6em/QBl4DwEqP5sea7
	bSrCqvDJjUjUJSICJkJomJow+gVqoztASh6nURmIJa2ldndRetvuCXOCegASfjbgdUHAc0p9Nie
	8vEgtl8rmbKtIeUIHm01jTotLne19vCNsMqQUb7h8dDaLuwGCiCBc0A==
X-Gm-Gg: AeBDiev6jW+CwbC+1jjE9SShFyBYq8S28RYJevqOaS+FsbRq0NsIr7psA1VQjUg72qi
	pS/3zbDvZr+5T5Y5vDhhHLaXDWoRrSUg5htV6hrzYjsmR1N4H57+iIXnVmSTTpqvJeOxGm/6KTX
	xgSaBZEKza1L4cGXAIy71MrYb2kNdPM/phtL4PuDXA0HGjEGwTldIdp6vpCrUhNPCm9D6G4gmzK
	eXpal/1Dxg7eeoThUSnDIZSZCz2IWXCz6+jQttcfQEL1tHdlOcDiUOX1oF3fnVHIVJiIqWkUxz9
	/kS37ySt9lV1j04zvunuVtXmFZy4IWgJxpKykSlqpzU4nJ+Zl1RBNd6GPL35MXG8hYlc3/wWXEN
	Edaew84wDCi1CS9nteJzDpWdi3oCmsHypTeZ8ECg5JPw8GjR0uEldfM0ypQFfY0PXrgZiQZQ1ZQ
	==
X-Received: by 2002:a05:6000:41f6:b0:43b:a16b:ee69 with SMTP id ffacd0b85a97d-43d2124e1f5mr31165874f8f.24.1775635961043;
        Wed, 08 Apr 2026 01:12:41 -0700 (PDT)
X-Received: by 2002:a05:6000:41f6:b0:43b:a16b:ee69 with SMTP id ffacd0b85a97d-43d2124e1f5mr31165826f8f.24.1775635960583;
        Wed, 08 Apr 2026 01:12:40 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-236.retail.telecomitalia.it. [79.45.205.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d214f2b63sm50930205f8f.28.2026.04.08.01.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 01:12:39 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:11:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Message-ID: <adYNUs3pmVmQe7pk@sgarzare-redhat>
References: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>

On Tue, Apr 07, 2026 at 04:31:56PM +0200, Luigi Leonardi wrote:
>`virtio_transport_send_pkt_info` gets all the transport information
>from the parameter `t_ops`. There is no need to call
>`virtio_transport_get_ops()`.
>
>Remove it.
>
>Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
>I marked this as net-next material, but honsetly I'm not sure if I
>should have targeted net. It's not a bug after all, it's just a cleanup.

The patch LGTM, but as Michael and Jakub pointed out, better to remove 
Fixes tag if this is not a bug fix.

Thanks,
Stefano

>---
> net/vmw_vsock/virtio_transport_common.c | 2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 8a9fb23c6e85..a152a9e208d0 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -60,8 +60,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
> 		return false;
>
> 	/* Check that transport can send data in zerocopy mode. */
>-	t_ops = virtio_transport_get_ops(info->vsk);
>-
> 	if (t_ops->can_msgzerocopy) {
> 		int pages_to_send = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
>
>
>---
>base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
>change-id: 20260407-remove_parameter-f61a3e40cf90
>
>Best regards,
>-- 
>Luigi Leonardi <leonardi@redhat.com>
>

