Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E1940DB5A
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832805; cv=none; b=XbMdDqX1kr+j5lLeM2oQALa70SxEDT2opYWHODdxJTUasDhOD/nabrlJikcY93JTGDMgh3X9eT5kWiky1CL2PRZpkShVZiLNwgI55L0OtaEwXIC8Hq8H2Px4D+Ii2ZhXvJNeuhR+iNWomzXfw4IUvmK5T6f8ReoEs+6tnCrsu1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832805; c=relaxed/simple;
	bh=ZklQP9gLtI0KostCZf71B8sLpLclJMgG2IG3vgSqYK8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hISRM9xAwdwwqRUAbVwLkWmbuxcdFMV3+S4hsci82hi2SXytt4dpFc7JLuFUESiibLMduijEKtFITtfgf8ApgQAvKud9Z57+j77mOLYUzAWZiH+66gVDVFlbjYTzNtHUxD6yvhbRjpzMPOzteOTx91QilxO0Oh0zYrYKaXwY5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kS0p4LDo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kS0p4LDo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2A61F000E9;
	Tue,  4 Aug 2026 08:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785832801;
	bh=gn+8WfuKGBCCRT0Cd64ANX1rSrBovZY8RCG7Qj89V8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kS0p4LDoLdpvGD1Hpm3pc+P82fh1BNRz2lyINAeTfmNSIDDGqjtsrO8p4DtvxcqWt
	 aOeuDZNiB2BKmQy3VGmlYmaV9XWPVQmLbaLqLgPuVVEvke35D2rMjDBLGIhdJNSSE1
	 4c4ODK/YTlKo209oVS9sjskQ6xLoc+W+z7aaUFn7m3+0XxSeZt1yoVI3vuZXb+qL4f
	 mq19+0ae+Lz3WemgrR4kYgWrNkEURNAIIkXm7gQU4C2t25lysiFof2bzvBEjmvjyaB
	 YeYSufHZ0zllqKzYMqnsOAfMh2q7Pb3YOLAywVI10DWv0FxP418VaV62eOIfwqdk6J
	 oV7xloV5PPCJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] LoongArch: KVM: Advertise already-supported
 capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260804082604.178092-1-cui.tao@linux.dev>
References: <20260804082604.178092-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 08:40:00 +0000
Message-Id: <20260804084001.6A2A61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Falsely advertising KVM_CAP_IRQFD_RESAMPLE without underlying arch=
itecture support leads to broken level-triggered interrupts (e.g., VFIO INT=
x pass-through).
--

--- Patch [1]: [PATCH] LoongArch: KVM: Advertise already-supported capabili=
ties ---
commit 09ee78983007b60953a55e2354d4d1971a9bc4c7
Author: Tao Cui <cui.tao@linux.dev>
LoongArch: KVM: Advertise already-supported capabilities

This commit advertises several KVM capabilities for LoongArch to userspace
that are noted as already supported. It enables discovery for
KVM_CAP_STEAL_TIME, KVM_CAP_IRQFD_RESAMPLE, KVM_CAP_VM_GPA_BITS, and
KVM_CAP_VCPU_ATTRIBUTES.

> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> --- a/arch/loongarch/kvm/vm.c
> +++ b/arch/loongarch/kvm/vm.c
[ ... ]
> @@ -120,8 +120,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lo=
ng ext)
>  	case KVM_CAP_READONLY_MEM:
>  	case KVM_CAP_IMMEDIATE_EXIT:
>  	case KVM_CAP_IOEVENTFD:
> +	case KVM_CAP_IRQFD_RESAMPLE:

[Severity: High]
Does the underlying architecture actually support IRQFD resamplers?

The commit message states the resampler is generic code backed by the
in-kernel irqchip. However, the generic irqfd resampler relies entirely
on the architecture's in-kernel irqchip explicitly calling
kvm_notify_acked_irq(), kvm_notify_acked_gsi(), or similar hooks when the
guest acknowledges the interrupt.

If the LoongArch irqchip implementations do not call any of these
notification hooks, the resampler will never trigger. Will this cause
physical interrupts to remain permanently masked after their first
injection, potentially hanging passed-through devices that rely on
level-triggered interrupts (such as VFIO INTx pass-through)?

>  	case KVM_CAP_MP_STATE:
>  	case KVM_CAP_SET_GUEST_DEBUG:
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804082604.1780=
92-1-cui.tao@linux.dev?part=3D1
