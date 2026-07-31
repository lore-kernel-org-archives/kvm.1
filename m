Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCD4440A2A
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785520181; cv=none; b=ryF+OjLUUbx2F03h0OH3zP2frrF02CmqJSC+EO2sPB7S9rE6BhJOHOqRSwdX/cciST8DtJ0bTcXWbOfuhBtP/d7sNEn/9yzrAaxtteaENq6tm3GwUs2TRPXFipMo2L5ckf3lkTXT5xdt96i1kIWDE9BPaMjJVllLE94xtfJBZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785520181; c=relaxed/simple;
	bh=7sGFqDCd1pvpsxHXPPCxdsOcU+0knYOsiWeMrzQnmfA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GfdmALt4CIwkMgWMe+OHXG2fgZKuxh1C8TyY698aOtCstUKzZ0PlvQzIBLbhxdNQYqP3So4blofyiWMajaMXzFyeVDlH0MYZpX9SWmW3ennT00EHZNlGhB9yQhzjdJey8fcD88LqPbAEBMVQ7wi9mVwQx+5LjPwOpipCSmwkk74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvjKmAgM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvjKmAgM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D371F00AC4;
	Fri, 31 Jul 2026 17:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785520180;
	bh=hfSK2SXUL+nhAReuiLiS8v2t4mcIl2ChyfgecMWYWrQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NvjKmAgMCg8JdL2a9T3YsV5tLXzq1aRozx2YZVeHAq69AmaOFXMAkTkn6Br72knNH
	 1SdM9P2WRp3vbUnwXlQzxCTY2EliF2o0fiutzWwoYUSHgqxrS3Gc/afOKpX1zj7Xci
	 7vZOKjlIdlVMn1uru4xLzG0OoCZRio5gvP74nSZXApiTWPDMmyxeOWuQuLlmbgCPV+
	 6ZS60zQThWkDxHT+82F1imhzTBIo/7j+H2FXPUdfmOYZbQEBhJ4T4BZvW7dyJrgHOX
	 NygcA8v7jDVCcoPRLA9PJA+MbIxbzXohjUj4ocdyN0w8QRJnT84IPO2jzRT3OfaDrD
	 6U7puy4QrH/Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/6] KVM: nVMX: Synthesize SHUTDOWN on RSM if L2
 requires emulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260731173340.2644656-3-seanjc@google.com>
References: <20260731173340.2644656-1-seanjc@google.com>
 <20260731173340.2644656-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 17:49:39 +0000
Message-Id: <20260731174940.54D371F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The early return for `leave_smm` failure in `emulator_leave_smm` b=
ypasses `kvm_leave_nested()`, leaving the vCPU in an inconsistent nested gu=
est mode state.
--

--- Patch [2]: [PATCH v5 2/6] KVM: nVMX: Synthesize SHUTDOWN on RSM if L2 r=
equires emulation ---
commit 4200f9610608af5b1ad7221b2b5cf164faad2906
Author: Sean Christopherson <seanjc@google.com>

KVM: nVMX: Synthesize SHUTDOWN on RSM if L2 requires emulation

This commit synthesizes SHUTDOWN for L1 if L2 requires unhandleable emulati=
on
after loading guest state from SMRAM during RSM. This prevents a misbehaving
L1 from triggering a KVM warning and bugging the VM.

> diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
> index a446487bdd5cf..656a38dad7e7a 100644
> --- a/arch/x86/kvm/smm.c
> +++ b/arch/x86/kvm/smm.c
> @@ -649,6 +649,10 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
>  #endif
>  		ret =3D rsm_load_state_32(ctxt, &smram.smram32);
> =20
> +	if (ret =3D=3D X86EMUL_CONTINUE &&
> +	    kvm_x86_call(unhandleable_emulation_required)(vcpu))
> +		ret =3D X86EMUL_UNHANDLEABLE;
> +
>  	/*
>  	 * If RSM fails and triggers shutdown, architecturally the shutdown
>  	 * occurs *before* the transition to guest mode.  But due to KVM's

[Severity: High]
This isn't a bug introduced by this patch, but looking at the earlier call
to kvm_x86_call(leave_smm)() in emulator_leave_smm() in arch/x86/kvm/smm.c:

    if (kvm_x86_call(leave_smm)(vcpu, &smram))
        return X86EMUL_UNHANDLEABLE;

If this fails, it returns directly and bypasses the kvm_leave_nested()
cleanup at the bottom of the function.

Can this leave the vCPU in an inconsistent nested guest mode state?

For example, if an unprivileged L1 hypervisor maliciously modifies the SMRAM
state (like an invalid CR3) for an active nested VM, could
emulator_leave_smm() call svm_leave_smm() -> enter_svm_guest_mode() ->
enter_guest_mode(vcpu) and fail in nested_svm_load_cr3()?

If so, would it return an error without leaving guest mode, bypass the
kvm_leave_nested() cleanup, and synthesize a nested VM-Exit to L1 instead
of properly transitioning L1 to SHUTDOWN?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731173340.2644=
656-1-seanjc@google.com?part=3D2
