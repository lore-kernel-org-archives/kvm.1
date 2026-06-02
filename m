Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F043F0AA5
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410504; cv=none; b=ShHqT6KMgLrDzPgRY3z2PQpOahRN6b6I/0y3T72kZOgAUAhUjxLqo+yFVtMwXrXBe+ZeO9nmUn1dYw2GiAqsqpAVfobhiOsXDnPnK6begFjBvAt7uctSb7u2cwZa+9yvpZ97dfM4g67FuRsUdjBUy9rbmvCtWwVSinLEpIPYczg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410504; c=relaxed/simple;
	bh=aA6yfUlVwrY4lnP4GNVFW1EeuwUWvQUMzztYX0yECG8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jP5aj272F8D7rolwI0Z3N7banPODBV3rjx/vsBQjQERmUzyNF71fMrRquQ46so7dlSPYybm+gJOkXHHFNBqpObbaz3RKvjLJlmbPtywpCKqheE1yoednEmYNhdXcbr+0lR2efkJgkEnsAFSH7gnAlPCM+SaD5dyzwNq0bv1yLyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jid8SuHG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLPxDiX2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jid8SuHG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLPxDiX2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rz7Al6BmtvMaWx4/rV779+0g/KkbqqnrBpIyAytu1MA=;
	b=Jid8SuHGzPT7qk8J7EpPlTYppXXxiDibsJwhANu4Xo0S521U5Ggv/e5k5uijzWwiuXTfFt
	b9YPyfFzthoDZ7+c0YtRgJ3BjBXNkJzdT0i/Qy8B/c4w2GpX8lU1goGJqkpoBFI700PAtw
	rhhF8twVtHzgyI+Jmz2DkZlsjG6OvE4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-bFb1-rqXNMe96-4q3ySjrw-1; Tue, 02 Jun 2026 10:28:21 -0400
X-MC-Unique: bFb1-rqXNMe96-4q3ySjrw-1
X-Mimecast-MFC-AGG-ID: bFb1-rqXNMe96-4q3ySjrw_1780410501
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5175bf22b1bso25229991cf.3
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410501; x=1781015301; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rz7Al6BmtvMaWx4/rV779+0g/KkbqqnrBpIyAytu1MA=;
        b=NLPxDiX277CgPbKqIAA5OyNfCOMwhQEF26FyZMzUCd2QNZPMDYUvAkw9kGunTDFVQ0
         ByyFokxn+LFuEwrsyIKfHE3gNy28EysZZbsdWGdRUTwf0PneO1b+zvOKffu8BGB/modh
         N5kb7z/8yJl5LsCwSmWqgmGqnUslD/GenqWCgBoUW3+78Pm9jvqDuC/SpmLju8BETM7c
         5w2dktgCtOTVNVOtM4YE3nN75R7mYDKxZebhGfivmYFE7MxEIVHQvtzRnaYRXol1V1GZ
         H4IYCKQLI1Sz16i4uy1KNyDIoI00uJEBfqUyo4WeC4v0cjLXzO0JqpyywK4F9mchyBLo
         0nSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410501; x=1781015301;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rz7Al6BmtvMaWx4/rV779+0g/KkbqqnrBpIyAytu1MA=;
        b=g2HiKYkmti8KdUudNiv6LpA1yXxpg/pWYMjecZhDlTeAtb6l3rGv6pML+f0tOVRl0Z
         BXm7Gjha8Y7RPFNO/sRocgwLF4vzhwbOT8xIx4NHjFskBKv23EJaEMnvXfwr5hIG9o1n
         vwzwMjFRl3pgWLmUN7yvxnsCy1cosOg2rD+K35T1AYFyEDeXiZQMAN1UivTgC3X33+jb
         huIGBMU6rpFU5DN+iktW8aktxn8i9l41GIZZQ9xXyc1+dgsQk97LSN9ngba1zPMZYGNa
         KtvWIjl+TPeeJLYdMQilr/WdINrt7ojzCPRYmvPePC++tB7sscSe78VU25SqZ4K45ZhC
         zojw==
X-Forwarded-Encrypted: i=1; AFNElJ8pCNM5wm2kKwktULhxsbkp1yIS7Xlj0PsLf4ufHsjS+5C7iWXAkdsJK3VTDin0zoAF9aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKzoTx83kZ0WjsG7GVXZLpURMjrqT/nCTz/8O+jhazfU+2RRUj
	3q+Iub8RMFF3Z1a8nDX3RYPkET3/+a94VUjzBCGRtrxdsROPxP5dW3CP74lbq3tB9h7W5tJ2hJa
	wgzzXqios48yfSTP+Dyb2saSSW3s1uulO+P0it58NtD2U81JnqEMEsg==
X-Gm-Gg: Acq92OF6Fh2rpor+iEn/B9E4hFJDGjIWsryZeIOjawV1LXMuuinuRNicI7sKB4D5CWW
	r+MgpFLoZdvFog0UF6Ez7LtAWrlgoAX8cNAo47k29WtPnyFP14/6CYaK2Sr6c/pbjFs+BVfvL1+
	dcct3cPJrySFsvtcXtueqq6jiZjykf/Dj0q7u2Nf85VlEHapLMIV5lKVy8mLgXMtcnrgsrYv+QD
	7Yc5B7UbpxBsK9gYXOs4ojWqv8uRhDfcU6VDaB3tW2vxavCJse2SjHk65E5/qBMLiY5Cgs2bMlr
	cN2EsLGzET+TkYE0EaAk5BX5VIMbTdugvBVg6SeIzEQov2dbo+7NmQOkbwgpIecYiTMxFUlTLcn
	+dOTN0PiCt5r/UNQs+ady1kvEzrA8XIQxxkpLb7o=
X-Received: by 2002:a05:622a:2514:b0:516:e6f3:c1e with SMTP id d75a77b69052e-5173a86a534mr220258931cf.54.1780410500726;
        Tue, 02 Jun 2026 07:28:20 -0700 (PDT)
X-Received: by 2002:a05:622a:2514:b0:516:e6f3:c1e with SMTP id d75a77b69052e-5173a86a534mr220258321cf.54.1780410500190;
        Tue, 02 Jun 2026 07:28:20 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c07c29sm110111cf.1.2026.06.02.07.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:28:19 -0700 (PDT)
Message-ID: <ed19f9fa3fd1cc452ac73e0b9604460f724fc3e7.camel@redhat.com>
Subject: Re: [PATCH 19/28] KVM: nVMX: advertise MBEC to nested guests
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:28:18 -0400
In-Reply-To: <20260505195226.563317-20-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-20-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-05 at 21:52 +0200, Paolo Bonzini wrote:
> From: Jon Kohler <jon@nutanix.com>
>=20
> Advertise SECONDARY_EXEC_MODE_BASED_EPT_EXEC (MBEC) to userspace, which
> allows userspace to expose and advertise the feature to the guest.
>=20
> When MBEC is enabled by the guest, it is passed to the MMU via cr4_smep,
> and to the processor by the merging of vmcs12->secondary_vm_exec_control
> into the VMCS02's secondary VM execution controls.
>=20
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> Message-ID: <20251223054806.1611168-9-jon@nutanix.com>
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/kvm/mmu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +-
> =C2=A0arch/x86/kvm/mmu/mmu.c=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++++---
> =C2=A0arch/x86/kvm/mmu/spte.c=C2=A0=C2=A0 | 10 ++++++----
> =C2=A0arch/x86/kvm/vmx/nested.c | 11 +++++++++++
> =C2=A04 files changed, 22 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 23bc5b18efd0..e1e3869f568b 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -100,7 +100,7 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, u=
nsigned long cr0,
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 unsigned long cr4, u64 efer, gpa_t nested=
_cr3);
> =C2=A0void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 int huge_page_level, bool accessed_dirty,
> - =C2=A0=C2=A0=C2=A0=C2=A0 gpa_t new_eptp);
> + =C2=A0=C2=A0=C2=A0=C2=A0 bool mbec, gpa_t new_eptp);
> =C2=A0bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu);
> =C2=A0int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
> =C2=A0 u64 fault_address, char *insn, int insn_len);
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index a5b68f18b220..ededc26c6675 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5959,7 +5959,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init_shadow_npt_=
mmu);
> =C2=A0
> =C2=A0static union kvm_cpu_role
> =C2=A0kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool acce=
ssed_dirty,
> - =C2=A0=C2=A0 bool execonly, u8 level)
> + =C2=A0=C2=A0 bool execonly, u8 level, bool mbec)
> =C2=A0{
> =C2=A0 union kvm_cpu_role role =3D {0};
> =C2=A0
> @@ -5969,6 +5969,7 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu =
*vcpu, bool accessed_dirty,
> =C2=A0 */
> =C2=A0 WARN_ON_ONCE(is_smm(vcpu));
> =C2=A0 role.base.level =3D level;
> + role.base.cr4_smep =3D mbec;
> =C2=A0 role.base.has_4_byte_gpte =3D false;
> =C2=A0 role.base.direct =3D false;
> =C2=A0 role.base.ad_disabled =3D !accessed_dirty;
> @@ -5984,13 +5985,13 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcp=
u *vcpu, bool accessed_dirty,
> =C2=A0
> =C2=A0void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 int huge_page_level, bool accessed_dirty,
> - =C2=A0=C2=A0=C2=A0=C2=A0 gpa_t new_eptp)
> + =C2=A0=C2=A0=C2=A0=C2=A0 bool mbec, gpa_t new_eptp)
> =C2=A0{
> =C2=A0 struct kvm_mmu *context =3D &vcpu->arch.guest_mmu;
> =C2=A0 u8 level =3D vmx_eptp_page_walk_level(new_eptp);
> =C2=A0 union kvm_cpu_role new_mode =3D
> =C2=A0 kvm_calc_shadow_ept_root_page_role(vcpu, accessed_dirty,
> - =C2=A0=C2=A0 execonly, level);
> + =C2=A0=C2=A0 execonly, level, mbec);
> =C2=A0
> =C2=A0 if (new_mode.as_u64 !=3D context->cpu_role.as_u64) {
> =C2=A0 /* EPT, and thus nested EPT, does not consume CR0, CR4, nor EFER. =
*/
> diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
> index f41573b0ccfa..d2f5f7dd8fe1 100644
> --- a/arch/x86/kvm/mmu/spte.c
> +++ b/arch/x86/kvm/mmu/spte.c
> @@ -517,10 +517,12 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits)
> =C2=A0 * host's MBEC setting does not matter.=C2=A0 On hardware without M=
BEC
> =C2=A0 * the XU bit is reserved-as-ignored, and setting it does no harm.
> =C2=A0 *
> - * For nested EPT MBEC is not supported, but bit 10 of the gPTE has
> - * no effect because (a) is_present_gpte() does not treat it as a
> - * present bit, and (b) permission_fault() uses an mmu->permissions[]
> - * array that effectively ignores ACC_USER_EXEC_MASK.
> + * For nested EPT, when MBEC is disabled by L1, correctness relies
> + * on (a) ignoring bit 10 of the gPTE in is_present_gpte(), rather
> + * than treating it as a present bit, and (b) permission_fault()
> + * using an mmu->permissions[] array that effectively ignores
> + * ACC_USER_EXEC_MASK.=C2=A0 Bit 10 of the gPTE does end up mirrored
> + * in the sPTEs but is ignored because L2 runs with MBEC disabled.

Makes sense.

> =C2=A0 */
> =C2=A0 shadow_xu_mask =3D VMX_EPT_USER_EXECUTABLE_MASK;
> =C2=A0 shadow_present_mask =3D VMX_EPT_SUPPRESS_VE_BIT;
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 84f5c25a1f12..bc1046f32ebc 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -469,6 +469,13 @@ static void nested_ept_inject_page_fault(struct kvm_=
vcpu *vcpu,
> =C2=A0 vmcs12->guest_physical_address =3D fault->address;
> =C2=A0}
> =C2=A0
> +static inline bool nested_ept_mbec_enabled(struct kvm_vcpu *vcpu)
> +{
> + struct vmcs12 *vmcs12 =3D get_vmcs12(vcpu);
> +
> + return nested_cpu_has2(vmcs12, SECONDARY_EXEC_MODE_BASED_EPT_EXEC);
> +}
> +
> =C2=A0static void nested_ept_new_eptp(struct kvm_vcpu *vcpu)
> =C2=A0{
> =C2=A0 struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> @@ -477,6 +484,7 @@ static void nested_ept_new_eptp(struct kvm_vcpu *vcpu=
)
> =C2=A0
> =C2=A0 kvm_init_shadow_ept_mmu(vcpu, execonly, ept_lpage_level,
> =C2=A0 nested_ept_ad_enabled(vcpu),
> + nested_ept_mbec_enabled(vcpu),
> =C2=A0 nested_ept_get_eptp(vcpu));
> =C2=A0}
> =C2=A0
> @@ -7257,6 +7265,9 @@ static void nested_vmx_setup_secondary_ctls(u32 ept=
_caps,
> =C2=A0 msrs->ept_caps |=3D VMX_EPT_AD_BIT;
> =C2=A0 }
> =C2=A0
> + if (enable_mbec)
> + msrs->secondary_ctls_high |=3D
> + SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
> =C2=A0 /*
> =C2=A0 * Advertise EPTP switching irrespective of hardware support,
> =C2=A0 * KVM emulates it in software so long as VMFUNC is supported.



Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

