Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722CC448B87
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789402202; cv=none; b=mMne8e5+pZzFUeX0mURofkoXAc7hxM6d0RrCAxUWGd20yiC5mC9G9T36zBadFNzZ0BejWD8OrGvpr2+/pFls4oPdIK7fWQbSrMKWoIopXarOKSHFlFrXMF4XxStdt5K6upjtP61KmMHVYe6UtQdSeIW9sjNQo7bsP6fgUQT2fy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789402202; c=relaxed/simple;
	bh=/EMXcNoyGL/e6dsUMCGiKQZzvIbC+oxCbfCbyBZeSAQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M0pMH5Rm5JuDb1F4UvAhs2dnTWeW4I3h7kvAXlYKqcFZI6N8Cf3sB6WpaFxyjwGC61K0rSO740Ic0rG0ZCdi02hXx6tjQjA3N4ao9I8UOkJzz0eG1Sylkog6TqgPAY8tuYnWsV10DMJ5RXM7JJywDg4niXE1RjpfbNIaLVmH2X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0s4vhT9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0s4vhT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CD21F000FF;
	Mon, 14 Sep 2026 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789402201;
	bh=NuApbsKj6d+qSZmUOUuzraBxoh/dXVoJWlVnF/eVlss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l0s4vhT9wZxEz5XRhecC7gFPFxvlfNYl8Hgk7W81qmfyNhNpkUpUtdrNTtIEeeXww
	 6ZhKrpChvW5RytaDMVqbOTuHzUC3x0hG3BwtbL9DHfyU19FwrVMdeKyyW7aG/MDQ9b
	 cFhepYo+mngZt1Zt4+6ROLZl7T1AdZuPGbpxrMRgZOdPdTsrw9C2bVGy4lh44kueyL
	 pRBHfApeEWUCGUlsaWFdRmMKRnnYkwEcMjhr01LJaUMIQqo53jElN4fvXptR9PKYur
	 6EtsiV3DzD1KGpaz26lbKcXpGrYToFrV9cS2L1BnKDXP8CQvrcIcm+4aREYh694gmB
	 wsvuTEwih5kaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: selftests: Test partial KVM_CLEAR_DIRTY_LOG
 requests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tharit Tangkijwanichakul" <tharitt97@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260914155301.14499-1-tharitt97@gmail.com>
References: <20260914155301.14499-1-tharitt97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 16:10:00 +0000
Message-Id: <20260914161000.E3CD21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Hardcoded page offsets and lengths cause memslot bounds violatio=
ns and guest memory aborts when host_page_size > guest_page_size.
- [Medium] Test falsely assumes KVM_DIRTY_LOG_INITIALLY_SET is always suppo=
rted if KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 is present.
--

commit 7a613b42770cbf4a2e9e3cd0b003c952b47213c3
Author: Tharit Tangkijwanichakul <tharitt97@gmail.com>

KVM: selftests: Test partial KVM_CLEAR_DIRTY_LOG requests

This commit adds a new test mode to verify that KVM_CLEAR_DIRTY_LOG correct=
ly
applies targeted clearing. It creates a memory slot with
KVM_DIRTY_LOG_INITIALLY_SET, submits a 64-page clear request at offset 64,
and verifies that only the requested page is cleared and subsequently
re-dirtied.

> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing=
/selftests/kvm/dirty_log_test.c
> index af5eb0334a74f..a12b538c3144e 100644
> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> @@ -815,6 +815,106 @@ static void run_test(enum vm_guest_mode mode, void =
*arg)
>  	kvm_vm_free(vm);
>  }
> =20
> +/* Use the 2nd 64-page range to exercise a non-zero offset. */
> +#define TEST_CLEAR_LOG_FIRST_PAGE	64
> +#define TEST_CLEAR_LOG_NUM_PAGES	64
> +#define TEST_CLEAR_LOG_BIT		1
> +#define TEST_CLEAR_LOG_PAGE		(TEST_CLEAR_LOG_FIRST_PAGE + \
> +					 TEST_CLEAR_LOG_BIT)
> +static void guest_code_clear_log(void)
> +{
> +	u64 addr =3D guest_test_virt_mem + TEST_CLEAR_LOG_PAGE * host_page_size;
> +
> +	while (true) {
> +		vcpu_arch_put_guest(*(u64 *)addr, 1);

[Severity: Medium]
Will this result in an out-of-bounds guest memory access on architectures w=
here
the host page size is larger than the guest page size?

When run_clear_log_partial_test() calculates the memory size using
guest_num_pages =3D vm_adjust_num_guest_pages(mode, 3 * BITS_PER_LONG), the
memslot may be severely undersized. For example, on an architecture with a
64K host page size and 4K guest page size, 192 guest pages is equivalent to
768KB, which is only 12 host pages.

Since TEST_CLEAR_LOG_PAGE is hardcoded to 65, calculating addr as
guest_test_virt_mem + TEST_CLEAR_LOG_PAGE * host_page_size places it far be=
yond
the mapped 768KB memslot mapping, which can cause a guest data abort.

> +		GUEST_SYNC(1);
> +	}
> +}
> +
> +/*
> + * Verify KVM_CLEAR_DIRTY_LOG only clears (and re-arms) the requested ra=
nge:
> + * with KVM_DIRTY_LOG_INITIALLY_SET every page starts dirty; clearing a =
single
> + * page must leave its neighbours dirty and must write-protect the page =
so the
> + * next guest write re-dirties it.
> + */
> +static void run_clear_log_partial_test(enum vm_guest_mode mode, void *ar=
g)
> +{
> +	unsigned long *bmap, *clear_bmap;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	u64 page;
> +
> +	guest_num_pages =3D vm_adjust_num_guest_pages(mode, 3 * BITS_PER_LONG);
> +
> +	vm =3D create_vm(mode, &vcpu, 2 * guest_num_pages, guest_code_clear_log=
);
> +
> +	guest_page_size =3D vm->page_size;
> +	host_page_size =3D getpagesize();
> +	host_num_pages =3D vm_num_host_pages(mode, guest_num_pages);
> +
> +	guest_test_virt_mem =3D DEFAULT_GUEST_TEST_MEM;
> +	guest_test_phys_mem =3D (vm->max_gfn - guest_num_pages) * guest_page_si=
ze;
> +	guest_test_phys_mem =3D align_down(guest_test_phys_mem, host_page_size);

[ ... ]

> +	kvm_vm_get_dirty_log(vm, TEST_MEM_SLOT_INDEX, bmap);
> +	for (page =3D 0; page < host_num_pages; page++)
> +		TEST_ASSERT(test_bit_le(page, bmap),
> +			    "Page %lu should be dirty after INITIALLY_SET", page);

[Severity: Medium]
Does this assertion assume that KVM_DIRTY_LOG_INITIALLY_SET is always suppo=
rted
if KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 is present?

The clear-log test mode checks for KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2, but it
does not explicitly check if KVM_DIRTY_LOG_INITIALLY_SET is supported before
running this test.

On older kernels that support manual protect but not INITIALLY_SET,=20
kvm_vm_get_dirty_log() will return a clean bitmap, which could cause this
assertion to falsely fail instead of gracefully skipping.

> +
> +	__set_bit_le(TEST_CLEAR_LOG_BIT, clear_bmap);
> +	kvm_vm_clear_dirty_log(vm, TEST_MEM_SLOT_INDEX, clear_bmap,
> +			       TEST_CLEAR_LOG_FIRST_PAGE,
> +			       TEST_CLEAR_LOG_NUM_PAGES);

[Severity: Medium]
Can passing TEST_CLEAR_LOG_FIRST_PAGE (64) cause kvm_vm_clear_dirty_log() to
fail with -EINVAL on systems where the host page size exceeds the guest page
size?

As mentioned above, if the memslot only has 12 host pages (e.g., when using=
 a
64K host and 4K guest), a first_page index of 64 exceeds the memslot bounds.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914155301.1449=
9-1-tharitt97@gmail.com?part=3D1
