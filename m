Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A54B3FCB1C
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 22:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140812; cv=none; b=Dnm9Cikwoc5L3cV+5pJO7rQA2SYKXS6horfwdo2YFVXvj9uvPYjW4iXM+7OSmrV6TgEo1TWfM9jaj6dpDA6nzuj/rKDmKj3fuCZ0bY3AkLbWRgbkrQe9t2TOazXXNBGF+Kpi5G9wH2436/ad2f9yDx2FX31V7QFwir6yVIRjnRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140812; c=relaxed/simple;
	bh=LCSRjf7PkyNobQg/zBgnuJ8jkLZ2yHjFSJJnBq8pOHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J4egiXvmWUVYW9RY0fgtMQJFxuwTxcF1ddj6c8IHtYYddD8VT/I1w6mqEr8wPysTf0qEfL/Jetvg6KxuQTm6aow+zOIzd/MPeEVyU5pUsww9ECMpXB4PlvviiUwix8baF5Za3zNp3RMu80GmQcPvNQD+8YGrHUk96OUN17yFVLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DZR1q9Eh; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZR1q9Eh"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cccfa32670so1248325ad.2
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 15:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786140810; x=1786745610; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eo+3SyDVYtMPCPJzEL1tdA76maDPSYwGhLHGHPKJZOA=;
        b=DZR1q9EhJhj5McBkPXBwJE6tDdGm68FEZ+cqxiIxEFIYgQVoZB5US7sg/jjitkmH4L
         GqTZ4heuQekqUohwqE3nDHtZ1DId83t/9L1nUEnQlq9ihIpgaQpdff5gDt3GXek/Dwmy
         xUGOMisIPZ+D54NNbpBi3/ImSvwMdBP+u4ntn+s/ee6P6+B0BXphvuVdNk3pVu8qLntt
         plzq78oz7MhLInlTbOWtmptZi4REbuNr0B+AiQ0X+wZmRQijevl2PQclNlln8ADfeGah
         id3Nk2OKEOI3oUR1t3SemkKEbI/ewxDQ4IL5g97Aok0SpinWdOnCRPmIen2qEw9bNWJN
         szVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786140810; x=1786745610;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eo+3SyDVYtMPCPJzEL1tdA76maDPSYwGhLHGHPKJZOA=;
        b=U6negJdpNtkDdG46S68A4+R2Ww0lxpObnDlNCgLCPSQr5MIneuInMzaNFBBh7k4hzy
         xx1ej0iJRcqFYjzJ8DTfoLQv2j+URRSVcMOahzjVlYg++m3FFY4k8gUOpsXxuHCk1IYN
         kXmDHvXvlGkNQxfHrwgnE5I0KhagmbOHVTUiffgzBflrG+Kz4ijemf1xlC2Cf14UHu2m
         4Vcvvxu3d/yp2YSDLgjQvhgqTmbNyj5UZN2/nhS8boogB8VNi8I+Jby/JMdQAhqg6Exp
         mB7Pqxa2UKMTlZDTZpPSNkQx0SDEjGjXLlYS9e9Pu7ozPUAl2KUZqfDCD08BpKAvl5SC
         wBoQ==
X-Forwarded-Encrypted: i=1; AHgh+RrDwjJwgmmy9p/v/YktMcCNso8fpfQbBHwFqA506YFd0rueg+A1gIVMt48jDXGckHFg5FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRoFRMzsFxiZe/EppUyfgzr6JG09C1gULivYPR4zqjszuBH1wW
	Mlb68wUgJKzEdiy38iAYE2SrHKw/Wj2Y3r5dAb0bZxrQadSlwYW54nGfIz6O0BMyBBsizzl/CX8
	vuaRBqg==
X-Received: from plkb14.prod.google.com ([2002:a17:903:fae:b0:2cc:e845:dd2b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32c9:b0:2ca:e62c:9e96
 with SMTP id d9443c01a7336-2d0ca712d9cmr278854675ad.5.1786140810209; Fri, 07
 Aug 2026 15:13:30 -0700 (PDT)
Date: Fri, 7 Aug 2026 15:13:29 -0700
In-Reply-To: <7867c759880de0ea4628deccfaa077a5d1c5fce9.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806214050.78058-1-seanjc@google.com> <20260806214050.78058-4-seanjc@google.com>
 <7867c759880de0ea4628deccfaa077a5d1c5fce9.camel@intel.com>
Message-ID: <anZYib2bADjRmxvE@google.com>
Subject: Re: [PATCH 3/4] KVM: x86/mmu: Top-up memory caches when retrying "map
 private PFN"
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kai Huang <kai.huang@intel.com>, 
	Yan Y Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 07, 2026, Rick P Edgecombe wrote:
> On Thu, 2026-08-06 at 14:40 -0700, Sean Christopherson wrote:
> > When mapping a private PFN in TDX's post-populate callback, top-up the
> > memory caches on every attempt to map the PFN to harden against bugs in the
> > map flow that could consume cache entries even if mapping ultimately fails.
> > E.g. as pointed out by Sashiko, the in-progress Dynamic PAMT support could
> > consume PAMT cache entries on TDX-Module lock contention.
> 
> I think it is the same for the other caches consumed by the fault. I guess
> "e.g." covers it. But it's not new after DPAMT.

I don't think so?  Especially since as you point out below, nothing else can
muck with the SPTEs.  The TDP MMU only consumes an cache entry if it successfully
creates a SPTE, and since nothing can muck with SPTEs, anything created on the
first attempt will still be there on subsequent attempts.  I.e. the TDP MMU might
create SPTEs that are ultimately unused, but I don't think it can exhaust a cache.

> > Harden KVM even though consuming an entry on failure is considered a KVM
> > bug, as retry is uncommon
> > 
> 
> The locks held by the sole call path will prevent retries from being needed due
> to TDX-specific details. So in the place where this code lives, it is a bug. But
> can't really be hit. To me "retry is uncommon" sounds like it's a rare case that
> is hittable. I guess you mean only in the uncommon case of bugs.

Ah, I was thinking a different task could pre-fault memory, but pre-fault isn't
allowed until the VM is TD_STATE_RUNNABLE, and KVM_TDX_INIT_MEM_REGION is only
usable if the VM is *not* TD_STATE_RUNNABLE.
