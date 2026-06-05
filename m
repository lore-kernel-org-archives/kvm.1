Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3A32BE03C
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680104; cv=none; b=J3yEuKMfd8gzPm4g55+pU2LDu5jQ+k1+6TfmHVDfCmHcUXWd6L+uToWTQrbD+q79CAxtDofAKScLgZaBZtG7r1+0n3+eVcRbPDgAtC3jfOXYIrPWbViFjW487uteki6LlRt+vH28A8QIdgK3oKjAGY+IqljA1tJmoN1goV7wFkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680104; c=relaxed/simple;
	bh=xuTJitpB4bXL5l9ry5pSxcKxRfDCPbVCAnHrn6Bo3gg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MfISLl0aLFQ8dh0ABb4tiwUrOs4FxHGUTafXVxOHDBqSjxHF2yB4ixvD6Xm8DPOOIDDpxSsdRW91yyLwtV6Lt7R1Po7c+FVEwPLAwJ75+iwx3EMwRzLFAux8x0BrasYa8RYoPoIxE+JhH6eSMzj6vDNRiMTsxvk8sbp2E5VE7Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2+BQ541; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2+BQ541"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18F51F00898;
	Fri,  5 Jun 2026 17:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780680102;
	bh=cen82m+r38djMAhM23zwl7W9280ufmicHqB2605PXCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z2+BQ5410IquXjghiU934bSFqnaw3ENvBFLCjIOC4CoH1gdKvN6cjHjTj4FCxMhdp
	 NQqZWHNrvbda2EZZqeycHJglGvn/VHj3Zs4Pg4XFqVEL3jGJiUtF1SGoIj7fAmScNb
	 Td2dlWRu3BXsLH+flgOulq1nniUiy0nkhuzDEwqkKleVghI0g50iSKrtdIn4H9I3YJ
	 E4OCnYkNG6mlbF0b0ApPsSsfew8RUQQRcMt7M+14aqziRQLyp2qDa95Lr5CPikKSpj
	 OYUb80L5FI2DIKsgBpzVseq4spXZ3xbucMgKkf3FV0vzFjV+eJnN9RgX5NggQoH2if
	 0oOBOLJhjaMFw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 06/10] kvm: guest_memfd: Add support for freezing
 and unfreezing mappings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <48777f4749fa43d5648085dbb2037aa99c144a88.1780676742.git.tarunsahu@google.com>
References: <48777f4749fa43d5648085dbb2037aa99c144a88.1780676742.git.tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 17:21:42 +0000
Message-Id: <20260605172142.B18F51F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] A malicious tenant can inflict a cross-tenant denial-of-service by=
 holding the global `kvm_gmem_freeze_srcu` read lock during massive, unboun=
ded `fallocate()` operations, blocking `kvm_gmem_freeze()` for other VMs.
--

commit 5ee5700d9538d9bd5f29f00de6d11fcc22d28ecc
Author: Tarun Sahu <tarunsahu@google.com>

kvm: guest_memfd: Add support for freezing and unfreezing mappings

This commit introduces freezing and unfreezing for guest_memfd mappings to
prevent fallocate and page fault allocations during preservation. It uses a
global SRCU structure to synchronize read-side operations with
kvm_gmem_freeze().

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 6740ae2bf948d..b94639cdf3126 100644
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
[ ... ]
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
Does this code allow a malicious tenant to inflict a cross-tenant denial of
service?

The srcu_read_lock() is acquired at the beginning of kvm_gmem_fallocate() a=
nd
held across the entire kvm_gmem_punch_hole() or kvm_gmem_allocate() executi=
on.
Because a guest_memfd can be terabytes in size, these operations could iter=
ate
over millions of pages and take a long time to complete.

During this entire time, the global SRCU read lock is held uninterruptibly
(yielding via cond_resched() in kvm_gmem_allocate() does not drop SRCU).

> =20
>  	if (!ret)
>  		file_modified(file);
> +
> +out:
> +	srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
>  	return ret;
>  }
[ ... ]
> @@ -1014,5 +1053,61 @@ void kvm_gmem_exit(void)
[ ... ]
> +void kvm_gmem_freeze(struct inode *inode, bool freeze)
> +{
> +	u64 flags =3D READ_ONCE(GMEM_I(inode)->flags);
> +
> +	if (freeze)
> +		flags |=3D GUEST_MEMFD_F_MAPPING_FROZEN;
> +	else
> +		flags &=3D ~GUEST_MEMFD_F_MAPPING_FROZEN;
> +
> +	WRITE_ONCE(GMEM_I(inode)->flags, flags);
> +
> +	if (freeze)
> +		synchronize_srcu(&kvm_gmem_freeze_srcu);

[Severity: High]
Can this synchronize_srcu() block indefinitely waiting on another tenant?

Since the SRCU is global, calling kvm_gmem_freeze() on a completely unrelat=
ed
VM will invoke synchronize_srcu(&kvm_gmem_freeze_srcu). This will wait for =
the
first tenant's massive fallocate() to finish.

The loop in kvm_gmem_allocate() checks kvm_gmem_is_frozen(inode) on its own
inode, so it will not abort when a different inode is frozen. This effectiv=
ely
allows an unprivileged tenant to stall live updates and preservation
system-wide.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780676742.gi=
t.tarunsahu@google.com?part=3D6
