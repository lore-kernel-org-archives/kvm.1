Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795100069;
	b=rfkNU+DFtvuw9oONa1oTiuqzKkZOy2cgVm77tT3fNTQOGCfh4rUVX3pyhy40nnCBujeN
	 8F56023oLSJhtCv94fiSesuJtq09GCxH5UNBYqPyyqyiM2R4TQOn2cZ2xNQ96DgGWtfQL
	 EPF9lz+RgFccA5LaAjiaNKLdl1n9UNBd0olsUhAcYpEO8IQyN0G3xYgO0SN81mwGsVTEQ
	 Nvpt+h1+spaCjQEwhZR5krf/6nuad9O91b8e0sG9axIq86xLMe358lBjJlDOeNdp6KwXw
	 K0db2MSw7uvBSYqx+Rm97xE9cOKYxrQ/RUb0HvMcGLjdLDx3RTF5b2dFA4YbGgWrJ6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795100069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=P2zzf8FFEBL81oIQV+yxC49Gt94XvsXrSt4IwcmCdEQ=;
	b=T1f2HD4IpBESLspZiP236dGa02TacrJ3z1lZaGuphCTpgDlskVGZ3HBlG0xwVHPPXnS3
	 w6mxSDOPMWY6t/Eni8pzK0+MEcpVkVatah42gpsfEo3kitovgpJeyrPtkZhxwTyctzNr6
	 D7t4JMVGGpmZnNs9YtHA2XHCK5TGbhCWVkwPGgXnDZdvpRANw8KP8Fqa2mJH7kApKUYSB
	 prnqI6bK4cRLHj7s6HaQReNxV31eCd6X3ays29o1RI/zTwfTdt61VAy+4XFOgBda3bX0l
	 6Bb8P1GixOTd4MswmPD2m6yAJw7imASDXkhLCHrrzMt9AJ5KcMkHUe5bWtk3tJpWTZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="jnl7/H8R";
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50175606A325
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 14:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50175606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jnl7/H8R
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2efdc279d95so11254255ad.1
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 06:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795100069; x=1795704869; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P2zzf8FFEBL81oIQV+yxC49Gt94XvsXrSt4IwcmCdEQ=;
        b=jnl7/H8R1eTBRPe4w3y/4xrMwlzD7pXAE8zRlMYip42/K3AEefn2SREmoAoHvl31Vu
         F/yWAnRvTXdXHfG7UaF8QJaP3uoylFIzyMQ07FqbUO9hnPQBalqpDkHTDjVREGXPOq2Q
         NJ3iTqNdel51Z5y+pZYzFFOihS1TyYT6Zqov7sUHBr1kuK6RNBrM+tC0MUkuVWrqXwOJ
         7lrJqEOifb6FwNE1XNLAr8Cv/nbRlEZZzvbez8DnTDrlA47guSI02N9whwz0F+hP+xQV
         5l0L+xo+quddDMbts/vZfwBB6T6+t6avSiiq3r5IacJLgWiPBLbZs2JLq/ug0f+AWiYt
         QqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795100069; x=1795704869;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P2zzf8FFEBL81oIQV+yxC49Gt94XvsXrSt4IwcmCdEQ=;
        b=ZArLYmzItd9XrxrI0y8o8CKA0poPx8BhpTDUnbzjS3BthhVibK2mKrkbOLrjyqinm6
         bnIVnPg6TTg9bQLB+zo/+iO9YCePyMRI3Mp022qA4quwiOue3TJa1PvSWNeVwcRXY2t1
         corB6RMmhjATuzbkSuhlOEn/I1IQp5PqJafvMogrCvTT6YYmyQw6TWgpzva8bT3s7Qel
         c6Luqi3qIn3mzFxr61LMp0Elrhl3GIKWHsT3U8iSCyoeMk3UXINO+BGaDlv501QY2siC
         xk2Kceinya4isRn93kR1q00nuivcJSN2aGnEJEzPWbobIjkh8O7Auw4HifJoYBNu9pwx
         5VYA==
X-Forwarded-Encrypted: i=1; AL+hErEbzEOq/1iMY7pmqzVtOpzlcMDxxglTCSh4GNrclHBQ8RKxhc3RRiqalfNfGwkg9ypgF2g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XIfofrulB9vKb1aj7gvurohccnGco0mJ9YABNNCh/o3lLt0hk
	R2B1Vt9EZ/GdWptRnmu+PYODdgdrfYFJyhJYl5V0zU6ujf3IvHo83ORCZ4VhsQT6rM121qH87C+
	HoGEY2w==
X-Received: from plbkl12.prod.google.com ([2002:a17:903:74c:b0:2ed:4c9b:1bfc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e74c:b0:2ef:f2e0:db0
 with SMTP id d9443c01a7336-2f03f18fb43mr715205ad.10.1795100068394; Thu, 19
 Nov 2026 06:54:28 -0800 (PST)
Date: Thu, 19 Nov 2026 06:54:27 -0800
In-Reply-To: <120ad525-efa5-4129-9d97-fa6fa5db747f@arm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116164358.142785-1-steven.price@arm.com> <20261116164358.142785-2-steven.price@arm.com>
 <CA+EHjTy5xBmavNWSYPjqU9qXtssV3ZHzsUr1s_4bVOt1GnDLVg@mail.gmail.com>
 <6bb490cd-ebbe-41d7-adf3-d6eaf0e53478@arm.com> <b1ef7241-54b0-4a17-83b6-0008e722f2f6@arm.com>
 <8a095a42-662a-416d-a5d7-79e10161201c@arm.com> <cc27e6a8-6bfa-4c82-92a7-33175baf6803@arm.com>
 <120ad525-efa5-4129-9d97-fa6fa5db747f@arm.com>
Message-ID: <av8No1rvJLXwciId@seanjc-mac.roam.internal>
Subject: Re: [PATCH v3 01/11] KVM: arm64: guest_memfd: Check mmap support when
 preparing memslot
From: Sean Christopherson <seanjc@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Steven Price <steven.price@arm.com>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	James Morse <james.morse@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, 
	linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>, 
	Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Kohei Enju <enju.kohei@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 19, 2026, Suzuki K Poulose wrote:
> I see, thanks Steven. For context:
> 
> Arm64 currently (without inplace conversion support) only allows GMEM
> with MMAP flags only and relies on kvm_slot_gmem_only() to detect that
> the GMEM has MMAP flag. But, when we enable inplace conversion,
> we can't reliably reject the slots by kvm_slot_gmem_only(), because
> all GMEM slots are marked GMEM only with inplace conversion.
> 
> Also, from the API Documentation,
> 
> "When the KVM MMU performs a PFN lookup to service a guest fault, the fault
> will always be consumed from guest_memfd, regardless of whether it is a shared
> or a private fault (unless in-place conversion is disabled and the backing
> guest_memfd does not have the GUEST_MEMFD_FLAG_MMAP flag set)."
> 
> So, in effect, with in-place conversion enabled a KVM_CREATE_GUEST_MEMFD
> without GUEST_MEMFD_FLAG_MMAP is an error

It's only an error if (a) the userspace address in the memslot points at the
gmem fd and (b) something in KVM tries to actually GUP the memslot using the
userspace virtual address.

> and thats what this patch is trying to fix in arm64 KVM. The question is:
> 
> 1) Should this be fixed ? How does TDX/SNP support older VMMs with
> inplace conversion ? What was the conclusion on this breakage ?

There is no "breakage".  If userspace doesn't point the userspace address at a
valid VMA, that userspace's problem.  The only thing the early check would do is
prevent weird use cases that may or may not be valid (and for which KVM doesn't
care), and error out earlier if KVM guesses right and userspace really did goof.

> 2) If it should be, then shouldn't it be done in kvm_gmem_create() ?

No.  As above, I don't see any reason to have the check at all.
