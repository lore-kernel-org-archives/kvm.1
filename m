Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B7F3D3324;
	Thu, 24 Sep 2026 02:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215555; cv=none; b=jWdD662Fyhn6mBsiWjvhFfYOmL/evLkBoF2njoKsokMwA5SQbM43xyaPQFFQTmOXOS2CLLbS5dYgoqWbjmAtLpTP3djyH+IyWP35rQXvH3fBjz2815VOkmCtCE2OA6H8fqf2NzsZw1/I2baiuzUSlmdsSCLA/FkdggJCFGaJsPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215555; c=relaxed/simple;
	bh=E+8rml4eeQ1gQkwzsqlnlOO8AmrtYgESx0n8qBTNVMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U4WHxRNzUmhpGsnyftGcPkFH34mb5kISCSFLcJ+Q3nFuGDkgM1MkzyRGRbHRCryT0igwS61Bm2Ni6psU418/PIy6V9ZYfpZyZw+gSiOofk1AQALXXMnHZXnk4WRvQWLm1Ca2eJKWcFbusmCmPGZTsK+XTY9FMoNPwqSFnu6T7VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gntvr7O8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gntvr7O8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790215553; x=1821751553;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E+8rml4eeQ1gQkwzsqlnlOO8AmrtYgESx0n8qBTNVMc=;
  b=gntvr7O8CF6D+J7REa3e6U2n/IIuEGvrNmzduqRUNfO3D12wKD38st9t
   RTnRvRJaQE7SdLNRtSQpcvoDE6hv/mUYvwGMWRwTi7gCrWP+/gpDVvce7
   YHpe916VqnmMD1nJiCRDL1cxYGJB2FISCoNij4dlRrAd/7iRUM+Fxg+x9
   M04mzmw+dpO48qzhzRqfKz7LNSCq75oruyfHQTuCXCluilUA4OKJZZd89
   sI5qb+nnZAOeTU6SP/7myIldZmq13RxmueEqipMuCEDIj6XA0NexgQbaN
   0iZJCsKGkyG7EsTizttK0twW2aVMM9Qac8Ec67i1TxpH3b2ZJXkVtn5i5
   Q==;
X-CSE-ConnectionGUID: cGp6iO3FSaiI1dcornTyrQ==
X-CSE-MsgGUID: v7VGGcUoSVWSl4mqp+h0HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="116492718"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="116492718"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 19:05:52 -0700
X-CSE-ConnectionGUID: zvsnqQR1T1OtYIoeUU+U3A==
X-CSE-MsgGUID: O5S8Q6WyRjirXrSwPN0jhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="278601304"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 19:05:48 -0700
Message-ID: <13ea0c8b-756e-4bf5-abf4-544ac2328bbc@intel.com>
Date: Thu, 24 Sep 2026 10:05:43 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Cc: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com"
 <seanjc@google.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "kas@kernel.org" <kas@kernel.org>, "Maloor, Kishen"
 <kishen.maloor@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "dedekind1@gmail.com" <dedekind1@gmail.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
 <20260917072548.2314491-2-binbin.wu@linux.intel.com>
 <a8ce5d830a04d99ec47cdc727e1761bd4031d544.camel@intel.com>
 <5ff81fc4-d144-4b2b-8375-d2f63e0dd618@linux.intel.com>
 <419b23f264af219da3be93a9d246b5401bbbaf13.camel@intel.com>
 <a436a059-b003-4e84-bd11-014bf2f17e97@linux.intel.com>
 <5168e058946a61f3be1cdb13f886dd632739d312.camel@intel.com>
 <ddba739a-b4b5-4c0f-84f1-803857f34179@linux.intel.com>
 <2cc4bbc3-11d3-48bd-9a9b-a9659fc101a1@intel.com>
 <a085134ba1e80e04ec5737dffaadd5abeb8c6d68.camel@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <a085134ba1e80e04ec5737dffaadd5abeb8c6d68.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/2026 10:25 PM, Edgecombe, Rick P wrote:
>>  But for TDX,
>> there is not interface to report KVM's support capabilities. After this
>> series, KVM_TDX_CAPABILITIES can serve as the interface. So it looks like a
>> bug fix to me.
> KVM needs to support all the bits that are 1 in the TD. Either directly
> configurable or fixed-1 or whatever. Userspace doesn't find out which bits these
> are until it does the KVM_TDX_GET_CPUID, at which point it finds out the
> "support" in a heavy handed way. So I think userspace does learn everything it
> needs already. And as long we don't have new fixed-1 bits, we will avoid KVM
> being forced to support things too early.

Do you mean after this series of before this series?

Before this series, i.e. with current KVM, KVM_TDX_GET_CPUID can tell userspace
the "support" bit for a given TD, but some of the "support" bits might not be
supported by KVM. For example, current userspace can set RDT_A and RDT_M, and
they will be reported as 1 on KVM_TDX_GET_CPUID. However, KVM doesn't support them.

After this series, KVM will not report such bits like RDT_A and RDT_M any more,
and userspace will no longer be able to set them for a TD neither.
