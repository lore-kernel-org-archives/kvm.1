Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956234BEE53
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 22:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164524; cv=none; b=Eg/Uix5GO3mgWR/wZKALDudAvhGosws0tDXhRR/OjJo7ti2uWSMIIG/7srQc5NYDXjWFcec4MiIv5Z4ULlupi5Z4dqBs5E+vUDAkjwsoELt+tKeg096vt6Sl1BksAihbgbEfNkXEnFeJDqbfPJpr5YWDdh6rdQ7B7+XXs8UlawI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164524; c=relaxed/simple;
	bh=Y+asBcbim5LUi1Gz/iKMn1dGHUv4RVYNgfwp5M9lj/A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TLKy+468nNt8diFGaZkxV4Vr2OuTLXMOYu1Z9KzKp8tAqbKPMmohbYBQy4qnZC54K9uDC3Vtr59CqYPiuyHU6GKcdBkkWQY+gIFj8OQQWzZCavCgtsg20vTiWkj1zsVSmK8Rvu8CkJ5qS/lCGddTgs5QWfak2CMHaLwp/thPmD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOyJhyKD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOyJhyKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE9E1F000FF;
	Fri, 11 Sep 2026 22:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789164523;
	bh=X5BgEdouTULcO2vFSB8AvgmPirSWSw4ufLjctWcrJxQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UOyJhyKDtysMKrQylyMsXM9I8+bmpsXkAY+NAhfhpEcu5WgQ9QcD9VC4raR81GPlc
	 vAGnlfzRGSvsY2J4qLzp9xuu7g/ypXH6TDVEqb+H0dmzHrJhq7yrv5UrGVKrFG2P78
	 JJBtxyrRKUnsncR8UF9PpBnuxS/zoHFzvA2jNu6quEBLCgbCvi/h/Dz0C20BVSxHFF
	 Fmc+T0CZsy0ynyfTBtN+aYZ/LcjHpwfhtZ1ufDidV4951Jq0L2HbKbSL8EejJw3qiX
	 6u51Q9blk3Rvj4SAcTxvxSWGsIo79PB3d2XCG/VebsUP4jlfthZDY54rHvG/hqcGza
	 UEubM6tfirlHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 03/28] KVM: VMX: Disable FRED if FRED consistency
 checks fail
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sohil Mehta" <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260911213659.2025974-4-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-4-sohil.mehta@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:08:42 +0000
Message-Id: <20260911220842.DEE9E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Flawed boolean logic in `vmx_check_entry_exit_pairs` allows KVM to=
 expose FRED on nested hypervisors or broken hardware with incomplete exit =
controls, bypassing the intended mitigation.
--

commit 125b825fe12cce02b0f6ac3d6d7b8bd72cd92cfb
Author: Xin Li (Intel) <xin@zytor.com>

KVM: VMX: Disable FRED if FRED consistency checks fail

This commit adds a check to disable the FRED CPU capability if FRED
consistency checks fail during VMX initialization. It clears the
X86_FEATURE_FRED capability by verifying the presence of
VM_ENTRY_LOAD_IA32_FRED in the entry controls.

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c

[ ... ]

> @@ -8122,6 +8122,9 @@ static __init void vmx_set_cpu_caps(void)
>  		kvm_cpu_cap_check_and_set(X86_FEATURE_DTES64);
>  	}
> =20
> +	if (!cpu_has_vmx_fred())
> +		kvm_cpu_cap_clear(X86_FEATURE_FRED);
> +

[Severity: High]
This isn't a bug introduced by this patch, but is it possible that this
mitigation can be bypassed due to a logical flaw in the pre-existing
vmx_check_entry_exit_pairs() macro?

This new mitigation clears X86_FEATURE_FRED if cpu_has_vmx_fred() returns
false, which checks for VM_ENTRY_LOAD_IA32_FRED. The presence of this entry
control relies on the consistency checks performed earlier.

Looking at the pre-existing vmx_check_entry_exit_pairs() macro in
arch/x86/kvm/vmx/vmx.c:

        if (!(entry_controls & n_ctrl) =3D=3D !(exit_controls & x_ctrl))   =
 \
                continue;                                               \

The x_ctrl parameter used for FRED is a multi-bit mask:

        { VM_ENTRY_LOAD_IA32_FRED,
          SECONDARY_VM_EXIT_SAVE_IA32_FRED | SECONDARY_VM_EXIT_LOAD_IA32_FR=
ED },

If the underlying hardware (or a nested hypervisor) provides incomplete
support and only sets one of the exit bits (for example, just SAVE), the
bitwise AND (exit_controls & x_ctrl) evaluates to a non-zero value. The
logical NOT of this non-zero value evaluates to 0.

If the entry control bit is present, its logical NOT is also 0. Thus, the
equality check passes (0 =3D=3D 0), the macro skips clearing the entry bit,=
 and
VM_ENTRY_LOAD_IA32_FRED incorrectly remains set.

Because VM_ENTRY_LOAD_IA32_FRED is still set, cpu_has_vmx_fred() evaluates
to true, and this new mitigation is bypassed. This could allow a guest to
escalate privileges if the CPU fails to restore the host's FRED MSRs on
VM-exit due to the incomplete exit controls.

Does the macro need to be updated to ensure all bits in a multi-bit mask are
present before considering the controls consistent?

>  	if (!enable_pmu)
>  		kvm_cpu_cap_clear(X86_FEATURE_PDCM);
>  	kvm_caps.supported_perf_cap =3D vmx_get_perf_capabilities();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911213659.2025=
974-1-sohil.mehta@intel.com?part=3D3
