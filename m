Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795113132;
	b=ZzHOnmNSq0YVioKp4hC19LFx/i/GNqCgw4Y1aTDVkwoPCdZTurMH/eCLf6go3Mc14EK5
	 OAUS5vqoUVxT/l93XDJqI/oROAD6vg9NhKEx9ebm6LQTP8B1yXc/NcRaKbOvjTIws4dzD
	 Qg7tcn4QBsVVxyGFPLL81oaa5wCYwj6StL7YKTKqkAa6OCPYIVOLtakWSEvrZuhkg1nbP
	 abrFI5NoewJ9ZBE25OWJ0jAwiD3e0VekzN7ahlCaGcOTclTttmOmZHbUH9g2cqCI3DwJ6
	 8NkctAA4f/cgpnhOOVHPGc+GUjPu3r2yqZEwIRLwWGJxK4cLEJro0lZmZt15xFs/5MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795113132;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rnpSKrnFQmYg+ietBlmwBi39cYR0OhHgd0OQTIatyVs=;
	b=bZvT/ZdOtIX9lxddx5VrX9Gj2vpl0CC/HqT6h2Fd/y21j1G+HNuoAMNiT0qoT8aSnBrP
	 4j0SCE2bP4uht0HvdWZZig2pO8u+ByZRaia7c9Q6V5OiiFU2SL4hM/6AqfSIQWEIidCe/
	 UKULQcuqQHxm84dH/+PnfJWq39/vPhULQPNPV9yiPZHakv9qjAJLtfjErTsCdv/uvUiQM
	 /X4eZXG0i0nnmoKKsaN/whKB1wBP8+vU5L9GrYNSGsKzWbfGq/14w1cqtRaEvjuOF7uJX
	 MhnMnCxfBhHHPP/pYj9SEvs/XjjlzkOP6DK+Xr5G0CfdQv2h1t6ePUdgIfF39BBMSVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=I51Wzs14;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FF5606A32C;
	Thu, 19 Nov 2026 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=I51Wzs14
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB8F1F000C6;
	Thu, 19 Nov 2026 18:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795113132;
	bh=rnpSKrnFQmYg+ietBlmwBi39cYR0OhHgd0OQTIatyVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I51Wzs14XbAG4qsckU/kwl6HJ858CxkZd8Rp3hB5PXisfTLMvM35ZoKvjH++juonX
	 AL35Xk4tz1hhVpn9MtlJe0CUC+dxBvx6wMLVyxPSbVNqCySeMu/oKGY6gfD+0PY32E
	 Ko4FR8GzYJBzLWe5QJX14zKR7S65A6HAY0c6Ypaw=
Date: Thu, 19 Nov 2026 10:32:10 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Usama Arif
 <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Peter Xu
 <peterx@redhat.com>, Alex Williamson <alex@shazbot.org>,
 kvm@vger.kernel.org, =?ISO-8859-1?Q?Lo=EFc?= Molinari
 <loic.molinari@collabora.com>, Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan
 <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, Yeoreum Yun
 <yeoreum.yun@arm.com>
Subject: Re: [PATCH v6 4/4] selftests/mm: test fork of PMD-mapped shmem THPs
Message-Id: <20261119103210.24a7612ee26c3ffc3db49451@linux-foundation.org>
In-Reply-To: <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-4-efa7817a2bb3@virtuozzo.com>
References: <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-0-efa7817a2bb3@virtuozzo.com>
	<20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-4-efa7817a2bb3@virtuozzo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Nov 2026 14:44:05 +0100 Konstantin Khorenko <khorenko@virtuozzo.com> wrote:

> Fork a process that maps shmem THPs with PMDs, in a VMA whose page
> tables fork copies: a private mapping with an anon_vma, and a shared
> one with a guard region. The child must find the PMDs before it
> touches the mapping, and its exit must leave the parent's mapping and
> the system-wide ShmemPmdMapped counter as they were.
> 
> With folio_dup_file_rmap_pmd() adding PTE mappings, the child's exit
> takes the parent's share off ShmemPmdMapped while the parent still maps
> the folios. Unmapping them drops it once more, so every mapping stays
> until exit, where the kernel reports "Bad page cache", or hits a
> VM_BUG_ON with CONFIG_DEBUG_VM. A kernel that leaves file THPs to a
> refault in the child skips the test.
> 
> ShmemPmdMapped is system-wide, and reclaim or NUMA balancing can take a
> PMD from the parent while the test runs. So the test makes up to three
> attempts, each on a fresh file, and fails only if all of them see the
> counter drop by exactly the parent's share: the bug does that on every
> fork, other processes only by chance. It passes on the first clean
> attempt and skips when none is clean.
> 
> The test mounts a tmpfs with huge=always over /tmp in a private mount
> namespace, so it leaves the THP settings and the host's mounts and
> files alone.
> 
> ...
>
> +static void test_fork(bool shared)
> +{
> +	const char *desc = shared ? "shared mapping with a guard region" :
> +				    "private mapping with an anon_vma";
> +	long before = 0, after = 0;
> +	enum result res = NO_THP;
> +	int i, drops = 0;
> +	char *mem;
> +
> +	for (i = 0; i < ATTEMPTS; i++) {
> +		mem = map_file(shared);
> +		/* Make fork copy the page tables; the last PMD gets zapped. */
> +		if (shared) {
> +			if (madvise(mem + size - pagesize, pagesize,
> +				    MADV_GUARD_INSTALL)) {
> +				ksft_test_result_skip("%s: MADV_GUARD_INSTALL: %s\n",
> +						      desc, strerror(errno));
> +				return;
> +			}
> +		} else {
> +			mem[size - pagesize] = 'p';
> +		}
> +
> +		res = pmds_ok(mem) ? fork_once(mem, shared, &before, &after) :
> +				     res == NO_THP ? NO_THP : LOST_PMDS;
> +		/* Later children get only their own mapping. */
> +		madvise(mem, size, MADV_DONTFORK);

autobot want the return value checked:

: If this fails, the next child inherits an earlier test mapping too. 
: Its exit can then change ShmemPmdMapped by more than the expected
: amount, causing the test to skip a real failure.

which seems ignorable - MADV_DONTFORK failures are super unlikely at present.

>
> ...
>
> +int main(void)
> +{
> +	ksft_print_header();
> +	pagesize = getpagesize();
> +	pmdsize = read_pmd_pagesize();

This is going to ruin Mark's day again, thanks to "kselftest: mm:
rename read_pmd_pagesize() to pmd_psize()".

I think I'll alter Yeoreum's above patch like this (presently untested):

--- a/tools/testing/selftests/mm/vm_util.h~kselftest-mm-rename-read_pmd_pagesize-to-pmd_psize-fix
+++ a/tools/testing/selftests/mm/vm_util.h
@@ -93,6 +93,8 @@ unsigned long pagemap_get_pfn(int fd, ch
 void clear_softdirty(void);
 bool check_for_pattern(FILE *fp, const char *pattern, char *buf, size_t len);
 uint64_t pmd_psize(void);
+/* temporary cross-tree compatibility thing: */
+#define read_pmd_pagesize() pmd_psize()
 unsigned long rss_anon(void);
 bool check_huge_anon(void *addr, size_t len, int nr_hpages, uint64_t hpage_size);
 bool check_huge_file(void *addr, size_t len, int nr_hpages, uint64_t hpage_size);
_

and we can clean that up later.

