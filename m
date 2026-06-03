Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E064C384CF7
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499490; cv=pass; b=PWI4IFeWvBNE0ETcOFMAm86ESI9bliqx8ummPQDEAuqaAmiegkou/P+9c9dzBRz8nAJZJzNt96tcm4LHhEH71nQK4LPJeJffQLF5hyiAztQivwEhel7HdkR+eLNO8B/P03UU26hNBuHHYxQOse/qsXS6/vuM8vgncpY4OeQf4+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499490; c=relaxed/simple;
	bh=A5/DR5/7Aqb950zyW+Q+1QnR65FBpmWLo26en9cyZgI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjTzv5iyc5EM5qZJ2mlGfEyHHP+8U4gY/kaPqsqSPPSzahFxuceClTtKnNV6n0kIQbpP8/Desi6GA+FoigCHv89XPMwGPfltwQhgSngEN0TBIVEGdsMddFXkiwKevz72Zh3y0X+Oi7XzCfP8jes6JztAL5jGOUmAN5dBouzlorw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uwzXhKgw; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uwzXhKgw"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1370417c01cso12916156c88.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 08:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780499488; cv=none;
        d=google.com; s=arc-20240605;
        b=Sbgs1V5f64+AVInzlBRUES6H0akYtsCzgTtP3MA8VN/ZW7GFI5dKD8obIk3GuayrUv
         StWAaat5khVSU2bKnAMEn+M5fIL/UPibtR+C9jmmLClh2xsjoG9KERLxjbi3tb1MWgWX
         8/5I0jeJWotFK1Z4oMoRDTLfInpX4Zlj8d+dLry9boJgOVDi2MrBDocWuy4r7Y2St2gB
         I0u6vAWaZCZbU56idkebkziI0QYO7L2N1iVurQlDm6kk5qFgZXkGw5yfVwvaQjsKvkC4
         6+x1VgPNeL4HrMSArAL19JcjQf4c7LH+SBDedBwwkN+2AgUz7kJ4nxfVhaQ13jAqam+J
         qpDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=eYo/RoO8Ab6uoruJUbfVcTXqfmLKCBjLy9NVhPXoQhc=;
        fh=JmKNrRT8nM+tkV9xyciaff9VBazzJF3oElGJw8WBhu8=;
        b=M9Col3eb/marEykNqGMycXwak2592Ma/nrJt1cpX9xhJwZ5TqT1YNnYTyPu0qYFLBO
         7ECw2IKH96l/4mjXDx+ZOr++6bgUDoZNIx0AGWEKm1pkbX9TNcbtPy1Sg+nwBP63zR3Y
         iBRq+MSBBNQ+WnTolVUEy4GK5amrnB3s7i+ut6QgZC3n6vfJutW2cRcZ8VyWs/5V564O
         lTCsZBtSrrERi29qGsIGNs3Z1gavY6/8uqZCSVEv70nX349r7Ltl+cNRSjmQWo8UFJK9
         ms9k381ew++S2rRFd9nA7Hn/NaDQTPt9I5kZDmVDW8kE8/Q44aHAxjpPFCmzLK8sPhE4
         YOHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780499488; x=1781104288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eYo/RoO8Ab6uoruJUbfVcTXqfmLKCBjLy9NVhPXoQhc=;
        b=uwzXhKgw4Q9cVGDu1BLLP1s6tyK3zDeCGJEESyXK/1kYpZM0g0xM6yZTHm/fLaUsAe
         jJQ9mG4Y7C389Lzu5LswdltqzLdXCjmzhZ95yZ0/y/GS0Q7lPzzmV2ryINPPkmRp3i3u
         RHn/DtBiaD8vgXwPhbH9Agg/PfAS9gv71xBHhLycaNkHWgduIGu77m178L2nsmYKhgSl
         WcIulHEXsZC3a+uUVRU7iz7AekQN2MavMNQJ16sIN6gcqcE3Q30gtzRDxG6DGpoIQqhZ
         PMmyFpvL/XL0wl8RXq5AR9lTtZbiEUoKxX98Iuwfh/q9wVj5LMFeP0WHPsox6ESL92NJ
         ng+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499488; x=1781104288;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYo/RoO8Ab6uoruJUbfVcTXqfmLKCBjLy9NVhPXoQhc=;
        b=Or8Be1Gsg57hCnU058RyR2wsC5IsJpX4XLq/b4UavTVPtG64p+W0kh+bkKMWejdWSf
         EPji0EyLylxZzqDEHJJQScNiYDaw4nybzTVrjtzyeJaJyvYnXgBpRrrAlE8MwzYHCo8G
         CJ1YuAZD87txDfhn/xXEWYYvjpyPd2ia2Qo4HmGidRgxhaYLW2ag5seqCECRAEXuwPRC
         e2zEtWVeXbnU+cX/kqq1xIyipqUyBo8AwKfUeZbMecZEB+CzG2sJRfGn0twU7nMDS5o/
         xa3s4jPs4fAIizO1VsDwXH5rBLUbJfFqZwYd2XZXE5bDLnOZFZwrCKN8vErGT4cZeTcd
         gwvQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fyhRxLhzdzdahDM5SGKP/HScxZuuKIbc8R6XezlJJqavbovVmkdEqmjwBBl+zbc50FHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2fm1HjP6PudGsj5H5PL3i/OnalkXS7OT4f0PkvULO1Jy0tSqM
	hnrplxHNtcfTvRqaCNenzogAncEulgp7Df8xHK0ckDF1i2daM3Xf9rSBXQr/YT1NK2wLcGmNmx2
	ZNcLoBGN2VHuFgRkAsGmc/NKGEDNoU/hYDDXea0wg
X-Gm-Gg: Acq92OHccHgc92zZBgbH9qnKLTk8DFCHdfrOhEa8zOArTjtlqMHOZjx02HUoJ1CcMFi
	5BxBHgjo8o4gj3L+9zv1iA40qRGH/IamlG/+eOndJBAKPXSPO+2+FLOO61pT32FAUEn5qCDVsgV
	07hZe3xa75TjZgTJ6VFztCL1ymntA4jRtTOrWBDtaedp02vKCzw4hhEZz3H6YqFQfCavDH5Qelj
	YbuDT5JPfN3s1mql/K0l05s+viA1AY20sUg6uf7zNJq4IFbtJtvFU596r78sVuPXNBsHCaD8hKl
	fnCaMz1fRA09v0hcuFMZzCPzGCNREbZaOe/KOVz9cLN84Yv95Q==
X-Received: by 2002:a05:701b:4245:10b0:137:f020:30e with SMTP id
 a92af1059eb24-137f6b5dbf5mr1189909c88.17.1780499487370; Wed, 03 Jun 2026
 08:11:27 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 08:11:26 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 08:11:26 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aiATMXdOtg1T8o4D@yzhao56-desk.sh.intel.com>
References: <aRsIstNXu0Bl0oID@yzhao56-desk.sh.intel.com> <CAEvNRgH6YGzp4OHF7hMQEtVodAe1pVg1F9UZWwLiu19-KNgJVQ@mail.gmail.com>
 <aiATMXdOtg1T8o4D@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 3 Jun 2026 08:11:26 -0700
X-Gm-Features: AVHnY4IyYUIHeWudpu-mcfXc55H8YGR7XAK0t7Sp1IffJl64v4IejMlaT8XAJpg
Message-ID: <CAEvNRgE8YG3L-SVJJmwkU8R37S-FoQrW_tdsEWhwZO+AJ0OUAQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: guest_memfd: Elaborate on how release() vs.
 get_pfn() is safe against UAF
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vannapurve@google.com
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

> On Tue, Jun 02, 2026 at 05:40:00PM -0700, Ackerley Tng wrote:
>> Yan Zhao <yan.y.zhao@intel.com> writes:
>>
>> Coming here from https://lore.kernel.org/all/ahn6qysOGfa74A2E@google.com/.
>>
>> > On Thu, Nov 13, 2025 at 03:22:29PM -0800, Sean Christopherson wrote:
>> >> Add more context and information to the comment in kvm_gmem_release() that
>> >> explains why there's no synchronization on RCU _or_ kvm->srcu.  Point (b)
>> >> from commit 67b43038ce14 ("KVM: guest_memfd: Remove RCU-protected attribute
>> >> from slot->gmem.file")
>> >>
>> >>       b) kvm->srcu ensures that kvm_gmem_unbind() and freeing of a memslot
>> >>          occur after the memslot is no longer visible to kvm_gmem_get_pfn().
>> >>
>> >> is especially difficult to fully grok, particularly in light of commit
>> >> ae431059e75d ("KVM: guest_memfd: Remove bindings on memslot deletion when
>> >> gmem is dying"), which addressed a race between unbind() and release().
>> > As mentioned in commit ae431059e75d ("KVM: guest_memfd: Remove bindings on
>> > memslot deletion when gmem is dying"), unbind() and release() are mutually
>> > exclusive, i.e., both protected by slots_lock, mentioning "race" here is
>> > confusing. So, that commit addressed the mishandling in unbind() after
>> > kvm_gmem_get_file() returning NULL?
>> >
>>
>> I agree that the use of the word "race" here is odd since both unbind
>> and release() are mutually exclusive and protected by slots_lock.
>>
>> Looking at ae431059e75d again, there are really 3 changes:
>>
>> 1. Refactoring out __kvm_gmem_unbind(), which is mostly about setting
>>    bindings in the xarray to NULL and setting slot->gmem.file to NULL,
>> 2. Checking that if slot->gmem.file is NULL, skip unbinding
>> 3. Checking that if kvm_gmem_get_file() returns NULL, just unbind
>>    without taking filemap_invalidate_lock().
>>
>> (2.) is explained in the comment
>>
>> 	/*
>> 	 * Nothing to do if the underlying file was _already_ closed, as
>> 	 * kvm_gmem_release() invalidates and nullifies all bindings.
>> 	 */
>>
>> The real fix is in (3.), I think? Could you explain how
>> kvm_gmem_get_file() works? Why would the file be dying with the
>> slots_lock making the unbind and release mutually exclusive?
> Below is my understanding:
>

Thanks for explaining!

> kvm_gmem_unbind() is invoked under slots_lock.
> kvm_gmem_release() holds slots_lock before it accesses any slot and sets
> slot->gmem.file to NULL.
>
> When kvm_gmem_get_file() returns NULL, it could be
> 1) kvm_gmem_release() is to be invoked soon.
> 2) kvm_gmem_release() is being invoked, before holding slots_lock.
> 3) kvm_gmem_release() is being invoked, holding slots_lock.
> 4) kvm_gmem_release() is being invoked, after releasing slots_lock.
> 5) kvm_gmem_release() has been invoked and completed.
>
> So, when kvm_gmem_unbind() finds slot->gmem.file != NULL while
> kvm_gmem_get_file() returns NULL, it could only be 1) or 2). And at

To clarify, 3, 4, 5 are not possible because kvm_gmem_unbind() is called
with slots_lock held, right?

> that point,
> the remaining user of the slot->gmem.file should only be kvm_gmem_release().
>
> For both 1) and 2), kvm_gmem_unbind() and kvm_gmem_release() can't operate on
> f->bindings simultaneously. kvm_gmem_unbind() needs to remove the slot from
> slot->gmem.file's binding. Otherwise, after kvm_gmem_unbind() returns, the slot
> will be deleted and kvm_gmem_release() will later hold slots_lock and cause
> use-after-free.

Thanks, this makes sense. The purpose of using kvm_gmem_get_file() is
that if the file is _being_ closed, as stated in the comment in
kvm_gmem_unbind(), kvm_gmem_get_file() would find the refcount to be 0
and return NULL. (The missing part for me was that _being_ closed leads
to kvm_gmem_get_file() finding a 0 refcount.)


Annotating all of these:

> void kvm_gmem_unbind(struct kvm_memory_slot *slot)
> {
> 	/*
> 	 * Nothing to do if the underlying file was _already_ closed, as
> 	 * kvm_gmem_release() invalidates and nullifies all bindings.
> 	 */
>

Above comment rephrased: !slot->gmem.file means kvm_gmem_release() had
already taken slots_lock, iterated all bindings and set slot->gmem.file
to NULL, and dropped slots_lock.

>
> 	if (!slot->gmem.file)
> 		return;
>

If we get here, we know for sure that slot->gmem.file is valid (not
freed) and can be dereferenced safely. We know this because
kvm_gmem_release() is the place that frees slot->gmem.file, and if there
was any chance of slot->gmem.file being freed, slot->gmem.file would
have been NULL-ed first.

Hence we can also safely proceed to do
filemap_invalidate_lock(slot->gmem.file->f_mapping), but as described in
ae431059e75d, file->f_mapping is not under KVM's purview. A future
change could NULL out file->f_mapping before .release() is called, for
example, and break the assumption that gmem.file->f_mapping is still
valid. Hence, rely on taking a reference on gmem.file from slot instead,
which is within KVM's control.

> 	CLASS(gmem_get_file, file)(slot);
>

If we do get the reference, we're good and we can take
filemap_invalidate_lock() and then unbind.

> 	/*
> 	 * However, if the file is _being_ closed, then the bindings need to be

If we don't get the reference, then the file is _being_ closed, so the
file's refcount is already 0, but kvm_gmem_release() hasn't yet been
called.

Later, when kvm_gmem_release() is called, it will iterate bindings and
then dereference slot. Hence, kvm_gmem_release() must not see the slot -
the slot must be removed from bindings. Hence we must unbind.

Unbinding without taking filemap_invalidate_lock() is fine since if
!file, we're sure there's only one last user of file -
kvm_gmem_release(), and kvm_gmem_release() is locked out by slots_lock.

> 	 * removed as kvm_gmem_release() might not run until after the memslot
> 	 * is freed.  Note, modifying the bindings is safe even though the file
> 	 * is dying as kvm_gmem_release() nullifies slot->gmem.file under
> 	 * slots_lock, and only puts its reference to KVM after destroying all
> 	 * bindings.  I.e. reaching this point means kvm_gmem_release() hasn't
> 	 * yet destroyed the bindings or freed the gmem_file, and can't do so
> 	 * until the caller drops slots_lock.
> 	 */
> 	if (!file) {
> 		__kvm_gmem_unbind(slot, slot->gmem.file->private_data);
> 		return;
> 	}
>

If we did get the reference, this is the most straightforward case. Take
the filemap_invalidate_lock(), unbind.

> 	filemap_invalidate_lock(file->f_mapping);
> 	__kvm_gmem_unbind(slot, file->private_data);
> 	filemap_invalidate_unlock(file->f_mapping);
> }
