Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD1B3C3C0E
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895197; cv=none; b=hzukAhM8BeRTCJysLGSFfPdlQ7IrX4FTpruEIrLy3thJmZ/O4hsN1kDYSftbjPi4h8cFjWA5wdreXHXmANiVrKc0w0mU3z8Xvn+wi7vCUt5RqfKR4aKAoJ+MIKOpqNMGBLP/Lq8MQgI/39AtBKOn21NWIrxERCpvb2ymZRCw0Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895197; c=relaxed/simple;
	bh=LtVNn8bx+voSusID796wWKrNBlX6Tm3AIGmQ0ZdJjkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OL6rSH66ANkoVfQN5bseWWW7HFbyVv32oM+OsMR3/exVtbjzHuREvN6F7zM1fze6R8hDGv2eziYHVuigEdjgtk6/wUWIAbm1jBOs6aeqPAX6xFA4KTk8OFKDXsSVvRlZDot8XbFUhyHpf5zwn2iyUTzg585iXY7VOMe+BtN1pmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kFdh4omb; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFdh4omb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779895196; x=1811431196;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LtVNn8bx+voSusID796wWKrNBlX6Tm3AIGmQ0ZdJjkc=;
  b=kFdh4ombAUlgpYbykp7inP/FcsDcZ9zkDlhCVLkvFs527AJkrOxxmlQ3
   qp2NI1L7MZ5ZI/KeMQEJlt7mQe44jO0t7BxlGhmEqZYbfkvC3etBDmYDF
   CFwLeaEZvs2XUvhBQFqT63GS96JXMWpYRUOYWEtDJE1QV06GmNToJsn4P
   /1T0Uclmg3qkYC9bXetTVSYnawo8AvAk2ggqk4aOOntf3WdCxsPUSwKBF
   hsFMYd/cPekMsZLOrJQji9yg0yAtVM5yC6adMLvixi5tNYtfobajJ+6dC
   G4pW83Vut45f2q99ngsGzTfwmEly+W0oqlenIwTC8x33BG3hTjVdcJRnw
   A==;
X-CSE-ConnectionGUID: vRLtb2SiTrGuL3uzayyXVA==
X-CSE-MsgGUID: PxORqICIR4Gs+NQ11AKRng==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="68257051"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="68257051"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:19:55 -0700
X-CSE-ConnectionGUID: 3RzNDKDwSCOXFsagFW5WPA==
X-CSE-MsgGUID: yte5GJARTty9Y2cDuiZb7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="247222440"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.18]) ([10.124.240.18])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:19:54 -0700
Message-ID: <d3cd9e60-3b4e-4df0-abd4-5677c30f20fc@intel.com>
Date: Wed, 27 May 2026 23:19:51 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 2/2] x86/vmx: (Re)Add a nVMX test to
 validate load/save of DEBUGCTL
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20260527151232.4058615-1-seanjc@google.com>
 <20260527151232.4058615-3-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260527151232.4058615-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/2026 11:12 PM, Sean Christopherson wrote:
> +	for (i = 1; i <= supported_bits; i++) {
> +		if ((i & supported_bits) != i)
> +			continue;
> +
> +		for (j = 1; j <= supported_bits; j++) {
> +			if ((j & supported_bits) != j)
> +				continue;
> +
> +			__vmx_debugctl_test(i, j);
> +		}
> +	}

What a clever idea!

A minor flaw: Both i and j should start from 0, since 0 is a valid value.

(I will go through the whole patch tomorrow.)
