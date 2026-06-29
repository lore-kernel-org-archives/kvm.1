Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA5F1F0E25;
	Mon, 29 Jun 2026 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741629; cv=none; b=jfEVxyWw17mB1lrQ1s2/6qF+VOTXv1jHuBVYbfLXbb9/zgxMnsrbRi55RE/kIqWELCpuPNsnDfDASArwVUvPyBQqnyIXQ9xAelZT1YyohEZR29JJxbTZ6VDgRUFD+IgWLn82rJ8/WJ7Sy3OC7kB5t8FEZ6pxwMwLLcFRq9SKpu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741629; c=relaxed/simple;
	bh=DBkqqzuRnw9PpmOZH6bX4GWe9m7BmKQ83NxR7XMCNyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ht63Hivh41k+qoH3hW2Iq2SVN66UOUm0bMamzz1kodcatkxS3JEY2/AZqX6AG6ImD/qGKrGZ2rLpf9eRIfQYzI6o58/BsYSeU+AQWkUx73YKNYHwrtM5mBqgjcUgJBYC/PBi3TjJ+RKtbuRo3F1fQJCN7pFqbAahHIanEV2RH9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjsGuR1V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjsGuR1V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8695C1F000E9;
	Mon, 29 Jun 2026 14:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782741628;
	bh=nrQ0h8iCijdq9h/HCuxi0sQxJ7nMjLHJaUOCoTtVI6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JjsGuR1Vs43gDkj5KXMbBnUrckiIBoNHJV4r4QaBfZxNjhs8A41+Q/vVdRxiq/O0l
	 Zo94CrqtSLNV6pEWOsb0h+jiYMkielj8UOu603MFzqP8eOtdFOlTC3roS0ZfIFF1MM
	 B8xpXwJWplO0PYAypNGXffK1wJx3OuYMDUw0+RXABJqbKtOM3ljtIsfAMPXMnIyOV3
	 jUrQhkCYV27sj+1/55UYgow8avwieI8D24TINhfQ6KV2mMhV81c7JQNsyRmWkGAdF+
	 exn26b+j7Ip6huuUGjCBS3OpuVP3SUdaS2kUeSeM0QMLnhn30GmoqTSC2sSyI0zC/2
	 +D41WJbjNn1Dw==
Date: Mon, 29 Jun 2026 17:00:07 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, Hao Ge <hao.ge@linux.dev>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Robin Holt <robinmholt@gmail.com>,
	Steve Wahl <steve.wahl@hpe.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dimitris Michailidis <dmichail@fungible.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v3 00/16] mm: Some cleanups for page allocator APIs
Message-ID: <akJ6Z2P8eMm1tc65@kernel.org>
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>

Hi Brendan,

On Mon, Jun 29, 2026 at 01:11:49PM +0000, Brendan Jackman wrote:
> 
> Some tweaks and cleanups for page allocator entrypoint and flags. This
> is motivated by preparation for __GFP_UNMAPPED [1] (which will probably
> become ALLOC_UNMAPPED in its next iteration), but all this is supposed
> to be an improvement to the codebase in its own right: unifying code
> paths, reducing API surface, and removing GFP flags.
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

Heads up before the full kbuild report:

CI has tested the following submission:
Status:     FAILURE
Name:       [v3,00/16] mm: Some cleanups for page allocator APIs
Patchwork:  https://patchwork.kernel.org/project/linux-mm/list/?series=1118244&state=*
Matrix:     https://github.com/linux-mm/linux-mm/actions/runs/28375636866

> I used Google's internal version of Antigravity (AI coding harness) to
> do the repetitive bits, those commits are marked with Assisted-by, the
> rest is manual.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

-- 
Sincerely yours,
Mike.
