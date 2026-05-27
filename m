Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42DA3DFC92
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903658; cv=none; b=Ibg4eqNY8LLrrdtJnW9G4ilh3vk3O63rg9VfvVmNHSHbKBxwRliZ9D1hOiePmx88iFvuG4hvBGUrwC7T3C+Rku6oYFRsQy0NlTjQaEDHhrbWJEd0IfGeKxHAxf9UcMvS4hqHefgMSQTwfF7LKoO0KUS9QBugaicjsNCMd+20nVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903658; c=relaxed/simple;
	bh=NesVSvxjeriy8JrLCo02bPpWiXiqhTNJcG0UfxEm1oI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=swzWXa9Z3NufDwpP3NMjCtudMe5qU8+BL1S96UmdvMl3Gev2oh1RnAjqg2SWG5MEx8fP75MW0oD1OQeor98s6U55KxFc9obsfV0Q8+HvCRAr2n4TqyJmzIfqjK05mn1hSLxKq37kPCydipiJdTrRwrINDKp8aEhD5EUrYTtUrrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cPUVaU6b; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cPUVaU6b"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba3245a43dso134096995ad.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779903656; x=1780508456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qag9lBdsZqOV4kYaafONmBvRHghB6X57fmrdhvqCEr4=;
        b=cPUVaU6bGwz4572efz4CeNyXF5ddFGzV2VlGRiZS+OCUQzyH73RTx7A90eC19tpFHA
         +Nesg50Wx0A6WUMsFePr/Cj8tyya9dukxGgm4xNlqdQnL7vhP8v/kcovDj4Z5O3kLz2R
         moPdMWYvLA48inVJXO9vh7WGpEbfhuFmMJ7sqK+U3o7CWlTL4rBaxV2LrDethOcJSP/j
         B0TNsh5FKMcW7gbcCcn2zX1aof0hpRscnaJCre9fRrT5QWQJi8a40ArFCpdbHRVuDxml
         6C2CpNC/kJR5Uj/4QqIkj5qmvN2zyLIPHMG19YaUZrGaRigXkTxFN2j3t+exzgbvcGDH
         Or3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779903656; x=1780508456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qag9lBdsZqOV4kYaafONmBvRHghB6X57fmrdhvqCEr4=;
        b=pC70nTSRO1bA94BnZYQwq/x2mgXVcbpZS0N0i0R/6qlMC/PUtBAcFKfA5brdOoYlU7
         so3uep7WrBeoktAMoPt9Bun3+NXUy2h6apQ1GolOz00NvKNVd1tM3l8n/dcGVyqctsKK
         Mu/XIjgi/Ro5IMs+/ieUlVvf8InyH4iUraXAUQyQpxa0jn+Z8/ZgUWKkTqmnOwK09D5H
         cFkcqzgbb8LZGxPfUXSLPlpuhG0G9Npj7rbDYs6AYbprVs93OsFsxdLN0oSJqgEVQzav
         0DCs7PJV+g9t2Ixe0y8ouGNzjyOPfF6bo2dw3+u1sPKKhRgcDEXgTYqmEAcMrUMAaQd6
         jobQ==
X-Forwarded-Encrypted: i=1; AFNElJ9TOXsrCPEJBqYBw7Eb+QHXi99M4TWz0qv77G2eyhiJIL/G2GcOJDLkzxdUaXUY4t+P4hM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKMIUmB1PkPDE8yfnOghOYNGi5x4hMFpyPCpW037x7TOWK0oVK
	tV2INsin8AV4xPRETDvihFgUa9urKNAEi5JXolGrV2B0f47Y9U6r524TLrKZJQOvPvCi8SnnqAk
	6oz3UJA==
X-Received: from pgii35.prod.google.com ([2002:a63:2223:0:b0:c79:22b6:a344])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9d91:b0:39f:9eb3:1d09
 with SMTP id adf61e73a8af0-3b328ee2e52mr24673521637.37.1779903655856; Wed, 27
 May 2026 10:40:55 -0700 (PDT)
Date: Wed, 27 May 2026 10:40:55 -0700
In-Reply-To: <ahcY4S7shzG_kDt6@Gautams-MacBook-Pro.local>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518044150.34632-1-gautam@linux.ibm.com> <agu2UAi6lWclxFYh@google.com>
 <ahcY4S7shzG_kDt6@Gautams-MacBook-Pro.local>
Message-ID: <ahcsp0tfST5AGdMb@google.com>
Subject: Re: [PATCH v2] KVM: PPC: Kconfig: Enable CONFIG_VPA_PMU with KVM
From: Sean Christopherson <seanjc@google.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, atrajeev@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, May 27, 2026, Gautam Menghani wrote:
> On Mon, May 18, 2026 at 06:01:04PM -0700, Sean Christopherson wrote:
> > On Mon, May 18, 2026, Gautam Menghani wrote:
> > > Enable CONFIG_VPA_PMU with KVM to enable its usage. Currently, the
> > > vpa-pmu driver cannot be used since it is not enabled in distro configs.
> > 
> > That seems like a problem to take up with distros, no?
> 
> Rather than enabling individually for different distros, wouldn't it be
> better if it is enabled with KVM automatically? I can rephrase the
> commit log to emphasize that this config option is only relevant for
> KVM (similar to CONFIG_KVM_BOOK3S_HV_PMU).

Not if you can't turn it off.  As proposed, CONFIG_VPA_PMU gets forced to
whatever CONFIG_KVM_BOOK3S_64_HV is set to.  At that point, the existence of
the VPA_PMU Kconfig is pointless.

If you want it enabled by _default_, then turn it on by default, e.g.

diff --git arch/powerpc/platforms/pseries/Kconfig arch/powerpc/platforms/pseries/Kconfig
index f7052b131a4c..74910ce3a541 100644
--- arch/powerpc/platforms/pseries/Kconfig
+++ arch/powerpc/platforms/pseries/Kconfig
@@ -154,6 +154,7 @@ config HV_PERF_CTRS
 config VPA_PMU
        tristate "VPA PMU events"
        depends on KVM_BOOK3S_64_HV && HV_PERF_CTRS
+       default m
        help
          Enable access to the VPA PMU counters via perf. This enables
          code that support measurement for KVM on PowerVM(KoP) feature.
