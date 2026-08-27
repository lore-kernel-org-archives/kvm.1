Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF843644BE
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787830383; cv=none; b=quSl/HFlSIfPsOTfGl9mZCHlwh7DaU0aYFWOEccpSz+l6L5ZIC6SREJA8/d7z0lyY7EJxlDaUly3x6yuLgEaxwj4qN5AryqHtdCMT9Pgka/vfee7ZzN+ZiMeKjx6x0HQaTm5pCmt3auwjVL/Zy7bpJ84DzlNNc4x6bNB1X3igss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787830383; c=relaxed/simple;
	bh=4GVptgxVXIyMJ9VcRpw9iypcMlcVO1ucGx2Qd+69AIg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=btsYFwBX/wEpqBnQZzaM19jPUanuiV7On+YZZ3cSWY4DdTzZS5rNmhAjuhGQAw0+dm4wCb3ErCyJLIcq1zd9VwGbhxoZyAEzpqEOeDOKdYPkZNF0yCUIe8A1m+7Adn3v3/QBPyMop2gWyjyxeW54F8xlyD/Kh8naVUk1qg8IsJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHMYqxIY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHMYqxIY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E58B1F00A3A;
	Thu, 27 Aug 2026 11:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787830382;
	bh=R6bfj1xtWdg3Z5Zv71feF0w/35oyOepv0yur80Gv0cs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UHMYqxIYSS+FkcZ+oVVWsT27VAtSRQcxw0N2eZaGt6c6brSJBkQpn3t+r4pHOjRDE
	 qPRnN4ZdqgnHswQGK3nP+ICRFdfcLA7PHaY2pHKA/iVOjOSKpNEvmz4yzVTxfCTYuL
	 QqniaZd+hwe6JQ4fq4mlkROU0N/5sTCfmZdB/VZxfmPEN5etR6JAkRZJ05ZpqMZchL
	 QKBgRGWUKhp7ur2g5B1GlHVHLSdsQpNsxHP0+n24KTv0muVNawfZLiqg1Bx6AaJZI3
	 GUvJaOesx2tWr34RW5GwU8qsYEIeikKuowLPcsIFUfY0QhUvIOLP9tVIbaGWavC+1V
	 dsEB8VUmH7mNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: Mask off the address space ID in
 kvm_set_internal_memslot() check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zeng Chi" <zeng_chi911@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260827112200.866476-1-zeng_chi911@163.com>
References: <20260827112200.866476-1-zeng_chi911@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 11:33:01 +0000
Message-Id: <20260827113302.1E58B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `__x86_set_memory_region()` leaks user virtual memory allocated vi=
a `vm_mmap` and leaves the VM in a corrupted partial state on error paths w=
hen `kvm_set_internal_memslot()` fails.
--

commit 1d364f757ed17cf4e343c19a31d2b4aeb3b66e5f
Author: Zeng Chi <zengchi@kylinos.cn>

KVM: Mask off the address space ID in kvm_set_internal_memslot() check

This commit fixes a sanity check in kvm_set_internal_memslot to correctly
isolate and compare just the memslot ID against KVM_USER_MEM_SLOTS. By
masking off the address space ID, the check is now effective across all
address spaces rather than silently passing for any address space other
than 0.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 65eb26a0520d8..e8d0e360ea26b 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2128,7 +2128,7 @@ static int kvm_set_memory_region(struct kvm *kvm,
>  int kvm_set_internal_memslot(struct kvm *kvm,
>  			     const struct kvm_userspace_memory_region2 *mem)
>  {
> -	if (WARN_ON_ONCE(mem->slot < KVM_USER_MEM_SLOTS))
> +	if (WARN_ON_ONCE((u16)mem->slot < KVM_USER_MEM_SLOTS))
>  		return -EINVAL;
> =20
>  	if (WARN_ON_ONCE(mem->flags))

[Severity: High]
This is a pre-existing issue, but I have a question about the error handling
in arch/x86/kvm/x86.c:__x86_set_memory_region() when
kvm_set_internal_memslot() fails.

When size > 0, the function allocates a VMA mapping via vm_mmap() and
iterates over all address space IDs:

        for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
                struct kvm_userspace_memory_region2 m;
                ...
                r =3D kvm_set_internal_memslot(kvm, &m);
                if (r < 0)
                        return ERR_PTR_USR(r);
        }

If kvm_set_internal_memslot() fails for any address space, it returns early.

Does this early return skip the vm_munmap() cleanup and leak the VMA mapping
allocated by vm_mmap() in the host process?

Additionally, if the loop fails on a later address space, earlier successfu=
lly
created memslots are left behind. During VM destruction, kvm_arch_destroy_v=
m()
calls __x86_set_memory_region() with size =3D 0 to free these internal mems=
lots.
Will this deletion loop fail with -EINVAL when it attempts to delete the
non-existent slot for the previously failed address space? Does this bypass
the final vm_munmap() step and leak the VMA mapping?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827112200.8664=
76-1-zeng_chi911@163.com?part=3D1
