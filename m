Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817477;
	b=hD+Z7bRfWeuleWB7Orw91bbJjEYG22kcx4EhVx4Zg7rP37ZKYEsl65+C3FnDj7ZINKW2
	 kBEK7cOTqGpE2Hx4XtpdswJkmJBowzN1G4FN7SlaPBi9fBv6BNXnhZH/Alzg7UycWjAfj
	 WCE4BZ9CVN3hdygDZ9tfgaPc+q7hI5j4qsJNRDrOyT16lDXuwr/J+UuxvA5EimEH/GesZ
	 VS8yI63hr2YgVI8kuRi9rcO6Fo1H4s4reKegueak5Ed7NXVJAAJg8xe2bcPt7TmE/iZND
	 FdOgKnTHGBEcvuFcXB0sun0tfWlHajuBPbTxsqqMEuBgqVKNsyr76Fhs1x0VsTfOLAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zP0FWmOJm/guqpM9jttc05RQpe78thW+WHjsEUvp+/0=;
	b=2bBR7wSyat91WGBDBRFK2mdkutDoCXyDPiVWj3/8h2SAaA6+gAnhz2qXP3V2TNE7hsfU
	 w57CLVVLG4SYSJxFfSgqKpEsWngkDB8irImPWhUJEPZfRS/OcaMIkMvBx1Z15wTxvq/BU
	 E811fgpG5AzV2owsXT5GBKestdsoQN0lNkch3gxjbHtwXooNw3WrVyT0Oz6SIlG8uJuKj
	 Qemkb7HppxdvZzw8QEXpdtu//7mTvtUTDNiiGJ8fCdhj5tWFAWiYs9JxhzYlEMZ1spoE2
	 hrXrr8izTHKw54na+RAV2ptSacCHYjKQhG2nYxMuaxwr/GNbGxprIARSyW5uwg0jyaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SJTFhGMv;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A886606A335
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 18:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A886606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SJTFhGMv
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so6518595e9.1
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 10:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817476; x=1794422276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zP0FWmOJm/guqpM9jttc05RQpe78thW+WHjsEUvp+/0=;
        b=SJTFhGMv7ixpbqd5/AooMmFq1Tqx0QwAQ5sx5WSk+kmzdAv++WxlnenqWZqmC6LIBf
         XlYJ6R5d1DPl+iHWve1QooVnwOP6TqiNx38vdvZ9fHhLfgA19nR5AuxMwWVIyGmV464T
         6VMZ4/9uszyEqMJJERE5qk4Kkhwi9a3QCvZHAJxwReCYsCBXmDKLvsqyTeMSUDpsBjyo
         cM3QrxMXHAHWZdU5rPIOqnO46kIy7lG+KPS426bMJsVVCJK5p29d7pkWo+wiVQ9WmJIk
         3SMU2CW0v5vUak9yMArXb8dOlqT7qNWmLgcFEz3DF+UWWP2fwAkCI1XHfjfKHeZ7fbMo
         HcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817476; x=1794422276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zP0FWmOJm/guqpM9jttc05RQpe78thW+WHjsEUvp+/0=;
        b=ECbWUFPfmgOnl20grMACNMWeuga8k50HODcD8QR/5BVJ/r78pBihnHj0JP7PNT4VcW
         dT38xj474OkIBXowTtxvkncz67DDOJeI0nA2bONMntlrpRgaqmD/z2GIgbqGGKYSGUnN
         sJ4D8nN8zsdDVeah//8cZ/w1ArXbIBFarB/rHvgN0nCeM7g0pcsv0n8IwzCzqjX3Ej2+
         UN8/Q8bYWSmittREsS+7GtELo+oRG/FfSQ7RCh+G+5kRFtZaioEl8KNZIsySf9nOh7v4
         OJtJHEn8EMQk4ZsA7s0kJaAW2jAYNYroM2QwlsC2jVXzxUqfFzHE96M66fPY+65WoYE9
         KKlw==
X-Forwarded-Encrypted: i=1; AKwUvBxkquk52A1hGBioXlfmvNHTo565ijfHNW9nVkOnZ2D+YyOGm1lIDSgWWzSjjbb/ur1FezQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dnVXqLgvh3vQHY9FAbWg5iIHsMEggSnk/9d410Gst9mmcMO2H
	31QqAjJ3ye7NEEI0COxcUn8Z0VpKohoRErYhCdFkU94eJq1K9jAG0LTq
X-Gm-Gg: AYBFou1FQx6dh4EDd/3+BhA3jHmQnL1LPHI1DsZ9/71YUdXOdVgwpYinpgf95oe/R0N
	uYsUk5nruzRWXlNexgr4E6iarZex5GSSt9+WKV3VTafm8PnYGxgnXgn5gRo7YzUi+z0okBvwvCK
	z+ifw0T5uy71HfdNyXn49OJGg/8Qe3Mi0sEIWX7UhmDP91zaJ/3XAS2xEwrEh7/oL6fwgyKErxd
	BFoRg778s+Ny7FddHU2Oc6Cep9VOHb4PNG1uhNLRecGHXrBzkZ/yXEx84TouodtHDwso0xHjmwi
	lFPqaXHWdtsGC1XufweTGGA03g2Ji2fwy0mqce2tywl9bvampxEm8RIN3pRr99ABqnXE0qmx26M
	H9LEtYaC2agf8znXfXKvu3hxxb5xr+fNGzFZr2/BlIHsZWki5Gxmrc/moGu6vQp22CFXEGXUHLZ
	uPQnAzE29d8J059Ie3CACLlSd9q1C6uBUTF6pAOemJ96BgAt71QhGAiyWb2thhGPiIovLcGZrGw
	wGONY2lSriugQC57PbtpMJA1D/8QI4npEpaENKkQRVNEGueXwj0moKBpF9PyFlwyPXCjc6CL3N0
	CLPw8gTACF/Uwd2vfYWIcCsUaceZvS6sf+/gVB9Sb/MbBN4hRHrTh2UqhPN+1RdwPwelCwacL7+
	nuRpTZQsVQkI8QQvE9fLtIt78V70Jo5QU7w67nyrkTbtcFCurnSqS7uOS/dA0dD8vVw==
X-Received: by 2002:a05:600c:8b85:b0:4a1:cd83:b23e with SMTP id 5b1f17b1804b1-4ac122897a8mr438143715e9.0.1793817475572;
        Wed, 04 Nov 2026 10:37:55 -0800 (PST)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56fca22e1sm4198665e9.14.2026.11.04.10.37.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2026 10:37:54 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev
Cc: Ackerley Tng <ackerleytng@google.com>,
	Alex Williamson <alex@shazbot.org>,
	David Woodhouse <dwmw2@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Christopherson <seanjc@google.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [RFC PATCH v4 06/25] KVM: guest_memfd: Support device-backed PFN providers
Date: Wed,  4 Nov 2026 18:37:54 +0000
Message-ID: <20261104183754.10457-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104150322.3516320-7-aneesh.kumar@kernel.org>
References: <20261104150322.3516320-1-aneesh.kumar@kernel.org> <20261104150322.3516320-7-aneesh.kumar@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> Device resources such as PCI BARs supply PFNs directly and cannot use
> the folio allocation path. Store the mapping owner and device ID in the
> core context during attach(), and use them when preparing device
> memslots. Keep device memory separate from ordinary PFN-backed RAM.

The device rules you wrote down in api.rst and locking.rst helped a
lot. If I read v4 right, the device backing differs from the RAM PFN
backing in these places:

  1. PFN mode calls RAM arch hooks: kvm_arch_gmem_make_shared() at
     conversion, kvm_arch_gmem_make_private() at fault, and
     kvm_arch_gmem_reclaim() on revoke and release. The device path
     has to skip them.
  2. lookup_pfn_range() only feeds those hooks, so the device path
     does not need it.
  3. The host mmap and stage-2 need a device memory type.
  4. In PFN mode, a conversion to private only updates the attributes,
     and the guest fault maps the page later. CCA has to map device
     memory at conversion, because the guest validates the mapping
     before it touches it.
  5. The device provider needs lock()/unlock(), the private range
     summary and prepare_memory_region().
  6. The provider gets the VM and the vDEVICE binding at attach.

Would these changes to PFN mode be enough to drop the device table?

  1. The arch hooks take the frame attributes. For RAM the arch does
     the RMP work. For MMIO it skips it, or does the RMM work instead.
  2. lookup_pfn_range() stays required. For vfio-pci it is the BAR
     start plus the offset.
  3. get_pfn() and lookup_pfn_range() report a memory type (MMIO) in
     their attributes, next to read only. The core mmap and the KVM
     fault path use it.
  4. A conversion calls an arch hook in both directions, and the hook
     can fail. CCA maps the private device range there.
  5. lock()/unlock(), the private range summary and
     prepare_memory_region() become optional ops for any PFN provider.
     A provider that moves RAM between guests needs them too: it has
     to order its moves with conversions and leave private pages
     alone.

I'm less sure about 6. Could KVM ask the provider for the vDEVICE when
the memslot is created, passing the VM? The provider would then not
need to keep a VM pointer.

Is there something in the device path that this would not cover?

Thanks,
Fred
