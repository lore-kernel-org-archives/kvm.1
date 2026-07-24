Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFA11E9906
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 01:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784855229; cv=none; b=Cb0K5f3RYb8SVMkOsbA9JLG8Ows45o5TzEJlPtk/1dGvZVwIWKPyCIfcN9G0MA30JlEc38O9Tu67ediTOOvqPOWOW7X5WLLKZ+tDAkrnLicZ35yqixb4lflqP4x89mdfNPmnwYU1xDwAb/vCTxifuSYBwCwskF+XW7CHjanxmUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784855229; c=relaxed/simple;
	bh=uYj4ZWUzKGoDpE7u2oScZ/b4Yz1NBFqtgzd88nl4Dyg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iedAOT7HS4vZHGLzmdW7xhH/DJ0hejIb1O7OUaPUEUHJRry/dMpNX+YiEk6deRT5vWcEQ++XWY0mpwl45JfjD8EcgBNW0JKxpTEGBc8R1YRAPrSfn+17Ju/aCooBp7UizL/8YLPFJ5nMHBXO0WzlWkx+lot/mn+kTI+/5Qi7yFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNAo7rA6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNAo7rA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD3C1F000E9;
	Fri, 24 Jul 2026 01:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784855227;
	bh=cwTB7yRY5CnZHqMgRJSOEDGah7rgOt8ZutE9N2oy12s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UNAo7rA6Vcoq19JeUW8puTHbM+uM5rwlYQwaHlrhozIlS2ZOEZVq6RqCglBF1Sl+o
	 jGEZxej3PIst5DBzF6n6r0MUw5xjU3YqAKGH90Q3IGTPgsly4+jbQyTnVh8ZHO8Gwy
	 TGWV3Ei3lTZkgyRVC8pqfVAS42m7FFZvOokw14Y9QnrGHo5GgdwTXg9sqmGzcyWmZq
	 lxckFdiFXPfpRmfSDW464vQIyDgiUcF5gG7iRG0JQRyNj3dKYLyWdBfC4blVb08zbC
	 aJ5qTKrYoaUbtmO0ClpDMyd7L3kTh+ULwHhYI9jDF0uuHWiBjPkm8tIgW7fA89YX+i
	 tqlOpAOhWkX9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES is
 cleared on VM-Exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260724004757.131420-2-seanjc@google.com>
References: <20260724004757.131420-1-seanjc@google.com>
 <20260724004757.131420-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 01:07:07 +0000
Message-Id: <20260724010707.8CD3C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] An L1 guest can trigger a silent host memory leak (pinned pages an=
d kmap space) by repeatedly executing VMLAUNCH with an invalid guest state.
--

--- Patch [1]: [PATCH 1/6] KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES=
 is cleared on VM-Exit ---
commit 529c03d57fc94827c8dfbb4372dfae1313c5dd93
Author: Sean Christopherson <seanjc@google.com>

KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES is cleared on VM-Exit

This patch ensures KVM_REQ_GET_NESTED_STATE_PAGES is always checked and=20
cleared when emulating a nested VM-Exit. This prevents double-mapping=20
vmcs12 pages if KVM manages to bail from VM-Enter without processing the=20
request and then emulates VMLAUNCH or VMRESUME.

Cc: stable@vger.kernel.org

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index b5460de4b1a72..f2518d67e7de5 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5066,8 +5066,9 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32=
 vm_exit_reason,
>  	/* trying to cancel vmlaunch/vmresume is a bug */
>  	kvm_warn_on_nested_run_pending(vcpu);
> =20
> -#ifdef CONFIG_KVM_HYPERV
> +	/* Note, "checking" the request also clears the request. */
>  	if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
> +#ifdef CONFIG_KVM_HYPERV

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential memory
leak related to how nested VM-Entry failures handle mapped pages.

If an L1 guest prepares a VMCS12 with valid addresses for mapped pages (like
virtual_apic_page_addr) but intentionally configures an invalid guest state=
=20
(e.g., an invalid CR0 value), nested_vmx_enter_non_root_mode() maps the=20
pages before validating the guest state:

arch/x86/kvm/vmx/nested.c:nested_vmx_enter_non_root_mode() {
    ...
    if (nested_vmx_check_guest_state(vcpu, vmcs12,
                                     &entry_failure_code)) {
        exit_reason.basic =3D EXIT_REASON_INVALID_STATE;
        vmcs12->exit_qualification =3D entry_failure_code;
        goto vmentry_fail_vmexit;
    }
    ...
}

The error path in vmentry_fail_vmexit synthesizes a VM-Exit back to L1 but=
=20
returns without calling nested_put_vmcs12_pages() to unmap the resources:

arch/x86/kvm/vmx/nested.c:vmentry_fail_vmexit() {
    ...
    if (!from_vmentry)
        return NVMX_VMENTRY_VMEXIT;

    load_vmcs12_host_state(vcpu, vmcs12);
    vmcs12->vm_exit_reason =3D exit_reason.full;
    ...
    return NVMX_VMENTRY_VMEXIT;
}

If the L1 guest resumes and executes VMLAUNCH again, KVM calls
kvm_vcpu_map() on the already populated map structures:

virt/kvm/kvm_main.c:__kvm_vcpu_map() {
    ...
    map->pinned_page =3D NULL;
    map->page =3D NULL;
    map->hva =3D NULL;
    ...
}

This unconditionally clears the pointers without unmapping or verifying the
previous state, dropping the only KVM reference to the previously pinned
host page and kmap address.

Could a malicious L1 guest repeatedly trigger this in a tight loop to
exhaust host memory and kmap virtual space?

>  		/*
>  		 * KVM_REQ_GET_NESTED_STATE_PAGES is also used to map
>  		 * Enlightened VMCS after migration and we still need to

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724004757.1314=
20-1-seanjc@google.com?part=3D1
