Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E780927732
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325183; cv=none; b=DoVZY58k9xWAZlCkYJ2Heg34N2IN8E9n7sRElr1gnjo8w0CAI9q2lpdxq9zsDXg2CjGpSR49JUIjzzxoK6bfDEgJx3QvCvXR2P5Xm+4oOkidEamzzKSy0lmVzDdASVNshXUmwqahkcGAKhXzQZ8iG1Sb+LDGYDDnAEUeSeXfLj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325183; c=relaxed/simple;
	bh=TdIA0C+hvWbuO2z/X3tRH27TnhL//kWqbhu9cqVNunU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BELmoZiD4xp3903FQcuA5H7/wwDECP7P9iB2S3VhOvlZBC03GJ3W+XpQzjXIw6slD3/Wf2zz/vmCBw8RNsplB920/gej9aNp3g3mWU6kcN7NxDTorDVaptgXRjdtM9CtZXMNGCdXxiP9qZkKdPoHyI6Z68/8JrFuKBBUWzvyGqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tf+w7GPk; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tf+w7GPk"
X-Forwarded-Encrypted: i=1; AHgh+RqJ+fqP/T9v4jd9lWXDIgrF8x7fhGv4FQL0VKIIm8YaDvJ+TBQeTSBwL3Jkven9hXXFxlM=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785325177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MgvBuiLRj24R5eL34h27DbmmXIsCnSbcavTOpGhYHMk=;
	b=Tf+w7GPkGS7gV+appyoA0+Gdz5HX1TvWHg2cEYp94PdYhqCtJvpRu98hu1eweUR8UV7SPi
	RRu+DKrThE+PA4Q/jClCLPEcLtbzRUL+3VwPSJG1nXngMtLxXyyx2308urbHI9wK0ftwQt
	ceqxPvJa8V+Ual8OlOz0K0PpyNw9f20=
X-Gm-Message-State: AOJu0YzzRIXH/WtPxw4GAJ4WXF/6jpmNo6hAm4t02xuN1TV/n3wbt9q9
	JvYA4D+uQeKPrGg6aKwRYnUFLACys+MGAUy1I3VC/aK9mASfRcTASdPKk4P+B26t7b1D6JDnjid
	he7LpKEC77IRnouJ2jW2W9GWsGR7sHXCnh7mJeUj1
X-Received: by 2002:a05:622a:8359:b0:516:ccc0:ee38 with SMTP id
 d75a77b69052e-52b2cc84a3emr5917821cf.9.1785325173789; Wed, 29 Jul 2026
 04:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722202702.4165917-1-congkai@amazon.com>
In-Reply-To: <20260722202702.4165917-1-congkai@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 29 Jul 2026 12:38:56 +0100
X-Gmail-Original-Message-ID: <CA+EHjTyMjsF6jp98TQhc+xBm3+p7wykeK-JMvybU+mjyu5gveA@mail.gmail.com>
X-Gm-Features: AUfX_myrOBKJjGr1oQQJhjpP2gtOW_slUtGnIubwUV7eVBsMrgW-SzxzJTTjCds
Message-ID: <CA+EHjTyMjsF6jp98TQhc+xBm3+p7wykeK-JMvybU+mjyu5gveA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] KVM: arm64: Expose PMMIR_EL1.SLOTS to guests
To: Congkai Tan <congkai@amazon.com>
Cc: Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Haris Okanovic <harisokn@amazon.com>, 
	Geoff Blake <blakgeof@amazon.com>, Stanislav Spassov <stanspas@amazon.de>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Wed, 22 Jul 2026 at 21:27, Congkai Tan <congkai@amazon.com> wrote:
...
>
> Congkai Tan (3):
>   KVM: arm64: Expose PMMIR_EL1.SLOTS under strict PMUv3 UAPI
>   KVM: arm64: Advertise STALL_SLOT* in PMCEID1 under strict PMUv3 UAPI
>   KVM: arm64: Add KVM_ARM_VCPU_PMU_V3_STRICT vCPU feature
>
> Oliver Upton (1):
>   KVM: arm64: Ignore writes to PMCR_EL0.N when using strict UAPI

Tested on QEMU: boot, get-reg-list, and vpmu_counter_access pass. This
doesn't exercise the KVM_ARM_VCPU_PMU_V3_STRICT runtime path, and the
series adds no functional selftest for the flag.

For the series:
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba < fuad.tabba@linux.dev>

Cheers,
/fuad
