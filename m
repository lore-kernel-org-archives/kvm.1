Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AEA3A63F2
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 06:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787727228; cv=pass; b=cUutjDm/3wzuakFFY6WN3vkniz1RV5XYYuSJynul+7VPG9EhywsrNzZ4/IBmnKN/EdpaMddjF1v8N42MbzAQZTNNk5aTCZbJtMTP53PRf+9pV2UR64H3xE+CXlGSKTf8808nfrGCTlB/kbakaup2EfRyWYQluSY1+M5ISdKihyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787727228; c=relaxed/simple;
	bh=/vyKACkfCL7rXCyIYMwbLdrFfGENnqR/w0Bj9SikPUU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVG9fiOuAVJvmz6/EbDDtSkT96LBMyr8Mkfd5ysypvtvQuPa9eKQWaHkxGMwmjTyf/2b/s+sXKsIhL6b9WEZa51ZUaIgWIGc5MUDNGO0M739vvEu59m1p/qBV80QZnq7mMJaa77Pq6qDVn+Xd/WuUh7zD3W1YCEY6d5psLb17BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/xlvGoS; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/xlvGoS"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c2cce930cso7076741cf.0
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 23:53:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787727226; cv=none;
        d=google.com; s=arc-20260327;
        b=UrRAs0PeIKvH5gIh0K3FmZddldQN7vxGWxon+19QCNMDur5Y5dFsPEHI5QtJS88jHw
         4sOKyNRfj7FbT8sBKF9mkUi21ybdbHwWgzpjmKossRyeh3ehVJtq6488WDNu8IxMmndy
         hHdiutwPQ73aWsYQIucyXapmD71bRgNuxG/ZGoXQAYtjyNCCI4k5gdiJ5VCSzCk0bjQd
         jbEx4WKp8RiES16zPlC+HeZF4Q6OL3cMwuTIXFb6jTVINkApRjFebUJypwSn3ssx6Rd5
         HELguhADTmOpYjj1Wcea6qQ/SHP6pv+6ALoenytp9Wd6puncbSDsz6D+uKypJXLiXPjA
         7F3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=gunoR0/5m2ShIW1cBAYYWni95R3wXjfnlI5bo7Tk+30=;
        fh=kF9a3047tW5+a3CN7ljDn4PZZJHdxbwq2F39B2fPQXQ=;
        b=SoBKq6DsFtUgSxnu0EgYtsdWDtoTdNoIH3hyOrTlcEzImz2FJYJ7bCB9A8ZdU+h19S
         W7nHCZ2Wrxw1GKOJYC7xQd277B2E3GS/9b9UOqpdc+MrnPR9c4+WW+05HF3VKAPyQ5jn
         DuX2YEQGM34/nrpk6hbRDGxFDuyXrTESW2K/Zs+mXDJ78c/msAGPpnXOc9+nW/aedx3r
         HgfzAKAbMJOoURQIUuAjZPPD8Lifekie0QM++WTRVSWOBv6rNY0EbrUMvDBkaak7S8/G
         Ux/w+Wgo5ir2vv83mEI6uxtDFXIlKAwbu3MuSLHGwqh05v204Z/o9wUg781MthQxikoN
         4+gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787727226; x=1788332026; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gunoR0/5m2ShIW1cBAYYWni95R3wXjfnlI5bo7Tk+30=;
        b=r/xlvGoS8wiusKkFXUlDEW/ZG8Jzvp8AlSU4MJDo1SuANJ6ka29hYpKo9txgDjSdiK
         xD9GE5/0T0edsf9VSGXthpktOUXdMANbXR591qoCaEbWIB075KjPOLrNtgEknwXwWb8B
         SFCwiTozKjF1gv7VPkKu+950wS4kfM3jjrREpI5tI7ALIw39IoceY87IQs30ldzxNf8x
         G4tk1bHrtFSMlHYNbmdIo009wSDLAT6Mn2O09OYOZ3pqw0sMthP4ssxvlkxkuhm/c8YQ
         +bpNeYT7n49WjYmuex1O3L81UCE3ow8/I2wMfH/sXUutSdGc2gSiP0gyqXW4H1QI70k+
         37NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787727226; x=1788332026;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gunoR0/5m2ShIW1cBAYYWni95R3wXjfnlI5bo7Tk+30=;
        b=WxcK4xk2H5205ZyCB8647/VnpJNtZR6SrMY3uaJv8Yxu+pPCkpK4xXn8iY2g7Hd70D
         2B2Mcd/yWbKzRHpVLLURICjXIQvY0oarxFjy8+YnbUrr+agDw9u0hqxkM0Bib/FjjA/p
         G8Y8kTjPlrovosvXXWMLPwR234GXVkRfmalsY1DcZl4Qd33Us595itpPmPsKKXRbzxRe
         /McdoMGOSrvi7VlB3Do12AGbtC3be9T5cqHARMOEwljaDEr9MwfsOtgyGntkVjwntb1X
         mbXZhb9m9Hi1kE3yfBafFreMMV4B2841UufUGC48h9v84wrs+WG2S2WyrzuPg8VNGlE4
         Ppjw==
X-Forwarded-Encrypted: i=1; AHgh+RpqpX708ei5oVJv5lxMb++G50I9sb7ML/xf4t+VY9m1Sxh111qUB2v8aoDWwmYP9o+OsMA=@vger.kernel.org
X-Gm-Message-State: AFuF++mhbwBhJhoQ+5AcPDowSUrn/D1Aao8mQzPX5AlaIOxQEpUyfa4V
	LAqpdArie3w5rWq4vXKDQeAsQbPJohnRqDJIueO3HA5Q+x6+NLdkW8paqebr2T7J+X0Yp3hobHn
	MbVwB2sDNaiQGoEBlgThZnLJOLbFQSMZ+EyfFUf+u
X-Gm-Gg: AR+sD11xEMjSfwMSFO362X8u96Smrd8hA4nUVq4YHAa5AjHBalXt+W33U6zFElab3Jp
	oGJEe890kxgKEwrPC7Igf/xSvCRiuLCqr4z/7zxg1bLLKtEAFEhfyRO7yHYmdEKhGraxhtgHhHc
	rVJ/RHA/nA1ADbajz3hftLL5xuNAOHvTFrsB+xrZma95EYPx3cD8Hp2Znrk9X2l3SsvHfjDOt6M
	lEhYppYm365X/Dt+akgfL5JM9HSdLd5aNLfRIV1Ad1LErh3R9u+R/DGIKnc8a9uYzIIh+m7eTWs
	+c1c1rT5k92Hfd4SsULRJuk9Mx53epvWzI/TFijh8jzvtd5cd1BcP1HrOHZ9rmoWr/dC9OuvzNf
	QQS5A+xlvAxsEHZJe+yT4V+EEpxu3CQ==
X-Received: by 2002:a05:622a:1b86:b0:51c:fc4:a144 with SMTP id
 d75a77b69052e-52e4228ddf0mr40451941cf.4.1787727224807; Tue, 25 Aug 2026
 23:53:44 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Aug 2026 23:53:43 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Aug 2026 23:53:43 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ao4Gmn5tSZMhl_nX@google.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-7-2fc18ee6d3ba@google.com>
 <a410cca6-0776-44af-8353-9b7375e2fd4e@intel.com> <CAEvNRgGvxMus6pp=xuDYOumH3Ge4oi0=YKjTaFykFHwXuzRDwg@mail.gmail.com>
 <54d1bd0e-c27a-4033-ab97-02cd9579a620@intel.com> <CAEvNRgFhjbgC9Ng1qviPx4oE=qihUwiBcsYOgJG3yOU-nLG1hQ@mail.gmail.com>
 <ao4Gmn5tSZMhl_nX@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Aug 2026 23:53:43 -0700
X-Gm-Features: AcwNN1W7XYwPjQi0IwDu9VBVz85rJlKXjtpX9LauU0RxJJUn8oPq1JlhbiQWidY
Message-ID: <CAEvNRgEHZZLXyhQ5HiHcTbCk65Y2Lb-fYu0fZ+LRMm1_eWgeSg@mail.gmail.com>
Subject: Re: [PATCH v10 07/41] KVM: guest_memfd: Stub in ability to enable
 in-place shared<=>private conversion
To: Sean Christopherson <seanjc@google.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
>> >
>> > I'm looking at the doc of KVM_SET_USER_MEMORY_REGION2, which reads
>> >
>> > # When mapping a gfn into the guest, KVM selects shared vs. private, i.e consumes
>> > # userspace_addr vs. guest_memfd, based on the gfn's KVM_MEMORY_ATTRIBUTE_PRIVATE
>> > # state.  At VM creation time, all memory is shared, i.e. the PRIVATE attribute
>> > # is '0' for all gfns.  Userspace can control whether memory is shared/private by
>> > # toggling KVM_MEMORY_ATTRIBUTE_PRIVATE via KVM_SET_MEMORY_ATTRIBUTES as needed.
>>
>> I'm not sure how this snippet from the documentation connects with what
>> you'd like changed.
>
> It's flat out wrong once in-place conversion lands, because it assumes PRIVATE
> is tracked per-VM.  Something like this?
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 4eb7e75a7473..c9769e5e7329 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6383,9 +6383,12 @@ on-demand.
>
>  When mapping a gfn into the guest, KVM selects shared vs. private, i.e consumes
>  userspace_addr vs. guest_memfd, based on the gfn's KVM_MEMORY_ATTRIBUTE_PRIVATE
> -state.  At VM creation time, all memory is shared, i.e. the PRIVATE attribute
> -is '0' for all gfns.  Userspace can control whether memory is shared/private by
> +state.  If in-place conversion is disabled, i.e. PRIVATE is tracked per-VM,
> +then at VM creation time, all memory is shared, i.e. the PRIVATE attribute is
> +'0' for all gfns.  Userspace can control whether memory is shared/private by
>  toggling KVM_MEMORY_ATTRIBUTE_PRIVATE via KVM_SET_MEMORY_ATTRIBUTES as needed.
> +If in-place conversion is enabled, then the starting PRIVATE vs. SHARED state
> +of a gfn is determined by the relevant guest_memfd instance.
>
>  S390:
>  ^^^^^

Will apply this, thanks!
