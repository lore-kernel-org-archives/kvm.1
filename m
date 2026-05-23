Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0611A0728
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 01:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779498120; cv=none; b=DzqntRp8vuW+LT1VhZp7dp7fK8KduBSMvhpfTPFZwAZOUep7th6kJ1rJRvH2wbk2Vs6upc74L9AndgGhbcaPYTbZ3PIQEn/f5pFbzrijgD2UK56sApLPNISMRStXw0PrA5JFOuyiOmDgvaNWQVpSgxKeWxwqhDbJk42RCiM0BhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779498120; c=relaxed/simple;
	bh=bXHcYzkMfG1FEG4/OVkukp0VzNLRVzZYVGodsfIwMbo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WQoD1jVq7VKIQoJG0ZlrkBzf5gWubVrP03MCrIoSgukCNr0YTk2N6sz7uSbo9Vu8OkF9XoL9zUB3DhIFwwVEti5l8vw2jTAp6Gpky1tdlrMD67+ysjzShPmLo0XJPF/16ljDpqwkwsNppK9B6suBivcPG2NVCKuJkBe1YmgXqMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evTktcwf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evTktcwf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085871F000E9;
	Sat, 23 May 2026 01:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779498118;
	bh=/BjSzbPXZEGqBCu7eFWtfEvx07jFRufGY2ByJgrGPXw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=evTktcwf3VEwc3DDiYEkZWH8aqcgUMd4mSs3khlFfF94hLBZfZHhtHwB/Jln/nNTR
	 NgOwfuOEZQTPtgr5RWpEIwJk3DXLiwjNMmqbPFpfvZLlu6FKXHzM9gX88rWkBNjAtR
	 vX8GHS4GsmV+yO/3LG6aeWDLhmuGjqDENEqnMkwU2E284GZdgPIiOjRSbuk8l+9/Fz
	 9TLaIaw9Su5GvhHtto+/84yeF1ksMeuuwtFJxkLHM6Ps++z0f1H2DqgCMvKHDJI4Xm
	 8wEgweH16WKTSw7jbbYsXQ6lVJvELAUi1TBQUw2cYEU2VIm6UCpXs92C/3gepHAZsi
	 9RP0vB0mLNyXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/42] KVM: guest_memfd: Add base support for
 KVM_SET_MEMORY_ATTRIBUTES2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260522-gmem-inplace-conversion-v7-9-2f0fae496530@google.com>
References: <20260522-gmem-inplace-conversion-v7-9-2f0fae496530@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 01:01:57 +0000
Message-Id: <20260523010158.085871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing .compat_ioctl for guest_memfd file operations breaks 32-bi=
t userspace.
- [Medium] Silent truncation of 64-bit memory attributes in maple tree stor=
age.
--

commit 49c89936f50d0c8e067175446db94838144dd770
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Add base support for KVM_SET_MEMORY_ATTRIBUTES2

This commit introduces base support for KVM_SET_MEMORY_ATTRIBUTES2 in
guest_memfd to update memory attributes. It defines the new ioctl and
its corresponding struct, allowing both read and write operations to
provide error details to userspace.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 4f7c4824c3a45..91e89b188f583 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -540,11 +540,125 @@ unsigned long kvm_gmem_get_memory_attributes(struc=
t kvm *kvm, gfn_t gfn)
[ ... ]
> +static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> +				     size_t nr_pages, uint64_t attrs)
> +{
[ ... ]
> +	kvm_gmem_invalidate_begin(inode, start, end);
> +	mas_store_prealloc(&mas, xa_mk_value(attrs));

[Severity: Medium]
Could the use of xa_mk_value() here silently truncate the highest bit of the
64-bit attributes field?

The UAPI defines attributes as a 64-bit integer (__u64), but xa_mk_value()
takes an unsigned long and shifts it left by 1 to set the lowest bit for
internal pointer tagging. On a 64-bit system, this restricts the usable
value to 63 bits. If an attribute ever uses bit 63, it seems it would be
lost when shifted, contradicting the 64-bit UAPI contract.

> +	kvm_gmem_invalidate_end(inode, start, end);
> +out:
> +	filemap_invalidate_unlock(mapping);
> +	return r;
> +}
[ ... ]
>  static struct file_operations kvm_gmem_fops =3D {
>  	.mmap		=3D kvm_gmem_mmap,
>  	.open		=3D generic_file_open,
>  	.release	=3D kvm_gmem_release,
>  	.fallocate	=3D kvm_gmem_fallocate,
> +	.unlocked_ioctl	=3D kvm_gmem_ioctl,

[Severity: High]
Does this missing .compat_ioctl handler break 32-bit userspace?

Without a .compat_ioctl handler, 32-bit KVM userspace tasks running on a
64-bit kernel will unconditionally receive -ENOTTY when attempting to use
the new KVM_SET_MEMORY_ATTRIBUTES2 ioctl.=20

Since the layout of kvm_memory_attributes2 is identical across 32-bit and
64-bit architectures (all members are __u64), should this assign=20
.compat_ioctl =3D compat_ptr_ioctl to ensure API compatibility for compat
tasks?

>  };
> =20
>  static int kvm_gmem_migrate_folio(struct address_space *mapping,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-gmem-inpla=
ce-conversion-v7-0-2f0fae496530@google.com?part=3D9
