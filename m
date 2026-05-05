Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1CC42B74B
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 12:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985067; cv=none; b=PJo0cY7gkYm7yaSrDFD1wFWPYxxzef5MzfA8BguGn4qSxAn1rJ21BVZxUjpumZj+aL2IqYcQTl6tV6S2DHkkXs4ijRLoTgeOI3FNayKcwGSNyiCPJ3vXMHS03FWszE9PTzEGgDBLNY3zPCXpgEVYEbUZKAto/dPWcPIWmvl4/6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985067; c=relaxed/simple;
	bh=hz98aOu66uNVwuTZiRLja0C8i6pImQOrnxxcY7S6SyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNjH1+ApCxrCn0mrZbAvEovWQ0xhMMMM9pwwm1zaxS7V71DKbaN7Wg+dwmeYXgbEiIbek5jSttefwUVWHWFOGN86UkNd4T1sajNS0k5mZg3uQl6FWF2rkGZt2AV3jT1urRrYpJWLx1W3JQlnbrzumE39caTnEAno6v9IY+kNP1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O13TYAgy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=byF3Z4NU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O13TYAgy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="byF3Z4NU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777985064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwSGsuiyqii/zr4WOQ6nXZFN/nOITIhLrEP6HdZcP9o=;
	b=O13TYAgyv9xiC2+hXXw8m5lGy5pTc2ImcSABHyF82UKo7zSeYqIjCd+XzkhN0u88pHCMhL
	RPoxsK+o6mC1dAz65nfS9+JCdsbuWfd+TR2uP8eX8QhguvSEC1bBO1hKWvhTGKG7JP6td6
	uTUPjipa6xz2XWsehq1M/hwy0rIRj90=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-ng9VVryBM32ZYPpC_Fk_Uw-1; Tue, 05 May 2026 08:44:23 -0400
X-MC-Unique: ng9VVryBM32ZYPpC_Fk_Uw-1
X-Mimecast-MFC-AGG-ID: ng9VVryBM32ZYPpC_Fk_Uw_1777985063
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44d68ed8f95so1650244f8f.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 05:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777985062; x=1778589862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jwSGsuiyqii/zr4WOQ6nXZFN/nOITIhLrEP6HdZcP9o=;
        b=byF3Z4NUEDg841ZEoHUmvCNTzJvR+1RkguBk03pNuHAPFut56h3rF3Z6rhBy2M2/eX
         lRTxHBSTOsp4B/F3py0jWUuB2T/cKWiYEpLTKy+/TIzX7dVwjQ+Wc3C2JB3ZYWjBVknz
         SI/14BsPswu07ortmuBvosS9Ez7gWvWwCYNEtICF3vGPjcaWnzYvYEFz/MwPrCP2psuc
         /npu9MKC28KazhFdInaG6A1hvbGCnGNDQqOI7Y72O8lPmddseVK3aIWgeuJM1QIE6j3j
         ideBFHaIwZX5xoIOMB8UngkTaBjOutOb8vj1uzAC9skDJp2LWXr6upb4zspNsSSa2ssY
         nHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777985062; x=1778589862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwSGsuiyqii/zr4WOQ6nXZFN/nOITIhLrEP6HdZcP9o=;
        b=cQWxKJQzIgLlbIYkmY2nKZy0IzG4n/Js8sEMqptFMuxZnvE3Iyz/EjspMhKBvGTyOH
         r2xR797YhwNICgqZp0x5MwKtgXf4PRsHqY2tIKL/WXW8ncwe9Y1yOUkR9S6Gngwm0qLq
         Tizv216J4I25HG5MLSbxZ+qJbI87f0TQxU3YCLrDOnDrrmlavWXeeOX3Nzeshhumph6k
         mrO/3t9pKK8hcPUEdK+yEjRXJfwVSF4E1JF2XEO+78DfTw/AzeP8vEqfwMylHjcA00gS
         ReUjFjUH/Y2PABtaBIp0DD19VphNH9sck4W03zaB6qeQtDcfNBhNox8BM9LQ+MiFcVlY
         vvWw==
X-Forwarded-Encrypted: i=1; AFNElJ+KGYD/nhsFqrQFknwRmH/H7zNNSPTijykvFDrt0JWSMPh2z3B9qr5VQ9NJA5WWcP7fROU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWfT2dSkeIK5mMTm17jibYiX4L7hVye8vEW5i4ocI+HWHUh3ii
	9K1IwpNB7c0UN5dp9LMEIOCZriWMza+Wkwkyy7FF9g4H4Kz1HWZSQc4O6no4jrr/C3ariSdvl3e
	yi8HyOI/Yovl12qkyQOyv8IgiKOY4RszOKA/aiQO74ivSrdsHwpaV3g==
X-Gm-Gg: AeBDievhGivVK/me+y+gH1VbMUcvUiOHFI5LgF162ool+PNIis7V+95e20ACStXqst4
	mjCZvBZJXktkgQWh/R2QKg1MHfI7il8L96D+yddKY6wY9SaWKEdyL4Fhw/Ji0X/HYoFt3iinXn5
	fNgtZVYLPjB7In4klVFwQAD9djl3VzQuMqaWDmmnIfVuSGBvjzQNIfSFAkUQOW/MdNoU8yhjpbq
	97gRM+VtVvC5+9d9pIyWoaZ178KFXgPE34CFAW8mDqrKcFc0hgiU31N/HbGQBrO+mboWbT75dps
	y6ZJazvvKCy+hXbn0dfxtMUmJnLP+bYCPL157ykWX1HTYxjwlGdCH6NZsda7q0GvLUKbIm1C7Cn
	fDk45yGLzylVWzcNCAzjWGrDu+i69sKfQn+fMdG0pMSHGm1KBtZ7GlPtReb2BqR39YI0AeSzIbw
	==
X-Received: by 2002:a05:6000:186b:b0:449:b7dd:4a75 with SMTP id ffacd0b85a97d-44fdee4405cmr6456579f8f.20.1777985062381;
        Tue, 05 May 2026 05:44:22 -0700 (PDT)
X-Received: by 2002:a05:6000:186b:b0:449:b7dd:4a75 with SMTP id ffacd0b85a97d-44fdee4405cmr6456485f8f.20.1777985061805;
        Tue, 05 May 2026 05:44:21 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505238e6e0sm4243514f8f.6.2026.05.05.05.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:44:21 -0700 (PDT)
Date: Tue, 5 May 2026 14:44:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby Eshleman <bobbyeshleman@meta.com>
Cc: stefanha@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	horms@kernel.org, Yiqi Sun <sunyiqixm@gmail.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Subject: Re: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap
 copy
Message-ID: <afnXIGtswspSEk8x@sgarzare-redhat>
References: <20260430071110.380509-1-sunyiqixm@gmail.com>
 <f4e52dcd-59ba-4c2e-9936-49cf27528b21@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f4e52dcd-59ba-4c2e-9936-49cf27528b21@redhat.com>

CCing Arseniy and Bobby.

On Tue, May 05, 2026 at 12:26:21PM +0200, Paolo Abeni wrote:
>On 4/30/26 9:11 AM, Yiqi Sun wrote:
>> vsockmon mirrors packets through virtio_transport_build_skb(), which
>> builds a new skb and copies the payload into it. For non-linear skbs,
>> this goes through virtio_transport_copy_nonlinear_skb().
>>
>> Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
>> As a result, skb_copy_datagram_iter() sees zero writable bytes
>> in the destination iterator and copies no payload data.
>>
>> This becomes an info leak because virtio_transport_build_skb() has
>> already reserved payload_len bytes in the new skb with skb_put(). The
>> skb is then returned to the tap path with that payload area still
>> uninitialized, so userspace reading from a vsockmon device can observe
>> heap contents and potentially kernel address.
>>
>> Fix it by initializing iov_iter.count to the number of bytes to copy.
>>
>> Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
>> Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
>> ---
>>  net/vmw_vsock/virtio_transport_common.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 416d533f493d..6b26ee57ccab 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
>>  	iov_iter.nr_segs = 1;
>>
>>  	to_copy = min_t(size_t, len, skb->len);
>> -
>> +	iov_iter.count = to_copy;
>>  	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
>>  			       &iov_iter, to_copy);
>
>@Stefano, @Stefan, the patch LGTM, but sashiko pointed out to a
>pre-existing issue you should probably want to address:
>
>>  	to_copy = min_t(size_t, len, skb->len);
>Does this length calculation account for the offset when a packet is
>split across multiple transmissions?
>If a packet is requeued, VIRTIO_VSOCK_SKB_CB(skb)->offset is increased,
>but to_copy still evaluates to the full length of the skb.

Yep, I just checked and vhost-vsock is the only place where we call 
virtio_transport_deliver_tap_pkt() wiht an offset != 0, but I agree that 
we should also fix it.

Looking better in net/vmw_vsock/virtio_transport_common.c I think this 
is a regression, indeed we have this comment in 
virtio_transport_build_skb():

	/* A packet could be split to fit the RX buffer, so we can retrieve
	 * the payload length from the header and the buffer pointer taking
	 * care of the offset in the original packet.
	 */
	pkt_hdr = virtio_vsock_hdr(pkt);

Before commit 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with 
sk_buff") we read the payload lenght from the header that is always set 
to the right value before delivering the packet to the tap.

 From that commit, we don't to consider the offset anymore since we 
started to use `len` from the skb, so IMO we should go back to what we 
did before it, I mean:

	payload_len = le32_to_cpu(pkt->hdr.len);

@Bobby do you remember why we did that change? Or if you see any issue 
going back to what we did initially?


Also IMO we should avoid to set all the iov_iter fields by hand and 
start to use iov_iter_kvec(). Plus, we can just use 
skb_copy_datagram_iter() in any case, like we already do in vhost-vsock, 
since it already handles linear vs non linear.

At the end I mean something like this:

@@ -171,7 +150,7 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
  	 * care of the offset in the original packet.
  	 */
  	pkt_hdr = virtio_vsock_hdr(pkt);
-	payload_len = pkt->len;
+	payload_len = le32_to_cpu(pkt_hdr->len);

  	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
  			GFP_ATOMIC);
@@ -214,13 +193,17 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
  	skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));

  	if (payload_len) {
-		if (skb_is_nonlinear(pkt)) {
-			void *data = skb_put(skb, payload_len);
+		struct iov_iter iov_iter;
+		struct kvec kvec;
+		void *data = skb_put(skb, payload_len);

-			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
-		} else {
-			skb_put_data(skb, pkt->data, payload_len);
-		}
+		kvec.iov_base = data;
+		kvec.iov_len = payload_len;
+		iov_iter_kvec(&iov_iter, READ, &kvec, 1, payload_len);
+
+		skb_copy_datagram_iter(pkt,
+				       VIRTIO_VSOCK_SKB_CB(pkt)->offset,
+				       &iov_iter, payload_len);
  	}

  	return skb;

And removing virtio_transport_copy_nonlinear_skb().

If you agree, I can send a proper series with these changes that should 
fix the issue reported by Yiqi Sun introduced by commit 4b0bf10eb077 
("vsock/virtio: non-linear skb handling for tap") and the issue 
introduced by commit 71dc9ec9ac7d ("virtio/vsock: replace 
virtio_vsock_pkt with sk_buff").

Thanks,
Stefano

