Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A53384232
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 07:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785482292; cv=none; b=TRey45fW98oZQOSGB8S6/0Lhn3x1xlZ5cxU1dBYBPc5pKqWIWzsmtDzKc3TlUZwkcxUN9XlmcFUPpZBs2tJUbz06V7kI07kOJ7nZ+w3DEVgc0BFcJemJcvoqcu48eNgtDnVKpxM/NMAntkO9dWwwwEV9MLEcnLPa6OWp93ZBAK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785482292; c=relaxed/simple;
	bh=BKbOyi0VRPpTzj3Ca4t1jMvBi+kCO6q/zrcY3T3kFvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukV65CIX8zEtx2Wm8DeB6PUFNpDx5pTeJ4A/eLPIvdpuLLQA6P4hDc1aMcWCAZdEwmi+Mskw0keMbC4doY3hJKiMMzezibNQv76IVuu+bNgEPtg1WEIIKv/3euYLlqNFqnOo0camQM5AOhsI6qPRVM/wPKby3S+IdFx9BJMQLWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1750312|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0595643-0.0109835-0.929452;FP=9219851515287299419|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.ia839jW_1785482282;
Received: from 172.18.22.107(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.ia839jW_1785482282 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 15:18:03 +0800
Message-ID: <29ac3889-5268-4676-ac6e-4078ba69ae3e@open-hieco.net>
Date: Fri, 31 Jul 2026 15:18:02 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/9] target/i386/kvm: Use AMD PMU MSR paths for Hygon
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
 <20260706055530.1752094-6-zhang_wei@open-hieco.net>
 <amw4x/BFXEJMwbI9@intel.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <amw4x/BFXEJMwbI9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/31/2026 1:55 PM, Zhao Liu wrote:
> To unify similar checks, how about we abstract them into the "PMU vendor
> family"?

Yes, this makes sense. This is a PMU architecture/layout compatibility
check, not a raw CPU vendor identity check. I'll update this in the next
version.


Thanks,
Tina

