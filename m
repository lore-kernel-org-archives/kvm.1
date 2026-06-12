Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4978233920;
	Fri, 12 Jun 2026 23:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781308182; cv=none; b=EQw9uvsplFGMpNQ8d2TjquGTCmgtA18Wv+Bw4k36wrCK4j+dZiKFRvMdij2sH69xA2L6VGWPJtcgt+hpuiFMh3unrgM9MqVuFT0blrIrXD1Z2n/YASPVgthqyqwXirRHVeGw69wJTncE7VaEnJeEsvFlt2Ke8IOIFvfBgRYr3eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781308182; c=relaxed/simple;
	bh=/GoBkTTyWuVWyBnDFplBzpF2F70F2v+HL1KizEQE4Jc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Xnh6kwsg3eq1rOYZRSRE04sPrNz3gOK1rEpO0ELc0r7b/TUdx54J6r7DnWtxduiGKPBTqs8dF+PsjNFT0ySbqck0QLb2VTTJ67hU8eGT11uSC5I94RCGtcHSTncCIDeGmCysYEhytOC10+rBlFhs3DOFZI4sk28lHt+BMEf/ozo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfn1wET9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfn1wET9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D1A1F00A3A;
	Fri, 12 Jun 2026 23:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781308179;
	bh=wfWIEvsi5SdCq+HdZOM8BTMSs0U2QQNMvVTNN8/t1IQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=jfn1wET9Bl4iu8PiThSlzemWqMPthOqQGPWxx4QmMi691K703gdtXhKx6x7+++LcG
	 SOl44JXFj1iIvRD1Dd2KX0LDYWvA6hzmFo8G4eVoWk/xLcCnpcrLrryY7OR1mMH/tb
	 hpTCnUt9EfG0KYiatPLAmUzYUwmw5GF4D8D1yzao+Ru0XPe2ILfRqPNCj+A0cryDzt
	 jWHBSRc4zLF7pjSnaZOHmheWvXBRILt+yn+HXs3r7MucRRWAWgdFfxZciaqBTNuogU
	 +anlNACsXYs8zpdwse/xWlnzYICgV7EauIp1fuuz84c69I66ZUzOFkhRuSvL35eVWu
	 pG2Je0JUcSR+Q==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id EAE72F40079;
	Fri, 12 Jun 2026 19:49:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 12 Jun 2026 19:49:37 -0400
X-ME-Sender: <xms:EZssauH6yxxfm5SNdVErT62duFScnn2I6iUoxrU0_95y8A7XfllaVg>
    <xme:EZssak5XX59gpdCUwVpmzJQ2brHqxjJTaLlrQlR69ik1pLbpnmNp0NpEg5YKGClX2
    5qRYDekhUoSsTPPpEPhnzlh9vj95YNYAgg6op_rwkzJ-UIfaWPiHzUA>
X-ME-Received: <xmr:EZssahvIQbimFqO6CewRV0R4ODCK5EHJ4BMs_JtzJ0APtTtzWjC5Mf33pX17q-5Y0Kj9cFZjJiFq0T1eRHiOLjiT_wVuNlEUHJU>
X-ME-Proxy-Cause: dmFkZTEFOPcjYWrEmlO3YTG1oXSmoLIF+uLn2pPV1vRpjDMgITqudxZyFAZBBBcD0TtiJd
    gmjki+y3RpFfK/58e+hIYIH31UBQU13CeQQin8cJAyIFC4VR6v/FZpogNA+Zl3BAzGYJt4
    SLwu1dDqLiNWcuJZKIWjbg1ualBZFU0PWr/qoM7KqxVZIieRhRdAO6Ki7qdihVuIDFOopQ
    NzMuNFGGpe6fimFy7x8wVBQE5ssaPIxu0GQzav886YPuAHC3DkiQqU0d33lBdY+vIUriGc
    dY/8q9gQGPOU6tAzdGI59FjvRkJaA0pExUb5Sd8qajW/0jvwRpuqcCIVx2tJmHbRAKK5lC
    ODQpDWBkG88rI3WC/+QSLixKSViP1ZjBkBsPPgXNkbqq+gJc27514u84VmJFJaiCtNN5N1
    8FXXH8yihV53biiSHOQmyoJjVdVGXr9uBvArR0+aqiBdma1SFSQvOhdHSxLB/ws70d15+F
    63PEmBL6YcfWRf6aXNnoJDoXtX/yJuI8/HeCgCvauE0Qqw7wfysYYP15KzLtnTDNh00JJz
    CQSpwpFjQwZQ08bx+pYmJlnQFXWVYfK157y68Zrtoxj5yM6Vc3OsKuzknfXZINXHNksJKC
    YmtxdaftjLmjDGUezPvofWoYogorDTotgvp47afR7/6ncKsgaxRcmblXHASQ
X-ME-Proxy: <xmx:EZssao-zNFBQA2VjM7mA-L8XrEb5wsVEMpYpYAz93Ge92XGjvI4cwg>
    <xmx:EZssarkJk39-FX-2Z3ctII_UedWuvj7t1LdE4Ekm_Jwg4G4dKBg_tg>
    <xmx:EZssaoOlSaL51mv1XSHbq1ihtzKX3a5uu_Jaeh763cYFO0k7yvrHqQ>
    <xmx:EZssaqJo0kKk1PPyG-GzmoGJQ-5cgRLo7tpcLlrXHhKR88NDQg7uUg>
    <xmx:EZssajGXKKuuHSxZxDXfSP1MIJ83Em4UcZvFBdnl3fvKwDUVJcbLUvAk>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 19:49:37 -0400 (EDT)
Date: Fri, 12 Jun 2026 16:49:36 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>, 
 kas@kernel.org, 
 djbw@kernel.org, 
 rick.p.edgecombe@intel.com, 
 x86@kernel.org, 
 peter.fang@intel.com
Cc: linux-coco@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, 
 sohil.mehta@intel.com, 
 yilun.xu@intel.com, 
 yilun.xu@linux.intel.com, 
 baolu.lu@linux.intel.com, 
 zhenzhong.duan@intel.com, 
 xiaoyao.li@intel.com
Message-ID: <6a2c9b10574ce_9b8551005d@djbw-dev.notmuch>
In-Reply-To: <20260522034128.3144354-3-yilun.xu@linux.intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-3-yilun.xu@linux.intel.com>
Subject: Re: [PATCH 02/15] x86/virt/tdx: Add extra memory to TDX Module for
 Extensions
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xu Yilun wrote:
> TDX Module introduces a new concept called "TDX Module Extensions" to
> support long running / hard-irq preemptible flows inside. This makes TDX
> Module capable of handling complex tasks through "Extension SEAMCALLs".
> Adding more memory to TDX Module is the first step to enable Extensions.

Like I said on the cover, I think "long running hard-irq preemptible"
invites more questions that it answers. The service calls are not "long
running" on their own. I think it is sufficient to say they are
resumable unlike typical calls that run to completion while monopolizing
the CPU.

> Currently, TDX Module memory use is relatively static. But, the
> Extensions need to use memory more dynamically. While 'static' here
> means the kernel provides necessary amount of memory to TDX Module for
> its basic functionalities, 'dynamic' means extra memory is needed only
> if new add-on features are to be enabled. So add a new memory feeding
> process backed by a new SEAMCALL TDH.EXT.MEM.ADD.

Rick commented on this as well, but a simpler way to say it is
extensions receive a one time memory pool allocation at init time.  The
extension uses that pool as its baseline for its own internal state and
data for the service APIs it offers.

> The process is mostly the same as adding PAMT. The kernel queries TDX
> Module how much memory needed, allocates it, hands it over, and never
> gets it back.
> 
> TDH.EXT.MEM.ADD uses a new parameter type HPA_LIST_INFO to provide
> control (private) pages to TDX Module. This type represents a list of
> pages for TDX Module to access. It needs a 'root page' which contains
> the list of HPAs of the pages. It collapses the HPA of the root page
> and the number of valid HPAs into a 64 bit raw value for SEAMCALL
> parameters. The root page is always a medium, TDX Module never keeps
> the root page.

I mention below, but I do not think the reader cares that the TDX Module
calls an array of physical addresses a "root" page.

> 
> Introduce a tdx_clflush_hpa_list() helper to flush shared cache before
> SEAMCALL, to avoid shared cache writeback damaging these private pages.
> 
> For now, TDX Module Extensions consumes relatively large amount of
> memory (~50MB). Use contiguous page allocation to avoid permanently
> fragment too much memory. Print the allocation amount on TDX Module
> Extensions initialization for visibility.

To be clear I believe there is a low chance of fragmentation given this
allocation happening early. However, at 10s of MB the benefit of
isolating blocks of PFNs that will never be returned, it makes to not
use the buddy allocator for that.

> Co-developed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  arch/x86/virt/vmx/tdx/tdx.h |   1 +
>  arch/x86/virt/vmx/tdx/tdx.c | 118 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 119 insertions(+)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> index a5eec8e3cc71..2335f88bbb10 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.h
> +++ b/arch/x86/virt/vmx/tdx/tdx.h
> @@ -46,6 +46,7 @@
>  #define TDH_PHYMEM_PAGE_WBINVD		41
>  #define TDH_VP_WR			43
>  #define TDH_SYS_CONFIG			45
> +#define TDH_EXT_MEM_ADD			61
>  #define TDH_SYS_DISABLE			69
>  
>  /*
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index c0c6281b08a5..622399d8da68 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -31,6 +31,7 @@
>  #include <linux/syscore_ops.h>
>  #include <linux/idr.h>
>  #include <linux/kvm_types.h>
> +#include <linux/bitfield.h>
>  #include <asm/page.h>
>  #include <asm/special_insns.h>
>  #include <asm/msr-index.h>
> @@ -1179,6 +1180,123 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
>  	return 0;
>  }
>  
> +static void tdx_clflush_hpa_list(struct page *root, unsigned int nr_pages)
> +{
> +	u64 *entries = page_to_virt(root);
> +	int i;
> +
> +	for (i = 0; i < nr_pages; i++)
> +		clflush_cache_range(__va(entries[i]), PAGE_SIZE);
> +}
> +
> +#define HPA_LIST_INFO_FIRST_ENTRY	GENMASK_U64(11, 3)
> +#define HPA_LIST_INFO_PFN		GENMASK_U64(51, 12)
> +#define HPA_LIST_INFO_LAST_ENTRY	GENMASK_U64(63, 55)
> +
> +static u64 to_hpa_list_info(struct page *root, unsigned int nr_pages)
> +{
> +	return FIELD_PREP(HPA_LIST_INFO_FIRST_ENTRY, 0) |
> +	       FIELD_PREP(HPA_LIST_INFO_PFN, page_to_pfn(root)) |
> +	       FIELD_PREP(HPA_LIST_INFO_LAST_ENTRY, nr_pages - 1);
> +}
> +
> +static int tdx_ext_mem_add(struct page *root, unsigned int nr_pages)
> +{
> +	struct tdx_module_args args = {
> +		.rcx = to_hpa_list_info(root, nr_pages),
> +	};
> +	u64 r;
> +
> +	tdx_clflush_hpa_list(root, nr_pages);
> +
> +	do {
> +		/*
> +		 * TDH_EXT_MEM_ADD is designed to use output parameter RCX to
> +		 * override/update input parameter RCX, so the caller doesn't
> +		 * have to do manual parameter update on retry call.
> +		 */
> +		r = seamcall_ret(TDH_EXT_MEM_ADD, &args);
> +	} while (r == TDX_INTERRUPTED_RESUMABLE);
> +
> +	if (r != TDX_SUCCESS)
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int tdx_ext_mem_setup(void)
> +{
> +	unsigned int nr_pages;
> +	struct page *page;
> +	u64 *root;
> +	unsigned int i;
> +	int ret;
> +
> +	nr_pages = tdx_sysinfo.ext.memory_pool_required_pages;
> +	/*
> +	 * memory_pool_required_pages == 0 means no need to add pages,
> +	 * skip the memory setup.
> +	 */
> +	if (!nr_pages)
> +		return 0;
> +
> +	root = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!root)
> +		return -ENOMEM;

I think this "root" term is a holdover from the complicated TDX Connect
case where it might sometimes be this odd "singleton" object? You could
just make it this for actual type safety.

struct tdx_hpa_list {
	u64 phys[PAGE_SIZE/sizeof(u64)];
}

> +
> +	page = alloc_contig_pages(nr_pages, GFP_KERNEL, numa_mem_id(),
> +				  &node_online_map);
> +	if (!page) {
> +		ret = -ENOMEM;
> +		goto out_free_root;
> +	}
> +
> +	for (i = 0; i < nr_pages;) {
> +		unsigned int nents = min(nr_pages - i,
> +					 PAGE_SIZE / sizeof(*root));

This looks wrong, sizeof(struct page)?, or size of physical address?

Becomes less error prone if you do:

min(nr_pages - i, ARRAY_SIZE(hpa_list->phys))

> +		int j;
> +
> +		for (j = 0; j < nents; j++)

You can declare j in the for loop.

> +			root[j] = page_to_phys(page + i + j);
> +
> +		ret = tdx_ext_mem_add(virt_to_page(root), nents);
> +		/*
> +		 * No SEAMCALLs to reclaim the added pages. For simple error
> +		 * handling, leak all pages.
> +		 */
> +		WARN_ON_ONCE(ret);

Perhaps to be friendlier to folks without the source code in front of
them drop the comment and do:

WARN(ret, "Fatal: TDX Module failed (%d) to accept memory, stranded %ld pages\n", ret, nr_pages)

...the once flavor not needed, right? It's toast at this point.
