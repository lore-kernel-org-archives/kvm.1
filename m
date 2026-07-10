Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2973F1ADD
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672609; cv=pass; b=gCeM2J/14fN/ze2mKOyyJlqT6B8viqXe0hX+Be5a73wTUs5kgLPeTdT7SG3tlVL//huNHR7yzOUJkuB0ELkrd65UPxptHBAWcRwoDh8ZQSKKQBEDdxpXOfTKK7CDHpLeqHZujpq2sbCQb0o1im6PRB8sRjWygWPPO4YCwatDRD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672609; c=relaxed/simple;
	bh=x3VvZRtbcKKcnIyHp/en5u74HZRbH+z8+Yx2BR2/F/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUS9/uaUHCKzaDpKcMiluLJmWNVSGsEVTyv9KnpQO4gfd4+buwHJ76GZMi5bxe7HjLr8PJekQsBg8DjRz7xIWJKff/Bu0RwNLr00P79vPuJrg4xPLIEx6M6GHint55SwKYQWa4gQ/TBPQ3qceOLW1nyrtcyR7hZwtQed9dY13xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YTuOyR5Q; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YTuOyR5Q"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso6893a12.1
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 01:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783672606; cv=none;
        d=google.com; s=arc-20260327;
        b=iO9+kaE7HHZIbX/hhVC0QxTjC1IF9QKrqsuDMO4ZFj4tSA/FTXSszys7RRJLvYWFdv
         yIhttaZaayXMhDbCi4gN/SnLu+kkKN0so3k62EHUpIcfUDCsvpOHaFAgAHjCPVKF/OMo
         dj7GmHueOxJibQKz/ozMDU8vbQnC+jLwQXq9qGwofnVG4voiZ6I0tfkwD6dX7uZyU6IF
         2PVaBp/I7rIX8DfbLadXBNQQHfRWl+1iP2/Z+VC3tB+4X2xhsWFoFJmDb4am82RntTxB
         CZiU9CcwzKBwlQoyhf53OGV7Z5cy1mC/iih61+qPHQZrfGhfOQtMacK+L5TNTCMZWsNv
         9sPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5vusuleFjZncfXS2nyCDuITFoJSaIiJ699qFr3aBd5M=;
        fh=mCbXxTVN87Uh7DQol78sgW7wQchd/BOYaIZvYqBEouQ=;
        b=LXlp2zTi6/eUAlscJU+e9IdL5gCtR6y0i8NbPGuIPhez8WygIS+ODT15LK2ZISRvMF
         ojbA/q6Qtc8cEQjV9T3lOZPMa/6lfRaPdI59PVRqsuotFBcFXFlWL9yzTtfHAtxj5Ha9
         +xLvJHEjS8sPxfoaQo+J9f9Gr3AqZIuFUH1SxvVmj0xr1MPNCdNv4Uzk6cR0osu8F9dd
         mErn1F8JsshBBDsiJUUpNDj7NlB0xnWn8YN+pyNZm5Hx8jfS5Wlhh9YpoVKjCtDHhg/P
         azNs3fvxWmKXvlQVmLBFgBr6mNkWvp6r//D5DpLVMzQ8rF1ugskg2IPU3ajJBAn8A2Cn
         CuWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783672606; x=1784277406; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5vusuleFjZncfXS2nyCDuITFoJSaIiJ699qFr3aBd5M=;
        b=YTuOyR5Q0/EB6uHDdH3T9oNDxDxkGZfVGszz7ng9JadWMe9Xs34gf6ZXHki+RRSf9M
         yznkEtMx8nLDza9bLjUnztrPP0k5OpXvIj8TXAOLyGUuupkZMRGR9Jab0IqBxVlEuseM
         fGWaU7wmeqoa4a40JcwRqGc/Jcnp4HbTRxDiCQOPPidpHMRvo93kvWtVH4hPAZIIa6c5
         msStbhE3Eos4A0sRHw2Y0mf1wgHDu294QQJqcJPtahIR5nMLNBKyGMv0qD+bHFqRmHml
         hrsB8HYFvCS1ynH7DjZDD0FjB1nLQmKfwQoUmfreGzJzyGY6tN1hUuAErj7NrOY6mUly
         sfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783672606; x=1784277406;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5vusuleFjZncfXS2nyCDuITFoJSaIiJ699qFr3aBd5M=;
        b=YRKv47p0yhgZKPNTWg6G9XhvsLOUS2KSMBoAMHqytBeZz/AT2r4ytlTs+mbO4pGNIz
         aYBzM9FsGbwRTvXzuyWTHBprdKZ1YZrehu5/9IkjGki5eBJnzWNBjFGnh3QoU6fsVdpQ
         S/FgpVK4z+rjQDurZ0kvP46CwYlQMx4xZADPB+qONcuvKv60yOfdGe7sK4LopMeN/WH3
         AX5u8ZW0BNO+wF1MErl6Awb0MRjYIp8GfjvJh9+caqTPTRlvwGBmA/8GbksxMbzzD6aM
         gw5Ti+k9/24vwVHjVQxfWYMgFqahFHidOusVLu/gXE3RLt4hGY+q/DYlbxnyxQcqqQKZ
         J7yA==
X-Forwarded-Encrypted: i=1; AHgh+Rqp+j0FeKX9tziJ4/n/p3ivlG4sciJUaJloPICG4y1hOZegHkKZCZnYR7cymzV3rxpe9vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrNba4zoz8BAK8hks/hJxviXqwN7x30UvtPJk4mCExhhAJdr6r
	1OCm7rnKRCKSJi1Ht2Pls6QjHdOP7/R4And3RWGHYXa40HuHRqcbSz906VuKIFaseZIhMiF8YCL
	H8Qmms7Lc/aDXGOuHjUONneyteJeIzkud/4y0lFoB
X-Gm-Gg: AfdE7clFf640gPlSJH/Y4VOetfVNdAqijkkTD2hXOCCOMaHpALrLjE4XOewb14ybzDr
	kTAWo/XbUw/MgDLPDgt/GJ3Xfc8+ynO5lG80z6m+K53sP+Z5YbMHHsanUFbu94YulaBpYRLKwcl
	Dp45TWSfghoces6tlahdAiblDIXRU19gGCvsTtpWQCFnCoIqP7WnMGErJGBcwbezuLgh7+FDNQM
	x6K/FSh/yOL1t4WBeU1OuCcP8IpbS+INKqJQ5CnT67Hp49EinbPrSabwnoSQcxaNAzifNFM//nM
	9BhyV2FU9EgSLH9Is5ygTqnbWA==
X-Received: by 2002:a05:6402:a541:20b0:697:6b08:459a with SMTP id
 4fb4d7f45d1cf-69c29ed9df5mr35748a12.7.1783672605521; Fri, 10 Jul 2026
 01:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
 <997c1a4d-ee99-4214-be58-7ceb3b9b9a36@kernel.org> <20260705003039.c9b4bd681c059f62b375051a@linux-foundation.org>
In-Reply-To: <20260705003039.c9b4bd681c059f62b375051a@linux-foundation.org>
From: Brendan Jackman <jackmanb@google.com>
Date: Fri, 10 Jul 2026 10:36:33 +0200
X-Gm-Features: AVVi8Ce87UhCHbfmvKkRHtYsfZSbDlT7JQG_kxBAkz9MTI2Uf45nPVr5mC018JQ
Message-ID: <CA+i-1C0exwnJnp-WXQa3r==d_TeRj2Ocrn9COMCdC93UiWvQoQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] mm: Some cleanups for page allocator APIs
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	Gregory Price <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Hao Ge <hao.ge@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, derkling@google.com, reijiw@google.com, 
	Yosry Ahmed <yosry@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Robin Holt <robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dimitris Michailidis <dmichail@fungible.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Jul 2026 at 09:30, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 3 Jul 2026 14:47:32 +0200 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:
>
> > On 7/3/26 14:31, Brendan Jackman wrote:
> > > Based on mm-new.
> >
> > Seems ready for mm-new to me. I suspect most further non-trivial page
> > allocator work will conflict, so better have it in mm to be based upon.
>
> OK, thanks, added.
>
> I also added some little notes to track Zi Yan's comments.

Thank Andrew. In this instance, what's the best way to send updates, I
guess now they're in mm-new it's best to just send them as fixups for
you to squash? In reply to the thread?

> Sashiko had things to say, mainly pre-existing things.
>
>         https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b714e19d3@google.com
>
> the xpc_create_gru_mq_uv() issues look like facepalms.

Oh actually I didn't see the point about the alloc_pages_nolock()
comment before. Other than that, yeah all of those comments have been
discussed during the reviews, or are brokenness in totally unrelated
code.

There is this where we should probably make a decision (also a
pre-existing issue but this time in mm/page_alloc.c):

https://lore.kernel.org/all/DJOTMGFAPDBF.261U5OD4NPU74@linux.dev/
