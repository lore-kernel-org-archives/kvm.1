Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909BB38911B
	for <kvm@vger.kernel.org>; Sat, 18 Jul 2026 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784384546; cv=none; b=EKK2PECCgTFF5+/PrEvEYxzdEA1/4fPz/eriwlLTImu3ZFCP73pHwfCN83iUeaL+bWKvQaBGw3/CQJRz/ik8vv/tr/jd6HaB6ZRYHSgN0wjYX8LSiMYCepD4gK8TWEHaxhLtnak7SJdVvJovzSNgkDGh7IHwfhdUhyIYOUDsa9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784384546; c=relaxed/simple;
	bh=nj0RfTDOOk/RVuOqgAUDl8HA6RWcXJ3VWn4JbsFh+kc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NOxcQ5yKOhG/6qusQR9nsl57Aawjhgba4xDbva6HiknfW5qPY09HwJEP5baouZQWsrX2jJ0PztYwdkt8BRS7s1wjwPaOUevhrcZ6lU8t2uOnoUhV9jdYPkSkIeFxGhKasIg1VhSKYMWyGCzDjdX2jTokClfW59P9qbBdx6FcbmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVAKrXZ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVAKrXZ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6A51F000E9;
	Sat, 18 Jul 2026 14:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784384543;
	bh=TY7b7ut508wuq5P8ZN39L8x1vscBYmeS5nBuCLXCWdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MVAKrXZ1+2J9PPPs+HMewH2d6uQUQShr0kd6OlrLGtjqx+OpKoOHbLrJBq1HpqTbn
	 14QDNnmewtBWU8533nNVVtU3TR50OM2EjZ6ZGyppnWAPKWZhJBb6ny13en9UmsKfnx
	 NWRObeVto63eXXSSTOYC66Th4GOPvJmHhbS4CUolkp+hQBH8qb+F2dlgVgiMFUMPT3
	 9+Cw16XIRgkVZ9+MPsN1tzR52/Nx8Bh/LMzLy8b2bcHbWUmkw1U/f4HWqLaXvWuBLs
	 j/DxV3tNjFYIaBR3RHEWaMBskmLwFTo9RwKg0Z02l1+wJoNN3N/90EAn4e0msOOLR2
	 cw0V1fh3bb2iA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost-scsi: Prevent OOM from invalid protection SGL
 count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260717142205.103515-1-physicalmtea@gmail.com>
References: <20260717142205.103515-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 14:22:23 +0000
Message-Id: <20260718142223.9D6A51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A malicious guest can reliably crash the host kernel by provid=
ing a virtio-scsi request where the T10 Protection Information length equal=
s or exceeds the total data payload size, triggering a BUG_ON() during SGL =
allocation.
--

--- Patch [1]: [PATCH] vhost-scsi: Prevent OOM from invalid protection SGL =
count ---
commit ee69ef365d50119dd5831e263cc68413e6e2bee1
Author: Jia Jia <physicalmtea@gmail.com>

vhost-scsi: Prevent OOM from invalid protection SGL count

The protection SGL path passes the result of vhost_scsi_calc_sgls()
directly to sg_alloc_table_chained(). The helper returns a negative
errno when the iterator is invalid or the request exceeds the segment
limit. The negative errno is then treated as a very large unsigned count
and sends the request into the SGL allocation path with an invalid size.

Cc: stable@vger.kernel.org

> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 9a1253b9d8c50..8486652fd31e8 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -972,6 +972,9 @@ vhost_scsi_mapal(struct vhost_scsi *vs, struct vhost_=
scsi_cmd *cmd,
>  	if (prot_bytes) {
>  		sgl_count =3D vhost_scsi_calc_sgls(prot_iter, prot_bytes,
>  						 VHOST_SCSI_PREALLOC_PROT_SGLS);
> +		if (sgl_count < 0)
> +			return sgl_count;
> +

[Severity: Critical]
This is a pre-existing issue, but could sgl_count evaluate to exactly 0 her=
e?

If a guest provides a virtio-scsi request where the protection information
length (prot_bytes) equals or exceeds the total data payload size
(exp_data_len), vhost_scsi_handle_vq() subtracts it without checking for
underflow or equality:

drivers/vhost/scsi.c:vhost_scsi_handle_vq() {
        ...
        if (prot_bytes) {
                exp_data_len -=3D prot_bytes;
                prot_iter =3D data_iter;
                iov_iter_truncate(&prot_iter, prot_bytes);
                iov_iter_advance(&data_iter, prot_bytes);
        }
        ...
}

This can reduce the data iterator's count to 0. When vhost_scsi_mapal() cal=
ls
vhost_scsi_calc_sgls() on the remaining iterators, iov_iter_npages() evalua=
tes
to 0, returning an sgl_count of 0.

Because the error check added here only tests for < 0, a 0 value will slip
through and be passed as nents to sg_alloc_table_chained(), which will panic
the host kernel:

lib/sg_pool.c:sg_alloc_table_chained() {
        ...
        BUG_ON(!nents);
        ...
}

Would it make sense to change this check to if (sgl_count <=3D 0) (and
similarly for the data SGL check below it) to prevent a guest-triggerable
host panic?

>  		cmd->prot_table.sgl =3D cmd->prot_sgl;
>  		ret =3D sg_alloc_table_chained(&cmd->prot_table, sgl_count,
>  					     cmd->prot_table.sgl,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717142205.1035=
15-1-physicalmtea@gmail.com?part=3D1
