Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D71519E819;
	Tue, 16 Jun 2026 02:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781576143; cv=none; b=uAm7wmkgUuOzAWVRAts9lDbOpFVLB0V77u0cntpMoz9xT+ZqMlCe1JNlDQhmzZM47ZAPjG3qMCvq+2NFL2HfSPgPqpsXFz4OU5kOCKls/wAjnBBKbVnT0ebyITt8maE4kPYu87aVZCTxeQCs7Y1dBfJKQD0IHONDQGG/hIRQKpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781576143; c=relaxed/simple;
	bh=Z2xwgJoIzgzJiwLVACamRHzG95+mc0vlUvTPzGaYKqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H99TafcH878KKJIRch7BfFa1jUB9OBPJjbDmQeSRmHWucNWN39wTQd3KTQEfVMck72XeZfG8N6zdo0ZkjxfePLpzkoKi6v8mg/fv/Jg/jacAyWI3op8ccTSyALfrKT5D91BCyVNB4TOZVMYEOv8VXbpfyZubyddIMqZ1nGuV/WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AcOUZ+Yc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AcOUZ+Yc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781576142; x=1813112142;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z2xwgJoIzgzJiwLVACamRHzG95+mc0vlUvTPzGaYKqo=;
  b=AcOUZ+YciLnebMK1FLKhEC1jpHPiLhRABTdx2h4ZBtA0jhz4AGPgm02D
   myZ+1YxJpNJhGdGuZ0lugdytDSEohWglN2YV2c+DcLkJahZrriDWRHdIo
   e5KyjaxKD5SJXXoXPnwDp3dODQFYSg3zchwEAnErNppuJQvOP14exsJMo
   dp+IsX6fJ9qTWTarW89DysA2Ccsb4LL+gSSuzHwDQafBW6+azJ3KcDwkc
   feBgeigzOOzQFfKiGriE6bFW6h/zUa/vSXLZfvLmFHDeh7S7HbgZqJ7W5
   MVjh3MUyTaDgKLMeXIFeNG4Nn8cc4DGhohoUwFqSnFVIToq4XdftFSJmo
   w==;
X-CSE-ConnectionGUID: lNt6V214QFS6TX4QDwLGew==
X-CSE-MsgGUID: MfMs9kXmTkK/IoxNxBD5Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="93821369"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="93821369"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 19:15:41 -0700
X-CSE-ConnectionGUID: KE1GcortSU6kkb3Bbgl8Qg==
X-CSE-MsgGUID: crzmSml2Sy6v7/4g4D7D7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="252754210"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 19:15:39 -0700
Message-ID: <2fc24874-cc67-43c8-a973-420d73e0185c@linux.intel.com>
Date: Tue, 16 Jun 2026 10:15:37 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/30] KVM: x86: Move register helper declarations from
 kvm_host.h => regs.h
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-16-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-16-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Relocate declarations of Control/Debug Register, EFLAGS and RIP helpers
> from x86's kvm_host.h to regs.h, to continue trimming down kvm_host.h.
> 
> No functional change intended.
> 
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

