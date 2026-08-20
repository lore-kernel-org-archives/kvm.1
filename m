Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75DA379C28
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787237276; cv=pass; b=EYLxbO7Umt+HHbgaAuFI7wP8YBXbrsv/OyfVsXngUE+AHLc+GcRzNEpaJ8bX3SiBAHcdk7XzXUgkfWSLFv0tz2TZwrTYd9KNhwDO4/cffyQCE1tjMuV6VwDZB4TtlO0hsgepWuhi0uD8vy2U5e9+QyV5wpR90Y5Gw/r9flEk37k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787237276; c=relaxed/simple;
	bh=r2hCL7XoFnqzQ8NQfsCqgeEbkv/DQ0+Almk3HSia9aY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjz4i0CvXJjENJ0we2sjYoUpaHzRmlsdAubgd+moBvTZLpdsGLVMv+eB2xi+y7TzkfR8yd/S2MihwguD8Wr1zt6rrkVYwx+xWwop5WbeoWBBMt8wu+liOtEX11hD6KW8kRkfvf/DDXW5IzkmIbREPJ83+HlpuatqVhs7SpdYe60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I5S0kC68; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I5S0kC68"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90c4e297a01so15601826d6.3
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 07:47:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787237273; cv=none;
        d=google.com; s=arc-20260327;
        b=NCVaGBKWdt+LPYSBIhlE3GWKhM3nGv/fxglTQRoHbbPgXV+k1ioqP6nHk841IexN+K
         DcGd7pORp2p4EAxeGn0ehDSUqzJSzp41sxR3oh+C/QEeHeDafFFZFRII+6sG39hwoMPi
         CoTOCQX86nfOh/kdS+V41yOOnPNYEpXkA2N2u7GtOnx7Ald9WvYNK91olOK9hHIRoZYA
         84DxqjZIFS4WjBVCAgpFiwMXk5tuobn7RYuFA8EU43RXWTE1qI2C4+Y24cm7uUTSRSyt
         mseIJ9fAsZFyWh2YGvLjjzJt6g9D+jDQqo9q4sNUEsPZpjzIt1TBep9LaQW+GOYFSMby
         arjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=wW5t0G/U8sBPBIi/hy7+eXOaj+vhlsnXo8EJATEvXbc=;
        fh=w8I//9pCvz02jFTLRDRX8hAZWD2wD4tQutqQccGf17M=;
        b=pYGJib7X9SAlIxWT2cSd+n+nPFuYAyOmPW12PotyolQtYu/6I0IGUIb68BKj8Bl6DO
         XXpqjftJvqa8tzvVmDyksEffraX8k10o78aJcL9KuUtrc9PnzS9IKeJYVeCjFGJmXVuz
         aAA7WFvFKCyTIHbAEkgs2TH3i7RmduazfqhStNeofKIRoxQiVKQ56w2Q4hI6W7An+F31
         VTypciYTr92+kpBt1LuWCy1V1h2jyudhD7uwzjFlkKA1pMVWQzkJ5xHglI/f12+iFtWC
         RtGrBMz+WLMDXGcr1qaUPzXKISwPpABmxi9P6fUXFMlIXgeXf3yOJK5L1eo+JdAcv97D
         2uLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787237273; x=1787842073; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wW5t0G/U8sBPBIi/hy7+eXOaj+vhlsnXo8EJATEvXbc=;
        b=I5S0kC68/eRkBV1r15BhDQIWgmW8OTQzTwsA3EOY9WDEqiENCUe38ft1QkTKAxOLyx
         mONFp7Cfa/FPXwGKoIg6v/SQN9cBFu66vsTtFQr5JITPhA3dYmeLmzDjeuL7EUa/UXU1
         PENCtb1gxFRgh1gQxJCDFF6Wr86yeCBy5p1iDruIeLPO733w7OsvPzojyLnAEcxdTk0k
         ubCwt19UANGog6fCov0Jo9YqWycbfwCy72W8DgiK5z0LdEBEgWbtbAIrPsGCQHLvwdHH
         0qnipBlY4ce1Ihnbdo3c0X+YHhOkoe/gJ3AVsc64EvDSWf/p4MzO94koNETUwZOHUAL1
         Oipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787237273; x=1787842073;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wW5t0G/U8sBPBIi/hy7+eXOaj+vhlsnXo8EJATEvXbc=;
        b=OfrkgyjsNP84JV9k+tNvtEsXhTOoQpI7d72fRCHO0a/tsorsFX/tUAmmdS9pac9c9b
         gp44Ocpo7ko3GwDr3a3blMYwJg32X4Li70NKRBAZ+3U8QHKZr6Myi/cIV/ur6WM5Tvsj
         guPJHqPc8RidAQnEHRGtZCpeS4MiF781y8A11qQ08MLvkJKXL6SL0orQ4Ld0/I9WGRlJ
         Id2Y7PIMZkiLzrAffTcE/abStbnIzL9xOW0b5P7uPCBqfmdkwrSmvOfjuAnUiEwFKCVE
         mOlDgY4yTg3coJVjGJgcbrQFMnDmX5Kc0xCEi9tN+yNt/80OuylqG+r/gnoEUjxNGikd
         Pang==
X-Forwarded-Encrypted: i=1; AHgh+Rrjqhj0b6q8rDfcIPIPgsjAu03yRUS7Ypit6vUZuT/+nypgHUwEkju91RRvQyKj94DETXw=@vger.kernel.org
X-Gm-Message-State: AFuF++mTET1o8R8BZf7Bg9sGNkKHx5DiqjdpqlsA8XxePuS44VWwdXeL
	qGosP6fekENCkYRRnkJVwi5vIOMb954k5ROYSHJhX2D7TXyYnb1+2AgQUwuNdw+zkQWc2FHfDV2
	Ut01TQJjhn2OnCMjetRVoJ1dVHzv1+25zVxRBUzhH
X-Gm-Gg: AR+sD13x8jqwst85t8MTC9vwyW8uqzStYU55u7rCDAoiby1vzP4tirq9+/ZN4SYwtPd
	nacmnAo5gzAQCFraTiJ2hn7s6ZTlPioug1vG1/txPx8PG2Tqsv2faVPh6nUFV3pO331X70FudpO
	hNLgXA5iH8+8qjVRtViJKa+igA90HktoORexE7OIFLZr5vOaa28NATkj+kFL0Difp8vF3zO6N6a
	WDUyoBfsW43fcvE5orcFm0A5qCU8rdLCH6QMvXv8kgCmh97NnBISuV3Hzg6gAGI5GKeNT1Jo1FK
	q8sXhZkvhi5YqEJXMp8kaBDQ6RXAdS6b6AQ1oVQdQ26E6fKoS4d+oleapFnTjPmmebwaRBF6SEK
	JC4U=
X-Received: by 2002:a05:6214:401:b0:8dc:2c21:32bd with SMTP id
 6a1803df08f44-90c5e68b4abmr133956736d6.1.1787237272678; Thu, 20 Aug 2026
 07:47:52 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 07:47:51 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 07:47:51 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aoVut/h1u7HdFxkR@yzhao56-desk.sh.intel.com>
References: <20260818-gmem-no-return-page-v2-0-5298f42d49bb@google.com>
 <20260818-gmem-no-return-page-v2-4-5298f42d49bb@google.com> <aoVut/h1u7HdFxkR@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 07:47:51 -0700
X-Gm-Features: AcwNN1WYYXv3T1n5AIJ_TiYtLTY6vDd5CVOeUwq99s4OCRdrQcgzzR3vkPd99ho
Message-ID: <CAEvNRgFFs2BC7m8YH7RnQSysU+eDqOjQpqAxL09mwJgrT_iYww@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] KVM: guest_memfd: Stop returning struct page from
 PFN lookup
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, David Hildenbrand <david@kernel.org>, Fuad Tabba <tabba@google.com>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Vishal Annapurve <vannapurve@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

> On Tue, Aug 18, 2026 at 09:15:55AM +0000, Ackerley Tng wrote:
>> From: Sean Christopherson <seanjc@google.com>
>>
>> KVM currently expects guest_memfd PFN lookups to return a refcounted
>> struct page, which callers hold across fault handling.
>>
>> Holding a page reference across fault handling is problematic for
>> guest_memfd. In-place memory conversions between confidential
>> computing shared and private states inspect folio refcounts to ensure
>> exclusive ownership by guest_memfd. A concurrent guest page fault
>> taking a reference on the folio causes conversions to fail due to an
>> elevated refcount.
> Nit:
> As this series is based on kvm-x86/next, where there's no in-place memory
> conversion yet, kvm_gmem_get_pfn() does not hold shared filemap invalidate lock.
>
> However, the benefit of dropping the folio reference immediately before
> returning from the guest_memfd PFN lookup -- preventing conversion failures due
> to an elevated refcount -- should be effective only if the reference is dropped
> before releasing the shared filemap invalidate lock.
>
> Do we need to make this info clear, since I think it's important? :)
>

Is this what you meant?

  In-place conversions uses the filemap_invalidate_lock() for
  synchronization of shared/private state. In kvm_gmem_get_pfn(), the
  PFN needs to be prepared according to its shared/private state. Hence,
  the filemap_invalidate_lock() is held while guest_memfd gets a folio
  and decides to make private before returning a PFN.

  In kvm_gmem_get_pfn(), the folio refcount is dropped before releasing
  filemap_invalidate_lock(). This ensures that a competing conversion
  grabbing the filemap_invalidate_lock() will never see an elevated
  refcount due to guest_memfd's folio-getting process.

It seems a bit weird to fit this into the commit message for this
patch. I think I could put the above two paragraphs into the patch that
introduces the filemap_invalidate_lock in kvm_gmem_get_pfn()?

>> guest_memfd already notifies KVM of page invalidations, so callers
>> within KVM only need to respect the MMU invalidation protocol to safely
>> rely on guest_memfd for page presence.
>>
>> Furthermore, removing struct page from the guest_memfd PFN lookup moves
>> KVM closer toward supporting memory backends that are not backed by
>> struct page.
>
> Could we also explain why the lack of SetPageDirty() (and mark_page_accessed())
> for a gmem page, due to NULL being passed to kvm_release_faultin_page(), is
> harmless?
>

Sounds good. What do you think of this, continuing from the paragraph
beginning "Furthermore":

  Drop the folio reference immediately before returning from the
  guest_memfd PFN lookup, and stop returning the struct page pointer.

  ARM's gmem_abort() is guest_memfd specific. Since guest_memfd no longer
  returns a page pointer, there's also no need to do any
  freeing. kvm_release_faultin_page() originally also serves to set the page
  dirty and accessed under some conditions. The dirty and accessed flags
  don't matter for guest_memfd anyway, so it is safe to just drop the call to
  kvm_release_faultin_page().

  For ARM's kvm_translate_vncr(), initialize the local page pointer to NULL
  so that the shared cleanup path that releases fault-in pages safely no-ops
  for guest_memfd.

  For x86, no additional changes are required in the MMU fault path
  because the page fault tracking structure is zero-initialized at the
  start of page fault handling, ensuring the refcounted page pointer is
  already NULL.

>>
>> [...snip...]
>>
