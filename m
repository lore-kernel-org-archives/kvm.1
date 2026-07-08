Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C677F43079C
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529418; cv=none; b=ZI+KVqj7fj/PgZ8+t/+60zFpGuZyCDysc73Oq3R0aBA18pI343Apiav/RBuD5kZpJnWeZapXdBwiSlonEn5ilJdxiohSG/ytzo18yL+5Ccj0+iC+HQI1qH0BPFB3si5pZ55PaXHxmqLHfMmmJ48jshMt97zNYOmXwW6FYuPg+KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529418; c=relaxed/simple;
	bh=HEXCS7+2myohc1YZaELPgANH9OaRCUzaJ5f7a6XuwhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzzbapgau3LfkE1DYmS686oVEjsw9CO6Y+OrkxeebhKip+rEGQCso1iUTVI8K1UY9qbwkqD+DZv8TSYnbYn0hHrBqWZNT/qjQyme+BXbLwEljaSQokMDtrw77hYR0emVv9E+jUcCI8PXS1bqe8F22E4/u3EgZuQA1SlB4Y3SOEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CR4kgh28; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2ZogioL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CR4kgh28";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2ZogioL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783529413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iOZxF9JBJJ0HTV1hxdJ54Cs/JFpZYK6OhfeE5DF280s=;
	b=CR4kgh28GW2JJuQiQCOVOVDhBPPPsmGORpuY/MW4mG3wuiv0heukWHxKbFlw/xkVJDtt/T
	bKGnoa385Lg3sZvqbdRCx1HcmMSoZk08nIhLhBns/2aGWhjzszl4dNOuJtzVFHrd6h3jFc
	cHnaDydv4JPObgpL4tlCbJZmCHtI9as=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-nwEn4ZMLO-662YoSthhKWg-1; Wed, 08 Jul 2026 12:50:11 -0400
X-MC-Unique: nwEn4ZMLO-662YoSthhKWg-1
X-Mimecast-MFC-AGG-ID: nwEn4ZMLO-662YoSthhKWg_1783529410
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-473f4a48e9aso685025f8f.2
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783529410; x=1784134210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iOZxF9JBJJ0HTV1hxdJ54Cs/JFpZYK6OhfeE5DF280s=;
        b=S2ZogioLkYQS9nC40/heiOWtv2tt+PBKqW9cyk5srBHMFR10DN1Wy7LiBG7QzZbs8r
         gRu6UiipzrgCGYvAjKgjTYNUTCZ3aZ0xPI8Dy7IRG6Wk/BprPcppjt5gGOHNkkcR/jLa
         gn3mCTT1OVtzNhfCyCQfRZvL5kl7BSl2qynNuD6lQ5Nn5PGiswMJsuDQcISTk1Q7B7MT
         nBCWwMo7VbhNVa7LyHJRsTd+G5Zp3MvEwMNttoJ36SHF0X9yXla9dcGYMPhXn37DHKzr
         qhL29zi80lzWVygg6Y9voFBqPAJ5Fa+pAZYVbAxa9WFJOfybPji9fqXEFQYThMihVoS7
         8pxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783529410; x=1784134210;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iOZxF9JBJJ0HTV1hxdJ54Cs/JFpZYK6OhfeE5DF280s=;
        b=skdmYIGyiQj4+bYQJAfj4tshe5a/XmyeSV8lahazgTkkh62oDtuUjAcN+w+D4fYXvs
         MCMJevCJp1s90ILEpYyCf47B8ESokto+/ehoa8Wcfceg4XO477j+wLWp6PjnEFvYoBHX
         aWEpZv4MME04zmTfAcHLFtkIHcLrnLugdpIJA7txHecvk9ke0NUlbNKT+JAMDH7EdWJO
         dj89Vd2uGIjC0wSJqvb0zTA/2VzAFkELqY1uT2QtyGaLFwyfccyrJrQWJ9l5P1SnGvNB
         ims2VU/tR7xVadrkjQ2wQvxRIxHkfguCjwx1bP7wH90yghT1DVJrKMDLW62m8Leup7lz
         EkNQ==
X-Forwarded-Encrypted: i=1; AHgh+RrNzSH7S+fBIvckkzFLrG4Bsft1wgVnAzmA4/eamU+txAVE5y61qREsmi9fG33ZkmHYEeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye79GYjq/wUrXZBLEkaTX17ByLPy58koBSNmDcLdhbhFtudP2X
	SQqO5hHsNwQnE73adIkEx/t62be5cScAJ29jRUSlK8Mpr3PjonbeaiznM0U3burCcXEgLFvnONT
	Tlxp0xBVhRsY2atT/wKt8NiS3IHT2cPmZxA/1fbMCx5yZwA+EG2mQng==
X-Gm-Gg: AfdE7cmVMh8jwwLXzKiUIzC1TpQJYJLprXgPPldOa39Zt8P6ib9ViJl6INOHOz5K4T9
	I7pZJmjy4k70REmvyG7UqTokMUJdfj/t8ZeYWUE4IqTuL8Sc/JBWlfIVLgOccYHIdRIM3IGm/b9
	NbVw4YsP871dPSMMN6LGw/duM9IqC/hwRcQkZEzNUNIDD/bBcFOu3VsTKOCA8KgDo3H44OqMg/B
	8NPUfnU88lpOfSQ1bpgIWBef9Z+DVeI0uvJ+r7DK9BpwxDAcVB62PS9/hQeW6HzfmrTrqj+GMBO
	O0lEMTEaLYNyfTEn2RJpwyicyJI40mZYMetFbsPmEFpNubV2bpN/PTSkvlsv1/BxwTRlgkf159Y
	HChS7DqbHhGoLYBDTZivqRq4IsKw2aCKj
X-Received: by 2002:a05:600c:19d0:b0:493:cce0:3724 with SMTP id 5b1f17b1804b1-493e68aed4dmr30880605e9.4.1783529410072;
        Wed, 08 Jul 2026 09:50:10 -0700 (PDT)
X-Received: by 2002:a05:600c:19d0:b0:493:cce0:3724 with SMTP id 5b1f17b1804b1-493e68aed4dmr30880225e9.4.1783529409552;
        Wed, 08 Jul 2026 09:50:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039b0cesm44408115f8f.22.2026.07.08.09.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 09:50:08 -0700 (PDT)
Date: Wed, 8 Jul 2026 12:50:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: enrico.zanda@arm.com
Cc: jasowangio@gmail.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kuba@kernel.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, eperezma@redhat.com, nd@arm.com
Subject: Re: [PATCH net] vhost-net: fix TX stall when vhost owns virtio-net
 header
Message-ID: <20260708124901-mutt-send-email-mst@kernel.org>
References: <20260708152242.2268848-1-enrico.zanda@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708152242.2268848-1-enrico.zanda@arm.com>

On Wed, Jul 08, 2026 at 04:22:42PM +0100, enrico.zanda@arm.com wrote:
> From: Enrico Zanda <enrico.zanda@arm.com>
> 
> When vhost owns the virtio-net header, i.e. when
> VHOST_NET_F_VIRTIO_NET_HDR is negotiated, sock_hlen is 0,
> meaning that no header will be forwarded to the TAP device.
> 
> In the current vhost_net_build_xdp() implementation,
> when sock_hlen == 0, the gso pointer can point at the start of the
> Ethernet frame instead of a virtio-net header.
> This results in a wrong interpretation of the destination MAC address
> bytes as struct virtio_net_hdr fields.
> 
> This can, for some MAC addresses, trigger -EINVAL and return early
> before the TX descriptor is completed, which can stall vhost-net TX.
> 
> Before 97b2409f28e0, the gso pointer was set to the zeroed padding area,
> using it as a synthetic virtio-net header. Restore that behavior.
> 
> Fixes: 97b2409f28e0 ("vhost-net: reduce one userspace copy when building XDP buff")
> Signed-off-by: Enrico Zanda <enrico.zanda@arm.com>


The fix looks good:
Acked-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko thinks there's something something security here, but I think
it is misguided. It's just guest hurting itself. driver breaks the
device it gets to keep both pieces.

> ---
>  drivers/vhost/net.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 77b59f49bddb..3e72b9c6af0c 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -731,10 +731,12 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
>  		goto err;
>  	}
>  
> -	gso = buf + pad - sock_hlen;
> -
> -	if (!sock_hlen)
> +	if (!sock_hlen) {
>  		memset(buf, 0, pad);
> +		gso = buf;
> +	} else {
> +		gso = buf + pad - sock_hlen;
> +	}
>  
>  	if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
>  	    vhost16_to_cpu(vq, gso->csum_start) +
> -- 
> 2.43.0

