Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE28C2C8
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791936030; cv=none; b=SLlf6rZgyUedct9XDMpYLixf/XCb0U5vlJjz4rQzr/K3k78/Cyh3MNPe83WqFW6cAjzhsKI+9k+37vnTYxK/Ycazj5IjeDhLxrgWDM0S8kG05id6PceYKHXEyYMX4rx8AeslPqMphKHMydATjLh9YzC4eDaS/zH2PURCDFax0rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791936030; c=relaxed/simple;
	bh=FSTxUGQtt1X9cUsFQ/i8NA1E065OntRXZtl9VO//Avc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8YQJfSGz7R76VqXYywqhYRkHxe7tFKCykUfr82ocPUNnIrMqQmckG4lrobfAY2KKxkapcQ9ACu0FsyOwPUT+dpOFpV/usHArQMbOm9rnfptOQ6NQZaQsPW28oV4qIE9F//VhE1yl3wvudn8N3m9LIvOV87huFwq7fCC7vJy+nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JeyZkBDY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RgdqNe/K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JeyZkBDY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgdqNe/K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791936028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OyJNtakCX3un/2pf1+yhpa5FhexdwrnTrBGiDYOcARo=;
	b=JeyZkBDY2llpRR7scCQlRscG3JPSUUyqLxgqRrVMB0TXe7numa9rAjFaeGiVMfqnebaiLJ
	d50QUAaXoF8ffENPa9ErvTi3eW/zD33UqqWlje2JhlYquht+OIpS+21SSP2BEHOZiw/HBL
	zBREC/BvjKz8cVLEX+KmDgl/rsyO0xQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-Ks3DMEBlOOGNbcoBVnf-6Q-1; Wed, 14 Oct 2026 00:00:26 +0000
X-MC-Unique: Ks3DMEBlOOGNbcoBVnf-6Q-1
X-Mimecast-MFC-AGG-ID: Ks3DMEBlOOGNbcoBVnf-6Q_1791936025
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1612c4b80so36316125e9.0
        for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 17:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791936025; x=1792540825; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OyJNtakCX3un/2pf1+yhpa5FhexdwrnTrBGiDYOcARo=;
        b=RgdqNe/KhojBS/7dE/VtDxpczmL7vu/123r7OyW8z7VN5Y1UA20fVg8+cZ/pzb639W
         /pwsUpbahBpAwp+5g6sQr9B7RzBu7FGSzBPpDemCXTXTlxW7tHEbyUzzMY0ZRiIzM9S3
         bb+D9ZmnsDLw/uI7TnIIo0A+pNyeQKbJGWqtURPeMjSaNnQiradoJp7hEwDj/mioqb18
         95S2pnz6ss6jF8sUv+J9FS9TS6yVEGdZrjEbQaykzC0xNJNXJmnnn1da8+rmu4dziOro
         34ymzFP9iZKM8+TugDcZl3M4Zrkfbr9uolBaBODkRgMIsZ+Sd3tY/t4towje9cjdHV1x
         L8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791936025; x=1792540825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OyJNtakCX3un/2pf1+yhpa5FhexdwrnTrBGiDYOcARo=;
        b=2SuaLaXT8oqjeNspC23XQ4VS20diVX/wUwWI/0B68/XngJUBi0Aw9iCu2OLm4NMi0A
         QkrJwmDyX3eKV8UXoOmhMx0FIqNk9B/GAnufkEtVHKg9TYqLKhRTNVoQzfdxVr5Qw9BW
         odM0swwG2KSxexDDfrVmxl1fCDnnvpwq2KJ1OOwjugVUckPKhLYyNfUIHIYwWSMJHt0j
         faOBEQXqyy6Cq9ZNnCLo1HEPACyJTiYB0Ii5fdLypVx+2NGmUJru4mghLb3i24wIN3fj
         g/7tGxVHKNHDMfUIAsULy0Lexz3+8pFxnqfwXK4G7SJsMP5b3GWDHsquL96ByFcRCCLg
         E7uQ==
X-Gm-Message-State: AFq9FYLOTrnSuPfDSQH4+CmstmkDxe+X3u2hRP63xHlepflzqj6qdgm6
	SIYR/AKfoBpi1DL1EEfbNpiWr6Wx2AikoJNu2iwlg2m/epKj9VlvHkDyiJS4yUNHL9uSh5sUUCu
	L1yS0PCnQ2VxUc03poCxDC2byMdLd5pWWQs5+t5rRAh7Q0fSVTWtw26c21BYu4A==
X-Gm-Gg: AYBFou38UBQmAF4CTK2RmSzfSGMbz3qZQBrzJMKpiy3LLZ5z6X44MnI9wSg/XaaMcNE
	ClI4S+VT4nRuW98DN5xvf365CFlgwMvOuqwQdjoDJSrA/Y8bBbo5l+6Pvxa7IU/bLXR82Ib9X6o
	uTNvXk2IPbhDRFD7HaemEvlwu0ebg7V+QyPYe9K244sKlKwVDbjHhTxy/6SIxNlcVxcICJ4nd/L
	lM3n6rld1Q8X0A8cIAfnu53J664SVQK7lrWvL2mW9434HEE3xCqow1CUaFy7YRnIhb4j60MzqhH
	RUveXwAwCSmyDsIJVTntKq5IHHoH9pxpZY1/uNBeG93d5ZzWZ8uKYyOlDnPHiBFgBwfcYA==
X-Received: by 2002:a05:600c:4f89:b0:4a1:acaa:9d4c with SMTP id 5b1f17b1804b1-4a1acaa9f79mr68275665e9.25.1791936024632;
        Tue, 13 Oct 2026 17:00:24 -0700 (PDT)
X-Received: by 2002:a05:600c:4f89:b0:4a1:acaa:9d4c with SMTP id 5b1f17b1804b1-4a1acaa9f79mr68275255e9.25.1791936024166;
        Tue, 13 Oct 2026 17:00:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea0f1csm572672735e9.9.2026.10.13.17.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 17:00:23 -0700 (PDT)
Date: Tue, 13 Oct 2026 20:00:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: read ROM via ACPI _ROM when hardware ROM is
 unreadable
Message-ID: <20261013195125-mutt-send-email-mst@kernel.org>
References: <31aa2fb273d7ff7ea535c74e0780e279aa9a119c.1791933554.git.mst@redhat.com>
 <sashiko-outbox-170641@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-170641@kernel.org>

On Tue, Oct 13, 2026 at 11:36:05PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] vfio/pci: O(N^2) overhead in ACPI ROM read via recalculating size
> - [High] vfio/pci: infinite loop in ACPI ROM size calculation
> - [High] pci: NULL pointer dereference in vfio_pci_acpi_rom_read() when _ROM returns no object
> - [Medium] vfio/pci: ACPI ROM reads truncated by unreadable physical BAR size
> - [Medium] vfio/pci: ACPI ROM reads missing 0xFF padding
> --
> 
> commit ef01db8fb34fde6cd15f6043dd6655f51df61bf4
> Author: Michael S. Tsirkin <mst@redhat.com>
> 
> vfio/pci: read ROM via ACPI _ROM when hardware ROM is unreadable
> 
> Some GPUs (e.g. NVIDIA Quadro P2000 Mobile in a laptop) have a ROM
> BAR that exists but is unreadable because the GPU was never POSTed
> by the system BIOS. On these systems the VBIOS is available via the
> ACPI _ROM method provided by the platform firmware.
> 
> > diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> > index df88480876815..9bc0a7df4fd69 100644
> > --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> > +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> [ ... ]
> > @@ -198,6 +199,112 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
> >  }
> >  EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
> >  
> > +#ifdef CONFIG_ACPI
> > +static int vfio_pci_acpi_rom_read(struct pci_dev *pdev, void *buf,
> > +				  loff_t offset, size_t length)
> > +{
> [ ... ]
> > +	status = acpi_evaluate_object(rom_handle, NULL, &rom_args, &buffer);
> > +	if (ACPI_FAILURE(status))
> > +		return -EIO;
> > +
> > +	obj = buffer.pointer;
> > +	if (obj->type != ACPI_TYPE_BUFFER) {
> 
> [Severity: High]
> If a system's ACPI BIOS is flawed and the _ROM method executes successfully
> but returns no object, acpi_evaluate_object() returns AE_OK but leaves
> buffer.pointer as NULL.
> 
> Will this unconditionally assign and dereference a NULL pointer via
> obj->type, crashing the kernel when vfio_pci_acpi_rom_size() is called
> during region info ioctl?

i can harden it sure.

> > +		kfree(buffer.pointer);
> > +		return -EIO;
> > +	}
> [ ... ]
> > +size_t vfio_pci_acpi_rom_size(struct pci_dev *pdev)
> > +{
> > +	void *buf;
> > +	size_t size = 0;
> > +	int ret;
> > +
> > +	buf = kmalloc(0x1000, GFP_KERNEL);
> > +	if (!buf)
> > +		return 0;
> > +
> > +	do {
> > +		ret = vfio_pci_acpi_rom_read(pdev, buf, size, 0x1000);
> > +		if (ret > 0)
> > +			size += ret;
> > +	} while (ret == 0x1000);
> 
> [Severity: High]
> Does this un-bounded loop rely entirely on firmware behavior to terminate?
> If a buggy or malicious ACPI _ROM method ignores the offset parameter and
> always returns a full 4KB buffer, will this cause an infinite loop and a
> kernel soft lockup?

i can limit to 16M as per pci spec.

> Additionally, this loop evaluates the ACPI method repeatedly in 4KB chunks
> to read the entire ROM just to determine its total size.

i will cache it.

>  Since
> vfio_pci_acpi_rom_size() is called in vfio_pci_bar_rw() on every read,
> will this cause severe performance degradation?  For example, reading a
> 128KB ROM in 4-byte chunks would execute the full ROM reading loop
> via ACPI 32,768 times.
> 
> > +
> > +	kfree(buf);
> > +	return size;
> > +}
> > +#endif /* CONFIG_ACPI */
> > +
> >  ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
> >  			size_t count, loff_t *ppos, bool iswrite)
> >  {
> > @@ -215,6 +322,14 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
> >  		end = pci_resource_len(pdev, bar);
> 
> [Severity: Medium]
> This sets the hard limit for reads based on the physical PCI resource length.
> If pci_map_rom() fails later in this function, we fallback to ACPI ROM.
> However, if the ACPI ROM is larger than the unreadable physical ROM BAR size,
> will reads beyond the physical BAR size be improperly rejected with -EINVAL,
> even though vfio_pci_ioctl_get_region_info() correctly reported the larger
> acpi_size?

end will be 0 then.


> 
> >  	else if (bar == PCI_ROM_RESOURCE && pdev->rom && pdev->romlen)
> >  		end = roundup_pow_of_two(pdev->romlen);
> > +#ifdef CONFIG_ACPI
> > +	else if (bar == PCI_ROM_RESOURCE) {
> > +		end = vfio_pci_acpi_rom_size(pdev);
> 
> [Severity: High]
> As mentioned above, is it too expensive to invoke this size calculation
> for every user read?  Should the ROM size be cached during region
> initialization instead?


it should.

> 
> > +		if (!end)
> > +			return -EINVAL;
> > +		end = roundup_pow_of_two(end);
> > +	}
> > +#endif
> >  	else
> >  		return -EINVAL;
> >  
> [ ... ]
> > @@ -235,6 +350,15 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
> >  			io = ioremap(pdev->rom, pdev->romlen);
> >  			x_start = pdev->romlen;
> >  		}
> > +#ifdef CONFIG_ACPI
> > +		if (!io) {
> > +			done = vfio_pci_acpi_rom_rw(vdev, buf, count,
> > +						    pos, iswrite);
> > +			if (done >= 0)
> > +				*ppos += done;
> > +			return done;
> > +		}
> > +#endif
> 
> [Severity: Medium]
> When reading past the actual size of the ACPI ROM but within the reported
> roundup_pow_of_two region size, does this bypass the standard VFIO
> padding logic?
> 
> If vfio_pci_acpi_rom_rw() returns a short read or 0 (EOF), will this skip
> the vfio_pci_core_do_io_rw() logic that safely pads remaining space with
> 0xFF, potentially breaking virtualization software expecting standard
> hardware behavior?

right better copy

> >  		if (!io)
> >  			return -ENOMEM;
> >  		x_end = end;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/31aa2fb273d7ff7ea535c74e0780e279aa9a119c.1791933554.git.mst@redhat.com?part=1

