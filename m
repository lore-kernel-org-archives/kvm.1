Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D803F210B;
	Thu, 27 Aug 2026 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787829681; cv=none; b=sLNc+DgdSe5/Rm3Ngth+H0q844/DcJBPq5KNkIwo5WzEI5N16rh6PREFSnEWoIK4DlBOSIMQTTdhRHwGmUvDt20PDNbCf6dXuCA+gpHGtUBoERThESwZOoLt4mKhvr41e688EW+0ATqqBOdesCACqm6sieCZI9oaIkTiz2UGsK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787829681; c=relaxed/simple;
	bh=rHbHMpWeZJyn7hIS7WVlw57xDOzTyULuqNzOeAv8564=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ln5MDge9JPFpD66Nzw/f+CAWGDkuW3u845JfW1/QQ9rui3pwgih1OdcIWbIuHaNeBkAOKg4gWxpy1idrknEP0DtKDL/uee/V1TYe8PsnRFe7x0R15AyWSDoKEPGCKtluZLgbVr1mX1huSznakHcBPZmRcYSlGeDyUGaoGJQ/y6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MW/vBlE/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MW/vBlE/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787829677; x=1819365677;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rHbHMpWeZJyn7hIS7WVlw57xDOzTyULuqNzOeAv8564=;
  b=MW/vBlE/HG8Umn/11o5ffbxzDDQ6RKnjaHaOTkaSqo+q8Ud2L6uLK02s
   1L7T+j/m6qQqXJFpQcvZ6Kc685D+mNv3jbtzQS31FD4kaEsN6GX6A3mzg
   EPVLvOeWmu/p1phSm9XZ7k7+Ah8oisvF6l3d3I5lQ5Typ0bonaRmNut6G
   mAfkUamv0n9Mv/dckrF7JJ5Zl8MlzlRX4dwhknb3LEKl1C3klKutUfjpd
   tVNLfR85fL37NjvtGScp/bT09WHMhbQtosOzLpJu/HE/VdPwsyhKMwv5K
   gtDYpSLHZQo6lqbatfDRCkcNk/WhIHWlkf8lzMQssKY3NiKVCG/5GpYVS
   w==;
X-CSE-ConnectionGUID: 4UwlA5qiT8etlk0LuaG1cw==
X-CSE-MsgGUID: N7dppJO/Smma43G0mF/CUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88090213"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="88090213"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 04:21:15 -0700
X-CSE-ConnectionGUID: PvSf7o9tQyGbftur5NRnfQ==
X-CSE-MsgGUID: 2DjN8I/pSRm0bOaMbd1njQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="271647305"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 04:21:13 -0700
Message-ID: <15c473e0-1ea5-4d35-b4f2-e07b21f87e11@intel.com>
Date: Thu, 27 Aug 2026 19:21:10 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] KVM: VMX: Disallowing using to_vmx() in common VT
 code
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 Yan Zhao <yan.y.zhao@intel.com>
References: <20260826171246.777729-1-seanjc@google.com>
 <20260826171246.777729-4-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260826171246.777729-4-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/2026 1:12 AM, Sean Christopherson wrote:
> Poison to_vmx() in main.c and posted_intr.c so that attempting to interpret
> the vCPU as a VMX vCPU will fail at compile time, as opposed to failing at
> runtime, or worse corrupting state without outright failing.
> 
> Note, to_tdx() is buried in tdx.c, i.e. isn't broadly reachable, and so
> doesn't need the same treatment as to_vmx().
> 
> Signed-off-by: Sean Christopherson<seanjc@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
