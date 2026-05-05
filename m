Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EDA2FE56E
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990491; cv=pass; b=UCYUUCpCwz7Cw+M4nbndwc0uaVOYGwX1Q184YApLVURNfJYFaRBUOuod7Xqto8nxG0vZpNVf2ahEGQbFjicGX19Nnktl7WnG/uc91rg3J1khwupoTN/cBy9IObWh+fNGLgCYr1/NS8+yqdDoaXOivsM9b4DLJi9Vb6OBQW7IZdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990491; c=relaxed/simple;
	bh=MnAAO4w1VfmrD02ylbi+VLyroPBD+EN8jrV6PBVFQ5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ow0ZWQaNucBDICyj0kbI2meOu1wCS0vrtvEIG92bT+NnJWCE7wHY+/4GbBwjlj7QT6aVzndN1XTwtsyHw9EY5ZbUcjJRMQJLE+9X+8vSlMwwa3dvBW1AoQGgDBKZA5AvJRk9Qc13YcEDPqpgUgLcmgRbdxrHl5ILDEabMlABFs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ksi3C2L9; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ksi3C2L9"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50fb4a7d704so42801511cf.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 07:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777990489; cv=none;
        d=google.com; s=arc-20240605;
        b=PnOP1jVI0rxW75fhXhYMY7lNHS3HHAe13ynHGJ6UhCyUSEh4jbjLIbXHPRcqm2N9A6
         RmS88s3FwMsucngDyr7AoH8tFmK3C/97svGiREwqyXhcgaNPS3wxbCC30IscOC/yw+jq
         xy6W1nQDzMWb5DT5yfOYSqCY21vrBeORcP06mRUaEY9ZtvFcvbN9/5Umi7LCVmmdzZsI
         BQ9KaibgT0DIP2YVu30bgX+uJZF4N4V4WPJSo0DhRRwcfgdTAYsxyS97ErSrvYqMBKCC
         wGOwXgKl+mpw5BUphT+FUKC1lpyQbJCI3mn4qeVphnBNQ8EzO1IhtMPqWHt5xCoGiHe+
         VImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dUYAYav/BIYvObp7yQw4M/QPkHnKb2/syh6Sp2vU04w=;
        fh=ny4EFSf8Vr8WlR6oiyYdcKi5kYHRx5jKunTpC3i5u0U=;
        b=MVZN9HIuIjmI9sXY5p3uNbTcKOYWFY8CI/fL0JGJicYnjx22bulDqyLXkqvmv2CN6e
         qR/amiYIaj42GrGaR9FU1sqsVnAN9E/MeiejV0oBtVyHRkOSj8cmFJ5rqH68QExT4xrS
         5/GvKh9R+/suHqCYKCKNyC5Cz6Oo36Tnfo1P2U+Gi6whU+l/MvoACo9jXE0GSRiw4U8T
         9MkxaP3sTNTjEWN//yzyaw4dfY6c4lBXsD3poDfcv4KtgK6au3C9xSViL6ptSCEnzyw6
         D90FmhAl0ymUttNy2/MNZanjHZ9lh8YPSOCXSys6B9/+jtEzRAUif+rK4SotjWvOEKwS
         LwMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777990489; x=1778595289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUYAYav/BIYvObp7yQw4M/QPkHnKb2/syh6Sp2vU04w=;
        b=Ksi3C2L9ttBJn9Sa/0LCRG2B9dbjILuemw/L11glQyg+RUpdTs49KRZbGlGD898wb/
         8J9Rt8WszvxU5q0RJSXPJdBCZepMCzqri8yPSp+92b1Z4r3G2jgxyBpoRYm39O+w5Jld
         4cHH6+vMMlM4/fnVHKx94pMgkqrbZ9dc2wUq/BuGHSqdz3dC0V1og1Hs3GioelpjlxJN
         7jsNVSG1l28DlECqoljLqnZFBjbvwO5ZVyw2U4080sFt61jZ0fmkHDU2WTUdezHS/T4J
         2nR4vpIbODkv/hf5CiddcAQIpbIxXMoIsK07eEl9nH+C+PckGxdmpZ9sikI8jWv5+TZl
         Dvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777990489; x=1778595289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dUYAYav/BIYvObp7yQw4M/QPkHnKb2/syh6Sp2vU04w=;
        b=Qb0+7P5UUauCruTCNzgmCFRuGpDXspbzH+zgr8gaCcmfjuxYgQ6M4fPWZUlgM5aCsl
         pBLUosv4T4yf7fS3hs75BO0tD7NpmRKw3zYKl8GtLMpYhoNzMLu19evEY4j+PoDXJPsy
         u2w4XmxaYcoX8l6TgN36xDM0VJ4DaptGJ+yB7g1AaaBgd+64GxVNGYPM5YpYhXgdJi9W
         kuicV5tC9xWtFxznJBGmpUhN9LT7Hzrrn3ToWS1rYVymerM1jgaGDAWt+eWYJlEyITWP
         6oIxi4YYDcKGR9WnbDT2cUWh11avtm2UjGo7bJXVqZaKqjLlnWFKhmaoPwD83tdla/lN
         8DLw==
X-Forwarded-Encrypted: i=1; AFNElJ+vtAIvhJVu7GkdYqMXuqReu1Zey190HMj5A0lRLDzI6eK6w4ZeeItxtLJ22tFBNnBkzy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz6+pqeZl01emnoXQirQX3bGlkkKzYUNzQXMNqYTIZNchPH2ya
	34chL2mEPXrR+Jv63t8nnzYtZH1yNhSgPAS6RGbZWloY5iW9M9BJd+SkvpPSmJ8/mewOZSLH/kZ
	AV7dOYhxy6xWgSTNCnsVzm5FZwJljNUJUcvjndGk0
X-Gm-Gg: AeBDievHTxoK7ZB1d4le9GOs62GjPFfzYzV7uyyc9D/IJToYAVc+YmiWJJ2WEOI+Pa7
	4K86G4L+zlsLLyVpPrX7OT3APTBZArpVghTujTevZl1DFeKwCcb5q4IIGbmhd4SysMSLyEEB9Xf
	i/VyU2Kjl5CrIsdPNp1ZHVIMF2XLpT3ftZTSsQ6zSGmSYoRoaeR5IysGEalDiQb+r5SpHyfRIVP
	AqyKxRZymR3Mz+y1FasjpR/1NwgJFWDt0dnF1aphpRK/3ibFSyBNTFT5/vUstnVdXeOpQ2hdPG8
	GQzcmz3j1oPM0+N+SBiu4qLvH1nVN9SmnniBO7I/qDVoiwbRd/68nLXzS80wGMKidqhJmXpafmZ
	6cYKtCtKAmTP8ht0CwpFDg5QZEpBRxljecDITMoL9dJtx4d/HQg==
X-Received: by 2002:a05:622a:2304:b0:50e:5cc3:6f42 with SMTP id
 d75a77b69052e-5104c033490mr204851261cf.59.1777990488136; Tue, 05 May 2026
 07:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430122653.554058-1-edumazet@google.com> <afn0ZdvZWswBuDMm@sgarzare-redhat>
In-Reply-To: <afn0ZdvZWswBuDMm@sgarzare-redhat>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 May 2026 07:14:36 -0700
X-Gm-Features: AVHnY4LCs_m-4d1LFjbzwKLOUUlRczsxD4uzf7jMKren00MMyTffvChvT5hoQlU
Message-ID: <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 6:52=E2=80=AFAM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
> >virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_allo=
c.
> >
> >virtio_transport_recv_enqueue() skips coalescing for packets
> >with VIRTIO_VSOCK_SEQ_EOM.
> >
> >If fed with packets with len =3D=3D 0 and VIRTIO_VSOCK_SEQ_EOM,
> >a very large number of packets can be queued
> >because vvs->rx_bytes stays at 0.
> >
> >Fix this by estimating the skb metadata size:
> >
> >       (Number of skbs in the queue) * SKB_TRUESIZE(0)
> >
> >Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account cr=
edit")
> >Signed-off-by: Eric Dumazet <edumazet@google.com>
> >Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >Cc: Stefan Hajnoczi <stefanha@redhat.com>
> >Cc: Stefano Garzarella <sgarzare@redhat.com>
> >Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >Cc: Jason Wang <jasowang@redhat.com>
> >Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> >Cc: kvm@vger.kernel.org
> >Cc: virtualization@lists.linux.dev
> >---
> > net/vmw_vsock/virtio_transport_common.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vir=
tio_transport_common.c
> >index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae18463=
5fbba4dfee58bd64 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vso=
ck_sock *vsk,
> > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> >                                       u32 len)
> > {
> >-      if (vvs->buf_used + len > vvs->buf_alloc)
> >+      u64 skb_overhead =3D (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TR=
UESIZE(0);
> >+
> >+      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
> >               return false;
>
> I'm not sure about this fix, I mean that maybe this is incomplete.
> In virtio-vsock, there is a credit mechanism between the two peers:
> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.ht=
ml#x1-4850003
>
> This takes only the payload into account, so it=E2=80=99s true that this =
problem
> exists; however, perhaps we should also inform the other peer of a lower
> credit balance, otherwise the other peer will believe it has much more
> credit than it actually does, send a large payload, and then the packet
> will be discarded and the data lost (there are no retransmissions,
> etc.).

I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
state to account credit")
and find a better fix then?

There is always a discrepancy between skb->len and skb->truesize.
You will not be able to announce a 1MB window, and accept one milliion
skb of 1-byte each.

This kind of contract is broken.
