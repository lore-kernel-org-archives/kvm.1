Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553BF47D945
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629406; cv=none; b=ISRJpiBdgE+wqP1qxLvphEOsEglDxsAL57SXJgwZ2rPuNa/GaHu1qKeCQ2NtN2u7bT9ZQe0J48Y/wM1qi8UFV+IuijYPheg+95tWpmhrQRHg3x99EbQJbDAj9XMnXEfykXE7ie+W7ePg3JfybLtmhAdvTaSF5yE8zxYFcFLVvrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629406; c=relaxed/simple;
	bh=X/MxDMXtHtJQMHyUlCOYoo+mHMQechldHDlIeLgIedY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HqcyBG5CGrE5s7iNSVv8Bb6XV4GNj8sYCiLNd7xOKaVz/u404YS86ri3u415cqsvg0F54H6ESfnKE7Mo5Kvje6jjY/VDktAg4ZP2DP22j78uYK2+79jY4f4uspXzEyZxk68iw9tBUdqk0xMnpv2rhAnJg6GLNH4NtyslFtHYe0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uj8ywRK7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uj8ywRK7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD6C1F00A3A;
	Tue, 21 Jul 2026 10:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784629405;
	bh=6sXddlUe14rJqNf64u0ADHDcNbhc6O8VnsZzi8dBGZs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uj8ywRK7j39J7BwZ8Le8kUurpFV9FTk0osELIX32uNopTihvR3nkd83Y0IbfQ7wlX
	 ZG2OXn/rEjPz3w6adPLrjq1xg4A+3SsKNbDNCpVh6iEjPdiFYHEQmUJBoQtJIV5Pdf
	 ZOhMMkYIZeJYSTLiCpWWL3+7Wa/8PP6CSUrW18sAiy6jlIFGQCEkn0Bo2NVYXr1GEP
	 +UpB5lQzleK5ZoyJojStsPs7MKbesNvpW0UDlJQIf4qLJkhAfIJnhkCLHa5fKXIZW4
	 YG5WQoRFbmTDdhC0RZ9QassXbKGRx0COCylNyKr2kd2UNzG5vdbglgKlbYsdt5t5mi
	 CLwhVl4GbS/gQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing
 workers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Drobyshev" <andrey.drobyshev@virtuozzo.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 10:23:24 +0000
Message-Id: <20260721102325.1BD6C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The placement of `synchronize_rcu()` and `vhost_dev_flush()` at =
the end of `vhost_dev_cleanup()` leaves destructive VQ operations unprotect=
ed against concurrently queued work, leading to data races and potential UA=
F/NULL-derefs.
- [Medium] vhost_workers_free() locklessly clearing vq->worker subverts vho=
st_worker_killed() synchronization, leading to leaked unexecuted work.
--

--- Patch [4]: [PATCH v5 4/5] vhost: synchronize with RCU readers when free=
ing workers ---
commit da9c9bade2016bfb46482de3d7f3d7b75b894fbc
Author: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

vhost: synchronize with RCU readers when freeing workers

This commit adds synchronize_rcu() and vhost_dev_flush() when freeing vhost
workers. It intends to prevent a race condition where a lockless reader que=
ues
work on a worker that is concurrently being freed.

> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 4c525b3e16ead..d6e235c25254c 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -729,6 +729,17 @@ static void vhost_workers_free(struct vhost_dev *dev)
> =20
>  	for (i =3D 0; i < dev->nvqs; i++)
>  		rcu_assign_pointer(dev->vqs[i]->worker, NULL);

[Severity: Medium]
Does clearing vq->worker here subvert the synchronization in
vhost_worker_killed()?

If a fatal signal kills the worker thread, vhost_worker_killed() runs:

drivers/vhost/vhost.c:vhost_worker_killed() {
    ...
    if (worker =3D=3D rcu_dereference_check(vq->worker, lockdep_is_held(&vq=
->mutex))) {
        rcu_assign_pointer(vq->worker, NULL);
        attach_cnt++;
    }
    ...
    if (attach_cnt)
        synchronize_rcu();
}

Because we've already cleared vq->worker locklessly above,
vhost_worker_killed() will see a NULL pointer, leave attach_cnt at 0, and s=
kip
synchronize_rcu().

If a lockless reader then queues work, vhost_dev_flush() will silently
abort because worker->killed is true:

drivers/vhost/vhost.c:__vhost_worker_flush() {
    if (!worker->attachment_cnt || worker->killed)
        return;
}

Will this leave the queued work unexecuted and permanently break the
virtqueue by leaving VHOST_WORK_QUEUED set?

> +
> +	/*
> +	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
> +	 * reader that fetched a worker before we cleared the pointers above
> +	 * may still be queueing work on it.  Wait for those readers to
> +	 * finish, then flush so any work they queued runs (clearing
> +	 * VHOST_WORK_QUEUED) before the workers are freed.
> +	 */
> +	synchronize_rcu();
> +	vhost_dev_flush(dev);

[Severity: Medium]
Does placing the flush here cause a use-after-free with the VQ state?

vhost_dev_cleanup() tears down VQ state locklessly before calling
vhost_workers_free():

drivers/vhost/vhost.c:vhost_dev_cleanup() {
    ...
    for (i =3D 0; i < dev->nvqs; ++i) {
        vhost_vq_reset(dev, dev->vqs[i]);
    }
    vhost_dev_free_iovecs(dev);
    ...
    vhost_workers_free(dev);
}

If a lockless sender (like the upcoming VHOST_RESET_OWNER support in vsock)
queues work that executes concurrently with vhost_dev_cleanup(), the
flushed work will run after the VQ state and memory maps are already
destroyed.

> +
>  	/*
>  	 * Free the default worker we created and cleanup workers userspace
>  	 * created but couldn't clean up (it forgot or crashed).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720102241.3716=
10-1-andrey.drobyshev@virtuozzo.com?part=3D4
