Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8063A31716D;
	Tue, 16 Jun 2026 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593104; cv=none; b=grmwkbnzammSced0XIb+hPfsrnAH8uya+1nGz9pNL9JxTU02BFdYPSNWDQK0xILln6qR0A237B9VCDOeWqy/9LGzDnPsKzgdGZmqJsD/pWb+is7QBMgFCm0gk6mtmiLfiI6ys+wurk/YkpLFzhl9md4JChkv2IdRHhjNBEwh+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593104; c=relaxed/simple;
	bh=fyv+pH0x71YVZXGQNKkzhJlqsSmxyeP9DdV6TpxS+sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWw1R7PAYwkqP0OUjtImXygU9F0aDk+jguzeCpNpP41xIW4zIgkE9oQaMB+fhcFW7hQD1GCNxwNyzWRV5NQ9PMlcYyORAEM+Tp1IpXNw8ZZAjvQ2sFToo4Nlju8s71JRzjlzgzTPd4aKnzsvlnSa9BIkQCOpvtmScII/32OHsSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJ3jJZ+X; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJ3jJZ+X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781593103; x=1813129103;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fyv+pH0x71YVZXGQNKkzhJlqsSmxyeP9DdV6TpxS+sc=;
  b=OJ3jJZ+XhXgiTm/GLOMgWjDpQ4fIw4XBVQoZRXqwFaugB6UC0R5/83Yl
   2rNoymp9o+FwdIDM/A0N958A91x8Aeuu8juwk2vgXq1oSMA6bnuPTHdvD
   3YuMJYpH0WfS8/9LvCmgMVwmTaZeh0GeSV0lnf/OhFFHjBsSYp0x14zKR
   f1Bn6iJTN4hCuTF8h3b20s/O4KZ521zXQzJiJpY6NvO7/Rw0HI9wtuGD+
   gYoDj3xSAkijpBtxtmXsVTEcsgNu6MQkH9gqm55ftKaDgWIwFAj45rknB
   nyykfPHeVdFdUNZohOuP/ciGk+/NmB/9Mm+NZpUqn5lpyl9rdJvLX6I0I
   w==;
X-CSE-ConnectionGUID: wyVuinIYSISsxjKFW+FR+w==
X-CSE-MsgGUID: 2o2LqQEeQryBdmCg3nEYew==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86189008"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="86189008"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 23:58:22 -0700
X-CSE-ConnectionGUID: WvHKw9nhT0mEovUaDM23mQ==
X-CSE-MsgGUID: sM5c6+DcQeW1z6R7zfZo9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="271405460"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 23:58:20 -0700
Message-ID: <9bf44206-74c1-441c-84ef-a30638cefda5@linux.intel.com>
Date: Tue, 16 Jun 2026 14:58:18 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 25/30] KVM: x86: Move kvm_pv_send_ipi() declaration
 from kvm_host.h => lapic.h
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-26-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-26-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Move the declaration of kvm_pv_send_ipi() into lapic.h, as its
> implementation is provided by lapic.c (sending PV IPIs relies on the
> optimized APIC map provided by the in-kernel local APIC), and it's only
> used by KVM x86 code.
> 
> No functional change intended.
> 
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

