Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335150;
	b=wI0tnALo+62Oz2oN6oyMIMJs5l9mXlPWKIhT6/LKK0BDw/O92saIOB+H3X1I9EADKXY5
	 ck7yyulZJgQFlSst6qYdYt7T8U8CEj76qyfeEi4SORxLgeI1okWns4An+UTzWrV2RmvIb
	 4rWMQDURAJT2RIAJ2oC+/83Fh8nN6ijNDMBXJdLB0DuQf1t9S+lolXCYjyYlgDkD1quzB
	 Z7g84hmxxGZKlM+W8kmhVEehH2tB9E6YmGWwKG40twPXizMSe9rH5tey6XNRPBbE/DhJW
	 oCdjAJ+oCLIeI1izmvd8dxFMGx2Xt2v0hJ2Otp6UkSyuZOZzoVL0v8MfebzFBdWpi9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=pg8+OEnjDNmIa2RbISOLY8VoGEN6y0ux1Fnyr8R7io4=;
	b=teNT6et4TN1hxIHLOQaK5pCp6ZUnp6QchhYzOfniywiN6xznecslEYzV0G5acz1TD8vm
	 wZ7GbH/FSyB1sDOs1oW7a8nTboBgXi80CuLQBdHj3nHJeqercpk8/ATnMKAPbcyNYUB9B
	 YGKD3czbQsw1cxAC6sd67tjYrf2JtAjhc4da6XWFWPEJVw+10jyn3xXiDWuFIXQYmSo8u
	 WO6Wxhm4dqoUKc5COm153+uKmsHcHi0Ww84hTvSc8aY/sB4Il4hXQs0YXCujpYM4RevVu
	 X4ZcphBWUTtDAQPzq0i9VqQe7hkXB+cT3UYvOdz9XaU0hDVXS1KHQ2Uu4/AlUiRqmiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ss2sAv1Z;
	arc=none smtp.remote-ip=209.85.218.70
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66D8606A32E
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 18:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B66D8606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ss2sAv1Z
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c50593b3eebso59859366b.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 10:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794335148; x=1794939948; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pg8+OEnjDNmIa2RbISOLY8VoGEN6y0ux1Fnyr8R7io4=;
        b=Ss2sAv1Z44xGCzrouTTSNStulPTKhVCnUO+g4V7Ttgr82dioG8oDl/aa9BFjmSvCYi
         euurrMXPzpvjVfF2ZfKzD82qUQBBtXAN9f+MJkGikK45Tj4cAehpSd8POZHmWpeSUTNa
         ee90SX5pk+PyA8l2gVtwImvYurJFi/PPJudDUyeLNd3LrsGsvH6KnVfocewpXHvIiLKq
         VjnnbVpNS7FQdGG2Lc5//B4NgFsI+lF/Az+FjkxpMpXT6wrqHKPZtvcjAcfxV7sSEMxX
         WSc7JvmUyi5mGyRJmJ514aI1wQP2Xz8QRVxCIv+4tiJbD3usEEvyGPpAG5S96WBYg/hM
         99Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794335148; x=1794939948;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pg8+OEnjDNmIa2RbISOLY8VoGEN6y0ux1Fnyr8R7io4=;
        b=REcDaXxIlO9KJkb/2yWUhDlefaSUaVOnILOKUOq9233uMlmLBu3dCviIN7WBuGY05I
         Matt6xneuz/NBMzyLvToKYBZklXrheB6Rh3XIM0oSF35P/TgHlLQmUPtmtJaZMDkV+5A
         qJpSVMDk2pIXZ88vQI9KPbSlSjhYyrm3ebroz0HshHXRMF5AGOYsPdd8xf37anqJT3TE
         LDhFgqVvyQThut4Sf5uTle7L+CL9Pe6tuoWGFqUwvecla4gFZUtwsD9cA9Ip+5fcz577
         NG0xQR6p5uOnuj5VyvddaNa+jQMUJWfxODd/4/ppG4cAO9l09L+Va5vvn2sTvUdbSOJD
         tXhQ==
X-Forwarded-Encrypted: i=1; AL+hErF46o3+m1uEFzZphwudq12yMgTcJmUnjVwi0PwWXu/mUbnpUD94UA99vqPmkxMG06NEtCw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8R8QCLtGw98PMSs21bfltcFbo3iVvlT6wF2ok26TMok0en97gq
	vbylduHEKmhv5eX+K4jTpZKSQW5QL/5SnqwDOTQjHj2xLO1hCDPWopIEuJyoqqT5XzEYuaAIO9i
	Amyl+DC9Fj7aE2sF4vw==
X-Received: from edfg4-n2.prod.google.com ([2002:a05:6402:a244:20b0:6b5:813f:c569])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:13c5:b0:6b5:76be:be54 with SMTP id 4fb4d7f45d1cf-6b777829b2fmr85425a12.35.1794335147866;
 Tue, 10 Nov 2026 10:25:47 -0800 (PST)
Date: Tue, 10 Nov 2026 18:25:47 +0000
In-Reply-To: <DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <20261110050202.529473-6-tarunsahu@google.com>
 <DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com>
Message-ID: <9huz5wy4tufo.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI compatibility
From: tarunsahu@google.com
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"Pasha Tatashin" <pasha.tatashin@soleen.com> writes:

> On Tue Nov 10, 2026 at 12:01 AM EST, Tarun Sahu wrote:
>
>> +/**
>> + * DECLARE_KHO_SER - Register a serialized payload structure with KHO.
>> + * @name:         Structure tag name (e.g. luo_ser).
>> + * @payload_size: Compile-time expected size of struct @name in bytes.
>> + * @nr_required:  Total number of defined required features.
>> + * @nr_optional:  Total number of defined optional features.
>> + *
>> + * Size and 8-byte alignment are asserted under CONFIG_64BIT: KHO and LUO are
>> + * 64-bit only, while !CONFIG_KEXEC_HANDOVER stubs pull ABI headers into
>> + * 32-bit builds where u64 has 4-byte or 2-byte alignment.
>> + */
>> +#define DECLARE_KHO_SER(name, payload_size, nr_required, nr_optional)	\
>> +	static_assert(!IS_ENABLED(CONFIG_64BIT) ||			\
>> +		      sizeof(struct name) == (payload_size),		\
>> +		      "struct " #name " size mismatch");		\
>> +	static_assert(!IS_ENABLED(CONFIG_64BIT) ||			\
>> +		      __alignof__(struct name) == 8,			\
>> +		      "struct " #name " must be 8-byte aligned");	\
>> +	extern struct kho_ser_hdr __kho_ser_hdr_##name;			\
>
> Remove this extern.
>
>> +	enum {								\
>> +		__KHO_SER_SIZE_##name = (payload_size),			\
>> +		__KHO_SER_NR_REQUIRED_##name = (nr_required),		\
>> +		__KHO_SER_NR_OPTIONAL_##name = (nr_optional),		\
>> +	}
>> +
>> +/**
>> + * DECLARE_KHO_SER_HDR - Declare a feature header variable, field, or parameter.
>> + * @name: Structure tag name registered with DECLARE_KHO_SER().
>> + * @decl: Declarator (e.g. *fhdr, **out_fhdr, or * inside DECLARE_KHOSER_PTR).
>> + *
>> + * Declares @decl with type struct kho_ser_hdr while checking at compile time
>> + * that @name was registered with DECLARE_KHO_SER(), documenting which
>> + * serialized payload structure a feature header pointer belongs to.
>> + */
>> +#define DECLARE_KHO_SER_HDR(name, decl)	typeof(__kho_ser_hdr_##name) decl
>
> Remove DECLARE_KHO_SER_HDR, use kho_ser_hdr directly.


I added this, because wherever in the kernel a serialized struture is
preceded with kho_ser_hdr, it will only be called `struct kho_ser_hdr
fhdr` which does not display (to readers) that this declaration of
header variable is not alone, it also holds the serialized structure
after this variable.

Using this macro, it clearly explain, that "Hey, I am header to this
serialized struct and I am compiled time initalized using
DECLARE_KHO_SER for this serialized structure and my pointer holds
location to both feature header followed by serialized structure."

Techinically this is just for readability.

WDYT?

~Tarun

>
> -- 
> Pasha
