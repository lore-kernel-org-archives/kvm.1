Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E96C2641CA
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779881237; cv=none; b=dfD9fiR9otqdYOOCuZWWtcqgP5bhiL4ZFlV9aBtbuS2c2chn1QyNaetG0VH1QS72T7CUNpC+ZakLQqxA9nmPxtGVAuO7Q6djjJMGTi4ZaO0UXMMGQ7HR1NgdWz1I7w0xL0sWSRNSIPX5fzyfS3jAu8l4yc0LRTLHQwVB93Rxbos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779881237; c=relaxed/simple;
	bh=WDcP4uLRnCpQCWc1T/S+81baSRubdhT5/fcmMqKSQV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlRiRua3ZWso4uHCyISTUk78lBQp7YF18jh4mV6OpYqzYUefRzrY0CzmZ9GjLmt4x1LtyW0QFRWtzM2wvlB7cuyLX5NwWRLX2rMywSk61S6BVsVZTOz9pVCgB0DBG+la71EYH/9eVh6StxTIbbKMNq5AdESnZuIilPPBE3Nocb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhWqQ0fQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhWqQ0fQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230C31F00A3C;
	Wed, 27 May 2026 11:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779881235;
	bh=DxSzOyzZjnQzUKY1w35QWmemvf3P4E5LbaaAHGPxe/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VhWqQ0fQYw4z7Iv43KkX5q8ldahaKPdN7aDT8SCB0kWRY3fPZlfwU2KtwwwDGBXup
	 D5h6xAvRTdsRTWs+MDYm0bWZv4uAb0wRQWGpgL7SJV9AftH71fWk892hXD/zPG+JU2
	 do0axeSkzRlwXAKlAk2xtIRcrFlREnK1IrQ4NoAvJNsedQcvvaxAqmUj8UWYvsBEBE
	 rJac51PNY7nEd983MmBoI06O5/LziBMuJWGOculpIvmMTie5NR7BWcUT+B55dALx5j
	 xsMYQSWdoonAhvecYmuQxhSmazcKXlMn06ZMSM60RuGj5tSuV9sKtbGKSVkFkcHcJt
	 wbEVlvWGzga1A==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 680CBF40068;
	Wed, 27 May 2026 07:27:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 27 May 2026 07:27:14 -0400
X-ME-Sender: <xms:EtUWasqFJ4doi9b047h7o-XSGeX8xYqt4e2-xsyRap9Ffv6Mcjlwmg>
    <xme:EtUWaqAzLN4DPahdOLs8bjLiyp-8iB5lj2gjwZuWhISQ8jll40nbSY0GmiDEduGKI
    vZjBmAVEmzOr3R24FhlvPXg-HXydHazxFOBI7ExPDUjwFuKD7bstfI>
X-ME-Received: <xmr:EtUWarjio82DgrOBGVJa6DRc_0WrGKaXNqK9rx5Cj5UmiiiVW66H0rUqiv0_bw>
X-ME-Proxy-Cause: dmFkZTGZ5Y0VfjJLxz1ex4ImMFh3+sJdSsGEkMhCzrE5EzkEH0JVpyxbNavSMJM9m5v27B
    RAmS7FSYFT+xkMdd1oCSD7qGNq+ynVmZRKX7afkMeZSlwV/xCBCK5rZp3ok4+iEswA61Jf
    UyBqh19RmIz9TMiGA9AaOepW3gNdgVKZFuKkho1CxUfApXHXBOVKYa5sh73Jb6TLugDx45
    lyihaCxmh9r2oMW2d5QHiZeiiADie3gFTILIgYYvslkAJYRe2opMsypsouFXHYwd8Hy8cu
    lcCtYL/rXYYkN7A7OyJDROEy2+31NbxwFg02thgxYmIJ/w38ZKpxuHsCxrWybTvaVuPLTH
    XBYd8ZxPsGkXRdrLt/vCdgKrP5G3tIGS0s+lANBatMwj5mfr6Q+ILo5bOUl8QoAUswBFcm
    e/pSGrgDEKWcmSUZNZSik7xgrm7nzu9EkO2NqeSAV0Ct92VojVJGv8aUe6xzp4W/+p15tU
    EJObDpI95tYuirj5WIIltgootl6uDZT/e+p1EYBSHDcmBj6syP2+XbvPG+KR+sVTlq+dhd
    fDbRjWByQXOoaOkeWaT3yvNBl1XOLqJbZ9n5JSyhZfbjJSQaaL9k3RTIelumIsjXOqyQM4
    lQ09yOtJXemkh/g4k09Zh7FxStXXHDLhoswPBiqfcHWxV1zTsXrOvWXzvmHA
X-ME-Proxy: <xmx:EtUWap4VhXstRKGyS5NCjXYU6DRrEJKAuP1d3VISxhWeWdO0GtpCMA>
    <xmx:EtUWavq-O_mN37gPk5pU4Kih2oKjOBDVVoXWsZk8BmwDZL3Cw4ZFZQ>
    <xmx:EtUWal7txxUV23R3ww_SjyeAdcYwf1R7iO6ZWNC8u0MCzdPPpzUyBg>
    <xmx:EtUWal0N81cdDlddCZW07nNd1gMB6tAAYs7hYvZwWQAI4OXJf6iAGg>
    <xmx:EtUWajNwWTu9LAWUSuHq3YzPlqOUIgJDEyY2TaHoikZnlCUnhZDjJIS_>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 07:27:12 -0400 (EDT)
Date: Wed, 27 May 2026 12:27:07 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, binbin.wu@linux.intel.com, dave.hansen@linux.intel.com, 
	djbw@kernel.org, ira.weiny@intel.com, kai.huang@intel.com, nik.borisov@suse.com, 
	paulmck@kernel.org, pbonzini@redhat.com, reinette.chatre@intel.com, 
	rick.p.edgecombe@intel.com, sagis@google.com, seanjc@google.com, 
	tony.lindgren@linux.intel.com, vannapurve@google.com, vishal.l.verma@intel.com, 
	yilun.xu@linux.intel.com, xiaoyao.li@intel.com, yan.y.zhao@intel.com, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v10 13/25] x86/virt/seamldr: Allocate and populate a
 module update request
Message-ID: <ahbQiisGLyG9wQ_A@thinkstation>
References: <20260520133909.409394-1-chao.gao@intel.com>
 <20260520133909.409394-14-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520133909.409394-14-chao.gao@intel.com>

On Wed, May 20, 2026 at 06:38:16AM -0700, Chao Gao wrote:
> +static void populate_pa_list(u64 *pa_list, const u8 *vmalloc_addr, u32 vmalloc_len_pages)
> +{
> +	int i;
> +
> +	for (i = 0; i < vmalloc_len_pages; i++) {
> +		unsigned long offset = i * PAGE_SIZE;
> +		unsigned long pfn = vmalloc_to_pfn(&vmalloc_addr[offset]);

I don't like that we need to assume how the image got allocated this
deep in the stack.

I can imagine situation in the future when we might want to load TDX
module to memory on boot, like initrd. And it won't be vmalloced in this
case.

Wouldn't be better to use a neutral way to get physical address that
doesn't have the assumption? Like, slow_virt_to_phys().

> +
> +		pa_list[i] = pfn << PAGE_SHIFT;
> +	}
> +}
> +
> +static void populate_seamldr_params(struct seamldr_params *params,
> +				    const u8 *sig, u32 sig_nr_pages,
> +				    const u8 *mod, u32 mod_nr_pages)
> +{
> +	params->version			= 0;
> +	params->scenario		= SEAMLDR_SCENARIO_UPDATE;
> +	params->module_nr_pages		= mod_nr_pages;
> +
> +	populate_pa_list(params->sigstruct_pages_pa_list, sig, sig_nr_pages);
> +	populate_pa_list(params->module_pages_pa_list, mod, mod_nr_pages);

I am not sure what the value to have this as a separate function.

Having it directly in init_seamldr_params() would be easier to follow.

> +}
> +
> +/*
> + * @image points to a vmalloc()'d 'struct tdx_image'. Transform
> + * it into @params which is the P-SEAMLDR ABI format.
> + */
> +static int init_seamldr_params(struct seamldr_params *params,
> +			       const struct tdx_image *image,
> +			       u32 image_len)
> +{
> +	const struct tdx_image_header *header	= &image->header;
> +
> +	u32 sigstruct_len	= header->sigstruct_nr_pages * PAGE_SIZE;
> +	u32 module_len		= header->module_nr_pages * PAGE_SIZE;
> +
> +	u8 *header_start	= (u8 *)header;
> +	u8 *header_end		= header_start + TDX_IMAGE_HEADER_SIZE;
> +
> +	u8 *sigstruct_start	= header_end;
> +	u8 *sigstruct_end	= sigstruct_start + sigstruct_len;
> +
> +	u8 *module_start	= sigstruct_end;
> +
> +	/* Check the calculated payload size against the image size. */
> +	if (TDX_IMAGE_HEADER_SIZE + sigstruct_len + module_len != image_len)
> +		return -EINVAL;
> +
> +	/* Reject unsupported tdx_image ABI versions. */
> +	if (header->version != TDX_IMAGE_VERSION_2)
> +		return -EINVAL;
> +
> +	if (header->sigstruct_nr_pages > SEAMLDR_MAX_NR_SIG_PAGES ||
> +	    header->module_nr_pages > SEAMLDR_MAX_NR_MODULE_PAGES)
> +		return -EINVAL;
> +
> +	if (memcmp(header->signature, "TDX-BLOB", sizeof(header->signature)))
> +		return -EINVAL;
> +
> +	if (memchr_inv(header->reserved, 0, sizeof(header->reserved)))
> +		return -EINVAL;
> +
> +	populate_seamldr_params(params, sigstruct_start, header->sigstruct_nr_pages,
> +					module_start,    header->module_nr_pages);
> +	return 0;
> +}
> +

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
