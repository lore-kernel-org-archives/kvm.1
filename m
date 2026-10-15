Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45316381B0A
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 07:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047941; cv=none; b=mHbu4y0es2h67FwTqecNtBzBf72JMM1walPKmQzYvu4CUM5ULOKkuFCStFXOPDbZ409f9kbCSMkVtVKY/3t0rG1mXWUXioQ4kb9N+v6JVwe4eSTDJQVrGOti+s27965UNmWRZ6gs2rAXLTmswfPW8+o7QKswEbnOq7me2sdcRgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047941; c=relaxed/simple;
	bh=/PnPoY6JLxGPRKO525ZBC3e8TrcKiObfr3XaM7M2IlQ=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=EPnJC4803q5Di3HZq5liqG9nQ9Vx9gqKKFvJKOgaAhdWvPaltWaMbVyyZGrHxHWx6yYtMr7pEhKThpZtHAM/7PkkCbHRr2p2iqp4kZiVbsjX9MG7KROm2TBV2MvPxwBGn3hNjCcj7XnNMpne07UdWbZzhyQ046xTqZhMz+o5vJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kj306cNC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kj306cNC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5D51F000C4;
	Thu, 15 Oct 2026 07:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792047927;
	bh=AS/0fPBV5W+/I1CsHZ/snnQg5WpelptIMiMQjf9C2/A=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=kj306cNCydrDk9d0AsXCI8XvIyFrtAjhGrd4WKM5+lFVLF3+I42pF67mngq8Vx9yH
	 lY5zhNKKitxaXj7Oalr4chsibrhCS76GF2MOGoFXDfOszVV9oyOYREFX6XwplRwJgK
	 BN0HxBKtqI6EO87pzSfN/aeX1RjlOdPQTUhVS0yI97GgPEj5IxIC+fE5lHFoR47FYk
	 WDN3QY1IO9sZjYipdB+oKbRDxXGzhdA84WbUFORYoR6FyUA3TKGN1iWx1rRQlp8Sc0
	 sbHTBn3Z5IIp5+w2i2a/UJu4aM+h+4HDjnZwZnqWpC7vjmWTB2rIq9m2LNZOB9TgZl
	 /MK2UCEVhUNPw==
Message-ID: <sashiko-outbox-172379@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/7] KVM: SVM: Add support for AMD IOMMU Guest APIC
 Physical Processor Interrupt (GAPPI)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>, kvm@vger.kernel.org
In-Reply-To: <20261015064515.10700-7-sarunkod@amd.com>
References: <20261015064515.10700-1-sarunkod@amd.com>
 <20261015064515.10700-7-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 07:05:26 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: svm: vCPU leaked on GAPPI pi_wakeup_list when AVIC deactiva=
ted
--

commit cd7fa3c00904984a2127bee934d4e48326ead7a8
Author: Sairaj Kodilkar <sarunkod@amd.com>

    KVM: SVM: Add support for AMD IOMMU Guest APIC Physical Processor Inter=
rupt (GAPPI)
   =20
    With AVIC guest-mode interrupt remapping, device interrupts are posted =
into
    the guest vAPIC backing page by the IOMMU. When the vCPU is not running
    (IRTE[IsRun] =3D 0), KVM must still be notified to schedule it. The leg=
acy
    path uses the GA log.

> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 8b1fa5bded3db..054b89c3cb0f9 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
[ ... ]
> @@ -1018,7 +1038,7 @@ enum avic_vcpu_action {
>  };
> =20
>  static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int a=
picid,
> -					    enum avic_vcpu_action action)
> +					    int cpu, enum avic_vcpu_action action)
>  {
>  	bool wakeup_intr =3D (action & AVIC_START_BLOCKING);
>  	bool is_running =3D apicid >=3D 0;
> @@ -1027,6 +1047,14 @@ static void avic_update_iommu_vcpu_affinity(struct=
 kvm_vcpu *vcpu, int apicid,
> =20
>  	lockdep_assert_held(&svm->ir_list_lock);
> =20
> +	if (amd_iommu_gappi && is_running) {
> +		kvm_pi_disable_wakeup_handler(vcpu, svm->gappi_cpu);
> +		svm->gappi_cpu =3D cpu; /* Store cpu number as target for GAPPI */
> +	} else if (amd_iommu_gappi) {
> +		apicid =3D cpu_physical_id(svm->gappi_cpu);
> +		kvm_pi_enable_wakeup_handler(vcpu, svm->gappi_cpu);
> +	}
> +

[Severity: Medium]
Does this unconditionally add the vCPU to the pi_wakeup_list when is_runnin=
g is
false, even during AVIC_DEACTIVATE?

When AVIC is deactivated via avic_refresh_apicv_exec_ctrl(), it calls
__avic_vcpu_put(AVIC_DEACTIVATE), which in turn calls
avic_update_iommu_vcpu_affinity() with a target apicid of -1 (so is_running
is false). This causes KVM to add the vCPU to the pi_wakeup_list of
svm->gappi_cpu.

Since AVIC is deactivated, the IOMMU falls back to legacy mode later in this
function:

	if (!(action & AVIC_TOGGLE_ON_OFF))
		WARN_ON_ONCE(amd_iommu_update_ga(...));
	else if (is_running)
		WARN_ON_ONCE(amd_iommu_activate_guest_mode(...));
	else
		WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(data));

Because the IOMMU is reverted to legacy mode, it will not send GAPPI interr=
upts
for this vCPU.

However, the vCPU remains indefinitely on the per-CPU pi_wakeup_list because
subsequent context switches (via svm_vcpu_load()) ignore deactivated vCPUs =
and
will never call kvm_pi_disable_wakeup_handler().

Could this cause KVM to unnecessarily traverse the leaked vCPU on every GAP=
PI
interrupt targeted at that pCPU from other active VMs, wasting CPU cycles a=
nd
risking spurious wakeups?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015064515.1070=
0-1-sarunkod@amd.com?part=3D6
