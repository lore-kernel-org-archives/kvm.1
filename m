Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7EB347BDB
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786183289; cv=none; b=pyR0MbMC+GnwFHQ+8IB2pNYfX5ogSpzEovuCkoLu4k8G8ixX5+tk5gVayCqFjQ4CSDQI7t1EEae+ATx0GTGjQSikIAgbdkaohtKsgPpakizZQsK7+9JiZO7U/H7weRqdVsHlunPY6ZzOc6cpmlaOJrXQgmcBMRFSSC80wa6crmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786183289; c=relaxed/simple;
	bh=xsqk3eRLwdV99XDV+yAARGjjj6QNsB6EQxQXhzw7EWM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SeJ8H1xTv5FpKMs8liNkbUeco3jGh2rr8BlSJR/IZbgIXPugevIZ4Am1WUCi6+O9/MQRMj0O91+0pkeeOFypsK9Q4LfOT/RXXrU2LQIu7pxjy8+my/jUD8ieVmzaNmc0uMZP2uNESf0nPy3zhO0GrA1SKtDKzUX41OdcIttpbm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4TQaVmK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4TQaVmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF84C1F000E9;
	Sat,  8 Aug 2026 10:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786183288;
	bh=2KKMSIo0tXkje9SoGhZ3KP144btY8lVHj4ie2qDvqXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m4TQaVmKpfUlzKrgs/QE/s0dsLMgH+vrTvpjTt75Q9EDy48Au3bV9sLrabZphPqYk
	 Vl+jRn3YPDbQ5vc2TR0K9eqkuYnQJ4R06MidKQjJ6vW5v/gVzpH3jAHr2zil0sleOe
	 OG6sy4vwPY5ZKwjUVUp0ditDmSSmS7Q1CLpuxcg+HoTUTysB6nGkLMcrgh3AF53BA/
	 rrJIfgbiNunP+S+K+mV1BT6usRxREBO6JjIBW2nWbzrrNPV93tp1In24csaagn8+/H
	 nYoitM/Pk2b0RocMoxydqC8YFXpapOiRYqEHdI8ExxiB0heGUjD4e3cFzGnQlGDR71
	 9m/24wEgcunYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] vhost-vdpa: don't install the eventfd_ctx_fdget()
 error in config_ctx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <yuz08559@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260807100025.19750-2-yuz08559@gmail.com>
References: <20260807100025.19750-1-yuz08559@gmail.com>
 <20260807100025.19750-2-yuz08559@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 10:01:26 +0000
Message-Id: <20260808100127.CF84C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Lack of synchronization between `vhost_vdpa_set_config_call()`=
 and the config interrupt handler `vhost_vdpa_config_cb()` leads to a Data =
Race and a Use-After-Free on `v->config_ctx`.
--

--- Patch [1]: [PATCH 1/2] vhost-vdpa: don't install the eventfd_ctx_fdget(=
) error in config_ctx ---
commit 97c24916f7205e9db996343c66b6d1658f9125bd
Author: Yu Zhang <yuz08559@gmail.com>

vhost-vdpa: don't install the eventfd_ctx_fdget() error in config_ctx

This commit avoids storing an error pointer in the configuration context on
failure. It validates the file descriptor prior to swapping it, preventing
config interrupts from encountering an invalid pointer.

> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -536,18 +536,14 @@ static long vhost_vdpa_set_config_call(struct vhost=
_vdpa *v, u32 __user *argp)
>  		return  -EFAULT;
> =20
>  	ctx =3D fd =3D=3D VHOST_FILE_UNBIND ? NULL : eventfd_ctx_fdget(fd);
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
>  	swap(ctx, v->config_ctx);
> =20
> -	if (!IS_ERR_OR_NULL(ctx))
> +	if (ctx)
>  		eventfd_ctx_put(ctx);

[Severity: Critical]
This isn't a bug introduced by this patch, but can this sequence lead to a
use-after-free if a config interrupt occurs concurrently?

In the interrupt handler, the pointer is read locklessly:

drivers/vhost/vdpa.c:vhost_vdpa_config_cb() {
    struct eventfd_ctx *config_ctx =3D v->config_ctx;

    if (config_ctx)
        eventfd_signal(config_ctx);
    ...
}

If the ioctl thread executing vhost_vdpa_set_config_call() swaps out the old
context and immediately calls eventfd_ctx_put(), it might free the context
while the interrupt handler has already read the old pointer but hasn't yet
called eventfd_signal().

Does this code need synchronization before freeing the old eventfd context =
to
wait for concurrent interrupt handlers to finish?

> -	if (IS_ERR(v->config_ctx)) {
> -		long ret =3D PTR_ERR(v->config_ctx);
> -
> -		v->config_ctx =3D NULL;
> -		return ret;
> -	}
> -
>  	v->vdpa->config->set_config_cb(v->vdpa, &cb);
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807100025.1975=
0-1-yuz08559@gmail.com?part=3D1
