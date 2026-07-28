Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E16A27FB0E
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 01:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200761; cv=none; b=Arsfuo0hbumB54LpXZYSPH8uqIuHwcyi+iMldc0ebppFLVnbA8SyU86KnBp+d2fe0ijmQ8x5ovRxB9lO0ZjcFmbJbBgPYq/G7JZXeDnQ3HbWDlPH3A6JxlL9xCs7h/grBO8RyKxhlmFm0ZMBU09OF7KY34GO2DEMZ47pqrS5QYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200761; c=relaxed/simple;
	bh=j7mj82gvAl3uCCi6dVPnrb66/WH3/JVzzB2tyij8HHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4ubuo6HAa7onoxbJtHrG0iLuFo8rSEhbDB99Ltql4CMyFcarveeT7GsPdVlNlwDkPT/WIJ7Fd3DNkwXRYCOX9MckdWyXy0Ufcgdmnup/1pNvRHp53h3+BOpOLakXXBkHIrOvWtqquDschUxWjIee44APXw0YqCF7mfB1l7RFrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngbUsMm1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngbUsMm1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D23C1F00ACF
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 01:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785200759;
	bh=/0yf1+6XoMf7v8xDIW6jzJHlD2CYH72+FF41j39t+vc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ngbUsMm1kPGXydxYCMscnoCzodfiouCr6aMYAE2dGxuvFNGWxEF1B4MBtwZQN24NT
	 W/WnVqb81oCQiPz+vOryAxpX8YRtYfrEDMeahY26DI9x78LxOFIDyBSZt/GBPVGXbG
	 895myKcWLhxJ2ajUvlOu5Qqzf/d16L5MmxfSdQUSAO6QSXZbqEbu4tEPenmz5bpe1a
	 ws4IzzwiQTU7AjNrL3RXkqhKxKd6XuvBUy2+FTWDsj+TQv7rivCJ81i0PHJyFCRUH/
	 fV8dBoQRgthtH+FahWa99sp0HOV5nPXD/WYkYepNImZw+VQd90e5QvDovirPt9dP30
	 GkEpOGUupLKgQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69ff40d9cbcso2412071a12.0
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 18:05:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqZjBwu/Xgbrhbu+5YEgUjg88A/EnuxYADDBFBfHFD976Cwo14/X2XGOy3/Sm9G4UozK+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPQh91tcK2+yYDFdeFThF7KvgV8PnU46H0TtlzHyg/+NE38ggO
	6N38AtAij+A9tX1bylCJNYQcvdvtFtm2oqngzTYxqMbcbwrZyY+ZFwolO8l3Eg+8m+YR2qao2l+
	jGkzJTCbDvYZS8Jm6SMarrscWljFv4zU=
X-Received: by 2002:a17:907:7b82:b0:c15:d6c8:2816 with SMTP id
 a640c23a62f3a-c1f71e1ea91mr7400866b.27.1785200757920; Mon, 27 Jul 2026
 18:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728003557.1136583-1-yosry@kernel.org>
In-Reply-To: <20260728003557.1136583-1-yosry@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 27 Jul 2026 18:05:46 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOVyea=7yRD25JcRmar4-0JtTpuoDpK__J431o9MJYj2Q@mail.gmail.com>
X-Gm-Features: AUfX_mxZLtroXRnN8APQPd5eBRw7NjnAwgXrMfZhYrE0Y4lPHPFpA574EWJtADo
Message-ID: <CAO9r8zOVyea=7yRD25JcRmar4-0JtTpuoDpK__J431o9MJYj2Q@mail.gmail.com>
Subject: Re: [PATCH v1 00/28] KVM: nSVM: Optimize nSVM TLB flushes
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"

> Yosry Ahmed (28):
>   KVM: nSVM: Flush the TLB after forcefully leaving nested
>   KVM: SVM: Document number of ASIDs CPUID setting
>   KVM: VMX: Generalize VPID allocation to be vendor-neutral
>   KVM: x86/mmu: Support specifying reserved TLB tags
>   KVM: SVM: Add helpers to set/clear ASID flush in VMCB
>   KVM: SVM: Fallback to flush everything if FLUSHBYASID is not available
>   KVM: SVM: Duplicate pre-run ASID check for SEV and non-SEV guests
>   KVM: SEV: Do ASID initialization at VMCB initialization
>   KVM: SEV: Expose sev_get_asid() outside of sev.c
>   KVM: SVM: Use a static ASID per vCPU
>   KVM: SVM: Only flush the fallback ASID when used by a different vCPU
>   KVM: nSVM: Add a placeholder ASID for L2
>   KVM: x86: hyper-v: Rename kvm_hv_vcpu_purge_flush_tlb()
>   KVM: x86: hyper-v: Allow puring all TLB flush FIFOs
>   KVM: nSVM: Drop svm->nested.initialized
>   KVM: nSVM: Flush both L1 and L2 ASIDs on KVM_REQ_TLB_FLUSH
>   KVM: nSVM: Always switch VMCB before leaving guest mode
>   KVM: nSVM: Split nested_svm_transition_tlb_flush() into entry/exit fns
>   KVM: nSVM: Service local TLB flushes before nested transitions
>   KVM: nSVM: Handle nested TLB flush requests through TLB_CONTROL
>   KVM: nSVM: Flush the TLB if L1 changes L2's ASID in vmcb12
>   KVM: nSVM: Do not reset TLB_CONTROL in vmcb02 on nested VM-Enter
>   KVM: x86/mmu: Rename __kvm_mmu_invalidate_addr() to
>     kvm_mmu_sync_addr()
>   KVM: x86/mmu: Refactor kvm_mmu_invlpg() to allow skipping the GVA
>     flush
>   KVM: nSVM: Flush L2's ASID when emulating INVLPGA
>   KVM: nSVM: Flush the ASID on nested transitions if shared by L1 and L2
>   KVM: nSVM: Use different ASIDs for L1 and L2
>   KVM: selftests: Add a test for nested TLB flushes

Sashiko wasn't able to apply the patches:
https://sashiko.dev/#/patchset/20260728003557.1136583-1-yosry%40kernel.org.

For some reason, it failed to apply on the baseline commit,
271255273d5ff348fe29d89fe4712b2f7f7907c3.

This is the top of kvm-x86/next tho, so I am not sure what went wrong:

$ git show upstream/kvm-x86/next
commit 271255273d5ff348fe29d89fe4712b2f7f7907c3 (tag:
kvm-x86-next-2026.07.27, upstream/kvm-x86/next, upstream/kvm-x86/HEAD)
Merge: a204badd8432f 2abcdf03fda13 9c66085e6dcfb db3a46e200df2
2708ecca4dbdb 710b3a30f407e e428f9779a437 653857a5af462 ec9a16c6aeba8
05a0b701d1089
Author: Sean Christopherson <seanjc@google.com>
Date:   Mon Jul 27 12:44:28 2026 -0700
...

The commit was from earlier today, maybe Sashiko only fetches the
trees every once in a while?

kvm-x86/next is not among the list of branches it tried. I don't see
the tree in MAINTAINERS, so perhaps this patch was never picked up:
https://lore.kernel.org/kvm/20260428171541.1342335-2-seanjc@google.com/.

Adding Roman here just in case. Sean, let me know if you want me to
resend this series after we figure this out.
