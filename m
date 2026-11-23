Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456987;
	b=4FIK4STn/8ofWMwY0bNo5g+oEIoDLijp9f+R1yQyB/8T8sAL2fvZdByuMYtaibDXKmTB
	 aPZY8UxAGw0ipUVynYgd3u6+hCKnVXQy4XFgbgM09qfLxSuOXcVdB/E0Y3I9fkjhj3JL6
	 cF+fEjrYBkkfjUZb1uhP73/pgAdy982xtngdRxIHdD2m5lYJMWILQW/peN+7w9S8lSzEF
	 niu70dYVddu3ug8dbYqXIj/NkxeHXtb6wz7No9kPcbnUJQJyFitFGCI4fCK1ZMyqAk4KR
	 QRSQ7/AVh3XGLGLtpF3TndXW6fBwo4mZhE8+xrlkiUPEHrYHmPQOVUtSb/EKfx+Xufg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456987;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ucj5Vibk0wP4QqlCmy5tuR1KFaKoo/7/DdUDKRr8QwY=;
	b=PbXKnfI79bXjWqxCfN182Dip6wlXQN8BF7ppDH5p6dxk11VXcjoMHf61jiDSOcXAsftf
	 0PIHhnvFDBiSRSA20nncVIe7IJFY/Cj6OjOEgpyzjgJAEsuwq6i+WDjjFClnaB+L6YSgO
	 XEUGEkEsAZ/rIDo8mXFvcu6RdF4i06sU6qhoex6XkzlGKmCJASpjhVeNreskFVxJiboTu
	 8/SiDDiURn5whUL7waTbZpzJ71G+LXiQf1skMpuaEdfZ8okRA6UQ7ZUfGD6GIi84MfvQ4
	 nx5xAanPlou3EN03sq0ox2CYrTofVqPMnvUt7ol1cxXLN5JJ3Aq0lJGBJEhhVc/6rfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BoNEZdMM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DCE606A31A
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BoNEZdMM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929451F000C0;
	Mon, 23 Nov 2026 18:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795456986;
	bh=ucj5Vibk0wP4QqlCmy5tuR1KFaKoo/7/DdUDKRr8QwY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BoNEZdMMRMgTJEGzq7mOUuU4VBrcerG1+s0mIsQCJwbeWuPsB2QSIrPwDTaBpal30
	 GvFZ/CQmIXbwmcJnPNg0Q9voa8vkWcOI24Yi44Dj+DuqtyapDqmZJPEMRTeoDpH0h3
	 woKx3p1SgB4Q05UwTAyseXBVAxYvrSGKajQKoU7iMWywRghB8LIBwSXDGbnCJg3YUb
	 mdRfeIpvX5mrkBbbfEYd6u7htJ3qGH+e305MUTTBCBv7js63sR8yVc7RBZwffAKbdZ
	 3cNegV8Tk31H9vVwAO8cJqDbt2Uf+KmDTBkgwCyBRiII90EZ66bF8drLUZjwGduEc+
	 03/W+yoqGi3ZA==
Message-ID: <sashiko-outbox-229793@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] KVM: x86: split vcpu->arch.hflags into
 nested_guest_mode and smm_mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxim Levitsky" <mlevitsk@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261123175512.80438-3-mlevitsk@redhat.com>
References: <20261123175512.80438-1-mlevitsk@redhat.com>
 <20261123175512.80438-3-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 18:03:06 +0000
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
- [High] KVM: x86: build failure in kvm_vcpu_reset() when
  CONFIG_KVM_SMM=3Dn
- [Low] KVM: x86: commit log names nested_guest_mode instead of
  nested_guest_state
--

commit f779a065108faeca6cdd5ce21f760f2b6bdeb40c
Author: Maxim Levitsky <mlevitsk@redhat.com>

KVM: x86: split vcpu->arch.hflags into nested_guest_mode and smm_mode

This commit replaces vcpu->arch.hflags with separate nested_guest_state
and smm_mode fields in struct kvm_vcpu_arch.

> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 683bb8bf43a94..17308713a2904 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -735,7 +735,6 @@ struct kvm_vcpu_arch {
>  	unsigned long cr8;
>  	u32 host_pkru;
>  	u32 pkru;
> -	u32 hflags;
>  	u64 efer;
>  	u64 host_debugctl;
>  	u64 apic_base;
> @@ -755,6 +754,16 @@ struct kvm_vcpu_arch {
>  	u64 arch_capabilities;
>  	u64 perf_capabilities;
> =20
> +#define KVM_NESTED_IN_GUEST	BIT(8)
> +	/* Non zero when the guest is executing another guest */
> +	u16 nested_guest_state;

[Severity: Low]
This isn't a bug, but the commit subject and message call this field
nested_guest_mode while the code names it nested_guest_state.

> +
> +#ifdef CONFIG_KVM_SMM
> +#define SMM_MASK		BIT(0)
> +#define SMM_INSIDE_NMI_MASK	BIT(1)
> +	/* Non zero when the guest is in SMM*/
> +	u16 smm_mode;
> +#endif
>  	/*
>  	 * Paging state of the vcpu
>  	 *

[ ... ]

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index aad065d035fbb..4e515bcdc85cb 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -9558,7 +9558,8 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool ini=
t_event)
>  	kvm_lapic_reset(vcpu, init_event);
> =20
>  	WARN_ON_ONCE(is_guest_mode(vcpu) || is_smm(vcpu));
> -	vcpu->arch.hflags =3D 0;
> +	vcpu->arch.smm_mode =3D 0;
> +	vcpu->arch.nested_guest_state =3D 0;
> =20
>  	vcpu->arch.smi_pending =3D 0;
>  	vcpu->arch.smi_count =3D 0;

[Severity: High]
Does this break the build when CONFIG_KVM_SMM is disabled?  smm_mode in
struct kvm_vcpu_arch is guarded by #ifdef CONFIG_KVM_SMM, but
kvm_vcpu_reset() clears vcpu->arch.smm_mode unconditionally.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123175512.8043=
8-1-mlevitsk@redhat.com?part=3D2
