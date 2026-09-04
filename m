Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B354E21ABBB;
	Fri,  4 Sep 2026 02:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788489052; cv=none; b=euMSKJRy/NCMfdiUNxne3Pxo8XmfSn142w6kIfrVEZ8Ndu8OVtHVsmek6+eVuBqvfYu5d4uavfsr8U7BwmsXW38gdQazCcJmPV7hCUHyooGQGFRCO8nM5v9r8+LdPMjntF6etNj5JZcWUG4jg3u4MYyHUlR5HLZ5Q09jCWk0VLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788489052; c=relaxed/simple;
	bh=tXnIW68QeYTxe26mdL1ti0jLsTICAr/Syr1+KzZkyOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxnvBIEWyUuZtwAUph+nIe6GsPazoWfkzDM8Lb+dUxRCON/HNfNUjLJH8h6Z9uWqo0AIujWD+18oTKX+QX1lKaq8siiah65OjlaWougze3Z2a1TL2MYzEjoo0Zi6uFA1CuKnV+pWNM8qfi8fIRDDqNAz0CcmJdyNgmc3yPU6iOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ADBnNo9d; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ADBnNo9d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788489050; x=1820025050;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tXnIW68QeYTxe26mdL1ti0jLsTICAr/Syr1+KzZkyOw=;
  b=ADBnNo9dl0dfEAb/1ThS4Y5iPd9nypZRmJ9P1q0k8Cx7c4nmk5phvqRT
   uCHS9YmpcBR/upiVcqeQnk7K0GbKm+mrNAueH8GrSNXtZFCw4xZ2pVJN9
   Js4XINJLED150pO7IEqmNM0ovmYGJIk8cJ2gLqV5Z9PYpDudAhLPvnaxJ
   qPUqkXxJqoMlKoLMbnsW7eDAlSpFdCCvFOg89fvB4PP2i00FuXHX8YCqW
   iEvIl0ozAgihkibSTLy3UuoTw2B6/IWUDKO8xmMXIhEUWLxujv3whQiGL
   e1z88QPP4zmiY9Fye1cK5meSEMn+YVF+GKDfIXySuzE8v3/l8uf97gAuE
   A==;
X-CSE-ConnectionGUID: KON22JBvTvml/I8OgOdrcQ==
X-CSE-MsgGUID: dvcVu1DbSRaBmPTzcEnvjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="99582373"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="99582373"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:30:50 -0700
X-CSE-ConnectionGUID: 9VzxvrVUTJ2ksV1w2gr/Sw==
X-CSE-MsgGUID: pcMWmoUvSXKkNL9J3v7OoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="293418458"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:30:48 -0700
Message-ID: <895bf2d5-59b0-484b-a380-485103cae9e1@linux.intel.com>
Date: Fri, 4 Sep 2026 10:30:46 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] KVM: VMX: Move the shared NMI handler/trampoline
 to common code
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Kai Huang <kai.huang@intel.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Yan Zhao <yan.y.zhao@intel.com>
References: <20260904010353.3175819-1-seanjc@google.com>
 <20260904010353.3175819-4-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260904010353.3175819-4-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/2026 9:03 AM, Sean Christopherson wrote:
> Move vmx_handle_nmi() to main.c to capture that it's a common handler and
> to allow guarding against incorrectly using to_vmx().
> 
> Opportunistically use a "vt" prefix instead of "vmx" to communicate that
> it's a shared handler.
> 
> No functional change intended.
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Tested-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
