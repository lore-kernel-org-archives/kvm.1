Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5930E847;
	Wed, 17 Jun 2026 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781666665; cv=none; b=CKT5VzcC5vJxCOISHJKRUg1QtPlTqGRRzYlQlDlOsBaw93PNRXhS09THP+1ECXcx05xTO6fHl4wIncUppKXD95bS4TLRqEJKNVOpvkEx6dP1+uljg9k0rZ2eZ57Y2jHP7vhR4x/Fobt9oJRxUQItzX05F8Jbomhe8gZTy4rnFhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781666665; c=relaxed/simple;
	bh=t1xxz5K4qN1IYVWQH30iGGO+YtYanpKqJtMFDCYmAZs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=X5eeH3CH+b/H2iYqK74IIb2m08LehFagFUOWZNMtmFPbwEn/bC5pfxp55S0MDqx3W6j5NghdYAKDpxu5/nZPeO35C5QEEz7jWdX4p2ESGXGiQP2dZlyXgW3/2TtiEFRR6VOsGCNpzns4Xwupj2W+v9rSJn6qcca3ySayb4/kUVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LA1KyDtw; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LA1KyDtw"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QXpgPLCGZMBAJlhoq6iPX1R1MqV1uv8ilwrrn60/bL8=;
	b=LA1KyDtw3R5x/rV5uAch8d0C04aDQivZ2h4t1Hz9AeLUdzfsQ+ExwOqkzGgnQ2szCDpcKv1LU
	DBdB63k7PKs9cNMqouWifcVcbcvgUQT9VlOS5cZyNVZZdOqeMTT2Q3caCqQSiuweoiKs+LsxSJ7
	bErq0V0cGYCOCWzDBPb4hb0=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gg8By2QM6zKmTb;
	Wed, 17 Jun 2026 11:16:10 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 320BD405D1;
	Wed, 17 Jun 2026 11:24:11 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Jun 2026 11:24:11 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Jun 2026 11:24:09 +0800
Subject: Re: [PATCH v4 5/7] mm: selftests: Add shmem into memory failure test
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
 <20260602-memory-failure-mf-delayed-fix-v4-5-a5bc7db5a9b2@google.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c5758613-38b0-fb9a-81ec-0ef709c786ec@huawei.com>
Date: Wed, 17 Jun 2026 11:24:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260602-memory-failure-mf-delayed-fix-v4-5-a5bc7db5a9b2@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/6/3 5:55, Lisa Wang wrote:
> Add a shmem memory failure selftest to test the shmem memory failure is
> correct after modifying shmem return value.
> 
> Specifically, test the expected behavior under various scenarios
> combining page dirtiness (dirty vs clean) and failure types (hard vs
> soft):
> + Dirty + Hard: Trigger a SIGBUS on injection, and trigger another
>   SIGBUS when reading the page again.
> + Dirty + Soft: No SIGBUS is triggered, and the original value can be
>   read successfully.
> + Clean + Hard: No SIGBUS is triggered on injection, but trigger a
>   SIGBUS when trying to read the page again.
> + Clean + Soft: No SIGBUS is triggered, and the page can be read
>   successfully.
> 
> Signed-off-by: Lisa Wang <wyihan@google.com>

With David's comment addressed:

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.
