Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5C12C11E1
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933899; cv=none; b=ebPuqX9grZUpbPOCYQpoeAFThA/D9QGERwMYJ38g3Rh9vwXmDWArT2zuTflyHKTr+2w5U0Wl/vYEtCchPB20B79DZXN24ZK+KgCGCXuaS96E/uOGoMn2K3UanTmaRhA8qoGq7P84Ljp4YRvm4Im6B58sbwhUqhUwAdyxm8xtC0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933899; c=relaxed/simple;
	bh=0eLEJzXjIRqVlckikGvhSVtmPEP61N8tYoxqFSdKfik=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LfZhvS4F67pLQB5TQLFEkyIcP12CEs2Pp7iPWfReaSleSFWlebl7SbsyZteZCtRwTcPQbqEXEqljviSgbcqvB0dUPJSdkjbFypbrchr8bKP6u+uUpWjqYvOemyFYz1xuVuf7bWvJKjc8XcBn+eINk1oam+jwpkkNW/DVQ/4dYJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzB51EAy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzB51EAy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664E71F00893;
	Mon,  8 Jun 2026 15:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780933898;
	bh=QK2XgJcX6vRXA/gpehDwc7SqopLNrSiNOfxvBdtoW+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lzB51EAy2i/B7PpPieMG9E6ry6gdqvPEajPSHk9qAS1dfPfHMYOXsMsDL9PADFNLV
	 hW/UXVhHAUip8Yio0GNP5Uy+nlitP/8IetcFzSKZWw38GJk1WSuykNvog8BRg4kT5b
	 oS9DoB0OF28gxZBGBni9gF4mTcbZRzamCylFMUe6PsL8FUllTzqeMLbbYgJ1aP/yWI
	 L+wIKrMOET91SSpcBouMTJdUhdrc1qdCJglK6ND9ZWbdTEp1GmxA6YnngsOUyx+Xfu
	 zMbIwyhrbhkBXbdcchS9qWjYCk8W9wSPwZqVpb7tjRBVmTsL63hB0YVlCeMJDTB/yl
	 LHo2XXCNYnuZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/60] kvm: Make kvm_running_vcpus point to struct
 kvm_vcpu_common
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-15-joro@8bytes.org>
References: <20260608144252.351443-15-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:51:38 +0000
Message-Id: <20260608155138.664E71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Unconditional dereference of a potentially NULL per-CPU variab=
le (`common`) in KVM hardware interrupt handlers.
--

commit f697a135faef85bfacb6055235544bacfb1b5251
Author: Joerg Roedel <joerg.roedel@amd.com>

kvm: Make kvm_running_vcpus point to struct kvm_vcpu_common

This commit updates the kvm_running_vcpu per-CPU variable to point to
struct kvm_vcpu_common instead of kvm_vcpu, aiming to eliminate the need
for updates during plane switches.

> diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
> index cbea4d9ee9552..b2c4f422414ef 100644
> --- a/arch/arm64/kvm/arch_timer.c
> +++ b/arch/arm64/kvm/arch_timer.c
> @@ -204,7 +204,8 @@ static void soft_timer_cancel(struct hrtimer *hrt)
> =20
>  static irqreturn_t kvm_arch_timer_handler(int irq, void *dev_id)
>  {
> -	struct kvm_vcpu *vcpu =3D *(struct kvm_vcpu **)dev_id;
> +	struct kvm_vcpu_common *common =3D *(struct kvm_vcpu_common **)dev_id;
> +	struct kvm_vcpu *vcpu =3D common->current_vcpu;

[Severity: Critical]
Can the per-CPU variable pointer be NULL here when the timer interrupt fire=
s?

As noted in the existing comment just below this in kvm_arch_timer_handler(=
),
hardware interrupts can fire asynchronously after vcpu_put() has already
cleared the per-CPU pointer because the hardware interrupt signal may not
have retired from the interrupt controller yet.

If common is NULL, dereferencing it immediately to access current_vcpu
would cause a host kernel panic in interrupt context. Should common be
checked before it is dereferenced?

>  	struct arch_timer_context *ctx;
>  	struct timer_map map;

[ ... ]

> diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-i=
nit.c
> index 933983bb20052..a12b89b423d5e 100644
> --- a/arch/arm64/kvm/vgic/vgic-init.c
> +++ b/arch/arm64/kvm/vgic/vgic-init.c
> @@ -730,7 +730,8 @@ void kvm_vgic_cpu_down(void)
> =20
>  static irqreturn_t vgic_maintenance_handler(int irq, void *data)
>  {
> -	struct kvm_vcpu *vcpu =3D *(struct kvm_vcpu **)data;
> +	struct kvm_vcpu_common *common =3D *(struct kvm_vcpu_common **)data;
> +	struct kvm_vcpu *vcpu =3D common->current_vcpu;

[Severity: Critical]
Could common also be NULL here during a maintenance interrupt?

Similar to the arch timer handler, if the vgic maintenance interrupt is
delivered asynchronously after the active vCPU has been put, dereferencing
common before checking it could result in a NULL pointer dereference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D14
