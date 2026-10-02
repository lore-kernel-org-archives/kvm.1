Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DAF4FECE1
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961067; cv=none; b=kU9qiL8THk6lPCeqiHp7xoSSRGbIiOgN6nzRaI9XF6DzCL6q8EeL8m4aPXzQr8Ngq4w6xKvakASFSi+m2nM0PMAc56w9rLSUvV46pWI91+atUkE/taOAjDL8d3hk1m3//Pjm6PunS7jHzZCpcCHmfsw04pfZnMHBNLmtu3raS0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961067; c=relaxed/simple;
	bh=mrxPXIId1qTShZKGlHGgNQz6PnSRa6+MIliC3LYulx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm2BjJGpjtEEjN2JUm/aSLJ1q4ltX8S+nwmz4Mht1gWCXUaNeGQFvoiwKwChjuju55d1AoL6CcsmAPrBagLOmSUU0HYlWqB7OOox8c+PvlzMxqqM7XRhmfpzhXoJLx5t7a+UMRiERJh8xMOoOlZqOOy48trIWJTU7UMakgTy1O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jIsrR6ZC; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jIsrR6ZC"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34d2d25127aso1780227eec.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 10:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790961048; x=1791565848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BgakvInNsjTIuwI/HruggHJb8c52XKSKFB4qu//ilyk=;
        b=jIsrR6ZCYoXUg62SeoHiJ6U1qQmTUvfmHWogxM0qjQgpdxTBR38CREigK8nBVg837B
         KemCEloefIFs0d6V2TsfLG+gXof4Lczn1A3R8NHqVJVEIGVHb/IebK+RpIye8M3zMs8i
         YTJWrFKclhx7CxJS5QL7+5f//INbWiK4y09jMHkcmwqjDq7GovOeOKTKri8BnYz4SJ/F
         Wb6KjoEp6g56AjVLR/e/dFRyT7rfM39Ade1CK3Dx+VZ1t0EdbRskxub4VkpZ+yFH9FCS
         4N5joGr5LsAuBrkxXGtJbCwSMI+3e4PJkLhKF7HnXpwKcgm3GyDvhTJqShefFqKWZr60
         C7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790961048; x=1791565848;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BgakvInNsjTIuwI/HruggHJb8c52XKSKFB4qu//ilyk=;
        b=HjDC8AVTiS5ws77U82wiih321OX3MbnFwNvssidHElmeFp6ZbVYKdQt0DUgVkkQZmx
         /THAjFBc8rUQ3kHYV5jJCQd2VGMG9ruPwxDqfaAkJl65dbK/ksrMhGoJK6sCbCdxwBkU
         baeb/7pILImQatlgglvEAGKbT8XQjJg6aYAFbtXAXYV/w2Pg8IQFKeBSBifduGyP6e2p
         otfcSb9p4jc0QbM6zhn3UPE9SB3EIjXn67/t81GgH7qvJq53f6yZ9Y+CwyJyQf67lT4z
         U6F7ngraz5THUmsT0zrZ68jRy3vBFpDF2KPQGUEdEh94yZyCb3bS5OjsXk5uoRna35s0
         GTfg==
X-Forwarded-Encrypted: i=1; AKwUvBwRokHIKtS2flxRL6YVWKh20ezxl4D26pblmZuSVCLL9IM5QtfvTfFaVTypgjUqzXRToFs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJq+XVbs7c+K6xqpFS5O9a66Q/We7P5/cSwpu/dlT3YF/dKnHzX
	ii8+Nn0DxhqP4E6BQQRJF7O6lA2uzUJoJfp7rTdZC1al7IQ0Cty+QBHEAQsL89fSF3w=
X-Gm-Gg: AYBFou3YJLn4NBynvi/RteB2920KmgCc0lEF4YutlB9Xr0K5IMnKic8FcdGbOvc1tC+
	fbM+M3CR3B4NmQNwKNb8uPuL89wVJ4CE1Ad3lcad6vE/1J+vaS8UpkC0eVa2Zc8+AwEyjkygsHP
	8dAoAuMdVgO8h/eQkFaHqGO5STqoy+RmJ55WK2rlYacOjR6zc3aL8EoZ8WVOpUHHR51VVL1dcRT
	uDzrgyadvVhhAPHVNpOb+B5wRdfwYFExcCmOVTEBdupeiASsxw5tTuOmDjisknUN34+GTtaKAIy
	qwT0RPev9NDjlkc1TSWeIBKNFoILn3so7v3XlZ1Bm2p/FFUcCD4h2Si1GtKdJPIm7mC8gt+Fx5J
	kJS/xwHUPgNCq5ftUYtlpaSH8/84dHz2X0p01GUsYtl0XeDxo4QcsfLcHn7R/snbP/EK9e3Loxh
	dJ4vx7LXRLWt7vHuAQ6Vx7oXWwcPe/bo4xoqktn3oDNG9h
X-Received: by 2002:a05:7300:e5c2:b0:34b:b410:9352 with SMTP id 5a478bee46e88-34f14f18c8cmr3725477eec.1.1790961048034;
        Fri, 02 Oct 2026 10:10:48 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3510850f86bsm4509703eec.11.2026.10.02.10.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 10:10:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xCgmU-00000000BiY-09Yw;
	Fri, 02 Oct 2026 14:10:46 -0300
Date: Fri, 2 Oct 2026 14:10:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: alex@shazbot.org, ath11k@lists.infradead.org,
	ath12k@lists.infradead.org, bhelgaas@google.com,
	jjohnson@kernel.org, johannes@sipsolutions.net,
	kevin.tian@intel.com, kvm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
	mani@kernel.org, skolothumtho@nvidia.com, yishaih@nvidia.com
Subject: Re: [PATCH 3/7] vfio/pci: Add qcom-vfio-pci variant driver
Message-ID: <20261002171046.GA32083@ziepe.ca>
References: <20260930151229.GR163130@ziepe.ca>
 <20261001071945.83116-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001071945.83116-1-jtornosm@redhat.com>

On Thu, Oct 01, 2026 at 09:19:45AM +0200, Jose Ignacio Tornos Martinez wrote:

> Regarding platform_device_msi_init_and_alloc_irqs(), I agree that
> moving the driver to device MSI domains would be cleaner on the
> driver side. However, even with that change, I think the VM problem
> remains exactly the same: the device MSI domain in the VM would
> allocate virtual addr/data pairs, and the firmware's private interrupt
> controller still needs the physical host values.

Yes, I'm not saying it fixes the problem..

> Also, the VFIO variant driver scheme would not fully break if the
> driver moved to device MSI domains. The variant driver caches host
> MSI values from the MSI descriptor, regardless of the allocation
> method. The hook point may need adaptation, but the fundamental
> approach (host caches physical values, VM reads them) remains valid.

It breaks because VFIO will only cache *actual* MSI-X table entries,
it does not have visibility into anything that
platform_device_msi_init_and_alloc_irqs()

The only reason this works for you at all is because the driver
hackily copies the vectors from the real MSI-X table so it can look in
the "cache" to find their true physical versions.

Which is my general objection, I would like to see the driver to use
platform_device_msi_init_and_alloc_irqs() and don't want to get stuck
unable to do that because it would break this.

> Regarding the hypercall idea for device MSI domains, I think that
> would be an interesting direction worth exploring as a generic
> solution, but that's a multi-subsystem effort that will take time to
> design and land.

Yes, but it does actually solve the problem in all its forms..

> I completely agree that this could theoretically affect any device
> with private MSI registers. However, in practice, I'm only aware of
> this specific behavior in Qualcomm ath11k/ath12k firmware, where the
> device's interrupt controller requires the host physical MSI
> addresses to be programmed directly. 

Everyone else seems to know this stuff doesn't work for
virtualization and doesn't try to do something like that.

> It's also worth noting that the PCI reset support for these devices
> has already landed in linux-next (commit 290153d46d1a "PCI: Add
> device-specific reset for Qualcomm devices") [1], solving the
> device reset path for VFIO passthrough. This MSI series is the
> remaining piece, with both in place, these Qualcomm WiFi devices
> would be fully operational in VMs for the first time.

Why do people care so much about this? I always thought it was a bit
odd?

Jason
