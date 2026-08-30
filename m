Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1C04A32
	for <kvm@vger.kernel.org>; Sun, 30 Aug 2026 00:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788048353; cv=pass; b=MjFCey/lujVpm7ZXyIozHTQB1x4mK1OPYCpFnEAGyFzc/k7YxKAZhESi9jeDVrIgmxNPerwnyrmCsKpu/mgHHHU9y/tmPOaxcvCH4uS/tiUKwgWOo9UGTpeCYnixpLpEnf5d/ntfvoDTV9L1TAnGkUDxeIv4K4lFbH1BdAcygJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788048353; c=relaxed/simple;
	bh=OdTWre4/E0GzO36yssBeAmGKtS1r+8euXeCxROlaL4g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ci3EAw9sboHfotLqMJVA5O9lznMbuEj19cwIWJpE7k763ZwSSQUjEOhC+4NCW2G6Ji7d4L85Tk7rfEkpna4BlhSzohpF4K79GVtwb0d9YSmcm3e+j5LeP2IwC1IK7k9rCQlZSunaW2Q3BXr1qwjQiaczKqGeuZPuD1JjJdiarOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FntZFPkg; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FntZFPkg"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e57a753f9so230704085a.2
        for <kvm@vger.kernel.org>; Sat, 29 Aug 2026 17:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788048349; cv=none;
        d=google.com; s=arc-20260327;
        b=AUyiq3aEo9xeH388st5zX66js1m1IMFxBVPyFNNnXUBIhM1UkIyDklS7D1fioWzBnM
         ZXQ8pcIQG8O9BcaqK/v/I/0Xb9BK7xJinRImxQEuIbjiNwTMbsJ73zuHqj+wZvup7Z/G
         +cnUx6VibXfaIvcHS2X1W53CnOBJJzpSKbq5tmpMN1wQ0c1d+FCnWCUngc0Eve1iBWV9
         SKmDsBxTd0Ti/2wPINjwIiJ8DPyluWtggXMJYnJw6LqSP4MHHEbM8Yn4dtXqzS4c0bPi
         ayXGPHg2N+MYH2x69Px7hS2j4WjS4tPIgvck2vJSBtv+53mGy2VQ5V2SL3es+haTlRzl
         +6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=OVPtev+UPa7dvRpZFUPuPS+p0V4Z4HKOiUpL+88GmnU=;
        fh=9ffjhnWBg213hgDZKLYdpq2FiCPuhmMU6fSJo94qzNE=;
        b=F9RFgzwlG2BG8YXWDakjIALOYnsibQnX0SC5ALD9Dza03L6uwKiVju/XK22vOI1rYd
         qXFBCtqE1Lb6YxoadrD27F7viN/XNQW9dXIwgbWoNL13tdvWK+2pARq4EsIMBRgB+EO0
         gBNxPswLKiPq3hLmIwhqEftnMFsYMuwJnpZNywR2WxEWRYON9yzBkovaI6TvYSeBTqIY
         rt3cgRYyyLQ5ROx4jDMauoKNKAuS3c7AH4FOoeP0+MaeTM9JeVC5E3v/MJFF2/8fSU6+
         NB9yGWL76pWTMRLY4ukhG8I4bKyfj5Ze8HhazTj+fo6p/vKLLV6tLIHQ6vJpT3Fdyxff
         VUBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788048349; x=1788653149; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OVPtev+UPa7dvRpZFUPuPS+p0V4Z4HKOiUpL+88GmnU=;
        b=FntZFPkgEkRUwbbHbmEKsdoQVaEcHbWlapP9tERIlbZ2roeyhjIMPb9q6TBF+nxQ0t
         SqmTsOczcuYsdNz0X1uu3BgJwgw9eiSUIwjS4gD7ledhNglZMn6tg9ccqIp1gjLMMOfH
         jlRe6SaGmpIOLDE6TCzPrN8SCI6VopvIGb5Yr2RmSWvojdqUcH1KxTYe5OQ9yUePrwLI
         WaggqDDoxHnXSA+Y5/bEe8mjJqLAY2I7YnAgxlTEshX0ViVAZBFFD1eGFDb4NsfnItuI
         +MuWPKZnQ1a+ApuSYZDisRiu1wFqLFpEr6PQcNfL9PAZjgpR6bg7aTumg92KkeqjTKFj
         5vOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788048349; x=1788653149;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OVPtev+UPa7dvRpZFUPuPS+p0V4Z4HKOiUpL+88GmnU=;
        b=qC9Qy2RlkMfaeiF9oxRRknrmKJVskh4Igfry/4lYqbHFSsd/tvyH0fkLGaDUgjT6PR
         xqa6kbdOwmOcPMVR/2rPTBstw0cXFxDMzklnCSSrpv/Pb8pNnA0Z+UVZl/t4Mx6ECx4i
         oZHC6vVyI4hebjg2CFL79tyEZ+pd5VjAJv/33cZ8I4nF9HbYsyBrQiSGjYYtWHoeLCl1
         KVprEFvyOTFWV0oCq3amu6lKTeLruvTRqneUi0fmDJc+1LpeRoePJOFipGoNgHWNM2Mm
         wiWl9bd7xpeRnR6gQNO1ygFSy846fLFw7sfJ7RuGYUoE79RJPicbUj75XgGH9ANnzDvG
         Jdyg==
X-Forwarded-Encrypted: i=1; AHgh+RoTViaLyyU7sAEE9W5GC/00wcYFPeooc/DWRbt4jjBjPcnwYWToxxKlHzIS9q3ebea1AK8=@vger.kernel.org
X-Gm-Message-State: AFuF++mebBe7bk/SwFhwPBXhD9F//Ew+YzwaVzqm/JW0uzilUSOFHX7e
	zxHOh1/dQoxLj3u2L5aLciPLL3MIw9v1pwhsT3f1/Voi+s5CwoDIuOU05IDCuRcawa9KYgoWSi5
	goUjVjyydHf6HnbZvbLR9+wPm/KqripRzg2bUKc/m
X-Gm-Gg: AR+sD116Fhwyf3P9GeyNcjG9HaWuuTuitWKJyrDj85uDRM29QZaNxjy6EHTJepvPKMa
	DyfDNt0SP8ReoVtd99/sWjBjg3nKN3CqhsKUFFwArRw3/cG8V07abvPLfapF5bgh0cBH2cBIk2B
	cKv2Wx03PniEGk1CI0Lh43Qtz+hs3EzFEZ3WBjaRs9JcwAeJ31JZSLGAmeOYT/0h4WGxVWS7xg9
	hbaFXjnWAAMEbkRLaerN2UbLLVrB/v3CahYztnayOmNS1IyakqkTZsnPf2YdysA8swCcqImhW3r
	L3Inn10PXEy7YGG37v+JFCrS6l4nxxbDBGIxy9PLvMs2MJG+5dM5o2ZRTS4aIo4bCOLx0iTgMZR
	4e6r0muRfTQM//A==
X-Received: by 2002:a05:620a:2b8f:b0:930:f35d:41ba with SMTP id
 af79cd13be357-939139565fbmr2030756285a.36.1788048348431; Sat, 29 Aug 2026
 17:05:48 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 29 Aug 2026 17:05:47 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 29 Aug 2026 17:05:47 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CAEvNRgHAwAJee6_ra9-zioDh_BqHM9Lbu+TGXxWHbG7za=g5Aw@mail.gmail.com>
References: <20260823-memory-failure-mf-delayed-fix-v5-0-d97a5703e45a@google.com>
 <20260823-memory-failure-mf-delayed-fix-v5-5-d97a5703e45a@google.com>
 <8a99f753-0713-4194-8eb5-90da0724e647@kernel.org> <ao8pCI3AaUssIO8S@google.com>
 <CAEvNRgHAwAJee6_ra9-zioDh_BqHM9Lbu+TGXxWHbG7za=g5Aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 29 Aug 2026 17:05:47 -0700
X-Gm-Features: AcwNN1UOqbFFjDrkvuROHBeY-FoM3Gy-1FuQx69V_3hC_6MdAax2NDuhHQBC0j4
Message-ID: <CAEvNRgECQqS8xXu61btmESZj_eWWjuEt-Yq0vRFrxCObvfnJVQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] mm: selftests: Add shmem into memory failure test
To: Lisa Wang <wyihan@google.com>, "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, 
	Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Rik van Riel <riel@redhat.com>, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, rientjes@google.com, seanjc@google.com, 
	vannapurve@google.com, michael.roth@amd.com, jiaqiyan@google.com, 
	tabba@google.com, dave.hansen@linux.intel.com, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

> Lisa Wang <wyihan@google.com> writes:
>
>> On Mon, Aug 24, 2026 at 03:00:47PM +0200, David Hildenbrand (Arm) wrote:
>>> > +++ b/tools/testing/selftests/mm/memory-failure.c
>>> > @@ -20,6 +20,10 @@
>>> >
>>> >  #include "vm_util.h"
>>> >
>>> > +#ifndef fallthrough
>>> > +# define fallthrough __attribute__((__fallthrough__))
>>> > +#endif
>>>
>>> This doesn't belong into this test.
>>>
>>> rseq/rseq.c selftest already uses it.
>>>
>>> I think tools/testing/include/ already provides it.
>>>
>>> Maybe
>>>
>>> 	#include <linux/compiler.h>
>>>
>>> does the trick?
>>
>> Hi David,
>> Thank you for replying.
>> Would it be better to change it to /* FALLTHROUGH */
>> like the rest of the mm selftests?
>>
>> If we prefer to include <linux/compiler.h>, we can
>> certainly do that, but we would also need to update
>> the Makefile and fix a redefinition in pkey-helpers.h.
>>
>> --- a/tools/testing/selftests/mm/Makefile
>> +++ b/tools/testing/selftests/mm/Makefile
>> @@ -37,7 +37,7 @@ endif
>>  # LDLIBS.
>>  MAKEFLAGS += --no-builtin-rules
>>
>> -CFLAGS = -Wall -O2 -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
>> +CFLAGS = -Wall -O2 -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES) -I$(top_srcdir)/tools/include
>>  CFLAGS += -Wunreachable-code
>>  LDLIBS = -lrt -lpthread -lm
>>
>> --- a/tools/testing/selftests/mm/pkey-helpers.h
>> +++ b/tools/testing/selftests/mm/pkey-helpers.h
>> @@ -22,7 +22,7 @@
>>  typedef __u8   u8;
>>  typedef __u16  u16;
>>  typedef __u32  u32;
>> -typedef __u64  u64;
>> +// typedef __u64       u64;
>
> Removing this u64 typedef seems to be unrelated, the layers of includes
> probably has some weirdness that needs to be ironed out.
>
> If the weirdness is not too complex to iron out to be in time for 7.4, I
> think we can iron that out, if not perhaps using /* FALLTHROUGH */ is
> fine, to be aligned with the other mm selftests.
>

Lisa did some more investigation, and we discussed too. Here's my
understanding:

TOOLS_INCLUDES in the Makefile points to tools/include/uapi, which provides
underscored types like __u64 to avoid polluting userspace symbol names. That
makes sense since tools/include/uapi is generally copied from usr/include/
that is generated at build time, and usr/include/ is used by userspace
programs in general.

selftests are a special case of userspace programs, and since we want selftests
to look similar to the kernel, we want to use u64 instead of __u64. While
the kernel uses include/linux/types.h, the tools subsystem provides its own
userspace compatibility header at tools/include/linux/types.h defining u64.

Hence:

1. tools/include/uapi/linux/types.h provides __u64.
2. tools/include/linux/types.h provides u64.

Adding -I$(top_srcdir)/tools/include switches from 1 to 2, causing
definition conflicts in the mm selftests and more warnings.


Since adding the tools/include path to use
tools/include/linux/compiler.h breaks existing definitions, my vote is
to use the comment-style fallthrough like the other mm selftests and
clean up in a separate patch series.

>>
>>
>> Lisa
