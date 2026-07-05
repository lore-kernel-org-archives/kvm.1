Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66BF357A25;
	Sun,  5 Jul 2026 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783236644; cv=none; b=p6oO8GHRQzRmRaKT1kWQkRXwaPukXIbC64QVetjVHIM78mHi5FU1HJYbapHdoPd2xHb7pfnNwvqkTxoaB/ggni2nvU+cNGkJTeCBN3bVJMAZ9d9mFkcaDXhTcLR4RMxLUEZJNPbC6qng+P5dhdYkTcVNE31HcEYtjIFOHmgMX5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783236644; c=relaxed/simple;
	bh=uQm7P0YcAHvP/UTB1DrUBsqTrFmgWyaGlmGUZwnbylc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NOryaJ8sNIky60u+8GTyyPf6mlsU7dsAbCqk6WIdg0FFY1hFibjy9HMoOVp87hbiwrsQOEBdI9UcyLzdd+LzI84BrD6DcF0u1WuwwjL79QIxbjjGpUjkNkCq2RvTx5u6H2m5oAV31P3b70o2L/VbCxjiRoatdYGVNQmqfLSYK5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Uk8MqM1T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Uk8MqM1T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4E81F000E9;
	Sun,  5 Jul 2026 07:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783236642;
	bh=mUhQ5u4srEz04rLNb28RAAN9CUToZCgnPFuwRWvIo0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Uk8MqM1TrvQ2Akr0P3bciF40of6gy+2r77qKifDdcmk+qMvAzZvqNZNizlgWpy2sP
	 Sh7R8LGrcBagwPZ0SXdHjCF6fAebxasfDgpUIjtzRZnBjDhp/uPV4hFnlU98MdeovZ
	 m6FkUJiVolp9rJDCVQ5/py1KTK1KtsVixAeVfnTQ=
Date: Sun, 5 Jul 2026 00:30:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Brendan Jackman <jackmanb@google.com>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, David
 Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Joshua Hahn
 <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park
 <byungchul@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, Alistair
 Popple <apopple@nvidia.com>, Hao Li <hao.li@linux.dev>, Christoph Lameter
 <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Roman Gushchin
 <roman.gushchin@linux.dev>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, "Harry Yoo (Oracle)" <harry@kernel.org>,
 Gregory Price <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Hao Ge <hao.ge@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, derkling@google.com, reijiw@google.com,
 Yosry Ahmed <yosry@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James
 Clark <james.clark@linaro.org>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Thomas Gleixner
 <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Robin Holt <robinmholt@gmail.com>, Steve Wahl
 <steve.wahl@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dimitris Michailidis <dmichail@fungible.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v5 00/18] mm: Some cleanups for page allocator APIs
Message-Id: <20260705003039.c9b4bd681c059f62b375051a@linux-foundation.org>
In-Reply-To: <997c1a4d-ee99-4214-be58-7ceb3b9b9a36@kernel.org>
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
	<997c1a4d-ee99-4214-be58-7ceb3b9b9a36@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Jul 2026 14:47:32 +0200 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:

> On 7/3/26 14:31, Brendan Jackman wrote:
> > Based on mm-new.
> 
> Seems ready for mm-new to me. I suspect most further non-trivial page
> allocator work will conflict, so better have it in mm to be based upon.

OK, thanks, added.

I also added some little notes to track Zi Yan's comments.

Sashiko had things to say, mainly pre-existing things.

	https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b714e19d3@google.com

the xpc_create_gru_mq_uv() issues look like facepalms.  
