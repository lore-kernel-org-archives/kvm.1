Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505660;
	b=2tNLCErxVXRQhF3D7uWMriVRWlc0sL7hDEXMA40sV/sfZQQXvuNUsQ2lA90iT2IVEeJy
	 EWfDKN+rUoooT5btLEq26zIiZKbQBT/v6Tg1tHmRYx95sVdsXOhwENB1Q49kH60Gg3LJo
	 /oSTrHbf1+hDnm99+OVUy1zy44tv82raV95Ahji+LohFUS8hPg1gl5FSSo2HpVEtgnfPm
	 thXIHjD9u30ypFkEuSQJs+vQYjxrn+meTQrP5jjny4XOKITGombEcCEbXKsJM/cCmsXwo
	 C1JBP9tjaTbgTxq0i4WMEvh/WL5b9a+Yvg3aZtiyvK7lYnb8LqlnY+Gzm32pr1h/hBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505660;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=KjRbeyRXk5bJOhswe1U9i7zg56tEqkEOemdqgbV7Zkw=;
	b=fA+dIgNBmwfkfXw04sT7462wt/2nKvE5oF1hrmPguPmBFBXJNukFdIm6gGpfRkRICstS
	 Folqg4m9rLEkFnFSBi70wV4tYM6D8Zo2JoYjUx3p+4dfQoqoSa1jmlZKd7y+KzF5KhE4p
	 x+DPvYFI9oCkokvKyYzV/NXDBsn/u8Ff2Kz6bulp4yFtR2uXJUVnsnPW7+U+hP+nbRq0j
	 lEiHTr2RZap7qcCHfFhRQI7f5mCbF87MhxDlEOiApgI3NI1pdHPUwFSrVgP+6GuBr4Cgq
	 62zErkytBqHXs9PP+4OCZC4YVD0yy5LjV6O110QAdlfP1y7pcWVgEjCchdEWZuvHBzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fGJnXgNv;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C674606A31C;
	Thu, 12 Nov 2026 17:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C674606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fGJnXgNv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794505659; x=1826041659;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eURjzySlnvsr7LWwcPduHPLyS2bRt1YK7k1xhKtV630=;
  b=fGJnXgNv6n1LG2uy/zEFMhsJdQCVFqajiaIHjGxpYzV3KwWwfPgLX6Te
   oQalcKYtyRNhaihZQU2Rfse2UhFTXoevzTsrilCIuUTTfqtC712YBCdMw
   Ahi5f68LtSHLnyKRHGevVZwAnkJ7FIy4VXMRIr/8LDFGWiq5SbWf+/OgX
   528RMwjO2QFJH6qFg8cjOeE/RfKnQPd6PaiItIXMDsuRm6HhkiLMXIwwa
   InF0WewXsXlARbMG0t72PqAt/eAcbaovEgsQqV8fUtLZcLLILgEInhrS+
   qpjYuRWxKTmNpi1ZTCl+wrlzRmIo3JzBl88q+k+T4Me4Kh7J70nohqbOI
   w==;
X-CSE-ConnectionGUID: DU0Cb3q7SVSFqqxEd8qM1g==
X-CSE-MsgGUID: HwDrKdqKRdujhIqiUr7XPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3222061"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3222061"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 09:47:38 -0800
X-CSE-ConnectionGUID: Duu2TAq1RHiHk/1SshfiCw==
X-CSE-MsgGUID: bXnn1gnXQQyHXnTvlVLjyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8581264"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 09:47:37 -0800
Message-ID: <f70b54de-7b25-4767-adea-d37dff6eda7b@intel.com>
Date: Thu, 12 Nov 2026 11:47:36 -0600
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/18] KVM: x86/pmu: Populate CPUID.0AH:ECX
 fixed-counter bitmap
To: Sean Christopherson <seanjc@google.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Yosry Ahmed <yosry@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20261106013927.166209-14-zide.chen@intel.com>
 <au491iiV7koeP0t6@google.com>
 <f20b59bb-a3c6-4129-ba61-5cec4d975601@intel.com>
 <f12bcb27-9c17-4b8c-b48c-c36a17e70ab6@linux.intel.com>
 <5f129d63-10c6-414b-86a9-a604e42038ce@intel.com>
 <51089074-1be0-47e3-8d53-732ca33f29a2@intel.com>
 <fceb4f61-621a-4d62-a648-a1cdd0de1671@linux.intel.com>
 <970e231b-c3ce-4159-ab27-ac371426500c@intel.com>
 <avSLss14zigMfUww@seanjc-mac.roam.internal>
 <3d4804e9-3e5a-447e-8a54-8fa5d1c28f5b@intel.com>
 <avXyxMgGzRBGbBN3@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <avXyxMgGzRBGbBN3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/12/2026 11:09 AM, Sean Christopherson wrote:
> On Wed, Nov 11, 2026, Zide Chen wrote:
>> On 11/11/2026 9:37 AM, Sean Christopherson wrote:
>>> On Tue, Nov 10, 2026, Zide Chen wrote:
>>>>>>> KVM's principle of "not policing guest CPUID" means KVM allows userspace
>>>>>>> to configure an arbitrary guest CPUID without rejecting the ioctl or
>>>>>>> mutating the vCPUID entries.
> 
> ...
> 
>>> Just because we *can* do something in KVM doesn't mean we *should* do that thing
>>> in KVM.    
>>
>> Got it.
>>
>>>>>> - Features that actually need host hardware support need to be checked
>>>>>> against both guest and host PMU capabilities.
>>>>>>
>>>>>> I'd propose something like this instead, leaving pmu->version unclamped:
>>>
>>> Why?  What real world use case is there for KVM actively supporting a PMU version
>>> "greater" than the underlying hardware?  E.g. emulating AnyThread deprecation is
>>> (presumably) easy, emulating *all* of v5 on a v3 host, not so much...
>>
>> Got it. I can think of a few discrepancies:
>>
>> For example, the guest is supposed to handle Freeze_LBRs_On_PMI (legacy
>> vs. streamlined) based on the guest PMU version. If KVM emulates the
>> legacy behavior, but a v4+ guest expects the streamlined one, it may
>> run into issues.
> 
> Well, yeah.  Because I'm saying KVM should *NOT* support running guests with a
> "greater" vPMU version than is present in underlying hardware.  That's nothing
> new; KVM rarely emulates features that don't exist in underlying hardare.
> 
> KVM doesn't generally enforce the virtual CPU model presented to the guest though,
> because (a) userspace can do all of the same checks KVM can, e.g. by validating
> its configuration against KVM_GET_SUPPORTED_CPUID, (b) adding that validation
> in KVM would require a ton of code and create all kinds of ABI issues, and (c)
> there are legitimate use cases for exposing a virtual CPU model that appears to
> be insane/nonsensical.

Thanks! That makes complete sense. I'll drop kvm_pmu_has_version() and
clamp pmu->version to kvm_pmu_cap.version in v4.

