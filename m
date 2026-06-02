Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD1C1624C0
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410132; cv=none; b=SAB7XZ8OL/PAQLbpcWRlYK7qvIcmwqrX3kXdUqvgZqongR6NyfnqdxbCsC6rsVh8UcsREWYA1sjpk7P0kDa1SgPG9cagEXbB8Q+GeChiWm5TWdN680X9XOrJV7ajryC2UHKQmgb7PaMDbZs3yBVDO3i4qfBSEQX1lhhTdjfanMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410132; c=relaxed/simple;
	bh=ShZdTUuAEEKLmhw+r+CFUy9KzlV3PYlt2MquaVa7urQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JkEFbIuAYI/Vs5ajswIGZktugGkbwzwIYLgwx5wCliDgCmFzk5VGXG3P/uYV4Kku7Okm0ii2tMwBQ0/xeqMdM1INWvTS5YSvcdSj2vavhc7ndv9bqWl6xg0fH0yfRRWS0/hjkz74jMb45Mv2yoH2U1PSYm4dPw7YkUTBxsMORaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h6N9fRxX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d07fxiDk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6N9fRxX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d07fxiDk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HmhbodaRtIHg+0Z0GxXZqH1SFjbgDpBEbtnjJeZEU2g=;
	b=h6N9fRxXNpRpxKBsHQwvQocV88Mh+MzTONrgJx4mIcNkSdzUzP3QEYv0MmEjWDAXTlCYbc
	tFBcWX0mMxUlkXnyBl1SK9ezqYnOz3Nro+oKZ+hTstZEhwJniwEGxRMYcIHPq6OkTUU9g3
	+fX6YsEEK2Z9ZSVEOjrDEC0b3h4hL5A=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-Dd0dD6MxM6SI7r_E1H6ZZA-1; Tue, 02 Jun 2026 10:22:09 -0400
X-MC-Unique: Dd0dD6MxM6SI7r_E1H6ZZA-1
X-Mimecast-MFC-AGG-ID: Dd0dD6MxM6SI7r_E1H6ZZA_1780410128
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-59eb8eafe1cso4378009e0c.1
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410128; x=1781014928; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HmhbodaRtIHg+0Z0GxXZqH1SFjbgDpBEbtnjJeZEU2g=;
        b=d07fxiDkGORGWBnGVHrRgzDg3uOWT0LXK2b62EyreW0UygCSXH3wWghK+rKnDi1VH1
         /3xlWaVVu4ME/QBtDgVPodtwms6aX1lgtQVSYLBO+J97oKIA6UVFLQNcg0LlzNOT8FKz
         w1Y/lQ4I2yQZejGH4+fR2/u/KKKD2hiagq87x+z1mOD5afQ/mPQa+0tUAMQNiCijg5WS
         AXR2yF/0Nx4dgdL0s+hBzOInJbI867Q+LX2nKACWs5FtnoM/imahos4BqaIo3Jr88ZSV
         lkLg5uAOgAZczw6l8zEkzsLMK4t5Bxbvw0Hay6G74sWyUZsM8IH1xAx27AGB1g0/e1jp
         urOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410128; x=1781014928;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmhbodaRtIHg+0Z0GxXZqH1SFjbgDpBEbtnjJeZEU2g=;
        b=eEQ6XmVFg2qU97woJWSbpUepkJnw1IjX3VOAIJZzuFPfFDICiIhSaujBD/vrEuWOep
         +5k/fTiTpuWtmoF7coED+AkQVR032jetBkxbznEeUL7pTvjb1LG5uHFPek8fZZlu5sDd
         vJKFToI4qwjyC+0yw9JW8XfzkV2ZyTLJ+jR5BspjBqDu0TPX9M7G2IpeP5YUR8RhlMlq
         da5jsyjF0gMog5m7e44rKJ5rx81nSW/PpuGEenhBuZ9M58pXjO/jW27gU7k1/jepe/ex
         ap+Thp7Ev4k54szmxSKHNirJleoNJTeGzN17M4Lv3ZQ+zus0/h/ahIL5EdzoAxphsML+
         UPPA==
X-Forwarded-Encrypted: i=1; AFNElJ+6/EpWp5xEJeqMjP464HvjNeS8K5rtNTUwAToBcJdIEs2nFiB7N9B7CQbB1J94XWrWrsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK5vWOhZzMK7oRl5pEV1rz+0TaLZKoZigIoIZXFnjQX2d0n27z
	uVtjb2rLqwkzGoJBejFqqWBosyLPSYysM+KsnAGpKon5/tdMckBj3zaCGM4O0o5Iup7pzsc6kG0
	X96LEmhjsBA6JA2elzcKz09+BD4OzL+vTZlpzMb2me2OZMN7Ozxt/sA==
X-Gm-Gg: Acq92OFsK0YdIgqcgerNZ8XmBQTpCSwBUWqWTqc7P2e8HuAKYOtF8XMC8UaaeofIrT9
	uut1dkqBkNJyrNtOne1dSiFDiAcETUUt5AiGpE0ruZH5NKU79Oshj3rUamL3Lim9/sii2ewEDrp
	/rCpv5eJ03bPa58orpQnScqT6wUMW5upKW0meTN1mitRmAk3XQ5yAwYutiHC/8/M2wB3uMmkEhh
	m5BLsawC5ZnYhAakrTUUJnQNOK2oaye+6m7iea/q97C/U9ff/fDGZprIz5s/0UDHQ2PkQcRSk8M
	NVaU5GAdLFkYQg+mFFW7WREMnVAO5LD56iDKCfyCt43l3FcF0I6YxziVF4dNe5mWOfTOmQhs6AV
	1nl1WVMVJh72Ir4qvyHyN8BsKdP5LZSUgeccTgOk=
X-Received: by 2002:a05:6102:55d2:b0:6cf:f288:f36b with SMTP id ada2fe7eead31-6cff288fc89mr4625031137.13.1780410128022;
        Tue, 02 Jun 2026 07:22:08 -0700 (PDT)
X-Received: by 2002:a05:6102:55d2:b0:6cf:f288:f36b with SMTP id ada2fe7eead31-6cff288fc89mr4624998137.13.1780410127602;
        Tue, 02 Jun 2026 07:22:07 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea1c30ecsm119506336d6.25.2026.06.02.07.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:22:07 -0700 (PDT)
Message-ID: <c113dbc2815b57a755aa89c95bbd2ffb1aa28d14.camel@redhat.com>
Subject: Re: [PATCH 06/28] KVM: x86/mmu: merge make_spte_{non,}executable
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:22:06 -0400
In-Reply-To: <20260505195226.563317-7-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-7-pbonzini@redhat.com>
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
> As the logic will become more complicated with the introduction
> of MBEC, at least write it only once.
>=20
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/kvm/mmu/spte.c | 20 +++++++++++---------
> =C2=A01 file changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
> index 85a0473809b0..849a1c1c92b5 100644
> --- a/arch/x86/kvm/mmu/spte.c
> +++ b/arch/x86/kvm/mmu/spte.c
> @@ -317,14 +317,16 @@ static u64 modify_spte_protections(u64 spte, u64 se=
t, u64 clear)
> =C2=A0 return spte;
> =C2=A0}
> =C2=A0
> -static u64 make_spte_executable(u64 spte)
> +static u64 change_spte_executable(u64 spte, u8 access)

Minor nitpick: to be honest this is a bit less readable, but overall, I am =
not against this change.
Can we add a comment though about what values the 'access' can take?
or even better, add an assert?

> =C2=A0{
> - return modify_spte_protections(spte, shadow_x_mask, shadow_nx_mask);
> -}
> + u64 set, clear;
> =C2=A0
> -static u64 make_spte_nonexecutable(u64 spte)
> -{
> - return modify_spte_protections(spte, shadow_nx_mask, shadow_x_mask);
> + if (access & ACC_EXEC_MASK)
> + set =3D shadow_x_mask;
> + else
> + set =3D shadow_nx_mask;
> + clear =3D set ^ (shadow_nx_mask | shadow_x_mask);
> + return modify_spte_protections(spte, set, clear);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -356,8 +358,8 @@ u64 make_small_spte(struct kvm *kvm, u64 huge_spte,
> =C2=A0 * the page executable as the NX hugepage mitigation no longer
> =C2=A0 * applies.
> =C2=A0 */
> - if ((role.access & ACC_EXEC_MASK) && is_nx_huge_page_enabled(kvm))
> - child_spte =3D make_spte_executable(child_spte);
> + if (is_nx_huge_page_enabled(kvm))
> + child_spte =3D change_spte_executable(child_spte, role.access);
> =C2=A0 }
> =C2=A0
> =C2=A0 return child_spte;
> @@ -379,7 +381,7 @@ u64 make_huge_spte(struct kvm *kvm, u64 small_spte, i=
nt level)
> =C2=A0 huge_spte &=3D KVM_HPAGE_MASK(level) | ~PAGE_MASK;
> =C2=A0
> =C2=A0 if (is_nx_huge_page_enabled(kvm))
> - huge_spte =3D make_spte_nonexecutable(huge_spte);
> + huge_spte =3D change_spte_executable(huge_spte, 0);
> =C2=A0
> =C2=A0 return huge_spte;
> =C2=A0}

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky

