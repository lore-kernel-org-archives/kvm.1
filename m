Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFC735CB91;
	Sat, 10 Oct 2026 01:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791595710; cv=none; b=HW0+GJZ7Ea+qt5iLbKYYsT6gQ0Ad4lg7EoyFXNmtt5SVzUNM7GUk2d5yVZq+mHdQIExg5+z8GIDitozrQQDfv8ca0g4BAVdyunsPF/ffK/fdiSJEkl7Topoq+p8riUC9Fjy5iQAL25n9U7Q9DjiD6OcBCsbHn3HvDa1Z47D2OIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791595710; c=relaxed/simple;
	bh=/Qx+j0z3o2diLFdlXDvGBkQHTeSctFQe3nqSnRJXVTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nquYA2cIDviIEYQnpBxkKyJTYiI+izlz43JL2C1pDlef/7bXuNi7L8UhKIyhc6YW2DA43MWwgg6mVsPFfbFiAUrmJuY2YKkvtcS7+zlTkSpv4pyVGuBymYEycteVEYnNjnTwDBIxr+zxmWOE4R4sneqO017rJ4D2VwSPfCg87WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UFBD3QZI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UFBD3QZI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791595709; x=1823131709;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/Qx+j0z3o2diLFdlXDvGBkQHTeSctFQe3nqSnRJXVTU=;
  b=UFBD3QZIxStuECK+4ro5lnPS1LdebvVXoa+QIwSVemTV7SfhUPdLeK2G
   eiXxPSfKQvO7//yMWl3QQjFbJQ3K4kXz2l9pp72geI/loD+RN0wv/zIt4
   8z1DFi3aRrSubp+GTKpIJqvScM1quE/XLTtrvM7EaoYnMFQdmNaZ36Fqm
   HauA95i7DN0ox1hGN4xr3fPBtCL3DVTGcTeTFT+Gz/ogVDGPZBQc4Arzv
   zTpwxdqq81ZqjrgTou2ZwjrrVsTytwh4sumjyx17NOMbSENGSgMsWUh+x
   P3Kexrw1L7gKLgDEGrBPPhE9eDN9LyTbLsekxEBEXdRrocHKlb48FQbOs
   g==;
X-CSE-ConnectionGUID: PPNZuaFQQZauUvo7kdTInA==
X-CSE-MsgGUID: XFoKtyAWS6WM6j3cFWnZcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="279643"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="279643"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 18:28:28 -0700
X-CSE-ConnectionGUID: BVIlNJyIS4y3q1Jd7CvslQ==
X-CSE-MsgGUID: sr1HDb6nRf+K/eMwO3D4MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="435968"
Received: from yizheliu-ivm.ccr.corp.intel.com (HELO [10.238.208.114]) ([10.238.208.114])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 18:28:23 -0700
Message-ID: <1fd70147-e175-43e4-b7a5-468d557ceb0c@intel.com>
Date: Sat, 10 Oct 2026 09:28:20 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/22] TDX KVM selftests
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Aktas, Erdem" <erdemaktas@google.com>, "shuah@kernel.org"
 <shuah@kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "afranji@google.com" <afranji@google.com>,
 "kas@kernel.org" <kas@kernel.org>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
 "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
 "ackerleytng@google.com" <ackerleytng@google.com>,
 "pratikrajesh.sampat@amd.com" <pratikrajesh.sampat@amd.com>,
 "oupton@kernel.org" <oupton@kernel.org>,
 "wyihan@google.com" <wyihan@google.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "sagis@google.com" <sagis@google.com>, "Gao, Chao" <chao.gao@intel.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "Wang, Roger" <runanwang@google.com>,
 "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
 "chenyi.qiang@intel.com" <chenyi.qiang@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "jmcrey@google.com" <jmcrey@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Hunter, Adrian" <adrian.hunter@intel.com>, "x86@kernel.org" <x86@kernel.org>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <5a44a6925715e1edbd379ac0ea5526ec990eb819.camel@intel.com>
 <4828f8e29801adb29a4d48b8980d3b3a0a813e06.camel@intel.com>
 <CAEvNRgELDhXvPFKaoz+w-yywoJn0WMWvA-Y2jfdnwJVSbCSWyw@mail.gmail.com>
 <0782a971b1e6aa64c12ba76f9a4e68c8fe72bd2c.camel@intel.com>
 <b2a03539707ee8155f277a7c9f3e505de8978c0b.camel@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <b2a03539707ee8155f277a7c9f3e505de8978c0b.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/2026 5:16 AM, Edgecombe, Rick P wrote:
> On Mon, 2026-08-17 at 10:58 -0700, Edgecombe, Rick P wrote:
>>>> Actually why is this on top of in-place conversion? I thought the idea was
>>>> to break the series apart to get something basic upstream:
>>>> https://lore.kernel.org/all/aJ-6JpHD6xhAvZPy@google.com/
>>>>
>>>> Adding in-place conversion tests seems to be going in the opposite
>>>> direction.
>>>>
>>>
>>> We wanted to have this series based on in-place conversion since
>>> non-in-place conversion is on a deprecation path.
>>
>> Hmm, what kind of timeline do you see for the old interface actually getting
>> yanked out of the kernel? I was imagining it would be there for many years at
>> minimum, in which case it would need tests too.
>>
>> The level of dependencies we have on coco stuff is pretty unfortunate I think.
>> Considering these tests should have ideally quickly followed the TDX base
>> upstreaming, it would be nice if we could avoid it here.
> 
> I saw the new version is also based on in-place conversion (which is now headed
> upstream, congrats!). But can we talk about the legacy deprecation? Is there a
> plan to actually deprecate and remove it, or even move qemu off of the old
> interface?
> 
> Otherwise, I disagree with the plan to drop the tests for the old interface.
> That said I'd would be thrilled to have anything upstream, so if the set can be
> smaller or faster that way, then I agree with the change.

The v15 actually supports both: out-of-place conversion (per-VM memory
attributes) and in-place conversion.

> But in general, I'd like to know the plan for the old interface.

Sean talked something about it:
https://lore.kernel.org/all/akUdhVsIb7BEqU7z@google.com/
