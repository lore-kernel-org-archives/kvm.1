Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2634194AE6
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779838263; cv=none; b=Jzz5+JxDSyN9N9nMvgq3B9tJIV0xbz/PoW+cQZBlvf13r+UFn0q3FF8+3xU7wE7BTUO573e8iO1Ai3/xUhiE/qDzLtHkj46+AJWMytvN2OMQ4vBhMJLkFgBa6lob3cvsgPAKeAR0VneF7UQPmyy38IMz/bxu7RiPfOXxbodLlGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779838263; c=relaxed/simple;
	bh=6XAhnzTuu1fObyQO7NgpetmpjBkwEMYbnAeTgjsVUPg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nrr0cj5rj2IzQEDnN4b8gpOKzVwmloHqkfU3KxanJx90R28CsdG2V1PBYndjhl9GKiyGIqb0UzxElaqirZTWbE56gzNV5dxtuo3UrXqUIOkqwKTb6IL3yY5XbkvI0O7M2lhKWX1PJ4p20skl2ssiO1PlouDNvBkr3fVIuv2FhPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZvTCyVaB; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZvTCyVaB"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b4678c6171so121444795ad.1
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 16:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779838262; x=1780443062; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7UStAfKDkrjCHaiZ314HFq/YDEdv+RlHz6nogZx/t4=;
        b=ZvTCyVaBCIiQkBAbFrZHPz9UH/8O5fltMsWYEoTxCpubm5ckNRYLPC8cH994TCGXzo
         EPBFDWc+Nw1A5Z2tm8cVxkynZYHYC+aGjSYIC+FN7d0HtW/OVLvXMA8oVzWHOuZKDt4D
         5MqlKHIuiyYq4iuiFoVt9QFtUJa9iX7slEnYPv9oCCCnM0H15DrBkFybv85iqCW2J1VG
         EsuTo9jgOj89MyE4gm0JsKhVhuAQUnidB7g5ufKIiBTs+WU/ayRva7To5ZCSEG9J+vJ2
         4MAzaBLvhud5UKURbyPFntKQYVcoDuskHQDf9utLaEYsSuQeqJSwN3W9YySmGOffMpKc
         6+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779838262; x=1780443062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7UStAfKDkrjCHaiZ314HFq/YDEdv+RlHz6nogZx/t4=;
        b=g6zJnTZsh/3nvI03ZRzjpyQnprmpi3oYn8ShaNNNKbw9QbC21PR0eTPw7P8p2htW5C
         DKRnXpFNXEstFvqnYBy/+bLjCcP/6MWjDpjNSMZveImEKMskwdgHz5k8sm2aaKP+tfJ7
         geNKsLhCUelhG1rKCG8uw5cowwvis7s10euZtitR8B1SWEn+EHJsYEUUBLT6p+02PWdm
         vLpX0/n1cDLh3fU/eb27kwGrmqcGWb8LAHDi45c+xW7/j/iV4XIFgpdJ6dQF84CkdRdD
         Y+TpwqkPm8kFvMyQwNtBzoFi6lD5LvzzAqiPg0GZ4FbAwD1v8tYK8btVrjToWMJHckvz
         rAEw==
X-Forwarded-Encrypted: i=1; AFNElJ8RGv28YRJFTzyKgeAPjn3b5VHE2XBtgebGNxXSXF3b7SZaiyPCNzDkvRYQr9TPcwxda7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO0XAuTCQUSGylxa/pntFqZ9a9H0WvIdn1i1TNDz8hzv1mR4Sh
	Z9skOngChjZoUwfLe1GZ1OrmgAMwWJ75W866CPeLEmUYT6zKg92v20h/Cg7Vatjxo5KKWHUoOc3
	Mn3+cfg==
X-Received: from plbkg11.prod.google.com ([2002:a17:903:60b:b0:2ae:41d1:278d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a27:b0:2b2:4b4e:e4d2
 with SMTP id d9443c01a7336-2beb0758412mr222791425ad.15.1779838261945; Tue, 26
 May 2026 16:31:01 -0700 (PDT)
Date: Tue, 26 May 2026 16:31:01 -0700
In-Reply-To: <20260506015733.1671124-9-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506015733.1671124-1-yosry@kernel.org> <20260506015733.1671124-9-yosry@kernel.org>
Message-ID: <ahYtNSL2LDhZx_kG@google.com>
Subject: Re: [PATCH v6 08/16] KVM: x86/pmu: Add support for KVM_X86_PMU_OP_OPTIONAL_RET0
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, May 06, 2026, Yosry Ahmed wrote:
> Add definitions for KVM_X86_PMU_OP_OPTIONAL_RET0() to resolve to
> __static_call_return0, similar to KVM_X86_OP_OPTIONAL_RET0(). Move the
> definition of kvm_pmu_call() to pmu.h, and add declarations for the
> static PMU calls in the header to allow making callbacks from the header
> in following changes.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  arch/x86/include/asm/kvm-x86-pmu-ops.h | 4 +++-
>  arch/x86/include/asm/kvm_host.h        | 1 -
>  arch/x86/kvm/pmu.c                     | 4 ++++
>  arch/x86/kvm/pmu.h                     | 8 ++++++++
>  4 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
> index d5452b3433b7d..03ed2c917bb56 100644
> --- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #if !defined(KVM_X86_PMU_OP) || \
> -    !defined(KVM_X86_PMU_OP_OPTIONAL)
> +	!defined(KVM_X86_PMU_OP_OPTIONAL) || \
> +	!defined(KVM_X86_PMU_OP_OPTIONAL_RET0)

Align indentation.
