Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19CC22D7A9
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 00:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785888402; cv=none; b=RonEaCZfVEesSgcK4aM3MReB3RiRyzmxtIgP30wRpj8y97NNNBfYZt6eZWdXaXtx7slGUuTduA4kN1kYWk8WgVsrtPjqXk4T6nTw5DsaXsf0yAzXUg8G2xFK5qUUI7B9yv4h9wgsk7YbgK5gvaKnkIOMlCAqSZDQCb1QVQnL1yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785888402; c=relaxed/simple;
	bh=DRNKRYrWlRgExWOnDAWX14t3f/A3qzpz5ZkI6zTX0lI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=st5GKvrBZbPwH/pt8SmvEXLrXYjdHJFtu9T1tlPGegyTNnXHLkIjrdt7WRhztF8U3joEPOtFHB8ZGjOQXVfLf3jM7RENeYwkzQJK3OZcjUeALeRnIzIzfoH3Lgm2s4gfQEc5An7pz9N6jtT+Sy3p76jlQkgGkzSf2fY8jcMRTPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+1VAZ38; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+1VAZ38"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827BF1F00A3A;
	Wed,  5 Aug 2026 00:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785888400;
	bh=RXyIA1vLV8WlBdkI/fFeIWz5Ly6gbVGqDI/fplYB5oU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T+1VAZ38VbAx2EToUNBi96iaY7zTItH2DAQ8h1Bd7GN4SCJ9k5eIKz8oJ4JrCCOdo
	 SkEC53jzxxLflKqMsx29cKhnXTnsMxx6IkK+3BFUR4KgBMn6gwzxFR0j2IDwKaXnz1
	 ZUp2JqkvKJnbk5uJUPLJmAjL1NzGT1oMBTiwatehmeQp/OJsiK83/62YWO4kgW62Oe
	 PTSbaM+BXKzFwW5YzVbUXInSuRosGHs0x+hjdS5O9CtbCLqxWtQPSh4rpZUDp9/Wmz
	 VyEPuQQ5gsOONhHlOFhY/oAJzHgG24IiJ45+kLfZm4p2oCXIYZAF+WgSxoPIqDPcRU
	 f/WssH//SiYKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/17] KVM: x86: Activate master clock immediately on
 vCPU creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260804233923.3504629-5-seanjc@google.com>
References: <20260804233923.3504629-1-seanjc@google.com>
 <20260804233923.3504629-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 00:06:40 +0000
Message-Id: <20260805000640.827BF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Checking the boolean `!vcpu->kvm->arch.use_master_clock` instead o=
f consuming the pending KVM request causes O(N^2) IPI storms on unstable TS=
C hosts and stale clock data when vCPUs have mismatched TSCs.
--

--- Patch [4]: [PATCH v8 04/17] KVM: x86: Activate master clock immediately=
 on vCPU creation ---
commit 5f130615aa4f4dff0ab2f9d96232c00ec3b489b7
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Activate master clock immediately on vCPU creation

This commit updates kvm_arch_vcpu_postcreate() to activate the master
clock immediately upon vCPU creation instead of waiting for the first
KVM_RUN. This allows userspace to retrieve a valid host_tsc and realtime
pair via KVM_GET_CLOCK without needing a dummy vCPU run.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9390,6 +9390,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>  		return;
>  	vcpu_load(vcpu);
>  	kvm_synchronize_tsc(vcpu, NULL);
> +	if (!vcpu->kvm->arch.use_master_clock)
> +		kvm_update_masterclock(vcpu->kvm);

[Severity: High]
Instead of checking the boolean use_master_clock, should this check and
consume the pending KVM_REQ_MASTERCLOCK_UPDATE request via kvm_check_reques=
t?

If the host has an unstable TSC, use_master_clock remains false. Won't this
unconditionally call kvm_update_masterclock() for every vCPU creation,
resulting in O(N^2) iterations and an IPI storm to running vCPUs during
hotplug?

Additionally, if a newly created vCPU has a mismatched TSC frequency,
kvm_synchronize_tsc() correctly queues KVM_REQ_MASTERCLOCK_UPDATE to
disable the master clock. Because use_master_clock is currently true,
this boolean check bypasses the update.

Could this bypass leave the master clock inappropriately enabled and the
request pending, causing KVM_GET_CLOCK to return stale data to userspace
before the first KVM_RUN?

>  	vcpu_put(vcpu);
> =20
>  	/* poll control enabled by default */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804233923.3504=
629-1-seanjc@google.com?part=3D4
