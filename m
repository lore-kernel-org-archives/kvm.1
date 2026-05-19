Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505123191BD
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 02:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779158181; cv=none; b=KuBCIog5CPVt7MRF15uP7q0bC62RaE3LgvqMISiFKWrUTXd1XZacIrpkRA+hWHL4fIjPUNogpeQyXpf5cqJjfExhiFS+kIadvYVccocc7fMFcnL/gD4oYkFGS0JIynCXqMKpMxAlJQnBZlx+ofNgX+nuHptLHWH+0nKIpcIkcbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779158181; c=relaxed/simple;
	bh=UVYd5pJ0cR3zRKU0bbbx2qkdYdn/5orsq03C0/LY9ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLoW+xq7WmKsLoGl8twlCu80eg24uIEi2qjmDt6ZfD3R/Jf/GzGOz1Bdiz6tyCjB4xJBvu1LvHZZjSNNMme1vcGEQc9iq3b2+OsqQ7FFXhNidNKLqgr0rH7YdluiymQSKgo3STYi1MRKjnhr6Hb351BWlQLMfzPshNLbcnk0bO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CaR7+Z+a; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CaR7+Z+a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779158180; x=1810694180;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UVYd5pJ0cR3zRKU0bbbx2qkdYdn/5orsq03C0/LY9ds=;
  b=CaR7+Z+asKyUgo7bXjUIUgU7LF1wVg6gBCEIkS8z27jUTlC/gsGRkvGr
   LBE6L4YD2chu4pILyqVyF1YGWshtxPYzrB6eu4CYVfIZuRxRgXU9Z2NPj
   izz8Le8B4+mNBUjsBuCjjZME8znjMaKV8iFAdNg2oz3wxglZQlFuO8IkP
   sNRyv+D0jWkUwWXu0k95B77BpzujDQQ6EAcrSvfcwrBafieLL/N+OyzzS
   sH41rCC0XLikp1aBRq25NYeT2xCrSgd759m8d0gsvkutjFXGGSa3zwQNC
   TGpZuG2giBUKwVykLR6WBcc0REqa/o8j3aAmyFsYpqG2yZ9xLHEz+YmCW
   w==;
X-CSE-ConnectionGUID: oMQdHYhTT0C/lZlmQ63wvw==
X-CSE-MsgGUID: MKD25j0eR5O1Wvbi12LPsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="97594305"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="97594305"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 19:36:19 -0700
X-CSE-ConnectionGUID: z4VA/AI9T8SmruvWY5cU4g==
X-CSE-MsgGUID: SW2RwL6eSa+ksta68dpybA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="233235221"
Received: from fanlilin-mobl.ccr.corp.intel.com (HELO [10.238.1.228]) ([10.238.1.228])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 19:36:16 -0700
Message-ID: <823c8399-6068-49af-8481-230e2680679b@linux.intel.com>
Date: Tue, 19 May 2026 10:36:14 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/27] KVM: x86: Add a paranoid mode for CPUID
 verification
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "seanjc@google.com" <seanjc@google.com>
Cc: "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Gao, Chao"
 <chao.gao@intel.com>, "Huang, Kai" <kai.huang@intel.com>
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
 <50ccbe42-4b74-4c2a-b530-a367f7285de6@intel.com>
 <bf569f46-8690-4f82-a2a0-d196970880de@linux.intel.com>
 <agsiQGikhZA0CGTY@google.com>
 <64ee4f0cbb158eeb21ce5581346359cb338d3ae5.camel@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <64ee4f0cbb158eeb21ce5581346359cb338d3ae5.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/19/2026 4:55 AM, Edgecombe, Rick P wrote:
> On Mon, 2026-05-18 at 07:29 -0700, Sean Christopherson wrote:
>> More or less the same benefits QEMU's default behavior provides.  Whether or not
>> the value added, relative to what userspace can/does do, is worth the complexity?
>> Dunno.  I haven't looked through the series, but this:
>>
>>   15 files changed, 1298 insertions(+), 525 deletions(-)
>>
>> definitely gives me pause.
> 
> Binbin, how much of this is CPUID bit data and how much of it is actual logic
> code to do the paranoid mode?

- Patch 3 ~ 11: Construct CPUID overlays
  10 files changed, 510 insertions(+), 439 deletions(-)

- Patch 12 ~ 19: Build allowed CPUID values for different overlays
  6 files changed, 556 insertions(+), 42 deletions(-)

- Patch 20 ~ 25: Implement paranoid CPUID verification
  7 files changed, 200 insertions(+), 30 deletions(-)

- Patch 26 ~ 27: Remove the hardcoded filter for TDX.
  3 files changed, 30 insertions(+), 29 deletions(-)

If we split the patch set into two parts:
- Logic code to do the paranoid mode (including userspace opt-in interface and
  documentation)
  740 insertions(+), 498 deletions(-)
  This part eventually adds 242 LOC.

- Build allowed CPUID database
  556 insertions(+), 42 deletions(-)
  This part eventually adds 514 LOC.
 
