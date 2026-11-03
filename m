Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793726848;
	b=UucdqZyJHop9xXxbR1abdeFkFapD9w39ThYQ+cRjXSt9+2ES7S9QrqdvgZIIcveSu0FA
	 RKICfpDtq40IzsY4kEHxxUCYOOb5KX5MAXtPXeTWdGH3+WluTOdKkB8g1OBlOznnkYd8G
	 oYtonMnVmYscbQSi+MF9qLl1gJWlKxDWXZdB+QV0HUfL5W4eucWP9QtKY5dAdGyaF4W3u
	 qR62KZESAVGg8v7we6LfnuHP8YIaHVQ76VT5eZSEh2CcW8QtkmhxKgyjZREOy5WZuDnvl
	 B+nFNn8A/pHsMOyjno4PCHV0ou0MxUUr7MRgsbNwPNSDI4FrhddeB/OZlABKfxQKCWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793726848;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oQ9etUacckBarYb1JALwGYSQHISLb3hr+LJXqLQq1xU=;
	b=OAURvnQtO4+mrhuzuEOWGTwt0I7F3FhVrZRn7gjseB7m+WoYWqs5cMsFdlgsEuEZALu5
	 t2tqSEmkNVpFeN15Y/AkBE2vYR9ffCzT1RTFFf6FgNthDjPnvs7q8j9wKYVADUmWwPIhh
	 HTma7iAbRNZfIXRTRiLwxcBDVR2SB43y/9BHmg5TExCR/MELjh9VlDBw95evJg9NfONyT
	 vSDvSbtnAX4XnpBCesKVdjjCCHdz4W2D2+IXVqu21jD9zc+yyQapWns184TZ0LkbqIgEK
	 T+e6EZUvcN3xBjAS03xIlXNHdmChGxIhFLuVmrPi94jbwalmkw6xNIzB5s+HmAPNXXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=zetR+WpW;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JXEGoqh0;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40285606A328
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 17:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40285606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=zetR+WpW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JXEGoqh0
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 779811D00173
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 12:27:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 03 Nov 2026 12:27:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793726845;
	 x=1793813245; bh=oQ9etUacckBarYb1JALwGYSQHISLb3hr+LJXqLQq1xU=; b=
	zetR+WpWn9DhB4CeqpdiTiOi6s3x1UHu7weQGhm2ryOeMvJOG6EbjaND+uAwD8/F
	+yHK9G6THdOWskS1PZ3uPXbtfVJ5VnYmCM6ZHf/59jXjuDRF9Xg+pQNYcaq2Kz0a
	UohJvK4+1FeTRUVIGvzYmST4S/mgxuWW+jX5ktnkedgHLoz1bUCNAT0lgOU3s98h
	jkBfEAoQJ4MlzRq5yYvNvoHW7Bl9wX/Y8z4iaTltOKNwt1NZcOQf6osZ5mAPZQnO
	wGm11tfJNslo4W/hBKsbwas0lKBNhrCzsT9BqMms8t9yW+GlEKcAVqCWBUJi8A1v
	VQLn9FtvziPL99xru7n1/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793726845; x=
	1793813245; bh=oQ9etUacckBarYb1JALwGYSQHISLb3hr+LJXqLQq1xU=; b=J
	XEGoqh0vkEc6Pb/P4kC/F0BEteuIO/Gug2WUziJjRiNGWhl+PUL61lnf5/MwAfVY
	G1Z+toMCX+Gig21jp5bKjQHEklPhbiBXGUkk9lbNC2I+4QaLx4b4+kZQxwetlir5
	YTXzm52wvRo7IXoyuLgcatTA6poR/3N10IcXIEZNmy9fmB7wMvtG96yr+cs/S+oq
	pOJwW3PbjAIZwYcwPm4W4k63DYPC5bb49lqXYI8G6EJpcr2f0AeLLKUhCPwAs6cu
	Wa3nC/7SA4V8/A0G1ID4Gf+ZEuSyPK8ae3u0LDt5x5BdW4nC4oWhKdZmrC2AQQn6
	B3DJz8UxMO9rEBcDue2VA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793726845; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:QSvVHB2Nt+7jSOWTQRndv0j1UdO/OrOGhP9gt6iE7fwpDRA
	27Ytg+zKn12RWXmYPia/xfIZcAyNSzJkiJqqCNjp8GMbn8d23f1L4vOTJ8Mld57x
	3AwTEbZe1My8Xd+XAwT+oQHkJpwNyz2yg0LkGCDHUao/MKz+c4RkVqqJfLL4o4ev
	dtWHP0v0hvY5w9duN7sNZzJh9OPpstB7KzzQ+TOw8o8hUB2rPYUrmcCHB9TS1Lhd
	B+68rL1cF2s8psjJ+1FMPH/Cb34IIvt+fgpIgTnRq1hmrRifSm69zbNixYjTXShg
	RxzMT/FwdHdb9v4Yx+gHTjtOl3d7Xt2Ozi6Xe7Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:zgsJtPfv4psusrXCbVcJ6TIGiHw75jq9I7pFokzImBE=:1pZpE/kNCy4mvcWmUyjXa3kNQemONISbbXXEIL2Fhpc=;
X-ME-Sender: <xms:fRnqaj0V-QKEOq1eWK_awsP416S3Tw7nbbLXILBvLcdO_fLz-5OpJQ>
    <xme:fRnqahj9xaJXLVmq9Y4wmagmx4LVjPk5RbX0y8s46lDo4aK-JlfwMOBt5EuoXEjnQ
    rAkLdsTkV2721_9jOUNkl5ZeQje3tHvECC_RoaImz0fYLBsgHklib8>
X-ME-Received: <xmr:fRnqak9Y--WXP7stmwrYpG7OBqRtSh9g_RYTNEt6Oabd5t6pVjqEKzf6nKdRaw>
X-ME-Proxy-Cause: dmFkZTEJbO7YJqbe3YmLuAs4b/MTR3S3PLssy8c1J8Dg54gC2msHiH/u1QXpq0oEYWNfTb
    hf36B+a5u4em/nWh9BXbMQ/a2ZW7sNVARuiEEtjeDq8w8dG3VaVDwRMhuHoZ9s8IblQTn5
    bHDnhh7ylFoeH3xSPHkVrElHsF60YWho6nGjfmw7brc9qWQqKtTbwRlTrxwpHpeHI0gk1o
    OJKEmoMYPVHZQ0G8eiTiDqh+guwsvgUkXid7sYO8x4URpUpiaOvj3cma+uUHcgifjVZXUF
    qfbrBZoIK2hwkdF1003/NfsNJpQtwsdsaLt8mdLyskdHAA+dQu84KG5ZGrkeclgWWllPkd
    ufqcYs3l3M79OWXxL77HBpdZEev7DnuniUyXWGZ1Yc6UPRZG1+gK4AahhOs6B/aCp8JfZ+
    ctHoRSRRaTzZ5GumKU+CYtCTrxtY6u9Cpm+CJb7uGruJ78E5G6kSXQm07BaQ2y46Vw7M/+
    QDuyqOl0ayEVsg51PK+iudM5iTBJkjtTxXIPle5tdcWFZ6vm8MkHVyBxL7yybcMcgqzTBg
    qB1wa7Sc9WZoQy36mNlp0zUye5n4mSwCsO5u7mfDO8gmyEVZi7Kk7jIvNN7HDajScxuVU9
    0xK1D6Il1AytMWcd95a17xV4iwctmW09Y3rpMtR84n/OsnEuAUCCmXPU7hrQ
X-ME-Proxy: <xmx:fRnqatIG2ttoasAnQjYUfvKx2__Tdpyy1ASYNwKkaEmQ7sbcioWN8w>
    <xmx:fRnqapwDcUT0CvZ3g_T8mFC5YlVb3-P9Gn4NmJj4-0Ji2LPtJZu65w>
    <xmx:fRnqag2Bvp8UxJ9xdzcq7fZZ1zA-SAYuI6Mq12lMtQY4KMdiSNc93Q>
    <xmx:fRnqai-rtYSLoJ1NTkhlE6sFTafVvxHnTeN4GZGlvkZgL9-CZpwZTQ>
    <xmx:fRnqalxC73gaLcpjFT8RgXzJ4RBhPhe2hnFhfY0AVwnl7qi23jCSP9Cb>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 12:27:23 -0500 (EST)
Date: Tue, 3 Nov 2026 10:27:21 -0700
From: Alex Williamson <alex@shazbot.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Peter Xu <peterx@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, David Matlack <dmatlack@google.com>, Shuah
 Khan <shuah@kernel.org>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma
 <vipinsh@google.com>, Alex Mastro <amastro@fb.com>, Matt Evans
 <matt@ozlabs.org>, alex@shazbot.org
Subject: Re: [PATCH v3 3/3] vfio: selftests: Test BAR write faults after
 clear_refs
Message-ID: <20261103102721.5d76c471@shazbot.org>
In-Reply-To: <20261102230445.3993629-4-almasrymina@google.com>
References: <20261102230445.3993629-1-almasrymina@google.com>
	<20261102230445.3993629-4-almasrymina@google.com>
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

On Mon,  2 Nov 2026 23:04:45 +0000
Mina Almasry <almasrymina@google.com> wrote:

> Add a regression test in vfio_pci_device_test to verify that huge_fault
> on writable MAP_SHARED VFIO PCI BAR mappings handles write faults after
> soft-dirty tracking clears VM_SOFTDIRTY and downgrades vma->vm_page_prot
> to read-only via /proc/self/clear_refs ("4").
> 
> Use vfio_pci_find_mem_bar() to locate a memory-backed BAR of at least
> 2 MiB that is safe to read and write, and zap existing BAR mappings via
> PCI_COMMAND_MEMORY before each sub-test to verify both:
> 
> 1. Read-then-write fault sequence after clear_refs, exercising in-place
>    huge PMD/PUD write-protection upgrade via wp_huge_pmd()/wp_huge_pud().
> 2. Direct initial write fault on an unpopulated BAR VMA after clear_refs,
>    exercising vmf_insert_pfn_pmd()/vmf_insert_pfn_pud() with
>    FAULT_FLAG_WRITE set.
> 
> Skip gracefully when the device has no known memory-backed BAR >= 2 MiB
> or when /proc/self/clear_refs soft-dirty tracking (CONFIG_MEM_SOFT_DIRTY)
> is unavailable.
> 
> Suggested-by: Alex Williamson <alex@shazbot.org>
> Cc: David Matlack <dmatlack@google.com>
> Cc: Matt Evans <matt@ozlabs.org>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  .../selftests/vfio/vfio_pci_device_test.c     | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
> index 93c11fd5e081..323a316f59e7 100644
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
> @@ -102,6 +105,68 @@ TEST_F(vfio_pci_device_test, validate_bars)
>  	}
>  }
>  
> +static void zap_bar_mappings(struct vfio_pci_device *device)
> +{
> +	vfio_pci_cmd_clear(device, PCI_COMMAND_MEMORY);
> +	vfio_pci_cmd_set(device, PCI_COMMAND_MEMORY);
> +}
> +
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
> +	struct vfio_pci_mem_bar mem_bar;
> +	int ret;
> +	u32 val;
> +
> +	if (!vfio_pci_find_mem_bar(self->device, SZ_2M, &mem_bar))
> +		SKIP(return, "No memory-backed BAR >= 2M on %s\n", device_bdf);
> +
> +	zap_bar_mappings(self->device);
> +
> +	ret = clear_soft_dirty_refs();
> +	if (ret == -ENOENT || ret == -EINVAL)
> +		SKIP(return, "soft-dirty clear_refs unsupported (%d)\n", ret);

My comment on v2 that this doesn't accurately test whether soft-dirty
is supported, potentially leading to a false pass still stands.

Please also have the courtesy to give reasonable time for review before
a respin.  Personally I would expect self review and testing to take
longer than the 80 minutes between David's feedback and v3.  Thanks,

Alex

> +	ASSERT_EQ(0, ret);
> +
> +	/*
> +	 * clear_soft_dirty_refs() stripped write permissions from
> +	 * vma->vm_page_prot on the unpopulated BAR mapping. Fault it read-only
> +	 * first, then write to exercise in-place write-upgrade
> +	 * (wp_huge_pmd/wp_huge_pud).
> +	 */
> +	val = READ_ONCE(*(u32 *)mem_bar.vaddr);
> +	WRITE_ONCE(*(u32 *)mem_bar.vaddr, val);
> +
> +	/*
> +	 * Zap the BAR PTEs/PMDs, clear soft-dirty again, and fault with an
> +	 * immediate store to exercise initial write insertion
> +	 * (vmf_insert_pfn_pmd/pud with write=true).
> +	 */
> +	zap_bar_mappings(self->device);
> +	ASSERT_EQ(0, clear_soft_dirty_refs());
> +
> +	WRITE_ONCE(*(u32 *)mem_bar.vaddr, val);
> +	(void)READ_ONCE(*(u32 *)mem_bar.vaddr);
> +}
> +
>  FIXTURE(vfio_pci_irq_test) {
>  	struct iommu *iommu;
>  	struct vfio_pci_device *device;

