Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436957;
	b=k3tanYLP2XkAzWVl8rt3NuC8peoVNpvoATbdcW+TTL9rEiDbVt6JwTJXYuSbr8Zkv7r5
	 q+lG8/f5oFdUy1NGXhm0md2/GOGJfdUFGKH027zywYYm9kw+i201SgRJSN2lVxef8yNFr
	 BhR+56wa50dLvFMBqp7RJcdHfFPRiN7VXZHOYls04w/rLNwxS7DpbmZ7eTd6an3YfjqKK
	 XA2PlT6lM6zOKGQxVXaA+EtLaX+Yx3meZDdph6Hxh72IIAj9cluvxg+bDnTL4rPL6Kq1I
	 O94YwwQpqiiEvWU3WvpYbsPslXCENcZf8HxAMHtW1efZ877fIodAKcQNTiRrn+TeT2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436957;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HAcShn6MNF1lV/8cU9TJTrH03OzCcG0D4QGrUNNdqP8=;
	b=lR1lPKNvbEyXkrmodgCEXkNqdK4ZyMM/2lM2YdyBughXfcyI+jDoEJmaG52EEpSshsL/
	 AmxhCBBb/gzM15PHvsdUWpdOMPhOZ4NRE55QdSh397SwZb4T8gdrI88pb3ivzKwPoKxkC
	 SFZHxiy+wIqMKSvSwU3pbvtkqDfxUE1gtg61euRktSdCHbxUGn+rT4T6GIcMqxFz08pIK
	 BnuC0ZakSMU+xE0sz3pppOuvb76dFJulpgjCIKSPeXHMSlALkbtq6OC79/VePornfAVh1
	 62XsBDaYipnqY8rZRyCKPTnj09wY1UbRHE1lO1hTB5O2fQ5ajYmfffWNLJ0fis2cUag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WmR1/mCF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50E9606A31A
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WmR1/mCF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592C51F000CF;
	Mon, 23 Nov 2026 12:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795436957;
	bh=HAcShn6MNF1lV/8cU9TJTrH03OzCcG0D4QGrUNNdqP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WmR1/mCFP3t0SPjJJYOVZrn2Cj6SK+ijkG5KWwZznKc3O6UHKrzmA9NfHH1IRV8vw
	 +sYbEer1AxufludBFGKaNWladpdau2E0xvHqP+t7lOpmlKIp7fNIG42WSwOLBU1JE8
	 RDvVGb4may+wJx0x3prUm2jHQvPskSnx1XfhDUDQqiu9slbL6YcvKP2jEuljrav6dn
	 Zl6TyyYJbbSrmrbYOObpybK/iuoYzgKDO0zuJkm6n+YjoaRSOr6vjtwH9Vo2js3Tp0
	 yqEv0E4VoCeyWKWOuG7+hDcYBGnU6ODZx9sAYv/CPSKwBN5c2+241BL8uBSgYwnXJT
	 Tiyz1GRrFtVXw==
Message-ID: <sashiko-outbox-229217@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y 2/4] KVM: Return an "unsigned long", not "u64"
 for the fixed-1 DR6 bits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Baoli Zhang" <baoli.zhang@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261123121427.2803358-3-baoli.zhang@linux.intel.com>
References: <20261123121427.2803358-1-baoli.zhang@linux.intel.com>
 <20261123121427.2803358-3-baoli.zhang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 12:29:16 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] KVM: x86: missing DR6 fixed-1 bit enforcement in
  KVM_SET_DEBUGREGS [1]
--

commit 6ea58ce45be6bc8f3686d6726ca7358f4937978d
Author: Sean Christopherson <seanjc@google.com>

KVM: Return an "unsigned long", not "u64" for the fixed-1 DR6 bits

This commit changes the return type and local variable of
kvm_get_dr6_fixed_1() from u64 to unsigned long to match the natural
width of debug registers.

Link: https://patch.msgid.link/20260930193634.3415089-4-seanjc@google.com

> diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
> index 3cd1fb8fb09ad..7556eee700029 100644
> --- a/arch/x86/kvm/regs.c
> +++ b/arch/x86/kvm/regs.c
> @@ -679,15 +679,16 @@ void kvm_update_dr7(struct kvm_vcpu *vcpu)
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_update_dr7);
> =20
> -static u64 kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu)
> +static unsigned long kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu)
>  {
> -	u64 fixed =3D DR6_FIXED_1;
> +	unsigned long fixed =3D DR6_FIXED_1;
> =20
>  	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_RTM))
>  		fixed |=3D DR6_RTM;
> =20
>  	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
>  		fixed |=3D DR6_BUS_LOCK;
> +
>  	return fixed;
>  }

[Severity: Critical]
This problem wasn't introduced by this patch, but can
kvm_vcpu_ioctl_x86_set_debugregs() and kvm_deliver_exception_payload()
leave dynamically fixed-1 bits cleared in vcpu->arch.dr6 [1]?

kvm_vcpu_ioctl_x86_set_debugregs() assigns dbgregs->dr6 directly to
vcpu->arch.dr6 without ORing in kvm_get_dr6_fixed_1(vcpu), and
kvm_deliver_exception_payload() applies static DR6 masks when delivering
a DB_VECTOR payload rather than enforcing the dynamic fixed-1 bits
(DR6_RTM and DR6_BUS_LOCK when the guest lacks those CPUID features):

arch/x86/kvm/regs.c:kvm_vcpu_ioctl_x86_set_debugregs() {
	...
	kvm_update_dr0123(vcpu);
	vcpu->arch.dr6 =3D dbgregs->dr6;
	vcpu->arch.dr7 =3D dbgregs->dr7;
	...
}

If userspace clears these bits via KVM_SET_DEBUGREGS or injects a #DB
payload that clears them, vcpu->arch.dr6 violates the fixed-1 invariant
and can trigger a host kernel crash or denial of service when subsequent
sanity checks evaluate DR6.

[1] https://sashiko.dev/#/bug/linux-aad38d43-73ef-489e-897a-07392877a8fb

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123121427.2803=
358-1-baoli.zhang@linux.intel.com?part=3D2
