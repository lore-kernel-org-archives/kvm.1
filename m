Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3007C3CAE95
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367334; cv=none; b=sjON50nhJ4xmkARD7poUlLJCIufhcwoNEKxl1tOvm5UfVOcdUKZ95+ynNlQhqrlx6iiWgQpdqGvONj1YKrly//DLTt5IPM8rpH9qnCbvx/OC3Sq+PypMDbTcdLf+If3LsNrpxcvZds/nW3hcGYPbc++WlqU9ecQfhzEu/KzaxJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367334; c=relaxed/simple;
	bh=vBxAOqpXOy3xBw2jLlc1xHZGLUnTc7rwy+EMZmi2RU4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bBOEUB7mxguOHNGTcRMAj7iOT3rRjRrpvdmUvvHGN6BK8+ifVTunsu1RlGQB67Wc8Icxb/lupzbdg+8vuRYqyBgunNSwTLJz/A2KHJkImVfuC1rAkxXwsTPYNqRPxz13eSBYRXoNFsMqiFVXXVdGpzgrvNhP978bTx9jTNWDPRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wjfh450M; arc=none smtp.client-ip=209.85.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wjfh450M"
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a22bf0so1888261a12.0
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 06:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786367331; x=1786972131; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oMcbMXyReyKJIZVlqYCZytsphgwWMjfKxVFVMEfDD0k=;
        b=wjfh450MF/lZ9b81aSP9jT08j1BV6UKDes01K8ph9w9uWjq4UOT04fk7nv8/Adlb4M
         hVkB+bi3kjkQzKZvQ0dHAv2eaSCQdo2a/1wC4Mw9R7KSbvp84NtwoiHL9dNRi0DtQbPg
         8v2IFEucuDZvUghWsLduM8J0oqxSK+yUsoiGwDgLE5QTU9vblK2srySjb4rChYmi44Mh
         +lw1MtdtoY0NDjGUrSENEgqyxA9X09Ph+DiAbJI/WNZ0X9e7YrxZiaW5l/UzFHnyryFa
         9L+lc/8LOjLz49QUNCl6xRC4OJzwW3HgVlZO+tc9Kk9u0qmJw4RGT4a1cA6bP+nWVgeQ
         kdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786367331; x=1786972131;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oMcbMXyReyKJIZVlqYCZytsphgwWMjfKxVFVMEfDD0k=;
        b=SfouNN5kzOSbVvDrrgNluZpO4tCIV6nEvpN3TxwSIRYZekyK5EL8ncZqWk2yCNgyAl
         ijh51aCmmY91sb+g2yPYH1QbKF3R193TyMbPS7f14ur2U2BBX+/H68pi3N9N/f3K+ndK
         imxc53vgBPe0lMjITqiika3627eJ4PfZTGIRdmJchbGCdpogLlnrvsSp7PQK81qsT4b5
         UCJbvEt5wQYs2SL+bUzTjC9LKeJnvzCX2xIawcM05TwLcFNC1IEg5f2jIP6J5NuDlVGt
         8sJnR43/F2Ochie32NoXHHIG0Szjlzq/emmgftEsks7nOBzmDn3tzWt1vrWheUDqh/We
         AG9A==
X-Forwarded-Encrypted: i=1; AHgh+RqQC0vYF03dJ1WL30LMRQX7M6I4vwLBCSxMlKpSb0oA64FMArPE4eyAWLXhkxWlvbQcNnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxKw4xgYmLkIGC64MskrQcU6SKPBml/BJ/IMcSCSel1UquNXM7
	mk3ySjZVBfQySK5QZLEcaicB+3erEAVoTaIRSsEFZ10flJ3k4g1eXukGrObUHeu1S7he1ogo8eU
	yV4w8zTILQjL4/IgY6w==
X-Received: from edbek14.prod.google.com ([2002:a05:6402:370e:b0:69f:da3d:dc37])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5048:b0:69a:a4cb:2882 with SMTP id 4fb4d7f45d1cf-6a355db411emr1046692a12.9.1786367331218;
 Mon, 10 Aug 2026 06:08:51 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:08:50 +0000
In-Reply-To: <CAEvNRgHW0P78eL0ip799XF+2geKwz7MQrjSFTgvCdUAuh9oykg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-8-tarunsahu@google.com> <CAEvNRgHW0P78eL0ip799XF+2geKwz7MQrjSFTgvCdUAuh9oykg@mail.gmail.com>
Message-ID: <9huz7bly86n1.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 07/11] KVM: guest_memfd: Add support for freezing mappings
From: tarunsahu@google.com
To: Ackerley Tng <ackerleytng@google.com>, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

> Tarun Sahu <tarunsahu@google.com> writes:
>
>>
>> [...snip...]
>>
>> @@ -273,16 +284,30 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
>>  static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
>>  			       loff_t len)
>>  {
>> +	struct inode *inode = file_inode(file);
>>  	int ret;
>> +	int idx;
>>
>> -	if (!(mode & FALLOC_FL_KEEP_SIZE))
>> -		return -EOPNOTSUPP;
>> +	idx = srcu_read_lock(&kvm_gmem_freeze_srcu);
>> +	if (kvm_gmem_is_frozen(inode)) {
>> +		srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
>> +		return -EPERM;
>> +	}
>>
>> -	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
>> -		return -EOPNOTSUPP;
>> +	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
>> +		ret = -EOPNOTSUPP;
>> +		goto out;
>> +	}
>>
>> -	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
>> -		return -EINVAL;
>> +	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE)) {
>> +		ret = -EOPNOTSUPP;
>> +		goto out;
>> +	}
>> +
>> +	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len)) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>>
>
> Continuing from [1], this guard is actually meant for PUNCH_HOLE... I
> wonder if there could be a deeper refactoring to check when actually
> punching a hole, basically the equivalent place as kvm_gmem_get_folio()
> in the flow of fallocating.
>
> Will srcu_read_lock() be taken in a nested way for the fallocate case?
> It can be taken in a nested way with some intricacies, but maybe if the
> freeze check can be done just as the folio is about to be removed (as
> described in the above paragraph), it would avoid this nested locking
> here.
>
> [1] https://lore.kernel.org/all/2vxzzf0kl3dt.fsf@kernel.org/

Instead of avoiding on remove folio, We can just add the freeze check
across the PUNCH_HOLE, So there will be no nested lock anymore. Nested
lock is just with fallocate populate -> kvm_gmem_get_pfn. So this nested
ness will be removed with this update.

~Tarun

>
>>  	if (mode & FALLOC_FL_PUNCH_HOLE)
>>  		ret = kvm_gmem_punch_hole(file_inode(file), offset, len);
>> @@ -291,6 +316,9 @@ static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
>>
>>  	if (!ret)
>>  		file_modified(file);
>> +
>> +out:
>> +	srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
>>  	return ret;
>>  }
>>
>>
>> [...snip...]
>>
