Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E34339B41
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791582516; cv=none; b=PBNnQnJlBd3S1011QynqcnxmVDFR1ZQJLDGCuhgktII8+JqhcevtZf5//H0k06X0gMXxLZdahMnUMKFgunms919YEHZt3/mrh53f5LtMGblQFe0+F+DaAZRlkVxz3XCXWiP0uEzVPMB3FGf9910WhezVOEvNiN7hz+wiDE+Rqlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791582516; c=relaxed/simple;
	bh=EmDDWbGRmWjRM78CVyG5sXdMPDaKuch4e5edFdAyPAY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NbOShlfK1izrnbsa0OR+CUD6Mx7ZS/ISCRb6I0FyAaHifdSWa5zKQaCIdP5hERW8mWzIPm+kOrTy1IDG4F56k0+A+Vk7JVqVcqhiib682eOHCjdKR+r+Hn9jAf7XSPeA1NQB2WhNSOa6QVCr0meOItSWYoWxX6V4EEbYSYCMgCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GEzkgX16; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G2XyQRnQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GEzkgX16";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2XyQRnQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791582513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGgqFDCfD+EtiLU0tPlWyAake8xNIynE3W4jW4V1afM=;
	b=GEzkgX16soMAawH8h/sVmIIRapCpMdTtgP6zCYONNdM9e6e2IvokED3y0eZl5blYraBKe+
	CtWgwDeaWso9urPr5+dHf712V5oDdmO5xfM9Qja2B5mwWQ8Ke2Bxi31o3Qg7pH/Hnsrag/
	iymZDYDkPQIVwCESCY0mHMzg9yr2J+4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-vJyEv8zTOpabHz53RYQPDg-1; Fri, 9 Oct 2026 21:48:32 +0000
X-MC-Unique: vJyEv8zTOpabHz53RYQPDg-1
X-Mimecast-MFC-AGG-ID: vJyEv8zTOpabHz53RYQPDg_1791582511
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93e49a1d3b1so28669585a.2
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 14:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791582511; x=1792187311; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mGgqFDCfD+EtiLU0tPlWyAake8xNIynE3W4jW4V1afM=;
        b=G2XyQRnQJxWvPNRoM+GzjRTs5yiKuRwrUh3CaGoH8fhcXs0g6YgUQ+NfypJkEEcvUn
         jJ/D7tFslOy4Cxi0UZdS6NRq6lpwUyVJBzQH8vC02SCY3Fl3EZF8+HSdDQVyqmVJ6yBx
         pB45IelqudYM5WQeMVSiJ7UuqgadOYLBhmQX8T0y99sGtdjrPCwj4ZVkvT5s0bHd+BQQ
         yLFjmeQMja/KJRnQPWsoPErN5jaz6DgPpYkPUhf94Kr8AHArfb8gCgzkaE7Yy6QOyxqL
         pIA9pusim+GdTSq7jaYzVHIjNkas9bMTsSCYfjIn/tJrxIp4vT7Kg8+3B+Q79f7dbLxL
         3+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791582511; x=1792187311;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mGgqFDCfD+EtiLU0tPlWyAake8xNIynE3W4jW4V1afM=;
        b=b622z7ZOKmkXMvTt4er+rfFubbEIfdFAWXFhZhvW2jK1z8DJMbnfZcE+wNZH7625c6
         oTpeOY7nTXjbWSnMLjG2RNVOvhMqhKsozEHAXXXQOcbu9eR0Eri1sMRYoAefHcSJrw/g
         f8yQwn0FaEx5eq2VuSDoBTcQx+PLT6c5XwyKKRxreW/ojSbX3aFwMOdKDOD8TMor7OxT
         B/rHpxlDOnvUafhqq6my80+385nopUjxRpgLg1Y2R0I2Pkb8HMxUxkWXuYPGw/nxd8mM
         sZJEf0ygqYB81ieNxV8L6et0KFcCUyDJ76mV1NR40auZVg3SvFZURybgsgKRR92nNZu2
         P5CQ==
X-Gm-Message-State: AFq9FYLttw4IxqvrdNZW/7AEWIcSC44M4ty6MIO2Rmlw6AMBHK5ktoeN
	HqRUUNTxWo+DfNxoo5xcX3y1qLeP2dQNlnxv7cE7UHvzGI72n6kkbC8DtOIEV9yTiP7JE6gTJuv
	dC+bJ/kT+1Bk4+fST/zk0R7+SGjv21h3kFIYyidzaTeX1OkNbDjrTTseBPsGFxg==
X-Gm-Gg: AYBFou0GFUXbXchV4JeDtRBHHnfXiTZJSe+3X7CKuZfxzjS+pGKZe9SF5qsR5U4twQK
	vhallvP4cgewH985PEpNaG5Bdv0Cu+hRqkt8fJCD2KAkmKpRMB1vHHCB9i128ZUuounim1rxHx9
	QO+AKgCSya6iuH3Se3yMHweD/kbkG/f9bwOZDp3xQvubev6nzqdd93VWUPtnvazpJeUGDVadux+
	S3qlZ9syXaH9rmsR9B/9CV9hBrHBFYAlhjnHcaDrg/3kx5CcpRLxrFK7nMRCteWybQwG9RNtkUq
	gthX8bn6tbahvQTh4C3ZZTMnWL1JVXYsMIpK7TrDZ1jcVdOeD/Jc0Lx5KvMuf0C5+GyR/hZEclf
	R9B7ZklWUMaRPmvLep8PkFgeeJFfoYZxRSG8fD3ObtjY/foVcQ5rTKQ1Wpisatar7P1jHSyXYXm
	Re9S5WIHZ7
X-Received: by 2002:a05:620a:468b:b0:93c:6fa0:9813 with SMTP id af79cd13be357-93ebd24ba2cmr594925985a.43.1791582511408;
        Fri, 09 Oct 2026 14:48:31 -0700 (PDT)
X-Received: by 2002:a05:620a:468b:b0:93c:6fa0:9813 with SMTP id af79cd13be357-93ebd24ba2cmr594922085a.43.1791582510880;
        Fri, 09 Oct 2026 14:48:30 -0700 (PDT)
Received: from mlevitsk-thinkpadt14gen3.ibmmarkh.csb (pool-173-33-204-162.cpe.net.cable.rogers.com. [173.33.204.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb984845csm282095385a.14.2026.10.09.14.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:48:30 -0700 (PDT)
Message-ID: <a836b841e730db8ded250a34748bef7573e8932c.camel@redhat.com>
Subject: Re: [PATCH 2/2] KVM: nVMX: avoid losing the posted notification
 interrupt when exiting L2
From: "mlevitsk@redhat.com" <mlevitsk@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Date: Fri, 09 Oct 2026 17:48:28 -0400
In-Reply-To: <sashiko-outbox-166067@kernel.org>
References: <20261009205036.672523-1-mlevitsk@redhat.com>
	 <20261009205036.672523-3-mlevitsk@redhat.com>
	 <sashiko-outbox-166067@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-10-09 at 21:03 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Critical] kvm: x86: out-of-bounds write in kvm_lapic_set_irr due to u1=
6 promotion bypass
> - [High] kvm: x86: guest-triggerable WARN_ON_ONCE and pi_pending state le=
ak
> --
>=20
> commit 00e061d66b6985b4612f371acc0c5f41a6c597b6
> Author: Maxim Levitsky <mlevitsk@redhat.com>
>=20
> KVM: nVMX: avoid losing the posted notification interrupt when exiting L2
>=20
> This commit detects if a posted notification interrupt is pending during
> a nested VM exit. If the target vCPU is about to exit to L1, the
> interrupt is injected into L1's APIC to avoid losing it.
>=20
> > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > index 11362aad2bc8a..66c4cf7f6e00f 100644
> > --- a/arch/x86/kvm/vmx/nested.c
> > +++ b/arch/x86/kvm/vmx/nested.c
> > @@ -2445,7 +2445,7 @@ static void prepare_vmcs02_early(struct vcpu_vmx =
*vmx, struct loaded_vmcs *vmcs0
> > =C2=A0			 ~PIN_BASED_VMX_PREEMPTION_TIMER);
> > =C2=A0
> > =C2=A0	/* Posted interrupts setting is only taken from vmcs12.=C2=A0 */
> > -	vmx->nested.pi_pending =3D false;
> > +	WARN_ON_ONCE(vmx->nested.pi_pending);
>=20
> [Severity: High]
> Is it possible for an L1 guest to maliciously trigger this warning and cr=
ash
> the host if panic_on_warn is set?
>=20
> Since the patch no longer clears pi_pending, could this state leak occur =
if a
> nested VM-entry fails early after enter_guest_mode() is called? For examp=
le,
> in nested_vmx_enter_non_root_mode(), the failure path
> vmentry_fail_vmexit_guest_mode calls leave_guest_mode() and returns to L1
> without executing __nested_vmx_vmexit(). This would leave pi_pending
> uncleared.

>=20
> Additionally, could there be a store-load race here? During normal VM exi=
t,
> leave_guest_mode() clears HF_GUEST_MASK, but there is no memory barrier
> enforcing visibility before pi_pending is checked further down in
> __nested_vmx_vmexit(). A concurrent posted interrupt delivery might read
> guest_mode =3D=3D true and set pi_pending =3D true, while the exit path r=
eads
> pi_pending =3D=3D false.

Then I'll clear it on both VM entry and VM exit to avoid these cases.


>=20
> In both cases, pi_pending remains true when returning to L1, triggering t=
his
> warning on the next nested VM-entry.
>=20
> [ ... ]
>=20
> > @@ -5151,6 +5151,14 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, =
u32 vm_exit_reason,
> > =C2=A0	kvm_clear_exception_queue(vcpu);
> > =C2=A0	kvm_clear_interrupt_queue(vcpu);
> > =C2=A0
> > +	if (lapic_in_kernel(vcpu) && vmx->nested.pi_pending) {
> > +		vmx->nested.pi_pending =3D 0;
> > +		if (!WARN_ON_ONCE(vmx->nested.posted_intr_nv =3D=3D -1)) {
> > +			kvm_lapic_set_irr(vmx->nested.posted_intr_nv, vcpu->arch.apic);
>=20
> [Severity: Critical]
> Does this guard actually protect against injecting an invalid vector?
>=20
> Looking at struct nested_vmx in arch/x86/kvm/vmx/vmx.h, posted_intr_nv is
> defined as a u16. When it is assigned -1 in prepare_vmcs02_early(), it
> truncates to 65535.

Yes, the fact that vmx->nested.posted_intr_nv is u16 wasn't noticed by me, =
because
it set in several places to -1.
I''ll switch to a more robust check.

>=20
> Due to C integer promotion rules, the expression
> vmx->nested.posted_intr_nv =3D=3D -1 compares the u16 value 65535 to the =
int
> literal -1, which evaluates to false. This bypasses the safety guard beca=
use
> !WARN_ON_ONCE(false) is true.
>=20
> If pi_pending was leaked as described above and PI is subsequently disabl=
ed by
> L1, wouldn't kvm_lapic_set_irr() be called with vector 65535? Inside
> kvm_lapic_set_irr(), calculating the bit offset for 65535 falls far outsi=
de
> the 4KB APIC register page, which could result in a severe out-of-bounds =
write
> into adjacent host memory.


>=20
> > +			kvm_make_request(KVM_REQ_EVENT, vcpu);
> > +		}
> > +	}
> > +
> > =C2=A0	vmx_switch_vmcs(vcpu, &vmx->vmcs01);
> > =C2=A0
> > =C2=A0	kvm_nested_vmexit_handle_ibrs(vcpu);

