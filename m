Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AB22E542C
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780451; cv=none; b=RLjT2Di4KIculoeNaM/XnQMybpTuxy0Ks0omJBUGVUSCSeT8WVJe51jzOF28EJPlEbiCPpQ0faadhHPoaQzn6IojDbpXcq0h8BWOWw4JCg6dYuLC7jC+nhv/hZS4TqLo1KCt9qtYpigepu4o9YC6qKnqo2mdW3yJzy7OfvbmjuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780451; c=relaxed/simple;
	bh=LaCpCdJ6vB3PHJFZwa69h40OFOstSpns4OZEo7++8GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEI0IXKxDFVr9mieqQvj491+WHR+mZUc4y416dW9irdrN0COX+ZruD7ehtF9B9Xs4PG52WkRS29Fm1UjNPAQdqik/veu4wPQN8i6oULYZdYgqE5Mreort53EByxaB4Bf/FWyNzMcBxLrNwN8iPacbNYGs9uC5sux2JQDhNb6Fkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etQeCTrl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etQeCTrl"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44a5174670eso4668463f8f.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 10:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778780449; x=1779385249; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KnaJVAZDC++uQU8uHfAQulgEWlG+rcJqqh5PyI/aA3o=;
        b=etQeCTrlcVnw0exp4DUyMumFFqLO3+e3gpHBRQe0HEXxIksslPirFIBGpYgHjDAKm5
         BP6tC1MrxblXE3R2RCKwstkt3NXl9zEmBUmnHKBEjGSN3E/RuBsvS5pay0zvN42uvYNM
         fZQV3iljx/YO22HzxSMucWe1IEZ1ZYCHLJWqXfdiLLu2AI15TppjIdip2uPGHgNYXSDh
         I3c7ryrDn2q93arAo+1F6GuqnbZMX2uRZaNX5DklVTl1SuK8V5sHD3gCSjhXzNZmP+Kf
         GwezXu7iFvgqNqs2eoXftdDyufUgzR4Z78TsNIlH6UX5Mx9x83PkyahiwPWp4E99bkA/
         RNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780449; x=1779385249;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KnaJVAZDC++uQU8uHfAQulgEWlG+rcJqqh5PyI/aA3o=;
        b=sbZMS9I+1eJoSz10OFQ03udSaQRqtH2lNgViSIYbSRgttAm5sFdbmD3QH5SEiVBtbx
         d1bFAhi7ebCtAB0bombzddY8EXlGAbO1rH5fCBc9Jtxn5aSFY5jOzdMevTZTmMNIyq8z
         g+AAWw8pW2kT8P3Tm69jydQ3FPWSNzGHW6ALzZ2j6Wrd6hXZdVy3uUWb/57QCS3uwtbH
         9X1v9g5FAfFXZlArNDai0Ubkbv6xHY1HvjtAbxfc5IijOheqFjpdCNHZU8dqzSJgeLwK
         vLI0N6lmsoXKH+e2yHLOIX2kpidQ/dXpcy8nIzlgS600vmy3ziIRs8mK1c2CjD+ECMyQ
         MMcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+k16wkLjwqveUEq8RDcgwBwArnFo503wWAfzpAgCx1QH38mEysuQg64NhkWcAO2JoKrJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqyPtt3s/p0Lihocq6cACNAMZ4usL5Yckdmn17MMos9FZV0tHH
	H7JHqS/jiZyedquQsSWNykrW3FFPEZ96E8j85vtNIiB1lAy9z8C9Q0Z3
X-Gm-Gg: Acq92OGTF3aLlLwf642PBc2vnn5je4ApqNRZkat1x3h/BfnmCbwGohtYySoqctKX6SQ
	mPO63M72mZfrqMF/buYxd879mV69+Et1DgQt5GVO6qd3rcLVO1eXVX5gazhyQ8eTMb8XUEDWB1N
	v0Donwnbtdiom6vkemFun3T7OCaDO0WUB/DYuLJyUV208mE/xyYUffzM+mtAXZRbaRvdB25WvKm
	BEbGyDqjjRxG4Gb4gIdxdlF3IKCNjZgDp6W5+gqIMfkGFws7waK7tIn6KH5anHvHIFOf8jCad6Z
	HijYwQlHBlEIebYNUhUhSXgoCSwPrVnS5jn9UcJRMVpkVxrYrCbbGI8dwPWBFGFKgR8MJQ9vSSm
	3QIeg9JkgiOobaoeUcReFrspJX9h3cBkXlNmpscykiFWkdpiFaJzV0CL/1S1JX/OurBlqaZievy
	wWGIhDncjltr3UwkT1BDhmy9fFDYaTiFZ8R9Xj9umjAYlQOghgj9Gj3jRszA==
X-Received: by 2002:a05:6000:2c06:b0:45d:4fc0:fe0a with SMTP id ffacd0b85a97d-45e5c5dd346mr66055f8f.32.1778780448681;
        Thu, 14 May 2026 10:40:48 -0700 (PDT)
Received: from osama ([2a02:908:1b6:8980:4f8c:d716:5699:930b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2ffdfsm7481200f8f.15.2026.05.14.10.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:40:48 -0700 (PDT)
Date: Thu, 14 May 2026 19:40:46 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] riscv: kvm: return SBI_ERR_FAILURE for PMU shmem OOM
Message-ID: <agYJHrUHeSq_m788@osama>
References: <20260415220930.287592-1-osama.abdelkader@gmail.com>
 <CAAhSdy3LpnWtc9iTnND2ez4WK8WJUF_edYaDfD9Nd8_F3dPJFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhSdy3LpnWtc9iTnND2ez4WK8WJUF_edYaDfD9Nd8_F3dPJFg@mail.gmail.com>

On Thu, May 14, 2026 at 07:13:04PM +0530, Anup Patel wrote:
> On Thu, Apr 16, 2026 at 3:40 AM Osama Abdelkader
> <osama.abdelkader@gmail.com> wrote:
> >
> > kvm_riscv_vcpu_pmu_snapshot_set_shmem() and kvm_riscv_vcpu_pmu_event_info()
> > returned -ENOMEM from the SBI extension handler, which caused
> > kvm_riscv_vcpu_sbi_ecall() to abort KVM_RUN and surface the error to
> > userspace instead of completing the ECALL with a negative SBI error in a0.
> > Use SBI_ERR_FAILURE and the normal retdata path, matching other PMU
> > handlers and kvm_sbi_ext_pmu_handler comment.
> >
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> 
> Split this into two patches where:
> 
> 1) One patch fixing kvm_riscv_vcpu_pmu_snapshot_set_shmem()
> 2) Second patch fixing kvm_riscv_vcpu_pmu_event_info()
> 
> Make sure to add Fixes tag in both patches.
> 
> Regards,
> Anup

Thanks Anup for the review, I just did that.

Regards,
Osama

> 
> > ---
> >  arch/riscv/kvm/vcpu_pmu.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> > index e873430e596b..f36b099f447c 100644
> > --- a/arch/riscv/kvm/vcpu_pmu.c
> > +++ b/arch/riscv/kvm/vcpu_pmu.c
> > @@ -435,8 +435,10 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long s
> >         }
> >
> >         kvpmu->sdata = kzalloc(snapshot_area_size, GFP_ATOMIC);
> > -       if (!kvpmu->sdata)
> > -               return -ENOMEM;
> > +       if (!kvpmu->sdata) {
> > +               sbiret = SBI_ERR_FAILURE;
> > +               goto out;
> > +       }
> >
> >         /* No need to check writable slot explicitly as kvm_vcpu_write_guest does it internally */
> >         if (kvm_vcpu_write_guest(vcpu, saddr, kvpmu->sdata, snapshot_area_size)) {
> > @@ -480,8 +482,10 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low
> >         }
> >
> >         einfo = kzalloc(shmem_size, GFP_KERNEL);
> > -       if (!einfo)
> > -               return -ENOMEM;
> > +       if (!einfo) {
> > +               ret = SBI_ERR_FAILURE;
> > +               goto out;
> > +       }
> >
> >         ret = kvm_vcpu_read_guest(vcpu, shmem, einfo, shmem_size);
> >         if (ret) {
> > --
> > 2.43.0
> >
