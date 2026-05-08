Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A21381AF0
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778275301; cv=pass; b=pN3fT6WAPRzSPrTP7ibxhKlaRjCWPQ2XpY6dp7WXLVbDmm23YECBkdSlGQJw8inzQqOXnLuA81oOE2fMnTeIhIb0jTX26GMihZtHrQYHUnIKH0303jLtkb5JdIz7KoLNMxGyWU5rqw1T9YIEx3bWDRx+MKQX8QCb50KzF0hUgrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778275301; c=relaxed/simple;
	bh=DwVpQtg2nQbOTA132JfDdSVfFAB6KCJ3Mceieu5x3bI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2YluDpAIz3UapcVWrYMahsCcuLAAjjMfSMrEuu8yrLdEiS8eFfMu/7DEcekdMxVoNDfciUzSrJ1WY4ofc/DKYcWkvTsWyLy5qlSt1QV0rumAWCs9ErRFLJIXzvPZ+z7F+rXnSMHL0/OVz7zD5O3FEGHL1D/X1nmUELRSLMSIzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UBSIVYV+; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UBSIVYV+"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-628086439b6so1870295137.2
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 14:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778275299; cv=none;
        d=google.com; s=arc-20240605;
        b=c3AedL/boLH7XkKAEMaDiLzd/mYgHlq4nsfttPo0xWpAPtsXTo9csgvRDvx8tVHFs6
         0/bHOd0sbw5Gpt8iHj6iny/B/7frbl3nyrv7tKE6XmS16CWh8EyjLYi8JrnT0C7eM660
         VfHV0yNkUEb5DfqB1zmEbkU8KiZaNCINbf5nZ3i53se0NnboER7mJoey7/BFr8C4boEU
         3KCPa3PP5dUMDoK+lsaW0Heh37Ch1yfHDIwc2jciySR5pUPdDyZ4gt8X07fAn34D1LQA
         0lvP5X4l1CvhdxGnpQa6VgGIA9hHr7eHW6pgQxPPXvb66Manw2iZ1ThzY8epfvJioBsL
         LmkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=DwVpQtg2nQbOTA132JfDdSVfFAB6KCJ3Mceieu5x3bI=;
        fh=1CuTevNMlVA/KEx4V7Rt2iqacguqKSsoEdH5iLhf2bk=;
        b=CLadGOByFGUKFIHQCV9NRDmqGb82RHYXj2ztL5buYkq4R3YeRuO1sCbES81UyUzpD0
         S0tqKrEA7G4nvn+4eNjQ57DPuNWzy3muZyPg5usfXQoDcqsSKC+ITFeu7A6H7iTuex8K
         0L/IZ53nMASvT9NeI86VTjK7zZb0NXbahlS8g3s3VXlVFsLgnq0rHTT2ziyl/DYHDpPl
         CPqS5BuHB4ColIh4aZuwvS9gok98JGZlsEa+C8THMtidxEZoBgt6D6zMF/m0ERZYr1u6
         AH1aWPSIk/TWvr3j0rbf66SwvXu7K01gm/L7pHRwkVEjWuQfzAqcNaAetVUGuB2j5KsV
         7asg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778275299; x=1778880099; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DwVpQtg2nQbOTA132JfDdSVfFAB6KCJ3Mceieu5x3bI=;
        b=UBSIVYV+DWGpniUTgfToZNAWd5wYknlbdg+jHa8ib8fuBYefruu53HdoscKhtUpTfF
         +FIyWQKOigzjLNooN8kmf4/QhFvDUVDYc1DUcEwGtTp4qHY19snvIawBSOEjY9rjxDAW
         E3hergxglpxvyoFLcNuUevBTJBOMui9j01AzYJ291EqYmksQtJmn1/DabVkI+CKc0zCu
         Z4YpJuyo1aHi8DACkQxc9lzxhTI2w3n2lp2v8tpBUyXyKIdRR4r/MKldOCN8M50cUoMS
         4iWjyCjMuorgsaXskKpwTX/0DXt6udn4RiGrk6SX/h/fYRWj7lxKdYbiKdgQcX9bbXJT
         ZGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778275299; x=1778880099;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwVpQtg2nQbOTA132JfDdSVfFAB6KCJ3Mceieu5x3bI=;
        b=UxfDAv82kcGAatIN4JnuQdOzkP+U+Qsp6xmXSO6vWTA/0YuSusGt113Qn1QzQM2ivR
         lfDLQoiUJNIVEgWie3dpgwQjbByQeCCtRcUy/Q7UfDywCZC+whw3+1OO1r6nQiyl1nnF
         1mgDS1E3yuk+pagwZlilnT9TrIM3NdNPUbsQQ8vIuUOlSy9OB+WVaFXrnV/tPluoF6bq
         lSqZmPDJbZ+CZWfqcDcAp/WSrV4aOmE94QXNPg43cUChkXA2y5w57wdb/Z4OlXPsQpCM
         860MagGdl5vthZTywzNdQiL9pUDMH63pX0zH7apzfdBDI79vLhbjyl4UBjIxYwGn4Srp
         HNrg==
X-Forwarded-Encrypted: i=1; AFNElJ8YeKw4cjyXXGt/6AoANu0kUGZbHd3N7KomCkVOS+qFcfJmyA97Y5BxGu3x7tTLFEGnPmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR45tlfs131qKH/px7WgRrawF8fwQTSEnLONVIBbfsn5xKi3cx
	qdvvGHUx1lm5G45LDUr5owflZIwPYfZ8n090ze1v+dDDg6dE4S+zihQxxYf4gkTQA35BIoQfbsf
	55bW0p1w6N/Z9DbXw+TYLYwtuEJNa/pZxn27XyhpW
X-Gm-Gg: Acq92OEAeGZH7IoIlioF+D6gQHdp/qh2t902GVl2auqz7ZyX4veO+eN8aWAD6XAG1SY
	kU9c419kJe0BC+lUVAOXEHxn1CAKBrnKumM8GuS9xLc0R/AVyT/jvch9aFm48+6aMwKaLGFl7il
	fU+XEKwDAGzl6O3nlWF8BvH3H5OcaHvRnkLC9oPoF3vyTFHyYlbqe+8IgwE6sTzx18iVj34kGDY
	Zfen8KoC/mmKp65a/pUH53gnq/KMGf54CY58B4Ti36qbq2igJLkLMGax+7oYs8x0p4s7Pv9k8CT
	DtCxQ/I10mQaMOJisyXqnAus/fZReYfjk7onyX378ldmrQ45/LxmMQdC/jcOsMeEWpGOGJnbDak
	zKURKOBT6gM9HoY8=
X-Received: by 2002:a05:6102:2ac7:b0:631:8bae:f74d with SMTP id
 ada2fe7eead31-6318baf205amr901736137.28.1778275298534; Fri, 08 May 2026
 14:21:38 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 May 2026 14:21:37 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 May 2026 14:21:37 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <af4gJ6xZ3e7UXOuO@google.com>
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
 <20260326-gmem-inplace-conversion-v4-10-e202fe950ffd@google.com>
 <2r4mmfiuisw26qymahnbh2oxqkkrywqev477kc4rlkcyx7tels@c7ple7kdgpo3>
 <CAEvNRgFkusZeKxGctUpTTbYjdi7nZL1ZZar-gT7XRUOCZ2xtpw@mail.gmail.com>
 <eiiecl7jvywvqb4drq7cchmcabcrdka25wxr77uavxqineeedm@rfcnhdz6xoxf>
 <3blpenhpvysb2ig7efegedx4v3flppl5ftnz6vhpqlatfk3ycn@vmmhs7mvjieg>
 <CAEvNRgGbMhkX310CkFY_M5x-zod=BDTiuznrZ0XvFPUK7weL1A@mail.gmail.com>
 <foi2zvv5qrfdcspnx4fstrvzl74m6xp6zrsw5omlbprxh4jrhx@vxnwk7fr46gu> <af4gJ6xZ3e7UXOuO@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 8 May 2026 14:21:37 -0700
X-Gm-Features: AVHnY4KoLAXwUd272WSq8KkXYOzbLX3Fym78BjF7-ccyQZ1fkjgts947Mu_AiDo
Message-ID: <CAEvNRgGOCUL-MzBmXZNZHYEiFdVmeL_K0itPrSRex2f+FazGGQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 10/44] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
To: Sean Christopherson <seanjc@google.com>, Michael Roth <michael.roth@amd.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
>
> Summarizing this week's PUCK call[*]:
>
> Scrap PRESERVE and ZERO, and simply rely on vendor specific semantics.
>
>
> [...snip...]
>

Thanks for the summary! Please see v6 here:

https://lore.kernel.org/all/20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com/T/
