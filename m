Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C03637BE80;
	Mon, 30 Mar 2026 07:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774854778; cv=none; b=mohgH/1nc33LVxyMihdUwJHMKw04G/QpK15yd1fKlfO8nxmawc8B4hsDys7vsbpyGVltPLmagYTFVWqGxXOIa4SYpU8RoTIisq7OwZ/6j5KSqwtAk/cBpMWGPZsvEIFzVxAHWbHGZRgh6jFsv+u2TTEGAqfe7ueQnrlNkbfRagA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774854778; c=relaxed/simple;
	bh=bEw+Cf+J+04/foRIiwQkPG8Joxe7gaEMd75c7gM0g+Q=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DzBE+rTtBgvtYm26qjAbq6AuC+MsxMhoXrNaiDv5hhu6DNWJS/IV5a2wN6a83rd2q7FsCc8Ije7boR93InDwA1/p71eblYbBB28cWeZhueeZ6k5QtCkgDvsf2wzF7M4z+NR8lZvZ8gi4J1MbbMYJVJmQ6l0kS9d53xcsbqbHq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=p229gL7j; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="p229gL7j"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vxHhFY8CnfVycioBKVd9CORZwlMpeneq2TR+IbnwoHk=;
	b=p229gL7j0wh9odCIlSr4SdDEvlLtoODBkFb+g8QtwXSNn7qpbpMOkxoprw60uisKi5It8Mleb
	jpAMIeWBTgqRAVwstD5ooinNDY7bnJP2a7ur7uWYyGsDChMLOS/1doh9OYTq31EpQ2oKvksuq+5
	jELvT8R9KL13EDZNkSqg5xQ=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fkj3J3YzTz1prKT;
	Mon, 30 Mar 2026 15:06:36 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D383440561;
	Mon, 30 Mar 2026 15:12:47 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Mar 2026 15:12:47 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Mar 2026 15:12:46 +0800
Subject: Re: [PATCH RFC v2 5/7] mm: selftests: Add shmem memory failure test
To: Lisa Wang <wyihan@google.com>
CC: Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Hugh Dickins <hughd@google.com>, David Hildenbrand
	<david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>,
	"Mike Rapoport" <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
	"Michal Hocko" <mhocko@suse.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <rientjes@google.com>,
	<seanjc@google.com>, <ackerleytng@google.com>, <vannapurve@google.com>,
	<michael.roth@amd.com>, <jiaqiyan@google.com>, <tabba@google.com>,
	<dave.hansen@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-0-92c596402a7a@google.com>
 <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-5-92c596402a7a@google.com>
 <78a855da-8fc2-4e85-90a0-6bf9af030c02@linux.alibaba.com>
 <acHeLL0l948jRchK@google.com>
 <52c26e05-5bbc-4f63-84bf-c4879a6de7d1@linux.alibaba.com>
 <accjlG9lUyDQO_mz@google.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f822616d-ad09-e408-147a-503381cd3333@huawei.com>
Date: Mon, 30 Mar 2026 15:12:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <accjlG9lUyDQO_mz@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/3/28 8:40, Lisa Wang wrote:
> On Tue, Mar 24, 2026 at 08:36:36PM +0800, Baolin Wang wrote:
>>
>>
>> On 3/24/26 8:43 AM, Lisa Wang wrote:
>>> On Sat, Mar 21, 2026 at 02:30:04PM +0800, Baolin Wang wrote:
>>>>
>>>>
>>>> On 3/20/26 7:30 AM, Lisa Wang wrote:
>>>>> Add a shmem memory failure selftest to test the shmem memory failure is
>>>>> correct after modifying shmem return value.
>>>>>
>>>>> Test that
>>>>> + madvise() call returns 0 at the first time
>>>>> + trigger a SIGBUS when the poisoned shmem page is fault-in again.
>>>>>
>>>>> Signed-off-by: Lisa Wang <wyihan@google.com>
>>>>> ---
>>>>
>>>> Why not move the shmem memory failure test into memory-failure.c?
>>>
>>> Do you mean let memory-failure.c kernel code check by itself?
>>> The reason I write the selftest instead of combining in memory-failure.c
>>> is because
>>> + do not need extra checking code in kernel code
>>> + make it easier to trace the entire execution flow, starting from the
>>>    madvise() down through shmem_error_remove_folio() and into the
>>>    truncate_error_folio() logic.
>>>
>>> Pleas let me know if I've missed something. Thanks!
>>
>> That's not quite what I meant. I mean, since there is already a
>> memory-failure.c in mm selftests (see [1]), I think we should move the shmem
>> memory failure test cases into that file.
> 
> Got it. Thank you for pointing out.
> Is anyone currently working on the shmem memory failure test? If not, I
> will merge it into my next version.

I'm working on shmem testcases. But please feel free to add it. I could move to
work on other scenarios.

> 
> I have a question regarding the current implementation:
> ```
> ret = sigsetjmp(signal_jmp_buf, 1);
> if (!self->triggered) {
> 	self->triggered = true;
> 	ASSERT_EQ(variant->inject(self, addr), 0);
> 	FORCE_READ(*addr);
> }
> ```
> Here is difficult to distinguish whether the SIGBUS is triggered by the
> injection or the read operation. I am considering splitting these into
> two separate SIGBUS jump blocks. Is it reasonable for me to split them?

It might be better to add two separate testcases, i.e. one for SIGBUS triggered
by injection, another one for SIGBUS triggered by read operation if possible.

Thanks.
.
