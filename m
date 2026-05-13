Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6264DB57A
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694769; cv=none; b=VDfDkWa9oV9JkSAmNHv3t6XZnlVIz20h6gV1Rp7qDZPsyPV6JKFl0y67XSh9TuRzaVqG/+X5DqHiuwTgjPGO5/DfNo3PppYNh+P1PHqaAdkEqi4L2FNssJdi18UtckK6MABKcdXWTQTQe/Tr4S0wmvv83wu6Bry6YTNf9jn8X/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694769; c=relaxed/simple;
	bh=9W+890ujBXwwVpQJQ8zKRCFTTdvxYay4Jdn5hyLyHjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMqLhAYSNKN1X0f0Hx9U71lYwzVlSvPjhwyp4fmElgmbz6B0WKAien0aNaUpgnUQ5FgiDkPailoezAus9bu/+aomjENwdJLhWc9qMMBsOeqK6Ngtq6QY949pZcruVDdEoudq++mWbchK/QfzdVXW/f84oel/4ikUgnjCTv6iSFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BgVxb1wD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgVxb1wD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778694767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Fg3GMEPHYejBQ9ioJAer/Jnm06fBGw+OHIcN8h472II=;
	b=BgVxb1wD3DdFZMS2yQlx68rNVSaiM2x25bmjD7odpjPGnO0CeWo1I5Vk651uvFDW76F/UC
	5mwhicXdGq5xtQkZu2OvAOeEUwPVQ/Seiu08FLBfuWoQtangYyMbrE1fMsKoy1Sm2Kojfs
	Q3R5sT5nCUOcrw+YMhFMWrxRQjiec7Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-B0nhTHzCOYeRsjMv31quBA-1; Wed,
 13 May 2026 13:52:43 -0400
X-MC-Unique: B0nhTHzCOYeRsjMv31quBA-1
X-Mimecast-MFC-AGG-ID: B0nhTHzCOYeRsjMv31quBA_1778694762
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B74F18002D0;
	Wed, 13 May 2026 17:52:42 +0000 (UTC)
Received: from [10.44.50.86] (unknown [10.44.50.86])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E6ED195394A;
	Wed, 13 May 2026 17:52:40 +0000 (UTC)
Message-ID: <9d3618a8-1927-40aa-87dc-a0bcc2c0f6c1@redhat.com>
Date: Wed, 13 May 2026 19:52:39 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/21] KVM: x86: Enable APX for guests
To: "Chang S. Bae" <chang.seok.bae@intel.com>, seanjc@google.com
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 chao.gao@intel.com
References: <20260512011502.53072-1-chang.seok.bae@intel.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260512011502.53072-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 5/12/26 03:14, Chang S. Bae wrote:
> Hi all,
> 
> This round contains relatively smaller changes compared to previous
> versions:
> 
>    * Generalize the load/store sequences to cover all GPRs (PATCH1-3)
>    * Clarify APX exclusion from the x86 xstate copy functions (PATCH6)
> 
> A few notes for the x86-side changes:
> 
>    * Move the previously deprecated arch/x86/include/asm/inst.h into KVM
>    * PATCH6 since x86 changes is better to gain an ACK from the x86
>      maintainers before going anywhere
> 
> The patchset still depends on these in-flight series:
> 
>    * Paolo's SPEC_CTRL refactoring
>      https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?h=queue&id=fcaf986d10768dddb23598d6f0560006dad0c8bd
>    * Sean's preparatory series
>      https://lore.kernel.org/kvm/20260409224236.2021562-1-seanjc@google.com/
> 
> A few notes are also worth retaining in the cover letter:
> 
> == State Management Design ==
> 
>    The initial approach (before V3) was access physical EGPRs directly
>    similar to vector registers, but this introduces non-uniform access
>    patterns against directly accessing VCPU regs[]. Sean thus gave his
>    feedback to shift away from it.
> 
>    To maintain uniformity, EGPRs need to be stored in regs[]. Sean's reg
>    accessor infra updates makes this feasible. It was also realized that
>    saving EGPRs outside of the fastpath is not viable, as fastpath
>    handlers may access EGPRs as well.
> 
>    Then, saving EGPRs on entry code appears to be the choice. This also
>    looks to provide some degree of robustness (but not completely yet
>    though [*]) for when the kernel clobbers those registers. The VCPU XCR0
>    can gate this path to avoid #UD from non-APX guests.
> 
>    The conditional path should be also under speculation-safety, rather
>    than wild guest control. Paolo's rework on entry code will establish a
>    SPEC_CTRL macro which allows a finer control.
> 
>    For userspace interactions, the EGPR state in regs[] can be copied
>    directly to/from the userspace buffer at the boundary of ABI handlers.
> 
> == Series Structure and Test Note ==
> 
>    * Part1, PATCH 01-03: Prepare entry code by macrofying GPR handling
>      Most KVM test will capture any regression out of it. I also tested it
>      more explicitly with tweaking the posted patch [1].
> 
>    * Part2, PATCH 04-07: Establish EGPR state management
>      These new state management flow is rather unique compared to other
>      XSTATEs. This fact leads to new test cases (patch20), in addition to
>      state_test (patch21).
> 
>    * Part3, PATCH 08-12: Update VMX handlers for extended reg. indices
>      Previously I tweaked to test an exit case like LGDT with an extended
>      ID. But this part leans into VMX unless KVM is paranoid.
> 
>    * Part4, PATCH 13-16: Add emulator support for REX2
>      KVM unit test patch [1] covers emulator changes.
> 
>    * Part5, PATCH 17-21: Expose features and add selftests
>      XCR0 tests basically covers the exposition.
> 
> This series is currently based Sean's preparatory series on top of the
> KVM's queue branch, which already includes Paolo's SPEC_CTRL rework. The
> full set is also available at:
> 
>    git://github.com/intel/apx.git apx-kvm_v4

Placed in kvm/queue while waiting for arch/x86/kernel/ acks, thanks!

Paolo

> Thanks,
> Chang
> 
> References:
> [1] KVM unit tests:
>      https://lore.kernel.org/kvm/20260420212355.507827-1-chang.seok.bae@intel.com
> [2] Previous version (V3):
>      https://lore.kernel.org/lkml/20260428050111.39323-1-chang.seok.bae@intel.com
> [3] APX specification:
>      https://cdrdv2.intel.com/v1/dl/getContent/784266
> [*] E.g. NMIs at entry code could mess up with APX-clobbering handlers
>      when XCR0[APX]=0. VMX extension to afford XCR0 switching by hardware
>      itself could be an option to avoid the issue.
> 
> Chang S. Bae (20):
>    KVM: VMX: Macrofy GPR swapping in __vmx_vcpu_run()
>    KVM: SVM: Macrofy GPR swapping in __svm_vcpu_run()
>    KVM: SEV: Macrofy GPR swapping in __svm_sev_es_vcpu_run()
>    KVM: x86: Extend VCPU registers for EGPRs
>    KVM: VMX: Save guest EGPRs in VCPU cache
>    KVM: x86: Support APX state for XSAVE ABI
>    KVM: VMX: Refactor VMX instruction information access
>    KVM: VMX: Refactor instruction information decoding
>    KVM: VMX: Refactor register index retrieval from exit qualification
>    KVM: VMX: Support instruction information extension
>    KVM: nVMX: Propagate the extended instruction info field
>    KVM: x86: Support EGPR accessing and tracking for emulator
>    KVM: x86: Handle EGPR index and REX2-incompatible opcodes
>    KVM: x86: Support REX2-prefixed opcode decode
>    KVM: x86: Reject EVEX-prefixed instructions
>    KVM: x86: Guard valid XCR0.APX settings
>    KVM: x86: Expose APX foundation feature to guests
>    KVM: x86: Expose APX sub-features to guests
>    KVM: x86: selftests: Add APX state and ABI test
>    KVM: x86: selftests: Add APX state handling and XCR0 sanity checks
> 
> Paolo Bonzini (1):
>    x86/fpu: Ignore APX when copying from/to guest FPU
> 
>   arch/x86/Kconfig.assembler                    |   5 +
>   arch/x86/include/asm/fpu/api.h                |   2 +-
>   arch/x86/include/asm/kvm_host.h               |  52 +++--
>   arch/x86/include/asm/kvm_vcpu_regs.h          |  25 ---
>   arch/x86/include/asm/vmx.h                    |   2 +
>   arch/x86/kernel/fpu/core.c                    |   9 +-
>   arch/x86/kvm/Kconfig                          |   4 +
>   arch/x86/kvm/cpuid.c                          |  28 ++-
>   arch/x86/kvm/cpuid.h                          |   2 +
>   arch/x86/kvm/emulate.c                        | 121 +++++++----
>   arch/x86/{include/asm => kvm}/inst.h          |  88 +++++---
>   arch/x86/kvm/kvm_emulate.h                    |  13 +-
>   arch/x86/kvm/reverse_cpuid.h                  |   6 +
>   arch/x86/kvm/svm/svm.c                        |   8 +-
>   arch/x86/kvm/svm/vmenter.S                    | 107 ++--------
>   arch/x86/kvm/vmenter.h                        |  44 ++++
>   arch/x86/kvm/vmx/nested.c                     |  74 +++----
>   arch/x86/kvm/vmx/nested.h                     |   2 +-
>   arch/x86/kvm/vmx/vmcs12.c                     |   1 +
>   arch/x86/kvm/vmx/vmcs12.h                     |   3 +-
>   arch/x86/kvm/vmx/vmenter.S                    | 120 +++++------
>   arch/x86/kvm/vmx/vmx.c                        |  26 ++-
>   arch/x86/kvm/vmx/vmx.h                        |  77 ++++++-
>   arch/x86/kvm/x86.c                            |  70 ++++++-
>   tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>   .../selftests/kvm/include/x86/processor.h     | 120 +++++++++++
>   tools/testing/selftests/kvm/x86/apx_test.c    | 191 ++++++++++++++++++
>   tools/testing/selftests/kvm/x86/state_test.c  |   3 +
>   .../selftests/kvm/x86/xcr0_cpuid_test.c       |  19 ++
>   29 files changed, 905 insertions(+), 318 deletions(-)
>   delete mode 100644 arch/x86/include/asm/kvm_vcpu_regs.h
>   rename arch/x86/{include/asm => kvm}/inst.h (62%)
>   create mode 100644 tools/testing/selftests/kvm/x86/apx_test.c
> 
> 
> base-commit: 98bfa4c89d413dfc69beedd1d3414d5bf15db5b9

