Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB39472F82
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 10:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792148282; cv=none; b=e/7/BogWHua8qoRVA5Ztn/Gc5wI0295lu7DUVWkhqf8vhTiwQQZ1z3TUA+fjZdHfWu8PTHEgrb90jw93h8Vodcr8+zlu8Bwv3s4FS9iNiGXGFvbO3Jv8HxRdwC+7zyEn6C0NOjZJFQLoaV1lMZYHZDAYvR/biGyiMxZTArqSJss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792148282; c=relaxed/simple;
	bh=Fg04sF4wbeMFqUdM8zmoRfU3uiwkIyCVmr/Efwdeo90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xdad4vVRFyn7ZTKU1eF/KWhyQigLca7RZ1HOIZQI39XUojvweTFIPWqyf/jlTpwVF/slNmW5L2Un6xZcXV/iOGlYGg5y7eHE4EnKeQWADuhKN7RW/twZ5Fjgb/vlF+agxWJnGof5vfUIj5E1VU6DzOoUS+8p4MihBmY39qzJ8eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7TxFbZ/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7TxFbZ/"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49ff680331aso33351725e9.3
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 03:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792148275; x=1792753075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JjoY/Y//bNqM95eGJvwXGt/YGARtJeL2jF1lkb5NGWs=;
        b=D7TxFbZ/sReh3v9xlEhDQQupP3G0XuiqfnTAAzEzRg5We8Zmo4u+UYf+BrHQNxoJlB
         0itiCLX2dCbSxl8MMiHEWrRUDTQSK9eAJX+mb9vFx7xZD+WTklf/ZEjZ6And0PB+8Wbz
         mbOoRzZK74MQ4iuuToNhMEe5wBNv2mBmN2j94m/daLFCHNfkVUKD41DRUzSQaaOgecnI
         fYEeaLyca9GqL31hNJ4nvpiI+tGZeQWaIBvQJIucst45Dm7CqdRhPp4AZzcwhxIiVvOE
         9AuCNdwX0HduL80rvl+L2tMQQVG7uaewRcw7rXuvXB+O58LqJ1fEelXrmOC+7WBlnBLU
         8GgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792148275; x=1792753075;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JjoY/Y//bNqM95eGJvwXGt/YGARtJeL2jF1lkb5NGWs=;
        b=sx+uKbnHIMhIz82JpRLGD9DlDu2mIafy0m06vTjj1sihu7wn1JJ+u3dpK6HUIsUePE
         Jw6RF1vco0trQd32cD5YfLnp7WChvglHwNyL//lKcp484NLaeY+v25nChkQtJJYaNGTC
         UudRJ3grStmai+beOINRzIWmAWEDFFhoPWREtLyEHS0Ja/gFN+029fUn4gmnQqQG0pyD
         +l+w0XNYrbicjYIiPwQHyyqzQB3WwUg7d6o+Uz7e69ZAydZPHOrcEGNDv3Xoo2IvjVft
         C6fV9q3vl+uZeNfB4FWmaaludcx71Sy9qbtQxppaL0lTekBwaMhq5IJaqCRPmUzvnfby
         eadg==
X-Forwarded-Encrypted: i=1; AKwUvBwpy/FQlCg7QSRHI5bSp20SNY5rsCHyQrUUHsKXn6PMrpXxzy8dp1ZcVJS41vxCv35HfdI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3lKG2gKW+BiCs7zeIsHEbvgzwULq6QxlUXb8Tn83nNEEYQfus
	qV/amB9fCNUqGSzg3xuuKgCxiZtpgrnM4kA2LAWUKCPkD/DRRCFYRnW/
X-Gm-Gg: AYBFou1mBeb7leRwSZR3LX5Puk6jLessIps21hWi1bhss7DEsO8cuG3vd8OveU7qWdy
	WlKNSPJElGeVzyP7mkTMEjo1pACETLock4w0TwW4KlKyBQJdcVqorsxa4ie0FPpkuLC98S188g0
	48KllpVOplbqQDpIIP8WHZyl2eh5lg7vav7ad4uLZEtlJxVounpuGGhIjtPZboSvFKhWc1odZ47
	hWtO+Ri3Ju5am6RyJiCU/WpV8Qmh7mbtTnhkjcGKws8e8qpmGXILN4/e4A4XC8YU0GgaORRIR95
	T3h1IP7g1zBHjpIX6SD3uANhnsWbxUIElVY90IEGPo5t4iJ8Hh7K6+wdzlfVWVRgc8IpWy+69Op
	tCTOujH9kFfrnpydGJAY2qzRQF3F/yQu4rcZl/M0ubRgNyNoDzNpODpEPtvI4p58kSKAEpPf7Il
	ZjZHqk7mVHXtVZhjRoEGtq1QUCRTn6Dm+6+8/PRab77aqalXCB7bvvNB4unZgdS1mxvT2dNEPkO
	r9W0kBaC1kh8iq38r3DPwrGEfwmcHXyzkjhas2PdJdRzVsP5uWM0XWhTRmz/tZrTy/7s8YHWK0l
	zTB3m3cZke31ggs9plRmRkryimC/QIgTzVc=
X-Received: by 2002:a05:600d:82c8:b0:4a1:cedc:ab51 with SMTP id 5b1f17b1804b1-4a1cedcac09mr30065765e9.35.1792148274917;
        Fri, 16 Oct 2026 03:57:54 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ae6d2esm50003685e9.6.2026.10.16.03.57.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Oct 2026 03:57:54 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/11] mm: Memory providers for guest_memfd and iommufd
Date: Fri, 16 Oct 2026 10:57:52 +0000
Message-ID: <20261016105752.68015-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <yq5a4iem57qv.fsf@kernel.org>
References: <20261014093733.90312-1-griffoul@gmail.com> <yq5a4iem57qv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:

> What confused me was the introduction of memory providers as a subsystem
> in their own. What we really need is the ability to map PFNs from
> other subsystems into KVM stage-2 and into subsystems such as iommufd?.
>
> Restricting the scope to the above, at least initially, would make this
> much easier to reason about.

Thanks for looking at it. I should have explained this better in the
cover letter.

A memory provider is the driver that owns some memory, like a carve-out
or a device BAR. It lends pages to whoever maps them, and it can take
any of them back later. guest_memfd is one user of that memory, and
iommufd is another, but neither depends on the other.

With this series, iommufd can map a provider file without any VM. Today
it cannot map such memory, because memory without struct page cannot be
pinned. For example, a host service that recycles provider memory
between VMs could clear it with a DMA engine driven through VFIO and
iommufd, instead of the CPU. And since such memory can outlive the
process, or a kexec of the host, a network or storage dataplane could
restart or be updated without losing its DMA buffers.

> For my use case, the VFIO fd becomes the backing provider (referred to
> as backend below). We can create a guest_memfd using that
> resource_fd, allowing MMIO BAR ranges to be mapped into KVM stage-2.

That fits well. VFIO could be a provider for its BARs: get_page()
reports the BAR frames with the MMIO type. guest_memfd takes the VFIO fd
as resource_fd, and iommufd can map the same fd. That could also replace
the dma-buf plus symbol_get() path that iommufd uses for vfio-pci today.

> Another feature provided by this series is the ability to map the same
> range into iommufd. We probably want to restrict this to shared ranges.
> It may be simpler for guest_memfd to drive this.

Agreed that guest_memfd must drive shared and private. I replied to
Ackerley on how that could work with the provider interface:

  https://lore.kernel.org/all/20261015171746.51538-1-griffoul@gmail.com/

In short, on a conversion to private, guest_memfd claims the range on
the provider file. The provider code in mm then revokes it for every
other consumer, iommufd included, and hands them holes until guest_memfd
unclaims it. So guest_memfd stays in charge of conversions, and
iommufd only ever maps shared pages, without going through guest_memfd.

> Currently, a private-to-shared conversion causes a VM exit, followed by
> an IOAS_MAP for the newly shared range. Could using guest_memfd with
> IOAS_MAP_FILE avoid this?

Yes, the IOAS_MAP goes away. The conversion itself still comes through
the VMM, but once guest_memfd unclaims the range, iommufd maps the
pages again on its own.

> Perhaps the series could be rearranged as follows:
>
> - Allow a guest_memfd fd to be used with IOAS_MAP_FILE.
> - Add a VFIO or other backend for guest_memfd, without calling it a provider.
> - Add support for guest_memfd to provide guest PFNs to other subsystems
>   through its file descriptor.

I'd rather not make guest_memfd the only way in. With kvm_gmem_ops,
each backend implements a guest_memfd: it binds memslots, invalidates
KVM's mappings, handles the host mapping, and for confidential VMs
prepares the frames and gives them back to the host. That puts KVM
internals in every driver. With a provider, the driver only reports its
frames and revokes them, and guest_memfd does the KVM side once, for
every provider.

Your diagram already uses mem_provider_ops between guest_memfd and
iommufd. It is the same interface: get the frame behind a page, and
revoke a range. So I'd define it once and let drivers use it too. That
also covers the cases above, where there is no VM and no guest_memfd to
go through.

guest_memfd can still provide its own file to iommufd where there is no
provider behind it, for a guest_memfd that allocates folios. That would
use the same interface, and the same iommufd code.

Would that work for your VFIO case?

Thanks,
Fred
