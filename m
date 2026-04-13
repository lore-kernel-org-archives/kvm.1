Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3942D3A69;
	Mon, 13 Apr 2026 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776081482; cv=none; b=NTrKlGdRg5GEurYYb1wXhFzvzIZGmT4vtuDjXBZd/hA1VSVe0DyiMbKQ+bVW2rH+sZs2DnEMmgE5Y2BuGXhObJ3bz6jJ1SnKa/P5wgzH/XlF1IQIvk5Pr2cyTBxPiCAIpkHVWAuo8qmGzZ/r2DJvn5v0i3xnSWYyyKKSf14rfmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776081482; c=relaxed/simple;
	bh=8S6MLNcBH8PxO4JVP5bm3FZXoNYj4CNjzcKC//Bfc1Q=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AOT2Mt0vD05qKu4jDbZ/syr1vVz0ss4Cgm4C7o62bimsTZkxhweRlvRuowXpfPG8m3E6TxWHtFXJap/6yyDs5VdHN7KNCCOnwY7L45dIdK0iqvydgSX5XzOsuoI14MDsBX9DfuEbFGDN6ehmI97M06V6V0/8lRsKi5PRuIwbxFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cLISFnuC; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cLISFnuC"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=t+bad71lwt55pbEushAAY3am/8JVpJ937KnhdbjHPvM=;
	b=cLISFnuCWUTjZvk4SBtq7ODsuprDgjfmxkCpvb7LxeAXAmgzF2kau5DX00qeLLRo9PxIsNXuE
	K2S9p1PD091doJlRCQU0GJHUK+rCSWnCpL38RVUhSXswBHze8XJbVXo5aE580yrfuoZ/NPXQF3T
	MibccXLXF5nqQrFqy3KVlYg=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fvQjn2GXmz1cyQc;
	Mon, 13 Apr 2026 19:51:41 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id B01BC4055B;
	Mon, 13 Apr 2026 19:57:57 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Apr 2026 19:57:57 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Apr 2026 19:57:56 +0800
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
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <9effbeca-3453-f0fe-571f-85f8923e1385@huawei.com>
Date: Mon, 13 Apr 2026 19:57:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-5-718f45eb7c75@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/4/9 1:24, Lisa Wang wrote:
> Add a shmem memory failure selftest to test the shmem memory failure is
> correct after modifying shmem return value.
> 
> Test that
> + madvise() call returns 0 when the poisoned shmem page is clean
> + trigger a SIGBUS when the poisoned shmem page is dirty
> + trigger another SIGBUS when the poisoned shmem page is fault-in again.
> 
> Signed-off-by: Lisa Wang <wyihan@google.com>

Thanks for your patch. Two questions below.

> ---
>  tools/testing/selftests/mm/memory-failure.c | 109 +++++++++++++++++++++++++++-
>  1 file changed, 106 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/memory-failure.c b/tools/testing/selftests/mm/memory-failure.c
> index 3d9e0b9ffb41..eb3f8d98f6c9 100644
> --- a/tools/testing/selftests/mm/memory-failure.c
> +++ b/tools/testing/selftests/mm/memory-failure.c
> @@ -30,9 +30,14 @@ enum result_type {
>  	MADV_HARD_ANON,
>  	MADV_HARD_CLEAN_PAGECACHE,
>  	MADV_HARD_DIRTY_PAGECACHE,
> +	MADV_HARD_CLEAN_SHMEM,
> +	MADV_HARD_DIRTY_SHMEM,
>  	MADV_SOFT_ANON,
>  	MADV_SOFT_CLEAN_PAGECACHE,
>  	MADV_SOFT_DIRTY_PAGECACHE,
> +	MADV_SOFT_CLEAN_SHMEM,
> +	MADV_SOFT_DIRTY_SHMEM,
> +	READ_ERROR,
>  };
>  
>  static jmp_buf signal_jmp_buf;
> @@ -165,17 +170,21 @@ static void check(struct __test_metadata *_metadata, FIXTURE_DATA(memory_failure
>  	case MADV_HARD_CLEAN_PAGECACHE:
>  	case MADV_SOFT_CLEAN_PAGECACHE:
>  	case MADV_SOFT_DIRTY_PAGECACHE:
> -		/* It is not expected to receive a SIGBUS signal. */
> -		ASSERT_EQ(setjmp, 0);
> -
> +	case MADV_SOFT_DIRTY_SHMEM:
>  		/* The page content should remain unchanged. */
>  		ASSERT_TRUE(check_memory(vaddr, self->page_size));

Why we skip check_memory() for case MADV_SOFT_CLEAN_SHMEM?

> +	case MADV_HARD_CLEAN_SHMEM:
> +	case MADV_SOFT_CLEAN_SHMEM:
> +		/* It is not expected to receive a SIGBUS signal. */
> +		ASSERT_EQ(setjmp, 0);
>  
>  		/* The backing pfn of addr should have changed. */
>  		ASSERT_NE(pagemap_get_pfn(self->pagemap_fd, vaddr), self->pfn);
>  		break;
>  	case MADV_HARD_ANON:
>  	case MADV_HARD_DIRTY_PAGECACHE:
> +	case MADV_HARD_DIRTY_SHMEM:
> +	case READ_ERROR:
>  		/* The SIGBUS signal should have been received. */
>  		ASSERT_EQ(setjmp, 1);
>  
> @@ -260,6 +269,20 @@ static int prepare_file(const char *fname, unsigned long size)
>  	return fd;
>  }
>  
> +static int prepare_shmem(const char *fname, unsigned long size)
> +{
> +	int fd;
> +
> +	fd = memfd_create(fname, 0);
> +	if (fd < 0)
> +		return -1;
> +	if (ftruncate(fd, size) < 0) {
> +		close(fd);
> +		return -1;
> +	}
> +	return fd;
> +}
> +
>  /* Borrowed from mm/gup_longterm.c. */
>  static int get_fs_type(int fd)
>  {
> @@ -356,4 +379,84 @@ TEST_F(memory_failure, dirty_pagecache)
>  	ASSERT_EQ(close(fd), 0);
>  }
>  
> +TEST_F(memory_failure, dirty_shmem)
> +{
> +	int fd;
> +	char *addr;
> +	int ret;
> +
> +	fd = prepare_shmem("shmem-file", self->page_size);
> +	if (fd < 0)
> +		SKIP(return, "failed to open test shmem-file.\n");
> +
> +	addr = mmap(0, self->page_size, PROT_READ | PROT_WRITE,
> +		    MAP_SHARED, fd, 0);
> +	if (addr == MAP_FAILED) {
> +		close(fd);
> +		SKIP(return, "mmap failed, not enough memory.\n");
> +	}
> +	memset(addr, 0xce, self->page_size);
> +
> +	prepare(_metadata, self, addr);
> +
> +	ret = sigsetjmp(signal_jmp_buf, 1);
> +	if (ret == 0)
> +		ASSERT_EQ(variant->inject(self, addr), 0);
> +
> +	if (variant->type == MADV_HARD) {
> +		check(_metadata, self, addr, MADV_HARD_DIRTY_SHMEM, ret);
> +		ret = sigsetjmp(signal_jmp_buf, 1);
> +		if (ret == 0)
> +			FORCE_READ(*addr);
> +		check(_metadata, self, addr, READ_ERROR, ret);
> +	} else {

Should we always add a FORCE_READ() just after variant->inject to verify the accessibility
to the addr for soft-offline case ?

Thanks.
.

> +		check(_metadata, self, addr, MADV_SOFT_DIRTY_SHMEM, ret);> +	}
> +
> +	ASSERT_EQ(munmap(addr, self->page_size), 0);
> +
> +	ASSERT_EQ(close(fd), 0);
> +	cleanup(_metadata, self, addr);
> +}
> +
> +TEST_F(memory_failure, clean_shmem)
> +{
> +	int fd;
> +	char *addr;
> +	int ret;
> +
> +	fd = prepare_shmem("shmem-file", self->page_size);
> +	if (fd < 0)
> +		SKIP(return, "failed to open test shmem-file.\n");
> +
> +	addr = mmap(0, self->page_size, PROT_READ | PROT_WRITE,
> +		    MAP_SHARED, fd, 0);
> +	if (addr == MAP_FAILED) {
> +		close(fd);
> +		SKIP(return, "mmap failed, not enough memory.\n");
> +	}
> +	FORCE_READ(*addr);
> +
> +	prepare(_metadata, self, addr);
> +
> +	ret = sigsetjmp(signal_jmp_buf, 1);
> +	if (ret == 0)
> +		ASSERT_EQ(variant->inject(self, addr), 0);
> +
> +	if (variant->type == MADV_HARD) {
> +		check(_metadata, self, addr, MADV_HARD_CLEAN_SHMEM, ret);
> +		ret = sigsetjmp(signal_jmp_buf, 1);
> +		if (ret == 0)
> +			FORCE_READ(*addr);
> +		check(_metadata, self, addr, READ_ERROR, ret);
> +	} else {
> +		check(_metadata, self, addr, MADV_SOFT_CLEAN_SHMEM, ret);
> +	}
> +
> +	ASSERT_EQ(munmap(addr, self->page_size), 0);
> +
> +	ASSERT_EQ(close(fd), 0);
> +	cleanup(_metadata, self, addr);
> +}
> +
>  TEST_HARNESS_MAIN
> 

