Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1119C311C32
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410247; cv=none; b=PpAOyXyD2IginMmLAb/4CKLe1vR/jGK7UloIebN9nOZIRLnGmxHILspHA0Sy2M00yPhHLWnqYuUsXgHwV+Ug4MNlLjB91AVLa8dPaXDakNPskKFOPKV8/r0tBJd8LJFpYnQZe1oK3f+iqsLxTsBj0xSybccjioVuS78Vj2mpmws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410247; c=relaxed/simple;
	bh=7h4yvIaxpZfu97W6NaqLOnIqPmnLwPk4acmyquCgAEA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uwn3P0LNsh75clLxJ5iKYuqmRjki24j6CbktWF6QWt82tohLQ+tDRAMPxNzvn7VLpPG6jlb9lMLFmuStge7boMIbrG/5k6MJrnvdsXLO+6lD/ElUpSbAj8TvFGkkLHtuWqPFcoSO1Efewn7UiLTUD/3ZbrR75DM0WKiwHJWPP0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NmD47QWi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=en/Pjq+E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmD47QWi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="en/Pjq+E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4IMuBtd9B7qFh8v4FQqCNaQDTtXidHmA4NK5U6dV2Ro=;
	b=NmD47QWi2AJ/q4oT0c0WxjUoNeDeNZ1PpAdh91axiZu6vyDDqBoX/hxUAUNi4SRHtXwiDX
	FfVvQ7EZzlMI6gjDoVkxqUrv1NV/62U9TXWUsqAhwJ3qvggdTOOYeMxDI46vTuKzGg/PhU
	3umIBOKDvQLj22RVENe1kAF5MF4W6tE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-MVfydG8kPsuNUqSfPXJUig-1; Tue, 02 Jun 2026 10:24:02 -0400
X-MC-Unique: MVfydG8kPsuNUqSfPXJUig-1
X-Mimecast-MFC-AGG-ID: MVfydG8kPsuNUqSfPXJUig_1780410242
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8cecac0e467so458366d6.0
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410242; x=1781015042; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4IMuBtd9B7qFh8v4FQqCNaQDTtXidHmA4NK5U6dV2Ro=;
        b=en/Pjq+EpG0ZgwfDnlf2JoXDOekfHY5OJYflFB05CdSAinHcPD5+NIFbXNSnPe1IFp
         B3/9WeWb0EoYcUVJHnkRJzgMIVJi2vKYTK3K3XA7y28yO7ou2UUVz6fRCyTU9YRsIpPn
         Q4wudlhvG4nHtpNdscctItyvUmvpBoaiwvARw4rB6seAYQdFZkyGhzhBNllEyAbWRBGS
         TQCUj+BBh93Dc5vCKTQtFV3rSl0bO1gmN2qQgOBjZNs+Pr/ZfzHx1p1fMcjch26Ru47r
         Yt0XvZB5G+soJyNMyUjr1aViA+DrtbjD6s7ox3QtOrcFpwWX9ZPrfKuvnRONMZ/abHsQ
         4j0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410242; x=1781015042;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4IMuBtd9B7qFh8v4FQqCNaQDTtXidHmA4NK5U6dV2Ro=;
        b=AXLY16pgIk1UkudtDDJfQXtpFM17wDoPYpWzp7Kkj7mqAvgpA/83LR2MWbkZxq0pL3
         +K9HeFXaIvxcrztKDVkzASBaq0zp8uOi8mtclYUJ1IUtpCg4cTW4IUUnYnt1Jm+KV/aM
         xOgoYI3NTcHy4c7pW5w2uQPD1qpYY6ZNNWEFaEOCT8kHklCjuP+sRngmr0AA5AxY0FB7
         uaZsQe7frBfS4hOGBWML/MjFZZVvI7Dhw32p14efChuvT9ahMAk/VnT3TOl238oyNmrJ
         cT3kMsK44cl6ocAobWrHF+wBgDVDw/0utkdw0XOWrFU3qoIBlOCi4fafUt28gzfCbLe8
         55KQ==
X-Forwarded-Encrypted: i=1; AFNElJ87hwTmLvdWncObnTSTxXkHfjGAVUmG3OR1Lc88ULxvNVCfgsOcWmEGdMhkLJIgly9uB90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8fCVhUTRFmwUyI20JF5+Oue1uxMYnV5K8ye0V6mS/lGxBHh45
	JevnF0/iET3tlrW04BIjXS9JTivs+lIxG/A+gxJ0jyaGkS3fye9KWcnB70DELb8rIypKBrxoKjt
	zKR+cMwxlmE3pe+eT1lI9I/wYRtuTEXSKoXdlwLmbalsF6Wu84E8d9Q==
X-Gm-Gg: Acq92OHjtxLycU/e2qieF2ktgS0DGSWZ6msj0Dx/XsxjtQ2yVGVsBVJcSpQpdY8LcVR
	l1vR43TQ8jCMTXcHz/YfTzYOSaFb0psNbpDujTYluiwDxlXEO4xVH2o62njqnIfOnLcGSU+8f7m
	Qb9+laJHAMRV2BbyzgAaE+q42lGclhcCpYwo6DMXISLqs4ORS43QdhQsJZ2kIDUSL4iO7cNe2HY
	TDlagBx6D/ZUpZsoRri1hqcpT/utdYpIrqzCkKFsgeoy9BzC8Xr1NJtApulPQtoavAgLtvbaKl9
	nYip/2w2CVH0bCfldsG4fNwAvPPRuf3t/wlRFjP6ljFddGPd2Be94vEIT8BngEPfX3dmhUclHWQ
	JqMEVF83IT5FK788Um1j6mTvncR+j9JExE6GEHEs=
X-Received: by 2002:a05:6214:1255:b0:8ce:abea:4727 with SMTP id 6a1803df08f44-8ceabea4c1amr161480086d6.31.1780410242004;
        Tue, 02 Jun 2026 07:24:02 -0700 (PDT)
X-Received: by 2002:a05:6214:1255:b0:8ce:abea:4727 with SMTP id 6a1803df08f44-8ceabea4c1amr161479426d6.31.1780410241511;
        Tue, 02 Jun 2026 07:24:01 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea06d4casm117931816d6.16.2026.06.02.07.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:24:01 -0700 (PDT)
Message-ID: <4945990d5ecf9a36c53fe0fdbef5f2da7e8ab0d4.camel@redhat.com>
Subject: Re: [PATCH 11/28] KVM: x86/mmu: pass pte_access for final nGPA->GPA
 walk
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:24:00 -0400
In-Reply-To: <20260505195226.563317-12-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-12-pbonzini@redhat.com>
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
> The XS/XU bit for EPT are only applied to final accesses, and use the
> U bit from the page walk itself.=C2=A0 This is available in the page walk=
er
> as pte_access & ACC_USER_MASK but not available to translate_nested_gpa,
> so pass it down.
>=20
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/kvm/hyperv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0arch/x86/kvm/mmu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 15 ++++++++++++---
> =C2=A0arch/x86/kvm/mmu/mmu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 8 +++++++-
> =C2=A0arch/x86/kvm/mmu/paging_tmpl.h |=C2=A0 4 ++--
> =C2=A0arch/x86/kvm/mmu/spte.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 6 ------
> =C2=A0arch/x86/kvm/x86.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++--
> =C2=A06 files changed, 25 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index cf9dd565b894..53688f7b76eb 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -2042,7 +2042,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, =
struct kvm_hv_hcall *hc)
> =C2=A0 */
> =C2=A0 if (!hc->fast && is_guest_mode(vcpu)) {
> =C2=A0 hc->ingpa =3D translate_nested_gpa(vcpu, hc->ingpa,
> - PFERR_GUEST_FINAL_MASK, NULL);
> + PFERR_GUEST_FINAL_MASK, NULL, 0);
> =C2=A0 if (unlikely(hc->ingpa =3D=3D INVALID_GPA))
> =C2=A0 return HV_STATUS_INVALID_HYPERCALL_INPUT;
> =C2=A0 }
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 23f37535c0ce..635c2e5d8513 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -37,6 +37,12 @@ extern bool __read_mostly enable_mmio_caching;
> =C2=A0#define PT32_ROOT_LEVEL 2
> =C2=A0#define PT32E_ROOT_LEVEL 3
> =C2=A0
> +#define ACC_READ_MASK=C2=A0=C2=A0=C2=A0 PT_PRESENT_MASK
> +#define ACC_WRITE_MASK=C2=A0=C2=A0 PT_WRITABLE_MASK
> +#define ACC_USER_MASK=C2=A0=C2=A0=C2=A0 PT_USER_MASK
> +#define ACC_EXEC_MASK=C2=A0=C2=A0=C2=A0 8
> +#define ACC_ALL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (A=
CC_EXEC_MASK | ACC_WRITE_MASK | ACC_USER_MASK | ACC_READ_MASK)
> +
> =C2=A0#define KVM_MMU_CR4_ROLE_BITS (X86_CR4_PSE | X86_CR4_PAE | X86_CR4_=
LA57 | \
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_CR4_SMEP | X86_CR4_SMAP |=
 X86_CR4_PKE)
> =C2=A0
> @@ -289,16 +295,19 @@ static inline void kvm_update_page_stats(struct kvm=
 *kvm, int level, int count)
> =C2=A0}
> =C2=A0
> =C2=A0gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u64 ac=
cess,
> - =C2=A0=C2=A0 struct x86_exception *exception);
> + =C2=A0=C2=A0 struct x86_exception *exception,
> + =C2=A0=C2=A0 u64 pte_access);
> =C2=A0
> =C2=A0static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_mmu *mmu,
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpa_t gpa, u64 access,
> - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct x86_exception *exception)
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct x86_exception *exception,
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 pte_access)

Hi,=20

IMHO the fact that we have now both 'access' and 'pte_access' is confusing,
and yet we have to do it in this way because this is how MBE works.

I think this needs a one large comment justifying the whole thing, includin=
g
explanation on what pte_access is and that it is only defined for access th=
at
translate the final guest memory access (it is 0 otherwise)

Maybe, I would go even further and suggest to replace the pte_access
with a boolean for the MBE only (bool mapped_as_user for example),=C2=A0
hoping that MBE will be the only case that requires this, and
have a comment explaining this. I am not sure about this,
but I do think that a comment is warranted here.


Again, this is not our fault, but rather a result of MBE being defined like=
 that.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky



> =C2=A0{
> =C2=A0 if (mmu !=3D &vcpu->arch.nested_mmu)
> =C2=A0 return gpa;
> - return translate_nested_gpa(vcpu, gpa, access, exception);
> + return translate_nested_gpa(vcpu, gpa, access, exception,
> + =C2=A0=C2=A0=C2=A0 pte_access);
> =C2=A0}
> =C2=A0
> =C2=A0static inline bool kvm_has_mirrored_tdp(const struct kvm *kvm)
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 46412e4d207f..3dbac7ad044f 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4348,8 +4348,14 @@ static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu =
*vcpu, struct kvm_mmu *mmu,
> =C2=A0{
> =C2=A0 if (exception)
> =C2=A0 exception->error_code =3D 0;
> + /*
> + * EPT MBEC uses the effective access bits from the PTE to distinguish
> + * user and supervisor accesses, and treats every linear address as a
> + * user-mode address if CR0.PG=3D0.=C2=A0 Therefore *include* ACC_USER_M=
ASK in
> + * the last argument to kvm_translate_gpa (which NPT does not use).
> + */
> =C2=A0 return kvm_translate_gpa(vcpu, mmu, vaddr, access | PFERR_GUEST_FI=
NAL_MASK,
> - exception);
> + exception, ACC_ALL);
> =C2=A0}
> =C2=A0
> =C2=A0static bool mmio_info_in_cache(struct kvm_vcpu *vcpu, u64 addr, boo=
l direct)
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmp=
l.h
> index 567f8b77ffe0..8dd9d510fc34 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -377,7 +377,7 @@ static int FNAME(walk_addr_generic)(struct guest_walk=
er *walker,
> =C2=A0
> =C2=A0 real_gpa =3D kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(table_gfn),
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 nested_access | PFERR_GUEST_PAGE_MASK,
> - =C2=A0=C2=A0=C2=A0=C2=A0 &walker->fault);
> + =C2=A0=C2=A0=C2=A0=C2=A0 &walker->fault, 0);
> =C2=A0
> =C2=A0 /*
> =C2=A0 * FIXME: This can happen if emulation (for of an INS/OUTS
> @@ -447,7 +447,7 @@ static int FNAME(walk_addr_generic)(struct guest_walk=
er *walker,
> =C2=A0
> =C2=A0 real_gpa =3D kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn),
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 access | PFERR_GUEST_FINAL_MASK,
> - =C2=A0=C2=A0=C2=A0=C2=A0 &walker->fault);
> + =C2=A0=C2=A0=C2=A0=C2=A0 &walker->fault, walker->pte_access);
> =C2=A0 if (real_gpa =3D=3D INVALID_GPA)
> =C2=A0 return 0;
> =C2=A0
> diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
> index 121bfb2217e8..8a4c09c5cdbf 100644
> --- a/arch/x86/kvm/mmu/spte.h
> +++ b/arch/x86/kvm/mmu/spte.h
> @@ -52,12 +52,6 @@ static_assert(SPTE_TDP_AD_ENABLED =3D=3D 0);
> =C2=A0#define SPTE_BASE_ADDR_MASK (((1ULL << 52) - 1) & ~(u64)(PAGE_SIZE-=
1))
> =C2=A0#endif
> =C2=A0
> -#define ACC_READ_MASK=C2=A0=C2=A0=C2=A0 PT_PRESENT_MASK
> -#define ACC_WRITE_MASK=C2=A0=C2=A0 PT_WRITABLE_MASK
> -#define ACC_USER_MASK=C2=A0=C2=A0=C2=A0 PT_USER_MASK
> -#define ACC_EXEC_MASK=C2=A0=C2=A0=C2=A0 8
> -#define ACC_ALL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (A=
CC_EXEC_MASK | ACC_WRITE_MASK | ACC_USER_MASK | ACC_READ_MASK)
> -
> =C2=A0#define SPTE_LEVEL_BITS 9
> =C2=A0#define SPTE_LEVEL_SHIFT(level) __PT_LEVEL_SHIFT(level, SPTE_LEVEL_=
BITS)
> =C2=A0#define SPTE_INDEX(address, level) __PT_INDEX(address, level, SPTE_=
LEVEL_BITS)
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ef1e3ae13887..67979b7de5d6 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1073,7 +1073,7 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned lon=
g cr3)
> =C2=A0 */
> =C2=A0 real_gpa =3D kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(pdpt_gfn),
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 PFERR_USER_MASK | PFERR_WRITE_MASK |
> - =C2=A0=C2=A0=C2=A0=C2=A0 PFERR_GUEST_PAGE_MASK, NULL);
> + =C2=A0=C2=A0=C2=A0=C2=A0 PFERR_GUEST_PAGE_MASK, NULL, 0);
> =C2=A0 if (real_gpa =3D=3D INVALID_GPA)
> =C2=A0 return 0;
> =C2=A0
> @@ -7849,7 +7849,8 @@ void kvm_get_segment(struct kvm_vcpu *vcpu,
> =C2=A0}
> =C2=A0
> =C2=A0gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u64 ac=
cess,
> - =C2=A0=C2=A0 struct x86_exception *exception)
> + =C2=A0=C2=A0 struct x86_exception *exception,
> + =C2=A0=C2=A0 u64 pte_access)
> =C2=A0{
> =C2=A0 struct kvm_mmu *mmu =3D vcpu->arch.mmu;
> =C2=A0 gpa_t t_gpa;

