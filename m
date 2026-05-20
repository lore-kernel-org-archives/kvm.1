Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5261C3BEB
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285142; cv=pass; b=ONCQuUFAHD+K0HQgziih1AEGI5dd9XqZ+k14pmT0eLawMvMPNK93aUpWyov4TD1PdpGFH0AVeserB8ab6s9UE+qEEt+HkfD2Dc6/VDzr1HQwX+ruucTv0kq/fhrlAwMa6rj9ORiDkUJmKT5Io7n9esOnko//C1tqQb5B+4zrHWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285142; c=relaxed/simple;
	bh=w4JDDKhr2QiuCMCCR6/SASV1LBSfLF+z9c67ox8kPyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zxpnsqv5VJnST0G3EzAKWLC4FoWf91AkNWI/c9Cp8yz/z+sFvFWUKCg6ZR/l1LyaRQk/SCsA+hif9pb3zlaaFjEfizuvc1pqV/bFo9zlD1LcFRFtL31shOSn3VNkwRPTnrNswprOdVSxA/cGXipz7yer5gHk/XonuD72C0QLK5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a2Ft0HL0; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a2Ft0HL0"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-515548f390fso16071cf.0
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 06:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779285139; cv=none;
        d=google.com; s=arc-20240605;
        b=NjDA3Wb7Tzvi3uIBZjt+Bq/ePwZ+yGGAiLp6vvE93vfGJVcIbfuOYr6qfrW3g+H/5U
         EqnV9Zg50H+7KVK3zNv9CDzh+H+MbkaNXXMafDE+a4hyhLaR/vSOeUmik4fOiJjh8bpv
         Ie7jaR4h0Gkx0nEf/i4Wc2Lqt3DfWaRfxpGIHLHx1Y7J23KD2TM0aTiom9KvzyygCVD8
         Ct8tPoBXnyktdNFmX+Kqs+Zsf9XI02L5aEO/+ansTBQwKJFTL7kzZw0DR5C3RGcmNyk6
         cW5Hh9k1jfl+BQ454rF+iESj+1d5WI7WyRFwM4UKBombBQ5gAh+aSZbsm3GVp1a7OOkF
         h1ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Worh2JLSPSAyI17eyly2xWvvXK0uXozd+nOzIiXznLs=;
        fh=TzV/foJOQybFifMi30U51qDxreSvLxbTeiQgMCkmv6Q=;
        b=CgbQ6ctH5KiseYm+4tedHfgt04Zb/GgZxKGrr2Fj9j7vq73ASopCo5xxXVPAE/wMdH
         384BGYpOu+23XgCNJRJdm3ZheDaghS07ZTr274s9NxZZ6tal0g1gINIvFSPnPMUPyosj
         2tKUbiUgezEO2wn06lZha2+KgJMIrLNJBU2/nMcJlijVBaBpFBvJhK0rIdHHS/3UU+yR
         tw0hXJsE/nw9T08zB9PEkKg7DAZr4BAFLI5Yat6k9sJoN9JgDH48CJa0O9f17V7v7ytY
         BwIcVyvdzbkUWEgPAvsU70cSdUIyWVjISHr2pXpjclZLyMe6OyDECcokOTqDUVYaO5so
         v07Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779285139; x=1779889939; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Worh2JLSPSAyI17eyly2xWvvXK0uXozd+nOzIiXznLs=;
        b=a2Ft0HL0pC1eYOIQcvNBz88Gn+nwwcWG9ItrsoXV1uF2+k/Luv4BHBWm4i03dfToZH
         ELiDekXwMn7OgysNbkSK6RY3V7sB957mkgn/NHuz8EHlyy73YRU8D1nDfmSY5FcCEqWO
         p/YQ4K0K+dvCgSnkfdWKMEOy3MIgNzzYdsFjNPVjL76skwQrX2OLJiXWsveFSpzqEzMS
         kw7xfDoXye9xPPX6pTND9oC0nNWanr+Pp7Y40gGF5SlSkUnGV44IIYmn8pJcmFINzN82
         0vzGqEF9G2Nmey4biWosRwDRfml8YLmeAhf5jjkL0VNIDZjk3cRwyzHZGysv8UdGeI7n
         EziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779285139; x=1779889939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Worh2JLSPSAyI17eyly2xWvvXK0uXozd+nOzIiXznLs=;
        b=eWIDigphtFwKdG2oBvnEPcAbPw7aWt3TMgHg0XufNEbXU58oolopMwDUAEbGg7tGAr
         U5JkicG+k7BYhQDjwpTuaICb+qGxD1jhU4d64K2t0XWyfIDfUOQKG1dOXqxJSMxhCCRQ
         zuS0bZ/XAGOCzjfpmvvdu5JrGoWT2S+FY4hPjy97FbjWGx+9fsPH5NJ0kv42DYCZZJRk
         S8wraC6dtK8eMtfaMJLkL3G+kCkJPlZEzgp4Va0pL8ABQ+MV6U4GP7c9JFrN5Hi2IIhs
         kxDlUwDFQS8NbcvGQOMX50hdci1TTpuY8oo5YgegA+iBMelnqwSgcW/X4M0dBXUua/re
         8T5g==
X-Forwarded-Encrypted: i=1; AFNElJ95Ql7Ir3DrPtJz/uKtSwtafQ9xEWdR1OiEnhsgcLsCIE9Zb5L/TEgcRyezK50a5pP6xfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR4F9rh8Ux5XX4A+RyhZm+pG10Rn/hjsno7jhfz4h64aDzpBfJ
	dYT3urffffUmQGGHxIjLtynIR6SFmvMLUvPcca7cAsPrt0ouU46s7zvE8gxpqUuXRI8BmNyWyor
	cJvqBMG5lq53dO8/51/hXMXvq64NsZVHMCnFFjVJx
X-Gm-Gg: Acq92OE33WyYuJqbRIzBPHCKcsJRofpyTFkv3ZQMMUaQ++RWEGVGwejLF3ZNpiNohx6
	r+5vpkn8xGfyondqkcDwANzQ2tpA5PtU0U+PGuEph5DxXGuWbnypXLBC6jPBDp3RGN0qvwdPApF
	RHiEZNvcveHPvF95pQ/tAy0b47m7YrbzVHJpKmDtPjT8MqcglO8eU1SF4EjXWGePujejhiSN8Je
	JNFkhwmTcxubOz+lsUboEGCUeZdME+b9IxuJ2ppTA2D31j+W8+FhqYC0+yAw24YFjFmZUgoibku
	7LHWMMUxzJN/hA4aezQ=
X-Received: by 2002:a05:622a:5d4:b0:516:4197:361 with SMTP id
 d75a77b69052e-5167937f111mr19778701cf.4.1779285137735; Wed, 20 May 2026
 06:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-8-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-8-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 20 May 2026 14:51:41 +0100
X-Gm-Features: AVHnY4J85RRb6CNplqSCM30M3DMf1Y3bV7iG1C3rTvm3LWaftfTfmZz57_1_-Dw
Message-ID: <CA+EHjTx+WbsKB66_0_1a3=vBkEdoeqJG9QOfZcUTuT8MYc=TtA@mail.gmail.com>
Subject: Re: [PATCH v6 08/43] KVM: guest_memfd: Only prepare folios for
 private pages
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 May 2026 at 21:22, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Ackerley Tng <ackerleytng@google.com>
>
> All-shared guest_memfd used to be only supported for non-CoCo VMs where
> preparation doesn't apply. INIT_SHARED is about to be supported for
> non-CoCo VMs in a later patch in this series.
>
> In addition, KVM_SET_MEMORY_ATTRIBUTES2 is about to be supported in
> guest_memfd in a later patch in this series.
>
> This means that the kvm fault handler may now call kvm_gmem_get_pfn() on a
> shared folio for a CoCo VM where preparation applies.
>
> Add a check to make sure that preparation is only performed for private
> folios.
>
> Preparation will be undone on freeing (see kvm_gmem_free_folio()) and on
> conversion to shared.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad
> ---
>  virt/kvm/guest_memfd.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 9d025f518c025..4f7c4824c3a45 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -888,6 +888,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>                      int *max_order)
>  {
>         pgoff_t index = kvm_gmem_get_index(slot, gfn);
> +       struct inode *inode;
>         struct folio *folio;
>         int r = 0;
>
> @@ -895,7 +896,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>         if (!file)
>                 return -EFAULT;
>
> -       filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
> +       inode = file_inode(file);
> +       filemap_invalidate_lock_shared(inode->i_mapping);
>
>         folio = __kvm_gmem_get_pfn(file, slot, index, pfn, max_order);
>         if (IS_ERR(folio)) {
> @@ -908,7 +910,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>                 folio_mark_uptodate(folio);
>         }
>
> -       r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> +       if (kvm_gmem_is_private_mem(inode, index))
> +               r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>
>         folio_unlock(folio);
>
> @@ -918,7 +921,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>                 folio_put(folio);
>
>  out:
> -       filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
> +       filemap_invalidate_unlock_shared(inode->i_mapping);
>         return r;
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
