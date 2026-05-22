Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CAE368958
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779473135; cv=none; b=YeCij3Oun7s5ygQXHV8coKfXc6j6lJKb8LECF0AIZ7jAahkwczTLlKvo9KbkkAXbkEWPLpSE7+51VqJ6MQHZ5+2tkRHXSRHiBLH7iCuYDHnN37y/E0cf0isIL6xpYDQuJtXuuSyk1wCQS8HVzlsOubgxvjVfUwmdOWU6Ycg9ryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779473135; c=relaxed/simple;
	bh=ebRTbvXGF9x2lbfT7InqhaPnMyNuaa2jYIXrLzHqkt8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BKuLbmayu6+lKPDdpzM3KVK/j2KkNYS5zBtycWuRN3346vRPs6EQH7kPzqwvWau1vvFg2vBv/CzRR6I9KCVLF6fTY2JO6DmS87KAClTyfbevq/5Kh1YnHt2nZFnp89XwD1+EJp/AnBnavVHF+YZi0IKkduGRyrgDCWfvJkU06x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHXJY/Cp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHXJY/Cp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9101F00A3E;
	Fri, 22 May 2026 18:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779473131;
	bh=fkXv6Xlho1LPgS92N2phwG1e9Pq+DWUMsA33t9JjvpE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oHXJY/CpExyInu5mSEBDgmceln4XciCKKsxoXp5mrfQcz6yCxjwU1bn5oO/d6w0sJ
	 7RBJilMS4bDNO1wQjUez+FKy3L/ayICtZyqZfsfXnx2xzzCQIwxhNmL5hRpYKKxFM9
	 NOuKXAOKFITMAECBoxYE40J/MzZaxwws3weMY5GzmaBNjk5H8BZorbexE0LM25Dmaa
	 GjeVJ7OmHwnOiKArnHkUT3zWLxpDhHgEP+ueiw8rek4od1f0w09RFGkkqcbhgqeNJG
	 0tzOziXuGXwtH98dfM1gjKsQlDhJx7FDdgPFX0huK/JdiettaRykUUb/pd7+7GPt2I
	 NIOAleZVVDyVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] KVM: guest_memfd: Return -EEXIST for overlapping
 bindings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260522172151.3530267-2-seanjc@google.com>
References: <20260522172151.3530267-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 18:05:30 +0000
Message-Id: <20260522180530.EE9101F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The return value of xa_store_range() is ignored in kvm_gmem_bind()=
, masking memory allocation failures and leading to a Use-After-Free vulner=
ability.
- [High] A signed integer overflow in the file size bounds check inside kvm=
_gmem_bind() allows userspace to map memslots beyond the allocated size of =
the guest_memfd.
--

commit 7edaac3f2255cc17c741557ce1e44f51d4cece29
Author: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>

KVM: guest_memfd: Return -EEXIST for overlapping bindings

This patch updates the KVM_SET_USER_MEMORY_REGION2 ioctl to return -EEXIST
instead of -EINVAL when a guest_memfd range overlaps an existing binding.
This aligns the error reporting with overlapping GPA memslots.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 69c9d6d546b28..46727539d08ac 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -675,6 +675,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_=
slot *slot,
> =20
>  	if (!xa_empty(&f->bindings) &&
>  	    xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
> +		r =3D -EEXIST;

[Severity: High]
This isn't a bug introduced by this patch, but looking at the bounds check
earlier in kvm_gmem_bind():

    if (offset < 0 || !PAGE_ALIGNED(offset) ||
        offset + size > i_size_read(inode))
        goto err;

Are these variables susceptible to a signed integer overflow?

Both offset and size are evaluated as loff_t values. If userspace provides =
an
offset close to the signed 64-bit maximum, adding size could wrap around to=
 a
negative value.

Would this cause the offset + size > i_size_read(inode) condition to bypass
the file size limits and allow the guest to map memslots beyond the allocat=
ed
size?


[Severity: High]
This is also a pre-existing issue, but I noticed the return value of
xa_store_range() isn't checked later in kvm_gmem_bind():

    xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
    filemap_invalidate_unlock(inode->i_mapping);

If memory allocation fails and xa_store_range() returns an error pointer,
does the memslot get omitted from f->bindings while kvm_gmem_bind() still
proceeds as if it was successful?

When the guest_memfd is closed, kvm_gmem_release() nullifies active bindings
but would miss this omitted slot, leaving slot->gmem.file set while the VFS
frees the underlying file.

Later, when the VM is destroyed, could kvm_gmem_unbind() attempting to
access the memslot's file via get_file_active() trigger a use-after-free?

>  		filemap_invalidate_unlock(inode->i_mapping);
>  		goto err;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522172151.3530=
267-1-seanjc@google.com?part=3D1
