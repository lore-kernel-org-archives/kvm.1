Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792613832;
	b=FhwKhQyVcfmKBHJUbhCbwjpXP3C8/5ywAQA/hYGnmjZGw/la7mD2anrmuBZWWQpHBe6E
	 0PlXFFWZsH7VwF59MrBZt7SVhMf9ey0e5vHl31Sg+LC72XtNrtH14iY7En0Jw6u7W8/Mz
	 egHTrIjonGziWCiPa4KAtTNwEvrcl0kySD5RyEgNFrcGkF61dXwAQBSfkNvOBUirM9XJh
	 tugB/8bYFO5lmMkB5NIz7hTFvnTSmEqTomQHgIf0dYHhxJsuXIYSvexQSsl+3RsfckpmX
	 qeB2Ca2Lg7PrUr4bCtvSmoyxd+0uHUQBOJYXw+YJlrza0OEPabfkjuKF5F/7GYVs9JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792613832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=At2A/wrqaAUfI4SKCwlEtMqC27pXN2/myITaZPv60nw=;
	b=aHBPemc82KeXn0apwQdBnSG6M7wEggvTktaQH0QUamsrRMdiT/hI7OtX3qWCmPSZjI2s
	 vH4aPIetlUpde5wpnk2+Br6zI+/rV/OfNM0I4kpjxx45sExfsCvki1AVFTE+x4qvmKpFv
	 8PywQLZ9eUHNO1EHrIbyTm8biILhamRnGqilCpofeCo5JYXTIjmrX3pcfQ4pnCKmoLyrV
	 q6Mnuxry9PMWKfDHl55uGqvYE931ws6dnFx46bM9lS1S8cPcoSRaLKtAlBJ5Zx79x04vH
	 rtvyvxnre/n9U0pigL7PRLee+a2cUCN4DZ/CqG8TdeGYB8G/BUpVPzBg6cE6ENhkMqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=oyFHm1Hz;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33F2606A328
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 20:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F33F2606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=oyFHm1Hz
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2db33db4de9so16865ad.0
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 13:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792613831; x=1793218631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=At2A/wrqaAUfI4SKCwlEtMqC27pXN2/myITaZPv60nw=;
        b=oyFHm1Hz0h2Qlknv1vsiheGJvlBp/hMgh02PzQTmYUIg+yqjimNbrLTG6YVDmdzSj7
         2h924ZyPg/b7FshKCBPU8Wf34MK3PzDVh+JJCflUO1RAYaHXuXv6wBxYmUiPzwczzC6w
         bGq67afFW30YUC+3zqYUjsX+7MoFVd5shYJCWSFseb2owxnYIjTAwTaK0aitNp4y5CHx
         5ok324KMIwDUZkyogu3Gc+7rODb6jTgVHOgl4UjYKgFk3g+pst9EPpMXc/FwibEyyGkO
         qbqM8aNdfBuih4c2QUv78AaB1MBNwVz+BUwlbiexmEA7RaPQMZ/69mzqr76MJIUIK66u
         ks6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792613831; x=1793218631;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=At2A/wrqaAUfI4SKCwlEtMqC27pXN2/myITaZPv60nw=;
        b=uspLGZHbr4Erc6Yn03OFjx53Im2WKMgoyt2108ViEiEdjEqG7J64CzpaT6fmVEkfJd
         LENqPrwoL+H3Dna0dJx1x4Y0RrUpUkm8vZ5e51ufuUMuL0hPrcKRS6FxczBNfdM+TXjT
         /eByntScAkUWVgu+dAy/iUASKyplXqjPHyYuBI0q1khIpk9n15XixyqGMEyG8lPJ1Ghk
         EV6UZ/K0iZ6Wtha1ClNARMYXOE0F1lfIMxqUHBRNRWAd1F3nwK5WvSGvJqwzqdcx1hnr
         FD4PG+kLmil8uV/Xu9KxuhOdUUMR3HD1WOOp7JwzQljK7WE6gK8d7dv27Dqz0TVEg/oH
         s9FQ==
X-Forwarded-Encrypted: i=1; AKwUvByhI8hVi4uFdp/BBMv1/JPew81fzpBf8PBYCowuMHTBegrkyfv4bYQxJZQRjYPK1tzyt4E=@vger.kernel.org
X-Gm-Message-State: AFq9FYK19CAVNSXyYpnh7rJDs3EkVTs+HrAhbzXOpt2nGClPX4mSlV7n
	m2vzAbAc1jFSDwqEnH4/FQHz4F2R6IaG5caZXE3jj515vHRbT+2ho+KRr3TUf7aMWw==
X-Gm-Gg: AYBFou0ryP0RJmD0VrLoijCBmD6Y1c6ZnrCh2FjtHPLgLLBy5FLryRAwPeiOhhKOV9J
	I02Dx0Mbqq60BAzTtCQ606zpHfCkTl3a6AftPUJSfh8oMqmDNM3TIQMA7IhN9LEMoAEc2q1njnf
	6UNEolJth2Z/KXhJtD7nLUo2X3XrQ0ZzzMsukyJzLFfezlOYteF6Bo1pZYBDke24kPf0hF7g/V+
	FBT4Sm84XKaic+HPqAKsiwtlb6LxUybmy2rzJTVHL0k/dqPfpjltqk8dECGv1g2uDkVUQabkeKb
	j/gCKnIJU+AJwzPx3icwVj4xAuIs18g1X6lImtVOfLe+qGVWE8uzYB7rG5io4gGKX2LjDx4ZAih
	CpWsTE3gkEY2DTeUUm4NV0UMs+6qaOS6SwBK434DfOquoZ2uDVIQV7IRO1VlPYlSoOT4ZF3hUSN
	Mr0Ht6ss7PswHcFq+5gVT/A5XFGOzIPrghisQVBfShLnpbRzDV79DVCr5GUcd33pZyQtrPJSeBt
	QzvOf+HnwZlTmX1o+9+HqZWFz4SvDz1B+CBBzi/B2mmCvfCIqdtGwlXw0NdxSSnFvhhDP/N/jrw
	SO2e5ffL9xRDhatpFm/298NpqFNzOciBexzWXYuqi5bpjQVm
X-Received: by 2002:a17:903:24b:b0:2e6:d25:d874 with SMTP id d9443c01a7336-2ea6313172cmr689965ad.10.1792613830593;
        Wed, 21 Oct 2026 13:17:10 -0700 (PDT)
Received: from google.com (163.1.145.34.bc.googleusercontent.com. [34.145.1.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4896c71sm927197a91.6.2026.10.21.13.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 13:17:09 -0700 (PDT)
Date: Wed, 21 Oct 2026 20:17:05 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Fred Griffoul <griffoul@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, 
	Ackerley Tng <ackerleytng@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2 06/11] iommufd: Map memory provider files
Message-ID: <atkO08eCJzLX6R58@google.com>
References: <20261014093733.90312-1-griffoul@gmail.com>
 <20261014093733.90312-7-griffoul@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261014093733.90312-7-griffoul@gmail.com>

On Wed, Oct 14, 2026 at 09:37:28AM +0000, Fred Griffoul wrote:
>From: Fred Griffoul <fgriffo@amazon.co.uk>
>
>IOMMU_IOAS_MAP_FILE pins the pages it maps, which cannot work for a
>memory provider file: the frames may have no struct page, and the
>provider can take any of them back at any time.
>
>Accept a provider file. iommufd neither pins nor accounts its pages.
>It asks the provider for each frame when it fills a domain, and on a
>revoke it unmaps the range in every domain and maps what the provider
>backs now. A device that accesses the range in between faults. A
>revoke charges the page tables it allocates to the memory cgroup that
>mapped the file, not to the task that revoked.
>
>Each frame gets a PAGE_SIZE entry, so a partial revoke never splits a
>large IOMMU page. The next patch maps larger blocks. Holes stay
>unmapped, read-only pages are mapped without IOMMU_WRITE, and MMIO
>pages with IOMMU_MMIO. Frame 0 is refused with -EINVAL: iova_to_phys()
>returns 0 for an IOVA that is not mapped, so a revoke would take that
>page for a hole and leave it mapped.
>
>A revoke would race a dirty bitmap read and lose the dirty bits of the
>range, so provider pages and a dirty tracking domain cannot share an
>IOAS: whichever comes second fails with -EOPNOTSUPP. A provider
>mapping cannot be split by a partial unmap, and in-kernel accesses to
>it are refused.
>
>Assisted-by: Claude:claude-opus-5-5
>Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
>---
> drivers/iommu/iommufd/Kconfig        |   1 +
> drivers/iommu/iommufd/io_pagetable.c |  13 +-
> drivers/iommu/iommufd/io_pagetable.h |  27 ++-
> drivers/iommu/iommufd/pages.c        | 288 ++++++++++++++++++++++++++-
> include/uapi/linux/iommufd.h         |  11 +-
> 5 files changed, 334 insertions(+), 6 deletions(-)
>

[snip]

>+
> /* The pages are not pinned, so their domains are tracked in pages->tracker. */
> static inline bool iopt_pages_tracked(struct iopt_pages *pages)
> {
>-	return iopt_is_dmabuf(pages);
>+	return iopt_is_dmabuf(pages) || iopt_is_provider(pages);
> }
>
> static inline bool iopt_dmabuf_revoked(struct iopt_pages *pages)
>@@ -285,6 +306,10 @@ struct iopt_pages *iopt_alloc_dmabuf_pages(struct iommufd_ctx *ictx,
> 					   unsigned long start_byte,
> 					   unsigned long start,
> 					   unsigned long length, bool writable);
>+struct iopt_pages *iopt_alloc_provider_pages(struct file *file,
>+					     unsigned long start,
>+					     unsigned long length,
>+					     bool writable);
> void iopt_release_pages(struct kref *kref);
> static inline void iopt_put_pages(struct iopt_pages *pages)
> {
>diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
>index 660af3d46f5e..aa7740326ad6 100644
>--- a/drivers/iommu/iommufd/pages.c
>+++ b/drivers/iommu/iommufd/pages.c
>@@ -52,6 +52,8 @@
> #include <linux/iommu.h>
> #include <linux/iommufd.h>
> #include <linux/kthread.h>
>+#include <linux/mem_provider.h>
>+#include <linux/memcontrol.h>
> #include <linux/overflow.h>
> #include <linux/slab.h>
> #include <linux/sched/mm.h>
>@@ -238,6 +240,35 @@ static void iommu_unmap_nofail(struct iommu_domain *domain, unsigned long iova,
> 	WARN_ON(ret != size);
> }
>
>+/*
>+ * Provider pages are mapped with PAGE_SIZE entries, and may have holes.  Some
>+ * IOMMU drivers warn when asked to unmap an IOVA that is not mapped, so find
>+ * the runs that are mapped and unmap each one, without touching the holes.
>+ * iopt_provider_map() refuses frame 0, which iova_to_phys() reports for
>+ * an IOVA that is not mapped.
>+ */
>+static void iopt_provider_unmap(struct iopt_area *area,
>+				struct iommu_domain *domain,
>+				unsigned long start_index,
>+				unsigned long last_index)
>+{
>+	unsigned long iova = iopt_area_index_to_iova(area, start_index);
>+	size_t left = (last_index - start_index + 1) * PAGE_SIZE;
>+
>+	while (left) {
>+		size_t len = 0;
>+
>+		while (len < left && iommu_iova_to_phys(domain, iova + len))
>+			len += PAGE_SIZE;
>+		if (len)
>+			iommu_unmap_nofail(domain, iova, len);
>+		/* Step over the run and the hole page that ended it. */
>+		len = min(len + PAGE_SIZE, left);
>+		iova += len;
>+		left -= len;
>+	}
>+}
>+
> static void iopt_area_unmap_domain_range(struct iopt_area *area,
> 					 struct iommu_domain *domain,
> 					 unsigned long start_index,
>@@ -245,6 +276,11 @@ static void iopt_area_unmap_domain_range(struct iopt_area *area,
> {
> 	unsigned long start_iova = iopt_area_index_to_iova(area, start_index);
>
>+	if (area->provider) {
>+		iopt_provider_unmap(area, domain, start_index, last_index);
>+		return;
>+	}
>+
> 	iommu_unmap_nofail(domain, start_iova,
> 			   iopt_area_index_to_iova_last(area, last_index) -
> 				   start_iova + 1);
>@@ -1349,6 +1385,10 @@ static int pfn_reader_first(struct pfn_reader *pfns, struct iopt_pages *pages,
> 	    WARN_ON(last_index < start_index))
> 		return -EINVAL;
>
>+	/* Provider pages are read from the provider, see iopt_provider_map() */
>+	if (WARN_ON(iopt_is_provider(pages)))
>+		return -EINVAL;
>+
> 	rc = pfn_reader_init(pfns, pages, start_index, last_index);
> 	if (rc)
> 		return rc;
>@@ -1647,6 +1687,228 @@ void iopt_pages_untrack_all_domains(struct iopt_area *area,
> 	}
> }
>
>+static int iopt_provider_prot(struct iopt_area *area, u32 attrs)
>+{
>+	int prot = area->iommu_prot;
>+
>+	if (attrs & MEM_PROVIDER_ATTR_READONLY)
>+		prot &= ~IOMMU_WRITE;
>+	if (mem_provider_type(attrs) != MEM_PROVIDER_TYPE_RAM) {
>+		prot &= ~IOMMU_CACHE;
>+		prot |= IOMMU_MMIO;
>+	}
>+	return prot;
>+}
>+
>+/*
>+ * Map what the provider backs in [start_index, last_index] of the area into
>+ * @domain, and leave the holes unmapped.  Each frame is mapped with a
>+ * PAGE_SIZE entry, so that a revoke of part of a large block never has to
>+ * split a larger IOMMU page.  On failure nothing in the range is mapped.
>+ */
>+static int iopt_provider_map(struct iopt_area *area, struct iopt_pages *pages,
>+			     struct iommu_domain *domain,
>+			     unsigned long start_index,
>+			     unsigned long last_index)
>+{
>+	unsigned long base = pages->provider.start >> PAGE_SHIFT;
>+	unsigned long index = start_index;
>+	int rc;
>+
>+	lockdep_assert_held(&pages->mutex);
>+
>+	if ((1UL << __ffs(domain->pgsize_bitmap)) > PAGE_SIZE)
>+		return -EOPNOTSUPP;
>+
>+	/*
>+	 * A revoke unmaps under pages->mutex only, so it would race with a
>+	 * dirty bitmap read, and lose the dirty bits of what it unmaps.
>+	 * Provider pages are not mapped in a domain with dirty tracking.
>+	 */
>+	if (domain->dirty_ops)
>+		return -EOPNOTSUPP;
>+
>+	while (index <= last_index) {
>+		unsigned long pfn, iova, block_end, nr, i;
>+		int order = PUD_ORDER;
>+		u32 attrs;
>+		int prot;
>+
>+		rc = mem_provider_get_page(&pages->provider.att, base + index,
>+					   &pfn, &order, &attrs);
>+		if (rc == -EFAULT) {
>+			index++;
>+			continue;

Hi Fred,

Thanks for this.

With this approach, silently skipping holes during IOAS_MAP_FILE means
iommufd has no tracking of which IOVA ranges in the area are actually
mapped, which complicates unmap and could also hide a bug if a hole in
the range was not expected?

I am wondering whether the areas can track the holes, or whether we
should have areas for the mapped/unmapped ranges? This should allow
proper sanity checks when doing revoke. I am also thinking about this
from the live update point of view, where we might need to sanity check
that the backing memory of mapped regions is preserved.

Could you please CC me on v3? I'd like to follow this from the live
update IOMMU and iommufd preservation side.

https://lore.kernel.org/all/20260921004834.2601285-1-skhawaja@google.com/

Thanks,
Sami
