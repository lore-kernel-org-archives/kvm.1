Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4EF34E75C
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160370; cv=none; b=JFP5kveeOGh5/uLf+y1Qh+RPsll//qStAeDtYzoNQbUuenhavP7Ji+ue3X/5x6GxddnOVVc4iVq5RI12ECx0j4H/RyrpbtYm5MQuVwhVI/2bd2kcidg3mLQdvg6WnePbAtE7xMX7Y6DtGwvecjElGC0r9bbETiR+h2luum+iSTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160370; c=relaxed/simple;
	bh=RkupLxr2klV1RXJtaTOnxBP0hXFG4YZZpSHw0GMULgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JP2HUVD/gp06Ktcobs8Om5in6HdxtcGlBG9OU/g3H405Flvuc0LqIPLcA4AqGSWAPztS3qaa5hnNgdpmc+4ngXy8hMyiVjpdhkDZYzEGbUaazf45rdd5Fbd3QqlLBpVD4agaGqYC5XhuyFYhW108oGa5KlHvN+UdKaL9fg2wTxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaxLV6Nq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaxLV6Nq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780160367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PfALm3Pjk4fuctRgh9swgrFCHCwUlFooQZNiMSzJrwg=;
	b=FaxLV6NqQ/rej50GMEOGNlyU0Vnh9dC/wEvITsh3aQoMH/6vn4OZqaqds6Im4ylasfs6JW
	2VpWM+BjpmwaVDqUXgtPa1GDRn7AcELo0Pjv3K8V63iR98L+na+DKwhF40TCiIOG5oCNzG
	JF8AdzTa9Ceh2NOai8H6+O7AGHL6pP4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246---1GnOhLMF2hRT4IK01LYg-1; Sat,
 30 May 2026 12:59:24 -0400
X-MC-Unique: --1GnOhLMF2hRT4IK01LYg-1
X-Mimecast-MFC-AGG-ID: --1GnOhLMF2hRT4IK01LYg_1780160363
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F11D1956046;
	Sat, 30 May 2026 16:59:22 +0000 (UTC)
Received: from [10.44.32.29] (unknown [10.44.32.29])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 83B4F180034E;
	Sat, 30 May 2026 16:59:18 +0000 (UTC)
Message-ID: <f1cae8a8-8842-493e-9b6a-6f0e0d761c4e@redhat.com>
Date: Sat, 30 May 2026 18:59:17 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/40] KVM: x86: GPR accessors and x86.{c,h} spring
 cleaning
To: Sean Christopherson <seanjc@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>,
 David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 5/30/26 00:21, Sean Christopherson wrote:
> The first half of this series adds proper, explicit "raw" versions of
> kvm_<reg>_{read,write}(), along with "e" versions (for hardcoded 32-bit
> accesses), and converts the existing kvm_<reg>_{read,write}() APIs into
> mode-aware variants.
> 
> At the end of that journey, introduce regs.{c,h} to avoid moving _more_ code
> into x86.h, especially since the resulting code split would be super arbitrary.

What about getting everything up to patch 14 into 7.2, and then starting 
7.3 development with these, the MMU split series, and possibly the 
pfncache cleanups?

I'll be away starting June 28th, so we probably want to get those three 
merged into kvm/next already towards the end of the merge window.

Paolo

> The second half of the series runs with the regs.{c,h} changes and performs
> spring cleaning on x86.{c,h} and asm/kvm_host.h (in case it wasn't already
> obvious, I have poor impulse control when it comes to cleaning up code).
> 
> I'm most intersted in getting feedback on the file names (regs.{c,h} and
> msrs.{c,h}.  I'm quite confident the actual code split is the way to go, and
> pulling stuff out of asm/kvm_host.h has been on my wish/todo list for years.
> 
> I'll grab these fixes for 7.2 no matter what:
> 
>    KVM: x86: Trace hypercall register *after* truncating values for 32-bit
>    KVM: VMX: Read 32-bit GPR values for ENCLS instructions outside of 64-bit mode
>    KVM: x86/xen: Don't truncate RAX when handling hypercall from protected guest
>    KVM: x86/xen: Bug the VM if 32-bit KVM observes a 64-bit mode hypercall
> 
> Depending on how people feel about the names and cleanups, I'll either send
> the big cleanups as a separate pull request after the initial for-7.2 pull
> requests (if there's overwhelming consensus on the names/splits), or wait for
> 7.3 (if more discussion is needed).
> 
> v3:
>   - Collect more tags. [David, Binbin, Yosry]
>   - Use kvm_run_sync_regs_{from,to}_user() instead of kvm_run_{g,s}et_regs().
>     [Kai]
>   - Fix a variety of typos. [Binbin]
>   - Everything beyond patch 15...
> 
> v2:
>   - https://lore.kernel.org/all/20260514215355.1648463-2-seanjc@google.com
>   - Collect tags. [Yosry, Kai]
>   - Fix some truly egregious goofs. [Binbin]
>   - Rename kvm_cache_regs.h => regs.h, add regs.c. [Yosry, because he
>     complained, not because he actually suggested this :-D ]
>   - Drop superfluous casting/masking of e*x() usage. [Kai]
> 
> v1: https://lore.kernel.org/all/20260409235622.2052730-1-seanjc@google.com
> 
> Sean Christopherson (40):
>    KVM: SVM: Truncate INVLPGA address in compatibility mode
>    KVM: x86/xen: Bug the VM if 32-bit KVM observes a 64-bit mode
>      hypercall
>    KVM: x86/xen: Don't truncate RAX when handling hypercall from
>      protected guest
>    KVM: VMX: Read 32-bit GPR values for ENCLS instructions outside of
>      64-bit mode
>    KVM: x86: Trace hypercall register *after* truncating values for
>      32-bit
>    KVM: x86: Rename kvm_cache_regs.h => regs.h
>    KVM: x86: Move inlined GPR, CR, and DR helpers from x86.h to regs.h
>    KVM: x86: Add mode-aware versions of kvm_<reg>_{read,write}() helpers
>    KVM: x86: Drop non-raw kvm_<reg>_write() helpers
>    KVM: nSVM: Use kvm_rax_read() now that it's mode-aware
>    Revert "KVM: VMX: Read 32-bit GPR values for ENCLS instructions
>      outside of 64-bit mode"
>    KVM: x86: Harden is_64_bit_hypercall() against bugs on 32-bit kernels
>    KVM: x86: Move update_cr8_intercept() to lapic.c
>    KVM: x86: Move async #PF helpers to x86.h (as inlines)
>    KVM: x86: Move the bulk of register specific code from x86.c to regs.c
>    KVM: x86: Move local APIC specific helpers out of asm/kvm_host.h
>    KVM: x86: Drop defunct vcpu_tsc_khz() declaration
>    KVM: x86: Move kvm_caps and kvm_host_values to asm/kvm_host.h
>    KVM: x86: Swap the include order between x86.h and mmu.h
>    KVM: x86: Move tdp_enabled from kvm_host.h to mmu.h
>    KVM: x86: Move eager_page_split to mmu.{c,h}
>    KVM: x86/hyperv: Eliminate an unnecessary include of x86.h in hyperv.h
>    KVM: x86: Move kvm_{load,put}_guest_fpu() to fpu.h
>    KVM: x86: Extract get/set MSR (list) ioctl logic to helpers
>    KVM: x86: Expose several TSC helpers via x86.h for use by MSR code
>    KVM: x86: Move the bulk of MSR specific code from x86.c to msrs.{c,h}
>    KVM: x86: Move register helper declarations from kvm_host.h => regs.h
>    KVM: x86: Move kvm_{g,s}et_segment() to inline helpers in regs.h
>    KVM: x86: Remove defunct kvm_load_segment_descriptor() declaration.
>    KVM: x86: Move MSR helper declarations from kvm_host.h => msrs.h
>    KVM: x86: Move MMU helper declarations from kvm_host.h => mmu.h
>    KVM: x86: Move LLDT assembly wrappers into VMX
>    KVM: x86: Move kvm_cpu_get_apicid() from kvm_host.h => avic.c
>    KVM: x86: Move misc "VALID MASK" defines from kvm_host.h => x86.c
>    KVM: x86: Move __kvm_irq_line_state() from kvm_host.h => ioapic.h
>    KVM: x86: Move IRQ-related helper declarations from kvm_host.h =>
>      irq.h
>    KVM: x86: Move kvm_pv_send_ipi() declaration from kvm_host.h =>
>      lapic.h
>    KVM: x86/mmu: Move kvm_arch_async_page_ready() below
>      kvm_tdp_page_fault()
>    KVM: x86/mmu: Move kvm_mmu_do_page_fault() from mmu_internal.h =>
>      mmu.c
>    KVM: x86: Move a pile of stuff from kvm_host.h => x86.h
> 
>   arch/x86/include/asm/kvm_host.h           |  452 +--
>   arch/x86/kvm/Makefile                     |    4 +-
>   arch/x86/kvm/cpuid.c                      |   13 +-
>   arch/x86/kvm/emulate.c                    |    2 +-
>   arch/x86/kvm/fpu.h                        |   26 +
>   arch/x86/kvm/hyperv.c                     |   21 +-
>   arch/x86/kvm/hyperv.h                     |    7 +-
>   arch/x86/kvm/ioapic.c                     |    1 +
>   arch/x86/kvm/ioapic.h                     |   12 +
>   arch/x86/kvm/irq.c                        |    7 +
>   arch/x86/kvm/irq.h                        |    6 +
>   arch/x86/kvm/lapic.c                      |   28 +-
>   arch/x86/kvm/lapic.h                      |    9 +
>   arch/x86/kvm/mmu.h                        |   92 +-
>   arch/x86/kvm/mmu/mmu.c                    |  134 +-
>   arch/x86/kvm/mmu/mmu_internal.h           |   66 -
>   arch/x86/kvm/msrs.c                       | 2732 +++++++++++++++
>   arch/x86/kvm/msrs.h                       |  156 +
>   arch/x86/kvm/mtrr.c                       |    1 +
>   arch/x86/kvm/regs.c                       |  875 +++++
>   arch/x86/kvm/{kvm_cache_regs.h => regs.h} |  258 +-
>   arch/x86/kvm/smm.c                        |    2 +-
>   arch/x86/kvm/svm/avic.c                   |    5 +
>   arch/x86/kvm/svm/nested.c                 |    9 +-
>   arch/x86/kvm/svm/svm.c                    |   19 +-
>   arch/x86/kvm/svm/svm.h                    |    2 +-
>   arch/x86/kvm/vmx/nested.c                 |    9 +-
>   arch/x86/kvm/vmx/nested.h                 |    2 +-
>   arch/x86/kvm/vmx/sgx.c                    |    6 +-
>   arch/x86/kvm/vmx/tdx.c                    |   18 +-
>   arch/x86/kvm/vmx/vmx.c                    |   14 +-
>   arch/x86/kvm/vmx/vmx.h                    |    2 +-
>   arch/x86/kvm/x86.c                        | 3789 +--------------------
>   arch/x86/kvm/x86.h                        |  480 ++-
>   arch/x86/kvm/xen.c                        |   39 +-
>   35 files changed, 4722 insertions(+), 4576 deletions(-)
>   create mode 100644 arch/x86/kvm/msrs.c
>   create mode 100644 arch/x86/kvm/msrs.h
>   create mode 100644 arch/x86/kvm/regs.c
>   rename arch/x86/kvm/{kvm_cache_regs.h => regs.h} (50%)
> 
> 
> base-commit: d1568b1332b6b3b36b222c2868fc102727c12a34

