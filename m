Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0034F2E739A
	for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784991541; cv=pass; b=oQxVSTV2KjKKrCwIdEqhimgWIoiLHMSX9hBTLh7668MpSKZr6gmrTIgffnrDJLFricV6T3Cy0WU6aTHjuXZHbxNkEAcGLfNGEpNT4ZouH1kXeZmSv+cVSGnEhBJnBEvkXPP9k8qxpfQ3mlnZdBMtDMhdewLx+bmBlKv+AXlisyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784991541; c=relaxed/simple;
	bh=OhLw9KAQr2cxrwXOPV6Wnw/YPuj+tJK6SULHnYzlWy4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHEEGWpiJtpwMwhwyzsqd92Ep36Kn0tsddBCUgZwP297sHF8k61p7Z+Y4H2XFJbJSS4Mq+9C2qK0JGtSEnoSZkQp1WAKgbmcmCp2dvqCTxALjwni5LTxk1G3jVh/r+GDVDQtGPSVi4RgdGUDErGR+fTSq0EEmXwx1YLzQNMXrI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jBJk5/JY; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jBJk5/JY"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15b33f7b23so212961766b.3
        for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 07:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784991538; cv=none;
        d=google.com; s=arc-20260327;
        b=pD7tZLSLpXSa1JpDviY8Hwr5RtNF6lE6R7CZLIqncPaICGxYXseSdVXyMJ4aPTw1iL
         jND503luv7ySYnsFG22a+KIl7tYJrPo5u1+OmEjtoJyPLf44hJTtUYoCtLBy4K3PN6Z/
         JBibj/bVEUhoIiYm3USgrZlWYQ5Qr0AlMQZdo/7gqvvpEDYuJ3P9pFi36i82AWMH4Sm5
         9MAeWigFvesSR2N0QUJCusRsU7cx38lX4AXfJqLVx47eTUsSnw6XZ8R+SkhlhK/2UO1G
         pdSe3na22SMDREH/OnbkPuKZK/N0DkXViZ/gW5ucWC5nQKjKvoixjzZDxINTrHVmCVLd
         Gfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Dh7lS9c7BNT8/ZTQdZVeuNIGg5F3470ONB2MveeV5mw=;
        fh=rwrYbFwf24hPID3nkl5yfZOxQTZWd//7Gp7H1M5VNFc=;
        b=XrNe2sLAfZqQESypoQ4Qhr5Q+6JXGyWWlvczwFHoh+gaZp1oEWw111TSkSMiY97sga
         UUSzJyw4zPBL6XGUNJWbv7wJgWkMjuhglK1+sBA+TCpPISjcPSJUbRnJFUcMXOOi0WNc
         uXXYm/fBo6nh3VvFscAjs9uSvFQxVnqz7THL2FsQV14/dj6+hIkF/fSPOP4y88Lt2wVF
         FCSMLW5Ri7d3E5EcqwxcqUhbN4yMOvYH3kTLe7tIstObGEsQnJFNUz95yF4z5WXh8DvP
         XHV9roDzI37jcfKFZ/htP16AhUGxMDy2+Oad5AJzsSIMDgJQVVyNelcVkVmHRwkdY1O0
         zRog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784991538; x=1785596338; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dh7lS9c7BNT8/ZTQdZVeuNIGg5F3470ONB2MveeV5mw=;
        b=jBJk5/JY8S1Tb4/bd2NrMV/PSAPRoxGO4mZPCspVEUs5/lF7GGoTgUn3LONDM6btup
         GfdIr6A9IWiex4rdyjvhs90hh7qjC2tAQvcsbLtOEywWBHF6ghPs6TvteP0iUgtgnlrO
         jWDkl2ECbfihfjVWZkVKxVr3jFZAnbn1Lio4ziYBd5oe1nwif4DcIKW3zLpaHLG3h5dO
         szpTJ84WRXiszxiOiVZ7RcR4ZP58Ns77Tf43rL+wc5KqhepcdiYuEntzkbxt9luZfp+m
         3RCc1uzj9Ay3pzD+kvJX/ueiAk7IqyRNEGRdcnJA8U/oum1KoK9m/oJN8diiBogsSiL3
         2Fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784991538; x=1785596338;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dh7lS9c7BNT8/ZTQdZVeuNIGg5F3470ONB2MveeV5mw=;
        b=pq08zHvl+BguicPj+41JnG7LFALkyJT+GCvuJ4OBnJ2yZhJi9pJ7Ktmyw/XdPDNRP9
         Hky/e63m0YzsE8x/toGSTYT+JIM2CGwenTOCsy5TQGv46vc563iosGkQpaA771VG6oWF
         Rs3G+xuHtdAKJYLKsMI58q+PM0LcI8CmGVKZjhok832GLzxGxGwl/DDqwce8hETqIx1t
         GBF4TLozHf7F62LolC/UdLgx1WOlAee2duoh7YQSB5BhDem/9qW/9B4jyzPgBirpZQz9
         gnbBW1KCwFct+zvjgmdF1XtTlIQf+JGySoVkU3Fjvb4O7jSh0d2A5ykz1apaYwuKCh0/
         yPQg==
X-Gm-Message-State: AOJu0Ywl1+wjldIhRJADwwynNTM11fVJo5e8yznbZHEJDT8izzbEm/yV
	2kl4UhxHlcQ3kQtX/sKL35u7U1YWZN405jsbMhLaOTKUEReGUEcbpVwaETkatew18D40savzzBC
	y2OT62f+nfPKs55kVe0XwmO/e2KqibQ3P4kbMM3AI
X-Gm-Gg: AR+sD11WxIWS7l3ChPENhFWoRFFlAwzmD27qJSfIpwDfcmkhT/jXL03RvDR3xLSJj4Y
	JNOMvHSlzwWy6g0lrG51+F+evTI1fIfOtAai2dh3Lz4wqEfDnW/Ara62TPkdcBJOvt8inK60Tjl
	2M1ZCQMQpyhkrtqSoCf4BYCykVH8ZqB6zZJh38NsL+t3j/e5SvsmC2IpBPcVULxW1ESZnNG8C8a
	BDFE2W8r8AJ6hllrvrs1jHWqbhAy/BZTPBUrShSNg7Q2MnLktAbTPN13qiJ8RKG4vyTPNapwMIf
	lkFYD44mMGzWZrIhHukwYYMB4TvK
X-Received: by 2002:a17:907:8746:b0:c1c:4d59:2b03 with SMTP id
 a640c23a62f3a-c1f1eabea23mr81001466b.3.1784991537562; Sat, 25 Jul 2026
 07:58:57 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 25 Jul 2026 07:58:53 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 25 Jul 2026 07:58:53 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260723210811.72720-6-seanjc@google.com>
References: <20260723210811.72720-1-seanjc@google.com> <20260723210811.72720-6-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 25 Jul 2026 07:58:53 -0700
X-Gm-Features: AUfX_my6ZTQzxI9vip_3rLhXnQVWg-TnFZ4bwKL61tFgFhXnUOLAX8siv5n-juA
Message-ID: <CAEvNRgF1LrogGaU62DgYHu4Fq7h3eGvPTn4+5e_V5DdNYoYRtA@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] KVM: guest_memfd: Add helpers to query SHARED vs.
 PRIVATE for a given page
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <fuad.tabba@linux.dev>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Add helpers to check if a given page in a guest_memfd instance is PRIVATE
> versus SHARED, and use the "is shared" helper instead of an open-coded
> equivalent in the user pagefault handler.  In addition to the immediate
> usage, providing an "is private" helper will allow cleaning up the so
> called prepare() code, and eventually will be heavily used once in-place
> conversion support comes along.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  virt/kvm/guest_memfd.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 2effff582f50..e9d61410e5fb 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -60,6 +60,16 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
>  	return gfn - slot->base_gfn + slot->gmem.pgoff;
>  }
>
> +static bool kvm_gmem_is_private_mem(struct inode *inode, pgoff_t index)
> +{
> +	return !(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED);
> +}
> +
> +static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
> +{
> +	return !kvm_gmem_is_private_mem(inode, index);
> +}
> +

Works well for the conversions series, thanks!

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>  static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>  				    pgoff_t index, struct folio *folio)
>  {
> @@ -397,7 +407,7 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>  	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
>  		return VM_FAULT_SIGBUS;
>
> -	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
> +	if (!kvm_gmem_is_shared_mem(inode, vmf->pgoff))
>  		return VM_FAULT_SIGBUS;
>
>  	folio = kvm_gmem_get_folio(inode, vmf->pgoff);
> --
> 2.55.0.229.g6434b31f56-goog
