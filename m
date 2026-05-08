Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D55839DBDD
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 22:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278966; cv=none; b=BHKeROMRzHbnjIif1r8fwHyuO9OZa3P6ovydtgxkG288CVawPZOZUTc1zLMqTqyNmHS15hwWvdUqymbK365JEx1UsmvplKq/PQLr6OK0ixY1F831A/F4jKSRRheFUUT4D/4dpTPpWShKvqFvcGqM/6Of4RDmu0vwYbi3muMkK9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278966; c=relaxed/simple;
	bh=ybo2HK/PI6PDF5GbqOTLQGuk0Dq2WjaK+tSFJS3Pp9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SF2kMNN/0yHDCMixZO2eUMg2haMNjwOfP+ZI8530pJqEheOcJVQ+F3qk3wuD/jumjS7k5SIigQHrUcEICq1wQqxO5xR0UHVFmSTHrNX2VEzO5RAUZ470N+rD+QwloRc3w/23Ef392UrgoUuxdWB7mYkieDQpXUhv16hRgV5DBpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuizcXye; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuizcXye"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8aca4e14411so26215816d6.3
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 15:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778278962; x=1778883762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5MQa0UpWFwjb5S8kUnJztiH2lQyqJ0Jvx1ScOQZwHKA=;
        b=cuizcXyeDI2zPjB6uL1F5Lldbr9PBBUQtUKz/vc8IV0wN7ZABZ0g36M3xkjq5XQyNU
         w4rBEKFc/VTtOKe6DburFSrQicZX8quIPqnLa+nGjwukyUXGHV2rjQjf4hLVV35sNsEF
         vmrpXzQzv40NgqcGmFAY4CUcqVMuwyJMUYvgJmJAyCKt0+3oVmoUGmUGeD5FLv9V/WUO
         I9D2t5eUYDIUMOJ/+dokux8av2rVGvRb87WMJ/CorZLmXvMEmAwaS5hTuOi3VDMVrJLD
         zvtRdRw9UHZUv/pghA/f+vCVNnbSBWJK2Xb83dBvkoJvsMZTb145g8hNPiIZOOWzY7s0
         2wsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778278962; x=1778883762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MQa0UpWFwjb5S8kUnJztiH2lQyqJ0Jvx1ScOQZwHKA=;
        b=eD4/OlR3O2dCPezFY9XrREBiKnl1s+GNsSba5uAb9gQZ2mAa45y9rynS5vcPykZfAH
         mqeP3cut+wapbDeaS+0MS1arE7zPMS6mSV/pa63DVVwmGiY7N4PKAndF0ILQMojIsqGC
         TFJ+ZRF92tsAyF2ljNpYH6XTxGWobsBLdrXacpvQbWgmo7yKDBk82I/K8hSB3lGmCSa2
         MFWyHayxWbtdRp7TEcdBW8m2LX+j7WsgA6LkgerXsTqW4+ZeAUVq1JKihQWxMHYGUEVC
         jgGDkU+pAS89N5if9MU+FY+ySKCa0j6MXtk/5K324Ydf6a2i3qz8mkI0iqAwTvYl3EWX
         X4oA==
X-Forwarded-Encrypted: i=1; AFNElJ/QMD1KfpcGkvi5keof+Oi1iShB4l9hpS8JFVB1jDOVAlGmWs/SWJ7S3UnnYprLVmh85PI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+RhwhAzB0tag3ATok4tnZKEBksRITYwhMjWZOz4k9jgNpU35K
	AcZk63uC8y5c6e77Xrjznya6TY8pcM70B05uYdqAy0uTG1+kPcDBAWuV
X-Gm-Gg: Acq92OFD1spReiSSA3jrmmWwnBOl51GE2yAKdAtDk5Gah9fqq5vTH4xoL/mp29OojY5
	BO+q6L1bEi2b9avdcAaJ/FV/cF2uR/YILCxdewdX/hoJ9eDs13NnCl4wEmzveUoiYoBDAQxfRR4
	+g6kuDmI+klZJao3hPWcWE8p0dHJrux1jmIW8P5Za7mcTqvl+YwNz7FPqlIGSWU5R5JAyDrpqkg
	pZunG5AzC1nOIYtKD8ox+4ry8hmZntz79A6j1X+GfDMpFPG0W25W36a7urf89PVleeM/+L+rUeO
	yXH/VCqi4gv/+UqNXG9NDVNoxnV2UlbvBl1IaLls5+zxArmz0PTXEAF3hrH4S514nYYOIXOhqy4
	y4cjrFhmOZXAKEV+MQHa4AYZXbSGX2Fj5HKRE4zUK3Es9KwK9LJ3ZZS4E9GDkOm/1aRPylb3yAC
	9bN4xn+770w9mBrWIYFxc9t9pEkQD/KgofpvN8335AkieH9mYNARcJd3k=
X-Received: by 2002:a05:6214:258c:b0:8b0:2ae4:da26 with SMTP id 6a1803df08f44-8bc422a66f5mr208086466d6.10.1778278962004;
        Fri, 08 May 2026 15:22:42 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf39c81b3fsm30363126d6.29.2026.05.08.15.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 15:22:41 -0700 (PDT)
Date: Fri, 8 May 2026 15:22:37 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Yiqi Sun <sunyiqixm@gmail.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH net 1/2] vsock/virtio: fix length and offset in tap skb
 for split packets
Message-ID: <af5iLWLo4Kz+USum@devvm29614.prn0.facebook.com>
References: <20260508164411.261440-1-sgarzare@redhat.com>
 <20260508164411.261440-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508164411.261440-2-sgarzare@redhat.com>

On Fri, May 08, 2026 at 06:44:10PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> virtio_transport_build_skb() builds a new skb to be delivered to the
> vsockmon tap device. To build the new skb, it uses the original skb
> data length as payload length, but as the comment notes, the original
> packet stored in the skb may have been split in multiple packets, so we
> need to use the length in the header, which is correctly updated before
> the packet is delivered to the tap, and the offset for the data.
> 
> This was also similar to what we did before commit 71dc9ec9ac7d
> ("virtio/vsock: replace virtio_vsock_pkt with sk_buff") where we probably
> missed something during the skb conversion.
> 
> Also update the comment above, which was left stale by the skb
> conversion and still mentioned a buffer pointer that no longer exists.
> 
> Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 9b8014516f4f..a678d5d75704 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -166,12 +166,12 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
>  	struct sk_buff *skb;
>  	size_t payload_len;
>  
> -	/* A packet could be split to fit the RX buffer, so we can retrieve
> -	 * the payload length from the header and the buffer pointer taking
> -	 * care of the offset in the original packet.
> +	/* A packet could be split to fit the RX buffer, so we use
> +	 * the payload length from the header, which has been updated
> +	 * by the sender to reflect the fragment size.
>  	 */
>  	pkt_hdr = virtio_vsock_hdr(pkt);
> -	payload_len = pkt->len;
> +	payload_len = le32_to_cpu(pkt_hdr->len);
>  
>  	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
>  			GFP_ATOMIC);
> @@ -219,7 +219,8 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
>  
>  			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
>  		} else {
> -			skb_put_data(skb, pkt->data, payload_len);
> +			skb_put_data(skb, pkt->data + VIRTIO_VSOCK_SKB_CB(pkt)->offset,
> +				     payload_len);
>  		}
>  	}
>  
> -- 
> 2.54.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
