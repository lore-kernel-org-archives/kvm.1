Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DACF270540
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 01:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779847174; cv=none; b=biLuoDB3SKuYtAr/ILyBWvJJf9DsDOehYQ3TXV8TJ0I7cZ84oi40c8/AgCP9eZxAbe6Gj3cp1bHl+uFoWnbHuNqPwXQHoVXTsZ9OUaCEiAXUybZlmGNxCauAoWKgqBwLcWmgCMCZQHux0r0bR7Xx6BjAE12PkCQ051m5sw5Fex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779847174; c=relaxed/simple;
	bh=DJBlXNG4XNHq8weSxkhvjnetNBz8vm9Ve5sdSMUy6EA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WyLtdeA1bDSkuG2UXy5NLwBgiQIYLecv0TzWgBQo6ziq+sE41NzRo0yhbmqnVq5e5CZicHfc7CC48c8d+gCespglc4tCEg12/2cuTB1zwFm7BlLkZ8jjkuj/bgEMHyUndBLouLIDopKuni+OEtN7/RH/GgQhN4AUGqBZ5FmTtBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UdFf7JUY; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UdFf7JUY"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-365faf6006dso10828598a91.1
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 18:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779847173; x=1780451973; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mam2wphCUQz0yDnDo2qArnv8ghGRNhFKB1YonuKsYBs=;
        b=UdFf7JUYaPtDzTRtZgtXOX0OkulUvioMAdE5OM84/U5nMe/LMLOrZgaRu+lKsOuVB3
         VsoUPvys4iZA39AhHoNJbUUphEAMs1csriP8oTo1lMH6kBVbeUzm7hPoIB+9D49dXb0a
         BqH0JMb7pKymLJZz1TFvneTi2CE6jvZMmAQsR+AzE0kmZMzKBJSmhgUYhU8a1fhFdf2F
         Ixa8ZRiSn2kfiODz5hgICAlPXbIgvyU3ILhtPxEPvRXV6Be5jmCjvlapHFbq5PqCboFo
         jVEc4p9bimxRTTyV2PUpEzlxFWcSRL3P3oyVQ4aBt15BcBve6pyjc7vJvT0JyBVdJv0Z
         WEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779847173; x=1780451973;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mam2wphCUQz0yDnDo2qArnv8ghGRNhFKB1YonuKsYBs=;
        b=KBXHSnxkCYs0xnpda8bQ715xNX1vRD6ke07DWIyoIRzcHql7yRD76d/Kljd5hTyzI9
         urmj938iZQQJjorgiBr1BWeY/9veT/KNyw8EFkiobd0F6rS20pqsUI3LULIF0LGFZ6t6
         Pol7OeCdp305Kmf2vTCNzGVUmqLLGymFYsZ7OwGZyAKiM0J6IWW3DYQ/lObDxuUBWR1/
         ZyG8qGUOkg7+zBn+eIKGBhyxkEhbzEr/IUjm1l8N0cjX0D6H5S1voxcBVtNBVIx8MVRE
         /gqgReIjrq0iOQ2tAhSJ/UrbQCuIEpzslPStib4GJyvJN7LWSAao8gd0Hhn+dzmhwbxT
         J4JQ==
X-Forwarded-Encrypted: i=1; AFNElJ+TzLT5LR6Vhm6Wp+sw32H/44xCxz5u7W9S1VnhmO44nuX/YsvhjfhsI7++LzS0ONH+J0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl3vjQf9AaTvnL9clSjQZuqqwsVKrvuB/kF8KKgvrNffWhTEFa
	XREQhU7xX+ITRkF1Y31jLncAMLXheuiZuwSBN+J9dE5jBiPfdlweuCmGC52hwXbEcPRocOM//92
	Q4dMK4w==
X-Received: from pjhh8.prod.google.com ([2002:a17:90a:508:b0:369:e312:c684])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b8c:b0:36a:5d1f:7b6
 with SMTP id 98e67ed59e1d1-36a6773c034mr18715913a91.2.1779847172478; Tue, 26
 May 2026 18:59:32 -0700 (PDT)
Date: Tue, 26 May 2026 18:59:31 -0700
In-Reply-To: <20260421231557.1254270-7-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com> <20260421231557.1254270-7-jrhilke@google.com>
Message-ID: <ahZQA1HO0wNG6MeU@google.com>
Subject: Re: [PATCH v3 06/16] KVM: selftests: Add IRQ injection test
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 21, 2026, Josh Hilke wrote:
> From: David Matlack <dmatlack@google.com>
> 
> Add a new test, irq_test.c, which verifies that KVM correctly injects
> interrupts into a running guest when triggered via an eventfd bound to a
> GSI using the irqfd mechanism.

Can you add some color explaining that this will/should work with IRQ bypass?
I assume it does right out of the gate.

> Suggested-by: Sean Christopherson <seanjc@google.com>
> Link: https://lore.kernel.org/kvm/20250404193923.1413163-68-seanjc@google.com/
> Co-developed-by: Josh Hilke <jrhilke@google.com>
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm |   1 +
>  tools/testing/selftests/kvm/irq_test.c   | 173 +++++++++++++++++++++++
>  2 files changed, 174 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/irq_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index d944b81cad7d..693c03372a31 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -156,6 +156,7 @@ TEST_GEN_PROGS_x86 += rseq_test
>  TEST_GEN_PROGS_x86 += steal_time
>  TEST_GEN_PROGS_x86 += system_counter_offset_test
>  TEST_GEN_PROGS_x86 += pre_fault_memory_test
> +TEST_GEN_PROGS_x86 += irq_test

Ignore pre_fault_memory_test, sort alphabetically.
