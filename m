Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793278364;
	b=zeQfkPZMRGgrUZDRGNMjOlq3gEcJnWq6VFFXTUwt17Y/E286wajd9xmBN0b+r4Avc7JD
	 QZQuWWU2cLhyUOufn9MEtjgn7aJdLEJ+gZecw1lg5EX7jesmZgHCVLGNbt3AzvSDnN9gL
	 ZZIwZ8NHeo4oJM41d0CkPrCuAJAKVK7RnH7hWitihveMrDCs7oMsNPDfO37HgyJSlM+o7
	 cpXE0Wek3hWM0zNHXGRXLCl6mPiGmdS/81JAc81RgUK/+JD0Q8DAT/UU5TjqjoaLG8PRa
	 mEB1osxTfOKmVa0iiLzMM/twJ0q00De1q2Q5lU0aVjmJUh2/tDY7zDSotMJJVPThD2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=zf2xViTkAeLxB49iEkeFNan7sx9Snfm1yj/XBegFK/Q=;
	b=tpXiSgKW9x8aeROGMhlB47MsWNpgpT8ZBX6tC6rpWSIaq9Rotoh2W0rTFGTv3qvwEuzR
	 7qMISxYY/tUe1+dh5Eep6bFV5GHZBFtIhZhb962PZYLe6QsAcCQrzPCQoE7aV4G5CQvXl
	 9/WK6v/m5E7Tst6noABO2Scp7M+pqqhF8dKqV/v7Tfdb/cDg92PaaJIeNmFy7PE3/nRZw
	 5aqMD5uuDLPWL/rexNhi2hIJIL423mhpmqbaz+uPECkgLuFhQqAcCOxJq7RmeTP/Eawv+
	 elDbaTRPeT5khEMSYaezd4s52dXYOD533Qxe6kdb5hC/TDJM2ak77UzTVi1fjVGuUVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kekh7D0y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2852606A31D
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 12:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2852606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kekh7D0y
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91c75267b0fso24077486d6.3
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 05:52:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793278362; cv=none;
        d=google.com; s=arc-20260327;
        b=AU8/gSzPgjpbnn9VF+heFbLmH3d1nVcCiLYPk34o7X2DNMK3bb5Pu2MdsagJkA1QbM
         SPrfMVz9CQKy6BR7G+AUnw8/cv7zg458EeJ8Knc0iUpnpJgeO15Iw1TtS5DTdQPoUfRu
         JX6/2L3A0aYxGGaX0i00gL6LTCfxOYH4Ef47aHbYl8c9fkn2JxxTwmsO3KjtxElfwFPQ
         UB4Fk22LYEmWkoWs/ya8PvcOeOSxVXHyeSqBoFMtzpRRV3INq13h1f+EWdNqEHkaJ8MK
         REzAQLhXVEAKugefai4QYUP5kEocPvdfcI3wRzDlZ1psXvYsYRXB2Ka4w3ch4+Y3ui8Q
         SNIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=zf2xViTkAeLxB49iEkeFNan7sx9Snfm1yj/XBegFK/Q=;
        fh=jMh7qc2mmqwn8NL0rrIvCE71vMw+0vptP34qp68ysOw=;
        b=k06FCMqXPl/4DUKgNtewLoQ+4xCj2w3xeTNyyNeiAma21y4dINxhqMjow8bIqQFw9R
         YRp4RHvN3kYXGebiDGL4sgVFQoVducIsybvVmYKHV2/Rr8v3iFUcx/tDq1JJFg3makH/
         bGsdZ3dKlBKHyA9N3+2VZMb34OVaPV+mxro62C81aNlZruaKII4B0y5hfXqTLbbBvr/D
         7FQgc2Fw5ETmT5/yExuFCdD1AYRtG4PoCGVgoEadS9wTr76VLpL7u5rq5kFrga1onGw4
         yMC5UuwmkIcSIThVFoURX6VCgAtML3ZdDLEI3d5vVpgAy/yocwSX3/dusYeMDNUgsZhs
         vD1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793278362; x=1793883162; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zf2xViTkAeLxB49iEkeFNan7sx9Snfm1yj/XBegFK/Q=;
        b=kekh7D0yvhQ1NkkjDmNzw05/UHrBOu1T0vh3axp5pIlugWookQdl2HOOKBAuRlC4kt
         SRUtmdrx6rNa2rvgMGUVi3vfVG40FI1tLn1EaEfWNlvzfMqQcK2jTfHgta0f0F7baGeN
         te9zb9jp/5y6rZKFj4kJ34DkOXFF/WFIe55uketGc44+LosN3Ael0rA13ZOowHojLeND
         /6/QUuP75GyXQ1IGOibX5jto2HJD9imi5mA+3+112vXYsn6jdRuRiKqtbBO+tQAt/+Wb
         NVgsnnU2dBOd/JmXYN0rBOFTvhIFtK1SSwZE/YxarMq8eETWEFURRIersU/k7dZ1pKpp
         5uMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793278362; x=1793883162;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zf2xViTkAeLxB49iEkeFNan7sx9Snfm1yj/XBegFK/Q=;
        b=lSkqC3CtXOzVT59F6P73V0i1waf94S4jAQnxPAWTTDTlkPEnQihFbBSZnFnoUEG5XX
         2+InASmLa52Hkv7O6aGaJwuFJFFjVjNPuvtu9Y0qFab2C5tyzA8qsFtxX9UA6IvXXWZk
         vXnnznk9GStIMMFjsUQ7h5wdY0nzkp/nJ+bs+aslFDKO6GbByfrYhdbPK/9uVdNAfcRK
         qfVRBmiT4J2myOriXf6n1hFB0M+yJtBx2imz1UzXSOYBfqB5E5o8cN+XdyuhCGtMdBN/
         u8cGKw3uIE/5seTnjw9U3/0nCBu/tPENxWz1zU9UhDggWsrZbQ9HUgbtXuTCI0vgI/BQ
         yYyw==
X-Forwarded-Encrypted: i=1; AKwUvByB2ivjUX0WMd8P1P3vOqLfahVpVSGpLEzuRxeNh1Zdi5ehKIkvv95TCKP+Dq47E4V1np4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0Eln3MaimFEGVmaUKHTtOCUWe0QhY+ChQXT88CE70EEb+5kWh
	DApG/NX3ord9Y8DuH+psXr244mLR4SFtzMPRAbHnno23V6XN6id6L2T6BBuEXx5g7YV+71pYu6L
	SbUIyUY2e0xLsl77W8pIY6fESENE0ClxshCmCNVEY
X-Gm-Gg: AYBFou0/v8j2TowaDyM+Sn8YNNwzuAd+xWDIW5nOgMRzYlYai95D9W5+FHBjJCz2iG9
	RN8Syx4mzD+xy2U2jD28RqGraX9FpUcidHR7wmlNzAmXWuAx7fjvNPU/ADQyGqGebJNfrU+4FWJ
	ini2VohimGwO5LNOVvj4I6dSs79us6ZLDTownph78rklGwOaUWLi2rIRPRE2BxbZzQL2a3m9A8d
	PbL5COOauBh10Sr0g5otDp/NeZLdvAEUuME6ATVGu1/xTtau3YBZOMFZTF512yshUN3k9W9NzV5
	Eg0rbmqbxhG8D2OUs/t5lo+UXuwwNEDFGeMqyR2Tj5c4fiMxt9AxcGKqODSBAhcvI+qX9+Aap1U
	9ddfm1RHY+9rsY7yWhuebo3aHzoDvR3hS6phYk9xBdVDkhNwOxMsgnxuDSOggyu5s9Q==
X-Received: by 2002:ad4:5747:0:b0:91b:9496:6a18 with SMTP id
 6a1803df08f44-91c7d1ae53bmr83041376d6.37.1793278361370; Thu, 29 Oct 2026
 05:52:41 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 05:52:40 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261027154649.91571-12-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com> <20261027154649.91571-12-griffoul@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 29 Oct 2026 05:52:40 -0700
X-Gm-Features: AclHuK85LBuCmtDdaaOWg4OEyIMQUVa8mDtLyPY6JdCBNPTut6N07RXjZEiRQWQ
Message-ID: <CAEvNRgGn09qrCZjUM5sdqQohPWE62GN4c52iK7ZV_gi5wro_Ww@mail.gmail.com>
Subject: Re: [RFC PATCH 11/14] KVM: guest_memfd: Add kvm_gmem_restore() for
 PFN mode providers
To: Fred Griffoul <griffoul@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Alexander Graf <graf@amazon.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Alexey Kardashevskiy <aik@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, 
	Ashish Kalra <ashish.kalra@amd.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Baolu Lu <baolu.lu@linux.intel.com>, Bill Wendling <morbo@google.com>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Connor Williamson <connordw@amazon.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Hildenbrand <david@kernel.org>, 
	David Rientjes <rientjes@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Erdem Aktas <erdemaktas@google.com>, Frank van der Linden <fvdl@google.com>, 
	Gregory Price <gourry@gourry.net>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	James Houghton <jthoughton@google.com>, Jan Kara <jack@suse.cz>, Jianxiong Gao <jxgao@google.com>, 
	Joerg Roedel <joro@8bytes.org>, Joey Gouly <joey.gouly@arm.com>, 
	John Starks <John.Starks@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	Justin Stitt <justinstitt@google.com>, Lorenzo Stoakes <ljs@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Michael Roth <michael.roth@amd.com>, Mike Rapoport <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Oliver Upton <oupton@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <shuah@kernel.org>, Steffen Eiden <seiden@linux.ibm.com>, 
	Steven Price <steven.price@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Tarun Sahu <tarunsahu@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Tycho Andersen <tycho@kernel.org>, 
	Vishal Annapurve <vannapurve@google.com>, Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
	Xu Yilun <yilun.xu@linux.intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, x86@kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Fuad Tabba <fuad.tabba@linux.dev>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, llvm@lists.linux.dev, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fred Griffoul <griffoul@gmail.com> writes:

> From: Fred Griffoul <fgriffo@amazon.co.uk>
>
> A device cannot fault, so when a PFN mode provider gives frames to pages
> that had none, or makes a read-only frame writable, a subsystem that
> maps the file must be told.

Totally makes sense that guest_memfd needs a way to actively map pages
into the IOMMU page tables, rather than passively like for userspace
page tables and stage 2 page tables.

When the memory is owned by guest_memfd, on a to-shared conversion,
guest_memfd would do the mapping for IOMMU, which can't handle faults
like Stage 2 or userspace page tables.

> kvm_gmem_revoke() does not fit: it would
> zap the guest's and the VMM's mappings and reclaim frames that a guest
> may already use.
>

I'd drop this paragraph from the commit message, kvm_gmem_revoke() is
the complete opposite and isn't a candidate at all for the goal, which
is to notify importers that a page is now available (and they can map it
in).

> Add kvm_gmem_restore(), the counterpart to kvm_gmem_revoke() that the
> sample provider leaves for users that cannot fault. It only updates the
> exports, under the shared invalidate lock.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
> ---
>  arch/x86/kvm/Makefile       |  1 +
>  include/linux/guest_memfd.h | 37 ++++++++++++++++++++++---------------
>  virt/kvm/guest_memfd.c      | 35 +++++++++++++++++++++++++++++++++--
>  3 files changed, 56 insertions(+), 17 deletions(-)
>
> diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> index 25fb3d6e2032..3255280884b5 100644
> --- a/arch/x86/kvm/Makefile
> +++ b/arch/x86/kvm/Makefile
> @@ -63,6 +63,7 @@ exports_grep_trailer := --include='*.[ch]' -nrw $(srctree)/virt/kvm $(srctree)/a
>  				-e kvm_write_track_remove_gfn \
>  				-e kvm_file_to_kvm_fn \
>  				-e kvm_gmem_revoke \
> +				-e kvm_gmem_restore \

provider --1--> guest_memfd --2--> IOMMU

2 is definitely required, but why is 1 required?

Between the first .get_pfn() or .lookup_pfn_range() () and
.put_pfn_range() or kvm_gmem_revoke(), the provider should consider the
memory in-use by guest_memfd.

When it's in-use by guest_memfd, then guest_memfd should use --2--> to
map into IOMMU page tables as necessary.

When it's not in-use by guest_memfd, why would the provider force it
into guest_memfd?

If the guest VM knows that the page is now usable (some other
communication channel), it would touch the memory and do a .get_pfn(),
that would be successful this time. Perhaps that's when --2--> needs to
be performed?

>  				-e kvm_gmem_export
>
>  # Force grep to emit a goofy group separator that can in turn be replaced with
>
> [...snip...]
>
