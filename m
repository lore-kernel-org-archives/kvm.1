Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9D351476F
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 19:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548801; cv=none; b=g+wFuGS+Uks/h7ly5QAB1K4dsoFRWi466adm11Q/aI6UK+eBMF35sDU//3+jxum7tNv5ttrQNS4Vo52NhhW9iqe7RLBIJ3mwGEoPdln2+w6/USNZkg4SDngqKpTcxlKUvZYH+4JkFMA7db61Owu4uD6rrxoGDYqKZF9NmL9S1U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548801; c=relaxed/simple;
	bh=21Bh4RJxpeiCW82oSWerk5Qo5AfL15/5sh5ePR1ifY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gL2niR88sQ/JfSQcK7iFeVlFYmrKhabANFygbb7nQcBYMQPpXhp2ZbR1wYzXthdlFW5t1+9d9z2iNpVFm5mooxg3xLi//y4h7aQhI929zQukCVKQmzejHNWWf40cmrJU1zzXdTl/25RYuMu1gPDt0ZUlEXqwX6V0eIzYZTJlJ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lhJTEp8O; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lhJTEp8O"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-86b03b75fecso23903867b3.0
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 12:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1788548791; x=1789153591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P3rzU4rRnN7pu/GZMmTRQuFVrRv0l5idd5+55lRqVAM=;
        b=lhJTEp8OWu5xBG+1oqPa1Wva5YmqttSbpi9gjB6Pf8MEua9tTIaB5YMCSVH2Yw2Vpr
         fB80hpNR1Fqv53+jZRPrNd0Pp27PljdjbsoP6QqhGT4JtXlW9T4coSMlOfoGPqtlrP0p
         ACsXkueYHAhSCr9vDxyN7+OluD+d2KdyXo4Bs5pyIDjYLJN4ZC6uv0+A6HjrJ2lQ0X5z
         RGMoCAkC4+8CsXybGFDMLgr+3ttjaHP9eAYBYKR30Xmf8Uni61ityUlqq9Rb7J/Gru/h
         dkZEh6jFSY0oOdI+/N5f+jqbOMVaJGabrZ+3Idnx2FQZNFt64YZZXiWPOBpScN5X6FHN
         WKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788548791; x=1789153591;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P3rzU4rRnN7pu/GZMmTRQuFVrRv0l5idd5+55lRqVAM=;
        b=eFzs6ktuoCRe5yc7t2PXYWmg7P2BJYml6TNdXH19OxxWOKqSay6zUwDepasqK1DCC2
         Cj1OaDhfp1hgrI0syN9qIRM9IXE7TbNTjUzecda+aSddItkErUqbGiCkMDGJSatWCOUd
         PiPbTQzcle7VSGaQkq7jUHyigCFNgIVKZUohFggcc44rjEGREQpTV4S6C5rwgBXbY0lQ
         ppnTk2GyqPguTVtC9eeawAA05Q+O2iAY8252N7cnau13lZqYZJwVJqwWuQITw4eG8HQI
         T8/ocgXdzRi2WWKa/v1C4liU0P3OxdrCP4Bkpf6SScGbrnPlnI749FAz/qkWHT7vxQz0
         40TA==
X-Forwarded-Encrypted: i=1; AKwUvBxF0AOMaGK2eVfcihtvzotpj44LFjv2ZVrrqmCN0mQCT1+XcoIQ67J1NW7un4xmUfImpm4=@vger.kernel.org
X-Gm-Message-State: AFuF++mZGNrU0fQXBBF9eNSjZx8uSRe7CH69sxNPWHsRnPHF8U/qY8+O
	QvhehJkhRJ6ILGaZurFnkr+HRR6N9TPTH1zZGtqMOgWtxDTXjGbuwkJVdb0vaMxzBJ4=
X-Gm-Gg: AYBFou1Hzlvru3t7NhfBWytcyTmRIRnb/R1dJ3pIPphNSfUpj+OCXLTty479izBKQb2
	6iKwoHhXhPEDY4RqikB/3U+fBwIs3dY2OzkD0EIKao0fZtK9US4KUFj/s7wu13G8ckH11EIec7d
	6C5KPcYxFLktNP8wQjkHHDGDxWPTN9jdhFS7M1+GgW73WPvvREmeyUCnolPnysyxIvWTjXT1d6c
	e5+wpPvNmC0x5vvYAUPE6Sf0u5MCP2QKECIf4o4puBTWIclNVWAmxxdFvlBBUdkBb8x24kApkEz
	r6mWRBx4Qy0PSFvnpe0v3eKMOCUu48gTuJaOT61XGE5oiBBL6MkdGbT/bJy3KWfbbZUlBvqn8uI
	x5hJHKxynbVD8GHX07F9DX9kgLGSHThNFefMf8JVadjOaeNa3QGZpMlI9VCvrCztWrhRQZUiIdW
	jYvdG2BNMYEH4ixzkrV9O/eafcoyEzhTCDaHetvarVC9wTOQGqhqFZpzXBOTpQtLCHk2geqB+xT
	FpWj3UP5HYI/j2K5Qj5n8q1LIY0hoivK/na86jE+FBTE0CkotfEDymPJg==
X-Received: by 2002:a05:690e:2026:b0:66f:c284:4834 with SMTP id 956f58d0204a3-66fc2844e8amr819081d50.60.1788548787246;
        Fri, 04 Sep 2026 12:06:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406481b4sm27434626d6.17.2026.09.04.12.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:06:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x2ZF3-00000002uJq-3KUc;
	Fri, 04 Sep 2026 16:06:25 -0300
Date: Fri, 4 Sep 2026 16:06:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	Alex Williamson <alex.williamson@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Message-ID: <20260904190625.GA667892@ziepe.ca>
References: <20260812045325.2733631-2-alex.williamson@nvidia.com>
 <an5JbIzz40svS3xe@google.com>
 <20260814083737.66bb83fb@nvidia.com>
 <20260817121810.GC933791@ziepe.ca>
 <CO1PR11MB48354AC2854C4D8E9984FD8E8CA62@CO1PR11MB4835.namprd11.prod.outlook.com>
 <20260818140304.GC5482@ziepe.ca>
 <20260818143906.1f58aecb@nvidia.com>
 <aod22_H66eUth9av@google.com>
 <20260820233722.GA1110819@ziepe.ca>
 <aoeffe1v--CgRK0a@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoeffe1v--CgRK0a@google.com>

On Fri, Aug 21, 2026 at 02:20:55AM +0000, Samiullah Khawaja wrote:
> On Thu, Aug 20, 2026 at 08:37:22PM -0300, Jason Gunthorpe wrote:
> > On Thu, Aug 20, 2026 at 10:38:07PM +0000, Samiullah Khawaja wrote:
> > 
> > > > The blocking domain operation looks like it might be simplest to
> > > > implement in the IOMMU core.  We can set a flag for a default blocking
> > > > domain on the IOMMU group when we take_dma_ownership of the group.  Then
> > > > release_dma_ownership picks the blocking rather than default domain.
> > > >
> > > > This is then unwound in use_default_domain, called via dma_configure,
> > > > attaching the device to the default domain in probe of the next driver.
> > > > Therefore until probe by another driver, a device used by vfio would
> > > > remain in a blocking domain even while unused and unbound.
> > > 
> > > The devices are expected to be attached to the default_domain even when
> > > these are unbound and the use_default_domain assumes that, and it only
> > > checks the ownership and doesn't switch the domain to default_domain. I
> > > guess we should add a WARN in use_default_domain() if that is not true.
> > > I will probably send out a patch for that separately.
> > > 
> > > I think we can move the device back to default_domain after reset after
> > > unbind, maybe it can be done in pci_dma_cleanup() based on
> > > driver_managed_dma?
> > 
> > This blocking domain stuff sounds very similar to what Nicolin
> > implemented for the per-function ATS issue?
> 
> I see you are talking about this invalidation stuff:
> 
> https://lore.kernel.org/all/348c50ab6e95b5ec6d48ee3fa05d529a784a34c3.1765834788.git.nicolinc@nvidia.com/
> 
> But this was the case where the device is going to be reset and to
> prevent ATS issues, we attach it to blocking domain before doing the
> reset. But of course, with the PF reset here, it induces the same kind
> of ATS issues on the VFs.

Yes, we need to attach a blocking domain before we make the function
unable to respond to ATC invalidation. PF or VF reset both trigger
this condition.

> Hmm... doing that for SRIOV also, by allowing PF reset but attaching the
> VFs to blocking domains before the PF is reset, will only resolve the
> ATS issues. But the software state is still out of sync with hardware
> state.

Sure, it doesn't fix everything, but it is something you'd need to do
to avoid problems in the iommu driver side..

Jason
