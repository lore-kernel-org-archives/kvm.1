Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F99819D89E
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410204; cv=none; b=jt82JSrlxk97deDXu4H+1Xyf02jwXtKJVirSLdB0DVJ2GzilhNvkJpTrlh606kfj3QVChZdkvJ3HQK3GayNCACGGme9El0bWbOMCesqVFB8DD7yXLGwa7wVrgMQgpSG9hNryJ9SMwdGp2ZG/91xA47wUltEjElggtTVLsq1MSrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410204; c=relaxed/simple;
	bh=VthkjPPEMgpxvjrLeJnRCW9c80r5WDyl4IYjG2qnST8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r7udWpDWZlDExnM2C+vhkdPnEZwtyEFfhjYP/SnLnwjkEvthRerP9xxQFzlW3gR3ekXo18sSQpjlXUKCbCqOgAa8qpG9hfZnEpsOAGGaOYrweG00DprzLofQWy4X7KLW/A1R5iX9kBBsW9QhojUpMbUkeNs30RXwN02IXLx4CjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EaiADC4z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GGcP3N5D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EaiADC4z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGcP3N5D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sB12ARljuAqROnQzZeDBqn0WF0tn9T3ze0j5C6Rr+Do=;
	b=EaiADC4zSNmySoikQH6L+6CbkwZOns9y6fZPCdS8/SgqGWFYSz8VNGgkyHLuqcy9R4/NaE
	aAq3Uudiud73Z5zcf/0z2IYCQyU+AJtdRUbCRWdHw2V/0W7d3YNM/e73Yvnthdvq+kUpvn
	NFjZRXpEk9tVj7jIvtjw4cEv+GQ2o84=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-P9h1qWc1NP-hweOCWSvTxw-1; Tue, 02 Jun 2026 10:23:19 -0400
X-MC-Unique: P9h1qWc1NP-hweOCWSvTxw-1
X-Mimecast-MFC-AGG-ID: P9h1qWc1NP-hweOCWSvTxw_1780410199
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8cce2b4c290so100441316d6.3
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410199; x=1781014999; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sB12ARljuAqROnQzZeDBqn0WF0tn9T3ze0j5C6Rr+Do=;
        b=GGcP3N5D0FXx2o5YezOf0HKX56v54j+vxtmVQyxftdUwvIOHyvK79+FAR29FCuXaXH
         Kr9b0y/VL33cAqvyLyKywkdnPg3YPsxKZfq51LVuBdwl8POn08MLxZJoyRrU3aF/CJk2
         SfEEiNs1gJxLf1YRfzSeN4I+SrIR7/xIJzpntSMG9PrpXPyFd/INC2rcNzLiNRntQFrM
         nFV6SwZPMZbVWiyrXUa3BJ1zY7j4aOJiH5HR9HqHPpdQevKTUsuqQ50ZQKEeaTO9/kMl
         vscv5ttvtN1ndDJ3C0pWyeQJmpGZ4Hl/FuHZOlQMT+O9zOeI3R6tp/TcfECOtnN0ebj3
         dh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410199; x=1781014999;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sB12ARljuAqROnQzZeDBqn0WF0tn9T3ze0j5C6Rr+Do=;
        b=YNt6KNTqUZ1qfZh0o9kkwFWdu7SobTxu7g1n1nUTFHPcR6lXk5kaabPz7C6bqPoE0B
         Iau/RonAHItNxzmA2mUFoo3Xyq0j0djRye1YjGzmeCEqcHfkDObtJ8pX/cyP8MNirSpL
         QDJnWRaOLt76EQbZ7IL0a5aElzouM7QhhawUnjK6f8k2t83RM+8pKJQmoKLuI2lsca3Q
         utIn+qrk1rKZQo85gjpsON6ckhtPvJ/Q4a5jplYKFcApF+pbfJSAXbQQAVS/Qf5Guw3b
         rZX3diHWwLZEHoThvmYMt9SHHmZUDIJwTOYrgmwZMFCUrrOqxlK4gLOBUdVW+xCZii70
         c7Xw==
X-Forwarded-Encrypted: i=1; AFNElJ8IcMHKZSHfcgKOPEwXSFKrGN9zijM2rxvEweqOsvW2cnAOxxAU1ru2G2FAAmLk7UcpX6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT2c9WY+JCHjO7hluk5wh2zluUotKYwVimMGNBOFUKDZ2pEEQB
	rGqnev0c79DOC1+D4N4BMTCSLuuMzotqlll9VHXXsoTjP1xwbS/ImRLZdK45hROBafhdibHq9I9
	3XRQ7cFrJoR9Tve7z8KtTQa58u5RxTY+wU4a0hEAV60cKvQALunkd8A==
X-Gm-Gg: Acq92OH3WpQw9zi+dbMoiUOy3LPYS6XtnQ7TXLICTlHoIdrtN003dcRzKSjX29001SG
	UnuCRoKy/z0xgTXvqqGXFadjmJDeaP+oV5dIAHzB/LJZsPzVsbSpJZm6hDm0vN5m5muLjio5mnZ
	PY90qvUMqe4Q/dFF96bd1DZdOf7JyJGzVlnE4nTc//22wVph8gGq/RaAL0U3S56XSLISLHjUEM9
	yAbzn+8R94BKGp4Tw/igQ9ydRHiArUgXVl4pdl1kes2CdgcadZib3FaubBcBtuUUPe2CZN88BnV
	HdJ95tG/soiAvZw7uXa/13v9jIA+Kt0KVp8gKNFugh0g3ETVKxoTnsbZc0/zUAxMPnfzH/hpcbr
	/94DHdCI8BfjtLckFNltUgvOixvS3t7rfrwhQ0p8=
X-Received: by 2002:a05:6214:23cd:b0:8ac:bb62:fe52 with SMTP id 6a1803df08f44-8ccefd32da9mr246634546d6.4.1780410198777;
        Tue, 02 Jun 2026 07:23:18 -0700 (PDT)
X-Received: by 2002:a05:6214:23cd:b0:8ac:bb62:fe52 with SMTP id 6a1803df08f44-8ccefd32da9mr246633726d6.4.1780410198165;
        Tue, 02 Jun 2026 07:23:18 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea1cadd2sm123081546d6.24.2026.06.02.07.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:23:17 -0700 (PDT)
Message-ID: <053a7dd830c2e25264b54e3ea91301ee392c6e23.camel@redhat.com>
Subject: Re: [PATCH 09/28] KVM: x86/mmu: introduce ACC_READ_MASK
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:23:16 -0400
In-Reply-To: <20260505195226.563317-10-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-10-pbonzini@redhat.com>
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
> Read permissions so far were only needed for EPT, which does not need
> ACC_USER_MASK.=C2=A0 Therefore, for EPT page tables ACC_USER_MASK was rep=
urposed
> as a read permission bit.
>=20
> In order to implement nested MBEC, EPT will genuinely have four kinds of
> accesses, and there will be no room for such hacks; bite the bullet at
> last, enlarging ACC_ALL to four bits and permissions[] to 2^4 bits (u16).

Thanks for doing the sacred work of untangling this mess!

>=20
> The new code does not enforce that the XWR bits on non-execonly processor=
s
> have their R bit set, even when running nested: none of the shadow_*_mask
> values have bit 0 set, and make_spte() genuinely relies on ACC_READ_MASK
> being requested!=C2=A0 This works because, if execonly is not supported b=
y the
> processor, shadow EPT will generate an EPT misconfig vmexit if the XWR
> bits represent a non-readable page, and therefore the pte_access argument
> to make_spte() will also always have ACC_READ_MASK set.


For the reference, for the shadow EPT, this is the code that checks the abo=
ve case:
   FNAME(walk_addr_generic) -> FNAME(is_rsvd_bits_set) -> FNAME(is_bad_mt_x=
wr)

As a side note, maybe it's also worth mentioning that KVM itself will never=
 create execute-only SPTEs
(at least for now), for it's direct MMU.


>=20
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/include/asm/kvm_host.h | 12 ++++-----
> =C2=A0arch/x86/kvm/mmu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0arch/x86/kvm/mmu/mmu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 45 ++++++++++++++++++++-------------
> =C2=A0arch/x86/kvm/mmu/mmutrace.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
> =C2=A0arch/x86/kvm/mmu/paging_tmpl.h=C2=A0 | 35 +++++++++++++++----------
> =C2=A0arch/x86/kvm/mmu/spte.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 18 +++++--------
> =C2=A0arch/x86/kvm/mmu/spte.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 5 ++--
> =C2=A0arch/x86/kvm/vmx/capabilities.h |=C2=A0 5 ----
> =C2=A0arch/x86/kvm/vmx/common.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 5 +---
> =C2=A0arch/x86/kvm/vmx/vmx.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 3 +--
> =C2=A010 files changed, 69 insertions(+), 64 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index c470e40a00aa..8f2a1b915df9 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -328,11 +328,11 @@ struct kvm_kernel_irq_routing_entry;
> =C2=A0 * the number of unique SPs that can theoretically be created is 2^=
n, where n
> =C2=A0 * is the number of bits that are used to compute the role.
> =C2=A0 *
> - * But, even though there are 20 bits in the mask below, not all combina=
tions
> + * But, even though there are 21 bits in the mask below, not all combina=
tions
> =C2=A0 * of modes and flags are possible:
> =C2=A0 *
> =C2=A0 *=C2=A0=C2=A0 - invalid shadow pages are not accounted, mirror pag=
es are not shadowed,
> - *=C2=A0=C2=A0=C2=A0=C2=A0 so the bits are effectively 18.
> + *=C2=A0=C2=A0=C2=A0=C2=A0 so the bits are effectively 19.
> =C2=A0 *
> =C2=A0 *=C2=A0=C2=A0 - quadrant will only be used if has_4_byte_gpte=3D1 =
(non-PAE paging);
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 execonly and ad_disabled are only used f=
or nested EPT which has
> @@ -347,7 +347,7 @@ struct kvm_kernel_irq_routing_entry;
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 cr0_wp=3D0, therefore these three bits o=
nly give rise to 5 possibilities.
> =C2=A0 *
> =C2=A0 * Therefore, the maximum number of possible upper-level shadow pag=
es for a
> - * single gfn is a bit less than 2^13.
> + * single gfn is a bit less than 2^14.
> =C2=A0 */
> =C2=A0union kvm_mmu_page_role {
> =C2=A0 u32 word;
> @@ -356,7 +356,7 @@ union kvm_mmu_page_role {
> =C2=A0 unsigned has_4_byte_gpte:1;
> =C2=A0 unsigned quadrant:2;
> =C2=A0 unsigned direct:1;
> - unsigned access:3;
> + unsigned access:4;
> =C2=A0 unsigned invalid:1;
> =C2=A0 unsigned efer_nx:1;
> =C2=A0 unsigned cr0_wp:1;
> @@ -366,7 +366,7 @@ union kvm_mmu_page_role {
> =C2=A0 unsigned guest_mode:1;
> =C2=A0 unsigned passthrough:1;
> =C2=A0 unsigned is_mirror:1;
> - unsigned :4;
> + unsigned:3;
> =C2=A0
> =C2=A0 /*
> =C2=A0 * This is left at the top of the word so that
> @@ -492,7 +492,7 @@ struct kvm_mmu {
> =C2=A0 * Byte index: page fault error code [4:1]
> =C2=A0 * Bit index: pte permissions in ACC_* format
> =C2=A0 */
> - u8 permissions[16];
> + u16 permissions[16];
> =C2=A0
> =C2=A0 u64 *pae_root;
> =C2=A0 u64 *pml4_root;
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 830f46145692..23f37535c0ce 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -81,7 +81,7 @@ u8 kvm_mmu_get_max_tdp_level(void);
> =C2=A0void kvm_mmu_set_mmio_spte_mask(u64 mmio_value, u64 mmio_mask, u64 =
access_mask);
> =C2=A0void kvm_mmu_set_mmio_spte_value(struct kvm *kvm, u64 mmio_value);
> =C2=A0void kvm_mmu_set_me_spte_mask(u64 me_value, u64 me_mask);
> -void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_exec_only);
> +void kvm_mmu_set_ept_masks(bool has_ad_bits);
> =C2=A0
> =C2=A0void kvm_init_mmu(struct kvm_vcpu *vcpu);
> =C2=A0void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long c=
r0,
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index fc34536c536b..fa6a5e4ee09a 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2033,7 +2033,7 @@ static bool kvm_sync_page_check(struct kvm_vcpu *vc=
pu, struct kvm_mmu_page *sp)
> =C2=A0 */
> =C2=A0 const union kvm_mmu_page_role sync_role_ign =3D {
> =C2=A0 .level =3D 0xf,
> - .access =3D 0x7,
> + .access =3D ACC_ALL,
> =C2=A0 .quadrant =3D 0x3,
> =C2=A0 .passthrough =3D 0x1,
> =C2=A0 };
> @@ -5539,7 +5539,7 @@ reset_ept_shadow_zero_bits_mask(struct kvm_mmu *con=
text, bool execonly)
> =C2=A0 * update_permission_bitmask() builds what is effectively a
> =C2=A0 * two-dimensional array of bools.=C2=A0 The second dimension is
> =C2=A0 * provided by individual bits of permissions[pfec >> 1], and
> - * logical &, | and ~ operations operate on all the 8 possible
> + * logical &, | and ~ operations operate on all the 16 possible
> =C2=A0 * combinations of ACC_* bits.
> =C2=A0 */
> =C2=A0#define ACC_BITS_MASK(access) \
> @@ -5549,15 +5549,23 @@ reset_ept_shadow_zero_bits_mask(struct kvm_mmu *c=
ontext, bool execonly)
> =C2=A0 (4 & (access) ? 1 << 4 : 0) | \
> =C2=A0 (5 & (access) ? 1 << 5 : 0) | \
> =C2=A0 (6 & (access) ? 1 << 6 : 0) | \
> - (7 & (access) ? 1 << 7 : 0))
> + (7 & (access) ? 1 << 7 : 0) | \
> + (8 & (access) ? 1 << 8 : 0) | \
> + (9 & (access) ? 1 << 9 : 0) | \
> + (10 & (access) ? 1 << 10 : 0) | \
> + (11 & (access) ? 1 << 11 : 0) | \
> + (12 & (access) ? 1 << 12 : 0) | \
> + (13 & (access) ? 1 << 13 : 0) | \
> + (14 & (access) ? 1 << 14 : 0) | \
> + (15 & (access) ? 1 << 15 : 0))
> =C2=A0
> =C2=A0static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept=
)
> =C2=A0{
> =C2=A0 unsigned index;
> =C2=A0
> - const u8 x =3D ACC_BITS_MASK(ACC_EXEC_MASK);
> - const u8 w =3D ACC_BITS_MASK(ACC_WRITE_MASK);
> - const u8 u =3D ACC_BITS_MASK(ACC_USER_MASK);
> + const u16 x =3D ACC_BITS_MASK(ACC_EXEC_MASK);
> + const u16 w =3D ACC_BITS_MASK(ACC_WRITE_MASK);
> + const u16 r =3D ACC_BITS_MASK(ACC_READ_MASK);
> =C2=A0
> =C2=A0 bool cr4_smep =3D is_cr4_smep(mmu);
> =C2=A0 bool cr4_smap =3D is_cr4_smap(mmu);
> @@ -5580,32 +5588,33 @@ static void update_permission_bitmask(struct kvm_=
mmu *mmu, bool ept)
> =C2=A0 unsigned pfec =3D index << 1;
> =C2=A0
> =C2=A0 /*
> - * Each "*f" variable has a 1 bit for each UWX value
> + * Each "*f" variable has a 1 bit for each ACC_* combo
> =C2=A0 * that causes a fault with the given PFEC.
> =C2=A0 */
> =C2=A0
> =C2=A0 /* Faults from reads to non-readable pages */
> - u8 rf =3D 0;
> + u16 rf =3D (pfec & (PFERR_WRITE_MASK|PFERR_FETCH_MASK)) ? 0 : (u16)~r;
> =C2=A0 /* Faults from writes to non-writable pages */
> - u8 wf =3D (pfec & PFERR_WRITE_MASK) ? (u8)~w : 0;
> + u16 wf =3D (pfec & PFERR_WRITE_MASK) ? (u16)~w : 0;
> =C2=A0 /* Faults from user mode accesses to supervisor pages */
> - u8 uf =3D 0;
> + u16 uf =3D 0;
> =C2=A0 /* Faults from fetches of non-executable pages */
> - u8 ff =3D 0;
> + u16 ff =3D 0;
> =C2=A0 /* Faults from kernel mode accesses of user pages */
> - u8 smapf =3D 0;
> + u16 smapf =3D 0;
> =C2=A0
> =C2=A0 if (ept) {
> - rf =3D (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
> - ff =3D (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;
> + ff =3D (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
> =C2=A0 } else {
> - /* Faults from kernel mode accesses to user pages */
> - u8 kf =3D (pfec & PFERR_USER_MASK) ? 0 : u;
> + const u16 u =3D ACC_BITS_MASK(ACC_USER_MASK);
> =C2=A0
> - uf =3D (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
> + /* Faults from kernel mode accesses to user pages */
> + u16 kf =3D (pfec & PFERR_USER_MASK) ? 0 : u;
> +
> + uf =3D (pfec & PFERR_USER_MASK) ? (u16)~u : 0;
> =C2=A0
> =C2=A0 if (efer_nx)
> - ff =3D (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;
> + ff =3D (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
> =C2=A0
> =C2=A0 /* Allow supervisor writes if !cr0.wp */
> =C2=A0 if (!cr0_wp)
> diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
> index 764e3015d021..dcfdfedfc4e9 100644
> --- a/arch/x86/kvm/mmu/mmutrace.h
> +++ b/arch/x86/kvm/mmu/mmutrace.h
> @@ -25,7 +25,8 @@
> =C2=A0#define KVM_MMU_PAGE_PRINTK() ({ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
> =C2=A0 const char *saved_ptr =3D trace_seq_buffer_ptr(p); \
> =C2=A0 static const char *access_str[] =3D { =C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
> - "---", "--x", "w--", "w-x", "-u-", "-ux", "wu-", "wux"=C2=A0 \
> + "----", "r---", "-w--", "rw--", "--u-", "r-u-", "-wu-", "rwu-", \
> + "---x", "r--x", "-w-x", "rw-x", "--ux", "r-ux", "-wux", "rwux" \
> =C2=A0 }; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0 union kvm_mmu_page_role role; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmp=
l.h
> index 901cd2bd40b8..fb1b5d8b23e5 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -170,25 +170,24 @@ static bool FNAME(prefetch_invalid_gpte)(struct kvm=
_vcpu *vcpu,
> =C2=A0 return true;
> =C2=A0}
> =C2=A0
> -/*
> - * For PTTYPE_EPT, a page table can be executable but not readable
> - * on supported processors. Therefore, set_spte does not automatically
> - * set bit 0 if execute only is supported. Here, we repurpose ACC_USER_M=
ASK
> - * to signify readability since it isn't used in the EPT case
> - */
> =C2=A0static inline unsigned FNAME(gpte_access)(u64 gpte)
> =C2=A0{
> =C2=A0 unsigned access;
> =C2=A0#if PTTYPE =3D=3D PTTYPE_EPT
> =C2=A0 access =3D ((gpte & VMX_EPT_WRITABLE_MASK) ? ACC_WRITE_MASK : 0) |
> =C2=A0 ((gpte & VMX_EPT_EXECUTABLE_MASK) ? ACC_EXEC_MASK : 0) |
> - ((gpte & VMX_EPT_READABLE_MASK) ? ACC_USER_MASK : 0);
> + ((gpte & VMX_EPT_READABLE_MASK) ? ACC_READ_MASK : 0);
> =C2=A0#else
> - BUILD_BUG_ON(ACC_EXEC_MASK !=3D PT_PRESENT_MASK);
> - BUILD_BUG_ON(ACC_EXEC_MASK !=3D 1);
> + /*
> + * P is set here, so the page is always readable and W/U/!NX represent
> + * allowed accesses.

This comment can be a bit misleading (this is a pre-exisiting problem)
P isn't set here - but rather the gpte_access is only called on PTEs=C2=A0
which have the P bit set.
Do you think that it is worth it to mention this explicitly?


> + */
> + BUILD_BUG_ON(ACC_READ_MASK !=3D PT_PRESENT_MASK);
> + BUILD_BUG_ON(ACC_WRITE_MASK !=3D PT_WRITABLE_MASK);
> + BUILD_BUG_ON(ACC_USER_MASK !=3D PT_USER_MASK);
> + BUILD_BUG_ON(ACC_EXEC_MASK & (PT_WRITABLE_MASK | PT_USER_MASK | PT_PRES=
ENT_MASK));
> =C2=A0 access =3D gpte & (PT_WRITABLE_MASK | PT_USER_MASK | PT_PRESENT_MA=
SK);


> - /* Combine NX with P (which is set here) to get ACC_EXEC_MASK.=C2=A0 */
> - access ^=3D (gpte >> PT64_NX_SHIFT);
> + access |=3D gpte & PT64_NX_MASK ? 0 : ACC_EXEC_MASK;
The new code is much more readable, thanks!

> =C2=A0#endif
> =C2=A0
> =C2=A0 return access;
> @@ -501,10 +500,18 @@ static int FNAME(walk_addr_generic)(struct guest_wa=
lker *walker,
> =C2=A0
> =C2=A0 if (write_fault)
> =C2=A0 walker->fault.exit_qualification |=3D EPT_VIOLATION_ACC_WRITE;
> - if (user_fault)
> - walker->fault.exit_qualification |=3D EPT_VIOLATION_ACC_READ;
> - if (fetch_fault)
> + else if (fetch_fault)
> =C2=A0 walker->fault.exit_qualification |=3D EPT_VIOLATION_ACC_INSTR;
> + else
> + walker->fault.exit_qualification |=3D EPT_VIOLATION_ACC_READ;
> +




> + /*
> + * Accesses to guest paging structures are either "reads" or
> + * "read+write" accesses, so consider them the latter if write_fault
> + * is true.
> + */
> + if (access & PFERR_GUEST_PAGE_MASK)
> + walker->fault.exit_qualification |=3D EPT_VIOLATION_ACC_READ;


The above needs a bit of clarification:

Unlike the good old x86/NPT case, EPT can report an access as read, write o=
r read+write.

Other than accesses to guest paging entries with EPT A/D enabled, where the=
 PRM explicitly states that access=C2=A0
is reported as read+write (regardless of whether the A/D bits were actually=
 set, by the way),=C2=A0
what about other accesses?

Can the cpu report read+write? Can the CPU report write-only as a function =
of the instruction that was executed?

Since our PFERR_ is based on good old x86 error code, we are losing this in=
formation, and the above code can
be seen as a partial workaround (although the problem itself is pre-existin=
g).

If you want to keep the logic as it is though,=C2=A0
what do you think about placing this code inside the if block, something li=
ke this?
This would be purely for documentation purposes.


 if (write_fault) {

        walker->fault.exit_qualification |=3D EPT_VIOLATION_ACC_WRITE;

 	/*
 	 * When EPT A/D is enabled, an EPT access to the guest paging tables is r=
eported as both read and write.
	 * KVM currently loses this bit of information when converting=C2=A0
         * the EPT violation qualification code to PFERR_* code,
	 * therefore add the EPT_VIOLATION_ACC_READ manually.
 	 */

	if (access & PFERR_GUEST_PAGE_MASK)
 		walker->fault.exit_qualification |=3D EPT_VIOLATION_ACC_READ;

 } else if (fetch_fault) {
        walker->fault.exit_qualification |=3D EPT_VIOLATION_ACC_INSTR;
 } else {
        walker->fault.exit_qualification |=3D EPT_VIOLATION_ACC_READ;
  }


> =C2=A0
> =C2=A0 /*
> =C2=A0 * Note, pte_access holds the raw RWX bits from the EPTE, not
> diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
> index 849a1c1c92b5..1b7fb508098b 100644
> --- a/arch/x86/kvm/mmu/spte.c
> +++ b/arch/x86/kvm/mmu/spte.c
> @@ -194,12 +194,6 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu=
_page *sp,
> =C2=A0 int is_host_mmio =3D -1;
> =C2=A0 bool wrprot =3D false;
> =C2=A0
> - /*
> - * For the EPT case, shadow_present_mask has no RWX bits set if
> - * exec-only page table entries are supported.=C2=A0 In that case,
> - * ACC_USER_MASK and shadow_user_mask are used to represent
> - * read access.=C2=A0 See FNAME(gpte_access) in paging_tmpl.h.
> - */
> =C2=A0 WARN_ON_ONCE((pte_access | shadow_present_mask) =3D=3D SHADOW_NONP=
RESENT_VALUE);
> =C2=A0
> =C2=A0 if (sp->role.ad_disabled)
> @@ -228,6 +222,9 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_=
page *sp,
> =C2=A0 pte_access &=3D ~ACC_EXEC_MASK;
> =C2=A0 }
> =C2=A0
> + if (pte_access & ACC_READ_MASK)
> + spte |=3D PT_PRESENT_MASK; /* or VMX_EPT_READABLE_MASK */
> +
> =C2=A0 if (pte_access & ACC_EXEC_MASK)
> =C2=A0 spte |=3D shadow_x_mask;
> =C2=A0 else
> @@ -391,6 +388,7 @@ u64 make_nonleaf_spte(u64 *child_pt, bool ad_disabled=
)
> =C2=A0 u64 spte =3D SPTE_MMU_PRESENT_MASK;
> =C2=A0
> =C2=A0 spte |=3D __pa(child_pt) | shadow_present_mask | PT_WRITABLE_MASK =
|
> + PT_PRESENT_MASK /* or VMX_EPT_READABLE_MASK */ |
> =C2=A0 shadow_user_mask | shadow_x_mask | shadow_me_value;
> =C2=A0
> =C2=A0 if (ad_disabled)
> @@ -491,18 +489,16 @@ void kvm_mmu_set_me_spte_mask(u64 me_value, u64 me_=
mask)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_set_me_spte_mask);
> =C2=A0
> -void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_exec_only)
> +void kvm_mmu_set_ept_masks(bool has_ad_bits)
> =C2=A0{
> =C2=A0 kvm_ad_enabled =3D has_ad_bits;
> =C2=A0
> - shadow_user_mask =3D VMX_EPT_READABLE_MASK;
> + shadow_user_mask =3D 0;
> =C2=A0 shadow_accessed_mask =3D VMX_EPT_ACCESS_BIT;
> =C2=A0 shadow_dirty_mask =3D VMX_EPT_DIRTY_BIT;
> =C2=A0 shadow_nx_mask =3D 0ull;
> =C2=A0 shadow_x_mask =3D VMX_EPT_EXECUTABLE_MASK;
> - /* VMX_EPT_SUPPRESS_VE_BIT is needed for W or X violation. */
> - shadow_present_mask =3D
> - (has_exec_only ? 0ull : VMX_EPT_READABLE_MASK) | VMX_EPT_SUPPRESS_VE_BI=
T;
> + shadow_present_mask =3D VMX_EPT_SUPPRESS_VE_BIT;
> =C2=A0
> =C2=A0 shadow_acc_track_mask =3D VMX_EPT_RWX_MASK;
> =C2=A0 shadow_host_writable_mask =3D EPT_SPTE_HOST_WRITABLE;
> diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
> index bc02a2e89a31..121bfb2217e8 100644
> --- a/arch/x86/kvm/mmu/spte.h
> +++ b/arch/x86/kvm/mmu/spte.h
> @@ -52,10 +52,11 @@ static_assert(SPTE_TDP_AD_ENABLED =3D=3D 0);
> =C2=A0#define SPTE_BASE_ADDR_MASK (((1ULL << 52) - 1) & ~(u64)(PAGE_SIZE-=
1))
> =C2=A0#endif
> =C2=A0
> -#define ACC_EXEC_MASK=C2=A0=C2=A0=C2=A0 1
> +#define ACC_READ_MASK=C2=A0=C2=A0=C2=A0 PT_PRESENT_MASK
> =C2=A0#define ACC_WRITE_MASK=C2=A0=C2=A0 PT_WRITABLE_MASK
> =C2=A0#define ACC_USER_MASK=C2=A0=C2=A0=C2=A0 PT_USER_MASK
> -#define ACC_ALL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (A=
CC_EXEC_MASK | ACC_WRITE_MASK | ACC_USER_MASK)
> +#define ACC_EXEC_MASK=C2=A0=C2=A0=C2=A0 8
> +#define ACC_ALL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (A=
CC_EXEC_MASK | ACC_WRITE_MASK | ACC_USER_MASK | ACC_READ_MASK)
> =C2=A0
> =C2=A0#define SPTE_LEVEL_BITS 9
> =C2=A0#define SPTE_LEVEL_SHIFT(level) __PT_LEVEL_SHIFT(level, SPTE_LEVEL_=
BITS)
> diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilit=
ies.h
> index 56cacc06225e..7e59eb0f41bb 100644
> --- a/arch/x86/kvm/vmx/capabilities.h
> +++ b/arch/x86/kvm/vmx/capabilities.h
> @@ -300,11 +300,6 @@ static inline bool cpu_has_vmx_flexpriority(void)
> =C2=A0 cpu_has_vmx_virtualize_apic_accesses();
> =C2=A0}
> =C2=A0
> -static inline bool cpu_has_vmx_ept_execute_only(void)
> -{
> - return vmx_capability.ept & VMX_EPT_EXECUTE_ONLY_BIT;
> -}
> -
> =C2=A0static inline bool cpu_has_vmx_ept_4levels(void)
> =C2=A0{
> =C2=A0 return vmx_capability.ept & VMX_EPT_PAGE_WALK_4_BIT;
> diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
> index adf925500b9e..1afbf272efae 100644
> --- a/arch/x86/kvm/vmx/common.h
> +++ b/arch/x86/kvm/vmx/common.h
> @@ -85,11 +85,8 @@ static inline int __vmx_handle_ept_violation(struct kv=
m_vcpu *vcpu, gpa_t gpa,
> =C2=A0{
> =C2=A0 u64 error_code;
> =C2=A0
> - /* Is it a read fault? */
> - error_code =3D (exit_qualification & EPT_VIOLATION_ACC_READ)
> - =C2=A0=C2=A0=C2=A0=C2=A0 ? PFERR_USER_MASK : 0;
> =C2=A0 /* Is it a write fault? */
> - error_code |=3D (exit_qualification & EPT_VIOLATION_ACC_WRITE)
> + error_code =3D (exit_qualification & EPT_VIOLATION_ACC_WRITE)
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? PFERR_WRITE_MASK : 0;
> =C2=A0 /* Is it a fetch fault? */
> =C2=A0 error_code |=3D (exit_qualification & EPT_VIOLATION_ACC_INSTR)
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index a29896a9ef14..337bbfecc021 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -8683,8 +8683,7 @@ __init int vmx_hardware_setup(void)
> =C2=A0 set_bit(0, vmx_vpid_bitmap); /* 0 is reserved for host */
> =C2=A0
> =C2=A0 if (enable_ept)
> - kvm_mmu_set_ept_masks(enable_ept_ad_bits,
> - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_has_vmx_ept_execute_only());
> + kvm_mmu_set_ept_masks(enable_ept_ad_bits);
> =C2=A0 else
> =C2=A0 vt_x86_ops.get_mt_mask =3D NULL;
> =C2=A0

Thanks again for simplifying the code with this patch!

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>


Best regards,
	Maxim Levitsky



