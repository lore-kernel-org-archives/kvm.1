Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4676C382362;
	Mon, 16 Mar 2026 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773666734; cv=none; b=XOeCTEYHOT4ayeqrWcVQVLlTg04xFoDB2uhdEjsK9FDaMUdhRnjE06W4Pcs+0DwlFWBvuaTt2VN63GwRCSfJ6STkL7jH9w6Qt9amIMkTuZlJilu6RYDQpZi/gIXMBZzw6Xm7Sd8uKKT037pj2broM9Tb5aiLwJ2kcm9gQzvJrig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773666734; c=relaxed/simple;
	bh=X3364DyV9+qQmR1c70C3WBPf+wo2HbpBx91Oa7wP6FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrjZ9TTH5ROswyuomXk/VMarCVZopRTdSNFvkzEsmxab/ypPu/t8AN+C16ckCewOREKGfxWFAZ/YvULvwUngi9wE77o2BMdaEPJEZQ9SGMv3w3cU3BI+nxdoDSDUI74+Fh7PyFJQcLMhvJA8FHI8xRO3ZGE1EA5x58u8Zv6m64Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nc39I1Nr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nc39I1Nr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137A7C19421;
	Mon, 16 Mar 2026 13:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773666733;
	bh=X3364DyV9+qQmR1c70C3WBPf+wo2HbpBx91Oa7wP6FI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nc39I1NrmvOmWfTmfTq3bRQ/XNiZVrid91WoQ69sNdF1IJPlXO/LGKxfxZAtonZkX
	 8VMSgHwJgUxzC0V2Suzo/4ryDnsFK03YmOa6ruDwZ9J8dfj8yaAO9CMCeS34+t5cUN
	 97nx54vn5VHU9hl3QoyTcnEq2/nPXaSVH+a9AlOnMe0PYjgSf8SLBh8MRs6l2yD53U
	 PVNz4ASrcp5QVSE+X0SLPjEG6apVSNd33P9Rrt8cbPFE2wcD7SBI5WtsEUjcHgv3/3
	 N94sSPHncpW5/pmWx28JX4p8gy4P4M23OheD4FUET/iqwTt5rWJbSM3tHyBcGlH41D
	 Zw2pTn9v0cwsQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2FF56F40075;
	Mon, 16 Mar 2026 09:12:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 16 Mar 2026 09:12:12 -0400
X-ME-Sender: <xms:rAG4abo58vO0SWsllMuo5vQ3lNAyBeRgNLOkIih9LDD38F8g2JdN9A>
    <xme:rAG4aUjX5wSWJcqZC_UFsJEz2HsjZBu2Egje-h9qNJ9L1sglK9xsa2FHVbTiIGgNF
    ps670rpqCFuRi-yJg8mrF1wd5F_N2LNVo4IUVk7cLhzYGNMOmx7gA>
X-ME-Received: <xmr:rAG4aYnl9y3Y7xKekxr9YEXzQJuZdrJQ41Gn8gbgH-dWZjmhGHorqHoLn0tehA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefmihhrhihl
    ucfuhhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtth
    gvrhhnpeeludettdeigfefhffhhfelveeludeuleduvefhgefgueeitedtleffudegfffg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkih
    hrihhllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieeh
    hedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovh
    drnhgrmhgvpdhnsggprhgtphhtthhopeehvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheptghhrghordhgrghosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqtghotghosehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepkhhvmhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsihhnsghinhdrfihusehlihhn
    uhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhdrjhdrfihilhhlihgrmhhsse
    hinhhtvghlrdgtohhmpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidr
    ihhnthgvlhdrtghomhdprhgtphhtthhopehirhgrrdifvghinhihsehinhhtvghlrdgtoh
    hmpdhrtghpthhtohepkhgrihdrhhhurghnghesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:rAG4aT7aVt6K6FdLZSasXL1aTp-HzOcTxfuPYl5NWUrBlNh3D1Z23g>
    <xmx:rAG4acla1T5U09X6ZvaaHFRm15NZWheNk0dRb8qCQIAV9MPjxASG7Q>
    <xmx:rAG4aVhLBmb6Gx0lv_hhsgQQwlsLb7XNdMi2OMZDYm4rsqMG0lmHYg>
    <xmx:rAG4aRkE-Jhf-0sgCBMsVkkMVVDpw3Fgg6n7W6ufz6mNRX0fLOQDbw>
    <xmx:rAG4acpRjA7qLoBErlMhlPL8wfwH7thjWe93LWSQ0bMOFYobs0CJol4K>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 09:12:10 -0400 (EDT)
Date: Mon, 16 Mar 2026 13:12:05 +0000
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
Subject: Re: [PATCH v5 05/22] x86/virt/seamldr: Retrieve P-SEAMLDR information
Message-ID: <abgBFmEhlsdmxa1k@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-6-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315135920.354657-6-chao.gao@intel.com>

On Sun, Mar 15, 2026 at 06:58:25AM -0700, Chao Gao wrote:
> P-SEAMLDR returns its information such as version number, in response to
> the SEAMLDR.INFO SEAMCALL.
> 
> This information is useful for userspace. For example, the admin can decide
> which TDX module versions are compatible with the P-SEAMLDR according to
> the P-SEAMLDR version.
> 
> Retrieve P-SEAMLDR information in preparation for exposing P-SEAMLDR
> version and other necessary information to userspace. Export the new kAPI
> for use by tdx-host.ko.
> 
> Note that there are two distinct P-SEAMLDR APIs with similar names:
> 
>   SEAMLDR.INFO: Returns a SEAMLDR_INFO structure containing SEAMLDR
>                 information such as version and remaining updates.
> 
>   SEAMLDR.SEAMINFO: Returns a SEAMLDR_SEAMINFO structure containing SEAM
>                     and system information such as Convertible Memory
> 		    Regions (CMRs) and number of CPUs and sockets.
> 
> The former is used here.
> 
> For details, see "Intel® Trust Domain Extensions - SEAM Loader (SEAMLDR)
> Interface Specification" revision 343755-003.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> ---
> Kai also suggested merging this patch with the first use of the new
> kAPI, so we don't need to add a comment for slow_virt_to_phys() (as the
> reason can be seen from the call site). I am fine with it, but the
> changelog may be a bit lengthy.
> 
> v5:
>  - add a comment for slow_virt_to_phys() [Kai]
> v4:
>  - put seamldr_info on stack [Dave]
>  - improve changelogs to explain SEAMLDR.INFO and SEAMLDR.SEAMINFO [Dave]
>  - add P-SEAMLDR spec information in the changelog [Dave]
>  - add proper comments above ABI structure definition [Dave]
>  - add unused ABI structure fields rather than marking them as reserved
>    to better align with the specc [Dave] (I omitted "not used by kernel"
>    tags since there are 5-6 such fields and maintaining these tags would
>    be tedious.)
> ---
>  arch/x86/include/asm/seamldr.h  | 36 +++++++++++++++++++++++++++++++++
>  arch/x86/virt/vmx/tdx/seamldr.c | 19 ++++++++++++++++-
>  2 files changed, 54 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/include/asm/seamldr.h
> 
> diff --git a/arch/x86/include/asm/seamldr.h b/arch/x86/include/asm/seamldr.h
> new file mode 100644
> index 000000000000..c67e5bc910a9
> --- /dev/null
> +++ b/arch/x86/include/asm/seamldr.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_SEAMLDR_H
> +#define _ASM_X86_SEAMLDR_H
> +
> +#include <linux/types.h>
> +
> +/*
> + * This is called the "SEAMLDR_INFO" data structure and is defined
> + * in "SEAM Loader (SEAMLDR) Interface Specification".
> + *
> + * The SEAMLDR.INFO documentation requires this to be aligned to a
> + * 256-byte boundary.
> + */
> +struct seamldr_info {
> +	u32	version;
> +	u32	attributes;
> +	u32	vendor_id;
> +	u32	build_date;
> +	u16	build_num;
> +	u16	minor_version;
> +	u16	major_version;
> +	u16	update_version;
> +	u32	acm_x2apicid;
> +	u32	num_remaining_updates;
> +	u8	seam_info[128];
> +	u8	seam_ready;
> +	u8	seam_debug;
> +	u8	p_seam_ready;
> +	u8	reserved[93];
> +} __packed __aligned(256);
> +
> +static_assert(sizeof(struct seamldr_info) == 256);
> +
> +int seamldr_get_info(struct seamldr_info *seamldr_info);
> +
> +#endif /* _ASM_X86_SEAMLDR_H */
> diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
> index 7ed9be89017c..7c0cbab2c4c0 100644
> --- a/arch/x86/virt/vmx/tdx/seamldr.c
> +++ b/arch/x86/virt/vmx/tdx/seamldr.c
> @@ -8,8 +8,13 @@
>  
>  #include <linux/spinlock.h>
>  
> +#include <asm/seamldr.h>
> +
>  #include "seamcall_internal.h"
>  
> +/* P-SEAMLDR SEAMCALL leaf function */
> +#define P_SEAMLDR_INFO			0x8000000000000000
> +
>  /*
>   * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
>   * interact with P-SEAMLDR simultaneously. Use raw version as the calls can
> @@ -17,8 +22,20 @@
>   */
>  static DEFINE_RAW_SPINLOCK(seamldr_lock);
>  
> -static __maybe_unused int seamldr_call(u64 fn, struct tdx_module_args *args)
> +static int seamldr_call(u64 fn, struct tdx_module_args *args)
>  {
>  	guard(raw_spinlock)(&seamldr_lock);
>  	return seamcall_prerr(fn, args);
>  }
> +
> +int seamldr_get_info(struct seamldr_info *seamldr_info)
> +{
> +	/*
> +	 * Use slow_virt_to_phys() since @seamldr_info may be allocated on
> +	 * the stack.
> +	 */
> +	struct tdx_module_args args = { .rcx = slow_virt_to_phys(seamldr_info) };
> +
> +	return seamldr_call(P_SEAMLDR_INFO, &args);

On what condition this information can change?

I see the next patch calls this on every _show operation. Would we
benefit from caching the response?

> +}
> +EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
> -- 
> 2.47.3
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
