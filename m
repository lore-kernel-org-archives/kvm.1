Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC113EF0A8
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410292; cv=none; b=PRJ8GO7xsPUqs5eLADD0nW6f5ppPCno1+nH/yriUGXBKQIODGl0PbMjWw+4LXdIoKcbssR37S36qdGMxID8j0ZvIhaNgzuC5q4n/HP77cEeOxS6T/lr6hemocQL4SVi66fFmbRcX4r/rtnyg1tUqNCdlU2Y+5bniHYyPYY3W99I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410292; c=relaxed/simple;
	bh=Al/0Zqc4jfsU1XYvVscUOcGofkQXsel/Rj5XutF4Urg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cyYhy7v5BK6Gl7KKTqXBq+0s/hOLeoj0Zzmqcqr+L8v4j80b6TQAd8hWQ9273VK2dTc3PMU4b7l1qx5cKrEntVlfBGqUvjJ3whM9WQ3oe0lIFVSKeSvTla5UJSyQKA2/X0fXnrl69bTsBnm6R3vryZEp79YagHi1RTIAdKJMYGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZxX9s8ZV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZZ8vTBL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxX9s8ZV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZZ8vTBL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aucYO9OqHILOKJy/EFQYeky0yKs5QE5NNJiqy9p6b6M=;
	b=ZxX9s8ZVyGEMPRSzQ1aXshtb2Hayfq56Z1nPCMLXefJyfaxfx+/a/TaHQTeZEfQdsuuP35
	vib0fXgbSC152apklVIwNPWZCXcHfSLLYhg6Yzrs7dzfBROJW8R3WcDm6ip984RY9jr9+T
	pYCE4NwvQ1GCA/far8gxYMrPxAq4qjI=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-38dpNW0wO1iQMEdmnxir9Q-1; Tue, 02 Jun 2026 10:24:48 -0400
X-MC-Unique: 38dpNW0wO1iQMEdmnxir9Q-1
X-Mimecast-MFC-AGG-ID: 38dpNW0wO1iQMEdmnxir9Q_1780410287
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-963df05f08cso667966241.0
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410287; x=1781015087; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aucYO9OqHILOKJy/EFQYeky0yKs5QE5NNJiqy9p6b6M=;
        b=fZZ8vTBLHbLZxCCWZbDeyp/ktLHRZNSbBjTD0Lsvt5qpSLHmpQPq/tOY4D4UoHVmGb
         mcRGUJAzb43S+BxvB+jpe2DYmcFwWQ5wGxujyx4PU4ByH6iPzCLod5e2uSBgc1xSEBKL
         ZAhOVDpvBoyMIM4+6Yd2yZXosCJjMnPIzTEtsEiS3Gxp+T3M83zBaedPmzh9xxYNw9P3
         K42scYHM2eL/CLGHeECuuAJBluh4JmsBiz54FkesdxKJdZUxvIAyR2Hd1dPr028pLOex
         RdiB5WR89Ngk/xTfYQycsj0WTyJrwLWA5Gi+9j/17lfkA+iEjauKzJoMNTmnX+CQAC2A
         3SFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410287; x=1781015087;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aucYO9OqHILOKJy/EFQYeky0yKs5QE5NNJiqy9p6b6M=;
        b=qKbjOeDQKrQJtSyIfDYLtnpanZoLJvNOklA0loDOTZ3bShFzPIlNwUP0KjQfxO1RZD
         DT97VgEKR8ji6po+nr/2Q/rtDthskwqHJt7p4rWLQGI3zWosU3eiSJ/WeRAoiqz/Q3Ao
         YRSr18C/FU2ViUR5R7n0DXHCxRC5zNqR4aqaGbKWaMGYI8yFssax/UBYl2muuKuMbo1+
         QoBN5pTfWFz5xEAyoIqCHAWALV43VS9WXLAmcyViepa53xwadHLAHI+puvvv5AH21KUr
         HomOIjR8iZ/nP6rgsdYmIhOgYP1Fc72bJVVgrqHgQTjbipOSZFAMzOV/pFamHYDq4FWc
         pZlQ==
X-Forwarded-Encrypted: i=1; AFNElJ9aarSWR3xN1pUYQGNRStXhbzpJbZHxgi/6nF2DTPPFDGgxlRUMl19jVt584WqLHNvtK78=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRBhlyCH4x6E0THQEFeRtMp/yrUjMFIGD2nltrkET8xLjpTPzI
	jbY5Is9ZwRTTSuL2bFulhYoeNa5pEh1QkJnowUOB3h1Jei0rLh4nDeowBhIpL4m1T5t1eD8nOPY
	lQluOEIpXm+z+MvL6x/2tH8yAW6a00cWReCbN7d0lsav3VZewyzC7w/yqG0grYQ==
X-Gm-Gg: Acq92OF9xOvd+2crGyrVIMI9dlUY+2bfiF2zt1SEomX6QQzya6Esm4045PQp0j0cNIo
	L9K5/oq+q7nl4EjX0AH4UrtWnCPggqakXxft4H9/rID0Wq4SX1RjggPSuw+4WuCJvxPD6AeZALb
	uOXqwu/fEM3qntrBm08bp2567fAtYBkbVG1W+DACJW8IFitpHUngNlpz69nJapXBi04SABN3Th+
	ugx2d5VAMhpQdwL/8MEWci9NlW6brl8ulqgw5KxM/b9ragVk3BsrKVvnYTz803M5wMqx9JhsW4m
	qZ41oLtoV0rTQXVP9ZZhDWezqI8d7dFKZ3ldof+0Mnl9pBx8moGI2BIQSBcJamhsgxFtYv9dUPM
	lul0cIeSWKxhCx8lPFonUGwW0Qr96vBda7CNNM3M=
X-Received: by 2002:a05:6102:2c11:b0:607:5cd7:d7c0 with SMTP id ada2fe7eead31-6c69b075494mr6605859137.19.1780410287310;
        Tue, 02 Jun 2026 07:24:47 -0700 (PDT)
X-Received: by 2002:a05:6102:2c11:b0:607:5cd7:d7c0 with SMTP id ada2fe7eead31-6c69b075494mr6605827137.19.1780410286776;
        Tue, 02 Jun 2026 07:24:46 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea1c2ca3sm119696756d6.29.2026.06.02.07.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:24:46 -0700 (PDT)
Message-ID: <7499ef2141c4fbf15ae1fcc2189521bed0a94c96.camel@redhat.com>
Subject: Re: [PATCH 13/28] KVM: x86/mmu: split XS/XU bits for EPT
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:24:45 -0400
In-Reply-To: <20260505195226.563317-14-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-14-pbonzini@redhat.com>
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
> When EPT is in use, replace ACC_USER_MASK with ACC_USER_EXEC_MASK,
> so that supervisor and user-mode execution can be controlled
> independently (ACC_USER_MASK would not allow a setting similar to
> XU=3D0 XS=3D1 W=3D1 R=3D1).
>=20
> Replace shadow_x_mask with shadow_xs_mask/shadow_xu_mask, to allow settin=
g
> XS and XU bits separately in EPT entries.
>=20
> In fact, ACC_USER_EXEC_MASK is already set through ACC_ALL in the
> kvm_mmu_page roles and propagates to the XU bit of sPTEs even if
> MBEC is not (yet) enabled in the execution controls.=C2=A0 This is fine,
> because the XU bit is ignored by the processor, and even once KVM
> supports MBEC this mode will remain for processors that lack the
> feature.
>=20
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/kvm/mmu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 3 +-
> =C2=A0arch/x86/kvm/mmu/mmu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0arch/x86/kvm/mmu/mmutrace.h |=C2=A0 6 ++--
> =C2=A0arch/x86/kvm/mmu/spte.c=C2=A0=C2=A0=C2=A0=C2=A0 | 62 ++++++++++++++=
++++++++++++-----------
> =C2=A0arch/x86/kvm/mmu/spte.h=C2=A0=C2=A0=C2=A0=C2=A0 | 16 +++++++---
> =C2=A05 files changed, 62 insertions(+), 27 deletions(-)
>=20
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 63be5c5efed9..d8c13e43c2d7 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -39,7 +39,8 @@ extern bool __read_mostly enable_mmio_caching;
> =C2=A0
> =C2=A0#define ACC_READ_MASK=C2=A0=C2=A0=C2=A0 PT_PRESENT_MASK
> =C2=A0#define ACC_WRITE_MASK=C2=A0=C2=A0 PT_WRITABLE_MASK
> -#define ACC_USER_MASK=C2=A0=C2=A0=C2=A0 PT_USER_MASK
> +#define ACC_USER_MASK=C2=A0=C2=A0=C2=A0 PT_USER_MASK=C2=A0=C2=A0 /* non =
EPT */
> +#define ACC_USER_EXEC_MASK ACC_USER_MASK /* EPT only */
> =C2=A0#define ACC_EXEC_MASK=C2=A0=C2=A0=C2=A0 8
> =C2=A0#define ACC_ALL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (ACC_EXEC_MASK | ACC_WRITE_MASK | ACC_USER_MASK | ACC_READ_MASK)
> =C2=A0
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 3dbac7ad044f..16eaf413b299 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5491,7 +5491,7 @@ static void reset_shadow_zero_bits_mask(struct kvm_=
vcpu *vcpu,
> =C2=A0static inline bool boot_cpu_is_amd(void)
> =C2=A0{
> =C2=A0 WARN_ON_ONCE(!tdp_enabled);
> - return shadow_x_mask =3D=3D 0;
> + return shadow_xs_mask =3D=3D 0;
> =C2=A0}
> =C2=A0
> =C2=A0/*
> diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
> index dcfdfedfc4e9..3429c1413f42 100644
> --- a/arch/x86/kvm/mmu/mmutrace.h
> +++ b/arch/x86/kvm/mmu/mmutrace.h
> @@ -357,8 +357,8 @@ TRACE_EVENT(
> =C2=A0 __entry->sptep =3D virt_to_phys(sptep);
> =C2=A0 __entry->level =3D level;
> =C2=A0 __entry->r =3D shadow_present_mask || (__entry->spte & PT_PRESENT_=
MASK);
> - __entry->x =3D is_executable_pte(__entry->spte);
> - __entry->u =3D shadow_user_mask ? !!(__entry->spte & shadow_user_mask) =
: -1;
> + __entry->x =3D (__entry->spte & (shadow_xs_mask | shadow_nx_mask)) =3D=
=3D shadow_xs_mask;
> + __entry->u =3D !!(__entry->spte & (shadow_xu_mask | shadow_user_mask));
> =C2=A0 ),
> =C2=A0
> =C2=A0 TP_printk("gfn %llx spte %llx (%s%s%s%s) level %d at %llx",
> @@ -366,7 +366,7 @@ TRACE_EVENT(
> =C2=A0 =C2=A0 __entry->r ? "r" : "-",
> =C2=A0 =C2=A0 __entry->spte & PT_WRITABLE_MASK ? "w" : "-",
> =C2=A0 =C2=A0 __entry->x ? "x" : "-",
> - =C2=A0 __entry->u =3D=3D -1 ? "" : (__entry->u ? "u" : "-"),
> + =C2=A0 __entry->u ? "u" : "-",
> =C2=A0 =C2=A0 __entry->level, __entry->sptep
> =C2=A0 )
> =C2=A0);
> diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
> index 1b7fb508098b..f41573b0ccfa 100644
> --- a/arch/x86/kvm/mmu/spte.c
> +++ b/arch/x86/kvm/mmu/spte.c
> @@ -29,8 +29,9 @@ bool __read_mostly kvm_ad_enabled;
> =C2=A0u64 __read_mostly shadow_host_writable_mask;
> =C2=A0u64 __read_mostly shadow_mmu_writable_mask;
> =C2=A0u64 __read_mostly shadow_nx_mask;
> -u64 __read_mostly shadow_x_mask; /* mutual exclusive with nx_mask */
> =C2=A0u64 __read_mostly shadow_user_mask;
> +u64 __read_mostly shadow_xs_mask; /* mutual exclusive with nx_mask and u=
ser_mask */
> +u64 __read_mostly shadow_xu_mask; /* mutual exclusive with nx_mask and u=
ser_mask */
> =C2=A0u64 __read_mostly shadow_accessed_mask;
> =C2=A0u64 __read_mostly shadow_dirty_mask;
> =C2=A0u64 __read_mostly shadow_mmio_value;
> @@ -217,21 +218,26 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mm=
u_page *sp,
> =C2=A0 * would tie make_spte() further to vCPU/MMU state, and add complex=
ity
> =C2=A0 * just to optimize a mode that is anything but performance critica=
l.
> =C2=A0 */
> - if (level > PG_LEVEL_4K && (pte_access & ACC_EXEC_MASK) &&
> - =C2=A0=C2=A0=C2=A0 is_nx_huge_page_enabled(vcpu->kvm)) {
> + if (level > PG_LEVEL_4K && is_nx_huge_page_enabled(vcpu->kvm)) {
> =C2=A0 pte_access &=3D ~ACC_EXEC_MASK;
> + if (shadow_xu_mask)
> + pte_access &=3D ~ACC_USER_EXEC_MASK;
> =C2=A0 }
> =C2=A0
> =C2=A0 if (pte_access & ACC_READ_MASK)
> =C2=A0 spte |=3D PT_PRESENT_MASK; /* or VMX_EPT_READABLE_MASK */
> =C2=A0
> - if (pte_access & ACC_EXEC_MASK)
> - spte |=3D shadow_x_mask;
> - else
> - spte |=3D shadow_nx_mask;
> -
> - if (pte_access & ACC_USER_MASK)
> - spte |=3D shadow_user_mask;
> + if (shadow_nx_mask) {
> + if (!(pte_access & ACC_EXEC_MASK))
> + spte |=3D shadow_nx_mask;
> + if (pte_access & ACC_USER_MASK)
> + spte |=3D shadow_user_mask;
> + } else {
> + if (pte_access & ACC_EXEC_MASK)
> + spte |=3D shadow_xs_mask;
> + if (pte_access & ACC_USER_EXEC_MASK)
> + spte |=3D shadow_xu_mask;
> + }

Hi!

Looks correct but at some point a question starts to ask itself:=C2=A0

Do you think that the time come to give up and add an is_ept/is_npt flags, =
and use that=C2=A0instead of checking for various properties=C2=A0that happ=
en to be specific to EPT/x86/NPT paging,=C2=A0
such as non-zero shadow_nx_mask?

The intention behind this is very good, but in practice IMHO,=C2=A0the code=
 still assumes
hard a EPT or NPT/x86 and there is roughly 0% chance that it will work if s=
ome
vendor ever ships a CPU with TDP paging that uses weird half-EPT, half-NPT =
entries.

I do understand that this is not black and white because x86 paging and NPT=
 also do
differ, but only slightly.

I think we should have:

is_ept() for cases which are explicitly EPT-only (e.g emulation of A/D)
is_npt() for cases which are explicitly NPT (e.g NPT specific checks on U b=
it with and without GMET)
is_x86() for cases which are common for NPT or EPT (or use !is_ept())

What do you think?

Sorry for ramblings, this is just an idea for a possible refactoring, no ne=
ed to do it now :)
BTW, actually we even already have boot_cpu_is_amd, which checks 'shadow_xs=
_mask =3D=3D 0'...

> =C2=A0
> =C2=A0 if (level > PG_LEVEL_4K)
> =C2=A0 spte |=3D PT_PAGE_SIZE_MASK;
> @@ -318,11 +324,13 @@ static u64 change_spte_executable(u64 spte, u8 acce=
ss)
> =C2=A0{
> =C2=A0 u64 set, clear;
> =C2=A0
> - if (access & ACC_EXEC_MASK)
> - set =3D shadow_x_mask;
> + if (shadow_nx_mask)
> + set =3D (access & ACC_EXEC_MASK) ? 0 : shadow_nx_mask;
> =C2=A0 else
> - set =3D shadow_nx_mask;
> - clear =3D set ^ (shadow_nx_mask | shadow_x_mask);
> + set =3D
> + (access & ACC_EXEC_MASK ? shadow_xs_mask : 0) |
> + (access & ACC_USER_EXEC_MASK ? shadow_xu_mask : 0);
> + clear =3D set ^ (shadow_nx_mask | shadow_xs_mask | shadow_xu_mask);
> =C2=A0 return modify_spte_protections(spte, set, clear);
> =C2=A0}
> =C2=A0
> @@ -389,7 +397,7 @@ u64 make_nonleaf_spte(u64 *child_pt, bool ad_disabled=
)
> =C2=A0
> =C2=A0 spte |=3D __pa(child_pt) | shadow_present_mask | PT_WRITABLE_MASK =
|
> =C2=A0 PT_PRESENT_MASK /* or VMX_EPT_READABLE_MASK */ |
> - shadow_user_mask | shadow_x_mask | shadow_me_value;
> + shadow_user_mask | shadow_xs_mask | shadow_xu_mask | shadow_me_value;
> =C2=A0
> =C2=A0 if (ad_disabled)
> =C2=A0 spte |=3D SPTE_TDP_AD_DISABLED;
> @@ -497,10 +505,27 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits)
> =C2=A0 shadow_accessed_mask =3D VMX_EPT_ACCESS_BIT;
> =C2=A0 shadow_dirty_mask =3D VMX_EPT_DIRTY_BIT;
> =C2=A0 shadow_nx_mask =3D 0ull;
> - shadow_x_mask =3D VMX_EPT_EXECUTABLE_MASK;
> + shadow_xs_mask =3D VMX_EPT_EXECUTABLE_MASK;
> +
> + /*
> + * The MMU always maps ACC_EXEC_MASK and ACC_USER_EXEC_MASK to the
> + * XS and XU bits of shadow EPT entries, regardless of whether MBEC
> + * is available on the host or enabled in the VMCS.
> + *
> + * For the non-nested case, pages are mapped with ACC_EXEC_MASK
> + * and ACC_USER_EXEC_MASK set in tandem, so XS =3D=3D XU and the
> + * host's MBEC setting does not matter.=C2=A0 On hardware without MBEC
> + * the XU bit is reserved-as-ignored, and setting it does no harm.
> + *
> + * For nested EPT MBEC is not supported, but bit 10 of the gPTE has
> + * no effect because (a) is_present_gpte() does not treat it as a
> + * present bit, and (b) permission_fault() uses an mmu->permissions[]
> + * array that effectively ignores ACC_USER_EXEC_MASK.
> + */




> + shadow_xu_mask =3D VMX_EPT_USER_EXECUTABLE_MASK;
> =C2=A0 shadow_present_mask =3D VMX_EPT_SUPPRESS_VE_BIT;
> =C2=A0
> - shadow_acc_track_mask =3D VMX_EPT_RWX_MASK;
> + shadow_acc_track_mask =3D VMX_EPT_RWX_MASK | VMX_EPT_USER_EXECUTABLE_MA=
SK;
> =C2=A0 shadow_host_writable_mask =3D EPT_SPTE_HOST_WRITABLE;
> =C2=A0 shadow_mmu_writable_mask=C2=A0 =3D EPT_SPTE_MMU_WRITABLE;
> =C2=A0
> @@ -548,7 +573,8 @@ void kvm_mmu_reset_all_pte_masks(void)
> =C2=A0 shadow_accessed_mask =3D PT_ACCESSED_MASK;
> =C2=A0 shadow_dirty_mask =3D PT_DIRTY_MASK;
> =C2=A0 shadow_nx_mask =3D PT64_NX_MASK;
> - shadow_x_mask =3D 0;
> + shadow_xs_mask =3D 0;
> + shadow_xu_mask =3D 0;
> =C2=A0 shadow_present_mask =3D PT_PRESENT_MASK;
> =C2=A0
> =C2=A0 shadow_acc_track_mask =3D 0;
> diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
> index 8a4c09c5cdbf..f5261d993eac 100644
> --- a/arch/x86/kvm/mmu/spte.h
> +++ b/arch/x86/kvm/mmu/spte.h
> @@ -24,7 +24,7 @@
> =C2=A0 * - bits 55 (EPT only): MMU-writable
> =C2=A0 * - bits 56-59: unused
> =C2=A0 * - bits 60-61: type of A/D tracking
> - * - bits 62: unused
> + * - bits 62 (EPT only): saved XU bit for disabled AD
> =C2=A0 */
> =C2=A0
> =C2=A0/*
> @@ -65,7 +65,8 @@ static_assert(SPTE_TDP_AD_ENABLED =3D=3D 0);
> =C2=A0 * must not overlap the A/D type mask.
> =C2=A0 */
> =C2=A0#define SHADOW_ACC_TRACK_SAVED_BITS_MASK (VMX_EPT_READABLE_MASK | \
> - =C2=A0 VMX_EPT_EXECUTABLE_MASK)
> + =C2=A0 VMX_EPT_EXECUTABLE_MASK | \
> + =C2=A0 VMX_EPT_USER_EXECUTABLE_MASK)
> =C2=A0#define SHADOW_ACC_TRACK_SAVED_BITS_SHIFT 52
> =C2=A0#define SHADOW_ACC_TRACK_SAVED_MASK (SHADOW_ACC_TRACK_SAVED_BITS_MA=
SK << \
> =C2=A0 SHADOW_ACC_TRACK_SAVED_BITS_SHIFT)
> @@ -178,8 +179,9 @@ extern bool __read_mostly kvm_ad_enabled;
> =C2=A0extern u64 __read_mostly shadow_host_writable_mask;
> =C2=A0extern u64 __read_mostly shadow_mmu_writable_mask;
> =C2=A0extern u64 __read_mostly shadow_nx_mask;
> -extern u64 __read_mostly shadow_x_mask; /* mutual exclusive with nx_mask=
 */
> =C2=A0extern u64 __read_mostly shadow_user_mask;
> +extern u64 __read_mostly shadow_xs_mask; /* mutual exclusive with nx_mas=
k and user_mask */
> +extern u64 __read_mostly shadow_xu_mask; /* mutual exclusive with nx_mas=
k and user_mask */
> =C2=A0extern u64 __read_mostly shadow_accessed_mask;
> =C2=A0extern u64 __read_mostly shadow_dirty_mask;
> =C2=A0extern u64 __read_mostly shadow_mmio_value;
> @@ -357,7 +359,13 @@ static inline bool is_last_spte(u64 pte, int level)
> =C2=A0
> =C2=A0static inline bool is_executable_pte(u64 spte)
> =C2=A0{
> - return (spte & (shadow_x_mask | shadow_nx_mask)) =3D=3D shadow_x_mask;
> + /*
> + * For now, return true if either the XS or XU bit is set
> + * This function is only used for fast_page_fault,
> + * which never processes shadow EPT, and regular page
> + * tables always have XS=3D=3DXU.
> + */
> + return (spte & (shadow_xs_mask | shadow_xu_mask | shadow_nx_mask)) !=3D=
 shadow_nx_mask;
> =C2=A0}
> =C2=A0
> =C2=A0static inline kvm_pfn_t spte_to_pfn(u64 pte)



Looks all correct to me.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

