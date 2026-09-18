Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E0C340283
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719879; cv=none; b=PfEEBr4uPMToFQwagMH1WzrZTEY2i9pSiyYDlPL8d2TIpV6fpwdWRKHTxCTm0PIGPKx26F/bcULCERxZ8F1WJqdbXm9HUJyWlMm81xJhXYxgASpHNHU8Wr7EM4j6FIyeemv0BEbL9idPmw2n8HhzhN0HU4rtqBHLHPlL14IjDAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719879; c=relaxed/simple;
	bh=tj5FjeKq8cnNfSnpfo+JO1fAyfDxnGpFfHghWgAsilU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SH4Mpe3nnEDZo3L/AnZ6Etije/PjMntVQS8CPIvK+YvJVjDMxImQJgfVkGPJAidSws5sBlfGuCkEJ38rIvQZneriQzsW7gFaDzuxFWFLxzzpcvYZrl7IzpCk1bE9GKVZZBQ5SPAaggxeS6svH1N3E2J9RNG05XWIudTvA4jhT/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ey9OhRBG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ey9OhRBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A301F000FF;
	Fri, 18 Sep 2026 08:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789719877;
	bh=YF2mcmEu4nWEZsWNK9Qn/fqi7AR/1cVA7v24LSO6I4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ey9OhRBG4Jf83hIKfwPTPXI3IpbR3EW1ei8PMu3tOZ2dtvoPg91g2p1tRXDLX26+B
	 AhpULB6hsGpypEmomVVxr8sPzx3H30EcfYJ0HhbXizK4VD50ebfETSLpqkfabxAvRp
	 IcgYvjSV00jLMHruXmiktYfP0SUGi88cLSZmLongQE3J4WXGQKmjFrB8c334dG90AS
	 +YD8LU7ocJr+Oj418isisTr8ckoUoeohCsNJfQEJzuGBJgTnAnIZVXYLLsG3/XXysf
	 AEACpZ9DHhIH3KvwtjJlauUOPvyDyCB+KQ2Zo40J03HGxScLK3Dhw8/zuWOzjaHvc3
	 bOQVRk8xEmXaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/28] KVM: selftests: test hypercall memory fault
 exits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918081543.139871-7-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
 <20260918081543.139871-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:24:37 +0000
Message-Id: <20260918082437.C7A301F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] kvm: selftests: host OOB write in test_readonly_input()
- [Medium] kvm: selftests: missing read-only memory map in test_clock_pairi=
ng_fault()
--

commit 363dccb0211d2629dd610b0d28c041e51635155e
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: selftests: test hypercall memory fault exits

This commit introduces selftests for KVM hypercall memory faults. It verifi=
es
that hypercalls with invalid or read-only guest physical addresses exit to
userspace correctly.

> diff --git a/tools/testing/selftests/kvm/x86/hcall_fault.c b/tools/testin=
g/selftests/kvm/x86/hcall_fault.c
> new file mode 100644
> index 0000000000000..63e38c87616f9
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/hcall_fault.c
[ ... ]
> +/* Read-only hypercalls, read-only inputs, valid/invalid argument */
> +static void test_readonly_input(void)
> +{
> +	struct hv_tlb_flush *flush;
> +	struct hcall_test *test;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	gpa_t hcall_page;
> +
> +	vm =3D create_vm(&vcpu, &test, &hcall_page);
> +	flush =3D (struct hv_tlb_flush *)&test->readonly_data;
> +	flush->flags =3D HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES | HV_FLUSH_ALL_PRO=
CESSORS;
> +	flush->processor_mask =3D 0;

[Severity: Medium]
Will this result in an out-of-bounds host memory write?

The test allocates two separate 1-page memslots for TEST_MEM_GPA and
READONLY_GPA. In the guest, they are mapped contiguously to test_gva. Howev=
er,
create_vm() gets the host virtual address of only the first page and assigns
it to the test pointer.

By accessing test->readonly_data, does this write past the 1-page host
allocation of the first memslot?

> +	test->control =3D HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE;
> +	test->ingpa =3D READONLY_GPA;
> +	test->outgpa =3D UNMAPPED_OUT_GPA;
[ ... ]
> +static void test_clock_pairing_fault(bool readonly)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	gpa_t gpa;
> +
> +	/* Unlike create_vm do not enable Hyper-V hypercalls. */
> +	vm =3D vm_create_with_one_vcpu(&vcpu, clock_pairing_guest);
> +	vm_enable_cap(vm, KVM_CAP_HCALL_FAULT_EXIT, 1);
> +	gpa =3D readonly ? READONLY_GPA : UNMAPPED_OUT_GPA;

[Severity: Medium]
When readonly is true, does this inadvertently test an unmapped write fault
instead of a read-only write fault?

Since test_clock_pairing_fault() creates a new VM with
vm_create_with_one_vcpu() instead of using create_vm(), it appears
READONLY_GPA is never actually mapped into the guest as a read-only memslot.

Will KVM treat READONLY_GPA as completely unmapped memory here, missing the
intended coverage for read-only memory faults?

> +	vcpu_args_set(vcpu, 1, gpa);
> +
> +	assert_memory_fault(vcpu, gpa, KVM_MEMORY_EXIT_FLAG_WRITE);
> +	kvm_vm_free(vm);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918081543.1398=
71-1-pbonzini@redhat.com?part=3D6
