Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506867;
	b=4lXNUi+ZQk/vWdLXr237I/ALdlBf6QC0VhpMd2vIMR9RH8w3IM1CR6P//Jx8P/l4DEMg
	 egWx7YNvwUARh/zORNaVtohoc6U9/9meEzZCXS3qZbTIlLgWwKpSkPzDWoVIw7AdUT/ah
	 W7JZffm1rAZFYxJ83rWFaXpr/8kjxD+CgiUeCvvD03bCz31nlTBoDjUrnIv97HuykjmVu
	 zMlTXFawSxl4sIpan12UWuk8b1uPWxvfm9YgpCApJIe+Su6OW3BfqEIdin2KR6bG92hUh
	 FUeQ+qaVEQfPLXbFDX8rIYwzbAYYF3a53xNuz3JUUXpT+VYgcjKDuv6lnM4lVkHi5yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=k1iKJ3ce6I7V1KzAt6ijmlB03GjSeH93EgIWrRWokzQ=;
	b=MLVH9CZJiQtvSuhwnMJQcS+maPJGecWFrPd5BNzdxagqzu/38MlovfTXbXIc+UU5KFSh
	 5yfsIVSyh9Q/XUezI8Dlbj9pmUsxNJrFeHlfhAT0Ni38E75T/F6AnIw7BG1dl1rJYg10k
	 jSsSbWxN4HmJZ8mdguxxB2zbkaoeT3EufjpVSw9C4Q4Atr/h/gnYTI71xQAuDWxnEqMX/
	 ScaYscBYDBpltATxXGR+W9AE/DYaIuvqaPbQZYzwTkceVVRbA4EyEYcVyjKYrYaUQxFet
	 vdGk1D2aHtP+AF1PAYpMQh7yKMqO2OuS/QeudNH8QJjWJZvmdydPYZ7qHFvGiVR5pxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WSZWdqmJ;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCAB606A33B
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 18:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CCAB606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WSZWdqmJ
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so66530a12.0
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 10:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794506866; x=1795111666; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k1iKJ3ce6I7V1KzAt6ijmlB03GjSeH93EgIWrRWokzQ=;
        b=WSZWdqmJqh+OgDpd0veh5NM3ZyaOZ2OD+CYCh11RQq/LhbAg+F59TVE2w8HLbiP37J
         AfTia6KAhVbRb3q5CFV5LOmYNMAQTDpEizJzAl+yYiIxvlcIsur+hL4XmOqbxN4Nrut5
         TAFERQq9ERTYuSdV1fZrNdPArb5TYPyPVddgh92h5N1IBbrCf0ATn9y5vSDDGfTAJR+w
         bG1hiauO5vPHMRNODgze/wKmPq5+m9DBT7Ch5CgS31kXkSIQbhBArKQDZUrVHryy0dQO
         2rHE3pUWOrEnhxHsV8torug94foBqDARJ+gDNh+HlEse6Cn3+uOV9GU2wUtfHYSTqcLP
         MGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794506866; x=1795111666;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k1iKJ3ce6I7V1KzAt6ijmlB03GjSeH93EgIWrRWokzQ=;
        b=kuhPDFvjPMiTtTeqMKLpRN24qGAxZmCH/7iKSZJDKnmQURGooZSF0HilzGCzoS/KOo
         HpeQ4G318pdju6WjMnGfi1Qmp+J0H/HH/kNlq8tGsNVIsk3rj3BI8mPQf8/20ZHId2Cb
         JdxqOX5SniDMyLNZ+VsHPIaBxRYY9pEXccl4lHrDWcmtdTSqo3Xy3MXKRLdRMP7bEFGO
         tUDtFLilSMAk+LXAuZ3lMKGusZgg+L+oBZv030R90G6Wg08P90zQ1mijHR5dnR5DKxHF
         L6+SOGfbvL/HswOJdd4RvN7rtALjCL52XNHa8d9uxAJz5/w+InErYyKzSUp3aecFLEhN
         j4rQ==
X-Forwarded-Encrypted: i=1; AL+hErGrgbjQJKdsN7ai5I85UPBpcCI5HleIOSoE6k/cz/u7BPwby7RENpiGv/4Q1u6vU/L6ej4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8udGhTvxtk4SjqutYgfXZ111UVq4ZFDRZMeXUXVQ8dpf95JpXF
	MtSFwuEWMJf32CT4UI05GEdf7qBQEDGPQEoBZTT5R28mx4NXyPnlLQ7o
X-Gm-Gg: AYBFou2e+0Sx6QOU5B1NiPpq4NMvhueHS37Ftz9wVCXvnbNVjQBW99JT1XICXRN4nwa
	RYOz0SepmT9MO2NL2W1wUkGNKNsA2Zu5yfxEsupZwWjBcCfhQt1Qmh2TE6O0CduDSq9ZXksm9he
	0quEc6S8v0vrqr7BdIL7TXClYqPmocZvBs4y30x4qTNkLPRT8hd59gAuyYdjw1jSYqZRCCd3/Ze
	ocIVVNcIZ55rHPXACpTGqUp6Hf2YHR+sqc8pl0unFn9myJi/2Mb07vEvUxGtutcn9qKoMRgOn+J
	15eb6WUA2y7OYdcOLaheRXAaE3I1udKEAeohKeLCjZ4KRJE0PdkpeOpIsJWbYrniyKsufkir3+O
	pU7VHN+1DHrMdxgc7sTjJ/PfL8mDPktFQr8xd9uc19X25tlAWj+LvAqIpszpo2VqwJfSnsIb3bf
	HGxzuV0DthzNBCzhWweZOBvrypxvNnerz3W4FPPfNNvXQCHGcyxL1H6XwgXg2lAVpwP55jcZ8jZ
	kV+QPhiFx/f6L2QG7V29aSCUt36xEPxrpNy9B5Nq1aqo7NkWnNdJBemDpXuPUaMp/vRvXHF6xeQ
	MYkQumPxqBPfbUZtgz8JTpyWGxyz+IuUb4vp+YkXPVXYw1cfuZdvDfgr2PaHwF/KSxdbM2vZMFh
	w3t/yI8aHtEPEc7mcgNtymy1mQx4PLO06lkrV9datbAqAtKE2bC4knNqXAaGQThXEq2RAKsi8Lb
	IdDoLDOX/yQsXqyV0m/KBOW4QZKlnOuReKpHPW52JM
X-Received: by 2002:a17:90a:e387:b0:3b1:8380:a9a0 with SMTP id 98e67ed59e1d1-3b18380ac2fmr4732901a91.46.1794506866237;
        Thu, 12 Nov 2026 10:07:46 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b181f8fd59sm5540773a91.1.2026.11.12.10.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:07:45 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Fuad Tabba <fuad.tabba@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Navneet Singh <navneetsingh@microsoft.com>,
	apais@microsoft.com,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: Re: [PATCH 1/2] KVM: arm64: Hide FEAT_LS64_ACCDATA from guests
Date: Thu, 12 Nov 2026 18:07:41 +0000
Message-ID: <20261112180741.17614-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <040cf379-baba-4e3a-bf3d-6bc009a9e28d@app.fastmail.com>
References: <20261023070110.1833446-1-fuad.tabba@linux.dev> <20261023070110.1833446-2-fuad.tabba@linux.dev> <86fqxwzul7.wl-maz@kernel.org> <CA+EHjTw08SZC_3Uodt6ew6vXVH-doW-8G41fVCF-rmaKsv+0fQ@mail.gmail.com> <86ecdgzp6m.wl-maz@kernel.org> <CA+EHjTy0jpY3sdVCENJRj_kfRDwbZ6TpkCAHQ2xUO-7ZuErpcA@mail.gmail.com> <ad724195-3452-495a-a50a-5e5c8093a483@app.fastmail.com> <CA+EHjTyLnAXanf9R7SuoL3gFZUNewX7QOnW=mc3qzwvaxg7jJg@mail.gmail.com> <040cf379-baba-4e3a-bf3d-6bc009a9e28d@app.fastmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Oct 27, 2026 at 02:48:29PM +0100, Arnd Bergmann wrote:
> On Sat, Oct 24, 2026, at 09:14, Fuad Tabba wrote:
> > On a host that runs at EL1 (nVHE or hVHE), this also requires
> > __init_el2_fgt to set nACCDATA_EL1 in HFGRTR_EL2 and HFGWTR_EL2, and
> > __init_el2_hcrx to set HCRX_EL2.EnAS0. Without them, the ACCDATA_EL1
> > access traps to EL2 and the hypervisor panics, and so does ST64BV0
> > once SCTLR_EL1.EnAS0 is set. Happy to write those and the KVM change
> > once you're ready to post this.
>
> Thanks for the offer, that part is definitely not my area.

Hi Arnd, Fuad,

We are preparing to post the Microsoft Smart Data Accelerator (SDA) VF
dmaengine driver for Microsoft Cobalt SoCs, which uses IOMMU SVA with
direct EL0 ST64BV0 portal submissions carrying the process PASID in
ACCDATA_EL1.

Now that Fuad's KVM guest FEAT_LS64_ACCDATA series is queued, are you
planning to post the host ST64BV0 SVA + EL2/KVM patches as a standalone
series soon?

Either way, we have Cobalt hardware with FEAT_LS64_ACCDATA available and
would be happy to test your patches on silicon, or help put together and
carry any remaining pieces alongside our driver series if you prefer.

Thanks,
Siddharth
