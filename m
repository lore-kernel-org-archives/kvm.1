Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A803F54C6
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410398; cv=none; b=IiuS5gzL17XrbUYZ9ygEsPEAbuKBMcNdudCci/Rh+V/EnaEtyuEMRp4a91JvB3cSPfLhZguUohh/ysSTYP+0GXElwTEDOBV/jIBlm3EoMfOTOS9kAeNtgIFGcKfj+HbqLqV3f66KkXEomaGu4qEY4Z6YYQFar6chpaSMf/0UVWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410398; c=relaxed/simple;
	bh=gTRtNe/elumsG8sdTc5c7UaMv9O77RaTZt8fSxo+ULc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BGfVkyQXleWHFlULEcKxVhtQUmRokPrEF0kyJqtGPntSgN6HxgcFnvuj80mwx8+E30xSJSoErt8XDVfOhyChW1FltqmpzbdXuSVyJcZDyVUYI3RljPLi3s0uuiw9SJTV1aqdckFY1sQbqIUQFm3A8dwCxrk5t0bl9FXU69FiJiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b0CtI+of; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KdCXIPjU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0CtI+of";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdCXIPjU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CtymgwRiB/i8yXA0KybQQF1a3LCwRRh5GYoTq1DS+Q4=;
	b=b0CtI+ofsRP67D/yVD3xbxpbypP7VfVy7nudCDD543ccS+EhT1jgrSwruSN+8QcZ4YFGOy
	Q9fDN6XHB6hSFrmkxYALyjKD8U36rXeqO8Wjq3UWPfm9h8MtKUzv71vvb5v2/DoCvb4TqP
	Lm9olAcofxNXW+5a3Uu9c5kjHLDNgi8=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-kUdSVb_ZPuGUCiOABFlUCg-1; Tue, 02 Jun 2026 10:26:33 -0400
X-MC-Unique: kUdSVb_ZPuGUCiOABFlUCg-1
X-Mimecast-MFC-AGG-ID: kUdSVb_ZPuGUCiOABFlUCg_1780410393
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-963aef8141bso1000161241.0
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410392; x=1781015192; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CtymgwRiB/i8yXA0KybQQF1a3LCwRRh5GYoTq1DS+Q4=;
        b=KdCXIPjUDPaLsM18tmeD65uFXJcccN7qbygH3TPZmxP7G71/oyJ+RD5MPn3ygNqEWw
         z36NmpCckiXpTUUusv1SPxxVPAHbW0mxCmg1OmZ2W+gq/Cuz8ulSWgxZSaFCHzHZJbGE
         cTHxDQvnpR1zY53KnpWnZknNiHfdJt/WrvGVNMOpdBdHQxt/6mIxjV/KK6MJH/jV+QdL
         qxLQQl1pnlFk3L35k9D9u0YkpOi1C903G5eLMe9ov3BYr53GlbrngvZS7QVB1LFbnR6B
         FOCahdHbucjWqSw5OYUFQbrq/5lJuMM47RE/4f7RFzjFn1L6hGAuq2BsUmnoyDCHMGaU
         xciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410392; x=1781015192;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtymgwRiB/i8yXA0KybQQF1a3LCwRRh5GYoTq1DS+Q4=;
        b=G430PaAMIE0r7O32Eloj4Jz5JINxcxGmR4Kl5R4VYOm1t25jdIE2wUFN16U7gLk/EU
         bvPi8jWmdYPbjc+T4sJk+lYKzWIprlhRRBSYM5pQsBiJu1RU9Stzmx0CDAhvW0u6SZDh
         dOvR7+AvRqmIyXZnQ0W2PJSV5dbennztTuuP9Vth9Aq+c0It/8Z8JtNGaKD0b/RcCq3p
         yxggPdqOMdjyeHcbM6hQ8N6VcHAvfZOPromX8ZDGUJPGPDZaZ+5ZLt1SpqHGLhT+9LTy
         x6xa9/MQL2K6Q9WUzDPxoxiI0eKmQkrgbft13dLY104PpE/ATFXFPbDp/13oyoC7c/Gh
         xGjw==
X-Forwarded-Encrypted: i=1; AFNElJ+5Jb2w9OtrryXR8FmUylei+EZZt3fSju8x5v4nqzQ2AmHJByB3Y5GCGgN9woh+IDtUSL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYQ2cqkdUGM27Hk2JCflLOhk+7dA9L3dAqRU/L2OKTqlrA0WT7
	ux8XC57/YTi2c2lMbRnQikxg7dpRzWMM8EeyaLi7lC6COEoSForPa/JMuoRmwk1KCICcwlm+NIf
	y09uQWn1sBJ53pOSTi6wfbvmuHNzq7Rg7XKeBIAOv5WDwGmcJnbx9kA==
X-Gm-Gg: Acq92OHpU0Q15vek2u2clw8Gyvf8q+xGW5XvIykA1uYaR+hDTKD8yvP/FOlxr8+Kk1q
	/UUWd/RA76le+A7oS6cpdSTT5GTrUfax+wHZkZHUbtfi+5KWWK10K1WZHb2t+gXtxGTJkZa4LKh
	ACbPSzhj8hQf1O8wrXZl3fCzh3mv6KM3xAjRBaouHWIJpixvz9bJ6TQ5v5bmsJUoalAtYDo8rq/
	x9iySExyjKpfufMoHI6OQPXoNJLPctGGr56s3AN/dPnmUggDqj1BtHC7LNA7AZtIfBoyEZ/VoQ0
	uojEQGpJRq8WW+NuOhwgm+ZVWecT5oHquFhrUJbMgUPaI/nsXWeMKe/e1L3qdzVGwmO+njO/pC3
	I4/r2yq7NWXyqSt9GuGxSdlznYcDzhnYtuXtKvn8=
X-Received: by 2002:a05:6102:801e:b0:611:e0c2:1604 with SMTP id ada2fe7eead31-6c6945aa17amr6740707137.19.1780410392297;
        Tue, 02 Jun 2026 07:26:32 -0700 (PDT)
X-Received: by 2002:a05:6102:801e:b0:611:e0c2:1604 with SMTP id ada2fe7eead31-6c6945aa17amr6740627137.19.1780410391743;
        Tue, 02 Jun 2026 07:26:31 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6c893de04c9sm7523907137.7.2026.06.02.07.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:26:31 -0700 (PDT)
Message-ID: <9cb8cf3f913018aaa0675b200cbd2eb93c306024.camel@redhat.com>
Subject: Re: [PATCH 15/28] KVM: VMX: enable use of MBEC
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:26:30 -0400
In-Reply-To: <20260505195226.563317-16-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-16-pbonzini@redhat.com>
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
> If available, set SECONDARY_EXEC_MODE_BASED_EPT_EXEC in the secondary
> execution controls.
>=20
> The changes are limited because the MMU is designed to create the same
> sPTEs independent of the MBEC setting.=C2=A0 On hosts lacking support for
> MBEC, and in nested guests which cannot enable it as of this commit,
> the XU bit is ignored by the processor.
>=20
> Note that, as of this patch, MBEC is not available to L1 hypervisors
> for their guests.
>=20
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/include/asm/vmx.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 =
+++
> =C2=A0arch/x86/kvm/mmu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++++
> =C2=A0arch/x86/kvm/vmx/capabilities.h |=C2=A0 7 +++++++
> =C2=A0arch/x86/kvm/vmx/common.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 =
+++++-----
> =C2=A0arch/x86/kvm/vmx/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 9 +++++++++
> =C2=A0arch/x86/kvm/vmx/nested.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 1 +
> =C2=A0arch/x86/kvm/vmx/vmx.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 14 ++++++++++++++
> =C2=A0arch/x86/kvm/vmx/vmx.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 1 +
> =C2=A0arch/x86/kvm/vmx/x86_ops.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 =
+
> =C2=A09 files changed, 46 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index 2b30b921b375..54aa5be50df9 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -619,9 +619,12 @@ enum vm_entry_failure_code {
> =C2=A0#define EPT_VIOLATION_GVA_TRANSLATED BIT(8)
> =C2=A0
> =C2=A0#define EPT_VIOLATION_RWX_TO_PROT(__epte) (((__epte) & VMX_EPT_RWX_=
MASK) << 3)
> +#define EPT_VIOLATION_USER_EXEC_TO_PROT(__epte) (((__epte) & VMX_EPT_USE=
R_EXECUTABLE_MASK) >> 4)
> =C2=A0
> =C2=A0static_assert(EPT_VIOLATION_RWX_TO_PROT(VMX_EPT_RWX_MASK) =3D=3D
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (EPT_VIOLATION_PROT_READ | EPT_VIOL=
ATION_PROT_WRITE | EPT_VIOLATION_PROT_EXEC));
> +static_assert(EPT_VIOLATION_USER_EXEC_TO_PROT(VMX_EPT_USER_EXECUTABLE_MA=
SK) =3D=3D
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (EPT_VIOLATION_PROT_USER_EXEC));
> =C2=A0
> =C2=A0/*
> =C2=A0 * Exit Qualifications for NOTIFY VM EXIT
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index d8c13e43c2d7..23bc5b18efd0 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -83,6 +83,11 @@ static inline gfn_t kvm_mmu_max_gfn(void)
> =C2=A0 return (1ULL << (max_gpa_bits - PAGE_SHIFT)) - 1;
> =C2=A0}
> =C2=A0
> +static inline bool mmu_has_mbec(struct kvm_mmu *mmu)
> +{
> + return mmu->root_role.cr4_smep;
> +}

Hi!

Sorry to complain again :), but in my opinion
'mmu_has_mbec' is also a bit confusing, especially since this will be true =
for NPT as well.
A comment can help saying that this function should only be called on MMU t=
hat uses EPT.

If we go with my suggestion though of a vendor neutral name then I think th=
at we can eliminate this function
and just open code :

if (mmu->root_role.has_user_exec_permission)
    ....

What do you think?


> +
> =C2=A0u8 kvm_mmu_get_max_tdp_level(void);
> =C2=A0
> =C2=A0void kvm_mmu_set_mmio_spte_mask(u64 mmio_value, u64 mmio_mask, u64 =
access_mask);
> diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilit=
ies.h
> index 7e59eb0f41bb..07469d1cfe74 100644
> --- a/arch/x86/kvm/vmx/capabilities.h
> +++ b/arch/x86/kvm/vmx/capabilities.h
> @@ -15,6 +15,7 @@ extern bool __read_mostly enable_ept;
> =C2=A0extern bool __read_mostly enable_unrestricted_guest;
> =C2=A0extern bool __read_mostly enable_ept_ad_bits;
> =C2=A0extern bool __read_mostly enable_pml;
> +extern bool __read_mostly enable_mbec;
> =C2=A0extern int __read_mostly pt_mode;
> =C2=A0
> =C2=A0#define PT_MODE_SYSTEM 0
> @@ -406,4 +407,10 @@ static inline bool cpu_has_notify_vmexit(void)
> =C2=A0 SECONDARY_EXEC_NOTIFY_VM_EXITING;
> =C2=A0}
> =C2=A0
> +static inline bool cpu_has_ept_mbec(void)
> +{
> + return vmcs_config.cpu_based_2nd_exec_ctrl &
> + SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
> +}
> +
> =C2=A0#endif /* __KVM_X86_VMX_CAPS_H */
> diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
> index 1afbf272efae..40fa72f31fc7 100644
> --- a/arch/x86/kvm/vmx/common.h
> +++ b/arch/x86/kvm/vmx/common.h
> @@ -91,15 +91,15 @@ static inline int __vmx_handle_ept_violation(struct k=
vm_vcpu *vcpu, gpa_t gpa,
> =C2=A0 /* Is it a fetch fault? */
> =C2=A0 error_code |=3D (exit_qualification & EPT_VIOLATION_ACC_INSTR)
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? PFERR_FETCH_MASK : 0;
> - /*
> - * ept page table entry is present?
> - * note: unconditionally clear USER_EXEC until mode-based
> - * execute control is implemented
> - */
> + /* ept page table entry is present?=C2=A0 */
> =C2=A0 error_code |=3D (exit_qualification &
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (EPT_VIOLATION_PROT_MASK & ~E=
PT_VIOLATION_PROT_USER_EXEC))
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? PFERR_PRESENT_MASK : 0;
> =C2=A0
> + if (mmu_has_mbec(vcpu->arch.mmu))
> + error_code |=3D (exit_qualification & EPT_VIOLATION_PROT_USER_EXEC)
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? PFERR_PRESENT_MASK : 0;
> +
> =C2=A0 if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID)
> =C2=A0 error_code |=3D (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED=
) ?
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PFERR_GUEST_FINAL_MASK : PFERR_GUES=
T_PAGE_MASK;
> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> index dbebddf648be..83d9921277ea 100644
> --- a/arch/x86/kvm/vmx/main.c
> +++ b/arch/x86/kvm/vmx/main.c
> @@ -755,6 +755,14 @@ static int vt_set_identity_map_addr(struct kvm *kvm,=
 u64 ident_addr)
> =C2=A0 return vmx_set_identity_map_addr(kvm, ident_addr);
> =C2=A0}
> =C2=A0
> +static bool vt_tdp_has_smep(struct kvm *kvm)
> +{
> + if (is_td(kvm))
> + return false;
> +
> + return vmx_tdp_has_smep(kvm);
> +}
> +
> =C2=A0static u64 vt_get_l2_tsc_offset(struct kvm_vcpu *vcpu)
> =C2=A0{
> =C2=A0 /* TDX doesn't support L2 guest at the moment. */
> @@ -966,6 +974,7 @@ struct kvm_x86_ops vt_x86_ops __initdata =3D {
> =C2=A0 .set_tss_addr =3D vt_op(set_tss_addr),
> =C2=A0 .set_identity_map_addr =3D vt_op(set_identity_map_addr),
> =C2=A0 .get_mt_mask =3D vmx_get_mt_mask,
> + .tdp_has_smep =3D vt_op(tdp_has_smep),
> =C2=A0
> =C2=A0 .get_exit_info =3D vt_op(get_exit_info),
> =C2=A0 .get_entry_info =3D vt_op(get_entry_info),
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index cd1924c6e075..299d4ca60fb3 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2440,6 +2440,7 @@ static void prepare_vmcs02_early(struct vcpu_vmx *v=
mx, struct loaded_vmcs *vmcs0
> =C2=A0 =C2=A0 SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
> =C2=A0 =C2=A0 SECONDARY_EXEC_APIC_REGISTER_VIRT |
> =C2=A0 =C2=A0 SECONDARY_EXEC_ENABLE_VMFUNC |
> + =C2=A0 SECONDARY_EXEC_MODE_BASED_EPT_EXEC |
> =C2=A0 =C2=A0 SECONDARY_EXEC_DESC);
> =C2=A0
> =C2=A0 if (nested_cpu_has(vmcs12,
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 337bbfecc021..f1d616f928a1 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -114,6 +114,9 @@ module_param(emulate_invalid_guest_state, bool, 0444)=
;
> =C2=A0static bool __read_mostly fasteoi =3D 1;
> =C2=A0module_param(fasteoi, bool, 0444);
> =C2=A0
> +bool __read_mostly enable_mbec =3D 1;
> +module_param_named(mbec, enable_mbec, bool, 0444);
> +
> =C2=A0module_param(enable_apicv, bool, 0444);
> =C2=A0module_param(enable_ipiv, bool, 0444);
> =C2=A0
> @@ -2773,6 +2776,7 @@ static int setup_vmcs_config(struct vmcs_config *vm=
cs_conf,
> =C2=A0 return -EIO;
> =C2=A0
> =C2=A0 vmx_cap->ept =3D 0;
> + _cpu_based_2nd_exec_control &=3D ~SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
> =C2=A0 _cpu_based_2nd_exec_control &=3D ~SECONDARY_EXEC_EPT_VIOLATION_VE;
> =C2=A0 }
> =C2=A0 if (!(_cpu_based_2nd_exec_control & SECONDARY_EXEC_ENABLE_VPID) &&
> @@ -4735,6 +4739,9 @@ static u32 vmx_secondary_exec_control(struct vcpu_v=
mx *vmx)
> =C2=A0 */
> =C2=A0 exec_control &=3D ~SECONDARY_EXEC_ENABLE_VMFUNC;
> =C2=A0
> + if (!enable_mbec)
> + exec_control &=3D ~SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
> +
> =C2=A0 /* SECONDARY_EXEC_DESC is enabled/disabled on writes to CR4.UMIP,
> =C2=A0 * in vmx_set_cr4.=C2=A0 */
> =C2=A0 exec_control &=3D ~SECONDARY_EXEC_DESC;
> @@ -7823,6 +7830,11 @@ u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gf=
n, bool is_mmio)
> =C2=A0 return (MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT);
> =C2=A0}
> =C2=A0
> +bool vmx_tdp_has_smep(struct kvm *kvm)
> +{
> + return enable_mbec;
> +}
> +
> =C2=A0static void vmcs_set_secondary_exec_control(struct vcpu_vmx *vmx, u=
32 new_ctl)
> =C2=A0{
> =C2=A0 /*
> @@ -8622,6 +8634,8 @@ __init int vmx_hardware_setup(void)
> =C2=A0
> =C2=A0 if (!cpu_has_vmx_ept_ad_bits() || !enable_ept)
> =C2=A0 enable_ept_ad_bits =3D 0;
> + if (!cpu_has_ept_mbec() || !enable_ept)
> + enable_mbec =3D 0;
> =C2=A0
> =C2=A0 if (!cpu_has_vmx_unrestricted_guest() || !enable_ept)
> =C2=A0 enable_unrestricted_guest =3D 0;
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index db84e8001da5..0a4e263c4095 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -567,6 +567,7 @@ static inline u8 vmx_get_rvi(void)
> =C2=A0 SECONDARY_EXEC_ENABLE_VMFUNC | \
> =C2=A0 SECONDARY_EXEC_BUS_LOCK_DETECTION | \
> =C2=A0 SECONDARY_EXEC_NOTIFY_VM_EXITING | \
> + SECONDARY_EXEC_MODE_BASED_EPT_EXEC | \
> =C2=A0 SECONDARY_EXEC_ENCLS_EXITING | \
> =C2=A0 SECONDARY_EXEC_EPT_VIOLATION_VE)
> =C2=A0
> diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
> index d09abeac2b56..69cf276be88e 100644
> --- a/arch/x86/kvm/vmx/x86_ops.h
> +++ b/arch/x86/kvm/vmx/x86_ops.h
> @@ -103,6 +103,7 @@ void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 =
*eoi_exit_bitmap);
> =C2=A0int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr);
> =C2=A0int vmx_set_identity_map_addr(struct kvm *kvm, u64 ident_addr);
> =C2=A0u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio);
> +bool vmx_tdp_has_smep(struct kvm *kvm);
> =C2=A0
> =C2=A0void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 *info1, u64 *info2, u32 *=
intr_info, u32 *error_code);

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky

