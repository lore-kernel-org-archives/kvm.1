Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440058;
	b=jybWQPiNbquqMgztB1HPHFsyHdd1fteP6QEc1XuX0eyqssqmuQ3Ad7qL0BwGtUWg/Age
	 uJophn9S4oxwcSknJGACj4ctBtAWa8U8N3AUdjf2snpQdik2JHgM16w4rNISk/odRW3EG
	 X3cci4r4p0M6sELbVpiCvsynKsVJ4UuKF5AWRIzm3RT3cDmqJVRWaJVarcra5UMS/OwN1
	 PP3Av1/wQ35H2gl69PLYZolWupYtGGCAZB3MD1jxUcZeKNZQJGS3BczOLVy5XSy83sBVW
	 ALB/JLfhgE3QToncYfb1cq7uzg8GC2ELLGpWZOYF3aErh9S4GtcfW9XmQULDlBiA+Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440058;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=m8+Us3U2Pncbjo77qvwp3S+xeyIDBlursH67bOY+7p8=;
	b=Yx/UInBRK+epCQNlIOLmyuH6GB09LS0skvBOPYdwfC/FFCTgXetq4mHq5Y0KTbMYBsYK
	 fb8OQfB3zIIeM1XWSWp7loS5RGSxRPNBTjjRgm6OvcylZzHr1UwWSU8CTD9KH8EZYuwVj
	 GMmuHr4MtMnbtRls2O6IHxqQda3e5yTI0i5Pt6cXeAhGEuqoLqHEt4f7Iicgk59WTOBMs
	 amTuycZNisc7a6EzknC9kf+00QauYi5eKMdh12skYTFa10pa6Rofv8YK2FFuES/C9/FDg
	 7xavrYckZBbY6gG0HYolykg+S+NX1z/roybsawSkWMUwHw+WVj7gB5yBBUb7NlqYQLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FoQWat5L;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66D3606A31D
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 20:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B66D3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FoQWat5L
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so2160171a91.3
        for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 13:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792440057; x=1793044857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m8+Us3U2Pncbjo77qvwp3S+xeyIDBlursH67bOY+7p8=;
        b=FoQWat5L/hFCnOMKQLsHoQZNnqb6DKn8b4TrjEsjJAddTaDOgKzMx9qZKYXKYv45VH
         4Tt1AFq/vL9g9fXOtvqCcL5qXYPOZM6fwrAKpFn446iKU4AGQBtdxQ30eB9ANNwAafGI
         j8t7SgDoBOIduouw9rhxkeEJNC7Npb1feHpEm9FFvHSA4HsFnbz73210OCmn9AWAgCcm
         HYwJelvaV4KeXrPDdPMNbereNkQtIo6IyG5wrW7mVJh7fzcCBXugT3DtvcjDZ1POqIyw
         ote8LrKCgsV7JtmUqHAFtJ3BbjYeF4X3LwfTDDSa49WR0oWzCY/NnEuhk09+WGqvIeWz
         WIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440057; x=1793044857;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m8+Us3U2Pncbjo77qvwp3S+xeyIDBlursH67bOY+7p8=;
        b=AJT2JnxgivxIPwVCK5yoe0gTsxWpWJbrtJyHdk+o9f0ON0HTDR1B3Ff/aSNn7hrhVO
         gifGJBrl8hd4IXGXu+OXE2zot0aGSpRNqVStioch/dC7wNIHqgsy+Su4JfOlscr4wEVk
         Oaz7FYlwTdZlEaAdX9OySy4LUDjFgCNwENDB2wOt28RjO9UgTpOGM1li05ogIoyc80Y8
         HwAhnAyDyc99quKR47Uark84k7FCD18Yx1+rf9vzX1E8+O8U1kFaFRm4TbY3TEDzd1mt
         cW/OpAwlltIRS5tYn6Seps51T1vHGZuYVPZjPSMB7IVSMdJkB0T5ARZS1mEAenFdXtIe
         yFIA==
X-Forwarded-Encrypted: i=1; AKwUvBw0yqmCPlw8UB8y/SWaW+yJO+flqCgfZR/UZZ+4PBgAXBWTIy15IKKS8WybmxfE9+bzLB8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLAPccP8VaFaTv9psEWpntko502s1DveU14cVLjqQ+skOIztkQK
	J2mvlwwQ0LsanbexDo1iEeOvzj/H6LxdmWl4vE1xfWUv2bdKT85Pz+VunLmqdsyTmkM=
X-Gm-Gg: AYBFou0kaUaPs1nNqDqbK1CMq27t2Ar9ZrJPMin7eO0p02IvkoPq47VccBzK4A0L1WC
	YYDYLEdih8bWYMKE7mgtt7hkSaTHLBflL0kWOZPHC/uM2gzfyivgI2GxYpyyLmg4d6lM9Gb1KUt
	sLC22fZnSlGgH2o3qJud8uRNC2QhsP6dqeBR4ffNsqa0wOp09UlJuAHicQHtGd97MvNc0SybpkH
	Xdr9eM7qWGoCU88NPaglfH1pkZAPUOFVo39sHylZHFFjRFa+n7IW78aZuiw1da7AbxldiGNHhgJ
	F0HcJHLx4of21WcpzZX2K3Lfg2DHBB9XcaYu/OgJN1LSjpR5DdNMMIpc52k5N+NTHtSYaqHO/sS
	YgbRkruT0eVd4nCzCOJi7TfIRTNylu0Xq3xBOpTeje7ytVS+ZHInVLT5gwFJWxhGwMk6yqr6spl
	FIugwOuiuQ7HScqZUjqroZfNTtNH/6tF4VHiZ3aj9UD7DCOB6qe0tWJMaFoI5KucjMPqYdI1+ck
	Q==
X-Received: by 2002:a17:90a:6082:b0:3ac:ffb8:183b with SMTP id 98e67ed59e1d1-3acffb826b6mr3745980a91.51.1792440056725;
        Mon, 19 Oct 2026 13:00:56 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:5410:6440:73bf:119f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad60f90a6bsm647159a91.13.2026.10.19.13.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:00:55 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:00:52 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: Re: [RFC v4 17/24] hw/arm/virt: Reserve one bit of guest physical
 address for RME
Message-ID: <atZ29B8xDwCoH6kF@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-18-mathieu.poirier@linaro.org>
 <e6fdb508-0036-4581-9c91-bbf74de1e0e5@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6fdb508-0036-4581-9c91-bbf74de1e0e5@redhat.com>

On Fri, Oct 02, 2026 at 02:19:11PM +1000, Gavin Shan wrote:
> On 9/4/26 5:36 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > When RME is enabled, the upper GPA bit is used to distinguish protected
> > from unprotected addresses. Reserve it when setting up the guest memory
> > map.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   hw/arm/virt.c | 20 +++++++++++++++-----
> >   1 file changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 61751aa31e0d..cf3a9320dc3a 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -4054,17 +4054,27 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
> >   {
> >       VirtMachineState *vms = VIRT_MACHINE(ms);
> >       int max_vm_pa_size, requested_pa_size;
> > +    int rme_reserve_bit = 0;
> >       bool fixed_ipa;
> >       int vm_type;
> > -    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
> > -
> >       vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
> > +    if (vm_type) {
> > +        /*
> > +         * With RME, the upper GPA bit differentiates Realm from NS memory.
> > +         * Reserve the upper bit to ensure that highmem devices will fit.
> > +         */
> > +        rme_reserve_bit = 1;
> > +    }
> 
> "if (vm_type)" are mapped to any VM types other than KVM_VM_TYPE_ARM_NORMAL, meaning
> it can be PKVM in theory. So this would be:
> 
>        if (vm_type == KVM_VM_TYPE_ARM_REALM) {
>            ...
>        }

I agree.

> 
> > +
> > +    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa) -
> > +                     rme_reserve_bit;
> > +
> >       /* we freeze the memory map to compute the highest gpa */
> >       virt_set_memmap(vms, max_vm_pa_size);
> > -    requested_pa_size = 64 - clz64(vms->highest_gpa);
> > +    requested_pa_size = 64 - clz64(vms->highest_gpa) + rme_reserve_bit;
> >       /*
> >        * KVM requires the IPA size to be at least 32 bits.
> > @@ -4073,11 +4083,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
> >           requested_pa_size = 32;
> >       }
> > -    if (requested_pa_size > max_vm_pa_size) {
> > +    if (requested_pa_size > max_vm_pa_size + rme_reserve_bit) {
> >           error_report("-m and ,maxmem option values "
> >                        "require an IPA range (%d bits) larger than "
> >                        "the one supported by the host (%d bits)",
> > -                     requested_pa_size, max_vm_pa_size);
> > +                     requested_pa_size, max_vm_pa_size + rme_reserve_bit);
> >           return -1;
> >       }
> >       /*
> 
> Thanks,
> Gavin
> 
