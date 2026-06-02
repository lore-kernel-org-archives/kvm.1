Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4013EC2E1
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410271; cv=none; b=bPSyv/mosQ7noxHbyIigfBxPZDA7D0Mqr10FEWmXsmKHgSQjfSglSUSXFQbIVPCcltj6iMS1DpNelcQ1IDQbhBUqEiM9OAn74QLSNhVtqJCyIi70VwStVd2fJ37UBJ/GrCsXYQ7GjEndJgqXcxPD4NCmiS3nBpNZ+zWkIpYezH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410271; c=relaxed/simple;
	bh=yHWawHcRNy+Mlf/3GbgmyH5P0mKzD9qwHAo72JxYNeY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GPExll0iOJBROoS4iDDT32nyTaekj+ElWol0FDkCYmoCClsdlyISqARf6qvEx9vY6HxipNLmcvyxovx8v/C5oJpSEgDenDRvpjdXzHUu5puMMt1q17MiWuPT4/Mmtlo5qovogWhIe74Cep+0tqnhBQ+fJ6R9KogT7AKNTg7uU1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YIJDNbCS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFyl721d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YIJDNbCS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFyl721d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6qeqqoJSoBMzW4sniDDXZPSZAPEaf893MDZNg+z0GY=;
	b=YIJDNbCS1YxcCNfyMIqlHIDY+2S8nRNaCVEtFJ+gO9TDU3wiYuWAv4h/qkGQ63w7AfVFea
	Mu3jqbMQ+vbQXPVL8XUlnnB+QgmgtHb/cMNciRVWdEv5PRVhbO+GnO1qDEM4hj5aBZM/Pl
	Ifk+3GDdlAMue6RBiw9KjPIMOBL3xiA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-LxYZWs48OFi9b5OxWUx6MA-1; Tue, 02 Jun 2026 10:24:26 -0400
X-MC-Unique: LxYZWs48OFi9b5OxWUx6MA-1
X-Mimecast-MFC-AGG-ID: LxYZWs48OFi9b5OxWUx6MA_1780410266
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-517480bde1cso55214811cf.3
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410266; x=1781015066; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K6qeqqoJSoBMzW4sniDDXZPSZAPEaf893MDZNg+z0GY=;
        b=PFyl721d+XHUMKcyZIUPIQuMt0wJc/KqKSYz7tqUokp4a4J4HKN0Fs+oPd5YWf58V5
         m7dq4Y/v0iEeL493/G3OAyBHrJ8brjMabHIAu/j0veurV/mxFvDMkxV7AjC2vpRpFZ9A
         MP1FcwrLPM1nQ9JBwhK93DQd/G5B5mzE1CVG/o4CIKahcFc6xYu8Q5IjKfy830mJvM6n
         gX/+Y25oWUawrlyFDRJYkCP4B9zWzMPW7LAvkGYCJixZ/Oyy4D9CrDM30by4NGDVGHt7
         8gbltB77zb8ZlBNVwFCJyjm0f3T8w43ENVKh+u9nrQAe7fYG3ldO1ENDeEDdT7KT7HLY
         ePwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410266; x=1781015066;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K6qeqqoJSoBMzW4sniDDXZPSZAPEaf893MDZNg+z0GY=;
        b=FHRkLfj7npA34A4yHo1mnB7EINTpqhpj6bpgpjEUh2U4TBfYjz/ksTiW6BTsElWFgW
         0EiEJurzVK9TVTUFHTM0p3sDb0l4WO+5vM8B8uSw8jsLac4pRuToO0/dfATC8nnoGDGK
         DMdp904L5zYFF/ofHX/EsITcOcA6QjkdbiRjITUvZeQVNrWvW5osccsRcO5Wj+HB5atP
         WQArIhjWNbLNBSFfxryCje21G7S5MKtraytCvY70lq2nqQwg/wGX6NAjGEGj1Bi5nkyD
         FC/+zw59YRXFafAnGP/V8wNLyMebiG/s2hjY/6abNkzWgp+Cex2SF1XGaM06AmTMZY+8
         dIAw==
X-Forwarded-Encrypted: i=1; AFNElJ8mZLIXGlFhuXc2CY4+AkihI0AnfJurT6hCaw+B+4AhAntWO/7sYC1HBX6UrNuHADvLMvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi2G9cn6AO3Fzg3hkPXdZc5itW5CXtPq5VGwSUWJ7Mw8ygaQhb
	aG4ezu4nLGl3YGG0tl0N8sgpZXDsk2KWwhQt86bvOhPRkDiQ6FlF0h7peHSlDq1y6NyNvtFmcqO
	KfEVD1/RXGoYxcjdny/Nzq4hKfojVR7toJ4aqOHW3HtoRhZeWJnx3Sg==
X-Gm-Gg: Acq92OF6sqX63tb17zEffkCjXrjPuRuIYRN2pV+ppGNddHOza77atIYY67XELxYO1oP
	b99BfwbovbmwNwmafhCvT4+JihekcwRZNCcu3QgIPSfytSup1/1GoOIZncBhNZEwZ2XlARF9723
	dMgLsBSH04GLDv734jif2SSfhDGQhFZoWW7Ai5PwAYEPJ0tF2Hn/w0gOGknNEp5h9aVqv78ivn6
	CZ0Wm4ODa7V2FGlY9UJ+Z3YR5fI+3mgp+f6uExq2oJLJSCiG+RSn1T5QWZZ1ZRuRh85z+mHEjxs
	NDAfz5gw1ZNupnemdTeo1iWY4hqa+6VhH1/60Z4SQYknM96ZmNJLYTNSXJwpYVqqJ6DrSDp5Cuq
	9s3Zvkw4lWi/2R1ozT6I0pGoJWYDwmsDC4J6lJyk=
X-Received: by 2002:a05:622a:8d09:b0:516:d678:5337 with SMTP id d75a77b69052e-5173a821e2bmr199534211cf.28.1780410266031;
        Tue, 02 Jun 2026 07:24:26 -0700 (PDT)
X-Received: by 2002:a05:622a:8d09:b0:516:d678:5337 with SMTP id d75a77b69052e-5173a821e2bmr199533631cf.28.1780410265401;
        Tue, 02 Jun 2026 07:24:25 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51757c02ba9sm43829141cf.22.2026.06.02.07.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:24:24 -0700 (PDT)
Message-ID: <9a2b9700a835798fdc090035936be3e8680f3566.camel@redhat.com>
Subject: Re: [PATCH 12/28] KVM: x86: make translate_nested_gpa
 vendor-specific
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:24:23 -0400
In-Reply-To: <20260505195226.563317-13-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-13-pbonzini@redhat.com>
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
> EPT and NPT have different rules for passing PFERR_USER_MASK to the
> nested page table walk.=C2=A0 In particular, for final addresses EPT
> uses the U bit of the guest (nGVA->nGPA) walk.
>=20
> While at it, remove PFERR_USER_MASK from the VMX version of the
> function, since it is actually ignored by the tables that
> update_permission_bitmask() generates for EPT.

Hi!

Since this used to not to be the case, it means that in theory=C2=A0
this patch series fixes a theoretical bug in which kvm_translate_gpa would =
fail on nested EPT=C2=A0
if requested to do exec-only access,=C2=A0because it used to ask incorrectl=
y
for PFERR_USER_MASK=C2=A0access which is used to be translated to a read ac=
cess,=C2=A0
and therefore=C2=A0 a guest PTE having only exec permission would fail the =
check.

I am not sure it is worth mentioning this, it is likely impossible to hit
this, it is just something that came up my mind when reviewing later patche=
s.


>=20
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/include/asm/kvm_host.h |=C2=A0 4 ++++
> =C2=A0arch/x86/kvm/hyperv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
> =C2=A0arch/x86/kvm/mmu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 +++------
> =C2=A0arch/x86/kvm/svm/nested.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 =
+++++++++++++++
> =C2=A0arch/x86/kvm/vmx/nested.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 =
++++++++++++
> =C2=A0arch/x86/kvm/x86.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ----------------
> =C2=A06 files changed, 36 insertions(+), 23 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 8f2a1b915df9..62dc782b2dd3 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2010,6 +2010,10 @@ struct kvm_x86_nested_ops {
> =C2=A0 struct kvm_nested_state *kvm_state);
> =C2=A0 bool (*get_nested_state_pages)(struct kvm_vcpu *vcpu);
> =C2=A0 int (*write_log_dirty)(struct kvm_vcpu *vcpu, gpa_t l2_gpa);
> + gpa_t (*translate_nested_gpa)(struct kvm_vcpu *vcpu, gpa_t gpa,
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 access,
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct x86_exception *exception,
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 pte_access);
> =C2=A0
> =C2=A0 int (*enable_evmcs)(struct kvm_vcpu *vcpu,
> =C2=A0 =C2=A0=C2=A0=C2=A0 uint16_t *vmcs_version);
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 53688f7b76eb..f35fae3a7b3d 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -2041,7 +2041,8 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, =
struct kvm_hv_hcall *hc)
> =C2=A0 * read with kvm_read_guest().
> =C2=A0 */
> =C2=A0 if (!hc->fast && is_guest_mode(vcpu)) {
> - hc->ingpa =3D translate_nested_gpa(vcpu, hc->ingpa,
> + hc->ingpa =3D kvm_x86_ops.nested_ops->translate_nested_gpa(
> + vcpu, hc->ingpa,
> =C2=A0 PFERR_GUEST_FINAL_MASK, NULL, 0);
> =C2=A0 if (unlikely(hc->ingpa =3D=3D INVALID_GPA))
> =C2=A0 return HV_STATUS_INVALID_HYPERCALL_INPUT;
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 635c2e5d8513..63be5c5efed9 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -294,10 +294,6 @@ static inline void kvm_update_page_stats(struct kvm =
*kvm, int level, int count)
> =C2=A0 atomic64_add(count, &kvm->stat.pages[level - 1]);
> =C2=A0}
> =C2=A0
> -gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u64 access,
> - =C2=A0=C2=A0 struct x86_exception *exception,
> - =C2=A0=C2=A0 u64 pte_access);
> -
> =C2=A0static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_mmu *mmu,
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpa_t gpa, u64 access,
> @@ -306,8 +302,9 @@ static inline gpa_t kvm_translate_gpa(struct kvm_vcpu=
 *vcpu,
> =C2=A0{
> =C2=A0 if (mmu !=3D &vcpu->arch.nested_mmu)
> =C2=A0 return gpa;
> - return translate_nested_gpa(vcpu, gpa, access, exception,
> - =C2=A0=C2=A0=C2=A0 pte_access);
> + return kvm_x86_ops.nested_ops->translate_nested_gpa(vcpu, gpa, access,
> + =C2=A0=C2=A0=C2=A0 exception,
> + =C2=A0=C2=A0=C2=A0 pte_access);
> =C2=A0}
> =C2=A0
> =C2=A0static inline bool kvm_has_mirrored_tdp(const struct kvm *kvm)
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 961804df5f45..df232153eb24 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -2071,8 +2071,23 @@ static bool svm_get_nested_state_pages(struct kvm_=
vcpu *vcpu)
> =C2=A0 return true;
> =C2=A0}
> =C2=A0
> +static gpa_t svm_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 access,
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct x86_exception *exception,
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 pte_access)
> +{
> + struct kvm_mmu *mmu =3D vcpu->arch.mmu;
> +
> + BUG_ON(!mmu_is_nested(vcpu));
> +
> + /* NPT walks are always user-walks */


Tiny nitpick: Maybe we can extend the comment above to explicitly mention t=
hat
even for the last, actual guest memory access, the CPU pretends to do a use=
r access to the NPT?
(NPT is really weird...)

Something like that:

/* NPT walks are always user-walks, even for the actual guest linear memory=
 access,
regardless of the actual guest access (user/supervisor) */


Unrelated, If I understand it correctly, without GMET, NPT *does* check the=
 U bit, but
for all NPT walks, even for the last one, it requires the U bit to be set.

And with GMET, U bit is only used for execute access which can happen only
on the last level, and for reads/writes U bit is ignored.

To be honest, I haven't found this mentioned in the APM.
Is this mentioned somewhere in the APM?


> + access |=3D PFERR_USER_MASK;
> + return mmu->gva_to_gpa(vcpu, mmu, gpa, access, exception);
> +}
> +
> =C2=A0struct kvm_x86_nested_ops svm_nested_ops =3D {
> =C2=A0 .leave_nested =3D svm_leave_nested,
> + .translate_nested_gpa =3D svm_translate_nested_gpa,
> =C2=A0 .is_exception_vmexit =3D nested_svm_is_exception_vmexit,
> =C2=A0 .check_events =3D svm_check_nested_events,
> =C2=A0 .triple_fault =3D nested_svm_triple_fault,
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 3fe88f29be7a..cd1924c6e075 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -7438,8 +7438,20 @@ __init int nested_vmx_hardware_setup(int (*exit_ha=
ndlers[])(struct kvm_vcpu *))
> =C2=A0 return 0;
> =C2=A0}
> =C2=A0
> +static gpa_t vmx_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 access,
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct x86_exception *exception,
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 pte_access)
> +{
> + struct kvm_mmu *mmu =3D vcpu->arch.mmu;
> +
> + BUG_ON(!mmu_is_nested(vcpu));
> + return mmu->gva_to_gpa(vcpu, mmu, gpa, access, exception);
> +}
> +
> =C2=A0struct kvm_x86_nested_ops vmx_nested_ops =3D {
> =C2=A0 .leave_nested =3D vmx_leave_nested,
> + .translate_nested_gpa =3D vmx_translate_nested_gpa,
> =C2=A0 .is_exception_vmexit =3D nested_vmx_is_exception_vmexit,
> =C2=A0 .check_events =3D vmx_check_nested_events,
> =C2=A0 .has_events =3D vmx_has_nested_events,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 67979b7de5d6..7c6942afae81 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7848,22 +7848,6 @@ void kvm_get_segment(struct kvm_vcpu *vcpu,
> =C2=A0 kvm_x86_call(get_segment)(vcpu, var, seg);
> =C2=A0}
> =C2=A0
> -gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u64 access,
> - =C2=A0=C2=A0 struct x86_exception *exception,
> - =C2=A0=C2=A0 u64 pte_access)
> -{
> - struct kvm_mmu *mmu =3D vcpu->arch.mmu;
> - gpa_t t_gpa;
> -
> - BUG_ON(!mmu_is_nested(vcpu));
> -
> - /* NPT walks are always user-walks */
> - access |=3D PFERR_USER_MASK;
> - t_gpa=C2=A0 =3D mmu->gva_to_gpa(vcpu, mmu, gpa, access, exception);
> -
> - return t_gpa;
> -}
> -
> =C2=A0gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct x86_exception *exception)
> =C2=A0{


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

