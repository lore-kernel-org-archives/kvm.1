Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02372473C60
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119952; cv=none; b=I8xol95nhZWhEUthH8YXqNamqp3U8Z9LxRTZQxznWZ9mPDcI58L6fN/GRTrSLrCT6hpx+Iz8YrzLN/F0C+5V9eHmfyXSJX9xuHRroPaFvU3fm+GV0yqCR6BPUwLHVv6VrCxGCp+eOP135WoueL3dkljWhSONusdUeXmAq3woY8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119952; c=relaxed/simple;
	bh=OhWdDAsnaD/Cqtgl3IDWm+0jfrWIeR0MePax6YWk/Lw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IcJ+PV5m2HVpV1mMKEgQE6Kx62Z98AYJ1T3BuCro+JOoiRty+XjHRB2ISRZf/HTHvKherjMMhNt7ilzv4qsor07hjL2OqIwrmMbgfc0GnEVs8zGP+xoK8DzxDsyG9mJw7gXY2uJixkk0kQy8durpXvxGGzDi+wvqSM6onlPAUi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LGhdWn4I; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LGhdWn4I"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84857446424so5942314b3a.1
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786119950; x=1786724750; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+B4ea2kuYIlgc5UTeAdsqf3H/PAXAp+er556DjsFuRc=;
        b=LGhdWn4Iznl7xzYyZACkCX17Fh1loaRkXOmY0iW5274N3dZXXoFGRwQdNkfpTm6/gn
         q99nA4zqlNMiFoG07VmlfxHObZUBx8VYca/Z+D7kr4qApmYloCkeZW+SYp41GQ7YOpfg
         7dpKWTlBZx2jjWyBRprcucNoSgTzWgez3mL9svyxPiuY1MM47K1pZ5bCxGiKizmDgQYn
         bD/me45BURjwXbYimXCiaxR/q+UQH5lQoJ8a5AoR//fD8iGSQEE0SnCD4Ijvyfg/I4re
         KamlewZC2HKt1XSf0hYa8Cy8fRm7u317VoVDVrN9eIlOKz/ZoOCOP+DnajMwMxuaahCR
         sqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786119950; x=1786724750;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+B4ea2kuYIlgc5UTeAdsqf3H/PAXAp+er556DjsFuRc=;
        b=kbLGrNf6EHcjRdi1fmzS+z1oTuy6m0R8qyB4gtVZGvyYfX1oUyZOwxDltSio5Yhwc4
         ei/zpP55/e3AskhXVVVpDDRMf98SPAIhR3VNXTVTPZvVs81GriVSP+J+1MHp+eB3M0sm
         6z2doosljigLDotzZf6LVXalrZVrVG35Rs4XWhj5BnB2/He5yrRsPkBw4Dnx8Xgogjeo
         dXAzXhouN6gdgEWPDga27jWFOrW+J7AhQiIj7DCcR6v6ZnpXgcSKQkXq47bdIISt51Mo
         EvgwW8fFBvTDPhNzvnQTOHQP0WzBjjLgCK00UihKRW2v9AWxF98PWZXaYMNJUxyQFW1d
         uJWg==
X-Gm-Message-State: AOJu0YwOPxy0Ele6OXbaiGa9pLWVMC9zTT2YUGchyxI2yopFbPhHe+Uo
	ko+KZu+S9iRjsRm5QfEGoqlVB3zt0m1T7udDyL8+HWzLP0a7+MaXX6QYoxf04Tjp0uyImelBXc+
	+iCm9ug==
X-Received: from pfbcw11.prod.google.com ([2002:a05:6a00:450b:b0:848:51a7:e8bb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c12:b0:84e:b7ed:7d50
 with SMTP id d2e1a72fcca58-84f2dfe8da7mr28005687b3a.16.1786119950019; Fri, 07
 Aug 2026 09:25:50 -0700 (PDT)
Date: Fri,  7 Aug 2026 09:25:25 -0700
In-Reply-To: <20260804210046.3413149-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804210046.3413149-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <178611991391.356691.13642495513205529979.b4-ty@google.com>
Subject: Re: [PATCH v3 0/2] KVM: selftests: Reduce PMC test runtime by ~17x
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 04 Aug 2026 14:00:44 -0700, Sean Christopherson wrote:
> Reduce the runtime of the PMU counters test on an Emerald Rapids system from
> ~85 seconds to ~5 seconds by (a) testing one random GP counter in the arch
> events test instead of every GP counter and (b) creating one large VM per
> "major" test and then running each subtest with a different vCPUs, versus
> creating a new single-vCPU VM for every subtest.
> 
> AFAICT, there aren't any bugs anywhere in the VM creation flow, there's just
> a lot of work to be done.  And VM creation isn't even that slow, but creating
> something like 1000+ VMs for the test adds up.
> 
> [...]

Applied to kvm-x86 selftests2, thanks!

[1/2] KVM: selftests: Test one random GP counter in PMU arch events testcase
      https://github.com/kvm-x86/linux/commit/a53d1602e3bf
[2/2] KVM: selftests: Create one VM with many vCPUs for each major PMU counters test
      https://github.com/kvm-x86/linux/commit/f6e01d4fa1e8

--
https://github.com/kvm-x86/linux/tree/next
