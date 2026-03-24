Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9C43D47B3;
	Tue, 24 Mar 2026 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355805; cv=none; b=J0FrEvxlzGVjnYA9FKGuL3jKQqhkrg2F4yWimp0WrXit89NoiJYufLAD3MC9hmTc/ymhbsWuMnCitMYIjF+dVSEJ07c84FtMeUjeV5M99Dhl8yG6YIc0epk/YUO2cbZ30XqrBL6Xr73cLlnS+yTtw27B5SokX42c3U4LE33DTVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355805; c=relaxed/simple;
	bh=6LAgfuE8PM3f0lc0stGjabRMCEBuAblH4igPBqp4HX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9s+j+tg/KcUoeAHxnmagIfGbtve3kV3kATziHlOrhb0TGmraeTpl0e+xlQoudKHW0g8nbQn83fAvso1t5b4abxZFjzSZOESoowmf7z75FbXGSEC/CxXs2SATckPzoeikkR5hlV+fxg/PIGcUbPbrIyXpPlKe/+1lt3Mv+Dx73Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=W8qWhQFB; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="W8qWhQFB"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774355799; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gsbBTSXyjpjhQEZuCSqVwoWgeHUnKm4qEkYJLH/MHak=;
	b=W8qWhQFB3hB4MQueuAre0jwk2hStSFwdVRWO66uQTzZFPLPceOs0ePpbyKDG9t/j5A75FRBz1EmBeGwm18tVYct/n5+cO/9WM+T1aZ8nnVq+VKBv3Ob+WFZDF/p7WtHz+In2RXhV/+wGXL5rnYKPfRmavuidUEaIhQan05zDH8Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0X.eWiee_1774355796;
Received: from 30.42.98.36(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.eWiee_1774355796 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Mar 2026 20:36:37 +0800
Message-ID: <52c26e05-5bbc-4f63-84bf-c4879a6de7d1@linux.alibaba.com>
Date: Tue, 24 Mar 2026 20:36:36 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 5/7] mm: selftests: Add shmem memory failure test
To: Lisa Wang <wyihan@google.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Hugh Dickins <hughd@google.com>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, rientjes@google.com, seanjc@google.com,
 ackerleytng@google.com, vannapurve@google.com, michael.roth@amd.com,
 jiaqiyan@google.com, tabba@google.com, dave.hansen@linux.intel.com
References: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-0-92c596402a7a@google.com>
 <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-5-92c596402a7a@google.com>
 <78a855da-8fc2-4e85-90a0-6bf9af030c02@linux.alibaba.com>
 <acHeLL0l948jRchK@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <acHeLL0l948jRchK@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/24/26 8:43 AM, Lisa Wang wrote:
> On Sat, Mar 21, 2026 at 02:30:04PM +0800, Baolin Wang wrote:
>>
>>
>> On 3/20/26 7:30 AM, Lisa Wang wrote:
>>> Add a shmem memory failure selftest to test the shmem memory failure is
>>> correct after modifying shmem return value.
>>>
>>> Test that
>>> + madvise() call returns 0 at the first time
>>> + trigger a SIGBUS when the poisoned shmem page is fault-in again.
>>>
>>> Signed-off-by: Lisa Wang <wyihan@google.com>
>>> ---
>>
>> Why not move the shmem memory failure test into memory-failure.c?
> 
> Do you mean let memory-failure.c kernel code check by itself?
> The reason I write the selftest instead of combining in memory-failure.c
> is because
> + do not need extra checking code in kernel code
> + make it easier to trace the entire execution flow, starting from the
>    madvise() down through shmem_error_remove_folio() and into the
>    truncate_error_folio() logic.
> 
> Pleas let me know if I've missed something. Thanks!

That's not quite what I meant. I mean, since there is already a 
memory-failure.c in mm selftests (see [1]), I think we should move the 
shmem memory failure test cases into that file.

[1] 
https://lore.kernel.org/all/20260206031639.2707102-1-linmiaohe@huawei.com/T/#m18e62ccb3e87316ec37dcde9389c1ba1c56d0951
