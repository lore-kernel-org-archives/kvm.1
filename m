Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D92397321;
	Fri, 12 Jun 2026 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267787; cv=none; b=l/KhE8irHHGiHaxQQabW+ES+vDJK9ZtKSMrUABZPdnQ6sxdxVklRA6rR9rcWTCsaNnYOSiPBX6kE02v58h1a6VxtUBYXQ/iKuM7OUNL02hapBVs/D2ePhACrXfohmhaM27x9L6hJtwWHziV7hxHwDnsUwtpMylGYOq3nK9tiiEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267787; c=relaxed/simple;
	bh=O7oad/u5GatqAWAQwQzS/JjpW110RCugntm6tR+J+FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFm3v51EsVVLo6piV1X6lmUYNBArwGBZSADE89XN43NoO28mCMZRkBL28lslDu5HFSixmm29FHs+k64FacBcS/of7/yKwsQ+a1eAbQcn+qgDcv2jk4egIL0fgE27ge8g/ZlO4kwtaZXnWwXHmJuMMJD7N6u8diqIJ9+bNY97qfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMiULBb5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMiULBb5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B0A1F00A3A;
	Fri, 12 Jun 2026 12:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781267785;
	bh=PeMJ7kOGOmDhkLOw6oVuBD2kC6vBg00Wi30UqdpyNLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MMiULBb5iHLxMHeAuM4uug/gAJnK6pBF/USt7suniClt08L89ZFEmynbnBrxfD8iP
	 KAGfJZ6Ju28L7ye9A4MgevNO0nUDBR/TADRNKljhr0D53HJTBmqqu6dJv7q5xfSA3x
	 9XcLPax1BaQlluf2B+SlhUHtpitpBlIwDmEjIJo061NoEOxwUe+kLIXd+9lgQRViD8
	 t4jXYfvHLA5QJ2A88lyVSUWOHjTzcWv11M7/6tUCw78AgTQ307F4QxReRTcMxYM+Yh
	 URT1FZb9dXn+uPQHxQs9liwNKoA2z/asdH3TBGLNw0wfHYISmfOuCmoRciguWWMXgs
	 PzWwK7g1oACuQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 97121F40076;
	Fri, 12 Jun 2026 08:36:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 12 Jun 2026 08:36:24 -0400
X-ME-Sender: <xms:SP0raittobGxFQA0XvbIKYOAEoFJPFXgIwmfKenEvADEmUCPTs8kOQ>
    <xme:SP0ranWcVrg-AyL43ZBEOHpbm0FNX0cxiVj1HCK3duayZGCFYy_773BqEnA3ROkQB
    iddeZBnwkLek3HZIvp_zdsnefus6TL2DEaJVOTO3iACyhrrFeXvp00>
X-ME-Received: <xmr:SP0rarHCJVZGqCth62UF3UpH6UwL2frW8PKXz_vOGvn0qdVCIvg8NP53F4w9mw>
X-ME-Proxy-Cause: dmFkZTEVkdYtJYpvmp1AQ9XYBojiMfF+RYFtFg+bz7wlMap9CUDF5A5tc28fkgJdjMQSnr
    fGPoUXTbRskCKPn3DwelUlVLxT4oAf6sJMLj/f7rY9Elx7SnIKhsSweJSWjIyafWdQynxs
    PfVKpgDIfCVHDpvoVDz0eedw80Mlhoaw5oGh3TAckkdqsPm9qQG5SjKeRg9VFCsUTtAFFv
    894vIFp7GikLjZ/M3b0n4d1vnStCsAwPE5hUeB3cw5/16ZPyIxNZb5g7/EgHL7oL52TKac
    6QC0G0ZAzVnkxHOW2IS1qE8JC5w4onOZyV4xswL0I58rJvXzQ29ZpmlHRaWGWZzw8doyID
    1HbF1TN0CLZM3LBwHH7EXq/Mthj025dGBy21nM4RP5go3s9mgY7kgNoPQDw/aSmczuicJH
    /h5+3TfFgA8MZgzejGlEJwO0UD7gHbyoFBII7eCpbkMrEquRMAXJjKTYuuODNUwLEzWKjl
    NAUiluZPyMWm1VoBX6ZkUwza5tGtDN2cn9nce3VNlroQsobtyNrYCqjp/GvK/Rr6j+/L5O
    wwziqg3bZnjksYgi7A1jEuXXcMiYF/G89FfPEhklOffFGv1b5kAjF8Dk6RsTBL2QB/UoCQ
    qGrxmf70i3wICHMmtL529RALuyhQecoOXLmUODJi+i3ZnE9beUG4r7oh5C0g
X-ME-Proxy: <xmx:SP0rapai23sSmOEnMUZUPYVu1YQa-WOcstL5FqT5ko9Df3PywSrm3g>
    <xmx:SP0ragHTZj1b93Wrlg6a47BaHZbJB44rpJhtm74hHALw_6DmhH8SLA>
    <xmx:SP0ramwDITx8pwLNwH8SmK0QPoQYPlqnOEYYf4XccZ_Er00U2QQCQg>
    <xmx:SP0raqE4AjHDHrzWIPF7D47hYyufSsL9H3VjvmeAxn57skvxojLRPQ>
    <xmx:SP0rajtbgxlFcSYkmDG2mN2escwC0dn1eTxXam3B4q1xDE6zoYRZp1tw>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 08:36:22 -0400 (EDT)
Date: Fri, 12 Jun 2026 13:36:16 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Peter Fang <peter.fang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/tdx: Add helper to query maximum TD Quote size
Message-ID: <aiv8mrJDgs_e8eLq@thinkstation>
References: <20260612110853.3188196-1-peter.fang@intel.com>
 <20260612110853.3188196-2-peter.fang@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612110853.3188196-2-peter.fang@intel.com>

On Fri, Jun 12, 2026 at 04:08:48AM -0700, Peter Fang wrote:
> TDX attestation blob ("TD Quote") sizes can grow with newer
> cryptographic schemes, so guests can no longer rely on a fixed-size
> buffer for the Quote.
> 
> Newer TDX modules report the maximum TD Quote size via a TD-scope
> metadata field. Add a helper to query it instead of exposing tdg_vm_rd()
> directly, as it can read arbitrary metadata fields.
> 
> Thanks to Xu Yilun for suggesting this.
> 
> Assisted-by: Claude:claude-opus-4-7
> Assisted-by: GitHub Copilot:gpt-5.4

These supposes to be on the same line, no?

Documentation/process/coding-assistants.rst:  Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]

> Signed-off-by: Peter Fang <peter.fang@intel.com>

One nit below, otherwise:

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

> ---
>  arch/x86/coco/tdx/tdx.c           | 19 +++++++++++++++++++
>  arch/x86/include/asm/shared/tdx.h |  1 +
>  arch/x86/include/asm/tdx.h        |  2 ++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 186915a17c50..88c66c46e70a 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -197,6 +197,25 @@ u64 tdx_hcall_get_quote(u8 *buf, size_t size)
>  }
>  EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
>  
> +/**
> + * tdx_get_max_quote_size() - Get the maximum TD Quote size
> + *
> + * Read the maximum size of a TD Quote from a 4-byte TD metadata field. The TDX
> + * guest driver uses it to size the buffer for Quote retrieval. Older TDX
> + * modules do not support this field and return an error.
> + *
> + * Return: Maximum Quote size in bytes on success, or 0 on failure.
> + */
> +u32 tdx_get_max_quote_size(void)
> +{
> +	u64 val, ret;
> +
> +	ret = tdg_vm_rd(TDCS_QUOTE_MAX_SIZE, &val);
> +
> +	return ret ? 0 : (u32)val;

Cast is redundant.

> +}
> +EXPORT_SYMBOL_GPL(tdx_get_max_quote_size);
> +
>  static void __noreturn tdx_panic(const char *msg)
>  {
>  	struct tdx_module_args args = {

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
