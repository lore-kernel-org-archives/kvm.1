Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794203941;
	b=FcmTKgqKB+3evTGdCqgHO7AnmcwupTCd/A0hW8vIW3XJ2MKB8K5EdGgOssDs2KhBfdUg
	 2ZAJe/xJqVq8W7C9GQTOOVoK+2fbmbzMl8eSUrKZ5TcmnWrQ7TuPQsptYxwc7oysnYl6W
	 6nByZGLwLB9AxXWr+L17CO3HE6sm1wWWZ9KLDDDAgOnuNHxysrNq5oFsSfB+41HbiZRYP
	 lonr9j7IEKWxCqZVbGpm8zdszN5CWaoc/ulbggy7zZO0vUreCMnJD+8MCOIXHul+u908m
	 GX1Q8D6UJOWDzJNv0BlTdcKrdr3EM+8UXQvJaN/KvT/3xde0xkwFqMbHvul1fWpNXWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203941;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/E3ZtH8ojoi/vmsGrVMl6AMo0m24rPSDyRXvjqgo+0c=;
	b=mHm2/eAFQ6tKBFgbrCdKdM9dWlCYgNOQMpVeRaPvSlj49m7qzt7BJFX8i8jXwhBxU6tv
	 0rWJdNtHZSltmTlMInPxFg7gU6tF0BpNu3YKJkSBRME/IEg43zPBtV9pUHk8DHQN9Jfi2
	 +UQWzMeAVXJgHSOfHIhvpJpMyO9DfbQnGn3KkMtcgpZ348XIucXaBD8iAkm0uRKOwImAi
	 9NTvJUZW4g21nl4M6pcseh6ycsj7pcI9xeGhi6/Unm5B4uvdqR2cYR1/cwXczIruUEetX
	 oqVez3yFVQOyNM2bbrRCZu2gMggmEPlpi9ibUCiOHyOdqxWRMoPHxz1fiiWBSyFTLYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n8s+c+Xs;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADB5606A31C;
	Mon,  9 Nov 2026 05:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ADB5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n8s+c+Xs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794203941; x=1825739941;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OGKuaFtpJu/00zUw78GQThfCA7h7SYaZtzIWG6Z/hag=;
  b=n8s+c+XsSLhKKjFbsklhOU6U+BeJe+3SW+GghvcCYq47gh0iHgB4uXuH
   18vd3diU8jINCdayagu5+oQDK2/nU0MkSCPL3T6ZNcOUjQ56CS1c0jDOP
   MOnZsU6rXhY8GlDB0dwBbQ4mX6ElxoxK0CLtrIEw6VKxKuCtYGhylI717
   Nx/7SLg9LSLWs9R23boFZcKRKBW9lV99/RRsctXYCg0R70CnU7aQHXXIx
   +L9cxTpGAVXuSxHBi24raF6hGPgV4h0Wx/I13ek51QE6CXiBnxpJBP3A6
   mE//q1CZ7zyKzvj2EYGusOJZyru7sbVY2MDHnsnUmttgAUYc74xOmWeoD
   A==;
X-CSE-ConnectionGUID: pQb27N7WQxG6A0I+q/IJkw==
X-CSE-MsgGUID: ZjEghJfXThyIxTuQhwwqyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="3022706"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="3022706"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 21:59:00 -0800
X-CSE-ConnectionGUID: tjo2rXZDQNSnB4+x8NjlaA==
X-CSE-MsgGUID: wjgjw2klTIuEErLWbS1uLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7789063"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 21:58:53 -0800
Message-ID: <d28422d6-7ac6-48ad-a28b-553ba724581b@linux.intel.com>
Date: Mon, 9 Nov 2026 13:58:51 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 03/20] KVM: selftests: Initialize the TDX VM
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
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
 <20261105-tdx-selftests-v16-3-2024e8fa517a@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20261105-tdx-selftests-v16-3-2024e8fa517a@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/2026 7:46 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Add tdx_init_vm() to handle the mandatory VM-level initialization
> sequence required for Intel TDX.
> 
> For TDX, the VM's CPUID configuration must be "sealed" during
> KVM_TDX_INIT_VM before any vCPUs are created. This is necessary because
> the TDX module does not allow the host to create and initialize any
> vCPUs before the VM's CPUID configuration is accepted and sealed into
> the TDCS.
> 
> Additionally, to satisfy the strict requirements of the TDH.MNG.INIT
> SEAMCALL, the helper masks the KVM-supported CPUID
> (kvm_get_supported_cpuid()) against the "directly configurable" bits
> reported by KVM_TDX_CAPABILITIES.
> 
> Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
