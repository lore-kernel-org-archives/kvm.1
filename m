Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D39234964
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780447205; cv=pass; b=swsDIJEAehjlAQnRHiL/8aW4k4k/9WfjjGNfK7T+YsxKK9egalOV0PXRau06Ug6+uP7pjDy5VxV34NLPFD4fC4LTWV4wTVSjzrcH4HM5n1OhyaUTCn2DxR8xxSNKNbBkA9afYA4OPpNQvP2H0xpejVvyILgkmE8nG+fMeH0Mzls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780447205; c=relaxed/simple;
	bh=3sNtc6eQ1Ns7iy/Nd2rlLDwjcg4/B1Mndbudgjem6q0=;
	h=From:In-Reply-To:MIME-Version:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=kX434lyLvlL3FhUW7pt8ty+77VfUn13dwMq2xNVQ7saas/t/U9HuAmquCQ7GwMZ85kcJ2X/zpFUJGWH7IoBf/sqZGdKu0YEpl7I8asSw5pymBr03Aj5bI8feRjGqL93tfQ3bhNurVCDJV15Vv0X/6uSSaO82uzfkPUzRpuVblrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nazM3oGt; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nazM3oGt"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-13721dfd471so11779108c88.1
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 17:40:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780447202; cv=none;
        d=google.com; s=arc-20240605;
        b=Kmdrxeili5CnT5pRHFyXiOKWgyZJhCoe+kwyE64HaY5tZPl3/ocqJoLiwHFyaRo8MS
         hq2OKJLyzWWVyAhzShQ+cQkhpCjjHn8xZ+BHA2U1/zsjMUX7PuDsjvCe2dIe2GdTOyPe
         i6P9k31wNm7FvXYd+7G90U4AGAjx+FLgv891FmzIMEqmk3bb2IIEB21NmaeNCfYdbnVK
         99lQejF18Gwx6OcWAfy3Q6JPcl7/sH2fHux2YcwZV72wU4qc/4uH//OYBAJfqUnsFXqb
         jiOL+9Pq3joHD4XaCUl+FjUFZWnFr0gDW+VsdO0+ZtjUNvHupJUF8IJiSGIWvDN6KdX4
         hSDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:from
         :dkim-signature;
        bh=FBazScWYa0AGy+EWsjUXFcaR4jQyLk2q2x7uPLoOiyU=;
        fh=b+sPoGDPBLuDvSaSAUKA5eHfpVgl8MdqB5RsvTcOiJE=;
        b=fsGG9bTkbNYF8vsogjLo4on3LhrQUVXmiTMyzeEmjmz92WCj4b+xsuH4QNz9IFWqNE
         0ri/MxX+PeKE4O8Q8QMVUrOrop4Ny8XTIT2KYXrEQjCvexkdirIXu4/sd//YQduJCghe
         P7AC0j2BlA+TNP4sJh7OZ/4XsiOYMj3/buwtF6kFA2mefNEEi9cbDLjGW45/7IK1P1zw
         n85Mn+JiWplKqS7nqxTghEtSRYK/O7SCrBi6ovv2WJJlROkWTIGd3a7VdDHfompR0NHu
         JE10ixheEFhmiyzG+YE4pjsSp1usO7zGEqH3rsvhZCLMdzCyLh6W/gi6c9QscriLfT7D
         jbdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780447202; x=1781052002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FBazScWYa0AGy+EWsjUXFcaR4jQyLk2q2x7uPLoOiyU=;
        b=nazM3oGteoCYi2Ahe9Xs1aDJWwMqW1oi7QqZbHxuTY2uSUuIZKnOPmE+xAcTae2WFs
         3hDIRP0VDfTSQt+kvbJqIu2GbO3ravFJHrYkOggSpemWeYX1rxdVgppnZYC4Pn1LtNM4
         qQBZxw7F4C8TOvxUjp2CYX/ZujeqRRahlOJkBSW08tr6ChNF5eC8DZ/wn4JPPqOmnwh5
         iCkcV25vFpH3+O/s53X9xPw1yLUJq506y1iDJSIT++9kRifiZMBlc3FSU/qRkygpI4LD
         W2CTt7KTnNNdWFPc1PnQjd8WpUcpKLLdD1qBkyktxQ9ng38QFzx6bzfCwHraax4SKU+z
         vC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780447202; x=1781052002;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBazScWYa0AGy+EWsjUXFcaR4jQyLk2q2x7uPLoOiyU=;
        b=AieHajbm9BlO+5TtMqJPYwQ9ZvcpkeL+mZo5GTxYXhBWzoK3nmCWtrpV5Rt9jQ+oEX
         dda8veC/VF+CZVii8jAKTqno0iLnOiVVNJPJa1aHviuaXwupNdSUCtH4DuCzW3UyKY1m
         Zp8ZqzUslyPJza/g/l+osdEo+3PYMK0FnQk74VVHNUrg1NYx/pVD8hJVgcuOKlatAGcS
         cWP0rRUIO8D9s1MI86fiCDRT+MaFtem7LxWDG9MblhVaORQqbjZq12dA/zOc9jC/UDVM
         uZ9caC/5iCOUJVPR7dpGxOlOeMDHuyB8btX3NOisl98KC5jnfELr7XqF7DTOqHdfZmBq
         87NA==
X-Forwarded-Encrypted: i=1; AFNElJ81PlkhnXstm/1S9yi9QHMPLADYjGVwottgv4Dz1wtPLeXjmvD094fRXlFBcW/9K/tEzaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNA/TC4eSx7qxV0DQ1r1Khrhh5ZdvyGgBysPRubB7UKp1Jijk4
	/n6uHCDvMmP3hHFoaZq6Wdq5Bgdv0E6vD9FzMzhnykuUqsDuBMajdqBGA0308vcLOvCVAg/cCnY
	/dj09J6igm2XH8gN1O5fTTwen3Ht+97ghV7jWiNrL
X-Gm-Gg: Acq92OG+XhstfkU7I7FlWvPy8ivI4iCH3tEchiKIfAbHDB5A/afg7qLoLPxGiZ8B6Pm
	Hqr1zhwA434VLDkXr7nYbmAJqxYxU1r7ti0k+lC6aFq0Dc6IOGW7CTUv3U9XuTWY/xP+DnKWYZC
	mSUhaGkRjx2T5gYR+eEQxXGlE2tfHD1N/79jg52Pz6p3SulINOona2E+Lj4xavrpq3BM1keIuhf
	mTpix8TbSvygYwAFor3IWVYD6dPWdyy8Y43HpogChcvUVdGXJCA+6T+J2e3yjT9r9A8PFJcOWlm
	x0MGc4vUkdBqsDJKkU8ywgq53jKdDY7qSZfW+Pedcz9G2UPJsBk64OU/vNWfTlARws5ibM4nLNm
	FTCau
X-Received: by 2002:a05:7022:44:b0:137:90d5:9530 with SMTP id
 a92af1059eb24-137f6c2d96emr383527c88.36.1780447201380; Tue, 02 Jun 2026
 17:40:01 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 17:40:00 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 17:40:00 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aRsIstNXu0Bl0oID@yzhao56-desk.sh.intel.com> (message from Yan
 Zhao on Mon, 17 Nov 2025 19:36:18 +0800)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 2 Jun 2026 17:40:00 -0700
X-Gm-Features: AVHnY4KEXLb-aWlr-GwChsZ5OrCLdsMI6_tJ2NmyD6o9z3yrrvkR05L9nb4RH9Y
Message-ID: <CAEvNRgH6YGzp4OHF7hMQEtVodAe1pVg1F9UZWwLiu19-KNgJVQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: guest_memfd: Elaborate on how release() vs.
 get_pfn() is safe against UAF
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vannapurve@google.com
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

Coming here from https://lore.kernel.org/all/ahn6qysOGfa74A2E@google.com/.

> On Thu, Nov 13, 2025 at 03:22:29PM -0800, Sean Christopherson wrote:
>> Add more context and information to the comment in kvm_gmem_release() that
>> explains why there's no synchronization on RCU _or_ kvm->srcu.  Point (b)
>> from commit 67b43038ce14 ("KVM: guest_memfd: Remove RCU-protected attribute
>> from slot->gmem.file")
>>
>>       b) kvm->srcu ensures that kvm_gmem_unbind() and freeing of a memslot
>>          occur after the memslot is no longer visible to kvm_gmem_get_pfn().
>>
>> is especially difficult to fully grok, particularly in light of commit
>> ae431059e75d ("KVM: guest_memfd: Remove bindings on memslot deletion when
>> gmem is dying"), which addressed a race between unbind() and release().
> As mentioned in commit ae431059e75d ("KVM: guest_memfd: Remove bindings on
> memslot deletion when gmem is dying"), unbind() and release() are mutually
> exclusive, i.e., both protected by slots_lock, mentioning "race" here is
> confusing. So, that commit addressed the mishandling in unbind() after
> kvm_gmem_get_file() returning NULL?
>

I agree that the use of the word "race" here is odd since both unbind
and release() are mutually exclusive and protected by slots_lock.

Looking at ae431059e75d again, there are really 3 changes:

1. Refactoring out __kvm_gmem_unbind(), which is mostly about setting
   bindings in the xarray to NULL and setting slot->gmem.file to NULL,
2. Checking that if slot->gmem.file is NULL, skip unbinding
3. Checking that if kvm_gmem_get_file() returns NULL, just unbind
   without taking filemap_invalidate_lock().

(2.) is explained in the comment

	/*
	 * Nothing to do if the underlying file was _already_ closed, as
	 * kvm_gmem_release() invalidates and nullifies all bindings.
	 */

The real fix is in (3.), I think? Could you explain how
kvm_gmem_get_file() works? Why would the file be dying with the
slots_lock making the unbind and release mutually exclusive?

>> No functional change intended.
>>
>> Cc: Yan Zhao <yan.y.zhao@intel.com>
>> Cc: Vishal Annapurve <vannapurve@google.com>
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> ---
>>  virt/kvm/guest_memfd.c | 20 ++++++++++++++------
>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index fdaea3422c30..2e09d7ec0cfc 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -338,17 +338,25 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
>>  	 * dereferencing the slot for existing bindings needs to be protected
>>  	 * against memslot updates, specifically so that unbind doesn't race
>>  	 * and free the memslot (kvm_gmem_get_file() will return NULL).
>> -	 *
>> -	 * Since .release is called only when the reference count is zero,
>> -	 * after which file_ref_get() and get_file_active() fail,
>> -	 * kvm_gmem_get_pfn() cannot be using the file concurrently.
>> -	 * file_ref_put() provides a full barrier, and get_file_active() the
>> -	 * matching acquire barrier.
>>  	 */
>
>>  	mutex_lock(&kvm->slots_lock);
>>
>>  	filemap_invalidate_lock(inode->i_mapping);
>>
>> +	/*
>> +	 * Note!  synchronize_srcu() is _not_ needed after nullifying memslot
>> +	 * bindings as slot->gmem.file cannot be set back to a non-null value
>> +	 * without the memslot first being deleted.  I.e. this relies on the
>> +	 * synchronize_srcu_expedited() in kvm_swap_active_memslots() to ensure
>> +	 * kvm_gmem_get_pfn() (which runs with kvm->srcu held for read) can't
>> +	 * grab a reference to slot->gmem.file even if the struct file object
>> +	 * is reallocated.
> Do you mean that
> as kvm_gmem_get_pfn() can't find a stale slot, it can't grab reference to stale
> slot->gmem.file, even if slot->gmem.file has been set to a different value,
> i.e., after invoking unbind(), bind() ?
>
> But I'm not sure why to put the kvm_gmem_get_pfn() relying on
> synchronize_srcu_expedited() in kvm_swap_active_memslots() in the comment of
> release().

This is a good question, I think the comment can be improved to explain
this.

> Without the guard of kvm_gmem_get_file(), kvm_gmem_get_pfn() may need to
> provide some RCU read-critial section too for release() to wait by
> synchronize_srcu()?
>
> So
> 	 * Since .release is called only when the reference count is zero,
> 	 * after which file_ref_get() and get_file_active() fail,
> is still helpful?
>
>> +	 *
>> +	 * file_ref_put() provides a full barrier, and __get_file_rcu() the
>> +	 * matching acquire barrier, to ensure that kvm_gmem_get_file() (via
>> +	 * __get_file_rcu()) sees refcount==0 or fails the "file reloaded"
>> +	 * check (file != NULL due to nullifying the file pointer here).
>> +	 */
>
>>  	xa_for_each(&f->bindings, index, slot)
>>  		WRITE_ONCE(slot->gmem.file, NULL);
>>
>>
>> base-commit: 16ec4fb4ac95d878b879192d280db2baeec43272
>> --
>> 2.52.0.rc1.455.g30608eb744-goog
>>
