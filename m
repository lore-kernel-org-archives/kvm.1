Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D315D3A783E;
	Thu, 14 May 2026 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762365; cv=none; b=nl/zpjGAuekGFlmeOBrrkiXajsO6vO4IklzhQfjaPVLU1uBGE6Ws2JWdt7TYvkBDzVsnkgm8NmA0t7BrWwfokMLv1od08o6/g/ynIWW+oFbnxodpwibEsZZ9I7ohVGdOhWLhOi3TotK6Hrjoto9XIoxualghdB0iZLY/+aaUrSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762365; c=relaxed/simple;
	bh=OKCcsspRabeoPjB6nlhNhXURZmKaENSQ+/YYoCf9FLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzqgBzAsS33j69RuBQpDzNZOqQrYwukUgSdbhXWI4e3moqPKTopK8qLBz5Q4AMu0e0WgUyYXmlHViZhDHY0k0cvCfrKg0oSIoHrYHcdBpBUKSOVjypGOk4CejyfBu0JK3cc0Onl/OoUfGpW+pWYoWfgDvnAdvpvzhtZ4ybdFUgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jPiXGMO5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jPiXGMO5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778762364; x=1810298364;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OKCcsspRabeoPjB6nlhNhXURZmKaENSQ+/YYoCf9FLk=;
  b=jPiXGMO51QKoeq6/pN7VuhH+eOnL598Aa0rYxS1aVatcYCzGnMc9t8kk
   noe4yfw7tjJtlHQKUQ1ciql0SzQ+cXiY+EJrpdBM5QD9NwvtzOPMjxfeX
   PLVw0bjll3fMgIq8sw20z2oVl4sT5Cr1BnxXBTznpvdcor5eYZVoa4kgw
   q0eAbfkluYjBL/oT4soVhNZ0JblFvwWdEyuGf/HcyGri3yQdvu2r7FQNy
   cHN35EvckdW1a5obR5s6I7u8lXBM0aqJN9WJA+dyxH6v5CPVskSicTx2G
   4iRa/E2uezi47GyMtEx997dzgZVHnMoAfkI+PeIMhAHErKakltPiDobVV
   A==;
X-CSE-ConnectionGUID: 6wQ/QmbNQNSlTnpI1ld5IA==
X-CSE-MsgGUID: 0z8FYYrDRyK5nXuGoyc8kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="78727281"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="78727281"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 05:39:23 -0700
X-CSE-ConnectionGUID: Atr1CzN/Saec56uma66O3w==
X-CSE-MsgGUID: aBoGEDBGR7e8g2to/IjoPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="276454137"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.18]) ([10.124.240.18])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 05:39:20 -0700
Message-ID: <6582affe-6fb5-4949-815d-8c2671051a9f@intel.com>
Date: Thu, 14 May 2026 20:39:16 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/cpu: Move intel_get_platform_id() to cpu/intel.c
To: Borislav Petkov <bp@alien8.de>, Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 dave.hansen@intel.com, seanjc@google.com, pbonzini@redhat.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, vishal.l.verma@intel.com,
 chao.gao@intel.com
References: <20260430020953.1405535-1-binbin.wu@linux.intel.com>
 <20260511100451.GBagGpw7jRBDdHkBgp@fat_crate.local>
 <d88d19f5-0a96-4115-97f7-8daf1edd625a@linux.intel.com>
 <20260513101436.GAagRPDAryWZ5hGqFO@fat_crate.local>
 <89d52fff-ec3b-420e-9f01-5cd2bc8ce5cb@linux.intel.com>
 <20260513200017.GLagTYUe_TGXnFVh7I@fat_crate.local>
 <20260513200713.GNagTZ8QI_BHBeZXXr@fat_crate.local>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260513200713.GNagTZ8QI_BHBeZXXr@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/2026 4:07 AM, Borislav Petkov wrote:
> It is not only used in the microcode loader anymore and the platform ID
> is cached in the cpuindo_x86 structure so move the getter to
> Intel CPU-specific code.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
with the typo pointed by Binbin fixed,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
