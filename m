Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C2248C3FA
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647100; cv=pass; b=F+F7tV9mzX/PR3fU112eJUWFMsihe/8g8HUxN18SabJg9cpKg9qFo0UwGa0hIMCZRiPW3dglDqj/LhwQFENsgIloW/Z1QnI/wWFHAe/nG0o0Xh6iSObadec3jN7iv7SPigLZQFoxSfxqMUMm6jkTPaPqF5fbzm3FCrrH+3UVF0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647100; c=relaxed/simple;
	bh=EePxyuxj/ORuNvnRcTqvK7WSqyTYRaPWHyS7fmka0Cc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMuARYE7s/caR9dXTLfCTrnSuxj1p/TUxLNsEjbl2DKm4dFYW79FOOIvpGRIEUwLkqt8xgiX7amfiJ66/Ui2ggCo+/NZob9t7XpudH9GhRCpbgeBY1sZb9OEThlNHJ2/h28nsIqMaD8pkqtEilDeaFJQ70lJa9O6644nXfbwl08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=llOgoqHZ; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="llOgoqHZ"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so1226077a91.0
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 11:51:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786647098; cv=none;
        d=google.com; s=arc-20260327;
        b=K2x/AsR0/Av5KfZv/n9JEFDOwiZuo5ROi4DJEWt4sdA8ZsTIizBdZhzdv8ikHi37dZ
         0mVzh+0E0nzRhjnATrJIIFqUgC0sROyi6K+ULdGE65/NV1v/HB2C0qh48uECfGzHIvfH
         RF3oRXH5fTT6AYTQJKod4L/kKPK5jO3J5RwNQjAHb9X+QV11olPG0IaFRJOtqHKg9vvL
         kLdC7f+/uV4C7ZUwPojL1IuViNQUXnvlDkqtJCUFzzpi42DGzmhKRmVzxbz71slJyPw9
         1nLL4WCpiefBoRROFfJ9U2OUiqkiT7xfELmm9VHzoDeKOhVtwO+I0XHnTypRQiY42aDi
         a5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=EePxyuxj/ORuNvnRcTqvK7WSqyTYRaPWHyS7fmka0Cc=;
        fh=C6sGsd7wBoTcrFC17Qi4QsDN3dEcexvOcZw5/nmWxBU=;
        b=BsaFwxY7DTSiInVd6O0aT6DjiHsxk+J2dSbVu6Y8oyluzM5I0aMDXXIgFceJwSbqZL
         D+wjeop585jXb/La6ParLBdz4OepI7dto9ZncqQlB7+ClPPJ6U7xDhKvX6fOSPGegUIW
         MN0EY7ow+J0v0wf+eIrVfKSJGSVNF6mcyRA5uZ0GkYcfRn1Bf6M2WBbi+9JvRVx5fKmN
         g6YYd2sb8iuJbWvV+QTPKwotj8wpcUlgDAoQwQ+w5/GfWfn98bblGCW/1JLlyqsyVfyd
         QIetnJ3okpjkjjSJuAmuMNeknSj5HZaUUBFRHH/o+g6bEc9KjAXn4DLeR3qIRTUowdzq
         6URg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786647098; x=1787251898; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EePxyuxj/ORuNvnRcTqvK7WSqyTYRaPWHyS7fmka0Cc=;
        b=llOgoqHZi6OxkI43AjwUwrPF5WbjEcaVshHgvpJ8EhGpy1qFS4z9v2QCzL+EUQXNJp
         lYMDECsMWialckL3BnDh0whRpYd74jDrai4iWSuq9KAmBUeo8Qwqp0OgmAg8WhWVFpGs
         0MK6yBdX19rXZZxs/AYmnRAXX5lgrFrLq/ZoCNUWM1x5Halpp9uLSfLD4VWXEy3PhnT6
         sGM9g3x/lAxHjLwHoqbXJc/Y/8XE2Nazpkw+8XTd9yXnZyAx+Kkwqe7i2bq1Wq+uwyqD
         BZvXJAMPa/MniY13cQfBslO8rWQKTJ1CfxSKijhum6aempPR7E+D47zYEMqI5Zydf9ur
         on4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786647098; x=1787251898;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EePxyuxj/ORuNvnRcTqvK7WSqyTYRaPWHyS7fmka0Cc=;
        b=anh0IdjTp0hssl2TdYnxjswe7wTPN+JhZKeZkNymezcWSZDdITOSoQFtF8DdJpkAPs
         nH5BcrWQaAzFKsVZlJtXa6QZbwEwirCRAsuJ6KovqlvNiLXDg8c3d4B9pIXkXTOGflK6
         xkwKQoiAQOi9sZOqSIch2JR5b9ETm/zYokApFYImwRb+hKPU6dE8JNgxMajoBcVkgVz0
         UyKUButVyZ5tZIFmCtlXGdNZMNVWeEXRYKpKUA627XV5/v2pVHeMxdFXNM+K2dldxqPN
         IUOEHWHW19l9I+gD/VWcvlT8M/nSVFlEYu/UIzBBrQBBdClLzkI8LvC1KHWn6yOFTGWD
         Yy3A==
X-Forwarded-Encrypted: i=1; AHgh+Rr23BWFO6a4JdS6ioDkp68CpQBd0BiaQjMO/oa0n9RyTus+fAWNA5mI3KGaRx1kiruDg+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP3CRi4sRchjblkHEi13k0TTxc1VXGRFptteeohF9YyWYMgSNN
	L8dysImRGneb7EJp1+VDiYS6j+H39m9Ex796Uc+q+VdkYUydzAgvleUlNM/0XusYRMjQzLLk5mH
	lFfSuzaWrphNsPV+NkPZYGbthaH8nR0CjqXCNESlV
X-Gm-Gg: AR+sD11HYP8hNj44yw3JunKL+r/XRJ6n+q6hyG3lDUmDRBJZ47Ics0e+SO3MIWiYZPJ
	XqZrIWgLG+9Z9dxi5417l0IG/9qjbxls21vH0s2NMbfTF+DtBV2h0C1SXk8BNXuLkn7O9122fVc
	jG4bWX8AsWLJ17mJgSO+S8UVTRFx4GzJg3QtQGsrzjx51heyIjZ/XVqitwPs+4eHEMiTNGVHXQe
	X/09/WVBS5YBwZAuUctFI8c18A+fOdy4jPUBh7szJjZC3cGlIkW9IW2nzuEAdgHchmxMaXI54Cd
	5yuc1rsmG9gl6QihTzX6wt9kDigcRbD9NUlYgtWR3jbz4dRI5jipanp+LUOTlOiGl1HGjuwYcAX
	KtpW8JX2XCXtF5UYx2EcR8VzeFI9b/80=
X-Received: by 2002:a17:90b:288f:b0:380:86d8:8162 with SMTP id
 98e67ed59e1d1-3931f5f5fffmr4564862a91.18.1786647097635; Thu, 13 Aug 2026
 11:51:37 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 11:51:36 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 11:51:36 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <a71d4fccdffd1f6a12332ddd18fa812542ea2118.camel@intel.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-11-2fc18ee6d3ba@google.com>
 <anZ4W9o5pTWIEgMY@yzhao56-desk.sh.intel.com> <anj2bPrGqzZgZWMF@yzhao56-desk.sh.intel.com>
 <CAEvNRgFzRj_=GVy8T4P8ehhQjYomYxkngzwtKBF0iEL0Cv6fuQ@mail.gmail.com>
 <anp1I64K0KeyQuyo@yzhao56-desk.sh.intel.com> <CAEvNRgFWcndQKJE_q+ZATFZEMYd=6uRLygozLvg7L77bPX0cEQ@mail.gmail.com>
 <anqqKH6kuwpvuwp9@yzhao56-desk.sh.intel.com> <CAEvNRgGWDY_fxbyBM-5sMdYMevMe0HzVP9kbC1cCGLE_dV=_Gw@mail.gmail.com>
 <a71d4fccdffd1f6a12332ddd18fa812542ea2118.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 11:51:36 -0700
X-Gm-Features: AUfX_myWEmd6jjOfyL-08bj4iJ8X-_1fqONSad0Pn1FbAvMHKm6jyQidagK1AHQ
Message-ID: <CAEvNRgHxda6XK_XqWaqqVnA7oW=Fhp_C5gF4vNcL+-HfwfXMqQ@mail.gmail.com>
Subject: Re: [PATCH v10 11/41] KVM: guest_memfd: Ensure pages are not in use
 before conversion
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
Cc: "david@kernel.org" <david@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"steven.price@arm.com" <steven.price@arm.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"x86@kernel.org" <x86@kernel.org>, "tabba@google.com" <tabba@google.com>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "forkloop@google.com" <forkloop@google.com>, 
	"Annapurve, Vishal" <vannapurve@google.com>, "willy@infradead.org" <willy@infradead.org>, 
	"tglx@kernel.org" <tglx@kernel.org>, "wyihan@google.com" <wyihan@google.com>, 
	"pratyush@kernel.org" <pratyush@kernel.org>, "aik@amd.com" <aik@amd.com>, 
	"jmattson@google.com" <jmattson@google.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "rientjes@google.com" <rientjes@google.com>, 
	"andrew.jones@linux.dev" <andrew.jones@linux.dev>, "chrisl@kernel.org" <chrisl@kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>, 
	"tarunsahu@google.com" <tarunsahu@google.com>, "mhiramat@kernel.org" <mhiramat@kernel.org>, 
	"baohua@kernel.org" <baohua@kernel.org>, "oupton@kernel.org" <oupton@kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, 
	"jthoughton@google.com" <jthoughton@google.com>, "yuanchu@google.com" <yuanchu@google.com>, 
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "shikemeng@huaweicloud.com" <shikemeng@huaweicloud.com>, 
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "shivankg@amd.com" <shivankg@amd.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "youngjun.park@lge.com" <youngjun.park@lge.com>, 
	"kasong@tencent.com" <kasong@tencent.com>, "pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"vbabka@kernel.org" <vbabka@kernel.org>, "weixugc@google.com" <weixugc@google.com>, 
	"michael.roth@amd.com" <michael.roth@amd.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "qperret@google.com" <qperret@google.com>, 
	"brauner@kernel.org" <brauner@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>, 
	"baoquan.he@linux.dev" <baoquan.he@linux.dev>, "liam@infradead.org" <liam@infradead.org>, 
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, 
	"axelrasmussen@google.com" <axelrasmussen@google.com>, "kas@kernel.org" <kas@kernel.org>, 
	"qi.zheng@linux.dev" <qi.zheng@linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"seanjc@google.com" <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> writes:

> On Tue, 2026-08-11 at 10:35 -0700, Ackerley Tng wrote:
>> > > Would like to see what Sean thinks of this. Either way, is it okay to
>> > > follow up after conversions lands?
>> > Let's see what Sean thinks of this :)
>> > I raised this because the issue was encountered by one TDX's stress
>> > selftest.
>>
>> Which stress selftest is this? I can try running this on my side too.
>
> We have some selftests that are built on the basic TDX selftests. One just
> hammers the MMU stuff with a bunch of zaps and also weird stuff from the guest.
> It was eventually too much work to try to keep the internal enhancements rebased

Would like all the comments we can get on TDX selftests v14 [1]!

> nicely so we actually just run an old branch's TDX selftests against newer
> kernels. So the branch is a bit of a pile, and not really suitable for sharing.
> We plan to clean it and upstream it when the path clears. So it would really
> help to get those basic ones upstream. We remain happy to help, so please let us
> know.

I guess at this point I'm hoping y'all and Sean are okay that this
conversions series merges, and we let this stress test failure be
handled later. I'll be around to fix things :)

I'd say the line of sight to fixing this would be when the KVM MMU only
gets PFNs (and no pages at all) from guest_memfd.

[1] https://lore.kernel.org/all/20260722-tdx-selftests-v14-0-15ad654a50db@google.com/
