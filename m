Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B3C35C6B4
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907215; cv=none; b=B2cMkU91hdApeb77Okun/5ix7FGZQtKrcMFa1oeoRMPWBIEADCJlkUp6wjMavnKctQ1+Hmrr12UPbkD/bb3pch8IdEiizZ+8rcu41ioUBxyJZvL50S8paHBe3+1glbWC770YC6IL9utYm/oFazCpAibOUzFnY8BYIZp5u6KWplo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907215; c=relaxed/simple;
	bh=bvfs/8IGzX7oDjXyDvG1it20ZfACBEJVYZA3rnjW69g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=psFNdVRrU28cuofdLRDF+czNuG4H9PWAhYfFSIHfswc02dn72ZMIVknEyMNMdsdmW5uzPHl2NpEYjqiHqmF455dtgAgQHVXr/DvY34yZh83MJxwF6jYl9gMnVxBVhLhUu2Cx8J6keg11+NPKS9zcW9pNMfJHDQNab1RqNVylUeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h78Y7muO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h78Y7muO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCBF1F000E9;
	Fri, 24 Jul 2026 15:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784907214;
	bh=FVHj6ybCeGqmEuCCQV123cCNesBCRqD554CWZUd827A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h78Y7muOT8RMyejlVpBFxDy2T0jcNAPXhcBoKDt51pjYoJbUTQoVH5cu2XioJnzhi
	 g3FzJb9/jqepd2YN3kDz/y5nHOCB7hpyKfR6DKK3dAgQXzhFkdkxpMN9IO0Tkoy3XM
	 3qKgL+33yeSJLWW0WKfUWw+vqilMQ7LoNDpSYbNA4eaCXmlKUfVq2/DzSUYWoH7HqO
	 2LfjUM3x8/GDiOGMwAno9QEzD+EzwBQxiIm9rR6pj3aQJWR4iI6S+dlIhETV9rAIUw
	 TCnfQ/coHn/NfzBJ5mW2rVyb3aeC0R+tLUxL+rEDXR/5P2OzeEfigZm5VymdAfNHMG
	 PcONG58jt2IIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost: clear vq->worker under vq->mutex when freeing
 workers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Drobyshev" <andrey.drobyshev@virtuozzo.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260723153310.745855-1-andrey.drobyshev@virtuozzo.com>
References: <20260723153310.745855-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 15:33:33 +0000
Message-Id: <20260724153334.1BCBF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch is an incomplete fix that introduces redundant locking=
 while failing to achieve its stated goal.
--

--- Patch [1]: [PATCH] vhost: clear vq->worker under vq->mutex when freeing=
 workers ---
commit b3a889e45c548a1e7c25fa886c0a431a661a7155
Author: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

vhost: clear vq->worker under vq->mutex when freeing workers

The commit adds mutex locking around the clearing of vq->worker in
vhost_workers_free(). The commit message states this is to eliminate the
sole instance where vq->worker is written locklessly.

> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 4c525b3e16ead..dbb6cb5eccea1 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -722,13 +722,19 @@ static void vhost_worker_destroy(struct vhost_dev *=
dev,
>  static void vhost_workers_free(struct vhost_dev *dev)
>  {
>  	struct vhost_worker *worker;
> +	struct vhost_virtqueue *vq;
>  	unsigned long i;
> =20
>  	if (!dev->use_worker)
>  		return;
> =20
> -	for (i =3D 0; i < dev->nvqs; i++)
> -		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
> +	for (i =3D 0; i < dev->nvqs; i++) {
> +		vq =3D dev->vqs[i];
> +
> +		mutex_lock(&vq->mutex);
> +		rcu_assign_pointer(vq->worker, NULL);
> +		mutex_unlock(&vq->mutex);
> +	}

[Severity: Medium]
The commit message notes that vhost_workers_free() is the sole exception
where vq->worker is cleared locklessly, but doesn't vhost_vq_reset() also
do this?

During device teardown, vhost_dev_cleanup() is called, which resets the
virtqueues before freeing the workers:

vhost_dev_cleanup() {
    ...
    for (i =3D 0; i < dev->nvqs; ++i) {
        ...
        vhost_vq_reset(dev, dev->vqs[i]);
            // Inside vhost_vq_reset():
            rcu_assign_pointer(vq->worker, NULL);
    }
    ...
    vhost_workers_free(dev);
}

Because vhost_vq_reset() already unconditionally clears vq->worker
locklessly, won't this new locking block in vhost_workers_free() simply
acquire the lock to write NULL to a pointer that is already NULL?

Since the lockless write still exists in vhost_vq_reset(), does this patch
fully achieve its stated goal, or does it add an unnecessary lock cycle?

>  	/*
>  	 * Free the default worker we created and cleanup workers userspace
>  	 * created but couldn't clean up (it forgot or crashed).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723153310.7458=
55-1-andrey.drobyshev@virtuozzo.com?part=3D1
