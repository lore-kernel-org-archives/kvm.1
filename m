Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A7843AB0
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 03:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785729503; cv=none; b=O4RogTjQAmEAP8Vn2DKceFKHL12Zyxtn6WePJ38kyNzPnIMrt0hReEOKYBlYIO8swGxJzoMsOL5iM8FdLdEPJJ4Q6dyDplM0284jgU2kbiy4BEiEppsO7GYsfZkgJBtwpdLvLPN8iREchEXL3XZh85qCjlydARmHDaMEbZzEZao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785729503; c=relaxed/simple;
	bh=e3R06Qo7jtn51qgA3HUQk6STRLDW8yBqrXRSAf60Jl4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rtra0YOtkwLEq+mT8EEaB16Om/Jw674OBqat/5FJGUrTK/k1ZEMEss0ZrOENasGBKC38+zaCrXJXfyGn10euvNsRdQdZ29WWndQUKeotLRTHMsl/XM3h7XCmmJnmtGGwENbIweZwWFeDlSIfmS8yr/u3D4X1bGAZJCs5mvXYWcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTF87O5Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTF87O5Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE121F000E9;
	Mon,  3 Aug 2026 03:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785729499;
	bh=gply/N5f4cJDqjlSKgEZSnkoQDdSUqT2Q6AIApI6fSw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PTF87O5Zlo0FB5U3ZC62zfWLGmbShFCkyYAS/3dagvLhdNe6wIkSIHgxfrk7SMw/d
	 9cTNhUKVzWyGGGqpxvyXL3DZSKyVX+lQrLIbo7WnjgSCiqoRzZ6KBUnU8Ugh1zDE9d
	 oN2po1jAyWlJE9WBjxCTpEvhZXCKOzo3+LxEA4XwLMefrn4r7cK5hTnvjDn00q8W13
	 chLACbq3vmjbPsonFP4XQF7VqyA/1feQkCj+rI+0nuweJT/auGVgAZDwFkGkDwwxfQ
	 YuLrrkivDvO79EcQM5KOaxu3HwpAQuPjCXybHY4PlG8hzw5rFhJ8wOhfZ6PRta9Vnk
	 hxblnVDWMvr1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV nestedv2: Don't drop pending
 doorbell across L2 entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vaibhav Jain" <vaibhav@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260803034426.44249-1-vaibhav@linux.ibm.com>
References: <20260803034426.44249-1-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 03:58:19 +0000
Message-Id: <20260803035819.AEE121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Concurrent doorbell requests from sibling vCPUs are silently lost =
due to unconditional clearing of `doorbell_request` on exit.
- [Low] Typo in variable name `cpu` instead of `vcpu` leads to an undeclare=
d identifier and build failure.
--

--- Patch [1]: [PATCH] KVM: PPC: Book3S HV nestedv2: Don't drop pending doo=
rbell across L2 entry ---
commit efc59a0f35293530907029b05624f01523b4f3ea
Author: Vaibhav Jain <vaibhav@linux.ibm.com>

KVM: PPC: Book3S HV nestedv2: Don't drop pending doorbell across L2 entry

This patch changes how pending doorbells are tracked during nestedv2 entry.
Instead of unconditionally consuming the doorbell on entry, it tracks the
L2's DPDES state and only clears the request if it was actually handled by
the L2.

Fixes: 54ec2bd9e017 ("KVM: PPC: Book3S HV nestedv2: Fix doorbell emulation")

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c

[ ... ]

> @@ -4296,6 +4295,17 @@ static int kvmhv_vcpu_entry_nestedv2(struct kvm_vc=
pu *vcpu, u64 time_limit,
>  	if (rc < 0)
>  		return -EINVAL;
> =20
> +	/* Check if privileged door bell was requested and handled */
> +	if (vcpu->arch.vcore->dpdes) {
> +		kvmhv_nestedv2_cached_reload(vcpu, KVMPPC_GSID_DPDES);
> +		if (vcpu->arch.vcore->dpdes)
> +			vcpu->arch.doorbell_request |=3D vcpu->arch.vcore->dpdes;
> +		else
> +			cpu->arch.doorbell_request =3D 0;

[Severity: Low]
Is there a typo in this assignment?

Using cpu instead of vcpu here appears to cause a build failure due to an
undeclared identifier.

> +	} else {
> +		vcpu->arch.doorbell_request =3D 0;

[Severity: High]
Could this unconditional clear overwrite concurrent doorbell requests from
sibling vCPUs?

If a sibling vCPU executes msgsndp and sets doorbell_request to 1 while the
target vCPU is executing the L2 guest, that update might be lost.

When the target vCPU exits with vcpu->arch.vcore->dpdes =3D=3D 0, this path
would wipe out any concurrent doorbell_request set by the sibling during the
guest's execution or exit process. Would this cause guest SMT threads to
miss IPIs and hang?

> +	}
> +
>  	timer_rearm_host_dec(*tb);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803034426.4424=
9-1-vaibhav@linux.ibm.com?part=3D1
