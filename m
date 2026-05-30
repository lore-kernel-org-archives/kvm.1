Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3095C13A244
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780132971; cv=none; b=h044nvlYcxBa09uLhxT8ww5yTNq4SVyeS9YCKsB3nUvRPa620Ug8WSD6Z/0PXCLrZDW0QxIQSpSdw4kHePK+v1TyukojVPVGdpJ78Xfbq9PENniL/Rn7MfjPTD0XUZlm2hH2/ZkFK/ORJV1LMDMa2tbSyCxAPObE8f7+yJUNnls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780132971; c=relaxed/simple;
	bh=zY0qnIRu1UmYghQw5aPvV0afPVfkKOXXFC2Wt/u4Yo4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SElxXqqngUM99UM5ZIgXBHiuh/t7fzl7i0jO4ptdKGwUvLgT+RBVNEbCOBYER8/Z5t03GTvtct9opEE1bKTqU80fAJQX47TrAFuhy1JxgmXbRMZ76rvQTgYH29fWdJYII9GIRWHF2KXPBvCe0aFQKLTHa7wnlv9eD/1SJddFc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwX3gIIF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwX3gIIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C3E1F00893;
	Sat, 30 May 2026 09:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780132969;
	bh=7CDmyrcxlv7vwY5ZNdVFG6CxQXX9LbL/nh+ljOWEYIE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MwX3gIIFF9rjlt8EC56hz7hB0Vw3U6knLnCArGZQ6t40CEw6FteaPwGnXQK2WKP5P
	 5BVNB7L7wb68BTxgkX7/HpuWii+ETfNJFRAHT+FdjPQYj2O8xwyHj09R9SPSql9eH0
	 svo3kQERquj1IPDGmFAqWDQxhP7oK2jTWG4LBtIDf34rcchrUsX431NJkzj05MFLQa
	 EngBtOUH7JeUxprlRyzxvP/MJm3sMnuqoEbTzin1o9fxP+woscTo9rpKEAWi+YDFcQ
	 0RBqlzxG8SRhYqPkXyrJ25mZA0Cc3BXTKCkxtHso5dhUzTTollsocUSgQlWUrj9Vv6
	 YfXqxmD7GFFpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 26/27] KVM: s390: arm64: Implement basic page fault
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529155050.2902245-27-seiden@linux.ibm.com>
References: <20260529155050.2902245-27-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 09:22:48 +0000
Message-Id: <20260530092249.A0C3E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Guest-reachable or hardware-driven edge cases trigger WARN_ON/BUG_=
ON macros, creating a host Denial of Service vector.
- [Low] Unused parameters `slot` and `hva` in `user_mem_abort()`.

Pre-existing issues:
- [Critical] Handling traps in-kernel causes an infinite loop because the g=
uest PC is not advanced before re-entering the guest.
- [High] The VCPU run loop unconditionally enters the guest, ignoring the r=
eturn value of `check_vcpu_requests()`.
--

commit 6963b72c83b66b00932e10f26e0df9e655610d27
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement basic page fault handler

Add host functionality to page in guest memory. If the guest does
something unexpected or illegal exit to userspace which very likely has
to stop guest execution. This behaviour will be changed to guest error
injects once all sysregs are accessible for the host.

> diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> index 18eca2261e0da..bf0866659421a 100644
> --- a/arch/s390/kvm/arm64/arm.c
> +++ b/arch/s390/kvm/arm64/arm.c
> @@ -437,6 +437,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  				  vcpu->arch.sae_block.vir);
>  			ret =3D -EINVAL;
>  			break;
> +		case SAE_ICPTR_HOST_ACCESS_EXCEPTION:
>  		case SAE_ICPTR_SYNCHRONOUS_EXCEPTION:
>  			ret =3D handle_trap_exceptions(vcpu);
>  			break;

[Severity: High]
This is a pre-existing issue, but since we are modifying the run loop handl=
ing
here, is there an issue with how check_vcpu_requests() return values are
handled?

Looking at kvm_arch_vcpu_ioctl_run(), check_vcpu_requests() is called and i=
ts
result is assigned to ret, but then arm_vcpu_run(vcpu) is called
unconditionally immediately after. Does this bypass pending signals, IPIs, =
and
userspace exits if check_vcpu_requests() returns a value less than or equal=
 to
0?

[ ... ]

> diff --git a/arch/s390/kvm/arm64/mmu.c b/arch/s390/kvm/arm64/mmu.c
> new file mode 100644
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/mmu.c

[ ... ]

> +static int user_mem_abort(struct kvm_vcpu *vcpu, gpa_t fault_ipa,
> +			  struct kvm_memory_slot *slot, hva_t hva)
> +{

[Severity: Low]
Do we need the slot and hva parameters in this function? It looks like they
are unused since kvm_s390_faultin_gfn() handles the page translation itself.

> +	struct guest_fault f =3D { };
> +	int ret;

[ ... ]

> +static int kvm_handle_pic(struct kvm_vcpu *vcpu, bool *translation)
> +{
> +	switch (kvm_vcpu_fault_pic(vcpu)) {

[ ... ]

> +	/* unexpected cases: */
> +	case 0:
> +		KVM_BUG(1, vcpu->kvm, "On MMU fault path but no fault occurred");
> +		return -EFAULT;
> +	default:
> +		KVM_BUG(1, vcpu->kvm, "Unexpected program interrupt 0x%x, TEID 0x%016l=
x",
> +			vcpu->arch.sae_block.hai.pic, vcpu->arch.sae_block.hai.teid.val);

[Severity: High]
Can this KVM_BUG be triggered by a guest action? If an unexpected program
interrupt can be driven by guest behavior, it would hit this macro which
expands to a WARN_ONCE, potentially creating a host denial of service vector
via log spam.

> +		send_sig(SIGSEGV, current, 0);
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
> +{

[ ... ]

> +		/*
> +		 * Check for a cache maintenance operation. Assume the guest is
> +		 * cautious and skip instruction
> +		 */
> +		if (kvm_is_error_hva(hva) && kvm_vcpu_dabt_is_cm(vcpu)) {
> +			kvm_incr_pc(vcpu);
> +			ret =3D 1;
> +			goto out_unlock;

[Severity: Critical]
This is a pre-existing issue, but does returning 1 here to resume the guest
result in an infinite loop?=20

When kvm_incr_pc() sets the INCREMENT_PC flag and ret is set to 1, the run =
loop
in kvm_arch_vcpu_ioctl_run() iterates without calling adjust_pc(), because
adjust_pc() is located at the out label completely outside the do-while loo=
p:

arch/s390/kvm/arm64/arm.c:kvm_arch_vcpu_ioctl_run() {
    ...
    do {
        ...
        arm_vcpu_run(vcpu);
        ...
    } while (ret > 0);

out:
    if (unlikely(vcpu_get_flag(vcpu, INCREMENT_PC)))
        adjust_pc(vcpu);
}

Would this cause arm_vcpu_run() to be re-executed with the exact same PC,
hanging the host thread?

[ ... ]

> +	/* Userspace should not be able to register out-of-bounds IPAs */
> +	VM_BUG_ON(fault_ipa >=3D kvm_phys_size(vcpu->kvm));
> +	/*
> +	 * Proper guest size faults have been injected.
> +	 * In theory it's fine to have device memory higher than MSL,
> +	 * even if not currently possible, but that would have been handled abo=
ve.
> +	 * So if we get here with a guest size intercept, we have a bug somewhe=
re.
> +	 */
> +	VM_BUG_ON(guest_size_err);

[Severity: High]
Is it possible for a guest to trigger this assertion? If a guest triggers an
address size fault where fault_ipa < kvm_phys_size(vcpu->kvm), the host ker=
nel
would hit this VM_BUG_ON. This could cause a panic when CONFIG_DEBUG_VM is
enabled.

> +
> +	ret =3D user_mem_abort(vcpu, fault_ipa, memslot, hva);
> +	if (!ret)
> +		ret =3D 1;
> +out_unlock:
> +	srcu_read_unlock(&vcpu->kvm->srcu, idx);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529155050.2902=
245-1-seiden@linux.ibm.com?part=3D26
