Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23753FFFAF
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526005; cv=none; b=LiG4beqCulgBXXBwt9Uej5fEv4kSNDe0LnV5AwRnylmSWcRJvYoDUkwm8kUb1YiqRO1vkV0FAbPrQMnizL5BrtFjEcNbKVtKShsv+ZpNF+XO2LaD5jMl7+ObtNKzKlawDDSYmpUWIE3br+cYf11L8I/7zyQdZI58qJpzGJ6Fqy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526005; c=relaxed/simple;
	bh=ZuDj6m38AfL48TmTZPjrj7qcjJgosEZ6Kp6WgfOX0aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLoUiIiCUbavbHyOx8TmYeLai1EOtQCsKkMtUzAazGi+/Yh6hE4gXykGadM6Jk/+kSHJjcyKAmDzSncmpy5YDjhujLpXMgetByvfqwJYMs32wVlZGvk7TA5Q+Iv9xJ3I2uCoEDLWuDIensqlZJctlIR7Pi25rMufeg0ASUQftmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OpABxtPS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OpABxtPS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786526004; x=1818062004;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZuDj6m38AfL48TmTZPjrj7qcjJgosEZ6Kp6WgfOX0aU=;
  b=OpABxtPSDU2nP4EnDAQdDxVRdQPZGWWWrXPCVO0codDjzddyWTqesegw
   KNuTrii7c6/Ou1VaD35A5pEpqHW0h2wty4PT8Vntb7f4+sTDmNvumw6A3
   ozMqPG8IQS0Ka0bUf28eQG26np6njX9fjtUxSyBfFDgApA+Q1nq7PL0XL
   8NnkXDLGl6bAFbGbw+vgf4Nwat3WfcEfq/RZNca9GTWumvEHiizPFyJly
   cdCfRc91GfcQybd0FPG7BJTDQnHusFrbaBbjkgLIR0ymyqTKxM7Q7UqSz
   cuF2bLBx6qWe33N3DAgCNrW3upCNKXrETlvE7lO4gQe4lhl3TGsZk1oA9
   A==;
X-CSE-ConnectionGUID: SWfk+OWmRN2uhZkGKfy2EA==
X-CSE-MsgGUID: M9DS6NuEQeSgfz/pvGgZuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="86927285"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="86927285"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 02:13:23 -0700
X-CSE-ConnectionGUID: cpiRHHBASimZuYulMCbgRQ==
X-CSE-MsgGUID: aQWiGWvPTcyMKM65Su/Nnw==
X-ExtLoop1: 1
Received: from unknown (HELO [10.238.208.98]) ([10.238.208.98])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 02:11:14 -0700
Message-ID: <b66874a9-3f3f-4b65-90b1-b08c4aab6649@intel.com>
Date: Wed, 12 Aug 2026 17:11:11 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] KVM: TDX: Enable Bus Lock VM exit
To: sashiko-reviews@lists.linux.dev, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
 <20260812080229.2481439-5-xiaoyao.li@intel.com>
 <20260812082029.118791F000E9@smtp.kernel.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260812082029.118791F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/2026 4:20 PM, sashiko-bot@kernel.org wrote:
> Pre-existing issues:
> - [High] The preexisting VMX handler vmx_handle_exit() silently drops negative error codes when a bus lock is detected.

As replied in the v2: VMX fix was sent already

https://lore.kernel.org/all/20260806111923.1990562-2-xiaoyao.li@intel.com/

BTW, Sean,

Will you pick the VMX fix separately from the series, if it looks OK to 
you? So the next version of that series can focus on the general x86 CAP 
changes.
