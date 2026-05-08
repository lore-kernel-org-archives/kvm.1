Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FF630EF68
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255454; cv=none; b=MhBYu1W0jC7+EFC8cnAc3d1lw91g4yd7IbiSfDMyq0aJkItizx22OcWRnkksR0SpSqZ3x6RrcfnGQvj2WxVML2a2+CMI411BdV9c5wE+nXq3gEoWHqP+eOJzvV2HAST+m6UsQRIyQSeHSeXeKF14oWo5RrnoRcBmRiOZSUGQn34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255454; c=relaxed/simple;
	bh=rdDtrTgIi+rN4hhDCNeEhPYuXlZ/J2y+H8n1qLpmtsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiqIBl1Mokpwf8v7OGBznGbDUvmlm7WX/nuxHh7DwELFsoIZtO5Amre6BdMq+aU3NBjbfUageN7Zg0CkDlS0EMcxVGNkLDg1OsLGYj+EbOCns19KAs5ILhvozUJ4u5c/9ELaaA4hBOkqKfHjnXj1Iw/rlM5QXY0Plyn95/KjL5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aoG6h6uw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/xX9xUM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aoG6h6uw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/xX9xUM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778255449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdBAwN+ZE1eYNiJtu0H0OHxl4J/6xgxxgGUcknEIPjk=;
	b=aoG6h6uwWfwPj4Oa7tfZ84TXZPd6AtyEmI8NiLKu8gKOShX/BqNkcKajnizu4aU/VigkYo
	O24rQeO9AtgTGt6t2ZzJzbDkAPxxz8O+adKaswWd9quzmy99cz7cF9Xcr2BkZerIRHS18X
	aSTCZygcYaIzd6WHVJn8MblQGo7ps6w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-z5UDuft_Muekj_ofjhgG2A-1; Fri, 08 May 2026 11:50:48 -0400
X-MC-Unique: z5UDuft_Muekj_ofjhgG2A-1
X-Mimecast-MFC-AGG-ID: z5UDuft_Muekj_ofjhgG2A_1778255447
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-441243ba35fso1882884f8f.0
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778255447; x=1778860247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdBAwN+ZE1eYNiJtu0H0OHxl4J/6xgxxgGUcknEIPjk=;
        b=h/xX9xUM74SzCTbQX9lL8fxCmC6PCt4VBk+g/rJkH6oufrX7DWFPgLsaXL9Ez+15fM
         LbfWbE7PczTQWI69WJLC5OQxbxB/utrtJ91C40HEmubhhj1CqeZedJrxYXbr4zTckvoj
         gqXmoYgZcFy4fL5PVM/F31+8Pr46AtV6MBZ71DPRJ/YVvgALiP5jFVqCGXW7Ym5cpPu7
         lfUvxmScpW3IpeHhzOzNeqcEf9n/BAqk5zgsVuv5VYIRmpbwdreJYavfOT7IBCfOEsKA
         8u/Urd/ew/pRWj3ZSN1r+tyhskEGgm4CMORpRygM+uUjbL4T5SD/O90f0jx1vYxQ8yRK
         hfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778255447; x=1778860247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdBAwN+ZE1eYNiJtu0H0OHxl4J/6xgxxgGUcknEIPjk=;
        b=cRhLgF24BozZoeyQOryO9LVJP+mi2RHVg8y16GLQz4fNLslfXToLxMXL8pYcLGM4sC
         b6jEPZu/sZFbSxSaX6Av6eOHBOS+CpyRVBZc/A4UmwwtRiGaKu9Vh8i875GoOSnvAvO6
         JvD5uMowURLyn9AJE56VuNven83O1JOBXOBrqOtFGvxC2eJWMVw+bxrZZwjrbgTFFLu/
         RiV4k8fpMxzIxKxEd0lzFsbKaO8owXfCxFWbQnL/i7IOj4/KdNxg6Uo0VzKdZ01cT28r
         1teSxr+o3u/b2K1B9C84XfpQMFtQFyG6MMuFeYupX43Xpdl6ICdDg65lmZqJjHa6gqjE
         pSGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/+x6DLSamdo2gFWSYz2DXLojU8U2hVdvcJA4GpQNoPJOOx9HRKlOX6t/F0nGwaRLwRLqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YysVn2QMFDi80jiIEZkmWbGel2Fv0fpHC7q3JgTz6AftxpkOWTo
	4x2IcRr6IOfi2C9vytJU60psZzNWCc6f9sP6Ms1StVOzQ98Y8zqm5YJsKif41VkCL3L+SUlwcXV
	Z6Qm8GCPFAqDsSQ5xrzh2+mTGHFcJZbFnEkNhlJ/MeKVogj0q9T6++w==
X-Gm-Gg: AeBDiesoJPh21e9ExbOyv0H5j/N9sIgYcRcMsZMDvE5s2UcCpMWFob0ND5slI7+6X3V
	/atPL6f7n2PZB6KEEoHZPOn/2l5XZiSJSTRsCE1gYU0MDoBoGDrdYNnlVyGWl5X9u8vXG7cowiE
	kbiCWJzH6MrI/8FqkQhX7zhezEdSQiL86G7ZMFay+iLIVhv2UXNcvKFKByloThqpLmqvahxcA1X
	xFWOBz0QmsXlDdiq0iAXqEXVgK85HW4LrR/V0OXAC1n0H6J+vRDuUAs68gwzShSjBMHntbWCUhj
	91Q7L/XjeoS9cgdiumsGmXCx/fITAomb/CTOpMFYdshnZf9ZhpvApm8o3zNr97juLaM3ktE564X
	aFPJpq8PZfK3hoVK5a79keYhxztfeb+DnpAc7axh0lwPRC07Ua0JmDlgqDk3Y/Pk=
X-Received: by 2002:a05:600c:8485:b0:48a:58ae:9933 with SMTP id 5b1f17b1804b1-48e51f32806mr210416025e9.18.1778255446890;
        Fri, 08 May 2026 08:50:46 -0700 (PDT)
X-Received: by 2002:a05:600c:8485:b0:48a:58ae:9933 with SMTP id 5b1f17b1804b1-48e51f32806mr210415475e9.18.1778255446303;
        Fri, 08 May 2026 08:50:46 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db11fc4sm2280025e9.27.2026.05.08.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:50:45 -0700 (PDT)
Date: Fri, 8 May 2026 17:50:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yiqi Sun <sunyiqixm@gmail.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Subject: Re: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap,
 copy
Message-ID: <af4GIeSEQ_65V5C2@sgarzare-redhat>
References: <afnXIGtswspSEk8x@sgarzare-redhat>
 <a7b95294-3aa6-4bca-9eab-a4bcd0202ae2@salutedevices.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a7b95294-3aa6-4bca-9eab-a4bcd0202ae2@salutedevices.com>

On Thu, May 07, 2026 at 11:03:57PM +0300, Arseniy Krasnov wrote:
>>CCing Arseniy and Bobby.
>
>Thanks!
>
>>
>>On Tue, May 05, 2026 at 12:26:21PM +0200, Paolo Abeni wrote:
>>>On 4/30/26 9:11 AM, Yiqi Sun wrote:
>>>> vsockmon mirrors packets through virtio_transport_build_skb(), which
>>>> builds a new skb and copies the payload into it. For non-linear skbs,
>>>> this goes through virtio_transport_copy_nonlinear_skb().
>>>>
>>>> Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
>>>> As a result, skb_copy_datagram_iter() sees zero writable bytes
>>>> in the destination iterator and copies no payload data.
>>>>
>>>> This becomes an info leak because virtio_transport_build_skb() has
>>>> already reserved payload_len bytes in the new skb with skb_put(). The
>>>> skb is then returned to the tap path with that payload area still
>>>> uninitialized, so userspace reading from a vsockmon device can observe
>>>> heap contents and potentially kernel address.
>>>>
>>>> Fix it by initializing iov_iter.count to the number of bytes to copy.
>>>>
>>>> Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
>>>> Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
>>>> ---
>>>>  net/vmw_vsock/virtio_transport_common.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>>> index 416d533f493d..6b26ee57ccab 100644
>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>> @@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
>>>>  	iov_iter.nr_segs = 1;
>>>>
>>>>  	to_copy = min_t(size_t, len, skb->len);
>>>> -
>>>> +	iov_iter.count = to_copy;
>>>>  	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
>>>>  			       &iov_iter, to_copy);
>>>
>>>@Stefano, @Stefan, the patch LGTM, but sashiko pointed out to a
>>>pre-existing issue you should probably want to address:
>>>
>>>>  	to_copy = min_t(size_t, len, skb->len);
>>>Does this length calculation account for the offset when a packet is
>>>split across multiple transmissions?
>>>If a packet is requeued, VIRTIO_VSOCK_SKB_CB(skb)->offset is increased,
>>>but to_copy still evaluates to the full length of the skb.
>>
>>Yep, I just checked and vhost-vsock is the only place where we call
>>virtio_transport_deliver_tap_pkt() wiht an offset != 0, but I agree that
>>we should also fix it.
>
>Yes, looks like the only place where offset could be non zero is 'vhost_transport_do_send_pkt()'.
>And we set valid length in header every attempt to send it:
>
>                /* Set the correct length in the header */
>                hdr->len = cpu_to_le32(payload_len);
>
>In all other places we call 'virtio_transport_deliver_tap_pkt()' with offset == 0. And thus
>skb->len == hdr->len.
>
>So for me looks ok. E.g. len in header is actual data.
>
>>
>>Looking better in net/vmw_vsock/virtio_transport_common.c I think this
>>is a regression, indeed we have this comment in
>>virtio_transport_build_skb():
>>
>>	/* A packet could be split to fit the RX buffer, so we can retrieve
>>	 * the payload length from the header and the buffer pointer taking
>>	 * care of the offset in the original packet.
>>	 */
>>	pkt_hdr = virtio_vsock_hdr(pkt);
>>
>>Before commit 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with
>>sk_buff") we read the payload lenght from the header that is always set
>>to the right value before delivering the packet to the tap.
>>
>> From that commit, we don't to consider the offset anymore since we
>>started to use `len` from the skb, so IMO we should go back to what we
>>did before it, I mean:
>>
>>	payload_len = le32_to_cpu(pkt->hdr.len);
>>
>>@Bobby do you remember why we did that change? Or if you see any issue
>>going back to what we did initially?
>>
>>
>>Also IMO we should avoid to set all the iov_iter fields by hand and
>>start to use iov_iter_kvec(). Plus, we can just use
>>skb_copy_datagram_iter() in any case, like we already do in vhost-vsock,
>>since it already handles linear vs non linear.
>>
>>At the end I mean something like this:
>>
>>@@ -171,7 +150,7 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
>>  	 * care of the offset in the original packet.
>>  	 */
>>  	pkt_hdr = virtio_vsock_hdr(pkt);
>>-	payload_len = pkt->len;
>>+	payload_len = le32_to_cpu(pkt_hdr->len);
>>
>>  	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
>>  			GFP_ATOMIC);
>>@@ -214,13 +193,17 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
>>  	skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));
>>
>>  	if (payload_len) {
>>-		if (skb_is_nonlinear(pkt)) {
>>-			void *data = skb_put(skb, payload_len);
>>+		struct iov_iter iov_iter;
>>+		struct kvec kvec;
>>+		void *data = skb_put(skb, payload_len);
>>
>>-			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
>>-		} else {
>>-			skb_put_data(skb, pkt->data, payload_len);
>>-		}
>>+		kvec.iov_base = data;
>>+		kvec.iov_len = payload_len;
>>+		iov_iter_kvec(&iov_iter, READ, &kvec, 1, payload_len);
>>+
>>+		skb_copy_datagram_iter(pkt,
>>+				       VIRTIO_VSOCK_SKB_CB(pkt)->offset,
>>+				       &iov_iter, payload_len);
>>  	}
>>
>>  	return skb;
>>
>>And removing virtio_transport_copy_nonlinear_skb().
>
>Yes, this looks shorter and better.

Thanks for confirming, I'll send a series soon and CC you.
Please review it :-)

Thanks,
Stefano

