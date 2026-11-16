Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794800607;
	b=oKidagZhrwxiQ4w9Rs8w39A8EVJMCC39i1rdavO9ejgzNKbs/lnYJhLnmDbtwTvmsdZN
	 3TNrPGoPgdXL5SRjEGCqYA62uWrU5T/xyfBiO4dwpQvP13SbKwGjxqVK3qtBOKj6eN2wL
	 qjKh8yDUCoLVoun/WAPcSD9HvtI8LcsCiCXXGj8psB5GoW4ixDpFiHJi1FU9WAkSw0Ia2
	 rQuubvVKv9/ZjMS8eQX4FvuTgRVFf96f128KB+XvGKvBx++PCf5i1fV+IchEPO1gI2rj4
	 jldMANqyBQbM1WvpOKvlMFvP8UX3o3I6IhdaOML5SqwDgAWoazMCNswnuQKBXv3meMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794800607;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VyWOgVepNkSKJ6XYbNAwi+c40lbehF8ImPxg4tm2wKY=;
	b=VuTDwi6btONE2VenRxioId73nlJ0CRS8ZSiGmdvQzVUTsnCWY6rgLucXAvHBZB5YdmZw
	 5sruUsMg1hBAkRocGCfZeu5j3ThiZYBT8TkbeHCF3W+9hgSTAg+FGqorJHSr+0mT3jOqP
	 tfpnC0HUl6T1tspb+aTvW6mICjxb+64F1ikNisYHee0vOYb9zK1fNbZTa9Yh2N24y/wx5
	 SQXR9nDxzoCRmgiDpJTHOzLaGPUXqFluS3DaO6AmAj2Mjr3DVMRQBh/PAIU2l1gJlX8h2
	 hVrXFYGCxqIPEMLqX64rM+m0Uanpi/xpQHnxUz2xIqgbNouU3bm2xTY7ZjYC7I/G/gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyLTMH3R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AA1606A31C
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyLTMH3R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25821F000C4;
	Mon, 16 Nov 2026 03:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794800606;
	bh=VyWOgVepNkSKJ6XYbNAwi+c40lbehF8ImPxg4tm2wKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hyLTMH3Rp7aFaZP7SYIUSzO4d5GTzE9IyRnGtjMu4jr7pt9cJwbqdhxmqujV/jmR3
	 9fzJgOEq8gCjO+s44hEAark1iFlBv6fh6SmFeXeUw6Uc6k/sqfXrI7ZUdCMVU2pT1h
	 FFWAdR9Nj6xQCewistmrIc6cY5Fo4+NkQfAFWEKkPaL0ZmwsF46ToGjYPQbrkFlRyJ
	 /3MOC566CXKgMa+vZ2yUUWiryTK1aP9tRN7oNyLeKXqAZBLLBi5yowcAmwp7FbY46s
	 duVWHRRbR6/lOh/hpmMDWiSb3Lr73navQSRFi1lQ2gtAEXID9ud6c1rHPhtmmGiTAM
	 nhGGe4DEQx3Sw==
Message-ID: <sashiko-outbox-216141@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/3] KVM: Add a module param to disable the per-VM
 debugfs directories
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peng Hao" <flyingpenghao@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261116032748.54582-3-flyingpeng@tencent.com>
References: <20261116032748.54582-1-flyingpeng@tencent.com>
 <20261116032748.54582-3-flyingpeng@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 03:43:26 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] KVM: debugfs leak and UAF in
  kvm_nested_s2_ptdump_create_debugfs()
--

commit 6b8cad730d46b448b05e32a4f22f6d9fe9cf399b
Author: Peng Hao <flyingpenghao@gmail.com>

KVM: Add a module param to disable the per-VM debugfs directories

This commit adds the kvm.per_vm_debugfs module parameter to allow skipping =
the
creation of per-VM and per-vCPU debugfs directories and files.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index fff19e9239d2b..54a2924f9b928 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c

[ ... ]

> @@ -1024,7 +1032,7 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, c=
onst char *fdname)
>  	int kvm_debugfs_num_entries =3D kvm_vm_stats_header.num_desc +
>  				      kvm_vcpu_stats_header.num_desc;
> =20
> -	if (!debugfs_initialized())
> +	if (!debugfs_initialized() || !per_vm_debugfs)
>  		return 0;

[Severity: Medium]
On arm64 with CONFIG_PTDUMP_STAGE2_DEBUGFS=3Dy, does returning early here w=
hen
per_vm_debugfs is false cause kvm_nested_s2_ptdump_create_debugfs() to leak
nested_mmu* files in the root of debugfs and leave dangling pointers?

kvm_create_vm() initializes kvm->debugfs_dentry to ERR_PTR(-ENOENT), so
callers passing it as a parent to debugfs_create_file() or
debugfs_create_dir() fail as expected.  However, kvm->arch.debugfs_nv_dentry
is zero-allocated (NULL) and is only populated when kvm_create_vm_debugfs()
reaches kvm_arch_create_vm_debugfs() -> kvm_s2_ptdump_create_debugfs().

When per_vm_debugfs is false while debugfs_initialized() is true,
kvm->arch.debugfs_nv_dentry remains NULL.  Initializing a nested vCPU in
kvm_vcpu_init_nested() then calls kvm_nested_s2_ptdump_create_debugfs(),
passing NULL as the parent dentry:

arch/arm64/kvm/ptdump.c:kvm_nested_s2_ptdump_create_debugfs() {
...
	debugfs_create_file(file_name, 0400,
			    mmu->arch->debugfs_nv_dentry, mmu,
			    &kvm_ptdump_guest_fops);
}

debugfs interprets a NULL parent as the root of the debugfs mount and creat=
es
/sys/kernel/debug/nested_mmu* with inode->i_private pointing to mmu.  When
the VM is destroyed, these root files are never removed while
kvm_destroy_nested() frees the nested_mmus arrays and kvm_destroy_vm() frees
struct kvm, so opening /sys/kernel/debug/nested_mmu* afterwards triggers a
use-after-free in kvm_ptdump_guest_open().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116032748.5458=
2-1-flyingpeng@tencent.com?part=3D2
