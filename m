Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794003614;
	b=zQ9s6tviqRToYTFwrH1n6ypsLdO4RvgRN5BfPU58ZXwi8LdJVxuUxhNXGV9UCzUTGcN4
	 5e+fnJJGcK8LOox0ZZ97EyybcV89h2lcwgXox38e3lwlxXxNr7ezf4xY2iMdaLqw0Gt9Y
	 oM57FYQrxBJa+T/eOxWh9U4KEDCtVzl8lbeOvawqnQxmZvzU441UEateuI//XDP1pA23s
	 Lcuzor4wCy+KyzExTeRJwggkrLSk0RV/Fv97zlDbkQtXAnGOsYk9QRYZpfCCGzWqswUEf
	 Wewi/0sLBCxrlqi4NYh2005HV6cvt0gBLmUANh/f4e+gXANO6VjFlYuk/+amyuTTbvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794003614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=YdrvcTfiK/07Nw/kCOuL7er8KrOXBZTHNtdfHcqY3yc=;
	b=rr3y1jTxFWkPK10i8tTndyZ3AgMLSZTq1IvNjyJivQ0x45CavkXUmTE/mhWSU0wfUS3K
	 PXsTtAYGiwvN4Fw/DhVSscncmDqd9lky7C1cl4AKdj64rQiBN7UgfU7caff/dIYfjsVxw
	 Z1c211fCRrgLwXBhBOav3tPY+teIRLAMel68SUkgbhSuzK+iMsBwDbQ7l4XSmMCxlzlvR
	 a7DG5Dt8DYWnR6d8HwjC6lshht9Iak2WokzwtPJ1myMM/HukXaFeEkW1JEi79jwZrqH+o
	 eFbnLdtp/RUwCVd/cK/xSHd4Gdbh49HVXcPu+BeHUNJl3o9GbXNb5dbRC6YAAxKl/SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LXEDKNDB;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18998606A339
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 22:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18998606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LXEDKNDB
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b09c07b3d2so711511a91.3
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 14:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794003613; x=1794608413; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YdrvcTfiK/07Nw/kCOuL7er8KrOXBZTHNtdfHcqY3yc=;
        b=LXEDKNDBLRIJbYbtObAwr4pGaCKvFWMV99QdmyNI1LdRkb0kyu8RPs5U/rQq4a6M0h
         5ASlz3BmDk3LbCaPAyYM+ml0fpr0LBMu3Q0UZRphZODpbT5qLOGmsnp2iuyMGrmWopeo
         0rfHxzgGItR2A3RsjfMqH1RMIqnPHk/DKQcOT7SxsJPifbZx3trsUOLshBP/kzfGPp40
         jwfo6kRiQl0dxVV33yemWrOK969JVlnLk1sX53xxNvUOyU2suRXcmx/I4zRoch0SsKrQ
         gy23ukO+EfJuK2oVUR2elXb03hZSdEx1PEMUCYg04OuYdXw6vsu9TD7Y/3wa6Yuenl32
         VwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794003613; x=1794608413;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YdrvcTfiK/07Nw/kCOuL7er8KrOXBZTHNtdfHcqY3yc=;
        b=eaRPWREnEsAPj/4ciUDaiFL5p1UuNVXkJ2LC8K7ktmORyg2R0Ub7Bqgj8pZOgUCcq9
         x0Z4Oa98sRHeNU2oHZG9xMDX7pqKQYb6RI8OCtSDfw6JKFO10bhtEsvHsEQ2LTJQ6nd2
         8zlSZPROCkmG3BR7kKvivdY/nJU2WMAr28htfkPOINzuhYx9px+4SVPaj1/yAckMgjL2
         d92M5xTiG/w2oCT9xMrAB2aV8u5tVw0L3J12AGg/Ce4AHHA3o9TvgRxf7LUh9y65cn8U
         vXtObonB0Iq+VWGj6dMWB9FlsWCYwmk25QxM7YY61LpOJaJTwhY+sehEqnfsI5z3YVQg
         z6Ow==
X-Forwarded-Encrypted: i=1; AL+hErEitWUvCdIopTwoOZEYdrt2SkAiWAKAnQbc8zNX8xK0bIS4Af57Lkh1S2u0OzHe5JuGFIA=@vger.kernel.org
X-Gm-Message-State: APuU4Z83x/AqZJ2bOyJb/5uMaVm6Pe05f8rtNkvZJ52V2Mo1IJU7nLF5
	SUYrLeVLggptKbeq9zCyMiTsKaxdepzmk6uBmFJwAf6+nDTBIsE09qxnCKkN3lHi9w==
X-Gm-Gg: AYBFou3HCxsQI/QcUUmtRjflJTrbo5ZOtlQ1fOxvsBtaJf0cvCKGhtWWbOhn9iIx4KS
	HVyhl/MGgmBHl5Ts4Yq5e5mwtvQOP05EJyqJ4dIN/ZxKCBOv9bwtqvrzukmN/nS2gL9y5+HqetZ
	9qce0nCZOYKba+o7WLXAO4x28xFrMhjDleTn6W35Epm+iD5aZrN5obo/cFvTdV4MNnhh8VmsBKu
	rZO6AIZXB8cY3DlyrI82UFmAVj3ktQ6WC1kSn1pJLFCBLlSdrQP8W4efeO2L2kc4lkOe4nIaReX
	mYbwjv5uUXTFTQ2R4OftMF0Dwm+euk/tgShKPBdo7Y+Z+PRqsexyB0W7GoZiR13mFKfJbp1Xxlc
	h4yxKG0mZaV2sYAr6jfoFe4tj1qHGDa9TP+DuKexDdg2CXDnXCxxgOBlvoUdMIQoDDnBTjh3IvI
	q2E8gT2VlHbSuK6qV1gvEAoXopjvWAySAt/T6tBvTLUr39FLbTjmjIeLfuPhWwD+0mNMSHrZvnZ
	ECn45ZmUh6H4aLDMdDNPVEDX/kko7PbIph8vYCMuYsq+l8Qeh9mQ2KVsNIYuzhNb+cu6oTfFDKE
	IrhMaQrdXQmKhX6WbDOc719FpXOaYWJsZvCMqK891NGtONzjhBZf5jAXk2eSKRmXbhekgw==
X-Received: by 2002:a17:90b:3ec8:b0:3a4:e735:b39d with SMTP id 98e67ed59e1d1-3b0db726100mr3762406a91.64.1794003612758;
        Fri, 06 Nov 2026 14:20:12 -0800 (PST)
Received: from localhost (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1057b1fa8sm528979a91.2.2026.11.06.14.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 14:20:11 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Nov 2026 22:20:10 +0000
Message-Id: <DMOH7D1PZUM4.1X82LVQK7E54Q@google.com>
Cc: <ajayachandra@nvidia.com>, <alex@shazbot.org>, <amastro@fb.com>,
 <ankita@nvidia.com>, <apopple@nvidia.com>, <bhelgaas@google.com>,
 <chrisl@kernel.org>, <christian.koenig@amd.com>, <corbet@lwn.net>,
 <dmatlack@google.com>, <graf@amazon.com>, <jacob.pan@linux.microsoft.com>,
 <jgg@nvidia.com>, <jgg@ziepe.ca>, <jrhilke@google.com>,
 <julianr@linux.ibm.com>, <kees@kernel.org>, <kevin.tian@intel.com>,
 <leon@kernel.org>, <leonro@nvidia.com>, <lukas@wunner.de>,
 <mattev@meta.com>, <michal.winiarski@intel.com>, <parav@nvidia.com>,
 <pasha.tatashin@soleen.com>, <praan@google.com>, <pratyush@kernel.org>,
 <rananta@google.com>, <rdunlap@infradead.org>, <rientjes@google.com>,
 <rodrigo.vivi@intel.com>, <rppt@kernel.org>, <saeedm@nvidia.com>,
 <schnelle@linux.ibm.com>, <skhan@linuxfoundation.org>,
 <skhawaja@google.com>, <vivek.kasireddy@intel.com>, <witu@nvidia.com>,
 <yanjun.zhu@linux.dev>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 00/27] VFIO PCI Live Update (noiommu mode)
From: "David Matlack" <dmatlack@google.com>
To: "Vipin Sharma" <vipinsh@google.com>, <kexec@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261102153656.1431701-1-vipinsh@google.com>
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>

On Mon Nov 2, 2026 at 3:36 PM UTC, Vipin Sharma wrote:

> David Matlack (4):
>   vfio: Enforce preserved devices are retrieved via
>     LIVEUPDATE_SESSION_RETRIEVE_FD
>   docs: liveupdate: Add documentation for VFIO PCI
>   vfio: selftests: Add vfio_pci_liveupdate_uapi_test
>   vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
>
> Vipin Sharma (23):
>   vfio/pci: Factor out the reset logic in VFIO PCI device close path
>   vfio: Export various helpers from VFIO
>   liveupdate: Export symbols needed by modules
>   vfio/pci: Register a file handler with Live Update Orchestrator
>   PCI: liveupdate: Add helpers to preserve struct pci_saved_state
>   vfio: Add helpers to identify device files that can be preserved
>   vfio/pci: Preserve vfio-pci device files across Live Update
>   vfio: Introduce vfio_find_device() helper
>   vfio: Refactor vfio_device_fops_cdev_open()
>   vfio: Add API to open cdev device for Live Update restore
>   vfio/pci: Retrieve preserved device files after Live Update
>   vfio/pci: Protect incoming preserved devices until they finish Live
>     Update
>   vfio/pci: Take over preserved devices without resetting them
>   vfio: selftests: Build liveupdate library in VFIO selftests
>   vfio: selftests: Initialize vfio_pci_device using a VFIO cdev FD
>   vfio: selftests: Add iommufd noiommu mode
>   vfio: selftests: Add helpers to map DMA memory at IOVA =3D=3D PA in
>     noiommu mode
>   vfio: selftests: Add helpers for Live Update DMA memory and sysfs
>     state
>   vfio: selftests: Add an attach() driver op
>   vfio: selftests: Test preserving noiommu devices in
>     vfio_pci_liveupdate_uapi_test
>   vfio: selftests: Add vfio_pci_liveupdate_kexec_test
>   vfio: selftests: Verify that opening VFIO device fails during Live
>     Update
>   vfio: selftests: Add continuous DMA to vfio_pci_liveupdate_kexec_test

This series is getting quite long. I would consider splitting out the
selftests into its own series and we can iterate on each separately.
