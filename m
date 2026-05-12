Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D423905FA
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592603; cv=none; b=jRmF6kkWLjdCDNTd4dTr/amrgT8lk+/ZYqo8ONNwk/Mqq+5BaYWH69taQA9YDw56M4gyo2I/Z9njOK4GwfrIjee1NDAvoq1dHwEKSLNYCQx5syp/FDJo3G3/GdQ1dTkxF+oFuk7nrqVl51JZ2JPsqvjz3hb59NlfFfxJzxLcVVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592603; c=relaxed/simple;
	bh=pDiZshBpS/wxU9Uro1koolEi4k/3XegrJ3uZ3HA4A2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J1SfcVNSOBSCo75kcnJkus4pax99Ya+xHUdTjQDb1VbSE8QWalk9yurHQU7q2yM4OxKzXh+8gg9ixqgXkE60OhtnnrhNCbM3tp5Dw80Tjfo3SZVMr9ISgA9AivHe3ghpliK/mcTIohoFA+SThSTPCeXfmdCSYfM0rwc2qtJ5ZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G3HGiAhR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G3HGiAhR"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8353df9bc7eso5229875b3a.2
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 06:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778592602; x=1779197402; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FwvmZbvQ55BiKQJH5ec2dbqWlhZ4p91dqEFuyoRuLTw=;
        b=G3HGiAhRZP/ux+tkdfyoXCj5LPp7oLHXTO8kHhKdwr56rSEUrMLTI6xQvGIYWcPzsv
         yqkBhpYQl4v5kRw+5VattIl7omv5e05anGG3ocu7GZFyLoPmPnisI14gove3IKt/mvsH
         r5p/4GXKJC9dWWsJX9+LzZmpvBhdQyfWRHvhIyBaziQ84ACLr4DeDzLbrGGUZUa/qo9u
         0o1cjyscmO4OqUfd77UtObHgOG/otJRCelrRMFQR/9/ILUduvYoEHC8HpEhwjMTp67M+
         LzEpK80jIwbmNd1sLZdu4RlvBcB1s9WuW7zKDixtCWvTO0gzI/WShy29/DPF1H/bORmI
         0OXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778592602; x=1779197402;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwvmZbvQ55BiKQJH5ec2dbqWlhZ4p91dqEFuyoRuLTw=;
        b=MYlW6CqE3mldrIpbyXu7qUqz1MWUwX0SW3VXxjN0WeVRXUgUHYoEe4FaW8wwPeDF0t
         R7ceK1l69ltbnvpO4ZsWH7fsrucE1dG5mx5T3rRhSwBnPqpo4pqHMRboCUx0br9KywXV
         hvUCcpFH3AZwXzL63o0iCUon4X2i1yZHglKa9IypjhelKQux0Fx/WnlkmT8kMuzadOH/
         MVkN1Zh9zUZBEcLRmb+jcaF5YYTppw+e+ukpDMsSPp9vO3YTx0yDUPewUjHc0gpvDWqa
         AWRfz+necdUYE7lE9n5h0alGDyjqwzQp3EfYLaXZFhJwaAZj6K61SxJ43iVqFbBPo0Ku
         t7Xg==
X-Forwarded-Encrypted: i=1; AFNElJ8Dg6J0O85507rRQHKptLWfkNmUItykKnvvTDdsX7gWK5v4C0wS3G54AXJc2eppM9TTWZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY8H+fF9hkBPhGXRB+E4ENETeOjNE2CRenUzL5QvfNia446nVx
	PSX0TP6hW536rIfTlV49sI9uYoKRc9ekDWvGQjDzUvL5uDcvPWuk+K/J0UqARgsSx4vWMsoDS2O
	hY3HG7Q==
X-Received: from pfbcg6.prod.google.com ([2002:a05:6a00:2906:b0:836:ed4a:203f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:80ed:b0:83d:b11f:796c
 with SMTP id d2e1a72fcca58-83db11f7bc9mr12471248b3a.49.1778592601686; Tue, 12
 May 2026 06:30:01 -0700 (PDT)
Date: Tue, 12 May 2026 06:30:00 -0700
In-Reply-To: <CA+EHjTxDvkDGyd-uyAqW7ErVxcKnUBpCYAgmnYfCdh+CCSq=3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511113759.610924-1-tabba@google.com> <20260511113759.610924-3-tabba@google.com>
 <agHugdIrptaXZW-2@google.com> <CA+EHjTw1z7ROF7u0fKqxDGao7S1kELxNWtyWhLoPQx5uwVfuWQ@mail.gmail.com>
 <agI7M7rZ_NZJyjhj@google.com> <CA+EHjTxDvkDGyd-uyAqW7ErVxcKnUBpCYAgmnYfCdh+CCSq=3g@mail.gmail.com>
Message-ID: <agMqc7Zub3fqToxp@google.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Fix FD double-close in kvm_vm_release()
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Will Deacon <will@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, May 12, 2026, Fuad Tabba wrote:
> On Mon, 11 May 2026 at 21:25, Sean Christopherson <seanjc@google.com> wrote:
> > > I used kvm_vm_release() because it's the only public API that closes
> > > vm->fd to trigger kernel-side destruction.  But the existing callers
> > > follow it with vm_recreate_with_one_vcpu(), so the "release + later
> > > kvm_vm_free()" path isn't exercised today.
> > >
> > > I see three ways to make this clean:
> > >   a) This patch: kvm_vm_release() becomes idempotent for its three
> > >      FDs, matching the kvm_stats_release() idiom it already invokes.
> > >   b) Leave kvm_vm_release() as-is and add a dedicated helper, e.g.
> > >      kvm_vm_destroy_kernel(), that closes vm->fd to trigger kernel
> > >      destruction while leaving the kvm_vm struct intact for
> > >      post-destruction inspection.  kvm_vm_free() learns to handle the
> > >      half-released state.
> > >   c) Something else entirely, e.g., the test should manage vm->fd
> > >      directly and not rely on library helpers for this pattern.
> >
> >     d) Fully kill the VM; validate the semantics with an explict mmap().
> >
> > The entire point of the test you are writing is to verfiy that a guest_memfd VMA
> > doesn't somehow cause KVM to leak state.  So, make that obvious instead of abusing
> > APIs that kinda sorta do what you want, but not really.
> >
> >         mem = kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED,
> >                        region->guest_memfd);
> >
> >         ...
> >
> >         kvm_vm_free(vm);
> >
> >         TEST_ASSERT(is_zero(mem, ...));
> 
> The test isn't about guest_memfd.  The pKVM support that just landed
> via Will's series [1] 

Landed where?  Is pKVM actually going upstream with anonymous memory?  I thought
the inability to protect against page faults in the untrusted kernel was a
non-starter?

> kvm_mmap() + kvm_vm_free() + is_zero() doesn't translate here.  The only
> host view of the donated pages is the memslot mmap, and kvm_vm_free()
> munmaps it on the way out, so inspection has to happen between
> kernel-side destruction and userspace free.  kvm_vm_release() is the
> only library primitive that does that today.
> 
> What do you suggest?

Manually allocate the memory and expose it to the guest via
vm_set_user_memory_region2() vm_set_user_memory_region().

