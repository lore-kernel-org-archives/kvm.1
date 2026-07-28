Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7123B8D70
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230387; cv=none; b=YOzfZ4gOZC5AEEwiEzrE5+l2QkH/bC54Zs5Sl9YA4BzmGt4KJ+A7yzhulqwEVudWBeUxfkN3IT+0ISK/GhPfgbpvSovTWwU8v/7vqCnCQAHtrbtuj56glePvEf9tY968WDsWi5MW19KRe3hqIJIXJkJSwoCm+yC/tInrwUU/Irs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230387; c=relaxed/simple;
	bh=lndrDXr/HixUoyotdeR9HJMt1IbsDmS81u35RYaN4Vg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a/evllXsbz0nxRRQiBwRYFugOtMLrguyNnFUYZ7k16QUxVQ8IYVEt1BSl4a1hwd/eMmUyfwqGJkYilDI5pwW7ZEaQO48LTaSVwSGnDxVIdk2ezxnrEiMf8OLXsfw9vkUSbX6ik8Wvj1DyN4l1nW7r1UWplxNFpxcIhk04JNtcB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmpFsydO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmpFsydO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6C31F000E9;
	Tue, 28 Jul 2026 09:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785230386;
	bh=C6ddXxRB2pru2ULyhojoxsbU5DuF7hHK9wWm4iC9L4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fmpFsydOEapGRpJX07oCmzEtSowb1rhSqCVWh80/qQqRYda3EzrfTx2s0yrP+Asxz
	 rlNhRct8X4Pm+5zUBjdOC/ZIVyUD0AjC77Ltdp8Aqrjnczzdxo1ljvjPkyTtpYdVDt
	 1raJ9tMoNVhQLo3ocH0zvojdyXVxTjGsJNey8KmkYcggEbSUgYr+HG79BQY42+ohB/
	 CWvZ+Hg9HvCxbgcmcFAjhwmar+/awGMDBZ21GDngBySzchmbk/UOc0nTlJgLx6IKgK
	 beg3JphYYkxet8vmdQZmRsSpTXS6YVRiVcbfhWYlh4dm+SWzhzfRizynoS8BkHq/02
	 0TTKYNFeR0UNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 4/4] KVM: selftests: exercise guest_memfd folio
 migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728-shivank-gmem-migrate-v2-4-269ac1f84e2b@amd.com>
References: <20260728-shivank-gmem-migrate-v2-0-269ac1f84e2b@amd.com>
 <20260728-shivank-gmem-migrate-v2-4-269ac1f84e2b@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 09:19:45 +0000
Message-Id: <20260728091945.EA6C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Hardcoding of NUMA node IDs 0 and 1 makes the test brittle and p=
rone to false failures on systems with sparse, non-contiguous, or memoryles=
s nodes.
--

--- Patch [4]: [PATCH RFC v2 4/4] KVM: selftests: exercise guest_memfd foli=
o migration ---
commit 3681825fc67afc2ab3cf2b50c6cec1297cae94b5
Author: Shivank Garg <shivankg@amd.com>

KVM: selftests: exercise guest_memfd folio migration

This commit adds a migration test to guest_memfd_test to verify that
guest_memfd folios can be migrated across NUMA nodes using move_pages().
It allocates folios on node 0, migrates them to node 1, verifies the
contents, and then migrates them back.

> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
[ ... ]
> +static void test_migrate_folio(int fd, size_t total_size)
> +{
> +	const unsigned long nodemask_0 =3D 1; /* nid: 0 */
> +	unsigned long maxnode =3D BITS_PER_TYPE(nodemask_0);
> +	int page_count =3D total_size / page_size;
> +	int *status, *nodes;
> +	void **addr;
> +	char *mem;
> +	int i;
> +
> +	if (!is_multi_numa_node_system())
> +		return;
> +
> +	mem =3D kvm_mmap(total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
> +
> +	addr =3D calloc(page_count, sizeof(*addr));
> +	status =3D calloc(page_count, sizeof(*status));
> +	nodes =3D calloc(page_count, sizeof(*nodes));
> +	TEST_ASSERT(addr && status && nodes, "Failed to allocate page arrays");
> +
> +	/* Allocate all folios on node 0 and fill each with a known pattern. */
> +	kvm_mbind(mem, total_size, MPOL_BIND, &nodemask_0, maxnode, 0);
> +	for (i =3D 0; i < page_count; i++) {
> +		memset(mem + i * page_size, (char)(i & 0xff), page_size);
> +		addr[i] =3D mem + i * page_size;
> +	}
> +
> +	kvm_move_pages(0, page_count, addr, NULL, status, 0);
> +	for (i =3D 0; i < page_count; i++)
> +		TEST_ASSERT(status[i] =3D=3D 0, "Page %d should be on node 0", i);
> +
> +	/* Migrate node 0 -> 1, then check both the location and the data. */
> +	for (i =3D 0; i < page_count; i++)
> +		nodes[i] =3D 1;

[Severity: Medium]
Could this hardcoding of NUMA node IDs cause false positive test failures?

If a system has sparse, non-contiguous, or memoryless nodes (for example,
nodes 0 and 2 exist, but node 1 is absent), is_multi_numa_node_system()
will return true, but the initial allocation on node 0 or the migration to
node 1 could fail.

Would it be better to dynamically discover available memory nodes in
test_migrate_folio() instead of assuming nodes 0 and 1 always exist and
have memory available?

> +	kvm_move_pages(0, page_count, addr, nodes, status, MPOL_MF_MOVE);
> +
> +	kvm_move_pages(0, page_count, addr, NULL, status, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-shivank-gm=
em-migrate-v2-0-269ac1f84e2b@amd.com?part=3D4
