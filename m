Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16E433343C
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813214; cv=none; b=CUUvUcoDzTZeQGqGuvZneG3z7gyJLAyrh/mFsEKj0K3DxVybWiR2jBi+Fhs3nmhF4gRPlS4Oc5RLPdOElKImZYoKIKNv0NxlhwNxQI1uxl8WKoXB4CKm4tvyWGbavzZWqZEwR8IXkeiswpRgOhYkZNTlb8Wvsy48RgFZasE8sQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813214; c=relaxed/simple;
	bh=7W5loQsxEPlIqdixs/boZ9QF2TKo7If3JoR1llY0kys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=il4jXglKI1ZCTIbukCHJBgRyc17Unx96ub06mmbfF55/JEsbQmS2TIdkwct0AjGNJmTU4VGxJaEq1Lk3HDLMGx3G1N+AK/aNd35C1JSy3XuN1VENMPXYkW1h12S8rFpO5cqzYpCxMeFV0GQOiZzHsCnXBXIQCzDk9byVZDjghmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f9Ac8GrL; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f9Ac8GrL"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccb6823efcso6810045ad.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 06:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784813211; x=1785418011; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XB78eBb1bQcNBielLx0mwRZgYzoYsmWQjD0VYPuwXXk=;
        b=f9Ac8GrLReVrggxSQQxHn3wwWMPu1CbZfCR7kAhHDFwI0adXVwVmPAT2MZiRrmX8ie
         xdCoHpDBtCH1bLg+m3NtCFdG6jml/d2blURZYHvZpcTQS5+6SNgqF7N+GShHONzqRVpn
         3BrHiF2jY+FjJC9XCiLhJWU7aIOF02wnocVGtLts7Bcar3+veMULHweBSnQdPvHB6X/F
         OxjbR28bJxaLGCw3rpBdgR0sfZpAlMY0J+j8b68IAO1YSjYYlwQMNbIK5BhxHweNckoO
         LyI4Y5YYQoE6HGMaPk/ASa+v3kC8S1DcviNYYAdoamRyB1mP4rPEapfwddctUEvCaSe8
         2n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784813211; x=1785418011;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XB78eBb1bQcNBielLx0mwRZgYzoYsmWQjD0VYPuwXXk=;
        b=cZTuX3oXQ3z7RjtoFfRco3Dly+StCE6WzP6b4cIfCMT0kOO0e+KZxa4u5R8d9kxySI
         4CRkARtv85RQdWRfLlFn5CX5rK3MNBW3I9TXP8xa3/HaXlGg8T3s7fyVhWC8wSF6tAFP
         gDVDN7lFHm94pX3XAz5kYlfFUDp8YzfMBDbRwAIj2Kki3PwYGIXS0iow1rQbG1q7PIQN
         H7bt2+2P4/olAXUneoh88OA4A9KbzXJNiN35BpAqeOzNBQG1W3GwZd0AB9oHeglkKJo/
         bStt4WqOontTTc5VUKm09Rl8J1t8e1THulLd6G0CL9xI6KX0Fic90wvg8ebGU9zbK+2G
         2OHw==
X-Forwarded-Encrypted: i=1; AHgh+RqQoa5jbGTms8cpCHr5leM6Js88Ap1Sk6trev01HfMiGfw8R/5FfDORK6E4VyQdSEG+8Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1Ae3OAoZrqgBgAZ9R7QSvjoVHQ5CiNthMKue3vh1uVLHuk0C
	T2WOOXWaxEVppbD8o5xycVFsH10jJ1BrNoG95Pgpuc3iFoniKPoWnAdW+/8pFEExH7uq4uw2BCO
	4UqSW8w==
X-Received: from plbms3.prod.google.com ([2002:a17:903:ac3:b0:2ca:e163:e0c8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:ac6:b0:2cf:9f62:1dcd
 with SMTP id d9443c01a7336-2cfa6d83500mr42509495ad.32.1784813210741; Thu, 23
 Jul 2026 06:26:50 -0700 (PDT)
Date: Thu, 23 Jul 2026 06:26:44 -0700
In-Reply-To: <CAO9r8zMjh0gJkAFKioX3Ed_oQY+UiH7WYJjPt-MyJODeGUd=vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-4-yosry@kernel.org>
 <amFDk2aenQTZUHs-@google.com> <CAO9r8zMjh0gJkAFKioX3Ed_oQY+UiH7WYJjPt-MyJODeGUd=vg@mail.gmail.com>
Message-ID: <amIWlDNNniaqUekc@google.com>
Subject: Re: [RFC PATCH v2 03/25] KVM: VMX: Generalize VPID allocation to be vendor-neutral
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026, Yosry Ahmed wrote:
> On Wed, Jul 22, 2026 at 3:26=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Tue, Jun 16, 2026, Yosry Ahmed wrote:
> > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > index 9368a71336fe4..e021ed562502f 100644
> > > --- a/arch/x86/kvm/mmu/mmu.c
> > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > @@ -8192,4 +8192,68 @@ void kvm_mmu_init_memslot_memory_attributes(st=
ruct kvm *kvm,
> > >               }
> > >       }
> > >  }
> > > +
> > > +static struct {
> > > +     spinlock_t      lock;
> > > +     unsigned long   *bitmap;
> > > +     unsigned int    nr;
> > > +} tlb_tags;
> > > +
> > > +int kvm_init_tlb_tags(unsigned int nr)
> > > +{
> > > +     if (WARN_ON_ONCE(!nr))
> >
> > I think we should cap @nr at 0xffff, i.e. at VMX_NR_VPIDS -1.  If we en=
d up on
>=20
> Why not VMX_NR_VPIDS (i.e. 0x10000) like the current implementation?

Purely because I wrote that suggestion when looking at that final code in t=
his
series that passed "VMX_NR_VPIDS - 1" as @nr, and didn't think too hard abo=
ut the
math.

> Is it to avoid allocating an extra long just for one 1 bit?

FWIW, it's not actually an extra long, __KERNEL_DIV_ROUND_UP(0xffff, 64) an=
d
__KERNEL_DIV_ROUND_UP(0x10000, 64) both come out as 1024.

> It would be a change of behavior for VMX tho, not that anyone would care.
>=20
> If we do this, I'd rather replace VMX_NR_VPIDS with a generic
> MAX_NR_TLB_TAGS, and just have the VMX code use that. WDYT?

The VMX code should use VMX_NR_VPIDS, that's its architectural max.  I say =
avoid
a #define and keep the limit internal to kvm_init_tlb_tags().  I can't thin=
k of
any reason to expose that limit outside of the allocation.  E.g.

int kvm_init_tlb_tags(unsigned int nr, unsigned int nr_reserved)
{
	/*
	 * Limit the number of TLB tags to VMX's hardcoded maximum of 0x10000
	 * to avoid wasting memory for the bitmap in the unlikely scenario the
	 * CPU supports an inordinate number of ASIDs (on AMD).  If userspace
	 * wants to concurrently run tens of thousands of vCPUs, they'll likely
	 * need a solution that works for both Intel and AMD.
	 */
	const unsigned int MAX_NR_TLB_TAGS =3D VMX_NR_VPIDS;

> > a system (e.g. in a VM) that supports 4 billion ASIDs, KVM will burn 64=
MiB for
> > the bitmap, without any reasonable hope of actually consuming anywhere =
near that
> > many ASIDs.  Burning at most 1024 bytes is far more reasonable.
> >
> > To provide some defence against future systems, maybe pr_warn() or some=
thing if
> > the number of ASIDs is capped?
>=20
> Sounds good.
