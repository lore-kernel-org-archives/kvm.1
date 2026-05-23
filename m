Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12AE175A98
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779496945; cv=none; b=ifhf5HFwV1g/BYqyaEED2vqlLgdH06Iu2scSiLnuydCdDKziORLeBT56FLxsV9fMpArdPf6VVujizBN3m/TGXo7aPxO19Gd0Q2uwNmmYoc+30xgLSFMWbDCG59amj9OMeZspoJrE07RF+czaCxK4nlztWk0YwLPk/ZdSZjTV3CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779496945; c=relaxed/simple;
	bh=O36hjmOwF1pgqw5Xs1Mqu+2PyeIwThfxOQwzGXZjOuc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eG8StyeVzC+rAfoGVi8Z2dtAE4bModlYmvDOwk5YJ8aR2HZgc2zIdGwCIYFxF12HR2ruhGBcl7OzCsuOgkRG4AymqFNbAgDff2OTQ8Ps6ou5KTDO6API8pzPd6i9szpcPeAz/i34Yx9x+BQV9Lpn3B3dYJ7Qz64LLZ1Rt1Dqvo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bf6/dhyM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bf6/dhyM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446AF1F000E9;
	Sat, 23 May 2026 00:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779496943;
	bh=LwRRzzRoh+/n0mb/6melE4Xf3erhNn7Hk7syHdvJh5M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bf6/dhyMk+HVPg8232EEXpudlSKvFL0RYY0B0OadgAo4UzJHbNr4YcMR1A+3hCHtY
	 DUhjiq/LYEwcQ4RqphKg7wbJqVI33f2yenTUfwlacM+S+TkVOGrzIajGUgcdcdnGGi
	 lYF4v5hMILFqTQAYQ4i6zBjvp2qPvtzm65pidAGxc14X68oGjDIXKW99OS7D/k1r3w
	 X6RlCPY/4Omn6TqVd9ADXezTOzV6+N+Dr0TY7gDRtnDPCddUDgDn5Ot4JZflRUjtBZ
	 W0lo/7rZgkq9A1xSiGyhMKRZVagr4/RVxccERMJE2TdOTY1ZhLbr0Pz78kTc2yYoc2
	 eMgnFiai+P1gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 26/42] KVM: selftests: Add helpers for calling ioctls
 on guest_memfd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260522-gmem-inplace-conversion-v7-26-2f0fae496530@google.com>
References: <20260522-gmem-inplace-conversion-v7-26-2f0fae496530@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 00:42:22 +0000
Message-Id: <20260523004223.446AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The size parameter in `vm_set_memory_attributes` and the new `gm=
em` helpers was defined as `size_t` rather than `u64`, risking silent trunc=
ation of guest memory sizes on 32-bit platforms.
- [Medium] `gmem_set_memory_attributes` invokes `kvm_check_cap` directly, w=
hich incurs heavy system call overhead on every invocation and incorrectly =
validates the capability attributes.
--

commit 89dd80303d47a776c6d340afaf265966a073bd73
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Add helpers for calling ioctls on guest_memfd

This commit adds helper functions to kvm_util.h for executing ioctls on a
guest_memfd. It introduces standard macros like gmem_ioctl and functions for
setting memory attributes. It also refactors supported attribute checks into
a new TEST_ASSERT_SUPPORTED_ATTRIBUTES macro.

> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testi=
ng/selftests/kvm/include/kvm_util.h
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
[ ... ]
>  static inline void vm_set_memory_attributes(struct kvm_vm *vm, gpa_t gpa,
> -					    u64 size, u64 attributes)
> +					    size_t size, u64 attributes)

[Severity: Medium]
The KVM UAPI structures like kvm_memory_attributes use __u64 for the size
field because guest physical memory regions can exceed 4GB. Since wrappers
like vm_mem_set_private() accept u64 sizes, does changing this parameter to
size_t risk silent truncation of guest memory sizes on 32-bit platforms?

>  {
>  	struct kvm_memory_attributes attr =3D {
>  		.attributes =3D attributes,
[ ... ]
> +static inline int __gmem_set_memory_attributes(int fd, u64 offset,
> +					       size_t size, u64 attributes,

[Severity: Medium]
Will this size_t parameter similarly truncate memory sizes greater than
4GB on 32-bit platforms, causing the ioctl to operate on incomplete memory
ranges?

> +					       u64 *error_offset)
> +{
[ ... ]
> +static inline void gmem_set_memory_attributes(int fd, u64 offset,
> +					      size_t size, u64 attributes)
> +{
> +	struct kvm_memory_attributes2 attr =3D {
> +		.attributes =3D attributes,
> +		.offset =3D offset,
> +		.size =3D size,
> +		.flags =3D 0,
> +	};
> +
> +	TEST_ASSERT_SUPPORTED_ATTRIBUTES(attributes);
> +
> +	__TEST_REQUIRE(kvm_check_cap(KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES) > 0,
> +		       "No valid attributes for guest_memfd ioctl!");

[Severity: Medium]
The kvm_check_cap() function performs open, an ioctl, and close on /dev/kvm
every time it is called. Since gmem_set_memory_attributes() might be called
repeatedly in loops over multiple memory regions, will this incur significa=
nt
syscall overhead and degrade test performance?

Additionally, this merely verifies that the capability bitmask is non-zero.
Should this perform a bitwise validation against the requested attributes to
ensure the specific attributes requested are supported, rather than passing
the check and later crashing the test with -EINVAL from the ioctl?

> +
> +	gmem_ioctl(fd, KVM_SET_MEMORY_ATTRIBUTES2, &attr);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-gmem-inpla=
ce-conversion-v7-0-2f0fae496530@google.com?part=3D26
