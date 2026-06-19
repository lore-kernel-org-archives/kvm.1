Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B87376469
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781866008; cv=pass; b=W869ANlDI9yG3L2hurAvR4BAph2eHukFCZYj3Qz8xcG6lR/qmiint2EQgGfTdrq5lG34eJsTSG8MOARzi6tNUxcbMypfVOmXkDePEoaHMRXkzfODsu7Eg6TKEnmDcm5XWyab7hgW76HPYOfabd+DINupoRHWpR6dOAiR014h5z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781866008; c=relaxed/simple;
	bh=GBE1TgSby7J232lUKGK26nn+IlCCdnbJXDX5316EbVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUJtah4/Gkw6xSZ3x2U5hbN/kqPIVa526jzsx0pbvCZNvsT7oQBorgiPO0DzPnnC4rZfLWa/501ItgCQrA7k6FatTLpYwXoS3eGPu+7TEcq82jCkCPNMVHRNQqgJhgCzR3grVTDrobuNFGA8QV8DKscLwqrIU3JQEP/wcOrT2fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U75CQJbP; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U75CQJbP"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51765531803so231981cf.0
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 03:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781866005; cv=none;
        d=google.com; s=arc-20260327;
        b=hMj4NpTGCg/iQTH5vn2LYeuP/4dXJbY9u4wQ0MgzFbQdvWPosA4Rn7VrX/i/J7Pz3M
         YEyR9eiZ1Asqx5+Q7sCb1MEsE+jXK6zkeDw+boV88LQVPsdpashZ/ti67LgFUJH6i8+Z
         FRPLSs8AXog9BmeC7KPX7Z0AMUadegHF6/R1vI75YoiBNW5tIuMtW7x3UCokhqCKTRdN
         lCwBeW9wwuxxFXNZedZVnJphK6yxK7HRQhq8t7EnwR654Onn8zxWHf15RbxPNXM9OtSa
         qxuP31S2pIPFoWmK0SgNLFspjnQyRKKnngoyETory/cACkhbZQKzRb/EVSYAmvTk/Wqn
         sC3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tqVqdR7eGLFAsCQYmX5JI1ornwlzeYgCHzhYfEkLeRM=;
        fh=MTQXvIELlfAmGcrOG1HbMIvyNSFhdbtDu+PriWRQCkU=;
        b=CgwmCey3txbMhQqlSz8lPo6VVa5VQo9VOIZjKteElMzp8o13FzIqEPQZQxbBzcAsMn
         TMZzBpWLlWJeKnAN1qCA4Zu1xOhlbfdfqaZuBcq9P4/3r1uB5Bv0MEzh1SNIkO9StS25
         ayTogAbFtPrvQm8QEO8BSgRaqLQuJr1Ko9ObKvzMu6wsqMB5lDkPxER2U/M2SEKqhuty
         RekXemBWnhLi1ITGTFC+rmBC50jXXx9aZ9iJRppAHLT8CepdscVnpUbgHVSdBavGFqxj
         O/zlQ0+h7rp0ir44H//m7SiR5wp9p9ZoHtKqMjY+p3AbfbxBn1gEQe/i+8VbounmGidF
         Edbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781866005; x=1782470805; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tqVqdR7eGLFAsCQYmX5JI1ornwlzeYgCHzhYfEkLeRM=;
        b=U75CQJbPcSNy7b3rqNQlOkqM3d9AAFeN+w9Y+3TxossyxgYPBaPMs5YymOB1n4gKgk
         fEjKdJv4RFKQtPh9n/tPH5u2C4dUPWhS8cieaRDcY9tSSgEuNkb03E9A2RLCFmqcA+kg
         Q2TvuYSvO41PrHwye+FSfBAENNXa4JUMv/GVmnCcN+r2gnmI+HXnldQVnpHtCJtcWnDN
         DXRz10L6pTc5gzwRTRJQ/yUvGtzmOFdn8T/Jsnbdo70Mu/AhB1wFr0G/NPHtXJkm8bWN
         Q9dF3ArHPxIlJy2gGqv6ryeGx+XhZ82IXM3bnz7n6pJylDpY6qQuzbseg7375z7kxqr0
         mk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781866005; x=1782470805;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tqVqdR7eGLFAsCQYmX5JI1ornwlzeYgCHzhYfEkLeRM=;
        b=O1xehKm801b/wmc3IoXGvxA6SWOKMPwgmwm57plp7UamUMWbf1yW1rO5v6fIw15ZJl
         Dvm2GqatDDXdHixOFD1iAs8W+VlreDPJz5Lgn768iw97ThWyi9ZXquGOy9Rj1/EXfhZT
         9GfEPzKqmrNgtucvcsLyjMn3w4xj2wtsY5+qgPuU44EYwKCe1NApiDHYoaMfkQbwI+G3
         WHmqZAuJ7Q9EGkN6VdfamrEnoRiGcVBwP60R5DcYJo+5dNEHkDsnZe/sh5CgqS46v42w
         e2MrKTa78Rv45s03FlQ3k468oFsx4iPD2dAUOT66+WYaysC1zZwLJBW9bqAsv1C/2y51
         arHg==
X-Forwarded-Encrypted: i=1; AFNElJ+dQZgGSzd7XBQXfMJuHY82fWtCr6Z+gPX8AGITesh7Osrkn6rkUdCkify2PKmH3DUldZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6PICBpvXTnc55xuY4HjLBjiLLgzXsEDWt6WHhOLQssIknH92L
	a3QMbebcXVMcPJZ+o7+/+0KEnKGByMVTumvOYopxQa63grh6++8LCLc9jMCMNRQieTpS1kAq/sF
	S6vrgDsrtds84alKEeEdIe0OWRDMEkTme7XLspGWx
X-Gm-Gg: AfdE7cl6T5tgHb1VAMK4A6HgFoPRbYzNcYkBzhpjeUjE8QXkQBOSBVNfKwUK+CtIVaO
	VM954Dald1CGYdX3R5i5eP6DRU+JMjfl3sR+dWuih8W7IhAYPKtfr6SUF3lhVB1PqjzbkvrH2yX
	Z9z+Qyf4/YzjfIrcRW/2uSWd1YSv5BwB/GTgydqJZoC8DtzQ/Au7j386zOnHSU0K4Z0o4Xib2nV
	CkSUCopYkxUfzjncxb5lfbn73dpMs/lLdAXbiVP2zAi21TVS6yWuQbIJMJG8Ko2R5rEYq6jmw==
X-Received: by 2002:a05:622a:1b1d:b0:516:3def:1cf4 with SMTP id
 d75a77b69052e-519e877e8c5mr5598281cf.1.1781866004326; Fri, 19 Jun 2026
 03:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-19-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-19-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 19 Jun 2026 11:46:06 +0100
X-Gm-Features: AVVi8Ccyp37Iml659Lz9n-v90nTTG1Iev3H81NTyrRm5pUpcj70uW3l4zFQ5-a4
Message-ID: <CA+EHjTxr1KrtZDakniWCF+c0E6s9_YbQ_gMVqCFnwEP3USEXXw@mail.gmail.com>
Subject: Re: [PATCH v8 19/46] KVM: guest_memfd: Use actual size for
 invalidation in kvm_gmem_release()
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
> __kvm_gmem_invalidate_begin() and __kvm_gmem_invalidate_end() actually do
> not specially handle -1ul. -1ul is used as a huge number, which legal
> indices do not exceed, and hence the invalidation works as expected.
>
> Since a later patch is going to make use of the exact range, calculate the
> size of the guest_memfd inode and use it as the end range for invalidating
> SPTEs.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  virt/kvm/guest_memfd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index d163559da0235..d72ecbfcc3144 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -366,6 +366,7 @@ static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
>
>  static int kvm_gmem_release(struct inode *inode, struct file *file)
>  {
> +       pgoff_t end = i_size_read(inode) >> PAGE_SHIFT;
>         struct gmem_file *f = file->private_data;
>         struct kvm_memory_slot *slot;
>         struct kvm *kvm = f->kvm;
> @@ -396,9 +397,9 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
>          * Zap all SPTEs pointed at by this file.  Do not free the backing
>          * memory, as its lifetime is associated with the inode, not the file.
>          */
> -       __kvm_gmem_invalidate_start(f, 0, -1ul,
> +       __kvm_gmem_invalidate_start(f, 0, end,
>                                     kvm_gmem_get_invalidate_filter(inode));
> -       __kvm_gmem_invalidate_end(f, 0, -1ul);
> +       __kvm_gmem_invalidate_end(f, 0, end);
>
>         list_del(&f->entry);
>
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
