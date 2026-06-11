Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085FE40C5CC
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781183901; cv=none; b=pdfkywRD5sNXbnFPjAtvLxnDJU8aCKBNoVOagS/Ux24Vlijk0f5jFrefIyaT3TJsR0sdqsr2L1Hzyu4CL97FM2iQysHRxWKHb0vtqbmQdOMLWVP79d8Gxu6M0csIrX5LUGj1WKJK0wUwXJGeLzyCknoKHNZiNNBf5w8e7ZxJJjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781183901; c=relaxed/simple;
	bh=2Bvhx6JOvRAoyFMb3yhqEB0vnLlGpl/tLai9cPJtahE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=feI6xks2HR+C0NrxLDK8itAVWee9OvDE9XzHpCfL7hAUhrGerCyxTmzqj8PQmv26k2Ube033pSoBzIaFHrwGXD4tBCX6Oq1GHmUM7ogUhPh/E339xWzOAtejaDWXZRtHqmmEfToPV0cqvdiX5XZ6fDMEjlnzTDhBl1rVrvhp63w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4dgjAVU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4dgjAVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4B21F00893;
	Thu, 11 Jun 2026 13:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781183896;
	bh=gXV4u/CQkDuedEf6vwPb3VpHTmtOeyTKZIyA5+OjDXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D4dgjAVUXTyjrV71j/kcb9aFoXSQvFNtaDhHIqGRx1waaeqj9C24AtTrwTj28O3iL
	 OtNsSBmPvjZOOy+kpQbdk/P0kuqV6j7MOEFeVxGVQisY5BIhMd/et09LnbsIC3qT3a
	 6p1PTkICStouT48DswtU5sqQdrJsbtnG4CsSiZgHriIQnUB91K+KAwtBvVht3yqyrE
	 j7bKF7KWIQlfBYv0Jmi/tBMoMBLmnJGBWM+TZhjXLi52MJMogWWicCKG5IUz2i1Uvs
	 pSfNjScpvOPmqs+311zvwBwsK90g1+y9x49ACieXGsPR0jx2ZMt9kAJnp8cNKVwRZX
	 nQzVQUPXs8nOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 3/3] KVM: selftests: exercise guest_memfd folio
 migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260611-shivank-gmem-migrate-v1-3-2d266bfc6f95@amd.com>
References: <20260611-shivank-gmem-migrate-v1-3-2d266bfc6f95@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 13:18:15 +0000
Message-Id: <20260611131816.1F4B21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test `test_migrate_folio` hardcodes NUMA nodes 0 and 1, lead=
ing to false-positive test failures on systems with sparse NUMA topologies =
or restricted cgroups.
--

commit 857b251fdce0e2a9ddc74b27904d9c410d3010ca
Author: Shivank Garg <shivankg@amd.com>

KVM: selftests: exercise guest_memfd folio migration

This commit adds a migration test to guest_memfd_test for the
MMAP | INIT_SHARED configuration on multi-NUMA systems. It migrates folios
between node 0 and node 1 using move_pages(2) and verifies data integrity.

> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> index 832ef4dfb99fa..04931d3add46c 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
[ ... ]
> @@ -76,6 +76,82 @@ static void test_mmap_supported(int fd, size_t total_s=
ize)
>  	kvm_munmap(mem, total_size);
>  }
> =20
> +/*
> + * Each page is filled with a distinct byte (its index). Check every byt=
e that
> + * data is intact after migration.
> + */
> +static void verify_page(const char *page, int page_idx, size_t size,
> +			const char *when)
> +{
[ ... ]
> +static void test_migrate_folio(int fd, size_t total_size)
> +{
> +	const unsigned long nodemask_0 =3D 1; /* nid: 0 */
> +	unsigned long maxnode =3D BITS_PER_TYPE(nodemask_0);
> +	int page_count =3D total_size / page_size;
> +	void **addr;
> +	int *status, *nodes;
> +	char *mem;
> +	int i;
> +
> +	if (!is_multi_numa_node_system())
> +		return;
[ ... ]
> +	kvm_move_pages(0, page_count, addr, NULL, status, 0);
> +	for (i =3D 0; i < page_count; i++)
> +		TEST_ASSERT(status[i] =3D=3D 0, "Page %d should be on node 0", i);
> +
> +	/* Migrate node 0 -> 1, then check both the location and the data. */
> +	for (i =3D 0; i < page_count; i++)
> +		nodes[i] =3D 1;
> +	kvm_move_pages(0, page_count, addr, nodes, status, MPOL_MF_MOVE);

[Severity: Medium]
Can this hardcoded target node cause false-positive test failures on
systems with sparse NUMA topologies or restricted cpusets?

is_multi_numa_node_system() verifies that get_max_numa_node() >=3D 1, but
it does not guarantee that nodes 0 and 1 specifically are online, have
memory, or are accessible within the current cpuset (for example, a system
might only have nodes 0 and 8).

If node 1 is unavailable, kvm_move_pages() or kvm_mbind() will fail with
-ENODEV or -EINVAL, triggering a test assertion failure.

Should this test dynamically discover available NUMA nodes instead of
hardcoding nodes 0 and 1?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-shivank-gm=
em-migrate-v1-0-2d266bfc6f95@amd.com?part=3D3
