Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793293675;
	b=S/9qfxzdfZGBNVn1JYpLaPs1MjbgShCT6gHxadA5y+BwzIIIkmEHjs3t883JNUqof27K
	 rZXVvYMzciglN8IRpYsiF/jh6Lq3SCtNtYlVWzmVq+TTMAsgd+QDnpeG1OYXbeaJmJ7N1
	 9GUcFHC0uHrttlMz88NQkwTgqdGUbPI4Y7VUQcJrIFxqk7aoEhJlZgH/0nOWi4tnAEIbU
	 QyHctp1osv3pTSbavGD464g6twFhmKmuSy64OZJ+ijim5ZnhTQ2GGpKaijmKYEbDHDkhA
	 UMiSPzou2Ah/VXLydTy3EWYwAojqi8eU7od19RyEqKDXuSQI1linqJdvl7jHIZYctzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0YjGbXSGdFWqGTw7iXBWdHWj/MRYXXZreyMjEGvCLmY=;
	b=z1MgRPYl6xrnEGWR1BB8/NravuU7N9ilFNTKYGb+RhsJJG8LsE9S39xftXWmsbk5Rgso
	 AlmsqY10egO4MOpWmAUWFUgbWp7DzxS/au7P3fdhHTS6pzEma/tZjxaToSSYOAEn15BfF
	 rkhXr6o7UuLgCW9144FBfPcPEz3IasDJzTeyzuIGp2Zh0VftaeQvTtsqjT62f1fojfN6K
	 71hA0lipM7c9Ph2RdLuvqDO1IGq66EyViVJFWmC5NYOd3nbBCV3CQIdnaH3H1mmV3MM7q
	 9X3y2ctmNCEKan9df064pxz4s164ByVbtBExQ2Kq/8eayISOFEFUq9hiXX/WV2kc2Dw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MuWAqUZR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479B4606A323
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 17:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 479B4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MuWAqUZR
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso432270566b.2
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 10:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793293672; cv=none;
        d=google.com; s=arc-20260327;
        b=CEYvRZjpCyPSlJ65MGEUV85AjtsDyyiC96hul0ubLgRiohAYRSLVvsyzNcjXL6pv/f
         3sCCf62w96+HdACYdTcWiUc1A87uHnpAyrHZlxC2b+b64ngM3kp9ABu9F1rjz/W28DYG
         MD365B/Y/AK+nVdF0A9xrzX0XKHLAnS0UWasXsyaEOpEVHcG5CnIC1gqAiloFzSVmsCx
         grFi2zuSPJEajrf9YLggc90lPat696qkpxnYEwvCZ1Xnyy3OC7AhnO32KMzDoWPzqwXg
         U1JchJXRmP27uxEXeZl9+Z7SDOxHE66ZfGuPSrnpIRe7uojg4YlvkwuLuiIvKAGlO8fc
         EVFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0YjGbXSGdFWqGTw7iXBWdHWj/MRYXXZreyMjEGvCLmY=;
        fh=PrZ1jzHINibOApjQ3D+MOIeClYSmQSju2FvEhggr0oI=;
        b=YPn/dInmXHIByrrygTdEEIOWZin08HoAZfIEzjyNJKB4NktL6+HzfKgRJh7maVTES3
         uzfb/7MnwLHuPjIBteXt4AgKl8T/qYWSni4XEVZVuTDce53hFaXZzzEHUYcp7S5uH2rv
         N9r19he5OGxKG7vUMqDH9Ft713pMhd0PbKUG7VaAA7eMN8k5hiajZMMr5wM1CKL27Rxc
         IPtMGU6ZFt/YNtiB4wD/lm6Ct7AWB6jK77wjaoGfclmiamzrvUdebgVoeNGwoOh4BQde
         TVF+ZFoWw6pvyyXIbVq9L11T9XbEEG5sVPkfNp0gW4qKjMKMbYFvLv3vKdbJqVN9RBn0
         1LNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793293672; x=1793898472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0YjGbXSGdFWqGTw7iXBWdHWj/MRYXXZreyMjEGvCLmY=;
        b=MuWAqUZRlat6aJ6f8GSESPnGQrfK9syg40aZf1Ngw4XasvhbbIUdsMyG95RGl30Qzz
         9Yxe0i/egPCaT2iDSP9o+SPOXxQDDHkvTy3Tmbsi7gHFPDFfNRdbgAMu2ri/XRuLOU4P
         w/N5pfbyO9+Mpyr56qJnr5Sli9u08T7aPzZBRGkJDhg+UkYzIxyUfOXZhvpgOXisSD+b
         zn44DE015kKSRc0VnLzrd7UMO1HCWL8nTrMaQf75CEoS8svAUUSwo8/rKdYyb+ti+XeW
         +ALiAdTd1CasSqLpNDr1GyAgjW6d36Qz7JKGCZD44Z9QbmaWAcCAiRBe1yPTRf3qPA3x
         QBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293672; x=1793898472;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0YjGbXSGdFWqGTw7iXBWdHWj/MRYXXZreyMjEGvCLmY=;
        b=MhDvIntmuURGSqtP0dyb4OHsH6T6lr16hZ7/qyGaGCpEkR+/zVN4KmOFMOvwunaAFU
         NsATCwRUZUS9ln8yvmo8dqpHA5zz03wlnjLOJ3ABpU8BY7w02eq7RuKBOnvzwrKXfJrN
         TBCE1c5yaF8h8eD8sIpKD0/DUFPm4/8bn9o1VgClTTSwAb0cSrfqvt9sb5GQo3G/Fsqw
         nrlNrX/l/4YSO8p7YUsjTjnoSQIH7BayT+ArlQhsGauN58mGNyDqj3UZD6tO0WpIewqB
         jLJZgz2rbRIIJGBsC94G3xmVm/jSDyWwHRfT46hNmZq8CLFfUVq87XvZueDoILOsXIxG
         LcRQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4YS4GXk3Avgtt8n3O0y2tKMw8BfCnp/5ApJV5ijZ6aBl7Puo3LoIul/EqyEQJ95TBLDk=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3IOS/0senvhVik333jfeGz6EacmAf11yTUtHnrlRD2SWNXnf1
	ZI271xpQSfaWZ68xrZyyvjMS7YpN5naf5ge0TRC49lO6adBEM5yd/ZGz1KQPpOLPgANMRMeUin6
	vD/dO7Le4Pm8hJdpGCOLK7kxVJJm2iWQ=
X-Gm-Gg: AYBFou32exmyxITP70poPR4hKkwzZabSwWK40TyohstgoneKU3ajrcfPs9BLt0jL6+P
	ymfZzsutKZpRYYKLH8fwVyXJPbUciR9xwZkKTpR9Kuy+QT7rDW1nc0svl088dqp5+HONz0QiT0r
	0Gw5YQS9khf4g5IwpjWUxOsVdsOaIeiVMMWjn6uiC8+TeSCSvi/5cUrblPTHFm7oM/Z2rrPnCL2
	YoUxfcGchOLLrhZeS35RvnzQlK5T0P1TuLMH9Mko+zHyrPzzS+kI7j75Y/YprXrz+ZVh5J/O4vv
	jpmiB8OxZt9VsUEp9tSf5lk//3Ts+CHIITKt2ECHIVFFE41F6I87CzoJW0Elo4CJwxk/gnDkNZL
	G+x698o0pk87XHSawPySCa+2/kT+iuQTNyNguS/H8csnSJuTOBbdwE+7KNaj1TWOIF0xc/BJjHZ
	GeF4MqxLxBE62JL1A=
X-Received: by 2002:a17:906:7313:b0:c45:c030:732c with SMTP id
 a640c23a62f3a-c49be03a73amr610119866b.41.1793293672256; Thu, 29 Oct 2026
 10:07:52 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com> <20261027154649.91571-2-griffoul@gmail.com>
 <CAEvNRgGvxtgT=x3sLcasLZzCrtX+qEkHjPgs2yFRY0HRJvodag@mail.gmail.com>
In-Reply-To: <CAEvNRgGvxtgT=x3sLcasLZzCrtX+qEkHjPgs2yFRY0HRJvodag@mail.gmail.com>
From: Frederic Griffoul <griffoul@gmail.com>
Date: Thu, 29 Oct 2026 17:07:41 +0000
X-Gm-Features: AclHuK-XOTTZ577Y9tlQyUF1DU-1w6QS3FSXEW1jGcpzGvSeAxBjghFI3p-6WVU
Message-ID: <CAF2vKzP7mKAsbDFfj-ndoYSxxZYbNzVO7uysb-XtKytR4zuC7w@mail.gmail.com>
Subject: Re: [RFC PATCH 01/14] KVM: guest_memfd: Clamp the order of PFN mode
 blocks to what KVM can map
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Alexander Graf <graf@amazon.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Alexey Kardashevskiy <aik@amd.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Ashish Kalra <ashish.kalra@amd.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Brauner <brauner@kernel.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
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
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 06:25:49AM -0700, Ackerley Tng wrote:
> Fred Griffoul <griffoul@gmail.com> writes:
>
> > +        kvm_mmu_invalidate_range_add(kvm,
> > +                         round_down(gfn_range.start, blk),
> > +                         round_up(gfn_range.end, blk));
> > +
>
> Yes, we want to make the invalidation range larger, but not the range
> being zapped. We can't over-zap for CoCo VMs.
>
> Would it be better to refactor kvm_mmu_unmap_gfn_range() instead of
> doing kvm_mmu_invalidate_range_add() twice?

Good point. As far as I can see, kvm_mmu_unmap_gfn_range() is only
kvm_mmu_invalidate_range_add() plus kvm_unmap_gfn_range(), so
guest_memfd could do the two steps itself: add the blocks around the
range, then unmap the exact range. The zap stays exact and the range is
added once. Or am I missing something about kvm_mmu_unmap_gfn_range()
that a refactor would need to keep?

> So I think we should follow the same model:
>
> + The provider reports the max_order based on it's contiguity
>   information, which is the actual contiguity of memory and
>   read-only attributes
> + guest_memfd further reduces max_order due to shared/private contiguity
> + After handing it to KVM, KVM further reduces the max order based on
>   the above.
>
> I think mappings for all other page tables (userspace and IOMMU) should
> also follow this approach.

Agreed. guest_memfd should then only reduce the order for shared and
private pages, and drop the gfn alignment and the rounding to a
page-table size, which KVM does. For the provider, "contiguity" would
mean a naturally aligned block of contiguous frames with the same
attributes, the frames aligned to the block too, so a mapping of that
size is valid as is.

One gap: KVM does not cover a memslot whose gfn and guest_memfd offset
are not aligned to each other. On x86, kvm_alloc_memslot_metadata()
disallows large pages when base_gfn and userspace_addr are misaligned,
but nothing compares base_gfn with gmem.pgoff, and kvm_gmem_bind()
takes any page-aligned offset. A gmem.pgoff check next to the
userspace_addr one would keep that in KVM too.

The export lookup in the series already works this way: it reports the
provider's block, reduced for shared and private pages. iommufd maps
PAGE_SIZE IOPTEs in this series, and will pick larger IOPTEs from that
block later.

> I guess the kvm_gmem_fault_user_mapping() equivalent of this max_order
> tuning is missing from this series. :) I think we should defer order >
> 0 to a later series though. I think read-only-ness should be part of
> the first PFN mode series.

Right, userspace mappings are PAGE_SIZE for now.

Deferring order > 0 for KVM and userspace is fine with me. I'd like to
keep the order in the export lookup, though: large IOPTEs matter for
device performance, and I'm preparing iommupt changes to split and merge
them in place.

Fred

On Thu, Oct 29, 2026 at 1:25=E2=80=AFPM Ackerley Tng <ackerleytng@google.co=
m> wrote:
>
> Fred Griffoul <griffoul@gmail.com> writes:
>
> > From: Fred Griffoul <fgriffo@amazon.co.uk>
> >
> > KVM maps guest memory in 4K, 2M or 1G blocks, and uses guest_memfd's
> > max_order to choose. A folio of order N is physically aligned and never
> > mixes shared and private pages, so the order needs no check. A PFN mode
> > provider's frames need not be aligned
>
> I'll need to think about max_order > 0 more for PFNs. I put it out of my
> mind because my frame of mind is that only order-0 folios are supported
> today. Perhaps with PFNs it's actually a lot easier to support order >
> 0.
>
> > and the provider does not know
> > which pages are private, yet kvm_gmem_get_pfn() passes its order to KVM
> > unchanged. KVM can then map a block over the wrong frames, or with one
> > attribute over shared and private pages.
> >
>
> Yes, makes sense that private/shared contiguity needs to be taken into
> account. I didn't consider this because order-0 is always safe to
> map. Thank you!
>
> >
> > [...snip...]
> >
> > -static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t s=
tart,
> > +static void __kvm_gmem_invalidate_start(struct inode *inode,
> > +                                     struct gmem_file *f, pgoff_t star=
t,
> >                                       pgoff_t end,
> >                                       enum kvm_gfn_range_filter attr_fi=
lter)
> >  {
> > +     const gfn_t blk =3D kvm_gmem_is_pfn_mode(GMEM_I(inode)) ?
> > +                       1UL << PUD_ORDER : 1;
> >       bool flush =3D false, found_memslot =3D false;
> >       struct kvm_memory_slot *slot;
> >       struct kvm *kvm =3D f->kvm;
> > @@ -355,6 +360,16 @@ static void __kvm_gmem_invalidate_start(struct gme=
m_file *f, pgoff_t start,
> >
> >               flush |=3D kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
> >
> > +             /*
> > +              * In PFN mode, a fault may map a block of up to PUD_ORDE=
R
> > +              * pages, sized before this invalidation (see
> > +              * kvm_gmem_pfn_map_order()): make faults anywhere in the
> > +              * blocks around the range retry.
> > +              */
> > +             kvm_mmu_invalidate_range_add(kvm,
> > +                                          round_down(gfn_range.start, =
blk),
> > +                                          round_up(gfn_range.end, blk)=
);
> > +
>
> Yes, we want to make the invalidation range larger, but not the range
> being zapped. We can't over-zap for CoCo VMs.
>
> Would it be better to refactor kvm_mmu_unmap_gfn_range() instead of
> doing kvm_mmu_invalidate_range_add() twice?
>
> >  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> >               kvm_arch_gmem_invalidate_range(kvm, &gfn_range);
> >  #endif
> > @@ -374,7 +389,7 @@ static void kvm_gmem_invalidate_start(struct inode =
*inode, pgoff_t start,
> >       struct gmem_file *f;
> >
> >       kvm_gmem_for_each_file(f, inode)
> > -             __kvm_gmem_invalidate_start(f, start, end, filter);
> > +             __kvm_gmem_invalidate_start(inode, f, start, end, filter)=
;
> >  }
> >
> >  static void __kvm_gmem_invalidate_end(struct gmem_file *f, pgoff_t sta=
rt,
> > @@ -670,7 +685,7 @@ static int kvm_gmem_release(struct inode *inode, st=
ruct file *file)
> >        * Zap all SPTEs pointed at by this file.  Do not free the backin=
g
> >        * memory, as its lifetime is associated with the inode, not the =
file.
> >        */
> > -     __kvm_gmem_invalidate_start(f, 0, -1ul,
> > +     __kvm_gmem_invalidate_start(inode, f, 0, -1ul,
> >                                   kvm_gmem_get_all_gfns_filter(inode));
> >       __kvm_gmem_invalidate_end(f, 0, -1ul);
> >
> > @@ -1535,6 +1550,44 @@ static struct folio *__kvm_gmem_get_pfn(struct f=
ile *file,
> >       return folio;
> >  }
> >
> > +/*
> > + * The order a PFN mode block can be mapped at: the provider's order, =
no
> > + * larger than the alignment of @gfn and @pfn to @index allows, rounde=
d down to
> > + * a page-table size, and never over pages that are not all shared or =
all
> > + * private, since KVM maps a block with a single attribute.  Called wi=
th the
> > + * invalidate lock held; an invalidation of any page of the block make=
s the
> > + * fault retry (see __kvm_gmem_invalidate_start()).
> > + */
> > +static int kvm_gmem_pfn_map_order(struct inode *inode, pgoff_t index,
> > +                               gfn_t gfn, kvm_pfn_t pfn, int order)
> > +{
> > +     u64 misalign =3D (gfn ^ index) | (pfn ^ index);
> > +     u64 attrs;
> > +
> > +     if (WARN_ON_ONCE(order < 0))
> > +             return 0;
> > +
> > +     order =3D min(order, PUD_ORDER);
> > +     if (misalign)
> > +             order =3D min_t(int, order, __ffs64(misalign));
> > +
> > +     if (order >=3D PUD_ORDER)
> > +             order =3D PUD_ORDER;
> > +     else if (order >=3D PMD_ORDER)
> > +             order =3D PMD_ORDER;
> > +     else
> > +             return 0;
> > +
> > +     attrs =3D kvm_gmem_get_attributes(inode,
> > +                                     mtree_load(&GMEM_I(inode)->attrib=
utes, index));
> > +     while (order &&
> > +            !kvm_gmem_range_has_attributes(inode,
> > +                                           ALIGN_DOWN(index, 1UL << or=
der),
> > +                                           1UL << order, attrs))
> > +             order =3D order =3D=3D PUD_ORDER ? PMD_ORDER : 0;
> > +     return order;
> > +}
> > +
>
> I'll review this function more closely again. I think the mapping order
> should fit into how KVM does it. After taking guest_memfd's input on
> max_order, KVM then lets these parties possibly tune the max order down:
>
> 1. lpage_info contains information about highest order due to memslot
>    alignment and alignment due to VM-level memory attributes
> 2. CoCo platform can impose a max order
> 3. Userspace mappings can impose a max order too.
>
> So I think we should follow the same model:
>
> + The provider reports the max_order based on it's contiguity
>   information, which is the actual contiguity of memory and
>   read-only attributes
> + guest_memfd further reduces max_order due to shared/private contiguity
> + After handing it to KVM, KVM further reduces the max order based on
>   the above.
>
> I think mappings for all other page tables (userspace and IOMMU) should
> also follow this approach.
>
> I guess the kvm_gmem_fault_user_mapping() equivalent of this max_order
> tuning is missing from this series. :) I think we should defer order > 0
> to a later series though. I think read-only-ness should be part of the
> first PFN mode series.
>
> >
> > [...snip...]
> >
