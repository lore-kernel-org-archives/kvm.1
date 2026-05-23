Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9631E8826
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 01:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779500159; cv=none; b=qFuE1phfwlOWp2TI9IFpNVAsSrCK7Oh21Gpa2SrlkffbxjN5XssmTs/+KrPmubxt6fe3YfYAYClI7mlfCrpMmgIkEhvwcvvesp0r0UNnjiE0auVXHdIjiKZOlJa7hwwC5P5jr7mSmSY5WYoHMopmwF3YMeeDhMCGFb3FauD2SJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779500159; c=relaxed/simple;
	bh=V6alLVeBT8wZ9VSkMecxU6BqABpu4pKujkKL9Ztme1I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UhQJyekSXGIw7/KXD5QKzFk/cEbhMKCKl4Zd0SabDH3WovOoKOkjpQ+8TTDCjdL78ONA7dVVeCqNQNu6Lq6t0FjPyz6Lk/G7ECJp9FX5O+FgF276r0Ne/IUg6aHLY5O5nyuuEjCf1bJ1ylmAKgoYgKnbk5sX4+dxQqx1k7Txwk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjEq6ia0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjEq6ia0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE1B1F000E9;
	Sat, 23 May 2026 01:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779500157;
	bh=/KnjUOacbUzobdfsk87GjHcObAdVf7Uk68D6Q8Vqogs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RjEq6ia0E9OU81VvPn4b5sCfKb/FibE9Jj9VFZXzarI1y/TxEmXDruJMKeNpihk4E
	 A3TC+OMTRajcTFAsyoKbt2d5i+IZ/VZG9MMaiZEnTQib3AiR5Kh/HmVi1iWRq3GQ0z
	 w5m3/SvoCqKJjpaSgT5EoPYI4VR0OkE6nfq/eQMn9kHUm+iGGV/s2OToSbb+9awjw1
	 Av56ROw3SOfZTf/ofAqN5tpLvi15Z8HlzzBNqwiQ2+9kJLIUtUToFnIZBGEHcdMxvs
	 zOlGKXI4aC7yDKuRR2hHPdyo+UjH6OghI3Xtkf3IK3taFpNmtrthjuRPdklYO+VJqH
	 JGUjWJehYD8og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 37/42] KVM: selftests: Provide common function to set
 memory attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260522-gmem-inplace-conversion-v7-37-2f0fae496530@google.com>
References: <20260522-gmem-inplace-conversion-v7-37-2f0fae496530@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 01:35:57 +0000
Message-Id: <20260523013557.8DE1B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unconditional assumption of guest_memfd usage based on a global =
capability check causes tests to crash.
--

commit a0935ebe20b0373676b5a8f369fcf1ea1cccf215
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Provide common function to set memory attributes

This commit introduces vm_mem_set_memory_attributes() to handle setting
memory attributes for a range of guest physical addresses, whether via
guest_memfd or VM-level memory attributes. It refactors existing shared
and private setters to use this new function and updates the size
parameters to size_t.

> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testi=
ng/selftests/kvm/include/kvm_util.h
> index e9b4ae9596e05..a86418cdf5f4f 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h

[ ... ]

> +static inline void vm_mem_set_memory_attributes(struct kvm_vm *vm, gpa_t=
 gpa,
> +						size_t size, u64 attrs)
> +{
> +	if (kvm_has_gmem_attributes) {
> +		gpa_t end =3D gpa + size;
> +		off_t fd_offset;
> +		gpa_t addr;
> +		size_t len;
> +		int fd;
> +
> +		for (addr =3D gpa; addr < end; addr +=3D len) {
> +			fd =3D kvm_gpa_to_guest_memfd(vm, addr, &fd_offset, &len);

[Severity: Medium]
Does this unconditionally assume the memslot uses guest_memfd if the host
supports KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES?

Since kvm_has_gmem_attributes is a global capability check, it doesn't
guarantee the specific memslot was created with the KVM_MEM_GUEST_MEMFD
flag. For example, test_private_access_memslot_not_private() in
private_mem_kvm_exits_test.c explicitly creates a memslot with flags =3D 0
and then calls vm_mem_set_private().

Calling kvm_gpa_to_guest_memfd() here will trigger its internal TEST_ASSERT
verifying the region flags, which causes the test to crash and breaks
bisection.

(Note: I see this is fixed later in the patch series by updating the test
to skip when per-gmem attributes are active, but pointing this out since it
breaks intermediate bisection.)

> +			len =3D min(end - addr, len);
> +
> +			gmem_set_memory_attributes(fd, fd_offset, len, attrs);
> +		}
> +	} else {
> +		vm_set_memory_attributes(vm, gpa, size, attrs);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-gmem-inpla=
ce-conversion-v7-0-2f0fae496530@google.com?part=3D37
