Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794924346;
	b=l+EX/IxJlHsT7jM894p3ha9cZweiMSz3tcYK56CraAQBatFPPcVfvCN/fCAahGJ01Ys3
	 nkKU6n481yyXas8BTwv3Zn3u34bbjSokXA2SqSOVcJupsRqLRCB+gsAxsvUghHRQY113I
	 PbUUvP0nXw26AsJImmjlL9ubbUT6eye8NpOTsupksXdljnZZkDNuiJFTJLCf1bL+H0jc2
	 YjwWQ2TWDP/DXotS4yQYJoQiSaqF9Kbg1OM/0PdF+sI65ajB0kpwH9hXa24ZVTPNZBri2
	 fRTw4VpWqnXKFcTXIuDqcNRHZnJMdsiU/Z3wubox2k8cT5X2W6lH9Yk8t83zB7fQasQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=ngfsadg2SKwRZORmemooRU9fe+LsEp8AELUWW3EroVQ=;
	b=WfK3DteyQm+YjdhihFtpePYE2Zz7OeVsk/mcc1LBln1qZgafS78kd7d/kjFi4OKPBgNA
	 NujYlFoXRT1ODr2Zh/HIuMU9GPDcA2ZCzqrSccu2G+z7Wu1DUTB2cnE2A0/pb+vu17KPU
	 z7st7uLaX0BnWK4uegFIf3kV9lwXRWaIJfucme4io4vY4kJW205g1Yz/IypKT5JgLyxDW
	 HNtZbQT/ChMW7fRL8b6ixG7TEXP00qKEOS/V4ey0GIhHUIHITgsDccntF8ovCdi0VaIEG
	 evT2V7i9NkViStns/kPtNAkbUpnRMBsAAmWHUDtcigscE38aE5f8Y/4u9VTvmVkfzKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gQaQzXh4;
	arc=fail smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DDB606A336
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 14:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15DDB606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gQaQzXh4
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5be58ad9600so8825e87.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 06:05:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794924344; cv=none;
        d=google.com; s=arc-20260327;
        b=WEG+3mMfZSUpPHY0ddP3/VV7fBq9kBQXhzyY4kzmlajq0gyaJAP37UFMYYejifbUPq
         lBEuC1RwqGaTgK5qVHnXaxH//7w0gk1f0TXIAe0LHvCUXEPmrgUsqBl0/MCKzdmEvHS1
         M1T/bpavaBM+0xe/IFeUymt48Y00P0uQuZ+S2y6parsH2KH61Fb6f1N3p+SobLWpLXvk
         hDoGE8dxUs04W8Qk/u/th2pV2nwSteGHrF46GDJ921Bq0w3sK7h8wcaewxGKmW9yq+rT
         Iso9yus6MtlFLeWZgTFf+rI2ha3bQzmQjugpV0RugLBaBZ/vEpyKhp3dbbZ1rLKIdRM7
         yTSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ngfsadg2SKwRZORmemooRU9fe+LsEp8AELUWW3EroVQ=;
        fh=eX0UUv20AwtGz/6DjiJ0HF+j7ya/SvNd9lj9bQBJBfo=;
        b=HgrWiCzJ+aOLXn5ji88/jH/0yxI/0IEvtVN+sMvW143+6VfQJVbx93tdZjnK3a/5ts
         CIna7G/7tOhOqccGZdbGPbTS1JadUlWrjTw/Ixf/UN/Lft2BCstulq5eXHEgK2zNEPjF
         WcYydH2BZo3WlxxyunByfjDelCzUrTB0rhBdKbymWXZAHOhMwuNdebGTQ8RcgegO72rZ
         hDDdNPfdaxav+VREMmfsig2sQ3AUqBA/2Zibz39DEn2w0aOz0lYeKJqUyh/OdWlu0Map
         bUaN0Yggmyl0LLpbW9ou40yDRxrDhoXYuOiMDw+7Saul8PL/d1SttwuiRSVD7H/cJjqC
         OXGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794924344; x=1795529144; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ngfsadg2SKwRZORmemooRU9fe+LsEp8AELUWW3EroVQ=;
        b=gQaQzXh4+kvCyesNc8fnwo3aUbPi8d7oSq0+OtSe7pXlNIH6BFEex5GHvXcFPBBb3M
         HiW+tdfhrYcsifnwoCPwTnugWDnSsRZB1FTNngFJ4rb9ozR+a9rvskfMxTh+QbUizdQt
         heDpVPP3qganrP1xo0HTVOs3i4RYBU+A3xa4PcdR9ntDHBaB8kdeuE+QL14uVfwMDLgd
         bRvGSQ66j5jbeR+bjY1Aw9zESB1nU2GsDza4YHgdWnzhQ4ubhAf0Yy6XhBTnPUhMBunj
         7OeLywIl7unRouMFEvam5oAyY9Of2NZUYT+FUUMiOaGwugm7JcQ5POV3JByOv9vJBpQq
         C6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794924344; x=1795529144;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ngfsadg2SKwRZORmemooRU9fe+LsEp8AELUWW3EroVQ=;
        b=sM6kQGAdct4FT+AQUDfSJTzGiBD3i3IFNCHOm0zRGat593YjONZVdsrnMsQ9ql1Odi
         fT2u8e2vzOg5aXlH9FMbZJ3+C+x938EFJE7tv1JD5npuYb5bO5TjF4RCgFShL7aPkoHH
         qSkEct7ABF8NIslFHAHPDiLtqreRmlZ5YB31cgkr+16dUVp7pwwJj4RKAGOA5xZRDuuL
         0Fd3Ao2GbcchebdgjBkV+5CFJVK2ruLL3iywI8dIU0Fkj032DtGcHa/KZBZaasIcBGd/
         2Z4eY7bHNQjethBl2y/mzWMMYhcWqM6IuWI4PqCeejQ1PXFLpjgTzMb+MBDbDRpyTpLX
         Q3wA==
X-Gm-Message-State: APuU4Z+9tNTivFeKOWxyE3x7HhMG8LTAymg/mPnJp3Dy+FdPNdrGmpyZ
	dtcLFyZEftZzQ2caXpTzaLzwggyOTxW34XUca8h9gArLm1WPE5juHpI7RXofxA443Oi1qbjlqKC
	xT08Uu4nSGgd62qXOomw2qbof8QzOD6GWx7/U02xG
X-Gm-Gg: AYBFou221I0WW909yGFGGhLFZhp5suzm0IAMHkKKtPcdkA5x4XgBwY9jUvFgEdpk8fc
	BgLkUUINv3E4T2CipcoyM8iumr4lfH8cdFQx6EySO4s4cYXNH3wEgi1MiDtjnXKkAElZ12UnRTx
	WzeCJGVLUF7t9AtsOBPT6clHD/xVMy/PRAA/Sn+8+8fdOjoec95L4QuKblvXfWjgfxKpc4Xi8H0
	SQeAS59BVlRWmVFK9DaYBiD1fwP6rG6uTQ6KvdBo9aKI+kTuiqc7akjobR7wx6N1b4Yj4mjZLAB
	xvBBBlEBmOYbnOzZDw3dbg+GUrveJeFhlwmdHp0OLnh7memiJOdoBKpFRcYZE/j5jSaVpdvWCPE
	CZZh3huIviZQbP7sBfQfI7D/jdpPJBDM0UC+v95jP9doKeMlTgqM0SDcAAGn97FOHWKHPx5S8Lr
	vH+31VlEFRxYBxR8dePdLStVQ=
X-Received: by 2002:a05:6512:1111:b0:5c1:4f9f:1ae6 with SMTP id
 2adb3069b0e04-5c1a217f086mr131117e87.15.1794924343575; Tue, 17 Nov 2026
 06:05:43 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116164358.142785-1-steven.price@arm.com> <20261116164358.142785-2-steven.price@arm.com>
In-Reply-To: <20261116164358.142785-2-steven.price@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 17 Nov 2026 14:05:07 +0000
X-Gm-Features: AclHuK9jKHIPqUkK3esGB7IzhXZkIYCyUzZ9ZlR4n4bgSHCJJEi20GuUOPH-oTg
Message-ID: <CA+EHjTy5xBmavNWSYPjqU9qXtssV3ZHzsUr1s_4bVOt1GnDLVg@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] KVM: arm64: guest_memfd: Check mmap support when
 preparing memslot
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	James Morse <james.morse@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Christoffer Dall <christoffer.dall@arm.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>, 
	Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Kohei Enju <enju.kohei@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

On Mon, 16 Nov 2026 16:43:47 +0000, Steven Price <steven.price@arm.com> wrote:
> Check the guest_memfd backing file when deciding whether an arm64
> memslot has mappable memory rather than checking whether the slot is
> gmem only. A public helper function is added to be able to reuse the
> static kvm_gmem_supports_mmap() function.

nit: could the message say why this is needed? It's a no-op until
patch 8 defines kvm_arch_has_private_mem(), which makes every
guest_memfd slot gmem-only.

Cheers,
/fuad
