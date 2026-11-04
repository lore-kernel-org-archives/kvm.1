Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793754628;
	b=sH/lcKI+v4/SyN6oIPIy6buAhg2kC4lC16a1QMddNGgtl7hAH6+uhSspnTACMBpsB6Uk
	 9rowPIEKBrqLNMZj+rppDR33BC8/HPL8FTWXhUyQmqzTfncmQ70rR3yVPKvTmXLSG3LPm
	 OWiWN/z7R5XxaGA69t2Z1jXUGPrNQHEsZQjjPORVMdo8f5wqCks/gUC8Fj6wsvesQ3Mbk
	 Is1shawAdgJbTfsobU+/i8VjMSNas5fyP/dhgytjgf+4Nk/BBOFqj5BdrQYbYxNe+mpE/
	 gQzbzVOvKh6AMXLKVJHwr/NLHYuzR/BEBq01ppyfSjHlbbJdBvyW9mkjpSWw1d9gKAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793754628;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JM5gvFP69JqF3K0oOnuCvxk4ceV2ST4OL5LjMtOhOss=;
	b=qvtYfqY+exKZbiJt3jNSBWccPZL12J1KiUQJdWsXaCO12ulLxFTs4/rZPwBnzCUPJqfa
	 oZMprpPmndox4AV85SYeuJdWk0ILFha4JWres15cI5y8yLTO1OzYr06mCgh4kArCV0bHq
	 5LQPqEYEdg58J2kRHLQO6T2TU5LXbYZLhwKLSbkcqoag1pK+7BvCOWV461+1WUKSVIzsc
	 SejyAgYljwOXpmv7aiAGlohTalXpDR5WpLPCTwYaiN6KtNSAe97Cu+ouMxhmV5IJFx676
	 dNNe/krbeEyGAdY1on7MrKhxta103sOIQmW9b4wvBM5T/gxMQiTNVR0MPy8qWCJYXtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5JqT5N7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4A4606A31B
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5JqT5N7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424BA1F000C1;
	Wed,  4 Nov 2026 01:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793754627;
	bh=JM5gvFP69JqF3K0oOnuCvxk4ceV2ST4OL5LjMtOhOss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F5JqT5N78ybuT4qPxQGhrWGlIfn2GEobmCKk7LzS0uCodVq4b4NrlDgx9wInpiccB
	 7C8spkyMJoTO6Q/W27OaZtRKuar3G3SSf2KVz1I+apqGBGWbFFmVlBZTKMjch4aWUB
	 ncBqla7xQ6uzM57hL0gzAKjSmJiHWSLxF7oN1347WHUo1PC6aQcuZc859EqoxHZxE3
	 reXvRHUbhR39ZnQdIUUsEizIMngVm9Ivb31tathwaF+1rrw3cn6R0zNwdu5q82i4sb
	 ucj3JVIgm9XISvaaRRVj2rKMti2q8t/sE/VhxshAJRRE0PHMGs7mgAneAJu6ZBv/7w
	 N1pSjeeEy8/EA==
Message-ID: <sashiko-outbox-196347@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/5] KVM: selftests: Test dirty logging of sparse
 nested mappings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fred Griffoul" <griffoul@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261104005331.50600-6-griffoul@gmail.com>
References: <20261104005331.50600-1-griffoul@gmail.com>
 <20261104005331.50600-6-griffoul@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:10:26 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] KVM: selftests: test_dirty_log() uses default HugeTLB pool inste=
ad of 2M
- [Low] KVM: selftests: free_2m_hugepages() duplicates get_free_hugepages()
- [Low] KVM: selftests: test_dirty_log() pre-divides extra_mem_pages by 512
--

commit f746099353da91d06474f4e326f2f464849f22eb
Author: Fred Griffoul <fgriffo@amazon.co.uk>

KVM: selftests: Test dirty logging of sparse nested mappings

This commit adds an x86 KVM selftest that verifies dirty logging of sparsely
mapped L2 memory across shadow MMU rmap chunk boundaries, as well as eager
page splitting of 2 MiB nested TDP mappings when dirty logging is enabled.

> diff --git a/tools/testing/selftests/kvm/x86/nested_dirty_log_sparse_test=
.c b/tools/testing/selftests/kvm/x86/nested_dirty_log_sparse_test.c
> new file mode 100644
> index 0000000000000..bc1c6b8760c96
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/nested_dirty_log_sparse_test.c
> @@ -0,0 +1,275 @@

[ ... ]

> +static void test_dirty_log(bool nested_tdp, bool huge)
> +{
> +	u64 npages =3D huge ? HUGE_MEM_PAGES : SPARSE_MEM_PAGES;
> +	enum vm_mem_backing_src_type src;
> +	u64 pages_2m =3D 0, pages_4k =3D 0;
> +	gva_t nested_gva =3D 0;
> +	struct kvm_vcpu *vcpu;
> +	unsigned long *bmap;
> +	struct kvm_vm *vm;
> +	struct ucall uc;
> +
> +	pr_info("Nested TDP: %s, L1 TDP page size: %s\n",
> +		nested_tdp ? "enabled" : "disabled", huge ? "2M" : "4K");
> +
> +	/* Room for L1's page tables and TDP page tables of the test memory. */
> +	vm =3D __vm_create_with_one_vcpu(&vcpu, 2 * (npages / 512 + 16),
> +				       l1_guest_code);

[Severity: Low]
Does passing 2 * (npages / 512 + 16) as extra_mem_pages divide npages by 512
twice?

__vm_create_with_one_vcpu() passes extra_mem_pages to vm_nr_pages_required(=
),
which already divides extra_mem_pages by PTES_PER_MIN_PAGE (512):

tools/testing/selftests/kvm/lib/kvm_util.c:vm_nr_pages_required() {
    ...
	nr_pages +=3D (nr_pages + extra_mem_pages) / PTES_PER_MIN_PAGE * 2;
    ...
}

Because npages is pre-divided by 512 here, extra_mem_pages is 96 (or 40 when
huge is true), so (nr_pages + extra_mem_pages) / 512 evaluates to 1 and adds
no extra page-table pages beyond the default. Should this pass 2 * npages
instead?

> +	if (nested_tdp)
> +		vm_enable_tdp(vm);
> +
> +	if (kvm_cpu_has(X86_FEATURE_VMX))
> +		vcpu_alloc_vmx(vm, &nested_gva);
> +	else
> +		vcpu_alloc_svm(vm, &nested_gva);
> +	vcpu_args_set(vcpu, 1, nested_gva);
> +
> +	src =3D huge ? VM_MEM_SRC_ANONYMOUS_HUGETLB : VM_MEM_SRC_ANONYMOUS;
> +	vm_userspace_mem_region_add(vm, src, TEST_MEM_BASE, TEST_MEM_SLOT,
> +				    npages, 0);

[Severity: Medium]
Should src use VM_MEM_SRC_ANONYMOUS_HUGETLB_2MB instead of
VM_MEM_SRC_ANONYMOUS_HUGETLB when huge is true?

In main(), the test checks specifically for four free 2 MiB hugepages in
/sys/kernel/mm/hugepages/hugepages-2048kB/free_hugepages and sizes the regi=
on
to 8 MiB (HUGE_MEM_PAGES).

However, VM_MEM_SRC_ANONYMOUS_HUGETLB uses the system default HugeTLB page
size without MAP_HUGE_2MB:

tools/testing/selftests/kvm/lib/test_util.c:get_backing_src_pagesz() {
	switch (i) {
    ...
	case VM_MEM_SRC_ANONYMOUS_HUGETLB:
	case VM_MEM_SRC_SHARED_HUGETLB:
		return get_def_hugetlb_pagesz();
	default:
		return MAP_HUGE_PAGE_SIZE(flag);
	}
}

On a host booted with default_hugepagesz=3D1G that has 2 MiB hugepages allo=
cated
in the 2048kB pool, get_def_hugetlb_pagesz() will check the 1 GiB pool in
/proc/meminfo and either skip the test if HugePages_Total is 0, or return 1
GiB and cause __kvm_mmap() in vm_mem_add() to fail with EINVAL because the 8
MiB region is not 1 GiB aligned.

[ ... ]

> +static u64 free_2m_hugepages(void)
> +{
> +	u64 nr =3D 0;
> +	FILE *f;
> +
> +	f =3D fopen("/sys/kernel/mm/hugepages/hugepages-2048kB/free_hugepages",=
 "r");
> +	if (!f)
> +		return 0;
> +	if (fscanf(f, "%lu", &nr) !=3D 1)
> +		nr =3D 0;
> +	fclose(f);
> +
> +	return nr;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX) || kvm_cpu_has(X86_FEATURE_SV=
M));
> +
> +	test_dirty_log(/*nested_tdp=3D*/false, /*huge=3D*/false);
> +
> +	if (!kvm_cpu_has_tdp())
> +		return 0;
> +
> +	test_dirty_log(/*nested_tdp=3D*/true, /*huge=3D*/false);
> +
> +	if (free_2m_hugepages() >=3D HUGE_MEM_PAGES / HUGE_PAGES_PER_2M &&
> +	    get_kvm_param_bool("tdp_mmu") && get_kvm_param_bool("eager_page_spl=
it"))
> +		test_dirty_log(/*nested_tdp=3D*/true, /*huge=3D*/true);

[Severity: Low]
This isn't a bug, but test_util.h already provides get_free_hugepages() in
tools/testing/selftests/kvm/lib/test_util.c, which reads the same sysfs file
and returns the free bytes:

tools/testing/selftests/kvm/lib/test_util.c:get_free_hugepages() {
	char path[128];
	size_t free;

	snprintf(path, sizeof(path),
		 "/sys/kernel/mm/hugepages/hugepages-%zukB/free_hugepages",
		 page_size >> 10);
	if (!test_sysfs_path(path))
		return 0;

	free =3D get_sysfs_val(path);
	return free * page_size;
}

Could main() use get_free_hugepages(SZ_2M) >=3D HUGE_MEM_PAGES * PAGE_SIZE
instead of defining free_2m_hugepages()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104005331.5060=
0-1-griffoul@gmail.com?part=3D5
