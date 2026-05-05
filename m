Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A6E48B369
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997483; cv=none; b=NPGnKWtXcQS+bgIWI3gE7Z40UwvSp5px+ufIu4OSo+nP+HPqfqtostW32xh8fH8I8fjH128uuCLIeLcwFDB5UOC8AdBFQ+QUJk6aHG3q4rz20/imKgE2IsJ5AEitYEyLQlFjrBQ9kRAnpQ7+2vBWeAXTC0HS8/rZknU8IkMts3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997483; c=relaxed/simple;
	bh=NZswvJER178yJggzp3PBiIDtYWsGq7nDkywdtiyUvBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fxfk6Y1XS7TaLx9GN6S0xhNA2Y+ptaJeGdVli4/G62aYrXXEvy9pgQOtvzkIzVz8WMrouBxfZmdsfhsCmNHvS5caN10G3nCfqNgjCDaWy9C189KwzH9aLb1amY4eLbocC+fJY+VROL+57Gu86G4vvvC12fdi6YpfyrU9FmhpTY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T++K7Hd1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPQHiS0t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T++K7Hd1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPQHiS0t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777997480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDx07l4ozVnxxK7UujBIhmzxsF1zsTEyokH05DVKlSg=;
	b=T++K7Hd1HS1HwpoZEaAYUQIUKRSVQKnYUdg6zjxq/NkhuJdzE1TUD55UlBTNSvMELIxMy9
	80EGdi10eNZOg5vM6herTQTvE3ezcw6Pz4S7jQwmRah6uSVIZX7OZTwkO/N/zuHNMzUUGV
	YwxXgXdVZ84M7PM7VrDw/vDeH9JbXoM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115--ZTfw304PyycMLegVBYIUA-1; Tue, 05 May 2026 12:11:19 -0400
X-MC-Unique: -ZTfw304PyycMLegVBYIUA-1
X-Mimecast-MFC-AGG-ID: -ZTfw304PyycMLegVBYIUA_1777997478
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48919890a95so35929325e9.2
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 09:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777997478; x=1778602278; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cDx07l4ozVnxxK7UujBIhmzxsF1zsTEyokH05DVKlSg=;
        b=jPQHiS0tjibLAhDCU6AAtsPYhuwHzyTPfWQ4l/Z8rBkOTMEZTJ0yuUFp00U/mjfmUK
         RQN9MQLCtOcEPiaPZC4OFOsnxcHG/KLrhJw9/G/s9ckv+EefHUYmyPADaN93SpVUfScA
         +j2S3Asipgu8f0h7V4kUn1KxgduO/mcG6KbB0OoWa6irXCBKXqA6F94CLtZ1ffoHM1++
         BlO36tl4Ni0RWf0twBi+e0zXtT9F0l/PSL92AnSHejzNe/x+rdOELiLZZANyd7pwagiD
         WHC0uCvs7KkmIXFevErB8v4MIXNKAWyJXhug0/CpJfiVvwwUJ9AX35I1uKDZdRYxzscs
         oCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777997478; x=1778602278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDx07l4ozVnxxK7UujBIhmzxsF1zsTEyokH05DVKlSg=;
        b=K36CqSHw5ByLaGC3vJkvwjze+/1xTOffF2qHZGkJb4241VUaKq7delTLrw4aKvSEjA
         FKEF4OJbqHD0S9norHv4K7OsZqszrpKQEZQ4s7Uv51WKhBLg5hGaidXWBlqAv/cBoKxg
         55E8KHyWOC5GVxxyt7zO1RBE1zpm9LMpBVspOtMqSIn7dEk0yYZJKrgdthl0sOARo+YH
         qUY/qlHIAJPgXjNRZI5ZGPO7/bkHPR8aPt+bdMZFPgVU7Hmh80whh/Z/kjJO3SiyPv2t
         IR3rYwARhgxFCFNjL9KBNP0teGTKbVQhAnPsAfYOt2F1VPl4R1Dwk0LbXdLLH4b7k9Pl
         IBpw==
X-Forwarded-Encrypted: i=1; AFNElJ9KzwW1nJ9LB31SwddBOCIFz6NLfsT412MKwj4CFEWArGIRNsl8v3WwR1Dw4fgNHEJOTlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbJWjPA6VjLrf519bnQS6wQPirrx4qY36kLxCWtyTix9lXtAfA
	CsgYTXLb+5avFjlg89TOUPg1ohYrYZ++MnTbnjCGXiw7xxK2W8SXaGb+Ju7h1WBRagCUEKRzzOP
	OmUlBT4iVPpj/KzzLFFgUBVlUWV9c+Vs+MsjsMjxkZPb7X6g6CaVFBA==
X-Gm-Gg: AeBDiesvLrmHoXvZfUtnd46l2t/HsrOJqt6gApfAtJYXw2hWHzqH0D3AjCT6eKw47Cv
	N/wuv/2gigNby3+fV41mlYZg5Ukvi+00znCAlaEVYITOFCDkC4Vd6hJfRNNYk8VhxI5SP5+Kmev
	8FFOu/r4XbJAwU5OFRRrRPdIYydGt+zkx55CRWgyv2+rVXOy8hpKsFwuWgb7uXunIVJl2jIxzgJ
	odP8h3abjd/C3TkFyRY/GGa+GpxMoJN06kRa2nlXZk5kHaf7ppemPQwL8nDf0t/eue/HZ6QPI66
	kfAM+jRuv1NntAQHK0I2P0M8synepi6XLTsAjH7oWYGhB+OtNHMps3ri1GP8dwOIz7l328k60bb
	U6EC7yh/1ypReYP39tIJOpNXPRmwTKpTN5a3KbJ/hp9AbRoRYXIQoP/pcF6TqjIztXyvrXDqBRg
	==
X-Received: by 2002:a05:600c:1d0d:b0:488:8840:e5ae with SMTP id 5b1f17b1804b1-48e51c723bfmr551455e9.24.1777997478329;
        Tue, 05 May 2026 09:11:18 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0d:b0:488:8840:e5ae with SMTP id 5b1f17b1804b1-48e51c723bfmr550795e9.24.1777997477746;
        Tue, 05 May 2026 09:11:17 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8ebb3dc1sm380443525e9.14.2026.05.05.09.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:11:16 -0700 (PDT)
Date: Tue, 5 May 2026 18:11:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eric Dumazet <edumazet@google.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <afoF_cHfl6ygcupM@sgarzare-redhat>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>

On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
>On Tue, May 5, 2026 at 6:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
>> >virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
>> >
>> >virtio_transport_recv_enqueue() skips coalescing for packets
>> >with VIRTIO_VSOCK_SEQ_EOM.
>> >
>> >If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
>> >a very large number of packets can be queued
>> >because vvs->rx_bytes stays at 0.
>> >
>> >Fix this by estimating the skb metadata size:
>> >
>> >       (Number of skbs in the queue) * SKB_TRUESIZE(0)
>> >
>> >Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
>> >Signed-off-by: Eric Dumazet <edumazet@google.com>
>> >Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> >Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> >Cc: Stefano Garzarella <sgarzare@redhat.com>
>> >Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> >Cc: Jason Wang <jasowang@redhat.com>
>> >Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> >Cc: "Eugenio Pérez" <eperezma@redhat.com>
>> >Cc: kvm@vger.kernel.org
>> >Cc: virtualization@lists.linux.dev
>> >---
>> > net/vmw_vsock/virtio_transport_common.c | 4 +++-
>> > 1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> >index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
>> >--- a/net/vmw_vsock/virtio_transport_common.c
>> >+++ b/net/vmw_vsock/virtio_transport_common.c
>> >@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>> > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>> >                                       u32 len)
>> > {
>> >-      if (vvs->buf_used + len > vvs->buf_alloc)
>> >+      u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>> >+
>> >+      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
>> >               return false;
>>
>> I'm not sure about this fix, I mean that maybe this is incomplete.
>> In virtio-vsock, there is a credit mechanism between the two peers:
>> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003
>>
>> This takes only the payload into account, so it’s true that this problem
>> exists; however, perhaps we should also inform the other peer of a lower
>> credit balance, otherwise the other peer will believe it has much more
>> credit than it actually does, send a large payload, and then the packet
>> will be discarded and the data lost (there are no retransmissions,
>> etc.).
>
>I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
>state to account credit")
>and find a better fix then?

IIRC the same issue was there before the commit fixed by that one 
(commit 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with 
sk_buff")), so not sure about reverting it TBH.

CCing Arseniy and Bobby.

>
>There is always a discrepancy between skb->len and skb->truesize.
>You will not be able to announce a 1MB window, and accept one milliion
>skb of 1-byte each.
>
>This kind of contract is broken.
>

Yep, I agree, but before we start discarding data (and losing it), IMHO 
we should at least inform the other peer that we're out of space.

@Stefan, @Michael, do you think we can do something in the spec to avoid 
this issue and in some way take into account also the metadata in the 
credit. I mean to avoid the 1-byte packets flooding.

Thanks,
Stefano

