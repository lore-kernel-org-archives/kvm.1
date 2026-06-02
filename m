Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C7F3F4100
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410558; cv=none; b=A6YIezaari4QIwJLADRuhTkVGdpvxKNXo4Af7HqVVE+1DOpijtQxkDSUoaW38yzhD7jdJaEnVusZEhtf6UFrR0eR5EkL9/Gb9ZB8+W4Kr7VXIgT7OK5p0XfZOhrz682r0e5SPsu6I76DbvaBmR+T+RxrfH9BL5+iAxgoL8GbV7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410558; c=relaxed/simple;
	bh=+A2uELDsnAGCdCh735goL76/wUe90FvZW4Lez3TfFeI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BiQHw+40Z0ohsTGasfsgyBZ1LtJ+eoS3ahb3dVQtvijDhw9Uu3lBVCdJMyZ4Z+G1rdTDvopRZXxV7dc77fDP/enJTGzLq6dHrPFTPQK0HzuRsuyz3KFYydh2URjAFbQMFwTHwm+uIZW03GXdMXNuwjwsx8fQdXiuQBcJwNEeDWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZcFVWvKH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oR1PDYUu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcFVWvKH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oR1PDYUu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0p3FJ0ShKCAizMIlCc8mStOg9WAQBwwXAaeLW6j6j6k=;
	b=ZcFVWvKHI1TSTZidrFbMcykRwvbXUqOW2pmuscopNxphYyMu03rhHOGHd5y787inGz2yas
	XJ842FjGxT88qKQ977Ji2F9hXK4Mpc7cf8u4Lghs9e2JNgmC1UBSyizwCzTIcPtlU/ZgYq
	5clpmMJ1Pmt7Fe8HFKMmFXDL+YnXAp8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-T0wDNqjoPyqnZmR1Kitdsg-1; Tue, 02 Jun 2026 10:29:15 -0400
X-MC-Unique: T0wDNqjoPyqnZmR1Kitdsg-1
X-Mimecast-MFC-AGG-ID: T0wDNqjoPyqnZmR1Kitdsg_1780410554
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9157c8eb597so152752885a.2
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410554; x=1781015354; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0p3FJ0ShKCAizMIlCc8mStOg9WAQBwwXAaeLW6j6j6k=;
        b=oR1PDYUuULDytM99Se4oAiLg5kE8HwY0NtfYS6zsBR9Iy8m8v40HHKP1zOunGf6zbR
         26QxNJ78BmDD8twIIzYtiiFCgjOmxZa23k2+FN04aAlFtcs1TPVpsL2NzyUsB641hFp9
         Snj0+an5hGSNZDOLbLvSuWOH24fZLgVW73rTphTIwbJjdu27HYrhlNCgg4TM/nz0cv3G
         bBuD3fDIomsWqciuAjJy9+6Z8kya6suFpCD1bOwCKcGV3gcIzK00ixT6bm4LpFePwWPk
         ZkeS+E4/a3wW4r3bYLOFAWK4Jbs6t3gyZurYCdTh2E88gy+d2eZWI+FeDMx1wK6CrbT9
         vvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410554; x=1781015354;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0p3FJ0ShKCAizMIlCc8mStOg9WAQBwwXAaeLW6j6j6k=;
        b=JCi2T0DRAvIaHBC7PBp83VCMtNd+UELANdbwTwm86BvRVYDSrpzfBaATRlxYR+L2VY
         P1Wppq/IYp7Q8Prqz2YsSjwXHnlSXtJHRljKWKxiwIUyR/2JIIPKKLYWD6JZf+GuLGmF
         H7s16HDtZDBmoFv7j/Ebb4vaxYf3f80VgMAf2uz63xzroHWroQCQP2zLQb8hO0dFR7vO
         x1/conFVuPkijiBv0UVLI8yyLeicMgYs++alzGtFqTXD5ErqO9NmSs5PlbXotsQ+XdhM
         EYcFFCIEgBuaL7Z1vTN/jNiLaD2e196kWX/BTEEeuI/k66S1Ya8aunY+x9E5tgOAuDVk
         Cw3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9lZglBtIHYR+MtXDQkNu4iDE+6hgCXYBNul90hz45HT+9/Su3sZBvlnVtuWkr2GkqIsVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvx7nTDQ2ze396BKhcl7fl65HjKkHjG7iqGN+SyYKu5ndTjNfV
	jB6H5yfmvN9eGvEgh7HtAISTbxjNrdolRBlm4YCAdV71qqHwIvra3VghzfGQZAbj1002jbwOXh/
	kthvLxik2KFO3R6vOfDBJIgoysQy3rdzIjVi6bWbxvkJPTeY3cWYrug==
X-Gm-Gg: Acq92OETNsTq/YgA2B6QbwYED3Beghy4BG542iuHTwgrzh0sdKBhWnlF8Hkr/k4cw9x
	hZgDKWTXX0S8cYXn0ki3ehZ8xrsO/4TiVmcpKq1g4i20a8V/ihjhDj/gIosKqAyHUtTyw2McV8p
	s0jcOdhNY+MqNOQi5wrrnAtMwabcNsf8Ya3+A4lm19qWOXUa2YT2bbl5c+GbmYaKMhUPpiRg44L
	ahulUzdcuHvJXI35vuCcnLEGWHDkJ08hTeW6QMhNZt6yBuhpE4q2BjKbDyuRx+DmsplMiqFmCFW
	Wx+/YCfx3zK+wKkNW6Mwxwb1L7G4Q9pd4cw/Z8Q5mUGkdfp5cfDGECpYdBc/q/3mpihJLtYlA6P
	X5xvZV5O1BK5l66EFJNish3SHmZTzuNkJa9mSzJY=
X-Received: by 2002:a05:620a:241a:20b0:914:c61f:c699 with SMTP id af79cd13be357-9153d938cd3mr1742905385a.13.1780410554318;
        Tue, 02 Jun 2026 07:29:14 -0700 (PDT)
X-Received: by 2002:a05:620a:241a:20b0:914:c61f:c699 with SMTP id af79cd13be357-9153d938cd3mr1742900285a.13.1780410553748;
        Tue, 02 Jun 2026 07:29:13 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91566f4abf3sm459120485a.27.2026.06.02.07.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:29:13 -0700 (PDT)
Message-ID: <48424fff4d8e760817def1842427f7bffab5ab16.camel@redhat.com>
Subject: Re: [PATCH 21/28] KVM: x86/mmu: propagate access mask from root
 pages down
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:29:12 -0400
In-Reply-To: <20260505195226.563317-22-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-22-pbonzini@redhat.com>
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
> Until now, all SPTEs have had all kinds of access allowed; however,
> for GMET to be enabled all the pages have to have ACC_USER_MASK
> disabled.=C2=A0 By marking them as supervisor pages, the processor
> allows execution from either user or supervisor mode (unlike
> for normal paging, NPT ignores the U bit for reads and writes).

Hi!

AFAIK, according to the AMD's APM, NPT forces U bit to be 1, so it might be=
 worth it to
update the commit message to state that NPT ignores U bit when GMET is enab=
led.

"A page is considered user in the guest only if it's marked as user at the =
guest level.=C2=A0
The page must be marked user in the nested page table to allow any guest ac=
cess at all."

I haven't found anything else about this in the APM (Rev. 3.44=E2=80=94Marc=
h 2026).
Using common sense, I agree that with GMET enabled, the U bit must be ignor=
ed for read/writes though,
but once again, I haven't found anything about it in the APM.


> That will mean that the root page's role has ACC_USER_MASK
> cleared and that has to be propagated down through the kvm_mmu_page
> tree.
>=20
> Do that, and pass the required access to the
> kvm_mmu_spte_requested tracepoint since it's not ACC_ALL
> anymore.

It might be worth it to mention that other than changes to the tracepoints,
this patch doesn't yet change any functionality (everything is still ACC_AL=
L)

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>


Best regards,
	Maxim Levitsky

>=20
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/kvm/mmu/mmu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 9 +++++----
> =C2=A0arch/x86/kvm/mmu/mmutrace.h=C2=A0=C2=A0=C2=A0 | 10 ++++++----
> =C2=A0arch/x86/kvm/mmu/paging_tmpl.h |=C2=A0 2 +-
> =C2=A0arch/x86/kvm/mmu/tdp_mmu.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++---
> =C2=A04 files changed, 15 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index ededc26c6675..156bab8afbc6 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3446,12 +3446,13 @@ static int direct_map(struct kvm_vcpu *vcpu, stru=
ct kvm_page_fault *fault)
> =C2=A0{
> =C2=A0 struct kvm_shadow_walk_iterator it;
> =C2=A0 struct kvm_mmu_page *sp;
> - int ret;
> + int ret, access;
> =C2=A0 gfn_t base_gfn =3D fault->gfn;
> =C2=A0
> =C2=A0 kvm_mmu_hugepage_adjust(vcpu, fault);
> =C2=A0
> - trace_kvm_mmu_spte_requested(fault);
> + access =3D vcpu->arch.mmu->root_role.access;
> + trace_kvm_mmu_spte_requested(fault, access);
> =C2=A0 for_each_shadow_entry(vcpu, fault->addr, it) {
> =C2=A0 /*
> =C2=A0 * We cannot overwrite existing page tables with an NX
> @@ -3464,7 +3465,7 @@ static int direct_map(struct kvm_vcpu *vcpu, struct=
 kvm_page_fault *fault)
> =C2=A0 if (it.level =3D=3D fault->goal_level)
> =C2=A0 break;
> =C2=A0
> - sp =3D kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn, true, ACC_ALL);
> + sp =3D kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn, true, access);
> =C2=A0 if (sp =3D=3D ERR_PTR(-EEXIST))
> =C2=A0 continue;
> =C2=A0
> @@ -3477,7 +3478,7 @@ static int direct_map(struct kvm_vcpu *vcpu, struct=
 kvm_page_fault *fault)
> =C2=A0 if (WARN_ON_ONCE(it.level !=3D fault->goal_level))
> =C2=A0 return -EFAULT;
> =C2=A0
> - ret =3D mmu_set_spte(vcpu, fault->slot, it.sptep, ACC_ALL,
> + ret =3D mmu_set_spte(vcpu, fault->slot, it.sptep, access,
> =C2=A0 =C2=A0=C2=A0 base_gfn, fault->pfn, fault);
> =C2=A0 if (ret =3D=3D RET_PF_SPURIOUS)
> =C2=A0 return ret;
> diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
> index 3429c1413f42..fa01719baf8d 100644
> --- a/arch/x86/kvm/mmu/mmutrace.h
> +++ b/arch/x86/kvm/mmu/mmutrace.h
> @@ -373,23 +373,25 @@ TRACE_EVENT(
> =C2=A0
> =C2=A0TRACE_EVENT(
> =C2=A0 kvm_mmu_spte_requested,
> - TP_PROTO(struct kvm_page_fault *fault),
> - TP_ARGS(fault),
> + TP_PROTO(struct kvm_page_fault *fault, u8 access),
> + TP_ARGS(fault, access),
> =C2=A0
> =C2=A0 TP_STRUCT__entry(
> =C2=A0 __field(u64, gfn)
> =C2=A0 __field(u64, pfn)
> =C2=A0 __field(u8, level)
> + __field(u8, access)
> =C2=A0 ),
> =C2=A0
> =C2=A0 TP_fast_assign(
> =C2=A0 __entry->gfn =3D fault->gfn;
> =C2=A0 __entry->pfn =3D fault->pfn | (fault->gfn & (KVM_PAGES_PER_HPAGE(f=
ault->goal_level) - 1));
> =C2=A0 __entry->level =3D fault->goal_level;
> + __entry->access =3D access;
> =C2=A0 ),
> =C2=A0
> - TP_printk("gfn %llx pfn %llx level %d",
> - =C2=A0 __entry->gfn, __entry->pfn, __entry->level
> + TP_printk("gfn %llx pfn %llx level %d access %x",
> + =C2=A0 __entry->gfn, __entry->pfn, __entry->level, __entry->access
> =C2=A0 )
> =C2=A0);
> =C2=A0
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmp=
l.h
> index f741f7d4cc2d..047400af924d 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -734,7 +734,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct=
 kvm_page_fault *fault,
> =C2=A0 */
> =C2=A0 kvm_mmu_hugepage_adjust(vcpu, fault);
> =C2=A0
> - trace_kvm_mmu_spte_requested(fault);
> + trace_kvm_mmu_spte_requested(fault, gw->pte_access);
> =C2=A0
> =C2=A0 for (; shadow_walk_okay(&it); shadow_walk_next(&it)) {
> =C2=A0 /*
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 7b1102d26f9c..5a2f8ce9a32b 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -1185,9 +1185,9 @@ static int tdp_mmu_map_handle_target_level(struct k=
vm_vcpu *vcpu,
> =C2=A0 }
> =C2=A0
> =C2=A0 if (unlikely(!fault->slot))
> - new_spte =3D make_mmio_spte(vcpu, iter->gfn, ACC_ALL);
> + new_spte =3D make_mmio_spte(vcpu, iter->gfn, sp->role.access);
> =C2=A0 else
> - wrprot =3D make_spte(vcpu, sp, fault->slot, ACC_ALL, iter->gfn,
> + wrprot =3D make_spte(vcpu, sp, fault->slot, sp->role.access, iter->gfn,
> =C2=A0 =C2=A0=C2=A0 fault->pfn, iter->old_spte, fault->prefetch,
> =C2=A0 =C2=A0=C2=A0 false, fault->map_writable, &new_spte);
> =C2=A0
> @@ -1272,7 +1272,7 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_page_fault *fault)
> =C2=A0
> =C2=A0 kvm_mmu_hugepage_adjust(vcpu, fault);
> =C2=A0
> - trace_kvm_mmu_spte_requested(fault);
> + trace_kvm_mmu_spte_requested(fault, root->role.access);
> =C2=A0
> =C2=A0 rcu_read_lock();
> =C2=A0

