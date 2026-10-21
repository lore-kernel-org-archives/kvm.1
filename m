Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792626948;
	b=FuhQKJGspoJLKIRSoKSrhGhGviCeQ7IRiH77Myd99SH/5p4JdBteoUzpE4Z39eO729JG
	 NWV3taMJsEeRA8pihmcVWcTJ5ENj80t2xzcEPMCASvm48O0msEVWSzaupr1EmF6Hyjr5O
	 WXRtLl4B137uRoefmNMnhp9FbDXJk3z7YaAdbxXgqyVv27/LhuQ4Nzn1ObgWOZPpxRnfF
	 PTcrLfMH6RFa8q6hBZgpb8BCN+HCd/XI+7fcplMYoY5/R/zvW/NukvB6YQvP7cn5X8PX+
	 4nK+KkJQUoFFRTAAydRS4Fu8VUk05JV/EBPePtrLj+pvJ8+JPNIG/nDzGANm0Dcv9wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792626948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=1fqUHRqztpFhXjrNb+RX+YalUvUHW60343cq6Q4Whxw=;
	b=YXwOn5bYMZW0P+CLvBJ6prxI0Rgn5rTOO+VdFFizJSoirQG8tr2dl9zKfxHoa0yE6yOr
	 tIveh9iC2c5QKajOb+AvoX0x47PP8sCOe/scbYi+FNDzzpGRHbvNOPDBwfLyw6lRnIxQG
	 8GP8eJH5lJM9RM/IConMAAU+yMmhM8EVPkDnFh/6zuPWjP0Mo8whSiik3KhwWFZ7rwmRA
	 tYaIJ7xNuIMTFkt5ZvM8OZ6J+leRyj6VN1NdLLa84iH0UmI2XyUgVx9F12BJtQW0mMfSS
	 2pJ6S0A3avtlZKfHrTzfGoeujiMp70qNbikYaqePFrKj0xDoxiLbmES0Gb356WAbNJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="EI/dWIvL";
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED750606A31B
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 23:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED750606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EI/dWIvL
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9f6a16aedso7522675ad.2
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 16:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792626947; x=1793231747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1fqUHRqztpFhXjrNb+RX+YalUvUHW60343cq6Q4Whxw=;
        b=EI/dWIvL3ZikjYSg7HzlCkK1GP/TAO36DVcBPvrm7OAp5Wrc1orLvwatwzKpFMCAoZ
         Gk/MHdfrb7wrGGOpo3k/Frr+uYE1d4Xgt5PRmpSGIlZjyHw/k3QgV7DUprgR5sBPyCv+
         aqE0g9FVnWJwBPoCLUhELJbSdSK8E9PDXGOTZY0Fh9l4qG+w3xZTS/Mk4XA8y5aQ8idl
         QX0mAG+zkxeLBEf8PetIs2pbn5JamQFtrxMd9R/AIqbAKtAnqV4mlXswuKOwnIszeUyq
         oEewKXpvMZdytWFJCci0L3whMEC1xnrji2lk6HZt1kfMRAlCa5UvqQwN0fylrWb/61aq
         byAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792626947; x=1793231747;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1fqUHRqztpFhXjrNb+RX+YalUvUHW60343cq6Q4Whxw=;
        b=XOU38So8aU/K7srT7b/aDDVnpUT5Ok0RRH7LkKWfTAQyzprNeE1cmnmrxNxAOpD77V
         mhS60MABUv/O5I71qlBHD0WmaPQ0OFaTgL4FOx5CqAxRYmU7ERydiY14FwoULOFbAJJl
         luIKphCLesjEgBqIJ4w5uI80WJ69gn/uy3ty2GfxSPVLgCEaGgOFqf9l7pAzaAxG9YiE
         m48t736I7mY4N2zAUKzmEUQfoM9Mx6lpgRPIqixYaOSdBom00Icdv18MIl2C7dF0BjX2
         rZzA76hgAOXpz0lT9UcQ0B3aCvw9UL8SwTGpE/5G48+3NHo+T94s+6TmpWsjAs0HGl6y
         vONg==
X-Forwarded-Encrypted: i=1; AKwUvBxgvkLDXv7CtlcQbHURZbnwmTQ/sy0sV9mMFAeXEAmuj9quIl1np1KUQN33K4sNolvAPFU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGO0lg2uaTWQOz2iQ+gcfrc+aaeZUOe3jv6DGSuZ0rB1hZE7rn
	k5dMqIHyRm1lkR8vXhNfoihzrCJPhl8J79WMknn9N4Ig8c0kb8HzCl1Rd5RgwLJyeQ==
X-Gm-Gg: AYBFou0x70Aqjwlr7WnE8CzCzfETbC1O1ssQOJ5jj2VXfiHcZCa+DvhINpi4ZPdwvi8
	sXMXFvrZ6QLbK/XREsKB2/TJ1elHlNDw08743GGLVxG3S7UtDMVw+XB+ahbUf1n3E203AGyA6Ge
	pTaEcm4/o+SphvXPqevaLE2BByRMvcTmwKRuIj6PKr2GailE41AG4VZtdhcc/L4ZYu9RGZOKZ6V
	AC6+CT0IRmn+C75XfJLE/nkwQLU+XAyUszgQ6K6bCu0BFYvKS8owhfbJXD54Cj/LY7y8su+Jm2W
	GYSK8CRLjXlb6nyzHEfF5kuYU/saXjiDarRcdPQUuXLios5GUTOYQjVPRFh98AFvLPrWotc2Srr
	SDNO4hUtkguP3E9kiRCOge8RFtXXlC0sCNZ0LrDqPrr4ISngJGdi28aUgYVz/ZrIu4Ny/We+WWu
	Z+FVzWjjVjrMMuaplthzdYC7ObPrH5qq8ECSeRq+yU4BAt3fx3TWhys92hB5pnNvYjMrul6IVAi
	Nx0tbLOse5ne7nUe4S+o+eEDAmykdtCEbsEr+xu7oQ4sggddtLpsxFLxq7up8jN17lZRkqqzT8G
	fUjq01Q9i/e4q47B
X-Received: by 2002:a17:902:f70d:b0:2e8:3190:73a with SMTP id d9443c01a7336-2ea44075412mr31011645ad.58.1792626946744;
        Wed, 21 Oct 2026 16:55:46 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b30829csm16784705ad.11.2026.10.21.16.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:55:44 -0700 (PDT)
Date: Wed, 21 Oct 2026 23:55:40 +0000
From: David Matlack <dmatlack@google.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <atlQ_Er0Ig7CCSxv@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021152527.375070-4-tarunsahu@google.com>

On 2026-10-21 03:25 PM, Tarun Sahu wrote:
> LUO and its file handlers validate handed-over state with monolithic
> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serialized
> structure, even an optional additive one, must bump the string, which
> breaks live update between adjacent kernels. Replace the string in
> struct luo_ser with a feature header, so that the target kernel can
> accept or reject the source kernel state per feature.
> 
> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> structure size from the source kernel followed by 15 chained u64 feature
> flags entries. The fixed size keeps payload field offsets identical in
> every kernel, regardless of how many flags entries a source kernel uses.
> 
> Each feature has a 2-bit pair (req, active) state (enum luo_feat_state:
> LUO_FEAT_DISABLED, LUO_FEAT_OPTIONAL, LUO_FEAT_REQUIRED). A flags entry
> holds 31 features, and bits [63:62] = 0b11 chain to the next entry (465
> features in total). Each subsystem defines its feature states as a
> static const u8 array indexed by its feature enum, which
> luo_feature_hdr_init() packs into 64-bit flags entries with
> LUO_FEAT_EXT_MASK chain bits. The target kernel validates the header from
> the source kernel against its own feature array via
> luo_feature_hdr_validate() according to the per-feature (req, active)
> truth table:
> 
>   Source Target Action
>   (1,0)  (x,x)  Reject -EINVAL: invalid source kernel (req without active)
>   (x,x)  (1,0)  Reject -EINVAL + WARN_ON_ONCE: invalid target kernel
>   (0,0)  (0,0)  Accept: feature absent
>   (0,0)  (0,1)  Accept: feature absent
>   (0,0)  (1,1)  Reject -EOPNOTSUPP: target kernel requires the feature
>   (0,1)  (0,0)  Accept: ignore payload data
>   (1,1)  (0,0)  Reject -EOPNOTSUPP: source kernel requires the feature
>   (x,1)  (x,1)  Accept: use payload data

I think we have different definitions of "required".

In the PCI series [1], required and optional flags describe the _data_
the previous kernel handed over, not the kernel itself. A required bit
means "this preserved state depends on feature X; a kernel that does
not understand X must not take it over". An optional bit means "the
data for X is here, but you can safely ignore it". The source kernel
only sets a bit when the preserved state actually uses the feature.

It's up to the FLB/FH retrieve how to handle the scenario where a
required bit is set that the target kernel does not understand. For the
PCI FLB we panic since failing to adopt the PCI state could lead to
memory corruption as preserved devices can be doing DMA.

The target kernel never requires anything from the source. If a
feature is absent, the target kernel must handle that, e.g. by
falling back to default behavior. If it can't, that is a compatibility
break and should be handled by the compatible string.

In this patch each kernel has a single static feature array that is used
both to generate the header and to validate the incoming header.  So if
kernel N marks a new feature X as required (so that older kernels reject
data they cannot understand), then kernel N will also reject every
kernel that does not have X, because of the (0,0) -> (1,1) row in the
truth table. That breaks forward updates from N-1 to N, and rollbacks
from N to N-1 even when **nothing being preserved uses X**. Therefore,
every new required feature becomes a compatible string bump.

I would drop the target-side required state entirely and let the source
kernel decide which flags to set for each Live Update based on what is
_actually_ preserved. Accessing a field added after the original struct
then always requires checking its flag.

At the end of the day it is up to userspace to never start using a
required feature while they can still rollback to a kernel that does not
support it. Cloud Providers know how to do this since Live Migration has
the same problem. This also means we must be very careful when adding
new required features, as they need some way for userspace to explicitly
opt-into them. I do _not_ think we should try to have some generic LUO
opt-in for required features. That is up to the File Handlers and FLBs,
as they have their own uAPI.

[1] https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@google.com/
