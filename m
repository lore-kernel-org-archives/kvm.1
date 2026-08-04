Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D25478E52
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879348; cv=none; b=m5Cl10r9UVVTuldGC5ThSx+BI61Ad3IskMLVJ+ZaN5OoIE+s79FHj5uY/qD3SGIXGMUo3mfk/jjJoAfOQcqkOsvs4AZNXdW+fLqpdAnSzoDtUlTF3f62ArmN5aS1MXKsqEsaOPQhjXtUwtGWn6xBUOuOApPwBdcK9JceF4X43Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879348; c=relaxed/simple;
	bh=dwcQ0xf/SdI8q7f4yUqmfMXSNwVIvYNuvj5PnvLO7gw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HvOFt7QciUAuMt570CYD4NDOqeI7niziQH52DeHQlV3g+FcdPKzXWXeRHQH0gyV+NDN/GiRO404rS7o0jgY/yyKNu8K+hEEhHgS23oNlTSyMibSQdmIuD87mifR7M9T/L6+ZvgiqM0da6DYb8A2IhPsBiPFFcYUMKE1YW0RyRNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DO+MBM1F; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DO+MBM1F"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84a3514f912so376122b3a.3
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 14:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785879346; x=1786484146; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5bYnpDQ6zlSv6ilwY+IJ9PnRIeS2oETKLqCHbQFwvVI=;
        b=DO+MBM1FqPbTQKhTSgwojEXovf+0IZLTY0slID9bcKawLRn/QMcyT4bNZ87U0krKut
         ab092af60m1Mj0XVmxCsmwb1Ds9CZPUnGiR36HLkVDotJ/r3W3Bgk5lv2sD14KpuMgkn
         Z72i1WiD1djcdOCKRaT2uXMovh4Og5OS30DsZ0lL3O8pVy1pAeI0kyosdZ0oPS2ssaLt
         T3Eu82qAbha1BgS44t31pmvyr0xL/TVu3wstia9obrsIU+XGCZDWRw80WjFF9u+ouJu1
         gzPwmfHRpOxiab5JdyOspgGpCX9K3w9xHwr4urNF1aqCJDqWhGFeH0q69QRs4IycR84J
         wRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785879346; x=1786484146;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5bYnpDQ6zlSv6ilwY+IJ9PnRIeS2oETKLqCHbQFwvVI=;
        b=FCo3jbEIRNpZ6JOts9Nw2YcSRqVF9ilhbeC6QRFVwMbceRKjf6rYjlYQIObgo4DLIi
         auYK1gfjnWe5MGm2YyUMRGe+Up7vglrBaiphssfS6SsZh/m7eSJfp47BW2uzhAG3SCVR
         +0LRW/Gm9yM93qo4AR1z3HYtyaAwQYGnnHnTFQDJqIMpIPx7qHtc2sGkf8OlcflLE9dq
         X/jwYvbB69ZdEUnW6lxFF6YgwInZLp/FdREPPkcui192BzxhUKFf/Ms5j4Z6o6BHKohj
         904mEPXJ2/ia49hM9WDZAjgc6WFZ78v47wYIH/FuI4woroy30MtK7pQQx+dBSeJ0E+06
         D57g==
X-Forwarded-Encrypted: i=1; AHgh+RrFOg0wr04gJzYrYRa5qqTiAD7OzcSXFDjkJx6bhhFgN6UcEkSoddL3bZW+O+F8GQX+1CM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKY3SkQBivrzKgNqDyp0IvBYzRdml62CkUzknufwDEn5sboPJX
	WJMvVMS2zz6DPc6y1EOSmlKtcKuDLyJ68XcqPeV25HAkZee73sQdBvV7wWYmZvzmLySfrcZZreB
	8KThVCw==
X-Received: from pfbkq9.prod.google.com ([2002:a05:6a00:4b09:b0:848:8808:ae6b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d12:b0:842:708f:39be
 with SMTP id d2e1a72fcca58-84f2dff7a22mr1642518b3a.5.1785879346115; Tue, 04
 Aug 2026 14:35:46 -0700 (PDT)
Date: Tue, 4 Aug 2026 14:35:45 -0700
In-Reply-To: <CAEvNRgHYhKACDfx9ZZy4a-TTS4yWzEJt=Jc92=eXxS15LPnTYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <4460e252-b6de-4df3-bea8-0368a9d0f4ff@kernel.org>
 <CAEvNRgEUQSju2tW_1zMk2=QmveZNtmkjjCZdqVBgBD2JPh0k4Q@mail.gmail.com>
 <a823e3d2-8acf-49d9-a812-ac1bb2136d7f@kernel.org> <edc3566b-370c-41a0-a71d-2e4a0e1a94f7@kernel.org>
 <CAEvNRgEas_9BEV-cNxXu4_wQx8sR2M4_OaW6DEd4=fszALMV0w@mail.gmail.com>
 <60552bee-3326-4917-b00f-5fb7ba3b8adb@kernel.org> <be77c2cb-6e41-4382-9d2f-cd299f634196@kernel.org>
 <anCtzQrUkFSSq8De@google.com> <99037993-ee13-4160-8c87-b6642faea554@kernel.org>
 <CAEvNRgHYhKACDfx9ZZy4a-TTS4yWzEJt=Jc92=eXxS15LPnTYg@mail.gmail.com>
Message-ID: <anJbMf5GBe0Pxh_x@google.com>
Subject: Re: [PATCH v9 14/41] mm: swap: Introduce lru_add_drain_progressive()
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Vlastimil Babka <vbabka@kernel.org>, "hughd@google.com" <hughd@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 04, 2026, Ackerley Tng wrote:
> "David Hildenbrand (Arm)" <david@kernel.org> writes:
> > Andrew wants to give it some more time in -next, so I'm expecting it to
> > land for 7.3.
> >
> >> 7.2 or 7.3, then I would strongly prefer to base v10 on linux-next (where
> >> the fix will presumably land soonish), and target 7.4 for in-place
> >> conversion. Then v10 can be applied against an early 7.3-rcN and we don't
> >> need to juggle branches (assuming Andrew is ok taking the proposed patch
> >> through the KVM tree).
> >
> > Agreed. We'd also have to get the actual preparation patch into 7.3. I can
> > send it out and coordinate with Andrew.
> >
> 
> Thank you!
> 
> When we were discussing this earlier at guest_memfd biweekly, before
> deciding to refactor out a function like lru_cache_drain_for_folio(), we
> did say that the likelihood of actually draining in practice is low,
> especially on a machine with heavy load making allocations all the time.
> 
> I think the threads with Xiaoyao have resolved, I can put v10 out
> tomorrow. Would it be okay to go with the following from v8, and then
> clean up later when lru_cache_drain_for_folio() is available?

No.

> I'm hoping not to push this back by a full cycle to 7.4,
 
Sorry, but we've missed 7.3, irrespective of the lru_cache_drain_for_folio() fix.
Even if v10 is perfect, applying tomorrow means it will get ~3 business days in
linux-next before I send pull requests to Paolo.  That's just not enough soak
time for land a 40+ patch series, even if half of those patches are selftests.

> and also hold back other series dependent on this one.

Eh, I don't think there will be meaningful impact in practice.  If v10 is good
to go, I'll get it applied on 7.3-r1, and will also get an early pull request
over to Paolo (probably around 7.3-rc4).  I.e. folks can start posting against
the landed series shortly after rc1, and I'll have a set-in-stone base on which
to apply more stuff around rc4/rc5.

And if v10 has issues, then *not* rushing it into 7.3 will likely be the fastest
path forward.
