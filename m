Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B49A36A371;
	Tue, 12 May 2026 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598254; cv=none; b=u8+a3g68MOytutm2Ky6Z6xbsSebsO0JsivT0lqtPKzjziSrQSG/E7qfJhBkvR8bJXBKMO/xng9e0WKXBfdpMrm19GL2euEuz1ELhIGinmLWiJRkpNBbKlnEH/gszBDeE7T+nyjTVhGJ63UZgCQFx99ZPbV8EURnjUqlKEHlbPQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598254; c=relaxed/simple;
	bh=9e4agnsk3Epm26Tyl0betzKQu1e9CrI0C+7TCaDt8nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtnnOZTyNALosFtGzdX4Uo/H9hPcLCUXeVmUI0wpF8kYe/8artSmvOd7qLtC11ZEhp55SsF5zOphHS9+mZXLNh404Ic9Ly2JDh2rfU1f7TF0KsPdJoLd4iSeLvcxposn/E+vW2nS8t/hCl3vQVTFUgdCPXUlWJfUouRuEtSHXjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqU6CxSs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqU6CxSs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1589C2BCB0;
	Tue, 12 May 2026 15:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778598253;
	bh=9e4agnsk3Epm26Tyl0betzKQu1e9CrI0C+7TCaDt8nw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iqU6CxSsBmKcbXgDGiaK/i2wZz6tXgeYklO0e5H3cPPPN1jJQFVXpVERGPbC0KKey
	 EUI5PARUfPIxJA/wbgDFclAdkEeD3sexJAMiDs+Lw3XbYnp5x7VCRe6nnT44nxcACw
	 Co4h9VRQ1KoRWfQ1gUnMhpK2e21n7V2tLeAqjpBhq1V++OxhORlFDSP/ewIkIO8ZL9
	 cT0MCK1Gvh8N9erTdbik71h4wjCuoCZxRZkU42lP0PvyhTd0S16TtdVbmfEDeT7LEQ
	 JjQIcr13AJ75RBJr6YaVggmP8XAdJNMeUWhpDOcEfq+6h75AuZJXako6ySeEhbrK7y
	 KwVIlzGo/s20g==
Date: Tue, 12 May 2026 16:04:07 +0100
From: Will Deacon <will@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Fuad Tabba <tabba@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Ackerley Tng <ackerleytng@google.com>,
	David Matlack <dmatlack@google.com>, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: selftests: Fix FD double-close in
 kvm_vm_release()
Message-ID: <agNBZ94I5SMCOzmi@willie-the-truck>
References: <20260511113759.610924-1-tabba@google.com>
 <20260511113759.610924-3-tabba@google.com>
 <agHugdIrptaXZW-2@google.com>
 <CA+EHjTw1z7ROF7u0fKqxDGao7S1kELxNWtyWhLoPQx5uwVfuWQ@mail.gmail.com>
 <agI7M7rZ_NZJyjhj@google.com>
 <CA+EHjTxDvkDGyd-uyAqW7ErVxcKnUBpCYAgmnYfCdh+CCSq=3g@mail.gmail.com>
 <agMqc7Zub3fqToxp@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agMqc7Zub3fqToxp@google.com>

On Tue, May 12, 2026 at 06:30:00AM -0700, Sean Christopherson wrote:
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
> Landed where?  Is pKVM actually going upstream with anonymous memory?

The basic memory protection code for pKVM using anonymous memory is now
upstream but we still have a tonne to do for CPU state, DMA, firmware
loading etc. It obviously doesn't preclude support for guest_memfd in
future and, as you know, Fuad has been actively involved in that
discussion over the years. It does, however, mean that we'd be offering
guest_memfd alongside anonymous memory, which matches what we'd have to
do in Android at this point anyway (given the millions of devices using
anonymous memory in the field). Of course, if that means we should have
an additional set of tests, then that's fine.

> I thought the inability to protect against page faults in the untrusted
> kernel was a non-starter?

We ended up solving that by forcefully reclaiming the target page from
the guest. So the flow looks something like:

1. The host kernel accesses a private (faulting) page via a kernel mapping
2. An exception is taken to the hypervisor
3. The hypervisor injects an exception back into the kernel, with
   sufficient syndrome information to triage it as an access to a private
   page.
4. The kernel searches its usual exception handlers (for things like
   load_unaligned_zeropad())
5. If no handlers are found, the kernel translates the faulting virtual
   address into a physical address using the 'AT' instruction and issues
   a hypercall to forcefully reclaim the page.
6. The hypervisor unmaps the page from the guest and replaces the guest
   pte with an immutable "poison" (faulting) entry. If a vCPU later
   faults on this entry, it returns to userspace with -EFAULT.
7. The hypervisor clears the unmapped page, maps it back into the host
   and returns from the hypercall.
8. The kernel treats the fault as "spurious" and retries the faulting
   instruction.

If the faulting access in (1) instead came from userspace, the kernel
injects a SEGV at (4). If the faulting access came from a uaccess
routine (e.g. copy_from_user()), then the fixup handler would run like
normal in (4).

Will
