Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAC82B9BA;
	Fri, 19 Jun 2026 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881465; cv=none; b=e72krWnLOCOJ1b9+ES4eXn6rSWoRlf/+W0NlUTBKqUs6edGXUBDUJiKlQcIVT8uPc6pgR8ePd5MqdMcMj0LiXSzIEiiMFs9qisOBfPLwMNZrr40PfbgoodLvuVAxTqeGp1hNpEbNwWavBaACH9o1oRu/Um6oKeNTFZTZHQ6UYmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881465; c=relaxed/simple;
	bh=KVPM8oTe1yjPB2sYuDI6/O8b4PeAra3PYXJMker2JLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=McWYWCee/zzj/y0H7ZgH9uAtElvl9nHAqwegqE5w1byRHgEwqlkMD+GFpgkQIaSte2AL6heQ3ec77hibYBwlMS0VajfJT7B8utgDX4tD9cuCeLrXQGTokYMh5vyE3NEr9RY/TklviP7jo0//aN/v8eq0mB7v2LzCs4hdGbkLoog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=inj5HqnB; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="inj5HqnB"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19EFB2681;
	Fri, 19 Jun 2026 08:04:18 -0700 (PDT)
Received: from [10.57.95.87] (unknown [10.57.95.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 508733F763;
	Fri, 19 Jun 2026 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781881462; bh=KVPM8oTe1yjPB2sYuDI6/O8b4PeAra3PYXJMker2JLI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=inj5HqnB3HLhB+ZOcTo+EJb6Yle1ZdReFsOucB2IoDGXAbl402HqynAjesZJ7ZyUI
	 PKZezIX9nr1MxzU5+AYZf+R+ik28jyuv824kIAM0qOe9q6g2fYVmakv5qlPdd8bxb+
	 k/7AG55oSfmVoe2C82dT4actPwK5wN9OxP/3jGVg=
Message-ID: <160f8cdf-0d26-43f3-b487-4181e6374782@arm.com>
Date: Fri, 19 Jun 2026 16:04:18 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: Request THP-aligned mmap for device fds
Content-Language: en-GB
To: Lorenzo Stoakes <ljs@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Anthony Pighin
 <anthony.pighin@nokia.com>, linux-kernel@vger.kernel.org,
 Kefeng Wang <wangkefeng.wang@huawei.com>, kvm@vger.kernel.org,
 linux-mm@kvack.org, "Liam R. Howlett" <liam@infradead.org>
References: <20260616180129.160016-1-anthony.pighin@nokia.com>
 <20260616163054.77fdb61a@shazbot.org> <ajKtdCN0AlbmBnAj@x1.local>
 <ajLontmFa1oRXeoK@casper.infradead.org> <20260617192928.GB231643@ziepe.ca>
 <ajQDVAu9b-LX8gUQ@lucifer>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ajQDVAu9b-LX8gUQ@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/2026 15:55, Lorenzo Stoakes wrote:
> +cc Ryan for contPMD
> 
>>
>>> And maybe there's a CONTPMD architecture we should also consider?
>>
>> ARM HW supports "CONTPMD" but I suppose it is not implemented..
> 
> Maybe Ryan has thoughts?

Sorry not quite sure what you're asking so will give a generic answer:

Arm arch does indeed support CONTPMD at level 2 in the same way that it supports
CONTPTE at level 3, as follows:

+-----------+-----------+-----------+-----------+-----------+
| Page Size |  CONTPTE  |    PMD    |  CONTPMD  |    PUD    |
+-----------+-----------+-----------+-----------+-----------+
|    4KB    |   64KB    |    2MB    |    32MB   |    1GB    |
|   16KB    |    2MB    |   32MB    |     1GB   |           |
|   64KB    |    2MB    |  512MB    |    16GB   |           |
+-----------+-----------+-----------+-----------+-----------+

For HugeTLB, Linux/arm64 support all of the listed sizes today. For !HugeTLB
(i.e. THP, large file filos) Linux/arm64 supports CONTPTE and PMD only. We could
(and probably would) extend to support CONTPMD once THP PUDs are supported.

Not sure if that answers the question?

Thanks,
Ryan

> 
>>
>> Jason
> 
> Thanks, Lorenzo

