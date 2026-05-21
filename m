Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A94E397321
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779392368; cv=none; b=lsrJv2t6i2PuiIrr1JCQHG7X7SGoc3s3YiBHmMwLz0SRDvupC0UHzHTO3iwjSgOeR4hk22mkg4FEiPYFCCgXswsmPFqpHqw42bBWnxMkErAslzJ3XtJqRsQdlBUZ3yf61J+w+5e4hC8HbcCZQOT0xxAKrmkxnPESLj1LRCaassM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779392368; c=relaxed/simple;
	bh=nMKBG3rJEEmkklBedmybAaMiMGB0p2z0B38+ldGC88U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MpGbqWwqc0WvxgighYoPGjuUJzPmRrYNHHBqsjXN316861RBK6lAciLC3BykuMxk0QIEqP9HFj4GDaawokaAWlhzObQGfBNeljplgFyatymNBQkOQDMUz/ufP4ZIWOKPOZd2Eui1zee6TzSbwXVEmV4gpi6yEra6eh77sDDfUyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sxxqFeSt; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sxxqFeSt"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b9b8137828so66442145ad.0
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 12:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779392366; x=1779997166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dsmzNvta+Ewkoo3CGEB6qYEmj2PCAz/7ILR9KeZC9gU=;
        b=sxxqFeSts+u4+wLIJ6q0CG7jpPZXKJq5VN1rMkqHFiuSJf4Dmf44tPdK0CnKlcbP1S
         QFIfkOKfJw98M/Z89MW4u4BeQhGknsdcGcvktQPJmhTFQaC3KuwUkcOpyLF1CmSgR7h3
         pO3LC/QbXApp1qFojNGEhVa8UoCBrTAuNBgEYK3bVzoMAWbtTl3DBBBYfWI3GCknGQXG
         LSbPvNvBaILuO5xTrTfDyKKksc6+AE95MD92kRGAaZ+MossBH7YzNWcZRiMVrAXdVJjd
         yuz5Ou4+4xw7rv+vSq7q2PSvFzQ/N6i7MRPrTCNshdTS/Qlp0b5ih6uzYXd3dRB3Gq5m
         VktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779392366; x=1779997166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsmzNvta+Ewkoo3CGEB6qYEmj2PCAz/7ILR9KeZC9gU=;
        b=mVmZ4lAms3evQCj8Up4P7zNb+V7/LtAeUkELpCG72q7wmAIywskAkO4b4LZoTZRzkE
         9E/OkTxn0GoibcSGjoXG+y2szJKvUSaaLHtlNzmey9ajsUlxM6ZEdWS8KrD90iEW30cU
         yE1wjRDnirn/am9PBezwrlpw05i4KGK8kuOGxaU4/BQLad5wi6EqkejM4no8m3etbMzX
         VLWCH/6Bvciw1nY7oyWUnXBGuuFS40aGLOTHfCE3ab8LHTOZMBU5cXcFcDbymkPAdL4i
         8ZmJ1I4jUni6I0FDUnaaTkId9WmRntz0dSUv8zSLpdsDW+NTJln/bNcRPw7Gv/fJKwdg
         xmBg==
X-Forwarded-Encrypted: i=1; AFNElJ+si458yeZ6U/BFMi7CGnC0EEwMONzYdjg3WCwfXMln1dTVa1G8VksFZ87tF7dvUH5nD1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSVuDgKnHb6xktB+EZNjiTB7T9ACM+GgSqYH0tVf6FFrxdp2Xc
	3emx23WksRXrPP0D5auxWZPQW0MDcICJTAr/JMQ/Ep6cE/NOk2jqY+a1gQIORi9A7fA549ECrcb
	5xPTCeQ==
X-Received: from plzt11.prod.google.com ([2002:a17:902:bc4b:b0:2bd:9574:2958])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e541:b0:2bd:e452:a484
 with SMTP id d9443c01a7336-2beb06fad0dmr2885405ad.33.1779392366325; Thu, 21
 May 2026 12:39:26 -0700 (PDT)
Date: Thu, 21 May 2026 12:39:25 -0700
In-Reply-To: <CABgObfZ+TXrw7UpMt2DQUYb6Gwr-+vHy8E3iNbP8WB2z=+1ZTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511150648.685374-1-pbonzini@redhat.com> <20260511150648.685374-18-pbonzini@redhat.com>
 <CAO9r8zMeg1ta0hL4panuB3D-10PmkwHL+9XKv_0NVjcpq0oJMg@mail.gmail.com> <CABgObfZ+TXrw7UpMt2DQUYb6Gwr-+vHy8E3iNbP8WB2z=+1ZTw@mail.gmail.com>
Message-ID: <ag9fbbWzOO0r777I@google.com>
Subject: Re: [PATCH 17/22] KVM: x86/mmu: pull struct kvm_pagewalk out of
 struct kvm_mmu
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Yosry Ahmed <yosry@kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Jon Kohler <jon@nutanix.com>, Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, May 19, 2026, Paolo Bonzini wrote:
> Il mer 13 mag 2026, 23:36 Yosry Ahmed <yosry@kernel.org> ha scritto:
> >
> > However, I can't immediately tell what vcpu->arch.cpu_walk is doing
> > either (compared to vcpu->arch.tdp_walk), so maybe the names can be
> > improved? If these walks are tied to these MMUs, maybe name them as
> > such (e.g. root_pg_walk and guest_pg_walk)?
> 
> No, cpu_walk is always GVA->(n)GPA and tdp_walk is the optional
> nGPA->GPA stage. While there is a 1:1 mapping from a struct kvm_mmu to
> kvm_pagewalk when doing shadow paging, for *emulation* purposes
> cpu_walk is used for both L1 and L2 and It replaces the
> vcpu->arch.walk_mmu pointer from the old code (which led to either
> root_mmu or nested_mmu). In fact the main change in the series is the
> removal of walk_mmu, with cpu_walk always representing the CR0/CR3/CR4
> page tables.
> 
> I could call them gva_walk and ngpa_walk, but I think the current name
> are also self-explanatory (especially once you understand that
> walk_mmu is no more and cpu_walk can be used for both L1 and L2). The
> confusion comes more if you look at the walkers from the POV of struct
> kvm_mmu. Which leads to the other half...

I like gva_walk and ngpa_walk, a lot.  A lot, a lot.  I also find cpu_walk to be
ambiguous and confusing.  It's not like the CPU walks GVA=>GPA but something else
walks GPA=>HPA.

> > I also think root_mmu and guest_mmu could still use some improvement
> > but that's probably outside the scope of this series. These are
> > essentially L1 MMU and L2 MMU, right? Maybe just mmu and nested_mmu
> > could work? But I am not sure if we can reclaim the nested_mmu name,
> > it's gonna screw with anyone doing backports :/
> 
> And even more important vcpu->arch.mmu is the pointer to either
> root_mmu or guest_mmu. I wouldn't reclaim either mmu or nested_mmu.
> 
> guest_mmu is not L2 MMU if L1 does not use two-dimensional paging, so
> l1_mmu and l2_mmu does not cut it entirely. And root_mmu can be either
> GVA->HPA or GPA->HPA, therefore applying the idea above (e.g., gpa_mmu
> and ngpa_mmu) would not work well.
> 
> I suppose guest_mmu could be ngpa_mmu or shadow_tdp_mmu, but another
> possibility/refactoring would be to adjust the code and call the two
> MMUs direct_mmu and shadow_mmu. I haven't looked into what this means
> for the code but it would definitely make for the clearest naming.

I'm not a fan of "direct".  Even if we deal with the CR0.PG=0 case, there's still
the direct shadow pages wrinkle.

I do like the idea of reworking the code so that there's an MMU for non-nested TDP
and a shadow MMU for everything else.  Given that the only thing standing in our
way of having tdp_mmu and shadow_mmu is the existence of TDP support in the shadow
MMU, what if we finally drop that?  Then we can have tdp_mmu, which is literally
the TDP MMU, and shadow_mmu.

> Having direct_mmu->w be NULL would be nice, so it seems promising but
> not something I was going to do soon (the *real* reason to submit this
> patch now is to get rid of is_executable_pte() half-assed support for
> MBEC/GMET, and that's where I stopped).
> 
> Even with the small complication that CR0.PG=0 is a direct mapping but
> would use shadow_mmu, it's still a GVA->HPA mapping and thus pretty
> understandable.
> 
> tl;dr: naming is hard so I tried to change as little as possible in
> this respect...
> 
> Paolo
> 
> >
> 
