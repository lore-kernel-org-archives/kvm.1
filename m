Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1EB49659
	for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781395834; cv=none; b=FQ7gj5VI5+cLkSiNg1TOklCaHGDpae9RtVUWVfuFndjP1JJCaiAN6gzxz7zHb1y38QCe8J6yZhMdInPdUpyynGY2xOK8IePUsi3lDis2QGzSkpe+42cJ52rKMuaWM2C5ymC8/ryPhGRBNtet2mHVcJSQ3Mi0M5X9+iILPb27dvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781395834; c=relaxed/simple;
	bh=YofLYg0i2BkQCTN+BiG0fX3koF452UVr2VBvQjTJ7bw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AklkHx28fto/8TZ7KDySfcyJdYrFEUZa4t3mgm0kre7cqvexjjW4KLbNGB6P6RYMK/g5cuYg3fMo1Qzro5nUfZCGOQvBRV6J2sQYYDO3OQUdptEbUd2rv9yzXDOCVLsWg4SOkDCgnJtHDoMMSCmGnkwmGfMc6sQ3bb4chkLfqsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAUknsW/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAUknsW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96051F00A3A;
	Sun, 14 Jun 2026 00:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781395833;
	bh=zwzenxrb2LvDDSwcTlldptaNj7+7pWbSXAR0uuRp+kM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mAUknsW/XRMT3TqVEC2IEfRQRMOF5Sn5RvtWS+L1GemOf3PMzl832Dhm2xfnM4cO1
	 pzgEPTUfuTLAR/kBY30GNdMWcjSexH0mY5Z43t5OoiBjB1c6IhTj9tdfKZzD6oWMJs
	 hY/+Jfp1eaECAgxNrTGf7FcskHpqswXr2dlCIZdCyHC5AAn8dwrXyoY8FmhYIYV/fy
	 yeTUIoUnLKhaukZdniF3TFQx3TSxIUHhY7LM3TaNeHhg2UGahJkps33j+ss5etAFb/
	 yrSpYoGx0Z1QmVaAqQUyZxwTP8EKIolqgb2wjc4JAbZXdD2poPt43RiclDpo5coNNJ
	 Y24CMKdJaR3vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/2] vsock/virtio: restore msg_iter on
 transmission failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Octavian Purdila" <tavip@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260613000953.467473-3-tavip@google.com>
References: <20260613000953.467473-3-tavip@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 00:10:33 +0000
Message-Id: <20260614001033.A96051F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Use of `iov_iter_restore` causes spurious `WARN_ON_ONCE` for `IT=
ER_KVEC` iterators and lacks support for `ITER_FOLIOQ`, risking state corru=
ption.
--

commit adc9013e2e0f53e4c04e792c4d6b248a3f5afb54
Author: Octavian Purdila <tavip@google.com>

vsock/virtio: restore msg_iter on transmission failure

This commit addresses an iterator desync issue when packet allocation or
transmission fails by saving the msg_iter state before attempting to alloca=
te
and send, and restoring it if an error occurs.

> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -368,8 +369,17 @@ static int virtio_transport_send_pkt_info(struct vso=
ck_sock *vsk,
>  		struct sk_buff *skb;
>  		size_t skb_len;
> =20
> +		/* Save iterator state in case allocation or transmission fails
> +		 * so we can restore it and retry.
> +		 */
> +		if (info->msg)
> +			iov_iter_save_state(&info->msg->msg_iter, &msg_iter_state);
> +
>  		skb_len =3D min(max_skb_len, rest_len);
> =20
> +		/* Note: virtio_transport_alloc_skb() can advance info->msg->msg_iter
> +		 * even if it fails (e.g. partial GUP success).
> +		 */
>  		skb =3D virtio_transport_alloc_skb(info, skb_len, can_zcopy,
>  						 uarg,
>  						 src_cid, src_port,

[ ... ]

> @@ -399,6 +409,9 @@ static int virtio_transport_send_pkt_info(struct vsoc=
k_sock *vsk,
>  			break;
>  	} while (rest_len);
> =20
> +	if (info->msg && ret < 0)
> +		iov_iter_restore(&info->msg->msg_iter, &msg_iter_state);
> +

[Severity: Medium]
Does this iov_iter_restore() call risk triggering a spurious warning for
ITER_KVEC iterators or silently failing for ITER_FOLIOQ?

In-kernel socket consumers, such as the Network Block Device, actively
construct ITER_KVEC iterators for request headers and send them via
sock_sendmsg(). Users can configure NBD over a vsock socket.

If memory pressure causes virtio_transport_alloc_skb() to fail during an
NBD transmission, the error path invokes iov_iter_restore() which evaluates
the following condition:

lib/iov_iter.c:iov_iter_restore() {
	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i) &&
			 !iter_is_ubuf(i)) && !iov_iter_is_kvec(i))
		return;
...
}

For ITER_KVEC iterators, the first part of the expression evaluates to true,
unconditionally triggering a kernel warning before restoring the iterator. =
On
systems with panic_on_warn enabled, this could lead to a kernel panic.

Additionally, iov_iter_restore() explicitly ignores ITER_FOLIOQ iterators,
meaning it would silently fail to restore the state if the VFS passes such
an iterator, potentially leading to infinite loops and desynchronization.

Could tracking the number of bytes advanced and using iov_iter_revert()
provide a safer way to handle this rollback?

>  	virtio_transport_put_credit(vvs, rest_len);
> =20
>  	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613000953.4674=
73-1-tavip@google.com?part=3D2
