Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F5C2F2910;
	Tue,  9 Jun 2026 05:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780983488; cv=none; b=DUExAOab6X4oMAsFPFw396AeO0/SiP1jyH5bI3UM3uzH1GeKhMq+GYyaeGmSM92RYbR+74ehzYjhcMo9mbzi7Ynwjanwktg+OHu/6d731P44l5c6RNUd1fH2VE1isfiPcU3jbbRvBNP5PxMvUuAyNR0gHw1Ch7DsevTxsTS8UIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780983488; c=relaxed/simple;
	bh=13H4rBXOwb8xQGBX0guI7OEhjmT0Lz/E1TcGCfJ+rwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TU2FPe98ktlT/2yR+aJQgu/fOplAEwWBlzUKCQGF7Uh7ux7+vZ/DjOZ1su/XkgY7UrfYZk6l54Qe//4oLbOhBKidYvuq/mAr1BNlTjTiAPfvq/qT0gHYNYpk6uLhaJDLU6wJWZuFdm7plCiEpZDBHFhw/XnA/IKflOKXQlR+zYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4sVGkdP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4sVGkdP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780983485; x=1812519485;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=13H4rBXOwb8xQGBX0guI7OEhjmT0Lz/E1TcGCfJ+rwM=;
  b=h4sVGkdPQ/pxf8LD4NzFNdYxrD2NLaA/XuCDMu4Qav2ob1AKo3eyLGvh
   b3qKoU7lS6cU7jWCIDRDvcEQmE9wGvsI6hCQZ2DA1fZ/mBMCPdQ/l5aQZ
   KKGOggrniQ9kkBFHLQptdhunovWsAA7HnMrBUwrp+97m8umlDimhhKisD
   FhqVWZ8zRIMRwZOdKH2TWRTzZpsjkMVelDql2uaCZMobost0uJA1lIuDN
   6lf7xWM/G/QCC87/n+XZB8GKgQ3igismFV1Rg9fK2QurhPMQEBRb9TGd5
   CFKrFKZqH6lRRoAvoJ7GurAlw08jLFqpen5dfpL9ccgpImecCasLPkBQ2
   Q==;
X-CSE-ConnectionGUID: LphlZHksSKmKEC5Ai+Y03w==
X-CSE-MsgGUID: YjBzBLbWQgKRuF86yFh6qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="104398000"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="104398000"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 22:38:05 -0700
X-CSE-ConnectionGUID: 3LkUyPELRx6Cy7oCkd0/LQ==
X-CSE-MsgGUID: fJrLrpFLTNifHob7ADMrZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="244914220"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 22:37:57 -0700
Message-ID: <a16f6ee5-263c-4627-b94d-5d248ee00f21@linux.intel.com>
Date: Tue, 9 Jun 2026 13:37:54 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 16/22] KVM: selftests: Load per-vCPU guest stack in
 TDX boot parameters
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
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-16-6983ae4c3a4d@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260521-tdx-selftests-v13-v13-16-6983ae4c3a4d@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/22/2026 7:16 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Allocate a guest stack for each vCPU and record the GVA in the TDX boot
> parameters region to allow proper vCPU initialization.
> 
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

One nit below.

[...]>  
> +void tdx_vcpu_load_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> +{
> +	struct td_boot_parameters *params =
> +		addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA);
> +	struct td_per_vcpu_parameters *vcpu_params =
> +		&params->per_vcpu[vcpu->id];
> +
> +	vcpu_params->esp_gva = kvm_allocate_vcpu_stack(vm);
> +}
> +
> +

An extra empty line.

>  static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
>  {
>  	struct kvm_tdx_capabilities *tdx_cap = NULL;
> 

