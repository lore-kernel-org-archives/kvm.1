Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43353F65E6
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410640; cv=none; b=DKzD8Yo5hh4hb8VPULJ0GxfFmjGM072sVK+uGrCVWSVY9uTYcQoVStNXac670OGfNwBSbWXJLYBvGjdP44EIaqWJokqxbKawGV0Pj1eZUPoUTSZTwJ7ESZ6NYRwAmgPgf1jCrbZXXjhD5evga2wPM9TCGcn1wG8YMbJ0TBRIOs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410640; c=relaxed/simple;
	bh=ifhBtlQccMTOl1OtyDUz4oMtXUzGOAAtYYQc1i4voz4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cGrDnzF5fbC62e10ipZLo4rMWy7pUqpmYhkEHdn74+Ix8PnKKYqV06lTArHeLst4DEli0yrNb4Sr2GZ3RptD7hOV9zZC417IPz+mgRIT0qtTq00+7SSnT8NzQRgeYzaDvJ0wMmkN7Lbj/674pI4gR0ZZABbG4xbualis/EYREd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i37Uwuk4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCwAfQum; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i37Uwuk4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCwAfQum"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ifhBtlQccMTOl1OtyDUz4oMtXUzGOAAtYYQc1i4voz4=;
	b=i37Uwuk4Ug3n4SngP0T+wZxMo6evuiKOdTpOEqCiv32Y7fZS2imkWCyjQmGgXoVa/CdiMW
	EzbF/ssDnGXjRDYoq7W7Cqp/AERnlR7OeI717jnRsgoHE6QusTC0JPA5vHjyp/VmLCA2js
	UAOq1UJRSS5flRbLspWvjaS+GLLtl08=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-E0xa55evOrucRX6IY6Z0Zw-1; Tue, 02 Jun 2026 10:30:35 -0400
X-MC-Unique: E0xa55evOrucRX6IY6Z0Zw-1
X-Mimecast-MFC-AGG-ID: E0xa55evOrucRX6IY6Z0Zw_1780410635
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ccf396f53bso83716026d6.1
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410635; x=1781015435; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ifhBtlQccMTOl1OtyDUz4oMtXUzGOAAtYYQc1i4voz4=;
        b=MCwAfQumQDpevKJ9JhR+Gsjb9C0/4DiafXqptLjprF92ik+kU0/tFOmZA3QmUGZHEi
         nDcT1UyN+frGXss+2mMaof54V2e6+O0kLGkiz9stPyofWDsYk0F6sBJJndjsQJeO8cAV
         oXBgk1y4ozzvjprrgmSnCObnrLKWQD/o/y/LwTmFiyf6tzN+XwwoNi39hGEMsHVWhs3G
         9Hp8urt/69XOZN009/wAl2VA3UztUxz/zYNph9Ev5wer6kuzQZjfSeVJ3gowcqAcVr3L
         5aKWP16K6bal2yX1wUavh80NSLUGF1hnfspGhKdkHwh+XqmyHycUBU2Ce94rN5KJqnDl
         u6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410635; x=1781015435;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifhBtlQccMTOl1OtyDUz4oMtXUzGOAAtYYQc1i4voz4=;
        b=huRplw5U24n2SkRylq8N65TshgleFvfZXSPEiq2TfIrZ14A5pdxVIitoZJBfNKvFkB
         bj5rzT5pECoggLIz+jdnQThvxB8ki7amHRk1xsk3+eJYH+MxmSmtM57UV2w5Peh+t9XZ
         hz2wGcqJDvj71hCA8SopsC1HP36jz1XU+JBclGuzj0MVsOFoQs50uymabXQVJG9Vd7wl
         XemqUNQY3JwfwXD9WK0bmNQ/0L4P7mBYpEWrOZOMD9vNHtob/jG4XIWN2lYUjRtd3VwX
         JTb7Lv6mbFX799SrJYVniW1T6wep7SbTPqBNnMppkSax96Gc0cXBki5th94teyp498Gb
         feqg==
X-Forwarded-Encrypted: i=1; AFNElJ8YQDEwzgydiJ2g68fu7KH6wLt3KQH2sHrKUKCoCaPTCp+OonqJ6CRJNdZvohv24nsngBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf7Y43DMQWtyRJFf2ACRIYxTalnn+BGugyUoQgL892hcMHdC0c
	TGSDMyx7KqxGSGvepMaNXhi4L3APSv7bLZjZIzJp2T+Hcc+Vj2YD3nyeAg0Vsg8r2k1Dw0zbM07
	36Edi6EXKUdMp8mG3I6xXEqnRdkKwVBP3FTDV4KFl7Yw5r3vtC3bu2E4EuLjVsA==
X-Gm-Gg: Acq92OFDNrSjJJ5wlQRWPAaMOT0ya2J/iNnqUR/SVahpVHLjOgbse3PBPFFYF9Xr02B
	6bEQljBBZ2Xq9mp5utHGLJkKI1aR4CuMUSqWvM8EgWktrAGFCiIDNlmrW8iEz4IAUy2adAgKO9P
	5dHwj7hyzkG2esFQ+BWh6yRkrQxbWBdGGsiT4GFCFjHAOLIVXgfXZW1bMGipGOlW9DbxB3DfvsI
	ZHy563yxdyMbzsuhbN9FlTMcMFP2ER1m8eKdWDf3Nc0vDLJbMCzHNFKak0CKgUM/cmp6YG8Egl1
	KcHLBaN930d6dPcJjIFxv/ABkU5ZoIcjpJHIhK+w7qjjGdHRBLW0VlD2H2x3uObViP+nJ7/qWuo
	/ByxXORpmRWtV2x/U3fkNMSJujmGkeSp/elGB++g=
X-Received: by 2002:ad4:4ead:0:b0:8cc:3546:2625 with SMTP id 6a1803df08f44-8cebf421b3emr57136776d6.9.1780410631953;
        Tue, 02 Jun 2026 07:30:31 -0700 (PDT)
X-Received: by 2002:ad4:4ead:0:b0:8cc:3546:2625 with SMTP id 6a1803df08f44-8cebf421b3emr57130996d6.9.1780410628709;
        Tue, 02 Jun 2026 07:30:28 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea202609sm120880346d6.36.2026.06.02.07.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:30:27 -0700 (PDT)
Message-ID: <c495f6d53e6472b7e9da02773f2f7916f69091cf.camel@redhat.com>
Subject: Re: [PATCH 24/28] KVM: x86/mmu: hard code more bits in
 kvm_init_shadow_npt_mmu
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:30:26 -0400
In-Reply-To: <20260505195226.563317-25-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-25-pbonzini@redhat.com>
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

> The host CR0 does not really reflect onto the NPT format because =20
> hCR0.PG=3D1 must be set and hCR0.WP is ignored.=C2=A0 Carve that in stone=
 =20
> by removing the cr0 argument from kvm_init_shadow_npt_mmu. =20
> =20
> Pass in WP=3D1 as well; it does not matter for GMET disabled because =20
> PFERR_USER_MASK is always set, but a cleared W bit in the nested page =
=20
> tables cannot be overridden in supervisor mode when GMET is enabled, =20
> either.=C2=A0 In fact, since CR0.WP=3D0 is the weird "extra accesses allo=
wed" =20
> mode, it is acutally easier think about it being always set. =20
> =20
> Likewise, clear X86_CR4_SMAP to avoid that KVM erroneously faults on =20
> supervisor accesses to an U=3D1 page.

Hi!

Minor nitpick: This all makes sense but can we also add the same comment to=
 the code? =20
Commit messages tend to get lost after a while, when new layer of refactori=
ng =20
replaces them in git blame.


> Signed-off-by: Paolo Bonzini <[[pbonzini@redhat.com](mailto:pbonzini@redh=
at.com)](mailto:[pbonzini@redhat.com](mailto:pbonzini@redhat.com))> =20
> --- =20
> =C2=A0arch/x86/kvm/mmu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++=
-- =20
> =C2=A0arch/x86/kvm/mmu/mmu.c=C2=A0=C2=A0=C2=A0 | 8 ++++---- =20
> =C2=A0arch/x86/kvm/svm/nested.c | 2 +- =20
> =C2=A03 files changed, 7 insertions(+), 7 deletions(-) =20
> =20
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h =20
> index e1e3869f568b..1b354e1f2d81 100644 =20
> --- a/arch/x86/kvm/mmu.h =20
> +++ b/arch/x86/kvm/mmu.h =20
> @@ -96,8 +96,8 @@ void kvm_mmu_set_me_spte_mask(u64 me_value, u64 me_mask=
); =20
> =C2=A0void kvm_mmu_set_ept_masks(bool has_ad_bits); =20
> =C2=A0 =20
> =C2=A0void kvm_init_mmu(struct kvm_vcpu *vcpu); =20
> -void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0, =
=20
> - =C2=A0=C2=A0=C2=A0=C2=A0 unsigned long cr4, u64 efer, gpa_t nested_cr3)=
; =20
> +void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr4, =
=20
> + =C2=A0=C2=A0=C2=A0=C2=A0 u64 efer, gpa_t nested_cr3); =20
> =C2=A0void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly, =
=20
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 int huge_page_level, bool accessed_dirty,=
 =20
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 bool mbec, gpa_t new_eptp); =20
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c =20
> index 912c8e97ef61..5a796ae8c396 100644 =20
> --- a/arch/x86/kvm/mmu/mmu.c =20
> +++ b/arch/x86/kvm/mmu/mmu.c =20
> @@ -5939,13 +5939,13 @@ static void kvm_init_shadow_mmu(struct kvm_vcpu *=
vcpu, =20
> =C2=A0 shadow_mmu_init_context(vcpu, context, cpu_role, root_role); =20
> =C2=A0} =20
> =C2=A0 =20
> -void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0, =
=20
> - =C2=A0=C2=A0=C2=A0=C2=A0 unsigned long cr4, u64 efer, gpa_t nested_cr3)=
 =20
> +void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr4, =
=20
> + =C2=A0=C2=A0=C2=A0=C2=A0 u64 efer, gpa_t nested_cr3) =20
> =C2=A0{ =20
> =C2=A0 struct kvm_mmu *context =3D &vcpu->arch.guest_mmu; =20
> =C2=A0 struct kvm_mmu_role_regs regs =3D { =20
> - .cr0 =3D cr0, =20
> - .cr4 =3D cr4 & ~X86_CR4_PKE, =20
> + .cr0 =3D X86_CR0_PG | X86_CR0_WP, =20
> + .cr4 =3D cr4 & ~(X86_CR4_PKE | X86_CR4_SMAP),


Nitpick: If we assume that EFER.NX is always true for NPT, as I suggested i=
n the previous patch, =20
we can drop CR4.SMEP from .cr4, which could clarify that =20
NPT doesn't depend on host CR4.SMEP either.

What do you think?



> =C2=A0 .efer =3D efer, =20
> =C2=A0 }; =20
> =C2=A0 union kvm_cpu_role cpu_role =3D kvm_calc_cpu_role(vcpu, &regs); =
=20
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c =20
> index df232153eb24..a1cffd274000 100644 =20
> --- a/arch/x86/kvm/svm/nested.c =20
> +++ b/arch/x86/kvm/svm/nested.c =20
> @@ -93,7 +93,7 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu=
 *vcpu) =20
> =C2=A0 * when called via KVM_SET_NESTED_STATE, that state may _not_ match=
 current =20
> =C2=A0 * vCPU state.=C2=A0 CR0.WP is explicitly ignored, while CR0.PG is =
required. =20
> =C2=A0 */ =20
> - kvm_init_shadow_npt_mmu(vcpu, X86_CR0_PG, svm->vmcb01.ptr->save.cr4, =
=20
> + kvm_init_shadow_npt_mmu(vcpu, svm->vmcb01.ptr->save.cr4, =20
> =C2=A0 svm->vmcb01.ptr->save.efer, =20
> =C2=A0 svm->nested.ctl.nested_cr3); =20
> =C2=A0 vcpu->arch.mmu->get_guest_pgd=C2=A0=C2=A0=C2=A0=C2=A0 =3D nested_s=
vm_get_tdp_cr3;



Best regards, =20
Maxim Levitsky





