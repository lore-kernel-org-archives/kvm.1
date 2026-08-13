Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C9C470EAA
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633215; cv=none; b=C7k+glQ6PSv5Z3PU51dxAmhaxlUo2ejVcjao3zXiTA2+rVnIhQEnh1wGVMSGIGE66l7HGa76GsK5gx1WQlWMHdXzVlp9XtJoFNTAy34iHWba+Mivz+KS4a41h6hS9A7aN7B8nSGL/36zIY7SkIxX3N44k8OCqVCTM31eu1R2jSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633215; c=relaxed/simple;
	bh=dFut0bDEPJ8yVRdPR4MTdKvzpAOU6nVqanSDPIqimX4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D++/jhSbFvNULzyZHyeiUsU33xqVZYPlZ8cAd0CRslXxWyMhGPYNa1XK0NWJpsDRCtusJV5IJ2jNg/OyZxay/c4PQPW4dW0AtpN8zdfpijYnNIJxMYNmfIEMu5RqQ9fd7GE0KpvL/rSqafmh63tiAxPBV8TpPrAKmQWCsUkuL34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0sjxVpF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0sjxVpF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AED91F00A3D;
	Thu, 13 Aug 2026 15:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633208;
	bh=dNyVtsw2PpifOTrmFRKJ35Wx/4U2g9yEqilARH2mSX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h0sjxVpFVqDzLyX0e6THduZRyXodMzx75FQ2gqZmtvNySIX+sFRCShUxNtDBUAKNe
	 icgaupLnBgvtSzrpkAEMUw5SLi3x1Nhh/oc60lJiT66/eZBXhQMEW0wH7n6xYJzV6b
	 GAyk697SazaX5k/Xv4ghYq8DfUCno8N8xeIV73tQQqkLGWQ2eBut/aNKsGrtbXZaqJ
	 XDjKn+e1RIVQjHtPgqnbrdy/MqXve/W1SOwrNf2+oWZa4T4l43PaMTlNUsj5XMDT14
	 Fn0CpVNGzPdfJSkMTyIeqDzRFGiMAHTfBEI6wKCmxyO/tmi7ducYP0urkvR9pMtJ3B
	 8htaAK+XHK9jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/10] vfio: selftests: Add mlx5 driver - HW init and
 command interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Gunthorpe" <jgg@nvidia.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <8-v4-021df3fb5a3f+98e-mlx5st_jgg@nvidia.com>
References: <8-v4-021df3fb5a3f+98e-mlx5st_jgg@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 15:00:07 +0000
Message-Id: <20260813150008.4AED91F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The teardown loop draining the async pages command slot lacks a =
timeout, risking an infinite hang if the firmware fails to respond.
- [Medium] Missing bounds validation on firmware-returned `output_num_entri=
es` can lead to heap out-of-bounds reads and writes.
- [Low] Signed integer overflow when calculating the doorbell vector for th=
e async pages slot.
--

--- Patch [8]: [PATCH v4 08/10] vfio: selftests: Add mlx5 driver - HW init =
and command interface ---
commit 7a09d2b7794945d7a16a9b914796b529c3098e0b
Author: Jason Gunthorpe <jgg@ziepe.ca>
Subject: vfio: selftests: Add mlx5 driver - HW init and command interface

This patch introduces a bare-metal mlx5 ConnectX selftest driver for
VFIO, implementing hardware initialization, teardown, and the command
interface.

> diff --git a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c b/tools=
/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
> new file mode 100644
> index 0000000000000..804801cc564e7
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c

[ ... ]

> @@ -710,9 +710,9 @@ static void mlx5st_pages_slot_post(struct mlx5st_devi=
ce *dev, void *in,
>  				    unsigned int ilen, unsigned int olen)
>  {
>  	mlx5st_cmd_post(dev, dev->pages_cmd_lay, dev->pages_in_mbox,
>  			dev->pages_out_mbox, in, ilen, olen,
>  			1 << dev->pages_slot);

[Severity: Low]
Does this code risk signed integer overflow?=20

If `dev->pages_slot` is 31, shifting the signed literal 1 by 31 bits will
shift into the sign bit, causing undefined behavior in C. Would `1U <<
dev->pages_slot` be safer here?

[ ... ]

> @@ -826,12 +826,12 @@ static void mlx5st_pages_slot_complete(struct mlx5s=
t_device *dev)
>  			mlx5st_cmd_copy_from_mbox(
>  				(u8 *)out + MLX5_CMD_INLINE_SZ,
>  				dev->pages_out_mbox,
>  				outlen - MLX5_CMD_INLINE_SZ);
> =20
>  		num_claimed =3D
>  			MLX5_GET(manage_pages_out, out, output_num_entries);
>  		for (i =3D 0; i < num_claimed; i++)
>  			iovas[i] =3D MLX5_ARRAY_GET64(manage_pages_out, out, pas,
>  						    i);

[Severity: Medium]
Could this result in out-of-bounds heap accesses if the firmware returns an
unexpectedly large output_num_entries?

Should num_claimed be validated against dev->pages_reclaim_npages before
iterating over iovas and out?

[ ... ]

> @@ -1187,14 +1187,14 @@ static void mlx5st_fw_pages_reclaim(struct mlx5st=
_device *dev, u16 func_id)
>  		MLX5_SET(manage_pages_in, in, input_num_entries, batch);
> =20
>  		mlx5st_cmd_exec(dev, in, inlen, out, outlen);
> =20
>  		num_claimed =3D
>  			MLX5_GET(manage_pages_out, out, output_num_entries);
>  		for (i =3D 0; i < num_claimed; i++)
>  			iovas[i] =3D MLX5_ARRAY_GET64(manage_pages_out, out, pas,
>  						    i);

[Severity: Medium]
Similar to the async completion path above, is it possible for a malfunctio=
ning
device to return a num_claimed larger than the allocated batch size?=20

Would it make sense to add a bounds check here to prevent out-of-bounds
array accesses?

[ ... ]

> @@ -1274,13 +1274,13 @@ static void mlx5st_hca_teardown(struct mlx5st_dev=
ice *dev)
>  	u32 out[MLX5_ST_SZ_DW(teardown_hca_out)] =3D {};
>  	u32 in[MLX5_ST_SZ_DW(teardown_hca_in)] =3D {};
> =20
>  	/* Drain async pages slot, then stop EQ processing */
>  	while (dev->pages_slot_in_use) {
>  		if (!MLX5_GET_ONCE(cmd_queue_entry, dev->pages_cmd_lay,
>  				   ownership))
>  			mlx5st_pages_slot_complete(dev);
>  		else
>  			sched_yield();
>  	}

[Severity: Medium]
Can this loop hang indefinitely?=20

Unlike regular commands which use a timeout mechanism, if the firmware fails
to process the async page command and never clears the ownership bit, it lo=
oks
like this will yield forever. Should this include a timeout fallback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0-v4-021df3fb5a3f+9=
8e-mlx5st_jgg@nvidia.com?part=3D8
