Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD5E3E95AE
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780607676; cv=pass; b=R60hMXQ2eP9/nTkH9JuN9abmgUY4X+b2m8ihjFL5AOppq7Kqfh0CzAB5B4I+Hlis7jgx2PQG/pLFZTcwy8O5YUHV9NeRk/vVt9q3sjwUJhDEX/GcDBdo/APF12LHixlt6iKtnSKhzYecXxMQDjmtxdwQJiPTYyJH9r2GtXj8xMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780607676; c=relaxed/simple;
	bh=3EQQ6v/Jh1n3vmJAx1K0KnEtPJfjxcjgCdoh94k7jVc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdZkIlcypAS0PHkBLEsyZmL89LS6ZaUq+arPdEI025OuuMoncGre000kuyoVdOln7cgP4LSVlGcPeaVr5JDGJ57Tg1b0UTk1dE35Tpj9P4lYAN2aSWJ5AVN+gX4QIPxd65vaYmCTj0SCm/Ug82HebUYwcNAE3Zu77KtU//vGknM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HSRVmStj; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HSRVmStj"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-307631dbfedso2397677eec.0
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 14:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780607674; cv=none;
        d=google.com; s=arc-20240605;
        b=g5WJrdPABChFPk8Ek7WlsOlz9jTzqPrakseBRn0QgY5CV2pRNvcMNXPPTk7ZDAuiB+
         sN7ro8bny5XpTAtO2IQmL4AqkY+k1UBF/S/RhLMKy8WfEW3+hbET94KY5ZJBWh88UzjF
         IuMR4z27rccDX4/pB3QZ1ATOW3OAe/c+EykFN2pTI1Z8nmL1r3W0nn4sRK8UV6m2lGdq
         7p9Ax+BtGjElB8K6o1F8nRz4J0VRiqJwkD32/oktfnZDOB8oCkYjvkfJMR+MjzfmP2Yi
         nTBAytfyCn0Lh/4zW45NqPZG9uP+Er1kYts+pvlrk+L/e4j5dmN7qNV+6RBMG8kaqkkI
         nqGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=lyPEsnWgMEwVBTMM4vHE6GHrBW2HxmanLD1B4poadMk=;
        fh=MFwBXLSgMYMUOriYcJ3jVbFqUlgDyJzGFG9p2CUKdmI=;
        b=C3RUjjdl8bSJ1FGpZkFjuXCun9Ln4H24/Pes7LWo4Ok4biz42qUdBlIwCz148bCHrp
         nWWa9vUyrKglz6ISmXUxmk7Wnn/pzf1VME9WlMWkixk4Vv2H8yl+3VsfBunDUnovfMmj
         WLBK1fE6zhbWHqf8Rb5vtt15ZD0IDtwi3J9scTACzvzd0jPpJqhPxkp65/s4WQAC7c/g
         1sCNbOFHof6pMymwHgSPN3wM5uX0Y7LHjmYQGR+X1GEgfoZ0N8jDN4+H4uXftw6IfrEn
         9o4X4O0rMPQES4tvLHW+EBY6E84UvWlcQyvToOW2sgfrmxwQX9EMbLFROg+FAVJ1CayV
         GWJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780607674; x=1781212474; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lyPEsnWgMEwVBTMM4vHE6GHrBW2HxmanLD1B4poadMk=;
        b=HSRVmStjClcx3bpB0Nbb1WbyCagVBGV1o7cutwUR264MGwQtzC2eb77Y4bg1tLolFP
         UxRJgZO+x7uVz755belwPYpkKr0fa/sLsswY6U1FbRuGSq+FRLZFV9E37egIdz3AcdQD
         Y6oth/EnlnZP+/as2xeBZe3f7YSCyOc+HK+OHIlR+MxlsswubTEXHxmnK/Y/SXtN+RNO
         jjIk9ygzfucGJ4Lbodc642V544cS1eVP+enD/KpsMBJXgJncUfmlXv1lk0kIwxMlnR97
         hDrSM1KDXGTYGLzCh7o2tGiU31yb/ExLLod3UWlbUSsGzNOsH+nfF8R4e8YKs+r5EgoY
         Z6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780607674; x=1781212474;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lyPEsnWgMEwVBTMM4vHE6GHrBW2HxmanLD1B4poadMk=;
        b=hJ3BAB24xQnn4MZKAdlpMvSEaZLcK2l+B8Z1g7OTnQyjKLJZRuQnkRrhQuEN/gAnYk
         vau4s10nvEpyl5MLT1MLAtMxqz4JQKMXF4M9rdFr0AFKivjfSNTJifniInFswkqK7+gZ
         wpEpAVBx9KIY0bIuyvBXY3ZPGaftDevXOrDg4lcyy+GwB9gaJwNmDEsWzPZgAITdCkMs
         oOvccaAxG7YWMcqJiBSIxw19dwmU/viq7kjAQIsIzrz8flEuUhRzQRETOEXYiOq62xT6
         s2LhTQyIWOXesnfi6LI5NIEE/XRrTEE5xFbKDsDk32dbg1cd9+ea3Q4gDCYaniISIaqB
         lWYw==
X-Forwarded-Encrypted: i=1; AFNElJ8XkAZXDvX9szrKOP2fXjHlR3FM6F4mb4QDs7k7HyKCK7fgqC6BKlShuUF5aPyrclMt14Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1PvEcGMa4heZz4v/4V7NpDqEbPHe74IANpNW+0MQFkdk4jN3q
	Uat+e4DzjwuN1TcEvdkM4A89HdPi1sP8pY9q+6GTPXiMR0nbPZaFxe4zebvXhvvnUOgBv33AIDn
	+M+V4FLuOMv2U2zSh/TyTJD5AlGhSs7EapDohGIC0
X-Gm-Gg: Acq92OFhYwssyEubzGoHOz8n5liwWoMFnQVkYZbB8dyrt5pXw3BlNmL4/a3X877/8jo
	GyNhfYPuNP9vKm7MHzmRd73ru85HJl7zH/Y4dZ6b49eaPOWdWM9VuOl0K+75dRImdPk4ahjbuYP
	Dygpvc38YZJk3MY1RnWqAjd+4LwKL6eTDl25+AK12Ye0NyU+8FeQ5iF4sk8qbBGb6naXJWu23Ow
	P7M8QscTGuxuA5CWI2SbmDFcfZ2oQaJqb0DbEgYqjrAYR5ldN2qR+ixsqhWJmxCdm7WgPlIEPN3
	uP2NkoExT20gOCwa4KvlooWwa3/Ry+oAKgaJwvHHk3d2AcIWRRAAR7FIiRHbA9cH+ohXLv5eXiK
	Ok34=
X-Received: by 2002:a05:7300:5b83:b0:304:acc:f086 with SMTP id
 5a478bee46e88-3077b7ec417mr207174eec.33.1780607673246; Thu, 04 Jun 2026
 14:14:33 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 14:14:32 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 14:14:32 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aiHeDZEPkAcWcSkn@google.com>
References: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com>
 <CAEvNRgGpaggjd3=ooyzv7iEbmA-x1mWJHgjLSjPi8=5CPrk-yQ@mail.gmail.com> <aiHeDZEPkAcWcSkn@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 4 Jun 2026 14:14:32 -0700
X-Gm-Features: AVHnY4J7O-BvLwAbWwmNVfQCapmW0Jz58QA9MN7lFJVjBHp7oGK-p6NKEbfSA24
Message-ID: <CAEvNRgHz5GDjq0GqRmpQdHc-X45gCNr39VYWZH-T7XhPEtN5CQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/42] guest_memfd: In-place conversion support
To: Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, ira.weiny@intel.com, 
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
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Jun 03, 2026, Ackerley Tng wrote:
>> Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
>> writes:
>>
>> > This is v7 of guest_memfd in-place conversion support.
>> >
>>
>> Here's the outstanding items after going over everyone's comments
>> including Sashiko's:
>>
>> + KVM: TDX: Make source page optional for KVM_TDX_INIT_MEM_REGION
>>     + Need to move page clearing into __kvm_gmem_get_pfn to resolve
>>       leak where populate can put initialized kernel memory into TDX
>>       guest
>>     + See suggested fix at [1]
>
> That fix works for me.  The initial guest image will typically be a tiny subset
> of guest memory, so unnecessarily zeroing a few pages isn't a performance concern.
>

In regular usage moving the zeroing in [1] doesn't change anything,
since the same zeroing would have first happened when the host faults
the pages to put the initial image. When populating, there's no more
zeroing since it was zeroed.

[1] covers the case where the host doesn't write anything to the pages
and directly tries to populate the pages to the guest.

>> + KVM: guest_memfd: Only prepare folios for private pages,
>>     + s/non-CoCo/CoCo in commit message "INIT_SHARED is about to be
>>       supported for non-CoCo VMs in a later patch in this series
>>     + Use Suggested-by: Michael Roth <michael.roth@amd.com>
>> + KVM: selftests: Test that shared/private status is consistent across
>>   processes
>>     + Improve test reliability using pthread_mutex
>>     + I have a fixup patch offline.
>> 	
>> I would like feedback on these:
>> 	
>> + KVM: selftests: Test conversion with elevated page refcount
>>     + Askar pointed out that soon vmsplice may not pin pages. Should I
>>       pin pages through CONFIG_GUP_TEST like in [2]? I prefer not to
>>       take a dependency on CONFIG_GUP_TEST.
>
> I'm not exactly excited about taking a dependency on CONFIG_GUP_TEST either, but
> it probably is the least awful choice.  E.g. KVM also pins pages is certain flows,
> but we're _also_ actively working to remove the need to pin.
>
> Hmm, maybe IORING_REGISTER_PBUF_RING?  AFAICT, it's almost literally a "pin user
> memory" syscall.
>

Hmm that takes a dependency on io_uring, which isn't always compiled
in. Between CONFIG_IO_URING and CONFIG_GUP_TEST, I'd rather
CONFIG_GUP_TEST.

>> + KVM: selftests: Add script to exercise private_mem_conversions_test
>>     + Would like to know what people think of a wrapper script before
>>       I address Sashiko's comments.
>
> NAK to a wrapper script.  This sounds like a perfect fit for Vipin's selftest
> runner (which I'm like 4 months overdue for reviewing, testing, and merging).
> If the runner _can't_ do what you want, then I'd rather improve the runner.
>
> [*] https://lore.kernel.org/all/20260331194202.1722082-1-vipinsh@google.com
>

Good to know we have this!

Thanks, I'll work on a v8 to clean up the above.

>>
>> [1] https://lore.kernel.org/all/CAEvNRgEVC=fFuKVgZYvWyZD7t_zvUZihFG8hrACjvtkD5cwugw@mail.gmail.com/
>> [2] https://lore.kernel.org/all/baa8838f623102931e755cf34c86314b305af49c.1747264138.git.ackerleytng@google.com/
>>
>> >
>> > [...snip...]
>> >
