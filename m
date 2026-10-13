Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207FA3E1D1A;
	Tue, 13 Oct 2026 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883269; cv=none; b=n23QzzhZ3HOqYoSi8VcR3pRp1LszX8aBT4hfN3JgbNnJNaXoVXdzHPH/NM1FUKOybsAPtyWsave77lKRrw6VhN8tuzv7Hn7faDw7R+by8JaRQSXSP7TT1tmL/Q59OnLE1um2tTn1UemAYN4RXk4RyxUh42+RZrKEpxanM9t6Rqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883269; c=relaxed/simple;
	bh=AqyTz9Cb3qNFJA6+xOzFS3cqwS1jejuS3ABsLWcvmSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vABLEjac7Q/ePIHZGM8sOtyEmlmtHkzPmaPxU8/GPSJNbBe0xx7jD3xQY2rrTQtfKrjbonc3HZtObpcmoN8uL+2Smi69TEDYqYdiwSgaNjVXJIuFigh6T1IsW2Nbkohx/EFZkPiNodp13lfPgzz+RTrUUwocw5asVrq52Ly/Z1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BkDnKlW1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BkDnKlW1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791883268; x=1823419268;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AqyTz9Cb3qNFJA6+xOzFS3cqwS1jejuS3ABsLWcvmSg=;
  b=BkDnKlW115djtGyXtpVtGK4rG887Hz8oXCcQ0ZgJtHgJ4nkEkLJHVmI0
   ENjekXDopMcNBpoSTvS1FLKKGD1K3zbVdbUY80sXYbhhG2bCF0ggsaeaT
   89PKXRvjVDJkYpQP4ViQpDBId5Ovo/4NCqDjl+hxn4SCAM2MKO8T+q44e
   OhZMMuKtXmd5GqPxvp4Ui2XTP6uykSGi5IxiDjvDJukhPIeJblWiplMEz
   uhSvMXEdiXXdbgRPoqUupsINXceH2nM64NeZcHhwY2zy+h9T82ZxddVJD
   wQDHKFssjEdUxzVwa9aCpP1svbtdBduuYGk/O4L5wwuwAba+sQ90Vg4yd
   w==;
X-CSE-ConnectionGUID: l8lbYo5SRZW6R9YE0dnJnQ==
X-CSE-MsgGUID: 2z7C/k+gRtSY5OLcOssXew==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="500133"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="500133"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 02:21:08 -0700
X-CSE-ConnectionGUID: 4Sa7HtG6T62mLO6pUvkSaw==
X-CSE-MsgGUID: mjDXqcSXSlm5R5ysTzrgqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1092542"
Received: from unknown (HELO [10.238.2.98]) ([10.238.2.98])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 02:21:04 -0700
Message-ID: <6348b9e7-d435-44a4-8df5-240465d6d988@linux.intel.com>
Date: Tue, 13 Oct 2026 17:21:02 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] x86/virt/tdx: Convert the handoff metadata
 reader
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, yilun.xu@linux.intel.com,
 tony.lindgren@linux.intel.com, rick.p.edgecombe@intel.com,
 nik.borisov@suse.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>
References: <20261012094754.27702-1-chao.gao@intel.com>
 <20261012094754.27702-7-chao.gao@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20261012094754.27702-7-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/2026 5:47 PM, Chao Gao wrote:
> Continue converting the metadata readers to the table-driven helper.
> 
> Add a table that pairs each field ID with the 'struct
> tdx_sys_info_handoff' member that holds its value, and read all fields by
> walking that table.
> 
> AI was used under supervision to review code and workshop logs
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

