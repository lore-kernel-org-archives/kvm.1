Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4723DA5D5
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366535; cv=none; b=TMhxGL4GkSzxBm7PZ2GZ/OIeTwO3t98bb1JJCQUFnUqqLVZk/jX9FqUA+HAIBa3t/2WBC42fSCrZmfshBM4qh1hfbxriDBSDLdF1WGHAHA2rsx83MwMCAj0hFpYI4IopMY2+py8W/xxzIOdwdwXLmT5HkB1wFSZ/xvTcZvqmCS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366535; c=relaxed/simple;
	bh=ABQ7rLH8LdDNKLwT5rPObn5whIed+p2i6tm3SaUf8iY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=beOE+piEs2SsTFHbdZGpr/QzZ4g9RZqvGT2FSvhjwd1GY0sOSyUc5lLgVC9Uh3jVi9puBgKdlgyYFLUNGmxt1qorswNjb9+n2f+0yGVI4q3uxG780GBlO3zu/+KiMMYOCDeJoJNqoBbM/mKMB3WvpOS7n/T9rVrEL9xBGi+xwE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mkyFgf6O; arc=none smtp.client-ip=209.85.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mkyFgf6O"
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6a178080182so2460110a12.2
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 05:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786366531; x=1786971331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CXS0NEGBTZuSyd76xEU6892riTmJKR4JCJe3n8Ek3/c=;
        b=mkyFgf6OstEjft3LFMCf2Z1UPWA62qixCLrVzFKnL3VOZ4snyBqAd91ihQovAoqTlR
         x2JOAVhCswdUAtepDmox9I6VTV+u2JdIqipclcJp8ZgMh4Pm2ht6leYZlS5QAveC2qTF
         mpuqfJXiLRRoVCNlLiApxA3H7mBeAvUPQRDi9UR7b3bH+eKikqV7TMg1qa7NlWK5ilM2
         5tLmNjZdwnMDNFTIO5UrJFKKEPO1tC8T0lqnE2qwOfZJKRARyt3oz7BPgjkrV1ZvaQW0
         b1kXfU5q772YfU9EejfJxeJcyDms0QLt0p94oDVINepYith+CJG63G1UHSiVP31kWtog
         1d4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786366531; x=1786971331;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CXS0NEGBTZuSyd76xEU6892riTmJKR4JCJe3n8Ek3/c=;
        b=ZAh4bmNmy9su7+5xzk3sU4tlbUV3Wrtm9WkkHRsZjHkfDFJcRJvuyLA1xEiFyMykzn
         qqLQXHbLFHogXNVsOygsXIHi86bIpEfzbCIug7WWmb0EhuK78ANDrnaRMtMmiTXCxQ1T
         ut4Jasb19eKW7cuZpYPBOfctnaRiB6/i+FU1qt3BzTiJP0lfdqDFXKAhfC4+VcfsGi9D
         39MQJVf+9C74FyO1V0nxwnNp4lNhjeWjLvzLYMM6ZfPwWBLhV/kPaNwT6HCBTO9VS8FH
         3lRu0ED27TRZEd7ssRiyPrrDOSGyGz3LB5ci8xPSC7Jw/lSbD1AHzbbDeIdQuJk4Vtwz
         VZhQ==
X-Gm-Message-State: AOJu0Yy09aMJweLgn5AtOalZJXiORL3KGt1Iikaq32MmOZlSarVp0q+x
	pdL9xl8UyL4XOWVSqBW0ZMy1qvo44pj9OS7bOBylXpU+WzjrknRDrRNIc17OZF6c+uoEg0w1FKH
	eymflnMsJmFYYP2Hiyg==
X-Received: from edeu12-n1.prod.google.com ([2002:a05:6402:a6cc:10b0:6a1:f089:88d7])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:21cc:b0:6a1:88e:90c1 with SMTP id 4fb4d7f45d1cf-6a355da6287mr898442a12.9.1786366531239;
 Mon, 10 Aug 2026 05:55:31 -0700 (PDT)
Date: Mon, 10 Aug 2026 12:55:30 +0000
In-Reply-To: <CAEvNRgGDhcu2LUqhwVtGJSUo4uXQHrGOYRDaM2qzPTO4LX=jKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-4-tarunsahu@google.com> <20260728122655.17C791F00A3A@smtp.kernel.org>
 <CAEvNRgGDhcu2LUqhwVtGJSUo4uXQHrGOYRDaM2qzPTO4LX=jKQ@mail.gmail.com>
Message-ID: <9huza4qu8799.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 03/11] KVM: Export kvm_uevent_notify_vm_create()
From: tarunsahu@google.com
To: Ackerley Tng <ackerleytng@google.com>, sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Ackerley Tng <ackerleytng@google.com> writes:

> sashiko-bot@kernel.org writes:
>
>> Thank you for your contribution! Sashiko AI review found 1 potential iss=
ue(s) to consider:
>> - [Low] The patch claims to export `kvm_uevent_notify_vm_create()` but f=
ails to include the `EXPORT_SYMBOL_GPL()` or `EXPORT_SYMBOL_FOR_KVM_INTERNA=
L()` macro.
>> --
>>
>> --- Patch [3]: [PATCH v4 03/11] KVM: Export kvm_uevent_notify_vm_create(=
) ---
>> commit 5e642ea16f0d267e622a352de60bfe397ecf79df
>> Author: Tarun Sahu <tarunsahu@google.com>
>>
>> KVM: Export kvm_uevent_notify_vm_create()
>>
>> This commit exposes the kvm_uevent_notify_vm_create function to allow
>> triggering KVM event notifications during VM creation.
>>
>> [ ... ]
>>
>>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>>> --- a/virt/kvm/kvm_main.c
>>> +++ b/virt/kvm/kvm_main.c
>>> @@ -6348,6 +6348,11 @@ static void kvm_uevent_notify_change(unsigned in=
t type, struct kvm *kvm)
>>>  	kfree(env);
>>>  }
>>>
>>> +void kvm_uevent_notify_vm_create(struct kvm *kvm)
>>> +{
>>> +	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
>>> +}
>>
>> [Severity: Low]
>> The commit message mentions exporting this function, but is it missing a=
n
>> EXPORT_SYMBOL_GPL or EXPORT_SYMBOL_FOR_KVM_INTERNAL declaration?
>>
>> Without the macro, won't dynamically loaded architecture-specific module=
s
>> like kvm-intel.ko hit undefined symbol linking errors when they try to
>> call it?
>>
>
> I'm not 100% sure about the use of EXPORT_SYMBOL... here but usually I
> compile kvm as a module to try and catch these types of linking
> issues. Maybe Sean will have a better method/explanation for this.

The Intention is just to make it global to kvm module files. it is only
used in kvm module so need to use EXPORT symbol as Sean also mentioned.
>
> This brings about another question I have though. How does luo work if
> the new kernel's deserialization of the persisted data structures
> depends on a module? Like in this case, KVM is a module, if KVM isn't
> loaded in the new kernel, do the data structures stick around until KVM
> is loaded? Or is KVM required to be loaded as a module in the new
> kernel?

If kvm module is not loaded then guest_memfd_luo/kvm_luo handler will
also not be registered. So luo_finish call will leak this memory and not
be freed. This is aligned with LUO design.

I have raised the saperate thread with LUO list to discuss if LUO_CORE
should throw a warning in such cases. [1]

[1] https://lore.kernel.org/all/9huzecg6ta6h.fsf@tarunix.c.googlers.com/

~Tarun
>
>> --
>> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728121138.1=
103610-1-tarunsahu@google.com?part=3D3
