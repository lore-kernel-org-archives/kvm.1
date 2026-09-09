Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C32E5519AA
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982065; cv=none; b=S9095JfnJU9MRiDiQpUpwtCC9mF9m0kO4CGwAhXvajGlfdnute0Uj5FyzzJLcNp84g/K7e4iMR2DcJ2Ud78X+dD8FHjTCoZSdBHynZQl5tKe0QD+mx+U+jji5yhebsTVNDkKp7jZfd0CExFWzokA6sr/PFXALVOhYa4MiWyjBHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982065; c=relaxed/simple;
	bh=I6oSFTNds+s9NlLuPGCHhSDpMwOfaItLVXSFUxWxScg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FgpauYgSiOUvYHUbhDmpY8HngB2643RjN2Y6rgB7usc2iLNSjE2NqvvVfgeI23ZrM1k5eWBRfPLYUumwBU7bhVVtOsY/ZPF56JZby8UXrpJnZj/W0rxyyZOuKyRxBAWKlUsTmDcuVzMMkTxi2wQKLEfnsy1tyFcSptE8AcrkxU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YGWOZNqp; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YGWOZNqp"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb835525b10so7324271a12.2
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 12:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788982063; x=1789586863; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UQpI0mVgouyaN7zxfkMJtMw/cMIll+7enT9xQjnBa90=;
        b=YGWOZNqpwWSQZssIceuc+Oq0o5L+c6lKtB+agZmWMsR8d/qetGqnWVeRFh0lQJ84gz
         pDZ8CZQZFrogjhqimX4URHg4pZWHrfwHoEyzjV4erCpY7q5xwZlNdhpeQ8JasYwDhN8m
         KJS178nk5QferruqTk2O3NOxdKWgpvVjxvXv5nNRJ5b31KprPsWorQ/lZtSvk9eqaq5m
         a0PpJOA+ML5GXQJzkiGHDqBnjnioM4BDLTmpYZIHcRJXhCb6OzehMs776Lk5P+iiOf3C
         1l1oquoQSd3eyJMcKDzV94VVZnSWJizkTaUY2+t7ZZlI8yVQZXTVK/2+qVSystOpz/KH
         ZXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982063; x=1789586863;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UQpI0mVgouyaN7zxfkMJtMw/cMIll+7enT9xQjnBa90=;
        b=HM22sztmEQN5EpwI2ByUa7suc91ugTAXHwepXmvOpfA5dU/e4bhX305F+kmJMisb8k
         curnI/m4BD+RpH8Z4yoa7IHwfPnAh1FpyHGp2JeZDP5Y4VKdc8DmMx9X0qFbaODN8N7N
         Z3cksXbsQNZN8Jhp2Lx0Amq/68CkyWMJK47UTPtmiGpsCPZqNDA6h9gcin9qLvCHO4Vu
         2fOuhbstBtNg8q19rsA1BHCacmBOh8CYrIww+WDb7gjE6RzbCdueEq3pYneUMtUtW0Gq
         mX2OgfBwjTy/EJjxK1ClrjqNh4npD9uYBAYWEyLaih+JZq/7HGHA/8N8GWHCROxuIeiM
         5WYw==
X-Forwarded-Encrypted: i=1; AKwUvByBRopqga6SS8qDq+H2Tzxx2PRRK/J5znuHy3NhnhlWqjRWdk4ZH8DyvbbVwK00497J3bU=@vger.kernel.org
X-Gm-Message-State: AFuF++l2DME3/czeAYyNJeBD9H/YLMnrbT67/DNr6fRbf8HNF35RWays
	uBK2nP6mLdKhwqwnSnz+z7obS3T+AQY9LuXwjshltMVhVibq1+0TNPx33LsT2Zju/nEsPg04gRH
	sR3hp4w==
X-Received: from pfbmt7.prod.google.com ([2002:a05:6a00:6e67:b0:869:6fdc:2a86])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9e4e:b0:3d3:ae40:51e0
 with SMTP id adf61e73a8af0-3da3a045196mr58708633637.20.1788982063138; Wed, 09
 Sep 2026 12:27:43 -0700 (PDT)
Date: Wed, 9 Sep 2026 12:27:42 -0700
In-Reply-To: <daa3875e-420d-4de5-9a1f-8c4138a1dbd8@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904004342.3162959-1-seanjc@google.com> <20260904004342.3162959-2-seanjc@google.com>
 <daa3875e-420d-4de5-9a1f-8c4138a1dbd8@kernel.org>
Message-ID: <aqGzLkjuQn5ALdYi@google.com>
Subject: Re: [PATCH v3 1/4] KVM: guest_memfd: Gracefully handle xarray errors
 when binding a memslot
From: Sean Christopherson <seanjc@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Dennis Tighe <dtighe@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 07, 2026, David Hildenbrand (Arm) wrote:
> On 9/4/26 02:43, Sean Christopherson wrote:
> > If inserting a memslot into a guest_memfd's bindings xarray fails,
> > propagate the error back to the caller, i.e. fail memslot creation as well.
> > Signalling success and continuing on with memslot creation results in
> > use-after-free, as the guest_memfd instance will remain reachable via the
> > memslot after the file is freed (kvm_gmem_release() won't nullify the file
> > pointer due to lack of a valid binding).
> > 
> > Opportunistically WARN and reject binding if KVM_MEMSLOT_GMEM_ONLY is
> > already set, partly to guard against goofs elsewhere, but mostly so that
> > KVM doesn't need to worry about clobbering flags when unwinding on failure.
> > 
> > Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
> > Cc: stable@vger.kernel.org
> > Reported-by: Stefan Teodorescu <fane@google.com>
> > Reported-by: Dennis Tighe <dtighe@google.com>
> > Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/all/20260823135031.4F6DC1F000E9%40smtp.kernel.org
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  virt/kvm/guest_memfd.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index b596486d184c..0b48e9a775aa 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -612,10 +612,14 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> >  	struct inode *inode;
> >  	struct file *file;
> >  	int r = -EINVAL;
> > +	void *xar;
> >  
> >  	BUILD_BUG_ON(sizeof(gpa_t) != sizeof(offset));
> >  	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
> >  
> > +	if (WARN_ON_ONCE(slot->flags & KVM_MEMSLOT_GMEM_ONLY))
> > +		return -EINVAL;
> > +
> >  	file = fget(fd);
> >  	if (!file)
> >  		return -EBADF;
> > @@ -654,7 +658,15 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> >  	if (kvm_gmem_supports_mmap(inode))
> >  		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
> >  
> > -	xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
> > +	xar = xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
> > +
> > +	r = xa_is_err(xar) ? xa_err(xar) : 0;
> 
> 
> r = xa_err(xar);
> 
> Should be sufficient, right?

Yes.  I didn't like relying on what I thought were internal xarray details, but
I missed that xa_err() itself checks xa_is_err().
 
> mm/memremap.c:pagemap_range() uses that and just avoids the intermediate xar
> value completely.
> 
> r = xa_err(xa_store_range(...);

Ya, it's ugly, but I do think it's less ugly than the intermediate xar.

	r = xa_err(xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL));
