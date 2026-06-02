Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4B733A711
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410683; cv=none; b=cjfejT4JuOf5RthsHNmNaqBEzao+ttfeL9cwVRSEHoNjl6mTfz7boK73O0K/Ea1rLJPN+mtDaIhX4xs9XjKYxLlue7jhtMQYCHj660+b0qwN2t2KhERK4QWwu31jh7NPqXS4EWh7IG3dWHRsIcGAMf+P+FauNqDx7ob3zvSDt8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410683; c=relaxed/simple;
	bh=SJ+rzUZwcW8xQId0WZoEfhBwqXV0mHrLGeGuGQwdFxg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rohk76VvQnrRCsD3lCKQcSJ3QYwXZSZQO0IA/JDMfERSBNXBAIZ2qPWdujMIXTX35OMSML9pMwKh+6xb/BladGL0cZ8nIIHQUKJd8DeLaAzeqgCdaZoczXAWDd89Wnb3fN9CboZUxFVOKS8y3scNzxWKnIWXkK0tbH45lmOd1yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hPImb1p9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPq/tpd9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPImb1p9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPq/tpd9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHsfQEV/Ti8WhGNgklx6MIcx2hzOrYanELTQwtlmlVk=;
	b=hPImb1p9Jfo4cuKK5lXXRbrF01rgU/PpqinGrIaDNuWfQKmr5JCx6GZVR3skhIlJkZXhoF
	yfU5fpM6hB+71HfKaX1SqwmpzO+3CcFiNdw5vxhbGCjGNSLvZplCz4bOU4RE+0ZoWPGgbk
	IgAtRBpbpGzfvQQSgtNkD7vtHHDw0ro=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-F2hyH2DPPae09bkCH35NTg-1; Tue, 02 Jun 2026 10:31:19 -0400
X-MC-Unique: F2hyH2DPPae09bkCH35NTg-1
X-Mimecast-MFC-AGG-ID: F2hyH2DPPae09bkCH35NTg_1780410679
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51736a08ce6so64430951cf.1
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410679; x=1781015479; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iHsfQEV/Ti8WhGNgklx6MIcx2hzOrYanELTQwtlmlVk=;
        b=EPq/tpd9xKU4xOJggevTmoWsOywQWuLX87ojGYdjjGqgo9MkmbpUu4uMF+uYi5KmHy
         f+AuMM00oyQ3aUJiVxPy5zn5T6HJ0sm2pX29gxMYVb0EZ3wXn/OwSd/uZaWqxMiQQzw9
         GCRDO15WoyHFQ7LfncFHw9OS6ktzIyKlJbymtdLwIDRMW5t7v+UAghSjEyIOwTluaNqg
         MMeW0mib8IiI58Uk5jEc1Ic2QXJUAt9vpUfoMei2MLmG0x7pzhLdrNsPh27fEEjibofP
         wGxFI1JD2RYgkeVMftZBpcppHnMJJZRA86x7U66bsS+5akf82mGsRpTeX0EKJUCvNglv
         EYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410679; x=1781015479;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHsfQEV/Ti8WhGNgklx6MIcx2hzOrYanELTQwtlmlVk=;
        b=gqMipES9ssYHj0CvRM04IqUm7DXnMqYwmlSYWztEzKtqpPI8MtGrUBUPotWuveWVwJ
         KRpJYCFKWc79S27mNK9bSUnpD4vJfZx6hhIfTFqRzeKAlpOkbEfVathPMJ5LeGuR5Dez
         UTf7cUEwf6q5zQM1nXYhNjiqAok6UyHbDh5OFa9ykXAxM5bbKlki5qDNoPgR9q4E+qli
         X+JXf9eYW87rswIddRVqBBu9n+JFi8nsNICR6DKXUP70+kE4ZpsXsSlORBB0x5lpsNst
         YKMceu6G+SLn52pOmSCt2vcwYkh2PtkYDs6GnjetkIVp189dx/Mt+Q9YRkUMqnfXdimE
         bQ2w==
X-Forwarded-Encrypted: i=1; AFNElJ+GyoDodu/Qwt6rM7W0ZyBPbrQLVK3x4P+SnOuqLBCRQbuemVp0KVC7Ty8/HB1Ntf+98Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDfJOeyXwpVyC08DktyQjnAFekw236idOqMcANryL/qhvSJlSl
	bCvMFKkj9iroRStfK/fC6aOHd4EWl6qV0lz+E6O/buXu+95ZceCSIdiJ141SwHbGhC4ALIg7NTJ
	LwWgH3oFMfhTqrQBfveN2x68sJTijfa/8u53rNTR3M+RKvHD2nhkMGg==
X-Gm-Gg: Acq92OGOSq1R6knRFOIMDVF4UL76h+WCMwSZwmQD4z9eOXgtbtQICE/2qSR6CoYWAUj
	tXuepy6b/OctvZZUwx9QlN0zZkJP5fUqvrxTebpE+Za/Xi1zMZaUZuzAqF1E0dUKuE2e9BAjMhF
	1PJX0P/mh560a+czwPmAE8rCOgKUnavh2GIIjzKAIzBTUJUvyS1CWlvraVQmqKaOkR/clXlx+IM
	GtEcbkXNVAJQSXge+w1PJFd77lRvjNrN4G8g2/FPmJaST1vJ30Pjmy3PLYo2RY0xce01raeuRi4
	KVopB7PTxriYqkEjI/J6mhnraqcZjLeondFw5/9uCpmEfZv80z7lSovuZlBQZ12q7dqJu7yb8Xs
	pMuTNgKyxbxZlJ73Jt7aVaKm9AAhsYN0OmckoQYk=
X-Received: by 2002:a05:622a:b:b0:517:5f04:f23f with SMTP id d75a77b69052e-5176620297fmr54887061cf.4.1780410678007;
        Tue, 02 Jun 2026 07:31:18 -0700 (PDT)
X-Received: by 2002:a05:622a:b:b0:517:5f04:f23f with SMTP id d75a77b69052e-5176620297fmr54885151cf.4.1780410675227;
        Tue, 02 Jun 2026 07:31:15 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5175ecbd701sm37066371cf.29.2026.06.02.07.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:31:14 -0700 (PDT)
Message-ID: <645c5adca68427d0f0964cefe016a01be9a521f7.camel@redhat.com>
Subject: Re: [PATCH 25/28] KVM: x86/mmu: add support for GMET to NPT page
 table walks
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:31:13 -0400
In-Reply-To: <20260505195226.563317-26-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-26-pbonzini@redhat.com>
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
> GMET allows page table entries to be created with U=3D0 in NPT.
> However, when GMET=3D1 U=3D0 only affects execution, not reads or
> writes.=C2=A0 Ignore user faults on non-fetch accesses for NPT GMET.
>=20
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/include/asm/kvm_host.h |=C2=A0 2 ++
> =C2=A0arch/x86/kvm/mmu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0arch/x86/kvm/mmu/mmu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 18 ++++++++++++------
> =C2=A0arch/x86/kvm/svm/nested.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 =
+++++++---
> =C2=A04 files changed, 22 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 7dde4ca87752..1da3d5c59e15 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -370,6 +370,8 @@ union kvm_mmu_page_role {
> =C2=A0 * cr4_smep is also set for EPT MBEC.=C2=A0 Because it affects
> =C2=A0 * which pages are considered non-present (bit 10 additionally
> =C2=A0 * must be zero if MBEC is on) it has to be in the base role.
> + * It also has to be in the base role for AMD GMET because
> + * kernel-executable pages need to have U=3D0 with GMET enabled.
> =C2=A0 */
> =C2=A0 unsigned cr4_smep:1;
> =C2=A0
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 1b354e1f2d81..ddf4e467c071 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -97,7 +97,7 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits);
> =C2=A0
> =C2=A0void kvm_init_mmu(struct kvm_vcpu *vcpu);
> =C2=A0void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long c=
r4,
> - =C2=A0=C2=A0=C2=A0=C2=A0 u64 efer, gpa_t nested_cr3);
> + =C2=A0=C2=A0=C2=A0=C2=A0 u64 efer, gpa_t nested_cr3, u64 misc_ctl);
> =C2=A0void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 int huge_page_level, bool accessed_dirty,
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 bool mbec, gpa_t new_eptp);
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 5a796ae8c396..a283b5078c61 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -55,6 +55,7 @@
> =C2=A0#include <asm/io.h>
> =C2=A0#include <asm/set_memory.h>
> =C2=A0#include <asm/spec-ctrl.h>
> +#include <asm/svm.h>
> =C2=A0#include <asm/vmx.h>
> =C2=A0
> =C2=A0#include "trace.h"
> @@ -5572,7 +5573,7 @@ reset_ept_shadow_zero_bits_mask(struct kvm_mmu *con=
text, bool execonly)
> =C2=A0 (14 & (access) ? 1 << 14 : 0) | \
> =C2=A0 (15 & (access) ? 1 << 15 : 0))
> =C2=A0
> -static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
> +static void update_permission_bitmask(struct kvm_mmu *mmu, bool tdp, boo=
l ept)

Hi!

I vote to call this 'npt' instead, because 'tdp' confuses me a lot,
it is used in kvm for so many things like the tdp_mmu and such.
What do you think?=20

> =C2=A0{
> =C2=A0 unsigned index;
> =C2=A0
> @@ -5633,7 +5634,12 @@ static void update_permission_bitmask(struct kvm_m=
mu *mmu, bool ept)
> =C2=A0 /* Faults from kernel mode accesses to user pages */
> =C2=A0 u16 kf =3D (pfec & PFERR_USER_MASK) ? 0 : u;
> =C2=A0
> - uf =3D (pfec & PFERR_USER_MASK) ? (u16)~u : 0;
> + /*

> + * For NPT GMET, U=3D0 does not affect reads and writes.=C2=A0 Fetches
> + * are handled below via cr4_smep.


While at it we might also want to add a comment saying that for regular NPT=
, U bit is checked,
but all NPT accesses are treated as user so it has to be effectively always=
 1.
(Assuming that APM is correct)
What do you think?

> + */
> + if (!(tdp && cr4_smep))
> + uf =3D (pfec & PFERR_USER_MASK) ? (u16)~u : 0;
> =C2=A0
> =C2=A0 if (efer_nx)
> =C2=A0 ff =3D (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
> @@ -5744,7 +5750,7 @@ static void reset_guest_paging_metadata(struct kvm_=
vcpu *vcpu,
> =C2=A0 return;
> =C2=A0
> =C2=A0 reset_guest_rsvds_bits_mask(vcpu, mmu);
> - update_permission_bitmask(mmu, false);
> + update_permission_bitmask(mmu, mmu =3D=3D &vcpu->arch.guest_mmu, false)=
;
> =C2=A0 update_pkru_bitmask(mmu);
> =C2=A0}
> =C2=A0
> @@ -5940,7 +5946,7 @@ static void kvm_init_shadow_mmu(struct kvm_vcpu *vc=
pu,
> =C2=A0}
> =C2=A0
> =C2=A0void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long c=
r4,
> - =C2=A0=C2=A0=C2=A0=C2=A0 u64 efer, gpa_t nested_cr3)
> + =C2=A0=C2=A0=C2=A0=C2=A0 u64 efer, gpa_t nested_cr3, u64 misc_ctl)
> =C2=A0{
> =C2=A0 struct kvm_mmu *context =3D &vcpu->arch.guest_mmu;
> =C2=A0 struct kvm_mmu_role_regs regs =3D {
> @@ -5953,7 +5959,7 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu,=
 unsigned long cr4,
> =C2=A0
> =C2=A0 /* NPT requires CR0.PG=3D1. */
> =C2=A0 WARN_ON_ONCE(cpu_role.base.direct || !cpu_role.base.guest_mode);
> - cpu_role.base.cr4_smep =3D false;
> + cpu_role.base.cr4_smep =3D (misc_ctl & SVM_MISC_ENABLE_GMET) !=3D 0;
> =C2=A0
> =C2=A0 root_role =3D cpu_role.base;
> =C2=A0 root_role.level =3D kvm_mmu_get_tdp_level(vcpu);
> @@ -6011,7 +6017,7 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu,=
 bool execonly,
> =C2=A0 context->gva_to_gpa =3D ept_gva_to_gpa;
> =C2=A0 context->sync_spte =3D ept_sync_spte;
> =C2=A0
> - update_permission_bitmask(context, true);
> + update_permission_bitmask(context, true, true);
> =C2=A0 context->pkru_mask =3D 0;
> =C2=A0 reset_rsvds_bits_mask_ept(vcpu, context, execonly, huge_page_level=
);
> =C2=A0 reset_ept_shadow_zero_bits_mask(context, execonly);
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index a1cffd274000..7adfa7da210d 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -95,7 +95,8 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu=
 *vcpu)
> =C2=A0 */
> =C2=A0 kvm_init_shadow_npt_mmu(vcpu, svm->vmcb01.ptr->save.cr4,
> =C2=A0 svm->vmcb01.ptr->save.efer,
> - svm->nested.ctl.nested_cr3);
> + svm->nested.ctl.nested_cr3,
> + svm->nested.ctl.misc_ctl);
> =C2=A0 vcpu->arch.mmu->get_guest_pgd=C2=A0=C2=A0=C2=A0=C2=A0 =3D nested_s=
vm_get_tdp_cr3;
> =C2=A0 vcpu->arch.mmu->get_pdptr=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D nested_svm_get_tdp_pdptr;
> =C2=A0 vcpu->arch.mmu->inject_page_fault =3D nested_svm_inject_npf_exit;
> @@ -2076,12 +2077,15 @@ static gpa_t svm_translate_nested_gpa(struct kvm_=
vcpu *vcpu, gpa_t gpa,
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct x86_exception *exception,
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 pte_access)
> =C2=A0{
> + struct vcpu_svm *svm =3D to_svm(vcpu);
> =C2=A0 struct kvm_mmu *mmu =3D vcpu->arch.mmu;
> =C2=A0
> =C2=A0 BUG_ON(!mmu_is_nested(vcpu));
> =C2=A0
> - /* NPT walks are always user-walks */
> - access |=3D PFERR_USER_MASK;
> + /* Non-GMET walks are always user-walks */
> + if (!(svm->nested.ctl.misc_ctl & SVM_MISC_ENABLE_GMET))
> + access |=3D PFERR_USER_MASK;

Tiny nitpick: maybe add a 'nested_gmet_enabled' similar to nested_npt_enabl=
ed?

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>


Best regards,
	Maxim Levitsky

> +
> =C2=A0 return mmu->gva_to_gpa(vcpu, mmu, gpa, access, exception);
> =C2=A0}
> =C2=A0

