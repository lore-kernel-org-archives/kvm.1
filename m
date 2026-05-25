Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8073A7F4A;
	Mon, 25 May 2026 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690287; cv=none; b=QyfnkrfR3hIihmXLx6YtODgpvOAn+LQBl8iE/0AQgHrvCVPERhFuYUKaQjNInNkNpic3nyQM45AcOrtINO5UR9sycRlvc+VDQPcWtPA9t8sPu/g3RSEMFuk8uo1VoPMqSmlL1hUGEl40gD7bUm01VL18eGor0cojMoGlA0ACaJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690287; c=relaxed/simple;
	bh=7QEs99OKEpBp0XzYt0E0idTSIoma9Xjl8SS3oxoRLC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rR6D6PYu8OQWhgrtkysrAVRk/b60+G6et7OkhVO9mOswE7hQW3jguykfAI952zC9Z8nstnE5nLbodzvxFZWKA4uakNnCmE/DPCc6U6Id7zCyy9mRrpgBUnFWqbeELtqOtsRPiT4Hx43EEz5CkHTq63t3boAYkKB7gl/BsjCGGlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hg+CoZQS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hg+CoZQS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779690285; x=1811226285;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7QEs99OKEpBp0XzYt0E0idTSIoma9Xjl8SS3oxoRLC8=;
  b=hg+CoZQSVMogmUdpqgVx4sFWej3WykbWq8gZDgsB9cRIFouxfkRM9Crm
   YuSVukTRscvaTl3tE8k0WUOKXYpl2uQ4HkQuZ+I9uiaqI3T7WJLXcWTqI
   erjv9Sx6nS1d6SYQWlZruAPyKzsso9TA/U8h4Um5qhtqUhT5lPT7xxTWX
   cb0eh03EAqxTFVZQfcO+8UkIAMQvDCdjRr6KcMvvPXzqflpsNSSM4UXtJ
   02OJxccMaD7Mzt2Qec2c9xpHkLlaYguXC0suUhG2Sts/Jy4uzvu6dYbKx
   +TgHp91xFP5nABZkGHZ78o3YiRgy+WYqVNzpi0585Xfcxg/b3tKsGSfY+
   A==;
X-CSE-ConnectionGUID: M+iGs+QsRha8Z6GuRF4MHw==
X-CSE-MsgGUID: bXg+pKLqTPyrqaFjmTaAPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="79656673"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="79656673"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 23:24:45 -0700
X-CSE-ConnectionGUID: codRSZlMS32nwrxhLCDHjQ==
X-CSE-MsgGUID: gzzr8r5ySFiamucLeWDI1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="265356970"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.239.158.44]) ([10.239.158.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 23:24:41 -0700
Message-ID: <8b2f285b-9685-4a66-bfa8-725f4da9896c@intel.com>
Date: Mon, 25 May 2026 14:24:38 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] x86/virt/tdx: Read global metadata for TDX Module
 Extensions
To: Xu Yilun <yilun.xu@linux.intel.com>, kas@kernel.org, djbw@kernel.org,
 rick.p.edgecombe@intel.com, x86@kernel.org, peter.fang@intel.com
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, sohil.mehta@intel.com, yilun.xu@intel.com,
 baolu.lu@linux.intel.com, zhenzhong.duan@intel.com
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-2-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260522034128.3144354-2-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/2026 11:41 AM, Xu Yilun wrote:
> Add reading of the global metadata for TDX Module Extensions.
> 
> TDX Module Extensions is an add-on feature enumerated by TDX_FEATURES0.

> But for the Module's integrity, Linux requires that all features that a
> Module advertises must have a complete, valid set of metadata, 

I doubt on this.

1. Is it a must that any new feature introduces new metadata field?

2. Linux only cares the integrity for the features it uses, not for all 
the features.

> and the
> validation must succeed at core TDX initialization time.
> 
> Check TDX_FEATURES0 before reading these metadata. If a feature is
> advertised, a failure in reading associated metadata causes the entire
> TDX initialization to fail, otherwise skip.

I'm not sure why we need to explain the behavior when the reading fails. 
It's not different to other existing fields.

Instead, I think you can explain why we need to check TDX_FEATURES0_EXT 
at first.

Anyway, I don't read it as a good changelog. It event doesn't tell what 
the added fields are and why we need them.
