Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30553C81A9
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391423; cv=none; b=SzTXEVhOAYKka2w0ZTR8ZLxdoHQYxawh5Dc0wxr8MgQbsRuiRLpVc0URHCozBMufKasBgBy2FvF3JSizMSGhJF3SSHKsJzWfKrnOVAr6X1VKPXRdQrEMlE/GdpN7mJzBUcbv+kTUVh7EKZG2kTVIttB6bR75/jaZqQeYLGCj8X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391423; c=relaxed/simple;
	bh=FgI4A/9tnstIZfI5Ks+6/YGXWuYr173O3UVnVL9EJ7I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lCX65f19J4bZoYcUv/zj9WAMzlb/n20tTy1JfywIE0pzCfYDJyybhEo+JvDs5OvvHR8cB03W+0Zz2RKxVbtGSnlUZlGLNEC/tf/JSbaPDab/CZ9kqcEGVNyn41qinPzh8k8y+ZLXhCmkUH5LsBFA82SOlXqjI7l2Kk3OVVMdk3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XojPCHvs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XojPCHvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4831F00893;
	Tue,  2 Jun 2026 09:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780391421;
	bh=ILvYXytW3GvzH5v1r/Xh6Y5AOIJV+J5oeStyEHN/yps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XojPCHvsa8NlCS89QcMHqOQCyLcZC2Vn+iyxIL3WnQXQVDKtIlCH9zpg7qL8pBSvX
	 uXFC9go4htPt2y3fOmMAxotCEhju4hlaeTF3+2KqIEttHyBNKgzRo8QaBYRxfGJUMa
	 i0eOCFhwu/Dspq5RLmCr+C4tyd1IqRdRHTWHpDZHKd9UhBckFWRnrk3oS0eE/ypZ+Z
	 TqAJAy2UQ6zpxN/mXnWmhgI8AkMmcnDR3bCnH+qT+NPIDfREWSqrpqamBb0ujwOtLX
	 /981MZdbZKYkgpU83zkWBRC8JK8QMDmBh/gYHYvuKNRY4RV7mMcX0jr2lyzoE4Pk1e
	 ufslQw9gcTrdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vfio: prevent infinite loop in
 vfio_mig_get_next_state() on blocked arc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <SYBPR01MB7881290BBDE79B61AE6A017FAF122@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB7881290BBDE79B61AE6A017FAF122@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 09:10:20 +0000
Message-Id: <20260602091020.DD4831F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `fput()` in the PDS driver's `pds_vfio_set_device_state()`=
 error path causes a `struct file *` leak.
--

commit 58878b617bd3ea4ea6d193f84e2c58c92a228294
Author: Junrui Luo <moonafterrain@outlook.com>

vfio: prevent infinite loop in vfio_mig_get_next_state() on blocked arc

This commit fixes an infinite loop in vfio_mig_get_next_state() caused by
blocked migration arcs evaluating to the ERROR state. It terminates the loop
when the next state is VFIO_DEVICE_STATE_ERROR, falling through to properly
report -EINVAL instead of spinning forever.

> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 6222376ab6ab5..5e0422014523e 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -858,7 +858,8 @@ int vfio_mig_get_next_state(struct vfio_device *devic=
e,
>  	 * logical state, as per the above comment.
>  	 */
>  	*next_fsm =3D vfio_from_fsm_table[cur_fsm][new_fsm];
> -	while ((state_flags_table[*next_fsm] & device->migration_flags) !=3D
> +	while (*next_fsm !=3D VFIO_DEVICE_STATE_ERROR &&
> +	       (state_flags_table[*next_fsm] & device->migration_flags) !=3D
>  			state_flags_table[*next_fsm])
>  		*next_fsm =3D vfio_from_fsm_table[*next_fsm][new_fsm];
> =20

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this change
to how vfio_mig_get_next_state() handles transitions, I noticed a potential
resource leak in the PDS driver's usage of it.

In pds_vfio_set_device_state(), pds_vfio_step_device_state_locked() can
return a valid struct file pointer (for example, when transitioning from
STOP to STOP_COPY). If the state machine is not at its final state and
the WARN_ON triggers:

drivers/vfio/pci/pds/vfio_dev.c:pds_vfio_set_device_state() {
        ...
		res =3D pds_vfio_step_device_state_locked(pds_vfio, next_state);
		if (IS_ERR(res))
			break;

		pds_vfio->state =3D next_state;

		if (WARN_ON(res && new_state !=3D pds_vfio->state)) {
			res =3D ERR_PTR(-EINVAL);
			break;
		}
        ...
}

Does overwriting res here permanently leak the struct file reference, since
res is assigned ERR_PTR(-EINVAL) without first calling fput(res)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SYBPR01MB7881290BBD=
E79B61AE6A017FAF122@SYBPR01MB7881.ausprd01.prod.outlook.com?part=3D1
