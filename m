Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B4338A72B
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933135; cv=none; b=MdkVEEVjQdwAI+zzG8D7XZhyGm2U/BVNlTrcjRQXsq1rO77a2nf2ps3ZX9loZnMwpN7B+GOK9fI5YwSChncZD6jbi4LdLSldDMEjHVL3snp1u40QZV462hrmRGweQY22kcpoWsxNXsENJvzfv+sGkf5qFVazv7w4gHPJg7rd17Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933135; c=relaxed/simple;
	bh=BiW6xwt0mHiz7G08IIF8pnbnLstkhMZghEP7HaFHgaQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=InSwvPr15hcLjKq7UXcJdksHVh3Is91+aGIN/JGhvX6n0uZjqj0OSqv/Wx6QxzU/jphfLpdn74OjxaiLcyFL1kr93FqaKuy46/q6fh3ox/h0VL2/TqGSzWRS4mTTgB8qYkpoZihk/wGIjripBMSPGHvjl8/Ahh6IRGeiadkm9GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5KXeM5l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5KXeM5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EE01F00893;
	Mon,  8 Jun 2026 15:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780933133;
	bh=Bi7VDlxnvFRRO3RsfsTTDgigE++/ABW2drsj8/f0xH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J5KXeM5l15o1DNseZUFO/7VBeMdNBNcZUYkH2O3rToR+y2dTHJOTOQAnsy4qYl143
	 Qc6Rk6ix/otNvPql7sVCXNsz1wHE1edafzBZ6deaSVwlExN5F/w+7PTUGPfHRsJR95
	 yftzNkMxo0T2xRKeLgT9u1npyurfuChX0VXxWlyLnsRzzzDYKYSlnB2FuecqdqFk0Q
	 v0FqXkIko+knrIXV+DFTfOpbsMFMo5YmJHnro6jlwkEuk9zx85zRepLmGSux6+f78q
	 Dq+6i3QnDr5y99fl36btVUZ3w+zKHQhqAPxPoMGpuaGkk0nJuoLot/MvAo58s3Unud
	 0L85Mctw03pBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vfio/qat: fix f_pos race in qat_vf_resume_write()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Giovanni Cabiddu" <giovanni.cabiddu@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608151317.136613-1-giovanni.cabiddu@intel.com>
References: <20260608151317.136613-1-giovanni.cabiddu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:38:53 +0000
Message-Id: <20260608153853.95EE01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Time-Of-Check to Time-Of-Use (TOCTOU) race condition on filp->=
f_pos leading to a heap Out-Of-Bounds (OOB) write.
--

commit 1308b8d3699cdbd06dda3a3c256a63827fa74e14
Author: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

vfio/qat: fix f_pos race in qat_vf_resume_write()

This commit fixes a race condition in qat_vf_resume_write() where bounds
checking on f_pos was performed outside of the migration lock. By moving
the bounds checks inside the lock, it prevents concurrent writers from
using an old file offset to bypass boundaries and copy past the end of the
migration-state buffer.

> diff --git a/drivers/vfio/pci/qat/main.c b/drivers/vfio/pci/qat/main.c
> index ac9652539d66a..60ff907b6a67a 100644
> --- a/drivers/vfio/pci/qat/main.c
> +++ b/drivers/vfio/pci/qat/main.c
> @@ -298,14 +298,18 @@ static ssize_t qat_vf_resume_write(struct file *fil=
p, const char __user *buf,
>  		return -ESPIPE;
>  	offs =3D &filp->f_pos;
> =20
> -	if (*offs < 0 ||
> -	    check_add_overflow(len, *offs, &end))
> -		return -EOVERFLOW;
> +	mutex_lock(&migf->lock);

[Severity: Critical]
This is a pre-existing issue, but does this same regression exist in other
VFIO drivers?

Since migration file descriptors opened by VFIO drivers use stream_open()
which unsets FMODE_ATOMIC_POS, the VFS does not acquire f_pos_lock when
userspace calls write().

This means concurrent writes can evaluate the initial f_pos before the
mutex, and then use an advanced f_pos inside copy_from_user(), leading to a
heap out-of-bounds write.

For example, this identical pattern appears in
hisi_acc_vfio_pci.c:hisi_acc_vf_resume_write():

	pos =3D &filp->f_pos;

	if (*pos < 0 ||
	    check_add_overflow((loff_t)len, *pos, &requested_length))
		return -EINVAL;

	if (requested_length > sizeof(struct acc_vf_data))
		return -ENOMEM;

	mutex_lock(&migf->lock);
	// ...
	ret =3D copy_from_user(vf_data + *pos, buf, len);

And also in samples/vfio-mdev/mtty.c:mtty_resume_write():

	pos =3D &filp->f_pos;

	if (*pos < 0 ||
	    check_add_overflow((loff_t)len, *pos, &requested_length))
		return -EINVAL;

	if (requested_length > mtty_data_size(mdev_state))
		return -ENOMEM;

	mutex_lock(&migf->lock);
	// ...
	if (copy_from_user((void *)&migf->data + *pos, buf, len)) {

Should these other drivers be patched similarly?

> -	if (end > mig_dev->state_size)
> -		return -ENOMEM;
> +	if (*offs < 0 || check_add_overflow(len, *offs, &end)) {
> +		done =3D -EOVERFLOW;
> +		goto out_unlock;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608151317.1366=
13-1-giovanni.cabiddu@intel.com?part=3D1
