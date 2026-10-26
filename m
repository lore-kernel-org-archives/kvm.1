Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015413;
	b=biR+7bB0j2kb72+Qs48OPDtZxU499fn37TZl2aBWWE82bMMpUOKOur+mEF0wF0UD+wAh
	 oe9OUoY3Yk4uOitbLsj9XyiZAIGx8Kv7VRmT8ZHj0GQ5WqJ1wx7DeS9HnEBdnwIn7bXgI
	 Cac2UhLtOmGkvo33ozxwiG/5yqdkFXhUqPNuIEQbsOenwDV3+7aPjYMWq8i95fBb8qDWI
	 7kKAMAxD3Cu727ehblowGO9aM8aPcw/inUqdiECgJ0BkALjHGsLclfOxW7dE/0yudRQVk
	 CLn7LXTbYXtgXVVyVSymmjdyX2hq90XAUW87q/bUKQeoEmSRJqEwQChpORUC6/aNXTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=E6ehAr+5O7aPeLIKo6+S6CS8cvliVvtVKcymE8BrUws=;
	b=bDHSmxt7Hyvv8n6QOHkMKk5tZaUHP2WkjrCHcYRyyZ0qlgCarag0ZllZfkKh2fCzB5QM
	 zz0QqLWt8G/GNqe877G8XHYFo2pDRprzhnyyCBbrnaQiZqwYyvHhNuy1yTmN9guW57jFS
	 qrdBtUa6ed/TUJQVtkgZ5/NrXveB0cTWIvm96uMgzL9s0m4H4fvL+g/uR5MNSpbowQJ9l
	 0srGzLCaapfkAkd4DfMDkV/gAc4RdP7Ky0j0yNTuMl/EL9/K39j6IEWFh0E/hhubbRxDW
	 gaHs1MwaYeSxPYal8UOIe3K2zqZ/TvoyhtVVo7A8a8NZRWadxwTUaHnutXeHlQLy3dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XAsGlQ44;
	arc=none smtp.remote-ip=209.85.208.71
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D6606A31D
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 11:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B2D6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XAsGlQ44
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b1d818b501so3599356a12.0
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 04:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793015411; x=1793620211; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E6ehAr+5O7aPeLIKo6+S6CS8cvliVvtVKcymE8BrUws=;
        b=XAsGlQ44QhxLbX3s/vWrWR1fEjhFGkT5IlmfbZ+lkLP9Oe85SXpiAn1GeRLEL1H2XO
         yQc+jA06Xl9daZwtD/YhVCQBe4QhPG4Wx6MdjOZ4iJEgGnKFU/FYUV7xzaqZQKLsA0aN
         R/0o43MCYXNrmiuXKNSZMqL9QRoabLxkTEN4RZcoISWY2W4N5MHoElGvLxv39SyWGeoh
         S2qHKVenxm/vznKTPaQvnAwIq1AJacG92itDoKu8OCiHjWi2HDS+a0fN0ni6jgV3kLpO
         SlxEHMWkwZPDCPxARUPnqJ5+CJrAkhzChQ6p6s68BDHOT5BDv1rKIoQIexS1xnBLr1l6
         sTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793015411; x=1793620211;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E6ehAr+5O7aPeLIKo6+S6CS8cvliVvtVKcymE8BrUws=;
        b=Isw+V5UofRaSwEXxG117QXqCiRyJud2FOdaOgOp1+sleo+FW231IjGZO5FCMJn+nvA
         g8nhFTwBp3wZP97ld2chBxO/41Z/FJnC9ddsaF6/o9vY2pOzFAUNbeGax9qd+OKi+7Jz
         5xWdluVirznQPgmAyeMa66AuXXNAjjOuWqWEGe4n10e9Ah4aRCnk7klcE0zkT074RLZ4
         FDHN4CychgjNKRxOc9PvcPVnQgwOu20A0fvaSHuad5q16fRI5F111DkdiJkFd8+mDeW/
         YvdoVpNgLtDUs6HHkmiHiPUiL2lDsFx5htV2kTNbisopXNIAyyXrwyg0IvifiJvkEl+W
         z/1Q==
X-Forwarded-Encrypted: i=1; AKwUvBw3m19frEbHofxYWTDLrqw3otOTF3n/Coqt00zhIWdX66rSAPxrbr8gafPRbLTii4a/vgM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIcpqDnh1C9kY+HKqqWbKSZBEFdbpoRDrNZYgskBWXw+ep5FJX5
	lylY0GLuto8rGqvN0/3J0n2lH4tsHavs/GwrVjZZMFgu4hhGSq/J0WzXBrvtGRMOR50Wt0nLTBd
	OFw7JqmLWdZFHajlXew==
X-Received: from edrd16.prod.google.com ([2002:aa7:d690:0:b0:6b3:8448:41c6])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:249e:b0:6b1:c7d9:b622 with SMTP id 4fb4d7f45d1cf-6b442fffef3mr7891637a12.26.1793015410774;
 Mon, 26 Oct 2026 04:50:10 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:50:10 +0000
In-Reply-To: <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com> <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
Message-ID: <9huzzew0el59.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
From: tarunsahu@google.com
To: David Matlack <dmatlack@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

David Matlack <dmatlack@google.com> writes:

> On Wed, Oct 21, 2026 at 4:55=E2=80=AFPM David Matlack <dmatlack@google.co=
m> wrote:
>>
>> On 2026-10-21 03:25 PM, Tarun Sahu wrote:
>> > LUO and its file handlers validate handed-over state with monolithic
>> > compatibility strings ("luo-v5", "memfd-v2"). Any change to a serializ=
ed
>> > structure, even an optional additive one, must bump the string, which
>> > breaks live update between adjacent kernels. Replace the string in
>> > struct luo_ser with a feature header, so that the target kernel can
>> > accept or reject the source kernel state per feature.
>> >
>> > struct luo_feature_hdr is a fixed 128-byte header: the serialized
>> > structure size from the source kernel followed by 15 chained u64 featu=
re
>> > flags entries. The fixed size keeps payload field offsets identical in
>> > every kernel, regardless of how many flags entries a source kernel use=
s.
>> >
>> > Each feature has a 2-bit pair (req, active) state (enum luo_feat_state=
:
>> > LUO_FEAT_DISABLED, LUO_FEAT_OPTIONAL, LUO_FEAT_REQUIRED). A flags entr=
y
>> > holds 31 features, and bits [63:62] =3D 0b11 chain to the next entry (=
465
>> > features in total). Each subsystem defines its feature states as a
>> > static const u8 array indexed by its feature enum, which
>> > luo_feature_hdr_init() packs into 64-bit flags entries with
>> > LUO_FEAT_EXT_MASK chain bits. The target kernel validates the header f=
rom
>> > the source kernel against its own feature array via
>> > luo_feature_hdr_validate() according to the per-feature (req, active)
>> > truth table:
>> >
>> >   Source Target Action
>> >   (1,0)  (x,x)  Reject -EINVAL: invalid source kernel (req without act=
ive)
>> >   (x,x)  (1,0)  Reject -EINVAL + WARN_ON_ONCE: invalid target kernel
>> >   (0,0)  (0,0)  Accept: feature absent
>> >   (0,0)  (0,1)  Accept: feature absent
>> >   (0,0)  (1,1)  Reject -EOPNOTSUPP: target kernel requires the feature
>> >   (0,1)  (0,0)  Accept: ignore payload data
>> >   (1,1)  (0,0)  Reject -EOPNOTSUPP: source kernel requires the feature
>> >   (x,1)  (x,1)  Accept: use payload data
>>
>> I think we have different definitions of "required".
>>
>> In the PCI series [1], required and optional flags describe the _data_
>> the previous kernel handed over, not the kernel itself. A required bit
>> means "this preserved state depends on feature X; a kernel that does
>> not understand X must not take it over". An optional bit means "the
>> data for X is here, but you can safely ignore it". The source kernel
>> only sets a bit when the preserved state actually uses the feature.
>>
>> It's up to the FLB/FH retrieve how to handle the scenario where a
>> required bit is set that the target kernel does not understand. For the
>> PCI FLB we panic since failing to adopt the PCI state could lead to
>> memory corruption as preserved devices can be doing DMA.
>>
>> The target kernel never requires anything from the source. If a
>> feature is absent, the target kernel must handle that, e.g. by
>> falling back to default behavior. If it can't, that is a compatibility
>> break and should be handled by the compatible string.
>>
>> In this patch each kernel has a single static feature array that is used
>> both to generate the header and to validate the incoming header.  So if
>> kernel N marks a new feature X as required (so that older kernels reject
>> data they cannot understand), then kernel N will also reject every
>> kernel that does not have X, because of the (0,0) -> (1,1) row in the
>> truth table. That breaks forward updates from N-1 to N, and rollbacks
>> from N to N-1 even when **nothing being preserved uses X**. Therefore,
>> every new required feature becomes a compatible string bump.
>>

Right, Required bit should be source kernel payload property to tell
target kernel that the payload must be handled to correctly deserialize
the data. It should be source kernel (userspace) responsiblity to make
sure it understand the target kernel before doing liveupdate.

Saying this, During deserialization, target kernel's required bit is not
necessary. So I propose the following truth table.

Source hdr  Target supported[i]  Action
----------  -------------------  ----------------------------------
00          0 or 1               Accept: feature absent in payload
01          0                    Accept: ignore the feature data
01          1                    Accept: use the feature data
11          0                    Reject: -EOPNOTSUPP
11          1                    Accept: use the feature data
10          0 or 1               Reject: -EINVAL (invalid encoding)

Where Supported bit is extra bit information used by target kernel to
deserialize the data. Which is static information of target kernel and
will never be used in serialization payload.

Like,

static bool memfd_feat_supported[MEMFD_NR_FEATUERS]{
       [MEMFD_CORE_FEATURE] =3D true
}

This makes every kernel 3 bit information.

required+active: used by source kernel and embedded in serialized hdr
supported: used by target kernel to deserialize the data if it supports.

~Tarun



>> I would drop the target-side required state entirely and let the source
>> kernel decide which flags to set for each Live Update based on what is
>> _actually_ preserved. Accessing a field added after the original struct
>> then always requires checking its flag.
>>
>> At the end of the day it is up to userspace to never start using a
>> required feature while they can still rollback to a kernel that does not
>> support it. Cloud Providers know how to do this since Live Migration has
>> the same problem. This also means we must be very careful when adding
>> new required features, as they need some way for userspace to explicitly
>> opt-into them. I do _not_ think we should try to have some generic LUO
>> opt-in for required features. That is up to the File Handlers and FLBs,
>> as they have their own uAPI.
>>
>> [1] https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@=
google.com/
>
> Oh and please see the follow-up PCI series to preserve BARs and bridge
> windows for some examples of using optional_flags to extend struct
> pci_ser with additional data without breaking backwards compatibility.
> e.g. https://lore.kernel.org/linux-pci/20261019213054.3157159-5-dmatlack@=
google.com/
>
> I don't yet have a use-case for a required_flag.




