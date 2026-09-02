Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9B6431A5C
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344201; cv=none; b=M84xbkkMSbQh0El9Bu/6TuSvGC2iA0yo7nB9tzKK2n05ZGY6IfbFvdnfmXQPcDgXafoBfBTJr90JkbQwZ2AzJSxLA8+r0NR4Sc1OyyBjKiUxAkcMTk1gJYg4ioBTTPPmLOdpurKYR0nWmPSTzerIbRF3XmDMtNgYoEu0YQukUqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344201; c=relaxed/simple;
	bh=XuWsCwVEmw1nsuFB/mbj8N981k8/d1KCbc+09ImqyQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVLf50LWTa/9wpSLsGF2GqkPPScH+BrxsDSBAyyQTaEwOwskRCoH9qugwn+s4lGUexz8yurxi7Pm7DE72gAzcKpxA9lcjZqyV8x4AhmEqyO0+MWYT+DFaFpgKLQR0hcyWLOT3PZl65zxTbytwDTwkhOXI99r9Phw0RQPLiADz5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFq6+mu4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFq6+mu4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788344199; x=1819880199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XuWsCwVEmw1nsuFB/mbj8N981k8/d1KCbc+09ImqyQY=;
  b=mFq6+mu4Ctsf9/1LzBBY+ypzQ9BDDKZzcfZdOj8UmBsTAUduGPtLBY7k
   eWx2DLNzy7p6rwtSXm0dcEJPUfzbkbmGJvycKni1S6tTfkVGcv485J6LT
   RpeXMh14FJzt7iqcZcEc1RT/rPdXZ/h5PS0099vi1CQuFCAQdH4Pqk+HP
   hoMYfGDixaWPf11J2Wo6bGhdhqxNlR7zf/70UAV983cwszWPaUaMrH8Ra
   UUQYgXdMpN8bbtAuzEkhIKxM5ZgN6bzoHvhhJfLEkYGc3jlNE4IdQlp+C
   GqhT5cHRwmdkKux+g7QdEZY5S9Yv05AVw4vrmT5XR3/eLwCpPErgZBnCh
   g==;
X-CSE-ConnectionGUID: PJ6IZjJASo+JtYjhjMEtgw==
X-CSE-MsgGUID: +tIjnLYqRYu6Oevcs7lJAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="92665425"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="92665425"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 03:16:39 -0700
X-CSE-ConnectionGUID: HT5Mz9KnSLWumBC+bu0xkA==
X-CSE-MsgGUID: Qsu9kHNARIOFz8yJPghDmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="274623500"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by fmviesa005.fm.intel.com with ESMTP; 02 Sep 2026 03:16:36 -0700
Date: Wed, 2 Sep 2026 18:16:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kvm@vger.kernel.org,
	sohil.mehta@intel.com, xiaoyao.li@intel.com,
	binbin.wu@linux.intel.com, farrah.chen@intel.com
Subject: Re: [PATCH 2/5] target/i386: Add LASS support in CR4
Message-ID: <apf3g2MQrt72OKdO@intel.com>
References: <20260826035734.114685-1-kishen.maloor@intel.com>
 <20260826035734.114685-3-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826035734.114685-3-kishen.maloor@intel.com>

On Tue, Aug 25, 2026 at 08:57:31PM -0700, Kishen Maloor wrote:
> Date: Tue, 25 Aug 2026 20:57:31 -0700
> From: Kishen Maloor <kishen.maloor@intel.com>
> Subject: [PATCH 2/5] target/i386: Add LASS support in CR4
> X-Mailer: git-send-email 2.47.1
> 
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> CR4.LASS[bit 27] enables Linear Address Space Separation, and may be set
> only when CPUID.(EAX=7,ECX=1):EAX[6] enumerates LASS.
> 
> Recognize CR4.LASS as a valid bit by adding CR4_LASS_MASK to the known
> bits, i.e. clearing it from CR4_RESERVED_MASK. Mark it reserved in
> cr4_reserved_bits() and clear it in cpu_x86_update_cr4() when the guest
> CPUID does not enumerate LASS. This keeps CR4 handling consistent on
> paths that reach cpu_x86_update_cr4(), such as gdbstub register writes.
> 
> LASS is not emulated by TCG, so it is not added to TCG_7_1_EAX_FEATURES
> and cannot be set under TCG (helper_write_crN() and helper_vmrun() both
> reject reserved bits via cr4_reserved_bits()).
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> [kishen: rewrote commit message, rebased, fixed formatting]
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  target/i386/cpu.h    | 7 ++++++-
>  target/i386/helper.c | 4 ++++
>  2 files changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

