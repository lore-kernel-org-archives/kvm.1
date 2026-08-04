Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3F736C9C5
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846128; cv=none; b=ddcA5Ke8Dn0E3z46W2Z81RrKelxEFv9iZYOfJVTcZgsfc7ofZbTJDGTKQayjMQlOO7Te3XAktYI//EOKwEmltwHA5Sx7qJ1TTp90xWxjQ9O81YMHjnU3YLRfxdrCM7egRZlbHhN9YjzvQ9YIK9BmTGUuFHHhEHN0C4n+E/tusME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846128; c=relaxed/simple;
	bh=K1XdpXzCqeMfT3gx1+GfQWAVnbTVzSRrQini9XusnHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWvtTHECoRTZGKZc+veBuAlsF0OrvL5/lK4Pcz6Xj3QxuFkWN8iEWhaXsg0HMTsxFiC1n+X2+jNV6gucJDtLF8mgzKu2doVMexgB2qTmmNxHgxauls/DrcJWGxLjHE2h8mjZj5nZM3apEquFhV2ah2xCcf2waivEnco/EeWXyBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CfJXDJ8H; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CfJXDJ8H"
X-Forwarded-Encrypted: i=1; AHgh+RrZw9+ywK1yg5nyncHDXSpH+FfLnEAALye3IPkDJ3lRSL+qRVMkDByOJgJUxCSnBKv8pAo=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785846124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K1XdpXzCqeMfT3gx1+GfQWAVnbTVzSRrQini9XusnHU=;
	b=CfJXDJ8HCWGw0clNvnJdQayGbEcF4R/memE/kwOj8wlemm+gjFopmITdcCPUHE0HKwMyPk
	dj6IJ9sqJLX4K3+mT/FsMh+V+XSr8wP0FXSMrciug2/npTbhKIumiZ2gV/o3j6BU1KxFmC
	G8Gw9DJR5a4AjAnlnuFUabuPxAxYpgw=
X-Gm-Message-State: AOJu0Yz4GMtOKRBz3LBw3NJdchTdnBNXwd1bbGwFRT7wlkH4GF8FK3WV
	VhoskSVgtxSSZbXQyOgpthf9s8oTsXSSKZB73e9nFvR9eyDLpuRugLkrJOHp58fqNzr1OGoPfI+
	bpuIK8Zs8/HJyhBii+kRToR/EwCOkT9DBCpQiZ2ID
X-Received: by 2002:a05:622a:8349:b0:51b:ff0a:2048 with SMTP id
 d75a77b69052e-52ce3f3c749mr201921cf.3.1785846085744; Tue, 04 Aug 2026
 05:21:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715142841.80544-1-steven.price@arm.com> <20260715142841.80544-16-steven.price@arm.com>
 <865x1rcvfw.wl-maz@kernel.org> <f971d029-84d9-4c66-9875-36fa8f1a2a1b@arm.com>
 <86zez3b6ps.wl-maz@kernel.org> <7beafe29-0c5e-418b-8797-190f1850b18a@arm.com>
In-Reply-To: <7beafe29-0c5e-418b-8797-190f1850b18a@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 4 Aug 2026 13:20:48 +0100
X-Gmail-Original-Message-ID: <CA+EHjTx751071VhZPf6ABaZngTqOdPG+_aVLCTct_G_ksfYviA@mail.gmail.com>
X-Gm-Features: AUfX_mxGnxORLKO8iAowkYu9tpNhSCXZ535sQNq-ffLHKfhzkRZPZxsKS-feAzQ
Message-ID: <CA+EHjTx751071VhZPf6ABaZngTqOdPG+_aVLCTct_G_ksfYviA@mail.gmail.com>
Subject: Re: [PATCH v15 15/37] KVM: arm64: CCA: Handle RMI_EXIT_RIPAS_CHANGE
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Christoffer Dall <christoffer.dall@arm.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>, 
	Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

Hi Suzuki,

+ Quentin (who's on leave, but for when he gets back)

On Mon, 3 Aug 2026 at 16:30, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
...
> > I.e don't hack into the API. Use the information you already have to
> > decide whether you need to use the existing API at all.
> >
> > If that cannot be done for whatever reason, then you need to indirect
> > the call with a set of operations that leave the existing code
> > untouched.
>
> Please let us know if you think we need to explore this ^ ?

FWIW, pKVM already has this kind of indirection: in protected mode,
the kvm_pgtable_stage2_* calls in mmu.c dispatch to the
pkvm_pgtable_stage2_* wrappers through KVM_PGT_FN(), and the callers
don't branch. It is global today because pKVM owns the whole host, but
a per-VM version would let the CCA backend handle the filter and the
IPA aliasing internally, keeping __unmap_stage2_range()'s signature
intact. That should work for pKVM as well.

Cheers,
/fuad
