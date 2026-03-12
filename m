Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9DF1D555
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 00:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773276392; cv=none; b=TVTyHXEgbfqbt4AR0JLv+IC1dcCzhQrajuo40INJ9vpEk1Zs+Iul4ujbWamKyQhrmcYQ4Wa6vGn36i2/otkSTW4LOWPK6IfqtQCdqYJGlVNQKH+p3kyHvrVx1R/HzJFjPNdSrBaxIozVRzCOOV1cO8hvfGmatp2QJKFkYBQdfUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773276392; c=relaxed/simple;
	bh=k+OMvBaKqjMs5h2T5BpFDOCJMnSBk/gTUU9E3vPFuVs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=msZRoi1g+7YuwRizfIwqcH/gAr2KzKdVd3ShtZzmXmyfnhyIm+c97KHsIkEvozOe2RGJ371Oju+lrgpwg93zA9qHbxCaMWv9dmihNnHcGs9Cke58uzFqjwzpMIrpPI3Xia8u4J/i2i3Mhd7OyqDPUVnrLxhynP/yyq8TJlE1MLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=euiUWFn6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="euiUWFn6"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae4f27033cso4412725ad.3
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 17:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773276389; x=1773881189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lsBEEmQ4QEyMQKvOuCt8YoNJx778DkMri6fYDa3ahb0=;
        b=euiUWFn6mgzfNj9xuhHwdPw9NkO60+EZY8Oshfz75QBI1NRJ3EZj54pL4Mcu9zgkwd
         71EgIMEdyE0G9d6hVHVMqRAc1olzh9WnUSbaKFtopaDBxX2ijRCNQu5thhE6jMb9HIO6
         2kXR0ZXnucU1W3L8epTSslD39oiGFBbOf/+njxAnoeWRsUhUy7NxnOm4BrnHN7S1RkZv
         83EtdX0e4v2yV+BV8Tgxow2pr8HNklI9dw6+VEg8NhuXuMxoj+urhw9AkyJtZ4HBH8Ns
         hFpVV76OAMhDfBgNq+H6g12jo6p2wAdAktltQVVxFhb/GtGk9AyExgHDWr2llVo88pUi
         r57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773276389; x=1773881189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lsBEEmQ4QEyMQKvOuCt8YoNJx778DkMri6fYDa3ahb0=;
        b=B/pXFSNrjiTTmhVI6RgjiMBYKs/46ow8+Jm8gS5TuBjevuYJrIywsktEi+MgP7Kz8h
         sQwrXPgBY0YpAdMMr15WPT7oWVPB9n9mivrgh4mnU36Ygf2j5PB8I0kydURfyXDL5jV+
         8Q9RkNeI+DRZacg8/MNcMauOp0hsv8exdy7ff275PmbI/b9sVbFJPWsIIYC3rEok8G/s
         rXheslJrd5LGYZDuyzJdR5kb9jrbflzUantohAi0jG2C/APvyKHpvKopyz9s8T+I6/aZ
         jNWXF4iTY/jwfkJ5l16UGAaH1FpAZLPYqUAGqw6d8hOIJuviFXoJaLc6b6x5ZMr78ERT
         NABA==
X-Forwarded-Encrypted: i=1; AJvYcCWGc5H5dmOSY+ayxggLDAhTuAZ5YUKjy419X+faIkp7EaQtWrZOhomNt2JtEWGBu3nZmts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0wSmkDUb3adUIhcwdAOezTGLyTmAgghkecw+FC83Qg+mxrRnB
	eKnwBkZm8BQW7uBuQWMn/d5ErCYjfhEkpH9Jv/XfGG6fvOCZr5TtqR9JuznWJyY0kxHBJdFvztG
	2/ZATSA==
X-Received: from plgo7.prod.google.com ([2002:a17:902:d4c7:b0:2ae:a8cf:e820])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:18b:b0:2ae:456d:b836
 with SMTP id d9443c01a7336-2aeae8f4d8bmr43372785ad.47.1773276388915; Wed, 11
 Mar 2026 17:46:28 -0700 (PDT)
Date: Wed, 11 Mar 2026 17:46:27 -0700
In-Reply-To: <20251114151828.98165-2-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251114151828.98165-1-kalyazin@amazon.com> <20251114151828.98165-2-kalyazin@amazon.com>
Message-ID: <abIM43oUcfIYMnBc@google.com>
Subject: Re: [PATCH v7 1/2] KVM: guest_memfd: add generic population via write
From: Sean Christopherson <seanjc@google.com>
To: Nikita Kalyazin <kalyazin@amazon.co.uk>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "david@kernel.org" <david@kernel.org>, 
	"jthoughton@google.com" <jthoughton@google.com>, "ackerleytng@google.com" <ackerleytng@google.com>, 
	"vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com" <jackmanb@google.com>, 
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, Jack Thomson <jackabt@amazon.co.uk>, 
	Takahiro Itazuri <itazur@amazon.co.uk>, Derek Manwaring <derekmn@amazon.com>, 
	Marco Cali <xmarcalx@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 14, 2025, Nikita Kalyazin wrote:
> ---
>  Documentation/virt/kvm/api.rst |  2 ++
>  include/linux/kvm_host.h       |  2 +-
>  include/uapi/linux/kvm.h       |  1 +
>  virt/kvm/guest_memfd.c         | 52 ++++++++++++++++++++++++++++++++++
>  4 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 57061fa29e6a..9541e95fc2ed 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6448,6 +6448,8 @@ specified via KVM_CREATE_GUEST_MEMFD.  Currently defined flags:
>                                 without INIT_SHARED will be marked private).
>                                 Shared memory can be faulted into host userspace
>                                 page tables. Private memory cannot.
> +  GUEST_MEMFD_FLAG_WRITE       Enable using write() on the guest_memfd file
> +                               descriptor.

Not the greatest place for it due to limited space, but the page alignment and
shared restrictions should be documented, and this seems to be the best spot.
And whatever we do on a partial copy also needs to be documented.  E.g.

  GUEST_MEMFD_FLAG_WRITE       Enable using write() on the guest_memfd file
                               descriptor.  The start and size of the write
                               must be page aligned, and all pages must be in
                               a SHARED state.  If the full buffer cannot be
                               copied for a given page, <something happens>.

> @@ -421,6 +423,53 @@ void kvm_gmem_init(struct module *module)
>  	kvm_gmem_fops.owner = module;
>  }
>  
> +static bool kvm_gmem_supports_write(struct inode *inode)
> +{
> +	const u64 flags = (u64)inode->i_private;
> +
> +	return flags & GUEST_MEMFD_FLAG_WRITE;
> +}
> +
> +static int kvm_gmem_write_begin(const struct kiocb *kiocb,
> +				struct address_space *mapping,
> +				loff_t pos, unsigned int len,
> +				struct folio **folio, void **fsdata)
> +{
> +	struct inode *inode = file_inode(kiocb->ki_filp);
> +
> +	if (!kvm_gmem_supports_write(inode))

Eh, no need for a helper, especially since flags is now easier to get at:

	if (!(GMEM_I(inode)->flags | GUEST_MEMFD_FLAG_WRITE))
		return -ENODEV;

I also think we should leave ourselves a safety net for in-place conversion, and
WARN if the gmem instance isn't INIT_SHARED:

	if (WARN_ON_ONCE(!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED)))
		return -EBUSY;

That will also provide a good place to actually verify the memory is shared once
in-place conversion comes along.

> +		return -ENODEV;
> +
> +	if (pos + len > i_size_read(inode))
> +		return -EINVAL;
> +
> +	if (!IS_ALIGNED(pos, PAGE_SIZE) || !IS_ALIGNED(len, PAGE_SIZE))
> +		return -EINVAL;
> +
> +	*folio = kvm_gmem_get_folio(inode, pos >> PAGE_SHIFT);
> +	if (IS_ERR(*folio))
> +		return PTR_ERR(*folio);
> +
> +	return 0;
> +}
> +
> +static int kvm_gmem_write_end(const struct kiocb *kiocb,
> +			      struct address_space *mapping,
> +			      loff_t pos, unsigned int len,
> +			      unsigned int copied,
> +			      struct folio *folio, void *fsdata)
> +{
> +	if (!folio_test_uptodate(folio)) {
> +		folio_zero_range(folio, copied, len - copied);

Hmm, do we actually want to zero and silently ignore the failure?  Given the
intended use case, silently failing here would be a terrible outcome.  Would it
makes sense to instead do this?

	if (len != copied)
		return -EFAULT;

	if (!folio_test_uptodate(folio))
		folio_mark_uptodate(folio);

	folio_unlock(folio);
	folio_put(folio);

	return copied;

That will cause generic_perform_write() to report -EFAULT if no pages were written,
or IIUC, return the position of the last _full_ page that was written.  Then in
the unlikely scenario userspace wants to retry, they can retry starting at the
page that was partially written.  That seems like what VMMs generally would want,
not silent failure.
