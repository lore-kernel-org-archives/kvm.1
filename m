Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF47038239C
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379222; cv=pass; b=OZuGXvUSf9RHk+jKnkKthURk0Flh9QK03Yv8/9QkY3K4AGy6kaVw1JTA1mo1CjHwxdqZjNIpAPsqg40pirBLb1PeZPM7nS/rGfJIQsQubzcbKnPhOIfWAomdq8W8NEM3/zyq2CKocZGJ6eDUpYEO8NW7XsP4at25HVd/0KVY/G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379222; c=relaxed/simple;
	bh=VvJfZbIRil3c4qUEVncM0B4gssrwDmoZt1aKoqwRohw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5Jh7TbPb/QheUJjTvLS46rQOV1WITKttfZDvqJWcJ7yO1sbNFBE2LEWZSj9UwGtH6d6pAHuUYzyXrJ99oHPtBHtf5qeRHLziPoMeQdCIQYGWm+DJp1N4ZLjoMi9kXWcpJtvD/Kb7vYsUWD0lAO/fWW+vmxEnY12ieBUvH8CdCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sHoCqtxc; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sHoCqtxc"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51765331535so162581cf.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 02:20:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782379220; cv=none;
        d=google.com; s=arc-20260327;
        b=qLRj/wH4gFZciX3mjNlWFxR0r2OH7rviNK39Lfps+y/5avxy+S0JJXycoGhNJRsrLH
         RJq+c0CP9JcibYke1F2sKuW3H6mJcN90Z0H/brHJZec9/hwxGqbh+SpvnEfoELYgWcuO
         0e94N7crxupc0i9BcpUzh0R37Z3HEn1jPQajv8pj7S7G/83sLG0kw59P0HrVcryVXRAx
         mk011H4U58uBxPC7GPAD60GAAPimvDIk1eczMgweUT288vNkxSROVOVoUrGesKMGs+YK
         DzJ7n6A552ZdnLFZZpEDsTsYFt+BdkeGA7Dlovc2fFxAPAaUFCVQiuZV8GwEQmHIAQ9N
         Zozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9sNVNZ83P6g0a7P8tPRt1nDyKQGm49SitMTFhdy7JFs=;
        fh=BEh4rJzPhuQMEShN45KCEuJV4eKnah+AphVtQcdDFTY=;
        b=DcxoxdVk2aReowBj2/4PpPZ4USN/O+SFseOviDUql1+yj7J5uWjlD/qHJ88HgIvRTx
         BOJc89jM2PddCLRWYK7fsnyDA8M5LGKQSsgaiGjNRoAYA3IXC6cBYhhl1R8htyh22rjT
         EVWCSE+0u0nX1w+xkuxrm1UTgqwPwbeWxXE9JJNX4hDGQ6G8eZvVuNN+AMy2JHvU+Hn+
         APE1rhy+aTFoos7NwPzqz66rMMAMKeJ0p4Pk0IvNxd/u2c9gRy2pycoXJ/bD9NHj7k5+
         hUMM/xlBf+J5XRn9/D7OwIObHufLjI4rNymwLsfXu2QGwPQHF5/WTMTE56fiN+yGajsm
         5K/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782379220; x=1782984020; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9sNVNZ83P6g0a7P8tPRt1nDyKQGm49SitMTFhdy7JFs=;
        b=sHoCqtxcsBpRGQR93WwrL4Rprcr1QwyvppQmBSKllNaiQKveEBRjCnonKRFZa7Z6m9
         +oOVGonFyUHMnZb+kZnS6iUCwNoCqG3Ny8+m7LrN8WACHABB83NkHapybUKORqHCauZF
         SEgIM9jSGnc+bD8NUFUGz81LgV6IFzMywzmXIVngK14vKU+I5M9ORDekRXX0DrnMltd9
         qORudEJ4Opzx/t8Gp+odaQo5QAgGZqIQefx7RHmiEHMkAlLgMrYdOBnsUqUDd7HTl566
         qSkdexSW2GvQXS6JErTD/Yu8fd0w5H+0Rg1WIRe7QcvxoG3iGKpgA4jH1NReHf+IqfRo
         sCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782379220; x=1782984020;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9sNVNZ83P6g0a7P8tPRt1nDyKQGm49SitMTFhdy7JFs=;
        b=V8wNvt0gs38AX244G8ZVI5skCzkKKjdEaRuDVv4BuFdG9befdWrz5SmCNHGatc76Bu
         b88V1yhiOdazQFdXbgv4E08CdAml+jLdQeF6dUywTk0Y28QUDCVf5veK9kDa9bUnv0ds
         qWk/pXq3M78BN22i08weYVeO3eah3vCznT2wGd7uOtz0ULPQRnc2rYypArO2X4usMujk
         /NdZD6IiKsVuDVfKRV8jMZPD9wgzk129IxmCJbRnWS0X2KqB0Io1H41L/blNqxAzSLtQ
         Bm5wAvB36Bi4ymm3InmAuMYYPczCnAhX/Vxrb51mUmAIxy4E1Y0yMHx+tHec65gVS2gm
         MQ+g==
X-Forwarded-Encrypted: i=1; AFNElJ+nZi1eqabaTQu1QgwEv+64meUKZvqVYUxta36HMSGfEPeqgaDDD5WdEsHGU74Jsb3hglw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2gMNNcxD1INopxXJyH2IWJMdaykyW/kNb4gg0YMw/w9l6ffRn
	hn2yYOBi2PDQWgoskMq/iHWsvbqi5fz1VwqmQBvC0pXoFQFFzOBLNGsKHhVuUgi/DzsezFMTXl0
	p29fXe1c8wqDOK8fSuJfpg1MFBwPRGWu3mf47YVdt
X-Gm-Gg: AfdE7cnB7dTS62gNXCCNyRbrAByx1fzI/kQ8DwQz1VOhil07Bl19WYNx6Zz2+qBECt4
	kmDBcWgkcjRviwXxFXuz6jeFji+4TJP6S1f1pGaFsw+DBR+0jgx538omZ/OLugFKPYWRMZLunsV
	QblvsNwcSPO+LAzo9pQ7bn4/+tnp50EhOtKBl89NHpiga6xjFgxnZONTT6y8j7nn1WnuZy3JU5M
	SdZXK3gfBnn6tN9VJa4R+FlOiZD6ILxkn6xQnjvdc+JI2ixz8tXjOGAnoMD3qJkipP2SR9s0Q==
X-Received: by 2002:ac8:58cb:0:b0:4f3:5475:6b10 with SMTP id
 d75a77b69052e-51a6e9af205mr7810381cf.8.1782379219049; Thu, 25 Jun 2026
 02:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-43-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-43-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 25 Jun 2026 10:20:00 +0100
X-Gm-Features: AVVi8CeL3q_KiSPnBQlDtTbHhecm2C_9dXyC0RdNzrEqsxqa92mG6-FntXo0Q6U
Message-ID: <CA+EHjTx3z48aykAeQ36d=pOGEEcChWst9_T5+rOFNcxP3n9vZA@mail.gmail.com>
Subject: Re: [PATCH v8 43/46] KVM: selftests: Check fd/flags provided to
 mmap() when setting up memslot
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
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

On Fri, 19 Jun 2026 at 01:32, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Check that a valid fd provided to mmap() must be accompanied by MAP_SHARED.
>
> With an invalid fd (usually used for anonymous mappings), there are no
> constraints on mmap() flags.
>
> Add this check to make sure that when a guest_memfd is used as region->fd,
> the flag provided to mmap() will include MAP_SHARED.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [Rephrase assertion message.]
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 0b2256ea65ff9..6b304e8a0e0d5 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1110,6 +1110,9 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>                                              src_type == VM_MEM_SRC_SHARED_HUGETLB);
>         }
>
> +       TEST_ASSERT(region->fd == -1 || backing_src_is_shared(src_type),
> +                   "A valid fd provided to mmap() must be accompanied by MAP_SHARED.");
> +
>         region->mmap_start = __kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE,
>                                         vm_mem_backing_src_alias(src_type)->flag,
>                                         region->fd, mmap_offset);
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
