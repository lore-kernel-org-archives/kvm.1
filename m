Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D4A449980
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790979151; cv=none; b=cf4MKpNyO33m9yx0lV4GLLbPAru/pP99QxaoWO5bp7xOQoc8//7PwXycYxf1NtEV1yw+4mkJh/kmLUkRftS2QIwQeV5BLFTJ8P3vJUgBAku6Q3JWfyr1el2IksligB6GezWyBfn+1kFRZmNzb0ZtudFK32lrVSV0EcMInepMgj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790979151; c=relaxed/simple;
	bh=kkiqdAS4BmeIKPvSPLaJlWr8VEOz3hct2LQ4xfgY4+4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TrSXHMS9fyVK0PcgNsCK4obEMfqWmWgUZXvuTaaLDSlFVNLtFvvxHhn83QoRtTPvTzpSjYktwsuPYVLVXFOjo/guslSbMxnOEYKnrcKTSGo/57sFgMvBk0gF0A840w1FWM7BnsJQi09Byvl9eGuWfW1cACxjPNkHw5tktx2SxI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p8ci6vrr; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p8ci6vrr"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-887c99013edso35781b3a.3
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 15:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790979150; x=1791583950; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m+BE8hAAq8CojA7/qWTm+y4+V1+d1I0cqoqJfhKPjfM=;
        b=p8ci6vrrR2Wq5Tjb4E4iRa6yZb8P8D0NwUhLezvcLAbUbKCw97wZ0vyoyUXuTNmYIP
         GyBvAX3p5ooaFjoYb2D88R7jLA2svp2WfrqfxkBl2heIP+Pl9qJKD5De2RlU+iG+CeLR
         UuMAxU0Fq97Uh7VLmi/s4fuOb3dxFrdL+vY5tZJm7LtxPrbHIpjBoMpJ1OuqQ7VwO/yQ
         BaYtnf3jfKrqMMy4EOwtuwWih+is1PkiGT1IQ4ohlZaxvIbBiUEyaOBdOb7EX+/9KwoR
         taRUOdLSLjQAQv3vmdcXhXWrQdvONshhjuMjziEH7A7yhQUxkkX7MA4HspKLx1KXChzh
         fhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790979150; x=1791583950;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m+BE8hAAq8CojA7/qWTm+y4+V1+d1I0cqoqJfhKPjfM=;
        b=rsTmzriNfaP6Plzflldkt0bESmmQMi25PD/nO4OfLa8+ef/e0FEkPnwmmTTHBPpkdL
         MhH0LhKGjNCGjy4EYb5rHUxhZ4XvJdvdN/V5Uk3QwBLkCSZpT8ltzITk3LUXPCc4a0uV
         x73EVI1s3A+wn6UKTnuLYYqaC6qxvyohWsS33urFF/twJUNtCo8S8WT6WapBoLgvdh36
         2Yqc5GA422EdbkrzlJn1KQZLKKlc3hQwfXBYns0QratGuEOe+eoY0K/bgo8B3EreVm6A
         nZSxsvyOVTD1SiC9EP+M05EdrSauE4t1bC3opasTVvadCqx2wEGK0WN2Fy9/0+xj6m29
         SbxA==
X-Gm-Message-State: AFuF++kpx4Nu3q38Z6MJTY87Vz6B3UiU7ckEFplDb16hNm9VJdMfFhmo
	kmo4qSE7UjW3lWCIHlRiL8o4ofQ6MLU0YrBbaVQIUdoS5mOOOsd9HI9wlpkYFxvolBgVrod5gqk
	Ukej+dw==
X-Received: from pgaa6-n2.prod.google.com ([2002:a05:6a02:6486:20b0:cca:bb35:aa9c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:748a:b0:3e0:b937:8829
 with SMTP id adf61e73a8af0-3e0d6ce0ea7mr619313637.51.1790979149504; Fri, 02
 Oct 2026 15:12:29 -0700 (PDT)
Date: Fri, 2 Oct 2026 15:12:28 -0700
In-Reply-To: <de328dc973a135a956a148dd83d8353b7157d452.1790101179.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790101179.git.ritesh.list@gmail.com> <de328dc973a135a956a148dd83d8353b7157d452.1790101179.git.ritesh.list@gmail.com>
Message-ID: <asAsTMn8naXCxhno@google.com>
Subject: Re: [PATCH v5 1/9] KVM: PPC: selftests: add support for powerpc
From: Sean Christopherson <seanjc@google.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 22, 2026, Ritesh Harjani (IBM) wrote:
> ---
>  MAINTAINERS                                   |   2 +
>  tools/testing/selftests/kvm/Makefile          |   2 +-
>  tools/testing/selftests/kvm/Makefile.kvm      |  10 +
>  .../testing/selftests/kvm/include/kvm_util.h  |   9 +
>  .../selftests/kvm/include/powerpc/hcall.h     |  17 +
>  .../kvm/include/powerpc/kvm_util_arch.h       |  22 +
>  .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
>  .../selftests/kvm/include/powerpc/processor.h |  39 ++
>  .../selftests/kvm/include/powerpc/ucall.h     |  21 +
>  tools/testing/selftests/kvm/lib/guest_modes.c |  20 +-
>  tools/testing/selftests/kvm/lib/kvm_util.c    |   8 +
>  .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
>  .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
>  .../selftests/kvm/lib/powerpc/processor.c     | 512 ++++++++++++++++++
>  .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
>  15 files changed, 851 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/hcall.h
>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/kvm_util_arch.h
>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/processor.h
>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/ucall.h
>  create mode 100644 tools/testing/selftests/kvm/lib/powerpc/handlers.S
>  create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.c
>  create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
>  create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fc320b373656..35df0c39e991 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14349,6 +14349,8 @@ F:	arch/powerpc/include/asm/kvm*
>  F:	arch/powerpc/include/uapi/asm/kvm*
>  F:	arch/powerpc/kernel/kvm*
>  F:	arch/powerpc/kvm/
> +F:	tools/testing/selftests/kvm/*/powerpc/
> +F:	tools/testing/selftests/kvm/powerpc/

I don't think sending KVM PPC selftests changes through the PPC tree will work.
It's "fine" for KVM PPC changes because the volume of KVM PPC changes is low and
rarely modifies anything outside of arch/powerpc.

KVM selftests tend to have a lot more cross-arch and/or common code modifications,
i.e. I think we'll be setting ourselves up for pain if we don't route all KVM
selftests changes through Paolo's tree.

Does it maybe make sense to have all of KVM PPC route through Paolo?  Punting to
PPC made sense when KVM PPC was on life support, but it looks like resuscitation
was successful for at least some flavors of KVM PPC?
