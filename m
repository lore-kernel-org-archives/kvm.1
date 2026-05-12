Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92921348883
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598405; cv=pass; b=LIKulG/ME8NuigHbFFh6wyfjaMPNsGQdCBGgBXFJwFSz2eEWMziqsa3BdGcyO+eZDi74ZAHm5dK1fnehcXlJEb2MyfhSIx+r6gYaD5IcrnoBocsO8zto6bo5AnuQdxZXWcdtGhWSjg3teX+JoGciSbUTcAdEfcFJGGVd2bdDcYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598405; c=relaxed/simple;
	bh=gcNBDheFBgH8XihHbSk3EkYFkn6fIMIdXTND3WNAdzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkN3T/P3qcopdZH4NnS3cuovpP/FuxopmrhFQxZ+8K6ei7Ibq2z6arr0qSkD/Ze9azF8zDhOHvNd6KqBIhlpHs28O43ghdJs/C4ifaSH67S/N8+BUCvkR3fukcgE3jMx5L/GAizF7m1nuTHAkeZX6+rXtEytGnWrgNlTgAGorrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sbEReKWp; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sbEReKWp"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-515548f390fso7531cf.0
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 08:06:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778598402; cv=none;
        d=google.com; s=arc-20240605;
        b=BgfOq8bnuUm9iTNgv2JCnSRK4kdFLx9lE6urU9SJ/u+H6u3OHS0xm05fJNe3k1mNaC
         ATat1HH5YvKhlC7rC0AfX4mPuFfw2ZkO0ygz0t4WcI3omCZC6UII0sYeOJlEFRDYDCfH
         +vOKKVRZBvAhCiN1jyax2FL245v6O/OiJvHCBiL1kEZKn5nCOCMc6Hxq9mAfM/g30axC
         xaiO4yjISULW1OtNV0iaqgJtnHM09xagFJ5CpbyTVaNLeMS12+z4PfksM3uKtTpRmGx0
         3Vg4ASbDmiyU5PYHvfZ5CVPvaFYGdRQJlQeAGLQE3dNLJRLREOQ53a2uThEojkbcXHTM
         0gaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=K3beaZW1jplvB3FYWIrdXKEVFakjYTyE58XRCIOhPFc=;
        fh=S9d+bQpHol54BhdWYrNfQksRfYcQAZSjbyPQzQdh4oI=;
        b=dpdBHo4JLsNr3Vx2vmikoja4yLd2jd8PgQAyP3CfGxkaWOQwxsfw3BQ4wODM6YToTH
         ayuAihyGAnSAivhbgYgbn1cDHqOEQN3M5PBUyVnaQ0tYzspBb0SFhDZqcYxm8Bm59Mk4
         as0WZI5T0PspebBN0kZD7/JavP6woDKjlGhY4W0qkGWYDZ4Z2A2L8fOKsD1EReNYcmtv
         2Y7wI08O0tNwyNW9dXrbxJvkkhG1mPm06HF7ip3jaDzKI/mcBu5+uF7WPLKW/vZooTs4
         n531GWiuI31WsBMKT6QzPoVaZK5KomVpDrcGOSDSCratYwSjOCFChQAA8EVK6vlJpdzk
         sKfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778598402; x=1779203202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K3beaZW1jplvB3FYWIrdXKEVFakjYTyE58XRCIOhPFc=;
        b=sbEReKWpiei+zg1mTeU9/7uDaNr6TIm45Qzum7v7WyBfs+YfRv0NQ9KBHh2mLeaWN8
         gUNue+wVp/+IFw9po3NWR/ne2YMl1uLhbh5rKcoWUC/CF/h7FdrnZ05l3q1X8nUlp6/Q
         2HvbKG31gQKc+OtaTiPz7WFwblKYDRtyu8R7WGH9rWTWoen0aLHvqfxFJQ9i6ox8+Lwx
         rEBJhtX4X4A3fKVB5IPQ7SmcFt4gdhWFJaR90W0J8ghATgUshrH2LjnqwywEvabbi942
         Yt86Og4k10NaScTR612B6Gin28N9BVof0tvuBhkh3FZR+CQzTl0tmkvO9buPjkA/BSxE
         gA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778598402; x=1779203202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3beaZW1jplvB3FYWIrdXKEVFakjYTyE58XRCIOhPFc=;
        b=LgKH9PisJkMPVw5zRim1paZfwp10OM3/z9BmdUixIfSU45jwqJaJryVOx6djQiC3hS
         l7RdILjcrpyW4CFzKbQmH0x1Vd5NNTfpU5HyFLVR3kktK+AdlFS0pOpZmwEM6e22SZIk
         Mt7stwezNBgGEzIoOuqMTl6wUJVflMSDj0bmRCmzjiyffUoVBnYKqRLzhiemU9/6J15J
         n79lUhgCfO0MGt04bK5cu+4rR+P4g0Fnasmuj1/KnVfx4dC3Dja4esvlfDB7XdsnhFff
         tFuRFc1DVnqC7cRd0Fz9E54RyCpGDfmCx7GQiBF99RmrVvbYpiT9Q0p29q0kxOnHi0J4
         JoVg==
X-Forwarded-Encrypted: i=1; AFNElJ80HgOeHF/svkko5YIWdOUyrqnJt51ITtXJHJ/pf7g2Y2IWv4JsslDRYQIbYoMMRxo6wq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv+wDgnJbudBdoflLqkU0FEsKlf/A++YmUHj/+poHRI0d6e0m0
	byJG7qyeGiR8JRzH1aMtWt9wrfaqPvjjcoWGUrnfkQftlEeOO0zrGtOwxQOAsydG1K2YW81L9u7
	cNWw2WQ8FqrbFK/fKX9tU7qJ4DgK42b3PKbRcG326
X-Gm-Gg: Acq92OHoYLumS9Qez9hhpP+AP1jemKbBKClBkMzhOe7UhZYSYMsc9hXSkvmcb/OtnHZ
	G1dA8cFt4gYc1gie3fudmVA0Ebz7PDauDf/0RYpFL6EaU/VU8PRxv5kBxIR99Hr6gZz+iQBFPas
	Z4tJudHCfbXXciYSjiTgcDj83closBZQi1k2UOS+IPDlZtFr6QNc5wSxKkXv+HEI6z6iPKSOI33
	DfUbNHgJT1NcjZgLTIS1jbQ99xRsJs7OFe1L4JjH+rClUjJSgJV7Nxwuyp5hRaI0rWYZwzOLU5i
	ltA43BLsupziLjd9DWFxUneJSzw0pPQR1huVKxPj9wpR+Ihw
X-Received: by 2002:a05:622a:a9d3:20b0:4f3:5475:6b10 with SMTP id
 d75a77b69052e-514d454198bmr12180171cf.8.1778598401986; Tue, 12 May 2026
 08:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511113759.610924-1-tabba@google.com> <20260511113759.610924-3-tabba@google.com>
 <agHugdIrptaXZW-2@google.com> <CA+EHjTw1z7ROF7u0fKqxDGao7S1kELxNWtyWhLoPQx5uwVfuWQ@mail.gmail.com>
 <agI7M7rZ_NZJyjhj@google.com> <CA+EHjTxDvkDGyd-uyAqW7ErVxcKnUBpCYAgmnYfCdh+CCSq=3g@mail.gmail.com>
 <agMqc7Zub3fqToxp@google.com>
In-Reply-To: <agMqc7Zub3fqToxp@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 12 May 2026 16:06:05 +0100
X-Gm-Features: AVHnY4IZcdb2DMJvh3qvpivj5i9gaNVVhOQykEAmW1saq1LKEVextu79Cahx9XY
Message-ID: <CA+EHjTwrfGnBa5UXdLgV2FPga7=HM0wCZ9F7nL6PjHurh2kP+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Fix FD double-close in kvm_vm_release()
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Will Deacon <will@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 14:30, Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, May 12, 2026, Fuad Tabba wrote:
> > On Mon, 11 May 2026 at 21:25, Sean Christopherson <seanjc@google.com> wrote:
> > > > I used kvm_vm_release() because it's the only public API that closes
> > > > vm->fd to trigger kernel-side destruction.  But the existing callers
> > > > follow it with vm_recreate_with_one_vcpu(), so the "release + later
> > > > kvm_vm_free()" path isn't exercised today.
> > > >
> > > > I see three ways to make this clean:
> > > >   a) This patch: kvm_vm_release() becomes idempotent for its three
> > > >      FDs, matching the kvm_stats_release() idiom it already invokes.
> > > >   b) Leave kvm_vm_release() as-is and add a dedicated helper, e.g.
> > > >      kvm_vm_destroy_kernel(), that closes vm->fd to trigger kernel
> > > >      destruction while leaving the kvm_vm struct intact for
> > > >      post-destruction inspection.  kvm_vm_free() learns to handle the
> > > >      half-released state.
> > > >   c) Something else entirely, e.g., the test should manage vm->fd
> > > >      directly and not rely on library helpers for this pattern.
> > >
> > >     d) Fully kill the VM; validate the semantics with an explict mmap().
> > >
> > > The entire point of the test you are writing is to verfiy that a guest_memfd VMA
> > > doesn't somehow cause KVM to leak state.  So, make that obvious instead of abusing
> > > APIs that kinda sorta do what you want, but not really.
> > >
> > >         mem = kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED,
> > >                        region->guest_memfd);
> > >
> > >         ...
> > >
> > >         kvm_vm_free(vm);
> > >
> > >         TEST_ASSERT(is_zero(mem, ...));
> >
> > The test isn't about guest_memfd.  The pKVM support that just landed
> > via Will's series [1]
>
> Landed where?  Is pKVM actually going upstream with anonymous memory?  I thought
> the inability to protect against page faults in the untrusted kernel was a
> non-starter?
>
> > kvm_mmap() + kvm_vm_free() + is_zero() doesn't translate here.  The only
> > host view of the donated pages is the memslot mmap, and kvm_vm_free()
> > munmaps it on the way out, so inspection has to happen between
> > kernel-side destruction and userspace free.  kvm_vm_release() is the
> > only library primitive that does that today.
> >
> > What do you suggest?
>
> Manually allocate the memory and expose it to the guest via
> vm_set_user_memory_region2() vm_set_user_memory_region().
>

That works for this test and is cleaner.  I'll restructure: mmap the
backing in the test, vm_set_user_memory_region2() it in, then
kvm_vm_free() -> is_zero() through the test-owned VMA -> munmap().
That drops the motivation for the kvm_vm_release() fd-guard patch
in this series; happy to drop it, or to keep it as a standalone
"match the kvm_stats_release() idiom" cleanup, whichever you prefer.

Thanks,
/fuad
