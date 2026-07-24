Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15494360EDC
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784915347; cv=none; b=nfiJT+NfY5dv7EwdZs3ilI9U15Rv1L5UvpJpmuSOhg9aw/tCrVP+L235JlqkOtjpGWJN1Gz0PlCF9ApfAhNJj5S2g8aaTey0OtwtRARK6TF47sq3IuftSNjAvbqzjk/QAIwubKLH12kVbeSQ2tOvjWI4QJ6BOPYIOlQUAeSyFV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784915347; c=relaxed/simple;
	bh=o8n+Gi9Gb7O9IY/G/NyEAPrSSVg5+1bBv9Hxi2V4ZDI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B/kYTjCgd79UsjfusueblAIqVyJ+ouLbm+vMOQO1EtoRxYwElr1gBeyryjLxEK6VKxQmH2snZdqRPFwAp9/LNPgu0St6C4x/8Kra1xLcqDIe4RuLleBDGuagyMWEUVPursJK1zSSN6vWB4JlUShpwgfrTp9kIBNgbKe6vFDVogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M77hvq7+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M77hvq7+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CBF1F000E9;
	Fri, 24 Jul 2026 17:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784915345;
	bh=YiY04GtwrfJzYrJUA+JveGdsIeMX4qF5j32ETs8KfJM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M77hvq7+BYhnTV0UhskzN5UJuFVOkSVseA0TmbuuLSCxOeC5K351OGlhMW7WXUq9w
	 v9BmbrZi0o5t0fBT1dlSOtSTdjNiFdl0jz4mBSihZH2IxUeIS1Ch7vl2jdhU4aCaR8
	 OP2cqVue17xsHG61CRq1F1gj8BIO2d40w9Xsu19TF6Gm8u71pD5hme5iYzrsa2ZKXR
	 8PooI1WOrc/oM8RKb2h5DhbfpJr3mw8ef0GMvvqVzGBe8AibTBqQcm07OPzjUON3z+
	 2zzQ7uhzxSDWHBy3B3DoWtlDQ98NY3uyzQIJHwxU22k1K7vWMPvJ7j3DRWIT7Sm3/I
	 Q+LO8CkW3c55w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] KVM: x86: Don't WARN if IRQ disappears because
 it was cleared from the PIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260724173425.278753-2-seanjc@google.com>
References: <20260724173425.278753-1-seanjc@google.com>
 <20260724173425.278753-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 17:49:05 +0000
Message-Id: <20260724174905.89CBF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch resolves false-positive WARNs for missing interrupts by =
suppressing them when an in-kernel PIC is used, but fails to handle Xen eve=
nt channels, leaving a guest-triggerable WARN for VMs without an in-kernel =
PIC.
--

--- Patch [1]: [PATCH v3 1/2] KVM: x86: Don't WARN if IRQ disappears becaus=
e it was cleared from the PIC ---
commit 6c8d9104c0454cc3f831a546f5333b795c67a6aa
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: Don't WARN if IRQ disappears because it was cleared from the PIC

This patch suppresses a warning when an IRQ disappears during injection for
VMs with an in-kernel PIC, as ExtINT handling tracks this per-VM. It keeps
the assert for split IRQCHIP VMs to help detect KVM bugs.

Closes: https://syzkaller.appspot.com/bug?extid=3Ddd769db18693736eee89
Closes: https://lore.kernel.org/all/6a360fdf.871e809a.2d6dda.0000.GAE@googl=
e.com

> diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
> index 1a84ea31e7fd2..eeaf527cecc46 100644
> --- a/arch/x86/kvm/irq.h
> +++ b/arch/x86/kvm/irq.h
> @@ -118,6 +118,22 @@ int kvm_cpu_has_extint(struct kvm_vcpu *v);
>  int kvm_cpu_get_extint(struct kvm_vcpu *v);
>  int kvm_cpu_get_interrupt(struct kvm_vcpu *v);
> =20
> +static inline void kvm_warn_on_lost_irq(struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * WARN if an IRQ was lost between detecting the IRQ and grabbing the
> +	 * IRQ for injection, unless it's possible the lost IRQ was due to one
> +	 * of the exceptional cases below.
> +	 *
> +	 * If the VM has an in-kernel PIC, the ExtINT handling that's routed
> +	 * through KVM's virtual PIC is tracked per-VM, not per-vCPU.  If
> +	 * another vCPU grabs the IRQ, or deasserts the interrupt (which is
> +	 * level-triggered), then it's both expected and "fine" for an IRQ
> +	 * seemingly be "lost" from this vCPU's perspective.
> +	 */
> +	WARN_ON_ONCE(!pic_in_kernel(vcpu->kvm));

[Severity: High]
This is a pre-existing issue, but does this warning also need to account for
Xen event channels?

If a guest is configured with a split IRQCHIP and Xen emulation, can a
malicious guest concurrently toggle evtchn_upcall_pending in its shared
vcpu_info memory to intentionally trigger this warning?

The guest could create a race condition where kvm_cpu_has_injectable_intr()
returns true, but the guest clears the flag before kvm_cpu_get_interrupt()
is called. This would result in an irq of -1, triggering the warning here
because pic_in_kernel() evaluates to false for split IRQCHIPs.

Could this be used by an unprivileged guest to cause a host denial of
service if panic_on_warn is enabled?

> +}
> +
>  void kvm_inject_pending_timer_irqs(struct kvm_vcpu *vcpu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724173425.2787=
53-1-seanjc@google.com?part=3D1
