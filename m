Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28C32F8E94
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782411634; cv=pass; b=BfyiFqZo+rw45ImzVjfCHfTzAMI8KDvS/k1OPKdpieZKSKn1SBrA2LPjzyDqyFZ+INKZbEt4ZaugkNAuU4w6u8tvCD6tfEoIoSI+0ZBAeE5VsUwA2rv9PxcJdSF5CD7+qcAHg+EFM83RxFT7cKFiDfVaBWbo2XCSDcJorbOCSNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782411634; c=relaxed/simple;
	bh=9k891PwJI4EFFALDu5zQboFYTAkeFrF++j9GP6B0KQ8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFzZDhlVKqVRqzbrnlvd3znGLC6Gv1w4WiSE0NyqPURRjL9E4HPq/gTpNXm0T4/qzgrsKEL1wWUdy8mOKbacSJpbouvYD/OcYzPfoJeHiKlMQH7vHC0ynOBjsZDtuepc1oI+jkvwXsj8EPBpzC7PTeq42n0CWXbpyAhFGAhmA8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e8oFt3LG; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e8oFt3LG"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-139d5c9a495so437857c88.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 11:20:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782411632; cv=none;
        d=google.com; s=arc-20260327;
        b=K9QFXRSZjYZR8hyibuOTbTpxGTjGe44b3joa9NriwoJ1I2Yr1A6mMl/wztJH+G8WH+
         FpXTWdzzcB8cGoardzjR3TUAorTrdoDNDVMDKQlqc8TyGBqy/Inkis222I3sYMJDf80t
         z/HjbKZDQHngx9jb+eEH/qHLIM8b5k2Is4xvOjoOOvtk/nqn8wq5MIlatkk3f5r08p4J
         Z0L2lH1ZthUST4ohZHmHpeoy4Kz9QhWgiithA22f02JwRNFpZoElQ7SoC8vcWu9lPK8l
         jqiLxLkeglmLvAyec5wiRNLsuluMCQpn85AMTIn85XMMSZnqQO0vHZKcYXsAaU2AZFHx
         80qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Zxjcsz/dsIe56trrVdkQTSG2simPYkWb/FM1GFAid2k=;
        fh=JPQRYB4y6UJYjGKFHXpYSt9mkFbPtuhfjiaqeO0jqoU=;
        b=LJyKCyHIhadtiG/X2y2ynb55MNm5TCe0pcdEc5mogdHff1nMesqMFFGPMVmCvhiVWe
         AuxQD3nPUobuS9F2cTXFSlS+oxHVC2UGkv/WlbvWJm49x3/XV4fxGExxHVyGJgTbwgzL
         wUY2HsdD6dzGV6bU11v79pdtuNRubWmXFAxOjiQBTCsA0cZiFskdT9oUlqKwq7gA8+g4
         O989eRfVfwQ3kIe9ciKrhNoJd6TYnMhRvuI5ERGmhnc5raht2pbJXPsg9Ul2sle4sDAT
         iOdB1xEIB9FKhXBW6Vwywfuocy7ACkDhyjYgi2jGCjOXjn7fJblhau4fqb6leAR7582T
         q3IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782411632; x=1783016432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zxjcsz/dsIe56trrVdkQTSG2simPYkWb/FM1GFAid2k=;
        b=e8oFt3LGsTo/VMCqFJZ012aCacvbQuFijkW3qnBD91v2JztKaQrzvk+Tw2sKJ4HNSd
         QH1bLDTTm0YEn9XreMNsjVFSzRe3IdWNeClgnwYIQOBUlrJPlb87KSGdiBEa2t7eYXAS
         CO4A9qdDjOrBDVdP04aD2QHnyIz5Q/LKXPrypJc/taOWvtYgzDw5yc1M5l6McpConPA+
         jSXKgCpCQJ/gD80g1/5E3nBcJ4atgOUWvE7aLsBumFESldYxrET9v6wHuaFYqE37XhJS
         URdCvXzUEKczc9FuzEHqAcwiqGgcR5HkBuyo67a5n6Rr16rqJj430QjR+fxFxbmGJhem
         SkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782411632; x=1783016432;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zxjcsz/dsIe56trrVdkQTSG2simPYkWb/FM1GFAid2k=;
        b=nNzRN++ZpkA16VymavQz804KGycH7rTAkSxem2eB0otIupCFMQbiOmvjs1pwEHvCY9
         vPCCOAWzjDnG1i08SV2vaFobFJqN63/wVTUlWSHfLnzmfgw8S1FCXFVpdYT3AtecrPBq
         XPXo9rt95kk56jwDccwxuUJh4hPSDz9S+nqh/2/ajb6MQrt+8av6nC69CvDCu7l+1OBl
         joZEPQ6sqeNqCsMjrBt7AjRisS0E1OsAxJOjHWWShkWjMag185x/0oTROcbtpzuwCmGO
         TBw/xVZ/sFw9rBmJELCKhta1/ycUA0yFnLTLCfkGtT/X/+fRtWbnSWzVwGp2hT64jAO4
         izow==
X-Forwarded-Encrypted: i=1; AFNElJ+/qMOkdwo5veDbDU9839fcodzdszK4sQS5Z4UP+Dm4Tu/NtyRAtUwBfiBehm/vSjoUqQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtJlEtwfOdrTroBK04ZsSknPR6ACkScZQMx1oZPmIev9L4hofg
	S0tSX4R6hhgol09w3sJ4xJJyBvTiFVSZdXReDHldK2/5/uUAU4tHAbhwU51EwzgqAvonBFQ/371
	5zVKpGPhlfLGXRPgEsG+9JvufLvw+2supJ3qk2Ipl
X-Gm-Gg: AfdE7ckeSb9BgDnAk/qR74Q9g77sZcIiKRSfHCEEsqHmB5NWp1e71JizbRSzgHJxnr+
	wTg+dZypaOB8y2Ox3Q5cGY/jtZ2wOc2nWpKOVKdRsG0c/z2fZx0AY+JeK77P/yQVzyIGk2zzyAR
	e+TLUVRknT4xhENIO8AK1IdA2CZWaBeT39qmK0CFLeiVCVyYy11sRIvkX/vrCWqzwVr8eSpGEVE
	K91qot2WusWJNErRIGsPHb+V7hzEkhlF0BOYEiOr7FehYnCxWNXSGMW0g0/7L65PF6n9VyW3z+6
	baauzLdWO8JC2WAMSzol3Nz2GuESeYQzBw4s+KRkQ1KaSgKWo4lqhaxc3Tk=
X-Received: by 2002:a05:7022:ebc4:b0:139:7bac:db41 with SMTP id
 a92af1059eb24-139dbb49566mr3555362c88.28.1782411631187; Thu, 25 Jun 2026
 11:20:31 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 25 Jun 2026 11:20:30 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 25 Jun 2026 11:20:30 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ajyCn0PnFtQK+Nka@yzhao56-desk.sh.intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-24-9d2959357853@google.com>
 <aji/2svhcc84rn5w@yzhao56-desk.sh.intel.com> <CAEvNRgHYTFnHbsLLgMTCSitmnp1_j9Pomikm9qmpGTh1w8YE5Q@mail.gmail.com>
 <ajyCn0PnFtQK+Nka@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 25 Jun 2026 11:20:30 -0700
X-Gm-Features: AVVi8Cc3nGhX7fIjy0JPI276GPFCp7STu7qOIMKXGadYwwvPojaXnYff9SHGUmw
Message-ID: <CAEvNRgFfgV0FbQLzP8hhNH5hMGaQao6OFQin4cb3TAmC7SVhfA@mail.gmail.com>
Subject: Re: [PATCH v8 24/46] KVM: guest_memfd: Make in-place conversion the default
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

> On Wed, Jun 24, 2026 at 05:05:44PM -0700, Ackerley Tng wrote:
>> Yan Zhao <yan.y.zhao@intel.com> writes:
>>
>> >
>> > [...snip...]
>> >
>> >>
>> >>  #ifdef kvm_arch_has_private_mem
>> >> -bool __ro_after_init gmem_in_place_conversion = false;
>> >> +bool __ro_after_init gmem_in_place_conversion = !IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES);
>> >> +module_param(gmem_in_place_conversion, bool, 0444);
>> >
>> > With gmem_in_place_conversion=true, userspace can create guest_memfd without the
>> > MMAP flag. In such cases, shared memory is allocated from different backends.
>> > This means this module parameter only enables per-gmem memory attribute and does
>> > not guarantee that gmem in-place conversion will actually occur.
>> >
>> > To avoid confusion, could we rename this module parameter to something more
>> > accurate, such as gmem_memory_attribute?
>> >
>>
>> I asked Sean about this after getting some fixes off list. Sean said
>> gmem_in_place_conversion is named for a host admin to use, and something
>> like gmem_memory_attributes is too much implementation details for the
>> admin.
> Thanks for this background.
>
> Some more context on why I'm asking:
>
> Currently, I'm testing TDX huge pages with the following two gmem components:
> 1. The gmem memory attribute in this gmem in-place conversion v8.
> 2. The gmem 2MB from buddy allocator. (for development/testing only).
>
> The gmem 2MB from buddy allocator allocates 2MB folios from buddy for private
> memory, while shared memory is allocated from a different backend.
> (To avoid fragmentation, only private mappings are split during private-to-shared
> conversions. In this approach, the 2MB folios are always retained in the gmem
> inode filemap cache without splitting.)
>
> Since shared memory is not allocated from gmem, there're no in-place conversions.
> The reason I'm using "gmem memory attribute" is that the per-VM attribute is
> being deprecated, as suggested by Sean [1].
>

v8 of conversions series changed that slightly, per-VM attributes is
going to stay around (because of work on RWX attributes, coming up) and
RWX will stay tracked at the VM level.

For v8 and beyond, only tracking of private/shared in per-VM attributes
is being deprecated.

By extension the entire thing about using guest_memfd for private memory
and a different backing memory for shared memory is being deprecated.

> Besides my current usage,

I think you can set up guest_memfd+2M for private memory and shared
memory from some other source, and that's the deprecated usage pattern.

> there may be other scenarios where gmem memory
> attributes is preferred without allocating shared memory from gmem.
> (e.g., PAGE.ADD from a temp extra shared source memory).
>

Is this TDH.MEM.PAGE.ADD, used indirectly from
tdx_gmem_post_populate()? This use case isn't blocked. Even if
gmem_in_place_conversion=true, you can still set src_address to
non-guest_memfd memory and load from anywhere you like.

Please let me know if that is broken! I think I accidentally used that
setup in selftests and it worked. The selftests are now defaulting to
in-place conversion.

> For such use cases, I'm concerns that the admins may find it confusing if they
> enable gmem_in_place_conversion but still observe extra memory consumptions for
> shared memory.
>

Hmm but I guess if someone enables gmem_in_place_conversion but still
allocates from elsewhere, they'd have to figure it out?

> [1] https://lore.kernel.org/kvm/aWmEegVP_A613WIr@google.com/
>
>> Sean, would you reconsider since Yan also asked? If the admin compiled
>> the kernel knowing what CONFIG_KVM_VM_MEMORY_ATTRIBUTES means, then the
>> admin would also be able to use a param like gmem_memory_attributes?
>>
>> There's the additional benefit that the similar naming aids in
>> understanding for both the admin and software engineers.
>>
>> Either way, in the next revision, I'll also add this documentation for
>> this module_param:
>>
>>   Setting the module parameter gmem_in_place_conversion to true will
>>   enable the KVM_SET_MEMORY_ATTRIBUTES2 guest_memfd ioctl and disables
>>   the KVM_SET_MEMORY_ATTRIBUTES VM ioctl. If gmem_in_place_conversion is
>>   true, the private/shared attribute will be tracked per-guest_memfd
>>   instead of per-VM.
>>
>> Let me know what y'all think of the wording!
>>
>> >>
>> >> [...snip...]
>> >>
