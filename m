Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66643346FB3
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154881; cv=none; b=Vsff0e9icQNi63oF4WyKC2PWJDVvjruoXfBfVHoMp22Pkiz+mFWo3CDMUX2IousJT5oT1tDRTbHg9pt+gbjIdOL0s+Yr9Aj7VbS/Lf3jEqnDq9ICoqyVGIW5194aMC5fZfpGUYhGtdltqkIUbug7hRM592Yr0jPasv/ODp9MbpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154881; c=relaxed/simple;
	bh=YbMTxdVbmpC0Whq8gcvlHC923ZRYzH+7k2Fp+4ibkVM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EgZLjADsp0zUKj4RSZKm03X6QmErVLXoBgcceAMvmHuZjxJ1bUIUTxNZaiY38mrFB1cfHmRzFipQAbeemsK0b3aQyYi4FxVYjpMRNGILpuIP5BljkYTPS5mBerhXQg+B/tT/AMAbOFGTxmJVlGvNAEvDQHfIinFFuWU7+Z8WPC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQLf3RC+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQLf3RC+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A351F00A3A;
	Mon, 22 Jun 2026 19:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782154880;
	bh=MPR/THYqRdfgqnE2DLiT4jRhBeUiZlot7CW4f05WHTU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oQLf3RC+hh95fOf87R9TSdlXuwfvcV6xgJFO5K0CDDDuVKTBEMw5Ou+z7b1CKLPy9
	 M1+2m1GbureoLnnaH/nrt118QPwObJp0Id90UX3GetzLL8WDrBDKV1iHuBa/9h38J+
	 b9V+HnyKGsZI8+PqzuWd2lt5FbQi4o8k0RGw8Q80X+lRrxDuj+7qvKv3NMXz7k53UT
	 RwWsZxY9WmvyD6+Y95sNNnYnI0nNT8R5YFJVXi+JQOkQiSS9q7ewzl3lOffMT8jqvz
	 hZgEx4Ljn552IQNBTkJOm3snvuxDQxmDdp8QYHlTAL96duE7GCowd4ydAs1qH7Ol+q
	 9atSB3zPjWYpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/9] kvm: guest_memfd: Add support for freezing and
 unfreezing mappings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260622184851.2309827-6-tarunsahu@google.com>
References: <20260622184851.2309827-1-tarunsahu@google.com>
 <20260622184851.2309827-6-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 19:01:19 +0000
Message-Id: <20260622190120.11A351F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Global SRCU read lock held across unbounded fallocate operations c=
auses system-wide DoS for guest_memfd freezing.

Pre-existing issues:
- [High] Calling `file_modified(file)` without holding the `inode_lock()`.
--

commit 76fd5a6866a1e58bea715f4038d1ddf2c323cc9d
Author: Tarun Sahu <tarunsahu@google.com>

kvm: guest_memfd: Add support for freezing and unfreezing mappings

This commit adds a freeze state on guest_memfd inodes to prevent fallocate =
and=20
new page faults during VM live updates. It synchronizes these freezing stat=
es=20
using a system-wide SRCU lock.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index fe1adc9ba48d1..a4d9d348e4d16 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
[ ... ]
> @@ -273,16 +284,30 @@ static long kvm_gmem_allocate(struct inode *inode, =
loff_t offset, loff_t len)
>  static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offse=
t,
>  			       loff_t len)
>  {
> +	struct inode *inode =3D file_inode(file);
>  	int ret;
> +	int idx;
> =20
> -	if (!(mode & FALLOC_FL_KEEP_SIZE))
> -		return -EOPNOTSUPP;
> +	idx =3D srcu_read_lock(&kvm_gmem_freeze_srcu);
> +	if (kvm_gmem_is_frozen(inode)) {
> +		srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
> +		return -EPERM;
> +	}
> =20
> -	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
> -		return -EOPNOTSUPP;
> +	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
> +		ret =3D -EOPNOTSUPP;
> +		goto out;
> +	}
> =20
> -	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> -		return -EINVAL;
> +	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE)) {
> +		ret =3D -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len)) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> =20
>  	if (mode & FALLOC_FL_PUNCH_HOLE)
>  		ret =3D kvm_gmem_punch_hole(file_inode(file), offset, len);
>  	else
>  		ret =3D kvm_gmem_allocate(file_inode(file), offset, len);

[Severity: High]
Could holding this global SRCU read lock across potentially unbounded
operations cause a system-wide denial of service?

When kvm_gmem_fallocate() calls kvm_gmem_allocate() or
kvm_gmem_punch_hole(), the operation iterates over a potentially massive
memory region. While kvm_gmem_allocate() yields the CPU via cond_resched(),
it does not drop this global SRCU read lock.

If another task on the host concurrently calls kvm_gmem_freeze() to preserve
a different VM, its synchronize_srcu() could block indefinitely waiting for
this tenant's operation to complete. Should the SRCU lock be dropped
and reacquired during long loops to prevent cross-tenant starvation?

> =20
>  	if (!ret)
>  		file_modified(file);

[Severity: High]
This is a pre-existing issue, but does calling file_modified() here violate
the VFS locking requirements?

The VFS API requires the caller of file_modified() to hold the file's
inode_lock (or i_rwsem) because it performs non-atomic timestamp updates
and security privilege clearing. Neither vfs_fallocate() nor
kvm_gmem_fallocate() appears to acquire the inode lock before this call.

> +
> +out:
> +	srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622184851.2309=
827-1-tarunsahu@google.com?part=3D5
