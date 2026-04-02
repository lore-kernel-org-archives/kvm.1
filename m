Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83DC3F0A86
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152059; cv=none; b=C3jZppukx2cn6PhZ+8yemx2RVvatWByggDiu22SD0SJFjxgGEmY+i9IxA03JEv3kCW2PTWesY8qryRfr9kwIG7J/oFTc+2+LxICvfC6VlkND4+S2hYRHXwjdzdwZBqgl0b7ZUNVeIsXxQiOcF8/rh+BzVkE7ALWMXrGrSfTC9ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152059; c=relaxed/simple;
	bh=3Di8gvKsTkDFToM7zcKTmXsWN181yR0mrnfUz3x4i4Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MJcwR3V+pRpYCt+j3hguG6DO8foXmhRHXJvCtrD1KTWBxKYA/6KDU1rZl2+b++Jo7uq29zGVjwB3mq/qEpDRLf2p+zPQ/6aE21HHaRU8OpdQQvtJBmbO7oKeLJ5sTRoxg7V1vPnQsFxbeK7hswQLpgae4mRNLdSpWAegzC9XTC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pi/j7dbu; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pi/j7dbu"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35641c14663so1051318a91.2
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775152056; x=1775756856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+oWiGeGtzmit4npH7dOJB++ykY7dC00uJhoSfG5ovJQ=;
        b=pi/j7dbuTIkjgqgS05Cl3F3air8pBBt/Eg+pxFA2SiDv68D1V5fwK+8wX8/VgS3Iwt
         pNFkWASMAZy07Cnx7wRJ2YB4h4I7PVntxGbN/U/RoRLfwmGZW658Va9cTYknrSrvyi5e
         KdvllXwHQMi9F+7jdAs8wYIiWesKBTgLxUmDrvJgdm19QvPD0w8+0VK5CGdLp1DyuuaT
         WaPnsXw7mlEJhsjLyIS7h2eGi25MuEs+txgaTXU82uksSL+r8oM/lijU1PCvcVQ/6Quv
         SOIeG1H6DH3iLL7ZihnT2zZVt59t9HZmS+miy2jpOsHTZO6hBm1DISo/kJUna8Yt+pge
         6XQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775152056; x=1775756856;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+oWiGeGtzmit4npH7dOJB++ykY7dC00uJhoSfG5ovJQ=;
        b=IzceWHx36GrZEgA2Q+xpfGqstz/xUkVCkYaVt7kVLCvsdebSySBbLeO7661kEZxzrD
         pKfyR4kvr6Y/0QeurNHej0KRVbs350bf4guYAY9AsmQ23jUKoLojwXUAeKOvKIi+c0lW
         hazKUgIZGmKYXm7xDktMykdivMXhle+Ehok4Zybo825oT7xyHlErBptsTQQr9jSuKVRw
         yVC8Qe/AcQV3sIZSbZaNcSXj/MpcMsjsFawgDlvrxblrKjpItMmBN5ME8iRkwmv3R32p
         w11ED1l1pQXE5Uyk2WIVoPokogSQumC0vK+kCNCq1+lnbC13RUKRLx/+Vwfm0VxuNBkm
         hiww==
X-Forwarded-Encrypted: i=1; AJvYcCWkeMqjGdycFZA+lEeUN+oAuGM8nywjrcyXqpxIz9TEdU9YLcqPgmqFwFTJaB0qhqyKHag=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtp6ENjjWDeEZObZkUBX8rb4ttvljtyw0u8jt2JWg2NpikREQ7
	bNMng+MGO2eHRiczGPxdfiGg9Ox+hCzg9t35PCgKLxJaebJa3LbhBSnI8BQ+BjwzqP+MDshGubT
	/mp1TlQ==
X-Received: from pjbgv20.prod.google.com ([2002:a17:90b:11d4:b0:35d:9e2d:2f06])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224e:b0:35d:a4c0:a0ac
 with SMTP id 98e67ed59e1d1-35dc6ea7a4emr7893547a91.3.1775152055923; Thu, 02
 Apr 2026 10:47:35 -0700 (PDT)
Date: Thu, 2 Apr 2026 10:47:34 -0700
In-Reply-To: <20260402-fuller_tdx_kexec_support-v3-1-34438d7094bf@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260402-fuller_tdx_kexec_support-v3-0-34438d7094bf@intel.com> <20260402-fuller_tdx_kexec_support-v3-1-34438d7094bf@intel.com>
Message-ID: <ac6rtq-n0JNa_Oc0@google.com>
Subject: Re: [PATCH v3 1/5] x86/tdx: Move TDX architectural error codes into <asm/shared/tdx_errno.h>
From: Sean Christopherson <seanjc@google.com>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 02, 2026, Vishal Verma wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Today there are two separate locations where TDX error codes are defined:
> 
>   arch/x86/include/asm/tdx.h
>   arch/x86/kvm/vmx/tdx_errno.h
> 
> They have some overlap that is already defined similarly. Reduce the
> duplication by unifying the architectural error codes at:
> 
>   asm/shared/tdx_errno.h
> 
> ...and update the headers that contained the duplicated definitions to
> include the new unified header.
> 
> "asm/shared" is used for sharing TDX code between the early compressed
> code and the normal kernel code. While the compressed code for the guest
> doesn't use these error code header definitions today, it does make the
> types of calls that return the values they define. So place the defines in
> "shared" location so that it can, but leave such cleanups for future
> changes.
> 
> [Rick: enhance log]
> [Vishal: reduce to a simple move of architectural defines only]
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Nit, when calling out minor amendments, IMO the blurb in the square braces should
be after the previous SoB so that there's a clear, consistent chain of handling
and ordering.  I.e.

  Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
  [Rick: enhance log]
  Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
  [Vishal: reduce to a simple move of architectural defines only]
  Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

That makes it clear the Kirill signed off on something, then Rick tweaked the
changelog and signed off on _that_, and Vishal came along and simplified the
path.

Acked-by: Sean Christopherson <seanjc@google.com>

> Reviewed-by: Chao Gao <chao.gao@intel.com>
> ---
>  arch/x86/include/asm/shared/tdx.h                    | 1 +
>  arch/x86/{kvm/vmx => include/asm/shared}/tdx_errno.h | 7 +++----
>  arch/x86/kvm/vmx/tdx.h                               | 1 -
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> index 8bc074c8d7c6..6a1646fc2b2f 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/bits.h>
>  #include <linux/types.h>
> +#include <asm/shared/tdx_errno.h>
>  
>  #define TDX_HYPERCALL_STANDARD  0
>  
> diff --git a/arch/x86/kvm/vmx/tdx_errno.h b/arch/x86/include/asm/shared/tdx_errno.h
> similarity index 92%
> rename from arch/x86/kvm/vmx/tdx_errno.h
> rename to arch/x86/include/asm/shared/tdx_errno.h
> index 6ff4672c4181..3c1e8ce716e3 100644
> --- a/arch/x86/kvm/vmx/tdx_errno.h
> +++ b/arch/x86/include/asm/shared/tdx_errno.h
> @@ -1,8 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /* architectural status code for SEAMCALL */
> -
> -#ifndef __KVM_X86_TDX_ERRNO_H
> -#define __KVM_X86_TDX_ERRNO_H
> +#ifndef _ASM_X86_SHARED_TDX_ERRNO_H
> +#define _ASM_X86_SHARED_TDX_ERRNO_H
>  
>  #define TDX_SEAMCALL_STATUS_MASK		0xFFFFFFFF00000000ULL
>  
> @@ -37,4 +36,4 @@
>  #define TDX_OPERAND_ID_SEPT			0x92
>  #define TDX_OPERAND_ID_TD_EPOCH			0xa9
>  
> -#endif /* __KVM_X86_TDX_ERRNO_H */
> +#endif /* _ASM_X86_SHARED_TDX_ERRNO_H */
> diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
> index b5cd2ffb303e..ac8323a68b16 100644
> --- a/arch/x86/kvm/vmx/tdx.h
> +++ b/arch/x86/kvm/vmx/tdx.h
> @@ -3,7 +3,6 @@
>  #define __KVM_X86_VMX_TDX_H
>  
>  #include "tdx_arch.h"
> -#include "tdx_errno.h"

For the record, the defines in tdx_errno.h are only ever used by arch/x86/kvm/vmx/tdx.c,
and that file already included asm/shared/tdx.h by way of arch/x86/include/asm/tdx.h.

>  #ifdef CONFIG_KVM_INTEL_TDX
>  #include "common.h"
> 
> -- 
> 2.53.0
> 
