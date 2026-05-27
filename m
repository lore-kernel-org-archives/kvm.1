Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85E53E3C7A
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896145; cv=pass; b=LxThLvBLyyywNmytQqaOGan0Gz3Y2wPaNH5twVNK0bPKeAhkE6VwRAAkaNznsjL29y6BCzugrFhKrU7oC1+V6u327+c1vPk0n2ac7XekMOeJlH64BYjrU6qxuMly92zItqlNds7lOoqjdk7JqRh/6EEgQjnmi10aX5c01PYug7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896145; c=relaxed/simple;
	bh=/34ZEKo4WKYSNfKeZJyC5zY+tHi9Bq+q7x5tIuisplU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpNBGxl7hNXYc6+ZfMEh2NCVA2LBp5JDtpqIw0mHMcWSg7e2YQHP0FlJSzDNveRCdfqHBqPLqpv3S+WpTStOqZH90yzLox4EzA3hKUF7B4pdyVGy12TLTL0JVexuhRSeJXePKmTDJS6v//p59bOpzPK5Rrd59WSLkkiPZ6Yy85k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wt/O37Jb; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wt/O37Jb"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-134ac81c445so20324809c88.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 08:35:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779896143; cv=none;
        d=google.com; s=arc-20240605;
        b=YUWMdWwV7orW6EyBFAEb3eZ1SS0JLu4TNe7XGAK7lVKwzqJmF7l4ylcsqNcZqX7oQz
         QmGtcx4x6pbt/8PSW2vXza2eOpxWtIeFbMgCk2HL8g19tb8lxKhHxbtG3yyWpzR2Gcw+
         5/4XDdvp56NMpBoYqHn1BWlpUmOn2i3MzKLSQXyIzpKP4dqmJeKOH2DTMi3N00/8/sY5
         24dOWJg+t+TYde7uFm54hw2WhHwT4E4yoNi1njd589FxZeRfxk0oAHYyM3x+YbEuqeD7
         tCHSFubezvqTklHyFqY4Dy3ZLvBdsRrn2LI08gyI17mVuId8S7nYw1PP7d+df4fSXFcb
         daxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=/34ZEKo4WKYSNfKeZJyC5zY+tHi9Bq+q7x5tIuisplU=;
        fh=cAmXX4QN7kAzmvfkxTdFwzOO8y0jzie11Cwe5w+vYbI=;
        b=gPjN2q9ftYtCJzqeWnvt9MN9jlVj0xV+TzWOsW4zPlvVHTH3GVc1Ipswj9AZuM/UxO
         QRpJKek4DAUpJJfirvuhvGvoZ45Sxb1OzsRT/CZe5CGj5MO35xbWPANeVZ8qNhSgKe4q
         +vYR7MT0FFiPh+uv2Jv4ixxbXBhHnYyppoaU4FQuIVNoLhp4psccpuFlX4oshi15AKa5
         AOdPmFGZLyzQkqdbtOChYvzsM5Pu0WSns3mYEDzvPkHMylnKIva4y/QOLVV8oLU/VFQe
         bEu5D9hL7W2YuKrmf7e7LuwP0WACNIuV4kKozhQgtp2zUpnv8GuChoaB5RetyZ58HEYH
         BbhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779896143; x=1780500943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/34ZEKo4WKYSNfKeZJyC5zY+tHi9Bq+q7x5tIuisplU=;
        b=Wt/O37JbYDl4yd5Km/nAsMShHhMavvHfWq9StSAp3LFUK8CYUV2vcyGMtpJljM5qs0
         Qd7khQMbrj/j6jFUmQe978B2aqvrzoPTY3QZQ4/RgRYQ89Q4E80vFtVpbQO9NZ2Bg5pR
         +4qsbxc9rCrq6KCOTJfXAGVMVURwAC4qgrnyq+4DzHcDefdVDhuHBaGnyYNZxG2jrcbL
         ZjkXcv/Bgs8i7XG5WQ2YpJtAcoxPiI7qmbTWT6ErUA+Xw8LgVNvkUDAezHm9hxnTz5Na
         i8xQ9G5L9/03p0AXx4shZ5vSZN21ldaoptMhVgXgq1St7tlc3mg57Io5GxElZVbJ8Ftj
         BUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779896143; x=1780500943;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/34ZEKo4WKYSNfKeZJyC5zY+tHi9Bq+q7x5tIuisplU=;
        b=h0Jl8a8Q1WUs07dtbonmnag1bj3IRa60i7gc/zieCpy89gxueUi/tN1qpUDPELswX/
         lZL0htEkK0ockPuVcdwEYVQVNyhG3ghmFWXuTxArQU8xFSCoSFH7eL++1S/mkR4ZBNNn
         Znr66jTzDjXh8vYwsP76HYtt/MUCLcdk/GrR06bM5Tw3q1MOZWgKrWrvBV8/g9Yx+ubp
         ySoU8JmGNy9uRp8X/nTK/En2Rghg8jM4ZNuj6s8MidgKhTILs/DGc0Fnks/YGeBmhB6n
         oerbImZG4d8x2iWh3eQI6S906wUGp1v5QbUBrjAU7uCxxJJiHM9+quUmVwUgkJJ6LZkV
         JgIw==
X-Forwarded-Encrypted: i=1; AFNElJ+LqXWzYmDPweLCQxTz7mJY0rjbNB7IdpZPi2EBZbGgs4X3tPBh68YwQvLi3yFbAkG1+SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWwo+YTrcM6ZHlFah1qUgXuov+TBEju0SE/OnClfOpdOKT3WWY
	2ZNjTKFyniHz6cgS5lDlTssj6OxaJnPF6L+Io2CHfEpH8WK1PfzkTQg9pL6uKegQqFSEDyRlh0l
	YQ9iZ/pNw+OQWiie+1oqttfCJRw0LREHxJViemziA
X-Gm-Gg: Acq92OECQCC7IJ2jZ76idmOhKOQxXplsilH4boV7eGvRKLMCfCSORnFkIQc1VptcIgS
	Sgb+1VdKeBpAdTJZdli2aOZliPtE07erbBZJuptz8lGGpc7PQaASHLBx9bE/kuRWTQpgjh2G150
	zHY1pgEk84d3rF3HLfLmFWEolFIreOGhisKmV+CyrE9yDIEOQISR7nIOjK8UKjtTf5KVZWzn5Ev
	6iuqRu+mNGC89xytGyjhvwNt0RTmRX/zoUIoUP4Pf6NLqs8Mc6lT0eB+XMyYjy4mMu9b4esSKcF
	q0ER986m1i7wMxSF0yZxKKw1H7WTC1OXwsPkjwSVI1US5h9QMQ==
X-Received: by 2002:a05:7022:525:b0:128:d4be:7428 with SMTP id
 a92af1059eb24-1365fb4fa18mr10605757c88.19.1779896142087; Wed, 27 May 2026
 08:35:42 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 08:35:41 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 08:35:41 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CAEvNRgEZ9vCKkoMC11tVrueAonGWH2x6OeaYYxXGEj2gwHUaKw@mail.gmail.com>
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
 <20260507-gmem-inplace-conversion-v6-5-91ab5a8b19a4@google.com>
 <CA+EHjTw-cUM=FrJevtSDtR7K6MwUfGfOx21LMFDn7DAy5bFzYw@mail.gmail.com>
 <CAEvNRgGQvMdDmVfbk42EY_PGN0ybTp-x21Zj+pg_X1mk9iCRtA@mail.gmail.com>
 <CA+EHjTzLCD-dU-euZKgzwyEr2ecPqFDNutcaHm2fCDGA+MHVXA@mail.gmail.com>
 <ag8JIlHjohAOC3-g@google.com> <CAEvNRgEZ9vCKkoMC11tVrueAonGWH2x6OeaYYxXGEj2gwHUaKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 May 2026 08:35:41 -0700
X-Gm-Features: AVHnY4JKedjh8K8TNAXOjoVnM50DfBi_EKpudGArqGboylLRPDEHJZCPBXCFwT4
Message-ID: <CAEvNRgH_ToNJunEmQKn3wED1aF02hwg3GrQcRwwZTs_bfPVf_w@mail.gmail.com>
Subject: Re: [PATCH v6 05/43] KVM: guest_memfd: Wire up kvm_get_memory_attributes()
 to per-gmem attributes
To: Sean Christopherson <seanjc@google.com>, Fuad Tabba <tabba@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
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
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

>
> [...snip...]
>
>>
>> Hmm, I wonder if we can figure out a way to consolidate some documentation,
>> because this is _exactly_ the same pattern that x86's host_pfn_mapping_level()
>> deals with (see its big comment below).
>>
>
> This would be great, are you thinking an actual comment or something in
> Documentation/?
>
> Perhaps we could iterate on this a little with me providing the newbie
> perspective. Do you want me to take a stab at writing something up?
>

Please see https://lore.kernel.org/all/20260527-kvm-locking-docs-v1-0-4fe8b602ff47@google.com/T/!

>>
>> [...snip...]
>>
