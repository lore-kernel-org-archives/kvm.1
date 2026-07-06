Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72E138BF97
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329571; cv=none; b=HqKljEaW9gbPws/3HeEXA7qqAJVpcZ2/iu1EvyLlpv2tkD4d7dWf465Xb8rStYSeR3tsdLdTWr7cGP/dv8QM0HYXd1Pa4Lqs4lIvfd9fWhQql/K0A/+6c3cP24XRY/Nlx7OzVgXY2sOcPz9fTIRQg5kwYenxpMrxbnZh8tP5v54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329571; c=relaxed/simple;
	bh=ukaF6KdPmzLGdXYqlruErHomAaJCHzkw5DcyqJ88I2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZUpGKA18pukiyXXk5FSU6BKSDzND2zzCxlCF//KE/hK0W2flz1tLUh5LIvwAPyYFNciu6aJqHcHKtba3rLrjf76fV5qBvya4P7vS1dtFdjlr+hcJj1i+rrRCmbjDXuSE5cQpgjkyFanyGfSjUx73N73xERicit1HLZYiDaEJgw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUIvRYnB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUIvRYnB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A2E1F000E9;
	Mon,  6 Jul 2026 09:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783329566;
	bh=9dkqEAItKX36rx4dmtAtsrSJf/M5a+2pA6ELmXuN16s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NUIvRYnBdbjDliqF70diqaLiwZYlC5WPfDbIlQ2eMOYhBiWEfDaDl9/gH5d6fjrj1
	 c6jaKAfbPp4LJyIg0aqRXmYX2SsX6sFv3b7dVdJFo6sM3aS+74pqtoQuol9lVuhSx6
	 JCHk68oV9RKDN/rCr3xsHojsNpjp/+g8V4yT+biHp8ej3fSe5o6UHkp9SD9C0se0pt
	 0Zpjcnc14bKidTlcC6I3/F6REnfk1ZHXmaEB7RiMGXuWOm7Lv0PbpUx5L7+v0+DIxp
	 rAt+k6j/OjCLQnOEa7SGrO3azD0DIBTUhssC5cNAUpXA89b6RKr9/jAkN9xSmne6rB
	 12jfiD/xoQOXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 14/15] selftests/mm: add userfaultfd RWP tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260706084805.8400-15-kirill@shutemov.name>
References: <20260706084805.8400-1-kirill@shutemov.name>
 <20260706084805.8400-15-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:19:26 +0000
Message-Id: <20260706091926.91A2E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The uffd selftests unconditionally call `err()` if `madvise(MADV=
_NOHUGEPAGE)` fails for RWP tests, which will abort the entire test suite o=
n kernels compiled with `CONFIG_TRANSPARENT_HUGEPAGE=3Dn`.
- [Medium] The `rwp-fork-pin` and `rwp-mprotect` tests will silently pass i=
f a kernel bug causes the `uffd-wp` marker to be completely dropped instead=
 of preserved.
--

commit c7d4aef17412fdd00834c4bcc5b4fbabc6db2f28
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>
Date:   Mon Jul 6 08:48:03 2026 +0000

    selftests/mm: add userfaultfd RWP tests
   =20
    Coverage for UFFDIO_REGISTER_MODE_RWP and UFFDIO_RWPROTECT. All tests
    run against anon, shmem, shmem-private, hugetlb, and hugetlb-private
    memory, except rwp-fork-pin which is anon-only.

> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing=
/selftests/mm/uffd-unit-tests.c
> index a6c14109e8188..bd3b9f41ee354 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c

[ ... ]

> +static void uffd_rwp_mprotect_test(uffd_global_test_opts_t *gopts,
> +				   uffd_test_args_t *args)
> +{

[ ... ]

> +	/* Round-trip mprotect(): PROT_NONE -> PROT_READ|PROT_WRITE */
> +	if (mprotect(gopts->area_dst, nr_pages * page_size, PROT_NONE))
> +		err("mprotect() PROT_NONE");
> +	if (mprotect(gopts->area_dst, nr_pages * page_size,
> +		     PROT_READ | PROT_WRITE))
> +		err("mprotect() PROT_READ|PROT_WRITE");
> +
> +	/* Touch every page. Async RWP must auto-resolve each fault. */
> +	for (p =3D 0; p < nr_pages; p++) {
> +		volatile char *page =3D gopts->area_dst + p * page_size;
> +		(void)*page;
> +	}

[Severity: Medium]
Will this test falsely pass if mprotect() completely drops the uffd-wp
marker? Since the test accesses the pages expecting async faults to clear t=
he
markers, but doesn't assert that the markers survived the mprotect()
round-trip first, a kernel bug dropping the protection might let the access
silently succeed and leave the marker clear.

[ ... ]

> +static void uffd_rwp_fork_pin_test(uffd_global_test_opts_t *gopts,
> +				   uffd_test_args_t *args)
> +{

[ ... ]

> +	child =3D fork();
> +	if (child < 0)
> +		err("fork");
> +	if (child =3D=3D 0) {
> +		volatile char c;
> +		int cfd;
> +
> +		/*
> +		 * Read the pinned page. Only reaches the fault path if the
> +		 * child PTE is protnone + uffd; async mode auto-resolves and
> +		 * clears the uffd bit. If copy_present_page() dropped
> +		 * PAGE_NONE, the read would silently succeed and the bit
> +		 * would still be set.
> +		 */
> +		c =3D *(volatile char *)gopts->area_dst;
> +		(void)c;
> +
> +		cfd =3D pagemap_open();
> +		value =3D pagemap_get_entry(cfd, gopts->area_dst);
> +		close(cfd);
> +		_exit((value & PM_UFFD_WP) ? 1 : 0);
> +	}

[Severity: Medium]
Could this test also falsely pass if copy_present_page() drops the uffd-wp
marker completely? The child touches the page and verifies the marker is
clear, but it doesn't verify the marker was correctly preserved prior to the
access.

[ ... ]

> @@ -1814,6 +2684,20 @@ int main(int argc, char *argv[])
>  				uffd_test_skip(errmsg);
>  				continue;
>  			}
> +			/*
> +			 * RWP tracks protection on ptes; a THP-backed shmem/anon
> +			 * range (e.g. shmem_enabled=3Dalways) would split on
> +			 * rwprotect and change behaviour under the test. Keep
> +			 * such ranges off THP. hugetlb is huge by definition and
> +			 * rejects MADV_NOHUGEPAGE, so skip it.
> +			 */
> +			if ((test->uffd_feature_required & UFFD_FEATURE_RWP) &&
> +			    !(mem_type->mem_flag & (MEM_HUGETLB | MEM_HUGETLB_PRIVATE))) {
> +				unsigned long len =3D gopts.nr_pages * gopts.page_size;
> +
> +				if (madvise(gopts.area_dst, len, MADV_NOHUGEPAGE))
> +					err("madvise(MADV_NOHUGEPAGE)");

[Severity: Medium]
Will this unconditional error check on madvise() abort the entire test suite
on kernels lacking THP support? On a kernel compiled with
CONFIG_TRANSPARENT_HUGEPAGE=3Dn, madvise(MADV_NOHUGEPAGE) returns -EINVAL,
which would cause err() to exit the process instead of gracefully continuing
or skipping the test.

> +			}
>  			test->uffd_fn(&gopts, &args);
>  			uffd_test_ctx_clear(&gopts);
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706084805.8400=
-1-kirill@shutemov.name?part=3D14
