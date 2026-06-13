Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711AF846A
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309802; cv=none; b=OWYGKsPvj4Iu3LRayjpVXXFzrsLtkH9xza4VJAwGyMe6ZW50FGqICGsPNROPGr/w+ghxePReNhkB/2GFAwt7WbAeOb3QZxom/Tit6bTeDVMbinmtH/7kPeGJfwBAg6LmPsZEtLtkx1zrHFO9g2L0DRq5lflYWeGDGK8alJA/AWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309802; c=relaxed/simple;
	bh=Pr30ax+iR3EwndUagMtMWl84J7NAFVi8ufgd8UjGlQo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TZNcbBDbS0z5Kso2hIHpdIa60bcIuMMITH1bUIitJKZSvNaFFrWopfCihTu9pmJAbPIDaPsR8VJvH3hsTBZBnm8kJyLxgzEBdGPdMKpQW9BWQVjege9ylkSv5qurkY587IaySBnrYK+2kjesBrqAxt07Hf4mmxsjzoT3RUYAb7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMkZ7qYH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMkZ7qYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040611F000E9;
	Sat, 13 Jun 2026 00:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781309801;
	bh=GjfXLtKJHHy4vpbFA3ZFzxhflhibh5dKomg9GmxRJQA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RMkZ7qYHgMgXZb+v7QBITGlmAXzY3HMvHXzL8vELsaC34isBmi2WQvIvdX3bpyu9g
	 RoNOBmElGkUcBIZeOergH94HMxzj3lRBPyvhnSmo45uGd960s+Sb4M+Z1vC/0xF7fj
	 rm+aPXziCaqwriAQjRGMScorGkR5Gid+oLgy13YlcUg7TsPtesCXzq1D81dL8BPngS
	 tVgbAYkzMtJwuWzpS/uO8agjQKOm6MtoQUrFcB9TYJTrBBOatGSm2b6TxfZ2xbJENS
	 6F6SsKz0cj5kjeSYDpz45iLe/OdCTlebJzs0UgGCzoUS3LUU+c4d12Z2NrYqZP88C8
	 6e/iejbY4d9XQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/30] KVM: x86: Expose several TSC helpers via x86.h
 for use by MSR code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260613000329.732085-14-seanjc@google.com>
References: <20260613000329.732085-14-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 00:16:40 +0000
Message-Id: <20260613001641.040611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless iteration of `vm_list` in `kvm_arch_enable_virtualization=
_cpu` during CPU hotplug.
- [High] Lockless cross-CPU modification of `vcpu->arch.tsc_offset_adjustme=
nt`.
--

commit ab7eedcd233e127b5aac182b220a36fa043a7767
Author: Sean Christopherson <seanjc@google.com>
Date:   Sat Jun 13 00:03:12 2026 +0000

KVM: x86: Expose several TSC helpers via x86.h for use by MSR code

Begrudgingly move adjust_tsc_offset_{guest,host}() to x86.h as inlines,
and expose several other TSC helpers in anticipation of moving KVM's MSR
code to a dedicated msrs.c. Unfortunately for KVM, several MSRs that KVM
emulates can affect TSC state.

Opportunistically drop a superfluous local "tsc_offset" variable, whose
existence causes checkpatch to complain about lack of a blank line.

No functional change intended.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ece8d53fb7fe6..316ec7a57f7dd 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -2448,22 +2448,6 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *v=
cpu, u64 *user_value)
>  	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
>  }
> =20
> -static inline void adjust_tsc_offset_guest(struct kvm_vcpu *vcpu,
> -					   s64 adjustment)
> -{
> -	u64 tsc_offset =3D vcpu->arch.l1_tsc_offset;
> -	kvm_vcpu_write_tsc_offset(vcpu, tsc_offset + adjustment);
> -}
> -
> -static inline void adjust_tsc_offset_host(struct kvm_vcpu *vcpu, s64 adj=
ustment)
> -{
> -	if (vcpu->arch.l1_tsc_scaling_ratio !=3D kvm_caps.default_tsc_scaling_r=
atio)
> -		WARN_ON(adjustment < 0);
> -	adjustment =3D kvm_scale_tsc((u64) adjustment,
> -				   vcpu->arch.l1_tsc_scaling_ratio);
> -	adjust_tsc_offset_guest(vcpu, adjustment);
> -}
> -
>  #ifdef CONFIG_X86_64
> =20
>  static u64 read_tsc(void)

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing these TSC
offset adjustments I noticed a race condition in how
vcpu->arch.tsc_offset_adjustment is updated during CPU hotplug.

In kvm_arch_enable_virtualization_cpu(), there is a lockless cross-CPU
modification of vcpu->arch.tsc_offset_adjustment:

arch/x86/kvm/x86.c:kvm_arch_enable_virtualization_cpu()
	if (backwards_tsc) {
		u64 delta_cyc =3D max_tsc - local_tsc;
		list_for_each_entry(kvm, &vm_list, vm_list) {
			kvm->arch.backwards_tsc_observed =3D true;
			kvm_for_each_vcpu(i, vcpu, kvm) {
				vcpu->arch.tsc_offset_adjustment +=3D delta_cyc;

Since CPU hotplug only pauses the CPU being brought online, could the
targeted VCPU be concurrently executing kvm_arch_vcpu_load() on another CPU?

If kvm_arch_vcpu_load() reads and clears this field concurrently without
vcpu->mutex, could the adjustment be lost or applied twice and lead to
incorrect guest TSC values?

[Severity: High]
This is a pre-existing issue, but I also noticed that the iteration over
vm_list in kvm_arch_enable_virtualization_cpu() is lockless:

arch/x86/kvm/x86.c:kvm_arch_enable_virtualization_cpu()
	list_for_each_entry(kvm, &vm_list, vm_list) {
		kvm_for_each_vcpu(i, vcpu, kvm) {

If a user concurrently creates or destroys a VM (which modifies vm_list
under kvm_lock), couldn't this lockless list_for_each_entry() dereference
poisoned pointers from list_del() during destruction, leading to a kernel
panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613000329.7320=
85-1-seanjc@google.com?part=3D13
