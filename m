Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104FC2F6596;
	Wed, 22 Jul 2026 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726480; cv=none; b=f6kP6dsfiG4ncgFHcTqghTUkMiHxxuKsl4CIpQfF2fPfhwLLE6sxv/NbK6n8yyMr242qn4GGXNF0GLoOMz6yZjgCqz+wM4tsEp3tQ49buNQ466Ebbl1bYYQJ+1kRf00ZzMBKX0CPa/H5F5tdyz87ww0INtItVjslAbWgIORvQxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726480; c=relaxed/simple;
	bh=4z6T7VvT75AOvFroyjHsOTgDhzLDj3O5IC7NlpWb58Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXQBvzqH5+4ehjCizlkMTX/xA0lYWSgN3zbkQPiTo3mY+4ZrXmnPqhab2xpkzssz9KMTRibPzUhj6b3bl9ljuQuZ3PTfYnXOxAq0CB15yJIJwWpMAuJgC2s25nfjTOd7bDS1MDFKib/8Y4Dof3gODpG4fFT8alsaPNhfy2gPmT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=avl2nUTq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avl2nUTq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784726478; x=1816262478;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4z6T7VvT75AOvFroyjHsOTgDhzLDj3O5IC7NlpWb58Q=;
  b=avl2nUTq6+gg/yx2umxHM1Q0jMVv8DOcdWakC6i4zZdPM1XgD8VDoxxe
   ShFziK1HAyJhUcxfGdNfqon3TITmcjfa2mKqBNbO6hp4DgUitckx+FFwO
   lv9xGMMDGbW4hAME3KITwjYU3v/8VQBTDCa9mbjbIRYJ5TEspBqp45D8e
   9zxij9lxZSGQUdpmrr9HCIr6SGmuhgnVI6B13buhT9pINTxEyx+0sVvUw
   VTMM22hbXTQr/joOSFhUPPIza2UvOE33lJafy+/5+3ycU/bv0NSbKUlYd
   qaZg/kpSpsBN/gpNojvLxbRkUxhPQs1q0W4Y74GVoAjH35e6maz+ENR/+
   Q==;
X-CSE-ConnectionGUID: ThYeGYSFTRanr0GlCEUcEw==
X-CSE-MsgGUID: uc/G4Am7TLiFQpoAQdbh2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="95719646"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="95719646"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 06:21:17 -0700
X-CSE-ConnectionGUID: q5Ls1xuRS+y8gOVqlmp24Q==
X-CSE-MsgGUID: 41/u9uPTQPKMTB3ENmbpWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="281377839"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.241.120]) ([10.124.241.120])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 06:21:14 -0700
Message-ID: <e083f203-684f-4ae2-81c5-39d9ff24629e@linux.intel.com>
Date: Wed, 22 Jul 2026 21:21:12 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/tdx: Add helper to query maximum TD Quote size
To: Peter Fang <peter.fang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Xiaoyao Li <xiaoyao.li@intel.com>
References: <20260717214349.4075994-1-peter.fang@intel.com>
 <20260717214349.4075994-2-peter.fang@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260717214349.4075994-2-peter.fang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/18/2026 5:43 AM, Peter Fang wrote:
> TDX attestation report ("Quote") sizes can grow with newer cryptographic
> schemes, so guests can no longer rely on a fixed-size buffer for the
> Quote.
> 
> Newer TDX modules report the maximum Quote size via a TD-scope metadata
> field. Add a helper to query the size instead of exposing tdg_vm_rd()
> directly, as it can read arbitrary metadata fields.
> 
> Thanks to Xu Yilun for suggesting this in an off-list discussion.
> 
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Peter Fang <peter.fang@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

