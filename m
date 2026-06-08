Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5865F3D7D77
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942828; cv=none; b=J3I2h1dJSMF5GANu7vO/9Wqgxuw6N6zO2rNNXSYxmxNH3T0NmAct8QMm8Ca0q33XTT1m2ACfxHFyKbNeEMGXE1xI/5yXy+5sWgFKP1J90VkhH2jmVIbF3QbSUMX6d0+yNhNP5ZkmqlvXB3w/VsXy1GM3ff98GGNreIC0YWQNdBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942828; c=relaxed/simple;
	bh=uDlD/Bu/PQ0e61cH+SHapBI07ybnECSXHATY9NVPzQY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jNJVJOkVWeDN/IGyynQZTXBpZea4GtaerrE3IKYb1Z9lbHlyoNkNy++UTyBxKxWxZnHrr0dXgzhPOAiVCb4i/CEaMhUxN16p6H7eem4GCxmWbFloMg3OyJdY8OhOyQXLi+gVsPxWYgsnANtMXgUFA8ukLyN/zNUV++vd69zQtd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFmAgWvK; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFmAgWvK"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-beba94353acso453497466b.3
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 11:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780942823; x=1781547623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXH/4dC+kvIrN8dyPSz1oRdGYg1mvWltQA3ulgK7Yz4=;
        b=IFmAgWvKmF5siMt4mNH3q0W9blHwJYGP+OztJBkCZ7ooqeUrP5KOuidPRDa6xTnVy1
         6eydcBAEAawVeeXQgecfOAgPux4krxA/zVEC4VP8J7XqtC8pyEa2XlW3Zrpc4wYW0gER
         cR7kIp1kLXNjr+YjeWZ7AqooLzqmfyUOxtLd3jbajnSEMF3szsszWy3EizLDkvCU4G+C
         N1fiKIyPt4amNSqnUGO/Qy3gB5XhTowz+gxnFeRG0RcJ4E9QWhOXe/V9mJ/G/KKg//qr
         qL837wf1fsZw/oSNzx66DNNRL5xpnwIku3jw11XwgeByJ83KIalqQRv75G4EMwnfPt2Y
         Jy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780942823; x=1781547623;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pXH/4dC+kvIrN8dyPSz1oRdGYg1mvWltQA3ulgK7Yz4=;
        b=eBMkt3hUooka23/eJqS6V8MndmS02bJW2nN3AhKdY52xK1BHzlIGcP9b+2Wq3fofGI
         XqaJu8fKbIMaytFMH6672z2bX9k0f1LKmyz+cp+sGP0AXMeo8PEas2keFDvdJsXpEpQ4
         O8sAHtJPmhOFD0RR+hWUl2q1OWsurCMznQ/ApM0S7WOQu7w8VTqmCBVuoUQftc71PuBv
         vOK42hWDatelHm5rJaIRO4z9VGLn7ImiIrWMhDn6+TFlHI1U6wAJP1gF0n/wdzbuox6q
         IfH2NZjQVH45w1PsCc3mcZthnV0aNBrw1WyyMkvOvhOWbujLCqn1SSYdIfvlPnplvPRH
         9XUQ==
X-Gm-Message-State: AOJu0Yzk+Q/S3Rx/0Jz5XM1JQ1WyEwr4DUO8P7c88AZ99LdfB5jmH125
	2YlU07h1mucgk3hT8GbvdFjdi8GLE11PBKKd9Eyab+kcwmli1B4cnNizzX9T1UBbC07sTySFvvm
	9yIP11NYR4MCflNy+qg==
X-Received: from ejbze21.prod.google.com ([2002:a17:906:ef95:b0:bf7:f52e:7ba0])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:a70b:b0:bec:b4e3:e930 with SMTP id a640c23a62f3a-bf370477ec4mr849247466b.12.1780942822361;
 Mon, 08 Jun 2026 11:20:22 -0700 (PDT)
Date: Mon, 08 Jun 2026 18:20:21 +0000
In-Reply-To: <20260605172142.B18F51F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <48777f4749fa43d5648085dbb2037aa99c144a88.1780676742.git.tarunsahu@google.com>
 <20260605172142.B18F51F00898@smtp.kernel.org>
Message-ID: <9huz8q8oyjve.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 06/10] kvm: guest_memfd: Add support for freezing
 and unfreezing mappings
From: tarunsahu@google.com
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] A malicious tenant can inflict a cross-tenant denial-of-service =
by holding the global `kvm_gmem_freeze_srcu` read lock during massive, unbo=
unded `fallocate()` operations, blocking `kvm_gmem_freeze()` for other VMs.
> --
>
> commit 5ee5700d9538d9bd5f29f00de6d11fcc22d28ecc
> Author: Tarun Sahu <tarunsahu@google.com>
>
> kvm: guest_memfd: Add support for freezing and unfreezing mappings
>
> This commit introduces freezing and unfreezing for guest_memfd mappings t=
o
> prevent fallocate and page fault allocations during preservation. It uses=
 a
> global SRCU structure to synchronize read-side operations with
> kvm_gmem_freeze().
>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 6740ae2bf948d..b94639cdf3126 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
> [ ... ]
>> @@ -273,16 +284,30 @@ static long kvm_gmem_allocate(struct inode *inode,=
 loff_t offset, loff_t len)
>>  static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offs=
et,
>>  			       loff_t len)
>>  {
>> +	struct inode *inode =3D file_inode(file);
>>  	int ret;
>> +	int idx;
>> =20
>> -	if (!(mode & FALLOC_FL_KEEP_SIZE))
>> -		return -EOPNOTSUPP;
>> +	idx =3D srcu_read_lock(&kvm_gmem_freeze_srcu);
>> +	if (kvm_gmem_is_frozen(inode)) {
>> +		srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
>> +		return -EPERM;
>> +	}
>> =20
> [ ... ]
>> +	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len)) {
>> +		ret =3D -EINVAL;
>> +		goto out;
>> +	}
>> =20
>>  	if (mode & FALLOC_FL_PUNCH_HOLE)
>>  		ret =3D kvm_gmem_punch_hole(file_inode(file), offset, len);
>>  	else
>>  		ret =3D kvm_gmem_allocate(file_inode(file), offset, len);
>
> [Severity: High]
> Does this code allow a malicious tenant to inflict a cross-tenant denial =
of
> service?
>
> The srcu_read_lock() is acquired at the beginning of kvm_gmem_fallocate()=
 and
> held across the entire kvm_gmem_punch_hole() or kvm_gmem_allocate() execu=
tion.
> Because a guest_memfd can be terabytes in size, these operations could it=
erate
> over millions of pages and take a long time to complete.
>
> During this entire time, the global SRCU read lock is held uninterruptibl=
y
> (yielding via cond_resched() in kvm_gmem_allocate() does not drop SRCU).
>
>> =20
>>  	if (!ret)
>>  		file_modified(file);
>> +
>> +out:
>> +	srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
>>  	return ret;
>>  }
> [ ... ]
>> @@ -1014,5 +1053,61 @@ void kvm_gmem_exit(void)
> [ ... ]
>> +void kvm_gmem_freeze(struct inode *inode, bool freeze)
>> +{
>> +	u64 flags =3D READ_ONCE(GMEM_I(inode)->flags);
>> +
>> +	if (freeze)
>> +		flags |=3D GUEST_MEMFD_F_MAPPING_FROZEN;
>> +	else
>> +		flags &=3D ~GUEST_MEMFD_F_MAPPING_FROZEN;
>> +
>> +	WRITE_ONCE(GMEM_I(inode)->flags, flags);
>> +
>> +	if (freeze)
>> +		synchronize_srcu(&kvm_gmem_freeze_srcu);
>
> [Severity: High]
> Can this synchronize_srcu() block indefinitely waiting on another tenant?
>
> Since the SRCU is global, calling kvm_gmem_freeze() on a completely unrel=
ated
> VM will invoke synchronize_srcu(&kvm_gmem_freeze_srcu). This will wait fo=
r the
> first tenant's massive fallocate() to finish.
>
> The loop in kvm_gmem_allocate() checks kvm_gmem_is_frozen(inode) on its o=
wn
> inode, so it will not abort when a different inode is frozen. This effect=
ively
> allows an unprivileged tenant to stall live updates and preservation
> system-wide.

Agree. With having per-cpu have a problem with the per-cpu structure for
the inode freeze as it is not tracked in cgroup (IIUC). which might result =
in
OOM on host when a lot of guest_memfd allocation are triggered.

We can use per inode rw_semaphore, but they will not be per-cpu, so
there will be cache line bouncing. Which will affect only slow path
(page fault allocation, fallocate). I would like to discuss on the best
strategy.

>
>> +}
>
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780676742.=
git.tarunsahu@google.com?part=3D6
