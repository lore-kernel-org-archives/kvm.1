Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C97372ED5
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781866329; cv=pass; b=QVvGPMYcnbz0H6SGDoBf923AshnsE75cUUnrWE3K083PxUP2aC+Z0BhLZR9LalMFSZdv35uRT7fF6hVr5FKDEdD+AHILD+jpGhI+gc7P9QyKxTcVJQrb6UbBgMx99EK0HC1tBvXXh1Vruifueaui7uGHrLRHSJ39CPQJSldl05k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781866329; c=relaxed/simple;
	bh=FV+HhQxDLV3ClDVmAYwBBibFkDhfDGLaaVmYDJKEf4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4CWOBisyXfLqQf86KvTemYuPi/DFHKw5aYq+mGjEQrOlAEOs1NHfEXG9JK30a6euYhhqRpOOQ0EDqbkoXhWmv5+55mS3LdXEbt45NbeClZgqRfPkYut9xBuLGym65I2oYL1h82VfkQ6SSDyLj66pE4GU3A+PNxGeC7ctDJEL3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/flVJqm; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/flVJqm"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51765531803so233191cf.0
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 03:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781866327; cv=none;
        d=google.com; s=arc-20260327;
        b=mCtDGEKrqSJEiFSjxupU7Vx666zGlFcUIEM1UxFFlah5NndJmAE0QrpMSXxOzVObOD
         EGt20e1veJ23HmMHHGX5iS0PQML+dCKrAGqOq1lgPtPALXfip5UkOTQDnn6T0E2js+34
         GjFulcAQ+QaUZqN5PJLoybzi+jTNpARqFHrZrjq7DYgabEnwS8++FQL10zs24x0xpK5t
         Sx3VFxW+lXOaoQwGCrbWLGMLG9ew+toakD4Sv9rA6ZfDb8OxqR8t05zG1vszFpOzEROR
         Fi/SfP0dQaskX5wRqhAka9MFES7egdp4/b9KseGleVNOF24JY6Mi8thyJ7c3JM5+0Ohw
         7xAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qqrLJidqwZhWczfBA7HD/HFgW4vaG9cXUmJMg4P1TGM=;
        fh=WcMdwgxGn2U25LZVZf/c88Ymhl4f9eK3doR2v2rBsaU=;
        b=L+zrNAdQhKV3e4uuSlGyLjY/DE0XK0iomTecrKIykbWSGDRq+a1v/y/6J+WoEGothh
         n/imiSQtCYYhTRPx8B8ZXmPwCC9jltdNHFBk7/ksuI7E2y5nYKjdhgZfSIE3xXwAAiWb
         lpXkE69gNt7/5nP+ctaCKM0veulIse/8SAftYZZVhnE5L1B7M3yrQvUFmYL6pFYPBwSs
         +75dPqKUi7ymJ43o8uonhDlv9ixAQ3HAggUGcV+ug3JNQf41YJO/tnpsBh7M7N6waABy
         iVTiS1y4Uwx71g4rrs3lMx0a06AJBz7x5EnK9Yti4qtO95qRXsDkJYGVd+JssCBLUUUj
         z1Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781866327; x=1782471127; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qqrLJidqwZhWczfBA7HD/HFgW4vaG9cXUmJMg4P1TGM=;
        b=e/flVJqmGPutL2J62kpQyfrqZj/S5ZnHKtlsC7HcAsS3CXMPwVQuqgs6EO86Al65Uy
         FmaZpmOvgKWy6ZBmDuARHeCcX5Lx2PtiMi89RFIHqZ0soQFxGH0jNeUyL+I3CJJWocrC
         A0BB7GoyvslRf65Rurn26dVQS2560pPol7HTovCAvlUvK2F05AKsA3bmdqXWqsWg4fWi
         ME+f8ZZwXY6lECXddc92I6S+wMylWv2MsjpsoSxQv4hfv4hAwA2pnxte9KEuaULV/+TU
         WiJKTeL2v45PsELmjDDSaB7roX0OziVablI1hymfDNVkJEKAbjGzbl2P9mbv0MnG/G01
         shfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781866327; x=1782471127;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qqrLJidqwZhWczfBA7HD/HFgW4vaG9cXUmJMg4P1TGM=;
        b=U3uIyhFtyR5xXgD0GVAAjBPUtOT/PwisOKBQ0hIwYjP8MtEWlYaU9hJQBxlHs8eoAc
         IGhjANepZkuYUzLVffPe6oGcHu6VKbf1rzVpKlHjhWZ/quVKtjyS28Z9EgOWT7T6FbMG
         nZQG1e57A3e8gf7ER+inc8VLR7+/7gN8h15EMqqUvr4pqS4hTY3QY4wCnnKaA49CNUJQ
         ucZR/kKGKPaxBrMJ5+3lHDW1NaH4rWaHJgHyh4fZRgh4D9Bt4DLCp/8RahhT6J+lvZ52
         KIkb1/HlX21PZ49+ojUxM3rp7BqBiADQ1NbSC1FBnIkXdlqpcFoRG+tAoCe5m/uuRuq8
         i0jQ==
X-Forwarded-Encrypted: i=1; AFNElJ9rt+oSmZGx9gOEcyv/FYqTPQKI/2rxm2vwv1ceS5+nK6HRKtQd4zNQDc0zZymM6cGZjUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkJwFGILViodBQqq1MhMRejjfCAC6Gfjw3RBN/LP6dYwrXyM+u
	//rYlD/OwI7XE0RLj7I8x53wYWNLwTux3rU2b8Pku4e4/ZTqEf8QCdQxJUSiTfrEz+Y5hFwwSEs
	IQL8rHJA/0KVW4+UwHd+zPoogAl7RZurKGk7icxWD
X-Gm-Gg: AfdE7cn+xuZfLCQD9/7jGPz8e6SZKNi1Y/c0v6/NweRUEmt+kNK9OIWP+nn7Kdr1m5I
	fTviQzSvoUMFwTQaPlcKoty5rNw6bYl6wGcErGnnUZgMmWw31y3mO9TXEXwE26ooli53db1C/d6
	Uzq22qnJ0CIhaLXyuaRU5/nhz9lBcmlBdjKIiIKc2mGwudtpac37tOzPw0/0pSBtVnbuhGDIiCj
	muYG9uS2CVG/44uuap79mFgl4Tgm6oyAE4inpi8Fnk7OZonthO5nrdVUCeiQwtF4cgwSnATgg==
X-Received: by 2002:ac8:5e0d:0:b0:50f:be7b:923a with SMTP id
 d75a77b69052e-519e890f9bfmr5827961cf.9.1781866326641; Fri, 19 Jun 2026
 03:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-21-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-21-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 19 Jun 2026 11:51:29 +0100
X-Gm-Features: AVVi8Cf7maLTmO8Ms_Jrooo0n7Lq-o--etDJs7TRVCXqEuhsxAt-xpYkzSdEOcg
Message-ID: <CA+EHjTxOYWNeZ=2Atxn0iGQTOskR+Y3uiujWEOOfGLGcWadoUw@mail.gmail.com>
Subject: Re: [PATCH v8 21/46] KVM: guest_memfd: Zero page while getting pfn
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

On Fri, 19 Jun 2026 at 01:31, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Ackerley Tng <ackerleytng@google.com>
>
> Move the folio initialization logic from kvm_gmem_get_pfn() into
> __kvm_gmem_get_pfn() to also zero pages if the page is to be used in
> kvm_gmem_populate().
>
> With in-place conversion, the existing data in a guest_memfd page can be
> populated into guest memory through platform-specific ioctls.
>
> Without first zeroing the page obtained using __kvm_gmem_get_pfn(), it
> might contain uninitialized host memory, which would leak to the guest if
> the populate completes.
>
> guest_memfd pages are zeroed at most once in the page's entire lifetime
> with guest_memfd, and that is tracked using the uptodate flag.
>
> Zeroing the page in __kvm_gmem_get_pfn() is chosen over zeroing in
> kvm_gmem_get_folio() since other flows, such as a future write() syscall,
> can get a page, write to the page and then set page uptodate without
> zeroing.
>
> This aligns with the concept of zeroing before first use - the other place
> where zeroing happens is in kvm_gmem_fault_user_mapping().
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad
> ---
>  virt/kvm/guest_memfd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 90bc1a26512b6..86c9f5b0863cb 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -1137,6 +1137,11 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
>                 return ERR_PTR(-EHWPOISON);
>         }
>
> +       if (!folio_test_uptodate(folio)) {
> +               clear_highpage(folio_page(folio, 0));
> +               folio_mark_uptodate(folio);
> +       }
> +
>         *pfn = folio_file_pfn(folio, index);
>         if (max_order)
>                 *max_order = 0;
> @@ -1166,11 +1171,6 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>                 goto out;
>         }
>
> -       if (!folio_test_uptodate(folio)) {
> -               clear_highpage(folio_page(folio, 0));
> -               folio_mark_uptodate(folio);
> -       }
> -
>         if (kvm_gmem_is_private_mem(inode, index))
>                 r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
