Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793257719;
	b=edAcfdoLw1I0yAMLql+KgkRMV9C6UtYLlSLN9SWNqXEDYj4d+8GOCSb6TpploFxr1XFX
	 nhQn4ycBhbXtGmy/KPeulSDuIaFOowHq5+OQMBgRcG3GwhHmEEib+USXHjROA7kF2G7EL
	 cf2uFFbefQh8J6Wm68rf7Qbx+BmzyjtDP6iKwTRplWzjco789704FUs2X4Hbe5jnIB8sl
	 +PAv6JwXzDQ1tRwfNUChlyp4fF4w2NnBSk/2QuY78n2pAwG/qQOzNvMUwSH+l7jPiV3At
	 HyEW47utwORiLnAp0cfQUp+NuCV6h40LY0QoBsUejL0gaNA+WQBe4S7l6MS29FERcnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257719;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=NcG7rziTtzBQo+YgRjjhG7OeEH2wIvONYfErWYNIqjI=;
	b=sdw3UQxYV24FAjEJcxh7k6hnELM4ZhUpZRVwjxe2FYSRrp7ojEUNVA9zTQerbyTNF0h5
	 ab2uqBDbMfVNjHcCCD06rsJJ4tSwskDJvuXexItJzBTq+TbYapj9TxAMcRyBlNE/Z3OBe
	 wlk5NdqGH+zubiszSNOTR83msI0QF4yKnKTz1HQZN6i/+znypZCNvNcxEc0gWTlLBc7q6
	 0TziyJW3JxIOFSLanNp+Bz+hm1mlfGKpSi4TpXkTakv1l2NjcAOZJYkaiNXXV41CEd9vg
	 UBn+12ghSCg6CrgiS9sbKqUU+ggamBAaa4XJf1W4cFbtRkyWf0ds57Zz5trs7D8nZfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b="kfi7zL3/";
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3150C606A31E;
	Thu, 29 Oct 2026 07:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3150C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=kfi7zL3/
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NcG7rziTtzBQo+YgRjjhG7OeEH2wIvONYfErWYNIqjI=;
	b=kfi7zL3/rr8sDCvbxJvwXX+rL/VVtaqKgNez2Wf2ByMEWMm1U6i6ncOOM167EOf6Q1cR13nys
	dz/8xRElyMbITao2PzoSBB43OVCo1PnLXvv8pnBvLtstXdh/0h4EplLxYhFPkF3extdTNeZdKvk
	EjWsN4t64y+XM32LpNJISoQ=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jFb0y2tZ4z1T4kk;
	Thu, 29 Oct 2026 15:08:18 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D83740537;
	Thu, 29 Oct 2026 15:08:29 +0800 (CST)
Received: from [10.67.120.103] (10.67.120.103) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 29 Oct 2026 15:08:28 +0800
Message-ID: <6d2411a3-b37b-4cdb-80ca-10654cc88a17@huawei.com>
Date: Thu, 29 Oct 2026 15:08:27 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/15] KVM: arm64: pgtables: Change write bit from
 S2AP_W to DBM
To: Leonardo Bras <leo.bras@arm.com>
CC: Oliver Upton <oupton@kernel.org>, <maz@kernel.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<pbonzini@redhat.com>, <yuzenghui@huawei.com>, <wangzhou1@hisilicon.com>,
	<yangjinqian1@huawei.com>, <caijian11@h-partners.com>,
	<liuyonglong@huawei.com>, <tangchengchang@huawei.com>,
	<yezhenyu2@huawei.com>, <yubihong@huawei.com>, <linuxarm@huawei.com>,
	<joey.gouly@arm.com>, <kvmarm@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<seiden@linux.ibm.com>, <suzuki.poulose@arm.com>, <fuad.tabba@linux.dev>,
	<mark.rutland@arm.com>, <seanjc@google.com>, <rdunlap@infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<skhan@linuxfoundation.org>
References: <20260929103655.85107-1-zhengtian10@huawei.com>
 <20260929103655.85107-2-zhengtian10@huawei.com> <arxW4PUY3qqRkogl@kernel.org>
 <8ca88576-651a-4b7f-91ff-2cb2359aa79e@huawei.com>
 <at9raEVrsbb7rj6n@LeoBrasDK>
From: Tian Zheng <zhengtian10@huawei.com>
In-Reply-To: <at9raEVrsbb7rj6n@LeoBrasDK>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr100010.china.huawei.com (7.202.195.125)



On 10/26/2026 11:02 PM, Leonardo Bras wrote:
> On Wed, Sep 30, 2026 at 10:44:26AM +0800, Tian Zheng wrote:
>> On 9/30/2026 8:25 AM, Oliver Upton wrote:
>>> Hmm... I'd actually like to see this structured where the "write" bit
>>> could either be S2AP_W or DBM depending on if the system supports
>>> FEAT_HAFDBS. Look at how HVHE is handled for selecting the right AP
>>> encoding for the hyp stage-1 page tables.
>>>
>>
>> Hi Oliver,
>>
>> Thanks for the suggestion. I missed the case where FEAT_HAFDBS is not
>> supported. Systems without the feature should keep the original
>> encoding, with S2AP[1] as the write permission bit. I'll follow the HVHE
>> pattern to select between the two encodings in the next version.
>>
>> Thanks!
>> Tian
>>
> 
> Hi Oliver, Tian,
> 
> After some digging, I think it would be better if we kept using S2AP[1] as
> a writable bit, while DBM can be treated as "Can promote a non-writable
> page to writable if HAFDBS=on".
> 
> I know it's not that intuitive, as the Arm ARM even introduced the concept
> of Writable-clean an Writable-dirty, but I think it will be the best way of
> referring to what was intended of the bit.
> 
> I wrote down what I mean by that:
> https://lore.kernel.org/all/20261026144413.441566-1-leo.bras@arm.com/
> 
> tl;dr:
> - DBM + S2AP[1] is set on writable entries (KVM_PGTABLE_PROT_W)
> - Writable detection is made only on S2AP[1], so no changes
> - Wrprotect sets S2AP[1]=0 from the PTE, and also DBM=0 if it's a block
> 
> On dirty-tracking:
> - If HAFDBS=0 : no functional change, DBM bit there but unused
> - If HDBSS=1
>    - Pages: writable-clean promoted to writable-dirty on write, HDBSS does
>      the tracking
>    - Blocks: faults on write, splits in pages, pages get DBM=1.
>    	(argh, I think we need a PROT_DBM for that)
> 
> Does that make sense?
> 
> Thanks!
> Leo

Hi Leo,

Got it. I'll wait for the conclusion of your discussion with Oliver
before proceeding.

Thanks,
Tian

