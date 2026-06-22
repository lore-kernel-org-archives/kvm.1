Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1899C39EF1F;
	Mon, 22 Jun 2026 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122760; cv=none; b=KO/0++QodJOq9W3agJ7kXjFr31rbz6pmc99xQOwZmtswN+y1ys3dmbd8dTRx5ND1XiVXhnnIpCwaJey47j9rKlwlyRGOzEEGpSR6hcT1sGAVuO+0IACLjQqxCGjNtdSaCqa8hEpgaN17uF1mg06iW0VHtmGZkG8OCxlIFB27RRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122760; c=relaxed/simple;
	bh=kksDzviDuit9B3lR50yQyCTyByq9ebx4O+jXSowufLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kADONzTaQZS2tcwum5d8mdTGK04kPsDlA81kWlOYUHNNAo0dM26XnSu182+py8VUW1pr6DDuqlD3WDqKFCF79err7yh9WWgYTAa7LKg9OJsYqdPCkzOoHkK+eHyxCNeM1s7t2E9GCEu3Layb6QYTTwqv82zBdFDqjloIcn8k/bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwAaLIA2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwAaLIA2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2801F000E9;
	Mon, 22 Jun 2026 10:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122758;
	bh=Lm3VHa+ibnCEVTeN7wPr7u/M30hvjlxo8BfYfr4ERzI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gwAaLIA2n0XNgC4oeoUPyfPVSbCaXwYUdSEZ9JcTUBqvQRSsu5MdVDuFghV3YKAJ7
	 e8X/CJtFSPnVVJyvV5cYb15rVIxLHJk68dcIgn0PzLTvFSm55yZ4IVr/HgLK6YOstV
	 5s5eVJ/2qt1gpKUF0Z2rAI05gHIb2ohAd0gp5tvuReSF6RsMaL9VmDx9v22eYPRY0I
	 6N5vyAARs9uVtZapx/D8I+AieSidW7z5wHqBAHvHkLqa7GT8YNB6WiBaeQZj7FRhvc
	 hJWo1NW6ksElIsjkIMD5wvL7NmBc15gY0bq2IhBrKjolsVSj+tm8Xe+UCUI2HcG4a5
	 Q9SQ6i1S3AnKA==
Message-ID: <6ca5edd6-80ce-44f9-98c1-d84b708d5df6@kernel.org>
Date: Mon, 22 Jun 2026 12:05:46 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] mm: Some cleanups for page allocator APIs
Content-Language: en-US
To: Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Hao Ge <hao.ge@linux.dev>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, Gregory Price
 <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Robin Holt <robinmholt@gmail.com>,
 Steve Wahl <steve.wahl@hpe.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dimitris Michailidis <dmichail@fungible.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+Cc Hao Ge for the "remove __GFP_NO_CODETAG" part

On 6/22/26 12:01, Brendan Jackman wrote:
> Some tweaks and cleanups for page allocator entrypoint and flags. This
> is motivated by preparation for __GFP_UNMAPPED [1] (which will probably
> become ALLOC_UNMAPPED in its next iteration), but all this is supposed
> to be an improvement to the codebase in its own right: unifying code
> paths, reducing API surface, and removing GFP flags.
> 
> [1] https://lore.kernel.org/all/20260320-page_alloc-unmapped-v2-0-28bf1bd54f41@google.com/
> 
> This started with unifying  __alloc_frozen_pages[_nolock]_noprof() and
> expanded from there.
> 
> Unifying the nolock allocator entrypoint with the normal allocator
> entrypoint means adding an alloc_flags argument to the later (only
> exposed within mm/). This presents an opportunity to take advantage of
> that arg to remove some GFP flags, if we add that alloc_flags arg a bit
> more broadly to allocator entrypoints.
> 
> To distinguish between mm-internal and "public" allocator entrypoints,
> it makes sense to use the __ prefix. There are already some public APIs
> with that prefix. For *alloc_pages*, just removing those variants seems
> like a nice cleanup anyway, so do that. For get_free_pages, the "__"
> variant is the _only_ variant and it's very widely used, so it doesn't
> seem worthwhile to modify that. Therefore, scope this "__" change
> specifically to the *alloc_pages* API, which means we leave the
> *folio_alloc* API untouched too, even though that could probably be
> cleaned up if so desired.
> 
> Tested:
> 
> - KVM, mm, and BPF selftests in a QEMU VM
> 
> - kunit.py on x86_64
> 
> - For the ALLOC_NO_CODETAG bits I just booted a VM and read
>   /proc/allocinfo. I confirmed that if I remove ALLOC_NO_CODETAG, the
>   kernel crashes in early boot, so I was at least booting code that
>   depends on this logic.
> 
> I used Google's internal version of Antigravity (AI coding harness) to
> do the repetitive bits, those commits are marked with Assisted-by, the
> rest is manual.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
> Changes in v2:
> - Fixed up whitespace in nolock unification patch
> - Introduced ALLOC_DEFAULT to replace literal 0 for alloc_flags
> - All other patches are new
> - Link to v1: https://patch.msgid.link/20260617-alloc-trylock-v1-1-83fd7858832e@google.com
> 
> ---
> Brendan Jackman (13):
>       mm/page_alloc: rename ALLOC_TRYLOCK -> ALLOC_NOLOCK
>       mm/page_alloc: some renames to clarify alloc_flags scopes
>       mm/page_alloc: unify __alloc_frozen_pages[_nolock]_noprof()
>       mm/page_alloc: relax GFP WARN in nolock allocs
>       perf/x86/intel: Use higher-level allocator
>       KVM: VMX: Use higher-level allocator
>       x86/virt: Use higher-level allocator
>       sgi-xp: Use higher-level allocator
>       net/funeth: Switch to higher-level allocator
>       mm: Remove __alloc_pages_node()
>       alloc_tag: Move to mm/
>       mm: Move __alloc_pages() to mm/internal.h
>       mm: remove __GFP_NO_CODETAG
> 
>  Documentation/admin-guide/cgroup-v1/cpusets.rst  |   2 +-
>  Documentation/admin-guide/mm/transhuge.rst       |   2 +-
>  MAINTAINERS                                      |   2 +-
>  arch/x86/events/intel/ds.c                       |   6 +-
>  arch/x86/kvm/vmx/vmx.c                           |   2 +-
>  arch/x86/virt/hw.c                               |   2 +-
>  drivers/misc/sgi-xp/xpc_uv.c                     |   2 +-
>  drivers/net/ethernet/fungible/funeth/funeth_rx.c |   2 +-
>  include/linux/gfp.h                              |  28 +--
>  lib/Makefile                                     |   1 -
>  mm/Makefile                                      |   1 +
>  {lib => mm}/alloc_tag.c                          |  18 +-
>  mm/compaction.c                                  |   4 +-
>  mm/hugetlb.c                                     |   3 +-
>  mm/internal.h                                    |  20 +-
>  mm/mempolicy.c                                   |  10 +-
>  mm/page_alloc.c                                  | 254 +++++++++++++----------
>  mm/page_frag_cache.c                             |   4 +-
>  mm/slub.c                                        |   6 +-
>  19 files changed, 193 insertions(+), 176 deletions(-)
> ---
> base-commit: cbe5256a15fc26f592efb037e528da54b2139ee5
> change-id: 20260617-alloc-trylock-14ad37dab337
> 
> Best regards,
> --  
> Brendan Jackman <jackmanb@google.com>
> 

