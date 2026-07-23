Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE96348453;
	Thu, 23 Jul 2026 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802279; cv=none; b=uxi4sEmMRwbNKwAD4PT/KTR9gti79NM8AdOVnEBoJI0Ln8/8VYJRU944XYVpLybizplAd2rSNUuEfk2WEzo/VPB+iWFsyHF3QDeJ9LdYAyuQpl5PhB1Di3FgN7T69lyWdxiXxfInzidu4iULjojnbRKuy7DEYqbL+ZAQNyHw6sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802279; c=relaxed/simple;
	bh=ulSQAYawKGFLwQsaWi7MgkTSdgT0TdYQBPa3lC2PW9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n36cYO4JVrOotQ6iPG7EXua7925mi3kU0JQ5HrX5dot1hLzs49u4D0bup1Q8ng24XrlvkJFaIxVhVDaBYSAmxPsYIvB7xIu5XcUuGQw2DVilOMY4a2Lhb5lnTON/J21BssIx4OAmaUSsMjegOv5rsQSBqEVBVqQudaYiY28EcuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TG2SlJ5v; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TG2SlJ5v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784802277; x=1816338277;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ulSQAYawKGFLwQsaWi7MgkTSdgT0TdYQBPa3lC2PW9Q=;
  b=TG2SlJ5v2lqG3sh6fvJlt6Dugd8E7nDBtMgP4KQEL2GBjz/api1RFvsf
   04PP6UC1f1otJvhJtRXcytjUOl5v6geaYotztebECvIYCYpZeJinomdo9
   4IKgyX86nl+6Q9nK582pxzHYj99C0oFmUIy+46E5Z1qsg5jk2rBj4fnwi
   quaFY1o7/E6NL1vmCplgsNWfZbUcQcrXxbEo9SdXuP55kcpvccBziHlIM
   l8eLVDQ6Y7vqFZko/cORjrBJZqesx4qZptnGhbtxidiuSWvGQY+Pu3U0M
   nCoYjq+KmoWUTMETZ7aQ0wlFK3ZiMbIbAj9+w8UscMFCLLvpsz/qY7dJM
   Q==;
X-CSE-ConnectionGUID: VJzkTYcRTS2e2fZ5yLXk1g==
X-CSE-MsgGUID: oOlwvP+cQXmu0+15Q0zm0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96043526"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="96043526"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 03:24:36 -0700
X-CSE-ConnectionGUID: i3l+KYEDT5203pkZqxQ0nA==
X-CSE-MsgGUID: vBD803FKT2qRY7BLnCVxRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="282886556"
Received: from unknown (HELO [10.238.208.132]) ([10.238.208.132])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 03:24:29 -0700
Message-ID: <36fb7b2b-6355-450a-a162-f50c15b13a13@intel.com>
Date: Thu, 23 Jul 2026 18:24:26 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 10/22] KVM: selftests: Set up TDX boot code region
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>,
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
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-10-15ad654a50db@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260722-tdx-selftests-v14-10-15ad654a50db@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/2026 7:13 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Add memory for TDX boot code in a separate memslot.
> 
> Use virt_map() to get identity map in this memory region to allow for
> seamless transition from paging disabled to paging enabled code.
> 
> Copy the boot code into the memory region and set up the reset vector
> at this point. While it's possible to separate the memory allocation and
> boot code initialization into separate functions, having all the
> calculations for memory size and offsets in one place simplifies the
> code and avoids duplications.
> 
> Handcode the reset vector as suggested by Sean Christopherson.
> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Erdem Aktas <erdemaktas@google.com>
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
