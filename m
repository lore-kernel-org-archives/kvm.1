Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55CD379C59;
	Tue, 16 Jun 2026 06:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592034; cv=none; b=hVU6PYgQMrzAn5je9lsQJ+EciPRef7RrScyVUcr3Mk+4kuWLhXNo5zf0DF1ksaeO3zVz8v+TiW/eSjewH5SRivDPjA9x+ZZb9UZlBSB0r90akSGQGqH5JWpF5bj7q8OnB2mO1SKgXl4V9P+loDWH0DxY29GJTOAJt/Nn23Qpyzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592034; c=relaxed/simple;
	bh=9AcryBqi0qYsaJBBfkw4KhooHXhnAI2cJrHr/4q5yEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FcOsSnGAoasOpAcfKIjAWP4CksLXUTglZrRj3AScfJFg8zFAuTMwpFbWssZOyswbGaestt5Bf6j/rdNE08s5k+MAYz4oMGuC2z2cnYre2MAl8DlQNpNNGhWEXGllpbjfx8V3JMCB55DV5/vK/FtAf0MtylYXal4aAJxPT88DGGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVFZGBXM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVFZGBXM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781592033; x=1813128033;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9AcryBqi0qYsaJBBfkw4KhooHXhnAI2cJrHr/4q5yEc=;
  b=cVFZGBXMN+41SYV9QALVh+lBuDzo12xISR1BPqUEbX4mIHgBGJ/NCs2+
   fpVXpcgxbl6oQ5Ily0Ujz0P0R6uB+IUPYda/2w3LwtzJ1tJ7pTubGI00A
   i7Ncyk1w1FsrH3FruMjukiA1pJuDeVAWTTPKBbIIYvB/DzDPDJ/VUSAys
   eOy5Ghg5U7Fw+3jcn8TqrHueM6P+OEiRxqcVxVelDetGJ0KaFDALv0xRP
   MH/vyOL9qyYIKGSjZK+vyifnxBEBtknkmE//3ykSZMLr9w+MwaXzFi8zC
   S+VxGnyq4AVb2fh7/36MT25fYtSupf+93UY5uIoAVN1KKiL9g6LJjMWHK
   g==;
X-CSE-ConnectionGUID: EAEw6eVbQ8y7rFF4BYSOaQ==
X-CSE-MsgGUID: I9c+UBoTQqC7+yBvQMswHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82090074"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="82090074"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 23:40:33 -0700
X-CSE-ConnectionGUID: T15XQ2DIR3ee4hMviw9Ivw==
X-CSE-MsgGUID: TxuIIvGrQYuzyV8viHIfAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="251981254"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 23:40:31 -0700
Message-ID: <2a71b025-c76e-459e-9865-fe6b645dd437@linux.intel.com>
Date: Tue, 16 Jun 2026 14:40:28 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/30] KVM: x86: Move LLDT assembly wrappers into VMX
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-22-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-22-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Move kvm_{load,read}_ldt() into vmx.c, as vmx_{load,store}_ldt(), as they
> are exclusively used by VMX to save/restore host state, and have no
> business being globally visible.
> 
> Ideally, KVM-specific helpers wouldn't exist at all, as they are nothing
> more than assembly wrappers for SLDT and LLDT, i.e. should be provided by
> the kernel, not by KVM.  Punt that cleanup to the future, as
> arch/x86/include/asm/desc.h _does_ provide helpers, but load_ldt() is only
> available for CONFIG_PARAVIRT_XXL=n builds, and both {load,store}_ldt()
> unnecessarily constrain the operands to memory.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

