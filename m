Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795491725;
	b=05Utm0BgkQ7glUxhkSrDvOmpIBnrTWuvL6um5da6hkGxlbt8MkRJsGVxTIlTV8zphOx1
	 ITLNMenOUkckiRQE9Sq01SWW6WcVEeR5EKWtytVdza3rG0491vPKrgEgXw+xXM19tyx+m
	 UXosDVQYajlkcsftK8xztZ4si9FzP81BrZCfns67EfGz92duTmojPQ5Uo2o3QS3iDUFs3
	 4ODJ4bCWeToboakCj7muMHBCdQCFUwj8AvGN3OHzdPR9wFRUlvAFwKVxC5EuHPMveLBBJ
	 xt3K3e2sIlIusI3LZyAagZMOJYBi51nKlA9QJi8c2+d65D+IHhegnKeOQsprIatV+xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795491725;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bBMozHIV2Sn0YSQVM46HYIDhN5C0ykbDmnBTFgAjBvw=;
	b=MUaSFZ1k65kNVqJZsHDJZHdmPmg1gv/BkQC6b8Y8MuhBi3UE2HJh12u8RUrrXNB1M5uj
	 63sJduJUJ/hFTBh0K7xWPDozgh3AuX8ONKTNwcOPRnOZ5XGybEXVNJ7YY6Y2xmpExuZev
	 BXxc2s71RAn/0gWSG3LSyOpffQPAqNl297CzUEUKRzp14URR0rIj35SLQlTvh9JVIC/TZ
	 GH+XCDQ6imjRCTec6w9HiU8uZXVj78LSHDzvPuSJ0QhHBl4oSzY6+huIxpqFhxRtrPSm+
	 cMq4zq9FBX0v+yZvi0kWfaAqnSvYai2S9BhlKw3NFLli39FKTlQAEn68RFY87fTWxGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9dM0RpI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D69B606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 03:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9dM0RpI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA5E1F000C6;
	Tue, 24 Nov 2026 03:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795491725;
	bh=bBMozHIV2Sn0YSQVM46HYIDhN5C0ykbDmnBTFgAjBvw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q9dM0RpI8gvb8RvGeYRH19x9oO40inOPSx3wPhqWmep51ZzIFtl5D3ZD5EdXbGbf4
	 Nn1W3QhE4wo8FC8b5YdHgVufpeN3A32VTos2KkmTnN1YZojNgijh+AoJh1Wppe+mZa
	 e7jTH/2MNJEd0o4Fr88wnUl/sNyEqvtucrlfHtnWNbIN/HKNXqHVxC/3LvQMochcYR
	 5ROB+0VzurT/AtGdo5BIYNKxbM7JngISno56NoOkAfFUFX06rLs92C3pq1zrpHDmf5
	 I0UASmMZEYRUo1DAIXlFxYOMEP8RI9FeXDOvFqmoGRBnq8mIajlGn2VR7lGSrUgwon
	 sGu4fZ39cmpzg==
Message-ID: <sashiko-outbox-230480@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: x86: Reject SMM on VMs with private memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Younho Choi" <gdool88@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261124032748.1221979-1-gdool88@gmail.com>
References: <20261124032748.1221979-1-gdool88@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 03:42:04 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Critical] KVM: x86: pending SMI in
  kvm_vcpu_ioctl_x86_set_vcpu_events() enters SMM
--

commit c37a22adf8ef4d4936cc15c833970255bb255e89
Author: Younho Choi <gdool88@gmail.com>

KVM: x86: Reject SMM on VMs with private memory

This commit prevents VMs with private memory from advertising
KVM_CAP_X86_SMM, emulating MSR_IA32_SMBASE, or enabling SMM via
KVM_SET_VCPU_EVENTS.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index aad065d035fbb..467262520dc4d 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3039,6 +3039,15 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(stru=
ct kvm_vcpu *vcpu,
>  			      | KVM_VCPUEVENT_VALID_TRIPLE_FAULT))
>  		return -EINVAL;
> =20
> +	/*
> +	 * SMM is unsupported for VMs with private memory, which expose a single
> +	 * memslot address space; entering SMM would select address space 1 and
> +	 * alias it with address space 0 (see kvm_arch_nr_memslot_as_ids()).
> +	 */
> +	if ((events->flags & KVM_VCPUEVENT_VALID_SMM) && events->smi.smm &&
> +	    kvm_arch_has_private_mem(vcpu->kvm))
> +		return -EINVAL;
> +
>  	if (events->flags & KVM_VCPUEVENT_VALID_PAYLOAD) {
>  		if (!vcpu->kvm->arch.exception_payload_enabled)
>  			return -EINVAL;

[Severity: Critical]
Should this check also reject events->smi.pending (and
events->smi.smm_inside_nmi), matching the !CONFIG_KVM_SMM check further down
in kvm_vcpu_ioctl_x86_set_vcpu_events()?

Passing events.smi.smm =3D 0 and events.smi.pending =3D 1 on a VM with priv=
ate
memory still sets vcpu->arch.smi_pending.  On the next KVM_RUN,
kvm_check_and_inject_events() calls enter_smm() (or hits KVM_BUG_ON() in
vt_smi_allowed() on TDX VMs), entering address space 1 and triggering the
vcpu->last_used_slot generation-aliasing use-after-free in
kvm_vcpu_gfn_to_memslot().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124032748.1221=
979-1-gdool88@gmail.com?part=3D1
