Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EC02F531B;
	Sat, 13 Jun 2026 00:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309049; cv=none; b=ARoznezaqOQwZFGU2BO/in3gmix6bXq8QNeFrogsklTOs9mxv1h5rPndc/qCefodqj9ltMRSEWBdX1Qpg9VNdUHIonULZ48Z4LCBBw0fuUGZjMzJBXtrjMNWV4WnwXFMdig1WVKL2fCrhRt96Piom0nbjG9zDGNGJkkRrtHmmxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309049; c=relaxed/simple;
	bh=5FMZpreKP6HzR6iIHGMdQc1YAzXWkwVPy8yLJhUS+xw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZW4e4Uo3HuY1thzcim5DVH9T1Kh6hChl3GHTsbR9s35kqTrcbzILadO5L39SQWjSXNOEWNoMuLqKC4NQ8951QyaZYsY5WdXUkAsiq4OSDMRjOm44taXrA7oTJaA6MHJAImC01lHhAJwfMP/8H6KdJGUsGimEUPYk8bbCe79qqeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WF9c1mlx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WF9c1mlx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3D31F00A3A;
	Sat, 13 Jun 2026 00:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781309047;
	bh=xOe8t2DMbm5StRw8EdR0ZiBhDS5a4ADhrFiSB8gnD2M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=WF9c1mlxb6s4k0hdx4LvKb8hoNVYRPOYHsLtcvKmQVOvqWGDgzmKkngdzqQlAL0+i
	 bCr69tq5hGus0FESVgpp7xMkX/ZPl2VvmU6eu0pgsaiPQup80ba+IaztAm2latLxpB
	 o4qnc1K66PDLzXKgs3qZ6g6+he4RLvpsrYsptBhpIXgFDuLT0txSNHuSFuAwwFc77p
	 nJnav+gz23Nap1eSRxQ02XrtK0tgxOWudgT24kLHG7bwggoyFLvr/24+U3DXfkNBkt
	 T53WSUS3DfwjGk8Qik42g80iWkQceg8AHNR2K+OMMzZjtnLQyzNSOrUbQiiEgKg7Ho
	 iKLehq4FP+g5Q==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id AFCF7F4009A;
	Fri, 12 Jun 2026 20:04:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 12 Jun 2026 20:04:06 -0400
X-ME-Sender: <xms:dp4sahBXfp_865DigpZ6hNYNRHK6cEVMuaheh-nlHf4Hg8MLRMYX2w>
    <xme:dp4salHRdkFfmONFBwvfnuSepuzGHI0gTohHGLu-AokqKyIV5MUOsHDPe6Nq2Ko7q
    mzIoUY0EVp5YyPl-hEH29fYwa0n9E8lGx5Af4cniO-8MrrS-kloH7E>
X-ME-Received: <xmr:dp4samJto-gXLR12evbbkmymNYRQVH5bUAGv22Wp-vXx1gKIAYqF1uc0HjCVh0c6w-dIlVBmx-W6YbU57FjD48WcRvCkNHjGTbo>
X-ME-Proxy-Cause: dmFkZTGilS0M3dezmeGnrGSX4Ch+dgHPVJ5esWLPQpGyfdBgwogwB0N8myN/g6TDUzG7S8
    4oBuSjyUBpCNhBGetgLyALiw2ouI1Y7lD2UpVQe9d3hTQzFJPY56Fm1DXrRfCgyfm7X0Lu
    JP0+VAV/KffvTK2oRSXSLn0k5fG4zhcfuoteHmcAAbuXqhOLsAGH6zacut63PB8mx9I7lb
    M2fOaKlBgGUX8DC0XAUFq74ZLpgah07mNXd1P4qZZjjUWsZUcYvjm0g2bzpQFHBecfj0Ka
    8/gQU0LkSNuD27Fpfhs0vgj7K8Sj68M4utYPxmcc2ZRwlFOeAbPaQ13Nm7Afsk4UP8lqSR
    u8wgnJnox5f2IjJNlGZL4mVEF/Uh3A2nkcr+mooL1AIGvqunFALAFzeapS4+jwtT5cmDsT
    4/HDwYui1i3rtpsr44bp7z/Ml8eXn92EUFUg60MI+FJEnlOgyj9HZM0IznsOaC8EZfViOh
    szh+1ghYsMrUMMW7dPrgUGvdwT4sH7u95FK1MT2C0pW9T+ZbkkIpVJTEMA2JcVmtPG6MpX
    p3wFw28/iFZt48lE2WO/hxcLmhh8vxziySDU/a9wbMjbiGhk7N5HlKJllOM6sUSZRXhpqE
    5pZeab7bOjahaZz7hfS8kir9iUH/79PphQbsDs3El4Qe7QI8x8o7gQhcpP0g
X-ME-Proxy: <xmx:dp4sasrcuZOkoRn3yROUCGO5NwPngY1DvAMF8stBguzB5QyKnx0XEA>
    <xmx:dp4satiZtA4UYaFm--jb4DaSHlAhegufhslKvdibXta1jpAwq_C6zg>
    <xmx:dp4sarbco3kcupAp5SiGhjP-xrMGAn0b7nm1_R7DDz_6B5H5rPUTLw>
    <xmx:dp4salm71x6hazR3m2GfBSl2R52V6ck4o2Yv6ct_cDdRz9cixJcViQ>
    <xmx:dp4sahw5cRQDIykIJJ87f1OzstY0YCeDLzIsvn-yiollqG0_iXOuQ6_w>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 20:04:06 -0400 (EDT)
Date: Fri, 12 Jun 2026 17:04:05 -0700
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
Message-ID: <6a2c9e7570dd_9b855100eb@djbw-dev.notmuch>
In-Reply-To: <20260522034128.3144354-11-yilun.xu@linux.intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-11-yilun.xu@linux.intel.com>
Subject: Re: [RFC PATCH 10/15] x86/tdx: Move and rename Quote request
 structure
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
> From: Peter Fang <peter.fang@intel.com>
> 
> struct tdx_quote_buf is currently used only by the guest, but the Quote
> buffer format will also be needed by the host for in-kernel Quote
> generation. Move the definition to tdx.h so it can be shared by both.
> 
> Rename the struct to tdx_quote_req to better reflect its purpose.
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  arch/x86/include/asm/tdx.h              | 21 +++++++++++++++++++++
>  drivers/virt/coco/tdx-guest/tdx-guest.c | 25 +++----------------------
>  2 files changed, 24 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index bc512a00a0d0..945e6817abb2 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -96,6 +96,27 @@ static inline long tdx_kvm_hypercall(unsigned int nr, unsigned long p1,
>  }
>  #endif /* CONFIG_INTEL_TDX_GUEST && CONFIG_KVM_GUEST */
>  
> +#if defined(CONFIG_INTEL_TDX_GUEST) || defined(CONFIG_KVM_INTEL_TDX)
> +/* struct tdx_quote_req: Format of Quote request message.
> + * @version: Quote format version, filled by TD.
> + * @status: Status code of Quote request, filled by VMM.
> + * @in_len: Length of TDREPORT, filled by TD.
> + * @out_len: Length of Quote data, filled by VMM.
> + * @data: Quote data on output or TDREPORT on input.
> + *
> + * More details of Quote request message can be found in TDX
> + * Guest-Host Communication Interface (GHCI) for Intel TDX 1.0,
> + * section titled "TDG.VP.VMCALL<GetQuote>"
> + */
> +struct tdx_quote_req {
> +	u64 version;
> +	u64 status;
> +	u32 in_len;
> +	u32 out_len;
> +	u8 data[];
> +};
> +#endif /* CONFIG_INTEL_TDX_GUEST || CONFIG_KVM_INTEL_TDX */

Drop the ifdef guards.

There is no cost to allowing a data structure to be defined
unconditionally. Usually the ifdef guards are to prevent compilation
errors when symbols do not resolve.

Otherwise looks ok.

Reviewed-by: Dan Williams <djbw@kernel.org>
