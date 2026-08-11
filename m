Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719D53563E8
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 20:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786480317; cv=none; b=h95hz1gVL8M6ODkN2xhMMlQzle84AQgjdSkpPv4HGTxpwRZKkJSgHHemJyD4E9nNEVtu2kgJzG2v7G2qsQdB3wV4QvUrXHSBYpKufEXtEsQtBUJvuVALtehK7n8LoZhYuXRSs+gwaTPbCCzYQpeHLuTkZvuXoIkvKCxb1RSsvno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786480317; c=relaxed/simple;
	bh=43c2sAspAfaKueM+YidHaHPS8dQ8ABbXqcByJfz9V4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fia+hoEXkqgzw1ZTPaLNb+Kjdtvh4kWUIOwSX52KBuGynQtP9BTs1N5NGKttpOYT4BV1I9tqKkxiKNzH2TzcYeENjKIuop4LyOdGEs0wuEaNWO240FH/zWYJwuvrb3BqlvKOIKUQU0xl2mvNy7zliS7w/cFXgaGN6TCbulf+cRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HRNlA8KK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HRNlA8KK"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cab97c86bdso9065ad.1
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 13:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786480315; x=1787085115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8HHyJsi6w9gqCfUisYo5+cUu/4xV1eXFx3itps6/QZY=;
        b=HRNlA8KK93Jxc8T1djbfWUier4KMSUhcWwhKN5H0qcK99zvQtkKR4w2SDfBgNzfcYF
         +7XXgKUwfR802WcvoBnV97zOfTKLvGchlvUna96amGTQNnU6aVL2paZokZGOTmWVUYLU
         oUQkGZgQVlYub8kMTgTdspQBnWK//ev3JCmNkhDwPgwMDxEJdoaw02awGEWYeYgpEQid
         jIldhriNnJWzQ19PNCTbJ6dzYigCHJ0Ly5ekNBMfE7DZQLYqsZE09n0Fs0cw9mqIwNvZ
         UWu3YrtD95q2eYtNmWtL6qCf2xJHni9/XlPZd2yF+llQbhGaf9uN+vZaOrOogATG1uLt
         i8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786480315; x=1787085115;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8HHyJsi6w9gqCfUisYo5+cUu/4xV1eXFx3itps6/QZY=;
        b=VuR4uZxkChjL9R2FzUyDF9SvMAy5p00wck4xYl9Pv7aOGR8cUXl9OCLEu2OYFNjA5Z
         C7L1QAM89MUTJAJg1/SV1b/nACNPfHyLqNP30eA9tCc3N/hRnbajYmyXM3jMvAlbfqID
         OG7VZiakzzbjxgAsjs/OnOxrD/f29alFpPOdZmJBLdB1Rz4B8peH12TmbTrVmyUB0xJP
         iT49zPr0PrD6eoAfYO6CYRmUm1f1oiKLQLllIc2T5RznHC4ATzzCs4k3zCp9PkTzJxEu
         jhCQJYMQQfh3etl44Vnia87YFBd3iS6x2zskkHnj3nfH2nxaHcAvyZTU3FFpWUcPyVyt
         r5Og==
X-Forwarded-Encrypted: i=1; AHgh+RohZxakbbvWukP1I5eZ/+Xq7MdX07gCCpb1QAn+IdRb3OCJHbXmAGuHYxTdwUaXL1Q6usI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGg75TS81+kOmyLFqqT7oQy49cfOFDxArN8bQx9oBPc/+8W4Oh
	+RsWlD6JpOFm86Rq7/j3mXLrhxhKXEhCcKQTi8UqLZbdjO/kuPe3f1oPqj7PfYIlnw==
X-Gm-Gg: AR+sD11r368YWsqERdJ6XLB/qE+ZQ8hWFCz4HCR7s4yOKt+DUCWykeu48RqOD32C7Sk
	Rz+yNJYuMhDQ3qoMtpvlZb4Ln2rwQbibY5nHNiZY/5AVEWhCKo2zOzaHAPRRt3+DX6o5uH0bd3x
	NTpLLoA2R3RfBq95WSnNck0IUbcD4CPd5spsQ3GGmCe71/nZFJOWNK3UoO3EQP8JY28QenuaBvd
	AbVNguZmWRj12nVvsjpDDYSFIJwtRjJdpYe36Ez6wqimh33QWPHKFpp8oIaMuBEfaGw+W7XEn4w
	zdth6VS2Lqnn9V2hrHuGjhE7+FP/F4Jg61vhm6ja0sxzf+5G4kbUhdLIQwWaXpSXAABn8MoWblj
	yk851b79P2l9gpRdvMn4JI26uEtZ3gOrA5NrkINL4BzTavPpK6scjleoGNkDL2Xa1qAl2IjJxw0
	5plr3L+CUtZQJ+sV5RYrvmM9oMx1WJhvOpgP8OQZmKkwwaRoIT8bXD6bg/iffTBf9OVYVxjzWAo
	bkKM7sbL47Sp/9dVwhiJ2B7x4/d19q21Kg4OGV7h2YeH4dSE4Ddv6NQ21h2yZvbIsz3RWB1Q8w=
X-Received: by 2002:a17:903:3e24:b0:2d0:1aaf:daec with SMTP id d9443c01a7336-2d33a9bb8b9mr1771485ad.9.1786480313955;
        Tue, 11 Aug 2026 13:31:53 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392fe4a8c05sm122090a91.2.2026.08.11.13.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 13:31:53 -0700 (PDT)
Date: Tue, 11 Aug 2026 20:31:49 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, bhelgaas@google.com, 
	Kevin Tian <kevin.tian@intel.com>, Leon Romanovsky <leon@kernel.org>, dmatlack@google.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] vfio/pci: Disable sriov on PF device close
Message-ID: <anpJrnR6Lbmgqad-@google.com>
References: <20260805003355.728299-1-skhawaja@google.com>
 <20260805003355.728299-2-skhawaja@google.com>
 <20260805090323.01b1a36f@shazbot.org>
 <20260806194739.GH28508@ziepe.ca>
 <20260810093223.50dbc8d0@shazbot.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260810093223.50dbc8d0@shazbot.org>

On Mon, Aug 10, 2026 at 09:32:23AM -0600, Alex Williamson wrote:
>On Thu, 6 Aug 2026 16:47:39 -0300
>Jason Gunthorpe <jgg@ziepe.ca> wrote:

Thanks Alex and Jason for feedback.

>
>> On Wed, Aug 05, 2026 at 09:03:23AM -0600, Alex Williamson wrote:
>> > On Wed,  5 Aug 2026 00:33:55 +0000
>> > Samiullah Khawaja <skhawaja@google.com> wrote:
>> >
>> > > When userspace closes a VFIO device file descriptor, the vfio driver
>> > > performs a hardware reset on the PCIe device to ensure it is returned to
>> > > a clean state. However, if the closed device is an SR-IOV Physical
>> > > Function (PF), it may have instantiated Virtual Functions (VFs) that are
>> > > actively bound to host kernel drivers (or other vfio instances).
>> >
>> > Wait, what?  We actively try to prevent VFs from a vfio-pci owned PF
>> > from being bound to host drivers other than vfio-pci.  You need to
>> > overwrite the imposed driver_override to make this happen and you're in
>> > a very precarious security model to have the VF owned by a trusted
>> > in-kernel driver while the PF is owned by userspace.
>>
>> Maybe, it really depends on the device. I can easially see someone
>> using a device where this would be safe. mlx5 for instance is pretty
>> OK.
>>
>> So I don't really mind someone doing this, we should block it and warn
>> it and so on, but like noiommu and the other vfio insecure modes, why
>> not give an opt in?
>
>An opt-in to what currently?  We generate a warning, but nothing
>actually prevents the re-bind to an in-kernel driver.  Whether that's
>sustainable in eliminating this reset gap is yet to be seen.
>
>Binding a VF from a userspace owned PF flips our model on its head in
>two important ways.  First is the security inversion.  An in-kernel PF
>driver is considered trusted, we absolve ourselves of issues related to
>whether the PF has access to VF data or interrupts VF operations and
>state through reset.  Second, the vf_token model explicitly defines the
>trust and coordination boundaries for the userspace SR-IOV ecosystem.
>An in-kernel bound VF lives entirely outside of that boundary.  For
>example, one mechanism we might use to prevent an MCE around PF reset
>would be to zap VF mappings and invalidate dmabufs.  Reinstatement of
>those mappings would require userspace coordination, which the vf_token
>model would define as an implementation detail in userspace relative to
>vf_token coordination and trust.

As you rightly mentioned that this issue would occur with vfio-pci bound
VFs also. For example a PF bound to vfio-pci can be closed and reset
meanwhile the VFs bound to vfio-pci keep working as usual. This might be
ok for some devices. But I think zapping VF mappings and invalidation of
dmabufs might not be enough. For example these VF drivers can continue
to generate ATS invalidations (posted PCIe messages that are dropped
silently).
>
>So we haven't done anything that explicitly blocks or taints this mode,
>yet, but correctly handling reset could be a tipping point.
>
>> > It's possible there are gaps that closing the PF can interrupt the VFs
>> > and we need to defer a reset until the VFs are closed,
>>
>> Oh definately, when running in a SRIOV mode it is really problematic
>> for the PF to reset while there are any active VFs. The PF controls a
>> number of shared items (MMIO, ATS, etc) and when it blips everyone is
>> at risk of unexpected fairly catastrophic system crashing errors
>> related to the shared items going away.
>>
>> So resetting the PF device unconditionally when vfio closes is
>> definately wrong in principal. I can see it maybe working for simple
>> systems, especially ones that don't MCE..
>>
>> I don't think we can skip the PF reset on close because of dev_set
>> reasons and leave a rouge device for the next user, so the thing looks
>> somewhat troubled?
>
>This is what our vf_token model would handle, if we could use it.
>Re-open with VFs in use through vfio-pci requires the vf_token
>proof/opt-in.  Re-open with no VFs in use could reset the PF, but we
>can't account for VFs bound to in-kernel drivers.

I think even with this a PF reset blip can be catastrophic for the VFs
in some usecases or devices. Maybe we need an opt-in where the PF driver
can specify that keeping the SRIOV enabled during PF reset is
catastrophic for it and so the reopen is not preferred by it?
>
>> Adding the sriov disable here at least makes it defensibly safe, that
>> we do still clear the PF on close, and we don't take risks that the
>> active VFs will crash the system during the FLR blip.
>>
>> Though I understand it was not the original intention, I feel we have
>> ended up in a strange place with the SRIOV PF feature ..
>
>I think we have 3 potential options for PF reset:
>
> a) All resets are blocked or deferred while SR-IOV is active.
>
> b) VF mappings are zapped/invalidated at PF reset and require
>    coordination to be reinstated.
>
> c) VFs are torn down on all PF resets.
>
>Option (a) is complex and doesn't look like stable material.  A deferred
>reset on .close needs to materialize on .remove or .sriov_configure
>(and of course .open), but to allow in-kernel VF drivers we can't rely
>on vfio usage counts, or even our vf-token trust boundaries, which is
>what leads to the .sriov_configure hook since we need to take advantage
>of every opportunity to issue a deferred reset when SR-IOV is not
>active when we can only rely on the PF state.

In my cover letter I pointed out that this problem probably exists in
the in-kernel drivers (or PCI core) level also. For example an SRIOV PF
driverA can reset the PF while VFs are bound to driverB. This makes me
wonder whether we should fix this at PCI core level to maintain the same
policy for all drivers when it comes to PF/VF lifecycle?  Basically,

option1) On PF reset when there is SRIOV enabled, PCI core returns
-EBUSY from the reset API.

option2) On PF reset, PCI core disables SRIOV. This might be tricky as
some drivers might block this waiting for VF driver tear down and
remove.

We probably cannot do this as default policy as it will break the
vfio-pci model where the PF can be reopened as you mentioned above. I
think if we go down this route, we would need some way of establishing
trust and lifecycle rules?
>
>Option (b) is potentially more simple, it implements the blocking of
>access on reset in the kernel for enforcement, but defers the
>coordination of reinstantiating mappings to userspace, which is really
>how the vf_token model is intended to work.  This is incompatible with
>in-kernel VF drivers, which I think means tainting on VF unbind from
>vfio-pci and those working outside the model would tread carefully.

While this might solve the issue for scenarios where the MMIO of these
VFs is mapped or exported (dmabufs), this might not be enough as the
software still remains out of sync as compared to the state of the
device.
>
>Option (c) is the more heavy handed approach, it means that a PF driver
>cannot fail or exit and re-attach.  We have existing logic that handles
>a PF driver re-opening the PF device with active VFs and authenticating
>the vf_token (logic also broken by in-kernel VF drivers that bypass the
>vf_token mechanics).  There also appears to be significant locking
>challenges in this approach, ex. the inversion of getting the device
>lock for SR-IOV teardown from the ioctl, config space, and .close
>contexts.

I think this can be a reasonable opt-in option that the PF drivers can
use to indicate that on PF reset keeping the VFs alive is catastrophic
for it and it does not want to reconnect to the VFs. If we want to go
for this one, I can maybe try figure out a way to break the locking
issues.

Or we could certainly do this in a deferred way that is somewhat similar
to the option (a). Basically PF openers can opt-in to not reset the PF
on close if the VFs are enabled, and teardown the VFs on subsequent
.open or .remove. This at least gives the system administrator (or
scripts) opportunity to teardown the VFs in a proper way.

>
>I'm open to suggestions, PF resets with live VFs is very much a gap
>that I'd like to close in the vfio-pci SR-IOV model.  Thanks,

Thanks,
Sami
>
>Alex
