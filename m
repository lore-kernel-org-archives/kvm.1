Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89943FB7D8
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410588; cv=none; b=pMcahzO8+Gp+43LI9vBDtuAxQpZFu7HbTc4kkaN5nIAHPp9WYvlmcfKFZ5nx1pjdKPNV7GZSGrRUBkvzFfKRHNsJwp07boxOlvGbB9TIwnY3oKSntHvZEth5ZXQGo+TU+epnUDt2FaRjL9D/sUypDtsyWgmhyV6TKfu2mROy2D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410588; c=relaxed/simple;
	bh=cYdHfGh3cm4HR+DZFB0V1k/026v4T/6EtPC6MoWxkDg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fhlUIEpwigDGOWWorOE67OLE9yx6tqbsMPVXmUOHEE5mEK045p+Hhcge4/f95upZfpJKrBXRyI/3MJFr6adxxyN1Xni1MBmmKejbJVwwGOjZYzbAsB8fgHhf4b+Cugdiv7jSFyQIbJS4vOlIKinPRdmkkvV/LGjIkTQgHiABjgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIIJ/U7Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pSMixPIU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIIJ/U7Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pSMixPIU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pmQDVDwR25l9J0qmh2mjUVcmSUfTfBOhIGtA0UlOIF8=;
	b=TIIJ/U7YT/fr+kWm5SwxA44+x/A/m98oLUMlMPchREgEW/EniO5to93PTE/N4Y7FUZF6d2
	7RaLNVdCjGtHjnmNp0Yd5zw0+d14aj/Z68Q7ORUtYVABdZq53MvN4TBXxoyV7GOAA/AgNV
	uBBJZe0DRcMt9zxC+jGOrUFCZGatMSc=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-FcdUr99sPYeHsJsnY1gkZA-1; Tue, 02 Jun 2026 10:29:44 -0400
X-MC-Unique: FcdUr99sPYeHsJsnY1gkZA-1
X-Mimecast-MFC-AGG-ID: FcdUr99sPYeHsJsnY1gkZA_1780410583
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6cea6ada5so3235703a34.1
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410583; x=1781015383; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pmQDVDwR25l9J0qmh2mjUVcmSUfTfBOhIGtA0UlOIF8=;
        b=pSMixPIUYKM4Wl44m7G+P7DdYzK2YNvpwiqob1grE8kSBZJDradPFJUym8K4Cnf//b
         +Qzqy/LrT/IFP35liSWTEAQcnTgj6IGe7Bhi1TblUFh5g8G3gnC1fUeMWR0XAahaqFO/
         2UkOf3w7htLaZnDpfqVdP8NovWa+zYbSwdF8mr8yfoTCWI35SHFS8hPb0DNidnFxiDt7
         6Ntbb8oy/QK3RV9eONcYiVnEmngMMnQGetyyyrkhBGYW7aJeSNnjP2AiFLYwS3MnHRCo
         y3ya3inHVaT1AUVsBmZUkAdHAi/zNVxSMM+OHsh2vpT6sJ1mGqZxP7G1c0zWhegm5VLx
         DeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410583; x=1781015383;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmQDVDwR25l9J0qmh2mjUVcmSUfTfBOhIGtA0UlOIF8=;
        b=DVYUFmj1bo8lJaXuzyaDbhESU5PQ2ALTAlgmsBYooFSIKLwzkx2zcsFTrG5Cxhj8e0
         tick/kfULvWdHXLHzkZR45YBEUQobWB75UXlvesP+YA5ouaX2ooRE4vMZL8ACF1xlBY7
         vnWaaxD2gWOKHBxM6PQMzu6/UUU2KcTVdgo6Ojai1KTHRXXfFwNIRS+oEMQ6oGLrrPCD
         J142RXJMtC4GI7DhLFAbXSYtRairrDlC46kSQQXpQBQNWPi3H4Tc8sm5GxDrzRucX5Ot
         qoFEeiiHwNFeS+wqZfiP5DcBKIFTWF9HyDVqzAOo+45hztuL0olCEaVX98eVJYnLCSOA
         ynrQ==
X-Forwarded-Encrypted: i=1; AFNElJ/YZgBbuXCFVLE4NkJ/GOmlnH5qSJG+JrDID4wBw9nntVsxt1xw4w0zPd1anrsO4rVu6yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUvGnKndx8AfHJYoTajXmjS4HiupEzDc8ncFID+OCfdEXzQBX4
	stwEQQjFSyBok+K8lqDxccR6VC8UmbsefSXJfYM+15rUmYpbE+DncszOgmqGpNNb8wU1gf46NSg
	vKjOr6WKpUt4QO+3wunV85ZTtcVmioLEexxqdRNx+/kWuehzzy7GmOiAJhGj3Dw==
X-Gm-Gg: Acq92OGDQE5q6/YEWiWh2L6fBu/kbfFJuNmX7K0/W2GaCap263jXDQSexskE20EKqSf
	jgleWP9nBDPi3HYZo8oiN/ak8geX6F+dEFYtIUSw1zsKPeqmYIVSZR8J581joXjuf7ZMO9RpYyc
	xEaLi65gMsNE+DCk2F8ky5TH/jiWNCG+BwdCfVB1mYoJ16SJvp4gsDzq+uqY6rTqZvze62+TRbv
	uqUGjL4wKgXZNdwLBjnmdpDxSDsSSAwb2pYDMzgvNVTF3DRfvDVEKfUwl3tmQO+0lWgm60p8tI/
	K/7pr+59cUcQwv46pjtBqO+sL+wGlfSirthUKjCzaHhuRIwVIbytCZCjq1UH6xLmlnW99nOSLnU
	jub427gTcJwyCjVzAAnI+nK53ZHCWLovkHZneGSQ=
X-Received: by 2002:a05:6830:2704:b0:7dc:d7e8:cb30 with SMTP id 46e09a7af769-7e6a1e9baffmr10305477a34.26.1780410583428;
        Tue, 02 Jun 2026 07:29:43 -0700 (PDT)
X-Received: by 2002:a05:6830:2704:b0:7dc:d7e8:cb30 with SMTP id 46e09a7af769-7e6a1e9baffmr10305449a34.26.1780410582854;
        Tue, 02 Jun 2026 07:29:42 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695d8a609sm10083330a34.24.2026.06.02.07.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:29:42 -0700 (PDT)
Message-ID: <e82cdc2b9aa86356d971103cfe396c69c45734bb.camel@redhat.com>
Subject: Re: [PATCH 22/28] KVM: x86/mmu: introduce cpu_role bit for
 availability of PFEC.I/D
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:29:41 -0400
In-Reply-To: <20260505195226.563317-23-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-23-pbonzini@redhat.com>
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
> While GMET looks a lot like SMEP, it has several annoying differences.
> The main one is that the availability of the I/D bit in the page fault
> error code still depends on the host CR4.SMEP and EFER.NXE bits.=C2=A0 If=
 the

Hi!

What do you think if we reword this like this:

"still depends on either host's CR4.SMEP or host's EFER.NXE being set"

I initially thought that we have to have both of these settings enabled and=
 it
confused me.

> base.cr4_smep bit of the cpu_role is (ab)used to enable GMET, there needs
> to be another place where the host CR4.SMEP is read from; just merge it
> with EFER.NXE into a new cpu_role bit that tells paging_tmpl.h whether
> to set the I/D bit at all.


I am thinking:

For KVM point of view, has_pferr_fetch will always be true on NPT, because =
the kernel itself always enables EFER.NX,
if it can (for reference, the code is in head_64.S), and there seems to be =
no override for that.

And then, KVM refuses to load when EFER.NX is not supported by the CPU=C2=
=A0
So host's EFER.NX will always be set for KVM (we can add an assert somewher=
e to be 100% sure)

In fact if this is the case, we can simplifiy things by assuming that we al=
ways have PFERR_FETCH for NPT.
What do you think?


>=20
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/include/asm/kvm_host.h | 7 +++++++
> =C2=A0arch/x86/kvm/mmu/mmu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 8 ++++++++
> =C2=A0arch/x86/kvm/mmu/paging_tmpl.h=C2=A0 | 2 +-
> =C2=A03 files changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 23a7ac8d7fbe..7dde4ca87752 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -414,6 +414,13 @@ union kvm_mmu_extended_role {
> =C2=A0 unsigned int cr4_smap:1;
> =C2=A0 unsigned int cr4_la57:1;
> =C2=A0 unsigned int efer_lma:1;
> +
> + /*
> + * True if either CR4.SMEP or EFER.NXE are set.=C2=A0 For AMD NPT
> + * this is the "real" host CR4.SMEP whereas cr4_smep is
> + * actually GMET.
> + */


If we adopt my suggestion of using 'role.has_user_exec_permission',
then I guess we won't need this patch?
What do you think?=20


Side question: Is it true that CR4.SMEP *on the host* is not needed for NPT=
/GMET?
(I wasn't able to find anything in the manual)


Best regards,
	Maxim Levitsky


> + unsigned int has_pferr_fetch:1;
> =C2=A0 };
> =C2=A0};
> =C2=A0
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 156bab8afbc6..912c8e97ef61 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -234,6 +234,11 @@ BUILD_MMU_ROLE_ACCESSOR(ext,=C2=A0 cr4, la57);
> =C2=A0BUILD_MMU_ROLE_ACCESSOR(base, efer, nx);
> =C2=A0BUILD_MMU_ROLE_ACCESSOR(ext,=C2=A0 efer, lma);
> =C2=A0
> +static inline bool has_pferr_fetch(struct kvm_mmu *mmu)
> +{
> + return mmu->cpu_role.ext.has_pferr_fetch;
> +}
> +
> =C2=A0static inline bool is_cr0_pg(struct kvm_mmu *mmu)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mmu->cpu_role.bas=
e.level > 0;
> @@ -5793,6 +5798,8 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct =
kvm_vcpu *vcpu,
> =C2=A0 role.ext.cr4_pke =3D ____is_efer_lma(regs) && ____is_cr4_pke(regs)=
;
> =C2=A0 role.ext.cr4_la57 =3D ____is_efer_lma(regs) && ____is_cr4_la57(reg=
s);
> =C2=A0 role.ext.efer_lma =3D ____is_efer_lma(regs);
> +
> + role.ext.has_pferr_fetch =3D role.base.efer_nx | role.base.cr4_smep;
> =C2=A0 return role;
> =C2=A0}
> =C2=A0
> @@ -5946,6 +5953,7 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu,=
 unsigned long cr0,
> =C2=A0
> =C2=A0 /* NPT requires CR0.PG=3D1. */
> =C2=A0 WARN_ON_ONCE(cpu_role.base.direct || !cpu_role.base.guest_mode);
> + cpu_role.base.cr4_smep =3D false;
> =C2=A0
> =C2=A0 root_role =3D cpu_role.base;
> =C2=A0 root_role.level =3D kvm_mmu_get_tdp_level(vcpu);
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmp=
l.h
> index 047400af924d..07100bbfc270 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -489,7 +489,7 @@ static int FNAME(walk_addr_generic)(struct guest_walk=
er *walker,
> =C2=A0
> =C2=A0error:
> =C2=A0 errcode |=3D write_fault | user_fault;
> - if (fetch_fault && (is_efer_nx(mmu) || is_cr4_smep(mmu)))
> + if (fetch_fault && has_pferr_fetch(mmu))
> =C2=A0 errcode |=3D PFERR_FETCH_MASK;
> =C2=A0
> =C2=A0 walker->fault.vector =3D PF_VECTOR;

