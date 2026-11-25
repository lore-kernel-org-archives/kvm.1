Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795626719;
	b=uR1ORjRCjhfXGhrrbr9YtgYZ1sD2MHbmX1FCUK9dn+PD++IN8q43T+V9sMqS33yJZ1hR
	 arOa8aUvO0JXwGdMy0bGI8gGNErLb9M9mHxqDjdzt+T437XWiqnnJr4hfEZ3a/UELzOpz
	 NitZrHqnl9R8GZr1PdB+aKqLz/hqE3RNpqd3mdIeC+1iFPSXuZmlPzwNl8XUG6AZO5I+D
	 AVyJ0R+9PLVRDLWbIkOt5h4VrqBJhiB7cTrKJL87BCQEgy+rchMPPl6KW3GCoupgpyKGG
	 9gxPgQjOQGivPxg1br7XuOLl17pag4WlfskOC33IuCkdsquxozVlizrEAujRVHaMrJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626719;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=wMnvi84iHgMT5EehQPUOpPHMSRil6iMt6kQQwsIp6L8=;
	b=pEbD/s3K8GvccvikOuP57OKtTqayZe7dGshY7LeoyFewOQ2piBsqOYdRo0XRYUTg7r3S
	 Cuk5c92qWz5G20dAKJFuvVfqZL8EBYSezVne4eDo2A55ewRY065CkEVnniI5I9sAfJpPP
	 B26pzYc5uqfCvvbKPzYnoEbwuQi4iYTIzC5c4u4sZN1dHHYwrM2IF9sYPHrDGZTLc/vPr
	 fpGpiOzAOiGa9yq8YS/vX/4vR3lA0HQBkm3xjBzweE9u3z2J8idVU01s+GZTkis2hI2VR
	 C174yhQ73GHIfzXtLGddCI6sgRhWn5a6Bb//jgXKfxY9iijvJqup3UItT361lgR9gPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PvzqpS9Y;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=D0wQeWAa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B4D606A68D
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 17:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30B4D606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PvzqpS9Y;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=D0wQeWAa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795626717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wMnvi84iHgMT5EehQPUOpPHMSRil6iMt6kQQwsIp6L8=;
	b=PvzqpS9YWn7uJPWfpfJTtVvtPA/h5KujtAShmaIUPw49Bt8JyYpi3CuWHSPTlz9R5MjML2
	jlyenGRyHkMhrKbQphOqZN5lyI8WLSybSnyeuPvfuE9/pgqFamFtE1+q10QCpgrl1Dbw1D
	g1wezw8n2khDnL28leAgb95avss+GyE=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-qF3nx5j7Oia5-mBkUxJX_Q-1; Wed, 25 Nov 2026 17:11:53 +0000
X-MC-Unique: qF3nx5j7Oia5-mBkUxJX_Q-1
X-Mimecast-MFC-AGG-ID: qF3nx5j7Oia5-mBkUxJX_Q_1795626713
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-6790b1d3bc9so10329883d50.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 09:11:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795626713; cv=none;
        d=google.com; s=arc-20260327;
        b=sL4HeFln4OguJit25XtIpSvtHqZ4q5XK+b2kkWe8J7H496NV5MXU+idoV4549iSVUB
         4TKBjgqD76wl/4ruX+qj4Fz3U1+35md3eJr5EdKONNHAQhfpWk5eZ67x7lnLKLsW3OuC
         7uMzq1gk9y/tTV9RYx0OKS3CKZ7ikgJcsTWK7CR6/NGdPIslwmMbCFhNr3y8KPSg7FSW
         Udk759h69+E+1K9l0XEv3nTn14v8F+3gConIAkCZKCq8iKSp4+8d3Nt1tcRXHH3W8u5/
         KrBpCZRZcro1GxIfYaWSdNsgWT1CcE1+lDQmWi/RaTBFIltHZLvew80fkvgHozz2Csbp
         te7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=wMnvi84iHgMT5EehQPUOpPHMSRil6iMt6kQQwsIp6L8=;
        fh=iNLqBgRbyt3zbR4uRND+aQarGcwgypQz5spw9bnnKcU=;
        b=q5xf4nFdt6u3TeX+Ce8vFHAaY/UpvTKsfAk6EeRGjs4rnnAXwsbk8tb7O6isQY4oOB
         FnV7rnXbf7yXt310zHVXz5ozCuEN1WZSZk0UBNuFgwnEMAb5VPypxy6k0Rr0nsMu7c7m
         szdinUIfRKEky00JofsEnMS1O9r1dH++vM4GFPVAA3Z3qOqVmAfSM9DL9DgIpNX021ev
         9KOGyiB65QCMUCQ32YRsWdMwa8rJNZtFo0mK5NFJpnNjFRqvAkc13MOid0UtKJxml6nb
         VIkcstegTc/MP6wRcER4bc0sZ+wT8b+fhE4pEpDu1z4zemShxWvBUHQYSEIkcJEKKawE
         z6nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795626713; x=1796231513; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wMnvi84iHgMT5EehQPUOpPHMSRil6iMt6kQQwsIp6L8=;
        b=D0wQeWAaebB28+WKLQBSOH4C2jOFLLlSZTlO04f71qF0Aa+Kyyhryv/vMtWXYnbvuT
         k6iAnPClddwWtDpUDuQsaqXT9ZiPmBpetc/POaZJ4XLLpC7W8isgpVShvNq1LTzChtAg
         t0Tq0bZdciT7TRUz1dmRtlu0m94iT7c0k3eQ7hoUgxj+HLNXGhBSpPqGUSo+w38U25V7
         v1iAQAZYAd68wWaGlNRRBkdYB9MYjiJL8VkALML1ApACMyKKVRcChwhC2YrvvKf+Mk7I
         qqCSwS+qUy6ye4DZ1arJuofB1aNTR9ShOI+a0SSfz1P5Vdsg4MabmJ73nWu6B2XzZIaE
         MxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626713; x=1796231513;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wMnvi84iHgMT5EehQPUOpPHMSRil6iMt6kQQwsIp6L8=;
        b=yLjTLJbP7J3I/P3YYNedvc6dtE4qOM4IdvB4puNWd6WMNUY7mAhA+kQ1w+OZystvrZ
         uhaKL5zYI6cXNyfpjNE3fjluoi9bbKXzrSAL12C7rPARKW2J4uz7NZKRaIsJyppj6XZk
         tfnE5Cfa8tcQOvnEARfzc5vy/hA60LVbfiEfKLmSSma9GuJ/uojLyBJVjhEvwZOrUret
         XnpHEfvAjIF511HVJTrYKP8RmZ1VfuMeNfe7MomSt9UjyXuH0L2HdQONUeg9lEPX1uHr
         gDLPxbKKTCFZgmNun/OuPo1F8hBqBZknSfv91h2wq3MunP4OnkpTpRV4QCZ90+w5qmBK
         YrXQ==
X-Forwarded-Encrypted: i=1; AL+hErEfYAd+Q9ytKLWSSRZEdmfDTeeKBRJlbsqD90ZUMcbYkZgOOcPlPj7g+/plqWrbrKFBkNg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8AGNOoTO6uk5nOiX3A+Uo57L9JicjHmWjtQhe0kWHKQ5j3gZID
	l305D6pQkC2nC/OuL9rM015J3rySsO+fkuQXT+fAezrU7VT+uhx0XpA/M68nLcQ4FYAms3cLGwh
	7gPSb0zvllhD0NeGUIYgwPtCdBwTwFDJUuepIbs46SETeMh01e+gIgFzNjrtN3oZWAHbYTdEoPR
	S9sKCMHkNq8J70j8ori1aRmU1+YU22
X-Gm-Gg: AZFdTZdjlme9lMsZ4nAfAWjXmk+wARnXBS2TCuhTIx0WgCvWomVJdUOkbWjkQqxy1ee
	cwHLSrrK7GM6o5EM62plvTEzm4+F97bi5JMJ+zn4g5SeEz1YpAvaIp+6TegWX72XjpGlPnGu4uI
	ZKcgjERh9IjF+hVRDU88fWPc7y9SxTYNt+22TRQvYBsYsO1riBOO3UTw8=
X-Received: by 2002:a53:ca02:0:b0:67d:c2d1:5f40 with SMTP id 956f58d0204a3-67df44a9f94mr7458636d50.97.1795626712837;
        Wed, 25 Nov 2026 09:11:52 -0800 (PST)
X-Received: by 2002:a53:ca02:0:b0:67d:c2d1:5f40 with SMTP id
 956f58d0204a3-67df44a9f94mr7458599d50.97.1795626712243; Wed, 25 Nov 2026
 09:11:52 -0800 (PST)
Received: from 821463759402 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Nov 2026 09:11:51 -0800
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <aveRRt/rHQ1By6ul@devvm29614.prn0.facebook.com>
References: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
 <20261113-vsock-dgram-support-v3-7-1523c8e9b27e@redhat.com> <aveRRt/rHQ1By6ul@devvm29614.prn0.facebook.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 25 Nov 2026 09:11:51 -0800
X-Gm-Features: Aa3M54rWhP6JPS6dAHPhCuA1V9j2mDkBDAmNkK_cOM-iU_dy7BMJhibPYf3kF0A
Message-ID: <CAAiTLFWpoZu9ArNVQ_uq6RRQyiiQYvy5=uNVbhpb=6-OBJV8mQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 7/8] vsock: fragment datagrams across receive buffers
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Bobby Eshleman <bobbyeshleman@meta.com> writes:

(I've just noticed I've missed replying to this review, sorry about that).

> On Fri, Nov 13, 2026 at 06:15:47PM +0100, Sergio Lopez wrote:
>> The guest already uses page-sized RX allocations. A datagram can exceed
>> one RX buffer. Growing every posted buffer to hold a full datagram would
>> increase virtqueue memory use and make small queued datagrams retain large
>> backing allocations. With delayed reads, a bounded receive queue could
>> then fill after only a few messages.
>>
>> Define START and EOM flags for datagram packets. Mark outgoing messages
>> with both flags, and let vhost split a message across guest RX buffers,
>> keeping START on the first fragment and EOM on the last. When a data
>> packet meets a descriptor with no payload space, vhost returns that
>> descriptor with zero used bytes. It drops datagrams but requeues stream
>> and seqpacket data for a later buffer.
>>
>> Reassemble consecutive fragments in the guest before tap or socket
>> delivery. Bound a partial message to 64 fragments and 64 KiB. Discard
>> incomplete messages on malformed packets, a new START, a peer mismatch,
>> an intervening non-datagram packet, or virtqueue teardown. Require complete
>> framing for host and loopback ingress.
>>
>> A QEMU reproducer now delivers a 9 KiB datagram as one message and all
>> 16 messages of a delayed-read burst. Paired host/guest selftests cover
>> 64 KiB messages and the burst through both a userspace backend and the
>> patched Linux vhost backend, with stream and seqpacket controls. A nested
>> vhost-vsock guest posting header-only RX buffers also passes stream and
>> seqpacket receive tests.
>>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>  drivers/vhost/vsock.c                   |  15 +++++
>>  include/uapi/linux/virtio_vsock.h       |   8 +++
>>  net/vmw_vsock/virtio_transport.c        | 115 ++++++++++++++++++++++++++++++--
>>  net/vmw_vsock/virtio_transport_common.c |  11 ++-
>>  4 files changed, 141 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index f4fb2ac732f5..1ff4a9aff907 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -185,6 +185,19 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>>  		 * buffer, we split it using multiple buffers.
>>  		 */
>>  		if (payload_len > iov_len - sizeof(*hdr)) {
>> +			if (iov_len == sizeof(*hdr)) {
>> +				/* Connected sockets must retry with the next buffer. */
>> +				if (le16_to_cpu(hdr->type) ==
>> +				    VIRTIO_VSOCK_TYPE_DGRAM)
>> +					kfree_skb(skb);
>> +				else
>> +					virtio_vsock_skb_queue_head(
>> +						&vsock->send_pkt_queue, skb);
>> +				vhost_add_used(vq, head, 0);
>> +				added = true;
>> +				continue;
>> +			}
>> +
>>  			payload_len = iov_len - sizeof(*hdr);
>>
>>  			/* As we are copying pieces of large packet's buffer to
>> @@ -244,6 +257,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>>  		 */
>>  		if (VIRTIO_VSOCK_SKB_CB(skb)->offset < skb->len) {
>>  			hdr->flags |= cpu_to_le32(flags_to_restore);
>> +			if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM)
>> +				hdr->flags &= ~cpu_to_le32(VIRTIO_VSOCK_DGRAM_START);
>>
>>  			/* We are queueing the same skb to handle
>>  			 * the remaining bytes, and we want to deliver it
>> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>> index 27b4b2b8bf13..e1937f756eeb 100644
>> --- a/include/uapi/linux/virtio_vsock.h
>> +++ b/include/uapi/linux/virtio_vsock.h
>> @@ -101,6 +101,14 @@ enum virtio_vsock_shutdown {
>>  enum virtio_vsock_rw {
>>  	VIRTIO_VSOCK_SEQ_EOM = 1,
>>  	VIRTIO_VSOCK_SEQ_EOR = 2,
>> +	/*
>> +	 * With VIRTIO_VSOCK_F_DGRAM, START marks the first RW packet of a
>> +	 * datagram and EOM marks the last. Both are set for a datagram that
>> +	 * fits in one packet. Fragments must be consecutive on the receive
>> +	 * virtqueue. Each packet's len is its fragment length.
>> +	 */
>> +	VIRTIO_VSOCK_DGRAM_EOM = VIRTIO_VSOCK_SEQ_EOM,
>> +	VIRTIO_VSOCK_DGRAM_START = 4,
>
> Should this be 4 if VIRTIO_VSOCK_DGRAM_EOM = VIRTIO_VSOCK_SEQ_EOM = 1?
> Seems like 3 is missing?

Yes, those are bitmasks. But they are also part of an enum, which is
weird and confusing. Perhaps I should prepend a patch removing the enum
and redefining those values in the form of "1U << 0"?

> Is VIRTIO_VSOCK_DGRAM_START strictly necessary? If we just received an
> EOM from a peer, then we know that the next pkt from that peer is also
> the start of a new dgram. We'd have to be careful to never abandon a
> datagram partway through, but for example I think we can just requeue
> the datagram fragment to later retry if we fail to place onto the vq?

Yeah, I thought about this quite a while too. Having START makes the
protocol less dependent on the transport semantics, allowing the guest
to identify an incomplete datagram to resume from a known boundary. I
think it makes the implementation more robust with a relatively small
cost.

Thanks!
Sergio.

