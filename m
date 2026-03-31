Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D884E3A5E8D
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774985408; cv=none; b=QwBi8G+9HtwcZVIlkDQORtMmkLVEl/HWsRgQK9afYsxBTmNQhrWJ97BBuz1kG7sfnI5zQwcSgu50gGiqlzmHHbajzlCthcc06XdMqz/ZZ/X7K3tX5Sc/pQ8Pq6E/x+XCCavL9lc7Ytne/FQIbv9Ab81jf+WWGlfz1VmxllQnIZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774985408; c=relaxed/simple;
	bh=hnUDt77C71ymSAORPdjXdt9/qUTqGq/wBBDTgrqrROQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hhGybUnoAhg1+Sygc5qIcxs0NxKX+FFsy8IZ1PBy9EcMOEGNs+qU7bkP8VkCxxsBvByi53d9yps0S9HQxf3LUWB4uSq8kzWsARiKQF2ubU21wkBuwWkiHp9A7+lbQ/k/6LkPVBdbKheLdnP3nrMdHQD2EoxGTMScaPF7e1oax9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IA8xZy/r; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IA8xZy/r"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b23af7d7e8so137886285ad.0
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774985406; x=1775590206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p2WegTQIoj8z+As4wwIqDMWlL5KxHd9mGRxfuRiVd74=;
        b=IA8xZy/rhZAliO+B94vi3Dk2DYSlAqCFQzl/YHrdNHQeX0lkc2s7SJk7aGZhOI8jLx
         rwxCNomxxRqVvnYBh5atxbCKyaP8RITFnFM5F+DIBWzyIJgIaioQmk5VSMxTH1/GHr2U
         kusSpr57Lyu1ljuANme+NxJ4sicLKTLUGj2QeN1u2y+oLvFu6CjwOkKOUirdqz2fCCX7
         Ru3u1b1OCRUASJqrL5Y9Mi94dBPZUbdwrAyMqw7lthBRRJlbDKPW6XsY7wc4BJLKCT29
         2NzBYFP46yuAD01OkslV0+sqehARZOC9nnYskFCqidMHenkLqdrOZgF9fRIdWCk1ROTI
         +LJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774985406; x=1775590206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p2WegTQIoj8z+As4wwIqDMWlL5KxHd9mGRxfuRiVd74=;
        b=kMbeYYe1voJx9936NNd+XSHzC1Ae6fK9IfkddqDkfeKqFOH3iKBQ8s5b6OGTA8GyJL
         EbWivcMKZMhiryHLdORd85ZuIOoZbJ0DsOAX/tKZOqkseBi6vLltEAyJ5yTiKLiB0uw7
         DxTLgwndEP0296BPfOEFe76aMq7ucDyCvbX6gpTcuSgqHp6C5xy/yomnItZAHHqB27l5
         Yg3GaMS2XW0Oy5TL1Zzo4nYBaAPRqaPhOLjqS60CM90scPY8Tm6bkuilD50E5v5K4M8a
         WdUVaNokSUAq1WKXnGkcCPNyycr+shhVXhPCYthIc/9QSk/AO7BNOxQ12tJmlaXDDO7X
         5q9g==
X-Forwarded-Encrypted: i=1; AJvYcCVXB0OygDwzYYtbVmaVeZ4yTrKgkhKGkDosbJSom5O/5mpefcJzfQBT8/XH1/9Qf5+I434=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+BXPlzBy0dTSB/t8m98z+61yNIG3xjWHnmXr//6GsImWK9Mtt
	CPwqB8/W92DQsOpwTV8L1UfgtSOG1mJPxo0XmvOEtRA+RCwELMgryt+3RWRn4c5ubg5hXBFexSw
	DGHFJ1Q==
X-Received: from plgq11.prod.google.com ([2002:a17:902:eb8b:b0:2b0:ada8:a666])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c411:b0:2b0:62dd:3a80
 with SMTP id d9443c01a7336-2b269b38df6mr4579345ad.17.1774985406005; Tue, 31
 Mar 2026 12:30:06 -0700 (PDT)
Date: Tue, 31 Mar 2026 12:30:04 -0700
In-Reply-To: <20260323-fuller_tdx_kexec_support-v2-1-87a36409e051@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com> <20260323-fuller_tdx_kexec_support-v2-1-87a36409e051@intel.com>
Message-ID: <acwgvBzK01IrAAeU@google.com>
Subject: Re: [PATCH v2 1/5] x86/tdx: Move all TDX error defines into <asm/shared/tdx_errno.h>
From: Sean Christopherson <seanjc@google.com>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 23, 2026, Vishal Verma wrote:
> diff --git a/arch/x86/kvm/vmx/tdx_errno.h b/arch/x86/include/asm/shared/tdx_errno.h
> similarity index 64%
> rename from arch/x86/kvm/vmx/tdx_errno.h
> rename to arch/x86/include/asm/shared/tdx_errno.h
> index 6ff4672c4181..8bf6765cf082 100644
> --- a/arch/x86/kvm/vmx/tdx_errno.h
> +++ b/arch/x86/include/asm/shared/tdx_errno.h
> @@ -1,14 +1,15 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/* architectural status code for SEAMCALL */
> -
> -#ifndef __KVM_X86_TDX_ERRNO_H
> -#define __KVM_X86_TDX_ERRNO_H
> +#ifndef _ASM_X86_SHARED_TDX_ERRNO_H
> +#define _ASM_X86_SHARED_TDX_ERRNO_H
> +#include <asm/trapnr.h>
>  
> +/* Upper 32 bit of the TDX error code encodes the status */
>  #define TDX_SEAMCALL_STATUS_MASK		0xFFFFFFFF00000000ULL
>  
>  /*
> - * TDX SEAMCALL Status Codes (returned in RAX)
> + * TDX Status Codes (returned in RAX)
>   */
> +#define TDX_SUCCESS				0ULL
>  #define TDX_NON_RECOVERABLE_VCPU		0x4000000100000000ULL
>  #define TDX_NON_RECOVERABLE_TD			0x4000000200000000ULL
>  #define TDX_NON_RECOVERABLE_TD_NON_ACCESSIBLE	0x6000000500000000ULL
> @@ -17,6 +18,7 @@
>  #define TDX_OPERAND_INVALID			0xC000010000000000ULL
>  #define TDX_OPERAND_BUSY			0x8000020000000000ULL
>  #define TDX_PREVIOUS_TLB_EPOCH_BUSY		0x8000020100000000ULL
> +#define TDX_RND_NO_ENTROPY			0x8000020300000000ULL
>  #define TDX_PAGE_METADATA_INCORRECT		0xC000030000000000ULL
>  #define TDX_VCPU_NOT_ASSOCIATED			0x8000070200000000ULL
>  #define TDX_KEY_GENERATION_FAILED		0x8000080000000000ULL
> @@ -28,6 +30,20 @@
>  #define TDX_EPT_ENTRY_STATE_INCORRECT		0xC0000B0D00000000ULL
>  #define TDX_METADATA_FIELD_NOT_READABLE		0xC0000C0200000000ULL
>  
> +/*
> + * SW-defined error codes.
> + *
> + * Bits 47:40 == 0xFF indicate Reserved status code class that never used by
> + * TDX module.
> + */
> +#define TDX_ERROR			_BITULL(63)
> +#define TDX_NON_RECOVERABLE		_BITULL(62)
> +#define TDX_SW_ERROR			(TDX_ERROR | GENMASK_ULL(47, 40))
> +#define TDX_SEAMCALL_VMFAILINVALID	(TDX_SW_ERROR | _ULL(0xFFFF0000))
> +
> +#define TDX_SEAMCALL_GP			(TDX_SW_ERROR | X86_TRAP_GP)
> +#define TDX_SEAMCALL_UD			(TDX_SW_ERROR | X86_TRAP_UD)

I don't think the host's SW-defined error codes should be used by the guest.  The
guest can't even make SEAMCALLs.  So unless I'm misunderstanding the purpose, I
don't think it makes sense to move these into tdx_errno.h.

Regardless, please split this up into two patches:

 1. Move tdx_errno.h
 2. Land more #defines in tdx_errno.h

Because IIUC, tdx_errno.h holds *only* architecturally defined values, which makes
(1) super duper trivial to review and ack.
