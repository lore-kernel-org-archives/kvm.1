Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF77678F2B
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337171; cv=none; b=EdgSqg0ixSRPJkkkwI86V9xkl8C//VRjOkBeDZOeUgOSj4pL9PwYG3kxr/wubp6oxuuBFbJ+cG/EfFIhSRn34s2CpFKCqh9y3ZCr23z4CBPmllk21IWJOZ2gDyX03a/GvL4NeF9znjY1GkQsP30+42y4iukSYzjfa1IpYZMU3xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337171; c=relaxed/simple;
	bh=FhVwFEXS0AUExjwFbKD3uITnZT0tNVchjeSg0ZvoF28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxYz5jV7ojef1NaAIi1UH/d9CfR0mLXS6WuJ4uCjugaY1wO20K7K4mHwc0d5VDW7rr4qjKZZPViwIqCBj2ax2MRNgYbSQr5AMo4EuJgeRZx6D/7MQWj6GJo2BZ/a7jlbpnkzHWLKOYVz8aCp69oRBF9Ij6ym3Or3LE/IKDGG+2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I5Ij3/8W; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I5Ij3/8W"
X-Gm-Message-State: AOJu0Yzo8QcH6M5MvPRi1ysNRrrK3J50ax8LY5/9K3frICHR9GlyaMDi
	w0Kj+dT3p+Wmk0gASNKJTCIkRmtbxute/+QppxgHEdb5BoslgRPbMrcVVKDD9YrI3kB3HwosWLA
	B49SIsgyIm55kSbcGwAouc57fat/7MSozKSPJqQgw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783337168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s1dKDdsx8dl4q0beLNZx8id+GQf+YKZnjU4uL11LHn8=;
	b=I5Ij3/8W/oHgwEYpm/m2DnUlU8UArMaAHyhxDGIRUkjaDF11NP6ZwTRBDDB3bpbRmB7NNF
	VxmBQn3zK5H2i9TjhvdEPTkAW0foPXyAIDKoF4n6SIWfIu+QdFmOzbSez1CVHTW2byIVbO
	eW95CdAe2TFC8GYd/U1s5bOepamWJpk=
X-Received: by 2002:a05:622a:b:b0:51c:ca9:3d17 with SMTP id
 d75a77b69052e-51c4c0c00demr17668081cf.12.1783337165445; Mon, 06 Jul 2026
 04:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706083555.302972-1-fuad.tabba@linux.dev> <20260706083555.302972-5-fuad.tabba@linux.dev>
 <5a699a28-07ce-4a6c-bc41-8b9bc7ca0d4a@arm.com> <ab60e6a1-e59a-4089-a6d4-386b83627b87@arm.com>
In-Reply-To: <ab60e6a1-e59a-4089-a6d4-386b83627b87@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 6 Jul 2026 12:25:28 +0100
X-Gmail-Original-Message-ID: <CA+EHjTxh0rbuOA+Ar4kzYUNOETf9kJ0p2c-Kz9xQOJTkCYNz+Q@mail.gmail.com>
X-Gm-Features: AVVi8CcU0sEey1WitJULIymXfvJrCjqGkr6F3IoLAnGgrA1u2SEg-ntKzIWO9IU
Message-ID: <CA+EHjTxh0rbuOA+Ar4kzYUNOETf9kJ0p2c-Kz9xQOJTkCYNz+Q@mail.gmail.com>
Subject: Re: [PATCH kvmtool v1 4/5] Add guest_memfd support to kvm__register_mem()
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, Will Deacon <will@kernel.org>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Andre Przywara <andre.przywara@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Mon, 6 Jul 2026 at 12:14, Suzuki K Poulose <suzuki.poulose@arm.com> wrot=
e:
>
>
>
> On 06/07/2026 12:00, Suzuki K Poulose wrote:
> > On 06/07/2026 09:35, Fuad Tabba wrote:
> >> Add a guest_memfd file descriptor and offset to kvm__register_mem().
> >> When guest_memfd >=3D 0, set KVM_MEM_GUEST_MEMFD and populate the
> >> guest_memfd fields, binding the memslot to the file. This prepares
> >> for backing guest RAM with guest_memfd on arm64.
> >>
> >> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> >
> > Looks good to me
> >
> > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Having another look... Thought of adding my comment, no changes to the
> above.

Thanks!

>
>
> >>   int kvm__register_mem(struct kvm *kvm, u64 guest_phys, u64 size,
> >> -              void *userspace_addr, enum kvm_mem_type type)
> >> +              void *userspace_addr, int guest_memfd,
> >> +              u64 guest_memfd_offset, enum kvm_mem_type type)
> >>   {
> >>       struct kvm_mem_bank *merged =3D NULL;
> >>       struct kvm_mem_bank *bank;
> >> @@ -327,6 +328,12 @@ int kvm__register_mem(struct kvm *kvm, u64
> >> guest_phys, u64 size,
> >>               .userspace_addr        =3D (unsigned long)userspace_addr=
,
> >>           };
> >> +        if (guest_memfd >=3D 0) {
> >> +            mem.flags    |=3D KVM_MEM_GUEST_MEMFD;
> >> +            mem.guest_memfd        =3D guest_memfd;
> >> +            mem.guest_memfd_offset    =3D guest_memfd_offset;
> >> +        }
>
> It may be worth capturing the fd and the offset in the mem_bank here,
> but agree that can be added on the need basis and there are no users
> of it for now, without conversion support.

Didn't want to over-engineer this. We'll add it when we need it, which
is soon I hope :)

Cheers,
/fuad

>
> Suzuki
>
>
> >> +
> >>           ret =3D ioctl(kvm->vm_fd, KVM_SET_USER_MEMORY_REGION2, &mem)=
;
> >>           if (ret < 0) {
> >>               ret =3D -errno;
> >
>
> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.
