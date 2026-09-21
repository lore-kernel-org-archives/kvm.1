Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384C151AEEA;
	Mon, 21 Sep 2026 22:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790030335; cv=none; b=GBwTYpNTsuRQrFuU64Fq2lNghhNxHjQ9l2TbQ+yKF2qYYa33t6NUSDHtN0FqIGtKq70Z4kOOdi/KWZ8XeN8f9s7C0qMvgE7nTzdZPyW+d9lgB3lPFNd1qCURD5GucwvyxQRfT+ZiYLDZl5pwzPSE5rTH4aR6UPejtY01MCZ5LNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790030335; c=relaxed/simple;
	bh=3g0q7Ij9nzRcg2zVM4o/E4Ackcg7ngcc2tKqZAwliBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLCGwIvoh2lF/H3FErw0pDolw3Tp6Qcu6MvMbChQw5Z4RpeyW6qj54+0kXYi0LJDWlzlJFbCleIlHS0GYI0gx3GYiaV7ql79MgZrXGVnG9TWi+0NYN4l49edH6UfQQLnveHw6LqZzSF3MWsL2nu5PVZOfPgQFaCOIRESlYmnGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mwK/wwZM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mwK/wwZM"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5E2416A3;
	Mon, 21 Sep 2026 15:38:47 -0700 (PDT)
Received: from [10.57.9.187] (unknown [10.57.9.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0551A3F632;
	Mon, 21 Sep 2026 15:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790030331; bh=3g0q7Ij9nzRcg2zVM4o/E4Ackcg7ngcc2tKqZAwliBo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mwK/wwZMN6yHUYXxM1HJ7kFXqzV3zwL8DSbcAGQh0dzeQjRE0daZvgBihhsFgCzmQ
	 o6RvVhDa6Pq3B2Pgf6skBdfv33eDcsdpg8RrD3Jec4uDn045zelu7Xq4amMww+CfBv
	 lY5k3bKOBitGl5MXvPr0OZk5aqqwTIcKlRpyhz2I=
Message-ID: <994feeea-87ab-44a9-bbc1-091e93fed8b6@arm.com>
Date: Mon, 21 Sep 2026 23:38:46 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 0/7] firmware: arm_rmm: Add RMM v2.0 base RMI support
Content-Language: en-GB
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org,
 will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, steven.price@arm.com,
 aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
References: <20260912083611.2513845-1-suzuki.poulose@arm.com>
 <20260921145338.000070e0@oss.qualcomm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20260921145338.000070e0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/09/2026 22:53, Jonathan Cameron wrote:
> 
>>
>> [1] RMM spec : https://support.arm.com/documentation/den0137/2-0bet3/
>> [2] This series: https://gitlab.arm.com/linux-arm/linux-cca.git cca/cca-host/fw_rmm/v18
> Not seeing this branch.  I wanted to sanity check on discussion in the thread and
> was being lazy so didn't want to check out the branch I built for review.

Apologies, I missed it. I have done so now.

Thanks
Suzuki

> 
> J
> 

