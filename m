Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCAD2DF701;
	Sat, 30 May 2026 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780103433; cv=none; b=DbNh9DNXhUP1uhsl7tSTXdE7JgABCiu6iIFlkUqVSUnGScbeJutEZL9lHV5rXettVyTlqNDhJuCse5AvF8y0zPxluAmdT6LBQtvPODA8hsX//7qt4dknaYMGt4IsCd8h13lVt4/fpC040s0kXBtcOkznOAx+lhFxRC5MkiGeQ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780103433; c=relaxed/simple;
	bh=M3bKVIX8RhzkH0JC9WwReExSUFPYtwEkbVtmsN3u4Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKxI5pUhoAlA/m+Teeokb0xPhMZFdPFQGEt8KJ4nWtZ/BMOnBB2HsVIOeXORGZ/txPl6CBMaDTgtRZBov+nS5kTFLWdG6+zXmf1ARwiLIVg8zNSQ4zAcVC1txND51ouwxH6tvgMuITf3ZwtB9NSfrAWbZGWpWtJbrZAqxb9Zbsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqtScVA4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqtScVA4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D921F00893;
	Sat, 30 May 2026 01:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780103431;
	bh=nGZhRpC/Gl0qz8zi9EA7DSdNePQn8NAzQT4NZeT5uek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OqtScVA4SA31/PLot5NFoEC8vjnfZOHBOdvuMkLwL0t6NzlYxdGqpMcaOq3I9rZaf
	 ifmTr4PBtElhoU3776lhHiu03BRo2Mncywgny2BgZBihvJNbDJdlUW0oD9UzsrKD1+
	 bBl8UtbaMaZ9u1PqOMq0Q+gS4oEIarTUF5wDb78v8YYUj5n++U4PmJlJruPwOK0/S7
	 bucnw8mpI8eh6PjAsWf/sGN3OIzBtSKjOIU8CgtFLW7qrrOx48XCC1ojJI+3IduQkW
	 2UoIXOAPUDll7oCo1ab+jDs8KOcTCNzJUEjmmUIMLa7tkCrR9kz18e/SKELVuqeYHN
	 CojQVjkMDunlw==
Date: Sat, 30 May 2026 01:10:30 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 36/40] KVM: x86: Move IRQ-related helper declarations
 from kvm_host.h => irq.h
Message-ID: <aho4YC1ufeX14HCE@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-37-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-37-seanjc@google.com>

On Fri, May 29, 2026 at 03:22:19PM -0700, Sean Christopherson wrote:
> Move the function declaration for APIs to get/query pending IRQs from
> kvm_host.h to irq.h, as the APIs are only used by KVM x86 code.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 5 -----
>  arch/x86/kvm/irq.h              | 6 ++++++
>  arch/x86/kvm/svm/nested.c       | 1 +
>  arch/x86/kvm/vmx/nested.c       | 1 +
>  4 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 866d33abaee0..38de6c0dc743 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2360,12 +2360,7 @@ enum {
>  # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, 0)
>  #endif
>  
> -int kvm_cpu_has_injectable_intr(struct kvm_vcpu *v);
> -int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
> -int kvm_cpu_has_extint(struct kvm_vcpu *v);
>  int kvm_arch_interrupt_allowed(struct kvm_vcpu *vcpu);

kvm_arch_interrupt_allowed() is only used in x86.c. Probably it wasn't
used outside of x86 code after a1b37100d9e29c1f8dc3e2f5490a205c80180e01.

It should probably be renamed and moved, maybe separately.

Anyway:

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
