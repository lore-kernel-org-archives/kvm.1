Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3489E35E1AD
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781118607; cv=none; b=nGmqsXWuTezQMWzRXqpSp1lF1IjTn+jT8EctpgGHmUmKF/uWBKng2evleyBtvTbJ8b8eRrpqovp2oirv4eapsc9p41IKfkCqGlXyJOmFG2TwB7TF9xpUdA9KBp+FS2/fnbXyQhIfBbSFVROKjeMYIRcQ6njBZ+dhEUCkleO7Lww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781118607; c=relaxed/simple;
	bh=hZNSV67JuHmfQtWprS1Y7e67EaDGRLPEvIVKQoJrkWU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XajE1Wjur6yGqumkDU7gO+BFlHqqVF2Wn3vuN02fA5Bf8uqzWdIRUY6doRye+lC7lVXwHOqf64kg4G/F6zEHY5pzJyIGm95kgzYn6r8bFkw08QZCyOq6Th8gWOG5NVGbc+wi2+draB8Zr9xyg2f2auUjaSTmGNpArZmnHBK4t3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVXJu+Hr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVXJu+Hr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F731F00893;
	Wed, 10 Jun 2026 19:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781118605;
	bh=5lCHaRx4+5CwxWscGckE6b9oHeqUtQkeax09RDARoJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bVXJu+Hrq0aHDamwcA5rOKiFTJS9w9lqzvecofRdPFBTFtuE7e7bpnaR9u1Ll/Api
	 Koq3bsT2QnxOgvtO1VgopirW25qaNhtnz83LOGhtwaTA0XgS2Yt/Sh71PNAHErK2Fr
	 I9dOzVy7Pd7RgG406PV+EUnvYtAxYF2DcGEnjMjdx1hZH1LT4Eiy7tW2ZM11XRxv1G
	 9yqgbD7fWov+u5i0FBkpjIwEbuQm8g7wbZb/PTKdcNjKE+CLatSaUe/4j5ZQeOI2uW
	 B8WikUQN9dKS19c8iL/bJCoc32l2csPRuInw4icy/ohN1l8VUsWq4cv7BzLjELVCY7
	 ousSso++YkAXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: VMX: Raise KVM_REQ_EVENT on TPR below threshold
 exit
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2FybG9zIEzDs3Bleg==?= <clopez@suse.de>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260610185042.2810880-2-clopez@suse.de>
References: <20260610185042.2810880-2-clopez@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 19:10:05 +0000
Message-Id: <20260610191005.93F731F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch successfully fixes the VM entry failure for hardware-ind=
uced TPR_BELOW_THRESHOLD exits but leaves the exact same vulnerability in s=
oftware-emulated TPR writes (MMIO, MSR, or intercepted CR8 writes). If the =
guest lowers TPR such that VTPR falls below TPR_THRESHOLD, but PPR does not=
 drop enough to unmask a pending interrupt (e.g., due to a higher-priority =
ISR), `apic_update_ppr()` will not raise KVM_REQ_EVENT. Consequently, `kvm_=
lapic_update_cr8_intercept()` is skipped, leaving a stale TPR_THRESHOLD in =
the VMCS that is strictly greater than VTPR[7:4]. On hardware without virtu=
al-interrupt delivery, this directly violates SDM VM-entry constraints, cau=
sing the exact same hardware error 0x7 VM entry failure the patch was inten=
ded to fix.
--

commit 277f13148f7967e36731fd691e61fdaf6d48f638
Author: Carlos L=C3=B3pez <clopez@suse.de>

KVM: VMX: Raise KVM_REQ_EVENT on TPR below threshold exit

This commit fixes a VM entry failure with hardware error 0x7 on older
platforms or under nested virtualization by re-introducing an unconditional
KVM_REQ_EVENT when handling TPR-below-threshold exits. This ensures that
vmx_update_cr8_intercept() is called to re-evaluate TPR_THRESHOLD.

Link: https://github.com/coconut-svsm/svsm/issues/1081 [1]

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index c548f22375ad6..21a469d3ba211 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5824,6 +5824,7 @@ void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned lo=
ng val)
>  static int handle_tpr_below_threshold(struct kvm_vcpu *vcpu)
>  {
>  	kvm_apic_update_ppr(vcpu);
> +	kvm_make_request(KVM_REQ_EVENT, vcpu);

[Severity: High]
This isn't a bug introduced by this patch, but does the same regression
still exist in the software-emulated TPR write paths?

Looking at apic_set_tpr() in arch/x86/kvm/lapic.c:

static void apic_set_tpr(struct kvm_lapic *apic, u32 tpr)
{
        kvm_lapic_set_reg(apic, APIC_TASKPRI, tpr);
        apic_update_ppr(apic);
}

If the guest lowers the TPR via MMIO, MSR, or an intercepted CR8 write such
that VTPR falls below TPR_THRESHOLD, but the PPR does not drop enough to
unmask a pending interrupt, apic_update_ppr() will not raise KVM_REQ_EVENT.

Consequently, kvm_lapic_update_cr8_intercept() would be skipped, leaving a
stale TPR_THRESHOLD in the VMCS that is strictly greater than VTPR[7:4].

Could this lead to the exact same hardware error 0x7 VM entry failure that
this patch aims to fix?

>  	return 1;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610185042.2810=
880-2-clopez@suse.de?part=3D1
