Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1052D3630B0;
	Sat, 10 Oct 2026 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791618051; cv=none; b=RX5kIARQdB3RRdqNkLDvodhrTiB5ASpwmBzGKgy6AKQjZ98j+rdWH2i+6Lra1zACK4chg+x9YQPWRwx75QdtuQTmHJ95YIFJgNlcLl5+wicvuu1KQFPVot0tZf5h8MG/TxVdWwiFrCSFYZhWU1TcglQZj/YIl1LA0PlfkG5tiuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791618051; c=relaxed/simple;
	bh=1vuW7igmuBaOaVd7Qx/9Busg1gOXOOX/G1LV5HNvmG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wm2t4zghSkIpKok47NDvSMR2FsJOJU9d1u8KCgFS4cofHMXah3j+ig6UoJANnbpPXUv1Agm0CkjUmR1XrNNEU1wbnVsQPX05FkWnTh2p7pauc2x7fXlPk9O8QoN1Ixb4QlP3s9scjyyzjXHdhA+Y3qmapDOWARrtB/2MNrO90Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGF+ItV1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGF+ItV1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791618050; x=1823154050;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1vuW7igmuBaOaVd7Qx/9Busg1gOXOOX/G1LV5HNvmG8=;
  b=GGF+ItV17ZDbcWLosMKJnwCnpXYii8YFaGSR5s5thtnLK9ZWxa1tZDaw
   x8HdoRBgFkfN7oryVUugGZmnVpjauQO+4rlRBri0OS6ZVacrk6/0RCQty
   4GBimkglCrl0CZznCydVo7OYKiPnmAIHZxihiVDJY3+7ravbBeaBdTGvR
   J+eW7LZIMwtCJQ+NybrnnPzeeXDx53R88c0Syku7xE3i5FUltK6vDb4Js
   qOCnWjDrmZ8Gr8QvdN/ObRo4oo91327XFlBrZt/1e35bCBC/U7w5TFXu0
   +LdtdYIknylfU4hBYl93cy2BGgWhRmNkxZ7nO2lI8b4F7Ga4j81g6D70B
   Q==;
X-CSE-ConnectionGUID: 4kAwUWxJScecFThtDhhmbg==
X-CSE-MsgGUID: 5HzpRduXSIOW6u9NdEEdOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="415460"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="415460"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 00:40:49 -0700
X-CSE-ConnectionGUID: pC2/cJPORAiRYpM0ldlElQ==
X-CSE-MsgGUID: WpdbfLUDTXad1/9cw7Oi/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="415171"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 00:40:44 -0700
Message-ID: <20778a25-8e89-440c-9c2b-16b42fe00c1d@linux.intel.com>
Date: Sat, 10 Oct 2026 15:40:42 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 23/23] KVM: selftests: Add TDX lifecycle test
To: Lisa Wang <wyihan@google.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Chao Gao <chao.gao@intel.com>,
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
 Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds <jmcrey@google.com>,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, x86@kernel.org
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-23-7c62a5d8a992@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20261001-tdx-selftests-v15-23-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2026 3:37 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Add a test to verify TDX lifecycle by creating a simple TDX VM.
> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
