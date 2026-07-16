Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE19F346A0C
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227336; cv=none; b=H7oxIC2aYgRJY9c8j+NDPtt+xItC+DEzkMN9CTviVXkWBtKKT++LvMbsETdYUfIL5SjyRDM+RD49xnGc3GgHH6Neqx+p1RnsRUZyJRraGRdsIlpDQLnkq6f5J5NOLi63vQ8ur17i4Ux0E/ebl2JAUAKww9MQp5U7tfDYCyxknZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227336; c=relaxed/simple;
	bh=cS3YOcQNymVM+5eDftFBzr+Eiu6SRAP8/LOjmzJXNnM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jioEZVPy5J8EVd6Rr06RWIao4jmUx4eOhSCZugy6yMQODGNr4rDCubY8K7qIZHsb4JYn0b4EqHmo0bNhwOUg4T6y23BebVcthtHVDShp6Q/jMOk9gRQrHOlMMgZwImymcjRV/KqTYjzAfmCPpRk/V9TVAtqbOGF78Azrtn7Yznk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmF1O6cv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmF1O6cv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA881F000E9;
	Thu, 16 Jul 2026 18:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784227334;
	bh=H3Xb1k3M0yXIRP85rZMw12UEZtAQikJx1iPgSWsFg/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gmF1O6cvC67cQInFrJS91wLJ4XfBAMqqB1CksfZcM8ceU9FDIWvkhO06pgbfqZfax
	 eAOMaxPHC1u8aTgJ2Ilxd70xTZ61guHFk9wvLdBxhdR4W98zUcxiFd71OANURotbsf
	 +OBJJNib1DswJDRb1Au+Te4jHcpLARI0X9HCUBqigdq6Nr9TPi9YiSU0fHBNB/0P9K
	 OgylClpCNJ/wpSYSCINq6wwGJvQQXbSNGo5X+vw1N8ct4Bqynj+eoWZ6oYSeVDLeE1
	 yLiSXzRoyu9rxNzU8YndNfWVXpdL+aJLwRgrEe1NfVrv65TfghdUSn+L5yVL0f9oSJ
	 gCdN7C2i1BySQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 22/24] KVM: x86: selftests: Introduce memory attributes
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716181456.402786-23-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
 <20260716181456.402786-23-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:42:14 +0000
Message-Id: <20260716184214.AAA881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Massive unintended memory allocation in the memory attributes te=
st.
- [Medium] Masked validation test for unsupported KVM_SET_MEMORY_ATTRIBUTES=
 flags.
--

--- Patch [22]: [PATCH 22/24] KVM: x86: selftests: Introduce memory attribu=
tes test ---
commit 4443977bb70263dd7f96620eede82bb13ee6a48d
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: x86: selftests: Introduce memory attributes test

This commit introduces a new selftest for the KVM_SET_MEMORY_ATTRIBUTES
ioctl. It tests various memory attribute combinations, MMIO access handling,
and input parameter validations.

> diff --git a/tools/testing/selftests/kvm/memory_attributes.c b/tools/test=
ing/selftests/kvm/memory_attributes.c
> new file mode 100644
> index 0000000000000..7066ae791b99a
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/memory_attributes.c

[ ... ]

> +static void test_input_validation(struct kvm_vm *vm)
> +{
> +	uint64_t flags, gpa =3D 0, size =3D 0, attrs =3D 0;
> +	int rc;
> +
> +	/* 'flags' is unsupported */
> +	flags =3D BIT(0);
> +	rc =3D __vm_set_memory_attributes(vm, gpa, size, attrs, flags);

[Severity: Medium]
Could this validation test pass for the wrong reason?

Because size is initialized to 0, the ioctl will return -EINVAL even if the
kernel's validation for the flags parameter is broken or missing. Setting
size to a valid, page-aligned non-zero value here would ensure this check
actually isolates and verifies the rejection of unsupported flags.

[ ... ]

> +int main(int argc, char *argv[])
> +{
> +	uint32_t guest_page_size =3D vm_guest_mode_params[VM_MODE_DEFAULT].page=
_size;
> +	unsigned int ptes_per_page =3D guest_page_size / 8;
> +	size_t size =3D guest_page_size * ptes_per_page * 2; /* 2 huge-pages */
> +	struct kvm_vcpu *vcpu;
> +	gva_t test_mem;
> +	struct kvm_vm *vm;
> +
> +	TEST_REQUIRE(kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES) &
> +		     KVM_MEMORY_ATTRIBUTE_NO_ACCESS);
> +
> +	vm =3D __vm_create_with_one_vcpu(&vcpu, size, guest_code);

[Severity: Medium]
Does this code inadvertently request a massive amount of memory?

The size variable is calculated in bytes (e.g. 4 MB), but it is passed to
__vm_create_with_one_vcpu() which expects the second parameter to be a page
count (extra_mem_pages). Passing a byte count directly causes the test to
request millions of extra pages for page tables (e.g. 16 GB), which could
lead to test failures due to ENOMEM on systems with stricter overcommit
limits or insufficient free memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716181456.4027=
86-1-pbonzini@redhat.com?part=3D22
