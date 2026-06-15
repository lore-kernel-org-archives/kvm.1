Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA7F331EDE;
	Mon, 15 Jun 2026 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781520213; cv=none; b=m1olRsk23Z9YWu85KQW8u6MMkmjwL6S/r2FkHZY8dMWEwvtmSHIeedqZ00RV1DW7dZYb0FnGa6RZH8UGogOYmnUNpGJczI4OrVhOyltJu8FSZ2VbGgHFrO8avMiyFp/t9h1R9zu0Gdhe02S+Z092hPNjjcN72O5SsogN52/5fJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781520213; c=relaxed/simple;
	bh=3yAHPoiKaxpCvGRtA07MNdia4xyAMd/XClNlGDs+yTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1kasskeBL+85Js8865CIvwzAGZz6LP1IlTvhKq3QHvA4iyU9QNhxsvdqgM7gSVqRX7KZy45598gexbkNLHaupYsXPjFBjVallpNo2vwS6jxK+sOU7rz+SMRlfh8k3ozW741jlPSMlk5WXwqRnGLAVEsh3v0LsyREddw2T+xSKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YilFCdw7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YilFCdw7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAEB1328D;
	Mon, 15 Jun 2026 03:43:24 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75FD73F905;
	Mon, 15 Jun 2026 03:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781520209; bh=3yAHPoiKaxpCvGRtA07MNdia4xyAMd/XClNlGDs+yTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YilFCdw7wnbi02p8Ri37XQ9LOpP+gWIbj1xLxh6VFzlKpkicKF+zKdXigOj42eUFe
	 ECB8oiTRkLs1UEvL96SQTRLUaBxPXfMXbysW2WvyNOHsHoIAo9UCdTxpZcD/tf4F/m
	 bGpKZ3AP3paUcX/S/ZEhVk3Sy2CPal6yF/LtIlWA=
Date: Mon, 15 Jun 2026 11:43:14 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Shivank Garg <shivankg@amd.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Ira Weiny <ira.weiny@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Nikita Kalyazin <nikita.kalyazin@linux.dev>,
	Patrick Roy <patrick.roy@linux.dev>,
	Pratik Sampat <prsampat@amd.com>,
	Ashish Kalra <Ashish.Kalra@amd.com>, linux-fsdevel@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] KVM: guest_memfd: folio migration for
 non-confidential VMs
Message-ID: <ai_XK__RTXMCEcCG@raptor>
References: <20260611-shivank-gmem-migrate-v1-0-2d266bfc6f95@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-shivank-gmem-migrate-v1-0-2d266bfc6f95@amd.com>

Hi,

On Thu, Jun 11, 2026 at 01:05:07PM +0000, Shivank Garg wrote:
> guest_memfd folios are currently marked unmovable, so the kernel cannot
> perform NUMA-balancing, memory compaction, etc. This is unavoidable for
> confidential VMs (SEV-SNP, TDX), since memory is encrypted and copying it
> needs firmware assistance. However, for non-confidential VMs (like
> Firecracker), we can migrate the folios.
> 
> This series enables folio migration for non-confidential guest_memfd and
> also lays the groundwork for migrating confidential guest_memfd later.
> Once firmware-assisted copying support is available, those VMs can be
> made movable, the confidential folio content can be copied separately,
> and the destination folio marked with FOLIO_CONTENT_COPIED so
> __migrate_folio() skips the host-side folio_mc_copy().

I always thought that one of the nice things about using guest_memfd as a
memory backend, as opposed to host userspace mappings, is that the host
cannot unmap VM memory because of KSM, automatic NUMA balancing, hugepage
collapse, compaction, etc, acting on the host userspace mapping of the
VM memory, and outside of the VMM's or KVM's control.

I think it would be useful to preserve this behaviour, even in the absence
of confidential VMs (i.e, guest_memfd file descriptor created with
GUEST_MEMFD_FLAG_MMAP).

Thanks,
Alex

> 
> Testing
> -------
> Host: 7.1-rc7 + this, 2 NUMA nodes
> 
> - KVM selftest: allocate folios on node 0, migrate them to node 1 and
>   back and verify resulting NUMA node and the folio contents at each
>   step.
> 
> - Firecracker [1]: booted a microVM backed by guest_memfd. While the
>   guest was running, forced host-side migration of its folios via
>   migratepages(8) and explicit move_pages(2) of guest_memfd
>   pages. Verify with /proc/firecracker_pid/numa_maps.
> 
> [1] https://github.com/firecracker-microvm/firecracker/tree/feature/secret-hiding
>     and change builder.rs to remove GUEST_MEMFD_FLAG_NO_DIRECT_MAP from
>     vm.create_guest_memfd()
> 
> Best regards,
> Shivank
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
> Shivank Garg (3):
>       mm: split AS_UNMOVABLE back out of AS_INACCESSIBLE
>       KVM: guest_memfd: support folio migration for non-confidential VMs
>       KVM: selftests: exercise guest_memfd folio migration
> 
>  include/linux/pagemap.h                        | 24 ++++++--
>  mm/compaction.c                                | 12 ++--
>  mm/migrate.c                                   |  2 +-
>  tools/testing/selftests/kvm/guest_memfd_test.c | 77 ++++++++++++++++++++++++++
>  virt/kvm/guest_memfd.c                         | 49 ++++++++++++++--
>  5 files changed, 149 insertions(+), 15 deletions(-)
> ---
> base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
> change-id: 20260611-shivank-gmem-migrate-8c1c519b30a6
> 
> Best regards,
> -- 
> Shivank Garg <shivankg@amd.com>
> 
> 
