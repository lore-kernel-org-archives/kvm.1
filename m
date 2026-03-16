Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B7DA55;
	Mon, 16 Mar 2026 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773666339; cv=none; b=rWXPFeePr52ZPJymiNfblAY1iFLhiO60CNnwmQXuWWlWv+7Me/ebtLJMAx6DxAlvMcuW0GIbL4U3vhgst6P7mPODush7gTX3DvlUDvULjr9coZao3tzt8hNil3eclgloChwkIk2uYf8/Gs79jPn4vKWwUDDddRix0fa58Jc5rGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773666339; c=relaxed/simple;
	bh=g5kZmA0yw/DQF+KEhs3w8BmQ1L3CG3z1AwFKMk3kBG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+NdkU6uaeV2hc0Q/8Ek2PIfT5Lk2XJAsjo/wsfj+xHG/4Zm3yDgahhr1m6StmIIkd1vfTfTFDC814STyfAPJ5qRDpjVlR3M1SnNETjCMr2GJvYnMp8El8Q5QE8/dLK6y6qDSI9SqQzAinMn5WTJTLuFf3SnjPupPW0K8RyKkxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6IZ/uuP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6IZ/uuP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147A4C19424;
	Mon, 16 Mar 2026 13:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773666338;
	bh=g5kZmA0yw/DQF+KEhs3w8BmQ1L3CG3z1AwFKMk3kBG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B6IZ/uuPYeW7c2/H5K7xRSNM/hYpzRUlmiz0MCVcu/fA12VOlBmLOHxzLD21/RtCy
	 j8/9EsakS0klSL/K5ewcs62wYBe/0GMl6YOL55OsbcDfxmpS7evc7welhlulnx8AQP
	 RdT7nSqq+qaosHcmSX7F2gAT1SNMbI2HLfiCgAZGPIacHEDWtOs3WG224/EWjvaRUQ
	 L/y1+pSZ96Px0Uj3Ie7Qqxsjk3Ycoe4NVuvv/iEkLFM8giyd45/mfLFBlRfUr/exlK
	 tRp44jTNInIhTAqVxetUAwdr+lRDqg43ZKB1P9PLhNx9xuET+9TzSsdbe5bUn6eI1U
	 DMnRGP5SW0NTg==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 321E2F40070;
	Mon, 16 Mar 2026 09:05:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 16 Mar 2026 09:05:37 -0400
X-ME-Sender: <xms:IQC4aWKTsRuGC-EUFnmc5x-kGpXz6GZPxB9qd93RmiEv6aHMp4oETg>
    <xme:IQC4adDzzTJi3pgIu17LLuWGkQVghHbIy4FHlmGE0MxCktoCF2AlbuusjNN9rRsSp
    aUQPWQLSl7izFmSyAhHs9p0X681Ruc-M3jDZexA_HQVqihGu4-uSN0>
X-ME-Received: <xmr:IQC4aXE79LMsuNqehTOR921-sk44G-wzRaSDRVnlsHwd7_LS3sV47VJ3SeWIdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefmihhrhihl
    ucfuhhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtth
    gvrhhnpeevhffgudeuleelueehfedtveduudehieefudehvdduheeivdeijeejledvgeeg
    feenucffohhmrghinhepihhnthgvlhdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkh
    gvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeh
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrghordhgrghosehinhhtvg
    hlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghotghosehlihhsthhsrdhlihhnuh
    igrdguvghvpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegsihhnsghinhdrfihusehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpth
    htohepuggrnhdrjhdrfihilhhlihgrmhhssehinhhtvghlrdgtohhmpdhrtghpthhtohep
    uggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhope
    hirhgrrdifvghinhihsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhgrihdrhhhurghn
    ghesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:IQC4aQbe1QEQy_hMtzVNlE-_9JgAfBJrykOH8aijcJ6dHrjXHYNdXg>
    <xmx:IQC4afGmr2XPdg0rS1Et6EZDjmohugkeNtw4TPXfnteBDIpl-3mCdw>
    <xmx:IQC4aWCoRPad65ZbDpVcFDu_2Fb8D0ZYqMSR-we2B8bVW7rkWTb9Nw>
    <xmx:IQC4aYHQer6IRgkJ88p_2hg1VFrFirJ8IMIAVlcbpA7C3mD-8sflfA>
    <xmx:IQC4aRLKwioCZQAbLDfs-rezdUh8ZIq0DjqrWQtduXyqkUeMC4IxDzJb>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 09:05:34 -0400 (EDT)
Date: Mon, 16 Mar 2026 13:05:28 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, binbin.wu@linux.intel.com, dan.j.williams@intel.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com, nik.borisov@suse.com, 
	paulmck@kernel.org, pbonzini@redhat.com, reinette.chatre@intel.com, 
	rick.p.edgecombe@intel.com, sagis@google.com, seanjc@google.com, 
	tony.lindgren@linux.intel.com, vannapurve@google.com, vishal.l.verma@intel.com, 
	yilun.xu@linux.intel.com, Farrah Chen <farrah.chen@intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 04/22] x86/virt/seamldr: Introduce a wrapper for
 P-SEAMLDR SEAMCALLs
Message-ID: <abf-3xRg7ouZw-F4@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-5-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315135920.354657-5-chao.gao@intel.com>

On Sun, Mar 15, 2026 at 06:58:24AM -0700, Chao Gao wrote:
> The TDX architecture uses the "SEAMCALL" instruction to communicate with
> SEAM mode software. Right now, the only SEAM mode software that the kernel
> communicates with is the TDX module. But, there is actually another
> component that runs in SEAM mode but it is separate from the TDX module:
> the persistent SEAM loader or "P-SEAMLDR". Right now, the only component
> that communicates with it is the BIOS which loads the TDX module itself at
> boot. But, to support updating the TDX module, the kernel now needs to be
> able to talk to it.
> 
> P-SEAMLDR SEAMCALLs differ from TDX module SEAMCALLs in areas such as
> concurrency requirements. Add a P-SEAMLDR wrapper to handle these
> differences and prepare for implementing concrete functions.
> 
> Note that unlike P-SEAMLDR, there is also a non-persistent SEAM loader
> ("NP-SEAMLDR"). This is an authenticated code module (ACM) that is not
> callable at runtime. Only BIOS launches it to load P-SEAMLDR at boot;
> the kernel does not need to interact with it for runtime update.
> 
> For details of P-SEAMLDR SEAMCALLs, see Intel® Trust Domain CPU
> Architectural Extensions, Revision 343754-002, Chapter 2.3 "INSTRUCTION
> SET REFERENCE".
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Link: https://cdrdv2.intel.com/v1/dl/getContent/733582 # [1]
> ---
> v5:
>  - Don't save/restore irq flags as P-SEAMLDR calls are made only in process
>    context
>  - clarify why raw_spinlock is used [Dave]
> v4:
>  - Give more background about P-SEAMLDR in changelog [Dave]
>  - Don't handle P-SEAMLDR's "no_entropy" error [Dave]
>  - Assume current VMCS is preserved across P-SEAMLDR calls [Dave]
>  - I'm not adding Reviewed-by tags as the code has changed significantly.
> v2:
>  - don't create a new, inferior framework to save/restore VMCS
>  - use human-friendly language, just "current VMCS" rather than
>    SDM term "current-VMCS pointer"
>  - don't mix guard() with goto
> ---
>  arch/x86/virt/vmx/tdx/Makefile  |  2 +-
>  arch/x86/virt/vmx/tdx/seamldr.c | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/virt/vmx/tdx/seamldr.c
> 
> diff --git a/arch/x86/virt/vmx/tdx/Makefile b/arch/x86/virt/vmx/tdx/Makefile
> index 90da47eb85ee..d1dbc5cc5697 100644
> --- a/arch/x86/virt/vmx/tdx/Makefile
> +++ b/arch/x86/virt/vmx/tdx/Makefile
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-y += seamcall.o tdx.o
> +obj-y += seamcall.o seamldr.o tdx.o
> diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
> new file mode 100644
> index 000000000000..7ed9be89017c
> --- /dev/null
> +++ b/arch/x86/virt/vmx/tdx/seamldr.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * P-SEAMLDR support for TDX module management features like runtime updates
> + *
> + * Copyright (C) 2025 Intel Corporation
> + */
> +#define pr_fmt(fmt)	"seamldr: " fmt
> +
> +#include <linux/spinlock.h>
> +
> +#include "seamcall_internal.h"
> +
> +/*
> + * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
> + * interact with P-SEAMLDR simultaneously. Use raw version as the calls can
> + * be made with interrupts disabled.

Hm. I am not sure how it explains use of raw_spinlock. What's wrong with
using plain spinlock with interrupts disabled?

> + */
> +static DEFINE_RAW_SPINLOCK(seamldr_lock);
> +
> +static __maybe_unused int seamldr_call(u64 fn, struct tdx_module_args *args)
> +{
> +	guard(raw_spinlock)(&seamldr_lock);
> +	return seamcall_prerr(fn, args);
> +}
> -- 
> 2.47.3
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
