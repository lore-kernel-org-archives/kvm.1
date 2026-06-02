Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA431342532
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410345; cv=none; b=V9tj8V8CQt+6GzBgJ3uRplPgFh6zBhrdDFHkpJulEnQWaBQ1mw1hluy5ucSjx+rKUcEKhfFRMhLfDmV+f217kQPqRaAA1QPnzCDWPU3rLmun1u+ZzrGcvuu4su6t4wjsT/5odyimPys320AigZZHYu9e5EjBWFghu8rr3apOBA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410345; c=relaxed/simple;
	bh=LGrbagM3xoLh11OXIndJvB9EJmGn02gSetu3YKXCg/M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BRTY/7srO5A0wyR4+aZpwC0dd2Nf6iwDWjkRMDC5IIVmb1ffPLvmjoUQjRS61G8TQIwG6PV9+3ZdgCTI2r+hPSOop3SiglB2NT8y7W8/c4SXfVMaLAv7Iz+cdonctA3luR9CRqvqnDKAejaSxhAYsZiErKBEQ39EXbgyluHKbYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jF0lnOSr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uNutaoP2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jF0lnOSr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uNutaoP2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ckD9jZ9wYrSCWOVHpCRNTi95yOjxn7M5Pqew4yie68=;
	b=jF0lnOSrNP8OFOia5FkxBf7ydAX71j5ECq6Tm9wy9kxBSWVqwEm2QG2W0OkI8gNwnvY4mA
	Of1gdXcCj4Vr0MP51+n323OkbiB3bUW4N6MTRnOEdt1t2LeQaAYf2J4Qt+r1WNpUQW44C4
	tEgBoi5DIUn6aTkpfXrfacI9ZaQsxk8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-ydD1oPELMLqx0eIV6RYpww-1; Tue, 02 Jun 2026 10:25:39 -0400
X-MC-Unique: ydD1oPELMLqx0eIV6RYpww-1
X-Mimecast-MFC-AGG-ID: ydD1oPELMLqx0eIV6RYpww_1780410339
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9157c8eb597so152040485a.2
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410339; x=1781015139; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3ckD9jZ9wYrSCWOVHpCRNTi95yOjxn7M5Pqew4yie68=;
        b=uNutaoP23VTTkp2/iw4BhE/T52147IUV6/cv4enK1fCEEQjInB0UZoRCB7rHG2CWOm
         G3rfUdIIzyQTRgiLZOOsjWAgXb00lgZgDQtL/WR5JBNUmX4XLamFkKUCZrCEuZ51aQ0I
         uiL5zvzSuAU+JAtkHkNb5sRRWewDx89rGWzbtGad6fb/c1V1q1DV3cwddkDehVUfn3o+
         7HjPjAlW7X2XQs1t2W8EvWD0JKuOL895iC2mIXv9kAXSCXnjgMwnop8uEoCkYeehBrjx
         xLndp9I5sZorKg80wgdlkYjpIjRLJlKjyrbFlEo9JAP9fgG+9L/UZi3Y2tUK4X5LOexD
         Kzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410339; x=1781015139;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ckD9jZ9wYrSCWOVHpCRNTi95yOjxn7M5Pqew4yie68=;
        b=GP/0sqMYia3dMdwv3iDK8USy/4nlwlN83Q6LS6ZURCS8PGmmryEXg71DwK29doajsM
         Q0TApmd1tj1g7mqOkzZj2EqhtlihllKbX6vn9/waa+SLl9mTRdIdJ1hjRThz7EFQAzmr
         mN+5S9r+pE1tSOGrPOSwC1NSnpSvP8kMDjcEpIIU4GXWK+r1VOlCcfyJCSPWvvD6bmXo
         6ZWDP0BbbED3VbN7WtFRlCUXbFc29820U3HZsh6ICf2j4U0Xd8EDG1SISkC/Xo1FgkpJ
         0OQz/BjTzugehmr+47sOXZmI1hjaF0slQ1EFFEOS0CZ7jadRSfvIib5uGOs+E5UqL4z3
         Cryw==
X-Forwarded-Encrypted: i=1; AFNElJ8BrkM/vxAlT7CklOAOO/8+lOSyjIBhQ3BPwCMnnV4hJgbwhFkxc5o6NyFOq9l2omQpIBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMWKiYbQuM6k/yx5VjQ9gRV0kkb065QXYFGWm7sPPmbJHoZvPZ
	34DmoIdc5rTxwxjpFpzRVj7P/UKTO4OKZCcEJeR8b2F9ELAUd/c1+o1Qg9iVd7snZ4Xiey4+MTJ
	vldE22trQQL/qqikG+oJ1f1gzFtCxTOe0Q5WvmGMdHIwC3CEqJoI1Cw==
X-Gm-Gg: Acq92OFCFvIJSsEp/N9Mk0tRLGo4hZjS4b15xIGAHR2qwD79mfsAFHZf8Yal75KmJsq
	uyTvQ53anMLbtMvH0LaungZy1ZCbhcY6frxwCzI4djz25Ns1yCnfMXYW6SOt+bPFkeNnMly63uI
	rTZsToYg2hWXCieMkjKO944RAA8ykX6pepWp3sTKnM0GqgAguHX5Jql0wZs7hqvHtXhsZ40BR8H
	DR4oMTfMJeOG80TxUXFs6XReUMBhlgfJ8I9+7/jeHbxfrxNRmgKKUfbV5Rb+3QgUM7pXwsN81a7
	WuZEkGPC5+Il2Tf3aRalx++eAH1AsylsKKIZXtVqoYdPco/29Rmy6m8kHLpuOsR1bMrKLNXQYzk
	eJU3NzXJ2QJPnsDN/YCWKnsH79icMyQ5YHfPRv1c=
X-Received: by 2002:a05:620a:c4d:b0:912:1:b41c with SMTP id af79cd13be357-9153d7e0e94mr2503677185a.0.1780410339057;
        Tue, 02 Jun 2026 07:25:39 -0700 (PDT)
X-Received: by 2002:a05:620a:c4d:b0:912:1:b41c with SMTP id af79cd13be357-9153d7e0e94mr2503672285a.0.1780410338475;
        Tue, 02 Jun 2026 07:25:38 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915326503d2sm1299464285a.44.2026.06.02.07.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:25:38 -0700 (PDT)
Message-ID: <ab164c9064c95017cd0127ab3e3b40149c09b365.camel@redhat.com>
Subject: Re: [PATCH 14/28] KVM: x86/mmu: move cr4_smep to base role
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:25:37 -0400
In-Reply-To: <20260505195226.563317-15-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-15-pbonzini@redhat.com>
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
> Guest page tables can be reused independent of the value of CR4.SMEP
> (at least if WP=3D1).=C2=A0 However, this is not true of EPT MBEC pages,
> because presence of EPT entries is signaled by bits 0-2 when MBEC
> is off, and bits 0-2 + bit 10 when MBEC is on.
>=20
> In preparation for enabling MBEC, move cr4_smep to the base role.
> This makes the smep_andnot_wp bit redundant, so remove it.
>=20
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0Documentation/virt/kvm/x86/mmu.rst | 10 ++++------
> =C2=A0arch/x86/include/asm/kvm-x86-ops.h |=C2=A0 1 +
> =C2=A0arch/x86/include/asm/kvm_host.h=C2=A0=C2=A0=C2=A0 | 23 ++++++++++++=
+++--------
> =C2=A0arch/x86/kvm/mmu/mmu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++---
> =C2=A04 files changed, 23 insertions(+), 17 deletions(-)
>=20
> diff --git a/Documentation/virt/kvm/x86/mmu.rst b/Documentation/virt/kvm/=
x86/mmu.rst
> index 2b3b6d442302..666aa179601a 100644
> --- a/Documentation/virt/kvm/x86/mmu.rst
> +++ b/Documentation/virt/kvm/x86/mmu.rst
> @@ -184,10 +184,8 @@ Shadow pages contain the following information:
> =C2=A0=C2=A0=C2=A0=C2=A0 Contains the value of efer.nx for which the page=
 is valid.
> =C2=A0=C2=A0 role.cr0_wp:
> =C2=A0=C2=A0=C2=A0=C2=A0 Contains the value of cr0.wp for which the page =
is valid.
> -=C2=A0 role.smep_andnot_wp:
> -=C2=A0=C2=A0=C2=A0 Contains the value of cr4.smep && !cr0.wp for which t=
he page is valid
> -=C2=A0=C2=A0=C2=A0 (pages for which this is true are different from othe=
r pages; see the
> -=C2=A0=C2=A0=C2=A0 treatment of cr0.wp=3D0 below).
> +=C2=A0 role.cr4_smep:
> +=C2=A0=C2=A0=C2=A0 Contains the value of cr4.smep for which the page is =
valid.
> =C2=A0=C2=A0 role.smap_andnot_wp:
> =C2=A0=C2=A0=C2=A0=C2=A0 Contains the value of cr4.smap && !cr0.wp for wh=
ich the page is valid
> =C2=A0=C2=A0=C2=A0=C2=A0 (pages for which this is true are different from=
 other pages; see the
> @@ -435,8 +433,8 @@ from being written by the kernel after cr0.wp has cha=
nged to 1, we make
> =C2=A0the value of cr0.wp part of the page role.=C2=A0 This means that an=
 spte created
> =C2=A0with one value of cr0.wp cannot be used when cr0.wp has a different=
 value -
> =C2=A0it will simply be missed by the shadow page lookup code.=C2=A0 A si=
milar issue
> -exists when an spte created with cr0.wp=3D0 and cr4.smep=3D0 is used aft=
er
> -changing cr4.smep to 1.=C2=A0 To avoid this, the value of !cr0.wp && cr4=
.smep
> +exists when an spte created with cr0.wp=3D0 and cr4.smap=3D0 is used aft=
er
> +changing cr4.smap to 1.=C2=A0 To avoid this, the value of !cr0.wp && cr4=
.smap
> =C2=A0is also made a part of the page role.
> =C2=A0
> =C2=A0Large pages
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kv=
m-x86-ops.h
> index 3776cf5382a2..e4fca997ec79 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -94,6 +94,7 @@ KVM_X86_OP_OPTIONAL(sync_pir_to_irr)
> =C2=A0KVM_X86_OP_OPTIONAL_RET0(set_tss_addr)
> =C2=A0KVM_X86_OP_OPTIONAL_RET0(set_identity_map_addr)
> =C2=A0KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
> +KVM_X86_OP_OPTIONAL_RET0(tdp_has_smep)
> =C2=A0KVM_X86_OP(load_mmu_pgd)
> =C2=A0KVM_X86_OP_OPTIONAL(link_external_spt)
> =C2=A0KVM_X86_OP_OPTIONAL(set_external_spte)
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 62dc782b2dd3..23a7ac8d7fbe 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -343,8 +343,8 @@ struct kvm_kernel_irq_routing_entry;
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 paging has exactly one upper level, maki=
ng level completely redundant
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 when has_4_byte_gpte=3D1.
> =C2=A0 *
> - *=C2=A0=C2=A0 - on top of this, smep_andnot_wp and smap_andnot_wp are o=
nly set if
> - *=C2=A0=C2=A0=C2=A0=C2=A0 cr0_wp=3D0, therefore these three bits only g=
ive rise to 5 possibilities.
> + *=C2=A0=C2=A0 - on top of this, smap_andnot_wp is only set if cr0_wp=3D=
0,
> + *=C2=A0=C2=A0=C2=A0=C2=A0 therefore these two bits only give rise to 3 =
possibilities.
> =C2=A0 *
> =C2=A0 * Therefore, the maximum number of possible upper-level shadow pag=
es for a
> =C2=A0 * single gfn is a bit less than 2^14.
> @@ -360,12 +360,19 @@ union kvm_mmu_page_role {
> =C2=A0 unsigned invalid:1;
> =C2=A0 unsigned efer_nx:1;
> =C2=A0 unsigned cr0_wp:1;
> - unsigned smep_andnot_wp:1;
> =C2=A0 unsigned smap_andnot_wp:1;
> =C2=A0 unsigned ad_disabled:1;
> =C2=A0 unsigned guest_mode:1;
> =C2=A0 unsigned passthrough:1;
> =C2=A0 unsigned is_mirror:1;
> +
> + /*
> + * cr4_smep is also set for EPT MBEC.=C2=A0 Because it affects
> + * which pages are considered non-present (bit 10 additionally
> + * must be zero if MBEC is on) it has to be in the base role.
> + */
> + unsigned cr4_smep:1;
Hi!

Sorry to complain, but in my opinion this can be misleading to someone who =
doesn't know this code,=C2=A0
because in EPT there is no SMEP and in the same time there is CR4.SMEP=C2=
=A0
which is not EPT related.

GMET is on the other hand similar to SMEP, but also not 100% the same, beca=
use for example it
is not driven by CR4.SMEP.

What do you think about giving this a vendor neutral name like 'has_user_ex=
ec_permission'=C2=A0
or separate_user_exec or something like that?
(With a comment explaining that this maps to MBE and GMET)

Any neutral name is IMHO OK, I am not sure that this particular name I have=
 chosen is the best.
As a bonus, we can still refer to the real cr4_smep, which is needed later =
for GMET.


> +
> =C2=A0 unsigned:3;
> =C2=A0
> =C2=A0 /*
> @@ -392,10 +399,10 @@ union kvm_mmu_page_role {
> =C2=A0 * tables (because KVM doesn't support Protection Keys with shadow =
paging), and
> =C2=A0 * CR0.PG, CR4.PAE, and CR4.PSE are indirectly reflected in role.le=
vel.
> =C2=A0 *
> - * Note, SMEP and SMAP are not redundant with sm*p_andnot_wp in the page=
 role.
> - * If CR0.WP=3D1, KVM can reuse shadow pages for the guest regardless of=
 SMEP and
> - * SMAP, but the MMU's permission checks for software walks need to be S=
MEP and
> - * SMAP aware regardless of CR0.WP.
> + * Note, SMAP is not redundant with smap_andnot_wp in the page role.=C2=
=A0 If
> + * CR0.WP=3D1, KVM can reuse shadow pages for the guest regardless of SM=
AP,
> + * but the MMU's permission checks for software walks need to be SMAP
> + * aware regardless of CR0.WP.
> =C2=A0 */
> =C2=A0union kvm_mmu_extended_role {
> =C2=A0 u32 word;
> @@ -405,7 +412,6 @@ union kvm_mmu_extended_role {
> =C2=A0 unsigned int cr4_pse:1;
> =C2=A0 unsigned int cr4_pke:1;
> =C2=A0 unsigned int cr4_smap:1;
> - unsigned int cr4_smep:1;
> =C2=A0 unsigned int cr4_la57:1;
> =C2=A0 unsigned int efer_lma:1;
> =C2=A0 };
> @@ -1887,6 +1893,7 @@ struct kvm_x86_ops {
> =C2=A0 int (*set_tss_addr)(struct kvm *kvm, unsigned int addr);
> =C2=A0 int (*set_identity_map_addr)(struct kvm *kvm, u64 ident_addr);
> =C2=A0 u8 (*get_mt_mask)(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio);
> + bool (*tdp_has_smep)(struct kvm *kvm);
> =C2=A0
> =C2=A0 void (*load_mmu_pgd)(struct kvm_vcpu *vcpu, hpa_t root_hpa,
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 int root_level);
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 16eaf413b299..156050e22329 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -227,7 +227,7 @@ static inline bool __maybe_unused is_##reg##_##name(s=
truct kvm_mmu *mmu) \
> =C2=A0}
> =C2=A0BUILD_MMU_ROLE_ACCESSOR(base, cr0, wp);
> =C2=A0BUILD_MMU_ROLE_ACCESSOR(ext,=C2=A0 cr4, pse);
> -BUILD_MMU_ROLE_ACCESSOR(ext,=C2=A0 cr4, smep);
> +BUILD_MMU_ROLE_ACCESSOR(base, cr4, smep);
> =C2=A0BUILD_MMU_ROLE_ACCESSOR(ext,=C2=A0 cr4, smap);
> =C2=A0BUILD_MMU_ROLE_ACCESSOR(ext,=C2=A0 cr4, pke);
> =C2=A0BUILD_MMU_ROLE_ACCESSOR(ext,=C2=A0 cr4, la57);
> @@ -5764,7 +5764,7 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct =
kvm_vcpu *vcpu,
> =C2=A0
> =C2=A0 role.base.efer_nx =3D ____is_efer_nx(regs);
> =C2=A0 role.base.cr0_wp =3D ____is_cr0_wp(regs);
> - role.base.smep_andnot_wp =3D ____is_cr4_smep(regs) && !____is_cr0_wp(re=
gs);
> + role.base.cr4_smep =3D ____is_cr4_smep(regs);
> =C2=A0 role.base.smap_andnot_wp =3D ____is_cr4_smap(regs) && !____is_cr0_=
wp(regs);
> =C2=A0 role.base.has_4_byte_gpte =3D !____is_cr4_pae(regs);
> =C2=A0
> @@ -5776,7 +5776,6 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct =
kvm_vcpu *vcpu,
> =C2=A0 else
> =C2=A0 role.base.level =3D PT32_ROOT_LEVEL;
> =C2=A0
> - role.ext.cr4_smep =3D ____is_cr4_smep(regs);
> =C2=A0 role.ext.cr4_smap =3D ____is_cr4_smap(regs);
> =C2=A0 role.ext.cr4_pse =3D ____is_cr4_pse(regs);
> =C2=A0
> @@ -5835,6 +5834,7 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vc=
pu,
> =C2=A0
> =C2=A0 role.access =3D ACC_ALL;
> =C2=A0 role.cr0_wp =3D true;
> + role.cr4_smep =3D kvm_x86_call(tdp_has_smep)(vcpu->kvm);

Similarly, if you agree with my suggestion of giving it a vendor neutral na=
me,

maybe we should find another name for 'tdp_has_smep'?
Something like tdp_has_user_exec_permission()

> =C2=A0 role.efer_nx =3D true;
> =C2=A0 role.smm =3D cpu_role.base.smm;
> =C2=A0 role.guest_mode =3D cpu_role.base.guest_mode;


The code itself looks correct to me, so:

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky

