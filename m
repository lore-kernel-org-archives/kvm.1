Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664715;
	b=TcJsgyY6d/lplnTjzOXOd5c4IyPMmTLI1A6s8Ef8MUaoZGrJY37m27oUv664f+py8QbB
	 GukHHpZVWAk2nM7O0uTNKwwyMVUC4KmgEmIYWLbVXxd1mABo5xZ2ussqBRy12C7gpTqZF
	 o5KI5mPSiVhltQjzAT66m5Za3H9SqJU+i0RT+xuWJ8MUf6k2zk6g82pt4rT/u5Lxsq9F/
	 pZwGi1p5eT92kAG3PizCTSXqQ6b05sHrCGbTU+LZF0PiR6RI8NVo9WJ/L1rloRy+79iZz
	 p2AnF2JbKL1/JWKb8eQdCO9LugPWtqHFjNxz6hw4BrmDTfQZ0yKlXgU/PCl6GRz7twQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664715;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nAYlfopKplFpCvjeBoKRW2i4VXzCq65tChw/Zjl0dY4=;
	b=Mz/lgIn57n8elQux9opQyb2Ut+rSePzxp/68L4VrcJd8k7LrQonwlNfx89E1yb/MAOuy
	 MgsRzlNVUMJyqrJZr4BaVDHSc/olJ1awR2v82ClMbafn8+Y9XQUC0a+0/XpYIF4VXUZhe
	 /RFSKEVOTldPZKQy5JajjR70GyLycELX96cme0mU48/5A0y2tIn4qJWI74dyWsnzVqlZe
	 P3bkLjZ8mq5NDZKZcP96865+kEsSz/A8F9o2Lv4KXN5lXF5eZ5LF/AkqoFjdQThKwjzk1
	 JrG0qBQJBVSPXsl6LATVKgTOuHbTR5sMjpIlTJVeg/vbP2kNPQQNeWKOuSUMyTfuXBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=EWqjTzRU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=CGBEru57;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77163606D80C
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 00:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77163606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=EWqjTzRU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=CGBEru57
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9A7081D000D9
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 19:11:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 02 Nov 2026 19:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793664712;
	 x=1793751112; bh=nAYlfopKplFpCvjeBoKRW2i4VXzCq65tChw/Zjl0dY4=; b=
	EWqjTzRUMCSlXkFm/qHNJt2WYDzbJtU+3zVCFQOJEbKYfeIQs/euI7/NsHeUTUuc
	MLk6Tbssr5r8EHudUe0Oi7iVGCdvRiqOMz/hk5ZOGljqjicxdURb9sjKjKKSJ2hB
	yp+Y/uAHoFeCibQF03TzpejhJQS1kw6nXCw7bRuTBCARCTmsAW/pbBUpoG7QycmG
	AYdCZBknmI65WPu9q46Id84i2biz+14bH/grLQHDTub3hKAq7jBD53pDgJbOqSE1
	DX0QiJnSOei/q+94BMCqEYoKMyZYN7zrvlZUQscp3aLXXaBbKWFpX+jASsya61Gn
	O/HpIBRltIHT5z9cCj3qmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793664712; x=
	1793751112; bh=nAYlfopKplFpCvjeBoKRW2i4VXzCq65tChw/Zjl0dY4=; b=C
	GBEru57NEjJ6zEnaA/s3EIUI3aPlGmG/pAEregPm5wc6mHMbRLmtkamFH6seghnm
	LeFCzR7G3tGYE0xExNw4tR/20RaElOLwwuFEAhXIS4NKWEdMu42t3QZLHFv+lc/c
	W4WfQ60scjhI2RQPr/SKdf0Tl8/+7BAzyodhFduaXvgitbvbrsW7cIA5Irci4hvc
	AR1m7IbtdHkoWYHPirkYttAa+hlRExfHWY0Vug2yxfAWzLwKId2t877gj3DgIY6t
	UiS5llybi467MaKcYcZcms3gxwnc5XMEEfWzcGbKtf+3uZrmSdS7ecIjnuCRGKma
	898CGzOwBhkw4fkFzneXg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793664712; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nAlctaKp9/p1041UDli+s8cfl94Ex0IVP0AYdJ9BaMBOc8v
	NvNN/dy9dN9tioVuDYCFCVIsH0Cib5Gm8l8gC1ryVnqgmgG1QaTE6CkI53xNJKAm
	BH393XFewyJnjYxy8c0BFQghx7P1CLi5KLdVvp3o2yA0KxO6a3eSNJl4zV3Y4Ge1
	jbvrk+8/HeEkVhrI5HwuzJEALYwZdZBIkVVW12KSuIG7G+Ztbn4bUy1L3xDTQ10x
	ZIhql6JEgDDov2XtA5Bm6ApG7L6dEQ6mkdr+zfgNLl1gVPPgU+cE5LYlxem8Q363
	s0NNiJCVtpyBtohX/FHyda3kiUugYwXYLU2reRg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ib1t8J7HIPjzcbaZLgDmo/S57AG8FFWKbLaEUAQkbF4=:zK6xMzgqMIjtNl7Qhz3cYyMrvTIOUJ7JryNKniSNlhU=;
X-ME-Sender: <xms:xybpatN3nQAp7QPYzH0wgeoEnvFG2dnvFnf9HKbwANOiSYKDfjDl2w>
    <xme:xybpar1pHCT9adN5rW0WHIV6zZXCYYmEGQgcPJxM0lIUlJaz7VeYPKVp8kITLcYoQ
    Bd1bbk2YCI4BaVaT2P3egpW19O3yx9ZhWwaO-pvL8yAYEARYxkXI_th>
X-ME-Received: <xmr:xybpapTuHxewKOQrbVrg0fLzvBDRF8xKrFVz9ld8VaMaeNh9CvYVSbj9EwChBA>
X-ME-Proxy-Cause: dmFkZTF8SRv5LTr0bKOnRmaCpL3IXr8QyK44csVcumPgbXUJKzwO6qj90HElaIqZj6Sbw5
    BlqP7qlQ31TVW0XeIQsoS0kLaluG5E5gQIy/LqC8pfIUyeBKs4IDzqt4lXJXV0OMnxa0Bu
    KGqrGWZnL5TlXEQj5TDi6EZBrQjNdWJAMnoCqtig8KTzwoumcmz0WDKnoUzjRAn6KaggE1
    oGrVPEExI31142Sx+/mPwdixYE342dJEur+yURNKSGHWQ1w/XJpGUWnysJHcQXcAgzcRix
    e2yRmWUdGFWsMGhFnQq6XW3MjKgFt3+162/wvdiQgzHrtyJ0ldBAxkPGCmCyvetm5PpykQ
    +cenZSYyi2nbRwKNbqTxJ5Rfz3PEf8p1RH5EsIuCWyDVpkeFyNsC9ZFCKjTpNfZKbYiLqA
    mv7pPrOnhSmFvoxpt/U1bZB8YccViG+jeTxlZaVfQ2atsmb3rGj1hLu51Yxyz1xho4I0SK
    /PdUOCGZ11MdUcKzT1I14pSzUvp5QOWD/r72hR6wvdw/szYAjYH2j8OhtTuy23kWsnWhg9
    JscAAv2E9BEDLM48MCyKMdYbMjowUtly4kyr6SaLwTT3/1xe+ap+3quwrtM9GciNoo96Nq
    JptV8LIGhDq8tQpvXb9T97GOk4q5Uxb/WcYBSe2u7u2Qb+2FUzFUbJJMKZgw
X-ME-Proxy: <xmx:xybpaun3ko6mTuDTVd0HLAfSi1pvedrzl8M8aHOzCUc0iTDd7kQj3Q>
    <xmx:xybpaqMdbCD11pLmhLVP44f6nIEwNGgTou8QLnToBNnd_xSW0LgKxA>
    <xmx:xybpaqhNm8-8kYvqmRjMvPuU5Yeauhsv_OXJ5nqd01vEay7mJq3YQQ>
    <xmx:xybpagiXT3q4xre88zdBaYsV-aoafPS3PgDha1ROqV8l0fVhcjz5xg>
    <xmx:yCbpalAX22tVfHT8wEautQEQ2wx8RRpBaOUxKdlkd6-ftoMHrdxFNfwn>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 19:11:50 -0500 (EST)
Date: Mon, 2 Nov 2026 17:11:49 -0700
From: Alex Williamson <alex@shazbot.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Peter Xu <peterx@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, David Matlack <dmatlack@google.com>, Shuah
 Khan <shuah@kernel.org>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, alex@shazbot.org
Subject: Re: [PATCH v2 2/2] vfio: selftests: Test BAR write faults after
 clear_refs
Message-ID: <20261102171149.5d4ed369@shazbot.org>
In-Reply-To: <20261101062049.998160-3-almasrymina@google.com>
References: <20261101062049.998160-1-almasrymina@google.com>
	<20261101062049.998160-3-almasrymina@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Nov 2026 06:20:49 +0000
Mina Almasry <almasrymina@google.com> wrote:

> Add a regression test in vfio_pci_device_test to verify that huge_fault
> on writable MAP_SHARED VFIO PCI BAR mappings handles write faults after
> soft-dirty tracking clears VM_SOFTDIRTY and downgrades vma->vm_page_prot
> to read-only via /proc/self/clear_refs ("4").
> 
> Specifically, for each mappable read/write BAR (already aligned up to
> SZ_1G by vfio_pci_bar_map() with MADV_HUGEPAGE), verify both:
> 
> 1. Read-then-write fault sequence after clear_refs, exercising in-place
>    huge PMD/PUD write-protection upgrade via wp_huge_pmd()/wp_huge_pud().
> 2. Direct initial write fault on a freshly mapped unpopulated BAR VMA
>    after clear_refs, exercising vmf_insert_pfn_pmd()/vmf_insert_pfn_pud()
>    with FAULT_FLAG_WRITE set.
> 
> Skip gracefully when /proc/self/clear_refs is absent or soft-dirty
> tracking (CONFIG_MEM_SOFT_DIRTY) is disabled, or when the device exposes
> no mappable read/write BARs.
> 
> Cc: David Matlack <dmatlack@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  .../selftests/vfio/vfio_pci_device_test.c     | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
> index 93c11fd5e081..75ccc557efb9 100644
> --- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
> +++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
> @@ -1,10 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> +#include <errno.h>
>  #include <fcntl.h>
>  #include <stdlib.h>
> +#include <unistd.h>
>  
>  #include <sys/ioctl.h>
>  #include <sys/mman.h>
>  
> +#include <linux/compiler.h>
>  #include <linux/limits.h>
>  #include <linux/pci_regs.h>
>  #include <linux/sizes.h>
> @@ -102,6 +105,86 @@ TEST_F(vfio_pci_device_test, validate_bars)
>  	}
>  }
>  
> +static int clear_soft_dirty_refs(void)
> +{
> +	ssize_t ret;
> +	int fd;
> +
> +	fd = open("/proc/self/clear_refs", O_WRONLY);
> +	if (fd < 0)
> +		return -errno;
> +
> +	ret = write(fd, "4\n", 2);
> +	if (ret < 0)
> +		ret = -errno;
> +	else
> +		VFIO_ASSERT_EQ(ret, 2);
> +
> +	VFIO_ASSERT_EQ(close(fd), 0);
> +	return ret < 0 ? ret : 0;
> +}
> +
> +TEST_F(vfio_pci_device_test, bar_write_fault_after_clear_refs)
> +{
> +	const u32 rw_mmap_flags = VFIO_REGION_INFO_FLAG_MMAP |
> +				  VFIO_REGION_INFO_FLAG_READ |
> +				  VFIO_REGION_INFO_FLAG_WRITE;
> +	struct vfio_pci_bar *bar;
> +	bool tested = false;
> +	int ret, i;
> +	u32 val;
> +
> +	ret = clear_soft_dirty_refs();
> +	if (ret == -ENOENT || ret == -EINVAL)
> +		SKIP(return, "soft-dirty clear_refs unsupported (%d)\n", ret);

-ENOENT seems to map to the open() when /proc/self/clear_refs is not
present.  We can't clear soft-dirty by virtue that the file is absent.
Fine.

-EINVAL seems to be intended to catch:

clear_refs_write():

        if (type < CLEAR_REFS_ALL || type >= CLEAR_REFS_LAST)
                return -EINVAL;

But that's only testing for a known type, not that it's supported.
This is never triggered, which can lead to a false pass if soft-dirty
really isn't supported and silently does nothing.


> +	ASSERT_EQ(0, ret);
> +
> +	vfio_pci_cmd_set(self->device, PCI_COMMAND_MEMORY);
> +
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		void *vaddr;
> +
> +		bar = &self->device->bars[i];
> +		if ((bar->info.flags & rw_mmap_flags) != rw_mmap_flags)
> +			continue;

Where do we filter out BARs that wouldn't trigger a PMD/PUD fault?  If
we're only testing sub-PMD BARs, this is another false pass.

If we do find a BAR to trigger a PMD/PUD mapping, what's the value in
continuing to exhaustively search and test the remaining BARs?

> +
> +		ASSERT_NE(NULL, bar->vaddr);
> +
> +		/*
> +		 * clear_soft_dirty_refs() stripped write permissions from
> +		 * vma->vm_page_prot on the unpopulated BAR mapping created by
> +		 * vfio_pci_device_init(). Fault it read-only first, then write
> +		 * to exercise in-place write-upgrade (wp_huge_pmd/wp_huge_pud).
> +		 */
> +		val = READ_ONCE(*(u32 *)bar->vaddr);
> +		WRITE_ONCE(*(u32 *)bar->vaddr, val);

Sashiko notes[1] an issue here that might be a false positive, but the
comment should at least note that a matching driver could already have
touched the BAR via read/write but doesn't invalidate the test... if so.
Thanks,

Alex

[1]https://sashiko.dev/#/patchset/20261101062049.998160-1-almasrymina@google.com

> +
> +		/*
> +		 * Replace the VMA with a fresh unpopulated mapping at the same
> +		 * hugepage-aligned address, clear soft-dirty again, and fault
> +		 * with an immediate store to exercise initial write insertion
> +		 * (vmf_insert_pfn_pmd/pud with write=true).
> +		 */
> +		vaddr = mmap(bar->vaddr, bar->info.size, PROT_READ | PROT_WRITE,
> +			     MAP_SHARED | MAP_FIXED, self->device->fd,
> +			     bar->info.offset);
> +		ASSERT_EQ(bar->vaddr, vaddr);
> +		madvise(bar->vaddr, bar->info.size, MADV_HUGEPAGE);
> +
> +		ASSERT_EQ(0, clear_soft_dirty_refs());
> +
> +		WRITE_ONCE(*(u32 *)bar->vaddr, val);
> +		(void)READ_ONCE(*(u32 *)bar->vaddr);
> +
> +		tested = true;
> +	}
> +
> +	vfio_pci_cmd_clear(self->device, PCI_COMMAND_MEMORY);
> +
> +	if (!tested)
> +		SKIP(return, "No mappable read/write BAR on %s\n", device_bdf);
> +}
> +
>  FIXTURE(vfio_pci_irq_test) {
>  	struct iommu *iommu;
>  	struct vfio_pci_device *device;

