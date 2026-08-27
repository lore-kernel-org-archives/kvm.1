Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0791225B082
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787789475; cv=pass; b=h7UTyxfmfwknuDqJg69dJKMFR1wGaLUl8YJ24NrIS9yUHPUMeNF/24YbsFj/xkyYLmLDDAlAzzw8VNtxHRYM0R9ErRN7TpXdzrQUqZvN31yA0L7y9YkOeZP8YbwVtkTi3pDIPd9YAlihpEQmnl5/m1Rdmx+bS5K5OP5/lM/JJKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787789475; c=relaxed/simple;
	bh=q9fPaqLMvwojY1sDSJE1KOtBByV27/rWMVd0RMgF7LA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUc+HVcq84WHVH33wa/1wmAskcFGCN1i/DcTnFprRpouankAtkJJYCdtVvcAyr3PajlN07sg34HgeNHwaHoywiD2mRVSKhRrDHeNh2iq0kNnjWEzE6Wii0f8HqcMbAXxq6T3r7JaTWbtdgDz8MA1kBTJKZ9BgSCSMhL+JTNm03U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DDHytNYH; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DDHytNYH"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-90ccbca8bdeso8406686d6.2
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 17:11:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787789473; cv=none;
        d=google.com; s=arc-20260327;
        b=Q1RtGDXVkgnYY2x8kM4MqPUSNsWP48lainDVUaXLucU2b88PAEUkbj2lzeHg3/aFxF
         je0xcPaPLmwl/MzlfQYI8ju3551KEUA9mJoY3fNEQvCcC2d7qjivPhvMTar/gpLuS20Z
         mN+vgZ3pdMinRkmd4+vbj9SU7lja6YQxPt81lcv9pap1CQekYU/bC12GQNcvSSkSvufv
         rNyPRGpnsIvXCCRg8BNn5xSFTHuzXWxSH3AEM7qGHD0njnIPLzj0BTP5PXxr+Ouw/S7f
         qPrulJ6YMjKj+GGup2UlJbTRtGI239GevltNyX8ITPo86EwU2Sfc210mDSgIXKy/ViXj
         pqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=AnLRTMnfrf4Gj+REZ5Itvxt0IiZsf+yGH35mZtX0wjs=;
        fh=wz2agcRS4m5Xq/aBLicoTg9PeM9OP5G4btxkpBraMX0=;
        b=MOm2qtfCtLpH5HyYk3udUJKyF3wDaRlD3AAhOheQh9U6q4DFFdVNC+nSrZtLdu15jM
         BqAqnZxfVfxikncIWnT4tds6WbRVK1OBLCOxVGx6kzFPJXwgHoRYqPS4HN9E3T6DkGIa
         3P6ZSnzh5Ea/n4HjL+fTwPxram6j+fSX3R+wDxHX+htC6QtI4H7yv18oz+5s0nA5BQaN
         5xuETQyH4hxLPrMJjwj+Fq905rx0fiJcCNIhZKFI/98eUpz/pROvQdFafMkRdYhxJxuf
         gnb+5rXvFeu07cTf05ElxC0Gf4frRmCiukoS+HJ76IQ9SBsiEXjehOn9ZuFvrebM++q+
         Nr2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787789473; x=1788394273; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AnLRTMnfrf4Gj+REZ5Itvxt0IiZsf+yGH35mZtX0wjs=;
        b=DDHytNYHmL8ZZFfUZQMn9dv9i2pHGtixDiXKH9NcxPc4aJG167NL84W4W1eFrg82s6
         K6FGfBmIu0OB/N4HK5JAFeA1UGR0z5TlKmc3aM+GLZARcczL7zef3x1NOk3gnKVBbErt
         xi4wq6VzqorqIOe3iRB2OmS6mFTNQfV99usutBR7zO4DRLOWqjr7mfDN5C7fBQb5JJdH
         p2T/sZgpckboyIVBPJAuAoTIcUqpQdX0fSP1tMUoo2TLb4tdTLhQG1ds/xrwWWn36i8l
         cCnl653nK2rd+DQLX4EaUe9yQIPUT0c7flfn4QVBnz+eNFPfHNpbIF014eIJsP8Ak4Tx
         3CoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787789473; x=1788394273;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AnLRTMnfrf4Gj+REZ5Itvxt0IiZsf+yGH35mZtX0wjs=;
        b=goYW6IgLFO5V/cetNM2Qj1Ke0rWzmosGkCBmuUI2STpIqlRUiaFczEXx4jBnAK767E
         5pvskqIwDPPqjPqYd8lBkiVKHX0eBru9n6o1eQyWiVNakrlHdfgzz7BxuMV+VdQaDIbY
         rnpsRGpnirorfg9xMoV5tTEwT9Jd7NTZgV1e49Hiqr3vi1CRGgzBHDDG8twJ3zgmBMOy
         ieGB5iZF6HB1E8hd+ilrjbAow1UrrICzlhRpABRel1MlBOn0+7S+Qwrf4MGWOPtB2GvP
         hIZRUxcHVGdxHRl9EZNNqRI2jOmfNgTYZymOyxuh7Z27iIiuW6KFx5BEci1FTfperkbe
         S5Jg==
X-Forwarded-Encrypted: i=1; AHgh+Rr4oPErX3QjS6NFKjVlX1Wn7KzM5zwrW/UM5LyhilqwoYKveLd2ZnsDqoQjWBZF6JFz2q4=@vger.kernel.org
X-Gm-Message-State: AFuF++lSk+UAl08O0beXbNs2asb9RDqDVFeRDIhN+3FtT8Vz4JYt66BU
	5PJUBZ79MZH/5kDoEuZmoiq4Y9nas+rldM49t89auy8Y3M7gsba4NK468fVMf77L1egCWGueCEY
	Dn7EQ/d2+1XFR5E4oXNsFj8jwPT9DMwIaKdMeK1g2
X-Gm-Gg: AR+sD12cHLXejpIv9l7DICP4HNg/9o2rvNcD1hQmWRFL7q8tDR9Axb7O3xKPBrFrCbS
	NtOl38swNdUUJluQbt+pQ7sUG9CtN1/MvBWxJZt2YJYplnLjrfuuYNj5aSb2BQ6h+YLa5vhVtcU
	Vw6vbIHq9gFcP7bJD/JM3u4u2r/nQX7tCQNOCSWO1MDSg/vt/ddJawyEXG6K7mmqUZ6KJIyXT6w
	gtdW7aaVGyb8z2sKCE2vEs2ZYQGRZXbIWUYdelJaEBWdps38spJRNF6QkPl77gUgE8CL6kujpmx
	AMczMIJjwj0TD2eoxXbu89BVDqTyMcCsz6nb1NioFDb34lb3+EnEaIOnCx1woB0KNouAs+HKsDX
	AEC8=
X-Received: by 2002:a05:6214:4602:b0:908:98fa:f374 with SMTP id
 6a1803df08f44-90cc7858733mr168107566d6.6.1787789472172; Wed, 26 Aug 2026
 17:11:12 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 17:11:11 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 17:11:11 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ao8pCI3AaUssIO8S@google.com>
References: <20260823-memory-failure-mf-delayed-fix-v5-0-d97a5703e45a@google.com>
 <20260823-memory-failure-mf-delayed-fix-v5-5-d97a5703e45a@google.com>
 <8a99f753-0713-4194-8eb5-90da0724e647@kernel.org> <ao8pCI3AaUssIO8S@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Aug 2026 17:11:11 -0700
X-Gm-Features: AcwNN1XfQOKyfEIZtdcwN4-zBTAXGB_PV6TdJFFinygb6qNke6evcDePz3wbfQE
Message-ID: <CAEvNRgHAwAJee6_ra9-zioDh_BqHM9Lbu+TGXxWHbG7za=g5Aw@mail.gmail.com>
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

Lisa Wang <wyihan@google.com> writes:

> On Mon, Aug 24, 2026 at 03:00:47PM +0200, David Hildenbrand (Arm) wrote:
>> > +++ b/tools/testing/selftests/mm/memory-failure.c
>> > @@ -20,6 +20,10 @@
>> >
>> >  #include "vm_util.h"
>> >
>> > +#ifndef fallthrough
>> > +# define fallthrough __attribute__((__fallthrough__))
>> > +#endif
>>
>> This doesn't belong into this test.
>>
>> rseq/rseq.c selftest already uses it.
>>
>> I think tools/testing/include/ already provides it.
>>
>> Maybe
>>
>> 	#include <linux/compiler.h>
>>
>> does the trick?
>
> Hi David,
> Thank you for replying.
> Would it be better to change it to /* FALLTHROUGH */
> like the rest of the mm selftests?
>
> If we prefer to include <linux/compiler.h>, we can
> certainly do that, but we would also need to update
> the Makefile and fix a redefinition in pkey-helpers.h.
>
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -37,7 +37,7 @@ endif
>  # LDLIBS.
>  MAKEFLAGS += --no-builtin-rules
>
> -CFLAGS = -Wall -O2 -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
> +CFLAGS = -Wall -O2 -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES) -I$(top_srcdir)/tools/include
>  CFLAGS += -Wunreachable-code
>  LDLIBS = -lrt -lpthread -lm
>
> --- a/tools/testing/selftests/mm/pkey-helpers.h
> +++ b/tools/testing/selftests/mm/pkey-helpers.h
> @@ -22,7 +22,7 @@
>  typedef __u8   u8;
>  typedef __u16  u16;
>  typedef __u32  u32;
> -typedef __u64  u64;
> +// typedef __u64       u64;

Removing this u64 typedef seems to be unrelated, the layers of includes
probably has some weirdness that needs to be ironed out.

If the weirdness is not too complex to iron out to be in time for 7.4, I
think we can iron that out, if not perhaps using /* FALLTHROUGH */ is
fine, to be aligned with the other mm selftests.

>
>
> Lisa
