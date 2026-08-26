Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D3438A70C
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787767071; cv=none; b=eZgb8OXc+wc3Ot/wqegUQxFyuekgdkYjdK/cb7IPkFXA2QWV01GVy3Cae6ucoWddWuxJPfD10F9kT/F88xRCasLvD0vhYWgzggvbKWb84yxHPRaX0AK79GR7GZnnylnUET4mITzYkqquVS+PhR2CbplQ4FBmcl+JP+PEEAiVEBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787767071; c=relaxed/simple;
	bh=WP3lzz3sPwNr/uWnF1dnEtr6qfIaUelhmsrLvivFud4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crId5CZzSVlERjn7Ie0uT2Xe5MaRspkXEQCKXPuD45QH9/o7T/3EdHGuHSjOT3AQr/WbT5cBlIYkDPnTAQ0eMNIwTsbYJ7VH8LHKQY2xYQYEhfaJjsU0w69n7Z4zIP6kWgtIfisMpC8XC+sh4LhSTEnLYgzdk4ymJtAcv0i7tfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hquZmByv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hquZmByv"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d3b440b97aso10665ad.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787767053; x=1788371853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mOyt5LoY374Qkpz6cQhUC33i8CoGf2Yn2cDcltrm0Cc=;
        b=hquZmByvqvONjAlbXKuBbz8QPQjRA5q24l+0d+Wr/FDWY71EaBqGj8IlwKdWAZ/7rN
         qfhOOD0fECT1ixEw028sq04lhB5Z07hNlWPm6R3OajIctcl5IT/kz9pvApm4OixZ97oz
         VZxiM4k8JmKXtVKR8jk7Gp9I4YGU5A7Chzn6ygBLmMqOe6Oa3kypdshgeQT3A/tHJtny
         haMbvbBbdWrldqdotn11ykqbR6cZYMaVgFxEYpU5hbmi6FjSNGAfZNFD30VDJSmHUmlR
         W7RvcM+aVp9V7cuZCosewrtpuz1dmLCXobqo+V3HFTZhZC6AHrBOyzbhjJdfQJguASa7
         7CYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787767053; x=1788371853;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mOyt5LoY374Qkpz6cQhUC33i8CoGf2Yn2cDcltrm0Cc=;
        b=n0Y7G6H8cURFJb9hkQ//CTsB8cBlLSDpQKhfYUNAHmNTMl9I8gi40PvVafN18SCZ3x
         pxT5uhX/9SRzAabNutRq8f9S+5oFr6NcRJxEU6RzQZGL9B0xACaPatz1ut5PV4pbmRwm
         9qIj7hsvY6pucInnrjkkF3Lkf/fg0KL1FFoY5cDet4mp6BlqZBQdWoP5C4EK5EMsAFFI
         H+caGukeWPcZWzDfpbvMkLmjFbPhxhf+5pRvAQcLfDSrb6eQByoXxMt3oKXPmr0GLaBe
         6Awnr7JG+2x3o8qHfzdN1R34OsSG37ODkqCzLLdPQ7DRngDqeg6JB9C1Y9fBaNixyaDl
         7O6w==
X-Forwarded-Encrypted: i=1; AHgh+RpmwvvXVJhGUuRe3CdjdKuJdN218s+uy91BOWBTP+iktMwXqp9DFbNILEN+0Sx3BrdH8YM=@vger.kernel.org
X-Gm-Message-State: AFuF++mKX4MVAPyPLhc56it0purYPkhmGXhJ0UJuhwszljEjLBFmsWBA
	PTTqkvienf8I4wzQ+435Yn+1xMTjM/AjzgFfRobxdGa0RftU0aZleGNsV6HxaJuBsw==
X-Gm-Gg: AR+sD10zrguHfeuqIwFIuEtkMMZQQXWVOsyFOR3xdYuSU43kehnKJ4pxQvV+vHyGr7C
	qJqQVtzzFrqB6Pi5hUccG731URdGJZrgpdqIydSz7PIeZhC9t/OopOg2ml4KmrZRuRbKcjhFakg
	TLhEaFiMAt0ij5PEAadhETxr/ZMQJO8Y5KgayV7t+1UA/GOCI4i8pouKp1G4BDgxCVyYTdB+/T7
	9zidVKpwMW6d3wOzX4/aqWaeyxwPmBkh0N4kPs5CJhOFua8xpHYPOEYsiVFdVdVUJb5z2t29kpG
	zFokElH7xwg/pavw5HduIdeUUDZR8uDGmYOCRE/k9yA3grlabV7ZLFopXT6wvdJRPHJKRFrzvE5
	y4jdNIlL6FpEjqdAstbW3D3gttw6R+Dhou3YtPG2pDhI98ggTRcStl7rzNIbMaGkMb/EQciBxH3
	SVP3nekGNMD3Eq3XgzDMKplesnfB27YA/WSs2Py3y/QQw7LHSdf2bGxlyDZxLGITK5nElMQgy6A
	a6Yp244qDN4AZZgN9iqyg==
X-Received: by 2002:a17:902:d4c7:b0:2c9:b404:b55 with SMTP id d9443c01a7336-2d72a6912edmr556605ad.6.1787767052531;
        Wed, 26 Aug 2026 10:57:32 -0700 (PDT)
Received: from google.com (195.5.127.34.bc.googleusercontent.com. [34.127.5.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645d31e8csm9002581a91.9.2026.08.26.10.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 10:57:31 -0700 (PDT)
Date: Wed, 26 Aug 2026 17:57:28 +0000
From: Lisa Wang <wyihan@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
	Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
	Rik van Riel <riel@redhat.com>,
	Yu Zhang <yu.c.zhang@linux.intel.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>, rientjes@google.com,
	seanjc@google.com, ackerleytng@google.com, vannapurve@google.com,
	michael.roth@amd.com, jiaqiyan@google.com, tabba@google.com,
	dave.hansen@linux.intel.com,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH v5 5/5] mm: selftests: Add shmem into memory failure test
Message-ID: <ao8pCI3AaUssIO8S@google.com>
References: <20260823-memory-failure-mf-delayed-fix-v5-0-d97a5703e45a@google.com>
 <20260823-memory-failure-mf-delayed-fix-v5-5-d97a5703e45a@google.com>
 <8a99f753-0713-4194-8eb5-90da0724e647@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a99f753-0713-4194-8eb5-90da0724e647@kernel.org>

On Mon, Aug 24, 2026 at 03:00:47PM +0200, David Hildenbrand (Arm) wrote:
> > +++ b/tools/testing/selftests/mm/memory-failure.c
> > @@ -20,6 +20,10 @@
> >  
> >  #include "vm_util.h"
> >  
> > +#ifndef fallthrough
> > +# define fallthrough __attribute__((__fallthrough__))
> > +#endif
> 
> This doesn't belong into this test.
> 
> rseq/rseq.c selftest already uses it.
> 
> I think tools/testing/include/ already provides it.
> 
> Maybe
> 
> 	#include <linux/compiler.h>
> 
> does the trick?

Hi David,
Thank you for replying.
Would it be better to change it to /* FALLTHROUGH */
like the rest of the mm selftests?

If we prefer to include <linux/compiler.h>, we can
certainly do that, but we would also need to update
the Makefile and fix a redefinition in pkey-helpers.h.

--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -37,7 +37,7 @@ endif
 # LDLIBS.
 MAKEFLAGS += --no-builtin-rules

-CFLAGS = -Wall -O2 -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
+CFLAGS = -Wall -O2 -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES) -I$(top_srcdir)/tools/include
 CFLAGS += -Wunreachable-code
 LDLIBS = -lrt -lpthread -lm

--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -22,7 +22,7 @@
 typedef __u8   u8;
 typedef __u16  u16;
 typedef __u32  u32;
-typedef __u64  u64;
+// typedef __u64       u64;


Lisa
