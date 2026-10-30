Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793396381;
	b=wZebp+a2/J6Oem7QASXDLlAjeHcclA1vy5D6ZivMqqF5u8I/Jw8XKJMtn82nJNodZVuC
	 HYYj7IxYj4m9LXNJzBVUt8N9NS/wfOI1dLmuzVf9EkD5sdwM7CJ54Bn11QtvEafSNP58N
	 0FrDNsNbWrGvs7JFKUpUHzEJg2XBCLYqAAuQ9dJ7Y2Xly/CPyOV7R7UmEXbGn+exVR1iM
	 wUt/+HSv6IKpGim/OpoaJ2VusJpBCR569Q+SFXu55WdKMr/PsXUYa2/yKtQMSO/SvkU/e
	 OUnM/rSIrVodQcXDsL/CLy2U9GnDAdH/r13MtwqyIXaIZxYwSI6q29QuKDAyOvKdOWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396381;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/j1I+XComumqUfNGzzkmVri4wYL4Z0TO/AqxkyrDT9o=;
	b=t8na6tGaRLW3eUyJ/n/ZSDif4Ndp2TPwDRpcMYCJ1JbFnG0Dr7meDpq8nXYwMjGPllV1
	 RM7TYXeH6keIaGyPHEaF7WWR+lfL1xFzqZvjiPmum+jA97/l5oCXb/KAIpVyAMAt3J9XV
	 39CA1DCGfOUXX1MLTobaE6z0ISH6RTb6NAk7PF3lMZxi946IGHapYWALVkFUT8xvylREn
	 ugJoGTskJjhNZ1c9rOMUvyJDpZY4Ig9ezuhRbmMfmjfqjc3WmvUXCmxkGHitIUOYofT2n
	 mZRzQTWZxBRY1XLeGBpVfVYBvyKimkNbRTx45tYRGavliMxvBENgjI93lrHEYY3VhCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NcGngCIg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28B1606A31F
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NcGngCIg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7221F000C1;
	Fri, 30 Oct 2026 21:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793396380;
	bh=/j1I+XComumqUfNGzzkmVri4wYL4Z0TO/AqxkyrDT9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NcGngCIgeQLj4nFpVwqr7ZDo5VyIhUCx/uBryMMaCG3IBTMEJeka7HcO/nEqv4zQj
	 Tz/J1VF1p/PAYnE6K2oM/DmiJrDlcfXLiLVXSQ9b1pIWJobMPcUNtDyOOYx09tBrSc
	 5NmTMsneSacKCouafqE3KFnhu1rfOJE1WFrOIjfERkbwReAtXOcRXWHuOk/phKf5Qa
	 uW/51GbZIb5ROAP4TTsm99tf7xCVSlTGW1Pee339FPEiyfZ1Z/pL5jllbCHsKxASXf
	 twtD+LDLryJM06aoQtwS6PR665rvqx6Z1JOTg0IRfA2k3YCWpjLUe9v6/jQQ1FToiG
	 Gb+O1B5j/7WCQ==
Message-ID: <sashiko-outbox-191540@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/7] Revert "KVM: x86: Skip EFER vs. guest CPUID
 checks for host-initiated writes"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261030212721.2606393-2-seanjc@google.com>
References: <20261030212721.2606393-1-seanjc@google.com>
 <20261030212721.2606393-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 21:39:38 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] KVM: x86: outdated EFER_LMSLE_MBZ api.rst doc and __kvm_valid_efer(=
) comment
--

commit e9f88969b96c2ee54c7d5d0af947bad813dd2acc
Author: Sean Christopherson <seanjc@google.com>

Revert "KVM: x86: Skip EFER vs. guest CPUID checks for host-initiated write=
s"

This commit reverts commit 11988499e62b ("KVM: x86: Skip EFER vs. guest CPU=
ID
checks for host-initiated writes") so that host-initiated writes to MSR_EFER
via set_efer() are once again validated against guest CPUID capabilities and
CR0.PG vs. EFER.LME constraints.

> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index e91650af44c20..2df42276fd826 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
> @@ -580,8 +580,11 @@ static int do_get_feature_msr(struct kvm_vcpu *vcpu,=
 unsigned index, u64 *data)
>  				 kvm_get_feature_msr);
>  }
> =20
> -static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
> +bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
>  {
> +	if (efer & ~kvm_caps.supported_efer_bits)
> +		return false;
> +
>  	if (efer & EFER_AUTOIBRS && !guest_cpu_cap_has(vcpu, X86_FEATURE_AUTOIB=
RS))
>  		return false;
> =20
> @@ -610,33 +613,18 @@ static bool __kvm_valid_efer(struct kvm_vcpu *vcpu,=
 u64 efer)
> =20
>  	return true;
>  }
> -
> -bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
> -{
> -	if (efer & ~kvm_caps.supported_efer_bits)
> -		return false;
> -
> -	return __kvm_valid_efer(vcpu, efer);
> -}
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_valid_efer);
> =20
> -static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> +static int set_efer(struct kvm_vcpu *vcpu, u64 efer)
>  {
>  	u64 old_efer =3D vcpu->arch.efer;
> -	u64 efer =3D msr_info->data;
>  	int r;
> =20
> -	if (efer & ~kvm_caps.supported_efer_bits)
> +	if (!kvm_valid_efer(vcpu, efer))
>  		return 1;
> =20
> -	if (!msr_info->host_initiated) {
> -		if (!__kvm_valid_efer(vcpu, efer))
> -			return 1;
> -
> -		if (is_paging(vcpu) &&
> -		    (vcpu->arch.efer & EFER_LME) !=3D (efer & EFER_LME))
> -			return 1;
> -	}
> +	if (is_paging(vcpu) && (vcpu->arch.efer & EFER_LME) !=3D (efer & EFER_L=
ME))
> +		return 1;

[Severity: Low]
As reported by Sashiko on v1 [1], now that set_efer() in arch/x86/kvm/msrs.c
unconditionally calls kvm_valid_efer() (including the
X86_FEATURE_EFER_LMSLE_MBZ check) even on host-initiated MSR_EFER writes and
folds __kvm_valid_efer() into kvm_valid_efer(), should
Documentation/virt/kvm/api.rst and the comment in efer_trap() in
arch/x86/kvm/svm/svm.c also be updated?

Specifically, commit 7358d13e1f19 ("KVM: x86: Honor the guest's
EFER_LMSLE_MBZ") added the following note under "Long mode segment limits" =
in
Documentation/virt/kvm/api.rst:

    Note, ``KVM_SET_MSRS`` is exempt from the check, as host-initiated MSR =
writes
    skip guest CPUID checks so that userspace can set MSRs before it sets g=
uest
    CPUID.  ``KVM_SET_SREGS`` and nested VMRUN are not exempt.

While the selftest failure in test_host_initiated_lmsle() in
tools/testing/selftests/kvm/x86/svm_nested_efer_test.c is addressed later in
this series by commit "KVM: selftests: Expect failure when trying to set EF=
ER
that violates vCPU model", Documentation/virt/kvm/api.rst still states that
KVM_SET_MSRS is exempt from the check.

Additionally, efer_trap() in arch/x86/kvm/svm/svm.c still references the
removed __kvm_valid_efer() helper in its comment:

    /*
     * Clear the EFER_SVME bit from EFER. The SVM code always sets this
     * bit in svm_set_efer(), but __kvm_valid_efer() checks it against
     * whether the guest has X86_FEATURE_SVM - this avoids a failure if
     * the guest doesn't have X86_FEATURE_SVM.
     */

[1] https://lore.kernel.org/r/20261022223052.646891-2-seanjc@google.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030212721.2606=
393-1-seanjc@google.com?part=3D1
