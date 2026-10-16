Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B247B3A4521
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 04:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125864; cv=none; b=MyOK/Ze0JOkQd8A268+A78XrrgkXDCuTv0JBUFify9dNGYBH5in/LJXRJG1MpridwtBMbRQ7wM1HmcgrfeePAZmvj/U7hoC2bYA1gbXPYlMt42a3EbqxIOaHVAo5L049y36zXbnpiJacjnPLdwwtbOildngMkckoajt+lhJmlAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125864; c=relaxed/simple;
	bh=LfHea5JuL4GUn6cXUPkEcbUBe4JbbrwRPAH8sTSrj14=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mm/RCeR4d0/Dhly4h5i2DPySRjpRg/hsvgX+cu19zCWzWafAHSc0r16UaRSAbh+DOhUWpLsbtpY9MLKc4KdEtBa95c4dMwSVV9D/Qx9u1UNPYPgq9WJ1+QfwsfbrE8iVH81LMmRwMEf2jkH1QMQGgd5NdPlPVJht6XbDLSMtgTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q2E/su3G; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q2E/su3G"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2df8484f12cso68039855ad.3
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 21:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792125862; x=1792730662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vb5br/eMh4MqVCAUtcyG7S23Z9Sb0D7nhQLL2kHxXuc=;
        b=Q2E/su3GeEK993XgJXUoa82YoLMRe4U5o5RLSHFP5jbWijOvpX1x2QskO8E9dOfjUz
         4dsuA46KZAQz4AsEHYYT3wcmG2fm8zNg5XHyzt+0C/pgdcNM5WTNCRQ+DZtZZdYLQX3E
         9IOEaM/1LHJ76smm3ue/F5EmKbJq8qqH+f0cR01xBMLt4ULPJZL22o1PAJJmdyaRnt0j
         By70lVnsNT47K2c4gwcPE7fhhTga+BCQyCUwjUH6ZUfQRwmkgJeA/KJvvvvcdZDFIz8W
         q5aWwAYX22gad1vZba0D1YUY0k4IEJhzEVxBZB0RpdA+yQl46EQL0iiJV4Vo9uE8vJ4q
         PHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792125862; x=1792730662;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vb5br/eMh4MqVCAUtcyG7S23Z9Sb0D7nhQLL2kHxXuc=;
        b=v6+z/+oFe9Ng4J2dzTIt9LPqesDXrh9T5mC5kqrpieRVSd3AcO/sxU2lqN1pkDarXZ
         G5DNjNtRkpxmz8sgCtT1GiZasr6k/vD4Gq27LVh7fXQoPYQ6fU42sWuzOUuWpfKCARI5
         Z0yqyq+W6rlFG4Io3NYqOj9+7yswj0OKNTqrdvwTQbdgGh7LgSVVKqqDWRwboYzJBNci
         SecbHEVqs7PaZJYN1PXy+GHEbHAdTCFwDDIZ3dvVNftD089lCgEGeuDO6MfeNBljHSSA
         p58t71d49iM3Mij0Rw7ZXUe1OIpZvFLFiCblxaoaqV06mDBR3O/bzETKOxHhKaomyM6h
         3rNw==
X-Gm-Message-State: AFq9FYIZ66PyXDUmcg2liH+8Kw6GLECTFm3Jl7+7BdHjLWzPlfhgcmEB
	4kTBqsbvw2Iv2FvU9oKO3bmZWaymFPqJYBsady5UlfBmPJyAYmLvdd2XV/dxoElQpwMLu34EX1v
	Mq5h0FQ==
X-Received: from plcr18.prod.google.com ([2002:a17:903:152:b0:2e5:399b:1731])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:9cc:b0:2e9:5c55:c472
 with SMTP id d9443c01a7336-2e95c55c7e9mr42427795ad.42.1792125861714; Thu, 15
 Oct 2026 21:44:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 15 Oct 2026 21:44:09 -0700
In-Reply-To: <20261016044415.958618-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016044415.958618-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261016044415.958618-5-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: MMU changes for 7.4
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The following changes since commit d4b7fb647204f0c81dfeae2d1a708e4d858e0c94=
:

  Merge branch 'kvm-xen-longmode' into HEAD (2026-09-04 17:35:03 +0200)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-mmu-7.4

for you to fetch changes up to 31adfe155db60a58b61e5b3d472cf85336ff3daf:

  KVM: x86/mmu: Fix NX page unaccounting for TDP MMU pages (2026-09-29 06:2=
9:11 -0700)

----------------------------------------------------------------
KVM x86 MMU changes for 7.4

 - Grab KVM's SRCU "lock" in kvm_zap_gfn_range() to fix a recurring bug whe=
re
   callers fail to do so.

 - Fix a variety of issues in the pre-fault code that are mostly benign in =
the
   current code base, but will show up in big ways if/when the pre-faulting
   logic is used to implementing prefetch-on-fault for the TDP MMU.

 - Guard rmaps with mmu_lock for PREEMPT_RT=3Dy kernels to fix a longstandi=
ng
   issue introducing by "lockless aging" where KVM would take its effective
   raw bit-spinlock with preemption enabled (because mmu_lock gets turned i=
nto
   a sleepable lock).

 - Prepare a memory_fault exit (paired with -EFAULT) when KVM hits an error
   PFN, e.g. so that userspace can resolve transient issues instead of kill=
ing
   the guest.  Convert a variety of WARN()+EFAULT paths into KVM_BUG_ON()+E=
IO
   so that KVM can hard commit to filling memory_fault on -EFAULTs that occ=
ur
   in the page fault path.

 - Fix a NX hugepage un-accounting bug where KVM would always uncharge the
   shadow MMU, even when handling TDP MMU pages.

----------------------------------------------------------------
Anish Moorthy (1):
      KVM: x86/mmu: Report a memory fault exit when the fault handler EFAUL=
Ts

Carlos L=C3=B3pez (1):
      KVM: x86/mmu: Fix NX page unaccounting for TDP MMU pages

Chengfeng Ye (1):
      KVM: x86: Take SRCU in kvm_zap_gfn_range()

Mikhail Malyshev (1):
      KVM: x86/mmu: Convert can't-happen fault path EFAULTs to KVM_BUG_ON()=
 + -EIO

Sean Christopherson (6):
      KVM: x86/mmu: Reload MMU on *every* page pre-fault attempt/iteration
      KVM: x86/mmu: Harden "map private PFN" against unexpected root invali=
dation
      KVM: x86/mmu: Top-up memory caches when retrying "map private PFN"
      KVM: x86/mmu: Add sanity check to detect stale page faults in "map pr=
ivate PFN"
      KVM: x86/mmu: Always guard rmaps with mmu_lock on PREEMPT_RT=3Dy kern=
els
      KVM: x86/mmu: Bug the VM if KVM attempts to unsync an upper-level sha=
dow page

 arch/x86/kvm/mmu/mmu.c         | 124 +++++++++++++++++++++++++++++++------=
----
 arch/x86/kvm/mmu/paging_tmpl.h |   4 +-
 arch/x86/kvm/x86.c             |   2 -
 3 files changed, 97 insertions(+), 33 deletions(-)
