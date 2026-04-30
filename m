Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE3E3D9045
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 23:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777593117; cv=pass; b=WbUrPgjKw8qv44Kwkx/NUVq4WMu8d6TNQmfu/XzByH8jgCplc6+UOGVZF8Sbg6eyDVqVR/T25WPzzDNfYmzvBMs/ieeZrRt+j/mxLBHv1y0TWztKN032Zqvc6FULY3eE34+dQw0T/RxxWm/5G1afncwL2jzPk6VRGbP7sW4nfMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777593117; c=relaxed/simple;
	bh=UxyyQr0iDJsnmrDySmyYHIs/8DyWV1oc/NXfPvCT6kQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKpMJSHbycim7gZP9aq2vRhp+VkTSpSPqjqqfgCW9wLOtlt6hcAb1HgyiJz8IvGA6GLOVV8fqGB91ZjljEJhSA8IHaQmMLhCazaby+TKXwxhtcQF46AOE53L07YLKeK/8w9rRNbQzhJJyHdDBP0evDx6oSYpc9XXzvVpFUslgu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CqSFCUZd; arc=pass smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CqSFCUZd"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56eec951db1so513376e0c.3
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 16:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777593114; cv=none;
        d=google.com; s=arc-20240605;
        b=YrLJyi+Khiq8kSpNnT986DGqOSclLi3D8uFCqPGLUN1SYFB9ACuD2/UGBDvLyzJRtZ
         8fE6FFaC9eKy1WjuLhlyTH8pFGpuGoV1Q2j33tchUmcCYmm6PbqgJ1RJt7mMVHcq27gy
         axeX0jaE8quBTqmeZama29A8LkO399ky9qAVUhjJLRA7RrwnTXCM2Rt8hRqt7onIWhan
         O01xuHj53pEpoBEOrugPhf6RLkhH0yCgtlq4w92+mlct1fGvEe3MP+FhuSycWWor9WL0
         2Ggb1z8mzKnGV5qaqSmZ+hREtnUO9eqJsMC0X6hiqNWzV0SP1z7HiRaM8Ljl8sGxApEJ
         e4bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=BpU7aJAXyZDKrOT/BsTxtUzbjAh38uTL3HfdWXDy/eU=;
        fh=qAS/4nkUVDhqNmPF0g8hdQhUQvfkapu8ALkP3JobDSQ=;
        b=kCEHD4Cw6gtSl70SJgm6PUT6hGwI00cQxIKWqUB78Ks0w0pUmEYVG2WwEokdBGySNV
         MpihdizfzlRX59PhSCymBozHIPR//1/Z+KPohm3aNhN0gAH7THuR5w8b/gLVgfW1uR4v
         /tUPWqv7mltzw1r9e19+wrYQpzier4yY5VjgKFfW5CiSEV3++fuNkyxroyv8J6DjexPv
         /4k6a6WDEneCKpxP2jWdLMz8v9ImtLHMfRPTU3A3xdGAou8eaxQP36vX3ub7KJ5btV/L
         JNnbgnWKAm/7Pvszk6R9XCGArSHwOnMBA7FvnwdBuUl5yi39aj1o44vjrSwTo1MT+1Bu
         WSRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777593114; x=1778197914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BpU7aJAXyZDKrOT/BsTxtUzbjAh38uTL3HfdWXDy/eU=;
        b=CqSFCUZdk9omtQVbKBoOT2HudEPyTkg3FSNYpCLNmhNr04zzQ3mdJd5rYebPzBP6as
         ng9vpnaeX/qFbPaoaxLOTNlkr+NfjfpVl4hlFzHM8RAn7zq59yQ2aMZlhRuTKLf5kqvT
         kWuBAvC3R1LzPs5vm6Zf5Xu1IEocUORqu+WoexPeXJQ1knC0M2eCOkqqUZdFzr7Rp8ov
         cwT7eJoAo6HFTIo69ew4bIpDbE1hjLHLaLTgvKnW9FrF5+f7zu6xYLsSwa9zOW9ZPFxt
         Rs5U/Mm8NTh6UB9HoczgM99qFid63mMHWE9OJHMLOKnLfLmWR509TBJiovCtxeG/FfX7
         Wn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777593114; x=1778197914;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpU7aJAXyZDKrOT/BsTxtUzbjAh38uTL3HfdWXDy/eU=;
        b=sP3Q5dytUhlAHACyKBfmsCo164QkOjf7NbaaaWuqLu95hFw1XH1s2BPvxnKpjEqKwj
         JhZ61X/iJ2hElBfpL7V7pdlpwESNxP1ENWevEQ7Q+pQ5KWgKvsUN3q0qOKixMhg1ruNP
         wv3yWjd9TMuXXEUpipiVC1yNNu7CaDYJ9BCfZsulwNJJkI30phWvnZNMge+4YQDKpL5B
         r4rX7I47oqKZk8BWFJbScvuKjfgOB508UxQqQDkLIYb3iAp54lm3Iw9XhZ3Tdycxfd4d
         vNJnD/CBQFZpw11vb8XlgEA95GvAFfpQRmjBTOJR47ZdvWShnduxVJbDsCUq+0EDpuV8
         D2+w==
X-Forwarded-Encrypted: i=1; AFNElJ9BP9QZ9vJZaecIlMvc8n6sjjhyL+K3PePeKNHhMYrb7VPc9FRfPzFAViUkugHS7T6jXtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6YaGa399ebuAE3LrfQV/h6K5SFabGlfDPBnfPrc4sbdZfY+Uj
	c0geg4DAYTToJeGJdghmh4d1PfT02p/qolgs0KsNO5R8YV8w5arhO2ndbVOAiFRDti30+4zrLoe
	kmsYZypvmQNEt7lDYM3WN5cvgGWb8Ln06DxaP+79o
X-Gm-Gg: AeBDieu/58dG4iajzh0QUQvCqfRc35SMov87xN+C3XcTXS140Rg4nUvHtO8pRMq9QXl
	CdEIPgkKActP64xV1Ge8CfPhfYrOUseVMSLiQNsPOpz8NTpi0nkTTZkirNKFMUZORJAEZXTE6B6
	GFlfFf/QuIPXRDGvANYnPiqw3rDpdsddHJJeaX/4vSiOQqbFFhf7hKDpDkyinc+/uvVqUbtHzuv
	CWU8ycVq5pljY6w+bds8a4nmvLZx4DiU6boY4+ZUUrHmKHBrJeBDzwFoBSJ7rC3a+z84JX3P3Tl
	aAyZ2ABYlpaS6xkkK8tQIU545K2PFRD2BwlVJbKY9qfuXPkC6LOQ8rsCO5vmZn6xV1bJcUlZvHs
	AcHy2pUMJuQ4UZsk=
X-Received: by 2002:a05:6122:8b14:b0:56c:d66b:7516 with SMTP id
 71dfb90a1353d-574beb44409mr376458e0c.13.1777593113169; Thu, 30 Apr 2026
 16:51:53 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Apr 2026 16:51:52 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Apr 2026 16:51:52 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <x7n77snnvvukofo3slopl74c5tmlb2t2un5qy5fq6eb3d2xt7e@6a6tixg5mdfc>
References: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com> <x7n77snnvvukofo3slopl74c5tmlb2t2un5qy5fq6eb3d2xt7e@6a6tixg5mdfc>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Apr 2026 16:51:52 -0700
X-Gm-Features: AVHnY4KlBX901bcbV2QvS7GwShwnTIsgZQP6_kTRQYnSwTTeAKUt2VFX-7vfC-o
Message-ID: <CAEvNRgHRpvsEjtr1A_Qz3d4oMEaffTxESavrZ73Jtt6OobCwhA@mail.gmail.com>
Subject: Re: [PATCH RFC v5 00/53] guest_memfd: In-place conversion support
To: Michael Roth <michael.roth@amd.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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

Michael Roth <michael.roth@amd.com> writes:

>
> [...snip...]
>
> I made a super-long-winded reply to that thread, but to summarize:
>
> PRESERVE flag has different enumeration/behavior/enforcement for pre-launch
> vs. post-launch, and similar considerations might come into play for
> other flags, so to make it easier to enumerate what flags are available
> for pre-launch/post-launch, maybe we could have 2 capabilities instead
> of 1:
>
>   KVM_CAP_MEMORY_ATTRIBUTES2_PRE_LAUNCH_FLAGS
>   KVM_CAP_MEMORY_ATTRIBUTES2_FLAGS
>
> where SNP/TDX would only advertise PRESERVE for PRE_LAUNCH, and pKVM I
> guess would enumerate it for both (or maybe just POST_LAUNCH?)
>
> That lets us keep the flags definitions more straightforward but still
> allows userspace to easily enumerate what exactly should be available at
> pre vs. post launch time, and give us some flexibility to detail
> variations in behavior between the 2 phases without documenting
> edge-cases in terms of VM types.
>

Oops Michael I only read this after the meeting today.

Sean, today at guest_memfd biweekly we also discussed this topic. I
brought up this topic because IMO the interface is starting to get
a little awkward, I'm struggling to put the awkwardness into words.

Here are some awkward points:

For PRESERVE, even though it is defined (now) as that what the host
writes will be readable in the guest, it only works for both to-private
and to-shared conversions for KVM_X86_SW_PROTECTED_VMs and pKVM. That's
because guest_memfd doesn't actually invoke encryption during the
conversion. For TDX and SNP, the encryption can only be done before the
VM is finalized, through vendor-specific ioctls that go through
kvm_gmem_populate() to load memory into the guest.

For ZERO, it is defined in api.rst that ZERO is not supported for
to-private conversions, and the rationale there was that when ZEROing,
guest_memfd/KVM can zero, but it's really the contract between the guest
and the vendor trusted firmware whether the guest sees zeros later.

Another awkward point is that ZERO was meant to enable an optimization
for TDX since the firmware zeroes memory, but it actually only zeroes
memory when the page is unmapped from Secure EPTs. guest_memfd (for now)
doesn't track whether the page was unmapped from Secure EPTs as part of
the conversion, so guest_memfd can't assume it was mapped before the
conversion request. To uphold the ZERO contract with userspace,
guest_memfd applies zeroing for TDX anyway.

Summarizing from guest_memfd biweekly today:

David suggested enumerating the combinations, something like
`SHARED_ZERO` and friends (since to-private and ZERO is not supported)
and Michael then brought up the other axis of pre/post launch. IIRC
there might be another axis since pKVM would need to determine
dynamically if a to_shared conversion can be permitted for the range
being converted, based on whether the guest had requested a to_shared
conversion.

I think this might just result in too many flags, and could paint us
into a corner if more options get supported later.


I spent even more time thinking about this today. I get that we want a
consistent contract to userspace, can we scope the contract differently?

What if we scope as "what KVM guarantees the content will look like
after guest_memfd updates attributes"? This is a smaller contract, since
it doesn't promise anything about what the guest sees. Running this
through a few examples:

+ Pre-finalize, SNP, to-private, PRESERVE: guest_memfd guarantees that
  after setting memory attributes, the contents of the pages will not
  change. The contents are then ready for populate. What populate does
  to the memory is another contract between SNP and the guest that is
  out of scope of guest_memfd's contract.

+ Post-finalize, SNP, to-private, PRESERVE: guest_memfd guarantees that
  after setting memory attributes, the contents of the pages will not
  change. SNP's contract with the guest does not, though. After the page
  gets faulted in, the guest sees scrambled data. This may be a
  meaningless operation now, but it leaves the door open so perhaps we
  could have an SNP-specific ioctl in future where step 1 is to set
  memory attributes within guest_memfd to private and step 2 is to
  encrypt in place.

+ pKVM, to-private, PRESERVE: guest_memfd guarantees that after setting
  memory attributes, the contents of the pages don't change. Separately,
  pKVM doesn't do encryption, so the pKVM guest reads the same contents
  the host wrote. The distinction here from the current state is that
  guest_memfd didn't guarantee that the pKVM guest will see the same
  content the host wrote since that's a separate contract between the
  pKVM guest and pKVM.

+ Post-finalize, TDX, to-shared, ZERO: guest_memfd guarantees that
  contents of the pages will be zeroed in the process of updating
  guest_memfd attributes. Host userspace reads zeros after faulting it
  in, which is because guest_memfd did zero the pages after conversion
  to shared. A future optimization is possible, where guest_memfd only
  zeroes the pages that were unmapped from Secure EPTs, since (this
  version of) TDX zeros memory when unmapping from Secure EPTs.

+ Post-finalize, TDX, to-shared, PRESERVE: -EOPNOTSUPP. guest_memfd is
  unable to guarantee that the process of setting memory attributes will
  not change memory contents. The process of setting memory attributes
  requires unmapping from Secure EPTs, which will zero the memory. (In
  future, if we want to relax this, we could permit this if nothing in
  the requested range was mapped in Secure EPTs)

+ Post-finalize, SNP, to-shared, PRESERVE: guest_memfd guarantees that
  after setting memory attributes, the contents of the pages will not
  change. For SNP, unmapping doesn't change memory contents? The guest
  reads garbage, and that's a separate contract between SNP and the
  guest. In the guest_memfd contract, guest_memfd PRESERVEs the memory
  contents in the process of setting memory attributes, and can fulfil
  that.

+ Post-finalize, TDX, to-private, ZERO: guest_memfd zeroes the shared
  memory before updating the attributes to be private, because it
  promised to. If this memory gets faulted in to Secure EPTs, TDX
  firmware zeros it again, because that's TDX's contract with the
  guest. I can't see any benefit to userspace in using this combination,
  but the guest_memfd contract and implementation are simple.

TLDR:

+ PRESERVE == guarantee that the process of setting memory attributes
  doesn't change memory contents.
    + implementation == do nothing in most cases, except -EOPNOTSUPP for
      to-shared on TDX, since unmapping is a required part of setting
      memory attributes to private, and a TDX side effect of unmapping
      is zeroing memory,
+ ZERO == guarantee that the process of setting memory attributes zeroes
  memory contents.
    + implementation == memset(zero) in most cases. For TDX, a future
      optimization exists, where memset() can be skipped for pages that
      were mapped in Secure EPTs before conversion
+ UNSPECIFIED == no guarantees
    + implementation == guest_memfd does nothing explicitly about memory
      contents. The implementation is pretty much the same as PRESERVE
      except guest_memfd won't take into account vendor-specific side
      effects of the process of conversion. Except for the test vehicle
      KVM_X86_SW_PROTECTED_VMS, where memory is scrambled.

>>
>> [...snip...]
>>
>
> Looking at the example you have there:
>
>   + Note: These content modes apply to the entire requested range, not
>   + just the parts of the range that underwent conversion. For example, if
>   + this was the initial state:
>   +
>   +   * [0x0000, 0x1000): shared
>   +   * [0x1000, 0x2000): private
>   +   * [0x2000, 0x3000): shared
>   + and range [0x0000, 0x3000) was set to shared, the content mode would
>   + apply to all memory in [0x0000, 0x3000), not just the range that
>   + underwent conversion [0x1000, 0x2000).
>
> Userspace would be aware of whether the range contains pages that were
> already set to private, so if it really wants to set the just the
> [0x1000, 0x2000) range to shared with appropriate content mode, it is
> fully able to do so by just issuing the ioctl for that specific range.
> If it attempts to issue it for the entire range, it only seems like it
> would defy normal expectations and cause confusion to skip ranges, and
> I'm not sure it gains us anything useful in exchange for that potential
> confusion.
>

Great that we're aligned here :) No complaints from guest_memfd biweekly
today as well :)

>>
>> [...snip...]
>>
