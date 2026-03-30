Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AD6282F05;
	Mon, 30 Mar 2026 07:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774855222; cv=none; b=WBCRuC1xY2ue8XYHXxrz2S6WWa6FYgiGVY8Js7fQNGvefUKqFu5D/EkErlLjH/Bext00ujPTyLWSOKj9YHXrq/FO9xszhT7EtRrKsf42/4zdRTAZNRdJ3PVOqPuNyHbZVZPpGtkO4/Bx8E49jIEwfW7UPN4FOb3c9W7xfJ1DnBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774855222; c=relaxed/simple;
	bh=cjXOoVwqbZs9zpKSEmLRqyefPMob/uW/xC60WF3EGyA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BiEvBYhb9ct1Xw3qDZlLYYGcB+oLEhfQk/A5msJZLo49+aHXVN4Bmp7ImLmCa+uEuMvO9FGAjGPUUZ0JQ8JHpIu/+n2Iza7XPCocdgF8YpCeFO7lJTpRnLYKvzG85l/PZXvPxnyyyZbGdwbqXaqix2yODeeOOa+OpScgQED9PV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=SC4qUK59; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="SC4qUK59"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pepwZ3XKeQcMZ6zDSFXuBMobmmIw3darhFzDaJYBZvo=;
	b=SC4qUK59hXpDZXbq+rPtEwSr1lC+YENsS5x5oofEvIuSsoICbJPp57M5OelZoptVim7CiUqx/
	r8nOFQmo2RwxP5Kmc4/H/PIQiN989RJVpw1UQeNNbHRb8snsbRJE0KvJWuq4NHwV8wN5XiIqjoA
	SQbdFIIdffGVUQ4MTItX8dA=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fkjCy0P0pz1prKb;
	Mon, 30 Mar 2026 15:14:06 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 6921D4056D;
	Mon, 30 Mar 2026 15:20:17 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Mar 2026 15:20:17 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Mar 2026 15:20:15 +0800
Subject: Re: [PATCH RFC v2 6/7] KVM: selftests: Add memory failure tests in
 guest_memfd_test
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
 <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-6-92c596402a7a@google.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <149c954e-dfe1-6bdd-295c-792642a9d915@huawei.com>
Date: Mon, 30 Mar 2026 15:20:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-6-92c596402a7a@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/3/20 7:30, Lisa Wang wrote:
> After modifying truncate_error_folio(), we expect memory_failure() will
> return 0 instead of MF_FAILED. Also, we want to make sure memory_failure()
> signaling function is same.
> 
> Test that memory_failure() returns 0 for guest_memfd, where
> .error_remove_folio() is handled by not actually truncating, and returning
> MF_DELAYED.
> 
> In addition, test that SIGBUS signaling behavior is not changed before
> and after this modification.
> 
> There are two kinds of guest memory failure injections - madvise or
> debugfs. When memory failure is injected using madvise, the
> MF_ACTION_REQUIRED flag is set, and the page is mapped and dirty, the
> process should get a SIGBUS. When memory is failure is injected using
> debugfs, the KILL_EARLY machine check memory corruption kill policy is
> set, and the page is mapped and dirty, the process should get a SIGBUS.
> 
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>

Should we add a testcase for hugetlbfs? It seems hugetlbfs_error_remove_folio() behaves same as shmem.

Thanks.
.
