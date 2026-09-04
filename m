Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CFF381EA1;
	Fri,  4 Sep 2026 02:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788489674; cv=none; b=pnZriZDhIXugXll/C3vHUOEFEb9ttA7TuAeu8jkbDnmbcka/MyyB07FANgGNyWHBmno1L4Lpk0oRFqpbnt+PQv8ftkHb9EAqhGKs5gGSVHl1x0n+G0p4xeYEfNmIUhfpZK155ccMFJkG72zi3IilSi1G/PncMBM3a0tBkQEBVFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788489674; c=relaxed/simple;
	bh=TmIrIvQ2clUl5WKmO18n431fkAfFjBFxToapjlcrHbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cdyi0W+sUmWVg3UGu2J8dKDHY9mEj0Tv16fx/jA1bisKYObbgtYN0NGlvqRR+AMTlE7Y/aNZUaEhIPauHu3HQvxjJwsnY0QedcBscnIJoINFTl7pIzQxABb7S5FfnOPjfCo+eWt+jOzam9+mDd2OPXrvloV96uqmruIAQGg7o80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F9NEHyND; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9NEHyND"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788489673; x=1820025673;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TmIrIvQ2clUl5WKmO18n431fkAfFjBFxToapjlcrHbY=;
  b=F9NEHyND9/+HNs+qASPvIhgImyDGKILmB0XnRVYUd8QDFJ5CMb6bxS2V
   Lw1u7L8BU3yld/dzv0UWfJUbE4vl9T7Q7lxDC704Di/k8SnjZ8WstcI4o
   tgYetVqeTAmBSU1jveE94u67baQUFG7z0s03Mo/pOMV7vbxKF5+F/3Z+v
   xHEZNiifWKehgisE949WIjs3MljSN5mJptZM0nDGZsFZbfMxrmXmC1Eu0
   Mx+7ognFHMf8CMkcBwBtof1pM7WPoHF7gSMLdp6T95NGmXH+TDDoYjE7A
   M8NgtYFqxQnDFoBk83sPwH4XZR2FzHy2SoDuQxJ7KG821hqiV0iwyJbcy
   w==;
X-CSE-ConnectionGUID: 7gnkelvySSi2zjxTisWSEA==
X-CSE-MsgGUID: p4+f8xTjSG+uybr9IOHPUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="106507123"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="106507123"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:41:12 -0700
X-CSE-ConnectionGUID: OLFAZstxTkqxOXRnYNJCxg==
X-CSE-MsgGUID: sQ9oKXBiQkufLyokHW72NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="270434856"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:41:09 -0700
Message-ID: <a0ad4a9b-64ad-42d6-837b-85c3169b6b92@linux.intel.com>
Date: Fri, 4 Sep 2026 10:41:08 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] KVM: VMX: Rename posted interrupt prefixes from
 "vmx" to "vt"
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Kai Huang <kai.huang@intel.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Yan Zhao <yan.y.zhao@intel.com>
References: <20260904010353.3175819-1-seanjc@google.com>
 <20260904010353.3175819-5-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260904010353.3175819-5-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/2026 9:03 AM, Sean Christopherson wrote:
> Rename all common posted interrupt APIs that use a "vmx" prefix to instead
> use a "vt" prefix to capture that they are used for both VMX and TDX vCPUs.
> 
> No functional change intended.
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Tested-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
