Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B68E42E8CF
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567322; cv=none; b=imdgQQZGgco0qJbIzF6r/coyZkqzaZURf1LbGs+plYddI+dp8OOhz4jwPSij57zvwTjE9LPp1dVTJTNVrP/IzZUamON9P2siZN6RXaWr0tWK0PqZsp93Ihvu1PvFmyNGoNjOg4jcqLnVxloBAM/uYMh0Q+SlfNLY+wJ4V8XrLto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567322; c=relaxed/simple;
	bh=U9MnGi+teUz7QJ5nQYDOvghfRANHOcAD8m+6/fWVDPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meDtzvAyVLN5La8yiePHF27+B9QDUadScE1mAyhdP8hoejIi3e1nem/Y0LMbx28y3C1vaIoieVKWjpk02ZiRSSe//UY0sawX3XXTkeEPMmf5tFehZJCWHmcJThZ410oBOEawsJBpcXRXG6QFLwbf4jztPV3WISz/f5AmHHMmZds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vhfazm1w; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhfazm1w"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cab97c86bdso411785ad.1
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 10:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784567320; x=1785172120; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aiMphJN0hEb752W3IjRxFzmLe0gtZmSXKy+eltAZsyI=;
        b=vhfazm1w8riXPetHdeW9F+f/ifuz/Op9m9lpNmWVVzbS7+k9JnIHZORTp19cCpP4gO
         LBMVS8j4qFInNdxb9jW0xpG3rGFj4QQppPyJ2iK26HffPgFewSNe9Cp+bPw7CNnL2RY6
         /y8r//deduXpw1/1PD5Dvoq88CO+jnbuMTzptx6mvYlmLwc1gSgpj57wqT0fVtMuflQv
         FdW7oqIyxmJSR3WMP/wtLq4O1tyb4XD+7uj/PGatN78p9t6xRWbq/ECmXGiFNPBUkySJ
         zVkNJqzAPl7IOuTHQLvDlKSsst7vCjrliAb8XErTXBbaSk04FHpb6Zb2kFIqzCpwL9Ec
         WA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784567320; x=1785172120;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aiMphJN0hEb752W3IjRxFzmLe0gtZmSXKy+eltAZsyI=;
        b=KdoTN/PxTIBaRAbLAIzOG/hhuMouLJmKPsepdFHkSl2ddYE9HSRE5kr4fG3RROmx+L
         FRvE3VOn+FBuzq6YWXG9zJMm58O1qYw3C2bffIiIzdob3x4jAy3BN+7SKGQMnNq1mpWV
         RbaZaMsaBvE+nrxZ/gFAKaE24rBw/17WQpTuSSKXPbPRS2h72Oj7EieJf+6aaQNWSoso
         hQij23DUyEj8eEfMaWibu5UzDLX9/Lj6hjt1cQq7eZYRm7lz2BohLsd6rMms9bcCKU7V
         h3sabsLFSddMOoY34Q2r4r2OnoU+MXUOgxSvQUA9mGBYw351c8JnVqgNYPWK8lXCSdNG
         eT8Q==
X-Forwarded-Encrypted: i=1; AHgh+RrYHka729Gvl5BTyIPfFeQKdagdzJcndIbGpmZ6Kuf/u3OXGZF5awwYTx0umIRnZvN4eXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU5OkzMQTxLtFdAR2xXcDLt9ctc3v6fPpq8TldjvoEOjZu3KuG
	JOK0/7AnwE41Ub55IQPlN3YV7el07dDOWgmBluO+N+QLB94RNdy/jijnCVjiHyDwUQ==
X-Gm-Gg: AR+sD10HR1iLduFM2Wdh6TBitVrasrdA1aOUcW+OgD8xsfMnfa2Svs3IlJUNAVNdsYh
	13QBUTD2pHV2ZqA3iyrVPM8sLAkqr9JCTa7BNwSG0Rvr8QIKwp0Qyhzzc+UcBr/PbRWB8pna36v
	8JCFkEQjdi2k13TAsDwdAd5Gg5dPtOmA2QuKhvY47GZlgft5uTbQZ0v306O0Cjml1gs10/povg4
	ZzWsfyjrvB9pAlDtImkXmO39k8PhTvIf9dEgK9qvsSHUWP4WN/ylPetADA0b4pYTXaoURSeQMyy
	OfjcB07rhTpvOWyXctwmLZvA9iWphePntMRVb7vIrKVFphbSOfE93EtExrWPGXUzcZlbC6cnez6
	UBjYoti3CzVb42fV6n9nLFHaqYSmwFsoK7ai1+F3smnNDkrzAbBlgojKM03j0ZyOuYy+diMKy6l
	/O3SjRmC/I5P8qy3M42rPPk3f8PBXB25Pr+iCW
X-Received: by 2002:a17:903:4084:b0:2cf:4353:f117 with SMTP id d9443c01a7336-2cf7b35e690mr923005ad.0.1784567319236;
        Mon, 20 Jul 2026 10:08:39 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e92091875sm91751a91.7.2026.07.20.10.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:08:38 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:08:33 -0700
From: Vipin Sharma <vipinsh@google.com>
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, graf@amazon.com, 
	jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, 
	julianr@linux.ibm.com, kees@kernel.org, kevin.tian@intel.com, leon@kernel.org, 
	leonro@nvidia.com, lukas@wunner.de, mattev@meta.com, michal.winiarski@intel.com, 
	parav@nvidia.com, pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, schnelle@linux.ibm.com, skhan@linuxfoundation.org, 
	skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, yi.l.liu@intel.com
Subject: Re: [PATCH v5 00/20] vfio/pci: Base Live Update support for VFIO
Message-ID: <20260720163452.GC1191959.vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <2c03ac97-60a6-4352-a942-27dcebae8d22@linux.dev>
 <8fd94fad-e457-4839-9e41-ae257a138bee@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fd94fad-e457-4839-9e41-ae257a138bee@linux.dev>

On Thu, Jul 16, 2026 at 06:22:07PM -0700, Yanjun.Zhu wrote:
> 
> On 7/16/26 4:24 PM, Yanjun.Zhu wrote:
> > 
> > 
> > On 7/14/26 8:14 AM, Vipin Sharma wrote:
> > > Testing
> > > -------
> > > 
> > > Tested using VFIO Live Update selftests in both QEMU and bare-metal
> > > environment (Intel DSA PCIe device).
> > 
> > I want to make tests VFIO Live Update selftests in QEMU. But how to
> > select a PCIe device?
> > 
> > what device do the PCI ID 0000:00:04.0 and 0000:6a:01.0 mean in the
> > following testcase?

Sorry, this was my copy-paste mistake when combining things from both
qemu and baremetal. You only need one device not two separate ones.

For testing using QEMU, you can use QEMU PCI test device.

  -device pci-testdev

In VM, use `lspci` command to find the BDF of the PCI device. It will show
output like:

  00:04.0 Unclassified device [00ff]: Red Hat, Inc. QEMU PCI Test Device

Then prefix the domain (generally, 0000) to the BDF and use the testing
commands.

`0000:6a:01.0` was the BDF of the Intel DSA device on my host. I
incorrectly mixed two devices during my copy-paste.

Limitation of qemu pci-testdev is that it does not have the DMA
capability. I used physical host with Intel DSA to verify that the
device performing DMA during live update gets reset.

> > 
> In my qemu,
> 
> 00:04.0 System peripheral: InnoTek Systemberatung GmbH VirtualBox Guest
> Service
>     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Interrupt: pin A routed to IRQ 20
>     Region 0: I/O ports at d040 [size=32]
>     Region 1: Memory at f0400000 (32-bit, non-prefetchable) [size=4M]
>     Region 2: Memory at f0800000 (32-bit, prefetchable) [size=16K]
>     Kernel driver in use: vboxguest
>     Kernel modules: vboxguest
> 
> I am wondering if the above pci device can work well with this patch set or
> not.

I think you should be able to test Live Update with any PCI device which
can be attached vfio-pci driver. 

`vfio_pci_liveupdate_kexec_test` will initiate DMA if the VFIO selftest
framework has the driver for the passed device (Intel DSA) otherwise it
will just skip over the DMA flow and do the remaining things.

Let me know if you still face some issue in running Live Update, I will
be happy to provide more details.

Thanks
Vipin
