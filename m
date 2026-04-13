Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AE03BED17;
	Mon, 13 Apr 2026 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080920; cv=none; b=ZiGw933jGTtyrai/6D270oR6zBPBBW13yRPbBKnNnCxpuFpKNmo6Jkae4tr4V7VYy9eGIF5KYIsbYqN0n6A/OhaT8YfBJfR3vNop641PylNcJSIdqiB1kkO22IZTNoJtdJZB1lTljs60I/BGLIWJLSD62J3g0aiccnaWSfYyNIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080920; c=relaxed/simple;
	bh=J/V7imGqwxMANwXYE8o5+Cwio01SLhKfcCJvKYu0050=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=h25M2Ubbb3mHFbzifqzZqbcKl4ykrTUOVDZsj7cS5QEmjOzvNcFly9AwFkoyPDsIwOLRYGlzDFU+t/Z8CneJQvko1lBPqk6MY0N1ROyNUut4hecz9hxQCMifqDeMA11EosPEeFSGMu1isfenJR6wZycjFTR0d2FeMVd0SVXop0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yYd4zdpn; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yYd4zdpn"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5bIyFtZevOlWJJtQOYjmineyJGabrQz1O42l7hIuFeE=;
	b=yYd4zdpnu7pyUMZhMTOR3q9BYpmDqiI1jW6R3cMAOPr75xQxxN0yXtI1mf/S6uXhpEFkEnDjd
	Nei5m8aQGEjGSYJYPdSu7Bhu8hDfVbTvPZLEVsdC2uF15mtEy1v3ss6FUrQhL5I5ZodNzfzTIDf
	7qivL0kLem8Lltx7ZMCqTjQ=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fvQWJ4D2Mz1T4Gh;
	Mon, 13 Apr 2026 19:42:36 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 8ECA240576;
	Mon, 13 Apr 2026 19:48:34 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Apr 2026 19:48:34 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Apr 2026 19:48:33 +0800
Subject: Re: [PATCH RFC v3 0/7] mm: Fix MF_DELAYED handling on memory failure
To: Lisa Wang <wyihan@google.com>
CC: <rientjes@google.com>, <seanjc@google.com>, <ackerleytng@google.com>,
	<vannapurve@google.com>, <michael.roth@amd.com>, <jiaqiyan@google.com>,
	<tabba@google.com>, <dave.hansen@linux.intel.com>, Hugh Dickins
	<hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, "David
 Hildenbrand" <david@kernel.org>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>
References: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-0-718f45eb7c75@google.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c308144f-e240-153c-d6d4-bf4ef4db0457@huawei.com>
Date: Mon, 13 Apr 2026 19:48:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-0-718f45eb7c75@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/4/9 1:24, Lisa Wang wrote:
> Here's a third revision to fix MF_DELAYED handling on memory failure.
> 
> This patch series addresses an issue in the memory failure handling path
> where MF_DELAYED is incorrectly treated as an error. This issue was
> discovered while testing memory failure handling for guest_memfd.
> 
> The proposed solution involves -
> 1. Clarifying the definition of MF_DELAYED to mean that memory failure
>    handling is only partially completed, and that the metadata for the
>    memory that failed (as in struct page/folio) is still referenced.
> 2. Updating shmem’s handling to align with the clarified definition.
> 3. Updating how the result of .error_remove_folio() is interpreted.
> 
> Changes from v2:
> + Address the comment about fixing the typos and clarifying the
>   'unmapped' status from Jiaqi
> + Address the comment about merging shmem memory failure selftest into
>   memory failure selftest from Baolin
> + Align the consistent style in truncate_error_folio suggested by Miaohe
> + Fix some bugs found out by Sashiko. e.g. set vcpu register when VM is
>   running.
> Thanks!
> 
> Would like to request reviews from Miaohe and Baolin regarding the
> selftests:
> + Is adding more TEST_F()s suitable?
> + Are you expecting refactoring to reduce code duplication in
>   selftests?

IMHO, when there are more and more memory failure testcases, we will inevitably
have to refactor the code. But for now, it probably isn't necessary yet.

Thanks.
.
