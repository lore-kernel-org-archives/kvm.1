Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03153BED37;
	Mon, 15 Jun 2026 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781508803; cv=none; b=E4w5bYSNhuB5C3YrqVZVDERHu5uPKm1qAYdmyjs6T5ynVN5oQuNW29jpo9HSOBzpCCDy/etzvbbF+bF0ORRBWX3UlVQsgx4RBgSHR9bZhsIricWMZfPBmZs6aj71nW83BppMqJnOSLbaV0WiVzxr/tNR/OHlCpP2FifKi31r3hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781508803; c=relaxed/simple;
	bh=8MQAYgo75cj7/85ZOWo3IXuCH8kbz8FMX/uOaWr9nIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F2owQ0Mcq+QYqhzZzudIgAhGc3vp9c8hEwpk5MLxzCbzcSRJX6K6Ht3ycf/qdDhnbHjcOH/80n5lpbiXk1o8E7VHm858Jw4bQTv99VVfFaR5yGwbAlW8fQfw4tGj1nvJu6wT/4Nf7A17SzRQ1CNJgkV7ekXEz2iPbIx16jJfpm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DD8AC5no; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DD8AC5no"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781508802; x=1813044802;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8MQAYgo75cj7/85ZOWo3IXuCH8kbz8FMX/uOaWr9nIM=;
  b=DD8AC5noWT6g4fb9U5+7qa9ZeEBMjCdR45mYc7Ft4IwzrsOC4v7rRSDs
   +RUwy4IyM9f/Zo9Aa3oBA91m3hpGE3IXG9VuES6E+XnXWnSIK6KNDhC12
   LhDnL9MYfYDImpkypcayd4LwVjpZKno9rcrM4nujOD3Ooy35j6gbahW1m
   Z+pbLmA9U2VJ4Zi/72t/Nn0swYVv3DA+dArTyLrgnNfravCwppR8BdPkC
   hAw06J8EmmASbIT3AjSBom/B78bycGMK/73N3x1jL7fE64gsGmPPwQc1K
   9yqFi21nhOtHjueKaTKZyBd0YWppt1a+5yxQHckyB7q0xu/qqHYLXEDtE
   Q==;
X-CSE-ConnectionGUID: rWKQNnl0TvyHgl2j+f2E5A==
X-CSE-MsgGUID: QiLFDtnNR+KSgEgLoyfPlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="93630979"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="93630979"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 00:33:21 -0700
X-CSE-ConnectionGUID: zaVfgIYlSgWr9DV8PqxcGg==
X-CSE-MsgGUID: WUifVASHTxq10pdlN45TaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="271087964"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 00:33:19 -0700
Message-ID: <8656eff8-9e01-46ca-8037-5696bc012a9f@linux.intel.com>
Date: Mon, 15 Jun 2026 15:33:17 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/30] KVM: x86: Move tdp_enabled from kvm_host.h to
 mmu.h
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-9-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-9-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Relocated the declaration of tdp_enabled into mmu.h, and opportunistically

Nit:
Relocated -> Relocate

> hoist tdp_mmu_enabled up to the top so that the two are co-located.
> 
> No functional change intended.
> 
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

