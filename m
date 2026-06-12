Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9002FE074
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 03:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781235994; cv=none; b=jYlmTY8S6nzcTTDF+nlCkRmzzam7IdzIC9WZ/0aEv+rb+Ti0oXkeTCdNjU1ih60O2knxQWh3evLjN9q0xbalQPNmMfgXAJDWynjFdrvdN3ZEvrsUygajsYy2qGAymBVP5K0JkNih6jLZAuyLg6/7uHdTdsbabcKXxd8N+Y8CchU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781235994; c=relaxed/simple;
	bh=y4YccP15eAvDweHUB0+Xw/n4fcgaXHaYmtm9jZK0XZE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iofUrQhVDnlqdupMktfVmksUEzivaFukQPowico7dcG5GwOUdrxfuLPTmQmtlDxC1JU3MyqREj4oHDQW8G5D2VDffBzs/6r7Ml2kdgiJ23+P7lRn1BgcQiXrl3lxPNeJXTgYOFqv9ukqxTJ+l5ZKKq7MDo2bBHcvCqZy3XKWnjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFVEmKMe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFVEmKMe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023F11F000E9;
	Fri, 12 Jun 2026 03:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781235993;
	bh=BZFiqPt3451m3YLMgE+uxEi285sfMk7fMMPe/q02Yms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PFVEmKMeaOpCZadv/xS1ye99tJnIcKRGJ9XcRNVB1h2Q7jUytuW6xSB54Vm4OIgIv
	 CHSAnNgKmgkk7fQVr0kdlHs4NVPL2bTrSB8SsXPri269qe4icyCj6Y2NcaellBbblk
	 61giTZe1P4Send27rJSahqFO+TtrQV1zQTPugYkLknjt3Qfk6cTBkSQX0w9UfOq/gr
	 Sz3AnviaqvBsyG2ALfmN2cRa32LO0vMfYiQ1M3Nm2dnXiDxbXqdUNpkVvwbSK44WUD
	 F292Omg3amNNc1kiZKXi/aPURSQ6T118hTWREFy87G/e4a5UFOlE9O6cp7+4zrZtbC
	 aDVDAHiT4GyKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/10] KVM: x86/lapic: Clear IPI tracking on
 matching-vector EOI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wanpeng Li" <kernellwp@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260612013355.59231-9-kernellwp@gmail.com>
References: <20260612013355.59231-9-kernellwp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 03:46:32 +0000
Message-Id: <20260612034633.023F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The EOI handler incorrectly clears the vCPU's outgoing IPI track=
ing state when acknowledging an incoming IPI due to conflated incoming and =
outgoing tracking fields.
--

commit f711eb495ad18e2339b40d0c737023fdb3459a71
Author: Wanpeng Li <wanpengli@tencent.com>

KVM: x86/lapic: Clear IPI tracking on matching-vector EOI

This commit updates apic_set_eoi() and kvm_apic_set_eoi_accelerated() to
clear IPI tracking state only when the EOI vector matches the tracked
vector, aiming to prevent eviction of pending contexts when unrelated
interrupts are handled.

> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
[ ... ]
> +static void kvm_clear_ipi_on_eoi(struct kvm_lapic *apic, int vector)
> +{
> +	struct kvm_vcpu *receiver =3D apic->vcpu;
> +	struct kvm_vcpu *sender;
> +	int sender_idx;
> +	u64 then, now;
> +
> +	if (unlikely(!READ_ONCE(ipi_tracking_enabled)))
> +		return;
> +
> +	if (vector < 0 || vector > 0xff)
> +		return;
> +
> +	if (READ_ONCE(receiver->arch.ipi_context.vector) !=3D (u8)vector)
> +		return;
> +
> +	sender_idx =3D READ_ONCE(receiver->arch.ipi_context.last_ipi_sender);
> +	kvm_vcpu_clear_ipi_context(receiver);

[Severity: Medium]
Does calling kvm_vcpu_clear_ipi_context() here unintentionally clear the
vCPU's outgoing IPI tracking state?

Looking at kvm_vcpu_clear_ipi_context(), it clears the entire ipi_context
structure, including pending_ipi and last_ipi_receiver. Since a vCPU can
act as both a sender and a receiver concurrently, acknowledging an incoming
IPI here appears to erase the vCPU's state as a sender.

Could this destroy the directed yield hint and cause concurrent IPI sender
and receiver vCPUs to miss the yield optimization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612013355.5923=
1-1-kernellwp@gmail.com?part=3D8
