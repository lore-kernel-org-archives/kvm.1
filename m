Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539CE3CF049
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780421160; cv=none; b=Qnj+aZkUELhKWo5/HsB5NfbxhianevptgKHu75KcQybmh2rWzOahoEhTIFE8ALvRidXjihGKL7hEdB/CFgyR+wUsBDepi610jfuA7+8ehXM/VZoaZ6TIN9WJPatAhf178TQHHgdLi7raPzAFJ/PW3Q4LPTTGOa92f4E9GKSWXT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780421160; c=relaxed/simple;
	bh=sixzcr2/18SOyaTHtpcN4jiZReODDdFBgt0bYjwFDi4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ovTKMb9DvyT0tiB8LrgQI1ufeKiNVNsa7HNJtD8Uu5i/UiLbdz8w82qVuG5oOj2AQNfl3ta3cmbW0fsrqc5xRKais1BUKL2N26ZCOHM3/5n7qLpBOH2Or3m0vOmS20NdjOiqMwQz+vBgx1YUYwcT5hZiYK8QMfGp5EpkE7wLf6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilLU4SFs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilLU4SFs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154F91F0089A;
	Tue,  2 Jun 2026 17:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780421159;
	bh=84yalU1+dM07cKAiEro1qwK700+ItSNV+upbpy9zDs4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ilLU4SFsU7QCzOm+Clqy95R++eW0LCDwLOOygvRFcZgH8D39f/xPbO57OA+H9d+yf
	 IzaRmN8fW0NIkAUkKtTPilingIsZsKV6t66ZtNP74YrbCCY8GNdKxX8oz5rRdITjKl
	 TxQvvy5ovbxTDRTuAsUfguLJcTC6qiDFi8jKy1uoAnMOFycR2oU49BC9xC+3GQ/+3j
	 AlEaYVejtK5ais3MvHtqO8yZ+6GWRDw7dn7GnDJFqCvQz7w22F4WFc9YNUCSFKcxX6
	 VANsqCppMpK+d/kJdQzwILwg0+aTpNRL0/B+1B666P/EH04A5E0Vo18ArPuQo8MfvN
	 Sw8vfBQUanFOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] KVM: guest_memfd: Treat memslot binding
 offset+size as unsigned values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602170921.1304394-2-seanjc@google.com>
References: <20260602170921.1304394-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 17:25:58 +0000
Message-Id: <20260602172559.154F91F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unchecked `xa_store_range` failure leads to Use-After-Free during =
guest_memfd teardown.
--

commit 5c26d9e5968ad3c31c35baf158f6f7140d83e0d8
Author: Sean Christopherson <seanjc@google.com>

KVM: guest_memfd: Treat memslot binding offset+size as unsigned values

When binding a memslot to a guest_memfd file, treat the offset and size as
unsigned values. This fixes a bug where the sum of the two could result in a
false negative when checking for overflow against the file size.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index bf9659a7b0f6d..a1cb72e662880 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -640,15 +640,16 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_cre=
ate_guest_memfd *args)
>  }
> =20
>  int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> -		  unsigned int fd, loff_t offset)
> +		  unsigned int fd, uoff_t offset)
>  {

[ ... ]

> @@ -664,8 +665,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_=
slot *slot,
> =20
>  	inode =3D file_inode(file);
> =20
> -	if (offset < 0 || !PAGE_ALIGNED(offset) ||
> -	    offset + size > i_size_read(inode))
> +	if (!PAGE_ALIGNED(offset) || offset + size > i_size_read(inode))
>  		goto err;
> =20
>  	filemap_invalidate_lock(inode->i_mapping);

[Severity: High]
This is a pre-existing issue, but does kvm_gmem_bind() need to check the
return value of the xa_store_range() call that occurs further down in this
function?

If xa_store_range() fails with an error like -ENOMEM, the memslot is not
added to the bindings xarray, but the function still returns success and
leaves slot->gmem.file pointing to the file.

Because KVM relies on f->bindings to clean up memslots when the guest_memfd
is closed, this failed insertion causes the memslot to be missed during
kvm_gmem_release(). This leaves slot->gmem.file as a dangling pointer after
the file is destroyed.

Later, when the memslot is destroyed, kvm_gmem_unbind() dereferences
slot->gmem.file->private_data to get the freed gmem_file pointer, which
is then passed to __kvm_gmem_unbind(). That function calls xa_store_range()
on the freed f->bindings, resulting in a use-after-free.

Should we check for an error from xa_store_range() and handle the failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602170921.1304=
394-1-seanjc@google.com?part=3D1
