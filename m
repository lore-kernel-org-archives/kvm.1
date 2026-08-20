Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD8623C8A0;
	Thu, 20 Aug 2026 01:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787190804; cv=none; b=b5vSatS435JTM9NXJKt0/lvidhMlEf/iIRRkpjOFo8SiJvnPuE8hLvRvT2UWtjXhKl4aR/UyZe2vMhWh1VU3lUR652oMD/DpWzCafMIb+XE4EN5+xWJVRnDiqTPmCZRBK3eTJq4PaHzcW4ZDdC0zY0eFEZy5uZDvLqi8n/hpZ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787190804; c=relaxed/simple;
	bh=8TbN3As+lAz1oCNMcYURTNYgukXRisL/cL9L3Mjc6KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPUTH7CmWITM3XM5XhwltGsyF/zmaL/fRcuABmo3oAvdOXe10Ijq+7hEKcgidxfLntPsVfYTwEKJp6LAgBulB1kamPaZDN5EJtNbwucQAFdgRFaKCoKO6td75A6acc4SiGW0znDQ4A1Rtga/fq3iHzjN+CmYaBClveS88ZFhle8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0590RyP; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0590RyP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787190801; x=1818726801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8TbN3As+lAz1oCNMcYURTNYgukXRisL/cL9L3Mjc6KY=;
  b=h0590RyPPa9sjakgnj8j5gxsxRp5eg/wwS0HeBYJQQUixiB3teoy7ekW
   Q+ncIQf7f9MoR3+nPDnjMKEhX67BDFHXALEVfsj2ssH+layw/N6pXIDVS
   9CdS1WhGgCg/HuKqOo8sejYVbL+WF1fbfUo/kgcVX+c5dQ7JMyCrT8atb
   Zvw0zIA4xoyzQ6B4bJzy8GMkrUi3+j2PMKDQYEJSmyW9g2QAXcLmXCSx+
   8NRbvUa3nk6uL8vim9H1SmiKCAFEVs7Nz+l+kuEL8tseJ9Gq2g/Sm0qCA
   i2PgHNpVW50XnKdH0AMfgq03+kzs2zx+0PbYBamAscG+5Heg2eYYuTeNG
   g==;
X-CSE-ConnectionGUID: tgvwxsTCTW6vxlaLCAOwCQ==
X-CSE-MsgGUID: CwM249iESpibbRzYLF1Y2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87779873"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="87779873"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 18:53:20 -0700
X-CSE-ConnectionGUID: TlZSYnaRT0qcGnybF3TpAQ==
X-CSE-MsgGUID: c2KE8cdfSDes5MpcC5he8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="269275796"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 18:53:18 -0700
Message-ID: <4fb37a2a-a069-4d73-9df1-b4fc250437ff@intel.com>
Date: Thu, 20 Aug 2026 09:53:16 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] KVM: TDX: Check if there is valid exit infos based
 on vp_enter_ret
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "seanjc@google.com" <seanjc@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kas@kernel.org" <kas@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>
References: <20260819094903.3060020-1-xiaoyao.li@intel.com>
 <20260819094903.3060020-3-xiaoyao.li@intel.com>
 <71de12296f46dec7753f9dec2ac08df97b49e8b8.camel@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <71de12296f46dec7753f9dec2ac08df97b49e8b8.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/20/2026 12:39 AM, Edgecombe, Rick P wrote:
> On Wed, 2026-08-19 at 17:48 +0800, Xiaoyao Li wrote:
>> Check if there is valid exit info based on vp_enter_ret instead of relying
>> on the clobbered Exit Reason, in tdx_get_exit_info().
>>
>> Current KVM uses "Exit Reason is not equal to the synthesized invalid
>> Exit Reason, -1u," as the condition to identify there is a real TD Exit
>> and valid exit infos.  However, there is one issue with this approach:
>> KVM updates the Exit Reason to the synthesized invalid Exit Reason for
>> real EPT MISCONFIG as well.  This is a false positive for real EPT
>> MISCONFIG, which has valid exit infos.
>>
>> Though the issue can be addressed by changing the handling for real EPT
>> MISCONFIG to not update the Exit Reason to the synthesized one, relying
>> on the clobbered Exit Reason itself is brittle.  Instead, check
>> vp_enter_ret directly to identify if it is a valid Exit Reason.
>>
>> Fixes: da407fe45908 ("KVM: TDX: Handle EPT violation/misconfig exit")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
> 
> This series has grown unfortunately, and I wasn't able to catch up on the
> threads from yesterday. Can we really not put this one in the non-stable patches
> at the end? Or maybe you can explain why it's needed?

It was suggested[1] (or requested) by Sean.

I agree that it's not mandatory for enabling Bus Lock VM exit for TDX. 
But considering that without this patch, both patch 3 and patch 4 need 
to change the line

	if (*reason != -1u)

in tdx_get_exit_info(), which brings unnecessary code churn. And given 
the patch number needs to increase anyway in this v4. So I just put this 
patch in to make patch 3 and patch 4 simpler.

[1] https://lore.kernel.org/all/an0N0vHwsYEqjpRe@google.com/

> Also "KVM: VMX: Preserve negative return value in vmx_handle_exit() with bus
> lock detected"?

It was suggested[2] by Sean.

(Since there are discussions happening in the cover letter thread about 
it. Let's continue the discussion there.)

[2] https://lore.kernel.org/all/an0KokdtSXE2GmM1@google.com/
