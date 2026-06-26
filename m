Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD87E3F7886
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481454; cv=none; b=e8md0yKBRgFR4V7ewYJE2Gl7Ro2YHwsRceR0jnaL3r9sw/hb68IgBX0T2KcX5T7RVzBF8qNdAtuyt21TeV07hb4sEZTjQHNrWZgesQysODqH47TkYhHBl7tJH1cC9pnmp26/hOHvMOMcyqfwnddupNePEdG2iZL+/mrhEqOJz/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481454; c=relaxed/simple;
	bh=B0pUn9zddnbLjyq3tVon9eQkN0AQ1q5LVHk/Ttih18M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=USUwV0Wf6zXJHLkPtpYC2NudH3CWFgSUy+DR/kU56OPIyr2czURWJh8JOyBEf2AC/RF7l/7vCU7is54Hvi4+1EWMr7DmZdpcFhSmSrR3fsn5EsQ6NlL+XqjCSt+cxvXg8XCgxgg32AZ9PIy7eQ5Loxg76GMYGyJqNMA8eL9s1l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLe/obkO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLe/obkO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C721F000E9;
	Fri, 26 Jun 2026 13:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782481452;
	bh=QrCSXL+YYWdVLuo4pBW5bfoUtjbZAo7wRs0fIy6oYBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NLe/obkODnbBRnk/cd1aqCnJphRd3D0qontgjfyvU7tg6XzfQLFY0tLvGJFnpK70h
	 FTL+9q2aXFUKr120NOXtscCOpttq+Jv6EIBUFb7YcR7eQx1tvBog+2AqZHud0omh87
	 4DtLZdFbOxmxmFeXL8a0KvdbnP4X6FcxUvHtL0f+s2KxrwKEMq2RB1yCz8jLFii7tk
	 SMI1gItvjE1S+aIcACk6PBBW6RvaGEOflkskubERMCjl556+WH23IsasN7I3reJc/i
	 bK5sdGcf+1MUMEasFRienWo8Ycd9bV6g5NAbRVzP4+unsydKp/bWiUqbPqZRz7ZhtV
	 RagUaVkMexPdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.10.y 12/17] KVM: x86/mmu: Check PDPTRs before
 allocating PAE roots
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260626112634.1778506-13-pbonzini@redhat.com>
References: <20260626112634.1778506-1-pbonzini@redhat.com>
 <20260626112634.1778506-13-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 13:44:11 +0000
Message-Id: <20260626134412.49C721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling mmu->get_pdptr() (which can sleep) while holding the vcpu-=
>kvm->mmu_lock spinlock, leading to sleep-in-atomic bugs.
--

commit f2009072d01cd7e9d707fa7cab9918b457bec0aa
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/mmu: Check PDPTRs before allocating PAE roots

This commit adds a validity check for PDPTRs before allocating any of the P=
AE
roots. It iterates over the PDPTRs and checks if they are valid to prevent =
KVM
from leaking previously allocated roots when a bad PDPTR is encountered.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3308,7 +3308,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *=
vcpu)
>  static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_mmu *mmu =3D vcpu->arch.mmu;
> -	u64 pdptr, pm_mask;
> +	u64 pdptrs[4], pm_mask;
>  	gfn_t root_gfn, root_pgd;
>  	int quadrant, i;
>  	hpa_t root;
> @@ -3319,6 +3319,17 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu =
*vcpu)
>  	if (mmu_check_root(vcpu, root_gfn))
>  		return 1;
> =20
> +	if (mmu->root_level =3D=3D PT32E_ROOT_LEVEL) {
> +		for (i =3D 0; i < 4; ++i) {
> +			pdptrs[i] =3D mmu->get_pdptr(vcpu, i);

[Severity: High]
Does this sequence call mmu->get_pdptr() while holding a spinlock?

Looking at kvm_mmu_load(), it calls mmu_alloc_shadow_roots() while holding
vcpu->kvm->mmu_lock:

kvm_mmu_load()
    spin_lock(&vcpu->kvm->mmu_lock);
    ...
    r =3D mmu_alloc_shadow_roots(vcpu);

If the vCPU is running a nested guest (L2) with a 32-bit PAE NPT, the callb=
ack
for mmu->get_pdptr() is nested_svm_get_tdp_pdptr(). This function reads gue=
st
memory via kvm_vcpu_read_guest_page(), which can sleep.

Can this lead to a sleep-in-atomic issue when the lock is held?

> +			if (!(pdptrs[i] & PT_PRESENT_MASK))
> +				continue;
> +
> +			if (mmu_check_root(vcpu, pdptrs[i] >> PAGE_SHIFT))
> +				return 1;
> +		}
> +	}
> +
>  	/*
>  	 * Do we shadow a long mode page table? If so we need to
>  	 * write-protect the guests page table root.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626112634.1778=
506-1-pbonzini@redhat.com?part=3D12
