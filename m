Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1830533F8B4
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348679; cv=pass; b=jTl8FqRZTnXqQlz6lvgFfuy9WsApCBaeDVw1EpUOJcmBRNdDFwumaJ0P0LExkWaJSm1UbdcVy+KYKVfn2kSco4yXJfK0wLlYXJBDDmbCq/ZhTtRRvmevOJLA1ziPCnoTeiW4k4RuCiVEe/M0VOyENSCg8jmY8adrivK652omJII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348679; c=relaxed/simple;
	bh=XHlZItdK9pHZDtShz/g2SubgxMlbGRtAoD9tOKGcWfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uvem5PLhPPZVWgv++k1xWjFZI1+AO0Gw/EJ5CQxJ0gH/vbByIilHX/dNU5If6hzPSjutNkp8g9+N58ynV+RLjQt6m5tmesUSlJ0Bp+lP+0zfJPEikarcnM/YQqqsNQvRHxR52SvIjbyGrJfqWRas0rLEHp1nrrbVEYx5QXyQaSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vMgBG+gl; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vMgBG+gl"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50d6b393d60so3981cf.0
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 00:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779348677; cv=none;
        d=google.com; s=arc-20240605;
        b=l17SMRy93gOECnP0ApNkNVBNK+MwEIjSq22blYejFJkLgUShqxT1/LOeNpFRMdivsj
         FRCNaT9sgJ8gDpDmutt+YaCyMWujtNFXguHMO+J0Kjsz7OcpkdWoZc+zaHlLmNyNY9cQ
         CL8/n9JIYA0k2D6P6An/25axd6Z8NzI36Qc0XbJPBPRBY5V3dZ8ClntEREnnNMIWHgTT
         VA18LuD29+csb+tASotAx6xyXOEYHPw/tMqPrTQPbfjZ4zxKUuOvRu9OJW/dbeeNXBnQ
         wFYNkWEGVpD9mxZKOdaPMERAZQXe+7F8XVuLzqZSOg7NOOYfJYNF9NnwUP/QjINdH2RU
         FD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1nov9/2BtMfIFSe84psXHPo953z02mFT+vkGOoJChBc=;
        fh=o9zGiIMQKfkq3PxslV4ydDBNqg1xCdz8JdJgrXl/T3s=;
        b=g/nkk3WdVXqkctvOi9rbeRuoSP+dqUsTVKwzOan+du8+/AngoOfpHCvLOk9/TZ/sEj
         SSm2MbgeCL4NggKLNEDTfgHMqlALNmARIwuG8AdrD++kKnLYrvCaWJ4LbcE/l7b5bSst
         SgDTH0xQqi2FYYL8a+kzX71vxn2zLm3+CjZXMvEqEH4F1XjxSIxoH91qULSF/9knrf39
         aRnn60+MHakckOs0Fx7+qI+ljacYlH+DnyhYE6ZIT+k6z5siKtF5QYD/Pe8E5cMiuwSc
         e+smu8lLEM86X7rsrcrsv1xKNRTWPM2tDXdrKsVkhnOvNN6P9C2xrOH14PaOuburGTFf
         mxiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779348677; x=1779953477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1nov9/2BtMfIFSe84psXHPo953z02mFT+vkGOoJChBc=;
        b=vMgBG+gl+TJmqz7EJrkxlO+cmw34zZITmz3M1CSGrp42FzHn1JgRe+y2jxAOU0PB5P
         7sDkQs2g4djNy3gDoohAVF0+NxIiQFtDcDG136xGO87w5kzZ1KgeNdSs4HewqYWTNvPV
         hV53phfFXwrjYrBD4MyleuvzRVwinutKcijNNYzvjvBKYiE8wJj9s3PIt/xaHftvWjdO
         g1pqyHfvVoAsb4CgMpNxnn8Q3YLWTHGya4OgNUAwzRnxxENnnSA/gDvYqI20b6JGDyb4
         rxPzXz+V2A/XtyIr+sCTLJRUkOrgUOjujx3aTsyKmWQClgSeCTiJkyqUPwz62AQIE45h
         rLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779348677; x=1779953477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nov9/2BtMfIFSe84psXHPo953z02mFT+vkGOoJChBc=;
        b=moUYNGIakYFtUY+tgISpEakVnAdyYQE7vGs4ZdfdvJbu0XhKBfjbwS4BFoVU7PURzk
         qw6alksl11i8ZsV7GAH/9UPX/RPRnYd6OHOJAh8tqD+i0FvaPV3XSFgwqhIqglk9lF5m
         /Zk+HVAVFFpNIGR1M3m4CPzRdTKojIri6WlasK3yCJs28dH0E7mcp34C4z0l5vrE8cT2
         qM+LXxOyAX1RBWahe2F+BsKfndtDBJdK5hAX/nZS2OymnzKkohoRcX3l7Vew863dqAi4
         CuKRDCwdvhLq01R6ou4JeB5wdhU2X81VufJgRrWduCmsjMulxNX1AyUN6fSj4tZC5fPB
         8VoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8KQjT6MwQwGKgo+ooxJAP9WS9brSbiJwF5GYVR1IswrETw1RTevLzWJ1Ymv05/SZ5yWXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4vh4Q2WT4PpKqWOSCtnt0QA85XAE7AmF2jcy/PnBrQFffv8bj
	JHy+Ie9HyfyNV1qEjssAobrfxttkKaxUgAxVncysiqQBQesjqRqLR+fhfkzeB64qHZJrWiC7OXK
	dLfpm4uN6Vks/yPasnKL+WXddJcS8M6MdPEA0/r8R
X-Gm-Gg: Acq92OERTNoP70GPuJ8GJWP24mPj6ttEq7k8pHrnbrRgBiAd0xBizmLiLyxgV/s7Qc+
	D+OgFffD3kUPS7rq4Ff5VDKdqhV9APGVIPQ7zjNNEXp3XeHBLB6uRUGGrQnvPKaxBb3FZanzJPo
	/LAi5Vfy7CVYp+8UEeb/GmYpBP8oKcsjbijD23/M9Qn3g0MF4D1kKKLDS8Cy31Jr+bSi4Z+ns12
	cPDW85SoBHqpgLS5aG9KXvjfDrqOKLUjQzYeFzrYUrkRZ1Ssc/FwlKkhQrZqXgyR8MhsBouhQH1
	ZEnb2nI42m1Prq+MyQM=
X-Received: by 2002:a05:622a:9005:b0:516:4f62:85e6 with SMTP id
 d75a77b69052e-516c54d8a37mr5382941cf.17.1779348676536; Thu, 21 May 2026
 00:31:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-16-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-16-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 21 May 2026 08:30:39 +0100
X-Gm-Features: AVHnY4JV7zINIc5-OFXxSXoQ_2kIaSiAQNVZEIUteRP4GKUxLGDjyOPiw4qGQa8
Message-ID: <CA+EHjTxcadguOfOo7RpJVtAzcY5JAFZTbrAT_wcN6akMi8gCUg@mail.gmail.com>
Subject: Re: [PATCH v6 16/43] KVM: guest_memfd: Use actual size for
 invalidation in kvm_gmem_release()
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

Hi Ackerley,

On Thu, 7 May 2026 at 21:22, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Ackerley Tng <ackerleytng@google.com>
>
> __kvm_gmem_invalidate_begin() and __kvm_gmem_invalidate_end() actually do
> not specially handle -1ul. -1ul is used as a huge number, which legal
> indices do not exceed, and hence the invalidation works as expected.
>
> Since a later patch is going to make use of the exact range, calculate the
> size of the guest_memfd inode and use it as the end range for invalidating
> SPTEs.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Want to look at what Sashiko has to say? Seems to be a real issue:

https://sashiko.dev/#/patchset/20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4%40google.com?part=16

If I understand correctly, the fix should simple: use
check_add_overflow() to validate the offset and size parameters in
kvm_gmem_bind()

   int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
             unsigned int fd, loff_t offset)
   {
       loff_t size = slot->npages << PAGE_SHIFT;
   +    loff_t end;
       unsigned long start, end_index;
       struct gmem_file *f;
...
   -    if (offset < 0 || !PAGE_ALIGNED(offset) ||
   -        offset + size > i_size_read(inode))
   +    if (offset < 0 || !PAGE_ALIGNED(offset) ||
   +        check_add_overflow(offset, size, &end) ||
   +        end > i_size_read(inode))
           goto err;

What do you think?

/fuad

> ---
>  virt/kvm/guest_memfd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 050a8c092b1a3..9f6eebfb68f6b 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -370,6 +370,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
>         struct kvm_memory_slot *slot;
>         struct kvm *kvm = f->kvm;
>         unsigned long index;
> +       pgoff_t end;
>
>         /*
>          * Prevent concurrent attempts to *unbind* a memslot.  This is the last
> @@ -396,9 +397,10 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
>          * Zap all SPTEs pointed at by this file.  Do not free the backing
>          * memory, as its lifetime is associated with the inode, not the file.
>          */
> -       __kvm_gmem_invalidate_begin(f, 0, -1ul,
> +       end = i_size_read(inode) >> PAGE_SHIFT;
> +       __kvm_gmem_invalidate_begin(f, 0, end,
>                                     kvm_gmem_get_invalidate_filter(inode));
> -       __kvm_gmem_invalidate_end(f, 0, -1ul);
> +       __kvm_gmem_invalidate_end(f, 0, end);
>
>         list_del(&f->entry);
>
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
