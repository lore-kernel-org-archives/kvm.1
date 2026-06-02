Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472D63EC2E3
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410704; cv=none; b=U0vBgG7D/H8bkfvxBgiwZF5UGyzmzwxmqNv+eh5bEqZCSWaN5EtkNGnP7Dhl9lMbe1iTL909zXlEZbr/Np5zrT6OHP6Ya/Lavyu8WdfZcSMbrqfw0RYVQhbfVyshws43V3cGz2nbX0olFJ4e9VY1JP4mdBU8tKJo31OgxVgqh/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410704; c=relaxed/simple;
	bh=TFypjZfLo9DnzPpOKLzpfkjiZrHA9SKY8YB0TyK9fXk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DDgNn4ylU9sa39/SEtui4FOyfXZLP7o7BIHJVDdmtW3srJs3Wc5FofOQ7BCeJ/opbcPkt5krTmq5cRAuKUn4lvAtTHWTH3Wb03F8UFyQKYt+tHswp7yDFH8wfcAGavvMkObNaIOD1SYNk2jv+LwVif+yYLWKf7yw2hwAbP6+W9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3b0+Uot; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rzki6W5k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3b0+Uot";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rzki6W5k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fjMoXrkd1B8wpID54sGKDOMLgz88p/WNA39to9hP/mM=;
	b=e3b0+UotkVW9ZF8YyJA9HxdYEfw1ntIaC7AaN3P+VEG23kaepsoWttyD4Y2QNRod4yTgAf
	Aj3kWi5pW8lNcHfnbCq5i+k/6jkHMZoL6WVP9QNyDRC8eWstCVQFDum3dxcZaJ1igEdPjh
	mA+0HaU+yRrCG+uWdQiaK4dTxdDRGFQ=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-Acu6CAS5PvGKkKr9RUgKIw-1; Tue, 02 Jun 2026 10:31:41 -0400
X-MC-Unique: Acu6CAS5PvGKkKr9RUgKIw-1
X-Mimecast-MFC-AGG-ID: Acu6CAS5PvGKkKr9RUgKIw_1780410700
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-66070d79aaaso4072382d50.2
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410700; x=1781015500; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fjMoXrkd1B8wpID54sGKDOMLgz88p/WNA39to9hP/mM=;
        b=Rzki6W5kBxC/gt6zp9W0dbI5RKhKkjnrCZXDbQ/tvQkdCUwRIjQVslqa2dY4WEh6Ne
         /BHrT099y5TimQ/xlx8tx8oqhFRmtM94oJYzF//+qFGw1Wlo5e0y4jP9refRTvItUBiM
         pEBRmiKosLjr48kzVYFuew+lNZM+hhsVR67FgCv4oDh5A//2zaqFPv3vjAyFu8HZ3wuT
         uNGtt87P/YVAGosAbGKo2wlYIXKj/XDTrmUfI4jw1lnJqgVY/pZ1rwekzabZNxuw6pXh
         oW7tn7/1rVt53b5HHLI8ru2Xnhw8aYBbuFd3uiu3C6GKU4OPF7z0i4xQyMselYAy3K0e
         HtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410700; x=1781015500;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjMoXrkd1B8wpID54sGKDOMLgz88p/WNA39to9hP/mM=;
        b=GAruLRUer8bLchJPD9TD0JsmWb4svmUgbFwYhy1UJSGifioSyDvHBe2iM7V3G0e+ZA
         6vXko7EgBhgmu2DWiMIiMsqutS+6jll1FJamOA5d1NgeEMZo9xMo7mBQOH213sCSh4Qk
         mINS7hXsPtydQUYo2tqSqoigjOO0q6FR6/zIreToSfaciQ8G2EJwPPg2xaqDVN+MrvtJ
         fcWbrbSsNScTm1SZ4YC8kokUgLfnjk5O+1o6+W53Acaa4Z0gV/HjfNoZC/GYyMCggA88
         fKWaFw/iDZXCxIopLKtFJnrAhJXl9wyRlMoE4ZnjWRYT5qZw4vXLLRg0kqF/equqBX+7
         6cfQ==
X-Forwarded-Encrypted: i=1; AFNElJ8AvaRMJQfomEAsxu90Xb+OJjVW/giMREwkioMunF6SHSO0F5nxAcBf+OHrKtn37a4nuxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaSkTUhfLxqSLid8G0WT3PY971bIbc3p+VQ+DqJgN8RplT0EzL
	X710Op+6uT9yJEDdHtsPVyZy1Gnz+qtUOTr6SQPDU6PfuXuhNNnsQZV7q7rzz/Fg9+wUeM8Ewbb
	/0WsvwU3HHjQBMCYJ0XgJ8643NRUM/LujDIeWzoTcf4GC80tLrghbjA==
X-Gm-Gg: Acq92OFZAe9JeeuKw5oQn3JC/aNH1eiSH4xSBq01Fe44W9CWwikevtD1NKkR32zGL9G
	YoEFOoqQMIYui/TZPpFF1sBQpIL85qKcEjWxYEntYfKpPdSeovpkO/6DtU/cKqEOokHZTmRl+I4
	9zxso0CY4W8QaHd63XbvXgf9Pa5HkrlgVAtt9RQR8iS9ZKz7i+6apUFNO70/hdO43w+TyZYw3w6
	OvfFVK2/TRePNvSM+y9+CM42EQ4tUfrzcbt0EUmiGbWIVXpfl2LnAbU/MUY2YA3v6dMa/aruaSL
	Fsm5IXplrbBAFn2ol8sMgRDTVsv/S1q0VDyho8DQdTm6g0wyX74y0Yp10WLSixGVDTACN9eMo4v
	e5ju+gW9xjddEPLg5N2brwKjvoQTJBH0OZs6qrQI=
X-Received: by 2002:a05:690e:1402:b0:660:7b4d:1ac9 with SMTP id 956f58d0204a3-6607b4d2483mr8879381d50.38.1780410700069;
        Tue, 02 Jun 2026 07:31:40 -0700 (PDT)
X-Received: by 2002:a05:690e:1402:b0:660:7b4d:1ac9 with SMTP id 956f58d0204a3-6607b4d2483mr8879325d50.38.1780410699493;
        Tue, 02 Jun 2026 07:31:39 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51758107935sm44332221cf.31.2026.06.02.07.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:31:38 -0700 (PDT)
Message-ID: <fdc9db2564255cb3a0c87e3aca62e75e1a318808.camel@redhat.com>
Subject: Re: [PATCH 26/28] KVM: SVM: enable GMET and set it in MMU role
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:31:37 -0400
In-Reply-To: <20260505195226.563317-27-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-27-pbonzini@redhat.com>
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
> Set the GMET bit in the nested control field.=C2=A0 This has effectively
> no impact as long as NPT page tables are changed to have U=3D0.
>=20
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/kvm/mmu/mmu.c=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++++-
> =C2=A0arch/x86/kvm/svm/nested.c |=C2=A0 9 ++++++---
> =C2=A0arch/x86/kvm/svm/svm.c=C2=A0=C2=A0=C2=A0 | 16 ++++++++++++++++
> =C2=A0arch/x86/kvm/svm/svm.h=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A04 files changed, 28 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index a283b5078c61..8b6122b66f06 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5855,7 +5855,6 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vc=
pu,
> =C2=A0{
> =C2=A0 union kvm_mmu_page_role role =3D {0};
> =C2=A0
> - role.access =3D ACC_ALL;
> =C2=A0 role.cr0_wp =3D true;
> =C2=A0 role.cr4_smep =3D kvm_x86_call(tdp_has_smep)(vcpu->kvm);
> =C2=A0 role.efer_nx =3D true;
> @@ -5866,6 +5865,11 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *v=
cpu,
> =C2=A0 role.direct =3D true;
> =C2=A0 role.has_4_byte_gpte =3D false;
> =C2=A0
> + /* All TDP pages are supervisor-executable */
> + role.access =3D ACC_ALL;
> + if (role.cr4_smep && shadow_user_mask)
> + role.access &=3D ~ACC_USER_MASK;
> +
> =C2=A0 return role;
> =C2=A0}
> =C2=A0
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 7adfa7da210d..74a1df1cb84f 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -858,7 +858,7 @@ static void nested_vmcb02_prepare_control(struct vcpu=
_svm *svm)
> =C2=A0 * the latter, L1 runs L2 with shadow page tables that translate L2=
 GVAs
> =C2=A0 * to L1 GPAs, so the same NPTs can be used for L1 and L2.
> =C2=A0 */
> - vmcb02->control.misc_ctl =3D vmcb01->control.misc_ctl & SVM_MISC_ENABLE=
_NP;
> + vmcb02->control.misc_ctl =3D vmcb01->control.misc_ctl & (SVM_MISC_ENABL=
E_NP | SVM_MISC_ENABLE_GMET);
> =C2=A0 vmcb02->control.iopm_base_pa =3D vmcb01->control.iopm_base_pa;
> =C2=A0 vmcb02->control.msrpm_base_pa =3D vmcb01->control.msrpm_base_pa;
> =C2=A0 vmcb_mark_dirty(vmcb02, VMCB_PERM_MAP);
> @@ -895,9 +895,12 @@ static void nested_vmcb02_prepare_control(struct vcp=
u_svm *svm)
> =C2=A0 /* Also overwritten later if necessary.=C2=A0 */
> =C2=A0 vmcb02->control.tlb_ctl =3D TLB_CONTROL_DO_NOTHING;
> =C2=A0
> - /* nested_cr3.=C2=A0 */
> - if (nested_npt_enabled(svm))
> + /* Use vmcb01 MMU and format if guest does not use nNPT */
> + if (nested_npt_enabled(svm)) {
> + vmcb02->control.misc_ctl &=3D ~SVM_MISC_ENABLE_GMET;

Hi!

Since this touches nesting without actually doing anything yet,
do you think it makes sense to move these two hunks to the last patch?


> +
> =C2=A0 nested_svm_init_mmu_context(vcpu);
> + }
> =C2=A0
> =C2=A0 vcpu->arch.tsc_offset =3D kvm_calc_nested_tsc_offset(vcpu->arch.l1=
_tsc_offset,
> =C2=A0 =C2=A0=C2=A0 vmcb12_ctrl->tsc_offset,
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e7fdd7a9c280..3895d8794366 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -138,6 +138,9 @@ module_param(pause_filter_count_max, ushort, 0444);
> =C2=A0bool __ro_after_init npt_enabled =3D true;
> =C2=A0module_param_named(npt, npt_enabled, bool, 0444);
> =C2=A0
> +bool gmet_enabled =3D true;
> +module_param_named(gmet, gmet_enabled, bool, 0444);
> +
> =C2=A0/* allow nested virtualization in KVM/SVM */
> =C2=A0static int __ro_after_init nested =3D true;
> =C2=A0module_param(nested, int, 0444);
> @@ -1209,6 +1212,10 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool =
init_event)
> =C2=A0 save->g_pat =3D vcpu->arch.pat;
> =C2=A0 save->cr3 =3D 0;
> =C2=A0 }
> +
> + if (gmet_enabled)
> + control->misc_ctl |=3D SVM_MISC_ENABLE_GMET;
> +
> =C2=A0 svm->current_vmcb->asid_generation =3D 0;
> =C2=A0 svm->asid =3D 0;
> =C2=A0
> @@ -4612,6 +4619,11 @@ svm_patch_hypercall(struct kvm_vcpu *vcpu, unsigne=
d char *hypercall)
> =C2=A0 hypercall[2] =3D 0xd9;
> =C2=A0}
> =C2=A0
> +static bool svm_tdp_has_smep(struct kvm *kvm)
> +{
> + return gmet_enabled;
> +}
> +
> =C2=A0/*
> =C2=A0 * The kvm parameter can be NULL (module initialization, or invocat=
ion before
> =C2=A0 * VM creation). Be sure to check the kvm parameter before using it=
.
> @@ -5355,6 +5367,7 @@ struct kvm_x86_ops svm_x86_ops __initdata =3D {
> =C2=A0 .write_tsc_multiplier =3D svm_write_tsc_multiplier,
> =C2=A0
> =C2=A0 .load_mmu_pgd =3D svm_load_mmu_pgd,
> + .tdp_has_smep =3D svm_tdp_has_smep,
> =C2=A0
> =C2=A0 .check_intercept =3D svm_check_intercept,
> =C2=A0 .handle_exit_irqoff =3D svm_handle_exit_irqoff,
> @@ -5588,6 +5601,9 @@ static __init int svm_hardware_setup(void)
> =C2=A0 if (!boot_cpu_has(X86_FEATURE_NPT))
> =C2=A0 npt_enabled =3D false;
> =C2=A0
> + if (!npt_enabled || !boot_cpu_has(X86_FEATURE_GMET))
> + gmet_enabled =3D false;
> +
> =C2=A0 /* Force VM NPT level equal to the host's paging level */
> =C2=A0 kvm_configure_mmu(npt_enabled, get_npt_level(),
> =C2=A0 =C2=A0 get_npt_level(), PG_LEVEL_1G);
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index a10668d17a16..dd93b3daefa9 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -44,6 +44,7 @@ static inline struct page *__sme_pa_to_page(unsigned lo=
ng pa)
> =C2=A0#define IOPM_SIZE PAGE_SIZE * 3
> =C2=A0#define MSRPM_SIZE PAGE_SIZE * 2
> =C2=A0
> +extern bool gmet_enabled;
> =C2=A0extern bool npt_enabled;
> =C2=A0extern int nrips;
> =C2=A0extern int vgif;


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

