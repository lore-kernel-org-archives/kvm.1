Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C0E31355D;
	Fri,  3 Jul 2026 04:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783053328; cv=none; b=KZq5pOtS6YFVaOhwimMkQ8ICwpzhFtFEBTIG7L/Dvj4OFamqoI4wjvSwivkAxtARhLlrHq1qPe4W20C9zQgtOGjm+ZexWGjNy5XuTTnQmLUnWLyJzDJasInPVR76YNV48rEZWZTbqNgVHHXnBF46x75SQGuFXKOh10YDvhAMUSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783053328; c=relaxed/simple;
	bh=QBC++khxS0F4L3bCCsPjlFJdDH+4s0OrtGBVyH+dyoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpOZUU4UvOke9uiMAxL+ACkfj8ly31i2Ie7Oi1OVNuAIYlbQ2e05tYjZVXu72Gf5GXq1v/V2wlaZIC8SRfMi+PWjXV/+igBzzXasDRMD1hFwCkqcEd1RGxyStLlKZJn5vYX2sf5a87b87Yfyx5iTWOhue28Bm0HIJH2r9xhZrm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DSe8FR1H; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DSe8FR1H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783053317; x=1814589317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QBC++khxS0F4L3bCCsPjlFJdDH+4s0OrtGBVyH+dyoc=;
  b=DSe8FR1HxpV/kexuOtsUsgbIlkAET46uZdg6U1WtB+SeaYNljJ7dvAyF
   GtZLbnbcrQ7b7Ey7zOq/SUaDSRebw/efuP6OxfFDxxKgBK+fEkTroWDbX
   /v6N9WCRdyQYCmxP7AHJ7rENODQOSNiwzK+glkrvjDqurrdxh9hwe1pLN
   qzbizL+PtTgLbgM/AOasoTWcJD47Jvm3jfefiaGWFFXv8vQFgplkrNylx
   sbnW6ilGzK6qb8krTjjLCFM36DbLqwpr4Iw/4rHM1Zl37LB1HGBz/dcEl
   oKeAPeo/WSgXeoAbro137stxwOiJjm97PWBJ6/Im/Nu+j+8Zzx5rkiUvg
   A==;
X-CSE-ConnectionGUID: A8JbyFxCTrC/NjEaJ7YBdQ==
X-CSE-MsgGUID: zOFV/pCRSemvKJ5U4XVVQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="82912096"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="82912096"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 21:35:15 -0700
X-CSE-ConnectionGUID: CsbBhky6RwK2wPRW3nkvZA==
X-CSE-MsgGUID: zMBR9hLDShqMjjcYmocl6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="257355714"
Received: from unknown (HELO [10.238.2.244]) ([10.238.2.244])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 21:35:11 -0700
Message-ID: <0a704b8e-a132-4cd2-a696-578407d11888@linux.intel.com>
Date: Fri, 3 Jul 2026 12:35:08 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/11] x86/virt/tdx: Enable Dynamic PAMT
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com, kas@kernel.org,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, nik.borisov@suse.com,
 pbonzini@redhat.com, seanjc@google.com, tglx@kernel.org,
 vannapurve@google.com, x86@kernel.org, chao.gao@intel.com,
 yan.y.zhao@intel.com, kai.huang@intel.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-11-rick.p.edgecombe@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260526023515.288829-11-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/2026 10:35 AM, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> The Physical Address Metadata Table (PAMT) holds TDX metadata for
> physical memory and must be allocated by the kernel during TDX module
> initialization. Dynamic PAMT is a TDX module feature that can reduce this
> memory use by allocating part of the PAMT dynamically.
> 
> All pieces are in place to Enable Dynamic PAMT if it is supported.
> Determine if the TDX module supports it by checking the 'features0' bit
> exposed by the TDX module.
> 
> The TDX module also exposes information about whether the *system* (and
> not the module) supports Dynamic PAMT.
> 
> The TDX module documentation describes how PAMT works internally. To allow
> the last level to be dynamically allocated, it uses a 3 level tree
> structure, not unlike page tables. Like page tables, it has a maximum
> address space that it can cover. This address space can be covered in 48
> bits. If the host physical address space is higher than this, than the
                                                                  ^
                                                                then


> TDX module can't guarantee the tree will be able to cover the TDX memory.
> 
> The TDX module exposes this system support via metadata stating the
> minimum number of HKIDs that need to be available in order for Dynamic
> PAMT to be usable. The reasoning appears to be that more HKIDs can shrink
> the "real" addressable physical address bits enough to make the 48 bit
> Dynamic PAMT limit workable on high physical address width HW. However,
> the docs also clearly explain the 48 bit limit and how this fits into the
> Dymamic PAMT tree constraints.
    ^
  Dynamic


> 
> The handy x86_phys_bits value is already read and adjusted for keyid bits.
> So just compare that against 48 instead of reading more metadata and
> burdening the code with the more tenuous connection to minimum HKID bits.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
It looks like whether to check 48 bit physical address width limitation is
still open.

The rest LGTM.



