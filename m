Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF8734EEEE;
	Sat, 10 Oct 2026 05:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791611835; cv=none; b=UJMUWdpyAzTR26wdPpkWzfMuoI4xwG8PlzDIReJgmbRZnh0TZ4hVrsZWNZxyKNOG2TmF0kkLUmQAuMFajGTbaR46HCWuE/n6ziwVHKHxPvcYaoKiIecVEPesIRZhvIq6o/4SJwHVkP/iIroXn56kNFAsonA/xv0g9gfp36ujee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791611835; c=relaxed/simple;
	bh=EnWZ/YZN6Z7cQWLpi9yWL8SQjZrozddsAnmu+c7QsLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+p12p3PXckdj8QCLEUONVzSzHy5EH7XLZ4IyCdUK9q6mHXxsMOtLlXtfMc3EzZN4pGrkba6sTF/QVTvVEXiL2xnzM8+XXFakLso2lhx+leMYBI76vgBfNSlMiJLgfh0vsUzKr0/xYFy2ozaKweOsMDN9flNN3o9rz5j3c/8KnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUGOXWXl; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUGOXWXl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791611834; x=1823147834;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EnWZ/YZN6Z7cQWLpi9yWL8SQjZrozddsAnmu+c7QsLk=;
  b=BUGOXWXlhIRW7/IyHgoB4J9PoIDP5GsDC8UoGfp/3bEnXRBuLoL2l2fh
   19BycVZGk2Uj9q3gakaE/+uw4mUm+SDCPLyuH15zhrRWRXXaMXGPvqm/s
   R0JH5LDycXyVCR03uhw1C5n4Pb5s2Lk7SRyF8Id6t2ukycOt04tBMJI59
   Zaje5b+IrTE9QG0yEE8VRE1R8OoDAqihi7RFoAnfTcl4JXd4hvrSjxWxr
   Q8EhTdK3mu0913qYc/qZu/fcOA5HHFfAWcirf1A/wx5vpe4D0+DCs6QmV
   FwSu8rLbUb2nuNvgpumJ2nfcz0rpPJFGh6CGAAHje5LcGjqkZ4yLf8BKk
   A==;
X-CSE-ConnectionGUID: 2TcRtYE8TZWbvDWo5XdORw==
X-CSE-MsgGUID: Tva/EPC/RCKyiuu3l5oqVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="311913"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="311913"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 22:57:13 -0700
X-CSE-ConnectionGUID: 2uEr6rGLRTasCz9utH9BqA==
X-CSE-MsgGUID: t73TNUn5Qka80IonXQuYJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="407321"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 22:57:07 -0700
Message-ID: <56921692-cfd8-4f0a-b11d-1bb215f768f5@linux.intel.com>
Date: Sat, 10 Oct 2026 13:57:04 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 19/23] KVM: selftests: Finalize TDX VM in
 kvm_arch_vm_finalize_vcpus()
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
 <20261001-tdx-selftests-v15-19-7c62a5d8a992@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20261001-tdx-selftests-v15-19-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2026 3:37 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Finalize TDX VM after VM and VCPU creation and memory initialization.
> 
> To integrate TDX VM finalization seamlessly, the finalization is hooked
> into kvm_arch_vm_finalize_vcpus(). This approach avoids the need for
> every TDX selftest to manually finalize the VM. While it does prevent
> TDX selftests from customizing memory before it is locked, no current
> selftests require this.
> 
> In TDX, finalization is a mandatory step to make the TD runnable. It
> also finalizes the MRTD of the VM's initial memory and state, locking
> them in for future attestation and preventing any further modifications.
> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

tdx_vm_finalize() does more than finalization.
It also calls tdx_load_private_memory() to populates the initial private memory.

otherwise,
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  tools/testing/selftests/kvm/lib/x86/processor.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index b4b76dc505ae..e1d0fd5ed1f6 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -1536,6 +1536,12 @@ bool kvm_arch_has_default_irqchip(void)
>  	return true;
>  }
>  
> +void kvm_arch_vm_finalize_vcpus(struct kvm_vm *vm)
> +{
> +	if (is_tdx_vm(vm))
> +		tdx_vm_finalize(vm);
> +}
> +
>  void setup_smram(struct kvm_vm *vm, struct kvm_vcpu *vcpu, u64 smram_gpa,
>  		 const void *smi_handler, size_t handler_size)
>  {
> 

