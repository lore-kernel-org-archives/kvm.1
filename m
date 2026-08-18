Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3E83B2FF6;
	Tue, 18 Aug 2026 09:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787043858; cv=none; b=YNpZS+1fv8kmkfW9r+hlz0Q7vX6cPKk9ClnUpOuRGs/nYkUegnA97BAyUO6ODS8uef4Oe5sODa7zDWjObakI7yDVl5SmcYRFPS+8PpJGmABbhnhwD2fpz4IrmifpemjkGGEqrZEkT4415hJcVin3dZHw8ddTKul6jxGF65ibYgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787043858; c=relaxed/simple;
	bh=gn3bG2uXjTB7/Gkv4zTxm+GkrW+QAtZDzStdA9fRYB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dyOTHUvE03SpHUGX+PJ3q1WUQ9DdT5G6a7QMKVqvfXX0Jq7sxZKB7UqEiIqbjUyuv45bCZJ+1wYSEjxsLbIQZS9qkza0Rp/6HtVWSvzKlWeLS8HNxzLPFvZ3CiGzk+Wzdez/FjK1FD0onBgqhgcVBTdoETAWo06LJ9f2rB+cF0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VBSPApZF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VBSPApZF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787043857; x=1818579857;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gn3bG2uXjTB7/Gkv4zTxm+GkrW+QAtZDzStdA9fRYB8=;
  b=VBSPApZF3+iAw732nWSZ15H8l5Jul34esnjlnb2PvzdJUVYAsEiPfiAy
   3JlAZG6OfCLnWB7Jm+7YMW3t1A849k6cV7d2HprHiLpJpjFHM7VtTejOA
   RMABB1i7uPku6ZQQ+owt8GX3PBcy1Q2nRsVGvAGudkbFGsoTycvyfC1ML
   Pm+/I7UMSeo0z71rLqVDjxpt7ZjtnssZsC12rAyaAS8xT9PTecRfodIAX
   4E8Mj/DrhI9/swtZP0ft+TPINIION7g5GLq25cwdhUMX+Clidr2C00bay
   fObCvuFRH5Vrwhc4XKvdFmPP+3/ZYftRELCTON8yBuuaND65CLVTTen6T
   g==;
X-CSE-ConnectionGUID: flNv7tleQv+CBpwmgmq/NQ==
X-CSE-MsgGUID: h+tldZpdQE+xiJ9a1fqaDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="86647895"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="86647895"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 02:04:16 -0700
X-CSE-ConnectionGUID: /AXHM77yStGvCGsM2346zQ==
X-CSE-MsgGUID: jTuxdOU9T0WH7qo9mXzWyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="265202934"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 02:04:11 -0700
Message-ID: <e86b80c3-38f9-44c6-aad2-b3b18597c647@linux.intel.com>
Date: Tue, 18 Aug 2026 17:04:08 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 17/22] KVM: selftests: Set entry point for TDX guest
 code
To: Lisa Wang <wyihan@google.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>,
 Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds <jmcrey@google.com>,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-17-15ad654a50db@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260722-tdx-selftests-v14-17-15ad654a50db@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/2026 7:13 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Since the rip register is inaccessible for TDX VMs, we need a different
> way to set the guest entry point for TDX VMs. This is done by writing
> the guest code address to a predefined location in the guest memory and
> loading it into rip as part of the TDX boot code.
> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

