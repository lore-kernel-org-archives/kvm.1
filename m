Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793472457;
	b=1KpgQ99rQlIl5VXkoWoibDe+jV7rknHO8dm+nUMMUWfnpWgBhLOVHkuTP0+urQSaykAS
	 on0HmSOCgmWvHLT44EKJ+VZZJJ/l0Rd7zGgzUIFIl3+rFlR+8DmSeMs9TOR6oamfl4oHG
	 GP7YQwEbRQX9hrS5lj6GTVENp9dMypQQoVt4eiT+YTqRGLm6SHGtEiX4gACVjt/uvuyMW
	 a8Ym1Igl278LWtcYATzm+LfUBnYMGZsZP1EOGWcPDFzVAguoxICwJKTivnek/sa4HfWBK
	 NbamqLdCZuKe86feVsRd0avgmlAy4IHIDpfEDDyRub+iQrHomaFbI6BgIAqEd/fj/XA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793472457;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=vkmwKYf8zQRpeat83U5XIB8sH7pruLs+dStmkRuX/bo=;
	b=l9qtLdRjsqw/sE4+IGbawJg9CdAqW7Lt6UcgP26qYLzBSM8YGj6wGCe7S4KojESdgmG+
	 FF/Kfz62WUUTX9rbFhJG1Jpv1EX/8s+qPTTb4XU6plx2iI79y07gnNYq9fzkQrsnVs974
	 DugSwUWbgvssveq4hPeovgP9HY6plWZFS+ZRq/R7PVN4XcKykt+4LMgrfitgO6tHJTkD6
	 JP642uu3Yi7NPzEIF+WgQ7nfbkWL+jPcfAPjWBM9JZ7H33Fio6ra3bwVaVnPQr6o2SUPg
	 sxrpzF9usqSy28t2uzL1T5KK5v/QUyJGasmarbhyYFzc+QEurix89WOPD4Zz6fUIGfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SEGFxxbt;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rgrcU8Lu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED05E606A31A
	for <kvm@vger.kernel.org>; Sat, 31 Oct 2026 18:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED05E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SEGFxxbt;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rgrcU8Lu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793472455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vkmwKYf8zQRpeat83U5XIB8sH7pruLs+dStmkRuX/bo=;
	b=SEGFxxbtDYA3Dh20ShZiGezANQRMftL2WGJ2FdJsn7RGSFPxKofjSBiru01/kZYjMavG5L
	Z5VUHsiVWtqPw8/uEMr6cwpninSIQxNuEIRQca1jevwo7j4Cx459FTMpnSop06qs24Psea
	CRAWeeJxXuJgdN/zKPe0X+Bf5domTvE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-iWFbYH_pNfa8pinDfpvEtw-1; Sat, 31 Oct 2026 14:47:33 -0400
X-MC-Unique: iWFbYH_pNfa8pinDfpvEtw-1
X-Mimecast-MFC-AGG-ID: iWFbYH_pNfa8pinDfpvEtw_1793472452
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e17d30a79so934683f8f.3
        for <kvm@vger.kernel.org>; Sat, 31 Oct 2026 11:47:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793472452; cv=none;
        d=google.com; s=arc-20260327;
        b=kEtsRxK9tyzlTPLPXV0nKXRWDyCYv0HqU5ktmb3tg267vyYMpyxaio6uIOfkPAo1up
         /YHkR508KmjbJ42NFgiR6tzCuFk+9VJ9IENTg7i8ERwAXO8iKelzRJHoPMKOpQxUv1yh
         vYEQBMfoUUsEswqKXmHnKxNNY3E0GQqUQgDqcy7k6K5nNoJoeDenbaB/H8J24crlehS7
         WVxJTmpySUxc/WWFNAE/HaIepYtDeUJRTwqzetzUwL0nfn9wWSwMO+lx94sTegiaOPPE
         ikyJ2P8bwHWhiZeStnlpJZG/+PUk8TSmbjw4gHg8USCZPQWiYqGqE1lqoIb/5cjcCUj6
         Rv7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vkmwKYf8zQRpeat83U5XIB8sH7pruLs+dStmkRuX/bo=;
        fh=XDxdcdx+xw9hxgnK2SR+zf4mabnhAWI1tHOmQwBlZWg=;
        b=rLyOpb0u/+VMiGXzUh+2G89S3R4aCm9IF+G9UYtqTUrwTF0tO7N0nNfc9JTzJlKClK
         kHy8yR6hRPcrpfAUydky3AncMm670GV6H6FdDMBqlycBI9CmBASGEKqwSrb0jlJzwwMY
         gcedo1OtzF1KWSNE1vt5XuqQ8cTybkhLnJVTdSAb3l2QEb5ZN+OCh1a9uml4kndwXWgc
         4V6ip2wFId4JB5RMiH4t4huEVpdYUajh+02vomKwsXGnFhSVPaSG2DYup3K4cQvamybh
         G4PixQfKYzNNgkxjJBzC2oFYXaAiin7tyzI5gjcbRxXeEcuNSsab/8+6KgMTQ1ca9HS2
         QMPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793472452; x=1794077252; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vkmwKYf8zQRpeat83U5XIB8sH7pruLs+dStmkRuX/bo=;
        b=rgrcU8LuZ/aUTGXonYVT8EYo/DbYN7xdSW4HZsjM1uMp/pMZWstNcwn9CpQur2eZkB
         iOjIsTZkAAPdESEQCaeU8e33i31U8ZR6o9yE42T7vZBteYhHO7W5TbYzKbpFsTAZPwiO
         Uk5LK+RitXQsr1zdzmjpeSTQJNDb8C7Iog5dddm0zzW9JyeDGXCNxuLcoaxy8Hsesq46
         7WQPaSrMfNGjaum5gnFaw2kkWwjSRudTFe7+2ktVCv9EMkU2YMImC24QGWorXDgNw9oZ
         9rRP18njy8mP9jM1GlCAvo5MkqK+kvxchXAiDMyXkcTYJnmsqXIMVshiUflSnaO6DAyU
         tr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793472452; x=1794077252;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vkmwKYf8zQRpeat83U5XIB8sH7pruLs+dStmkRuX/bo=;
        b=G+X9PYHvDFyD+CqzFLsfbOpzv97lJW33SsO9CocmgmCclBS7cQicO5cUV/zJrgZfXx
         psDxgyxLxPXejPyQ2mEc89sT/otwYipMnYHiD0GPoN/5ehglhaWtKsI0bozRS0/bKN47
         RnYumzQmjqdBnNVKSyJF+RMLPaP3B2QfWnrJOjW8EEcEvKD61NyvR6orrCj4/Q7gITVg
         mzUWppYbpzBVAE3eslU/HRrv8TK7TFmkjDwH4t9cZO0BEZzWwgKeam9YmeZk6KUBCb+d
         wVa6S0tuDhuGdcyaubRQtC5rF7q7nyak0cbpAr2VmyA8kqsihNntcO3pDnWKKy6tgdaB
         hp3A==
X-Forwarded-Encrypted: i=1; AKwUvBzToKepsrDqenHMNAatlkyQC8JXNLuoxL7uuAEF96SgG220g7wRN8As0fvVwF64Dfda8aM=@vger.kernel.org
X-Gm-Message-State: AFq9FYINLyj9gyOP89aoXsY945FzrNSY4CL21rOrdUJu4MmpRo54sO8k
	lkAqeIJ2t2RjiplIGpNWhuFSDRcFVD1DmiAWZh0zx2Z9HTmYWU+BBJWRoAGrG1jbvDupkH/Uuix
	uT3/I76ZymQasQPqo0oUZNAutgfZnBT77b79b9WDaRStJMVtYjI+7dGqchMVY+bi3sSu6jjhWyd
	9hzPp+MjkZ4DWCCVjwLcIsEs2IPB9D3CRi3gRCZ8A=
X-Gm-Gg: AYBFou1IE0PCR0wpTMoD7/Ev7r4NCqvwIVH0kenz5QJzwHJSG25ZrrDUnyqMVkcfSO2
	y6J9qsN2Lua3CLrZchB7yL8ao7OOZopDQOy2eBAwQr00DS1hzO9rUMKfgFAci/UqiVoeKYl9j8x
	GILjr1Oa1OgWFzJi/gq80XWuo5lu1aDoeVwmOXT7NYZWvQuzCIuUJf2PCgMGV6sg/b3n9NBmh9L
	EMHSKWlbdlg76hiCFMf1coEMGle/fMaFO8XjCJB76ktjoNyqoHQRAI6KM8b
X-Received: by 2002:a05:6000:310d:b0:48a:f59f:8b70 with SMTP id ffacd0b85a97d-48e6e4f8c71mr13594321f8f.46.1793472452528;
        Sat, 31 Oct 2026 11:47:32 -0700 (PDT)
X-Received: by 2002:a05:6000:310d:b0:48a:f59f:8b70 with SMTP id
 ffacd0b85a97d-48e6e4f8c71mr13594299f8f.46.1793472452215; Sat, 31 Oct 2026
 11:47:32 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030183604.3e8e373c@fangorn>
In-Reply-To: <20261030183604.3e8e373c@fangorn>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 31 Oct 2026 19:47:20 +0100
X-Gm-Features: AclHuK_9y-00d5m76qSsFcMjJfOv9KZyclM-AmIVcVyuVMir0oD899CQbDHFHvQ
Message-ID: <CABgObfYRHc0ELLdqm2gF+9y=ef5871TVPy4JoGy1XwPChQhsCw@mail.gmail.com>
Subject: Re: [PATCH] KVM: reject VMA straddling the dirty ring on mmap
To: Rik van Riel <riel@surriel.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm <kvm@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

Il ven 30 ott 2026, 23:36 Rik van Riel <riel@surriel.com> ha scritto:
>
> kvm_vcpu_mmap only tests the VMA's first and last page against the
> dirty-ring interval, in order to prevent a MAP_PRIVATE VMA from
> getting mapped into the dirty ring, breaking dirty tracking.
>
> A VMA that starts before the ring and ends after it has neither
> endpoint inside, so the check passes even though the
> mapping covers the ring.
>
> Getting this wrong is observable from host userspace: the VMM
> (QEMU) mmaps the vCPU fd to reach the dirty ring, and a MAP_PRIVATE
> mapping that spans the ring succeeds even though it covers the ring.
> Faulting one instantiates a private CoW copy instead of the shared
> ring page. The guest's dirty-ring writes then land in a page the
> VMM never sees, silently breaking dirty-page tracking.

This is deep in "if it hurts don't do it" territory. Unless I am
missing something huge, it's at best a decent code cleanup. "Silently
breaking" is overselling by a lot...

> Fix by testing interval overlap instead of endpoint membership.
>
> Tested by creating a VM with a 16-page dirty ring. Mmap the
> VCPU fd covering pgoff 0...199 MAP_PRIVATE, then fault a
> page inside the ring. Succeeds before this patch, -EINVAL after.

I probably would have applied it, but the commit message and
especially the comment in AI English made me change my mind quickly.

You've been working on Linux for 30 years, I would have expected a
higher standard; and if this is the kind of commit in Meta's
8000-patch stash, I'm not sure I want to look at the rest...

Paolo

> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  virt/kvm/kvm_main.c | 10 +++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4175,9 +4175,15 @@ static const struct vm_operations_struct kvm_vcpu_vm_ops = {
>  static int kvm_vcpu_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>         struct kvm_vcpu *vcpu = file->private_data;
> +       struct kvm *kvm = vcpu->kvm;
>         unsigned long pages = vma_pages(vma);
> +       unsigned long ring_start = KVM_DIRTY_LOG_PAGE_OFFSET;
> +       unsigned long ring_end = ring_start + kvm->dirty_ring_size / PAGE_SIZE;
>
> -       if ((kvm_page_in_dirty_ring(vcpu->kvm, vma->vm_pgoff) ||
> -            kvm_page_in_dirty_ring(vcpu->kvm, vma->vm_pgoff + pages - 1)) &&
> +       /*
> +        * An overlapping VMA is rejected when private or executable: a CoW
> +        * fault hides guest writes from the VMM.
> +        */
> +       if (vma->vm_pgoff < ring_end && vma->vm_pgoff + pages > ring_start &&
>             ((vma->vm_flags & VM_EXEC) || !(vma->vm_flags & VM_SHARED)))
>                 return -EINVAL;
>
>

