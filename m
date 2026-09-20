Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFE7481FCA;
	Sun, 20 Sep 2026 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789941465; cv=none; b=guzfN26+MnkO1EUSEdzPFn/KXmF6AWTr4fhrtaM5GaaJdlrZND6AivYnQj/MZ4oFAESaRlG5QjnJ9zahYbnzWCtIQwo3LHAEtjuOslwJgzebWFlSbG/xrpn2t2TrONJKqPgbw4qrq+iD7ZEPHZYsw1Y2JURSWu4wTai+8hUq0LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789941465; c=relaxed/simple;
	bh=bZa1pElkzClMfmQwucEy+nArbsZOWFANAM4HqgqupDQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CGRF4rmWpQ6dIbTsZgF1+IjIFX6dJP5pfoXs00hlEHgtOxlqgjQRbxBV8JGAO787YKAHgymfrqgjqPh8rmF9DVfAcRrCG5ZqLlgW6RlyN86Tm9tYl0kGAp77nHDOJVQf2myYNMsIZqJZlP0ypUTshBAK2gSDbcqWJQTop8LVIeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6HhOkw1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6HhOkw1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90CB1F000FF;
	Sun, 20 Sep 2026 21:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789941459;
	bh=K5lgCFXvudAyPyRrwuAH655JZLJ/x1VD68ZBotZZ/74=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H6HhOkw1E/7UbiDyZtItNXxqVGwQ81wi3Xe+ruSG04y6K42mz/JjPQoslxH9MGQix
	 LcXiN9MRUUB763Ev+USq436t/oJQVCdWZdlTB2SVgu5Gr7riwUlsrnaswigVi04yZU
	 lSM0n0c4Gv0Dapdh5w+Q62CkVxMdQJcermWxf8liI5DDvkTt+O/MVsmBuFuQ0G43i6
	 NSeFXnU3pFeuwOKrGU6PIveiSL7mZHFm5uCMMliWcEOf79uv8t+bUT1TlzirMzeBeF
	 VWd5AkQ50ge44yCfntREvbdkF2qDWpz/iqFqpgHfSYJ1e90jV69PfnMoRVC3dyTA2m
	 DIpZ/uiSjhdPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/17] KVM: nVMX: Use pinned pfncache for L1 APIC
 virtualization pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260920211920.928306-12-dwmw2@infradead.org>
References: <20260920211920.928306-1-dwmw2@infradead.org>
 <20260920211920.928306-12-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 21:57:38 +0000
Message-Id: <20260920215738.E90CB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kvm: nVMX: Guest-triggered KVM_EXIT_INTERNAL_ERROR via unaligned A=
PIC-access address
- [Medium] kvm: lockdep: AB-BA circular dependency between gpc->refresh_loc=
k and kvm->gpc_srcu
--

commit daeb1861c76d9216ee8842648d7c50ed244624b3
Author: Fred Griffoul <fgriffo@amazon.co.uk>
Date:   Sun Sep 20 20:49:39 2026 +0000

    KVM: nVMX: Use pinned pfncache for L1 APIC virtualization pages

    Replace kvm_host_map usage with gfn_to_pfn_cache for the L1 pages whose
    physical addresses are handed to the CPU in vmcs02 for direct use while
    running L2. This eliminates the map/unmap cycle on every L2 VM-entry/ex=
it.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 5fe7e5d1f72d9..105ff6cbfe583 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c

[ ... ]

> @@ -3494,26 +3591,74 @@ static bool nested_get_vmcs12_pages(struct kvm_vc=
pu *vcpu)
> =20
> =20
>  	if (nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
> -		map =3D &vmx->nested.apic_access_page_map;
> -
> -		if (!kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->apic_access_addr), map)) {
> -			vmcs_write64(APIC_ACCESS_ADDR, pfn_to_hpa(map->pfn));
> -		} else {
> +		int err =3D nested_gpc_hpa(&vmx->nested.apic_access_page_cache,
> +					 vmcs12->apic_access_addr, &hpa);
> +		if (!err) {
> +			vmcs_write64(APIC_ACCESS_ADDR, hpa);
> +		} else if (err =3D=3D -EAGAIN) {
> +			kvm_gpc_unpin_for_guest(&vmx->nested.apic_access_page_cache);
> +			kvm_gpc_deactivate(&vmx->nested.apic_access_page_cache);
> +			goto retry;
> +		} else if (!lazy) {
> +			/*
> +			 * Entry-time resolution (VMLAUNCH/VMRESUME, or resume
> +			 * from KVM_SET_NESTED_STATE): an unbackable
> +			 * APIC-access page is a misconfiguration to report,
> +			 * not a transient to ride out.
> +			 */
>  			pr_debug_ratelimited("%s: no backing for APIC-access address in vmcs1=
2\n",
>  					     __func__);
>  			vcpu->run->exit_reason =3D KVM_EXIT_INTERNAL_ERROR;

[Severity: High]
Does this allow an untrusted L1 guest to crash the VM by triggering a
KVM_EXIT_INTERNAL_ERROR?

The L1 guest can write a non-page-aligned address to the APIC_ACCESS_ADDR f=
ield
in vmcs12 and execute VMLAUNCH. When nested_get_vmcs12_pages() calls
nested_gpc_hpa() with this raw, unaligned address, nested_gpc_lock() will r=
eturn
-EINVAL due to its strict !PAGE_ALIGNED(gpa) check.

Because this non-lazy path treats -EINVAL as an unbackable page and aborts =
the
entry with KVM_EXIT_INTERNAL_ERROR, the host userspace might kill the entir=
e VM.
Should this be handled as a graceful architectural VM-Entry failure instead?

>  			vcpu->run->internal.suberror =3D
>  				KVM_INTERNAL_ERROR_EMULATION;

[ ... ]

> @@ -4065,6 +4269,8 @@ static void vmcs12_save_pending_event(struct kvm_vc=
pu *vcpu,
>  static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> +	int pi_idx, vapic_idx;
> +	struct pi_desc *pi_desc;
>  	int max_irr;
>  	void *vapic_page;
>  	u16 status;
> @@ -4072,22 +4278,32 @@ static int vmx_complete_nested_posted_interrupt(s=
truct kvm_vcpu *vcpu)
>  	if (!vmx->nested.pi_pending)
>  		return 0;
> =20
> -	if (!vmx->nested.pi_desc)
> +	pi_idx =3D nested_gpc_lock_if_active(&vmx->nested.pi_desc_cache);
> +	if (pi_idx < 0)
>  		goto mmio_needed;
> =20
> +	pi_desc =3D nested_pi_desc(vmx);
>  	vmx->nested.pi_pending =3D false;
> =20
> -	if (!pi_test_and_clear_on(vmx->nested.pi_desc))
> +	if (!pi_test_and_clear_on(pi_desc)) {
> +		nested_gpc_unlock(&vmx->nested.pi_desc_cache, pi_idx);
>  		return 0;
> +	}
> =20
> -	max_irr =3D pi_find_highest_vector(vmx->nested.pi_desc);
> +	max_irr =3D pi_find_highest_vector(pi_desc);
>  	if (max_irr > 0) {
> -		vapic_page =3D vmx->nested.virtual_apic_map.hva;
> -		if (!vapic_page)
> +		vapic_idx =3D nested_gpc_lock_if_active(&vmx->nested.virtual_apic_cach=
e);

[Severity: Medium]
Will this nested lock cause an AB-BA circular locking dependency warning fr=
om
lockdep?

Here in vmx_complete_nested_posted_interrupt(), nested_gpc_lock_if_active()=
 is
first called for pi_desc_cache, acquiring the SRCU read lock for kvm->gpc_s=
rcu.
Then, while still holding this SRCU read lock, it attempts to lock the
virtual_apic_cache. If a refresh is needed, kvm_gpc_refresh() is called, wh=
ich
acquires the gpc->refresh_lock mutex.

Since all gpc->refresh_lock instances share the same lock class, lockdep wi=
ll
observe gpc_srcu -> refresh_lock here.

However, in kvm_gpc_deactivate() in virt/kvm/pfncache.c:

	guard(mutex)(&gpc->refresh_lock);
	if (gpc->active) {
		...
		if (old_state & (GPC_VALID | GPC_INVALIDATING))
			synchronize_srcu_atomic(&kvm->gpc_srcu);

The refresh_lock is held while synchronize_srcu_atomic() waits, establishin=
g the
reverse dependency: refresh_lock -> gpc_srcu. This circular dependency can
disable lockdep and pollute kernel logs.

> +		if (vapic_idx < 0) {
> +			nested_gpc_unlock(&vmx->nested.pi_desc_cache, pi_idx);
>  			goto mmio_needed;
> +		}
> +		vapic_page =3D vmx->nested.virtual_apic_cache.khva;
> +
> +		__kvm_apic_update_irr(pi_desc->pir, vapic_page, &max_irr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920211920.9283=
06-1-dwmw2@infradead.org?part=3D11
