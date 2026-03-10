Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA4E315D40;
	Tue, 10 Mar 2026 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169118; cv=none; b=NUsWAqS/aZQSt/fgOWBJheDw2uKfqxV/Io5JGyGqEVoq5d5kps0sxtz+jkjFmV/FBgnqv52LebtCSKguAbvnng+hWOJqoG49xaVk++Q/cXeHqbB04Zl5qypYT++QCKIhxwP1C4trv6nfF0yy/oz2oRiqwTuTD5wUu26fkMCMVlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169118; c=relaxed/simple;
	bh=81CV99lNlV4J5277gW3fDZjdxnK5AWBgeJX1oceDRck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpucFyfoP+G6of+p5CzEcbKevVbAWLeuDr0GIzKhEvjDr6GMuMMWp8hQDOGNkOlXw/ELbb9dfXFbdwGofuyUOOsCFfWmBTlYy2/iSsAu8DmHzSWoCLUqxMhfoSJmWj6UymUKFn5KdAeV06xwGLNIHAFRH74LM6Tui/Blc+VNgxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FkN0XsAs; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FkN0XsAs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773169115; x=1804705115;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=81CV99lNlV4J5277gW3fDZjdxnK5AWBgeJX1oceDRck=;
  b=FkN0XsAsM7TPb5U+j+HsB7D+eCrj4aQ6CMEy7ZHDT6eAHKyrcLpt+kza
   MsOAbaHBIYWC2Clf7lNnbNAknMp83G3+YPgSFOklPOvOMAME+kl63fccG
   F+DOqNEzKr3xxu4nBuC5XWVocBR2Cmp3EyTObTNcF41SOuMIAHRRfSN+P
   5cIe+KVJ4zc+5O8RhrMzF8giSIC/HiQp4sUu4SQhaIsszOrWfipClIKr0
   NLNiJ56OO/R19bLrJ7E60V5wVbFIfn0Mn5w8PD9zZ2uFBW/rEXLfUn7EV
   O3meu9f6RqFgRKvWvzsAfMVIozNCMLYLUoWiOlSzmpibV0/e35qQ24AIu
   g==;
X-CSE-ConnectionGUID: xuSbJAJmRcuRQVpaPzuU3Q==
X-CSE-MsgGUID: 7FxZkWB4QzyLFVzTDgl18Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="91612435"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="91612435"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 11:58:34 -0700
X-CSE-ConnectionGUID: 25foagyRT22nwTHS2Epupw==
X-CSE-MsgGUID: uMwr1lC9Q4KVq/pQOhbdlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="224393587"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 11:58:33 -0700
Message-ID: <1d06d750-f846-49a3-8555-d315b0e2cabd@linux.intel.com>
Date: Tue, 10 Mar 2026 11:58:34 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] virt: tdx-guest: Optimize the get-quote polling
 interval time
To: "Miao, Jun" <jun.miao@intel.com>, "kas@kernel.org" <kas@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260211085801.4036464-1-jun.miao@intel.com>
 <20260211085801.4036464-2-jun.miao@intel.com>
 <1cc137df-0940-4eb4-b7c3-2e5e8948d9f5@linux.intel.com>
 <PH7PR11MB8455A677E5BB797F9074E1EC9A76A@PH7PR11MB8455.namprd11.prod.outlook.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <PH7PR11MB8455A677E5BB797F9074E1EC9A76A@PH7PR11MB8455.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jun,

On 2/21/2026 6:17 PM, Miao, Jun wrote:
>> On 2/11/2026 12:58 AM, Jun Miao wrote:
>>> The TD guest sends TDREPORT to the TD Quoting Enclave via a vsock or a
>>> tdvmcall. In general, vsock is indeed much faster than tdvmcall, and
>>> Quote requests usually take a few millisecond to complete rather than
>>> seconds based on actual measurements.
>>>
>>> The following get quote time via tdvmcall were obtained on the GNR:
>>>
>>> | msleep_interruptible(time)     | 1s       | 5ms      | 1ms        |
>>> | ------------------------------ | -------- | -------- | ---------- |
>>> | Duration                       | 1.004 s  | 1.005 s  | 1.036 s    |
>>> | Total(Get Quote)               | 167      | 142      | 167        |
>>> | Success:                       | 167      | 142      | 167        |
>>> | Failure:                       | 0        | 0        | 0          |
>>> | Avg total / 1s                 | 0.97     | 141.31   | 166.35     |
>>> | Avg success / 1s               | 0.97     | 141.31   | 166.35     |
>>> | Avg total / 1s / thread        | 0.97     | 141.31   | 166.35     |
>>> | Avg success / 1s / thread      | 0.97     | 141.31   | 166.35     |
>>> | Min elapsed_time               | 1025.95ms| 6.85 ms  | 2.99 ms    |
>>> | Max elapsed_time               | 1025.95ms| 10.93 ms | 10.76 ms   |
>>>
>>
>> Thanks for sharing the data!
>>
>>> According to trace analysis, the typical execution tdvmcall get the
>>> quote time is 4 ms. Therefore, 5 ms is a reasonable balance between
>>> performance efficiency and CPU overhead.
>>
>> Since the average is 4 ms, why choose 5ms?
>>
>>>
>>> And compared to the previous throughput of one request per second, the
>>> current 5ms can get 142 requests per second delivers a 142×
>>> performance improvement, which is critical for high-frequency use
>>> cases without vsock.
>>
>> Is this addressing a real customer issue or a theoretical improvement?
> 
> Hi Kuppuswamy,
> 
> From the customer issue, the more detail "Test Report"
> [PATCH 0/1] [Test Report] get qutoe time via tdvmcall
> [Background]
> Currently, many mobile device vendors (such as OPPO and Xiaomi) use TDVM for security management.
> Each mobile terminal must perform remote attestation before it can access the TDVM confidential container.
> As a result, there are a large number of remote attestation get-quote requests, especially in cases where vsock 
> is not configured or misconfigured and cannot be used.
> 

Thanks for the details.

Since it's a real issue, I'm fine with updating the polling interval to 5ms. 
Given that deployed QEs respond fast, we should also reduce the maximum wait 
time to 2 seconds (from 30 seconds) to fail faster on errors.

You can use read_poll_timeout() from <linux/iopoll.h> to simplify the 
timeout handling instead of manual loop counters.

That said, polling with fixed intervals doesn't scale well since QE response 
times vary by implementation. The proper long-term solution is still an 
interrupt-based approach to eliminate the polling overhead entirely.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

