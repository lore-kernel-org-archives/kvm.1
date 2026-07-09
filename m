Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FCC38E12D
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 05:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783576403; cv=none; b=Sq7y97zSMvGGnm1z5vZ1bMAkJULSRKivdro/CEohoPnZWRhNUOUTwhfCO7oPidyUPN7H8/sKVbHV3bMt9l8yXQfXynm3RiO/EtK4AwH3X28cZ4N98HEeRAgNszJw46M6PDC4FJ/5hDdCWbCpj3FntJh+VdxbKHBzYo3ZKV2M4nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783576403; c=relaxed/simple;
	bh=+fgm7zQTLcQ+l73BG8XA5m3ziDkO7/tf7Zt3/4jHgtc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TSZWvE9ZBdk4Jyo6Jc+VTSg5b8IdK7svJSNrubQ8KN6du5MWjxtrriG4B9Tq9TNdBkGjk49wfExYsMAMlmIpFA/A7Jaf+n2NFvORibHKzWxkhPOVf5t6uWvCE/ZgFarHLgRjxStTRj27l//kiVOXbATQ01Cc6aySJPV3XIqEes8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6HtlAm0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6HtlAm0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED4B1F000E9;
	Thu,  9 Jul 2026 05:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783576402;
	bh=7NQFjeQZEHqy+eTf+dkhUxBjfjpa5atInoa5mu7MNqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f6HtlAm04rnepXumVM+KDkMHUancakv0gU+jxuVgFEvAJRMPK2lW6lLsBP2Yw065X
	 AJ2tniEra7m6F78DoIJdW1xRvf5fGN/Utvkf2vbnhUnaufr3GwAzWyXelqYfzNvR5S
	 BFwwpIidv/7MiWz7wUR2Zxti0BhxVtie3OXD9H2GE6oKDNAGCEKuvf7iangcE+K4bE
	 dgEJvuvcvZ9b/IcNFsjmBCC1AttVyzf39Xa0a9u9HIA6ERYkW7IXKxcKJN7A0lgw7T
	 X7s157xqBrhsQhqOs/gTagbGeRQs0A65epvc68VZ0Hd/sMSBnvPMB8XkspK/w5+jvE
	 S+WpVxD5h6rpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: x86: Preserve KVM_EXIT_DEBUG on emulated HLT with
 single-step
Reply-To: sashiko-reviews@lists.linux.dev
To: suryasaimadhu <SaiMadhu.KoyyalaHariVenkata@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260709053949.211165-1-SaiMadhu.KoyyalaHariVenkata@amd.com>
References: <20260709053949.211165-1-SaiMadhu.KoyyalaHariVenkata@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 05:53:21 +0000
Message-Id: <20260709055321.EED4B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The fix to preserve KVM_EXIT_DEBUG during instruction skipping was=
 not applied to kvm_emulate_ap_reset_hold().
- [High] kvm_emulate_halt() restricts early return exclusively to KVM_EXIT_=
DEBUG, overwriting other critical exit reasons like KVM_EXIT_INTERNAL_ERROR.
--

--- Patch [1]: [PATCH] KVM: x86: Preserve KVM_EXIT_DEBUG on emulated HLT wi=
th single-step ---
commit a928dfda27cebab2c60b683589e4cf4ae12635fb
Author: sai madhu <suryasaimadhu369@gmail.com>

KVM: x86: Preserve KVM_EXIT_DEBUG on emulated HLT with single-step
   =20
kvm_emulate_halt() calls kvm_skip_emulated_instruction() before
kvm_emulate_halt_noskip(). When single-step debugging is active,
the skip path can trigger a debug exception and set exit_reason to
KVM_EXIT_DEBUG, but halt emulation then overwrites it with
KVM_EXIT_HLT on the userspace LAPIC path. Return immediately when
a debug exit is already pending so userspace debuggers receive the
correct event.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ff8812f3a1293..473a03f58e263 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11701,10 +11701,16 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_halt=
_noskip);
>  int kvm_emulate_halt(struct kvm_vcpu *vcpu)
>  {
>  	int ret =3D kvm_skip_emulated_instruction(vcpu);
> +
>  	/*
> -	 * TODO: we might be squashing a GUESTDBG_SINGLESTEP-triggered
> -	 * KVM_EXIT_DEBUG here.
> +	 * If kvm_skip_emulated_instruction() triggered a singlestep
> +	 * debug exception, return to userspace immediately so the
> +	 * debugger can process the event. Do not let halt emulation
> +	 * overwrite the KVM_EXIT_DEBUG exit reason.
>  	 */
> +	if (vcpu->run->exit_reason =3D=3D KVM_EXIT_DEBUG)
> +		return ret;

[Severity: High]
This isn't a bug introduced by this patch, but does restricting this early
return exclusively to KVM_EXIT_DEBUG overwrite other critical exit reasons?

If kvm_skip_emulated_instruction() fails (e.g., executing HLT inside an
SGX enclave), it queues KVM_EXIT_INTERNAL_ERROR and returns 0.

Because this check only handles KVM_EXIT_DEBUG, emulation failures fall
through to kvm_emulate_halt_noskip(), which then overwrites the exit reason
with KVM_EXIT_HLT for the userspace LAPIC path.

> +
>  	return kvm_emulate_halt_noskip(vcpu) && ret;
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_halt);

[Severity: High]
This is a pre-existing issue, but it looks like the same issue is present in
kvm_emulate_ap_reset_hold().

arch/x86/kvm/x86.c:kvm_emulate_ap_reset_hold() {
	...
	int ret =3D kvm_skip_emulated_instruction(vcpu);

	return __kvm_emulate_halt(vcpu, KVM_MP_STATE_AP_RESET_HOLD,
				  KVM_EXIT_AP_RESET_HOLD) && ret;
}

Because && evaluates left-to-right, __kvm_emulate_halt() executes
unconditionally and overwrites the exit reason with KVM_EXIT_AP_RESET_HOLD,
even if kvm_skip_emulated_instruction() already returned 0 to exit to
userspace with a debug exception or emulation failure.

Does kvm_emulate_ap_reset_hold() need a similar fix?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709053949.2111=
65-1-SaiMadhu.KoyyalaHariVenkata@amd.com?part=3D1
