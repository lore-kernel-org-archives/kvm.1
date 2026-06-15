Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9314C8635D
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545714; cv=none; b=nO4Gi55jtyBRDtSbXDvygY1M5z3CT9OfJM6lks5J1AZ0kOyrSYtk9vcfn/Fuw1J+zSfv3uIXP+f/4kwDYEL573phiglQgvJhnS0jpkjB9+jOLHJpkO7N3CKjXKUNfC6H6P1pYJt4ytiqbwG8b1a/S0o3eZjD1cAf7qSdif7X3Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545714; c=relaxed/simple;
	bh=/gnzHc+oF76xE4aXroL6vc7daqNTNOlLFEMzfWkiIuY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rIuvpqj0ldcK4ScWyJ34Kn8gydSv2WIP35qS0xHhlQoPtD9s0dVJFsc4uTISBJ+fOFlCOVi7c7KZFDtyjmYwngtm4eFrFx6SFZNFcgG5EsQkJ86AkdWnJXFSzuG9D6Xw9A/SmNpfdvc71Am0BVon5v/OJWSGTwah7tnQQjeaOQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3/+HNWO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3/+HNWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE741F000E9;
	Mon, 15 Jun 2026 17:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781545713;
	bh=dv0fFKasvEKYfvytW7Ect6TsBd5Wxl3YDiBaA2r/B4I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K3/+HNWOd+2k1jzL90+IfyKomKsBDUzs7Lb5TRqr1JaQQL0pWVXalGxr/AQK1rP7a
	 qFUh19VH2YWIA5aO8r8LAdMJsabC9zoIwlH4M12htO8hdGmRPGIHcPDHDB3SBvENPz
	 Rwo+q4FFvJpVP0OAJNI2ZUlvwmmKaVZge3gwWsNfKF/0R3M+WFUZlKaFwIGR3nr3Xk
	 FAk2DCPtuKU3/586JiFAGPAyGSkU4S/lw4WFoBWYfhIbo90NCP2Mv+m556c4e1qA+w
	 uh0iW53iGDZ7s873W5js3VLWRQnzBtaZc4oQ4kPznICRlm/sGdJFODt2gk8NNhlg3g
	 aVuX4FYRwG/BQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vsock/virtio: rework MSG_ZEROCOPY flag handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arseniy Krasnov" <avkrasnov@rulkc.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260614174756.170631-1-avkrasnov@rulkc.org>
References: <20260614174756.170631-1-avkrasnov@rulkc.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 17:48:32 +0000
Message-Id: <20260615174833.4BE741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] MSG_ZEROCOPY consumes multiple completion IDs per sendmsg() call i=
f the message is split.
- [High] Valid but unaligned MSG_ZEROCOPY sendmsg() payloads can randomly f=
ail with -ENOMEM due to the MAX_SKB_FRAGS limit.
--

commit dc53c3cec37e35ad80f978cae7292ef9c7bfe500
Author: Arseniy Krasnov <avkrasnov@rulkc.org>

vsock/virtio: rework MSG_ZEROCOPY flag handling

This commit refactors MSG_ZEROCOPY flag handling in the vsock virtio
transport to align more closely with the TCP implementation.

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virt=
io_transport_common.c
> index b10666937c490..f549d67d36d18 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -328,38 +328,36 @@ static int virtio_transport_send_pkt_info(struct vs=
ock_sock *vsk,
[ ... ]
> +		if (info->msg->msg_ubuf) {
> +			uarg =3D info->msg->msg_ubuf;
> +			can_zcopy =3D virtio_transport_can_zcopy(t_ops, info, pkt_len);
> +		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
> +			uarg =3D msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
> +						    NULL, false);

[Severity: High]
This isn't a bug introduced by this patch, but does passing NULL
unconditionally here violate the MSG_ZEROCOPY API contract?

When a MSG_ZEROCOPY payload is split across multiple enqueue loops in
vsock_connectible_sendmsg() (for example, due to socket credit limits),
passing NULL to msg_zerocopy_realloc() allocates a new ubuf_info_msgzc
and increments sk_zckey for every chunk.

TCP avoids this by passing skb_zcopy(skb) from the write queue tail
to reuse the uarg. Without reusing the uarg, vsock consumes multiple
completion IDs per sendmsg() call, which breaks userspace completion
tracking.

> +			if (!uarg) {
> +				virtio_transport_put_credit(vvs, pkt_len);
> +				return -ENOMEM;
> +			}
[ ... ]
> +		/* 'can_zcopy' means that this transmission will be
> +		 * in zerocopy way (e.g. using 'frags' array).
> +		 */
>  		if (can_zcopy)
>  			max_skb_len =3D min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>  					    (MAX_SKB_FRAGS * PAGE_SIZE));

[Severity: High]
This is also a pre-existing issue, but can this max_skb_len calculation
lead to unexpected ENOMEM failures for unaligned MSG_ZEROCOPY payloads?

If a user passes an unaligned buffer for MSG_ZEROCOPY, restricting the SKB
length to exactly (MAX_SKB_FRAGS * PAGE_SIZE) bytes means an unaligned
buffer of this size will span MAX_SKB_FRAGS + 1 pages.

When __zerocopy_sg_from_iter() processes this, it reaches the MAX_SKB_FRAGS
limit before satisfying the requested byte length and returns -EMSGSIZE.
Unlike TCP, which falls back to sending a smaller segment, vsock's
virtio_transport_alloc_skb() propagates this error as a NULL return, which
is then converted into an -ENOMEM failure here. This causes valid sendmsg
calls to fail sporadically based on memory alignment.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614174756.1706=
31-1-avkrasnov@rulkc.org?part=3D1
