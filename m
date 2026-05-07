Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777A8371D00
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778145012; cv=none; b=nuR5UO+7/BnjCNq4iv/iVQHp0iTvPExWz+Sti4cYCBqscUOSo50jvfCYKHpjcJ8/ZSneslc/NEd7gRdcyIitiW+RDnIiXxhhCshfzLQoaml4vJeXgH/sSGUR2WI10HddefaoMaRqfyIfkdHool6khICzKNkudrU4fVTgbp5c3W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778145012; c=relaxed/simple;
	bh=Su7MqlfynL8vSWqkM5vxWmtynu5V1wq3cdMpdL7zE08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMdrAHQ78hJ35frn2iiaCIyZvXlUfblkFaMF6pliNOsinBNTG9Wa8JqmvCBA//QNudf9MZkFZ6ouSm8LsWUNOS0w8w1JsbomEI47GQ+cNQB1w6p/HkNJXOk+cM7idmUHtzQS7x4jxmcZaNbaErE6fD0RktG58eqIfQOBPJ1T+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bWv2xYON; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eb1iyvKb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWv2xYON";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eb1iyvKb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778145001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0+Dw+cwNE8SIW/NQeUoL6sJg8a8J+n/owA/XlUfbDM=;
	b=bWv2xYONscM92OeCdL00yrt2ta2kVDB5d1oHRxbvx91RgNaBao4VIyY0ohI94XfdNbT42O
	em++TBOyUY1TTJSb37WZgoRpuBe/pxcCIy/h+g6GZeyNjKnIxEWMNEzyjdYYbqtBi1ut/m
	w2U1kjQp5SjhTC7lma1FbIAdo0/5pbY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-yWBIPQKeMIa5W366vs-4pA-1; Thu, 07 May 2026 05:10:00 -0400
X-MC-Unique: yWBIPQKeMIa5W366vs-4pA-1
X-Mimecast-MFC-AGG-ID: yWBIPQKeMIa5W366vs-4pA_1778144999
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44a52d5e572so363745f8f.3
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 02:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778144999; x=1778749799; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r0+Dw+cwNE8SIW/NQeUoL6sJg8a8J+n/owA/XlUfbDM=;
        b=eb1iyvKbS1Hz0+ztLNwNgMd/5ZzHj91ouzO9jQhldkmdSa7ZEoTsmkavdqqxjZJ0Np
         42fOmJQSg+Al3z8z21M7L/w655Qkt5FvyF+sixHU0S5NQesjs2THbzj1+VLZDNJgONB/
         BJUtDO/fRir82ltWhf83DT1SfGvz9d5aTY3h5bUfSxerf83FCFuj5pAEa+kTOGr2TX/7
         736I8hn0iybLJYdYrh76nyEpw0plstt6W2mI8OYLypOzzbxGcJx9CEuKbfYzxH/7eBXU
         bLnieaDw/itv2XLLsj/DQYvp0rRcaKpgFC1+DL+B9eYN+McJY3/INJbzuKbSgFicnEZP
         SeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778144999; x=1778749799;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0+Dw+cwNE8SIW/NQeUoL6sJg8a8J+n/owA/XlUfbDM=;
        b=VGItoAK4en/VLZyx+ldD7StmfgKXnY6Xt5jvDqC/gx9EIw3uDw+nuBhvPqpGftwotl
         viCSSeF1ZouDC97wNobFQJZT6J3rivLGlob5apZdSHdpbDLXi5hHSaztcUSONp67qAQP
         j0LFSdCdjZalyGtpWKBFCuYdviLkSD52XaM8eQG6FqXTKRWr7I7VtIz+6R2F+KGKPuZD
         7SCw1SdsKp/2ML4TsD/IOf+/cHwvqE2EirxI3A4Y8jvl+LvjJ9+coJ8s1nXeFQYiboM7
         EC9AsbgIP99Ie8bosMWfGqNtPNLszM+2f93vYecEvSxaqAGcjUFOi4dgBv83pdv3xM3q
         QCcA==
X-Forwarded-Encrypted: i=1; AFNElJ+Gwaonbvh2awSPIhBr8d5lan974SbEgwOlP2er9EYyfL5s2F51F+cc1wIp4oCwDq1eZSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvW0ylP7C3jPscFe64QN+7da3rI7/Qhg2XV2NqCZvfSEpz8/57
	BdY5e1Mxqt9Zd0LqFFhkTPcSZGFNd8GUp7CeDL0DWmKp9cKywFUGNZjVqB2c4sQVuu9QzFA9veQ
	wY7s5+W0sjH25xcNF0pUWkrO7ZNeWSS4U9CFpgK514A9rFwaWd95goQ==
X-Gm-Gg: AeBDietOFDrWAI/Qx9+twj+M7KJ3KsLN64xtpf0G0xsvNzT3KPuWRP96icSsTwWLIck
	XT+7xzZHhKlnWrFqS+T7q0A3MJP4IXwqJWo5Q3/IRsMzHecAB8U9iehwaZFq9u2vtVmISsOxnJx
	kYhHtP8VTsZG12vHP0RUDCpaESGUHdhdwXHhwbBMMfVxZhC11Y32fiwvJ8k7qMU2FlEl8uTZALl
	oHfcz99xM0XLsoN9n4s6/dZRI99iz6E3rp5Og4PCUxO358vk/RSSGZvA6cG4YEBMl2cghhaPG7b
	Vw4chXPou7H+GjpCUTUGwoBeVSVZ51q3hUjjBu4HhTr/cLFUgwWImOyyqIoqeNDJ2XWVJctGNj6
	PQtGhWF9IqYAIFrH3+ZHy08f6NIvvgJ4MZ+VVgH/x0IwEWlbLhYKa/Py698whErDLNOqQhzoWng
	==
X-Received: by 2002:a05:6000:310a:b0:43b:4f86:e985 with SMTP id ffacd0b85a97d-4515d3dcac9mr11750290f8f.33.1778144998939;
        Thu, 07 May 2026 02:09:58 -0700 (PDT)
X-Received: by 2002:a05:6000:310a:b0:43b:4f86:e985 with SMTP id ffacd0b85a97d-4515d3dcac9mr11750200f8f.33.1778144998234;
        Thu, 07 May 2026 02:09:58 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960973sm18883323f8f.30.2026.05.07.02.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 02:09:57 -0700 (PDT)
Date: Thu, 7 May 2026 11:09:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <afxVH2So9BbZ3Gta@sgarzare-redhat>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <20260506113554-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506113554-mutt-send-email-mst@kernel.org>

On Wed, May 06, 2026 at 11:37:45AM -0400, Michael S. Tsirkin wrote:
>On Tue, May 05, 2026 at 06:11:13PM +0200, Stefano Garzarella wrote:
>> On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
>> > On Tue, May 5, 2026 at 6:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> > >
>> > > On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
>> > > >virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
>> > > >
>> > > >virtio_transport_recv_enqueue() skips coalescing for packets
>> > > >with VIRTIO_VSOCK_SEQ_EOM.
>> > > >
>> > > >If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
>> > > >a very large number of packets can be queued
>> > > >because vvs->rx_bytes stays at 0.
>> > > >
>> > > >Fix this by estimating the skb metadata size:
>> > > >
>> > > >       (Number of skbs in the queue) * SKB_TRUESIZE(0)
>> > > >
>> > > >Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
>> > > >Signed-off-by: Eric Dumazet <edumazet@google.com>
>> > > >Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> > > >Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> > > >Cc: Stefano Garzarella <sgarzare@redhat.com>
>> > > >Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> > > >Cc: Jason Wang <jasowang@redhat.com>
>> > > >Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> > > >Cc: "Eugenio Pérez" <eperezma@redhat.com>
>> > > >Cc: kvm@vger.kernel.org
>> > > >Cc: virtualization@lists.linux.dev
>> > > >---
>> > > > net/vmw_vsock/virtio_transport_common.c | 4 +++-
>> > > > 1 file changed, 3 insertions(+), 1 deletion(-)
>> > > >
>> > > >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> > > >index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
>> > > >--- a/net/vmw_vsock/virtio_transport_common.c
>> > > >+++ b/net/vmw_vsock/virtio_transport_common.c
>> > > >@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>> > > > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>> > > >                                       u32 len)
>> > > > {
>> > > >-      if (vvs->buf_used + len > vvs->buf_alloc)
>> > > >+      u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>> > > >+
>> > > >+      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
>> > > >               return false;
>> > >
>> > > I'm not sure about this fix, I mean that maybe this is incomplete.
>> > > In virtio-vsock, there is a credit mechanism between the two peers:
>> > > https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003
>> > >
>> > > This takes only the payload into account, so it’s true that this problem
>> > > exists; however, perhaps we should also inform the other peer of a lower
>> > > credit balance, otherwise the other peer will believe it has much more
>> > > credit than it actually does, send a large payload, and then the packet
>> > > will be discarded and the data lost (there are no retransmissions,
>> > > etc.).
>> >
>> > I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
>> > state to account credit")
>> > and find a better fix then?
>>
>> IIRC the same issue was there before the commit fixed by that one (commit
>> 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")), so
>> not sure about reverting it TBH.
>>
>> CCing Arseniy and Bobby.
>>
>> >
>> > There is always a discrepancy between skb->len and skb->truesize.
>> > You will not be able to announce a 1MB window, and accept one milliion
>> > skb of 1-byte each.
>> >
>> > This kind of contract is broken.
>> >
>>
>> Yep, I agree, but before we start discarding data (and losing it), IMHO we
>> should at least inform the other peer that we're out of space.
>>
>> @Stefan, @Michael, do you think we can do something in the spec to avoid
>> this issue and in some way take into account also the metadata in the
>> credit. I mean to avoid the 1-byte packets flooding.
>>
>> Thanks,
>> Stefano
>
>Why do we need the metadata? Just don't keep it around if you begin
>running low on memory.

I don't think removing the skuffs will be easy; we added them for ebpf, 
zero-copy, and seqpacket as well. For now, we're already doing 
something: merging the skuffs if they don't have EOM set.

As a quick fix, I'm thinking of reducing the `buf_alloc` value to 
account for the overhead and notifying the other peer, at least until we 
find a better solution.

Stefano

