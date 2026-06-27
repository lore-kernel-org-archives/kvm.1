Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD46A2D12EC
	for <kvm@vger.kernel.org>; Sat, 27 Jun 2026 13:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782568129; cv=none; b=nzNIow3A8KsF4kANcukLKM5qm2pwKaUU16SA2Z9ah+jtX/IknYBFM9HLcIm0TCwbeYDPaDRqG5byMcQgwy0ydTQ1QAyNyii8++JGHWj5ZtP1g5F5BlycSSVytJF37INo9377CbpqKu4r20okmHVedBaecMlKOfZKM0WcRckjCzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782568129; c=relaxed/simple;
	bh=priMs/FXdDuwQGui4JuPIzNk6savooLZUuBjDdMUX2s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rJtNGMcubAF/rQwhG0JzkOZMJw/CHFNdrXZixWDf4X4B2XGGZzY0lxl6kLwkYpPLiPiWcs8ZUQwacap18QlyMqxWH8P0m6+45ABAiT3Qi1ofHg9RD7fOF+qDrsevh07u7Et93N+p/81oFb6vhXaoQ2EF8AF58C+TnpfZSOD2S3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dURNRvdy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dURNRvdy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A4F1F000E9;
	Sat, 27 Jun 2026 13:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782568128;
	bh=P9iBJXQDxLghBfA23riNkM32cln9zYJVTiIXab/HqjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dURNRvdy5NnxTlk9pGVfhgLYk3Q4twMP/MVhDZMaUVYmW7dxUck2tiPCnNJScCcTa
	 wJFWvnnFTLjX1U3w0R37/R5YB9D4/MXA4tnQWYTNxP4TkP+nQBsHCKFC3ztkCJb1z1
	 Vph+KncZxxL8kye3FYxbi/rA/6tnDjwIQjZHGSIK9PAwyI2CE1189/cnzlSadfpeTD
	 TwjteFAb961nuF1DqVlxwMxYotrMGnzzPLVybNt9HpqbIcnkcS0VH2vToWilldlKV3
	 L4lCrrA59/hDF1scWBxmdVZ1pqGT7NnIdIfkSX8NxmjH8Yaq5YiC61YaTea12F+WC5
	 TFnXWmJqhMehg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] vsock/virtio: collapse receive queue under
 memory pressure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefano Garzarella" <sgarzare@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260626134823.206676-2-sgarzare@redhat.com>
References: <20260626134823.206676-1-sgarzare@redhat.com>
 <20260626134823.206676-2-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 13:48:47 +0000
Message-Id: <20260627134848.20A4F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] If `skb_copy_bits()` fails during receive queue collapse, the er=
ror path drops `new_skb` without updating `rx_bytes` and `buf_used`, causin=
g a permanent socket credit leak and stream corruption.
--

commit 7c26a8d9c487a00892dd5ed3c4bb090956e769a6
Author: Stefano Garzarella <sgarzare@redhat.com>

vsock/virtio: collapse receive queue under memory pressure

This patch adds a mechanism to collapse small packets in the receive queue
into larger, compact SKBs when memory pressure prevents enqueueing new
packets. This reduces SKB overhead and avoids connection resets during large
transfers under backpressure.

Closes: https://lore.kernel.org/netdev/618701dd023e$063de350$12b9a9f0$@gmai=
l.com/

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virt=
io_transport_common.c
> index 09475007165b3..304ea424995d4 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
[ ... ]
> @@ -420,6 +420,137 @@ static int virtio_transport_send_pkt_info(struct vs=
ock_sock *vsk,
[ ... ]
> +/* Called under lock_sock when skb overhead exceeds the budget. */
> +static void virtio_transport_collapse_rx_queue(struct virtio_vsock_sock =
*vvs)
> +{
[ ... ]
> +		/* Cannot fail since src_off/src_len are within bounds, but if
> +		 * it does, discard new_skb to avoid queuing corrupted data.
> +		 */
> +		if (WARN_ON_ONCE(skb_copy_bits(skb, src_off,
> +					       skb_put(new_skb, src_len),
> +					       src_len))) {
> +			kfree_skb(new_skb);
> +			new_skb =3D NULL;
> +			goto out;
> +		}
> +
> +		le32_add_cpu(&virtio_vsock_hdr(new_skb)->len, src_len);
> +		virtio_vsock_hdr(new_skb)->flags |=3D hdr->flags;
> +
> +next:
> +		__skb_unlink(skb, &vvs->rx_queue);
> +		if (keep)
> +			__skb_queue_tail(&new_queue, skb);
> +		else
> +			consume_skb(skb);
> +	}

[Severity: Medium]
If new_skb successfully absorbed data from a previous SKB in an earlier
iteration before skb_copy_bits fails on a subsequent SKB, does
kfree_skb(new_skb) drop that accumulated data without updating vvs->rx_bytes
and vvs->buf_used?

When consume_skb(skb) runs on those earlier iterations, the original SKBs a=
re
freed. If this error path later frees new_skb, the previously merged payloa=
ds
are permanently lost, but the socket accounting still includes them. Will
this leak receive buffer credit and eventually cause the socket to stall?

> +out:
> +	if (new_skb)
> +		__skb_queue_tail(&new_queue, new_skb);
> +
> +	skb_queue_splice(&new_queue, &vvs->rx_queue);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626134823.2066=
76-1-sgarzare@redhat.com?part=3D1
