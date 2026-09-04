Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837C229B781;
	Fri,  4 Sep 2026 03:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490862; cv=none; b=qV6aSNxz+Et1nNc5hhmei/9BPQlKbsC1sAWIK7hIkWXopFZlJUzKYPQcvZKRtsZll790ZtFvRHP+gyc6+AUtoGn6ctRY+rFa7hegRdIOI0u+9SJNnjFI8Q/M09BqFByOj7aXeD+BZdZeY6s7REeoqede8wFvv5mk4ERfvkwwUjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490862; c=relaxed/simple;
	bh=Y4wQ8Wn+gn9c4agb/hKRqOV+AwGG0fXfgBPp4Bk8tjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDy82zIGfBUbiez7boYFkBXD57DKOzACH7Bj9Lh281As9BxWZuwTNEgdAhGGoJeDgxUbuwQdUGmamBwC+CYx3Bh8XA/FcxnYyHqoNO00g8M7eaebsevOtAPgEHl/lXx7ZBEXIkuglJLAUsQdfPCMHoqNyewet2Y2rfvdj2xryig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJzp/zKI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJzp/zKI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788490861; x=1820026861;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y4wQ8Wn+gn9c4agb/hKRqOV+AwGG0fXfgBPp4Bk8tjY=;
  b=EJzp/zKIccVoHadRWq2dw0tXhemTmpSPRMfjhmK05bIcSt3euSqwlxqI
   UN2YJ3ISSr5rJHX5Gl7kS7PYeuVKDIUMiiwHUOdS5DsjIxDHk9bWN546e
   EoXevpg1nVx+kEjw/8+Xi6VTvAVUpi01Yyh0190tbymESkO7yuNLajQ+v
   wxjGPPqz/JFwEPCA5zI1DSmSy/Z47NBbRCyvPaaOepwe/eWaO/H2HUECV
   2LBc9UlV4kIASKuPP9LZdIgX4xQSqCiXGQ994y6cJRPxIZScoZQtYhvSx
   Tmd8Fz/E/LFEYJSHIoGyNA8pUU4ooRK+IhRKCWg0HpHKusNOZAhVhWtwy
   Q==;
X-CSE-ConnectionGUID: +JahrDrkScaBHhZhpI0wEw==
X-CSE-MsgGUID: kRUcZDqeSoel6qP9LR6rSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="99318816"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="99318816"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 20:01:00 -0700
X-CSE-ConnectionGUID: PV1xzFIfRta1JZjjEWHXKA==
X-CSE-MsgGUID: z0nDE6DmQQOT97SEBpkXTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="266231293"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 20:00:57 -0700
Message-ID: <38d13237-71e8-4b82-8f21-7317fd27f50c@linux.intel.com>
Date: Fri, 4 Sep 2026 11:00:55 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] KVM: VMX: Rename common exit info getters prefixes
 from "vmx" to "vt"
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Kai Huang <kai.huang@intel.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Yan Zhao <yan.y.zhao@intel.com>
References: <20260904010353.3175819-1-seanjc@google.com>
 <20260904010353.3175819-9-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260904010353.3175819-9-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/2026 9:03 AM, Sean Christopherson wrote:
> Rename all common prefixes for the APIs that get exit information common to
> VMX and TDX from "vmx" to "vt" to capture that they are used for both VMX
> and TDX vCPUs.
> 
> No functional change intended.
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Tested-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
