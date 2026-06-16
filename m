Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36011FECAB
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613379; cv=none; b=L8d1sU7gOVg2WDa/mIW2zkquBkbJNCtJkyPFQlUesdij+wmRrX2cKv8kF7LIHbUbkA7VSd53apiNJPypf4Y1XkCBZVXxBIAiRUoVbD1DM6Q0Olc3pc5ex59tYd0hP4bofnGnLpTa+8gkOKvDS5OsW8dPvi4RESJ8d1OlNx/hDs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613379; c=relaxed/simple;
	bh=We5ZGXz91oTGJ0dJSujyq11OFk6rNuSPRZXQZ0H5xKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+rCgPgmk5TTdVXB6mqW5KOBXRuEFenwCwKAVXvFBKr4EYMYqcm2ZFHbvJxqwWQjryGNAknxleO2wFm9ct6vf9LyttBJGi9dXhrWJVLDTkIG4nEAPqnEulIHjK3+mkpK6RhkIHUZUzTV84actpbkjquJKdzjxbsZEWFDe3xeC/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TXPnzvPB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mPPYrUx9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXPnzvPB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mPPYrUx9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781613377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FSnkO0gt5pvplCuR7CfDwnBPmu7f4V6aR0qzT3FcJKM=;
	b=TXPnzvPBpkEmkYLCg85Yy1ODSms1dHWNccf7BU9Y+JclWjAklRtSnju9fzfuJgd3ckZyom
	/kxKSZCetfgHQ0ki/hNYh3oSXAdG7/Oa0ZRvUqu06Ebjs43o8Kb36TLfRgEng1Xhw/f0TB
	hujsSy7qzFqogkCj5c6LzfoOba0Ys3I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-1Hh0boXxPyqF_RaXnwKv2Q-1; Tue, 16 Jun 2026 08:36:15 -0400
X-MC-Unique: 1Hh0boXxPyqF_RaXnwKv2Q-1
X-Mimecast-MFC-AGG-ID: 1Hh0boXxPyqF_RaXnwKv2Q_1781613374
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490c840efe6so48146045e9.1
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 05:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781613374; x=1782218174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FSnkO0gt5pvplCuR7CfDwnBPmu7f4V6aR0qzT3FcJKM=;
        b=mPPYrUx9Sdm5PrGHaYnzcEFCSKRIJF+RxN1IDyMoX1j1ge4DxWs0lzQ58hw436uDXf
         pL7Brr57XHIJlAsp9TxosqGk0+pYRDvBBuO1NvjTHziFaC+QBj4ER2ZobNvTsS3NFP7z
         h73OENg+rUCPWAROq35eVsX80VBcdP6tv7huFHy29NAOEcUZA9piVtsJbH4PTspH7sV8
         3hcvdM4z4O/4geyodXBVvp7bMvx9IuMs3yzzTup/VKi8yojRz9nH5YVK+ew3yf7N9r4+
         XxqcHJR9uDZoPQvftHge6zQPoKzgGVSTPA3gUGjPvL3GH/sdBjzSPMGVccrv168tPZB8
         Ev8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781613374; x=1782218174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSnkO0gt5pvplCuR7CfDwnBPmu7f4V6aR0qzT3FcJKM=;
        b=lDwYzRdpJPpHe94LSq5Qc/SjZ14Bn7rtIKf8hvQUdj6ofKXHoLD539ZeD60WJUHSkT
         6i7r7VpWMaBfepFl9R8KtwiUg2g3nWfWgmnPfoe8FCEksHw5CVb/sYFkJmsM21ksetTV
         bqfeEVphYaGGfdZLeWITyNl6857bGs04z3x5gFYYV58vDvCpzlWJlwUfSkQ/B9s6ik7F
         9+Q/N2gEOG7B3YLy8QALheALXmQQ641twKy03sbERypBUqx0xm/vvpVI3R80JiKUm+G1
         pi//n4DOOAxeaFeMefEbY5cAdF5thFqjQPdZ1u01RHW8PPlC1WWu2waBh+go/NImovgG
         P7mg==
X-Forwarded-Encrypted: i=1; AFNElJ/lOBGa0XeU/ZB0Eo2HnPbqFEVDRCZI2Y5tRfuzNE5AkwaZ6lGTj2bphQbp/QMeD7d4iNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiFk3WTZUAtyxVtCW+tORJA6w8zaP3/YNLZl/cln+BTx7oOoT6
	bR4/3CPidEnwm9nLeTkHZyem9pkGvlzpTjGrOPslrErpCBlen/AvUSn1l76WZ7RIrHXaP7lw2M0
	h8KzufjI2lPS6yAQoTKKRPpSVAqWeLqMbxtbYyrpmBD5/91GnkdNRFg==
X-Gm-Gg: Acq92OFuqowL5Z+CYI2y0IiQPnn1MLK5JXHPGhYCMwrMZGD4iUINlxvsbBYlOnbRh3L
	oSsaYIHhzeTrJPDQAkDO83k5P1mlUtfhQpvdWHV/soHgXjZ2/1AJCSl11USQilTp3MMv5FoZneV
	A71+6xwp7BK5JCItJwJvs8ONIgwImRy423bgqQmhzGlXxuyoO00OEb1QD+RSpNPasMGMuqXzw8c
	l0wcLUXnV6AZKEXa95xf1xc8c6mooGhZWTqMbyN78GdtsfKA7Hm1B6NBeAjGkO9evflK8eT8tuu
	WHqTHwJqsvFV3sEWBUNVU7f5OU0ByND5F1aqGSt+7zG6+52h3Ukqt4pyI5fSsvZ2Yvtmo0Q6x+p
	w+nivk0EmQJvBcIVNgXGKUJfVBsGrqAFMjPoW/X6xYbbgzwcZC0Cq+3r60TNI5frfO1nW8Yw=
X-Received: by 2002:a05:600c:6215:b0:490:e180:2e0 with SMTP id 5b1f17b1804b1-4922fab22c9mr52204425e9.3.1781613372065;
        Tue, 16 Jun 2026 05:36:12 -0700 (PDT)
X-Received: by 2002:a05:600c:6215:b0:490:e180:2e0 with SMTP id 5b1f17b1804b1-4922fab22c9mr52200315e9.3.1781613368029;
        Tue, 16 Jun 2026 05:36:08 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a8ec56sm53027215e9.9.2026.06.16.05.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:36:07 -0700 (PDT)
Date: Tue, 16 Jun 2026 14:35:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Octavian Purdila <tavip@google.com>
Cc: netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 1/2] iov_iter: export iov_iter_restore
Message-ID: <ajFDIHuKC31pumnY@sgarzare-redhat>
References: <20260613000953.467473-1-tavip@google.com>
 <20260613000953.467473-2-tavip@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260613000953.467473-2-tavip@google.com>

On Sat, Jun 13, 2026 at 12:09:52AM +0000, Octavian Purdila wrote:
>Export iov_iter_restore so that it can be used by modules.
>
>This is needed by the virtio vsock transport (which can be built as a
>module) to restore the msg_iter state when transmission fails.
>
>Signed-off-by: Octavian Purdila <tavip@google.com>
>---
> lib/iov_iter.c | 1 +
> 1 file changed, 1 insertion(+)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>index 243662af1af73..067e745f9ef53 100644
>--- a/lib/iov_iter.c
>+++ b/lib/iov_iter.c
>@@ -1491,6 +1491,7 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
> 		i->__iov -= state->nr_segs - i->nr_segs;
> 	i->nr_segs = state->nr_segs;
> }
>+EXPORT_SYMBOL(iov_iter_restore);
>
> /*
>  * Extract a list of contiguous pages from an ITER_FOLIOQ iterator.  This does
>-- 
>2.54.0.1136.gdb2ca164c4-goog
>

