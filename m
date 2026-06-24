Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815EE344DAE
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782340215; cv=pass; b=RNZWLgw67+W35y/DH7vD9puoMURIv2g8uc755krEtUsCN5sZjpCIB3rZDRNdRErx5DXhmIhPELZ/VX1A4tWmtTYzcT9y0F55XYskF9ddJU2WH4RpFn2dK+KJBtwhewxrs7Pv3ifQUwSq5TwBnBLxx+1g7E4Y8zejwutgmJQdfS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782340215; c=relaxed/simple;
	bh=Cryz59YAm4hKcZvNvNbTkH+hut/Wk5VenNHAj/cSfOQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbtYSLkNc5V0yHDAAc7dfxvP/LWjfoOUPiT9tNutBIVxIUPHJ7vYpzDp29e4wvczpzO6C27/bF7vaHCND60L+QxtXllL/Ia5Beato8eRyG/n+cDgrSLAsyxEAYBORR42bHWp8GFWkrnvRIPjWkGuPhGr5wiBzw0BAOXmFHhzEy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mt+d5S8C; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mt+d5S8C"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-13981833e13so1991146c88.1
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 15:30:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782340214; cv=none;
        d=google.com; s=arc-20240605;
        b=Rac9xkYNI3ydl7AnHMaPscJItjqWoYKWPOgWONPMlCG5lAk96YHfSIiZb6vav+ySeJ
         vPrrBCTo8OmRy5KkxTRBBMS1RHBwHcjhZfSwfHKkZxrp+B84TQvHD2qM6FVh10ceXe2+
         d2vOeqJrYTMbX8PMCIm2Hyj2rdGJ7czUhCAVQXRlT4XEa2qgUOMqTAqAsdOE/yp6jnpp
         kiteY81fF+cQk0iC9xANMLKix/Mmn/erx4o85yZu20hG0+cUca64tUDiRJLYKNuXuTCm
         dj9GJ/OKPYjB8v+xuPL+gENqMbjTDsCBgANC9/sUm5AR2aMB4hoLoU6UAF0F/zySBVaK
         Q91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=oVosxF/7uHKl1pdZQ4oI0wtR65vPmKvzzWf+IZ9YyQw=;
        fh=GprNcbP8e7CMzzUcbJ2IobMhq9a0Qhpp3eb+HH1EzXY=;
        b=ESTtprFcL+7JxT1Yat9uRMJntlzo9YFQ0WXJW5nZDhQQleimYFwIvLHOvpZ+VC2bwE
         BcQoMFSzt8qS3Y31R7jGXQ6dixWbEb96yPLrwffNQ6wFjzoqKjXx8d/G+SqTembLJsLM
         Nm8Ea1nKjFTfDLx/OICatK2WElXMg236UjOXAuspUMOcAQu2gii2k/IyfM8P52zxYSe+
         6r+WvpJaHRaLvBhKrI+ynxwK3jVdyyCGCVKq7dT1AjO7xtofa6gIMSIxVKZQOEc6DzaJ
         29kB0vlwOCpcXrf/Xk2GfRlOHHgkze/RNZyqhdO4v0bAdBXf+fz95SUuSnHs4D14iKfy
         dipA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782340214; x=1782945014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oVosxF/7uHKl1pdZQ4oI0wtR65vPmKvzzWf+IZ9YyQw=;
        b=Mt+d5S8CeVyF2uzGbd/9JRs3fsdMoDQplep/243tDeeCK/0viIoreyIvZcomm9oFbc
         osynA3dqv1S/DHst+neAr2nnckPTMGSsR9x/VWNduGgtd3hbI0IfDb0tvdIIRFXegKHc
         F9+5XdmXGx4YFP5WMZU+iCNLYnXl3s5oXgwyZFLzkcQqd8L0W7aRV/+ooPtJ1n58PieV
         ntjs2EoS/iHYsL1LDjxKZj24m+kHe8Ztctu93X6yp0krBWnoiRVrb2A8yEv75Zb2B0jh
         Ze/glsnOlcOHOoI1SgAH6AYIMaGlaWoLyLmhkHDQjfQQ+iEr8XfE/a9xE3hKqQPNtJci
         TZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782340214; x=1782945014;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVosxF/7uHKl1pdZQ4oI0wtR65vPmKvzzWf+IZ9YyQw=;
        b=GpV1BaQE5sFk2TyJPr02IMD9jXgXNxgRitmjAZ8WDy1gVIAsAdUVkA1ajJrX02+fLK
         PfdwHbBpfmISShpRyQHJH9nCgx2IICEHNHpxxxKrmSFlr+Bmt2vm9GTYyN/ouSC4dAVp
         80n1N+91zbkth2G5LorwiOjx834EXd6N0OcQk0qPtK6l/pZ1Mgp4ih1fdgRvMZcP+AVM
         ne0tCKEVy3e0mh0s3ysBKXpXNoJPMEEQ85WJCepYCS9RY5kVmCmfyh2gYfwizPP8dpRo
         GUY920c95Vhl12ZD9P4FphS+3SRP5+jOkyvPgajOPOPwvIiBOmf/PZuuoooCQushPrET
         k9MA==
X-Forwarded-Encrypted: i=1; AFNElJ9CBIkR5gu4bSrqam1cHeDVVK/kVy6hHRPd69JdcSAugnIHJ1ru19bKa+Dt8xQsmj5vuiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrZPxCHWZ6c/vqw6G6wqCVIoEIgZtxBP//zl7MOqezqdOzrcVT
	sflMVnKC+2Q5AGCJJA8FZpZK44Lk40fzc81JKAyrBGH+zaoWruxDoiXzVOgH/MNFvz2LbJRhpcK
	j7A/5FeZMZg5y3bLqAXdb+4SFLd6Mzh8pFaRlqEkq
X-Gm-Gg: AfdE7cmoQOQNvJj1hH7MbTPPSZbtxs5p/6oSc2naezFc8gLe0STQf9v4A4kOgQAgAHl
	BmyxybKWF8XQiZ2DB0uIKHkV0cnTRXvMcC3hclkVwvhPP7TSH1+CRwaxT0U7u/4L1WTKkoEkxOV
	8jWEOMBUY7BrqIOeimB4wiSMBIXFpBakWP3YgDm9c2K8/xuHNzrk+aNBgs21IEIlCNu0SWRWnjH
	plX/7dilr61tu4xlTqtl4L5DwWa6Q9tqazu3BmCmTNVckHAMLMmJzxfUT6dgLVY0C2sM0yVbplE
	zgJbE62oQRPY0abvTkNUmcNs5lw4NAYaaK+U8CKC3CRfRtRTP2k5lOvpWD8=
X-Received: by 2002:a05:7022:fe06:b0:132:5d42:55ba with SMTP id
 a92af1059eb24-139c5d0503fmr6919345c88.16.1782340212554; Wed, 24 Jun 2026
 15:30:12 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 15:30:11 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 15:30:11 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ajpKK/SyRh8LExrY@yzhao56-desk.sh.intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-21-9d2959357853@google.com> <ajpKK/SyRh8LExrY@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 15:30:11 -0700
X-Gm-Features: AVVi8CdqNo4bRyAdjZ4VoxTkK6AK5USFMYju6TEGtZz_v5HiC3fCw0ntlVpZrZ8
Message-ID: <CAEvNRgE=-cdbiToHEu-FCks2XSh3inVDdW3r+h9VYYbE4REttw@mail.gmail.com>
Subject: Re: [PATCH v8 21/46] KVM: guest_memfd: Zero page while getting pfn
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

> On Thu, Jun 18, 2026 at 05:31:58PM -0700, Ackerley Tng via B4 Relay wrote:
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>> Move the folio initialization logic from kvm_gmem_get_pfn() into
>> __kvm_gmem_get_pfn() to also zero pages if the page is to be used in
>> kvm_gmem_populate().
>>
>> With in-place conversion, the existing data in a guest_memfd page can be
>> populated into guest memory through platform-specific ioctls.
>>
>> Without first zeroing the page obtained using __kvm_gmem_get_pfn(), it
>> might contain uninitialized host memory, which would leak to the guest if
>> the populate completes.
>>
>> guest_memfd pages are zeroed at most once in the page's entire lifetime
>> with guest_memfd, and that is tracked using the uptodate flag.
>>
>> Zeroing the page in __kvm_gmem_get_pfn() is chosen over zeroing in
>> kvm_gmem_get_folio() since other flows, such as a future write() syscall,
>> can get a page, write to the page and then set page uptodate without
>> zeroing.
>>
>> This aligns with the concept of zeroing before first use - the other place
>> where zeroing happens is in kvm_gmem_fault_user_mapping().
>>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>  virt/kvm/guest_memfd.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 90bc1a26512b6..86c9f5b0863cb 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -1137,6 +1137,11 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
>>  		return ERR_PTR(-EHWPOISON);
>>  	}
>>
>> +	if (!folio_test_uptodate(folio)) {
>> +		clear_highpage(folio_page(folio, 0));
>> +		folio_mark_uptodate(folio);
>> +	}
> Note:
> In the __kvm_gmem_populate() path, this folio_mark_uptodate() call makes the
> later one after post_populate() pointless.
>
> __kvm_gmem_populate
>     |1.__kvm_gmem_get_pfn
>     |     |->folio = kvm_gmem_get_folio()
>     |     |  if (!folio_test_uptodate(folio))
>     |     |     folio_mark_uptodate(folio);
>     |2. ret = post_populate()
>     |3. if (!ret)
>     |       folio_mark_uptodate(folio);
>

Good point! I'll remove the folio_mark_uptodate() in the populate path
then. Thanks!

>>
>> [...snip...]
>>
