Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795566137;
	b=pwoQdJi3X2P5T3u2O3UY+ccIt6DvlHaF0Krm/ysHQaDqN8z4dV5Dyrd/PAmLwi2DnSB1
	 xhIaVOWHpnwmi65BH4s55DxLRG2kxkNMuc+vI6jG842eIY0on+2AiG151ONr1mGI3cwl0
	 r6ZsNk4zmLUn3LDmYJnvKKBgsGFsF48wV67g9axdvzn/oFRitLXQ180uiFxu/HzcwuopP
	 1Thf8kmegcaJzYEfmOvjw8jeCaedx3jH4SGt/VF5e0Q4JkWUUkwyUqITflLeJ908iMs6G
	 K+nPO4+cKV0vOzksUBdtGXMl+XlIUl+sLr5d2Vb0Ns4huFmWLNirSjSQTSCExRUvfNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795566137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=TYzGQKZhwagkTAG/Juiri3uWHZu9q9sF8vYxgRrqGqI=;
	b=z8JGtYwg5WrbKiUBxPUxbBKkJXKu484x/vVLMiKl60/19r5usicE+W5idblu2OUqqS4J
	 7VgPa3fAqYwCZCdN8R5YAbnPEeBkonTOrFq+4eTgsAl1jNO6HFA7Y6WdrtFHDMkZWMt+I
	 4Z1m5djQFFYxUT1d+68Xc1S8njAEH6z4NKCTA9IoI4y8WgufNrtFB34H1JUWavLGSlE+k
	 +J9WYKc6Eb1Fmx9IuUauiWSOCMH8IDkSdQ/69qNkucAqFGbcFazkxld3r+3thcgVJ7J42
	 8OJBY41RFXoHgQ/a+UYsppyfK2f+LYSKPS+4zaXhmOcheVCh4IApuQpYCZh9Fsi6tog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LfPgAdNb;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A70606A321
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 00:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4A70606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LfPgAdNb
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2efc4a84e75so224285ad.1
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 16:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795566136; x=1796170936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TYzGQKZhwagkTAG/Juiri3uWHZu9q9sF8vYxgRrqGqI=;
        b=LfPgAdNbCEDzCVpOnulQo/JfASfRYYqM8kEugcugzPGJ+NPbODW3+ygXTW0bNuIf5P
         A2XRNe2x7f+tAvPEGA1cRGorelRDVbaP+U+ddsFRCNj5z+W84jTSKFtz9kcBfGUWZC72
         SnFxGfVjCFp/z1Aa/+SHoZIDZO0uwSybMcQ66aXdRD4LdLcywEoOXgWcMH/V7mNH4s8f
         6XdzUaIXoGVjOKhep+XpCNQOQ9J3zvG41go0MsMLi2NqRkSlp7Tq/AZhdHJETH8nlrzc
         k/0QP7KipslWB7Abjqfz4P+Dp2kXVPk0ZUtHs8oX8GDEW08ku9UAuX/yOFeAIPM+FyQF
         2+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795566136; x=1796170936;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TYzGQKZhwagkTAG/Juiri3uWHZu9q9sF8vYxgRrqGqI=;
        b=dMc9xAev3HbhdU9gLU5+qdmlgxMuETV/MNeQFcVq0yDHgGhXl5M9YGANm1mlAZq+Au
         UyNRrDqK14nJ0ou2qgsfqAIOLhjWjhIuyKO4Tb4PrCBY/saZI3itOae2dvU8/x3z8QSy
         5mAd9OuGH5O6Yusrtvk5ZVrJRQh/83JVsON6MlDZ5G2w+ib1GhS2NYj9uXM58RIC4v3Q
         YwVb+lEhaX2G+JeKfqRorECG2c+Hid9rKwHsvq+hiRUEfxryz9MDh8BmbxRrmWD3PYHA
         d7wHVfPF0tAIEBntphBR9GY+cGJIFps5V2/1LozRNHPT3fq3jGeu/DvdRJXyMQ+G6eSt
         ubHA==
X-Forwarded-Encrypted: i=1; AL+hErFN6C3q8eVLATx354LPQpilvwNYKk5+aEShfVQkIkux0go/h3/aK+DS8MB3LwV1gs6owEo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OjwdyclpU2UX/C9tyw+J22uwjxVVvEG05isnC//ia80XnFESH
	R1ny9fQTexWGmHnTNL22qxlZiAXP2KSdgVL+K3sT7Y3XaCPzCrgnK2Z8FzfIiTiohA==
X-Gm-Gg: AZFdTZczcw5BAK8xMpCbeqzzJwArS1HhvHJozEk0Bz5eInGiSJJ1dyaJsByqVl4UQu6
	ukzHtHhYux0Nh9wECCNNyecqTR9CEhwimtuT+VfFBPhEhEzmAPO9vhzfDKSJusnTBDyCrYC855D
	qEfAqSmy1AuUcNiXBBcS0afDCEWMCmTFBq8zGDhVlcWNnFea4FlhWm67Xl1XQbWVYkFMqZ0PpRI
	7G5707++7mQG7pOwamWZ3sXIEnDpnv3wFwB5CJJICPn7VKy2A/ImCnN6wAixxP2qaUNXlenDhtL
	xPC/wKtmfv8HcVIW+WUQd8F2yJBTxoA7n7dwTA1UD3k1B6i7b8wRtgy+2vIhmTQlCcSNF576ZSH
	YXrsXaTM4KWpA2+QFNX+omJHa7QAwLBZl5xnCnLQ4hRicRUwvW+mZyJ4mP560RDmWVzNPiCQ18z
	tfUiBkSbO/uSVL3NV6WUwuQICaen6LkzLOYhSdWPZDeXDIoULyAGYIC8HkLP263B7UqXa8dC267
	Tka9phZoFSFdIlmdeFeos15hVnXbxY/+/YtDZ3PL3GC7fK9BuNULw/KzOA4mnJ8ji6XLD/Tol6C
	3OoTF2UKNQOLMj0RvBUjM0zpuhiyJ4kyuIggglI5rEXao2x7X7g3b8iOw86VbqXtA7w=
X-Received: by 2002:a17:902:ce0b:b0:2e9:73e0:2a6e with SMTP id d9443c01a7336-2f0666fb91bmr16319865ad.17.1795566135674;
        Tue, 24 Nov 2026 16:22:15 -0800 (PST)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f105b76sm76508585ad.50.2026.11.24.16.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 16:22:14 -0800 (PST)
Date: Tue, 24 Nov 2026 16:22:10 -0800
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
Subject: Re: [PATCH v6 07/27] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <20261124234830.GB3545683.vipinsh@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-8-vipinsh@google.com>
 <auzftbPFO_6XBYVw@google.com>
 <20261117220059.GA2250529.vipinsh@google.com>
 <DMZLLYOVIGOU.1RXWYJN6UQTM@google.com>
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
In-Reply-To: <DMZLLYOVIGOU.1RXWYJN6UQTM@google.com>

On Thu, Nov 19, 2026 at 04:06:38PM -0800, David Matlack wrote:
> On Tue Nov 17, 2026 at 10:44 PM PST, Vipin Sharma wrote:
> > How would a userspace opt-in? New kernel can change a capability visiblity
> > or virt and write permission of the bits inside a capability. Kernel
> > cannot know if userspace used the capability or not. Creating a VFIO
> > device in the new kernel by default results in a opt-in and currently
> > there is no way for userspace to opt-out unless we add a new
> > functionality where userspace can disable/enable features something
> > similar to KVM capabilities.
> >
> > For now, I think we don't need to worry about it. As this version will
> > be a base and if any serialized data with flags set received in this
> > kernel will lead to erroring out restore.
> 
> We don't need an opt-in mechanism in this series. Detecting mismatches
> is enough to make Live Update safe in both directions: if the next
> kernel would emulate the device in an incompatible way, retrieve should
> fail.
> 
> But an opt-in is needed to make rollback possible once vfio-pci starts
> changing its emulation. I imagine something like a VFIO_DEVICE_FEATURE
> that userspace can use to enable new emulation behavior right after
> opening the device, with the enabled bits recorded in a field appended
> to struct vfio_pci_core_device_ser behind a required flag. Devices that
> don't opt in keep the baseline emulation and stay compatible with older
> kernels. But that can come in a follow-on series.
> 
> > In the next version, I will not preserve pci_config_map. Hopefully,
> > anyone changing VFIO code doesn't forget to update flags if they change
> > capability or permission bits (I will write comments at appropriate
> > places.)
> >
> > If we want to be very careful, we can do two things in this series:
> >
> > 1. Create a per bit valid mask for the vconfig and compare this between
> >    new and old kernel during restore. In the new kernel, VFIO then takes
> >    each bit from the preserved copy only where the mask says it was
> >    valid, and keeps its own freshly initialized value elsewhere.
> > 2. Create a hash or store virt and writable bits in config space.
> >    Compare it with the new kernel.
> >
> > Both of the above combined will safeguard against forgotten flag update
> > in the code.
> >
> > We don't have to do it but it safeguards against mistakes. Let me know
> > what you prefer.
> 
> I think we should do both in this series, as two per-bit masks over
> config space, preserved in place of pci_config_map:
> 
>  - virt[]: the bits whose value vfio-pci keeps in vconfig and returns
>    instead of the device's value. This says which bits of the preserved
>    vconfig are valid.
> 
>  - write[]: the bits whose writes take effect. For bits in virt they
>    update vconfig, and for other bits they are forwarded to the device
>    (possibly after validation). Writes to other bits are ignored.
> 
> The masks should describe what vfio-pci actually does rather than copy
> perm->virt and perm->write.
> 
> vfio-pci can keep changing its implementation in ways that don't break
> Live Update, e.g. start intercepting writes to a register to sanity
> check them before forwarding them to the device.
> 
> Something like:
> 
>   struct vfio_pci_core_device_ser {
>           ...
>           u8 virt[PCI_CFG_SPACE_EXP_SIZE];
>           u8 write[PCI_CFG_SPACE_EXP_SIZE];
>           u8 vconfig[PCI_CFG_SPACE_EXP_SIZE];
>   } __packed;
> 
> 
> [ Note: I'd probably store virt[], write[], and vconfig[] on their
>   own folios to avoid multi-order folio allocations, but I am embedding
>   them here for simplicity. ]
> 
> The outgoing kernel computes virt[] and write[] through a helper in
> vfio_pci_config.c and saves vconfig[] during freeze().
> 
> The incoming kernel computes its own virt[] and write[] masks and
> requires both to match exactly with what's in vfio_pci_core_device_ser,
> otherwise it fails the retrieve. On take-over it uses the preserved
> value for bits in virt and its own freshly initialized value for the
> rest, like your option 1.

For now, we will be rejecting any changes and in future when we add
userspace opt-in mechanism then we can loosen this check, am I right?

> 
> I'd store the full masks rather than a hash, so that a mismatch can be
> pinpointed.

Yes.
