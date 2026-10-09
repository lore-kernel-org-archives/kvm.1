Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05588439F86;
	Fri,  9 Oct 2026 06:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526257; cv=none; b=VV7v8Gylk/NVAQ10P9M2nsRpjgSUG2NIf1xV+no0M1469X66AKmB3VetZt3ZeFsYL8K4l56VcsBE8zH+hPcKCLPPIr0yh7d/G7Zk5/U04U21yGwLIDUw3SX9RkRRxaIjI1NLz/rSSvEU6dJgpXUjgpS2K+1GFBHCnZ2NxOCYWYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526257; c=relaxed/simple;
	bh=lWz4osHLrKAgMrC5fleRhH64RQ2aHG2Iofd7MllV4r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TY15pxp2FC2BsPEAhwhHd2tPqhLPNPdxLc1ApKC2yOkAiKFbN0CDGIkVfOE+PxZZttCs5vbkg7UrguVkripUDYWWaUww5w3kPRRdXO7oOqYE/gB+8z5QqWUJRXyWbLTgtS3i5GNy2rQrv0tKEO5WuYSh+jngAWLdwnOUkfZ4LQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buxhMhKp; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buxhMhKp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791526256; x=1823062256;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lWz4osHLrKAgMrC5fleRhH64RQ2aHG2Iofd7MllV4r0=;
  b=buxhMhKp11SKgunxusGqU63v2Oyww+uCeQ7I/SK6WcD2zRHtEZ1jrIbA
   r3DF5x13GilJbpD4EGn9jU7taH0QkJ1Ix9HKZbtbXnCqciiOMAZ2/hcy0
   ZeOtVyoK/e1Nudg7GpQxmU/QcAEYIBLOG/3PVosZOwFiAk4kYOzErx6Vl
   OjCV24etsKiAP8+/wKwnjkorDGBoLQfsn5XyZHOgZIZn/w1Gar2xssTo0
   i066xAKezczPc7eKh7GJDFEkDLNw8gz4DGLwAY0taEkriKiNu3H+A+xxd
   8AlWMU9YVT0LGWrKci5MDg4FsdRL/i3qrRrtYPGYR49vmVTsP275Bsd7T
   A==;
X-CSE-ConnectionGUID: EUYRbCmaSTe1VV64Zgli7g==
X-CSE-MsgGUID: n9c4lsK/SDa3WiKVjoCDrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="428868"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="428868"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 23:10:55 -0700
X-CSE-ConnectionGUID: Vt6S9iFySK6VcjFNgQVXVQ==
X-CSE-MsgGUID: WzG4shnSTciyydw5xxCr0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="2053926"
Received: from yizheliu-ivm.ccr.corp.intel.com (HELO [10.238.208.114]) ([10.238.208.114])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 23:10:48 -0700
Message-ID: <db4c2dcc-8cd3-49d1-bb46-5c0e35428ec6@intel.com>
Date: Fri, 9 Oct 2026 14:10:46 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 05/23] tools: include: Add kbuild.h for assembly
 structure offsets
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>,
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
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-5-7c62a5d8a992@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261001-tdx-selftests-v15-5-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2026 3:37 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Add the Kbuild macros needed to enable the filechk_offsets mechanism to
> generate C header files containing structure member offset information.
> 
> Tools depending on assembly code that operate on structures have to
> hardcode the offsets of structure members. The Kbuild infrastructure
> can instead generate C header files with these offsets automatically,
> allowing them to be included in assembly code as symbolic constants.
> 
> For example, the TDX guest boot code requires access to parameters
> passed in the C structure (struct td_boot_parameters). This header
> provides the macros needed to extract these offsets from C code and
> expose them to assembly, ensuring the two remain synchronized.
> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Ackerley Tng <ackerleytng@google.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>  tools/include/linux/kbuild.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tools/include/linux/kbuild.h b/tools/include/linux/kbuild.h
> new file mode 100644
> index 000000000000..957fd55cd159
> --- /dev/null
> +++ b/tools/include/linux/kbuild.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __TOOLS_LINUX_KBUILD_H
> +#define __TOOLS_LINUX_KBUILD_H
> +
> +#define DEFINE(sym, val) \
> +	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
> +
> +#define OFFSET(sym, str, mem) \
> +	DEFINE(sym, __builtin_offsetof(struct str, mem))
> +
> +#endif /* __TOOLS_LINUX_KBUILD_H */
> 

