Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CD431D381
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781369865; cv=none; b=atXsc5QIgf8YhHolteNBCba6M4cYsniX12cX74vTnWWY381RopFCvb2tvmyQC0LA+BTJ+x3vG5YVLyfrrONR6RtWhSRUQqouiP77utaXnLsH/XCSvUVrL2Trxi/300EUqBIrbSGB727ZU/5bbCjMaBFjl/TF0KeOPFX7IaExEIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781369865; c=relaxed/simple;
	bh=kis/d3RgbyqkMs6TJ1RL/RvQahdzbryg1tzc8jJXIXM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZaH34abJ6pZG3xjOmTvJiKcbGz4vvhxH4l4wIR41ZhPYVh0mcsp/gTK7ziFZO7WsG9EDyZfSwtxtbTRtA14atv6fC+1ttRe2hlj/qIPo/KkDwNt4Tw4DShnfwal3WI9QRN/RebH41CLvbE7Mq38hJy2c1bpkLfKjXjgG+0jKhhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGS62Y4r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGS62Y4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D901F00A3A;
	Sat, 13 Jun 2026 16:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781369864;
	bh=PDN+TzQCuTKj0TAFECm60kO6zDkx0bg5a/ucIVaKcJs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mGS62Y4rqsUxTZoY1aTrHyMoLnHckAwfTfu/rs+SKBVwlst2AhgdIpqLqMbolZ7NB
	 7ST4fWbTmEqleUy6z0Tmb/aq47JMms8i4Ltdb8YlWNeG7g/HEWL5Ov1I/WHwHMv8wb
	 I2uhKnTUVHKDfS19I6ekcU+RSOvkFH76RiYjOH9wtG3/SfqY6noW5O/CFjolYkkPb6
	 eJEfDivlI6PQSM0zlpvMMN1sCK7YIaqsTQVWHkO7l1t2i/fLIZRKAMLWdoZgIYCXj0
	 GMzfXHhZHOHY99bCC8GqMlqYkN5rtG1oI5xCIPKHRknMwqn7VzRMvdyCb3Ph/7RK7i
	 iWNlfIzqemmyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] vhost/vsock: suppress EHOSTUNREACH fast-fail during
 CPR pause
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Drobyshev" <andrey.drobyshev@virtuozzo.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260612165718.433546-4-andrey.drobyshev@virtuozzo.com>
References: <20260612165718.433546-4-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 16:57:43 +0000
Message-Id: <20260613165743.C9D901F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Memory ordering TOCTOU race allows incorrect fast-fail of packets =
during CPR resume.
--

commit ee9060520c490bf817a7d5354ea841c3834e4978
Author: Denis V. Lunev <den@openvz.org>

vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause

This commit suppresses the fast-fail in vhost_transport_send_pkt() during C=
PR
pause by adding a cpr_paused flag. The flag is set when backends are dropped
and cleared when started, allowing packets to be queued instead of dropped
with -EHOSTUNREACH while the connection is paused.

> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index e629886e5cf84..bcaba36becd79 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
[ ... ]
> @@ -311,11 +312,17 @@ vhost_transport_send_pkt(struct sk_buff *skb, struc=
t net *net)
>  	 * the mutex would be too expensive in this hot path, and we already ha=
ve
>  	 * all the outcomes covered: if the backend becomes NULL right after th=
e check,
>  	 * vhost_transport_do_send_pkt() will check it under the mutex anyway.
> +	 *
> +	 * Don't fast-fail if cpr_paused is set, keep queueing skbs instead.
> +	 * The kick in vhost_vsock_start() will drain them on resume.
>  	 */
>  	if (unlikely(!data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX]))=
)) {
> -		rcu_read_unlock();
> -		kfree_skb(skb);
> -		return -EHOSTUNREACH;
> +		smp_rmb();	/* pairs with smp_wmb() in start/drop_backends */
> +		if (!READ_ONCE(vsock->cpr_paused)) {
> +			rcu_read_unlock();
> +			kfree_skb(skb);
> +			return -EHOSTUNREACH;
> +		}
>  	}
> =20
>  	if (virtio_vsock_skb_reply(skb))
[ ... ]
> @@ -640,6 +647,9 @@ static int vhost_vsock_start(struct vhost_vsock *vsoc=
k)
>  		mutex_unlock(&vq->mutex);
>  	}
> =20
> +	smp_wmb();	/* pairs with smp_rmb() in send_pkt */
> +	WRITE_ONCE(vsock->cpr_paused, false);

[Severity: High]
Does this memory ordering still allow a TOCTOU race where packets are
incorrectly fast-failed?

In vhost_vsock_drop_backends(), the writer updates variables in the order:
cpr_paused =3D true -> smp_wmb() -> backend =3D NULL.

The lockless reader in vhost_transport_send_pkt() reads in reverse order:
backend -> smp_rmb() -> cpr_paused. This correctly guarantees it won't see
backend =3D=3D NULL without cpr_paused =3D=3D true.

However, here in vhost_vsock_start(), the writer updates them in the same
order as the reader:
backend =3D vsock -> smp_wmb() -> cpr_paused =3D false.

Because both the reader and this writer process the backend pointer first a=
nd
cpr_paused second, the memory barriers do not prevent interleaving. Can a
concurrent reader execute its first read (backend) before the writer's
update, seeing NULL, and its second read (cpr_paused) after the writer's
update, seeing false?

This would cause the reader to erroneously drop the packet with
-EHOSTUNREACH on an active connection.

> +
>  	/* Some packets may have been queued before the device was started,
>  	 * let's kick the send worker to send them.
>  	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612165718.4335=
46-1-andrey.drobyshev@virtuozzo.com?part=3D3
