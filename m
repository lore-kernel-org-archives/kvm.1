Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D22E125A0
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 01:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779498474; cv=none; b=S7Zl0H3HgwKCW44amj7LoMo59wo010EXvawb3oIqiq6lB4Mxcs4EIzgHXB3f1wAyxPmrEhn3E7t+zwPEGQaYa3MGvHhrH2zCiy45ChtATBzebr7io50I/g623p8XIKxNakB+U7/vGcF/kSvQUTxZFMvwTik4z7k7JPpGX6v+MIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779498474; c=relaxed/simple;
	bh=y1hC983bYdjNf8xPwxL3cHThvEQvjGej2+uTxS9jiXc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RZFi7QpJF5TNVlS4lS9PqFfzC8pFaakq6cSxQ1nsx4xc52JE3P6p60K8cvA7N+YGHSFknkzDvJc1VRSqMwHDaSAHmqcUkHEgpxt0QlpAfaMeC7+cmE/ywe07cMcJwsyxfiM+vWGN5C3kEZYYW1eBVK3H2+X8m3uXDBc4P1YpnSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0PYBj0d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0PYBj0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7AF1F000E9;
	Sat, 23 May 2026 01:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779498472;
	bh=am6Osyji1Xkj6LdPUNfrf3HcYOTosTOEACY3RFM933Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j0PYBj0d3YsGmHofn4x9JuqN6QxbxUu7Jy7nc4N+QK0ijPtuSTJ0DcOtuGF8kKB+d
	 jJGu6Z3pVfZNgbdWL3sHp3n+z0fosvHrER8pp8lMkjBb+7VdSMP7egO6IB/o/MpnjH
	 f5FD3WsMm0pe/hM43ST2vrNBYudkxHJhvaSCJmFJfksNAOmPDnsGa+nGyD18FDkYX8
	 lSViiWTdAQbHx/0C40Ly5+XV89AXNSliMqeHi3aO4cS/NT2k5K6GeA8mezzc1CP+/V
	 rUcOKjqbH6CQajat9//aG4e2tjc2Q4eZCG0RghRKWYZP54NxKyTgj0XyHgxiz0NLly
	 SpYgmqO7O19mQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 21/42] KVM: TDX: Make source page optional for
 KVM_TDX_INIT_MEM_REGION
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260522-gmem-inplace-conversion-v7-21-2f0fae496530@google.com>
References: <20260522-gmem-inplace-conversion-v7-21-2f0fae496530@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 01:07:52 +0000
Message-Id: <20260523010752.CA7AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Uninitialized host kernel memory is disclosed to TDX guests wh=
en performing in-place population.
--

commit 38e76d2ce3c699d4b64b580ab16a7b4cbc2b189a
Author: Ackerley Tng <ackerleytng@google.com>

KVM: TDX: Make source page optional for KVM_TDX_INIT_MEM_REGION

Update tdx_gmem_post_populate() to handle cases where a source page is not
explicitly provided. Instead of returning -EOPNOTSUPP when src_page is NULL,
default to using the page associated with the destination PFN, allowing
in-place memory conversion.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
[ ... ]
> @@ -3116,8 +3116,12 @@ static int tdx_gmem_post_populate(struct kvm *kvm,=
 gfn_t gfn, kvm_pfn_t pfn,
>  	if (KVM_BUG_ON(kvm_tdx->page_add_src, kvm))
>  		return -EIO;
> =20
> -	if (!src_page)
> -		return -EOPNOTSUPP;
> +	if (!src_page) {
> +		if (vm_memory_attributes)
> +			return -EOPNOTSUPP;
> +
> +		src_page =3D pfn_to_page(pfn);
> +	}

[Severity: Critical]
Can this sequence lead to uninitialized host memory being exposed to the gu=
est
if the guest_memfd folio has not yet been populated?

When KVM_TDX_INIT_MEM_REGION is called with a NULL source_addr,
__kvm_gmem_populate() attempts an in-place conversion. If the target
guest_memfd folio is unpopulated, __kvm_gmem_get_pfn() allocates a new folio
using GFP_HIGHUSER, which lacks __GFP_ZERO.

Because __kvm_gmem_populate() bypasses the normal kvm_gmem_get_pfn() zeroing
path (where clear_highpage() is called for !folio_test_uptodate()), the
allocated page contains uninitialized host memory.

Since src_page is set to the same physical page here, will the TDX module
read this uninitialized host memory using the host KeyID and encrypt it into
the guest's private memory space during the TDH.MEM.PAGE.ADD SEAMCALL?

Could a malicious unprivileged VMM exploit this regression by passing a NULL
source_addr on an unmapped guest_memfd region, causing arbitrary host kernel
memory to be disclosed to the TDX guest?

> =20
>  	kvm_tdx->page_add_src =3D src_page;
>  	ret =3D kvm_tdp_mmu_map_private_pfn(arg->vcpu, gfn, pfn);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-gmem-inpla=
ce-conversion-v7-0-2f0fae496530@google.com?part=3D21
