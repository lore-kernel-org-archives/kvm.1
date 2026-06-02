Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73B53B6348
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410220; cv=none; b=Rkl50KxXVUxFm28ev77CUcGUN8+05YDo6QWKavwtNcB43+aLJBohlt05z5K4gau90Qap1mhUb/S1/9YAZBWuhFxnCANiyD2jh0pntept2mZwShMqqCDnCxJcBUlhSoBWeJrD0dfkktuKSoQaJhoxIiMfSxX1olxHXd4FTSTYKW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410220; c=relaxed/simple;
	bh=Ku7g4ZCuk/Cpv2BlA16k0aIFZdUp9krbT4FfE9XslOY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e2eGnz7LoiO3FTdERvuqnor9MA3c9VcDRAyIZSBeavPZjC3VxckC65moZ4LE3gJydJex0+z/NqgObgOpUoq01B94De+PhfpfTl0PuWJ3fD/ibTY5ldjNo91zK8JXbd+/aNe+KmTBBfBZHMhRfCU5fF9sDIh6VIEHXeCHo3Sn2/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gf9w7Rau; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eg3qUlhk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gf9w7Rau";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eg3qUlhk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpc+JGRt1hDcmHZ2rPz09E08kestCg2du2YlJ7+7Dm0=;
	b=gf9w7Raudf0FcuRhnLBAwacIW55E/V+GQoVfJdX4D1OWQ1lNhNVOv0JIz4cRP8luPCqX+u
	tzQXb0CKTgl+dEdJrX36zLw21UGvVGZfqI2XjAYXGgkv5EE2EwailxlUE3trHMoRi2QPue
	QkhA59k/aIIHBZS3zrITlDBsYLajwxk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-IVijsTr-PI6hh4Adtd4jJA-1; Tue, 02 Jun 2026 10:23:35 -0400
X-MC-Unique: IVijsTr-PI6hh4Adtd4jJA-1
X-Mimecast-MFC-AGG-ID: IVijsTr-PI6hh4Adtd4jJA_1780410215
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-91565f8c589so381516285a.0
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410215; x=1781015015; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cpc+JGRt1hDcmHZ2rPz09E08kestCg2du2YlJ7+7Dm0=;
        b=eg3qUlhkXE0BNzUJQtXSZg4LAb/CVjWGZWiUEPeOMFoFZSafd0x+e7nqwGcGGI79iJ
         hQrjaP1x+Cfr8shbqJbReh6wlGVY/I7fM4qiubgxL4BVL0y+w4K0W3MZgET+nLHCRZWI
         KGNtO1hmN3JZyBy392hBxFrLObXUFssR+xNBThTR9/AJ7DdQVGMsi3YYE4zBLvwfkR4H
         3bZimw2Dm9VMW++/F8JeMEqFB0d45LRRulTg9YR4kyFyfANSbs23PHmXkCQKkkzj7jtZ
         FpuZhhxlIUFfK12LMwC1ZDlRIm+h16wnT8mXd5h25b66rHlzo8MttrGww3/sxz2G90aW
         7IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410215; x=1781015015;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cpc+JGRt1hDcmHZ2rPz09E08kestCg2du2YlJ7+7Dm0=;
        b=TfsAWxw+XNVnYIMJWyjOcAZKhW2zB9SjcdESq/7CWxjinkKntiMOtWShLaDTDRpF4N
         Sf0Sxs+gSlnDOfT7GZX6iCdOCcZwPksWmiT29e7LQ0Ubdo+bYycqiiFXaRaVI3opswUu
         uoLMxsbFXUGhRZHpBByZygAovzKzQXrUThdFhMFlAAtx39GLUSBsTFJhiFdbX5YS7V2U
         MacOEnMBG6DDzsO+CkwE/7lts4F53uf8o0q6BR6E6ykhUDVHXjHPAqDBva3EokxHGRNU
         pi+ow6Kfq8EyWEJCqM926ztuB2qiSch2rZgDcMBFkuf/1dMQtQOmWu7KdZNMi4vc3wcJ
         17CA==
X-Forwarded-Encrypted: i=1; AFNElJ8tDSDKswX9Ukp3RLAMx1mlLFdfwFD0Z+IcXnDoCqr7Bu7tzfJzPdzPULJKaD4T6dzG5uE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0hpLklvDDGpClonZopxVTfsbfZgpUBRBp00wk1uOsKIiRq9uG
	oa98CLez11iIkjYx9ejRq4wydD8NWT9bcnoV1rTePu+iJB9wVwlNe/pxdZrvLRpLB5T+aXH4L8j
	CCvncL8LalDxpm8KeugcXifKrXQUdBoGkg0fPj6cgUdnfF6IEXNO8Bw==
X-Gm-Gg: Acq92OErYtUcENq7aP1gtWbrrqKezjRYKlNco1DtFF+nk8dMXXSd6iyNZ6OQJigg9Pp
	G2VnQ47elWYc1zp7Ogn+fkjdIfKdVals+woBX0OVLkhK5mbakF1f1vjseeS3Pb9/iRz7Edu5Uvd
	XdqaTFxpN82kVTZJRbMmEfm0dLZeAS8Y4fmjY2DES72XV8g+3TbpI7oeJ6kHwCYm1MiGlj9P8Uh
	jNv16aYwPpkGA9oooSkpRvuNpM4PZrd1dPND+xzvmI4r6SARwHbeJJIR2iwxk9bBfOhQpZGspMO
	b7KynaFoiEcZ7v/uVF+PsgG/f29ezNc5OCpPLclnRv3f/CVFKRXuwhFm2bG+D9HuId3i+KtTwde
	WDD9aYS8y89fU9R5SCgfMtjyhgr6yfW4iN7E/8mw=
X-Received: by 2002:a05:620a:3723:b0:8f8:d17c:9f9 with SMTP id af79cd13be357-91577eae6c7mr599206785a.16.1780410215175;
        Tue, 02 Jun 2026 07:23:35 -0700 (PDT)
X-Received: by 2002:a05:620a:3723:b0:8f8:d17c:9f9 with SMTP id af79cd13be357-91577eae6c7mr599200185a.16.1780410214593;
        Tue, 02 Jun 2026 07:23:34 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91586c6aabesm48118185a.40.2026.06.02.07.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:23:33 -0700 (PDT)
Message-ID: <1fa043a5573867db87ed572ae373330c5cfa3974.camel@redhat.com>
Subject: Re: [PATCH 10/28] KVM: x86/mmu: pass PFERR_GUEST_PAGE/FINAL_MASK to
 kvm_translate_gpa
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:23:33 -0400
In-Reply-To: <20260505195226.563317-11-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-11-pbonzini@redhat.com>
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
> U bit from the page walk itself.=C2=A0 While strictly speaking not necess=
ary
> (any value of PFERR_USER_MASK would be the same for page table accesses,
> because they're reads and writes only), it is clearer and less hackish
> to only apply MBEC to PFERR_GUEST_FINAL_MASK.=C2=A0 Allow kvm-intel.ko to
> distinguish the two cases.
>=20
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/kvm/hyperv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 3 ++-
> =C2=A0arch/x86/kvm/mmu/mmu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 3 ++-
> =C2=A0arch/x86/kvm/mmu/paging_tmpl.h | 7 +++++--
> =C2=A0arch/x86/kvm/x86.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 3 ++-
> =C2=A04 files changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 9b140bbdc1d8..cf9dd565b894 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -2041,7 +2041,8 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, =
struct kvm_hv_hcall *hc)
> =C2=A0 * read with kvm_read_guest().
> =C2=A0 */
> =C2=A0 if (!hc->fast && is_guest_mode(vcpu)) {
> - hc->ingpa =3D translate_nested_gpa(vcpu, hc->ingpa, 0, NULL);
> + hc->ingpa =3D translate_nested_gpa(vcpu, hc->ingpa,
> + PFERR_GUEST_FINAL_MASK, NULL);
> =C2=A0 if (unlikely(hc->ingpa =3D=3D INVALID_GPA))
> =C2=A0 return HV_STATUS_INVALID_HYPERCALL_INPUT;
> =C2=A0 }
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index fa6a5e4ee09a..46412e4d207f 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4348,7 +4348,8 @@ static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *=
vcpu, struct kvm_mmu *mmu,
> =C2=A0{
> =C2=A0 if (exception)
> =C2=A0 exception->error_code =3D 0;
> - return kvm_translate_gpa(vcpu, mmu, vaddr, access, exception);
> + return kvm_translate_gpa(vcpu, mmu, vaddr, access | PFERR_GUEST_FINAL_M=
ASK,
> + exception);


This is an existing problem, but now that I look at this and at the next pa=
tch, it is not
100% clear what 'access' is, especially for someone who is not familiar wit=
h he code.

Also soon we will have 'pte_access', which can make this problem worse.

I think that there is a need for a comment here, in this or in the next pat=
ch to avoid
a confusion.
What do you think?

> =C2=A0}
> =C2=A0
> =C2=A0static bool mmio_info_in_cache(struct kvm_vcpu *vcpu, u64 addr, boo=
l direct)
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmp=
l.h
> index fb1b5d8b23e5..567f8b77ffe0 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -376,7 +376,8 @@ static int FNAME(walk_addr_generic)(struct guest_walk=
er *walker,
> =C2=A0 walker->pte_gpa[walker->level - 1] =3D pte_gpa;
> =C2=A0
> =C2=A0 real_gpa =3D kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(table_gfn),
> - =C2=A0=C2=A0=C2=A0=C2=A0 nested_access, &walker->fault);
> + =C2=A0=C2=A0=C2=A0=C2=A0 nested_access | PFERR_GUEST_PAGE_MASK,
> + =C2=A0=C2=A0=C2=A0=C2=A0 &walker->fault);
> =C2=A0
> =C2=A0 /*
> =C2=A0 * FIXME: This can happen if emulation (for of an INS/OUTS
> @@ -444,7 +445,9 @@ static int FNAME(walk_addr_generic)(struct guest_walk=
er *walker,
> =C2=A0 gfn +=3D pse36_gfn_delta(pte);
> =C2=A0#endif
> =C2=A0
> - real_gpa =3D kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn), access, &wal=
ker->fault);
> + real_gpa =3D kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn),
> + =C2=A0=C2=A0=C2=A0=C2=A0 access | PFERR_GUEST_FINAL_MASK,
> + =C2=A0=C2=A0=C2=A0=C2=A0 &walker->fault);
> =C2=A0 if (real_gpa =3D=3D INVALID_GPA)
> =C2=A0 return 0;
> =C2=A0
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0a1b63c63d1a..ef1e3ae13887 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1072,7 +1072,8 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned lon=
g cr3)
> =C2=A0 * to an L1 GPA.
> =C2=A0 */
> =C2=A0 real_gpa =3D kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(pdpt_gfn),
> - =C2=A0=C2=A0=C2=A0=C2=A0 PFERR_USER_MASK | PFERR_WRITE_MASK, NULL);
> + =C2=A0=C2=A0=C2=A0=C2=A0 PFERR_USER_MASK | PFERR_WRITE_MASK |
> + =C2=A0=C2=A0=C2=A0=C2=A0 PFERR_GUEST_PAGE_MASK, NULL);
> =C2=A0 if (real_gpa =3D=3D INVALID_GPA)
> =C2=A0 return 0;
> =C2=A0

Looks correct to me otherwise.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky


