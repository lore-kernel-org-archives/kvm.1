Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035C847F2E1
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070805; cv=none; b=Vbzi9JP3SQuKmwqHmXHhMDCQTqOaEZQP/C4m8oFEm/AbpYgOlPK2Oot+RYbKLyX3FTuBP+fBOulyKC/+xjBLFWu/js8vEo6UAe/POXy8f3JjfyQB4Ekc5M/8iWWv8u+zXZ9VjZEKZAu9nV74v3jLl9rjcPFEhezZmQuPRhnqez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070805; c=relaxed/simple;
	bh=0igr8Zes/VrYG9fBE3Cru4sD9Bym8t8t+dDC8+h+gAE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sPep6ohgEeLbX2/Me8fICg/58bgGYVeNDV/SR3ZuOBrbZIB0m/sCPF6WOkWYAN4Sik5o4EMLBfGKSCNaYnl9Yb+fG4egyZ0Hg5uazj/Ud5Mge8bisHuygdxOjHgXfYFrRG7FYYjQSMMsrpP2CT/ISv/JHXuFr4ZRZmczo7xOhzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y2CmzhOQ; arc=none smtp.client-ip=209.85.218.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2CmzhOQ"
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c1686e23b9cso57182866b.0
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 09:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787070802; x=1787675602; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NYCxMBx4BOPF4yBl5aKpfQIqd2cMC8x5BNz4F0URw58=;
        b=Y2CmzhOQUiBpcQdqp7SRGIDAIpVBtJP7x53ivlFZPPvsipZCsIiKakPMi5TtmYUbWB
         W5dbbG/qcSqKmAewTxQua3qwspuJOOlM34loyMPQAB8YpHdgQh+Fo3Rq4+8tWYti1N+/
         m0+SSoP6tsy8kpMREm+5HVJ5uYLbMgtX9BKEn9WhzKCs2fEjoQK69q/GACruN2sSdqj0
         4PLBqlcyC2CtT5XMwPGS3jJ4HdNbwiEp3jT/QLAL6qg5exaRx5rDaIF5wYJRCe2bT+Zx
         aT/3v4VX657/Cvcr7CHOfi58xcJ9Dw5r2UK1MQF5yqYaDbzJrFylXOp8JLkflQxHm8DE
         d63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787070802; x=1787675602;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NYCxMBx4BOPF4yBl5aKpfQIqd2cMC8x5BNz4F0URw58=;
        b=S3fFFp/hxtcTZZ1DfLV31LDxjCsjIRbUapyNkJCus4/HvWZ9JNDUCmo0874GdJ/XRW
         h5Ld1ATk0UWqsS8HNGrIcgS6lOgqlGGSz3T/DqgDDtvdsI3J/vWTMue2e+iOcEyJY64G
         r3l0cdTiVz8G5enRU+Wmis3yzmv+dS6RmQFEWzpekcAkZaQlL28cEEExK7fmxadsX0tx
         7Br6tJbPU9cNFPXYmxnpaJcgJblAdW5xU232BzS+4TAJotN7yLr5BJxuSjkvTXuQCcYy
         nZar7ibLzKTsBJX5pmKzUroF+w/ar1u47DYwWKnDmI4TNb/zzPkiml0Z3VOSyIK4xTZC
         j9DQ==
X-Forwarded-Encrypted: i=1; AHgh+RqUmKW3+dPQ87+tDQ2U6e0BqNAIP78Q3CMLp2Q651xbGoeoLjI21qb/kSIZ0v3ZLkacoa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKe3sl8EoC9BFYidombmJYC8IfCBcknjlSj0OfpPZEgt3b8CgA
	3UY2ZQo305YFPdGNqeh05kkoVuSvhdzUUckQ85MTkAJFFalobmKu5QbKVaP9+clXw7a6ZWzNykp
	SvJNs4uT99up/0hI+sg==
X-Received: from edea16.prod.google.com ([2002:a05:6402:a190:b0:697:8356:d9d6])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6938:a091:10b0:c15:a487:3482 with SMTP id a640c23a62f3a-c2188a9df89mr438613166b.21.1787070802257;
 Tue, 18 Aug 2026 09:33:22 -0700 (PDT)
Date: Tue, 18 Aug 2026 16:33:21 +0000
In-Reply-To: <anpieno-RyRl54fp@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-8-tarunsahu@google.com> <anpieno-RyRl54fp@google.com>
Message-ID: <9huzfr0bv166.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 07/11] KVM: guest_memfd: Add support for freezing mappings
From: tarunsahu@google.com
To: Sean Christopherson <seanjc@google.com>
Cc: ackerleytng@google.com, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	linux-kselftest@vger.kernel.org, andre.przywara@arm.com, michael.roth@amd.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, will@kernel.org, 
	vannapurve@google.com, maz@kernel.org, fvdl@google.com, kvm@vger.kernel.org, 
	oliver.upton@linux.dev, kvmarm@lists.linux.dev, alexandru.elisei@arm.com, 
	skhawaja@google.com, aneesh.kumar@kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, kexec@lists.infradead.org, 
	suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Jul 28, 2026, Tarun Sahu wrote:
>> +/**
>> + * kvm_gmem_freeze - Freeze or unfreeze a guest_memfd inode mapping.
>> + * @inode: The guest_memfd inode.
>> + * @freeze: True to freeze, false to unfreeze.
>> + *
>> + * This API is used strictly during the live update / preservation transition
>> + * window to prevent host userspace and guest-side faults from making any
>> + * mapping modifications (such as fallocate or page fault allocation)
>> + * to the guest_memfd page cache.
>> + *
>> + * Synchronization Strategy (Sleepable RCU):
>> + * To avoid high-contention VFS locks (like inode_lock or
>> + * filemap_invalidate_lock) on the vCPU page fault hot paths, this subsystem
>> + * implements a lightweight, system-wide Sleepable RCU (SRCU) mechanism
>> + * (`kvm_gmem_freeze_srcu`):
>> + *
>> + * Global vs. Per-Inode SRCU
>> + * ======================
>> + * A single system-wide global static `srcu_struct` is used instead of a
>> + * per-inode SRCU structure to completely prevent unprivileged users from
>> + * exhausting the host's per-CPU memory allocator. 
>
> This argument doesn't hold up given that each kvm structure has two SRCU structs.

Ohh okay. I was very skeptic that per-cpu structure are not counted in
cgroups and liveupdate is once in a while usecase So avoided making it
per-cpu. But otherwise I am fine with going with per-cpu. Will take care
of it in next revision.

Thanks
~Tarun

