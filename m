Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37E93B05AC
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788379502; cv=none; b=NknxIjiOU7jsv/1SJ0nQUQT0Ur+JWXrjf5JFogshYs1M2N/Zur07HABo5FVOdt8sgXl15ql2fIWjRF96UtcvRDjrwU6ft5Lqig8p3XH49OQfuUrbLXrtkR3lEEbrPU6qC2Jp/NbkOJ5E7guq/+i4euPlHnQsflFiFDI36j+fUR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788379502; c=relaxed/simple;
	bh=3yYT4pwZGPPisZMGkD+xhz/U9UCRqkU3MoqC1nRnglA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V5zZdik+ibeJ/1vLXSpLHstmVjlH3GrMZ78EcKQzPglcO3u7UKWngJGltkgFxG5PtD3CripjBCWxigbZcBB9oYr4cJYPNmNdFeLLEm8egyrARKXD1G65XXSlWD61/6G/4EnCyasRXVUPUytNDSfVEE9zbcbhry0+eOyUw3XZYMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2Bh5awe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2Bh5awe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5703F1F000E9;
	Wed,  2 Sep 2026 20:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788379500;
	bh=WaigSkIraj8WFQmqNhK6gSXJqy8S4Z7ThcLK0H4aaCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h2Bh5aweOlsrMx9upapLig95VE6P/wtgmBnGyCgE/GtXcuknLjjIN6ODbgFuaF5EL
	 eDS2C5Y8RHZWLpCAE5bJMRiOCeS8r816HnfGUAc0Z8W8zuR4UvfPnuEkb2dvlM73ea
	 rL7nzuzr/5/b9t1MM+KnZfOrxfvuXypXnMS6jrpgxXpyhW52U+WX9OAghLFUYDW+2Q
	 Zu6sta5gbjcxLbV7/ctf0Y/Gz9J93kdYkj0/FxhNRX7Ew968bZ6CJ/cHAvh/N2nWWz
	 EDNV/q5aefkms9EBuK41YVxAN8/YkXegne8ETchjHIgkqyX6y3n4hp45qN6qxJUpnf
	 C2+2vheFINnXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] selftests: KVM: guest_memfd: test
 GUEST_MEMFD_FLAG_BIND_NODE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregory Price" <gourry@gourry.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902194657.79075-6-gourry@gourry.net>
References: <20260902194657.79075-1-gourry@gourry.net>
 <20260902194657.79075-6-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:04:59 +0000
Message-Id: <20260902200500.5703F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The test `test_bind_node` assumes that NUMA nodes 0 and 1 always=
 exist and are online, which will crash the test on systems with sparse NUM=
A topologies.
- [Medium] Skipping GUEST_MEMFD_FLAG_BIND_NODE unconditionally in test_gues=
t_memfd_flags() omits testing its rejection on unsupported kernels.
--

commit bc5b1f010d9045d5cca04643d1e37516ee53b8b5
Author: Gregory Price <gourry@gourry.net>

selftests: KVM: guest_memfd: test GUEST_MEMFD_FLAG_BIND_NODE

This commit adds tests for the GUEST_MEMFD_FLAG_BIND_NODE flag in the KVM
guest_memfd selftest. It verifies behavior on NUMA setups, including
faulting onto remote nodes, and checks for invalid arguments. The flag
is skipped in the general test_guest_memfd_flags() loop as it requires
a valid node field.

> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> index 1818e0fea5690..b333cb42fab29 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
[ ... ]
> @@ -196,6 +196,83 @@ static void test_numa_allocation(int fd, size_t tota=
l_size)
>  	kvm_munmap(mem, total_size);
>  }
> =20
> +static bool has_bind_node(struct kvm_vm *vm)
> +{
> +	return vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS) &
> +	       GUEST_MEMFD_FLAG_BIND_NODE;
> +}
> +
[ ... ]
> +static void test_bind_node(int fd, size_t total_size, int node)
> +{
> +	const unsigned long other_mask =3D 1UL << (node ? 0 : 1);

[Severity: Medium]
Does this code assume NUMA nodes 0 and 1 always exist and are online, which
could fail the test on systems with sparse NUMA topologies?

By hardcoding the "other" node as 1 (or 0) using
other_mask =3D 1UL << (node ? 0 : 1), the test assumes these nodes are alwa=
ys
present. On a multi-node system where node 0 is memoryless or only nodes 0
and 2 exist, wouldn't the kvm_set_mempolicy() or guest_memfd creation fail
with EINVAL?

> +	const unsigned long maxnode =3D BITS_PER_TYPE(other_mask);
> +	bool steer_away =3D is_multi_numa_node_system();
[ ... ]
> @@ -429,6 +506,10 @@ static void test_guest_memfd_flags(struct kvm_vm *vm)
>  	int fd;
> =20
>  	for (flag =3D BIT(0); flag; flag <<=3D 1) {
> +		/* BIND_NODE depends on a valid node field, test separately */
> +		if (flag =3D=3D GUEST_MEMFD_FLAG_BIND_NODE)
> +			continue;
> +

[Severity: Medium]
Does skipping this unconditionally omit testing its rejection on
unsupported kernels?

The loop in test_guest_memfd_flags() is designed to test that all
unsupported flags are correctly rejected with -EINVAL. By bypassing it
entirely with this continue statement, wouldn't this fail to verify
that older kernels without BIND_NODE actually reject the flag? Should
this instead only skip if (flag & valid_flags)?

>  		fd =3D __vm_create_guest_memfd(vm, page_size, flag);
>  		if (flag & valid_flags) {
>  			TEST_ASSERT(fd >=3D 0,
> @@ -486,6 +568,8 @@ static void __test_guest_memfd(struct kvm_vm *vm, u64=
 flags)
>  			gmem_test(mmap_supported, vm, flags);
>  			gmem_test(fault_overflow, vm, flags);
>  			gmem_test(numa_allocation, vm, flags);
> +			if (has_bind_node(vm))
> +				gmem_test_node(bind_node, vm, flags, 0);

[Severity: Medium]
Does hardcoding node 0 here cause the same sparse NUMA topology issue?

Similar to the logic in test_bind_node(), passing 0 as the node assumes
that NUMA node 0 always exists and is online. Could this crash the test on
systems where node 0 does not exist?

>  			__gmem_test(collapse, vm, flags, pmd_size);
>  		} else {
>  			gmem_test(fault_private, vm, flags);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902194657.7907=
5-1-gourry@gourry.net?part=3D5
