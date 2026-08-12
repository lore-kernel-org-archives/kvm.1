Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8AD4503F1
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541715; cv=pass; b=KwVRoyVI01cBNVYVq1lDwkPEWbK2GVKVV19Z84QGyiXR74jX44hustTXLBLMTgn9e/jnKf6mNm8gL5kQQVoImLa4fY0QXjX6owVz5jmLtAVtVl6Z586H2lJxUEMoMkJ29MARxQv9PCXqnNXsrUdIsmidVm7c0mdqhiXTmOwjGog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541715; c=relaxed/simple;
	bh=Qd0DA5nheV/pXBjB/+20R2YQSj6wjwSeW68i3S2Fko4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBY06AlMUp4ePpo3EBXItlqS1I5kOeuifPUgeTQmDhS2qCBXEUxwIp3XlyNfTXyQszm8Gdww+Rkpequ0L1sATys1btWIuuJkT9qb9ipBUpt466zGpvAtFB3OvhL6WDxsjctOMpPwU9SHjSD2V9tDUw/9G7AqV6nCgNr2QDLNuVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d6cdPoRv; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d6cdPoRv"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c15a5b265so228041cf.0
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 06:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786541710; cv=none;
        d=google.com; s=arc-20260327;
        b=m+KmUynaOEa9GX1cffyyksNyJQaul6/Sr0NoaWC3Ddj72xRdn4TNR2vXUudt6dV+nD
         sqgRDNYjdmEaze73huwnZnIpFR/p80M4SxNxEC/sDt4Gp1RYMCpJ2dcx9g1t/J3aglsI
         BL9nNEvWag0dkmMNV8XwIh0tNW8WJrCmgbZerx+JJ1lq/9bzQkPJwV7jO2Pcyo3EasF7
         DgCUSCMBgIFzHMzTnQOL7WjkQ0LEHRfnYeC8M2xpQOZmmVg3JYOU6d6+QSEKAstsrZeR
         sk6UMc0RGh9H6M++LXDe6nXozN7gioreBzJOmu0xsYHIpiT4ruawHkUdw5MPA1CzxTIh
         3K3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=btatRIN/qVx6m6u+kKi9+q5rHWXBFe/go9/mpyrKKkA=;
        fh=a3r2GwRHEs6FiyTvs2aaHNugbOCNEC4D1LKpcMlz81A=;
        b=Uhty5L6fSynh+9Jc9NkWsNQv6VScNWzyLEUEdIwA19eK4DzCadbWf2a/+tdddV6Iah
         dYZrCCPitYaIoC/wgAsQifEe+77PYorYPCQxBS7JT1cFBG/UmSgTjmezUsYFtEzcME3H
         TUrgG7qW/lHRb+euge9Ozg2ZTkewgN6KL2RCFlcXuyuFJTbSIESQxpkJa8mJX7j/BO6r
         ygYapPsHigrVq/3tSALDWAuP3e/ccrbNnjCOikVafaXStLRGWVW4QtcL88rBKW3BMutL
         FwFRr9qlM5RBdBx/nBLh/zZkANOnsD86RHdVvXWhvjN6xhwPTqHPSMiMvRWIoXCSbM0S
         tWLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786541710; x=1787146510; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=btatRIN/qVx6m6u+kKi9+q5rHWXBFe/go9/mpyrKKkA=;
        b=d6cdPoRvZLtbyQOxdILVtHHSWKF/GQGf/zERGvY3/BzBHVWvov+zxPMSX2kyHlICNu
         +0hb1Nac+n4kZVPFWD5giqXCajCunsRCxt3aVabQ6aKBx2CRzoOoXdnr7AwOmeGgKpuD
         udDmOnfv1Ksi+hQQpagcD7i0GvF7ESEKICfUMOVU3Xwq8UrMX99Dbx/92eUDY8+8IO0z
         YYBIegDZhK3t5vFWVOnteSqfDRmGzRB88bIhUECPjxnmW+NH8yGh8yKO9DClXqgcwY5G
         URk9cnGcr+4GjGWJAodya56YhUG2tlfuyU5JR8ZNi4312tTS5EMPTLJwCNjHhwxF4plp
         k/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786541710; x=1787146510;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=btatRIN/qVx6m6u+kKi9+q5rHWXBFe/go9/mpyrKKkA=;
        b=foIg+Wk8L5r/oitgawriOffdOwi4kLFb/g8KNSsYEgWC7RSfhlHedWLfXWK5d2BjJl
         tVv7Rs384NMFcZ19nY/jM3YoTOKiKm6wL2pDkIfnFg8wE1kQf0WPYB3zHtZ4alE0CHdg
         H9kfZPYnVdMQ8wESjNv4FaYxx/ZZm8JdomXg86+7st0fXugVYnypIwNCoz7i6ewqjJlk
         Oe6VjttRTCikl9ykQ9Fc9+uYTY+Re1TGCVfJchp6BwAdBcoQr8KXTW6jR4wivB2xa+du
         3l+aTEIsR/ShiICw9iRAjpBxotytxBEQAyxZmCioJTrszBRIPx8a9S49ershTpBm6R7P
         z7yg==
X-Forwarded-Encrypted: i=1; AHgh+RohXFpvTRA6B+SjPPov6jl7ClgaQnovN6QT83xDsvqiKN49sb74cNo8GFUZjWemz9gMztc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjLDwNdgEFrFyrQhP4ANo8TZ/X1HHM1JutBD1xXdtlun5ef3St
	GJ1Nj19Ranr22Jm3fEJKkF4BhLh3XHu4fPA2kYsN1zK1MQlHQ7gEqZhGYblBt7vvN6LBJ5yzGZu
	mVDeDVDEtNb39rzMPJjlhiCIp0+MlIAUCVXrOsk1y
X-Gm-Gg: AR+sD11OuS+ZADi9iV4/f5zAnaNeke8Ekxtl8g1OcVb6/sVPbaCxk9CcWzh2XzbEm+4
	ju1KiJEUE5LxZuUFzCMF3FzhC8wfxiMKYahTJeag/Uq0Y+BhXaRjjVRz9107e/pr8rX894q3WND
	hb/HOyxjgPPV31lNLXTC7lsASAch2iUHYA242IqjvAmyMvzn0UmWrefqSUC2REX0cLzEVkVYeE2
	SsoC5Xv6r2IA9ACl5YaOavBMSj7LqLe+8Nn0jzYrECr4cDd9NKFrom+5Xtb1ex9IWRGLaN+aqnL
	zajKgD7fataVFHRCs4uZagOTTDCcUiEF5KSWreyl9KHzmw==
X-Received: by 2002:a05:622a:e198:10b0:50f:af60:3496 with SMTP id
 d75a77b69052e-52d65464646mr13714571cf.1.1786541709957; Wed, 12 Aug 2026
 06:35:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com> <20260807-gmem-inplace-conversion-v10-1-2fc18ee6d3ba@google.com>
In-Reply-To: <20260807-gmem-inplace-conversion-v10-1-2fc18ee6d3ba@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 12 Aug 2026 15:34:32 +0200
X-Gm-Features: AUfX_mzDGNX5m7h-J9AcKRPzqX1cpxh6BaIQgAnDEV-ghyjmfpFsGGynIKZZ1iE
Message-ID: <CA+EHjTzkOQD0YddPUs=2=yThG6s3=jQR2xwm+CeAedjyFaANZA@mail.gmail.com>
Subject: Re: [PATCH v10 01/41] KVM: guest_memfd: Use kvm_mem_is_private() when
 populating guest_memfd memory
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Aug 2026 at 23:52, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Using kvm_mem_is_private() when populating guest_memfd instead of using an
> open coded equivalent.  In addition to simplifying the populate code *now*,
> this avoids the need to provide a range-based gmem lookup API in the future
> as well.
>
> No functional change intended.
>
> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
> ---
>  virt/kvm/guest_memfd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index b596486d184ca..a11cf6dc785da 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -811,9 +811,7 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>
>         folio_unlock(folio);
>
> -       if (!kvm_range_has_memory_attributes(kvm, gfn, gfn + 1,
> -                                            KVM_MEMORY_ATTRIBUTE_PRIVATE,
> -                                            KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
> +       if (!kvm_mem_is_private(kvm, gfn)) {
>                 ret = -EINVAL;
>                 goto out_put_folio;
>         }
>
> --
> 2.55.0.654.g21b8a5bc05-goog
>
>
