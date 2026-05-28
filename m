Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0848BEEA8;
	Thu, 28 May 2026 03:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779939102; cv=none; b=e2djABRs3TC4b1KLcOZf2aX7fdP6LW2s3U+T/XbbYMnoZoYnWP6+r1RbQ89YljPHDkJgWNk9Pg1mS94YrGSVGKineXEb74FW1TZfmHjgVYX9fea/Ea7bnv+N4Khgllc6XRLe8BIPFt9UTtHPnbBE2mxvC5qw/q/OJcZfA7MFfJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779939102; c=relaxed/simple;
	bh=DMPnp/jyAet9uJC9R6NBEgWBUA5/5QsJUGswhhYrs/Q=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Hu9Gzkam9Zkl1HzWdpYKIqia4uzbLeyCjU7dJV7Xhg6GYkD2fQkBotgAySdDWgUnBjYh/UPzaGwnqkgYp51PfvUHsg+W6h7z3/+I5Sue1uvRTjbARcBEKQfOhWW044yPEH+nqa1HcbPwXbH0JvoauIMBZwgb9DQ4ks1TJQy2/VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=AGMvFtGV; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="AGMvFtGV"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=c5Hk8QYPMIPNx8ud4lNIyGEeROuyNFJv+XxWeF1fn+k=;
	b=AGMvFtGVwo6Y0FHx8ka/ETADMQfqFwzqcD1HYVjhSZUd6/XUeReV/gHwMQJIZ09YEab+gT9Fg
	NmLag4kgDCv/OxazIufHenWHXQV2yvL/55BwNXDX39TJgPoP+nERrRPgbhocQRBhk9SFKAIYR1q
	Oe/hLUGX4t/K+Dr9p/UNT6w=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gQsJq6rdbz1prMF;
	Thu, 28 May 2026 11:23:39 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 951064056A;
	Thu, 28 May 2026 11:31:28 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 May 2026 11:31:28 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 May 2026 11:31:26 +0800
Subject: Re: [PATCH RFC v3 5/7] mm: selftests: Add shmem into memory failure
 test
To: Lisa Wang <wyihan@google.com>
CC: <rientjes@google.com>, <seanjc@google.com>, <ackerleytng@google.com>,
	<vannapurve@google.com>, <michael.roth@amd.com>, <jiaqiyan@google.com>,
	<tabba@google.com>, <dave.hansen@linux.intel.com>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Hugh Dickins
	<hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, "David
 Hildenbrand" <david@kernel.org>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, <linux-kselftest@vger.kernel.org>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
References: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-0-718f45eb7c75@google.com>
 <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-5-718f45eb7c75@google.com>
 <9effbeca-3453-f0fe-571f-85f8923e1385@huawei.com>
 <ahcjRGwLFEN2NH3b@google.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <85ae0dea-3f49-3102-059f-55f5f67c91ac@huawei.com>
Date: Thu, 28 May 2026 11:31:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ahcjRGwLFEN2NH3b@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/5/28 1:00, Lisa Wang wrote:
>> On Mon, Apr 13, 2026 at 07:57:55PM +0800, Miaohe Lin wrote:
> [...snip...]
>>> -
>>> +	case MADV_SOFT_DIRTY_SHMEM:
>>>  		/* The page content should remain unchanged. */
>>>  		ASSERT_TRUE(check_memory(vaddr, self->page_size));
>>
>> Why we skip check_memory() for case MADV_SOFT_CLEAN_SHMEM?
> 
> Because we did not write 0xce to clean_shmem.
> The difference between clean and dirty pagecache is whether we synced
> the dirty pages to disk. However, the difference between clean and dirty
> shmem is whether we initialized it with 0xce. Thus, we need to skip
> check_memory(), which checking 0xce,  for clean_shmem.

Got it.

> 
>>> +	case MADV_HARD_CLEAN_SHMEM:
>>> +	case MADV_SOFT_CLEAN_SHMEM:
>>> +		/* It is not expected to receive a SIGBUS signal. */
>>> +		ASSERT_EQ(setjmp, 0);
> [...snip...]
>>> +   if (variant->type == MADV_HARD) {
>>> +           check(_metadata, self, addr, MADV_HARD_DIRTY_SHMEM, ret);
>>> +		ret = sigsetjmp(signal_jmp_buf, 1);
>>> +		if (ret == 0)
>>> +			FORCE_READ(*addr);
>>> +		check(_metadata, self, addr, READ_ERROR, ret);
>>> +	} else {
>>
>> Should we always add a FORCE_READ() just after variant->inject to verify the accessibility
>> to the addr for soft-offline case ?
>>
>> Thanks.
> 
> In dirty_shmem, check() already verifies accessibility to the address
> through memcmp(). Thus, we only need FORCE_READ() in clean_shmem. Will
> add this in the next version. Thanks !

Thanks for your work.
.

