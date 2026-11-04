Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832916;
	b=x/K+/DFtNHMTINU6E0ItuRdiZuuVAVuJ/EJSMO0xYCtFv4YQ1HClRmtpm1I03I4cLvC/
	 GtinD/gDd4Irzj9IgTAwQaiVqVkPya5GFCWS4lb650lUOMKMErUz/mhDH9IiSjDnEIChs
	 m3Q6bEF0FIlYvAK3mN8MzyfS/wngOZmQJFvUEMVpSJHtHRBEbcZ2qXgrSdxIxE5rdp5j5
	 RrU47gbDGh2HsxaCmb3F52LfeLQUDu2pJsW8TP4WIbOXtc3hq9WN48tIjxCNR86GCxHqj
	 TcGdU/j4/AE1PNGq/DHULZbWblaOVSFrJeNB3ZHJylPUFNhn0Jix2cNlfcNun0txw+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/zbs/VJDYV0GvGSr2Zgo/ryZBI/tPePChlLCcPRtDrw=;
	b=R+fxX3/auTIWfVMF1YI6Ahop6oK/iht+Nja+K7TPqquRGOSh7vsl0gS9sVSZ7a75c9sY
	 Yo8VykyeNtEqHSlKHZ718REbfRKqqSyWtpIY4fm8vVMSjHdIFVA66IdmMY6Ddo5BG1ISl
	 WSfoXJvOrWTuf1b90lYaa4qn4fyj25wGpCy3fAFTs65pU9EiVZSiYyr+zzotuuvRc+iKy
	 uWAZSjfhZo97qndNCFjbKCni0y2yi9SLn/KAomQfZeHvL2pZSm/sUQDiT/4ml99e4rHRD
	 0kQFBa2lt//CfyzgRNI0KhParJIk63+8dcdk0Ce/r+4y3Boy3CXWnIVcOPVCRkjLoVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iX8ZqbG5;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22234606A32E
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 22:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22234606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iX8ZqbG5
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ea7f9c11e6so21205ad.0
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 14:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793832915; x=1794437715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/zbs/VJDYV0GvGSr2Zgo/ryZBI/tPePChlLCcPRtDrw=;
        b=iX8ZqbG5kGhk9C7VPkqjhx2OKZ5xbfR9h1Aef/l6k3JjEk7yu0t/FYe5ycxHHDWtQ0
         19wFv+lPRy1qGjlmTyU9yKNwh5CIs+A9xxTyv83krzQuMbIjXC4SjI9bZkZEQQLYjav7
         o8p8FC8HgUrU9sHGmblpdCUujQZ1DCxQEmwArqz5qYpThbmIErnb4BXQbe4ojBPuf6GI
         BQ1dQdM4HGHcxxDGx0eDNq0a80qflOL4oBs83Fg7eL55XCcCPExeCxPxKS4WGjOYke96
         XTkOCjNPK5gQ2pwUT4Rzu2ckbqOm/PMxytwGmeVeJVL0CWqD87AJemcrP//eGcQkeQC8
         F0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793832915; x=1794437715;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/zbs/VJDYV0GvGSr2Zgo/ryZBI/tPePChlLCcPRtDrw=;
        b=v5h+e25poJFC1TcLTT7V5jr8kcGvWHbIh5aUtR466TzjiwqM7UnEd1jN7nKU22/jtC
         0yfFy0UkDC2IGIvNSD/YXaIy25fpjVPwTFBOiEaF0V4Cim0wSTWNr21ABOtxLwR02zO9
         FAXQJQ5OtKv7vJ6d/RpNR/BUTRqzJNkJenmUikb2ybp++EztxNS1nxbh/s/tPBKCLgsn
         USAbJVTiTWYuf1oScUoUJTHZD3ImQhcnTn94y3D3unaUGTErTbzDeUT3q+797tp1ydtm
         AedaVaQK5noaomMEMsobR1A0nobtx6UC6XQCubW6aQEPpBQPZdGgOrT0WxtKNPyInf4z
         LXVA==
X-Forwarded-Encrypted: i=1; AKwUvBxK/QCZslbQp2buEBfVsMrlD7aDKrAzFlXjiMhVY9chByeqaEWpJ4N5lVLDoaeZ8oCP1XM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8nPI4uCRD5fUBpii4XG6YqoHRhgYjZuI2MppnykiS9pWTojoMt
	ZsefCy3LFupyGyYd2mEH5oVPa8IpZSXiK2KzgKtmi9lfLmO/87DluxpI2NwO20Ih8g==
X-Gm-Gg: AYBFou2/wjSwkUsLg2WKVhB+9vbb1DjQiJUrW0Cobalbqbs9mooTUBRBxS8bum7MvzT
	etOnW/gocX2tbhgTarcn2YwTIpxD1X3kbhhrHmwVCEdql4uTYyNXbIr293ShpSHS/rv7g2eLgXF
	KeE/s1IH5S3FSYZn37PFGO4ZpuqoOI2jZ7RN4+8TffRctYY/jzJOVnFMNmz8+Gj4FqSgrzXVYQm
	dF2k2kIsqaofY7Fu4S6vTQsIEd+01eQoi9nXZj2sHn55V+GqYkU2pRt9zk9H6D5lUMs4HUI41A/
	KiR2JvNiJ6F6Pe6ngyxm86+6jjQls2OOKW9n7HLNFzW1k4NqXSrb/PJ9OSizyYR4BOOxE3QnnqV
	+Ig+Jft/O7vuVnmAjRmCgwwj8nhrjABLYxT4ParJedvCcKAke0xJBgMpSxoi+bczKxZHBW9hfue
	0fmdIX1rMC7kkzFvCZu6sNw21qcINXmsjneMqKd3tVeVdeL4W6QVg4Foc5ZByEvlaYtsVDFO73B
	BCoXA9iZxzEiulOiHyjIzoFmW6WX4f7dnkAoVhtCOqDmE88WhdhZZ75FHyxwZBR52yo8Mm3QAWX
	tmfrSUYfXDmwy1e51KitpWB2sHRCiHwqqrNRctyzcGErv9pcyRdapn4VP6LZ5n+xAA==
X-Received: by 2002:a17:902:db11:b0:2dd:3a08:d47b with SMTP id d9443c01a7336-2ed27e06d7bmr1039485ad.13.1793832914948;
        Wed, 04 Nov 2026 14:55:14 -0800 (PST)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09455fbdasm2528714a91.0.2026.11.04.14.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:55:14 -0800 (PST)
Date: Wed, 4 Nov 2026 14:55:07 -0800
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, 
	apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, 
	corbet@lwn.net, graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, 
	jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rdunlap@infradead.org, rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, schnelle@linux.ibm.com, skhan@linuxfoundation.org, 
	skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Subject: Re: [PATCH v6 05/27] PCI: liveupdate: Add helpers to preserve struct
 pci_saved_state
Message-ID: <20261104222438.GB511751.vipinsh@google.com>
References: <20261102153656.1431701-6-vipinsh@google.com>
 <20261102230624.GA1038787@bhelgaas>
 <aukvTvnfyAvahb51@google.com>
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
In-Reply-To: <aukvTvnfyAvahb51@google.com>

On Tue, Nov 03, 2026 at 12:48:14AM +0000, David Matlack wrote:
> On 2026-11-02 05:06 PM, Bjorn Helgaas wrote:
> > On Mon, Nov 02, 2026 at 07:36:34AM -0800, Vipin Sharma wrote:
> > > struct pci_saved_state is private to the PCI core and its in-memory
> > > layout is not a stable ABI. Add helpers to serialize it into a
> > > caller-provided buffer and rebuild it in the next kernel with a stable
> > > struct pci_saved_state_ser ABI. Using caller-provided buffers allows
> > > drivers to embed the serialized saved state directly in their own
> > > KHO-preserved data with a single allocation and lifetime.
> >
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> We discussed this patch off-list this morning. I'll sharing the context
> here since you were not there Bjorn.
> 
> The ABI added by this patch is not actually stable across kernel
> versions.
> 
> struct pci_saved_state_ser is stable, but the contents of each
> capability entry are not:
> 
> > > +struct pci_cap_saved_data_ser {
> > > +	u16 cap_nr;
> > > +	u16 extended;
> > > +	u32 size;
> > > +	u8 data[];
> > > +} __packed;
> 
> @data is a memcpy() of the per-capability save buffer, and the layout
> of that buffer is not defined by the device or the spec. It is whatever
> registers that capability's pci_save_*_state() function happens to
> read, in whatever order it reads them. 
> 
> None of that is described in include/linux/kho/abi/pci.h, so this patch
> implicitly turns the private layout of every capability save buffer in
> drivers/pci/ into Live Update ABI. Someone changing
> pci_save_pcie_state() or pci_save_aer_state() has no way of knowing they
> just broke Live Update compatibility.
> 
> And these layouts do change. Commit 898585172fa7 ("PCI: save and restore
> PCIe 2.0 registers") grew the PCIe buffer from 4 to 7 registers, and the
> AER, LTR, L1SS, PTM, TPH and DPC buffers were all added over time.
> 
> This is the problem I was trying to solve with:
> 
>   https://lore.kernel.org/linux-pci/20260924173501.856380-1-dmatlack@google.com/
> 
> That series replaces the per-capability buffers with a single store
> indexed by config space offset.
> 
> Where a saved value goes is then determined by the device's config
> space, not by the kernel that saved it, so the PCI core can change which
> registers it saves without changing what the data means. Serializing
> that for Live Update should be trivial (a size/flags header plus the
> bitmap and the values). The cross-kernel compatibility question also
> becomes explicit and per-register ("the previous kernel saved offset X
> and this kernel doesn't restore it") instead of a size mismatch on an
> opaque blob.
> 
> Bjorn, this is also related to your last comment:
> 
> > I think it would be helpful if the names of "config_space[]" and
> > "caps[]" hinted at the connection between them (both are in config
> > space).
> 
> With the offset-indexed layout the two are no longer separate. The
> header and the capability registers are all just DWORDs in the same
> config space map in struct pci_saved_state.
> 
> So I'd suggest that we land the saved state series first and then rebase
> this patch on top of it.
> 
> I can send a v2 of that series this week that addresses Josh's feedback,
> rebases on top of the PCI Live Update v10 series, and includes the
> serialization helpers. We can use that as the basis for the next version
> of this series.
> 

Agree with David here. I think David's series will make things more
explicit in saving PCI state and easier to find changes. I will review
your series provide my feedback but don't stop your v2 on it.

Thanks,
Vipin
