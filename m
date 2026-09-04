Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AC4392C29;
	Fri,  4 Sep 2026 02:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788489775; cv=none; b=kSiDLl751QJ6h1Q1sj8jBHF2TjKOs84HLWUc5UiMlDXBtrO0kla8tKFx6MNgcuLjCZK22OiZAjvaIwiPmI59N8Ey7Wvx5Z3q/9ZIHojmrr5JuztDtQoFrlaOQCDjM5pMhf8Ij1qSwm9sQ4ecIQgH0i86fBL/S3EQmQJqZT14xGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788489775; c=relaxed/simple;
	bh=VrQpdIBVssKB0dQ6AzZzdBno6BCOyz1cQUV8K+mD/xY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omRLEUGPGVFELFw2YfXzSP42rLpNcy+tM+ikQpOiq5B398rZuahKV/2QT9epW3HTQowj2pYCC3WfDDcRtNklsZIZi65tPRBhtlUF5b1q6LFdcY4f2GfuiZ+cziXoTpMivJATZqGHu1dkK3ypmV/LrtwuPqipAkSQeStDQat3Md4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QaJZjz+f; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QaJZjz+f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788489774; x=1820025774;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VrQpdIBVssKB0dQ6AzZzdBno6BCOyz1cQUV8K+mD/xY=;
  b=QaJZjz+fyjoIYubfESRsYEFGE8DZz8D4K93vpQ1Uktm8VB9xPAf2OTVu
   FI4j8ff2ak/WxlFXcl8zwkQA4PU9+fvS0byLGGny7LeqpVJbzDkg5wec5
   t9xicjCAOVBzblsclML1zEBQNuDUTuS6nDXo8QiFcEEIXSXHLo9jQd2G+
   NG71t844GOTgKsWM4lAAo43grQf/GDsfg+lkBt/hMdOj1/DX5+7EMI4DZ
   K35OE93LS2O45GXmCDJzqEpZ1NmBTs8x/tR3R0Klb/T+8xajbi8HIJI94
   dPdgK8fspo2hpCfVC8GhFn2t05JlF4hwKuLYM3Kdm1QRKjrRiCadrdov2
   Q==;
X-CSE-ConnectionGUID: 2q+/4in/SViku9LyQlh7ZA==
X-CSE-MsgGUID: q2xAe9I2SeGC6HuFEeqd8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="91499412"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="91499412"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:42:54 -0700
X-CSE-ConnectionGUID: 9JoiDv7cSb+PuJU3L4tPGw==
X-CSE-MsgGUID: kaPfOZjAT2mS4PkQgigXog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="268601157"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:42:51 -0700
Message-ID: <3a94a159-b8e1-4093-91b4-c28ac55c88cf@linux.intel.com>
Date: Fri, 4 Sep 2026 10:42:50 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] KVM: VMX: Rename EPT violation handler prefix from
 "vmx" to "vt"
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Kai Huang <kai.huang@intel.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Yan Zhao <yan.y.zhao@intel.com>
References: <20260904010353.3175819-1-seanjc@google.com>
 <20260904010353.3175819-6-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260904010353.3175819-6-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/2026 9:03 AM, Sean Christopherson wrote:
> Rename __vmx_handle_ept_violation() to __vt_handle_ept_violation to capture
> that it is shared between VMX and TDX.
> 
> No functional change intended.
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Tested-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
