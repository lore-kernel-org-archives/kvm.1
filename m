Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3281B3E4C87;
	Wed,  8 Jul 2026 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783543654; cv=none; b=hkqRVArsCbPz0x69rUXo8J4SWp7Vx9h0E2fHb0c0m43MllVwtzItXr92YFBnObhbiNkY9myXtwRCW7XWVgc8uvRd6yPSyXXHnaS+umRHAn19DM1EpdF77Kzq9tHa2JNaI5kqmSWTYUHAVPxHgsn3hAF9dmZzj/b5hklnWxqX23E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783543654; c=relaxed/simple;
	bh=cR1HiUm7pVgCihmLA1IsI6MdrD1/WBYTeEy1VGa+t2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7sN0Wea8HTGXBDnLlJy850yFgt4bJMkpYKglNeXFzRz7C8/wzUQJxFr+tep3j4FHefoEkke2aJMW/EEuVfkD/Dtg4eFh9DIjLH7+0MToBvP6g9kp1v32Vu3/EPVvVs3+ej3dM948T+jq4qimE+E+2FH0pcqEfqlk2WhplyyHYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WddHFLI5; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WddHFLI5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783543653; x=1815079653;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cR1HiUm7pVgCihmLA1IsI6MdrD1/WBYTeEy1VGa+t2E=;
  b=WddHFLI5wEehrLw1QO4zs3LY5av7K6asxa+LYUX6euo35Citr4gZvlAn
   n35mQCGFECTaZ8DhoZD+bLjUcFZLO23IOM69jDbmTkSzB3Y5SJx4d8Xzx
   qzAQSu2e2LnwkjuD2jRBA7myFOZ6P08BKZadHDsrsg4/ZtB6jk+UK6lDI
   HW+WQVCp708ubuLhDU7/hiRRHLLGTicJnCmRWBGuCcEJV7zbNHjDj1wmV
   VaHYFXOQZtWZdlcky+kB7Z2w8aIJWmdAXrbrbXcW5c5aF4XPxf4k3Ufhd
   HAzDaUBlGnojR6++MOce2AL6oW0+HwIILo4t4cX+EeiQNT8TnYU8EzlYG
   Q==;
X-CSE-ConnectionGUID: GQoidYbWToGqiY0BJ4lpRw==
X-CSE-MsgGUID: iyyGbfHMToyuP3De0pnNmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84316031"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84316031"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 13:47:33 -0700
X-CSE-ConnectionGUID: W4S9+43UQ0SsgOsyVy4BJA==
X-CSE-MsgGUID: 4mAzlO8KRd6FX6clzJ59AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="256308413"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.111.66]) ([10.125.111.66])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 13:47:32 -0700
Message-ID: <08c9bf2f-75be-4244-b99c-153ec1f604ca@intel.com>
Date: Wed, 8 Jul 2026 13:47:29 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
To: Sean Christopherson <seanjc@google.com>, Peter Fang <peter.fang@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 "djbw@kernel.org" <djbw@kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, "kas@kernel.org" <kas@kernel.org>,
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 Yilun Xu <yilun.xu@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sohil Mehta <sohil.mehta@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Kishen Maloor <kishen.maloor@intel.com>,
 "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-17-yilun.xu@linux.intel.com>
 <aj1tFuwZWdPGfUoG@google.com> <20260629100301.GA1743876@pedri>
 <akMQ3J6fK3DUBsPH@google.com>
 <23a9173f6e278ca7dfedce3374626c6ea3e1b47a.camel@intel.com>
 <6a445e4be6b12_3a3568100db@djbw-dev.notmuch> <akVNdxCzk-n4bgMv@google.com>
 <9df36c49e6be69dd9eece71f70a404a84b1563ab.camel@intel.com>
 <20260704054342.GB2169894@pedri> <akvsgVjwb00P1EuA@google.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <akvsgVjwb00P1EuA@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/6/26 10:57, Sean Christopherson wrote:
> What is "the S3M" though?  Is it a separate chip a la AMD's PSP/ASP?  Is it a
> per-package thing? Per-core?
I'll give you my rough software guy mental model of what it is: Each
package has its own S3M. They are microcontrollers which are discrete
from the CPU cores. Each S3M gets some CPU physical address space routed
over to it.

> How is it accessed, and what are the "rules" for for those
> accesses?  What types of latencies are we looking at?

As far as I know, the latency for one round trip to/from S3M is on the
order of a "real" device. It has a physical address and when the OS
wants to talk to it, those addresses are mapped with ioremap(). It's
similar to any modern I/O device control plane. Note, though, that for
TDX, there's no ioremap() because the I/O is hidden in the TDX module.

The real overhead comes because the I/O window is essentially 4 bytes
wide (IIRC) and all the data that comes in and out of it has to be
squeezed through that window. It reminds me of a UART, but with a
slightly more arcane interface.

For TDX, though, the craziness is mostly hidden in the TDX module.

> What else uses the S3M?  Do we have to worry about contending with
> non-TDX usage?
There _are_ different users of S3M. But each of them should get their
own I/O address and S3M firmware has to handle talking to those
different users at the same time. The TDX I/O window is owned
exclusively by the TDX module.

So, while S3M has and long and growing list of jobs, the random software
(like the host kernel) poking at one I/O window doesn't have to know
about the other piece of software (the TDX module) poking at another.

I'm sure I got a detail or two wrong in there, so folks that know this
better: please correct me. But I think that's a halfway-decent 10,000ft
view.
