Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DA6449988;
	Thu,  3 Sep 2026 08:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423165; cv=none; b=FDf9VWwPFBZEpt/eQlaXKvtKFtgNUo1bg1JETsexf7B7D1R1qjdcGl8YsiIM+uk47+1JBShnOMewVhBrhA43itzLX5/YF/MaY/c0yFgy3CLKugwzh4j72m17izINE/JF4+36ttYuZsC6w6irf7BNojp1MhVfE2ALPdgaysgtyFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423165; c=relaxed/simple;
	bh=6w4bfji6hAGZea5dXhSgXU5mFR56zgAIYb4H+KRrPzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZOtfwRvcgtTnOeeZYvfGTQOtGHJILxwW+EUZgepvCa0EOdHi50Ui3MSJDk2iep0LIam/A5uJFGr9mEW5E+EyvZO59zXgVMo7ePJVuH8VMNnQ27DgZwJxWrZkq3Clj67Rre66fCpU4Qw2VrlExupgDBtyUSy+cAKbRChujzYYBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpIYV9AE; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpIYV9AE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788423163; x=1819959163;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6w4bfji6hAGZea5dXhSgXU5mFR56zgAIYb4H+KRrPzU=;
  b=FpIYV9AEQcUhrKPbId7XqRNkm1BwG+/EJMo+vYVdLDQxJkxSP3+RKei+
   1V9z65vy++ZJ2l/nyk2eCKG/24yrYk82eivTl6NnZW1JPygQUWN0Y5kVt
   hTwMjBOaS20f9G0TF8uim+vZPEhMWiEY8zql2SJCDGleEzEs+7oLSdryR
   CjERvROhNKgKN8Y6UZgM7uZd+Zr27YOHuyNZ/R4kUMj/LyFn7xDrYjOHs
   MpmLBeQiHc76+CpUC4V097mBR+3rNidZlGOm2C3+HkVyiXlFb1uKLmrWH
   ixz4vOnW4PO8mL56lUXFU6aLui51uSyzeuZbur1l2RJDFd6n5K5osKWXD
   g==;
X-CSE-ConnectionGUID: yX4AVdEAToqhLstZ6eODAQ==
X-CSE-MsgGUID: 2ThAdPDgS5WxuNYpXN88NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="106416137"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="106416137"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 01:12:43 -0700
X-CSE-ConnectionGUID: /u1yE0FgQGueLdY6JsPdsA==
X-CSE-MsgGUID: eSW4BurGRs2Ih0+FrZymiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="307852873"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 01:12:40 -0700
Message-ID: <d04fee8f-6742-469c-9dfa-6afbc44129a6@linux.intel.com>
Date: Thu, 3 Sep 2026 16:12:37 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] KVM: TDX: Report CORE_CAPABILITIES as configurable
To: Kishen Maloor <kishen.maloor@intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com,
 andrew.cooper3@citrix.com, nik.borisov@suse.com, kas@kernel.org,
 rick.p.edgecombe@intel.com, xiaoyao.li@intel.com, chao.gao@intel.com
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-3-binbin.wu@linux.intel.com>
 <73beeef9-3ecf-49fc-87e3-6fa30f8f56d3@intel.com>
 <d47c8cc6-242b-4ebf-89f2-0909abdaadd5@linux.intel.com>
 <0c2881c6-3352-486d-be59-e6350fda9ad7@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <0c2881c6-3352-486d-be59-e6350fda9ad7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/2026 2:10 PM, Kishen Maloor wrote:
> On 9/2/26 7:22 PM, Binbin Wu wrote:
>> On 9/3/2026 1:43 AM, Kishen Maloor wrote:
>>> On 8/26/26 8:18 PM, Binbin Wu wrote:
>> ...
>>
>> Actually this is the #VE reduction on fixed-1 bit, which changes a previous fixed-1
>> bit to directly configurable.
>> There are several cases of this category, i.e. MCA/MCE/MTRR/CORE_CAPABILITIES.
>> However, CORE_CAPABILITIES is the only case that KVM doesn't support for non-TDX
>> VMs
>> I will add these info to the change log.
> 
> 
> The cover letter highlights the deprecation case, but it sounds like
> you hit this now due to #VE reduction. Is further #VE reduction expected?
> If this is altogether rare, then yeah, added measures aren't necessary.

No new #VE reductions are expected.

