Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4673D1CA8;
	Thu, 10 Sep 2026 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789034306; cv=none; b=JRSHgCLSNSGjEQYg22XUkJq1dYI6IVTmsKP6RyFj71mfOnI4pXmpD6SPwpfTBBu6LhypkfRxzMy/Gcpf2RCgt/TOIumKw3dOW4D4qEuAJFj26qpiR1NxndVEb62y/BgYop+Er1qjpibvq8nHOvf/hOSpYmi8/uvKEEdoMtWkF1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789034306; c=relaxed/simple;
	bh=i1iGnO2jLZ+E8QVOhOJd6QekAN+lQ5WC5ZETlQ+nHaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbgEIUZxBAUCGlMwMznZtkCi1wnpfEXWSO3FhoEtpVZZssV3Zvwe4XvRrA8YgoWMhzOBx6sbTiHFcjehR43VskTtYwPPlAt2LyKG1xwmuWumsVwhIO/K9N5i+6DHHeNZTZA+bs1iVf/yh121vJopnFxb8wKVZf4Sk5/BvI3UgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrOGHh3N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrOGHh3N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD821F000FF;
	Thu, 10 Sep 2026 09:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789034304;
	bh=mioPuWYQDLrb+YQYF+a6jlDq2OqbhOCoGkf+EICrOg0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LrOGHh3NXCbcHPXaYr8Nvp5QUtBTzcIX3pfYfimfLhnYi7CdEm2LS5aK8GxbBNmNT
	 IANyxLqPfYNsKWyFC97tXQpZ2lHS6QOrl4iGdvNl1fXdOlWkzL5rBp7fCCvO1AbH7y
	 VMXxWnagNCgzAt+9Ds6gwUt3VjVJ1E4poXNg3baVpQUPPykCw8EKXv7lw82++xmtWw
	 9m+J3aT4qA3bA8XF10ZlY9+ht8wjY2bamG5QcJhhLdhPb1XrN0OTDd5qIHb+BCcsMM
	 /OSi9FEgXDVkdkH7U7nEGUqAwNosUntKwQR3ONWe9YSdLs4LPm++GcDCS5AGaOVK8D
	 cEFhPKrFZQ96w==
Message-ID: <0b8c746e-544b-4ec0-91dd-d5e10e1920dd@kernel.org>
Date: Thu, 10 Sep 2026 11:58:09 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] KVM: guest_memfd: folio migration for
 non-confidential VMs
To: Shivank Garg <shivankg@amd.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Chao Peng <chao.p.peng@linux.intel.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Michael Roth <michael.roth@amd.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>, Ackerley Tng <ackerleytng@google.com>,
 Sean Christopherson <seanjc@google.com>,
 Vishal Annapurve <vannapurve@google.com>,
 Nikita Kalyazin <nikita.kalyazin@linux.dev>,
 Patrick Roy <patrick.roy@linux.dev>, Pratik Sampat <prsampat@amd.com>,
 Ashish Kalra <Ashish.Kalra@amd.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Peter Shier <pshier@google.com>,
 Jim Mattson <jmattson@google.com>, Ricardo Koller <ricarkol@google.com>,
 Ira Weiny <iweiny@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20260805-shivank-gmem-migrate-v3-0-00d8bdec4e1d@amd.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260805-shivank-gmem-migrate-v3-0-00d8bdec4e1d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/26 08:40, Shivank Garg wrote:
> guest_memfd folios are currently always marked unmovable, so the kernel cannot
> perform memory compaction, offlining, etc. This is unavoidable for
> confidential VMs (SEV-SNP, TDX), since memory is encrypted and copying it
> needs firmware assistance. However, for non-confidential VMs (like
> Firecracker), we can migrate the folios.

Yes.

> 
> This series enables folio migration for non-confidential guest_memfd and
> also lays the groundwork for migrating confidential guest_memfd later.
> Once firmware-assisted copying support is available, those VMs can be
> made movable, the confidential folio content can be copied separately,
> and the destination folio marked with FOLIO_CONTENT_COPIED[4] so
> __migrate_folio() skips the host-side folio_mc_copy().
> 
> Testing
> -------
> Host: 7.2-rc6+(c21bb419386) + this, AMD EPYC ZEN 3, 2 NUMA nodes
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
> Notes
> -----
> - Sashiko pointed out a pre-existing ABBA deadlock between
>   kvm_gmem_error_folio() and truncation. It's being addressed separately
>   by Hao Zhang. [2][3]
> 
> [1] https://github.com/firecracker-microvm/firecracker/tree/feature/secret-hiding
>     In builder.rs, add GUEST_MEMFD_FLAG_MIGRATABLE to bit-2 and pass it instead
>     of GUEST_MEMFD_FLAG_NO_DIRECT_MAP to vm.create_guest_memfd().
> [2] https://lore.kernel.org/all/ambEdSPjerZIVN0b@192.168.1.215/
> [3] https://sashiko.dev/#/patchset/20260611-shivank-gmem-migrate-v1-0-2d266bfc6f95%40amd.com
> [4] https://lore.kernel.org/all/20260630-shivank-batch-migrate-offload-v6-1-da95d7e8b8a2@amd.com
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
> Changes in v3:
> - Fix unbalanced mmu_invalidate_in_progress count unbinding dying guest_memfd. (Sashiko)
> - Fix maxnode handling in xapic_ipi_test selftest.
> - Add GUEST_MEMFD_FLAG_MIGRATABLE documentation
> - Replace open-coded sizeof() * 8 calculation with BITS_PER_TYPE()
> - Add get_numa_mem_nodes() and use  MPOL_F_MEMS_ALLOWED for allowed NUMA ndoes
>   instead of hardcoded NUMA node IDs. (Sashiko)
> - Extend migration selftest to verify rejection without MIGRATABLE flag and
>   move repeated checks into common helpers.
> - Drop RFC tag.
> - Link to v2: https://lore.kernel.org/r/20260728-shivank-gmem-migrate-v2-0-269ac1f84e2b@amd.com
> 
> Changes in v2:
> - Make folio migration opt-in through GUEST_MEMFD_FLAG_MIGRATABLE,
>   preserving unmovable behavior if userspace don't explictly ask. (Alexandru, David, Sean)
> - Add kvm_arch_supports_gmem_migration() so arch can control whether
>   GUEST_MEMFD_FLAG_MIGRATABLE is advertised.
> - Allocate movable folios with GFP_HIGHUSER_MOVABLE. (David)
> - Keep guest_memfd unevictable. (David, Sashiko, Sean)
> - Split migrate_folio() implementation and enablement as separate patches.
> - Update selftest with new flag.
> - Link to v1: https://lore.kernel.org/r/20260611-shivank-gmem-migrate-v1-0-2d266bfc6f95@amd.com
> 
> ---
> Shivank Garg (9):
>       KVM: guest_memfd: take the invalidate lock when unbinding a dying file
>       mm: split AS_UNMOVABLE back out of AS_INACCESSIBLE
>       KVM: guest_memfd: implement folio migration for non-confidential VMs
>       KVM: guest_memfd: add GUEST_MEMFD_FLAG_MIGRATABLE


As discussed, we should for now just always enable it and not expose such a
flag. The hope is that use cases that need migration disabled can just find a
way for kvm to tell guest_memfd about that internally ... or we'll add a
GUEST_MEMFD_FLAG_UNMIGRATABLE or whatever later.

With migration in place, as also discussed, it would be interesting to
investigate what it would take for these shared-only (no conversion) and
migratable guest_memfd instances to support THPs.

I'd assume we might have to teach

1) guest_memfd / KVM parts about this, although I recall that most of it should
be there

2) Unlock guest_memfd in khugeapged

We disallowed khugepaged entirely in commit

commit dd085fe9a8ebfc5d10314c60452db38d2b75e609
Author: Deepanshu Kartikey <kartikey406@gmail.com>
Date:   Sat Feb 14 05:45:35 2026 +0530

    mm: thp: deny THP for files on anonymous inodes

    file_thp_enabled() incorrectly allows THP for files on anonymous inodes
    (e.g. guest_memfd and secretmem). These files are created via
    alloc_file_pseudo(), which does not call get_write_access() and leaves
    inode->i_writecount at 0. Combined with S_ISREG(inode->i_mode) being
    true, they appear as read-only regular files when
    CONFIG_READ_ONLY_THP_FOR_FS is enabled, making them eligible for THP
    collapse.

It will also be interesting to figure out how well khugepaged would collapse
guest_memfd when most folios are not actually faulted into the user page tables.

collapse_scan_file() does not seem to worry about whether folios are actually
mapped, just if they are present in the page cache.

Which might mean that as long as guestmemfd is mmap'ed, it might just work.


-- 
Cheers,

David
