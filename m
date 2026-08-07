Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD1831354C
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111872; cv=none; b=Q1DeQe55fB+MAbPoRFcfAbNjAe8okprtJ0kM97iMlCtnUxTbG0nMB1E3aTIpI1liSAP7C9vfWAN+f6zNvSmzxhz94RjJ9t++U5JqU1JFegUxwA1gmoxjQ9UIOHFA9cGPUxPhd/hc0PkB41gLzEklp8FvXyezkugDkFrwxYgzZKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111872; c=relaxed/simple;
	bh=U9MqL4v+NhVhyTx3Cwek+W3DM0zjnAz1EndTb+NvPYA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dnbwjHeaTJsyjuTfTmfoIou7TWWfSU3pwgJ/Id6SxF0QSLquJRjcB1vZRqPsogv6X1fRgpWpOg2H0V9dNYJpVU/l8bbxlnPt/IlbtXE3v5bKgsTDsaOSHMKm4Q2m+cnt6TaOvSwq2iXDUuMVcA7OeCMe2P7UaR3djZn4TNx0r0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkSoYLDE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkSoYLDE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552891F000E9;
	Fri,  7 Aug 2026 14:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786111869;
	bh=bb/sJcG+BWo03UvESFZh214LfMDWaFFsB8cb1Um84KY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gkSoYLDE3UmvMNDAlJdwfvO1SJxrfxDJ/3Gox15UcJZPrWM8sEValNnPjIYMXdEXl
	 cLiNIg0x3Wrq5mk/i4tEXy34POt1U38yVYI9NT4DsM0G/JwxY1r4nHriuGE87wB0Ub
	 G0FVtk+7KxOMZ/NqIHXXjCJTfo3WMuxq+vWFpWrv1J3OkU1RGG9XRJ5qJABLy++rE5
	 qpvy0+/Lnw202YXNM8Cn9RNBPRnMGbz+C5PSXxccGVG5GYPsU5SFECTN4G0vSQMgDR
	 775G8X4Vk421CZRGirRu+M6tdYAoYgdwTXBJ7oGdJq4lKott1kiwtxYstNDjZoo+LB
	 qyncU1Q8zcejw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] vhost: coalesce and retry IOTLB miss messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260806140616.59025-1-physicalmtea@gmail.com>
References: <20260806140616.59025-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 14:11:08 +0000
Message-Id: <20260807141109.552891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Guest can intentionally trigger a `WARN_ON_ONCE` in `vhost_iotlb_m=
iss`, causing a host kernel panic if `panic_on_warn` is enabled.
- [High] In-flight IOTLB miss node escapes `vhost_clear_msg` during backend=
 detach, causing a permanent virtqueue stall.
- [High] Virtqueues on `iotlb_wait_list` are ignored by `IOTLB_UPDATE` noti=
fications, resulting in permanent deadlocks.
--

--- Patch [1]: [RFC PATCH] vhost: coalesce and retry IOTLB miss messages ---
commit df21dbd6b3d7b91189f87885be5157a564b6e59e
Author: Jia Jia <physicalmtea@gmail.com>

vhost: coalesce and retry IOTLB miss messages

This commit introduces a mechanism to coalesce and retry IOTLB miss
messages in the vhost subsystem. It limits the total number of in-flight
IOTLB messages device-wide and keeps a per-virtqueue record of the current
miss to prevent duplicate allocations.

> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index a0c1d54019aac..d5de41fdc3c05 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c

[ ... ]

> @@ -1191,20 +1198,104 @@ void vhost_dev_stop(struct vhost_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_stop);
> =20

[ ... ]

>  void vhost_clear_msg(struct vhost_dev *dev)
>  {
>  	struct vhost_msg_node *node, *n;
> +	struct vhost_virtqueue *vq, *vq_n;
> +	int i;
> =20
>  	spin_lock(&dev->iotlb_lock);
> =20
>  	list_for_each_entry_safe(node, n, &dev->read_list, node) {
> -		list_del(&node->node);
> -		kfree(node);
> +		list_del_init(&node->node);
> +		__vhost_free_msg(dev, node);
>  	}
> =20
>  	list_for_each_entry_safe(node, n, &dev->pending_list, node) {
> -		list_del(&node->node);
> -		kfree(node);
> +		list_del_init(&node->node);
> +		__vhost_free_msg(dev, node);
> +	}
> +
> +	if (!dev->iotlb) {
> +		list_for_each_entry_safe(vq, vq_n, &dev->iotlb_wait_list,
> +					 iotlb_miss_wait_node) {
> +			list_del_init(&vq->iotlb_miss_wait_node);
> +			vq->iotlb_miss_waiting =3D false;
> +		}
> +
> +		for (i =3D 0; i < dev->nvqs; ++i)
> +			dev->vqs[i]->iotlb_miss_node =3D NULL;
> +	}

[Severity: High]
Can an in-flight IOTLB miss node escape being cleared here during backend
detach, resulting in a permanently stalled virtqueue?

If a userspace orchestrator detaches the backend while a thread is reading =
an
IOTLB miss via vhost_chr_read_iter(), the node is temporarily dequeued for
copy_to_iter(). This function skips the node since it is not on any list.

Because dev->iotlb is still active during backend detach, this fallback
cleanup is skipped and vq->iotlb_miss_node is not cleared. When the node is
later enqueued to the pending_list and a new backend is attached, the next
IOTLB miss will hit the WARN_ON_ONCE(vq->iotlb_miss_node) check and abort
indefinitely.

>  	spin_unlock(&dev->iotlb_lock);

[ ... ]

> @@ -1602,18 +1693,25 @@ static inline int vhost_get_desc(struct vhost_vir=
tqueue *vq,
>  static void vhost_iotlb_notify_vq(struct vhost_dev *d,
>  				  struct vhost_iotlb_msg *msg)
>  {
> -	struct vhost_msg_node *node, *n;
> +	int i;
> =20
>  	spin_lock(&d->iotlb_lock);
> =20
> -	list_for_each_entry_safe(node, n, &d->pending_list, node) {
> -		struct vhost_iotlb_msg *vq_msg =3D &node->msg.iotlb;
> -		if (msg->iova <=3D vq_msg->iova &&
> -		    msg->iova + msg->size - 1 >=3D vq_msg->iova &&
> -		    vq_msg->type =3D=3D VHOST_IOTLB_MISS) {
> -			vhost_poll_queue(&node->vq->poll);
> -			list_del(&node->node);
> -			kfree(node);
> +	for (i =3D 0; i < d->nvqs; ++i) {
> +		struct vhost_virtqueue *vq =3D d->vqs[i];
> +		struct vhost_msg_node *node =3D vq->iotlb_miss_node;
> +
> +		if (!node || msg->iova > node->iotlb_miss_iova ||
> +		    msg->iova + msg->size - 1 < node->iotlb_miss_iova)
> +			continue;

[Severity: High]
Does this loop skip virtqueues that are on the iotlb_wait_list?

When the 2048 message limit is reached, vhost_iotlb_miss() places the
virtqueue on the wait list and returns -ENOSPC without allocating a node,
leaving vq->iotlb_miss_node as NULL.

When userspace later sends an IOTLB_UPDATE for the requested mapping, this
check ignores virtqueues with !node. This means the waiting virtqueues are
never woken up to use the new mapping and stall permanently.

> +		vq->iotlb_miss_node =3D NULL;

[ ... ]

> @@ -1858,8 +1986,40 @@ static int vhost_iotlb_miss(struct vhost_virtqueue=
 *vq, u64 iova, int access)

[ ... ]

>  	msg->type =3D VHOST_IOTLB_MISS;
>  	msg->iova =3D iova;
>  	msg->perm =3D access;
> +	node->iotlb_miss =3D true;
> +	node->iotlb_miss_iova =3D iova;
> +	node->iotlb_miss_perm =3D access;
> =20
> -	vhost_enqueue_msg(dev, &dev->read_list, node);
> +	spin_lock(&dev->iotlb_lock);
> +	if (vhost_iotlb_miss_exists(vq, iova, access)) {
> +		vhost_unwait_iotlb_miss(dev, vq);
> +		goto unlock;
> +	}
> +	if (WARN_ON_ONCE(vq->iotlb_miss_node)) {
> +		ret =3D -EAGAIN;
> +		goto unlock;
> +	}

[Severity: High]
Is it possible for an unprivileged guest to intentionally trigger this
WARN_ON_ONCE?

If a guest triggers an IOTLB miss, vhost allocates a miss node. Before
userspace resolves the miss, the guest could overwrite the descriptor's IOV=
A in
shared memory and issue another kick.

The vhost worker would attempt translation again, fail for the new IOVA, and
re-enter vhost_iotlb_miss(). Because the IOVA changed,
vhost_iotlb_miss_exists() returns false, leading directly to this
WARN_ON_ONCE. This would cause a host kernel panic if panic_on_warn is
enabled.

> +	if (dev->iotlb_msg_count >=3D VHOST_MAX_IOTLB_MSGS) {
> +		vhost_wait_iotlb_miss(dev, vq);
> +		ret =3D -ENOSPC;
> +		goto unlock;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806140616.5902=
5-1-physicalmtea@gmail.com?part=3D1
