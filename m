Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894544457A2
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784759827; cv=none; b=PTmc7EfZ6n0pCLrYKcdrLA3hIDCqif4FL2j2FiHe/epmRrWUneYARy41JY1Y2Y6YEU2hNAyiQ+UfbhROCGLUGvDJCOvjdXPKRA9DXOtpgicBxnLJ5/uNa/+q2MeJ/Z7lluR+JZxbuYCSsPlO93d3/8nC1Yc07fEY+1o1ODZTjPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784759827; c=relaxed/simple;
	bh=s3JKsHKGIsrpDnQdhuAr/074k7lAmdznQBqtLplhEKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSu10HZwwgjcGZZm+NtgCZTt2hSYyAPZR+EtciuOQnicoD8UFh0A4alaWClXgllgKtgbwMnPzUgwEz57QdQaXU3fuLT3vPogzV459Dr45I852aMcToiqh9V6gtPXROo1Mokfn/zmBXPWa5/QeBMhX5WYnDvRXp558Yx6puKAySM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcP5pl64; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcP5pl64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3885C1F00ACF
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 22:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784759825;
	bh=2YyESR4ahS9/r9dLQjl3Q7ag7pvJGSQ/7mpTOXscFlk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QcP5pl640NDSvBZ3EcqOY88laU+v8MrgVDuq25G3NQOURHYCYdEXNnWDaMhMUOAaw
	 Aj2S8tONFBxZ5JNgCK0URwCLizLgb6c0ocFJOU3VexPVrUKz1x5A1ksK6Fp+MK/aAi
	 aw/WkrFsQYV9z0W8U/F56xRmaM1wA2NaTv+Sk9WUO+XMMo+33hQpXcO7zS0vG47kiF
	 MpclwIgw3f7hbhYAYHh3vNtrSY/PUMAcPRj7u9+/uMXoV199XJyak0/JEt83JkXWtG
	 gnZnz4+08iFzecFVU2ibNkyCX3+CBcSNnoJaBzIwLjcub4mR/Bf/oexJwk0zyRTiX0
	 M9hq2+sQDutXA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso9593419a12.0
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 15:37:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RouT4UB77u1Ntlf3+MfwPD5CLcUJHf0bVlFOhml45K5u1O3IWP67vpmzfE+iupZViDbUlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7z/Wjuv+9t1XIRcfQ3KgjfxQHhwJpY0MYRH/qfn97pQQeptAh
	3uUZBUfAgemLIOIkmXBEopm2qxuKXFMflCVb6M4BbK78sBJ0+17qCz1lWlGbubSWQgrbnauSz6E
	PZ34PkOQK8RsDAhH7wuq9BDwYR4F4pEo=
X-Received: by 2002:a17:907:70a:b0:c15:c323:36e5 with SMTP id
 a640c23a62f3a-c1c536b9134mr6297866b.10.1784759824012; Wed, 22 Jul 2026
 15:37:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-4-yosry@kernel.org>
 <amFDk2aenQTZUHs-@google.com>
In-Reply-To: <amFDk2aenQTZUHs-@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 22 Jul 2026 15:36:52 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMjh0gJkAFKioX3Ed_oQY+UiH7WYJjPt-MyJODeGUd=vg@mail.gmail.com>
X-Gm-Features: AUfX_mzxSJixYfVRoImIMU9jl0r_40QkOzGd706PbsvIjpA6ZpND0D4TWNhwgfQ
Message-ID: <CAO9r8zMjh0gJkAFKioX3Ed_oQY+UiH7WYJjPt-MyJODeGUd=vg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/25] KVM: VMX: Generalize VPID allocation to be vendor-neutral
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 3:26=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Jun 16, 2026, Yosry Ahmed wrote:
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 9368a71336fe4..e021ed562502f 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -8192,4 +8192,68 @@ void kvm_mmu_init_memslot_memory_attributes(stru=
ct kvm *kvm,
> >               }
> >       }
> >  }
> > +
> > +static struct {
> > +     spinlock_t      lock;
> > +     unsigned long   *bitmap;
> > +     unsigned int    nr;
> > +} tlb_tags;
> > +
> > +int kvm_init_tlb_tags(unsigned int nr)
> > +{
> > +     if (WARN_ON_ONCE(!nr))
>
> I think we should cap @nr at 0xffff, i.e. at VMX_NR_VPIDS -1.  If we end =
up on

Why not VMX_NR_VPIDS (i.e. 0x10000) like the current implementation?
Is it to avoid allocating an extra long just for one 1 bit? It would
be a change of behavior for VMX tho, not that anyone would care.

If we do this, I'd rather replace VMX_NR_VPIDS with a generic
MAX_NR_TLB_TAGS, and just have the VMX code use that. WDYT?

> a system (e.g. in a VM) that supports 4 billion ASIDs, KVM will burn 64Mi=
B for
> the bitmap, without any reasonable hope of actually consuming anywhere ne=
ar that
> many ASIDs.  Burning at most 1024 bytes is far more reasonable.
>
> To provide some defence against future systems, maybe pr_warn() or someth=
ing if
> the number of ASIDs is capped?

Sounds good.
