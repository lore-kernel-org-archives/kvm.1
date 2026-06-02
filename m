Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94603EF64A
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410489; cv=none; b=nWpksX4EUf5OqCo+IP4Q/dp3sU1FKWGoWdRsimAMkwxssOCrPctfaSVZ1DvtJevZtZ/l7tBRRfFI81bcPf0m8gzUyLQoHBvQTh+dzVb8fk0YtKj3wrGAPHu6opl5j28WgyWZZEv5kGDEYg2vLVCZQSM6j6iiNGWUtesL+mfVdUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410489; c=relaxed/simple;
	bh=O9z2CTlEScbrop7hkyX0gspFAPLnDYUZoGb169xMmDg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bYKdi5z1WBL0NP9WFhLfV4yxRFKW8W0cIMHEtVZ1H4wj6RntkMUw1d/fKhdSXRalO5wolVgFFcrhsnf0MCa6qMHaQnj/I+D1PSjFia5cnNu7JMi0o+81DcgntYPO+rW2SiICL5dccNVYzl+CjCY9iIbsVJIyrOZU7a4Fgfyt8Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SruExQhB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ThZO+bGC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SruExQhB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThZO+bGC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7WHiZ5y+ullQSiOz1G9ZwMItQUjI0d4F5eqECGEu0Dk=;
	b=SruExQhBC/HqINdKtErEubA3BULpneWUtKryh8SnySohbyjnAELEFQux/2t/BlFsjMekvw
	UMEtujFZlU3F21Pkt40D2vlfg/mWdHkpeXz++kHT0VzaShzwKT6yuudb9A7rsDClIRRFLq
	gHnlRKjzuPNZjNbtccgZnlWHpVibMoI=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-l0R7rft-OzWT4jaXvjoRMw-1; Tue, 02 Jun 2026 10:28:05 -0400
X-MC-Unique: l0R7rft-OzWT4jaXvjoRMw-1
X-Mimecast-MFC-AGG-ID: l0R7rft-OzWT4jaXvjoRMw_1780410485
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-96396658728so1179006241.1
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410484; x=1781015284; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7WHiZ5y+ullQSiOz1G9ZwMItQUjI0d4F5eqECGEu0Dk=;
        b=ThZO+bGCmgR2nyPeGyDAnYdy6XWjduZP6jrfJkJ/Oxc3y9qDID29aFIiYBKyQSZKB9
         KpgGaIAujlL1vKajPYtTWA4Zcawcm/22Ojvd0gCnrCb++UeHdL2J+Xq/txvZCI222oQm
         b0txWWuD0hTSdcwVGJtmxYvorzSlJOs121kzAGVLc3XkFV4spChKOK8davAg47ev490B
         2Cg6lSIzSecqXHY8PZQucTNMlYvoaD3U0xTXQGuWolT/zwf3lHegGf1zlHN+2fNOaE0i
         +WdnAIbuXF3GMLLoMJFdiPykLHxNzmVy2BVTcIW+yW7nwDnfVToPJ4cEe1xbSJJmvBuJ
         xC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410484; x=1781015284;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WHiZ5y+ullQSiOz1G9ZwMItQUjI0d4F5eqECGEu0Dk=;
        b=GK4RdBo8w+aFPFy7tiWcYo0+lxXynsqOeh0u+NFDtm98Y4xwYqAm2+C1T+Af2LHmEK
         VTXWBxMMTuiVAHdUO0cUaUGIbrcz8bm4qC0pW+shqclz0YGdJaOzSz5zofQg6RDVXg5D
         QYn4/M6V1Xo08WkQ70Ll3bgkmNZ42J+vFF3m0gKXXQ/apAadvQNvdqbfKZs2J1qD5rdr
         aaNT6P8Wd85me2V5wkXy9CwjJ2aTiQLh2bHlJd9t6zXLGDpmAQeI+/Uq221lLQEsx4yM
         PvktE1k8Kf2QeZDAvz12Zqmse3ftDzOtY/9qaWpUbK3ezxLDP3uzbHcvNZWaDj9tgIPV
         Gqzw==
X-Forwarded-Encrypted: i=1; AFNElJ9aas8XX1IOChSfPIvXKxQ4EbEE7maIk6aeEXdzrfUJ/XLOK71De6cZAjV51UvGRtAK51U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgqvR7XEyLHzNS04HDVGFYmiJH/diD2J1UQ0+UUV9p2X+kxJJQ
	uAHAIDR2vHYZVOVNbpxcXXzrk9QiILPOe04l+DePqEyPRlYK4aTx0ZdY2EhjuqrhKNoecCLlNaQ
	WKBrvvYbGhTD/Lily9jqv9ciFSxvKBn6scRcraE5J/ytpyI+ZpNX1VQ==
X-Gm-Gg: Acq92OG3AiDv91VFsI4F5qZXCezxTfU+YYr9uR9Y2r/7thjXF4q0dKlYrpT40r1aLpb
	51FPvS24G+qEplswyl+2fRpJttgsoc8DklNr8Fe1RDMO3TotVRzFxNsatKn0QTdFzQbfv2qLEKA
	m0HKR7EHqDnsb0KwGSaVwYsby4PpuM3pu2w31bF6jrTwrDzSXHl32X9Ssb1mOBKVFdgWN9gY+G9
	zKOi1XzPohhIPrR1yruqOCJQNrihl4BnP5bVeGTm9hwyeNbfxdmY1mJuJQJ5O+3hqHRUpvyISSj
	NTVWmz1OdmKx8DxB8+8j45+TMIaj0XxvrWP9SoqGa6od6Uhcb/IFrhszVxDcm4sUZx4mmQlANqK
	2mvVHyvWwRw7+Rp6Z3JfTQrOAxLhR7Myb2O+vH6A=
X-Received: by 2002:a05:6102:801f:b0:6dd:405b:26d0 with SMTP id ada2fe7eead31-6dd405b2c17mr4170832137.23.1780410484570;
        Tue, 02 Jun 2026 07:28:04 -0700 (PDT)
X-Received: by 2002:a05:6102:801f:b0:6dd:405b:26d0 with SMTP id ada2fe7eead31-6dd405b2c17mr4170798137.23.1780410484056;
        Tue, 02 Jun 2026 07:28:04 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042373sm121720406d6.9.2026.06.02.07.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:28:03 -0700 (PDT)
Message-ID: <e2da2fbf6e89b8bedbe23b0fe329ed9be15c5032.camel@redhat.com>
Subject: Re: [PATCH 18/28] KVM: x86/mmu: add support for MBEC to EPT page
 table walks
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:28:02 -0400
In-Reply-To: <20260505195226.563317-19-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-19-pbonzini@redhat.com>
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
> Extend the page walker to support moving bit 10 of the PTEs
> into ACC_USER_EXEC_MASK and bit 6 of the exit qualification of
> EPT violation VM exits.
>=20
> Note that while mmu_has_mbec()/cr4_smep affect the interpretation of
> ACC_USER_EXEC_MASK and add bit 10 as a "present bit" in guest EPT page
> table entries, they do not affect how KVM operates on SPTEs.=C2=A0 That's
> because the MMU uses explicit ACC_USER_EXEC_MASK/shadow_xu_mask even for
> the non-nested EPT; the only difference is that ACC_USER_EXEC_MASK and
> ACC_EXEC_MASK will always be set in tandem outside the nested scenario.
>=20
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/kvm/mmu/mmu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 13 +++++++++++--
> =C2=A0arch/x86/kvm/mmu/paging_tmpl.h | 27 +++++++++++++++++++++------
> =C2=A0arch/x86/kvm/mmu/spte.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 ++
> =C2=A0arch/x86/kvm/vmx/nested.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 +=
++++++++
> =C2=A04 files changed, 43 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 156050e22329..a5b68f18b220 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5570,7 +5570,6 @@ static void update_permission_bitmask(struct kvm_mm=
u *mmu, bool ept)
> =C2=A0{
> =C2=A0 unsigned index;
> =C2=A0
> - const u16 x =3D ACC_BITS_MASK(ACC_EXEC_MASK);
> =C2=A0 const u16 w =3D ACC_BITS_MASK(ACC_WRITE_MASK);
> =C2=A0 const u16 r =3D ACC_BITS_MASK(ACC_READ_MASK);
> =C2=A0
> @@ -5611,8 +5610,18 @@ static void update_permission_bitmask(struct kvm_m=
mu *mmu, bool ept)
> =C2=A0 u16 smapf =3D 0;
> =C2=A0
> =C2=A0 if (ept) {
> - ff =3D (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
> + const u16 xs =3D ACC_BITS_MASK(ACC_EXEC_MASK);
> + const u16 xu =3D ACC_BITS_MASK(ACC_USER_EXEC_MASK);
> +
> + if (pfec & PFERR_FETCH_MASK) {
> + /* Ignore XU unless MBEC is enabled.=C2=A0 */
> + if (cr4_smep)

Hi!

If we go with my suggestion to call GMET/MBE with vendor neutral name, we w=
on't need to use  cr4_smep here
which is confusing.
What do you think?


> + ff =3D pfec & PFERR_USER_MASK ? (u16)~xu : (u16)~xs;
> + else
> + ff =3D (u16)~xs;
> + }
> =C2=A0 } else {
> + const u16 x =3D ACC_BITS_MASK(ACC_EXEC_MASK);
> =C2=A0 const u16 u =3D ACC_BITS_MASK(ACC_USER_MASK);
> =C2=A0
> =C2=A0 /* Faults from kernel mode accesses to user pages */
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmp=
l.h
> index d4ce55195a7c..f741f7d4cc2d 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -124,12 +124,17 @@ static inline void FNAME(protect_clean_gpte)(struct=
 kvm_mmu *mmu, unsigned *acce
> =C2=A0 *access &=3D mask;
> =C2=A0}
> =C2=A0
> -static inline int FNAME(is_present_gpte)(unsigned long pte)
> +static inline int FNAME(is_present_gpte)(struct kvm_mmu *mmu,
> + unsigned long pte)
> =C2=A0{
> =C2=A0#if PTTYPE !=3D PTTYPE_EPT
> =C2=A0 return pte & PT_PRESENT_MASK;
> =C2=A0#else
> - return pte & 7;
> + /*
> + * For EPT, an entry is present if any of bits 2:0 are set.
> + * With mode-based execute control, bit 10 also indicates presence.
> + */
> + return pte & (7 | (mmu_has_mbec(mmu) ? VMX_EPT_USER_EXECUTABLE_MASK : 0=
));
> =C2=A0#endif
> =C2=A0}
> =C2=A0
> @@ -152,7 +157,7 @@ static bool FNAME(prefetch_invalid_gpte)(struct kvm_v=
cpu *vcpu,
> =C2=A0 =C2=A0 struct kvm_mmu_page *sp, u64 *spte,
> =C2=A0 =C2=A0 u64 gpte)
> =C2=A0{
> - if (!FNAME(is_present_gpte)(gpte))
> + if (!FNAME(is_present_gpte)(vcpu->arch.mmu, gpte))
> =C2=A0 goto no_present;
> =C2=A0
> =C2=A0 /* Prefetch only accessed entries (unless A/D bits are disabled). =
*/
> @@ -173,10 +178,17 @@ static bool FNAME(prefetch_invalid_gpte)(struct kvm=
_vcpu *vcpu,
> =C2=A0static inline unsigned FNAME(gpte_access)(u64 gpte)
> =C2=A0{
> =C2=A0 unsigned access;
> + /*
> + * Set bits in ACC_*_MASK even if they might not be used in the
> + * actual checks.=C2=A0 For example, if EFER.NX is clear permission_faul=
t()
> + * will ignore ACC_EXEC_MASK, and if MBEC is disabled it will
> + * ignore ACC_USER_EXEC_MASK.
> + */
> =C2=A0#if PTTYPE =3D=3D PTTYPE_EPT
> =C2=A0 access =3D ((gpte & VMX_EPT_WRITABLE_MASK) ? ACC_WRITE_MASK : 0) |
> =C2=A0 ((gpte & VMX_EPT_EXECUTABLE_MASK) ? ACC_EXEC_MASK : 0) |
> - ((gpte & VMX_EPT_READABLE_MASK) ? ACC_READ_MASK : 0);
> + ((gpte & VMX_EPT_READABLE_MASK) ? ACC_READ_MASK : 0) |
> + ((gpte & VMX_EPT_USER_EXECUTABLE_MASK) ? ACC_USER_EXEC_MASK : 0);
> =C2=A0#else
> =C2=A0 /*
> =C2=A0 * P is set here, so the page is always readable and W/U/!NX repres=
ent
> @@ -331,7 +343,7 @@ static int FNAME(walk_addr_generic)(struct guest_walk=
er *walker,
> =C2=A0 if (walker->level =3D=3D PT32E_ROOT_LEVEL) {
> =C2=A0 pte =3D mmu->get_pdptr(vcpu, (addr >> 30) & 3);
> =C2=A0 trace_kvm_mmu_paging_element(pte, walker->level);
> - if (!FNAME(is_present_gpte)(pte))
> + if (!FNAME(is_present_gpte)(mmu, pte))
> =C2=A0 goto error;
> =C2=A0 --walker->level;
> =C2=A0 }
> @@ -414,7 +426,7 @@ static int FNAME(walk_addr_generic)(struct guest_walk=
er *walker,
> =C2=A0 */
> =C2=A0 pte_access =3D pt_access & (pte ^ walk_nx_mask);
> =C2=A0
> - if (unlikely(!FNAME(is_present_gpte)(pte)))
> + if (unlikely(!FNAME(is_present_gpte)(mmu, pte)))
> =C2=A0 goto error;
> =C2=A0
> =C2=A0 if (unlikely(FNAME(is_rsvd_bits_set)(mmu, pte, walker->level))) {
> @@ -521,6 +533,9 @@ static int FNAME(walk_addr_generic)(struct guest_walk=
er *walker,
> =C2=A0 * ACC_*_MASK flags!
> =C2=A0 */
> =C2=A0 walker->fault.exit_qualification |=3D EPT_VIOLATION_RWX_TO_PROT(pt=
e_access);
> + if (mmu_has_mbec(mmu))
> + walker->fault.exit_qualification |=3D
> + EPT_VIOLATION_USER_EXEC_TO_PROT(pte_access);
> =C2=A0 }
> =C2=A0#endif
> =C2=A0 walker->fault.address =3D addr;
> diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
> index f5261d993eac..fe9571837fee 100644
> --- a/arch/x86/kvm/mmu/spte.h
> +++ b/arch/x86/kvm/mmu/spte.h
> @@ -395,6 +395,8 @@ static inline bool __is_rsvd_bits_set(struct rsvd_bit=
s_validate *rsvd_check,
> =C2=A0static inline bool __is_bad_mt_xwr(struct rsvd_bits_validate *rsvd_=
check,
> =C2=A0 =C2=A0=C2=A0 u64 pte)
> =C2=A0{
> + if (pte & VMX_EPT_USER_EXECUTABLE_MASK)
> + pte |=3D VMX_EPT_EXECUTABLE_MASK;
> =C2=A0 return rsvd_check->bad_mt_xwr & BIT_ULL(pte & 0x3f);
> =C2=A0}
> =C2=A0
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 46b65475765d..84f5c25a1f12 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -7452,6 +7452,15 @@ static gpa_t vmx_translate_nested_gpa(struct kvm_v=
cpu *vcpu, gpa_t gpa,
> =C2=A0 struct kvm_mmu *mmu =3D vcpu->arch.mmu;
> =C2=A0
> =C2=A0 BUG_ON(!mmu_is_nested(vcpu));
> +
> + /*
> + * MBEC differentiates based on the effective U/S bit of
> + * the guest page tables; not the processor CPL.
> + */
> + access &=3D ~PFERR_USER_MASK;
> + if ((pte_access & ACC_USER_MASK) && (access & PFERR_GUEST_FINAL_MASK))
> + access |=3D PFERR_USER_MASK;

I think that this hunk should be in 'KVM: nVMX: pass advanced EPT violation=
 vmexit info to guest'
or if you adopt my suggestion then in the combined patch.

My case is that this is the second half of extraction of 'PFERR_USER_MASK' =
for MBE, and it would be nice to have
both in a same patch to see that they share the same MBE imposed weirdness =
of utilizing the U bit from the guest x86 walk.

It might even be worth it to extract this hunk and the '__vmx_handle_ept_vi=
olation' hunk to a separate patch.
This can strengthen the explanation of why this had to be done this way.

> +
> =C2=A0 return mmu->gva_to_gpa(vcpu, mmu, gpa, access, exception);
> =C2=A0}
> =C2=A0

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Leivtsky

