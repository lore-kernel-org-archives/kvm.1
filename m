Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E8C14D719;
	Wed, 18 Mar 2026 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820417; cv=none; b=pK4+8HbyJUzXS9erKkexcFOUrVlaxUmOtti5Vcaq+azujHtDz+XCqtL1sf8C2o1/JED2ktRlNWtmv32Rdegk+BdE1r5MOOzklA5GbKKIgMT7hMLR5bFAYWBSrQk/iV/s3gm9u+UQOhIkbJf0fQt1FhhfTGLx5Z9DswCgyEKAiyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820417; c=relaxed/simple;
	bh=ZXwT1asYd0yxLvRty4sNfZaaQpqmaOTjA/6Jd0XE5lE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BTJdWUhiTipT35hxQ6Er7jyk9LbvgFeSblVSz2GD7I2OH+bQPXHBnaSy4KIePmf8qRAa9F54K1Lx7zNMesJuLJa+99XWEfl8/TO2rZW4pfBCwpAQ6/Om4qpTasJuvBfZMX49Sd5ZC9/2f/jSNVmhuecOC4/O23R2ZN0hfZW9ZCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRA0y562; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRA0y562"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773820416; x=1805356416;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZXwT1asYd0yxLvRty4sNfZaaQpqmaOTjA/6Jd0XE5lE=;
  b=FRA0y562Xz1W/sxH/dCe5kKbK0tuVzZJt9McM02wXr4omYee+kh7SVA0
   dZcTt3xSl3piEv8pXws/6kRrENvIDMBGe8ieNzjNyIOyAgMNBFIu+6vLd
   ReYcf75vE8jFfq8s7ec/NYKq6X0psUbIpP6MSg0MNERm9msen9vagizuQ
   Yz5fizWshIp0X2QcTJ50wPNQLJmpPXVaeHB92ZAKIMV4LN2MvLs8UEuD6
   gNdGEqM138tV74pzXeEKSm2f/oFESWB8EHINfL+9fWiptm3RsAY450LCp
   3D/fvhhku/CZ9te+iViBU+88tjKCUirC7HQKZZzFpMGhtlkzG0uQ7A5dG
   A==;
X-CSE-ConnectionGUID: psRs7tjtQ6O35tsStUumKw==
X-CSE-MsgGUID: fe30zzAnTpqm+bMwRWD1Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74048540"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74048540"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:53:35 -0700
X-CSE-ConnectionGUID: x1xZejZmTcGo+LJ+CwmtQg==
X-CSE-MsgGUID: ize9rudvRG+HgvXuSZq7Nw==
X-ExtLoop1: 1
Received: from unknown (HELO [10.239.158.72]) ([10.239.158.72])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:53:29 -0700
Message-ID: <0f5fe0ba-1699-4762-90b0-60fd8bb9c869@intel.com>
Date: Wed, 18 Mar 2026 15:53:26 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/22] x86/virt/seamldr: Retrieve P-SEAMLDR information
To: Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org
Cc: binbin.wu@linux.intel.com, dan.j.williams@intel.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com,
 kas@kernel.org, nik.borisov@suse.com, paulmck@kernel.org,
 pbonzini@redhat.com, reinette.chatre@intel.com, rick.p.edgecombe@intel.com,
 sagis@google.com, seanjc@google.com, tony.lindgren@linux.intel.com,
 vannapurve@google.com, vishal.l.verma@intel.com, yilun.xu@linux.intel.com,
 Farrah Chen <farrah.chen@intel.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-6-chao.gao@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260315135920.354657-6-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/15/2026 9:58 PM, Chao Gao wrote:
> P-SEAMLDR returns its information such as version number, in response to
> the SEAMLDR.INFO SEAMCALL.
> 
> This information is useful for userspace. For example, the admin can decide
> which TDX module versions are compatible with the P-SEAMLDR according to
> the P-SEAMLDR version.
> 
> Retrieve P-SEAMLDR information in preparation for exposing P-SEAMLDR

This patch only implements the function but nowhere calls it. Please 
adjust the wording and the PATCH subject.

...

> +
> +/*
> + * This is called the "SEAMLDR_INFO" data structure and is defined

I'm curious why you changed "This called" to "This is called" in this 
v5. In v4[1] you just used what Dave provided to v3[2]

[1] https://lore.kernel.org/kvm/20260212143606.534586-6-chao.gao@intel.com/
[2] 
https://lore.kernel.org/all/b2e2fd5e-8aff-4eda-a648-9ae9f8234d25@intel.com/
