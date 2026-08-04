Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C4C456DE3
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849055; cv=none; b=hA7cj4Xd5ur4XaxWSMXQF0ifHhFhRcXeE14EMBRP/SZbmhms9aMiYW/N3GlFhBJmQ7HHoNwhpu3MY6y9MFtuTYg3fDP2gse9/lK8kFcGqgFcgRhCIXYJd7M2oeEYUQLNuQ6Mtn2ajIQ3fUUcJ3HWfUSKmXfsOKIXiu8ZgPQ+77M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849055; c=relaxed/simple;
	bh=YypOBVgvdSIXQIPkAvf7Ht49fUL+oAogMQuiYmYQZng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZwcfzDAJcDT2wwcHaNf7U5Ypocf9oneI6xVdx+12Y/ErhhGRN79ZjOLSn1F8KUm/VmOs93aKrwTtyDe2by1WpA2Ht0bO6FLKmV0Z3mMFxqgMM+24CdSCadfSYy6qCj4KTl64Eopql4XIYAGi2naIcBqXULa8ptL+14/JkaNDg5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s4T+OAxy; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s4T+OAxy"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848544a8496so5376248b3a.0
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 06:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785849053; x=1786453853; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6aPOJ74G4KzXfvLJssyQANYRbmIuLz4KQSTSRbojMF4=;
        b=s4T+OAxy3vzWPEmL2XKOVGcgx1P4GWBPWyuOAw/BruVZ0IhjwAKd0D1ZKrRujeWri2
         Binnl82swxVSERzhkUTXU52L1rL1w2mF7TfC4Pr35YnZd7A5KlmlAGjGafcoLSEgD07z
         9hMTaMVsZUwLlIlNt8KuZeLHbt68HbU1tcRH4CSA0I44OvHpzF+J1MtqMey4dmZUw9LH
         8wgeRh5TXlta5qW9PyWdCS4uUgndUoiyaHbVGhcCoTi4rRx/JaDdeQclBXYbu94sVAuf
         6Lfy7BGTcVh8T3DJmjc9BEoUSK+kAwh0lgyeDueAHqHU9/bzGK1olvNjCwWnmRIxWUZW
         ts9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785849053; x=1786453853;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6aPOJ74G4KzXfvLJssyQANYRbmIuLz4KQSTSRbojMF4=;
        b=TOxBfyOzImqghYAzUBsZ+LDLGqRt/Pu3QuskdTmlS5hawnfW1Ux5ZRZjUmdYfOppIi
         GyhUc9CNaa4JK9+D8GG2ve1WlJEVmRG/2TDjoa89QdQui9MyZVpEgYH0EZFhXjdMb3xb
         BJeFa6aXPdy5JGHQS9Utmk4kDI73BRQ408u+0S5OWtS1ZDbOTz6Gld5KSh3BxKkvwMMI
         4gYk3V+PySRYa56gVJB0CBvFH1EtrlM+R/dA4z1Nr1Du6x0bo8TNAD116gyazGDxJC9u
         ndUFcmLQV/PWHDpF5RYrMZ1fpbQGi4YS+7Hs/pimMKLvKD/WlQmfiyc/ScJDEGFk86hL
         jAIw==
X-Forwarded-Encrypted: i=1; AHgh+RrPeJNAWc6t3UCCf4JqmtPea/t3+C76XA4dFQejzOiZtizHpRz+RSa3JWnn6l9iePZ+X+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIaZJwmaxqzjcScbevOL3w3hI0Q7iKahTA5dH7yvRD4oVd+i6D
	q2fA1YeH4ZYaqfk8GfiwDrC8+X912TDIK7ClojMrBTshHE3GUZEZwZ4de+bSKMeJtH5JZn6VKVc
	N/yKeJQ==
X-Received: from pfbhj5.prod.google.com ([2002:a05:6a00:8705:b0:848:49f6:6f5c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b06:b0:847:926a:7ae3
 with SMTP id d2e1a72fcca58-84ee480a5c3mr13246814b3a.20.1785849052879; Tue, 04
 Aug 2026 06:10:52 -0700 (PDT)
Date: Tue, 4 Aug 2026 06:10:51 -0700
In-Reply-To: <20260804105755.276646-1-kimjw04271234@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804105755.276646-1-kimjw04271234@gmail.com>
Message-ID: <anHk2wTLHYxdB0jD@google.com>
Subject: Re: [PATCH v2] KVM: x86/mmu: Write-protect tracked GFNs in all
 address spaces
From: Sean Christopherson <seanjc@google.com>
To: Jinu Kim <kimjw04271234@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 04, 2026, Jinu Kim wrote:
> KVM relies on write tracking to fault all subsequent guest CPU writes to a
> GFN that backs a shadow page.  The write-protection installed when tracking
> starts is currently restricted to the supplied memslot.
> 
> With SMM, the same backing page can be mapped through both x86 address
> spaces.  If the peer address space already has a writable SPTE, a guest
> write through that mapping bypasses page tracking and leaves KVM's shadow
> state stale.  

...

> This restores the invariant that a tracked GFN cannot remain, or become,
> CPU-writable through another x86 address space.

Not really.  There are multiple ways to bypass KVM's write tracking, for all
intents and purposes they've already existed, and realistically I don't see us
ever plugging all the holes.

>  arch/x86/kvm/mmu.h              | 11 +++++
>  arch/x86/kvm/mmu/mmu.c          | 77 +++++++++++++++++++++++++++------
>  arch/x86/kvm/mmu/mmu_internal.h |  3 ++
>  arch/x86/kvm/mmu/page_track.c   |  2 +-
>  arch/x86/kvm/x86.c              |  8 ++--
>  5 files changed, 84 insertions(+), 17 deletions(-)

Assuming the true badness referenced by commits:

  2e8a2c1b0306 ("KVM: x86/mmu: Check all address spaces before skipping unsync")
  0f38453cdb2e ("KVM: x86/mmu: Check write tracking in all address spaces")

was eliminated by: 

  0cb2af2ea66a ("KVM: x86: Fix shadow paging use-after-free due to unexpected GFN")
  81ccda30b4e8 ("KVM: x86: Fix shadow paging use-after-free due to unexpected role")
  aad885e774966 ("KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE")

I am leaning toward taking an erratum for cross-address-space modifications of
guest PTEs instead of applying this, and then reverting 2e8a2c1b0306 and 0f38453cdb2e.

This is all a non-trivial amount of complexity that, in practice, no use case
cares about.  By fixing the issues, we're implicitly stating that such shenanigans
are supported by KVM, and I would much rather say "don't do that" and document
exactly what is in/out of scope for shadow paging.

Paolo, emulated SMM matters a lot more to you, what are your thoughts?
