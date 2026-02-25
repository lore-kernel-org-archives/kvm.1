Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32573D4131;
	Wed, 25 Feb 2026 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031847; cv=none; b=OiG1CI6gfSWI3YXu11bSOMLicf7JZ6KMCwjkAvL1tMLqJq5Mx+Tjx4jlHjzCUJ+YMxlsCOL3U60hzcsPKJTgoNME3qIKoWBjxej86SS0tD5DEUoy1P/RosgB/i7Z4AAu7RniY9O2PC8cT8TMgRqHKg5YSDig+t4CmrcEM95zCzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031847; c=relaxed/simple;
	bh=l0QziCYpZZxVYpSpkG+yXWVu0Ga0YF3LnsMseBP+FtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjNK5JZGxj5WATQ0A5cPcXOIq9NRzht6ITx5I9U1UlsvCKj4EzBRQjkkmwDdMDBLza6m8MsLDEj2HvjM30zlpn/qdUMEHYRpsrpIYvhf4nvGbXn+RNKDksxubZMdf5Krf84lXP2YBPJNTTCd9x0ivuDx58JqDOz6DwFxmDXRdMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kn7uKfKu; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kn7uKfKu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772031846; x=1803567846;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l0QziCYpZZxVYpSpkG+yXWVu0Ga0YF3LnsMseBP+FtU=;
  b=Kn7uKfKuY/HOuoF5BHaxvRY+CNmR6dOJ8NK/Tf9BYir4MHrf6Uk17cb1
   vNHQiCk7Zan1VqY+AM9mYqVZSp5XAzwcNM2zUEkudZ8ykn/cSlxHtNIpw
   E8fchasVCsP0LLgmLoF0IhdI8xYq7M2II/d6+kUZwzt43jXzh3cHh1fQK
   Yiqv7x5fLW+ckAUSr2qAYFXW3iPgwiTFUH67HJaC+gsLwXLRkwGXERJdT
   xG1NB5HeQ6RgiPf4XCjYa62jy101cL2nKys8OeXyPmhe6q2nEDZtNXGbi
   rib/W38laBytn6xjt6YPivIRU+iP63tbOYk+HJOTf5eaq639KrFhVmVGI
   w==;
X-CSE-ConnectionGUID: BBQVLmBdRRi04YUM4LPHZA==
X-CSE-MsgGUID: xsr598HHQRWoayg2HbC8PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="76677756"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="76677756"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 07:04:05 -0800
X-CSE-ConnectionGUID: q6MBpsdcTtmu0pn6w8pZlQ==
X-CSE-MsgGUID: jMhwxDuPR/WwmEThn92WRw==
X-ExtLoop1: 1
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.241.97]) ([10.124.241.97])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 07:04:00 -0800
Message-ID: <291d582c-842e-4850-90b8-504f7ca35ec2@linux.intel.com>
Date: Wed, 25 Feb 2026 23:03:58 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: TDX: Set SIGNIFCANT_INDEX flag for supported CPUIDs
To: Sean Christopherson <seanjc@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 "changyuanl@google.com" <changyuanl@google.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Binbin Wu
 <binbin.wu@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>,
 "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
 "kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "tglx@kernel.org" <tglx@kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
References: <20260223214336.722463-1-changyuanl@google.com>
 <213d614fe73e183a230c8f4e0c8fa1cc3d45df39.camel@intel.com>
 <fd3b58fd-a450-471a-89a3-541c3f88c874@linux.intel.com>
 <aZ3LxD5XMepnU8jh@google.com>
 <66336533-8bee-4219-9936-3163c7ce06bb@linux.intel.com>
 <aZ8AKZQ4L5n7wVMT@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <aZ8AKZQ4L5n7wVMT@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/25/2026 9:59 PM, Sean Christopherson wrote:
> On Wed, Feb 25, 2026, Binbin Wu wrote:
>> Do we need to consider the panic_on_warn case? I guess the option will not be
>> enabled in a production environment?
> 
> Nope.  That's even explicitly called out in Documentation/process/coding-style.rst:

Thanks for the info, and sorry for not checking it before asking the question.

> 
>   Do not worry about panic_on_warn users
>   **************************************
>   
>   A few more words about panic_on_warn: Remember that ``panic_on_warn`` is an
>   available kernel option, and that many users set this option. This is why
>   there is a "Do not WARN lightly" writeup, above. However, the existence of
>   panic_on_warn users is not a valid reason to avoid the judicious use
>   WARN*(). That is because, whoever enables panic_on_warn has explicitly
>   asked the kernel to crash if a WARN*() fires, and such users must be
>   prepared to deal with the consequences of a system that is somewhat more
>   likely to crash.
> 

