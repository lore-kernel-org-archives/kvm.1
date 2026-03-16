Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248EB3932F4
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661875; cv=none; b=YmIqpvEeOPRxYYAoPgGqbx4OmLqiWmHHgWjH3629HJ9gP2NNVEzFB7eyqyxI14j61de+3EZW1DvqOJ8nnTbtX0YGqG7F13NdsJhwlgdV1dq2ntI3t5vj2mkW7s6i+iLZyuj3c2+eFbgRAl1QLaBgZbaojknFQM6Sv90G/Sn3tyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661875; c=relaxed/simple;
	bh=T0JYGOr6ugZU2jMvsc9HFYY1EYF/qs9KP14VMrqzgE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2wW02xHM2J4gUxiEsiamaqZ8B/rhZLf4Nt+6uGnF06tVvrC+9EgOWnRL5Qha3MUcRwaMSKZllMahD/NFY0dZB16g83NRem11qzw2K5zZYA+tMAV0JKVWoMej36ViAJbcu+0b9ilJvefCcjEXe2SnfU1doKYRF4gGgUt3V6WPbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBO+8Led; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBO+8Led"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C973C19421;
	Mon, 16 Mar 2026 11:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773661874;
	bh=T0JYGOr6ugZU2jMvsc9HFYY1EYF/qs9KP14VMrqzgE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eBO+8Led9woWAONG8gUtaXPJa+McQVCCkO8guYoIMxgIZFPOEWYLHx5XG8TN8oDIY
	 BaFWsN+7Vf8Wv5hbkPYN7WFKID/5qylTpFBgIkjZfnq+LICoWF1QgPT9TixhTqPmIA
	 +D5e5LCcyvNmUbz69g/35AQWwthmxml+QNNOgL+0L1319JIDymYlDuPeM8+2D/9E8n
	 BGBIF9moELPae94hROyApkztc/am8n3ceXQJCB1j2jmu+A3ORALZ/TmhWkx9zHaU7+
	 uR+1HRSsvWiGK+e0EZ0WpZz2xoCK0H/1EQZ+mvbPEA05mwxlvojFoXCFvJE+WaEA0o
	 IfITlxe9xqFiA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6278EF40069;
	Mon, 16 Mar 2026 07:51:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 16 Mar 2026 07:51:13 -0400
X-ME-Sender: <xms:se63adRfw8h56GxTOsa2Nfp5EZWnrJDqUp6HFt5VGFjq4dWSiLX11g>
    <xme:se63aZHpsc9lAVSNZ0qiOXcw7p1naHyHoDNYZ_4yIRxBAxQFE0QK7qbs1CF1IEESp
    BQfuQ4YRh55U5AaeK3FuJ8KLsBkp6z3PfswRrsXXuRHmVCRu4Oxhw>
X-ME-Received: <xmr:se63aRgWGHMZLnpGiUJqagSb9JZ8WknvT-dDnBviP4rjVXQ_o4-t06-CMhH-_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepfedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehrihgtkhdrphdrvggughgvtghomhgsvgesihhnthgvlhdrtghomhdprhgtphhtth
    hopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehi
    nhhtvghlrdgtohhmpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgtphhtth
    hopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    tghotghosehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhinhhgohes
    rhgvughhrghtrdgtohhmpdhrtghpthhtohepphgsohhniihinhhisehrvgguhhgrthdrtg
    homh
X-ME-Proxy: <xmx:se63aR8OaExk9SsirPQYh_jH4J_6z9g_IqQN7nQjOEUOVxfekJjJvA>
    <xmx:se63aUL6IolEf2bAAb4N-kYsl27U_XMh7tM_jn0dmioUnnoJBIdc9w>
    <xmx:se63aRqKY_E8eMggAP7TyMHdxKEdqAhSWuypYfJX3-kOQ2p5HNdPAA>
    <xmx:se63aQw_4hs3SffuX69NLifqthW1nwpjP7dN-UfMzCZQvmrfYyL4vA>
    <xmx:se63aeqHeklOzbJvlnukp5WjFkM7_aAi4rpKUy59p_dTnDMPonEV80HX>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 07:51:11 -0400 (EDT)
Date: Mon, 16 Mar 2026 11:51:06 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, pbonzini@redhat.com, seanjc@google.com, tglx@kernel.org, 
	x86@kernel.org, chao.gao@intel.com, kai.huang@intel.com, ackerleytng@google.com, 
	vishal.l.verma@intel.com
Subject: Re: [PATCH 3/4] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Message-ID: <abftAJkiU3Q24wYQ@thinkstation>
References: <20260307010358.819645-1-rick.p.edgecombe@intel.com>
 <20260307010358.819645-4-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307010358.819645-4-rick.p.edgecombe@intel.com>

On Fri, Mar 06, 2026 at 05:03:57PM -0800, Rick Edgecombe wrote:
> From: Vishal Verma <vishal.l.verma@intel.com>
> 
> Some early TDX-capable platforms have an erratum where a partial write
> to TDX private memory can cause a machine check on a subsequent read.
> On these platforms, kexec and kdump have been disabled in these cases,
> because the old kernel cannot safely hand off TDX state to the new
> kernel. Later TDX modules support the TDH.SYS.DISABLE SEAMCALL, which
> provides a way to cleanly disable TDX and allow kexec to proceed.

Does it need to be enumerated?

I don't see this SEAMCALL be covered in the public documentation.
</me looking around>
Ah! Found it the the draft. So the feature is not yet finalized.

"Support of TDH.SYS.DISABLE is enumerated by TDX_FEATURES0. SYS_DISABLE
(bit 53)"

I am seeing the next patch calling it unconditionally. Is it okay?

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
> The SEAMCALL may be interrupted by an interrupt. In this case, it
> returns TDX_INTERRUPTED_RESUMABLE, and it must be retried in a loop
> until the operation completes successfully.
> 
> Add a tdx_sys_disable() helper, which implements the retry loop around
> the SEAMCALL to provide this functionality.
> 
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/include/asm/tdx.h  |  3 +++
>  arch/x86/virt/vmx/tdx/tdx.c | 18 ++++++++++++++++++
>  arch/x86/virt/vmx/tdx/tdx.h |  1 +
>  3 files changed, 22 insertions(+)
> 
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index f0826b0a512a..baaf43a09e99 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -173,6 +173,8 @@ static inline int pg_level_to_tdx_sept_level(enum pg_level level)
>          return level - 1;
>  }
>  
> +void tdx_sys_disable(void);
> +
>  u64 tdh_vp_enter(struct tdx_vp *vp, struct tdx_module_args *args);
>  u64 tdh_mng_addcx(struct tdx_td *td, struct page *tdcs_page);
>  u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, struct page *page, struct page *source, u64 *ext_err1, u64 *ext_err2);
> @@ -204,6 +206,7 @@ static inline void tdx_init(void) { }
>  static inline u32 tdx_get_nr_guest_keyids(void) { return 0; }
>  static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
>  static inline const struct tdx_sys_info *tdx_get_sysinfo(void) { return NULL; }
> +static inline void tdx_sys_disable(void) { }
>  #endif	/* CONFIG_INTEL_TDX_HOST */
>  
>  #endif /* !__ASSEMBLER__ */
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 0802d0fd18a4..68bd2618dde4 100644
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
> @@ -1940,3 +1941,20 @@ u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page)
>  	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
>  }
>  EXPORT_SYMBOL_FOR_KVM(tdh_phymem_page_wbinvd_hkid);
> +
> +void tdx_sys_disable(void)
> +{
> +	struct tdx_module_args args = {};
> +
> +	/*
> +	 * SEAMCALLs that can return TDX_INTERRUPTED_RESUMABLE are guaranteed
> +	 * to make forward progress between interrupts, so it is safe to loop
> +	 * unconditionally here.
> +	 *
> +	 * This is a 'destructive' SEAMCALL, in that no other SEAMCALL can be
> +	 * run after this until a full reinitialization is done.
> +	 */
> +	while (seamcall(TDH_SYS_DISABLE, &args) == TDX_INTERRUPTED_RESUMABLE)
> +		;

Silently ignore any other errors?

> +}
> +
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
> -- 
> 2.53.0
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
