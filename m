Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E796335E940;
	Tue, 16 Jun 2026 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599710; cv=none; b=lQoVxKUHdKvW75nYY9mW06p2yWhG33Xhx7G4HcAaeaJhli76MqHkB5lPNmqP5D6aKvOOXSb07K2Uq/Xviyh3M0Tjk1B8dYNsSml6Seb7YC4Qc8u4HMF1IvL+AfjUE3KNiPl9qTjkdZpf2983L8NATbBLzcUWOelSjjt9XeqTq74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599710; c=relaxed/simple;
	bh=fD4hD7zruXAOUH/DALUQnF9v4k8jJbm7lk14qtZUJks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9E6SFqqh4/O/b6mypZfUgKPOhdqhew17jJs6Z1ftpjvqYyfSQhsZa+mG2WNwwmOtNGmxLpgHkqR1y8+QBXNL5MXbzvtpYRxNYIBIP+0uMNL8iZALW7S9D7MH6jfyOP24NvPsMVX8UbNmyiTQIPKA0h+WJo73/GVn2mRFD0D0I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFaSoVl9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFaSoVl9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781599709; x=1813135709;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fD4hD7zruXAOUH/DALUQnF9v4k8jJbm7lk14qtZUJks=;
  b=FFaSoVl9rLi4rcArML/6fdKQ93gHjUgfX3s36SyIgY7CVXrinfQGUhyP
   4gHLV7c+0D7DIFjA4nOjrRCGb6U9FZJ3MODA6terYxActYuH9JGm6W0Jx
   ZZorHieVsxda1E6JslavdoqW5sgtW4L3MSh/k0oUs4pas/mtpjQAPkIMn
   uSZgIBQ584CFpk2RFHPVSbQ8VEA9FwnrWBISj17wgfa/C+BexlayKgqai
   FSrBuow8GMsE2cTUaGaof3PPZRstv6OIX1/mUoKnZYnuhxT/fT6AMhxQh
   PWWzkuzVUhU3Fda9KWGjuoUMEuxtoFZzZYz36pEJm2GB/mmGxQ7PO4Xov
   w==;
X-CSE-ConnectionGUID: c+oI4p38Q9CjEZrEZSgi7A==
X-CSE-MsgGUID: RA+jIUzGQPmLl4r2vP0IKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="92919620"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="92919620"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:48:28 -0700
X-CSE-ConnectionGUID: c+ooL/BtQme2C9NJuSoxvw==
X-CSE-MsgGUID: xj9EU0ZsQb2NcvJ6aAgMqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="243339874"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:48:26 -0700
Message-ID: <a81c873d-4522-4b4c-99d7-674cbea78ca3@linux.intel.com>
Date: Tue, 16 Jun 2026 16:48:24 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 29/30] KVM: x86/mmu: Move kvm_mmu_do_page_fault() from
 mmu_internal.h => mmu.c
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-30-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-30-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Move kvm_mmu_do_page_fault() into mmu.c, as there are no users outside of
> mmu.c, and the function typically isn't inlined by the compiler anyways.
> This will allow moving the EMULTYPE_xxx definitions into x86.h without
> having to include x86.h in mmu_internal.h, i.e. will help preserve the
> goal of making x86.h KVM x86's "top-level" include.
> 
> No functional change intended.
> 
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
