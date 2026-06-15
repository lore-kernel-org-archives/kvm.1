Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DB331F98D;
	Mon, 15 Jun 2026 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512229; cv=none; b=PyMNv6n4/9mgv6LZU1I4GjVS26OTI+QqmwMLRsUwoaTk3baNuTpwMKeK+BF5KhsnItQiHxJB2d+ZWWRfMpapfp2QpsIFtF/As1wnOwLm56bHW2fier1tx4gnxvy8KZwCCd6J5wi9v/80760QO+vUMD3GrdysTIfcm8g2tJNsrEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512229; c=relaxed/simple;
	bh=jECFebR35CUlRZf1BR5ezb1DB1rT/+O7bI9UDZJ5bVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nw8AlD78yAy+nkZcRFAz5NdFysCaCbfpqQ8EfF6edokE5CErZb6T/s2s58fyqhD73gYxzd8jx4Yhcoyk5aVXTU8tTQIXioLKIeXGbjSGetaRRiYcn9dG7RMULxBwfS3HwgMzcXB0Lx3jkYHpvP9pq6yHCBnyDEtsLD3oAALSREU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgPne4cO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgPne4cO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781512228; x=1813048228;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jECFebR35CUlRZf1BR5ezb1DB1rT/+O7bI9UDZJ5bVQ=;
  b=hgPne4cOJyVTeX1yJMwV+eFtoIgoeFKFHFAE7pA/YQyB5kp5fIhjNKV+
   0NOfxTW7wsIqjKgc9BeDRoa3qCRe08uyZDS9/zsaip9cqXftnmYaJdZ+4
   2Qq++We/AWoljnIBdOAEp7KAFUZFzWr/6eDYDI47gqUDB8OLCsRBhg9XJ
   Khmh4G8KMY5nIwzMIjXesvq1VtZNoO+3oZ3vOPv6FYgmZddfNIVoeXUK8
   7bdAYlbElgPJAthcXli4kEtH8NWhKDlL9nd2AckAqBQLpnAnK9TxZtlzh
   DmLKSpQDFHr0zpGerEjIenykkINdu4idir+T8M+JSjsPv/UefqJRAaKZe
   Q==;
X-CSE-ConnectionGUID: cp2FMIB2TMel7lDgmVtLMA==
X-CSE-MsgGUID: GDNeqDdhQg2/sCqnjLID2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="82353558"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="82353558"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 01:30:27 -0700
X-CSE-ConnectionGUID: byz0vffgTxSLh0ZRbYtlaA==
X-CSE-MsgGUID: ehag4vkwQFanTPPX1Cu3eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="252497828"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 01:30:21 -0700
Message-ID: <3c9276f8-06c7-4db5-8d1b-bfd823b02b5f@linux.intel.com>
Date: Mon, 15 Jun 2026 16:30:18 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/30] KVM: x86: Extract get/set MSR (list) ioctl logic
 to helpers
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-13-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-13-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Extract the code for getting/setting MSRs and MSR lists to dedicated
> helpers in anticipation of moving the MSR code to a new msrs.c.
> 
> No functional change intended.
> 
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
