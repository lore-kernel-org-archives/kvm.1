Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583783CB561
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 21:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791581734; cv=none; b=gChLRYKBIBlWbQCUKuRK2oGh/8N9cCiYfPl3iNeZ0BeMeWr03lRSL1HJAHfZ8KC2l70KWl/0CjwW2ozf5hmRR2d5cK7OsfXI7WCnX4DeSiEAIxIPyzabfbM4dLB2+WmHTaQKW74tkPPQC9Hx+iOuUxxLzZezXgK0tUeP+Q9XxeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791581734; c=relaxed/simple;
	bh=2RxPfUSD7JXq22WLhThn54N+05jAje/3xk6YO0LcdCo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DMIajQZuSVXkk2sfojWv2YbzdWo+57c2Hc7ctnT7O8aPLaJ/TWxELbPUAPJcS4IntcZMc5kQ50dEzuh4Y+A17SoHHlp1dYyM2y8tRT72158gBNgaNGZ0SMJeDwSPFBlrZyJd/1qDVXzYCRd9HZ8z8vw3fOsLdlzhEjwvgkEPQD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTx6I6GF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5QWCP8Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTx6I6GF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5QWCP8Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791581732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7qrnbWCiEvCZxzwHJXj+vDALX5giaXNbTIm72EEdEPc=;
	b=aTx6I6GFpRvd7ZVkj+GK5NroVWREcnWWPe25B8f2lByfGQE1ruMo/WVDZaQ7EojAWWx8JB
	4RMUocRmXbSOC1/j//o1emSBtUvdmDCWcZEM/vYj1uzoN7+JKXFDFttgHw+O/khEPkM+en
	XFV0bCSta/WIY1uW3kCMfIRTNA55BZ0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-28EiF0SZMbq_YbHzhHAaeQ-1; Fri, 9 Oct 2026 21:35:24 +0000
X-MC-Unique: 28EiF0SZMbq_YbHzhHAaeQ-1
X-Mimecast-MFC-AGG-ID: 28EiF0SZMbq_YbHzhHAaeQ_1791581724
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-9197553d398so6219326d6.1
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 14:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791581724; x=1792186524; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7qrnbWCiEvCZxzwHJXj+vDALX5giaXNbTIm72EEdEPc=;
        b=K5QWCP8QtaW16X0cQOl3iKICw4qhMKJC1WBN9kGMVkZoP/3KWrglvJcvz9eenQLpDe
         FlUgesTOlIePZUEr6zqeiztdhLfZIqC0wBXuqxUB8VcUQaB2o1lyu/ta0iAQ5/UuAaSn
         9wncILaj+sjdftVgXhHcq1EeFtSuhbD6Mqa5mQPDTn4Wt6SUClsUeW9xi5lReioYKXFz
         3CwG8U/nwB1CG6Naent+1qaKH4xZVPQ0BHIRoAVwxEvYhfMlhhbirTtSRZn3ncnmV5kd
         QZKR/BceMRfPqVV5PDedgkAWgf7w33uERlBtEtwMUNeS0cQk37ZTP5Te+Albi8jfU7ur
         7/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791581724; x=1792186524;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7qrnbWCiEvCZxzwHJXj+vDALX5giaXNbTIm72EEdEPc=;
        b=IpyoOOXrRrFLvpVfWz0wbvjrypWqZGs9j725wkVOXb//F4fLpuGuh5ajJzmS0IeyCU
         eaNy9RihQ1Dpx/GYv/1t0kKp+nXuJTGG4KAPRNAymdHbgOKJGIDc07VHg525gcS1oiRm
         Ryk/PRgOBaVaV+igTPEFzEOEmM7PD/SZV069MSR4KaRCYJUBSaZSwSvIIyaWp3mv6F5m
         QZjiiI0xgPEbNmhPTRt05dwegAeBomjRHYs13WFE/f6fNR1tFDRaR7WTJeJdsKTkm4bm
         fsW+IRAZQ7jkORZNN/S8gyS62KnVfVj3SSNsGBBLB562S6JFs7Ph2J2q1lIudbFRmOuD
         wn5w==
X-Gm-Message-State: AFq9FYJ2Lze+CQEch3qH6cled+cHM+8Gh9mZ6WPr6MQJcaneN/3I3i07
	Nq5zakZ9RhXcnAop5XNSMz2Mr0Xc1enjP3mOUe1QkJTZD4jWthW/18j/K9fLfilUgJsZ6/3zfqi
	fUU1dofR5+HPPUjHDjrMquwhVJw7a8RKMYjTv1pzD4P4crtTla7tykCb1E3oD2w==
X-Gm-Gg: AYBFou0dMDI7w4nt+3G99ljbYl9J036qqqPs6s3lxENC/HztRNK2AKXZsLj0bPbdhLA
	xRL5X5+iGlUPDwrrzvPpdzvsE15o3O9FLeQsOLALJYE/BI7OE18SXWjQaoe7BETerybM413KX7f
	FsxiIK0aE3NzbsdTpDdU9RRGBI+rsOvGWX7KN7Cq2VJP+4N+IT36hSWL8FOI5OI35ztM3lcL95l
	g6ZYNN+olL6fkdo3rlnalnFzM7ZBZrzOaNNxi+SSdhc09xKYjJoMvBk4aumnjBK87Gdmv+WSnQm
	W8f6I2Yh4iHkMFBOWM7yFwttUzAcpu/NRe9QKa5G7BpOmo+3ZmHuh8LIKG1toSL5YSZiDznPUr9
	18OZV0zUgKxy31UymWQhT55PzcXcwbGuPLY9cSLbXRGY2eL40pvmPTsSy4VSuwMjLWK0CScKLyI
	EaL+ealXhQ
X-Received: by 2002:a05:6214:5f0a:b0:919:867b:5215 with SMTP id 6a1803df08f44-91b55334746mr52189946d6.3.1791581724235;
        Fri, 09 Oct 2026 14:35:24 -0700 (PDT)
X-Received: by 2002:a05:6214:5f0a:b0:919:867b:5215 with SMTP id 6a1803df08f44-91b55334746mr52189576d6.3.1791581723628;
        Fri, 09 Oct 2026 14:35:23 -0700 (PDT)
Received: from mlevitsk-thinkpadt14gen3.ibmmarkh.csb (pool-173-33-204-162.cpe.net.cable.rogers.com. [173.33.204.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550e177csm28434456d6.47.2026.10.09.14.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:35:23 -0700 (PDT)
Message-ID: <c1eac67937b1f625a251e910f3b85000bf7a7504.camel@redhat.com>
Subject: Re: [PATCH 1/2] KVM: nVMX: don't check PIR.ON when processing
 nested posted interrupts
From: "mlevitsk@redhat.com" <mlevitsk@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Date: Fri, 09 Oct 2026 17:35:22 -0400
In-Reply-To: <sashiko-outbox-166078@kernel.org>
References: <20261009205036.672523-1-mlevitsk@redhat.com>
	 <20261009205036.672523-2-mlevitsk@redhat.com>
	 <sashiko-outbox-166078@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-10-09 at 21:04 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] kvm: spurious vector 255 injected due to TOCTOU race in PIR upda=
te
> - [High] KVM: nVMX: missing compiler barrier after pi_clear_on() leads to=
 lost L2 interrupts
> --
>=20
> commit 3c2cccabb927f653f71a7a79b1d1600d4fb5f728
> Author: Maxim Levitsky <mlevitsk@redhat.com>
>=20
> =C2=A0=C2=A0=C2=A0 KVM: nVMX: don't check PIR.ON when processing nested p=
osted interrupts
>=20
> This commit modifies nested posted interrupt processing to no longer requ=
ire
> the PIR.ON bit to be set. It achieves this by replacing the conditional
> pi_test_and_clear_on() check with a direct pi_clear_on() call.
>=20
> > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > index ddf6df7bee93b..11362aad2bc8a 100644
> > --- a/arch/x86/kvm/vmx/nested.c
> > +++ b/arch/x86/kvm/vmx/nested.c
> > @@ -4033,8 +4033,11 @@ static int vmx_complete_nested_posted_interrupt(=
struct kvm_vcpu *vcpu)
> > =C2=A0
> > =C2=A0	vmx->nested.pi_pending =3D false;
> > =C2=A0
> > -	if (!pi_test_and_clear_on(vmx->nested.pi_desc))
> > -		return 0;
> > +	/*
> > +	 * Don't test the value of PID.ON.
> > +	 * It is valid to trigger a posted interrupt without setting this bit
> > +	 */
> > +	pi_clear_on(vmx->nested.pi_desc);
>=20
> [Severity: High]
> Does this change introduce a missing compiler barrier that could result
> in lost L2 interrupts?

>=20
> Replacing pi_test_and_clear_on() (which uses test_and_clear_bit(),
> providing a full memory and compiler barrier) with pi_clear_on() (which
> uses clear_bit()) removes the implicit compiler barrier. On x86,
> clear_bit() uses inline assembly without a memory clobber, providing
> no compiler barrier.

Yes, this makes sense, I will fix.

>=20
> Without an explicit smp_mb__after_atomic(), could the compiler reorder th=
e
> earlier vmx->nested.pi_pending =3D false store to after the ON bit is
> cleared?
>=20
> If reordered, the CPU could execute the PIR read inside
> pi_find_highest_vector() before committing the pi_pending =3D false store=
.
> If a concurrent software IPI triggers
> vmx_deliver_nested_posted_interrupt() on another CPU during this window:
>=20
> - It will set the new PIR bit.
> - It will set the ON bit.
> - It will assert vmx->nested.pi_pending =3D true.
>=20
> The delayed pi_pending =3D false store would then silently overwrite the
> concurrent true signal. Since the PIR was already read prior to the new
> bit being set, KVM would miss and permanently lose the interrupt.
>=20
> > =C2=A0
> > =C2=A0	max_irr =3D pi_find_highest_vector(vmx->nested.pi_desc);
> > =C2=A0	if (max_irr > 0) {
>=20
> [ ... ]
>=20
> > =C2=A0		__kvm_apic_update_irr(vmx->nested.pi_desc->pir,
> > =C2=A0			vapic_page, &max_irr);
> > =C2=A0		status =3D vmcs_read16(GUEST_INTR_STATUS);
> > =C2=A0		if ((u8)max_irr > ((u8)status & 0xff)) {
> > =C2=A0			status &=3D ~0xff;
> > =C2=A0			status |=3D (u8)max_irr;
> > =C2=A0			vmcs_write16(GUEST_INTR_STATUS, status);
> > =C2=A0		}
>=20
> [Severity: High]
> Could this execution path erroneously inject a spurious interrupt vector
> 255 into the L2 guest?
>=20
> By removing the pi_test_and_clear_on() gate, the code now unconditionally
> falls through to __kvm_apic_update_irr() whenever max_irr > 0 and
> pi_pending is true.

This is true regardless if ON is set or not, guest can do the same with ON =
bit set.

>=20
> If an L1 guest concurrently modifies its PIR/IRR memory structures during
> L2 posted interrupt processing, clearing the PIR and IRR in guest memory,
> __kvm_apic_update_irr() can update max_irr to -1.
>=20
> When max_irr is -1, the code subsequently casts it to u8:
> ((u8)(-1) =3D=3D 255)
>=20
> Since 255 is typically greater than the current RVI, KVM would write 255
> to GUEST_INTR_STATUS. Can this cause L2 guest crashes or undefined
> behavior by injecting vector 255?

I guess if the L1 corrupts PIR and that crashes L2, it gets to keep the bot=
h pieces.
However here could be a pre-existing bug, I'll take a look later.

Best regards,
	Maxim Levitsky

