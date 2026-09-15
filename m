Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270CA374E40;
	Tue, 15 Sep 2026 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461804; cv=none; b=UDmIXQwNfQCvZo9UdnvzVYLcKYgVFVrC29xDeU47ruHrCN3dUy7ULkDO65wC+GKiipulVCshJsYgNM1H+QLG+ec7Qex0FiifgV4cVsuBSteFbViim1U3tBg5YCz9SkEhh6widJy5LL0FeNar/PauOWv08bCmjDa/C/eQAHUuGhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461804; c=relaxed/simple;
	bh=cyRG1T2PDPHf7Ppda6R4nWqA/AhxSLime81k93QDI4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EascnJf2jUsQ1+e5RI3p4ayF5yZY+/Z6UKtB2aijh8cv8YsbviPiDjAeANeNvH+1esKJZSKUOXB4d3jbDVVM02aAye/gvER4vbzKME34X/XHuBTb3C7zAzf+g5819vSDJmDqBpwIwO8sV99TA1O7PYXaiDujHBxQrYTi/7+dzvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VlvIT/GE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VlvIT/GE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789461802; x=1820997802;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cyRG1T2PDPHf7Ppda6R4nWqA/AhxSLime81k93QDI4o=;
  b=VlvIT/GEVxOWZ2tnkpIWo6Q5+aVFSGuc6FIaKuTQy0JOHTVO+M+vTuFV
   nSSGqRo2+0wwurWOLcic/+//2NZ7gwBUa90wsjB5VKo9eVnvHLa/Pnnq/
   MapUZrMNOHDOWDMUGcpv+CmQBHQK81Nmra62/opqUO8rBq+IChx/hnKT/
   Rg3dTy+MM0gj2QRRD+sTaSraLPFV5sBwJ9EVyarpQlwincB0Jlh+erqRE
   UflDdv5OjHwlj0l2nIQRYQLIQmUPFnFuL8Z6jmBn+fxEmVKoafJ8xVVOv
   IiTX1E0Z78nugpBUkBE5761dcMe+99jm6hUeWUqlhglM3POqC88KHRWKC
   g==;
X-CSE-ConnectionGUID: Kf9x3PViSeOVEIl2WTPf3g==
X-CSE-MsgGUID: BTCX2F/RSle0Rb/mOvFIOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90024768"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90024768"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 01:43:22 -0700
X-CSE-ConnectionGUID: OyZntYNITX+nXcX5R7EO1w==
X-CSE-MsgGUID: 2wD6B4vlSpSOQa7VbCzv3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="273410897"
Received: from unknown (HELO [10.238.2.139]) ([10.238.2.139])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 01:43:11 -0700
Message-ID: <93667a03-f7ae-46eb-82f5-8167f74f16c2@linux.intel.com>
Date: Tue, 15 Sep 2026 16:43:07 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/28] KVM: VMX: Save/restore guest FRED RSP0
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Mehta, Sohil" <sohil.mehta@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "x86@kernel.org"
 <x86@kernel.org>
Cc: "corbet@lwn.net" <corbet@lwn.net>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "dmatlack@google.com" <dmatlack@google.com>,
 "seanjc@google.com" <seanjc@google.com>, "xin@zytor.com" <xin@zytor.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "shivansh.dhiman@amd.com" <shivansh.dhiman@amd.com>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "nikunj@amd.com" <nikunj@amd.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "tglx@kernel.org" <tglx@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, "Gao, Chao" <chao.gao@intel.com>,
 "Liu, Zhao1" <zhao1.liu@intel.com>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "yosry@kernel.org" <yosry@kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-10-sohil.mehta@intel.com>
 <dd7b17e4-8d84-426a-9962-3ae693dcf401@linux.intel.com>
 <22c2c3f67198185a8e3a6bda43e4f12b78305cbf.camel@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <22c2c3f67198185a8e3a6bda43e4f12b78305cbf.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/2026 12:14 AM, Edgecombe, Rick P wrote:
> On Mon, 2026-09-14 at 15:04 +0800, Binbin Wu wrote:
>>> Note, an equivalent TDX side implementation is missing. No TDX module
>>> with FRED support exists yet so this would be an issue for future
>>> platforms. A generic discussion regarding this is ongoing at:
>>> https://lore.kernel.org/kvm/20260827031837.2863609-1-binbin.wu@linux.intel.com/
>>
>> For old KVM versions, we want to defer the opt-in design or backport decision.
>> (
>> https://lore.kernel.org/kvm/c6b240bd-3c45-4abe-b17c-72a1a7da582f@linux.intel.co
>> m/)
>>
>> We may finally choose to backport the TDX CPUID filtering patch series to
>> stable kernels. If this patch series lands first, should we add FRED in the
>> deny list for TDX as a temporary solution to avoid having some version(s) that
>> allow FRED for TDX without FRED support in KVM?
> 
> The specific FRED problem starts with FRED host usage + TDX, so I don't think
> there is a reason to tie and temporary fixups to VMX FRED support, in any case.
> Or were you thinking to blame userspace for not respecting
> KVM_GET_SUPPORTED_CPUID, which would change after this series? 

My concern is if there is a release x with this patch set, but the release is not
a LTS/stable kernel branch. Then backporting of TDX CPUID filtering patch series
will skip this release. When the TDX module with FRED support released and work
with the kernel release, it will have problem.


> 
> Since there are plenty of released kernels with FRED host support already, I'd
> think to wait until we settle the opt-in question. Which doesn't seem like it
> should be too much longer. It will be less thrash.

OK
