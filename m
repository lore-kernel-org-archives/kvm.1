Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6A63033FB
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322371; cv=none; b=GjKHn9WOFsKB2L12QvhXw0SAzMVsy0UvkUBAVco9G1cEQHwqLbKTLdE2MRpovz6Mdrfk08Om8aaJ+jmK/Yu/S129GoKp4e5dx7Ypeim700upLJnTc/a9GTtJm9z5+zbl2nGj1lvmrGArGNuTk9nUB3YwdnCgY8s3YG20eWVHaps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322371; c=relaxed/simple;
	bh=iikYRdViwRtzh9V9/K4oM7wLc4TMqwuuo3WzFq6sMBI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TLTpFKRAOnhRjbfl8DTwMKNQlTa5E3o/C8F63lai+LcqJDyn4QPTyA+Nh4SMIviPA7kcozgoS57TOgceaQHfQMd2p8El/rJwgd3eGAPnLK3wxwBaFsHLDmJpIAVVan+w2mHBM70i9Zp6/SZ8u8mtB+LBsCh3ZNxxEFj6lxO2FM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LFhdzk+2; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LFhdzk+2"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84238e83851so990929b3a.1
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 10:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782322370; x=1782927170; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NuCvG+ANEtYYDDfdrUYBmspYw8vstGpW69KsCXQmcQ4=;
        b=LFhdzk+2Do8UQMJm5Y48bOFY4ViXc1bsi4f3edRXhS5k7rcIdAbK+9Qa0sh/j39D72
         a0xKi8lwqe1wylHuSHz+MtI2uTSmsZNjIFIr3kLbSVNt0bkjzv4kOoYwqn2G0g7YIM0x
         0wFTn5pBWj9bp1BnXaFxMydBlxe/4sVPKFNEmdIhBJwgbYGxoWjE9zGFGWrScpubmbvg
         a/SY1tuMxCQ9AdbZfI4QGpd9z0SpqehYjx6/9wrm2kPWfW/2a4pzVxJsCvKzQOrz1Xel
         G7f2g9csChThxzWE9N7c8+mdOEVSNgsm2gY5gIGfGZs57yRZ3Okiiinxv0xfytURO6rl
         IzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782322370; x=1782927170;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NuCvG+ANEtYYDDfdrUYBmspYw8vstGpW69KsCXQmcQ4=;
        b=ZAKdoWg6Su6jDWDo4jSmT+Eog8jjgQEtNf+3nagVcTldkeUDNyV+alkch5WOpeQQzA
         ua9cr2+IvQoZ++06oH4RIvwYgL9l9LGEz4rWTzzMQHVyhIa5Ze/PzGYRSBVbT+HV1jKR
         3qTH4Hxwogt7eqIhtWEYvB8tHS/YP67ydoS0Re89O/NazEMlXZYPz3lPWaqNwFX5+IgZ
         0Hf6Hfs1dvl6E9rVUPlwlMqX6YLgtuoDqncw3SSAb+VgXopylaNDIplpNQKUYa/aXHo1
         SkCsK41NZMNBSw9+y/Udnqr5x13tHrsn4QiYqT/PAGa7zUlOeJ3LQE27kKkHk1aBUhhf
         6+sA==
X-Forwarded-Encrypted: i=1; AFNElJ/KrJxdzwOaUiJ6iSMYgUZR9O2c16kXsgd/Uc0/sVJheK0jTcS1jmmE0U0zONkq6RN9PzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz62rCdF2SXSULcfUSLZ+Befh9M+GgKR/ri6w7p9uVy0qcYdBgf
	R9Yz6G1j+jNeh0G1+Ah/7+RukBrexcR7UwmpcLbIoVOlS/ci51QYTfy08wThrpY9dd1txbSgGC3
	7i+QILA==
X-Received: from pfih1.prod.google.com ([2002:a05:6a00:2181:b0:842:9550:318a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:450f:b0:83a:ebec:452f
 with SMTP id d2e1a72fcca58-845a28d4650mr5767948b3a.42.1782322369734; Wed, 24
 Jun 2026 10:32:49 -0700 (PDT)
Date: Wed, 24 Jun 2026 10:32:49 -0700
In-Reply-To: <CAEvNRgE9cLfjDbXuR5wq3fEWZyHxYPxdExxNjXUFO1nT5m==1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615155244.183044-1-alexandru.elisei@arm.com>
 <20260615160901.9A1A61F000E9@smtp.kernel.org> <ajA6ogaNiI3KDv5i@google.com>
 <ajKcDRqT5m069PXK@raptor> <ajMPvgA2eHQCj-B0@google.com> <CAEvNRgE9cLfjDbXuR5wq3fEWZyHxYPxdExxNjXUFO1nT5m==1A@mail.gmail.com>
Message-ID: <ajwUwX2xIOLjACh0@google.com>
Subject: Re: [RFC PATCH] KVM: Ignore MMU notifiers for guest_memfd-only memslots
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, sashiko-reviews@lists.linux.dev, 
	Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Oliver Upton <oupton@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 23, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > and purposes, we're conceptually treating conversions as free()+re-alloc().  So
> > while the page might still be in the page cache, it's effectively been "freed".
> > So in that case, KVM really does need to ensure it handles mmu_notifier events
> > correctly to avoid UAF.
> 
> Just making sure: "handle mmu_notifier events" here refers to
> gfn_to_pfn_cache and other parts of KVM that works with memory.

Yes. 

> There's no issue with a UAF between mmu_notifier invalidations and
> conversions, right?

Right.
