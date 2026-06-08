Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFEE3AFCEC
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911427; cv=none; b=bGbozHj3MTzT8FzZaeq1MHyiFKwuUh7uX++eCpQlfgfgPYVUczAZ7FT8KVX3n0KQbjcod0WqsdKboFE3gpqVhAHUIfZ4/wpseOk1K090TH+0pXtNWEP3pXobbLjdvlaQc3OUL7DWx3Dhww5L1dw3qgSRNafaANk3c1iK67P0NI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911427; c=relaxed/simple;
	bh=59/tSJ0dW51Zn1c5BQkejmWziRwoc8zt4d0DBdDQLfw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVj2l6eYxY+IEplwC1SmN3eS13Ub0lZ1s2NWAEZ/ar1h5U3Z2kpkImaVcj6xZiKK41llrux/6jmMgEASOZW5KZVB6VFY7z0ErjRJvRCAooNDqi1yJ61c0Dlh1PC2ZiLu35I4vCK1WGxesuNniSJb8PdXY+tIaUJ1KQFitH5b18Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8G3fjYi; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8G3fjYi"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so2667846f8f.0
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 02:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780911424; x=1781516224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Spb0RtZEviQD3qiwv62vU4Wzwzz7ccUnGUeAg2w4gY=;
        b=X8G3fjYiOpM9+24zhgjsJrZ3zuEqBqU3EkC2N1dTwSoOTpEl1xndwv3zkfy4ROBwEg
         RosFkFZZgdpiII42/uF4+TMOWexyXGPc1aESM3UNq3oiZIdHDaSG0JFWXU125LUmLRAd
         icY2fBfrbiZvzSTrMHimrJjfF84rs27H3w1nJg4A+McoZpIluyn5iBftyHK/9iYnu3g9
         BZQmnPsO71bxLwat/Su8u0tdV6V4lxCk5wi1ROw1tbVUspchpzCuLG+NQsJI8qEeDheT
         Wb7OlT3mXNrxIaUEQf1AS0I+sYfGE080oOis35xpFKLrSHAteFwnuLq+G6MxVJjeof1+
         /6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780911424; x=1781516224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Spb0RtZEviQD3qiwv62vU4Wzwzz7ccUnGUeAg2w4gY=;
        b=BYd/PJXCxMqOdtgHlK2xr8ZbsWN/G6/UjQi5ZV0CUveUI4bstt70FO/ozpKT2mJ7hr
         kxf+5Nbvoc0WkbVvbEM1bYdCXW0xjIvZfC9hAmrJl7FMfmv2CJon+uBF7LA3CJ+6PNsW
         IJjW6m9Iuqhq2ZRrc3KIJNrtNFa5wO0Y/R/pyMZry7gJpCaGBFMxFSleFkpvWZaHZj14
         /XgqQ9xX5WnHxBQAMN8ja26orTpSuzWGWfUNEq5DmxqxdYNLufJBPaABtG4lnFX+z4x4
         oe8bhw63G+t2ALdr8rnQB/Eb2FIZ4xOi85qE49swj45+3U4d20zS6YsvA1qHKTqi0vxj
         HZgA==
X-Forwarded-Encrypted: i=1; AFNElJ8DC0Iw0ZtLgijexpp1EYx/3jaPgqve75IPm9DRTDXQTZQbgSLXZrNojMSwljWiNpYfAF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx090NETv2XzHEmCYzo4iV05f95T9QTc/Iiy8/kNVMdZWdSDmgL
	4UrcIl6gqDZBJENPnRV0x4grvHHYFiXz5oXhuKyS98oIKb7ol2CqE6qO
X-Gm-Gg: Acq92OGXLYBxj7p/cyVVyThCiaM0wL/TeIOgqVtji8eDhKUX24nY+K1Y1pScPyUgy9Z
	aEAT0IzYcqgc8WuMVyhmszQPSjJJMntv7PWd+ZJ/bx1spi6dvMQ+JZ9LmfQwky0HfLgaG6sj10C
	x3VHtJsp/Jb48BurCjrliFUm0T2cBpEBl4+THiCYPSQlTGxmjC7oGRX4x/UHNUILejJgltf1jjI
	PaIz26SgRohZWse5I6+xQgMJkuQrmxRJmFqrAt6UDStwtwOoMzpcl+m2qZYEGua7gWGljikgl8j
	0fBNb25pK4ZDPg8sD7g7jSQHXJS5T/1/apSjHKBtAnQSOQu+HlCWZ/TT73ms/+zEDl6o2IqTxP7
	VHat7itxA8oUiIMn2A6uD2t1kkGGgzW68bVCVZG72x3PaicIJsYRBgHOPrmD4DUXEUZfp80nF4h
	66Q2Z085Dzody1TeaML+yL0I28Q9fuibo2iYQwxvyyI6WhCHxOPpMIXPtWSi3llpEOjtz9WSh+C
	eFuuvVTVg==
X-Received: by 2002:a5d:42d1:0:b0:43c:fa96:d939 with SMTP id ffacd0b85a97d-46030609782mr16804802f8f.22.1780911423510;
        Mon, 08 Jun 2026 02:37:03 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm55824962f8f.5.2026.06.08.02.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 02:37:03 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:37:01 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Simon Horman <horms@kernel.org>,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, oxffffaa@gmail.com,
 rulkc@linuxtesting.org
Subject: Re: [PATCH v1] vsock/virtio: rework MSG_ZEROCOPY flag handling
Message-ID: <20260608103701.7839ff1b@pumpkin>
In-Reply-To: <e5200406-d336-4ddf-9abd-78fccda24546@rulkc.org>
References: <20260605115314.552321-1-avkrasnov@rulkc.org>
	<20260605160851.3ddbd2ed@pumpkin>
	<e5200406-d336-4ddf-9abd-78fccda24546@rulkc.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jun 2026 11:10:24 +0300
Arseniy Krasnov <avkrasnov@rulkc.org> wrote:

> On 05/06/2026 18:08, David Laight wrote:
> > On Fri,  5 Jun 2026 14:53:14 +0300
> > Arseniy Krasnov <avkrasnov@rulkc.org> wrote:
> > =20
> >> Logically it was based on TCP implementation, so to make further
> >> support easier, rewrite it in the TCP way.
> >>
> >> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
> >> ---
> >>  net/vmw_vsock/virtio_transport_common.c | 64 ++++++++++++-------------
> >>  1 file changed, 32 insertions(+), 32 deletions(-)
> >>
> >> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/v=
irtio_transport_common.c
> >> index 2fd9eaaf5ca6..00caeeaa5590 100644
> >> --- a/net/vmw_vsock/virtio_transport_common.c
> >> +++ b/net/vmw_vsock/virtio_transport_common.c
> >> @@ -73,10 +73,13 @@ static bool virtio_transport_can_zcopy(const struc=
t virtio_transport *t_ops,
> >>  static int virtio_transport_fill_skb(struct sk_buff *skb,
> >>  				     struct virtio_vsock_pkt_info *info,
> >>  				     size_t len,
> >> -				     bool zcopy)
> >> +				     bool zcopy, struct ubuf_info *uarg)
> >>  {
> >>  	struct msghdr *msg =3D info->msg;
> >> =20
> >> +	/* We have completion - attach it to 'skb'. */
> >> +	skb_zcopy_set(skb, uarg, NULL);
> >> +
> >>  	if (zcopy)
> >>  		return __zerocopy_sg_from_iter(msg, NULL, skb,
> >>  					       &msg->msg_iter, len, NULL);
> >> @@ -208,7 +211,8 @@ static struct sk_buff *virtio_transport_alloc_skb(=
struct virtio_vsock_pkt_info *
> >>  						  u32 src_cid,
> >>  						  u32 src_port,
> >>  						  u32 dst_cid,
> >> -						  u32 dst_port)
> >> +						  u32 dst_port,
> >> +						  struct ubuf_info *uarg)
> >>  {
> >>  	struct vsock_sock *vsk;
> >>  	struct sk_buff *skb;
> >> @@ -245,7 +249,7 @@ static struct sk_buff *virtio_transport_alloc_skb(=
struct virtio_vsock_pkt_info *
> >>  	if (info->msg && payload_len > 0) {
> >>  		int err;
> >> =20
> >> -		err =3D virtio_transport_fill_skb(skb, info, payload_len, zcopy);
> >> +		err =3D virtio_transport_fill_skb(skb, info, payload_len, zcopy, ua=
rg);
> >>  		if (err)
> >>  			goto out;
> >> =20
> >> @@ -321,38 +325,36 @@ static int virtio_transport_send_pkt_info(struct=
 vsock_sock *vsk,
> >>  	if (pkt_len =3D=3D 0 && info->op =3D=3D VIRTIO_VSOCK_OP_RW)
> >>  		return pkt_len;
> >> =20
> >> -	if (info->msg) {
> >> -		/* If zerocopy is not enabled by 'setsockopt()', we behave as
> >> -		 * there is no MSG_ZEROCOPY flag set.
> >> +	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
> >> +		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
> >> +		 * 'MSG_ZEROCOPY' flag handling here is based on the same flag
> >> +		 * handling from 'tcp_sendmsg_locked()'.
> >>  		 */
> >> -		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
> >> -			info->msg->msg_flags &=3D ~MSG_ZEROCOPY;
> >> +		if (info->msg->msg_ubuf) {
> >> +			uarg =3D info->msg->msg_ubuf;
> >> +			can_zcopy =3D virtio_transport_can_zcopy(t_ops, info, pkt_len);
> >> +		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
> >> +			uarg =3D msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
> >> +						    NULL, false);
> >> +			if (!uarg) {
> >> +				virtio_transport_put_credit(vvs, pkt_len);
> >> +				return -ENOMEM;
> >> +			}
> >> =20
> >> -		if (info->msg->msg_flags & MSG_ZEROCOPY)
> >>  			can_zcopy =3D virtio_transport_can_zcopy(t_ops, info, pkt_len);
> >> =20
> >> +			if (!can_zcopy)
> >> +				uarg_to_msgzc(uarg)->zerocopy =3D 0;
> >> +
> >> +			have_uref =3D true;
> >> +		}
> >> +
> >> +		/* 'can_zcopy' means that this transmission will be
> >> +		 * in zerocopy way (e.g. using 'frags' array).
> >> +		 */ =20
> > I've not looked at the tcp code, but the above doesn't look right.
> > I don't see why msg->msg_ubuf might be non-NULL without SOCK_ZEROCOPY s=
et.
> > That would give the outer code a callback when the last skb is freed but
> > still copy the data. =20
>=20
> Hi,=C2=A0
>=20
> I guess case when 'msg->msg_ubuf' is non-NULL is special case today for i=
o_uring MSG_ZEROCOPY implementation.
> It was added here https://git.kernel.org/pub/scm/linux/kernel/git/torvald=
s/linux.git/commit/?id=3Deb315a7d1396b1139fc7daea55f2d3191e8e7092
> As I see implementation of its tests in tools/testing/selftests/net/io_ur=
ing_zerocopy_tx.c , it doesn't require setting SOCK_ZEROCOPY option for
> socket, so for virtio vsock case I just copied same logic to maintain com=
patibility, because there is MSG_ZEROCOPY io_uring test for virtio/vsock.

That code path probably sets info->msg->msg_flags & MSG_ZEROCOPY so wants '=
zerocopy'.
But wants it's own callback function called rather than one that msg_zeroco=
py_realloc()
adds.

But there is no reason why a caller might not just want a notification that
all the skb associated with the sendmsg have been freed without requesting =
zerocopy.
Maybe no one does it today, but it is trivial to support.

>=20
>=20
> >
> > I also don't see the point of calling msg_zerocopy_realloc() to get a
> > callback when the last skb is freed and then setting
> > 	uarg_to_msgzc(uarg)->zerocopy =3D 0;
> > so that the callback doesn't actually do anything.
> > It isn't as though you 'find out' later on that you can't actually do
> > zerocopy. =20
>=20
>=20
> Sorry, what do You mean "last skb" ? In this code we first allocate uarg =
(allocate, because third arg is always NULL). Then in
> loop we allocate sk_buffs, fill it with data and send. I mean first/last =
skb will be freed after uarg is already allocated and we
> don't touch it. I think i didn't understand Your question here.

The 'uarg' is referenced by all of the skb that contain data for the sendms=
g().
So when the last one of them is freed the callback function is called.
The purpose of that callback is to 'undo' the zerocopy (page pinning etc).
But when you set uarg_to_msgzc(uarg)->zerocopy =3D 0 the callback does noth=
ing.
So there is no point setting up the callback at all.

-- David

>=20
>=20
> > =20
> >>  		if (can_zcopy)
> >>  			max_skb_len =3D min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
> >>  					    (MAX_SKB_FRAGS * PAGE_SIZE));
> >> -
> >> -		if (info->msg->msg_flags & MSG_ZEROCOPY &&
> >> -		    info->op =3D=3D VIRTIO_VSOCK_OP_RW) {
> >> -			uarg =3D info->msg->msg_ubuf;
> >> -
> >> -			if (!uarg) {
> >> -				uarg =3D msg_zerocopy_realloc(sk_vsock(vsk),
> >> -							    pkt_len, NULL, false);
> >> -				if (!uarg) {
> >> -					virtio_transport_put_credit(vvs, pkt_len);
> >> -					return -ENOMEM;
> >> -				}
> >> -
> >> -				if (!can_zcopy)
> >> -					uarg_to_msgzc(uarg)->zerocopy =3D 0;
> >> -
> >> -				have_uref =3D true;
> >> -			}
> >> -		}
> >>  	}
> >> =20
> >>  	rest_len =3D pkt_len;
> >> @@ -365,14 +367,12 @@ static int virtio_transport_send_pkt_info(struct=
 vsock_sock *vsk,
> >> =20
> >>  		skb =3D virtio_transport_alloc_skb(info, skb_len, can_zcopy,
> >>  						 src_cid, src_port,
> >> -						 dst_cid, dst_port);
> >> +						 dst_cid, dst_port, uarg);
> >>  		if (!skb) {
> >>  			ret =3D -ENOMEM;
> >>  			break;
> >>  		}
> >> =20
> >> -		skb_zcopy_set(skb, uarg, NULL); =20
> > Aren't you passing uarg through two function calls instead of doing it =
here.
> > Doesn't even make it clearer what is going on. =20
>=20
>=20
> Agree, to simplify patch, uarg could be set earlier (without passing it t=
o functions) I guess.
>=20
> Thanks
>=20
>=20
> >
> > -- David
> > =20
> >> -
> >>  		virtio_transport_inc_tx_pkt(vvs, skb);
> >> =20
> >>  		ret =3D t_ops->send_pkt(skb, info->net);
> >> @@ -1178,7 +1178,7 @@ static int virtio_transport_reset_no_sock(const =
struct virtio_transport *t,
> >>  					   le64_to_cpu(hdr->dst_cid),
> >>  					   le32_to_cpu(hdr->dst_port),
> >>  					   le64_to_cpu(hdr->src_cid),
> >> -					   le32_to_cpu(hdr->src_port));
> >> +					   le32_to_cpu(hdr->src_port), NULL);
> >>  	if (!reply)
> >>  		return -ENOMEM;
> >>   =20

