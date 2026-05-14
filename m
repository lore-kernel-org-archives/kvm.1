Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDE93CF970
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778799530; cv=none; b=U+ZbkFLN2qez7zPljmsmouVftfx8fGSxCwQeHElk4hBrcbLS+FnmF0AbMaJt4WDXFZ8SYGDfTp0Q9cz2oVZ89+VbvAu8GAguAXl3gHuRBP7LgvorcvUKj9KTskCpJLDSg/uHm6q/th6pW3ZBr02rkOGp0IPZMlJDM120EL4VJr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778799530; c=relaxed/simple;
	bh=i8w7VpQr+6X4a4/yPJf10QNnECBtGebsq7fakngaHoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNxpmrU5Vy+dzhklGVLP8NdKCPmw9couPPbZYscvUIkIH9CthtYTfmso0A4cjR+z0wX/5MHLTd+sReM7RQHnLf6bbwp2UO8GapNsvuin3rIZFfk/3fJ13bsZo2rVBcR9qLL8mOF95GynbwO1wuz3WiMsSyYA9IVnhlzzEy/b+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P27eIE26; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P27eIE26"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c15849aa2cso11679112eec.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 15:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778799528; x=1779404328; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NDdeoDPqkkjirbrQZdWdWsogLJA5TPCEhQZ/zT+bmaQ=;
        b=P27eIE26Pv5O1uJl4GQsNyAlMANY+J5yNtaKctEriMhzPF6YIgKa0RrLEUfr6uFQ8Z
         7W7WsgcjJEiUMEzEB1NEESaz9wWoFHa8BVY6wnPoNF5rJe1YJQDitlW7enHCbL+LyVgl
         pbpYnug3+IFDuz8Sqgn0+FJcGiqZiTIeew3N6Y/a08MRw6wzQ5i//dqGNbpgZlfLixGT
         3+yA4ZA6xvqSu55tEiifpw7iYgOb0gseTiniibabTMWn6VgdnlRiux+QrFD1sX12yzM2
         /0DmKWLYzAq040Q9OZYxsMI9k34YLTpcyTQcFs6uLiJuXaF9R+DR/skW5R+Y2yVo2zqw
         78dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778799528; x=1779404328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDdeoDPqkkjirbrQZdWdWsogLJA5TPCEhQZ/zT+bmaQ=;
        b=T+DeKhcOoq4a5MK+WfpE08+f31XvFCh9PBmJHEoNoQvCd7nTdgIt4yiNUvswI15vEi
         Uqr1b6ouwJ4iiiETGytzgQBloenUSm/iaMw0XKYBLEHhVb1V8OuR/H3GtloC7UXYo5OC
         itE3ZL2gGJLDkxjYSOviaGs/8cyPv5HzQ4C4Jcb+WO1kSN9naiVF4n4sZJesG9ATaaI0
         R88djUpUteJlZwmeMiMa+qH4E4lPI/il93jnFD7AiZYncrVvR4cmgE1uj6m5mKTwTZP4
         hnnE+P/O7WA+oVfEZMLXa5V+XNv0uMhTLiDtcWVm57tBZCLyFjQ6qirwQwxYFy7qlNnb
         Kvxw==
X-Forwarded-Encrypted: i=1; AFNElJ/MZ5DuENIcXNYvjyb8t5RSHkrGUczPAq7tq+k0hm2QYIYGkDtyGQOEReTJQrFB/CYMVb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL7eVyGYKiaySVKVmRTnNtFt5TZzOQ8dc9Z7ff5XTTCw0ptwcA
	2KqDW31j9vkq4Dl5L2z+PSJ7NUCloyGc+QRSVmNYkaYXcZy0RTX06X8jJxpSW0FSuQ==
X-Gm-Gg: Acq92OGJSO7uwL0g/2ScyXdZAOHLBRJwJmuqNGX6HNn1Lds0/VqHMBHpIY6dkNG4NDR
	pEckEzIKCKSJlDjjYmeFk+GWs3GyfgoGYqZ/76ZoHd/Chr1DLyzuRUgwXlKieG8emi8+R4V+aVJ
	EPFC5gpvaS+RZt87sey6nWEc7vDwrBrubwvOIJXW8i/u63Xw9fMNHFOhlOPRHPUY5wu6rO1jk8D
	EY3f3NABZR7hYJSTezihY2p2rQHkz3cYCvIVhojpd8sxLc4QC8e1o0YS4kwLw6fQCdDH9o/hs0a
	iENNiVn3MsaME6RZNnKum6zqc1x8cFD6mk/24uE4N3F7T3HHt0UFX9PuCFpybxSVK4h8ho9wRwa
	DoXQetGBc2wSGG9W8a1cdTw+sQ0DyjP6ieFnMNMzDPCbo2UiPsB2nt0+2qkhfuAqF/2eXW/CzXp
	MTtDJJkAjjXVYkJgXK5boXIFgpR52QZCyTLYS6/TFJfHWDtTN64Qh4RcMppPSZ0/SX7kAtD63q
X-Received: by 2002:a05:7301:6448:b0:2da:a813:a5fd with SMTP id 5a478bee46e88-3039867fa16mr894249eec.22.1778799527786;
        Thu, 14 May 2026 15:58:47 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978b1a79sm4765745eec.28.2026.05.14.15.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 15:58:47 -0700 (PDT)
Date: Thu, 14 May 2026 22:58:43 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Josh Hilke <jrhilke@google.com>, Vipin Sharma <vipinsh@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] vfio: selftests: Add driver for IGB QEMU device
Message-ID: <agZTo-OzlSbD9G5n@google.com>
References: <20260511211839.2781731-1-jrhilke@google.com>
 <agJqAO-RRdjMrUZJ@google.com>
 <CAAdrzjtiiOtw7-YL2COgZC-QSFp6LLwq+jP9V3jPKLUe0w7Y0g@mail.gmail.com>
 <CAAdrzjuf3z-CyWeBRPKmMQxmQZ9U=2Tc0cDAFqdRFRDHKw_K-Q@mail.gmail.com>
 <agUKLmKLoV71Hq6S@google.com>
 <20260514102824.6be38bf6@shazbot.org>
 <CAAdrzjv7FiYWhXHDJQvK-c71UpKo+uwOu-dnbtka=6p2qj86zQ@mail.gmail.com>
 <20260514164844.2698802c@shazbot.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514164844.2698802c@shazbot.org>

On 2026-05-14 04:48 PM, Alex Williamson wrote:
> On Thu, 14 May 2026 14:49:28 -0700
> Josh Hilke <jrhilke@google.com> wrote:
> 
> > On Thu, May 14, 2026 at 9:28 AM Alex Williamson <alex@shazbot.org> wrote:
> > >
> > > On Wed, 13 May 2026 23:33:02 +0000
> > > David Matlack <dmatlack@google.com> wrote:
> > >  
> > > > On 2026-05-13 11:49 AM, Josh Hilke wrote:  
> > > > > On Tue, May 12, 2026 at 7:12 PM Josh Hilke <jrhilke@google.com> wrote:  
> > > > > > On Mon, May 11, 2026 at 4:45 PM David Matlack <dmatlack@google.com> wrote:  
> > > > > > > On 2026-05-11 09:18 PM, Josh Hilke wrote:  
> > > >  
> > > > > > > > +     retries = 100;
> > > > > > > > +     while (retries-- > 0) {
> > > > > > > > +             if (rx->wb.status_error & 1)
> > > > > > > > +                     break;
> > > > > > > > +             usleep(10);
> > > > > > > > +     }  
> > > > > > >
> > > > > > > Why bail after a certain timeout? The test may have kicked off a large
> > > > > > > count of memcpys. Is this for error detection?  
> > > > > >
> > > > > > The bailout was intended to detect errors during development.
> > > > > > Shouldn't need it anymore. I'll remove it in v2.  
> > > > >
> > > > > Sorry, I forgot: we need the timeout  to detect DMA errors for the
> > > > > memcpy_from_unmapped_iova test in vfio_pci_driver_test. The test
> > > > > triggers an IOMMU fault because the IOVA is unmapped, and the IOMMU
> > > > > aborts the DMA operation. However, the QEMU IGB implementation does
> > > > > not set an error bit, so timing out is our only method for error
> > > > > detection.  
> > > >
> > > > Hm... that's going to be tricky then. This means we would have to set
> > > > the timeout to longer than the longest possible memcpy duration to avoid
> > > > false negatives? That means we'll have to set the timeout to quite long.  
> > >
> > > FWIW, I had AI churn on trying to make this work on a physical 82576 as
> > > I have several of these in my local machines as sort of the defacto,
> > > readily available SR-IOV NIC.  The AI got up to 30/35 tests passing but
> > > is currently stuck that the queues stall in the mix-and-match test when
> > > it's trying to DMA from an unmapped IOVA.  So far none of the in-band
> > > methods to kick the queues seem to work, I'm not sure if we'll need to
> > > resort to an FLR.
> > >
> > > I'd be happy to send the changes it's made so far if you want to
> > > validate and incorporate, or have any thoughts to kicking it after the
> > > IOMMU fault.  Some of the changes are related to timeouts, where QEMU
> > > loopback is actually faster than bare metal since the physical  queues
> > > run at 1Gbps even in loopback mode.
> > >
> > > I'll also plant the seed that if we do have outstanding issues for a
> > > driver that binds to a real world device, but only works on the
> > > emulated version of that device... how do we handle that?  In part, I
> > > think it's emulated in QEMU because it is so ubiquitous.  I'm also
> > > hoping to use the same device for the new SR-IOV selftests.  Thanks,
> > >
> > > Alex  
> > 
> > I'm glad you're interested in this as well!
> > 
> > Unfortunately (and ironically) I don't have access to a physical device.
> > 
> > Regarding driver support for the real vs. emulated device, I think we
> > should prioritize supporting the emulated version. This approach
> > unlocks the ability for anyone to run VFIO/Live Update tests without
> > needing specific hardware. Once that's done, other folks can add
> > patches to update the driver if they want to use the physical device.
> > What do you think?
> > 
> > I plan to add SR-IOV support to this driver in a separate series after
> > the driver merges.
> 
> I've got it working now, I'll need to do some cleanup and verification,
> but it's not too bad (imo), several places where QEMU emulation only
> supports one mode and we don't fully configure the device or don't
> account for physical hardware limitations or timing.  The most
> significant change is in resolving the issue above, that once the queue
> gets wedged from DMA errors, VFIO_DEVICE_RESET unfortunately seems to
> be the most straightforward mechanism to get it unstuck.  That may
> result in some initialization refactoring and plumbing to restore the
> interrupt state. Thanks,

FWIW I had to do similar for the ioat driver, except it used a
device-specific reset mechanism instead of VFIO_DEVICE_RESET, so I think
this approach should be ok.

static void ioat_handle_error(struct vfio_pci_device *device)
{
	...
	ioat_reset(device);
}

static int ioat_memcpy_wait(struct vfio_pci_device *device)
{
	void *registers = ioat_channel_registers(device);
	u64 status;
	int r = 0;

	/* Wait until all operations complete. */
	for (;;) {
		status = ioat_channel_status(registers);
		...
		if (status == IOAT_CHANSTS_HALTED) {
			ioat_handle_error(device);
			return -1;
		}
	}

	...
}
