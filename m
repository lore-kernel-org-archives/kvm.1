Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D60A3914F0;
	Mon,  8 Jun 2026 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903892; cv=none; b=pwQpxla76aFQbMfztX6OHh2Oh3xISa76B/FfVVKVD3k3HBy749g3TVAGjmwSAvvkQI4qhQWmcszxJuBkTYZqhdXkcGSdWkhGetGP8lKTgaWMalykZLJBzzlTXJPDjjEFf7JLFiZ461uzSrJrabx7bvGY1qmkK+g1yF6zKCMqKR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903892; c=relaxed/simple;
	bh=CvTLFyhxq9msoIgNWC90DtZohlxaCQTF9fNqOcbIN3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCCKAMZVfpq0MQhbPE6F2ONitMcphvREIVliYYcxKaCdjgqtbs8YgY8+vAubNaZCT1KQNcpdhMntsoU50+IIsBQ4xTLaHBIgbIXTCbrx218Iz3Xg1Qy6DmV9ap9gyyN7qcFeUIEtZYypavic/ra3OsHmG9FXMT3lPDaRgEbsrwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V5fxnQbo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V5fxnQbo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780903889; x=1812439889;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CvTLFyhxq9msoIgNWC90DtZohlxaCQTF9fNqOcbIN3g=;
  b=V5fxnQbopyLIlesGC8aG9YMAchWDac6kRSZFOD8M3db7CEkNIvtdofzs
   96oxwL3p3K8OSDr0/6T8O7IDzxZwHlxb11RDwcBrd/zm4nER5VO+gdtW6
   AdBHb0179VI71Li6nvf8ty2WZ/iRr7o0bV/AuaR3JseSKW/URvrejPhKa
   CjcAF7VTV4lPYi9422IoQWBiAq2lwuPF99CnSv1KHhh4Ow8bkmZxHNVFs
   5C40KEjFF0uPh6u/j6VomOBS/lmu3h5dJSRlgdj9zTr/c23YWnGN5QpIj
   Ht+wzPsmveKFvQ/erpZbnOy7ew91GmJ6v9w8ya42q4f3P1OGqk+29Pxie
   A==;
X-CSE-ConnectionGUID: dlFW4YDOQMCN92C+iMk2pA==
X-CSE-MsgGUID: gk8uiiL3Qee0cqPtvM8AUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="84206795"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="84206795"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 00:31:18 -0700
X-CSE-ConnectionGUID: dlvNSPV/Qf6vGo/QWFgWxA==
X-CSE-MsgGUID: d3OpymgeS7SsWO8cOkbqIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="242496781"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 00:31:12 -0700
Message-ID: <14385c18-a236-44fd-8728-598d6b6cc8a5@linux.intel.com>
Date: Mon, 8 Jun 2026 15:31:10 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 12/22] KVM: selftests: Back the first memory region
 with guest_memfd for TDX
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
 <20260521-tdx-selftests-v13-v13-12-6983ae4c3a4d@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260521-tdx-selftests-v13-v13-12-6983ae4c3a4d@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/2026 7:16 AM, Lisa Wang wrote:
> Force GUEST_MEMFD for the primary memory region of TDX VMs.
> 
> TDX must use guest_memfd for private pages as there is no alternative
> mechanism supported by the TDX architecture.

This sounds a bit confusing to me.
It's the kernel/KVM only support guest_memfd for private pages.
The restriction is not from the "TDX architecture".

Also, the short log is also a bit confusing.
Why describe the "first memory region" here?

> 
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index d1befa3f4b30..9a29540fff40 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -472,7 +472,7 @@ void kvm_set_files_rlimit(u32 nr_vcpus)
>  static bool is_guest_memfd_required(struct vm_shape shape)
>  {
>  #ifdef __x86_64__
> -	return shape.type == KVM_X86_SNP_VM;
> +	return (shape.type == KVM_X86_SNP_VM || shape.type == KVM_X86_TDX_VM);
>  #else
>  	return false;
>  #endif
> 

