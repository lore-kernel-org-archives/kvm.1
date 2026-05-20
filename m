Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308552857FA;
	Wed, 20 May 2026 23:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779318388; cv=none; b=bxdIlseWpCgxHqfVx6O4++zZtoJpTpINjkbC7P3df0VlDFde+OcBFaBMseKCRCvJKnTspdPc84xOrElifdLaL2J3oq+pB5dyFgGosGYMR3rn3FqfqfTG2OJjPg5k8E5MwV8yKtBHwqlgI5vWGQoB91+mEQFQgJZd62xrAq/VIds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779318388; c=relaxed/simple;
	bh=V313m8L97j8mFtY/XUymRF9YlUvkZE0RumOS54eIe28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTwWshpE+7aAwpO4CvteYftygIyyHCCLTZv15Yl2lj/Q24benykekjkoCyPeKxE8FiiLGsvlpS85x5ucbilzjFleHTxstg1+wn20iwf6SAbz+MmNTlAkEMSBeS389J7UD5R9lRuvNjgh+ne1+aWTmEl3uMzNiztAoYZly//7ylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByNanX0C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByNanX0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3391F000E9;
	Wed, 20 May 2026 23:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779318386;
	bh=BVGPLAkKkk1YqfqfUN1P6AMENqtxRJwQpWbMuxkSR+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ByNanX0C/5bgwCHg7NrVM9PQaZ0U4D3aYm6uyCMIn56e7+u4sRYG1l4ojgaj8rUad
	 MnThpjNCLs2+06YrYyjO/blObLBWyHQIxW0o8ovx+U0UFcHJfveq2ZSKcjkfEX38E5
	 ey6F7mt2GS5fQqv7v6YXJ0XocCU2eV1JKWdCHU2XsxP0llnQ5r1Kui23NJZOtNB53S
	 mCJGwOSs3hZRh+lYz+Q9rQy5eyGZ+OimD1FTQZntBWbV//iNYxtQScGZJF64nDu6Us
	 PN5KM6ZEFJ+x203utm9wk+Z8WnB4YOaxeIU702btlUODMswClW7UkkKj5utgSF6CZr
	 y5uEqUxANe/fQ==
Date: Wed, 20 May 2026 16:06:21 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@kernel.org, linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	Paolo Bonzini <bonzini@redhat.com>
Subject: Re: [PATCH v3 1/2] x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into
 x86 core
Message-ID: <20260520230621.GA706311@ax162>
References: <20260423155611.216805954@infradead.org>
 <20260423155936.843498069@infradead.org>
 <20260508091829.GO3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508091829.GO3126523@noisy.programming.kicks-ass.net>

On Fri, May 08, 2026 at 11:18:29AM +0200, Peter Zijlstra wrote:
> 
> Move the VMX interrupt dispatch magic into the x86 core code. This
> isolates KVM from the FRED/IDT decisions and reduces the amount of
> EXPORT_SYMBOL_FOR_KVM().
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: "Verma, Vishal L" <vishal.l.verma@intel.com>

I am seeing

  vmlinux.o: warning: objtool: idt_do_interrupt_irqoff+0xe: no-cfi indirect call!

after this landed in -next.

  $ cat arch/x86/configs/repro.config
  CONFIG_CFI=y
  CONFIG_KVM=y
  CONFIG_KVM_INTEL=y

  $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 mrproper defconfig repro.config vmlinux
  vmlinux.o: warning: objtool: idt_do_interrupt_irqoff+0xe: no-cfi indirect call!

  $ llvm-objdump -drS --disassemble-symbols=idt_do_interrupt_irqoff vmlinux.o

  vmlinux.o:	file format elf64-x86-64

  Disassembly of section .text:

  0000000000001540 <idt_do_interrupt_irqoff>:
      1540: 55                           	pushq	%rbp
      1541: 48 89 e5                     	movq	%rsp, %rbp
      1544: 48 83 e4 f0                  	andq	$-0x10, %rsp
      1548: 6a 18                        	pushq	$0x18
      154a: 55                           	pushq	%rbp
      154b: 9c                           	pushfq
      154c: 6a 10                        	pushq	$0x10
      154e: e8 00 00 00 00               	callq	0x1553 <idt_do_interrupt_irqoff+0x13>
  		000000000000154f:  R_X86_64_PLT32	__x86_indirect_thunk_rdi-0x4
      1553: c9                           	leave
      1554: e9 00 00 00 00               	jmp	0x1559 <idt_do_interrupt_irqoff+0x19>
  		0000000000001555:  R_X86_64_PLT32	__x86_return_thunk-0x4
      1559: cc                           	int3
      155a: cc                           	int3
      155b: cc                           	int3
      155c: cc                           	int3
      155d: cc                           	int3
      155e: cc                           	int3
      155f: cc                           	int3
      1560: 90                           	nop
      1561: 90                           	nop
      1562: 90                           	nop
      1563: 90                           	nop
      1564: 90                           	nop
      1565: 90                           	nop
      1566: 90                           	nop
      1567: 90                           	nop
      1568: 90                           	nop
      1569: 90                           	nop
      156a: 90                           	nop
      156b: 90                           	nop
      156c: 90                           	nop
      156d: 90                           	nop
      156e: 90                           	nop
      156f: 90                           	nop

Cheers,
Nathan
