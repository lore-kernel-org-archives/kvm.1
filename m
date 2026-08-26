Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89F048989D
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780017; cv=none; b=SFpzTlnQkU+8hEpMSPujuwYvy3/a2KtDHEqoiT816cHZqAJKagEAm/MHQripLcpDHZqQUtXX+thG329FCt5krwOxX/qtY0NILJgRyV32wpDUDQEjo6u7I4MxwgiAz884G0ZSVd0aU1bT1Tk/Vhi0GoyqEj9EvWhOC86jDffMSYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780017; c=relaxed/simple;
	bh=uY9cS0I6zAzQMoUTO3/Ycze8wv5cMh6WhS1ycRoG2/A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BhJ+rQSLcfaUNWim4ztfuZha28xK2RLxo0tYrHqRJdvU8lECujdnA8fvGwABTKFLCdOylspgujKUjwH6W7uFw3Z3DMiAcuItmLsUc1d+SYUb7elxz3dDc1uDEkv73CDNom6QtecXqKPs9wjdOU0tMIB85UQUdK6F567zkw5g1bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWsPH/0h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWsPH/0h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480441F000E9;
	Wed, 26 Aug 2026 21:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787780002;
	bh=0Blbz231a2qfBh1C+pZvqWulriD5FiWfboK8Lczqb+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DWsPH/0hy3qpod0zu9+WIUnEG0JQpmJwWPa8VCfTdZvTaTV3Hg+u2OG/EInkZNV3L
	 jZBhQQUqO5U7LLPXEdQSUZox+Ib7XSVxeYLk8mi9/HU3rfQWMM95tdhwaUyf3tfen5
	 ibQ+k5kcgSJVeMOWjjIZeTFxMb36jBUKg2Q2ZEXpqspmYcWIZt/TWcsLvs/C6LvEZ+
	 9aecbnqHPxPq2L4pciMJ0yKyd7JR+XYMb+esMZ5eve1pKH5c6lCN9+bKgcYATfFYiI
	 k5jiNkN7CXAMph1YwQd04VJsvMlDkOz9hEHSozAsESfrrTQ7+TnSUryz66z17LYuTP
	 eWgFxor0x8ZNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has
 EFER.LMA=1 && EFER.LME=0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260826211844.884951-2-seanjc@google.com>
References: <20260826211844.884951-1-seanjc@google.com>
 <20260826211844.884951-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 21:33:21 +0000
Message-Id: <20260826213322.480441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] svm_set_nested_state() leaves the vCPU in an inconsistent nested s=
tate if nested_svm_load_cr3() fails.
--

commit c04793c5ea54cf0af42f1998cd2e7c8148705788
Author: Sean Christopherson <seanjc@google.com>

KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has EFER.LMA=3D1 && EFER.LME=
=3D0

Reject KVM_SET_NESTED_STATE if the incoming L1 host state has an
impossible EFER combination of LMA=3D1 but LME=3D0. This prevents KVM from
consuming the illegal state when constructing the shadow MMU for L2.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 73f37b050d0a0..49fb10ad1f9f6 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -2028,6 +2028,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vc=
pu,
>  	if (!(save->cr0 & X86_CR0_PG) ||
>  	    !(save->cr0 & X86_CR0_PE) ||
>  	    (save->rflags & X86_EFLAGS_VM) ||
> +	    ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)) ||
>  	    !nested_vmcb_check_save(vcpu, &save_cached, false))
>  		goto out_free;
> =20

[Severity: High]
This isn't a bug introduced by this patch, but looking further down in
svm_set_nested_state(), does this code leave the vCPU in an inconsistent
state if nested_svm_load_cr3() fails?

arch/x86/kvm/svm/nested.c:svm_set_nested_state() {
...
	ret =3D nested_svm_load_cr3(&svm->vcpu, vcpu->arch.cr3,
				  nested_npt_enabled(svm), false);
	if (ret)
		goto out_free;
...
}

If nested_svm_load_cr3() fails, the function jumps to out_free and returns
an error without unwinding the guest mode state transitions that occurred
earlier in the function.

The vCPU is left in guest mode with svm->vmcb pointing to vmcb02, but the
MMU is not re-initialized for the nested guest because it returns before
calling kvm_init_mmu().

Will a subsequent KVM_RUN ioctl attempt to execute the vCPU with mismatched
VMCB and MMU state?

Could an unprivileged host userspace process trigger this intentionally to
corrupt KVM internal state and crash the host?

For example, could userspace call KVM_SET_CPUID to set a high MAXPHYADDR,
call KVM_SET_SREGS with a CR3 near that limit, and then call KVM_SET_CPUID
again to lower MAXPHYADDR? This would make the previously set vcpu->arch.cr3
illegal, causing nested_svm_load_cr3() to fail its kvm_vcpu_is_legal_cr3()
check and return -EINVAL during KVM_SET_NESTED_STATE.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826211844.8849=
51-1-seanjc@google.com?part=3D1
