Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9221F405C38
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743077; cv=none; b=Z9+2X72x3RctiP/8vC8evI5CD+Zr44fzHog2NRB/6a49gDm75Ldr0vw3UinID1sd0c7I7gdbI5SdVxN06g5GUXead8yIghzFx//hu5hG5WcS2lLFrrjRFc0/MCk8vniLp1pGEDN/uEe8w0AUQFNjKa+vKrsNxz+N6S+FJpH86aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743077; c=relaxed/simple;
	bh=h5cZsGKWrMXzmekoRAj8WHyaGhT9z6Pr5c9d04J22pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QO2FhWo0sgnDnON+b9/rjAoidNsxOq+ZRYBlnZ/FYrSmmaXi1I/6VhoLVEkRB52WHQh7GeASOPwSwvVAUdMb6lTegu2KrdB8GvArvGQrUgDCOL4Mf7lgBWyCZBw1nagLXswXmx3AY5chq3UKtwMA5hgIZlKyAJ0nnfl8EFfOo4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s6mvtHvM; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s6mvtHvM"
X-Forwarded-Encrypted: i=1; AHgh+RopILXX/qAO/Ys1j162OQNLbXCBj2ooREGe1xRiV4BN5lWWPMgboRg0ztTxAiOfnIiaCgs=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784743073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RNf+StBq+Xe+3jbYQBIhdsx2jh5oqIZIvT85TkHHRhA=;
	b=s6mvtHvMvkRbEwsAe0JyLahl3z+Ayr+UBew4wiDusaOrableoT/09ETeL6AAbmjNQLAd2K
	F2xB1jNPpnqo3HOF+P8Avm7eyIuhKk8LjeB9v0Vw5iV8MvbOipzGmtEntWLLdylqqt4Gzz
	tNwJsrMlUEb3i5hFzt1gtUvyXmu0xHw=
X-Gm-Message-State: AOJu0YwjcXiMQZB8TM0jJvXTcNykDof7N3gzKntKH1NLwV+DXmjfzB8F
	uImV/CZtw2M32dzIgIwMAZawf8IpNj6jdNhEVS8p2KJjWBKwTUBu6rzIU/divX91zjIH5gTkJLr
	EuCA4wgPetY+QlJJCTvlue+xyeSOJDkPVJDT/6SSf
X-Received: by 2002:a05:622a:a981:10b0:517:6dc0:698d with SMTP id
 d75a77b69052e-5283b8641f5mr863721cf.0.1784743059542; Wed, 22 Jul 2026
 10:57:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703154811.3355680-1-sascha.bischoff@arm.com>
 <20260703154811.3355680-37-sascha.bischoff@arm.com> <CA+EHjTybDSAgr44jXNFnssnYq_vVeuZ+1qORS8f4dtQgMzOZ5A@mail.gmail.com>
 <71dc44828b55c848ca7bc842cb13b34681617ac7.camel@arm.com>
In-Reply-To: <71dc44828b55c848ca7bc842cb13b34681617ac7.camel@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 22 Jul 2026 18:57:02 +0100
X-Gmail-Original-Message-ID: <CA+EHjTwMHxwpRLi0BEx5ykH+Nc1Oxja=6DYmdeS=3A3yzYYRzg@mail.gmail.com>
X-Gm-Features: AUfX_mxTwAstkGjzWOdnvL1hFBOCWR33UqAdcJvL9E7YW2li2DEVUoBMCGBfKY8
Message-ID: <CA+EHjTwMHxwpRLi0BEx5ykH+Nc1Oxja=6DYmdeS=3A3yzYYRzg@mail.gmail.com>
Subject: Re: [PATCH v3 36/40] KVM: arm64: gic-v5: Implement save/restore
 mechanisms for ISTs
To: Sascha Bischoff <Sascha.Bischoff@arm.com>
Cc: "yuzenghui@huawei.com" <yuzenghui@huawei.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	Timothy Hayes <Timothy.Hayes@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>, nd <nd@arm.com>, 
	"peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Joey Gouly <Joey.Gouly@arm.com>, 
	"maz@kernel.org" <maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

Hi Sascha,

...

> I think that this is a great idea. It makes a lot more sense than
> blindly trusting that the VMM has done the correct thing. With this,
> KVM can validate that the VMM at least claims to have done what we'd
> expect.
>
> I guess you had something like this in mind?
>
>     struct kvm_vgic_v5_ist {
>         __u64 spi_ist_addr;
>         __u64 spi_ist_size;
>     };
>
> Which then means that we can do:
>
>     struct kvm_vgic_v5_ist ist_attr;
>     size_t expected = kvm->arch.vgic.nr_spis * sizeof(__u32);
>
>     if (copy_from_user(&ist_attr, uaddr, sizeof(ist_attr)))
>         return -EFAULT;
>
>     if (ist_attr.spi_ist_size != expected)
>         return -EINVAL;
>
>     if (!ist_attr.spi_ist_addr)
>         return -EINVAL;
...

> When I originally designed this API, I was keen to re-use the guest
> memory here so had quickly dismissed this approach. However, looking at
> it again now, I think it makes a lot of sense, especially as we are
> limiting the guest to 16-bits of ID space - this wasn't the case
> originally which allowed the size of the ISTs to balloon significantly,
> and hence it made more sense to re-use the guest's memory.
>
> > That would remove the ordering requirement
> > entirely, and by my reading the worst case is 65536 entries at 32
> > bits, so 256 KiB, given the 16 bit clamp on the guest's LPI ID bits.
>
> I am actually in favour of this approach. It removes the asymmetry
> between the LPI and SPI ISTs on the save/restore path, and avoids the
> explicit iteration over guest memory to save or restore the LPI IST.
>
> With this, the proposed struct would become the following.
>
>     struct kvm_vgic_v5_ist {
>         __u64 spi_ist_addr;
>         __u64 spi_ist_size;
>         __u64 lpi_ist_addr;
>         __u64 lpi_ist_size;
>     };
>
> The VMM would need to read the guest's IRS_IST_CFGR and IST_IST_BASER
> to determine if the guest is using LPIs or not, and how many it needs
> to provide storage for. If no LPIs are in use, then allow
> lpi_ist_addr/lpi_ist_size to be 0, but otherwise the size must match.
>
> Does this align with what you had in mind?

Pretty much, yes. Folding the LPI IST in the same way is better than I
expected. All __u64 also avoids implicit padding.

The LPI size is the one that matters. The SPI size is nr_spis * 4, and
nr_spis is something the VMM set itself through GRP_NR_IRQS, so the
two sides cannot disagree. The LPI size is derived from IST_CFGR
instead, so that is the buffer where the kernel computing the expected
size and rejecting a mismatch earns its keep. The entry is a fixed 4
bytes either way, since only the architected 32-bit ISTE is exposed,
so sizeof(__u32) is right.

The main thing I would ask is that the checks be strict both ways,
since turning silent acceptance into -EINVAL is really the point of
the size field. Two cases: reject a non-zero lpi_ist_addr when the
kernel has no LPI IST, not just allow 0 when it does; and on restore,
reject rather than silently skip when the LPI IST is not configured
yet, which as far as I can see makes an out-of-order restore, the IST
buffer before IST_CFGR and IST_BASER, a no-op.

Another thing your proposal cleanly resolves is the ordering point
from my earlier mail. Once the LPI IST save writes the userspace
buffer instead of guest memory, the requirement to serialise guest
memory after saving the ISTs goes away, since the save no longer
touches guest memory.

Cheers,
/fuad
