Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA54426431
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720482; cv=none; b=Y7w9d/baFUj+MHs4LRpjr9ahciRAIF7om5aK4PwAc5yjt+hp5c7EVlYRn81Dh2JV6XC67IK09ExjQsJqQ9/Qgo1xhta4ppzt0NpOy1FnyXqepGFElEWxpW9BwfnWjR4W3sbbhvhKLWIDV9GHNz7i5ovbNy+Dv1/SuSc3Ybbxug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720482; c=relaxed/simple;
	bh=JTPzKWnjU+8hgMWlLwBzP/vjBtZqQ69VFHiFUg+aZYg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tdPZ8a1EBrqChWaz5j0WeBjuM91fNaPORSMSj/b/FoLu6QxEkcWBgyoEDuOqIGkVHTk9HgyA32ERQc8O20J6extnFSdDwW53J3DqYXLscLcb09zxXvVpmDM0vaRBpnj25+Jb8Z1Ms8lOHBZMJVVh/UJaf9RcDLrhdc8snjekFvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV6Sbn/X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV6Sbn/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460C81F000FF;
	Fri, 18 Sep 2026 08:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789720470;
	bh=xajbterJpRr27YGpozOIMcjHssNs57dFtliakkN5mXY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eV6Sbn/XxbS1bmKgGpk3wGhDewxJjxjaAq3HGM2HimEwcU2Ky5BivIe2AvLKM39Ly
	 sZBVvF2Gd2++z0jmIgd7eM9DLFkScTBcUFIYPncMXz5TlC0xG2Q/6o/P99rdhbZqJi
	 yoz8wuCdxb5bSOsmel85NeUrsscrrtQ71qd36zjS8Z6oVgr7RnRZlYE0vRsSKGAKPj
	 ulJZr+lDjTXd33XagFd+gLNCSc+t8goErWOxfoF4ptDI6+tbnaRAtg0xPr67mSUOqB
	 +nM39SJsSS41TC/khcf97AoRHaKR2EWE2oQ6b/gYqbS4NprvklO5ocTE4GDapegLp4
	 6M8k6oR3uWz7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/28] KVM: apply nGPA->GPA translation to
 KVM_HC_CLOCK_PAIRING
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918081543.139871-5-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
 <20260918081543.139871-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:34:29 +0000
Message-Id: <20260918083430.460C81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] kvm: L2 VM escape via unaligned KVM_HC_CLOCK_PAIRING write
--

commit 852f8a2ef0b30977a5795285699a50deabf3525c
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: apply nGPA->GPA translation to KVM_HC_CLOCK_PAIRING

This commit updates KVM_HC_CLOCK_PAIRING to translate the guest physical
address from an L2 address to an L1 address when running nested.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 79468ddfe4736..2b81e7a478c45 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7217,6 +7217,11 @@ static int kvm_pv_clock_pairing(struct kvm_vcpu *v=
cpu, gpa_t paddr,
>  	clock_pairing.flags =3D 0;
>  	memset(&clock_pairing.pad, 0, sizeof(clock_pairing.pad));
> =20
> +	paddr =3D kvm_translate_gpa(vcpu, &vcpu->arch.gva_walk, paddr,
> +				  PFERR_WRITE_MASK | PFERR_GUEST_FINAL_MASK, NULL, 0);

[Severity: Critical]
Does this translation adequately handle the case where the struct crosses a
page boundary?

When kvm_translate_gpa() is called in kvm_pv_clock_pairing(), it only
translates the base L2 GPA. If an untrusted L2 guest provides an unaligned
guest physical address (for example, at offset 4033 in the page), the 64-by=
te
kvm_clock_pairing struct will span across two L2 pages.

> +	if (paddr =3D=3D INVALID_GPA)
> +		return -KVM_EFAULT;
> +
>  	ret =3D 0;
>  	if (kvm_write_guest(vcpu->kvm, paddr, &clock_pairing,
>  			    sizeof(struct kvm_clock_pairing)))

[Severity: Critical]
Could this regression lead to L1 memory corruption when crossing an L2 page
boundary?

Looking at kvm_write_guest() in virt/kvm/kvm_main.c, it writes linearly into
L1 physical address space. When a write hits a page boundary, it increments
the L1 GFN (++gfn) and continues writing to the next contiguous L1 page:

virt/kvm/kvm_main.c:kvm_write_guest() {
    ...
    while ((seg =3D next_segment(len, offset)) !=3D 0) {
        ret =3D kvm_write_guest_page(kvm, gfn, data, offset, seg);
        ...
        ++gfn;
    }
    ...
}

Since contiguous L2 pages are not guaranteed to map to contiguous L1 pages,
incrementing the L1 GFN directly could write the remainder of the 64-byte
struct into an unrelated L1 page. This appears to allow an L2 guest to
overwrite up to 63 bytes of L1 memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918081543.1398=
71-1-pbonzini@redhat.com?part=3D4
