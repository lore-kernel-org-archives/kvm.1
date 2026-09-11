Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9823C585E
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789166238; cv=none; b=o/25SWkZlQ209JGgEJn4LpEaf+qm8WDAkOeBskxVe7tDsY3bu3QnDq+pvxwI+sB31GXEl7+Pc/dZFNKJWei8DfeYHpWPqZf42UaFGIiFHNewfyXtYycH1TDPM2Yufk5hK2Q6mM3HdQcrBF6EaP5jZ9vLMdVjCZDWPSCKtvXlk4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789166238; c=relaxed/simple;
	bh=Ik140aH4lrs6y2JmnYwULtFmnJWU6CCXjh947w4cM18=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vC1nhDfjm48tNn7MOUZkooFxaAJXedy3q5ejGGwHQNdsoGNTD7yAQHuPKlgWCcbd2iE76FO4QDhareMdiiILZ79YqrAxxjz66UpCbJeWDJMKGW8zDlRIqlKnk+8+KvwG4oWx3R1hzNz1C5GCjf/iiG4QQxczcdJWHxWSH//h8B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZQ9Ms9A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZQ9Ms9A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2391F000FF;
	Fri, 11 Sep 2026 22:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789166236;
	bh=YqxCE0ID2FXen3v91KM7GAc9TIsrdOmM5OZE+7mbmbM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OZQ9Ms9AhiTvrwaBoQjczd7MMwQVipDl/aiz+V5EUKGoYoYUAJTSifJQFWzcvUTt+
	 WEA8XOyKVt9biQOaE9/x0tGKUlitlhuIn8LM6uggd9ikgIwyumZ2H/GGzcvGDzRrly
	 bjcPEccl6+UQQ79jH0h/P3nMGvsY6sL4tDtq7P1y23nHDQ6MJO+elEC6VM+78cvX80
	 4nbVXVysQpXo/eMUOh4dD8t7uBVRDPJjIjCAUxwORFgAb9f7SG0kSWWFkGZFWt43h0
	 gg9PxAKnZorq/y/9gUyq09reU23Epz0yvbbNlcVwW46PRD026x1Oj8w+g8j+7VmoDo
	 K1kmPZifqAqmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 25/28] KVM: nVMX: Enable VMX FRED controls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sohil Mehta" <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260911213659.2025974-26-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-26-sohil.mehta@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:37:15 +0000
Message-Id: <20260911223716.4F2391F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM unconditionally advertises nested VMX FRED controls to L1 gues=
ts without verifying host or guest FRED CPUID capabilities, leading to sile=
nt state drops during nested transitions.
--

commit 8c95c51cce41b2dd05048f8b79efa91ac6528519
Author: Xin Li (Intel) <xin@zytor.com>

KVM: nVMX: Enable VMX FRED controls

This patch permits the use of VMX FRED controls in nested VMX by updating t=
he
entry and secondary exit controls, allowing FRED-related operations during
nested VM exits and entries.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -7371,12 +7371,8 @@ static void nested_vmx_setup_exit_ctls(struct vmcs=
_config *vmcs_conf,
> =20
>  	if (msrs->exit_ctls_high & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS) {
>  		msrs->secondary_exit_ctls =3D vmcs_conf->vmexit_2nd_ctrl;
> -		/*
> -		 * As the secondary VM exit control is always loaded, do not
> -		 * advertise any feature in it to nVMX until its nVMX support
> -		 * is ready.
> -		 */
> -		msrs->secondary_exit_ctls &=3D 0;
> +		msrs->secondary_exit_ctls &=3D SECONDARY_VM_EXIT_SAVE_IA32_FRED |
> +					     SECONDARY_VM_EXIT_LOAD_IA32_FRED;

[Severity: High]
Does this unconditionally advertise nested VMX FRED controls to L1 guests
without verifying host or guest FRED CPUID capabilities?

If an L1 guest is configured without FRED CPUID capabilities, it is still
permitted by these MSRs to set the FRED controls in its vmcs12. KVM directly
copies this control bit to the hardware vmcs02 structure.

However, because KVM's nested entry routines explicitly check
guest_cpu_cap_has(vcpu, X86_FEATURE_FRED), KVM will skip initializing the
vmcs02 FRED MSR fields. When the physical CPU enters L2, it will load
uninitialized or stale FRED MSR fields from KVM's vmcs02 memory, which can
lead to unpredictable L2 behavior or silent state drops.

>  	}
>  }
> =20
> @@ -7392,7 +7388,7 @@ static void nested_vmx_setup_entry_ctls(struct vmcs=
_config *vmcs_conf,
>  		VM_ENTRY_IA32E_MODE |
>  #endif
>  		VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS |
> -		VM_ENTRY_LOAD_CET_STATE;
> +		VM_ENTRY_LOAD_CET_STATE | VM_ENTRY_LOAD_IA32_FRED;

[Severity: High]
Similar to the exit controls above, does VM_ENTRY_LOAD_IA32_FRED need to be
dynamically masked from msrs->entry_ctls_high in nested_vmx_setup_entry_ctl=
s()
when FRED is unsupported by KVM or the guest?

>  	msrs->entry_ctls_high |=3D
>  		(VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR | VM_ENTRY_LOAD_IA32_EFER |
>  		 VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911213659.2025=
974-1-sohil.mehta@intel.com?part=3D25
