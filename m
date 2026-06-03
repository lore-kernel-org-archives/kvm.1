Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62AD4D98E4
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527021; cv=none; b=K3C/GYXjx8dstICVBREt/OKsYhw/DOFYwpoCD1Dx6yCBoEgaBay9xbSq5nScKV7VddzE4nBFXyist5BRb0uGF8YfC2LzUWyMcWjMAmW/Urp19EGBSMPsLTzgtJXmHHDaHOCVPWaL+s7cbuyJzQMJ+Wqwjd85MhGe6TzHM6QP4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527021; c=relaxed/simple;
	bh=nCqkpezqNrp4+g096TTDsHn3yks6anWaAxwLh9c9RrE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eCZQT5o3CKp6c5ZvMon88EibaeOW/zqkCZqdVwXX98sg9AQOs9Dp453WZGiy2iIi/bdTLdQ1XnbzOlh7O7AfRIDm6+CyTztfnPJAMDpFNK1VfigXI0eoZ/24VhmSb/9V1+tgQ9JjcUEKqC/eP2JT4zBNVO+t9+WfV1QaqsV1T80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNZpcwG+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNZpcwG+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E151F00893;
	Wed,  3 Jun 2026 22:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780527013;
	bh=fyWQobaGZ/GZc9BUFqWH0qjn3KQ7cpyaeUE7SWtI5V4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UNZpcwG+QIC1dCuHkXUqvDZW27LA0+V1rspU/4nzU+IMBNTIuuqaVo6krTdqfTG/z
	 RLADlSaseW1dNC+6hA4bm8bFgOqJq1Xt+8nRh0a0UvVF2+XnohLLYVAkJOJ4mdap7Z
	 HLb6rnmfyqHGXs9V74SI1nPw8frucHuChVLgdC/Scx4SfUp3o3b1VVHpUA3u2jiIow
	 dFVxJ9IxFViZwi74aEw21GU4aXFiPG7E0VbAceJ5T8TI+vPi0FH97MQGB+DWhk0VHo
	 UAUDYv9jYyNg4dEtI5MMEbhUu1cHqH24fX+2nilu2kInPMUPuatm7dB6HEao4MEO/m
	 2NzLMpIXycO9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KVM: nVMX: Don't use vmcs01.GUEST_CR3 to snapshot
 L1's CR3 when EPT is disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603223418.1720035-3-seanjc@google.com>
References: <20260603223418.1720035-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 22:50:12 +0000
Message-Id: <20260603225013.99E151F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Reading `vcpu->arch.cr3` directly captures a stale CR3 value when =
EPT is enabled, corrupting L1's CR3 on late VM-Fail.
--

commit bc5d55e01f501ccb793937fda67ddf44633f6fda
Author: Sean Christopherson <seanjc@google.com>

KVM: nVMX: Don't use vmcs01.GUEST_CR3 to snapshot L1's CR3 when EPT is disa=
bled

This commit adds a dedicated field in struct nested_vmx to track L1's
pre-VM-Enter CR3, avoiding the use of vmcs01.GUEST_CR3. It also modifies
nested_vmx_enter_non_root_mode() to save the CR3 value, and
nested_vmx_restore_host_state() to restore it.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3651,19 +3651,14 @@ enum nvmx_vmentry_status nested_vmx_enter_non_roo=
t_mode(struct kvm_vcpu *vcpu,
>  				    &vmx->nested.pre_vmenter_ssp_tbl);
> =20
>  	/*
> -	 * Overwrite vmcs01.GUEST_CR3 with L1's CR3 if EPT is disabled.  In the
> -	 * event of a "late" VM-Fail, i.e. a VM-Fail detected by hardware but
> -	 * not KVM, KVM must unwind its software model to the pre-VM-Entry host
> -	 * state.  When EPT is disabled, GUEST_CR3 holds KVM's shadow CR3, not
> -	 * L1's "real" CR3, which causes nested_vmx_restore_host_state() to
> -	 * corrupt vcpu->arch.cr3.  Stuffing vmcs01.GUEST_CR3 results in the
> -	 * unwind naturally setting arch.cr3 to the correct value.  Smashing
> -	 * vmcs01.GUEST_CR3 is safe because nested VM-Exits, and the unwind,
> -	 * reset KVM's MMU, i.e. vmcs01.GUEST_CR3 is guaranteed to be
> -	 * overwritten with a shadow CR3 prior to re-entering L1.
> +	 * Stash L1's CR3, so that in the event of a "late" VM-Fail, i.e. a
> +	 * VM-Fail detected by hardware but not KVM, KVM can unwind its
> +	 * software model to the pre-VM-Entry host state.  When EPT is
> +	 * disabled, GUEST_CR3 holds KVM's shadow CR3, not L1's "real" CR3,
> +	 * and so simply restoring from vmcs01.GUEST_CR3 would corrupt
> +	 * vcpu->arch.cr3.
>  	 */
> -	if (!enable_ept)
> -		vmcs_writel(GUEST_CR3, vcpu->arch.cr3);
> +	vmx->nested.pre_vmenter_cr3 =3D vcpu->arch.cr3;

[Severity: High]
Does directly reading vcpu->arch.cr3 here capture a stale value when EPT is
enabled?

Because KVM does not intercept L1 CR3 writes when EPT is enabled, L1 can
update its CR3 without KVM immediately tracking it. On VM-Exit (such as for
VMLAUNCH), KVM invalidates the CR3 register cache by clearing the
VCPU_REG_CR3 availability bit.

If nested_vmx_enter_non_root_mode() directly assigns vmx->nested.pre_vmente=
r_cr3
from vcpu->arch.cr3 instead of using kvm_read_cr3(vcpu), it seems this would
bypass the cache refresh and stash a stale CR3 value.

> =20
>  	vmx_switch_vmcs(vcpu, &vmx->nested.vmcs02);
> =20

[ ... ]

> @@ -4975,7 +4970,7 @@ static void nested_vmx_restore_host_state(struct kv=
m_vcpu *vcpu)
>  	vmx_set_cr4(vcpu, vmcs_readl(CR4_READ_SHADOW));
> =20
>  	nested_ept_uninit_mmu_context(vcpu);
> -	vcpu->arch.cr3 =3D vmcs_readl(GUEST_CR3);
> +	vcpu->arch.cr3 =3D vmx->nested.pre_vmenter_cr3;

[Severity: High]
If pre_vmenter_cr3 stashed a stale value, will restoring it here corrupt L1=
's
CR3 on a late VM-Fail?

If a late VM-Fail occurs (detected by hardware but not KVM), writing this
potentially stale pre_vmenter_cr3 back into KVM's state (vcpu->arch.cr3) and
marking it as available could cause L1 to resume with an outdated CR3, which
might lead to guest memory corruption or a triple fault.

>  	kvm_register_mark_available(vcpu, VCPU_REG_CR3);
> =20
>  	/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603223418.1720=
035-1-seanjc@google.com?part=3D2
