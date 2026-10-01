Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE7736D9FE
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862163; cv=none; b=Ua1MLmYjxO/phUFjFaWB4Dyj1fPQEt1MVHHCtwaa2CQ43SsTkAsPfhzb0gBjLv7QGvlU/iGG1iXFe9RknDESXEHMk88Ylxnyt4iswwkFtZmzHqYtEtMyH8eWBATKFD7LzgBmy/+J8kdmDoX8inUvsCTug0e41vW2JR+/EeOCwR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862163; c=relaxed/simple;
	bh=9/+tCd94iL8kXeGB2Qg2OUOvm2WiWKuY0gLzpz03J7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdZSfKUpfZoda7ld32iIIK7atU4bqOBRjsz4qJDXMTPrI6h6hAU4nXq+fHmjufGrMcpqSRMJqAdqyCoG1K+Ttrqk0krdjdjdBOxqnUoyWGQf54/pylJmlkqu1FTfK/uzqBIwAKbptfXHqiLMto1drvhzkec8jRMjl6nfNQXSLaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QTyyRQ0p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/ur4ZQj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTyyRQ0p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/ur4ZQj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790862147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cu6OcuQYFoTCH5UaDqxha9ec8EBwkEwB9eRLNdJBaGY=;
	b=QTyyRQ0pUyBRm8p1rQxc+2zJyFrcRD9DKXhoiz16hFWVcquClWAJoOyujxrgjhbO3amRlY
	vldD8XQA96kjVWsszxzOf7z0Wke+p0GKRlpDjkN2bxk57cOK2IIwmR2hvPg5BNRL6QeE2Z
	FN13ORxdrD1b3zKVHg1iJp6UIN92Asc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-KJczQFZMPBKNeM8kIlChOw-1; Thu, 01 Oct 2026 09:42:26 -0400
X-MC-Unique: KJczQFZMPBKNeM8kIlChOw-1
X-Mimecast-MFC-AGG-ID: KJczQFZMPBKNeM8kIlChOw_1790862145
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e735659b7so49191335e9.3
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 06:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790862145; x=1791466945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cu6OcuQYFoTCH5UaDqxha9ec8EBwkEwB9eRLNdJBaGY=;
        b=i/ur4ZQj65xDkONUTm63ZH3iuOFIQSAz8NPNbrydMr6Mpxm+s8wh/tmZJe91DyTK80
         d8OsnbqU6cauSnkT4sgkUW7a5sGpul5D6ir0chQrNgzWu2UusOHU2WVTpcyZ+YpRsPtg
         qMqhcWR2PLzu7YTnRhYO9vYhLtTFYCbQFJOFw1e6L74JBr0WnoRIuzUKJC4c6BGMEjM3
         g6PVZMMQ7zlx6y+7C6pD8Qq4GrZks8zQlFmpHUVYHpHQeAVmD8ckQkK+Sv8sPofBJAJU
         iDUla7wmtIJJmv9oTNKx+qelyn5GmkH4vZGt3FiiN1CgB58caIt+a8SV00jgJUFE4OdZ
         2OOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790862145; x=1791466945;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cu6OcuQYFoTCH5UaDqxha9ec8EBwkEwB9eRLNdJBaGY=;
        b=plCSFGaO6jZF+KV7bGzFIqcI3GIB7Sb/rZnWXe4FmN8sgZVehmwhgjPQ++q6YM4VFN
         kp1p3xfPZ1SSiyr6OxCj5TzwVGcdl0P5q55ftgdn65WQeoyWMgyaW7Sm2ENMiPNdN0Xr
         w3p86BIg6J54+UtWcVbTZ62CuE+DkLsyw/Kwnf4dB6X9ez7f341WKU4vi9D6/lv8Kg5s
         qn1YwDTXIVzV53SJ5QoUun0FpVBoM/3xcR4AyX5/MUQkxl6eEOsr3OxBEq0/NUdtVCox
         5vnUIDgR6h2ee4yI6ZjXP4MaJjehkPrukkyDsSrCaCHb3pbf8jJOl7tSRAq/0AkEnEMv
         neqA==
X-Forwarded-Encrypted: i=1; AKwUvBzNGfrYRTbIXWprz/5P+w8vPzXbHGYQWdZxBrQSAroy4N7acL4mAQ/qU4gmBLrygpKhX9E=@vger.kernel.org
X-Gm-Message-State: AFuF++mKsH6rO58llwcxhzIzUD71BhOtxDO8JpmMosrBezfEiWNBbv+9
	WNys9DQyzGArJnVMIw26S8XqfqBlmN86hpuhG+GF5Xh5/x/9VIMtHx46yB+LTXrY+3YIfzTqlB+
	yGO0vx5B+OEVkXxQnHJestw72oIt3cMGv5pRLPA/+qD5AUty+QA7tyw==
X-Gm-Gg: AYBFou0bxOb9tl5ETSzs86TkDa0EmOo9UlD4e6uJwRDAL9H3MwMAV4ZegYYZvBlvJb9
	pDMRZvqMbKhDHKh2Xz+/rcJYjF4Werdgp0CAiXqCqBHYYVcLew5vak0iScrbjejflltDVxlldZk
	o/k4gAQLlRxPKQiiNIE71wSWoIK2fMNhx4JI05ZMwDhaH1/xLsFFs/whOkxjHeEtRWWfzOe0/cs
	6H6dDx+JYPl9EBmFOtt5QuuUWFeXBzmgdR/D8YIkCv67eoq7DkW0LiT7srnk7ldkgD3Dtv1YuCJ
	jXVe75oH4iuDrRi5411Zz72OVa+7XwiMq+lw4cW8jNDwg5BSavnPGotqn872tlZi4pFfZkqig+V
	GCQ67KFolFKN5onEyder++cZ3VVXEk6aDcbw=
X-Received: by 2002:a05:600d:8652:10b0:4a0:25fe:a4f with SMTP id 5b1f17b1804b1-4a025fe0b7cmr6753575e9.26.1790862145211;
        Thu, 01 Oct 2026 06:42:25 -0700 (PDT)
X-Received: by 2002:a05:600d:8652:10b0:4a0:25fe:a4f with SMTP id 5b1f17b1804b1-4a025fe0b7cmr6753205e9.26.1790862144781;
        Thu, 01 Oct 2026 06:42:24 -0700 (PDT)
Received: from leonardi-redhat ([176.206.38.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f984d89sm81821335e9.7.2026.10.01.06.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:42:24 -0700 (PDT)
Date: Thu, 1 Oct 2026 15:42:21 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: account only unread bytes in read_skb()
Message-ID: <ar5gU4DSSTUuGi8P@leonardi-redhat>
References: <20261001121541.2983379-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261001121541.2983379-1-4ncienth@gmail.com>

Hi,

what about using `vsock/virtio` instead of `vsock`? We are changing
just the virtio parts of vsock.

On Thu, Oct 01, 2026 at 09:15:41PM +0900, Daehyeon Ko wrote:
>After a partial stream receive, rx_bytes tracks the unread suffix while
>buf_used and peer credit still cover the whole packet.
>virtio_transport_read_skb() dequeues that packet but passes pkt_len for
>both counters, underflowing rx_bytes.
>
>On a connected CID_LOCAL stream with an SK_SKB verdict, a 40-byte read
>from a 100-byte packet made SIOCINQ report -40, an empty recv return
>ELOOP, and poll report the empty socket readable.  After verdict detach,
>receiving 40 bytes wrapped the counter to zero and hid those queued bytes
>until one more byte arrived.  The fixed run kept the counter balanced
>and exposed all queued data immediately.
>
>Subtract only skb->len minus the VSOCK offset from rx_bytes.  Retain the
>full packet length for buf_used and peer credit.
>
>Fixes: 45ca7e9f0730 ("vsock/virtio: fix `rx_bytes` accounting for stream sockets")
>Cc: stable@vger.kernel.org
>Assisted-by: LLM
>Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index f225f53ed4bab..1e762a480df49 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1927,6 +1927,7 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
> 	struct sock *sk = sk_vsock(vsk);
> 	struct virtio_vsock_hdr *hdr;
> 	struct sk_buff *skb;
>+	u32 bytes_read;
> 	u32 pkt_len;
> 	int off = 0;
> 	int err;
>@@ -1946,7 +1947,8 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
> 		vvs->msg_count--;
>
> 	pkt_len = le32_to_cpu(hdr->len);
>-	virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);

maybe it's worth adding a comment? not a strong opinion.

>+	bytes_read = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
>+	virtio_transport_dec_rx_pkt(vvs, bytes_read, pkt_len);
> 	spin_unlock_bh(&vvs->rx_lock);
>
> 	virtio_transport_send_credit_update(vsk);
>
>base-commit: e23a64eb244356ee47c0620f0722d51bd88db522
>-- 
>2.55.0
>

code LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

Thanks,
Luigi

