Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B182F4FDE61
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744832; cv=none; b=OoGkz6SjKzU1Zb2wyIP+4M7sdqnzk2Rs/9aQm0XIAIB/C9UCHY2Frev8hZqqd7QNPtYLkOr1ucZjz/2oqQ1Gs6KU5lAjEmS/eTDJhPBz4B5G/c70EmkerI7yDDFL6dVNDdzJt7dGQ3isJnOk7FuWj2oY/keTsOzQdi7AHuHBCY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744832; c=relaxed/simple;
	bh=ovaWvxow36WXHSa6vybQQMTcDgGqfi6uFNUbiiwYw+c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y30LwKaBvQ6nO04CRa3fCTooEvu7I4rQQV1ZfU1Kq0yv9kBJjVmQ+DMcyC6U/XCnLKo3vDOUNVF2F4/8CFHoKwTSS443Z86xlx+bvo8ttjrWXGuDLAEXp37cY1FSNwooYZDmr4RkfrDJFBdt8CDkCLwRU5944xXhqbHLQAyVMQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=axqVLly/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axqVLly/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789744829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=adglXUWynEeiltce+pOA1IZytW30VrOtxV5r38mK1Ck=;
	b=axqVLly/hxV4RzOo1EoWEOW7Wo7wIMi0ueipfHqe+XuclkvOfO1OKoewyGwRvkE3Sf5lyk
	FXI04K/agmtCOp2L/bW8GlawpG91zfN1RlOGY4eToeLtjI9L0LD1zLzdTKBAO1Z9XgH6+H
	PA8DBqXjukAbe1ooTRZB8G9cIIgbHnQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-dNQZCiLIO4WXl28laiu37A-1; Fri,
 18 Sep 2026 11:20:26 -0400
X-MC-Unique: dNQZCiLIO4WXl28laiu37A-1
X-Mimecast-MFC-AGG-ID: dNQZCiLIO4WXl28laiu37A_1789744825
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BCDB1935DE5;
	Fri, 18 Sep 2026 15:20:25 +0000 (UTC)
Received: from [100.90.56.12] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 845B0180049F;
	Fri, 18 Sep 2026 15:20:23 +0000 (UTC)
Message-ID: <1460b98f-d8a4-4683-8d38-079727581ca1@redhat.com>
Date: Fri, 18 Sep 2026 17:20:15 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/28] KVM: x86: Introduce memory protection attributes
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: nsaenz@amazon.com, vkuznets@redhat.com, snambakam@linux.microsoft.com
References: <20260918135030.171564-1-pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260918135030.171564-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 9/18/26 15:49, Paolo Bonzini wrote:
> [cover letter copied from v2 - sorry for the very quick turnaround
> but it's pointless to ask for reviews with the issues reported by
> sashiko]
> 
> This series introduces a mechanism to let userspace block read,
> write or execute access to individual GFNs via KVM's memory
> attribute mechanism, and have them reported via KVM_EXIT_MEMORY_FAULT.
> It is mostly the work of Nicolas Saenz Julienne, with my working
> consisting in reorganization, code cleanup, and using the recently
> revamped MMU code (ACC_* masks and kvm_page_format).
> 
> KVM needs to check the attributes anytime KVM takes GPAs as input for any
> action initiated by the guest; if the memory attributes are incompatible
> with such action, it should be stopped.  This means that there are quite
> a lot of cases to handle.  While some families of functions can be
> handled in one step, there are simply many places that do memory access.
> 
> Along the way, the patches fix some issues in the memory attributes code,
> that surfaced due to having more than one attribute.
> 
> Paolo

The remaining AI review issues 
(https://sashiko.dev/#/patchset/20260918135030.171564-2-pbonzini%40redhat.com) 
are simple or intentional with one exception:

- patch 21 - missing xas.xa_node == XAS_BOUNDS check, easy enough

- patch 26 - missing EFAULT returns from the emulator, need to look at 
it and write tests

- patch 28 - i think it should be fine, but it can also be fixed with 
cond_resched() if needed

- patch 31 - WRITE_ONCE can be used for completeness

If desired, patches 1 and 5 can be applied to stable and/or 7.2-rc.

Paolo

> 
> v2->v3 is just a bunch of sashiko fixes:
> - new patch "KVM: x86/hyperv: do not overwrite hc->ingpa for slow
>    SIGNAL_EVENT hypercall"
> - rewritten "KVM: apply nGPA->GPA translation to KVM_HC_CLOCK_PAIRING"
>    to handle cross-patch accesses
> - rewrite choice of KVM_FILTER_SHARED/KVM_FILTER_PRIVATE prior to
>    setting memory attributes; even though the previous version worked,
>    it relied on not having any attribute at all for has_private_mem VMs
> - fix WARN_ON_ONCE/WARN_ONCE confusion
> - fix loongarch compilation
> - new (not really satisfactory_ patch "KVM: Take memory protections into
>    account for __kvm_vcpu_map"
> - fix incorrect NOT in "KVM: x86/mmu: Do not prefetch sptes on gfns backed
>    by memory attributes"
> - do not use kvm_mmu_prepare_memory_fault_exit() for attribute exits on
>    PTEs
> - new patch "KVM: let kvm_arch_post_set_memory_attributes drop mmu_lock"
> - testcase fixes
> 
> Anish Moorthy (1):
>    KVM: Define and communicate KVM_EXIT_MEMORY_FAULT RWX flags to
>      userspace
> 
> Nicolas Saenz Julienne (12):
>    KVM: selftests: Take into account mixed memory fault flags
>    KVM: x86/mmu: Init memslot hugepage information for non-private_mem
>      VMs too
>    KVM: Introduce NR/NW/NX memory attributes
>    KVM: Include memory protections in result of gfn->hva conversion
>    KVM: Take memory protections into account for memory read/write/fetch
>    KVM: Encapsulate memattrs array into anonymous struct
>    KVM: Introduce a generation number for memory attributes
>    KVM: Take memory protections into account for accesses with cached
>      gfn->hva
>    KVM: pfncache: Fail to refresh if it contains memory protections
>    KVM: x86/mmu: Do not prefetch sptes on gfns backed by memory
>      attributes
>    KVM: x86/mmu: Take memory protection attributes into account during
>      faults
>    KVM: x86/mmu: Issue memory fault exit if walk failed due to memory
>      attribute
> 
> Paolo Bonzini (18):
>    KVM: x86/hyperv: do not overwrite hc->ingpa for slow SIGNAL_EVENT
>      hypercall
>    KVM: selftests: Test address translation for Hyper-V direct L2
>      hypercalls
>    KVM: apply nGPA->GPA translation to KVM_HC_CLOCK_PAIRING
>    KVM: x86: Introduce memory fault on invalid hypercalls reads/writes
>    KVM: selftests: test hypercall memory fault exits
>    KVM: x86/mmu: intersect writability from __kvm_faultin_pfn with
>      fault->map_writable
>    KVM: x86/mmu: Extend map_writable to a full ACC_* mask
>    KVM: pass kvm == NULL case to kvm_arch_has_private_mem
>    KVM: adjust for presence of more than one attribute
>    KVM: Introduce kvm_fetch_guest_page() and use it for x86
>    KVM: Take memory protections into account for __kvm_vcpu_map
>    KVM: loongarch: do full validity check on the gfn-to-hva cache
>    KVM: Introduce kvm_check_gen()/kvm_memslots_check_gen()
>    KVM: let kvm_arch_post_set_memory_attributes drop mmu_lock
>    KVM: x86/mmu: Obsolete all roots if memattr contains gPTEs
>    KVM: x86: selftests: Introduce memory protection attributes test
>    KVM: x86: selftests: Introduce memory attributes PTE test
>    KVM: x86: selftests: Introduce memory attributes side-channel tests
> 
>   Documentation/virt/kvm/api.rst                |  38 +-
>   arch/loongarch/kvm/vcpu.c                     |  12 +-
>   arch/x86/include/asm/kvm_host.h               |   4 +-
>   arch/x86/kvm/Kconfig                          |   4 +-
>   arch/x86/kvm/hyperv.c                         | 172 +++++--
>   arch/x86/kvm/mmu/mmu.c                        | 183 +++++--
>   arch/x86/kvm/mmu/mmu_internal.h               |  21 +-
>   arch/x86/kvm/mmu/mmutrace.h                   |  36 ++
>   arch/x86/kvm/mmu/paging_tmpl.h                |  25 +-
>   arch/x86/kvm/mmu/spte.c                       |  12 +-
>   arch/x86/kvm/mmu/spte.h                       |  13 +-
>   arch/x86/kvm/mmu/tdp_mmu.c                    |   2 +-
>   arch/x86/kvm/x86.c                            |  66 ++-
>   include/linux/kvm_host.h                      | 128 ++++-
>   include/linux/kvm_types.h                     |   6 +-
>   include/trace/events/kvm.h                    |  14 +-
>   include/uapi/linux/kvm.h                      |   7 +
>   tools/include/uapi/linux/kvm.h                |   3 +
>   tools/testing/selftests/kvm/Makefile.kvm      |   2 +
>   .../testing/selftests/kvm/include/kvm_util.h  |  32 +-
>   .../selftests/kvm/include/x86/processor.h     |   1 +
>   .../testing/selftests/kvm/lib/x86/processor.c |   5 +
>   .../testing/selftests/kvm/memory_attributes.c | 453 ++++++++++++++++++
>   tools/testing/selftests/kvm/x86/hcall_fault.c | 246 ++++++++++
>   .../testing/selftests/kvm/x86/hyperv_evmcs.c  |  16 +-
>   .../selftests/kvm/x86/hyperv_svm_test.c       |  15 +-
>   .../selftests/kvm/x86/memory_attributes.c     | 415 ++++++++++++++++
>   .../kvm/x86/private_mem_kvm_exits_test.c      |   6 +-
>   virt/kvm/kvm_main.c                           | 271 +++++++++--
>   virt/kvm/pfncache.c                           |  30 +-
>   30 files changed, 2027 insertions(+), 211 deletions(-)
>   create mode 100644 tools/testing/selftests/kvm/memory_attributes.c
>   create mode 100644 tools/testing/selftests/kvm/x86/hcall_fault.c
>   create mode 100644 tools/testing/selftests/kvm/x86/memory_attributes.c
> 

