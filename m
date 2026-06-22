Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD436EA8B;
	Mon, 22 Jun 2026 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133748; cv=none; b=Uv4GS8x0PKdrV2WGH0D3LYsAcMDO0Aj14g5KfENRdX83BKP0fvrpjyQWxLm8RGLXePZ08FvOnKn5YWS4uE1Zp8F+dd9CA0EhuB7+7MkOm0jUh9iRaHRV5glFvrwo7ym/SW9zYrUcCcWbtN8v6k7V+N0gB5mPvtEtWxP/LenXPU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133748; c=relaxed/simple;
	bh=gZFdRQ3GzBV1ICnHazzOEay0tG4QdLrRZcdMJ9xFc38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEMheCqXTfhy0+Av1GtaTl7C+ZgZwrvGbw0+uN/k3aRD4u1345FSM/CDeMsnQY2s6rW+cako66k/81+v/EoRyG7h+lHYd9B5xiwUeVlJWAakF3Kj8eJjK0MJiE85HlAsKV8gyzo8QkL5hf7IMCgjZK5Row/0nhQm5uq/xtdQvaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUM9v+wL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUM9v+wL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34141F00A3A;
	Mon, 22 Jun 2026 13:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782133747;
	bh=gZFdRQ3GzBV1ICnHazzOEay0tG4QdLrRZcdMJ9xFc38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KUM9v+wLZQO1enI+613wmnzT5egxmMhGsrEkuqN+eZP9WGyAxxpH7mgEw3iPsFslR
	 YiaYDYjhOFRElWICPJ+JqrqiOmq4erOBWjVa5gyD4vd4lDqQ3jdB6TduZ+6VveFBWT
	 erzp5pR4Jmekf/pM3TbZ42h/1XVll872BDQWM2+tQ7gRSDA0JUtLXYwQItTlf5JR+8
	 2twS2Intb0BHBaKE8gx2QRKXwOCaST7ZNwWkuDGfDQispoVoItGORL02yUVxD/lVkT
	 TAA9GEK5WxOg7ftjS59xgVbEkvODv/RHUhPIL1ISoP1N8/IiWxqyJXsWZ2tQTHg1gK
	 Et44PH7BYtLvA==
Date: Mon, 22 Jun 2026 14:08:51 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Mike Rapoport <rppt@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	"Harry Yoo (Oracle)" <harry@kernel.org>, Gregory Price <gourry@gourry.net>, 
	Alexei Starovoitov <ast@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Robin Holt <robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dimitris Michailidis <dmichail@fungible.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2 00/13] mm: Some cleanups for page allocator APIs
Message-ID: <ajkzGElCGxJt-s84@lucifer>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>

Thanks for the series (cleanups are always welcome :) but just a gentle,
annoying, note to say it's week 2 of the merge window soooo we're not taking
anything at the moment as it's a quiet period (mm-unstable taking only fixes
AFAICT).

Though, it's potentially good to get stuff in front of people early, just an FYI
that we're trying to move towards keeping the merge window preview/RFC-only
going forwards.

I'm not sure if that'll fix the impossible review load problem (TM), but it at
least helps keep us sane re: what's actually landing/not.

So Andrew will expect you to resend this after 7.2-rc1 appears!

Thanks, Lorenzo
