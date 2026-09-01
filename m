Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED66A37107E
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 00:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223725; cv=pass; b=rOycWqFxVkKySpcEqoVaPjN5qe13g4ZnAirEbAT191xE6clET1MCfEL1CttlyX/WYz+E/TfqWuIEABTJXzk+YT3xt3LFTE7CgZMPWNotDpbyIdgLGqqqhbOvge4vTZTTXhN06CNOsydCESqsl7cJ6TuxYkxnJhtjkcOJUDUtWn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223725; c=relaxed/simple;
	bh=jS73Y9Ax+M/4TFI/BHflongxHZ7kkQuWe5CVcgbwi+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RF7j4XckCszYdUrREcef+4dvvtTjXZ2wDDjfE25Xg7Jh4+mVH6Cw+OQ+flT94cPNKRkorXe3YGDb04zFXbZpz+HhwQT48oxzL+3Ep+QGPNK3l3Kfc/xT9r6QZuQVaQF/r9rgGhef/KJo4z2R0zhbq/bFuO3YQDepGbn8cjM0pz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqyRXJGM; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqyRXJGM"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso2928995ad.3
        for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 17:48:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788223723; cv=none;
        d=google.com; s=arc-20260327;
        b=QqQKXiiqlArhSis0AgauByBIaTi623MJLYB9VSCDg5sX+Z/2BlaKEXe4SIk2SjC0R0
         aZ7ixM3H50dwkA5MBkhmztlfyzRtACuIsCQfAqMXwFbDNV+WxkVe/7KwTWQIM1uNEu8R
         xuJQUK62AbdyeBkeRtITsj094njNMt4UPX71SZ1vpwW24Z0eh+x6jljHJADcuXDtbitf
         AnhJQat6BeexeRr/DNWUJfWt0mAcNKOEeHGEZdS3Rle1c6/Zjnvltdc2xbODudMU8i75
         xl7jl4nntV83iZeuyVHlH1ZHxAKliiYYHyJ2UOqGUawe1X7lqM1G2uBJTtAGdYS+zIvi
         FkDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bazjSzwMCF+AgN6pYQNjRZEW2QtTTdcfXFPY1xxZKAk=;
        fh=clmWqNh3m5Le1U/Dd/TOld8q2vazUSvFMPgfPMWuA0M=;
        b=oXxQ7UWaZe/H0lmmkdAKZal8SfKCN4KpNXaxZk/Ma71k/4Vutey9pvM4x4pPMuPN1G
         X/AI2VRFxlqp6RWQ6UHWob8U14EndlEBAaMMQ3cU+1xaxbEjx2fYW67DQeSsyRMT1fq3
         Jcfs8s2ZXJaz1RLjMYupxH931VC5WnYG4Na9kDkd9I1hbl03YuRTr/AAS0Syya3zeEU6
         Q8DAz90mDgocMV5zuT6XKQH+s12+oQj+NApfjLGUFOjwXySXMeHDZOVepV4KznTtVjGW
         zaQ3OYnBAr5W2NrLM46qYWwJ3PnKmKCXDWZHjzZtL3NwaGFQay6N/slVyVWACByBUaeX
         iuHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788223723; x=1788828523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bazjSzwMCF+AgN6pYQNjRZEW2QtTTdcfXFPY1xxZKAk=;
        b=CqyRXJGMeB6toUR6dpPVpC9OYYap/7UB5+Tiq0HXTj4yg28ftq6LKvqgf8HWs6rESR
         DmQN6Vppoqq1Wq1uIi7tXU56txioVwtJenbafsiVW1upUCgq0cbHL/nYQG3NOwVAuHL/
         kwiOZLcZb2pfnOowwM9cnXm+4bF1KP3yut/hi83fxz+x2pzkEy7IJ8HzQSapXl0V0GKZ
         AneNu2nM9874T/SbMAxLnuUmYXyraf63HCfC8DUPB2uUM7JRs4lcBledftqjNO0d49Ub
         4gkYb9GAfvMkfKWaO2/vKzf+aszR58Iq30eIlkLpj7D8HXOEsm0vSMOTOJRCzhzT/uhe
         vboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788223723; x=1788828523;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bazjSzwMCF+AgN6pYQNjRZEW2QtTTdcfXFPY1xxZKAk=;
        b=VVVoJrUIHyLFTkoE/QmZAGlffi9oi8RRh8ijWMZM1pcFXfaIuMoX8jQfO2ANre6st5
         yQbD1da17CvaD5/v26T0IAVP9S8K0jOo5Qj2XFTUqQFAhhmpfQMVh+pP11MmdNTJYuwZ
         23tuR5HnCtEthQccBZMA5C4E21p4rjXhuF3Ed3Dtx5PgIHcOV0cfnZdreK6KPfcZXiRs
         n8an60A9fuZWX3vvf6VfRIlZT+YF6nd9mT5pcrLnJCME6GqvHhVo/qjLtl21IdXD6C7g
         QQpsM0dsWT+68jCwemuNWQgAriABOjZoJylyvDdjK5DEPr3Da5neK/ryA80sy24cgbSh
         0ZNQ==
X-Gm-Message-State: AFuF++kateWZ/L2U7jLmMgE92GwTAPogEDXiSw5M/naqovbm40HzgOx4
	FsDaJPCw99aQUfLZVaiHL9FjX66n9kcrGEaGGtaH9UaXrOzzESqEVWXdnHEFzunEig74e0mU0ye
	xQCmWW5m6Epk5EukpFxn3iCsDfxRoo+61BDK5UqrXUg==
X-Gm-Gg: AYBFou3KUYfm3aB5tzxtDFNCLePcmgwQ4Z4E22JnKUBnHRLqqtQnQQj8ss7t3d6LIHi
	yIZuYTKrMxNNhtWCFaHK/MI6UkEvfhemP+NdBpN2B+JUY+mParr4/PUiTICszr1QFsc0revVomq
	S1XtnIYE2BM7ftR6CPApH6iPSSXrh70zloSJKu1I8WKZpQnW/J1LTldULxWWEZDrGQhCGyMUcPy
	h+pcNK7HvEZrzvksrQA96NhRgShutead/GHloNrXa9IX0F/UfjdeNhiA3/33iSKdl/Y0zsnoIuS
	Q7P32dgsmRRGl8u+u9dXHFOP3nwnD5iMjgDKcTIgWIqyaJZUKUZeyyIBECLXtzX4V1Nsl1S9CCd
	wqQ==
X-Received: by 2002:a17:903:388e:b0:2d7:44c5:1a13 with SMTP id
 d9443c01a7336-2d74df17b06mr475050065ad.8.1788223723108; Mon, 31 Aug 2026
 17:48:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807112818.958190-1-kimjw04271234@gmail.com>
In-Reply-To: <20260807112818.958190-1-kimjw04271234@gmail.com>
From: Jinu Kim <kimjw04271234@gmail.com>
Date: Tue, 1 Sep 2026 09:48:32 +0900
X-Gm-Features: AcwNN1Wz291OtiDO0yLKdqxMF1hiX1iPzMyfEM1kmMxlGvIMy0a5OidH_3jkXks
Message-ID: <CAH+3ta7b7MudRedhFG4xQH6-3ZK9gfkcEPy_aHsAHBwjyK81+w@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Use active memslots for the per-vCPU MMIO cache
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, security@kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean, Paolo,

A friendly ping on this patch.
I originally sent this on August 7, which was fairly late in the 7.2
release cycle, so I held off on pinging during the remainder of the
cycle and the 7.3 merge window.
Now that 7.3-rc1 is out, could you please take a look when you get a chance=
?
Please let me know if you'd prefer that I resend or rebase the patch.

Thanks,
Jinu

2026=EB=85=84 8=EC=9B=94 7=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 8:28, Ji=
nu Kim <kimjw04271234@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> KVM tags the per-vCPU MMIO cache with a memslot generation so that a
> memslot update invalidates cached MMIO information.  Both the fill and
> validation paths use kvm_memslots(), which unconditionally selects addres=
s
> space 0, even when the vCPU is running in SMM and using address space 1.
>
> Commit 56f17dd3fbc4 ("kvm: x86: fix stale mmio cache bug") added the
> memslot generation to the cache key so that a memslot update could not
> leave a stale entry valid.  When commit 699023e23965 ("KVM: x86: add SMM
> to the MMU role, support SMRAM address space") added the SMM address spac=
e,
> these helpers were not converted to use the active memslots.
>
> Consequently, an update to the SMM memslots can leave an entry from the o=
ld
> SMM address space apparently valid after the vCPU returns to the normal
> address space.  A guest can then cause an access to valid RAM at the same
> GFN to be returned to userspace as KVM_EXIT_MMIO.
>
> Completing that exit through the VMM's RAM address space writes the backi=
ng
> page without going through KVM's write-tracking path.  If the page backs =
a
> nested EPT table, KVM can continue using shadow translations derived from
> the old contents.  The WARN_ON_ONCE() in kvm_mmu_write_protect_fault()
> catches this invalid cache and memslot combination.
>
> Use the vCPU's active memslots when caching and validating the entry.
> Memslot generations are unique across address spaces, so the generation
> also distinguishes the normal and SMM views.  This matches the MMIO SPTE
> cache, which already uses kvm_vcpu_memslots().
>
> On an unpatched current-mainline kernel, a regression test that fills the
> cache in SMM and updates only the SMM memslots fails the intended RAM wri=
te
> and triggers the kvm_mmu_write_protect_fault() warning.  With this change=
,
> the same test completes the RAM write without a warning.  The x86/smm_tes=
t,
> set_memory_region_test, and memslot_modification_stress_test selftests al=
so
> pass.
>
> Fixes: 699023e23965 ("KVM: x86: add SMM to the MMU role, support SMRAM ad=
dress space")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinu Kim <kimjw04271234@gmail.com>
> ---
>  arch/x86/kvm/x86.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 9de577ef9c97..a6d86d3dcff6 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -313,7 +313,7 @@ static inline bool is_noncanonical_invlpg_address(u64=
 la, struct kvm_vcpu *vcpu)
>  static inline void vcpu_cache_mmio_info(struct kvm_vcpu *vcpu,
>                                         gva_t gva, gfn_t gfn, unsigned ac=
cess)
>  {
> -       u64 gen =3D kvm_memslots(vcpu->kvm)->generation;
> +       u64 gen =3D kvm_vcpu_memslots(vcpu)->generation;
>
>         if (unlikely(gen & KVM_MEMSLOT_GEN_UPDATE_IN_PROGRESS))
>                 return;
> @@ -330,7 +330,7 @@ static inline void vcpu_cache_mmio_info(struct kvm_vc=
pu *vcpu,
>
>  static inline bool vcpu_match_mmio_gen(struct kvm_vcpu *vcpu)
>  {
> -       return vcpu->arch.mmio_gen =3D=3D kvm_memslots(vcpu->kvm)->genera=
tion;
> +       return vcpu->arch.mmio_gen =3D=3D kvm_vcpu_memslots(vcpu)->genera=
tion;
>  }
>
>  /*
> --
> 2.43.0
>
