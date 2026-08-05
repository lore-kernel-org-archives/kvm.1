Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272C1632E7
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910229; cv=none; b=HcDjz5Kq4twkPB0bf+phtfhLQ0ypEpNdCJ+dk5poOh6evoEiEm/Vx612bdOU1ie4ntxCLTCBXCYOGId7Ca6xOWDMsSKq98L2idSJDqxM7XjJBx4TNhIVV26hd91lndh8XBTVgTjg7npEaZ/ovutxkPAsGyQUSyktNtvwfkra4OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910229; c=relaxed/simple;
	bh=Paqp8EbkIHa5h197COKkfCFE6yXnrLFUeTcgywkWwcg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GJCm7GcgrxeAaUSbIpaJgsWWiGq7Ee7smyEWuJmEKRjJ9/+siBg4kIGF+i/q1PatmefV/K9HCOvI73SAMiDhxLJ7PEba+wIJHavHqhXDKnlZWtzA5B+gRKoJX7nbEyyeZrWfj3sLVYia3Nu4UXWZGqf89nJHNYeCo0wq7ntcsOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQHkZUxi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQHkZUxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07741F000E9;
	Wed,  5 Aug 2026 06:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785910228;
	bh=e20HYKd+CQWO8o02qTJDMvs4LkohDWfWjsS+9iI0k2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DQHkZUxiq3o4RzFruqSUxIDlNdDMQHuLr2j83Hwovn8bjdu/npER5ui/2+1ZdltwA
	 0iv8IRc2PBZzZftuCWioY0i1VNiaIwfHguWG11Snq0TC2iB0dJZaN8iT3kSlvlCct3
	 1qkZaAxoRnF5b0PUcObG6+ZlB7X7m+7SQpWOK2xwIwYKtmPStr0+2n1LbGdK/mN0QV
	 aXke6ye6HtP9DLDRkJW/M8gaibs8LCZ5poJkSYorT4h8JUjGhrwf1xMUOToRXmdcM4
	 ziGvx/TjLBQ6YJzcJXNJs8JODA2nXVdgoEYBrXRywFeWJDvG4Eg8Yyg4wipyQOejZq
	 Pwz5Zq1Gk7pNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: selftests: verify toggling KVM_MEM_GUEST_MEMFD on
 an existing slot is rejected
Reply-To: sashiko-reviews@lists.linux.dev
To: "Valery Borovsky" <vebohr@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260805055830.740175-1-vebohr@gmail.com>
References: <20260805055830.740175-1-vebohr@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 06:10:27 +0000
Message-Id: <20260805061027.C07741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The commit message incorrectly claims that both directions of to=
ggling KVM_MEM_GUEST_MEMFD are enforced by the XOR flags mask.
- [Low] The second test case reuses a memfd and offset that are already bou=
nd, which could lead to shadowed errors if KVM validation ordering changes.
--

--- Patch [1]: [PATCH] KVM: selftests: verify toggling KVM_MEM_GUEST_MEMFD =
on an existing slot is rejected ---
commit bf15eec5cbe6f11d42dcd195f6bac07b5502de7d
Author: Valery Borovsky <vebohr@gmail.com>

KVM: selftests: verify toggling KVM_MEM_GUEST_MEMFD on an existing slot is =
rejected

This commit adds a new test case, test_toggle_private_memory_region(), to
the set_memory_region_test. It verifies that KVM rejects attempts to both
clear KVM_MEM_GUEST_MEMFD on a private slot and set it on a slot created
without it.

> Add test_toggle_private_memory_region() to close that gap. It asserts
> both directions are rejected with EINVAL:
>=20
>   1. clearing KVM_MEM_GUEST_MEMFD on a private slot;
>   2. setting KVM_MEM_GUEST_MEMFD on a slot created without it.
>=20
> Both are enforced by the flags mask in kvm_set_memory_region():
>=20
>   (mem->flags ^ old->flags) & (KVM_MEM_READONLY | KVM_MEM_GUEST_MEMFD)

[Severity: Medium]
Is this explanation entirely accurate for direction 2 (setting the flag)?

Looking at kvm_set_memory_region() in virt/kvm/kvm_main.c, setting
KVM_MEM_GUEST_MEMFD on an existing slot seems to be explicitly rejected
earlier in the function:

if (mem->flags & KVM_MEM_GUEST_MEMFD)
        return -EINVAL;

Could the commit message be updated to clarify that direction 2 is caught by
this early check before the XOR flags mask is evaluated?

> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools=
/testing/selftests/kvm/set_memory_region_test.c
> index a152ab65c6577..8fb2e7a96f6cd 100644
> --- a/tools/testing/selftests/kvm/set_memory_region_test.c
> +++ b/tools/testing/selftests/kvm/set_memory_region_test.c

[ ... ]

> @@ -500,6 +500,50 @@ static void test_add_private_memory_region(void)
>  	kvm_vm_free(vm);
>  }
> =20
> +static void test_toggle_private_memory_region(void)
> +{

[ ... ]

> +	/*
> +	 * Symmetrically, attempting to set KVM_MEM_GUEST_MEMFD on a slot
> +	 * that was created without it must also be rejected.
> +	 */
> +	vm_set_user_memory_region(vm, MEM_REGION_SLOT + 1, 0,
> +				  MEM_REGION_GPA * 2, MEM_REGION_SIZE, NULL);
> +	r =3D __vm_set_user_memory_region2(vm, MEM_REGION_SLOT + 1,
> +					 KVM_MEM_GUEST_MEMFD,
> +					 MEM_REGION_GPA * 2, MEM_REGION_SIZE,
> +					 0, memfd, 0);

[Severity: Low]
Does reusing the same memfd and offset 0 make this test unnecessarily britt=
le?

This call uses a memfd and offset that were already successfully bound to
MEM_REGION_SLOT earlier in the test function. If KVM were to ever reorder
its internal validation and evaluate kvm_gmem_bind() before rejecting the
immutable flag toggle, wouldn't this return -EEXIST due to the already-bound
range, causing a false test failure instead of the expected -EINVAL?

Would it be safer to use a fresh memfd or a non-overlapping offset to
strictly isolate the flag toggle validation?

> +	TEST_ASSERT(r =3D=3D -1 && errno =3D=3D EINVAL,
> +		    "Setting KVM_MEM_GUEST_MEMFD should have failed with EINVAL, got r=
=3D%d errno=3D%d", r, errno);
> +
> +	close(memfd);
> +	kvm_vm_free(vm);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805055830.7401=
75-1-vebohr@gmail.com?part=3D1
