Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13D22AF1D;
	Fri,  9 Oct 2026 06:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526424; cv=none; b=CdffXiu8Grx+ebmCLd10Aq1ZOvQGeNZAyimCQGNe2Iga32Zr4UhaGYfYqkqIQrBaOCWXCXfEDiIDBUBE4lZ2Mvtu8QkrIlfKKHgSX+kfkvqymIFTfx7wuMBNjlEQ+j2BQE1/PTM/BmJZ+TxUmts4fAILFDQUc+Ciw9nE2zx0xno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526424; c=relaxed/simple;
	bh=dn5ZM3AANbzoJ0X9A0Sjx2l4v4xZ2iShZ/4yg4B6GqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtgbTh1G+LENQPCwkMXD/4FfIlpC1CnIYgf8iWBgsjOL03evDiEhk8eQTpCrhM7+kGUM1GLCSzip1bxr/WXEKAKKeAppEfmMVEBG1919zrI73RC3ZgdcsmZR/KsnA1XnQgm55/+hUYJ2Ti6MW7LKcvuwMb66C+2IhhnReUX41gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQUgTLUJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQUgTLUJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791526424; x=1823062424;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dn5ZM3AANbzoJ0X9A0Sjx2l4v4xZ2iShZ/4yg4B6GqA=;
  b=dQUgTLUJjaM5EUvJlR+O3bafS1yWBDRQZ8gDHlfA7YWh3/qYy0zZya+P
   O8P/FVWipQa5vhS6Mc0+1zBdlxRcjQwP9/nJKKMJLU2jHIGe6n7EGhvXY
   fbwuWPfPj0QWFitYpMIhyTOgH8yUeXMqebZLij1oz0+je5wwnOWXjhg/E
   KxPyfY1QpYqZbC4tU0TwB3rQufX8zebu/lvr0KiCMynf35vxyYN0KerRN
   JZEGKkW+VadibOClYNr8PgHk/ZK0UqwosS6f+VX9L06BCldYR+wWGB35p
   3m8RgWlcm9cW+94XB0UjRch40u0KkmJlwSI/+yyTsUkIfvNcoLPIfQ5U+
   A==;
X-CSE-ConnectionGUID: Yz4uMfmpS8qpDAaslIcZIA==
X-CSE-MsgGUID: HfOogXT0T6upQkuIb7Lx6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="429014"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="429014"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 23:13:43 -0700
X-CSE-ConnectionGUID: Par3w1KoRwSmZwN64fikmg==
X-CSE-MsgGUID: 10j855TITQmEa6M4HQVkow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="2054118"
Received: from yizheliu-ivm.ccr.corp.intel.com (HELO [10.238.208.114]) ([10.238.208.114])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 23:13:37 -0700
Message-ID: <ebe7bc53-100d-4fce-afbe-f7ec35dba432@intel.com>
Date: Fri, 9 Oct 2026 14:13:35 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 06/23] KVM: selftests: Introduce structures for TDX
 guest boot parameters
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>,
 Kiryl Shutsemau <kas@kernel.org>, linux-kselftest@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>,
 Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-6-7c62a5d8a992@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261001-tdx-selftests-v15-6-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2026 3:37 AM, Lisa Wang wrote:

<snip>

> @@ -326,11 +341,8 @@ LIBKVM_S := $(filter %.S,$(LIBKVM))
>  LIBKVM_C_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_C))
>  LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
>  LIBKVM_STRING_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
> -LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ)
> -LIBKVM_OBJS += $(LIBCGROUP_O)
> -ifeq ($(ARCH),x86)
> -LIBKVM_OBJS += $(LIBVFIO_O)
> -endif

the check for x86 arch is removed below, is it intentional?

Other than it,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> +LIBKVM_ASM_DEFS_OBJ := $(patsubst %.c, $(OUTPUT)/%.s, $(LIBKVM_ASM_DEFS))
> +LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ) $(LIBCGROUP_O) $(LIBVFIO_O)
>  SPLIT_TEST_GEN_PROGS := $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
>  SPLIT_TEST_GEN_OBJ := $(patsubst %, $(OUTPUT)/$(ARCH)/%.o, $(SPLIT_TESTS))

