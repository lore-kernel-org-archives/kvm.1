Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20C5283FD4;
	Sat, 21 Mar 2026 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774074614; cv=none; b=TP8QubCzmH1oPVFBJeZjqZGfjXXWEaVH/4Xuq0iUbSaueNQu5VKid0V9IInCW5WS2mz2bfi5DDGJc4zn5kyBlk32HElkcPifaSXkXvXeuF87Hf5u1ws0jIX5+W1vaChcyWlAapyvO19k4DVLvHfNl3dVJQC5n1grJTNaZmDxYSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774074614; c=relaxed/simple;
	bh=9MvAYMoIZEEjk8GHBm4yxtzTz7MoHSnIjmv3D7Jefk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+Dt1WIyBc5GG4elsONzfLEiPmsF0ovGWCdN+m541+GfAxjR8QmyLgEV9CS+FYzi4yNxochHroyDMnjuNo2//Gi5G5KxALNh7sUyY923trtYivZvBD1YqUduMzoLGmjlAoafbXcrB31IMfqlqyFwSRGrr8H70c+26Jmss6rqvPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=njWwmqRp; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="njWwmqRp"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774074608; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gM+fv1OX3vBODJfoWDYk+AU+Hzbvk2rJwSdiRSKHo7w=;
	b=njWwmqRpegNRx8UuwwgBdm1iJ0RDx8ClRs1p30NIXcYiLdcBffyAVWofpjT+1Jcu3gSJoL9+CAsx0fybz/oK/0LhQooJxlGV8Z8VMsKIPF4srWE3y+KGjwQqy7a0Wit2yTMfrAyKl9tYaNbSoER71MbmF6mvwMA3yf37O+3OWbc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0X.O7cqx_1774074604;
Received: from 30.42.98.36(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.O7cqx_1774074604 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 21 Mar 2026 14:30:06 +0800
Message-ID: <78a855da-8fc2-4e85-90a0-6bf9af030c02@linux.alibaba.com>
Date: Sat, 21 Mar 2026 14:30:04 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 5/7] mm: selftests: Add shmem memory failure test
To: Lisa Wang <wyihan@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Hugh Dickins <hughd@google.com>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: rientjes@google.com, seanjc@google.com, ackerleytng@google.com,
 vannapurve@google.com, michael.roth@amd.com, jiaqiyan@google.com,
 tabba@google.com, dave.hansen@linux.intel.com
References: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-0-92c596402a7a@google.com>
 <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-5-92c596402a7a@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-5-92c596402a7a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/20/26 7:30 AM, Lisa Wang wrote:
> Add a shmem memory failure selftest to test the shmem memory failure is
> correct after modifying shmem return value.
> 
> Test that
> + madvise() call returns 0 at the first time
> + trigger a SIGBUS when the poisoned shmem page is fault-in again.
> 
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---

Why not move the shmem memory failure test into memory-failure.c?
