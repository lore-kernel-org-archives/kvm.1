Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368FC1E4BE;
	Tue,  7 Apr 2026 03:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775534162; cv=none; b=nZIyxZyOzRLruHjkL/ErFI33pzToQlwubqOucsIaFR6nPyRCUCVd36gmtuOd91e0/7L6vUMWcA9qy9GiJfTFpZkttDPo5kjoj7Xa27j/bGlEEJMVnmqrxCzJnfReDIQJVA8sdhbwVJQ1KCxVesxKkfXf+baxYkmIAj5ea/zc4Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775534162; c=relaxed/simple;
	bh=5dUvt3kRQqn76vxWTecrFUMU+Wj1DXXflX7Q0MpR1AI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WaF6WpK5SSiBYDoJW7fIDxZGQWMUEkAlQXsKnMI6MG8/oVkbpdwW83oInx2yA/mxYfNz4JVbMKeo/2Hqk2nhvYYpdgCCYhPik9nMRUnRpwCKCXeV4fY+C5noMtlITkjLJ8GExVfNeHWjj9UsYIHHJsg/QM2r0wJ34MZhFRt2yMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=uhKBDx9C; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="uhKBDx9C"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=N/SN3cde34vYrXXv9Yap1E3YMIsPr4AanC6zRI3cK0k=;
	b=uhKBDx9CRiP9dznDHPcAkzvQcYzKf+KKMOiPGcXiexycWbsSTMd1KgFwfPAHLOxP3YyQrMynU
	pagQ1IEkx1g07P4uhWYC2vBErW7iTxaB4srAQ+vsATgYjVbNx3cleQrVnxqXszYZn/tMo2UX/Pn
	z6W9yX1IZSPrP9YF2Kkcwzo=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fqXJ74B00znTVg;
	Tue,  7 Apr 2026 11:49:27 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B43140565;
	Tue,  7 Apr 2026 11:55:50 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Apr 2026 11:55:50 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Apr 2026 11:55:48 +0800
Subject: Re: [PATCH RFC v2 2/7] mm: memory_failure: Allow truncate_error_folio
 to return MF_DELAYED
To: Lisa Wang <wyihan@google.com>
CC: <rientjes@google.com>, <seanjc@google.com>, <ackerleytng@google.com>,
	<vannapurve@google.com>, <michael.roth@amd.com>, <jiaqiyan@google.com>,
	<tabba@google.com>, <dave.hansen@linux.intel.com>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Hugh Dickins
	<hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, "David
 Hildenbrand" <david@kernel.org>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-0-92c596402a7a@google.com>
 <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-2-92c596402a7a@google.com>
 <2f177e0f-2eb0-48d0-b48c-7a0a340caf5d@huawei.com>
 <adA_1zXLUBqmSHFl@google.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5c5dfa85-baab-5c0f-6f6d-b71abbe10ed8@huawei.com>
Date: Tue, 7 Apr 2026 11:55:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <adA_1zXLUBqmSHFl@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/4/4 6:31, Lisa Wang wrote:
>> On Mon, Mar 30, 2026 at 03:02:01PM +0800, Miaohe Lin wrote:
> [...snip...]
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -941,6 +941,8 @@ static int truncate_error_folio(struct folio *folio, unsigned long pfn,
>>>  	if (mapping->a_ops->error_remove_folio) {
>>>  		int err = mapping->a_ops->error_remove_folio(mapping, folio);
>>>  
>>> +		if (err == MF_DELAYED)
>>> +			return err;
>>
>> Will it be better to add a pr_info here to provide some information for users?
>>
>> Thanks.
>> .
> I think we don't need to add pr_info here; truncate_error_folio() always
> leads to action_result, which already logs the recovery status.

No strong opinion but I want to make code style more consistent with sth. like below:

if (err == MF_DELAYED)
	pr_info xxx
else if (err != 0)
	pr_info("%#lx: Failed to punch page: %d\n", pfn, err);
else if (!filemap_release_folio(folio, GFP_NOIO))
	pr_info("%#lx: failed to release buffers\n", pfn);
else
	ret = MF_RECOVERED;

Thanks.
.

