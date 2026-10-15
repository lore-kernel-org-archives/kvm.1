Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1FE4E2F1E
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054942; cv=none; b=Di6uu/B5M/KGY9ndWkC8Rv/i/h9Dkm8ToaQo1HWxoi7n3ghbHkVVltYWpteCpIcJGJd11Ct6JGKWtMmJPlpihqNW9Yd1Crn8ijvXuwbhK5iKZ4C9Rka8QGB71EE1oDflFv+Os/t5F0sbWUXhfrwj8IXKYQt5VG0co9LFGZMS8eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054942; c=relaxed/simple;
	bh=E05jcZ56gHgbv1TbyLJmnwJZV6xT+j282k47EQoynaw=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=YHRn6mIt4v6iwYG6VDK8F1w03ThlzxID3QKj3RzdYjI84aFPplFC8n2lNa7+AOJfJhpIa9xekrmJJSRcYMYUq5U1qQiVg34Er61ifRdVfBc5+GG4GMxEMshswUOBy7/xrJR2/MhhNY5fu8btVh4H0SUFnkbVmofJKVGDPsSzhMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoW8G4RQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoW8G4RQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B901F000C4;
	Thu, 15 Oct 2026 09:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792054941;
	bh=PXjZMu0+qCZQWOPd/VyfR4J28MIZYAyKg0Bto+2Nf5g=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=PoW8G4RQEfWeC/YjKilv1p6q7AZQvfQ7BjsNmBCNU9XJAk4DszJghLadHhIJGLQko
	 sZK6jpUIZShNJLEOgNVJz9ZoC+VpkohFWAqJA3gC4MCkY+L9jlFhkzUbVzAni/PUJT
	 xFM3o78Db7VSafONAIiwpigTw2rxyunzs9nseuMlFqmBw8x5BYwJfLIceItvCtHAGO
	 vkSqGvBmtzZch2V3E9G8B5ZgSy14IaImjH+TWxKQPy9zFuoc8GlUIaTSTQNcL7pqRt
	 Vg3L8PzqIaRKkiZd56bUb1eR7Tl/Rgju/hJGtJO9OqzMn/QlglK3ZadLFZn+YLy10k
	 RgNlTZlLizUFA==
Message-ID: <sashiko-outbox-172536@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] KVM: nVMX: Reset MMU back to the root MMU if
 loading L2 state fails for !VM-Entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261015083123.790030-2-pbonzini@redhat.com>
References: <20261015083123.790030-1-pbonzini@redhat.com>
 <20261015083123.790030-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 09:02:20 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: vmx: nested state corruption (CR0/CR4/EFER) on KVM_SET_NESTED=
_STATE failure
--

commit 55d55918900f4eae4bf7636855cdc83ba4433cf5
Author: Amirmohammad Eftekhar <amirmohammadeftekhar@gmail.com>

KVM: nVMX: Reset MMU back to the root MMU if loading L2 state fails for !VM=
-Entry

This patch resets the vCPU's MMU pointer back to the root MMU if loading L2
state fails when not coming from VM-Entry. This prevents KVM from hitting
a NULL pointer dereference when attempting to run L1 with a nested MMU.

Link: https://patch.msgid.link/20261001214356.3825100-2-seanjc@google.com

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index b252168627408..5165275128fce 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3770,8 +3770,10 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root=
_mode(struct kvm_vcpu *vcpu,
>  vmentry_fail_vmexit:
>  	vmx_switch_vmcs(vcpu, &vmx->vmcs01);
> =20
> -	if (!from_vmentry)
> +	if (!from_vmentry) {
> +		nested_ept_uninit_mmu_context(vcpu);

[Severity: High]
When userspace invokes KVM_SET_NESTED_STATE, KVM executes
vmx_set_nested_state() which calls nested_vmx_enter_non_root_mode() with
from_vmentry set to false.

This unconditionally calls prepare_vmcs02(), which modifies the vCPU's
software state (such as cr0, cr4, efer, and tsc_offset) to match the
nested L2 state.

If prepare_vmcs02() subsequently fails, for example due to an invalid L2
CR3, it returns an error and jumps to vmentry_fail_vmexit_guest_mode.

While this patch fixes the MMU pointer, since from_vmentry is false, does
this early return bypass load_vmcs12_host_state() and leave the vCPU's
software state permanently corrupted with L2's values?

>  		return NVMX_VMENTRY_VMEXIT;
> +	}
> =20
>  	nested_put_vmcs12_pages(vcpu);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015083123.7900=
30-1-pbonzini@redhat.com?part=3D1
