Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F427384233;
	Tue,  9 Jun 2026 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992223; cv=none; b=D4bnnPtO/moLm+LcjGMr8qO/mi2p16QM6RDUmQOguA5PQ59DECLQTFgWY9+VYrx4oLg/5avYMcJv/YLbl4oJ83sSxF0he5ahorxcYWoy8EhGnhKJipXszo69kUun5o53j4wXNRECI1yAyhFQWOS+h09YnSClzctcvsRVRFOUA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992223; c=relaxed/simple;
	bh=tcPEnFaGHlyq3HGOis5Z/JiQSEi5N9zhgX+AvfVV4FY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rCgISG9aM+I9m5eH1YQkxV9ETXVtk4PPQ5vVfPiqLGLKShaj8IteyT+FalaQDuw6TzIsNbttjKbo34j6iuL47Nco4b3MsEuL1oo+WXOy79jejCV0ZcfEde0p5xxVhJmDllN1UthPYSgbOGioo2HqNcvaZ7lKr48vgTfAe1ZC5RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xQAuBxMb; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xQAuBxMb"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HlBlOHMPbvtbUB1n/vkZ2Ftsfcpe6TvbqLXbZg5mnVk=;
	b=xQAuBxMb8mzsb7Jf7ox4zUkRKG53+Cimxagzt8XKYaOjdENJso8ZC07weXNRQH5oR687sy+m6
	uXXB+h8Fi4Kp8IbHwqYAtIXlS6EWgn4Ic3ovMEgUrzAUwgGaWTXAQWhBYp6VKMDgM8ICPj468nr
	/yxBP9dKfByAYRac+9pNCAs=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gZLn15GD0zKm4s;
	Tue,  9 Jun 2026 15:55:33 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id C430940565;
	Tue,  9 Jun 2026 16:03:29 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jun 2026 16:03:29 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jun 2026 16:03:27 +0800
Subject: Re: [PATCH v4 4/7] mm: memory_failure: Generalize extra_pins handling
 to all MF_DELAYED cases
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
References: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
 <20260602-memory-failure-mf-delayed-fix-v4-4-a5bc7db5a9b2@google.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1fcac146-cb21-7012-3eeb-e4bcc6d9ac0b@huawei.com>
Date: Tue, 9 Jun 2026 16:03:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260602-memory-failure-mf-delayed-fix-v4-4-a5bc7db5a9b2@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/6/3 5:55, Lisa Wang wrote:
> Generalize extra_pins handling to all MF_DELAYED cases not only
> shmem_mapping.
> 
> If MF_DELAYED is returned, the filemap continues to hold refcounts on the
> folio. Hence, take that into account when checking for extra refcounts.
> 
> As clarified in an earlier patch, a return value of MF_DELAYED implies that
> the page still has elevated refcounts. Hence, set extra_pins to true if the
> return value is MF_DELAYED. This is aligned with the implementation in
> me_swapcache_dirty(), where, if a folio is still in the swap cache, ret is
> set to MF_DELAYED and extra_pins is set to true.
> 
> Signed-off-by: Lisa Wang <wyihan@google.com>

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.
