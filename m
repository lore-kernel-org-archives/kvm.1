Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620703FBEA5
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164047; cv=none; b=K4G8SxlAv0Esl0eGUJAnQLZO+4DOW/c98hSitGxX0CUqyYXw2Az5zPSH4ZdB6jqgvgpJTOCYDv0O6gtWkrPkUsnmqFlAI+g5dYw20sLlwE5CyR+2nHDkt3wpAFor1V0Ge+bEkyhyveXjnrU48dQEfZtqc4G9lhEJqZ4q6vWbiFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164047; c=relaxed/simple;
	bh=+5pg4FELgyt6vRWC7r7H4Cp5ff/vh4icYvx4AK3qnLM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U0srbKAbB3aEK2X8w/x2F+x9QM81yGCTgCUVuB5GfRmkP0M0TVY1iBdWCRav2+K2+DFrqNEdEkr5LcpPAQbuDmB/hWXNLFfRiuenEXuPKqQ6qhQK2Nr537KBn9//zVRHiL7pDsF5aBoZVyQ1ZrnNnRwmdGSSF5GWj6IZuGPwWfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D11oYMhf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D11oYMhf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4A91F000FF;
	Fri, 11 Sep 2026 22:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789164046;
	bh=kaIA/EIdh+pEBQeFZwHJXOCKZZhlXwePP+kUz/G4OEg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D11oYMhfLUvvC3My/wT/wqXTJDUkzGWcvT55mn7nB2SLDBb4phs3bTFAsyq4m6mwW
	 8V43tsR2U087+fFTVqXkrqZdygV0kFdrt7qW1hn9ZVgOrEAEIwcmU/1s81EoeVMEVZ
	 4JyK+lZBwx7u/3/NToHRm53wuSFl2nSb0BC+3NP+eXU487CK92pKDHLIlKuPZDvBlg
	 vSkJ/DWkFac3pO6gRF3878dCWs5/pNQiOD+vALvcfA8vSBh9IqQSFOmV3/hw6M2G6+
	 8CqjAsDBJqr2ciu08cscLrIjpb+rTf1BGypODzivz4n6DHPPtJR8bNP1svQ99caP0z
	 6dPfWqNMWEkdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 02/28] KVM: VMX: Initialize VM entry/exit FRED
 controls in vmcs_config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sohil Mehta" <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260911213659.2025974-3-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-3-sohil.mehta@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:00:45 +0000
Message-Id: <20260911220046.1A4A91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] `vmx_check_entry_exit_pairs` incorrectly validates multi-bit e=
xit controls, silently accepting partial feature enablement and exposing th=
e host to privilege escalation.
--

commit 2bf701245fc6586c07b00b47292677b65ee2dec9
Author: Xin Li (Intel) <xin@zytor.com>

KVM: VMX: Initialize VM entry/exit FRED controls in vmcs_config

This commit sets up VM entry and exit FRED controls in the global
vmcs_config to ensure guest FRED state is saved and loaded correctly.
It also adds a check to the existing consistency framework.

[ ... ]

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index b4aec4218b7da..062631e2dd376 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2778,6 +2778,8 @@ static int setup_vmcs_config(struct vmcs_config *vm=
cs_conf,
>  		u32 entry_control;
>  		u64 exit_control;
>  	} const vmcs_entry_exit2_pairs[] =3D {
> +		{ VM_ENTRY_LOAD_IA32_FRED,
> +			SECONDARY_VM_EXIT_SAVE_IA32_FRED | SECONDARY_VM_EXIT_LOAD_IA32_FRED },

[Severity: Critical]
Can this multi-bit mask bypass the validation logic in
vmx_check_entry_exit_pairs?

Looking at how vmx_check_entry_exit_pairs validates these fields:

#define vmx_check_entry_exit_pairs(pairs, entry_controls, exit_controls) \
...
	if (!(entry_controls & n_ctrl) =3D=3D !(exit_controls & x_ctrl))     \
		continue;

If the hardware or an L0 hypervisor provides only one of the two FRED exit
bits, a bitwise AND against the multi-bit x_ctrl mask will still be non-zer=
o.

This makes !(exit_controls & x_ctrl) evaluate to 0, which matches the entry
side, bypassing the inconsistency check entirely.

Could this allow KVM to be partially configured without returning -EIO?

If only one of the exit controls is enabled, could the host resume execution
after a VM-exit with guest-controlled FRED MSRs?

Would this result in a privilege escalation by allowing the next host
interrupt to execute arbitrary guest-controlled code in host context?

>  	};
> =20
>  	memset(vmcs_conf, 0, sizeof(*vmcs_conf));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911213659.2025=
974-1-sohil.mehta@intel.com?part=3D2
