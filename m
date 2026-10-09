Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D493B058F;
	Fri,  9 Oct 2026 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791530568; cv=none; b=X0tjYv8jvv/UUiKyzYtbCqguOTi+IofBMnwpxcHGZJEEMT8TkMRrMQ6UBYJNwpzFv+9DQOsCZJKzaCHV59G8z0d1tlctMj7QybnrDJMepF6IcfdHzR/cqk6fU9TKSzA+9Vf/ngRX4+rMyOa8GAXEBk7t6qWibhAgCuVZI/9pG9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791530568; c=relaxed/simple;
	bh=0dI3k+gxfGj9M0cvqQzcyughoM9wXOQcQMwXsBwyM+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5WfUpBSc/AIssCcW4LnPdsRGO81JwHEQQ3jTHRZoiUoxUt0RIhDgYKzRHGJEQ1nWOJQJD5/D+QzvcRBOKwx47gUAtXCkFKmxy7aVQJUoCQmC+d/tb7v6t+eMOvH+wyB+CpZMCBIobPzyeZHYwVgDngA4sUZoShf+aiv5/pIDBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2Jj9dPH; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2Jj9dPH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791530567; x=1823066567;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0dI3k+gxfGj9M0cvqQzcyughoM9wXOQcQMwXsBwyM+4=;
  b=H2Jj9dPHOnOsGHUQOwWC2ER6i2UoTG7nyxr8HaJwIt5CtnWHQGVbM2FP
   z1PyeP7I3IDXeY+y6uTj/hhNrBGSyoaQXXT/pCqnYjb0/FG6VY3VsFebh
   gK2uSdtieGq2kXQhQRX3Zb4eShCAoI3gsNMWiEsn4QZO7c5PucU/OsLk3
   EiBBmdUiVlIdFJmQ8CL8r4nPF5r61PvcKyvwEma984xLYUp56r1XOyPd7
   EVO6/6OHnjdCL87T5yGdEnRuv98bZtlgPzIDSS9vgXbHGKt9mN3pPN+qk
   IRJqw+6gCk/mCoI/QrFKI+T2+A7mF4u4xYC4F2D/TsWsMF852BH3cKp2w
   A==;
X-CSE-ConnectionGUID: TcA0FnV6Q3Slx299IZoQrg==
X-CSE-MsgGUID: bQTL6yMuRMauAXSuNj20AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="212494"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="212494"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 00:22:46 -0700
X-CSE-ConnectionGUID: oY1O8vM0RnW0NYXh5YrIjw==
X-CSE-MsgGUID: qXlPkVodRJKero9ROwJfJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="584103"
Received: from yizheliu-ivm.ccr.corp.intel.com (HELO [10.238.208.114]) ([10.238.208.114])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 00:22:40 -0700
Message-ID: <0e5ceeb8-492b-48e6-80d2-462c437a6dce@intel.com>
Date: Fri, 9 Oct 2026 15:22:37 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 10/23] KVM: selftests: Set up TDX boot parameters
 region
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
 <20261001-tdx-selftests-v15-10-7c62a5d8a992@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261001-tdx-selftests-v15-10-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2026 3:37 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Allocate memory for TDX boot parameters and define the utility functions
> necessary to fill this memory with the boot parameters.
> 
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
