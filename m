Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792735104;
	b=uOTwf4S7Qkmk7IDGmKera2UAbKSbE0Evss8TOVOTcqNVe8jLHGcNusZv09aTKihozP8D
	 qXCmW2FozVjT0F+HBvZQ7yYt0zJTVg1+aWge4KQurBSXeDEx7pDa9w51CQQtdCMQA5f39
	 1t3nk5CbNYrnP/xa5PB3Srz3z3okHqTVm7E6ufGmDAdbJOlmTqSG3sb0PuNKoMl5RG3+1
	 HHom7XVtSM+XvCnJWZuf+dooi0pTsbMHAB5sLzYQam8Twud7qjw9MGjt+TXEMRSOXI6i9
	 iFrQszYt6kBN4Jo4F60Y3uxP5kV+Zd6b4l1aG7j2Wcd41lEbP2uurvbCsfsoqdlCrlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792735104;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=R65EXrMvOWuGDp90Ia9xcp0VR60LBasxd5jtdZ6NYKI=;
	b=ftUAFVH4SpVaZYcOM/wpWGD8Rhf+hLzw/Q+eFT/jnUqTtmv3yZB4cMd5MeazYJN583UE
	 MWy622RGUe/riurSZMEFIwNhjTtv+z1cH47Qo5KOmGgm6K7++G2m/zEey4Hb9NZbgZiY4
	 JoHiPaXZ4uVbYxkhVBS5Z5ucKpHrTryBRts/LFFyxXv0jnCUYkr2t+MmSDgInyBWGyotO
	 0SGBUJdZHdIoE5qWtBmVnhbJqXCPktz9z1qYfagLME0b4Nhyr1R0Y0GwT7CioNQsIg0Ra
	 +R7U35NzOWIFhtINkyjWG8m9MaoxUrrGrycndgf0x3gn7IC9ljSSZsPbtJV9lKb2/Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="TpbZ/h2K";
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDAC606A31A;
	Fri, 23 Oct 2026 05:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFDAC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TpbZ/h2K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792735104; x=1824271104;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MY2zCagseHT6AI4LZ4aKhSGYc5LnpUrcAqNbCjAsBJs=;
  b=TpbZ/h2KtjPStL0LG53fXn6zU9ehq+AxH+h4eg906hHReQxdGBMqjRbl
   pdsqRsJAhM/SdPMggqC9CGUnQVHxjFmgGOgjmb8MdPdso9hv2+8MvOewl
   8aMpUoVsEnIDKjDXYY5vgaSLVkDUGUNe8yUCZH0eJeKQEuxC6s2pWMeVX
   IvoojxrINLroCjvvUEre7IPMEdyeH45fcZddxF8NpSQNdSyuSRLe79f+l
   FB8x67v7PBFa4+tWFsfv7okKsKS1eCBjXiTO0WDvxFBfNotdDdn56domd
   L4uhJLNZXnkbF1sNdCVc0vcoViy1r0eqWhHIB5tFUwd3ZThZVoiMo2Rr5
   w==;
X-CSE-ConnectionGUID: FG3SC8K2SZmM8dPobH18ww==
X-CSE-MsgGUID: DHIQ1ogESK2r6xMCJVYKFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1598437"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1598437"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 22:58:23 -0700
X-CSE-ConnectionGUID: trPy+hzDTlWQ0bMQYawqrw==
X-CSE-MsgGUID: 8fxvhsDWTJ66y6zIq8gJqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3591530"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 22:58:17 -0700
Message-ID: <9dd75d43-883b-44fd-a68d-3c7916691dfa@linux.intel.com>
Date: Fri, 23 Oct 2026 13:58:15 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/28] x86/cea: Prefix event stack names with ESTACK_
To: Sohil Mehta <sohil.mehta@intel.com>, kvm@vger.kernel.org, x86@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Xin Li <xin@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Shivansh Dhiman <shivansh.dhiman@amd.com>,
 David Woodhouse <dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>,
 David Matlack <dmatlack@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-5-sohil.mehta@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260911213659.2025974-5-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2026 5:36 AM, Sohil Mehta wrote:
> From: "Xin Li (Intel)" <xin@zytor.com>
> 
> Add the ESTACK_ prefix to event stack names to improve clarity and
> readability.  Without the prefix, names like DF, NMI, and DB are too
> brief and potentially ambiguous.
> 
> This renaming also prepares for converting __this_cpu_ist_top_va from
> a macro into a function that accepts an enum exception_stack_ordering
> argument, without requiring changes to existing callsites.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
