Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5F23B9610
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 07:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617784; cv=none; b=u6IfxSO8ShsMIo+Jxv8i/nuNC3/yMQAaSEoOJORJ08/lilSgo8+O66sIydndMxhM7DaIvia6Yn03+7ICRj/sWwHPGmMm94D77J4l5oq3f79CCh6087VE+MSu74D9sW0WzK7XbSf6LE9nv2gXiKnGQ90GOA6C7RjpZM5F3W9VnoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617784; c=relaxed/simple;
	bh=FFvXeGHoAzgIZzjGObLtcQpi1gYIl90YePjT1VPpuMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HYmdbfiaWg4mx6cwLvrj1WwBb5bIl2PFSx+anoT9/3aRkMfqlDtLWIAvUOtpfsDfAxZS84ZG6YfTx68alGEOeWHJCuYcwKu/AJJf9Fpq3TWvfNYNk+oi1HWjgyJxZnweBGIMsXGG6iWwHOK8WGifZOZvtmgMvvidZbJqRBBzC+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9SS2nmI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9SS2nmI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784617781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2k15j2uyoPBnkrbn8zYdzF3/nFYutM13cpLNbhMpn8M=;
	b=h9SS2nmIvYRRuKzHe/SvZBi5GLkALKGMG1t9C/p/dt6olI+p3laGJVN3lupoVrpPUj3FOe
	oUw0V0RRT+9CsOdQRfmQ9RX5R66vkOYxfQSDJ2sf8sVV4Idsz70+0gg9c2kQa1OMKpPSbi
	bd5Ezc67UdOEdUP9Gu9jsUng08CW3lI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-NfRY61_GMMOJqzVL93nbhw-1; Tue,
 21 Jul 2026 03:09:36 -0400
X-MC-Unique: NfRY61_GMMOJqzVL93nbhw-1
X-Mimecast-MFC-AGG-ID: NfRY61_GMMOJqzVL93nbhw_1784617775
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E8101955F16;
	Tue, 21 Jul 2026 07:09:35 +0000 (UTC)
Received: from [10.44.48.28] (unknown [10.44.48.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D48B300418D;
	Tue, 21 Jul 2026 07:09:33 +0000 (UTC)
Message-ID: <081e6523-04c8-439f-a251-37a5647054f8@redhat.com>
Date: Tue, 21 Jul 2026 09:09:30 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/20] KVM: x86: Enable APX for guests
To: "Chang S. Bae" <chang.seok.bae@intel.com>, seanjc@google.com
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260720171949.498680-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 7/20/26 19:19, Chang S. Bae wrote:
> Hi Paolo and Sean,
> 
> Here is another iteration for this enabling series.
> 
> One topic worth highlighting first is about how to handle userspace
> writes to the APX state through the KVM XSAVE API, following the
> discussion here:
> 
>    https://lore.kernel.org/CABgObfaocwfLdUBKJYYYEDH8X3n6iEbMsscbaCe_C=8JNnhDBA@mail.gmail.com
> 
> So what this revision ended up with is just to keep those copy paths from
> userspace and acknowledge the redundant copy to VCPU cache / guest
> fpstate. Patch3 has more context on that.
> 
> Besides that, this revision has several fixes and improvements. Sean
> gave feedbacks. 0-day spotted on an issue. Also, since the preparatory
> patches have been merged into the mainline, finally a review bot could
> provide some feedbacks as well. The major changes are:
> 
>   1. VMX Instruction Information Extension
> 
>      During the time of V4, 0-day reported out an issue with patch7.
>      Fixing that also revealed patch4 was missing another function.
> 
>      With a review bot's feeback, patch7 was also updated to ensure EGPR
>      indices for handling debug-register accesses. Also looking at
>      associated macros, patch6 was added for further cleanup.
> 
>   2. Emulator Register Tracking
> 
>      The review bot at hand also found a potential shift-out-bounds issue
>      in the register tracking. Patch10 was fixed.
> 
>   3. APX Feature Exposure
> 
>      As per Sean's feedback, the APX XCR0 and userspace exposure were
>      reworked a bit in patch14-18.
> 
> Along with the in-tree KVM x86 selftests, this time I ensured running the
> x86 KVM-unit-test comparing between:
> 
>   * Baseline - Paolo's `queue` branch
>   * This series on non-APX systems, and
>   * This series on APX hardware
> 
> The full set is also available at:
> 
>    git://github.com/intel/apx.git apx-kvm_v5

Thanks, will review.  Sashiko was a bit drunk when doing its thing, but 
please give a read to its comments in case it found something important.

Paolo

> 
> Thanks,
> Chang
> 
> Relevant Posting
>   * V4: https://lore.kernel.org/20260512011502.53072-1-chang.seok.bae@intel.com
>   * KVM-unit-test patch: https://lore.kernel.org/20260420212355.507827-1-chang.seok.bae@intel.com
> 
> Chang S. Bae (19):
>    KVM: x86: Extend VCPU registers for EGPRs
>    KVM: VMX: Save guest EGPRs in VCPU cache
>    KVM: x86: Support APX state for XSAVE ABI
>    KVM: VMX: Refactor VMX instruction information access
>    KVM: VMX: Refactor instruction information decoding
>    KVM: VMX: Remove unused control-register access defines
>    KVM: VMX: Refactor register index retrieval from exit qualification
>    KVM: VMX: Support instruction information extension
>    KVM: nVMX: Propagate extended instruction information
>    KVM: x86: Support EGPR accessing and tracking for emulator
>    KVM: x86: Handle EGPR index and REX2-incompatible opcodes
>    KVM: x86: Support REX2-prefixed opcode decode
>    KVM: x86: Reject EVEX-prefixed instructions
>    KVM: x86: Guard valid XCR0.APX settings
>    KVM: x86: Add APX in supported XCR0
>    KVM: x86: Expose APX foundation feature to userspace
>    KVM: x86: Expose APX sub-features to userspace
>    KVM: x86: selftests: Add APX state and ABI test
>    KVM: x86: selftests: Add APX state handling and XCR0 sanity checks
> 
> Sean Christopherson (1):
>    KVM: x86: Move KVM_SUPPORTED_{XCR0,XSS} into kvm_x86_vendor_init()
> 
>   arch/x86/Kconfig.assembler                    |   5 +
>   arch/x86/include/asm/kvm_host.h               |  19 ++
>   arch/x86/include/asm/kvm_vcpu_regs.h          |  50 +++++
>   arch/x86/include/asm/vmx.h                    |  22 +-
>   arch/x86/kvm/Kconfig                          |   4 +
>   arch/x86/kvm/cpuid.c                          |  27 ++-
>   arch/x86/kvm/cpuid.h                          |   2 +
>   arch/x86/kvm/emulate.c                        | 121 +++++++----
>   arch/x86/kvm/kvm_emulate.h                    |  21 +-
>   arch/x86/kvm/reverse_cpuid.h                  |   6 +
>   arch/x86/kvm/svm/svm.c                        |   8 +-
>   arch/x86/kvm/vmenter.h                        |   1 +
>   arch/x86/kvm/vmx/nested.c                     |  75 +++----
>   arch/x86/kvm/vmx/nested.h                     |   2 +-
>   arch/x86/kvm/vmx/vmcs12.c                     |   1 +
>   arch/x86/kvm/vmx/vmcs12.h                     |   3 +-
>   arch/x86/kvm/vmx/vmenter.S                    |  31 ++-
>   arch/x86/kvm/vmx/vmx.c                        |  28 ++-
>   arch/x86/kvm/vmx/vmx.h                        |  77 ++++++-
>   arch/x86/kvm/x86.c                            |  92 +++++++--
>   tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>   .../selftests/kvm/include/x86/processor.h     | 120 +++++++++++
>   tools/testing/selftests/kvm/x86/apx_test.c    | 191 ++++++++++++++++++
>   tools/testing/selftests/kvm/x86/state_test.c  |   3 +
>   .../selftests/kvm/x86/xcr0_cpuid_test.c       |  19 ++
>   25 files changed, 801 insertions(+), 128 deletions(-)
>   create mode 100644 tools/testing/selftests/kvm/x86/apx_test.c
> 
> 
> base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370

