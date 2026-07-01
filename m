Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E4D3CAE75;
	Wed,  1 Jul 2026 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892968; cv=none; b=phyn/raNzdmPidfQLT7OahVYHb2NVyBvzGCoODioXoKk81p7WCxfsE+kZ+/wGiX+ff8+F/HuRNdkW/9o9feFBxuHB8RaGxedE4CIVjul+tWDdMcI5XIRJvD96cKST1fkRA1xmqYYp6l9KONxQA3SBJd2kGiFBKyG6O/ajNlHvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892968; c=relaxed/simple;
	bh=gs91U4urshrpyhxajeGAiyZrHp+mWkTmV2lV7ilyUlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/RGeYvO8vSA+O5fyStlW4g7Fs3GqLa+qQfMDLD0GfcIlcxAIDHwtL6DeLWwmVWvtfQWoqZ2Prl6tRyv7mgRaA8699qvHXMnAtLWz7jZD+1JAb24FeDM80oJW5P9b2aDq1XLo0LV3jyggxQt1uIUzOUt//FGcLmDIFNNjP5m+2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BA7Nbj73; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BA7Nbj73"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782892966; x=1814428966;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gs91U4urshrpyhxajeGAiyZrHp+mWkTmV2lV7ilyUlk=;
  b=BA7Nbj739I6rccnQQUGD60TN1cv5Z/BNAI6yG73QCCiWIL0dKkH//cK8
   3033NXk7Atqf+MlXNAkyOBkXFW2urzpV7jnHtrnesej7gCH0Vm5ydxvlV
   hC4+CddjsfNWF2jkpOr9Kd4c0MVp1qg3iWBJ4pk/c2IRwgHhfK1UQZdIi
   Ju+kHczvZ4p0rR2G73UvmRvJgUgfxatiKoHJ6d93oEekE7MsJksidB5BN
   +hbVTy4pZQ15J+QKuMuwipTbMI7iQfrZIq6xNvz71T6n61HvK2QPfEBUO
   XQVyqHqgtrFIzAfFQg9wJTiIKy0VhNESrUtqjhExC4aK57VlkM1rLkOJs
   A==;
X-CSE-ConnectionGUID: xnvuQhIwSSKNhXzKK0xxwA==
X-CSE-MsgGUID: goTLXkIfSuSdacgKU1Ld1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="109163585"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="109163585"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 01:02:44 -0700
X-CSE-ConnectionGUID: RGH33WRNQVmSpOZLXBWB1w==
X-CSE-MsgGUID: m+yLhzAJS6yr8hx+8z+Gxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="249848219"
Received: from unknown (HELO [10.238.2.244]) ([10.238.2.244])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 01:02:39 -0700
Message-ID: <323a9a1a-6cf9-4a68-b92a-867f497b3d34@linux.intel.com>
Date: Wed, 1 Jul 2026 16:02:36 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] KVM: TDX: Return EINVAL, not EOPNOTSUPP, for NULL
 INIT_MEM_REGION source
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Sashiko Bot <sashiko-bot@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Ackerley Tng <ackerleytng@google.com>
References: <20260630213711.479692-1-seanjc@google.com>
 <20260630213711.479692-3-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260630213711.479692-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/2026 5:37 AM, Sean Christopherson wrote:
> Return EINVAL instead of EOPNOTSUPP if userspace attempts to pass a NULL
> pointer for the source page of INIT_MEM_REGION, so that KVM's ABI is
> consistent between TDX and SNP (for LAUNCH_UPDATE).  EOPNOTSUPP was chosen
> to be a forward-looking error code for when guest_memfd supports in-place
> conversion, but even when in-place conversion comes along, it's an awkward
> error code as KVM is deliberately choosing to disallow virtual address '0',
> which is technically a legal userspace address.  I.e. it's not so much a
> lack of support as it is that KVM reserves address '0' to simplify KVM's
> internal implementation.

Nit:
Do you think it's worth calling this out in the documentation?

> 
> Opportunistically move the check so that it's co-located with the other
> checks on the userspace address, and so that it's more obvious that a NULL
> source address is explicitly disallowed.
> 
> Fixes: 2a62345b3052 ("KVM: guest_memfd: GUP source pages prior to populating guest memory")
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linxu.intel.com>
