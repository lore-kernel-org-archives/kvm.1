Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620493;
	b=i6TAmUvKJy/ohgQtcYJ/ir1JD27ckYLwfXiZCP0Bj3Z86E5HtCBJTRYmbGrOFaQbytQ6
	 UxNjwJigvlLh1QSXCzaoBKrrNHbqZmdnFh6zeaOv1yKfmC0HgBcapSG/5QB7URuiJDsU9
	 caAG0guSckbYvZgavbwhNXTU7fJGidzisW5CEC+CULdAiDNYwCPn2PZ81o/oNffYCZ1gB
	 tg3oLVRGba8rKXdCUrTkggsyQGHzA+RWYbHVPW8oucWZyNxAHEM5UkLq6T3MNJ/M4RDcS
	 v5Gu+LWWHzixk42Z2ifDBdV5+7WB95Emt0NtjdKN9bP1c9urZfzrz3K80DnJxox3YCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620493;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version;
	bh=lgIANs+qLIIOzj/H2zLJZm2Lmsm8CkjE/+alsxp6LU0=;
	b=5CYrwm8r9vZV3256EZ7rdWxg+nBN5rHiV6l+0qS4gvU2NKXcWUXbR5lw77HHXPtuPLJq
	 G4SUSIWjEcbXdDU3sBMJWT1MoTchsTNB4g53IpKRgBLBdKI8oWjT0ZiYfuaMl5VK7UAQu
	 Ip2U8FFU3fYcV5pcVmwG3p8UR0k3980MvBxq3pS/qKzvAWWqTLwD5VGEkIzJQwZIMoKU3
	 7HbGwLCF7i0xRdfIPVq4hFZCZvs+2Tw8HQ/O85BdqRdfgqU4dE/0Njj0qF/vf2bDrFCU+
	 7CRkToY0gIDedo3qK3WWBnFvXRFviwxww78zcMHeIyEbxeP9wBnPLz3W/tFc4amrPsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="XreoMY/P";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VkiTzf5w;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291C5606A327
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 291C5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XreoMY/P;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VkiTzf5w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795620492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgIANs+qLIIOzj/H2zLJZm2Lmsm8CkjE/+alsxp6LU0=;
	b=XreoMY/Pdi1VIE3Vp7uUiuFWmYMu7jC7aBHpk1W0FgNE3lN4mcYeqnX1Skxt07uKgBMJyl
	+hIuKNzHXr2KiIs6f71fq8NDKxPcaZ3lcMdRozI5mAg3nvwmCfqJF/xYMU7JE1/7ESpOmf
	8/pEFgJB8WRBLlHLDuFyzeCmamtf4DQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-R615K9owOKWBniQXeQ4Nng-1; Wed, 25 Nov 2026 15:28:07 +0000
X-MC-Unique: R615K9owOKWBniQXeQ4Nng-1
X-Mimecast-MFC-AGG-ID: R615K9owOKWBniQXeQ4Nng_1795620487
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6ba810fb7caso4294283a12.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 07:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795620487; x=1796225287; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lgIANs+qLIIOzj/H2zLJZm2Lmsm8CkjE/+alsxp6LU0=;
        b=VkiTzf5wml3WZpwY0SkizSN7gV6MuDTGC4uiHkBYOSD3/B8Oj4lFQc5//a1YyKYpoi
         uvqApsCN4OOQxZPWdF/UXRMQF3PVcD1gkqzi4z45dSSOS0QpEM2lIB2BqEshBK4YkPfV
         aaYOGk0+xZhn1AE3a/d5lyx+7vGIxWbSqNPusin7VwCMsW6ObQMl19Qn7ozBAgUfEK2B
         Wg7kMYczL3i8X19yDItMGgwBrxucQlZlnlYz9pcLmF+gqIkgTmMwYRdBOvaSkJFRzuy/
         SI8enqtmK1vlhPysEfKjYTVXoI37XR3skhxD/yqV3nIGkScpKiVxEd5glFIQdXVjRlTs
         uznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620487; x=1796225287;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lgIANs+qLIIOzj/H2zLJZm2Lmsm8CkjE/+alsxp6LU0=;
        b=03zAdYvU3i/Qa4LH+BP8K4dvU45rIZIiIX89gJEEu4yatkHO0KWrR+SX0sUrbyGqSb
         YgMUDiDpxPDphEGMtLUDcA/M87CRQKqN9ybqBsCOFzX7VmAJhZvQSQSofB+Jy5G+fxkI
         1G2Kgo1jJSu5oG8esZRsdkgOuqkoq80n2Piinr/nd26h6W7MzTAv4n8++AqBclcg0Yuv
         kjUECml8v6/Vk/C9vgRxGKPP3HMvsCw0NN4RW8818p4z88MB5bpO4hbq4LlZD1ShagYk
         wc964cSJmZuZbZIUIy34Ota2Ql7+E2fA3VjfrR92C85t7GkzWAJyrs8/TRxsCDJGukPp
         tcqw==
X-Forwarded-Encrypted: i=1; AL+hErHz6xXxEZY0udTtNPKaPlYh0dGy5Mf14A4kFyzoUbDHIONq+sejTffBYCC4aUmVMomLOZA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HyIpbBxMOsUxUz652HkjRvc12HRnaYAFOIVtmiIh0v7s69Hmk
	p/KrnZUVJjaURCBgmcTeWh6o9r3/dj+iQFffOEkeVbsX+Yht1em7SHcgjZZqmYaWytku58eEubp
	VhIhhkzHEkYTzaeYxUHi8cPXUZXBa0CmFipN1FqubP4t581yLmIdmyA==
X-Gm-Gg: AZFdTZeoPwYoFt51yonGACsvWm4o2VwYOvXQRuJh5iL4YGvsSVyhwh5ykKfnxdjS3dC
	BRoVqHWVGCiofdrzu367an7KUR8F8Dts8J/jGYcrS9SdI6rwI3XHusQiThtECws85361csjSEAo
	kbvo2qESi3PPZv3sXKS4Z6T71kL8+cVUSbGmKbTa2y2VbvUs8K9N31myX/Fcj8u6RaVSTL+D1le
	4gOOJL2R6T/6Q9j7L1C2ebZD4RDsUm2hF6R0EtePXTnmepxNxrnxwjPTOIZ4si0EFa2uMgdpCPR
	AwzE17Qd/df6oEoAXC5s7oAg27PVIrQWiQylgO/zdZsewLmS47r2dIn//vK0XI1emKwNftPYg99
	xFedmWL+hVrdEJX3vhSMN0jqNLyRck+AWU7ZSD9xlDnD9LUiQW49ERr88c/p/22Osl9vRgH1Ydw
	piTpBC9lI=
X-Received: by 2002:a05:6402:3212:b0:6ba:31be:edc3 with SMTP id 4fb4d7f45d1cf-6ba31beee34mr13288290a12.6.1795620486639;
        Wed, 25 Nov 2026 07:28:06 -0800 (PST)
X-Received: by 2002:a05:6402:3212:b0:6ba:31be:edc3 with SMTP id 4fb4d7f45d1cf-6ba31beee34mr13288273a12.6.1795620486165;
        Wed, 25 Nov 2026 07:28:06 -0800 (PST)
Received: from mlevitsk-thinkpadt14gen3.ibmmarkh.csb ([209.103.33.216])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6bb1d49d992sm1496168a12.26.2026.11.25.07.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:28:05 -0800 (PST)
Message-ID: <19aa03249ef85403c23a8d0287c9324fb02ab00f.camel@redhat.com>
Subject: Re: [PATCH v4 5/5] KVM: x86: nVMX: fix races in delivery of nested
 posted interrupts
From: "mlevitsk@redhat.com" <mlevitsk@redhat.com>
To: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Date: Wed, 25 Nov 2026 10:28:03 -0500
In-Reply-To: <sashiko-outbox-232632@kernel.org>
References: <20261125052139.362046-1-mlevitsk@redhat.com>
	 <20261125052139.362046-6-mlevitsk@redhat.com>
	 <sashiko-outbox-232632@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-11-25 at 05:52 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [High] KVM: nVMX: delayed KVM_NESTED_PI_ACTIVE misdelivers PI to
> =C2=A0 halted/restored L2
> - [High] KVM: nVMX: gating KVM_NESTED_PI_ACTIVE on pi_desc breaks
> =C2=A0 deferred error exit
> - [Medium] KVM: nVMX: __nested_vmx_vmexit() processes nested PI on
> =C2=A0 failed VM-Entry
> --
>=20
> commit aef7be5a3f3ba4f7dee7a4841c7b946e8a11d349
> Author: Maxim Levitsky <mlevitsk@redhat.com>
>=20
> KVM: x86: nVMX: fix races in delivery of nested posted interrupts
>=20
> This commit serializes nested posted interrupt delivery against nested VM
> exit using atomic operations on vcpu->arch.nested_guest_state and delays
> enabling nested posted interrupts until vmcs12 pages are mapped.
>=20
> > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > index eb33528619c2f..a5ef9a15e7e9c 100644
> > --- a/arch/x86/kvm/vmx/nested.c
> > +++ b/arch/x86/kvm/vmx/nested.c
> > @@ -3440,7 +3440,18 @@ static bool nested_get_evmcs_page(struct kvm_vcp=
u *vcpu)
> > =C2=A0}
> > =C2=A0#endif
> > =C2=A0
> > -static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
> > +static void nested_vmx_enable_posted_interrupts(struct kvm_vcpu *vcpu)
> > +{
> > +	struct vmcs12 *vmcs12 =3D get_vmcs12(vcpu);
> > +
> > +	WARN_ON_ONCE(vmcs12->posted_intr_nv & ~KVM_NESTED_PI_VECTOR_MASK);
> > +
> > +	atomic_or(KVM_NESTED_PI_ACTIVE |
> > +		 (vmcs12->posted_intr_nv & KVM_NESTED_PI_VECTOR_MASK),
> > +		=C2=A0 &vcpu->arch.nested_guest_state);
> > +}
> > +
> > +static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu, bool from_v=
mentry)
> > =C2=A0{
> > =C2=A0	struct vmcs12 *vmcs12 =3D get_vmcs12(vcpu);
> > =C2=A0	struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> > @@ -3505,6 +3516,9 @@ static bool nested_get_vmcs12_pages(struct kvm_vc=
pu *vcpu)
> > =C2=A0				offset_in_page(vmcs12->posted_intr_desc_addr));
> > =C2=A0			vmcs_write64(POSTED_INTR_DESC_ADDR,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 pfn_to_hpa(map->pfn) + offset_in_pag=
e(vmcs12->posted_intr_desc_addr));
> > +
> > +			if (!from_vmentry)
> > +				nested_vmx_enable_posted_interrupts(vcpu);
> > =C2=A0		} else {
> > =C2=A0			/*
> > =C2=A0			 * Defer the KVM_INTERNAL_EXIT until KVM tries to
> > @@ -3540,7 +3554,7 @@ static bool vmx_get_nested_state_pages(struct kvm=
_vcpu *vcpu)
> > =C2=A0	}
> > =C2=A0#endif
> > =C2=A0
> > -	if (is_guest_mode(vcpu) && !nested_get_vmcs12_pages(vcpu))
> > +	if (is_guest_mode(vcpu) && !nested_get_vmcs12_pages(vcpu, false))
> > =C2=A0		return false;
> > =C2=A0
> > =C2=A0	return true;
> > @@ -3671,7 +3685,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_roo=
t_mode(struct kvm_vcpu *vcpu,
> > =C2=A0	prepare_vmcs02_early(vmx, &vmx->vmcs01, vmcs12);
> > =C2=A0
> > =C2=A0	if (from_vmentry) {
> > -		if (unlikely(!nested_get_vmcs12_pages(vcpu))) {
> > +		if (unlikely(!nested_get_vmcs12_pages(vcpu, true))) {
> > =C2=A0			vmx_switch_vmcs(vcpu, &vmx->vmcs01);
> > =C2=A0			return NVMX_VMENTRY_KVM_INTERNAL_ERROR;
> > =C2=A0		}
> > @@ -3701,6 +3715,9 @@ enum nvmx_vmentry_status nested_vmx_enter_non_roo=
t_mode(struct kvm_vcpu *vcpu,
> > =C2=A0			vmcs12->exit_qualification =3D failed_index;
> > =C2=A0			goto vmentry_fail_vmexit_guest_mode;
> > =C2=A0		}
> > +
> > +		if (nested_cpu_has_posted_intr(vmcs12) && vmx->nested.pi_desc)
> > +			nested_vmx_enable_posted_interrupts(vcpu);
>=20
> [Severity: High]
> Does gating nested_vmx_enable_posted_interrupts() on mapping
> vmx->nested.pi_desc break the deferred KVM_EXIT_INTERNAL_ERROR when
> posted_intr_desc_addr cannot be mapped?

Yes, I made this check to be consistent with KVM_GET_NESTED_STATE, but this=
 was wrong,
KVM_NESTED_PI_ACTIVE carries more weight that I thought.
To still be consistent, I'll activate PI regardless of mapping failure in b=
oth=20
nested_vmx_enter_non_root_mode and in nested_get_vmcs12_pages.

>=20
> When kvm_vcpu_map() fails in nested_get_vmcs12_pages(), KVM sets
> vmx->nested.pi_desc =3D NULL to defer the internal error exit until
> __vmx_complete_nested_posted_interrupt() tries to access the descriptor.
> Because KVM_NESTED_PI_ACTIVE is now left unset when pi_desc is NULL,
> neither vmx_deliver_nested_posted_interrupt() nor
> vmx_check_nested_events() recognizes vmcs12->posted_intr_nv as L2's
> posted interrupt notification vector:
>=20
> arch/x86/kvm/vmx/nested.c:vmx_check_nested_events() {
> =C2=A0=C2=A0=C2=A0 ...
> 		if ((nested_state & KVM_NESTED_PI_ACTIVE) &&
> 			((nested_state & KVM_NESTED_PI_VECTOR_MASK) =3D=3D irq)) {
> 			vmx_complete_nested_posted_interrupt(vcpu);
> 			goto no_vmexit;
> 		}
> 		nested_vmx_vmexit(vcpu, EXIT_REASON_EXTERNAL_INTERRUPT,
> 				=C2=A0 INTR_INFO_VALID_MASK | INTR_TYPE_EXT_INTR | irq, 0);
> =C2=A0=C2=A0=C2=A0 ...
> }
>=20
> Instead of setting KVM_NESTED_PI_PENDING and exiting to userspace with
> KVM_EXIT_INTERNAL_ERROR via __vmx_complete_nested_posted_interrupt(), KVM
> injects a bogus EXIT_REASON_EXTERNAL_INTERRUPT VM-Exit into L1, and the
> !vmx->nested.pi_desc check in __vmx_complete_nested_posted_interrupt()
> becomes unreachable.
This should be fixed.

>=20
> > =C2=A0	} else {
> > =C2=A0		/*
> > =C2=A0		 * The MMU is not initialized to point at the right entities ye=
t and
> > @@ -3712,9 +3729,6 @@ enum nvmx_vmentry_status nested_vmx_enter_non_roo=
t_mode(struct kvm_vcpu *vcpu,
> > =C2=A0		kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
> > =C2=A0	}
> > =C2=A0
> > -	if (nested_cpu_has_posted_intr(vmcs12))
> > -		atomic_or(KVM_NESTED_PI_ACTIVE | vmcs12->posted_intr_nv,
> > -			=C2=A0 &vcpu->arch.nested_guest_state);
>=20
> [Severity: High]
> Does deferring nested_vmx_enable_posted_interrupts() until
> KVM_REQ_GET_NESTED_STATE_PAGES misdeliver nested posted interrupts when L=
2
> is restored in KVM_MP_STATE_HALTED?
>=20
> After nested_vmx_enter_non_root_mode(vcpu, false) during
> KVM_SET_NESTED_STATE (or vmx_leave_smm()), a halted L2 vCPU enters
> vcpu_block() rather than vcpu_enter_guest(), so
> KVM_REQ_GET_NESTED_STATE_PAGES is not serviced while blocked.=C2=A0 When
> another vCPU sends vmcs12->posted_intr_nv to wake L2,
> vmx_deliver_nested_posted_interrupt() sees KVM_NESTED_PI_ACTIVE =3D=3D 0 =
and
> queues the vector into L1's LAPIC IRR.=C2=A0 vcpu_block() then runs
> kvm_check_nested_events() -> vmx_check_nested_events() while
> KVM_NESTED_PI_ACTIVE is still unset, failing to morph the notification
> vector and instead reflecting a spurious EXIT_REASON_EXTERNAL_INTERRUPT
> VM-Exit to L1.
>=20
> > @@ -4025,22 +4039,15 @@ static void vmcs12_save_pending_event(struct kv=
m_vcpu *vcpu,
> > =C2=A0	}
> > =C2=A0}
> > =C2=A0
> > -static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
> > +static int __vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcp=
u)
> > =C2=A0{
> > =C2=A0	struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> > =C2=A0	int max_irr;
> > =C2=A0	void *vapic_page;
> > =C2=A0	u16 status;
> > =C2=A0
> > -	int nested_state =3D atomic_read(&vcpu->arch.nested_guest_state);
> > -
> > -	if (!(nested_state & KVM_NESTED_PI_PENDING))
> > -		return 0;
> > -
> > =C2=A0	if (!vmx->nested.pi_desc)
> > -		goto mmio_needed;
> > -
> > -	atomic_andnot(KVM_NESTED_PI_PENDING, &vcpu->arch.nested_guest_state);
> > +		return -ENXIO;
> > =C2=A0
> > =C2=A0	/*
> > =C2=A0	 * Don't test the value of PID.ON.
> > @@ -4057,7 +4064,7 @@ static int vmx_complete_nested_posted_interrupt(s=
truct kvm_vcpu *vcpu)
> > =C2=A0	if (max_irr > 0) {
> > =C2=A0		vapic_page =3D vmx->nested.virtual_apic_map.hva;
> > =C2=A0		if (!vapic_page)
> > -			goto mmio_needed;
> > +			return -ENXIO;
> > =C2=A0
> > =C2=A0		__kvm_apic_update_irr(vmx->nested.pi_desc->pir,
> > =C2=A0			vapic_page, &max_irr);
>=20
> [ ... ]
>=20
> > @@ -5121,7 +5141,10 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, =
u32 vm_exit_reason,
> > =C2=A0	if (enable_ept && is_pae_paging(vcpu))
> > =C2=A0		vmx_ept_load_pdptrs(vcpu);
> > =C2=A0
> > -	leave_guest_mode(vcpu);
> > +	old_nested_state =3D leave_guest_mode(vcpu);
> > +
> > +	if (old_nested_state & KVM_NESTED_PI_PENDING)
> > +		__vmx_complete_nested_posted_interrupt(vcpu);
>=20
> [Severity: Medium]
> Can calling __vmx_complete_nested_posted_interrupt() unconditionally in
> __nested_vmx_vmexit() lose posted interrupts when vmx->fail is set or
> virtual_apic_map is unmapped?
>=20
> When a hardware VM-Entry of vmcs02 fails (vmx->fail =3D=3D 1),
> __nested_vmx_vmexit() skips sync_vmcs02_to_vmcs12().=C2=A0 Running
> __vmx_complete_nested_posted_interrupt() before checking !vmx->fail
> clears PID.ON and harvests PID.PIR into the virtual APIC page, but writes
> the updated GUEST_INTR_STATUS.RVI to vmcs02 where it is discarded without
> being synced to vmcs12.
>=20
> Also, if virtual_apic_page_addr could not be mapped (which forces a
> vmcs02 VM-Entry failure while leaving pi_desc mapped),
> __vmx_complete_nested_posted_interrupt() clears PID.ON in guest memory
> before checking !vapic_page and returns -ENXIO without harvesting PIR or
> marking pi_desc_map dirty, while __nested_vmx_vmexit() ignores the return
> value.

While not optimal, this is not a issue, as posted interrupt is not really l=
ost,
and since it only happens once per migration, I don't think that this is a =
problem.


Best regards,
	Maxim Levitsky

