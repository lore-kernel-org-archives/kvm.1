Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901657;
	b=Io4rN4z+VBlDgXv7NOtXqavD9pDugz0jaGLMdGJpS5P01PTEYD9JfqH49oNP8u5xA3bv
	 fHS/+rX5wpEhvQBUzEc6iABLh1yL7f0owxybnsbeCo2CCVe9GXLpaVbrYXgGWhZ2Qgd9/
	 mJ5Xs8wHP6fCcKrkDW9dz1qtiJLl0eB5WBIL8hvUh6Nr4aiAOeZfHWrtRtbz2/u1ATewJ
	 YBUzCPTA+N+mprWR0Xgp6nhv4XD7eUM7/Ij6K/8ApY7W9ppupJbG5IVwZ2t5APQPsCtUZ
	 JjPu+c/xcxGh2wggWv17flSM6dHIRfKNu1wXRDHdBSkKh4BvyU6Nk6id2i+3uVHN8Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901657;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bCQhV4HQF+1I59AZVsu0ERiMiOlRIkLomlHjNrzPKQ4=;
	b=kbV+T15ehpY2/uUYgpE85DlcirdqTic5hOBZcyiJRaFKaEfxZghfYOpp2mVERFnWGs28
	 ULI8Gj1QYzRkPKp+nORfhMGeKE4wfvFbX3TFryCK3fYFL3lZMcPbw2P5ZSYDrDoulQ93F
	 cbA2dXmLSYs9y7rI5qALoWPS7GvE/eieU8/QSW/XtNPX23lNo5Ninh17LvHXX/fbxHNmk
	 YyA0CP74n6EP1LyGecjRtqN/VFe2sdk4doSr5tvj2x68cShaOrNxeDDLnzxiJSJrDdMkq
	 eaTlnSavpJP8wo1J2fPtmmRMuuOEwRl4VZDtzpMdG3LhTWv1bdQLjXaLf+c898taEcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=isfcZEBj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AC6606A326
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=isfcZEBj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567781F000C1;
	Thu,  5 Nov 2026 18:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793901657;
	bh=bCQhV4HQF+1I59AZVsu0ERiMiOlRIkLomlHjNrzPKQ4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=isfcZEBjNcc8j4Bt7LVyXztovUfSwVA5Vq/lJiTSSyaczNTzyWj5tihbFZBzGf2it
	 hgRS+FnsebGejjH/sS1ZQy7QYuYnSdo+9ehbykwsU+IcAjqL90Qgo1ABhyFW+UNKPk
	 JnNFMLj0kN3ureeGlnlzqhOfAEE9uYTDQntmlZPdmGFRHLVU52ev/ADMi3nt9D/wQB
	 uXlM4yNLKFl32C2RHZdSsyo3yJpRleyjD+FvieGxDSAYIazEo70jyodw/+IO8gWxUJ
	 wSbjsRpckxLjOSekl0uyNn+Y+7ptaK3Qm9x+p3AlGFwlkhcltR30Td2EndykxFrHiK
	 1oEbo8odTEEFA==
Message-ID: <sashiko-outbox-199680@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 07/23] KVM: x86: Avoid redundant masterclock updates
 from multiple vCPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261105154955.2525419-8-dwmw2@infradead.org>
References: <20261105154955.2525419-1-dwmw2@infradead.org>
 <20261105154955.2525419-8-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:00:56 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM: x86: race in kvm_update_masterclock() on MCLOCK_INPROGRESS an=
d TSC page
--

commit 568cc2c30a5c5633833d9fd527d1659f817b9d25
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Avoid redundant masterclock updates from multiple vCPUs

This commit avoids redundant masterclock updates when multiple vCPUs process
KVM_REQ_MASTERCLOCK_UPDATE by checking under tsc_write_lock whether the
requesting vCPU's request is still pending and clearing the request across
all vCPUs once a single updater proceeds.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e3618d82c099c..77bd3e4bfdcd7 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1712,10 +1712,39 @@ static void kvm_make_mclock_inprogress_request(st=
ruct kvm *kvm)
>  	kvm_make_all_cpus_request(kvm, KVM_REQ_MCLOCK_INPROGRESS);
>  }
> =20
> -static void __kvm_start_pvclock_update(struct kvm *kvm)
> +static void kvm_clear_mclock_inprogress_request(struct kvm *kvm)
>  {
> +	struct kvm_vcpu *vcpu;
> +	unsigned long i;
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm)
> +		kvm_clear_request(KVM_REQ_MCLOCK_INPROGRESS, vcpu);
> +}
> +
> +static bool __kvm_start_pvclock_update(struct kvm *kvm, struct kvm_vcpu =
*requesting_vcpu)
> +{
> +	struct kvm_vcpu *vcpu;
> +	unsigned long i;
> +
>  	raw_spin_lock_irq(&kvm->arch.tsc_write_lock);
> +
> +	/*
> +	 * If another vCPU already did the update while we were waiting
> +	 * for the lock, our request will have been cleared. Bail out.
> +	 */
> +	if (requesting_vcpu &&
> +	    !kvm_test_request(KVM_REQ_MASTERCLOCK_UPDATE, requesting_vcpu)) {
> +		kvm_clear_mclock_inprogress_request(kvm);
> +		raw_spin_unlock_irq(&kvm->arch.tsc_write_lock);
> +		return false;
> +	}
> +
> +	/* The update is VM-wide; prevent other vCPUs from redoing it. */
> +	kvm_for_each_vcpu(i, vcpu, kvm)
> +		kvm_clear_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
> +
>  	write_seqcount_begin(&kvm->arch.pvclock_sc);
> +	return true;
>  }
> =20
>  static void kvm_start_pvclock_update(struct kvm *kvm)
> @@ -1723,7 +1752,7 @@ static void kvm_start_pvclock_update(struct kvm *kv=
m)
>  	kvm_make_mclock_inprogress_request(kvm);
> =20
>  	/* no guest entries from this point */
> -	__kvm_start_pvclock_update(kvm);
> +	__kvm_start_pvclock_update(kvm, NULL);
>  }
> =20
>  static void kvm_end_pvclock_update(struct kvm *kvm)
> @@ -1732,22 +1761,25 @@ static void kvm_end_pvclock_update(struct kvm *kv=
m)
>  	struct kvm_vcpu *vcpu;
>  	unsigned long i;
> =20
> -	write_seqcount_end(&ka->pvclock_sc);
> -	raw_spin_unlock_irq(&ka->tsc_write_lock);
>  	kvm_for_each_vcpu(i, vcpu, kvm)
>  		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
> =20
>  	/* guest entries allowed */
> -	kvm_for_each_vcpu(i, vcpu, kvm)
> -		kvm_clear_request(KVM_REQ_MCLOCK_INPROGRESS, vcpu);
> +	kvm_clear_mclock_inprogress_request(kvm);
> +
> +	write_seqcount_end(&ka->pvclock_sc);
> +	raw_spin_unlock_irq(&ka->tsc_write_lock);
>  }
> =20
> -static void kvm_update_masterclock(struct kvm *kvm)
> +static void kvm_update_masterclock(struct kvm *kvm, struct kvm_vcpu *vcp=
u)
>  {
>  	kvm_hv_request_tsc_page_update(kvm);
> -	kvm_start_pvclock_update(kvm);
> -	pvclock_update_vm_gtod_copy(kvm);
> -	kvm_end_pvclock_update(kvm);
> +	kvm_make_mclock_inprogress_request(kvm);
> +
> +	if (__kvm_start_pvclock_update(kvm, vcpu)) {
> +		pvclock_update_vm_gtod_copy(kvm);
> +		kvm_end_pvclock_update(kvm);
> +	}
>  }

[Severity: High]
Can calling kvm_hv_request_tsc_page_update() and
kvm_make_mclock_inprogress_request() in kvm_update_masterclock() before
checking whether KVM_REQ_MASTERCLOCK_UPDATE is still pending cause races on
KVM_REQ_MCLOCK_INPROGRESS and hv->hv_tsc_page_status?

In vcpu_enter_guest(), KVM_REQ_MASTERCLOCK_UPDATE is checked with the
non-clearing kvm_test_request() before calling kvm_update_masterclock().
When the first vCPU enters kvm_update_masterclock() and calls
kvm_make_mclock_inprogress_request(kvm), it kicks all other running vCPUs o=
ut
of guest mode before acquiring kvm->arch.tsc_write_lock and clearing
KVM_REQ_MASTERCLOCK_UPDATE. Those kicked vCPUs re-enter vcpu_enter_guest(),
still observe KVM_REQ_MASTERCLOCK_UPDATE set, and also call
kvm_update_masterclock(), broadcasting additional rounds of VM-wide
KVM_REQ_MCLOCK_INPROGRESS kicks before bailing out in
__kvm_start_pvclock_update().

When a losing vCPU (vcpu1) acquires tsc_write_lock in
__kvm_start_pvclock_update() after the winning vCPU (vcpu0) has finished,
!kvm_test_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu1) is true and the bail-o=
ut
path unconditionally clears KVM_REQ_MCLOCK_INPROGRESS on all vCPUs:

arch/x86/kvm/x86.c:__kvm_start_pvclock_update() {
	if (requesting_vcpu &&
	    !kvm_test_request(KVM_REQ_MASTERCLOCK_UPDATE, requesting_vcpu)) {
		kvm_clear_mclock_inprogress_request(kvm);
		raw_spin_unlock_irq(&kvm->arch.tsc_write_lock);
		return false;
	}
}

If another updater (such as kvm_vm_ioctl_set_clock() via
kvm_start_pvclock_update(), kvm_hyperv_tsc_notifier(),
kvm_arch_vcpu_postcreate(), or another vCPU handling a per-vCPU
KVM_REQ_MASTERCLOCK_UPDATE from kvm_synchronize_tsc(),
kvm_write_system_time(), or kvm_hv_set_msr_pw()) has already called
kvm_make_mclock_inprogress_request(kvm) and is waiting on tsc_write_lock (or
running hyperv_stop_tsc_emulation()), vcpu1's bail-out clears
KVM_REQ_MCLOCK_INPROGRESS across all vCPUs in the VM (and similarly
kvm_end_pvclock_update() clears KVM_REQ_MCLOCK_INPROGRESS even if another
caller has already set it while spinning on tsc_write_lock). Other vCPUs can
then enter IN_GUEST_MODE while the second update is in progress. Because
kvm_end_pvclock_update() sets KVM_REQ_CLOCK_UPDATE with kvm_make_request()
without kicking vCPUs, vCPUs that entered guest mode early will not be kick=
ed
and can run with stale pvclock state.

Similarly, because kvm_hv_request_tsc_page_update(kvm) runs before
__kvm_start_pvclock_update() checks KVM_REQ_MASTERCLOCK_UPDATE, two races on
hv->hv_tsc_page_status can occur:

1. If vcpu0 and vcpu1 both call kvm_hv_request_tsc_page_update(kvm), vcpu0
completes the update and runs kvm_guest_time_update() ->
kvm_hv_setup_tsc_page() (setting hv->hv_tsc_page_status =3D HV_TSC_PAGE_SET=
),
and a new KVM_REQ_MASTERCLOCK_UPDATE is raised before vcpu1 acquires
tsc_write_lock, vcpu1 will see KVM_REQ_MASTERCLOCK_UPDATE set and perform t=
he
second masterclock update without kvm_hv_request_tsc_page_update(kvm) being
called for it. In kvm_hv_setup_tsc_page(), HV_TSC_PAGE_SET causes an early
return, leaving the Hyper-V TSC page stale.

2. If no second update occurs, a lagging vcpu1 that runs
kvm_hv_request_tsc_page_update(kvm) after vcpu0 has already completed
kvm_hv_setup_tsc_page() resets hv_tsc_page_status from HV_TSC_PAGE_SET back
to HV_TSC_PAGE_HOST_CHANGED, bails out in __kvm_start_pvclock_update(), and
then rewrites tsc_sequence and the shared Hyper-V TSC page in
kvm_hv_setup_tsc_page() while other vCPUs are already running in guest mode.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105154955.2525=
419-1-dwmw2@infradead.org?part=3D7
