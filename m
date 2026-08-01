Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40E237713
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 06:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785565535; cv=none; b=UC8S9OZl0Z1WEVqr09+OutspFFXlOHiG5VLkG5nxNawJ6b4Mt65c/HGKgvzL/d7a65f76uM2uyM2Qfl64Kz14rMML4Ke7+tjNHoa+SM8694kDBEOgvjgaplUUPpnxBuGjFLiU2UNB2HrJMUhMZoYR8aCEmqnw6FMXzRYCHBvklk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785565535; c=relaxed/simple;
	bh=PdXVrYexpnKjXV+8SY1+DLa15l+I3CkXD26YryngjTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4aMQrqCfPJ0QHNO0SkFsQxNK7XEcjQ5tuwrtTVeUQY/DJY+FMeGN1oMz1ebsqjLNO3CCnPqQSfPFjyHKDg8mdl82ofnhFPk8sKF84EMVh2O7EG2M333Vu6HWW75+9HBWNUnW8guUdz8Sl+U2n+avA6v82HgkmoIsAppdKF8kHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOXvFrOu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOXvFrOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0F71F01559
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 06:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785565534;
	bh=yb2gj/Ty+CYFEXfoBe9L/5xPsDEsA4bgzq6vS2vwF0k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VOXvFrOukKedsBQ5N6QwmGxKolM12LXWx1f2oMOmi2QSL9nFm7kMg34gTLO91ffk7
	 2gBq8PH5znUAsRvX849+ZSoeCcUk9Az87ACrQHtpKVAI6myIGkeg0uBwsrczovlgEt
	 krgjrfn1lCtd7m6icJe/ssR+et7PiEY4ip8bf72ubTdVufNRWJTarIDVVTKbcuCeXn
	 H3UIvhgJHgfeZzqU0aubZ9u+0UXfwsIF3chGwdthtA8CxjYJ9hN0LBtBMjADz6GGB3
	 1l39XCOYwqXqiTsiU0MSn1UwlauOkw+RZHbBTDvXZlxcXz1m2ZppKEsGbX2bTS7Bz1
	 r79tnhXBW0WDA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c197eaaab00so282677466b.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 23:25:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro5E4+bxI1Z+6Wvsel/Oe4dNYcE3WFmgoGb9sWAT60xvtZ3ILSqAsRwQEJKxzqyTmpIk7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgfiNuv5nPnhQQ/MmhtUnqq6gpYD6wTAWKUgom+fnT19y9AINy
	8Safb7WqwMPt8FOcJeX5bsE783OU3q5e/D+TCXa9hWsfjzCmof8UyRaQEC8dvPd8EoCliZlLvsJ
	mcB3g7GmekGmzBJmJq7e0uKXGFvMDpHA=
X-Received: by 2002:a17:907:1c81:b0:c1f:c061:569a with SMTP id
 a640c23a62f3a-c1fe816753dmr137453866b.7.1785565533096; Fri, 31 Jul 2026
 23:25:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728003557.1136583-1-yosry@kernel.org> <20260728003557.1136583-11-yosry@kernel.org>
In-Reply-To: <20260728003557.1136583-11-yosry@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 31 Jul 2026 23:25:21 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMYx+63kuGv2La9d_e7FdPm=aGCUrXVpOGB_KSk4xV7kw@mail.gmail.com>
X-Gm-Features: AUfX_mxiZMXh4UXZDu_w8rzcaRtBvAFBpg5UvPhv3-NrOvefI00SNuH9ePzNH4Y
Message-ID: <CAO9r8zMYx+63kuGv2La9d_e7FdPm=aGCUrXVpOGB_KSk4xV7kw@mail.gmail.com>
Subject: Re: [PATCH v1 10/28] KVM: SVM: Use a static ASID per vCPU
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> @@ -487,6 +482,21 @@ static inline void vmcb_set_gpat(struct vmcb *vmcb, u64 data)
>         vmcb_mark_dirty(vmcb, VMCB_NPT);
>  }
>
> +extern kvm_tlb_tag_t fallback_asid;
> +
> +static inline kvm_tlb_tag_t allocate_asid(struct kvm_vcpu *vcpu)
> +{
> +       if (is_sev_guest(vcpu))
> +               return sev_get_asid(vcpu->kvm);
> +       return kvm_alloc_tlb_tag() ?: fallback_asid;
> +}
> +
> +static inline void free_asid(struct kvm_vcpu *vcpu, kvm_tlb_tag_t asid)
> +{
> +       if (!is_sev_guest(vcpu) && asid != fallback_asid)
> +               kvm_free_tlb_tag(asid);
> +}
> +

From internal Sashiko:
---
Can this trigger a kernel warning during SEV VM destruction?

In sev_migrate_from(), the source VM's active flag is cleared via
src->active = false. However, the source VM's vCPUs still retain their
SEV ASIDs.

When the source VM is subsequently destroyed, free_asid() is called. Since
is_sev_guest(vcpu) now returns false for the source VM, the SEV ASID is
passed to the standard allocator:

kvm_free_tlb_tag(asid)
        WARN_ON_ONCE(tag < tlb_tags.start)

Because SEV ASIDs are numerically lower than the normal tag pool start, this
will trigger the warning. On production systems with panic_on_warn, could an
unprivileged user exploit this by migrating and destroying an SEV VM?
---

This is similar-ish to the other issue in this patch, and more
annoying. The SEV ASID is only freed when the VM is freed, which I
assume only happens after all vCPUs are destroyed and free_asid() is
called. I am not sure how important it is to actually clear the SEV
active flag on the source of the migration, but I'd rather not try and
find out.

We can simply drop the WARN here and ignore attempts to free a
reserved ASID. Another option is clearing src_svm->asid in
sev_migration_from().
