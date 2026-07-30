Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BA0449B34
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437971; cv=none; b=q6Yhp0DWmZmmkbzgWJ/3FBaA/9Q8nSlX5ObXzVEkbPLDz3WeK3vied0t8zHML2DlMPEfn3J9VRBgBVXwFmifEVzHXMoCDONnUm9l0USXme3jRaiQxcvt6IB4Bx65S6Cu06yeIbNiPSCGtABTmaIfcdLcxkp8vcTOPjckbDQeb0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437971; c=relaxed/simple;
	bh=gTatSQfPhViYI04YU5D9d8W93JAvO9Cfkc1fTQ+cfdQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G3MxpAEJksDbyYNZX1lYW3SyaDz1p4HclB98/yx8VD4BmHernaZFsH92gRHDdkj9MOzEpycPtKScDz0uS+1fDjlBK8QSVdun2vC5V6gdKg3Y3ctFdUSZN224SiZuaSLhevhiPsZMWgu0GL35BSjF3hE5gra6hw76UFbmmZdBoX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqWtmu5i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqWtmu5i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBE41F000E9;
	Thu, 30 Jul 2026 18:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785437968;
	bh=g25RUeMFEHjNqVkqfzXOZ67BR7DM9dBSal11eefVFKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IqWtmu5ieW9NKjrjiEFeOqsSv1H7LcJMi8e3iCht5J4QPCsvItVQzvc+C1os4A47P
	 oGEnsvvC0sJJR5ogothZ5JWXPsmj/6QZ34Ej95Xko443cf0iT+7I1x30rucWB2ZGEW
	 O6pAJ6YEd/CiYk4W90MFJY8m9/4O5O3J3xLBvJZrVOIY72OFfcCUMcZIunPGApb5k8
	 aZo3bSd9BBDOnk6HUbn2heUrafckkIyoiZ5pgzy+yW9WZYLcU6MD7/ZiuAtnuB85fU
	 PYqZeQR33YXcK1GG4ESiesuEKNO49t4t5vTx2YVYP0z/5TO7hH0HNh6cx9W1+L2w2A
	 8FN3N7QDKYE0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] vsock/virtio: read virtqueues under worker locks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729185831.3247971-2-bestswngs@gmail.com>
References: <20260729185831.3247971-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 18:59:27 +0000
Message-Id: <20260730185927.CEBE41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Flawed workqueue flush order in `virtio_vsock_remove` causes U=
se-After-Free when `virtio_transport_send_pkt_work` queues `rx_work`.
--

--- Patch [1]: [PATCH v2 1/2] vsock/virtio: read virtqueues under worker lo=
cks ---
commit c2d4498ec56e6055b57f65b66030241e0c52ce07
Author: Weiming Shi <bestswngs@gmail.com>

vsock/virtio: read virtqueues under worker locks

This commit ensures that virtqueues are read under their respective worker
locks after checking the run flag. This prevents a worker delayed across fr=
eeze
and restore from observing a running state while retaining a pointer to a
deleted queue.

Link: https://lore.kernel.org/r/20260727035804.1860862-1-bestswngs@gmail.com

> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_tran=
sport.c
> index 57f2d6ec3ffc6..a8e1dd95ba8c8 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct work_st=
ruct *work)
>  	struct virtqueue *vq;
>  	bool added =3D false;
> =20
> -	vq =3D vsock->vqs[VSOCK_VQ_TX];
>  	mutex_lock(&vsock->tx_lock);
> =20
>  	if (!vsock->tx_run)
>  		goto out;
> =20
> +	vq =3D vsock->vqs[VSOCK_VQ_TX];
> +
>  	do {
>  		struct sk_buff *skb;
>  		unsigned int len;

[ ... ]

> @@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct work_st=
ruct *work)
>  		container_of(work, struct virtio_vsock, rx_work);
>  	struct virtqueue *vq;
> =20
> -	vq =3D vsock->vqs[VSOCK_VQ_RX];
> -
>  	mutex_lock(&vsock->rx_lock);
> =20
>  	if (!vsock->rx_run)
>  		goto out;
> =20
> +	vq =3D vsock->vqs[VSOCK_VQ_RX];
> +
>  	do {
>  		virtqueue_disable_cb(vq);
>  		for (;;) {

[Severity: Critical]
This is a pre-existing issue, but does the workqueue flush order in
virtio_vsock_remove() risk a use-after-free if virtio_transport_send_pkt_wo=
rk()
queues rx_work concurrently?

Looking at virtio_vsock_remove(), works are flushed in this order:

    flush_work(&vsock->rx_work);
    flush_work(&vsock->tx_work);
    flush_work(&vsock->event_work);
    flush_work(&vsock->send_pkt_work);

If virtio_transport_send_pkt_work() runs concurrently, could it be preempted
after dropping the tx_lock, but before queuing rx_work?

virtio_transport_send_pkt_work() handles this here:

    mutex_unlock(&vsock->tx_lock);

    if (restart_rx)
        queue_work(virtio_vsock_workqueue, &vsock->rx_work);

If preempted there, virtio_vsock_remove() would skip flush_work(&vsock->rx_=
work)
because it isn't queued yet. It would then flush send_pkt_work, blocking un=
til
virtio_transport_send_pkt_work() resumes.

When virtio_transport_send_pkt_work() resumes, it queues rx_work and finish=
es.
virtio_vsock_remove() would then complete and free the vsock object via
kfree(vsock), leaving the newly queued rx_work pointing to freed memory.

Could the flush of rx_work be moved after the flush of send_pkt_work to han=
dle
this race?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729185831.3247=
971-1-bestswngs@gmail.com?part=3D1
