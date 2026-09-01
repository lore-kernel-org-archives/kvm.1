Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4CA342510
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251961; cv=none; b=aIxzoUErbexbonoj0dby/k1eYtsHZ8NUB8l5HYB8u5vwVzfeSx5obeNc8uXJDeGlYlb+0JkNeMFZ8svaDZARlyRXLf1SUzCW+HFdRRFh1oBbzGaJl4VZrY9OvqXFcSiOEFW8snZvog4LHhSUgeM0skzQvIRcdeg2YXjMbqOgJpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251961; c=relaxed/simple;
	bh=dEy7Qnp8NJuXpqsAwuJmjb5GeyIl7vCnLmJoPBFhIRw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HtK8EltFZ1SfhF5xhSb0GTNiGOnDqzkE0TjQIh/k6ZSe3AYS1mEEvRyIW/FgSiZHEM+8Qz9QKAf1lAhYupCZHcpnHeGNWhsm9Vigy3Ce8MNqLzoelsavCwLMn6EjWzI3hzZkb8bmBXuvEkQU7XLX6Vah6Ch65FFuE8WEUCLHlKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSy+7/29; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSy+7/29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C86F1F000E9;
	Tue,  1 Sep 2026 08:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788251960;
	bh=3qsiWwwfkVp8eRAcOt4JCu6HEFSph4Dbee3JQgpifmM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hSy+7/29A7Ux234f5AvQg0RMt1bSDOY+y/LgCmV9nOK2Vtw/CMIEw1dnqyVJwwBH7
	 kGMu9mfhFIqtxZkDXNskhUHXPXwpqjbWPhnpMuXHVO0gJsBc3B3BcjyvsBCyXZP6UN
	 b5k8cJr9PvyRNQ9tCBA914TtYXR5Dr83dB0dLYUGfzDXYm+ITla+1vMFYehQsfO/yS
	 dWCsEaYrzi9TEtvQKpuul9TR0AIUTGtnsXdq1Tx3O6J15f7G3iYodEjYCvhPwx6lEk
	 oH0qPHYPruaJjA3d7W2V4G2SXco63hdxw+kqKTR/hHXeNKTXRMf9n3Hh4JuCByzMZM
	 1d4zrRAH2n5kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] KVM: selftests: use allowed NUMA nodes in
 guest_memfd_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260901-gmem-selftests-fix-v2-4-5a273153354c@amd.com>
References: <20260901-gmem-selftests-fix-v2-0-5a273153354c@amd.com>
 <20260901-gmem-selftests-fix-v2-4-5a273153354c@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:39:19 +0000
Message-Id: <20260901083920.1C86F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Stack buffer overflow in test_mbind when retrieving memory polic=
y on 32-bit architectures.
--

commit c29a637608e8b3ee37278728fd941b62df184a8b
Author: Shivank Garg <shivankg@amd.com>

KVM: selftests: use allowed NUMA nodes in guest_memfd_test

guest_memfd_test assumes that nodes 0 and 1 exist and have memory. Select
the required nodes from MPOL_F_MEMS_ALLOWED instead. The sysfs helpers for
finding maxnode are no longer needed.

> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> index 2233d871a38f4..aee80dda62295 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
[ ... ]
>  static void test_mbind(int fd, size_t total_size)
>  {
> -	const unsigned long nodemask_0 =3D 1; /* nid: 0 */
> -	unsigned long nodemask =3D 0;
> -	unsigned long maxnode =3D BITS_PER_TYPE(nodemask);
> +	unsigned long nodemask, bind_nodemask;
> +	unsigned long maxnode =3D BITS_PER_TYPE(nodemask) + 1;

[Severity: Medium]
Can this cause a stack buffer overflow in test_mbind() on 32-bit architectu=
res?

The nodemask variable is declared as a single unsigned long, which is
4 bytes on 32-bit architectures. However, maxnode is set to
BITS_PER_TYPE(nodemask) + 1, which evaluates to 33.

>  	int policy;
>  	char *mem;
> +	int nid;
>  	int ret;
> =20
> -	if (!is_multi_numa_node_system())
> +	if (!get_numa_node_ids(&nid, 1))
>  		return;
> =20
> +	bind_nodemask =3D 1UL << nid;
>  	mem =3D kvm_mmap(total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
> =20
>  	/* Test MPOL_INTERLEAVE policy */
> -	kvm_mbind(mem, page_size * 2, MPOL_INTERLEAVE, &nodemask_0, maxnode, 0);
> +	kvm_mbind(mem, page_size * 2, MPOL_INTERLEAVE, &bind_nodemask, maxnode,=
 0);
>  	kvm_get_mempolicy(&policy, &nodemask, maxnode, mem, MPOL_F_ADDR);

When maxnode is passed to kvm_get_mempolicy() here, the kernel must
write at least 5 bytes to return 33 bits of node status. This rounds up to
8 bytes (two 32-bit words).

Will this overwrite the 4-byte nodemask buffer and corrupt adjacent
variables on the stack?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-gmem-selft=
ests-fix-v2-0-5a273153354c@amd.com?part=3D4
