Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71C6391E49;
	Tue, 16 Jun 2026 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781576394; cv=none; b=Xr4uDofm1T27Rs/a+I8HP0qEvAFYd6m+1QODzmaYfZJ6V5Z44CbEXmMKeAPgUtndzDaeiWxkqnilRwGr20Ci9H1ZBs5DX3kfIcNKoVMn2CgOQ5/y0777havXDM3Ox92kYjrUyvz1cRpdGOiJDOkxRn6VjcAXm+IrSkNn6wrhCig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781576394; c=relaxed/simple;
	bh=iWcSX2FGVZtrraKoIKa2o/gHbYiF2FOcmqvoMTGc60w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2+rlV28j6uPeF7QIGDL41TXGDOt4B75gO3yXuVVQ6ji4xrY2DE4Zn/vGaQGoyC9vQdKMlhsdcf+70jpEBkGSnKQ811MNKnSrfdATbIGlitHTPIp0NWCHyl8GY4QIY/QHK/mNk2WMvDjdpMrHm0kBvrdkneQ4Acc5uAkyo2uYlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2b94vva; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2b94vva"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781576393; x=1813112393;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iWcSX2FGVZtrraKoIKa2o/gHbYiF2FOcmqvoMTGc60w=;
  b=V2b94vva3TgCKjr8dPlENqJ321odjKJNN0JlGrJMSC288fZ//nv+ONCI
   VKXHtoj9WQKiIdwv6rxtjfqC3HHwMRr3R74KT24oN5P4+zyIcHRJzoyOd
   YQZgmi50akIOHidVPqlqib0zeCtyw+lPgJu8qUpNccd8CMRwpvDmFPFmy
   R+CS0+37u55iyoTfseiGF7diw38T2poxaBglVr3P+ThqnskKfiJy7NEmr
   hh2dFs5qi1DrqAP2/i7evlmuDOTgWyJvOPHlWxZxsaQAIMFqL4aM/jD+y
   A7x1wIMozzqG0KjvANrXKlRHmVuUdFP/I0ILyyYacR0WUrbgsTs8GHw2V
   g==;
X-CSE-ConnectionGUID: EK3VYGdeQaWJcHMLBuylwA==
X-CSE-MsgGUID: AaaaA0eaSouio6bnvpuU0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="93821591"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="93821591"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 19:19:52 -0700
X-CSE-ConnectionGUID: 4FhVQk2QRcmT4wgU69aLBA==
X-CSE-MsgGUID: yijpDknnSOKgJPThIe4EmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="252754775"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 19:19:50 -0700
Message-ID: <312748ca-1cf7-48e9-83f7-3471e758790b@linux.intel.com>
Date: Tue, 16 Jun 2026 10:19:47 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/30] KVM: x86: Move kvm_{g,s}et_segment() to inline
 helpers in regs.h
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-17-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-17-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Define kvm_{g,s}et_segment() as inline functions in regs.h, as they are
> literally one-line wrappers to invoke vendor code.
> 
> No functional change intended.
> 
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

