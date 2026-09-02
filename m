Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B4B4AA02A;
	Wed,  2 Sep 2026 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366313; cv=none; b=gOcuwfXqNTTJGrM4b/I05Xf72qtB7HZkmTvtpGVPQ2NgZRo+pMqdZvudUm5Hk4mTaGwqHDX2VFOjJBxlCa80fciOxMOqH9L7dwFGHwlj2Jpe/uzY/lBEPlbFSo6N6m+Y4RcpKu3z7Z5ixTI5Y9PW+xQNQv1hWyOyzYP6vsiPskc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366313; c=relaxed/simple;
	bh=ySYYcwlClxp/Mkrb0eAVLiKUcceiCcG4UM6cRTF2EYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+BLiQ1jfo3LdIn6X578EbBdXhusWB7a0gnaGK1Kt8+csiJYco3UpKhPoB/NNIS3NZYB/vJ6AWbZThYtC7cav1G94u5EGFpnoB0c5+0jMpLce2w86t/LzysWX7037u7mUsoQw9wzfM/BKfBJQh/VB4y/F3kKx/xkGUHnqWQbhwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NgQjYyLP; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgQjYyLP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788366312; x=1819902312;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ySYYcwlClxp/Mkrb0eAVLiKUcceiCcG4UM6cRTF2EYM=;
  b=NgQjYyLPYKKkWh3ic97G0Iu/SISPNdAYY/fPtZWjzcFumHZ6EjWUo1Mi
   brbK97Q69I7zCwNo46oNBM99ByuMI916l4uLX8olTCGwQCd+oo9O54mhW
   Y8e2T2Rzr9+X0AOZk9mAqMgDKR/Rjg28ueXCwU9tNaDp+0RgdXLy+Bq1N
   Lrzq6iwXa+LgrfpUn3sifUmQtRSut8x5GcGkdG1DsQgn4XqJHlbuZbRza
   gVxr6bv7rrmw8gl6XlyOYjrBb6uFM83j2H/+7hAwkz3s5dztB/uFoWJRy
   9rYgFFdWPtvsSrFl+s9jz7NZxjPv4MxztsdydtO4SfqXaQM56WujjJ/Vw
   w==;
X-CSE-ConnectionGUID: amqKp9UERgOcvtp4slqIjw==
X-CSE-MsgGUID: 1E98HUrZSM2zLlz4yFZG5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88881447"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88881447"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 09:25:11 -0700
X-CSE-ConnectionGUID: GbzBxvqnT8e+19c8F1v4og==
X-CSE-MsgGUID: 63y2m2ghQC6izEIgTw+7GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="271424957"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 09:25:08 -0700
Message-ID: <a018a58f-76af-43a7-930b-943a9a5c0a9d@linux.intel.com>
Date: Thu, 3 Sep 2026 00:25:05 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "kas@kernel.org" <kas@kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "seanjc@google.com" <seanjc@google.com>, "Gao, Chao" <chao.gao@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-2-binbin.wu@linux.intel.com>
 <55488b92-66a8-45e5-ad0f-8fed63ce1187@intel.com>
 <a30741f8-b99b-4f36-80a5-4688c2578d99@linux.intel.com>
 <6b565572-b316-4e86-906d-f150c896fe21@intel.com>
 <84891108-55be-48c1-9993-c730a5334d5b@linux.intel.com>
 <249dcccf2353181f595547d19a07232fded71023.camel@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <249dcccf2353181f595547d19a07232fded71023.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/2026 12:22 AM, Edgecombe, Rick P wrote:
> On Thu, 2026-09-03 at 00:19 +0800, Binbin Wu wrote:
>>> I see. You added patch 2 because without it QEMU breaks. While for
>>> EST/TM2/SDBG/XTPR/DCA, QEMU doesn't break after they are turned to
>>> non-configurable. QEMU cannot represent all the userspace VMM. It still has
>>> the potential to breaks other userspace VMMs.
>>
>> I think the risk is pretty low.
>> I am not sure if Sean could provide some insight about this in google's
>> userspace VMM.
> 
> Can't we fix the issue if we are wrong?

I think it could be fixed to add the missing bits (if any) as bug fix.

