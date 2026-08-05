Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F003D300F
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962878; cv=none; b=mOgMmWhA+5J8O0BB1NjehSJTB2EMnRbV3Jg/82Vl2JM03aTySWN0gI53pNDKfobwQhapCaNxDs9z7IkM+8Br6cSx/gYmzEjYvNZo+vRuz05f9qtIZ0K76zKm62CQJk8xOMwENjjXsx64jlpVsPkMx+7EtWsKWyfuZFCzDdbta8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962878; c=relaxed/simple;
	bh=/BjKphHFdjs2Rjdpm/BgqW4T/OOnLtJVOWTA+xCMW2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d6ZLT8tjzw7n12FcJNk/64RCOgBHZ6Mf/C+bWztjaWq1wZdMJ3QcHg2k7eLf/WQkDFp1HgIKcjvUQ/U1HL/WA03g8pECz72Z6rImGKIS188va/0gi+dOGRbR82VZNlv8WKd9uaIhSo9g4lgu/LstFhEH6LbsgrPGXjOzUnJKnQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVtykuuv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVtykuuv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0371F000E9;
	Wed,  5 Aug 2026 20:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785962876;
	bh=o+gN0IGyvHeVPV3W2sSBthsRXnHcAeh78/lgxUbeTfU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mVtykuuvuDfEI8NGUMZpPQp9O4petw4ClEG5Fzd1/X/MN0fzAYEV2AO3+VFTIcMUl
	 G7q5sbw9A11TTEEEQBd0iADwcgfW2udeOfnGT7hfycxv9R3uZ0XN5MA6od+G8o2ibq
	 9FUuI8hXLt/22OLi/f5TXrounzl1dvFtvZgZ6Ly6u7CugGA+U/Dw822kfH5v4vzOyT
	 M1AIlG3E7w3hT9LPexh9Y5vlBn7eH2Njr5xo29FNfooThh5eaiToTtNqjgC80xYPI7
	 2hKNF7Md25zzaWXW1MAf0BRFVO856ryAojBBbb9X/Z/g4mRNhprqz4WSUGVyOpPKAT
	 9b5IkbPE1JDZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] KVM: x86/xen: Extract delivery of event to vCPU
 into a separate helper
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?V29vZGhvdXNlLCBEYXZpZA==?= <dwmw@amazon.co.uk>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260805195528.3853473-5-dwmw@amazon.co.uk>
References: <20260805195528.3853473-1-dwmw@amazon.co.uk>
 <20260805195528.3853473-5-dwmw@amazon.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 20:47:55 +0000
Message-Id: <20260805204755.EA0371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The refactored helper injects an MSI instead of forcing a VM-exit =
when the vcpu_info cache check fails.

Pre-existing issues:
- [Critical] The host can be forced to perform unaligned atomic operations =
on guest-controlled memory, leading to a Denial of Service via split lock.
--

--- Patch [4]: [PATCH v3 4/7] KVM: x86/xen: Extract delivery of event to vC=
PU into a separate helper ---
commit de0f33b78cabce7ad4bdfa1d85f662391c0c5256
Author: Woodhouse, David <dwmw@amazon.co.uk>
KVM: x86/xen: Extract delivery of event to vCPU into a separate helper

This commit moves the marking of an event as pending in the target vCPU's
vcpu_info into a separate helper function, __kvm_xen_set_evtchn_fast().
The intent is to improve readability without causing functional changes.

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c

[ ... ]

> +/* Called with kvm->srcu held, as kvm_gpc_check() consults the memslots.=
 */
> +static void __kvm_xen_set_evtchn_fast(struct kvm_vcpu *vcpu, int port_wo=
rd_bit)
> +{
> +	struct gfn_to_pfn_cache *gpc =3D &vcpu->arch.xen.vcpu_info_cache;
> +	bool kick_vcpu =3D false;
> +
> +	/* Now switch to the vCPU's vcpu_info to set the index and pending_sel =
*/
> +	rcu_read_lock();
> +	if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
> +		/*
> +		 * Could not access the vcpu_info. Set the bit in-kernel and
> +		 * prod the vCPU to deliver it for itself.
> +		 */
> +		if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_se=
l))
> +			kick_vcpu =3D true;
> +		goto out_unlock;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_64BIT) && vcpu->kvm->arch.xen.long_mode) {
> +		struct vcpu_info *vcpu_info =3D gpc->khva;
> +
> +		if (!test_and_set_bit(port_word_bit, &vcpu_info->evtchn_pending_sel)) {

[Severity: Critical]
This is a pre-existing issue, but does test_and_set_bit() here risk a
host denial of service via a hardware split lock?

If a guest or userspace sets the vcpu_info GPA via
KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO to an unaligned address such that
evtchn_pending_sel spans a 64-byte cache line boundary, the 8-byte
atomic lock bts instruction could trigger an #AC exception.

If the host kernel is configured with split_lock_detect=3Dfatal and
panic_on_oops, this would panic the host.

This also applies to the 32-bit compat branch below where the pointer
is cast to unsigned long *.

> +			WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
> +			kick_vcpu =3D true;
> +		}
> +	} else {
> +		struct compat_vcpu_info *vcpu_info =3D gpc->khva;
> +
> +		if (!test_and_set_bit(port_word_bit,
> +				      (unsigned long *)&vcpu_info->evtchn_pending_sel)) {
> +			WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
> +			kick_vcpu =3D true;
> +		}
> +	}
> +
> +out_unlock:
> +	rcu_read_unlock();
> +
> +	/*
> +	 * Deliver the upcall or kick the vCPU only after dropping the RCU
> +	 * read lock. Both paths end up in kvm_vcpu_kick(), and the MSI
> +	 * delivery also walks the APIC map and takes APIC locks; none of
> +	 * that wants to be nested inside the GPC read-side critical
> +	 * section, which must be no longer than the accesses to gpc->khva
> +	 * above. Invalidation waits for a grace period, so holding the
> +	 * read lock across the kick would extend how long a memory
> +	 * invalidation is blocked.
> +	 */
> +	if (!kick_vcpu)
> +		return;
> +
> +	/* For the per-vCPU lapic vector, deliver it as MSI. */
> +	if (vcpu->arch.xen.upcall_vector) {
> +		kvm_xen_inject_vcpu_vector(vcpu);
> +		return;
> +	}

[Severity: High]
Does this new helper inadvertently bypass the required vCPU kick when the
vcpu_info cache check fails?

In the original code, if kvm_gpc_check() failed, the code jumped to the
out_rcu label. This intentionally bypassed the MSI injection block, and
fell straight through to kvm_vcpu_kick(). This forced a VM-exit so KVM
could synchronize the pending events to guest memory via
kvm_xen_inject_pending_events().

With this refactored helper, if the cache check fails and kick_vcpu is set
to true, the code jumps to out_unlock, drops the RCU read lock, and then
unconditionally injects an MSI if upcall_vector is present. Because it
returns early, the kvm_vcpu_kick() is skipped.

If APICv posted interrupts deliver the MSI directly without a VM-exit,
won't KVM fail to sync the in-kernel pending bit, causing the guest to
read stale memory and drop the interrupt?

> +
> +	kvm_make_request(KVM_REQ_UNBLOCK, vcpu);
> +	kvm_vcpu_kick(vcpu);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805195528.3853=
473-1-dwmw@amazon.co.uk?part=3D4
