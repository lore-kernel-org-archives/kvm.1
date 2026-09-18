Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469463BB138
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742147; cv=none; b=AcJnpkYBvDfeLXN/lTb50XQwWZBaXd0b6ekasRt0+ZdltSCXaJ4wGYQGc5m2aPp+nMcM5jzRLv0D2HAPqWp2rjH6k3ZV4d5Tr7kYDp9kz3Wif2ALmswUp39oKu8z/WB178fz92yo6a8KbmLeibuswtDwzHA7UgTB3ERIfEmL+HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742147; c=relaxed/simple;
	bh=iNcrRaS8Y3/NYlgKX5QXkNQRZr+ExHh0YFIXOwXc7/U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YAp9wYF38IFZ9FnMK7YZ7g50UH0PMpaz05nYP9oscOU0l7BGuR9TxM1ET7TuV4wHGnZyQG9HpbW79+2Y0ibJlm6m7si5thYFzhZdU/L8UJDlVbsw9VUtPiW8Gi3OVwxkfFgFRPj19uyGHYPDZWJ5zVf6/Qx+z0WlTfTbXoc5rRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaYktU6K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaYktU6K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7E11F000FF;
	Fri, 18 Sep 2026 14:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789742146;
	bh=68H0gOlfLW0qm8GZ+X3CY6pdwLYaRqIZsa1ru527CQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OaYktU6K78z1opKRVvPFTwXEj/xe2Z06WoCwCxxapBqe5u9gd/9rqhQwVg2KWa3VA
	 Hxq6Gw7HTDF1wEYkqLmdEUuCbr9pwO8O8FsarpcKlpdtEbS2r0bwu/VwG738Lh7z0Y
	 D/cIIwoNq2mIgOnq4x6A/ojl0Oq81zZX8u7NQw17Z+/vAnJCfe8vtoiO4nPpxpTvsC
	 L0oclyTmBJB+9k54Nsk+EwDSpJrORlOUbB6TlIzpKp9y3hp6mf+8BEBxw4LgrSaClg
	 uU7gS/TsK55Rmnc2o/SZjLu9BH0RnvjRtLIUdLJHgwZsyrkbFSuDPYTNpB46XiYysx
	 xzQLzVE7M/Wrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: selftests: Test partial KVM_CLEAR_DIRTY_LOG
 requests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tharit Tangkijwanichakul" <tharitt97@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918142053.10127-1-tharitt97@gmail.com>
References: <20260918142053.10127-1-tharitt97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:35:45 +0000
Message-Id: <20260918143545.BE7E11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: selftests: out-of-bounds memory read in dirty_log_test
--

commit 91a9082b8baef537794ce258865b745e98facf50
Author: Tharit Tangkijwanichakul <tharitt97@gmail.com>

KVM: selftests: Test partial KVM_CLEAR_DIRTY_LOG requests

This commit adds a test to verify that KVM correctly applies a clear log
bitmap relative to a nonzero first_page offset. It introduces
run_clear_log_partial_test() to ensure that pages not selected by a
partial request remain dirty.

> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing=
/selftests/kvm/dirty_log_test.c
> index af5eb0334a74f..3976748f39400 100644
> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
[ ... ]
> @@ -815,6 +815,114 @@ static void run_test(enum vm_guest_mode mode, void =
*arg)
[ ... ]
> +static void run_clear_log_partial_test(enum vm_guest_mode mode, void *ar=
g)
> +{
> +	unsigned long *bmap, *clear_bmap;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	u64 page;
[ ... ]
> +	bmap =3D bitmap_zalloc(host_num_pages);
> +	clear_bmap =3D bitmap_zalloc(BITS_PER_LONG);

[Severity: Medium]
Does this allocate an undersized buffer on 32-bit systems?

Using BITS_PER_LONG allocates 32 bits (4 bytes) on 32-bit architectures,
rather than the 64 bits mandated by the KVM API bit count for the request
below.

> +
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
[ ... ]
> +	__set_bit_le(TEST_CLEAR_LOG_BIT, clear_bmap);
> +	kvm_vm_clear_dirty_log(vm, TEST_MEM_SLOT_INDEX, clear_bmap,
> +			       TEST_CLEAR_LOG_FIRST_PAGE,
> +			       TEST_CLEAR_LOG_NUM_PAGES);

[Severity: Medium]
Will this trigger an out-of-bounds read of userspace heap memory?

The test passes clear_bmap alongside TEST_CLEAR_LOG_NUM_PAGES (which is 64)
to kvm_vm_clear_dirty_log(). This instructs the kernel to read 64 bits (8
bytes) of dirty log data.=20

Since clear_bmap is only 4 bytes long on 32-bit systems, this appears to ca=
use
the kernel to read 4 bytes past the end of the allocated buffer.

> +
> +	kvm_vm_get_dirty_log(vm, TEST_MEM_SLOT_INDEX, bmap);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918142053.1012=
7-1-tharitt97@gmail.com?part=3D1
