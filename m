Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE27A3C9ED0;
	Mon, 30 Mar 2026 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871945; cv=none; b=KVuvxHfXTwVcLt3MaINMACxnvp1PTqm5YMmyN//5POo+H1xRiascZYJdeVS9YLHcGJHI3D7ksfgtHPLoL+5qcUmjNAXtRYrcSyurpZ5GZ/YP2YmeJgMJqWAQMJPeRygCR1BLgZPYpJFK3gH7gmKTq9P55ftmZdYhuiAsyu0a78g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871945; c=relaxed/simple;
	bh=OjF9jnKvHJuUhcj8kbGOZ7BW8KyRGB6l0B8doDNPLi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+VTXdioMM62bTxm3CwBwHPWbT3bmYf3M+qLXG+Q3dOfvkFAQ9hlGie5WN0hRdpZAKoNEhMhlyi219GJj4HsRHOxGy8Whdp7SDVaEXj/miLJQEoOdnqPB7TFYJEDYUslMRzcoWuhj6v9pWCzZNxedyk8bADqPG6UQn1Pi9s6blQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqi0p01m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqi0p01m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CF0C2BCB0;
	Mon, 30 Mar 2026 11:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774871945;
	bh=OjF9jnKvHJuUhcj8kbGOZ7BW8KyRGB6l0B8doDNPLi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hqi0p01miFDcfjtDesxXRXmpNbgBafEO4gb1/suHg0ZWzk0sw96LgOAVmeB4N+9kL
	 mst2v1uSS3A+qdLAv49n2zw1avUgmHHir8rQu4OXSAmqW0SGCVR4lXa/QKzoV9lzVy
	 +YSHjcYnPj8ez0u57CZmFAm+xc+kNVnlVmgtPm8Qgzyoh/FSW99+zxuNBd8kbAW9IA
	 srNv+kWsCxWtjW3zJ0UFEPBoZhz4fusYjve0re+HFSDL6wX/JcEac2ojU5OsBlIVlT
	 pXtsf8C2shw6Bw7S1Zo4m3DIMZVNpfZxUqP8VwRdIMihBUnlM+bfdNaDOrdj+J0/tx
	 iCoKawthjDhYg==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2F468F4006C;
	Mon, 30 Mar 2026 07:59:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 30 Mar 2026 07:59:04 -0400
X-ME-Sender: <xms:iGXKaSbAzoikW_mRVcDGqgZOL52Gj1s8wqLoFFQA5IHmroHr1L37_A>
    <xme:iGXKaeslEAn5JGFx7WlYpRYQP8J1LP-18BY87e-9VuBP0vhuXRDOqIv0FyF0pll0k
    lyquAyJOxGGgUUytu-F01soPihKfCaRWQWQnbj9P0SfF5bZg_IETo-E>
X-ME-Received: <xmr:iGXKaU-wZmZl1SlKcj6iJVcVaTsY-uHTbsnCjx3146hnzv6XSYxsZfww2NvECg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehvihhshhgrlhdrlhdrvhgvrhhmrgesihhnthgvlhdrtghomhdprhgtphhtthhope
    htghhlgieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvh
    gvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeigkeei
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhphgrseiihihtohhrrdgtohhmpdhrtg
    hpthhtoheprhhitghkrdhprdgvughgvggtohhmsggvsehinhhtvghlrdgtohhmpdhrtghp
    thhtohepshgvrghnjhgtsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:iGXKaeVqAyvsd1dlNtVHl7CI1RkkeQTlIw2xmHemQ_Gh0dEQVy6weA>
    <xmx:iGXKaYvriyc1NMRB0emm3peeP6Cr0rYscEfrwTvzjR5N9pq80j42bg>
    <xmx:iGXKac-DTfL7bm0NGxRQySDtQor3sQGL69gxeJS-Q1c2P0LxK9Susg>
    <xmx:iGXKaZ0v5V0DeaQ4IWN1pwOLhzBDACddYSsx35ZEikvAgPCJ4vb5vw>
    <xmx:iGXKaZRdyT3D1D5-kHagGbFMX6hFt7XFgohYaffII5raSGMfzSLBKQnR>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 07:59:01 -0400 (EDT)
Date: Mon, 30 Mar 2026 11:58:56 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v2 3/5] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Message-ID: <acpiGUKS-WRmLoxp@thinkstation>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
 <20260323-fuller_tdx_kexec_support-v2-3-87a36409e051@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-fuller_tdx_kexec_support-v2-3-87a36409e051@intel.com>

On Mon, Mar 23, 2026 at 02:59:06PM -0600, Vishal Verma wrote:
> Some early TDX-capable platforms have an erratum where a partial write
> to TDX private memory can cause a machine check on a subsequent read.
> On these platforms, kexec and kdump have been disabled in these cases,
> because the old kernel cannot safely hand off TDX state to the new
> kernel. Later TDX modules support the TDH.SYS.DISABLE SEAMCALL, which
> provides a way to cleanly disable TDX and allow kexec to proceed.
> 
> The new SEAMCALL has an enumeration bit, but that is ignored. It is
> expected that users will be using the latest TDX module, and the failure
> mode for running the missing SEAMCALL on an older module is not fatal.
> 
> This can be a long running operation, and the time needed largely
> depends on the amount of memory that has been allocated to TDs. If all
> TDs have been destroyed prior to the sys_disable call, then it is fast,
> with only needing to override the TDX module memory.
> 
> After the SEAMCALL completes, the TDX module is disabled and all memory
> resources allocated to TDX are freed and reset. The next kernel can then
> re-initialize the TDX module from scratch via the normal TDX bring-up
> sequence.
> 
> The SEAMCALL can return two different error codes that expect a retry.
>  - TDX_INTERRUPTED_RESUMABLE can be returned in the case of a host
>    interrupt. However, it will not return until it makes some forward
>    progress, so we can expect to complete even in the case of interrupt
>    storms.
>  - TDX_SYS_BUSY will be returned on contention with other TDH.SYS.*
>    SEAMCALLs, however a side effect of TDH.SYS.DISABLE is that it will
>    block other SEAMCALLs once it gets going. So this contention will be
>    short lived.
> 
> So loop infinitely on either of these error codes, until success or other
> error.
> 
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  arch/x86/include/asm/shared/tdx_errno.h |  1 +
>  arch/x86/include/asm/tdx.h              |  3 +++
>  arch/x86/virt/vmx/tdx/tdx.h             |  1 +
>  arch/x86/virt/vmx/tdx/tdx.c             | 28 ++++++++++++++++++++++++++++
>  4 files changed, 33 insertions(+)
> 
> diff --git a/arch/x86/include/asm/shared/tdx_errno.h b/arch/x86/include/asm/shared/tdx_errno.h
> index 8bf6765cf082..246b4fd54a48 100644
> --- a/arch/x86/include/asm/shared/tdx_errno.h
> +++ b/arch/x86/include/asm/shared/tdx_errno.h
> @@ -15,6 +15,7 @@
>  #define TDX_NON_RECOVERABLE_TD_NON_ACCESSIBLE	0x6000000500000000ULL
>  #define TDX_NON_RECOVERABLE_TD_WRONG_APIC_MODE	0x6000000700000000ULL
>  #define TDX_INTERRUPTED_RESUMABLE		0x8000000300000000ULL
> +#define TDX_SYS_BUSY				0x8000020200000000ULL
>  #define TDX_OPERAND_INVALID			0xC000010000000000ULL
>  #define TDX_OPERAND_BUSY			0x8000020000000000ULL
>  #define TDX_PREVIOUS_TLB_EPOCH_BUSY		0x8000020100000000ULL
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 7674fc530090..a0a4a15142fc 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -172,6 +172,8 @@ static inline int pg_level_to_tdx_sept_level(enum pg_level level)
>          return level - 1;
>  }
>  
> +void tdx_sys_disable(void);
> +
>  u64 tdh_vp_enter(struct tdx_vp *vp, struct tdx_module_args *args);
>  u64 tdh_mng_addcx(struct tdx_td *td, struct page *tdcs_page);
>  u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, struct page *page, struct page *source, u64 *ext_err1, u64 *ext_err2);
> @@ -203,6 +205,7 @@ static inline void tdx_init(void) { }
>  static inline u32 tdx_get_nr_guest_keyids(void) { return 0; }
>  static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
>  static inline const struct tdx_sys_info *tdx_get_sysinfo(void) { return NULL; }
> +static inline void tdx_sys_disable(void) { }
>  #endif	/* CONFIG_INTEL_TDX_HOST */
>  
>  #endif /* !__ASSEMBLER__ */
> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> index dde219c823b4..e2cf2dd48755 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.h
> +++ b/arch/x86/virt/vmx/tdx/tdx.h
> @@ -46,6 +46,7 @@
>  #define TDH_PHYMEM_PAGE_WBINVD		41
>  #define TDH_VP_WR			43
>  #define TDH_SYS_CONFIG			45
> +#define TDH_SYS_DISABLE			69
>  
>  /*
>   * SEAMCALL leaf:
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 0802d0fd18a4..3a76000dec7a 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -37,6 +37,7 @@
>  #include <asm/msr.h>
>  #include <asm/cpufeature.h>
>  #include <asm/tdx.h>
> +#include <asm/shared/tdx_errno.h>
>  #include <asm/cpu_device_id.h>
>  #include <asm/processor.h>
>  #include <asm/mce.h>
> @@ -1940,3 +1941,30 @@ u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page)
>  	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
>  }
>  EXPORT_SYMBOL_FOR_KVM(tdh_phymem_page_wbinvd_hkid);
> +
> +void tdx_sys_disable(void)
> +{
> +	struct tdx_module_args args = {};
> +	u64 ret;
> +
> +	/*
> +	 * Don't loop forever.

Nit: Add a new line here.

> +	 *  - TDX_INTERRUPTED_RESUMABLE guarantees forward progress between
> +	 *    calls.

And here.

> +	 *  - TDX_SYS_BUSY could transiently contend with TDH.SYS.* SEAMCALLs,
> +	 *    but will lock out future ones.

Locked out by who? Is it TDX module contract? I don't see it documented in
the spec.

I assumed that if the SEAMCALL fails other SEAMCALLs suppose to be
functional. Hm?

> +	 *
> +	 * This is a 'destructive' SEAMCALL, in that no other SEAMCALL can be
> +	 * run after this until a full reinitialization is done.
> +	 */
> +	do {
> +		ret = seamcall(TDH_SYS_DISABLE, &args);
> +	} while (ret == TDX_INTERRUPTED_RESUMABLE || ret == TDX_SYS_BUSY);
> +
> +	/*
> +	 * Print SEAMCALL failures, but not SW-defined error codes
> +	 * (SEAMCALL faulted with #GP/#UD, TDX not supported).
> +	 */
> +	if (ret && (ret & TDX_SW_ERROR) != TDX_SW_ERROR)
> +		pr_err("TDH.SYS.DISABLE failed: 0x%016llx\n", ret);
> +}
> 
> -- 
> 2.53.0
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
