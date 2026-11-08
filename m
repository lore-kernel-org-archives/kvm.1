Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098678;
	b=USK2G+mkrsJ/NW4ABty8c6Xs6xvApM8p5AuwJsci2YpzDpaL9YF5tNVK1/BpT/d22Lzd
	 9Q4ltQJpUPAEuHGXfCWldkridEhmbMkEJ/5NDfi4LIsJjlRV76QSk5uAIWzgqlQKDkvT6
	 UPNFyhQKboZf5A+wPf5hjuaADtN2sPt07DtIOPHT/tqsgd7giDXK4miNoVGnZjjceNLHc
	 kpoqZ+geG++lVSXaETmO38WNXXBVPGJLzLqGHc75SmW29vCZDCS9Rc1tLd00IoRxQLuby
	 GPxU+Rm+V535zLfZSFg66KdD5owOaim5K/mFcFXLiyyOc1M3poqVybWmu/Oa7lDUUCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098678;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OwHtPnW9YeN4LvnZD2FTRbt02bshB25Ve0QR6Se3vzM=;
	b=XxMov2J3aY0ibId02ReQ8UP+SSZbg2a5Cfh9jucEvsYaKyOcr+xiG4VoKpOFs3ckJyFQ
	 DBTiR6aOwK95Ro1LAmQlByDa044WUU/MOWNQ0GCYxURfVQaER2vOiPPIBm2tUsvKtfetS
	 +BkTRfAwPu6Bw/gcoJWE1lWeyoQI7YW8W4BHWQluZixseHuT46YhOs/x0BAJ+h1FnCGtZ
	 MVAt6pv06ZmN0trsBps/k5FE/Clhx+DrtEiMrG1MkukEIdulY1mV4xm1l8W2Bm3RKCEUi
	 TieGxkmou6fJT4pxuUJE3BfDw3SChKZej3xb284cqqphU2HtwK5GbR0VL7hD2phxOdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzQOnuAI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9344A606A33F
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzQOnuAI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B721F008A2;
	Sun,  8 Nov 2026 00:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098678;
	bh=OwHtPnW9YeN4LvnZD2FTRbt02bshB25Ve0QR6Se3vzM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FzQOnuAItpvcW0OQIMbLVlUO9HeuNn1hV1G2JaHYA6EFfWkCbEattbssdlGFnVuVW
	 jqPOUcdV2rmEC9csgoIeGGlIk81a0j6PHvATkQ3K5YjSgjwTZhx3beawTRHaGMJqoE
	 7wnBPqwuttu7cipbvMsy7Y/nUKu0WkKqhPQkMIKT/25ifg6p1EknTYrxrlG9r1XhGa
	 LJjg2xfb1rykmZbcF/2IAyqlVE8xSU3kvHCFXpCASHe2p00XEfStmp6l0o6TEMfbXE
	 2NI7EIg69G0CM/FoRaOFPb9Q8c3WSqXbb6+Skagc7JYT5XFySalMU0Mp7jHbFP+YBz
	 fcXDDBt4y2DvQ==
Message-ID: <sashiko-outbox-203489@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 78/88] KVM: selftests: Verify VFIO access
 directly and via guest_memfd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>, "Alexey Kardashevskiy" <aik@amd.com>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, "Fred
 Griffoul" <fgriffo@amazon.co.uk>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jianxiong
 Gao" <jxgao@google.com>, "John Starks" <John.Starks@microsoft.com>, "Michael
 Roth" <michael.roth@amd.com>, "Paolo Bonzini" <pbonzini@redhat.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Sean Christopherson" <seanjc@google.com>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, "Tarun Sahu" <tarunsahu@google.com>, "Vishal
 Annapurve" <vannapurve@google.com>, "Xu Yilun" <yilun.xu@linux.intel.com>, "Fuad
 Tabba" <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261106-gmem-alternative-providers-v3-78-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-78-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:37 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] KVM: selftests: missing SW_PROTECTED_VM cap check in
  guest_memfd_vfio_setup()
- [Low] KVM: selftests: misuse of TEST_REQUIRE() in
  guest_memfd_vfio_setup()
--

commit 228d91c74f669cf39c584f55bf33a2c0818a27c4
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Verify VFIO access directly and via guest_memfd

This commit extends the VFIO igb selftest with fixture variants to test BAR
access, mmap, and device reset both directly via the VFIO descriptor and via
a guest_memfd resource descriptor.

> diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c b/to=
ols/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
> index 91cba359e4392..03c324f7f618d 100644
> --- a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
> +++ b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
[ ... ]
> @@ -123,12 +145,50 @@ FIXTURE_SETUP(guest_memfd_vfio)
> =20
>  	bind_args.argsz =3D sizeof(bind_args);
>  	bind_args.iommufd =3D self->iommufd;
> +	if (variant->use_gmem)
> +		bind_args.flags =3D VFIO_DEVICE_BIND_FLAG_CTRL_ONLY;
> +
>  	ret =3D ioctl(self->vfio_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind_args);
>  	ASSERT_EQ(0, ret);
> +
> +	/*
> +	 * Create a SW_PROTECTED_VM with 1 runnable vCPU allocated for memslot0
> +	 * and stack/page table allocation, so guest_mapping can execute vCPUs
> +	 * and FIXTURE_TEARDOWN uniformly cleans up self->vm across both varian=
ts.
> +	 */
> +	self->vm =3D __vm_create((struct vm_shape){ .mode =3D VM_MODE_DEFAULT,
> +						  .type =3D KVM_X86_SW_PROTECTED_VM },
> +			       1, 0);

[Severity: Medium]
Does creating a KVM_X86_SW_PROTECTED_VM unconditionally here cause a
regression when the kernel is built with CONFIG_KVM_SW_PROTECTED_VM=3Dn or
booted with TDP MMU disabled?

Without checking kvm_check_cap(KVM_CAP_VM_TYPES) &
BIT(KVM_X86_SW_PROTECTED_VM) first, KVM_CREATE_VM returns -EINVAL and
vm_open() aborts via TEST_ASSERT(), failing all tests in both the
guest_memfd and direct variants instead of skipping when the VM type is
unavailable.

> +
> +	if (variant->use_gmem) {
> +		uint64_t gmem_flags =3D GUEST_MEMFD_FLAG_USE_RESOURCE |
> +				      GUEST_MEMFD_FLAG_PFN_MODE |
> +				      GUEST_MEMFD_FLAG_MMAP |
> +				      GUEST_MEMFD_FLAG_INIT_SHARED;
> +		uint64_t gmem_size =3D (uint64_t)VFIO_PCI_NUM_REGIONS << VFIO_PCI_OFFS=
ET_SHIFT;
> +
> +		/*
> +		 * guest_memfd providers (including VFIO) is only intended to be
> +		 * used with gmem_in_place_conversion.
> +		 */
> +		TEST_REQUIRE(kvm_has_gmem_attributes);

[Severity: Low]
Should this use SKIP(return, ...) instead of TEST_REQUIRE()?

Because kselftest_harness.h calls ksft_reset_state() in the forked child
before running FIXTURE_SETUP(), TEST_REQUIRE() calls ksft_exit_skip() with
ksft_plan =3D=3D 0, which prints a nested "1..0 # SKIP" plan line in the mi=
ddle
of the TAP stream and leaves _metadata->results->reason empty so the harness
reports "# SKIP unknown".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D78
