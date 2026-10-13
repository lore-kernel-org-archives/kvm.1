Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4E13C3443;
	Tue, 13 Oct 2026 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886723; cv=none; b=XWY6bT3nPDgRaubJTAT+iuRFjJoli/h52jfECS+6ZPN+xGubikNtlvOt5Z2Ar3ltDVACVnslCkB8UAdcpeahM5JFzWFG9+khPNl2hWf7Czcp3mv6oWHgowdIODBRcJ3jH06jZmK9rpTe4DxgNLSg+t2VvkVO5hMpXwdzm9g0EKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886723; c=relaxed/simple;
	bh=lKt1qElPyYS2iInFY1JoDCNqs5vMC6nGwRBDANiHges=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRMTj8Sg+F0As5i5BW1GKuqprxdHKOaj8pmncB1vFhiMgZR+R1j2/SFNKCr8fgy2MSLIMfnDV/ADcFmNPT/W+JwKMDmFZdNG+gWPZJ4Z99Br4LwQSkfLHB7mPl7H8ZqoGEnlt/ssWlMq0QrvQrEU3uIbhix3M/564+MviZvMoiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S1JfAlgf; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1JfAlgf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791886722; x=1823422722;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lKt1qElPyYS2iInFY1JoDCNqs5vMC6nGwRBDANiHges=;
  b=S1JfAlgfl+pZ/0I+rq0oK1skMB6nrajLPpy9BdAMQuUqfCcr3lIemMNq
   XoQhCcOz1pUJXmi3VLj2niYmCGaY2NP5SyFsnQ1yXQlWszSue26/wZa1t
   Y0Rm5ofW5pPRPGE8+l59SyjSBANh0Qw2fhEmCGoPL9TeMdeyZS4astLRx
   acKDCUgSOZWue+Wa9TdpMaeJCBrC8ZoPl0+FgEbBeIpHxAr8nWKxRJ6sM
   9lqCZRz3S7b3XKRVkb1VnQy9XYtTHi0pUGQoZMln8rwBM6q5dm74UfXmR
   j5eAhJncvSqKuHDAdKisW6z6Jwk2N7dyXMYLMaq0bLK9PWj1GUG4F3jcx
   g==;
X-CSE-ConnectionGUID: MED74EPmTMepdh7y6Lx53A==
X-CSE-MsgGUID: 2SMLjqrGTyaV+ior+S0xig==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="617018"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="617018"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 03:18:41 -0700
X-CSE-ConnectionGUID: DEY0xYCFTUiLwKHN8s/pKA==
X-CSE-MsgGUID: 3D02l4zsQ8aQNraV1GeqZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1574262"
Received: from unknown (HELO [10.238.2.98]) ([10.238.2.98])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 03:18:38 -0700
Message-ID: <d87f51ac-d485-4b99-a573-d0c9fcf2058a@linux.intel.com>
Date: Tue, 13 Oct 2026 18:18:35 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] x86/virt/tdx: Remove tdx_global_metadata.c
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, yilun.xu@linux.intel.com,
 tony.lindgren@linux.intel.com, rick.p.edgecombe@intel.com,
 nik.borisov@suse.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>
References: <20261012094754.27702-1-chao.gao@intel.com>
 <20261012094754.27702-9-chao.gao@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20261012094754.27702-9-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/2026 5:47 PM, Chao Gao wrote:
> tdx_global_metadata.c held the script-generated metadata readers,
> deliberately kept in their own file so that generated code stayed separate
> from hand-written code. It cannot be compiled on its own because it lacks
> the low-level SEAMCALL wrappers, so tdx.c #includes it directly.
> 
> Including one C file into another is unusual, and now that the readers are
> maintained by hand there is nothing left to isolate. get_tdx_sys_info() is
> the only function still in the file.
> 
> Move get_tdx_sys_info() verbatim into tdx.c and delete
> tdx_global_metadata.c along with its #include.
> 
> AI was used under supervision to review code and workshop logs.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

