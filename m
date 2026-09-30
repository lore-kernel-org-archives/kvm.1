Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566AA367B97;
	Wed, 30 Sep 2026 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790737454; cv=none; b=khfBH6s0IJoKNN4RIIUrjYEggUJlyi74oIbSfvcdH0bJj2Ydy7QbP/GIjYCvCDpdhcCPpyiw2TP+8P7S4//OtUBIb6D+wYAmbq6vuhnoUiQExyXMJeVa1o6z294SZvAB0ZIXYeW1X4uPqrk1lAt1J6MPbTzi5EPlhSIQZl9/v9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790737454; c=relaxed/simple;
	bh=te9Mu7Sj/GWTev+Vc29U0Kei4dcN+cA9jeGvoVSxMMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/yKdrc7hYYVHECpCVvZR5MWNfsoZ1ODJ0VuydNhdWRaxaXQ44y4bksXBtJA+HhALGWe2dvECxdafbEibZHt664SZpLn0JbufUSE+zYYQAbOpHTQltATR3Ia/e57a5YZkKrQySe9+HCVNu+fUVgkC6PEMOAhZk9C2BiJG2V++YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buDPC0Ai; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buDPC0Ai"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790737452; x=1822273452;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=te9Mu7Sj/GWTev+Vc29U0Kei4dcN+cA9jeGvoVSxMMU=;
  b=buDPC0Ais6pdT5QMcVUmyRPVJZ4fvJhBs8Kh4+XNaRBGRvVRqXOLz4+H
   gAKQXOTzt4NzR7gDWQ09HwcPN0OM+uE6wmFpFMkb5eh6pEdPhYZE+3KZK
   8gvgjzAVFW3MZvtsyoKh+SwKEqou3Lm80/e6d/RtbhWWKSC2dwTKs05HM
   9wbReZdMujF42ygRJ/MUbot6/9nfaFELILjG70XQRgqFF7c7dw9YQGPsf
   Ufc8PeKY76Z2Y4+F+HuPOOkqaFh3b5iOu9yBMlgru6J4jYi/Yh4o5s3lG
   aU2s2rcKzYgdcz+ASK9jE4EBK/qMea0OwuEFfvYQ7d7xbKaYLqsTUmHG2
   w==;
X-CSE-ConnectionGUID: pujqNk3NTVWsjVvuv4m7Rg==
X-CSE-MsgGUID: zUjAW3xNTtSEb9Ny1MMsuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90368240"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="90368240"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 20:04:12 -0700
X-CSE-ConnectionGUID: 81IinBxNTSiXVsCbmUcVYg==
X-CSE-MsgGUID: RkG95wYOQVige/1ouvrdjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="275113400"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 20:04:08 -0700
Message-ID: <01408d38-f9cc-458f-98d6-a591c342b336@linux.intel.com>
Date: Wed, 30 Sep 2026 11:04:06 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] KVM: x86: Add a helper to prepare vcpu->run for a
 SHUTDOWN exit to userspace
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 James Houghton <jthoughton@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Ackerley Tng <ackerleytng@google.com>,
 Vishal Annapurve <vannapurve@google.com>,
 Sashiko Bot <sashiko-bot@kernel.org>
References: <20260930001127.3170009-1-seanjc@google.com>
 <20260930001127.3170009-2-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260930001127.3170009-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/30/2026 8:11 AM, Sean Christopherson wrote:
> Add kvm_prepare_shutdown_exit() to dedup the paths that exit to userspace
> with KVM_EXIT_SHUTDOWN, all of which happen to be x86 (presumably other
> architectures use KVM_EXIT_SYSTEM_EVENT?).
> 
> Note, this adds a clearing of mmio_needed for SVM's shutdown_interception().
> Not clearing mmio_needed in that case is all but guaranteed to be benign;
> KVM should never enter the guest with outstanding emulated MMIO operations
> (the equivalent VMX and TDX paths likely copy+pasted the code from
> KVM_REQ_TRIPLE_FAULT, which does need to clear mmio_needed as KVM can
> synthesize a triple fault shutdown in the middle of instruction emulation).
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>


