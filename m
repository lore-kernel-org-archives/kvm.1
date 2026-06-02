Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89DE13D886
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410043; cv=none; b=Pw/1NzIg59GW74nYRneM6EH059qiVRiWMWK1eiylQwlrSttLOTYvQQqt6X9dH0/XvnxXfPyfY36O1HROkA5iQADqiTt7QcPI1q7Uxvv2ZCKir16ymFkMtqEgqY1RowgP3bdVFkEsxvczbZBEY3fnJt7xntZFMYhByKLMJx+sdaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410043; c=relaxed/simple;
	bh=qyp+BHEiGdpj8bT8vwJLmz2RR21leDzgEIi7JxJcBRo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I/EnlH7PUt4mYhXnNFjI7W9JpU2X7GgfDYUCwxbGP9Hb/cOkZonD6dcXI3Rmpu4KOhduQ/t5/rXDg/zlbWnH3WaQgiLrIJAAXDQhGqmzA2IyI6q/1eODigVoiNWG4XlooBpYP6WjYTR7DMVwB97hYXsvCuoOeG0h3A6I1UFcvlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TqhogPOK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOxa6USI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqhogPOK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOxa6USI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEgO+xwxmJaZFysSSP5XF/rWfCHIcxTdKIYUfYW3Z7g=;
	b=TqhogPOK6zToBC1cU1rqF5uCS1txEAXAtQkYdUPxmwz7f8Be8VkHRbeGzVJJ6BplceUHrl
	HWVQgC0TbO/TWXK2Nh8dnv5g3NRVlQTST+780mLmRiHEQzo8xh9+n8Zo/RJO0dh9ZKjHE3
	BQIXD9TKomR4VRH8tUDcL2mzYh7BS1U=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-kfuZLnBqN32dPOI6EG5J9g-1; Tue, 02 Jun 2026 10:20:39 -0400
X-MC-Unique: kfuZLnBqN32dPOI6EG5J9g-1
X-Mimecast-MFC-AGG-ID: kfuZLnBqN32dPOI6EG5J9g_1780410039
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8cced2dabc1so95076566d6.0
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410039; x=1781014839; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cEgO+xwxmJaZFysSSP5XF/rWfCHIcxTdKIYUfYW3Z7g=;
        b=YOxa6USItfUq9WQM06v54+wNNsXAkgUyxGR/ca7tepylwf+000tRZB8JYDddRDKqgQ
         ofQDs2borlv9w3sFF/rySiFKP6HXjvpizevpcX4a/JqpI1MR1DudUNrh1yV+1IKOm5FH
         yofaXZUucxJD1h897TFkFTFQS9/R8T8JERosEbhWkf6ajjqHuf2SiHxsX0M215eaeHEa
         Hbp2pmmaKYWK26K1+j4Ucm8CoYLUtItjAfnD5+9NOLYFj0iDKMEuG4OvGRPuTFzRk8fl
         kqoAfIk4NDL0o0WkZejs06/oihZpTl/oLYLAzGCDuvf5Pm2nAcaPhPcrNf/rcyajCrL9
         ww1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410039; x=1781014839;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEgO+xwxmJaZFysSSP5XF/rWfCHIcxTdKIYUfYW3Z7g=;
        b=J6B5geDjluJcLRSeP4kt5RE0YJyy+uv6MSOguAww91/Tch8CR29gC24NqkGTai2pUR
         qoI7uKcYMuLpeipzDh3ZL4LxH5swgwfZNj+ickkJveceJgMzEHH02/+i2oenRRUpEQF9
         qGfYRXyPbJy9CN7VIeW0eliS3Pc0Cnwud39462V115VI+qN4G8ac62CzecyTDRsdpa2P
         YYRcZtfBsOg0EM4+Qljt8BTQQzoj7UfByoPmWuzVcsLrTPMxka4WGHcWGk3jBznmB8MR
         A0CqANY1qSudH8nur3PGBMWs07Xh85U34PuDR6/JSqVJxahTWHLZwLgvIlLUB/aTVWwV
         fxqA==
X-Forwarded-Encrypted: i=1; AFNElJ+Q92CKJfkyDBsFBSvNM42774Mc4uFnU+zYqbwXSPEnGb7bzK7Z0eAnfBjdYcABHuXenIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRum2+K9XysvS9iUSEGnWzwz8b9ZBBzXy6BEKKflKbb/aEFHVt
	i7XkwWcq9Ki1cHIIF/E5krCcDcBIpxe90XEKOI7mVz3F63iMQoOMLkEAtUsRHfnrIQoeZmwaiFL
	Y5rO6LIMYM0mJ1FWJfR44fUQUO91cIQSSNJf6WCq2FNF89qMzjAYKvw==
X-Gm-Gg: Acq92OGkE9CUgAFCp2iU4L5KpPKlo7oJkWh1+oLMo+j5NUbL75/FOAJUFV2DhYx4+QP
	gYsOu1jaDwsrjtPzhASWNYq9Zd2u5uoeRiSC94FytclWt+05ArgwtzAfOiG+EdQpZNf818WI2ao
	GYoTNxGXLFlpy3B8N2nnDpRv0h23gIPqnUqMYhG8rFlhbZqYV1vlqGUkQSrTQ8Ukj4nwBUUrTxe
	nAwlwRJhQ1LysrggNgUQsQXnD/tMfIBzXkpjhomExFEdOh3F0eVfyQh0otseFmydgrnJJrhiXVB
	SSy/0+g1oflRd4D0ocT32YHcB9T3o/ZmA9sCetFrCs/O1ld+CBYhEisw4jiFgdAQlOOEaSg6jd9
	M0EjiXe8BCmnA6nQByFLkMJaxMLZLZIDK6TMB/yQ=
X-Received: by 2002:a05:6214:250b:b0:8ce:b018:89f4 with SMTP id 6a1803df08f44-8ceb0188bf0mr118475646d6.37.1780410038608;
        Tue, 02 Jun 2026 07:20:38 -0700 (PDT)
X-Received: by 2002:a05:6214:250b:b0:8ce:b018:89f4 with SMTP id 6a1803df08f44-8ceb0188bf0mr118475146d6.37.1780410038158;
        Tue, 02 Jun 2026 07:20:38 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea272fdfsm119654156d6.49.2026.06.02.07.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:20:37 -0700 (PDT)
Message-ID: <1e5cb897b978666bde558083d8097a101324ec86.camel@redhat.com>
Subject: Re: [PATCH 03/28] KVM: x86/mmu: free up bit 10 of PTEs in
 preparation for MBEC
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com, Kai Huang <kai.huang@intel.com>
Date: Tue, 02 Jun 2026 10:20:36 -0400
In-Reply-To: <20260505195226.563317-4-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-4-pbonzini@redhat.com>
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
> Update SPTE_MMIO_ALLOWED_MASK to allow EPT user executable (bit 10) to
> be treated like EPT RWX bit2:0, as when mode-based execute control is
> enabled, bit 10 can act like a "present" bit.=C2=A0 Likewise do not inclu=
de
> it in FROZEN_SPTE.
>=20
> No functional changes intended, other than the reduction of the maximum
> MMIO generation that is stored in page tables.
>=20
> Cc: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> Message-ID: <20251223054806.1611168-4-jon@nutanix.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/include/asm/vmx.h |=C2=A0 2 ++
> =C2=A0arch/x86/kvm/mmu/spte.h=C2=A0=C2=A0=C2=A0 | 20 +++++++++++---------
> =C2=A02 files changed, 13 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index b2291a766e3f..2b30b921b375 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -560,10 +560,12 @@ enum vmcs_field {
> =C2=A0#define VMX_EPT_ACCESS_BIT (1ull << 8)
> =C2=A0#define VMX_EPT_DIRTY_BIT (1ull << 9)
> =C2=A0#define VMX_EPT_SUPPRESS_VE_BIT (1ull << 63)
> +
> =C2=A0#define VMX_EPT_RWX_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (VMX_EPT_READABLE_MASK |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
> =C2=A0 VMX_EPT_WRITABLE_MASK |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0 VMX_EPT_EXECUTABLE_MASK)
> =C2=A0#define VMX_EPT_MT_MASK (7ull << VMX_EPT_MT_EPTE_SHIFT)
> +#define VMX_EPT_USER_EXECUTABLE_MASK (1ull << 10)
> =C2=A0
> =C2=A0static inline u8 vmx_eptp_page_walk_level(u64 eptp)
> =C2=A0{
> diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
> index 28086fa86fe0..4283cea3e66c 100644
> --- a/arch/x86/kvm/mmu/spte.h
> +++ b/arch/x86/kvm/mmu/spte.h
> @@ -96,11 +96,11 @@ static_assert(!(EPT_SPTE_MMU_WRITABLE & SHADOW_ACC_TR=
ACK_SAVED_MASK));
> =C2=A0#undef SHADOW_ACC_TRACK_SAVED_MASK
> =C2=A0
> =C2=A0/*
> - * Due to limited space in PTEs, the MMIO generation is a 19 bit subset =
of
> + * Due to limited space in PTEs, the MMIO generation is an 18 bit subset=
 of
> =C2=A0 * the memslots generation and is derived as follows:
> =C2=A0 *
> - * Bits 0-7 of the MMIO generation are propagated to spte bits 3-10
> - * Bits 8-18 of the MMIO generation are propagated to spte bits 52-62
> + * Bits 0-6 of the MMIO generation are propagated to spte bits 3-9
> + * Bits 7-17 of the MMIO generation are propagated to spte bits 52-62
> =C2=A0 *
> =C2=A0 * The KVM_MEMSLOT_GEN_UPDATE_IN_PROGRESS flag is intentionally not=
 included in
> =C2=A0 * the MMIO generation number, as doing so would require stealing a=
 bit from
> @@ -111,7 +111,7 @@ static_assert(!(EPT_SPTE_MMU_WRITABLE & SHADOW_ACC_TR=
ACK_SAVED_MASK));
> =C2=A0 */
> =C2=A0
> =C2=A0#define MMIO_SPTE_GEN_LOW_START 3
> -#define MMIO_SPTE_GEN_LOW_END 10
> +#define MMIO_SPTE_GEN_LOW_END 9
> =C2=A0
> =C2=A0#define MMIO_SPTE_GEN_HIGH_START 52
> =C2=A0#define MMIO_SPTE_GEN_HIGH_END 62
> @@ -133,7 +133,8 @@ static_assert(!(SPTE_MMU_PRESENT_MASK &
> =C2=A0 * and so they're off-limits for generation; additional checks ensu=
re the mask
> =C2=A0 * doesn't overlap legal PA bits), and bit 63 (carved out for futur=
e usage).
> =C2=A0 */
> -#define SPTE_MMIO_ALLOWED_MASK (BIT_ULL(63) | GENMASK_ULL(51, 12) | GENM=
ASK_ULL(2, 0))
> +#define SPTE_MMIO_ALLOWED_MASK (BIT_ULL(63) | GENMASK_ULL(51, 12) | \
> + BIT_ULL(10) | GENMASK_ULL(2, 0))
> =C2=A0static_assert(!(SPTE_MMIO_ALLOWED_MASK &
> =C2=A0 (SPTE_MMU_PRESENT_MASK | MMIO_SPTE_GEN_LOW_MASK | MMIO_SPTE_GEN_HI=
GH_MASK)));
> =C2=A0
> @@ -141,7 +142,7 @@ static_assert(!(SPTE_MMIO_ALLOWED_MASK &
> =C2=A0#define MMIO_SPTE_GEN_HIGH_BITS (MMIO_SPTE_GEN_HIGH_END - MMIO_SPTE=
_GEN_HIGH_START + 1)
> =C2=A0
> =C2=A0/* remember to adjust the comment above as well if you change these=
 */
> -static_assert(MMIO_SPTE_GEN_LOW_BITS =3D=3D 8 && MMIO_SPTE_GEN_HIGH_BITS=
 =3D=3D 11);
> +static_assert(MMIO_SPTE_GEN_LOW_BITS =3D=3D 7 && MMIO_SPTE_GEN_HIGH_BITS=
 =3D=3D 11);
> =C2=A0
> =C2=A0#define MMIO_SPTE_GEN_LOW_SHIFT (MMIO_SPTE_GEN_LOW_START - 0)
> =C2=A0#define MMIO_SPTE_GEN_HIGH_SHIFT (MMIO_SPTE_GEN_HIGH_START - MMIO_S=
PTE_GEN_LOW_BITS)
> @@ -217,10 +218,11 @@ extern u64 __read_mostly shadow_nonpresent_or_rsvd_=
mask;
> =C2=A0 *
> =C2=A0 * Only used by the TDP MMU.
> =C2=A0 */
> -#define FROZEN_SPTE (SHADOW_NONPRESENT_VALUE | 0x5a0ULL)
> +#define FROZEN_SPTE (SHADOW_NONPRESENT_VALUE | 0x1a0ULL)
> =C2=A0
> -/* Frozen SPTEs must not be misconstrued as shadow present PTEs. */
> -static_assert(!(FROZEN_SPTE & SPTE_MMU_PRESENT_MASK));
> +/* Frozen SPTEs must not be misconstrued as shadow or MMU present PTEs. =
*/
> +static_assert(!(FROZEN_SPTE & (SPTE_MMU_PRESENT_MASK |
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMX_EPT_RWX_MASK | VMX_EPT_USER_EX=
ECUTABLE_MASK)));
> =C2=A0
> =C2=A0static inline bool is_frozen_spte(u64 spte)
> =C2=A0{

A note for myself for the future: document the effective format of NPT and =
EPT SPTEs,=C2=A0
including the bits used by hardware, the ignored bits repurposed by KVM=C2=
=A0
and the format of MMIO SPTEs.


I have created a draft of this already and I can prepare a patch for=C2=A0
something like this to live in the Documentation/ folder.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky

