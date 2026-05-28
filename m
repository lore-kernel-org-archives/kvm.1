Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A128B33372A
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000950; cv=pass; b=hVYpL9RrASmy/F1onZGR8axERMSeLrXxU5k5QsZ2/ttCU9iexWqrg8ZGDrAa0XGIEcxEu3GlRX0eavLcbigXt7zm41MGlA+eI5dVSeRSbNzDlvs2VI6Z8sGyiGY8YSl5gsTakm9qEHt05nvLOso4KEd/fKwH0pzYfWEyUMqCLuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000950; c=relaxed/simple;
	bh=1uLy69djA2PRxy6hP4Nolsa5RjbotLrqLZyiH0FXDE8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZhMRU7pjEAz8ZRykJkLqHR47SiRlnZRsQ3T5peuc1sYGO0fy3T5fD91k8X10hSQ+T7lrb1qykbUMycboKxM3MkvNPfDX8a7rX6OCYKn4I2dD7D9XMJDhefyKe79v8k3xm/ePNxP24I1E8pxhYuiAoxWjEEYiYAz8nCM+aM4t84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jVcj+o4+; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jVcj+o4+"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-134ac81c445so24011610c88.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 13:42:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780000949; cv=none;
        d=google.com; s=arc-20240605;
        b=kgf1aevF9aTLy2NTPtu/RfBU+8zM2gsXJEelyVADu6AK/HtEky7M/mLX40hE83T6UK
         QCs1OevzYL8xsUJw9Mf9I/ux68+Vs2z6RgDJ4n2E5j8yc3MaSvuakFiK6nbHCRBY1D6i
         RyKyEaeYTtu7UlT1Q7OfrxNeGLVObtX1KUBLuHWAvbAMuz5d9RkhBN4cJETkYCgixYzX
         XyodP0j+iqHAiCcCt2fmfXNOrTTEh47L3WeGHt2UsSvNwJtrplV+qKxRUPeNrcAEjosb
         iyuPJH1nc39UjXnQYhzXSSRWHwvM8eP4KQVVDtoVMcnL0sATrgFnXyGGcOG/HlV7r3hA
         xeWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=4mfCtyWI4ijglngNmmktGYEAhOd/SX85n2/kwApF6ZA=;
        fh=6+Y59ngkcqvp+KHilIlOLr2ZdeoM5AX4PWbAVy8/Z28=;
        b=SRgzg8Th8FIQooVFj5IYr3J+STCO4Z0tzMWFV5T6A5b5ovibm0XW7dhqpLL4rv0Ovn
         Om4XYxiGFKg4C+0QPi3anuYyEzBcYD3qqkD/vwgfG873dVeMOi4UvmR/+v4cH7uDZ51k
         7g+z1bHrPGQmdxzBU0Ui0cI1Pqqe8MtUk9V9Y04diyc/ox6b7lLWwz4B+RKlJ9D9NPZB
         CxE0f89cEc15EAhF8RrArykWQrlZaoEl3vMuTnFqckbVd3NMEyWdtOSwNGULwGJMYMxv
         xfx+OsYJOj7DFfoNuQ/HhNz4Dza58tXZAInMeSK38HfT3p/hpmdwZglYee6IQfWvw6yV
         htcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780000949; x=1780605749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4mfCtyWI4ijglngNmmktGYEAhOd/SX85n2/kwApF6ZA=;
        b=jVcj+o4+VNK1dZhExFQvTH8Wqb0En3oXQYq3BSPwGVgUdIHbuX4/SmP/VrmK6yeO1g
         XWCPNimS+HsjApLNN3Un8pxTJCVH32/wf4vOyYY1LJz0FJkbcKeY5AZ12fs6EBtf4QXv
         175v7Q8nuJlXjh/PnquXlquR+IeXNvivw9QZnLk7m+GufN9hhaGeQImU6oCR1P08RZUV
         N1uji4XJYjjZXxZiV4xRIp1IxoBKINTyDoYbd4JDhpXWug+Nk5r4Ei7wwUjtTGGS/+l9
         dRbllJCmSGHLtAlB7DLC4l1RFvlKdUkX1tcg4/ue7HiN6l/d2QHoESLBGEyyAZHULwnr
         ZaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780000949; x=1780605749;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mfCtyWI4ijglngNmmktGYEAhOd/SX85n2/kwApF6ZA=;
        b=CXD1WSKwSaQFowirAl0s8TlRzxr5OBcP7qQpdyBVu1zGrwKXwimRjQkNOBp6+yp6lY
         rocsrkdXuoj/yJgOhqb/mtm3mHZPXpjbOMBhI/wXK8ODH6Mht8Deb/kMo4Jtp9sE+u4l
         oJuQbWIo/YGPYUJ3D9m6F9PT6HHyxkfx90u2Ebzn8b7OmNrw6Am4G2wrX8Qiy2kWdZAJ
         d9oYQLsW8Gt3ymC0qLdcW9ylN/RtI+/7Bdgg05zigldbTFk3jfGNl/RvkZjvxKQ9DMF7
         MJ43yqub4qbBLtRNpAogIzqBfk+ZpRFzRBCGeLeYVJl6HwJcsO+TRZstQRdyhNJQS8zs
         x5cg==
X-Forwarded-Encrypted: i=1; AFNElJ+M5A8Hr5X2cLtsoJNqNcugf4Irnql7043xWbamDCteWil/Z3BUek+BbCy75QK6d1qDkI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrPRdrGAWptIN/CibpiXj+quTg9R+5sfxjaHSHNDWGCeWbrwxy
	bXqHdGxKNe0aeo81h3ySn/I9mNBk1Jj5F711wnXojk5cRL67hqR4lbbP0fv+cdiei/T7tiWDH5R
	GhipEzoUgqNetFIW3eHQPt2Yfl5LxdV7WMC4mJxGe
X-Gm-Gg: Acq92OEa9mCnM44HGt0hpSZWJWBXyBD8ReC13T/pJ8Eu9rMKaob31xPzLzw/jETIb6U
	cbHwauP+29beAf3yBvVq2OtCVz9d56kf3AboDHjq8X9KdNcIEYFAJ6fiu/WcQ3BWiL35I0L1ibr
	GIhDekWgwKqyAXjw2w51KPBEKAFcXCYr9mbhCLeizqRlUteaOIuDKWRCLkXhIb4cqfqZZiNB5gk
	lUABU5y7K/BW83WtluqcD2eeKAa47pemwokULGfbgm8ZvtTP9WWt3bFNL3jmkeZjUy8687Sv2qS
	nvvtkBeFXGnIIhUpFu3b4GJEJyJsKxWkpQzOioSUomavpLnaZTs4Ule1eoVuxbmGEhW3l+L8rWH
	9XnLgxZeZMRPUEoI=
X-Received: by 2002:a05:7022:ba1:b0:12d:b7e5:a691 with SMTP id
 a92af1059eb24-137ae971b78mr9437c88.7.1780000948054; Thu, 28 May 2026 13:42:28
 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 13:42:27 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 13:42:27 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ahiB9uD1aeWt4H7P@google.com>
References: <20260528021117.107984-1-seanjc@google.com> <20260528021117.107984-2-seanjc@google.com>
 <CAEvNRgFAt2NSbK91Oc95iKA7eLo-3Pw==2X0PQvbonhVM_bZ7Q@mail.gmail.com> <ahiB9uD1aeWt4H7P@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 28 May 2026 13:42:27 -0700
X-Gm-Features: AVHnY4IwlS0YMiF4UToOh8zPVfaTCmk0Ygiu9sF2xreqfYQGTsCADl48ToIXJ40
Message-ID: <CAEvNRgF4TT3Tax5Dju-w4TyUS71dOcWDjn=S69yFV5dTFDnm+Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] KVM: guest_memfd: Treat memslot binding
 offset+size as unsigned values
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Thu, May 28, 2026, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>>
>> >
>> > [...snip...]
>> >
>> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> > index bf9659a7b0f6..a1cb72e66288 100644
>> > --- a/virt/kvm/guest_memfd.c
>> > +++ b/virt/kvm/guest_memfd.c
>> > @@ -640,15 +640,16 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
>> >  }
>> >
>> >  int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
>> > -		  unsigned int fd, loff_t offset)
>> > +		  unsigned int fd, uoff_t offset)
>> >  {
>> > -	loff_t size = slot->npages << PAGE_SHIFT;
>> > +	uoff_t size = slot->npages << PAGE_SHIFT;
>>
>> I get why uoff_t is chosen for byte offset, but why is uoff_t also
>> picked for size, over size_t?
>
> Because size describes the max offset.
>
>> Not trying to nitpick, guest_memfd deals with lots of sizes, byte and
>> page offsets so I'd like to derive a mental model for using these types
>> in functions.
>
> Earlier you asked what I meant by "same domain", and I forgot to respond.  What
> I meant by "domain" is that both "size" and "offset" operate in the "number of
> bytes in the file" domain, and so should use the same type.
>
> E.g. size_t isn't literally just for sizes, it's also used when comparing against
> a size, e.g.
>
>   $ git grep "size_t i;" | wc -l
>   476
>
> Changing all of those to uoff_t because their effectively offsets, not sizes,
> would be nonsensical.
>

Got it, so the takeaway is that local variables' type (especially if
only used in one case) should mostly align with what it's being compared
with.

>> >  	unsigned long start, end;
>> >  	struct gmem_file *f;
>> >  	struct inode *inode;
>> >  	struct file *file;
>> >  	int r = -EINVAL;
>> >
>> > +	BUILD_BUG_ON(sizeof(gpa_t) != sizeof(offset));
>> >  	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
>> >
>>
>> I never knew this was meant to show the concept/typing relationship
>> between gpa_t and byte offset, gfn_t and page offset. Can we add a
>> comment to explain the presence of BUILD_BUG_ON()?
>
> Eh, I'd honestly rather not.  I agree that on the whole, the kernel tends to be
> far too stingy with comments.  However, at some point a baseline of knowledge is
> required.  For me, understanding trunctation falls well below that line.  It
> does require the reader to know that guest_memfd bindings are gpa:offset, but
> that too is core/basic knowledge that the reader needs to have to make any sense
> of this code.
>

I agree that both truncation and knowing that guest_memfd bindings are
gpa:offset are both below the line, the part that's new is using
BUILD_BUG_ON() to remind people of the binding. Is this BUILD_BUG_ON()
also the part that strictly requires guest_memfd to be 64-bit only?

>> Also, what's the rationale for picking BUILD_BUG_ON() over
>> static_assert()?
>
> https://lore.kernel.org/all/aI05DvQlMWJXewUi@google.com
>

This is helpful, thanks!

>> static_assert() could be placed outside block scope which makes this
>> relationship declaration more general/global. Putting it in the function
>> makes it seem local (seems to suggest trying to assert some guard for just
>> this function).
>
> Well, yeah, because it is local.  _This_ code relies on the sizes being the same,
> otherwise we'd have to deal with potential truncation, whereas overall KVM does
> NOT.  The purpose of adding asserts like this is to document an assumption and
> guard against future breakage.
>

I saw the gpa:offset and gfn:page_offset relationships as local to
guest_memfd as a whole rather than just this function.

Either way good to know for next time!

> Just because we _can_ put the assertion in a global location doesn't mean we
> should.
>
> KVM does use static_assert().  But without exception (at least in x86, haven't
> checked other architectures), every usage is still co-located with the exact code
> that relies on the assumption that's guarded by the assertion.
