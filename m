Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793655924;
	b=IxjkXh4OuuBo00PV2033473lX1DmEHhxkmYqCPaSLCqwGPx3Is59QsHGEZ++JlRBLicO
	 vqHS4pjRmNvHrnyrEvgtn+mrcBiM0dr+hy1kttKplmihl5mLE+/BvwO+9gwNOuHXkAY2v
	 cvh4iwChiwUwaxnPC9X2PibCFnwGF/X1TlEsTs+ZvLQOlLA50OAWpq4kgAMsnoJHOxLKu
	 OfZGeeEVW5GDo1G1DmmmaPOPYmW+LMXdLBHClc3vPXsc7ISUpZnbsO+24ag9YXz1Yw++k
	 Rtap5oPLhZs7pzOjnTFCxIkNa8mxTMLCGHAsbHACjlTgjIBmyt4gceGYMpjHn28ynrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=q5JdWOppAER7/sVf+/wRTQ5JltDoWihbM3Khp4hBQTg=;
	b=kjuF30ovitUI+zd85b04S+ckc/v6szve56LWBjhwJ+K+e70a63Uu2+8ZUwTvmpEoJGrI
	 5q3Gmfu0KtOjH8ub95VnOit6rVJe8487j+tEx1JtonitdG7jChltwyM1ftW6r6vnFdxrF
	 n34JbWQuAD8SCIs+jXI5queR0SyMu4ObfP6UZH/nKzbfs/n2o9vZksauWJFfIpNKDPw+3
	 s7qB27dV1LfcUJP/smCKo/eCv79wKRXmtw7ieZIzzrzix1HwxdYA+plellSvA1Qjj/98J
	 mTuRbfYUzewW/oYyBERVw65Qw4TX7Ccewauve1Pu2n1ccbtgemPthN0z/BJdU8inkTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=de9Kt5CT;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42529606A32E
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 21:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42529606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=de9Kt5CT
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e946155442so31367675ad.3
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 13:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793655923; x=1794260723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q5JdWOppAER7/sVf+/wRTQ5JltDoWihbM3Khp4hBQTg=;
        b=de9Kt5CTxtyWM3N06gzLlqXfbp5WOfVOsPd00ZIGyw+wLuZ53xAn15Kk9DrPwuPHHs
         fqE8vlRJK1sQeilEUi25dESfhuamVK9XQzSx4kR6tLrBwKa045VhrLvjuJgPoT46RAe5
         oec9+BvmtL3okDCIy7/mIZG3G89p6/+5+fxEoBv0F/NtEqD3gwDjjDIakfu3ZwEurTNW
         TBw9rBECj30cN2V+b0GpDdTaitNKwdkubnG0T61VGsweH5YHf9lDCUkS3N86PXJNysJT
         fC9I0paRdU/SU79hCANwvz+CwQMjRF0lYJcexmHs//wji5d4xerIXda6STzf7i5OTCh+
         VL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793655923; x=1794260723;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q5JdWOppAER7/sVf+/wRTQ5JltDoWihbM3Khp4hBQTg=;
        b=Ntn9GVHrOogM/XOkUhsoeEjyk4owiAzY9fZVZwn4RkMzfbkMVpMZ2fbcNPXvA8Qqug
         AEWkx/hISytijRY6bzoPIi7rnL85aT5t2hGt+l3QS5OmBtkyR5UblKoql4p1z6EnZL1Z
         Sm2QmuiPpd114n060cYqci88jaN0TI0z7S0C/2M6MJb3ZhzAeNM7x2TfjtsSnxPeCgT/
         sHfx039TtROeHFkVM+sGWSXI9q9vQ9jn6lwhWEOgGW/aj/jZ6/QgRv25e3QCuEaQkLeL
         fjAtMSXKVwO6+8QR/iy876i7UGbof6MS8ZWQUZ3cxxlQiyGavCT+VPBJT7PPaG7rwMhk
         UUaw==
X-Forwarded-Encrypted: i=1; AKwUvBxavsK0QETtb/i5aqtcwEK/JJhJ87CnCWDXRdEnpt8hNqLr9NLtiKzCxFNjALVnwHCZm/s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qQgxwPxjBEJ+rrFKl8R50Q+MVi/8CcJHRv09uVsaIjeZ0My/G
	Eoiw3VaszQqrDh9uA8Ycc0C3dnrmxwUJY6bJsue62V3WiXrnj2X3Oe1B5uXIoR5lJw==
X-Gm-Gg: AYBFou3BhGldEPJa+Y7VjxIUs+e/CIV9GzMUzDHVcvXtMOX14bO8fvrwM3pU8EjO9YA
	VRo61+RD2JByHcOxAJZuiSRGZHG0lMaS+RuyYh+pS9cQMHPWEkFoftzP9MJDwdILlWb2s3vkUNY
	uLgE08nkXm2QRDeeqb2BLbn1zUqNol2YxJfG9ZBwH+7loT6NI7rv2egze9rKm4g92sEvZRcMZU9
	BLuKo5ULxG/qJG3CzHgC2kIIMrTTJ/XjUwgqm1IyZs8ykX/33QjdzlRruOCsoK+21EhkNqP3f0k
	ss3iSUAcA1lvsKayAwCO7qX4hT51W9PigcOBxHfPwjZsGj+On9k4lO3jEzBINKed5vUDGP5YeHp
	S8ooDkcY+wDMaiOQ8Jhzpd2VDrXFIllsv1aLUTnXjh2NBwepHutJKDQrcNUgcBnR1lpeaMCGXZU
	hR6Gwkm3qsdeLWo2yUkVzjtGA50SzX+FIwxBCk15fkgoQIWlAKpeI5qzfXglbef16oO4lReRt+E
	iVQlsexfVvmEyBR1ODjlt31ki2ZHozyi8WWWexIBDA+c5c1LkcQ60KP4P6wndxxy93N9NvauphM
	YWcF8MVaCAzbfkWoPslGVh0PY+YMyxy9tG7oYMC8+O9wf3bwr3KcwFks/H8CgrYh
X-Received: by 2002:a17:90b:570c:b0:3ac:8897:7ba9 with SMTP id 98e67ed59e1d1-3ae8985d52dmr10189518a91.56.1793655923061;
        Mon, 02 Nov 2026 13:45:23 -0800 (PST)
Received: from google.com (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c29e619sm1046130a91.0.2026.11.02.13.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:45:22 -0800 (PST)
Date: Mon, 2 Nov 2026 21:45:18 +0000
From: David Matlack <dmatlack@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Peter Xu <peterx@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH v2 2/2] vfio: selftests: Test BAR write faults after
 clear_refs
Message-ID: <aukEbs9W2rnjb1jQ@google.com>
References: <20261101062049.998160-1-almasrymina@google.com>
 <20261101062049.998160-3-almasrymina@google.com>
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
In-Reply-To: <20261101062049.998160-3-almasrymina@google.com>

On 2026-11-01 06:20 AM, Mina Almasry wrote:

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
> +
> +		ASSERT_NE(NULL, bar->vaddr);
> +
> +		/*
> +		 * clear_soft_dirty_refs() stripped write permissions from
> +		 * vma->vm_page_prot on the unpopulated BAR mapping created by

Sashiko's finding here is right. The BAR mappings may be populated
already at this point. You can reliably zap the BAR mappings by clearing
PCI_COMMAND_MEMORY. e.g.

  static void zap_bar_mappings(struct vfio_pci_device *device)
  {
          vfio_pci_cmd_clear(device, PCI_COMMAND_MEMORY);
          vfio_pci_cmd_set(device, PCI_COMMAND_MEMORY);
  }

Then you can also use this instead of mmap()+madvise() below.

> +		 * vfio_pci_device_init(). Fault it read-only first, then write
> +		 * to exercise in-place write-upgrade (wp_huge_pmd/wp_huge_pud).
> +		 */
> +		val = READ_ONCE(*(u32 *)bar->vaddr);
> +		WRITE_ONCE(*(u32 *)bar->vaddr, val);

Writing to offset 0 of every read/write BAR isn't necessarily safe. It
could be a doorbell, a write-1-to-clear status register, the MSI-X
table, etc.

There's no way to trigger the write fault without actually writing to
the BAR (e.g. MADV_POPULATE_WRITE fails on VM_PFNMAP VMAs), so the test
needs to know where it's safe to write.

To solve this, I propose adding a helper to the VFIO selftests library
that finds a BAR (or range within a BAR) that behaves like memory, i.e.
every location can be read and written with arbitrary values without
side effects. Something like:

  bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
                             struct vfio_pci_mem_bar *mem_bar);

Detection would be based on a table of known devices, and tests SKIP()
when no such BAR is found. Your test would then ask for a mem BAR of at
least PMD_SIZE and run both cases on it.

This came up recently with Matt's DMABUF mmap() test as well [1], so I
think it belongs in the library rather than in vfio_pci_device_test.c.
It shouldn't be much more work than a test-local helper (but please add
it in a separate commit).

My suggestion would be for QEMU's pci-testdev (1b36:0005) to be the
first device in the table, since anyone can run it in a VM without any
special hardware. With membar-backed=on, pci-testdev's BAR2 is a 64-bit
prefetchable BAR backed by plain RAM, so it's safe to read and write
anywhere in it. membar-backed requires QEMU 10.1 or newer. For example:

  qemu-system-x86_64 \
    -machine q35,accel=kvm,kernel-irqchip=split \
    -device intel-iommu,intremap=on \
    -device pci-testdev,membar=1G,membar-backed=on \
    ...

Then boot the guest and run the test against the device:

  $ BDF=$(lspci -D -d 1b36:0005 | awk '{print $1}')
  $ ./scripts/setup.sh $BDF
  $ ./vfio_pci_device_test $BDF

membar=1G is large enough to exercise both PMD and PUD mappings, since
vfio_pci_bar_map() aligns the mapping to min(size, 1G). If 1G of host
RAM for the BAR is too much, membar=2M still covers the PMD case.

If you want to also add the device you reproduced on to the table, that
works for me too. More devices can be added later as needed.

This could also be added to the vfio_pci_driver framework, but I'm not
sure that is a good idea. Devices that have large memory-like BARs
aren't necessarily the same devices that can implement memcpy and send
MSIs.

Would you be open to adding vfio_pci_find_mem_bar() as part of this
series?

[1] https://lore.kernel.org/kvm/CALzav=cGtmkBBpfUA8nP7AQ3azB_Hn7_8jJL=J+E+h61CpOFrw@mail.gmail.com/

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

Should only BARs >= PMD_SIZE be considered tested?

> +	}
> +
> +	vfio_pci_cmd_clear(self->device, PCI_COMMAND_MEMORY);

This should restore PCI_COMMAND_MEMORY to whatever it was at the start
of the test. Or just leave PCI_COMMAND_MEMORY enabled (that would also
be harmless).

> +
> +	if (!tested)
> +		SKIP(return, "No mappable read/write BAR on %s\n", device_bdf);
> +}
> +
>  FIXTURE(vfio_pci_irq_test) {
>  	struct iommu *iommu;
>  	struct vfio_pci_device *device;
> -- 
> 2.56.0.385.gac671c819a-goog
> 
