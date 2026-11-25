Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589733;
	b=DxekMwNle2r7mCTB1mER03qMas4MSCBoBqRL+UNvt3JtL1C4SmUoqnOt2GloX43DjfiF
	 L27uRe8T2Sedi2x/f6tzpedkSGoAxWtnvW/Eq7rGLtlL6H/L+HbArPaGqGbzgw7xJ0ELY
	 GbOyR3dY0C6EDowdYJNhGX/357Kcb/DtZroENQXFYfHSgSmCVYiXaAL2Vjz6xkF64gI+k
	 hViNh50jO33rxeH+Ca6aSwuoIOvYtryWuQ9ApWBEB9adEJ+1JEEk9a0BBvBn/HBGh2oR9
	 +GNRYLP2jdNBFXg3jPUjJ6DF7hkvFVJ5k8ej/r5CzNvsZzKJnnO5E+rW1Qf38oR1QNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=JPRUbVIzxn2NwG5vGsxVyrASfvomYL0+/SGbKSIacUs=;
	b=qbEqdUGOmxipwmLJ/pVqNi1PHg8UZL8Zs+ygBuld1+8e8LlYwBeLSIVRaFod17E9iV1h
	 7YMcWUeald8kCQoFdwLkBxQqJn67oxcnkcf49ryCwxgSdjJbOSr0ylgVhaxSj3K3JYzgM
	 V2g5EtQyiwJIXfW0rHl7nsVjMINBNEyo8OZRMkddrzZ985otmdsDWZbfPhC6TWfdySEuJ
	 XbYB6NShhOOH2Q5i0pdbOiQfwm/B0Yf5Eb88QK51gPViHefLSemGTmy0SS5BEykKfWq6H
	 P8JZbDRHyTAM7u5Q9+QpIuCg068oaQJpTrCVZBdm0DtUYJQdgrkgjAOwchjVnyE9CsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g2XD8HSm;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33346606A33D
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 06:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33346606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g2XD8HSm
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f0afdb97abso177265ad.1
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 22:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795589732; x=1796194532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JPRUbVIzxn2NwG5vGsxVyrASfvomYL0+/SGbKSIacUs=;
        b=g2XD8HSmkhaG8PVlHZI6mAvv8Wwg2jX1cb2UOcKTHjuP4GmPqMR6qJ8TFHBCivwinl
         osXQgXc7Wo3PkphAJ2CzCZRmXnhFmLtD0XfJnl6om1YxMEiHb5wtAF35FCGAOGUQYnDn
         XX+CFDXH1bSKUJsB9LxRsESs8BqmKbD7qsp9InR2aIOL2aip7HaOu4duJCQa/bq3D/QP
         oXm/VFFrfrwmOts62pobW8qbQdJfJrchjO6JXvlNyq929vlwupeHQsAhijFOTg5SnCdV
         uVOTDb/DaW9r9O9VWiEHyC7WvNorHbxn5Pb8FwpO5kPE6Oyvn1V6qHFBmKri1lkzsxzT
         j0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589732; x=1796194532;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JPRUbVIzxn2NwG5vGsxVyrASfvomYL0+/SGbKSIacUs=;
        b=Ngm049W/qbpBZv4pP2I5YlBFMiYIDRYCFV1Xt19S3QlmNeXZ4lsFg58e1nqICRh7mI
         T6DIKXSHPsMZH5F0Jjn6FLupt7iweqW1umcDt4kZSnM086YM6nYmAD2aO1GV7PRvZV2a
         XaDZduvrXaJCks29YXk59OyBoRM1xq+kTQbs9fjL/rmeka2iqSV1SEWCFkqtpICx7Mdd
         eKhLhnoo3I/WdWY3aAXFfvfcRkA5K6AMeb+akbG5Hw6KJX6jhzz5nLfUD6huK8qmdi/x
         LjqmQUNQrEWbtjEWhbLi0VSy1cnX1DMM7mMupA5q3omSJLp0A3AYYOFw2I4sFIAgEZQP
         +rOQ==
X-Forwarded-Encrypted: i=1; AL+hErH7BarDySmNW3APNETqb0+UIGbDSCjZedlnOrlBlqggm5oAuAfIwHWWmHD3rbZjVv2hagI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9t4EjfFrlttzvAUHWtuly7qWQ2WMN6y7QiTn+9ITCmLJEs+Hdc
	4zmwyiTjuTyZROiGOizDYI6Dxhw7B+Wa/dQHH3YlA3plK/Yez1ls4tPKPsbEkzXREQ==
X-Gm-Gg: AZFdTZeSjoXvpxOb4mye/mhY9DKKrUz/wX0lXQ2MsCXVo+i1uX5h2pJhk1QQhWaVELP
	kSUH0NEVp5w6J1eqALlLPbZLtr16IXSAXYVXkUERyXRc4UkWGuWaoANRysJuvwL8850fCmTTfWI
	aXJpQPNh9BSKVYPnsVuKSUalNTXvxrz/GcVKTcvk2JEHSmVA/CDC0rXlnUAioQ27oiREiujrePF
	Vcot9h3wsIWu2Sb4JhzgDijxuQ3BqE9nCEDCVEYM7I9E1/Xg9ZOjgSnkefuUuSthlQDlJvunfiT
	iDX1JUxVqnSzSlhtjAugRq6GENbBuJZfGaXTseB8fa7lSNGZhk4NKg9uFEmyPuAYCwf+HQeZjdN
	QDHsfL0x/OVzDLeeP21QKrLzbKO8P8eZee1GgL43BmLZpu6XuPaFS8sLNY57e/ihe9dFPljTnbE
	lbaaon8cc73bvD1ixAa/J2Wyk/mJDb7FypctEJAg4ZBr/HACjsAdAGwQRmzxpu9DCDwP/PjrWr2
	NLjMtvDQRmWJw/9bzSLiZPiQszAT2EQcX5/g7s0n0V17DJKAG/EzMrcWunJuRRjrdhCNZtN2emz
	lcOCmRK3SbDQxSulvWQemvmzG3OOcW6CRpT1XiBwJYH7pVQbRhw8GUENcEOeB3++CGM=
X-Received: by 2002:a17:903:298c:b0:2e6:1013:ad57 with SMTP id d9443c01a7336-2f0666c0739mr15428995ad.12.1795589731845;
        Tue, 24 Nov 2026 22:55:31 -0800 (PST)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfebdbasm8167972a12.13.2026.11.24.22.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:55:30 -0800 (PST)
Date: Tue, 24 Nov 2026 22:55:27 -0800
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, ajayachandra@nvidia.com, 
	alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, 
	bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, kevin.tian@intel.com, 
	leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, mattev@meta.com, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, praan@google.com, 
	pratyush@kernel.org, rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 11/27] vfio/pci: Retrieve preserved device files after
 Live Update
Message-ID: <20261125003759.GD3545683.vipinsh@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-12-vipinsh@google.com>
 <DMZMRTXS7OSC.M79XF39ZVEWE@google.com>
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
In-Reply-To: <DMZMRTXS7OSC.M79XF39ZVEWE@google.com>

On Thu, Nov 19, 2026 at 05:01:19PM -0800, David Matlack wrote:
> On Mon Nov 2, 2026 at 7:36 AM PST, Vipin Sharma wrote:
> > Enable userspace to retrieve preserved VFIO device files after a Live
> > Update by implementing the retrieve() and finish() file handler
> > callbacks.
> >
> > During retrieve():
> >  * Validate the handed-over struct vfio_pci_core_device_ser header,
> >    sizes, and flags.
> > [...]
> 
> Please make the commit messages in this series easier to read. They are
> mostly long bulleted lists of everything the code does, which is hard to
> follow and largely repeats the diff. A commit message should explain, in
> prose, what problem the patch solves and why it solves it this way, and
> only call out details that a reviewer can't easily get from the code.
> This applies to most of the patches in the series (e.g. PATCH 07 and
> PATCH 13 too).
> 

 I will do a better a job in the next version.

> > Do not implement can_finish(): closing a retrieved LUO session invokes
> > finish, and refusing can_finish() would leak the session and leave
> > unclaimed devices running. Instead, finish() always completes:
> >  * If the retrieved device was claimed by opening it via
> >    VFIO_DEVICE_BIND_IOMMUFD (which consumes vdev->liveupdate_incoming;
> >    subsequent patches replace the open-time reset with non-reset
> >    take-over, reject opening incoming devices other than via retrieve(),
> >    and protect incoming kept-running devices across runtime PM, dev_set
> >    resets, and non-noiommu boots), finish() simply completes its PCI
> >    Live Update participation.
> >  * If the device was not claimed (never retrieved, retrieve() failed, or
> >    retrieved but never bound via VFIO_DEVICE_BIND_IOMMUFD),
> >    vfio_pci_core_liveupdate_reset() logs one pci_warn() naming the
> >    device, clears PCI_COMMAND_MASTER, resets the function, and restores
> >    the inherited pci_saved_state just as closing the device would. If
> >    the device has a function reset but is not reset, e.g. because
> >    pci_dev_trylock() contends with a concurrent driver unbind, latch
> >    vdev->liveupdate_reset_pending so vfio_pci_core_unregister_device()
> >    completes the function reset and state restoration via
> >    vfio_pci_core_liveupdate_reset_locked() under the device lock held by
> >    device_release_driver(). Opening the device after finish() resets it
> >    like any open, so it drops the latch.
> >  * If the device was not retrieved, look it up under pci_dev_lock(),
> >    which waits for a vfio-pci probe in progress. If it is bound to
> >    vfio-pci, finish it as above. If it has no driver, clear bus
> >    mastering and reset it. Otherwise leave it to the bound driver.
> >  * Call pci_liveupdate_finish() and kho_restore_free() on every path.
> 
> This is a lot of complexity for one commit, and it's hard to review. I'd
> like to start with the simplest approach and build from there: implement
> can_finish() and have it return false until the device is fully
> retrieved, i.e. retrieved and taken over by VFIO_DEVICE_BIND_IOMMUFD.
> Then finish() only needs to free the incoming state and call
> pci_liveupdate_finish().

Closing session FD is not retriable. If it returns an error then
userspace won't be able to retry. So, only option will remain to reboot
the host.

VFIO doesn't need to impose this restriction. We discussed in LPC to not
block finish() as this call can only be tried one time in LU if
session is leaked.

> 
> That gets rid of vfio_pci_core_liveupdate_reset(),
> vfio_pci_core_liveupdate_reset_locked(),
> vfio_pci_liveupdate_finish_lookup() and its bridge and device locking,
> liveupdate_reset_pending, and most of the finish documentation. If you
> want to handle the other scenarios (devices that are never retrieved or
> never bound, devices bound to other drivers, unbind racing with finish),
> please add them in separate commits on top, each with its own
> justification.
> 
> As for closing the session leaking it and leaving unclaimed devices
> running: that only happens if userspace closes the session without
> taking over all of its devices, and leaving the device running with its
> memory still preserved is safe. Resetting the device in that case is
> something that can be added later.
> 
> It also has a nice side effect: LUO calls can_finish() on every file in
> a session before finishing any of them, so a memfd in the same session
> that the device DMAs into can't be finished before the device has been
> taken over.

If userspace has two session, memfd in one and vfio in another, we will
still have risk, where memfd is retrieved correctly and may be
closed/released due to a process crash but VFIO device still acessing memory
by continuing its DMA and potentially corrupting memory.

I am still inclined to let finish proceed without blocking via
can_finish(). I can try splitting patches.
> 
> > +static int
> > +vfio_pci_liveupdate_attach_incoming(struct vfio_pci_core_device *vdev,
> > +				    struct vfio_pci_liveupdate_incoming *in)
> > +{
> > +	guard(mutex)(&vdev->vdev.dev_set->lock);
> > +
> > +	if (vdev->liveupdate_incoming || vdev->liveupdate_claimed ||
> > +	    !pci_liveupdate_is_incoming(vdev->pdev))
> > +		return -EBUSY;
> > +
> > +	vdev->liveupdate_incoming = in;
> > +	return 0;
> > +}
> 
> The pci_liveupdate_is_incoming() check here is redundant with the one in
> vfio_pci_liveupdate_retrieve(). Nothing can clear it in between, since
> only finish() should do that (see below) and LUO holds the session mutex
> across both retrieve and finish.
> 
> The liveupdate_claimed check is redundant too: LUO only lets a token be
> retrieved successfully once, PATCH 12 prevents opening an incoming
> device any other way, and the liveupdate_incoming check already prevents
> attaching twice.

I will remove it.

> 
> > +	if (!pci_liveupdate_is_incoming(pdev) ||
> > +	    ser->cfg_size != pdev->cfg_size) {
> > +		ret = -EINVAL;
> > +		goto out_put_dev;
> > +	}
> 
> If the device isn't incoming here, that's a kernel bug. The previous
> kernel only preserves the file after pci_liveupdate_preserve()
> succeeds, the PCI core marks the device incoming when it's enumerated,
> and only VFIO's finish() should clear it. So this should be a
> WARN_ON_ONCE().

I will add a WARN_ON_ONCE().

> 
> > +	if (pci_liveupdate_is_incoming(pdev))
> > +		pci_liveupdate_finish(pdev);
> > +}
> 
> Likewise, the device must still be incoming here, so
> pci_liveupdate_finish() can be called unconditionally.
> 

Yes, I will remove it.

> > +static inline void
> > +vfio_pci_liveupdate_unregister_dev(struct vfio_pci_core_device *vdev)
> > +{
> > +	struct pci_dev *pdev = vdev->pdev;
> > +
> > +	scoped_guard(mutex, &vdev->vdev.dev_set->lock) {
> > +		/*
> > +		 * Complete a reset that finish() could not do, see
> > +		 * vfio_pci_liveupdate_finish_vdev().
> > +		 */
> > +		if (vdev->liveupdate_reset_pending) {
> > +			vfio_pci_core_liveupdate_reset_locked(vdev);
> > +			vdev->liveupdate_reset_pending = false;
> > +		}
> > +		vfio_pci_liveupdate_free_incoming(vdev);
> > +	}
> > +
> > +	if (pci_liveupdate_is_incoming(pdev))
> > +		pci_liveupdate_finish(pdev);
> > +}
> 
> VFIO should only call pci_liveupdate_finish() from its finish()
> callback (see the kernel-doc of pci_liveupdate_finish()).
> 
> If vfio-pci is unbound from an incoming device before finish(), it
> should just leave the device and its Live Update state alone. That's
> fine: if vfio-pci is bound to the device again, the device is still
> incoming and can still be retrieved. And once the device has been
> retrieved, LUO holds a reference to the device file until finish(), so
> vfio_unregister_group_dev() already blocks unbinding it like it does for
> any other open device file.
> 
> If userspace binds a different driver to the device instead, that's
> userspace's problem. The PCI core documentation already says it is the
> user's responsibility to ensure that incoming preserved devices are
> bound to the correct driver.
> 
> So I don't think the unbind path needs any Live Update handling at all.

I think this should be doable.

> 
> >  #ifdef CONFIG_VFIO_PCI_LIVEUPDATE
> >  	bool			liveupdate_frozen;
> >  	bool			liveupdate_intx_disabled;
> > +	bool			liveupdate_claimed;
> > +	bool			liveupdate_reset_pending;
> > +	struct vfio_pci_liveupdate_incoming *liveupdate_incoming;
> >  #endif
> 
> With the simpler finish(), I don't think liveupdate_claimed or
> liveupdate_reset_pending are needed.
> 
> PATCH 13 later inverts liveupdate_claimed into liveupdate_kept_running
> and uses it to block dev_set resets while a preserved device is still
> running. That can use pci_liveupdate_is_incoming() instead. It blocks
> resets until finish() rather than until take-over, but since finish()
> now requires take-over, userspace controls that window. If some flag is
> still needed later, please introduce it once with its final name and
> meaning instead of adding it here and inverting it in PATCH 13.
