Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B5A30BB8D;
	Wed,  9 Sep 2026 05:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932232; cv=none; b=Va3FQIuD2Uio3+pkUkDTHINImAQZl/O6R/q3hVweWCWx/VQUAOSf+FpGYhAV6qNlIutQExnL8cI4TvLvqyddZDdyNz3vdNqRe2kioNnTNdwjFw7mUSHnEx0uFnISn1HojBLvz+3rEB8TvCeak3g79V232YP+to2EDuvWCePTXys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932232; c=relaxed/simple;
	bh=+sNUk2yMtfaDZ+ICaqK6nwQI79xTb44V9/GAt1GvBWk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P4PL66k/gmOUi+81Hd5z/hbGrK+Op6r4lc/YDK6qPCLllYvlVjpQNkB636va5WRt2Y0vV5Yotovf+U4JgkrgEViqJ97TcYd9tQHh324PMXJ+aMDT1PXoMt0GGrrMk1xRwdekNxH/3m/yhay1shNeaZ0xGBNHMn0lcx2ZCX0E+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRni+Abs; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRni+Abs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788932231; x=1820468231;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=+sNUk2yMtfaDZ+ICaqK6nwQI79xTb44V9/GAt1GvBWk=;
  b=cRni+AbsQnYCP8pK3h+2WFcIBP4IJ7OQBaFn7Dpo7z3aJv77aKFiPFlw
   1opESECuTpIskBpXvj+LW8CvkgEadxEizKnI3ObMmWm0VFmtKQvWYsfwj
   3F7nQE13w/HJzm8ZClOljiTH/fCQbHaPzzTbKspzZPd8JAkCY9UOqzaF/
   rA5c2huRNpDNfDOiLPS44trIZ+8Ti1JPxNtk0Nxv8uF8GTK8LKagCK95L
   UwM4wOzqu6yrrYHY/7/r8kT17hCx+jkBt/yi2X5fvCTeYLZVnsutDPms4
   5Jmb2GqX/Noobu/CzrISFNF6zpLAKdKVPUj5FF/eQRSN2TP7axSSi9ekP
   A==;
X-CSE-ConnectionGUID: 2hC0ZWUvTPKdagwOzIwS0w==
X-CSE-MsgGUID: J/2lOutiQyuducRmVlhptA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89378487"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="89378487"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 22:37:10 -0700
X-CSE-ConnectionGUID: TEleFn1UTTCM9KlUcfEsxw==
X-CSE-MsgGUID: jdBAEHNFQUGvrjUtK6vuNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="269466826"
Received: from unknown (HELO [10.238.2.139]) ([10.238.2.139])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 22:37:08 -0700
Message-ID: <ecd8ec8a-9710-43ab-a05a-28634ced26e2@linux.intel.com>
Date: Wed, 9 Sep 2026 13:37:05 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
From: Binbin Wu <binbin.wu@linux.intel.com>
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
 pbonzini@redhat.com, dave.hansen@linux.intel.com, andrew.cooper3@citrix.com,
 nik.borisov@suse.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <32b51faabf60f6e87d9fdebbf2c3fe5a45fbff1c.camel@gmail.com>
 <59626371-b9f2-4a8c-9c3f-ad7104b21dc0@linux.intel.com>
Content-Language: en-US
In-Reply-To: <59626371-b9f2-4a8c-9c3f-ad7104b21dc0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/2026 7:54 AM, Binbin Wu wrote:
> 
>> So maybe the way to go is to just follow 'msr_preservation.pdf' and
>> adjust the allowlist? I find this approach safe and acceptable.
>>
> 
> Rick explained the long history:
> https://lore.kernel.org/all/58c185c82658819454a9950f37c6424226a098bb.camel@intel.com/
> 
> The Denylist based solution is not a clean solution:
> - It couples the feature enabling for normal VMs with TDX tightly.
> - Each time a new feature is added in the denylist, it needs to be backported to old KVM versions
> 

Please ignore this part since I replied to the wrong thread.

> 
>> Artem.
> 

