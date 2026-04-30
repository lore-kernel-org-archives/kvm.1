Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26FE3314C5
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565807; cv=none; b=HB9gfh/+QZKQu3wFpmklVEgWNjoXPUcP+YI2CtPH5cQ0ZwuCK43yYdVnp7O0RZy9RrwuhmfV2bEqT6g+uDi566btWNU00C0m6pMNKa/vosFgTvQpUyZIlG7qhwTvB7cdX4qej/cHjs5hTP7Xfaqp8XNWbIAtFQH7iwT10zIimRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565807; c=relaxed/simple;
	bh=NS1hXzMwNlNeELf6tfokB8A0U2esXVs5kEvQlnBzzDM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=g6ElvLOMrFxELH3YlommyNYwfg9soZKoMrU9fKDfl9a4nP8J3lnl7mo6hxBhBaLbzvZQlIZ7uObZJl/biFKYF2qq4+KwLdNQd5+G9eY+DhGWutiulTZcsgeu5Ow2y1umPudYpOpLZjmYAA9YmtsWPnWP4nWLJmYyg/nWav7O1CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AjwncAQC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjwncAQC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777565802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PaMQiKUB6gk/d0VVBJ9lG+Y+gC5pmabTI7erdrEsW0M=;
	b=AjwncAQCVVi+u9rvIk1qSwTGE3YKQCjsxrgZnQpclgFqaCraX7D8oAeFkY82Nwz64NW9rV
	H5nkZ2WNRPvata2yC8pPTsRA1Y8K9iZVcrcZdBKIwsexQO/gpQOcVVBr9fo4ocnS+ip2Dn
	2WSVtXNn20wn0vlHiYUIUC0524YS968=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-BgvLDh5cPBm5JeABD_a0Rg-1; Thu,
 30 Apr 2026 12:16:39 -0400
X-MC-Unique: BgvLDh5cPBm5JeABD_a0Rg-1
X-Mimecast-MFC-AGG-ID: BgvLDh5cPBm5JeABD_a0Rg_1777565798
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8D081800578;
	Thu, 30 Apr 2026 16:16:37 +0000 (UTC)
Received: from [10.44.50.160] (unknown [10.44.50.160])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7FEAD1800446;
	Thu, 30 Apr 2026 16:16:36 +0000 (UTC)
Message-ID: <7b4dc292-a2e2-4d42-9e4a-bb1fe37a9013@redhat.com>
Date: Thu, 30 Apr 2026 18:16:35 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/28] KVM: combined patchset for MBEC/GMET support
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
References: <20260430150747.76749-1-pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260430150747.76749-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 4/30/26 17:07, Paolo Bonzini wrote:
> I will once more send you to v3 (https://lore.kernel.org/kvm/20260408154217.458420-1-pbonzini@redhat.com/)
> for the description of the series.
> 
> v4 incorrectly rebased onto 7.1 KVM and broke the case where L1 disables
> NPT.  On top of that I made a few final touches on the patch split, and
> opted to use the XU bit unconditionally in the MMU even if MBEC is disabled.
> This is more consistent with the idea of reducing as much as possible
> the differences between mbec=0 and mbec=1 modes.

I placed this also at branch kvm-mbec of 
https://git.kernel.org/pub/scm/virt/kvm/kvm.git.

Paolo

> Paolo
> 
> v4->v5:
> - patches 8 and 9: swap to clarify use of ACC_USER_MASK to detect read faults
> - patch 11: fix final argument to kvm_translate_gpa (using pte_access instead
>    of walker->pte_access worked more or less accidentally, but it is incorrect
>    because vmx_translate_nested_gpa uses ACC_* constants rather than PT_*)
> - patches 13 and 15: revert to always setting shadow_xu_mask ==
>    VMX_EPT_USER_EXECUTABLE_MASK, even if MBEC is disabled.  The MMU always
>    operates as if MBEC is available, instead of complicating its life (and
>    potentially introducing bugs) by mapping XU onto X; blocking incorrect
>    configuration can be done at higher levels.  Add a comment on the design.
> - patch 24: also block CR4.SMAP
> - patches 26 and 28: fix rebase onto 7.1 KVM (fixes nested NPT disabled)
> 
> v3->v4:
> - patch 15: clear enable_mbec = 0 if enable_ept == 0
> - patches 23-27: adjust for rename of nested_ctl to misc_ctl
> - patch 24: new
> - patch 27: disable svm_get_cpl for SEV-ES/SEV-SNP
> - patch 28: fix commit message reference to __nested_svm_check_controls
> 
> 
> Jon Kohler (5):
>    KVM: TDX/VMX: rework EPT_VIOLATION_EXEC_FOR_RING3_LIN into PROT_MASK
>    KVM: x86/mmu: remove SPTE_PERM_MASK
>    KVM: x86/mmu: free up bit 10 of PTEs in preparation for MBEC
>    KVM: nVMX: advertise MBEC to nested guests
>    KVM: nVMX: allow MBEC with EVMCS
> 
> Paolo Bonzini (23):
>    KVM: x86/mmu: shuffle high bits of SPTEs in preparation for MBEC
>    KVM: x86/mmu: remove SPTE_EPT_*
>    KVM: x86/mmu: merge make_spte_{non,}executable
>    KVM: x86/mmu: rename and clarify BYTE_MASK
>    KVM: x86/mmu: separate more EPT/non-EPT permission_fault()
>    KVM: x86/mmu: introduce ACC_READ_MASK
>    KVM: x86/mmu: pass PFERR_GUEST_PAGE/FINAL_MASK to kvm_translate_gpa
>    KVM: x86/mmu: pass pte_access for final nGPA->GPA walk
>    KVM: x86: make translate_nested_gpa vendor-specific
>    KVM: x86/mmu: split XS/XU bits for EPT
>    KVM: x86/mmu: move cr4_smep to base role
>    KVM: VMX: enable use of MBEC
>    KVM: nVMX: pass advanced EPT violation vmexit info to guest
>    KVM: nVMX: pass PFERR_USER_MASK to MMU on EPT violations
>    KVM: x86/mmu: add support for MBEC to EPT page table walks
>    KVM: x86/mmu: propagate access mask from root pages down
>    KVM: x86/mmu: introduce cpu_role bit for availability of PFEC.I/D
>    KVM: SVM: add GMET bit definitions
>    KVM: x86/mmu: hard code more bits in kvm_init_shadow_npt_mmu
>    KVM: x86/mmu: add support for GMET to NPT page table walks
>    KVM: SVM: enable GMET and set it in MMU role
>    KVM: SVM: work around errata 1218
>    KVM: nSVM: enable GMET for guests
> 
>   Documentation/virt/kvm/x86/mmu.rst |  10 +-
>   arch/x86/include/asm/cpufeatures.h |   1 +
>   arch/x86/include/asm/kvm-x86-ops.h |   1 +
>   arch/x86/include/asm/kvm_host.h    |  48 +++++---
>   arch/x86/include/asm/svm.h         |   1 +
>   arch/x86/include/asm/vmx.h         |  14 ++-
>   arch/x86/kvm/hyperv.c              |   4 +-
>   arch/x86/kvm/mmu.h                 |  30 +++--
>   arch/x86/kvm/mmu/mmu.c             | 176 ++++++++++++++++++++---------
>   arch/x86/kvm/mmu/mmutrace.h        |  19 ++--
>   arch/x86/kvm/mmu/paging_tmpl.h     |  73 ++++++++----
>   arch/x86/kvm/mmu/spte.c            |  92 +++++++++------
>   arch/x86/kvm/mmu/spte.h            |  70 +++++++-----
>   arch/x86/kvm/mmu/tdp_mmu.c         |   6 +-
>   arch/x86/kvm/svm/nested.c          |  38 ++++++-
>   arch/x86/kvm/svm/svm.c             |  31 +++++
>   arch/x86/kvm/svm/svm.h             |   1 +
>   arch/x86/kvm/vmx/capabilities.h    |  12 +-
>   arch/x86/kvm/vmx/common.h          |  20 ++--
>   arch/x86/kvm/vmx/hyperv_evmcs.h    |   1 +
>   arch/x86/kvm/vmx/main.c            |   9 ++
>   arch/x86/kvm/vmx/nested.c          |  46 +++++++-
>   arch/x86/kvm/vmx/tdx.c             |   2 +-
>   arch/x86/kvm/vmx/vmx.c             |  27 ++++-
>   arch/x86/kvm/vmx/vmx.h             |   1 +
>   arch/x86/kvm/vmx/x86_ops.h         |   1 +
>   arch/x86/kvm/x86.c                 |  18 +--
>   27 files changed, 529 insertions(+), 223 deletions(-)
> 

