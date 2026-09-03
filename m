Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C348340DA6;
	Thu,  3 Sep 2026 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468349; cv=none; b=lpvzp01oGBJr1A1FouMXzej+5xhHFs2xcdpevcxlUsF6WE0JxrQFUgIY0iMIE4yIqiC3Ffd8Q8Mw6896z0+1gJ8IWB8YZvih6PcjI0nJDYb/nkvvoMbv8/U+S2Ga/fd33YrkHVhWjux7GBvGhGyenqMlTz8pehCPvm2Bhf06DKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468349; c=relaxed/simple;
	bh=Y6I8mx1FOcVoOnZTSG+ikb4onSWdn8gl40y3j1dXUjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bm7MMD0UKbeRT+gUCUNYRGOew/xcm90i56nIhlHfP8ieX2JQUxiKtuJHokj5JaYwDLntVFmrRzHgf1DS+5QbDTM+XgKxhqk/+Q5Cfm9qz1A9onj4rENYiPbbB8TV8aruC/0UXFN4h1qe+i+M4yZPvr74YHsepOM31CiT40fRnMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KSRqKkpw; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KSRqKkpw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788468343; x=1820004343;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y6I8mx1FOcVoOnZTSG+ikb4onSWdn8gl40y3j1dXUjQ=;
  b=KSRqKkpw/xdZE1AgoxRtmdN73/FKGuv011Mx3JG6Q3fF6L/+3wEA+ouN
   irMKPTmqOpMlwB2tK/ARKjuPWlw+pzVzAAatuVZxlWdWaB4K4mK7w/tOi
   OsmBhNNzE87jgpdZgeE/5ddA0th+lGdoADW+rlpSmhWVsLcWM2hSyeqIP
   6nD6A+Z+Um8JagVdPvS7owfYIn9rtTbItxBbzUevrS9EHGPyWEteKkHII
   nuYRHPPXsHZ202DtP62uFatu89nAc7l4suhjlk+YRKPMoLGbJTkvTcRmJ
   QtJP+pe4bX6Nc9Z17t7qzvj1cJVIiCfZSNg1EShbe3Uytb6XQ9j+SV5wD
   Q==;
X-CSE-ConnectionGUID: s+yIIO0bTIWFWk1yBS6+2g==
X-CSE-MsgGUID: 0twC+vbRSs+nSJx6uXtpcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92834655"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92834655"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 13:45:34 -0700
X-CSE-ConnectionGUID: lKmyHwd3RNazTqtw5ibN8Q==
X-CSE-MsgGUID: VzKRiIOsQQSH4M+oKO6ndA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="293349724"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.110.172]) ([10.125.110.172])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 13:45:33 -0700
Message-ID: <0af7543d-e415-4c1d-88b1-376aea063365@intel.com>
Date: Thu, 3 Sep 2026 13:45:32 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 10/11] Documentation/x86: Add documentation for TDX's
 Dynamic PAMT
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "Huang, Kai" <kai.huang@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 "Wu, Binbin" <binbin.wu@intel.com>, "kas@kernel.org" <kas@kernel.org>,
 "seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
 <mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
 "Annapurve, Vishal" <vannapurve@google.com>,
 "Mehta, Sohil" <sohil.mehta@intel.com>, "bp@alien8.de" <bp@alien8.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Gao, Chao" <chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Cc: "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
 "hongyu.ning@linux.intel.com" <hongyu.ning@linux.intel.com>
References: <20260903015113.93343-1-rick.p.edgecombe@intel.com>
 <20260903015113.93343-11-rick.p.edgecombe@intel.com>
 <225572f8-5636-41fd-9315-ef5efb78f0a5@intel.com>
 <7cd4a38ed0ab1618a90e1afc8d56b450d57a9374.camel@intel.com>
 <ac7c383e-9da5-4456-97fe-532518d6c2a7@intel.com>
 <94ebff5d4a229608ad89aa40254f02709b16d184.camel@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <94ebff5d4a229608ad89aa40254f02709b16d184.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/3/26 13:39, Edgecombe, Rick P wrote:
> This ugly hack might be a bit better to get the same behavior? Basically do the
> check TDX module wanted VMMs to do, but in a more convenient way for
> the kernel:https://lore.kernel.org/lkml/20260526023515.288829-11-
> rick.p.edgecombe@intel.com/

OK, so no good options for kernel fixes. That leaves us with:

 1. The TDX module gets fixed
 2. Users learn not to set incompatible configs

Neither one of which is the kernel's problem, honestly. There's only so
much we can do.

