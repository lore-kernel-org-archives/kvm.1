Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E06C2BEC5E
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 03:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777607448; cv=pass; b=hpVMtVJKm09nbFAcoiMAZL4PyKGNiuuT5sRoqOaBOck6jmvbrLOw0qyppcvgOMmVA1kuCnSTcu6NvLCfUaDh69KZ4iYM2OPmVwiVDtm6QOU3wyoUaSKlHnbWGiRAn+aVd6KDBaxQ+MMppxGvJhdZoSyRbVW6eTJS0dyYZaQcS6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777607448; c=relaxed/simple;
	bh=TnGUat4Y36HQRS+ZM3cf/6THQgU46V/qR5SsJSI9+dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rikSrGoPybYl9H17/Hg338gnqMraiW9iWyuglx2t6wPqKPklkyshDPH48AjnazuM6XmeU1itZywChkmCuArwIii6I+8sVXMt4r9GS8m3D7bC1zDyjKbIh8DZZnlZbw4PURxppxw4IUZqhEOFsGBbLRKiUIVZh4KTDYeeJ/fEjkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fv6/jROy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mxOfqWqk; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fv6/jROy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mxOfqWqk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777607445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjfLQJppvPaaYp6l8PobV3YhJrwQYLkitEM0mnrvyFk=;
	b=Fv6/jROyzL7tM4SNAH/gQkuEgUm97Bq+PcT6jcM8m/up3SCe7nRBj2n0LIzUmAUzKeF3kc
	Kk5xPWfQaMtwlI0A89DcOgxDzCNSOc/qtR4dJfUfDKeLTCWMiLrPu/m8lU1evH4NkkvMt5
	R0m/wOaZX88rmlE2KacnUa2qB9oaAi0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-aUpAGyH4NNywN3A1kLfiqQ-1; Thu, 30 Apr 2026 23:50:40 -0400
X-MC-Unique: aUpAGyH4NNywN3A1kLfiqQ-1
X-Mimecast-MFC-AGG-ID: aUpAGyH4NNywN3A1kLfiqQ_1777607436
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43cfedb10a8so916624f8f.1
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 20:50:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777607434; cv=none;
        d=google.com; s=arc-20240605;
        b=IzGtWhDLTaKy1p2txIXsBQU3cpDnnZoaGgeLYhlNZQyRBBRnGNy585SI1vQ3Om5JVz
         9ectJ5Dfm42IGxj+X60wgfrTC6dmTGn0liJXQLQfQinMyeUxZXXS6P+Fz50jKe6SuZTO
         P2G4O70SKYyPGKmhDuRronV9u7rB6kIeqG7/BPfcu+dxoWOO8NLs03ypm0HIKnpOx/f8
         Hk7mM8UDOoSCUNTx5eDtAMwdkllQ1ylpdm4mix8rYxRzMx8PIJNQhpXeAOCTSnZbDq8D
         432Wi64NmZB9nOucdc58Brz0ADEka+4K6oyP8oyBGts7Z/aaqaSUHCkzjKvrNywVpS/4
         6j1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qjfLQJppvPaaYp6l8PobV3YhJrwQYLkitEM0mnrvyFk=;
        fh=M0NvJMho9UjKmNfyuvaXBMW6nbqHnvGjN2bPBpCtyd4=;
        b=MEl7OOum0AX58HfwNM0p6iizn0DsaPcKU+wJA7M9WPDQauJym6uXx/YanVCkF2T2Ot
         OpTb3PIgad/3AUc8M+Sw/EaOoGLcnjuiQPq4ShPe4PhnkHLW6M48Cru1Uiu2gs6UOPc8
         AkrIgN3AnatUUJ7TTujuidfa+qDuHy39y6iyCTds7owwdYvfcBGpWAPMwfD/UjkyQ1BG
         xM+AecSmTpmjC/zr36dEjwkvQ926lin5TkDH9yCMMRBuogxhFT+LtmZ2kao47CW/qBJA
         1UjmKN2jhDtplJ0kKMh8Z+HNwi+HPaTtHFjPglP0l/sSQjPsUbtR+tUM/yyIjdd6EnWi
         gNhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777607434; x=1778212234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjfLQJppvPaaYp6l8PobV3YhJrwQYLkitEM0mnrvyFk=;
        b=mxOfqWqkjUrRTYvOSbWYuIkkiNQH4Vs4Yh1Bo4kdjvP5SKwsXUkGeB/6+H6o/RW/sb
         jOaHXGSDutgehU2ogd4MjVvhZbIoRNOWn1hFu+7eqxhbU+2OJ8/izmdiJudO4oXBTow2
         px24GbaGPPh9Z6wPYYoK3CIGHty0WK71TYjipi0wnJM3x01fXvzq+wcKxt64pW0NRMt/
         jCK2k4WqB6ZVDyxcpRHrMPYjDgKXcap/lcdTklBv6lx/TRiH+16CsfO8odiC5VPDJh8j
         aNG9/haiTvgr4A2AEVBwY+NABez10zVVJtHWgkDl2oLtx2dOiw5uIq0f8xX9JiT30xRm
         AF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777607434; x=1778212234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qjfLQJppvPaaYp6l8PobV3YhJrwQYLkitEM0mnrvyFk=;
        b=quuHJi7BhhXnwjn9XLxrgliW+xiO442AWHneHzi6sr6WvZpR+7y8GjSLEQURYHSfHZ
         3rBdiD0vaIzTWsfs3Jv8/yoXC8VIuOmSEbrm7qOrEQYpWDCtRJ4/7JHqrIh9fUYp+V1n
         pfD4X5w/pB7mDCfy/uDfgc+zHG6d/t8Sy+LJCZ8V4bVPCcS0RwkfX+98NgepH+HmKyku
         3fo02iceVHib+B+jJOVXp7q50UoEQZdHUY3szBiJFCuHsI7khtiEj3X0tg0WWnaBizwq
         xXHRja+x3jHid1Q/kf+RiaYH2rT2Yfb/8EhqI9uDrN1xeO2RA9fi6T2IhVGi8saCUkhf
         tyCA==
X-Forwarded-Encrypted: i=1; AFNElJ+B+w3L8M3M4S606Uj6NxAM5sGKag2oQgvoElI/I+RxZMez50XkBSIN9zI2drtOmbeXP2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh/qGMHM9mN4ZeX+rAPuUVISQSy8xGRKhTPlqcOc2sko+CYFIh
	ZioN5oM+KdA3Wf53fidIerINh3Vj/fNPhE0+q9DpNn5CEVMVlfY7pcDyiHm1FKX4ej55Khwo73i
	kF6CRfvuHIm4d6t8QGdUXsfTzdUSHxoD9S0aUbBTAl0VssN0zwdxClRuzuoPMjTXWlLmdv64luq
	raz5Z96iB5cYJ320fNZGKYXJJDCymgqHK8ufTV
X-Gm-Gg: AeBDievCy+xB44O0KxhU3j62CizagEIQoZHv8IsFfJudI1iIrcY6eU0nXahTmOseRjv
	LWMKCjHy4AzbydMh2uwE8ls5zqwS+vmtKW1EdciuyhyeT03j5/X+6TG4DYD0eTvumxJUOxCrjBQ
	LUnldT24gKs0EBJFZ+XTfgYRWLZe0niBGUkevigKiTbXdhZlH2JHasny2nR/No7ibndz/zdn4UN
	JJ6YNEyIjaZb/MWuOBmvFczSvc/lYhklVFPDrLuvdfsrobzpb1chTgvWxU22wDyrJfm7uLB/Lqn
	fkOBEs8rxKH1KWo=
X-Received: by 2002:a05:6000:2585:b0:448:5ec1:dcb5 with SMTP id ffacd0b85a97d-4493c3821f1mr9061123f8f.7.1777607434482;
        Thu, 30 Apr 2026 20:50:34 -0700 (PDT)
X-Received: by 2002:a05:6000:2585:b0:448:5ec1:dcb5 with SMTP id
 ffacd0b85a97d-4493c3821f1mr9061104f8f.7.1777607434179; Thu, 30 Apr 2026
 20:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430150747.76749-1-pbonzini@redhat.com> <20260430150747.76749-25-pbonzini@redhat.com>
 <afOo4xvnIJn_FvSx@google.com>
In-Reply-To: <afOo4xvnIJn_FvSx@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 1 May 2026 05:50:22 +0200
X-Gm-Features: AVHnY4LN7LTeJllEZOh4ohjqiI3guvh8nYhllZle5Yc_w262pQhCvNHrtRILYpY
Message-ID: <CABgObfYXLPtp=DauQkRaD98XPBowzr0bPdqd1cCgHt1cZk9xWw@mail.gmail.com>
Subject: Re: [PATCH 24/28] KVM: x86/mmu: hard code more bits in kvm_init_shadow_npt_mmu
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 9:09=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Apr 30, 2026, Paolo Bonzini wrote:
> > Likewise, clear X86_CR4_SMAP to avoid that KVM erroneously faults on
> > supervisor accesses to an U=3D1 page.
>
> What, don't you want to more closely follow real hardware?  :-D

Uh, I cannot parse this. Is there an errata I don't know about?

Paolo

