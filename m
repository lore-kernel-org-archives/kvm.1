Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3490047F2F2
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128630; cv=none; b=G3HIBmWgIC7Pirlvs9+uej4R7wjSQrVGPveovjZBGpvzgn+VrTT/SsjfgpAI4HjShvH1x0QipKbADZMtgC9Mll7bCJ8JfOunHo2U8Ip7/TA9DJcD+59/DR+PqdXD04iRc4ILZ+TJmrgPeZbbrm1J1tOfkxlwbu7amrnbc6v8DIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128630; c=relaxed/simple;
	bh=k40W8CexIoKm7x8yfjHCqRIHTPfR+gaWB1asyujvZNw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WCgpFcCCv9diQtJO006Ek6LDbs1i/UatqjZtlRr2d1h+7G/JOCrK+M5jll5U8ZKhfpzWwJlJtqbPIsuIyvIpRMmrpaugPsV5OZDUDjdH2v/D6cIcFB0BEg5+OcRYfJKKknfE6+Ug4uKT/o4gt3eohk1oEtKdMVbEH5ApAxhro7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTY0wSyC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTY0wSyC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9290E1F000E9;
	Wed, 15 Jul 2026 15:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784128628;
	bh=4tkJWnJ1x5ESWRzPOy2pZYIBUKWmEJnvT6/VCEFzgyg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aTY0wSyCoZqAVvIqxVrvKhmHfEUSSiWjAWUyqKpWJm9+yHdnPgjiIYVPaPYSSMvup
	 8HGqq8qpMfNODj5yuV0iWKYR+1gfaEpvdiHrwK2QsavDbxgRlywDzD8iaw/8njcckw
	 IQEG70UOeB/bWTwWbpIc0849/GaN62FO0RUJuk7lYbhIJR+gG/G08aq4xJR1J+D5Zf
	 Hz5kiNzu6uKWQOF0OipGznsu0Few1Q/og6S3PjI0VU8pHOFsZFfZjgGvqCUjDWjdxB
	 m9QtwaHUS8y7+5pf4MPAgkIZyqOQ8ZwYrmbc7bYbZ44rtZb1vSvfJKeGxRd3+YqAF8
	 xOITvE7oLu39Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] vhost: synchronize with RCU readers when freeing
 workers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Drobyshev" <andrey.drobyshev@virtuozzo.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714151638.143019-5-andrey.drobyshev@virtuozzo.com>
References: <20260714151638.143019-1-andrey.drobyshev@virtuozzo.com>
 <20260714151638.143019-5-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 15:17:08 +0000
Message-Id: <20260715151708.9290E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Executing queued works synchronously in `vhost_workers_free` runs =
them in the caller's user task context, triggering a `WARN_ON` in `kcov_rem=
ote_start` and causing concurrency issues.
--

--- Patch [4]: [PATCH v4 4/5] vhost: synchronize with RCU readers when free=
ing workers ---
commit bda2bbe84ea18859f63f457a24229bd9742c9be1
Author: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

vhost: synchronize with RCU readers when freeing workers

This patch synchronizes with RCU readers in vhost_workers_free() before
destroying vhost workers. It waits for a grace period and then explicitly
runs any newly queued work items left on the workers' lists. This ensures
nothing is left with VHOST_WORK_QUEUED set.

> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 4c525b3e16ead..0d1414d40f4e7 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -729,6 +729,21 @@ static void vhost_workers_free(struct vhost_dev *dev)
> =20
>  	for (i =3D 0; i < dev->nvqs; i++)
>  		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
> +
> +	/*
> +	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
> +	 * caller that fetched a worker before we cleared the pointers above
> +	 * may still be about to queue work on it.  Wait for those RCU readers
> +	 * to finish before freeing the worker, then run whatever they queued
> +	 * so nothing is left with VHOST_WORK_QUEUED set.  Mirrors
> +	 * vhost_worker_killed().
> +	 */
> +	if (!xa_empty(&dev->worker_xa)) {
> +		synchronize_rcu();
> +		xa_for_each(&dev->worker_xa, i, worker)
> +			vhost_run_work_list(worker);

[Severity: High]
Can executing vhost_run_work_list() synchronously in the caller's task cont=
ext
trigger a KCOV warning or cause concurrency issues?

When vhost_workers_free() is called from a user task (like handling the
VHOST_RESET_OWNER ioctl), vhost_run_work_list() will be executed in that
task's context.

This calls kcov_remote_start_common(), which expects to be called from a
background thread and will trigger a warning if KCOV is already enabled for
the current task:

kernel/kcov.c:kcov_remote_start() {
	...
	if (WARN_ON(in_task() && kcov_mode_enabled(mode))) {
		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
		return;
	}
	...
}

Additionally, since the worker kthreads are not stopped until
vhost_worker_destroy() is called later in this function, could the ioctl
thread and the kthread concurrently dequeue and execute work items, breaking
vhost work serialization?

> +	}
> +
>  	/*
>  	 * Free the default worker we created and cleanup workers userspace
>  	 * created but couldn't clean up (it forgot or crashed).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714151638.1430=
19-1-andrey.drobyshev@virtuozzo.com?part=3D4
