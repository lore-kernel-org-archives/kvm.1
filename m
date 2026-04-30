Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F113E5EC1
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554287; cv=none; b=NTgzfbJ707HeCxwtB3diEHESqIfb5Q46o8b1lqN8npT2Mjlb5EkkwXOjOeGoD16U+KulEu7p0wJvM4FBJCSm+B29VRGHROfGF3yCL0hS59CsqzHwPpXIFtuDM48yYP6gyJMZfSEEnIqo6dXtxpIWml2nU6G9l4karqAwz7xxpvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554287; c=relaxed/simple;
	bh=Dk9brHbKfFNbGJGzioI4SNCia5lWoLEHi0LrGbaPeqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmXfiGMFdqxLuAm6yBtGrdPihzJ5xBBAOv0e9CammeZpswn1Ok/5F5M1mumGddNvcN6D/g0uXIgOUpGmWqIPfRKZ2U9jbDceZrz0SyamQeIicKaZtpHI5Yh+5UhIaD1ZnHLS3mP+nFgjbFJ+v0pTY907+mf0ap5RSmSOfHEF+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGlUyu4r; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=POTcm97i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGlUyu4r";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="POTcm97i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777554284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4iM1C5bPOK6CsY7bMqOIntIdxAE/svN63ooTIzddU6M=;
	b=ZGlUyu4rbOPVnW4Sr1iIvILnB3w43V+YJDxJ1yHvjiV/UlSXj1cD0OAZo3lmAdYseokGMb
	rlgba/lLn2FVt5AmAN24j/uL6hIIk59CO6XG6vRpTIfmaI5REgQK9ORhIsMbv2k7hhCf80
	qkshYq4W3135MLlOzZbdyc+5349FFSg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-7IJRoLU3P_KrS3f3Zn_4iA-1; Thu, 30 Apr 2026 09:04:43 -0400
X-MC-Unique: 7IJRoLU3P_KrS3f3Zn_4iA-1
X-Mimecast-MFC-AGG-ID: 7IJRoLU3P_KrS3f3Zn_4iA_1777554282
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48919890a95so6589635e9.2
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 06:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777554282; x=1778159082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4iM1C5bPOK6CsY7bMqOIntIdxAE/svN63ooTIzddU6M=;
        b=POTcm97iezuPZHqF0RvZ1r7OFeiV8TDsuFww9kPOTy5qXjT6k+smCN2BzrSSRP2zRX
         YMYHmpLE4gqRM4OrBSpe2pGideFti0061hbCb5Sw/T9AJ5cW49YqtaprYa5fBbnNrDPD
         ayjK//nCMh6OjbCNexe1Hllnk7K7DQ3XdXAkSU8+HKvyrJ2SQ/Tox1ZQvb8iLnDsJDNY
         V5Taor7rsLr1ehAiKoKRP/7bRt4zN3TTzTHDQmnHsqT+ffKvdx5vpcika7oxNs7SLbpS
         Ku6+BUag+ciarVWBDfaCPCe1N9Q1AEpV4fCfhCDbR2cJWyM9ftP6xY+j0bkdSatTVUQD
         SGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777554282; x=1778159082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iM1C5bPOK6CsY7bMqOIntIdxAE/svN63ooTIzddU6M=;
        b=Q2mqd10T+s1IRMWjRqyJirh9Gn/2m799A6+mDFWjCO0ZdtkH77bX4iOA8NOKtyOb6W
         A4mTs3YLMU3u0Or7Udvh1gnk9/OiPj7OXcuUHPZ1A4ArvkjJA78T29t68REsgj913kqN
         wNQntSoSCNab/7IWETzTqV5RGofso+tMAoWYCEfFWSnA7ykZEJ3F04guhyhVeI5D0VyY
         kfGOjWgP3NG/vzebFEdCtG6svWjU/Hr55gPsk+0SeUzx3UJi56h9kgMrLbn5vlskc1B5
         +TfNWP3sgyzUI/tdJWiMqczGRA0YIkS4dF0C8AjWB0AB9PBm2tf9DmXZquZPzv7zNsS1
         24Jw==
X-Gm-Message-State: AOJu0Yx8CeS3NA0U21FmWiRFLq7eKTMTA2QXM0IMcYRvRJ5/M6bPzlCi
	vJyK1xjSnXhkZRL29Kr/91XS3BL2QUX8l1E8pmOIjLCW24zzpn+CCYCcRDZnbx0oR85nptNlsmH
	X01GE1ju70BryXflr33DDK6YWsbYYr2zL/VcYL7OFHILhKjby1ZI2AQ==
X-Gm-Gg: AeBDies6jckwcSPqWE9oE+uuoCsZjZAAJQ1k+ha3qlghbHyIaxSoFPjk4wjhQ5tLBiX
	1jqZ5B5HdMU1/xJx6AW9gKDNmB83RaAFwYW8P51A2i03E6HJZZpViMKKRuQx6tX0YRuAXWfQrYo
	MCGITs3qxKT+Ib0hMANvWqS4OmeyYbaeiRVjARh3gdOYEOjNz96PsfakKsJpUGQkG9+BoUoM6+r
	pL1CnRxih38OOyvz0opVHNKhJFJt0x2ihh5JsfpfOtUBU5BtdO9J+BXtymUf7K8ZijZUvpf9wHV
	hpHJyp1EUU/8s2eYplzm/AIB4zlVmBQCiRn7Wa40x+OVEv8VhNWrad5tL1QiYp3wwlxSDl3io6h
	IB947b9KcOqlBWzEVC7U+RL1hjKfmqsF2SlS1Xg==
X-Received: by 2002:a05:600c:6992:b0:48a:56de:d62a with SMTP id 5b1f17b1804b1-48a83d7b059mr51482205e9.11.1777554281980;
        Thu, 30 Apr 2026 06:04:41 -0700 (PDT)
X-Received: by 2002:a05:600c:6992:b0:48a:56de:d62a with SMTP id 5b1f17b1804b1-48a83d7b059mr51481435e9.11.1777554281407;
        Thu, 30 Apr 2026 06:04:41 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301b7bsm71336415e9.11.2026.04.30.06.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 06:04:40 -0700 (PDT)
Date: Thu, 30 Apr 2026 15:04:37 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Yiqi Sun <sunyiqixm@gmail.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stefanha@redhat.com, 
	sgarzare@redhat.com, mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap
 copy
Message-ID: <afND89LDgovPpanE@leonardi-redhat>
References: <20260430071110.380509-1-sunyiqixm@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260430071110.380509-1-sunyiqixm@gmail.com>

On Thu, Apr 30, 2026 at 03:11:10PM +0800, Yiqi Sun wrote:
>vsockmon mirrors packets through virtio_transport_build_skb(), which
>builds a new skb and copies the payload into it. For non-linear skbs,
>this goes through virtio_transport_copy_nonlinear_skb().
>
>Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
>As a result, skb_copy_datagram_iter() sees zero writable bytes
>in the destination iterator and copies no payload data.
>
>This becomes an info leak because virtio_transport_build_skb() has
>already reserved payload_len bytes in the new skb with skb_put(). The
>skb is then returned to the tap path with that payload area still
>uninitialized, so userspace reading from a vsockmon device can observe
>heap contents and potentially kernel address.
>
>Fix it by initializing iov_iter.count to the number of bytes to copy.
>
>Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
>Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 416d533f493d..6b26ee57ccab 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
> 	iov_iter.nr_segs = 1;
>
> 	to_copy = min_t(size_t, len, skb->len);
>-
>+	iov_iter.count = to_copy;
> 	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
> 			       &iov_iter, to_copy);
> }
>-- 
>2.34.1
>

Thanks for the fix!

Tested using vsock_loopback sending zero-copy packets. Payload is always
zero before the fix.

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

