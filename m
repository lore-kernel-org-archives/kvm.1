Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B853B83EF;
	Fri, 10 Jul 2026 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673477; cv=none; b=RPAOnK2A7KeruIaJUNhm1SXYD40bPxVIS9oIEGzdaCd1UjAGDH9agr4AFeZcN1mbWoY8jn6kTuSyeJf2qKqcKYWMIwBABsS+JEMZPAb1tqeQnbcnioBwiV2I8Ys9XV3i93h9Ux0IsZnQNDW2iGaOgWzUcz1DuaJbTI/lSBQOf4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673477; c=relaxed/simple;
	bh=hAjtZuJApJgFbgnUiOBmxIzFgh7XePbaCXBszR470WM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fd9T7pqucek7n5gahHxwr/0GBn3a3HlYkes6TxnjQv2JY5lH6bTEvssIqQYVFJbhnmtjQ/FcGs9yc2X678aNgNJ8ceR3eLEh6V4YSB8NbB9MlMiP7wr8m/J0eRZhGY2aS5InXAnq2z8KsoAtfklg4QP26ItwYy3OKznVf/NVI+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETskqg1Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETskqg1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCC21F000E9;
	Fri, 10 Jul 2026 08:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783673476;
	bh=l541v1EFpOsT9TcOT7hmekqkweb22uc4jP4hT/F8g+0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ETskqg1QJvbGYjExd/I0ja12H+y5nv0eE4PHNgDPS/o9S4X01yU3/0KX6oxIEQ+TH
	 3xPMY6bKrpbsYU8OSbQ5HnhYx/MD3teIiBCdvz+hWKgcLS+cEuOh9XALOtWQquVG3e
	 9NMpFftxlmMbBUL03UVKSrwRGcO5AzaWTX8ZY0SuhHeXmz9upY83Fwlp0DnM5pCF0b
	 Iiw1ke6R6wLnT491xuGSprUl8dTcsbqO0i+t09PGv827RSM6IoWiChD9RMnGKiIk/B
	 E0IKJ4q0EU3VMyDhXNk9I3Us5tYJDbkIqMO+x0qTYGASlA6pvJpFbqYxMfGy/HBg36
	 gRJdbyuoQ6rkA==
Message-ID: <b2177dec-786b-48ec-ae14-6013df3275bd@kernel.org>
Date: Fri, 10 Jul 2026 10:51:01 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/18] mm: Some cleanups for page allocator APIs
To: Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
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
 "Harry Yoo (Oracle)" <harry@kernel.org>, Gregory Price <gourry@gourry.net>,
 Alexei Starovoitov <ast@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Hao Ge <hao.ge@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, derkling@google.com, reijiw@google.com,
 Yosry Ahmed <yosry@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>,
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
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
 <997c1a4d-ee99-4214-be58-7ceb3b9b9a36@kernel.org>
 <20260705003039.c9b4bd681c059f62b375051a@linux-foundation.org>
 <CA+i-1C0exwnJnp-WXQa3r==d_TeRj2Ocrn9COMCdC93UiWvQoQ@mail.gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <CA+i-1C0exwnJnp-WXQa3r==d_TeRj2Ocrn9COMCdC93UiWvQoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 10:36, Brendan Jackman wrote:
> On Sun, 5 Jul 2026 at 09:30, Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Fri, 3 Jul 2026 14:47:32 +0200 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:
>>
>> > On 7/3/26 14:31, Brendan Jackman wrote:
>> > > Based on mm-new.
>> >
>> > Seems ready for mm-new to me. I suspect most further non-trivial page
>> > allocator work will conflict, so better have it in mm to be based upon.
>>
>> OK, thanks, added.
>>
>> I also added some little notes to track Zi Yan's comments.
> 
> Thank Andrew. In this instance, what's the best way to send updates, I
> guess now they're in mm-new it's best to just send them as fixups for
> you to squash? In reply to the thread?
> 
>> Sashiko had things to say, mainly pre-existing things.
>>
>>         https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b714e19d3@google.com
>>
>> the xpc_create_gru_mq_uv() issues look like facepalms.
> 
> Oh actually I didn't see the point about the alloc_pages_nolock()
> comment before. Other than that, yeah all of those comments have been
> discussed during the reviews, or are brokenness in totally unrelated
> code.
> 
> There is this where we should probably make a decision (also a
> pre-existing issue but this time in mm/page_alloc.c):
> 
> https://lore.kernel.org/all/DJOTMGFAPDBF.261U5OD4NPU74@linux.dev/

I think we can fix that in a follow-up patch. Tag it with Fixes: and stable
and see what happens. We shouldn't have to rearrange everything for small
fixes first just if it's just about !SMP.
