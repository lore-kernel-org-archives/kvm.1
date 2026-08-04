Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF34440A3D
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878480; cv=none; b=QdsvnSLhs0VD8QOboVXg2kd0LxOrFi7IjhjGyc8N4bG3nru3Y+MO4/aEB1pKjuwessi9J8Lx/zb/qBNliXcex0Z1Su2ZWAOtA5yHTE5PznadQPt54k1927ti5mU90Teka2NV/VNLo4fMRkk7RhlwY9oayX/kBL++MTc307HUwK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878480; c=relaxed/simple;
	bh=xzRPCs/rv1FhtkiR8oU1AWkWRGI+B37AVWNvL9stlSo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fa1/++UopCh3EWJaoFupqaQYCAczJ1QFJRjYu8WCeq0aJd4jhQI01xFQOAFWQ/S1UEmEsz5OkF3W3BLjwtAkvliUmOAyptOQwtp/Nx6NQIIsrrTv1p3zWwQDbi8bGRUDQGosQHWFG3iSUT5X8EnZaoVNh6rjXf5d/qRStWsWf/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R4tnhJps; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R4tnhJps"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-848544a8496so276414b3a.0
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785878477; x=1786483277; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WFgMw4fiBgrQ1xsL5NWX1WqzYPj0vpROk8XmbnyUdOw=;
        b=R4tnhJps62sDUI4VJMax8L3AOHXry0CSPlXwQ5esTHVA3PbdnY/vXFn56WYEibJyoS
         42/1pXC6INuB2jP0N88ec4zgHghLNqLoU5TqgMwHiv55v/AAy+QX+uOlwGqBb2d6UtdP
         lpQ1SenKcLAwpbDZY49d6UPLshgWWs5EvyCsOSWD439x4cMnEUSXn6gIeUvlyfH3GsCr
         s9VW0kC0HuAn7oxv3+yrdM/pok9yD07LM3daSUOyUROwIsWQP9XdxJGdp0WUOeanC3x9
         uTmXMNQbD7XdXXEDL79B8b7q1gCuHx2TuAU+0WXtyQUC3f/ekRNUKOPDos4akrGzuKlo
         2pkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785878477; x=1786483277;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WFgMw4fiBgrQ1xsL5NWX1WqzYPj0vpROk8XmbnyUdOw=;
        b=CBjOImq3W0DXtguUyiWbDKT9EqjbTFMfct3b3f3k89AmjluX6aUEMp+DT0zRA0Otca
         1fq6O/L4QpmUDIWGOnhkK03LILV/D7VyGo+qNPTomh3XCIc+l/9TllEG22jz/+QsWZNP
         AvYqz5YrnwY95RMqIAzQRGkSAeYYck6wQb2w8mFSgiEJdlYf5rc7HSW/RQOxaiIx2XeA
         UivG2iqaupPCQdnDCxbacuhjFgLYgO3nVGZyZBz0YF6o4LS4o+FO5Bu3GrPwCpAoRZN5
         ixVssPOuerLn2HqGjrHv1sOdhk/LMpmgVlmLj2So9w9F74xn0izSr/OmDBcMhv1RXtSL
         1dNA==
X-Gm-Message-State: AOJu0Yw/fJrtGI4vjCi3SSqWUV0WcMaVGRGWWZ7CrOikiRa4C1hiadJa
	bcAWl1zwNGGuIeh5BX3AUngbEXK4kQae4ffCPlxAGqf+mJNCBoBypJ8sbnNjBbdxnD2qvHqtaKQ
	diCb7ig==
X-Received: from pfw16.prod.google.com ([2002:a05:6a00:a270:b0:847:840c:ba17])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a20:b0:84e:f90e:492f
 with SMTP id d2e1a72fcca58-84f2dfc338fmr1489489b3a.7.1785878476592; Tue, 04
 Aug 2026 14:21:16 -0700 (PDT)
Date: Tue, 4 Aug 2026 14:21:16 -0700
In-Reply-To: <20260804211300.668C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804210046.3413149-1-seanjc@google.com> <20260804210046.3413149-3-seanjc@google.com>
 <20260804211300.668C01F000E9@smtp.kernel.org>
Message-ID: <anJXzBxq6fbPuoQC@google.com>
Subject: Re: [PATCH v3 2/2] KVM: selftests: Create one VM with many vCPUs for
 each major PMU counters test
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 04, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> > +	pr_info("Testing arch events, PMU version %u, perf_caps = %lx\n",
> > +		pmu_version, perf_capabilities);
> > +
> > +	/* Testing arch events requires a vPMU (there are no negative tests). */
> > +	if (!pmu_version)
> > +		return;
> > +
> > +	vm = pmu_vm_create_with_vcpus((NR_INTEL_ARCH_EVENTS + 2) * (ARRAY_SIZE(unavailable_masks) - 1),
> > +				      guest_test_arch_events, pmu_version,
> > +				      perf_capabilities, &vcpus);
> 
> [Severity: Medium]
> Could this cause the test to assert on hosts with lower vCPU limits?
> 
> This calculation requests up to 144 vCPUs per VM ((14 + 2) * (10 - 1)). If the 
> host has a KVM_CAP_MAX_VCPUS limit lower than 144 (which is common in nested
> virtualization or lightweight VMs), 

No, it's not.  Unless userspace overwrites the VM's max vCPUs, KVM x86's *minimum*
value for KVM_CAP_MAX_VCPUS is 1024.

	case KVM_CAP_MAX_VCPUS:
		r = KVM_MAX_VCPUS;
		if (kvm)
			r = kvm->max_vcpus;
		break;

  #ifdef CONFIG_KVM_MAX_NR_VCPUS
  #define KVM_MAX_VCPUS CONFIG_KVM_MAX_NR_VCPUS
  #else
  #define KVM_MAX_VCPUS 1024
  #endif


  config KVM_MAX_NR_VCPUS
	int "Maximum number of vCPUs per KVM guest"
	depends on KVM_X86
	range 1024 4096
	default 4096 if MAXSMP
	default 1024


KVM_CAP_NR_VCPUS incorporates the number of CPUs in the system, but that's purely
a "suggestion" for userspace.

	case KVM_CAP_NR_VCPUS:
		r = min_t(unsigned int, num_online_cpus(), KVM_MAX_VCPUS);
		break;

> vm_create_with_vcpus() might fail with a hard assertion.
> 
> Should this check against the host limit and either skip via TEST_REQUIRE()
> or batch the creations into smaller groups of vCPUs?
