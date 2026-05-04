Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA723DCDB6
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777917550; cv=none; b=m30J0UF71Jg2WsFjSg+A2ufmP5SDu9FAFllXOOBp9kMc1CaQyUp4wj8mXoggrg4oO3NV5wWknT6IR9UNoWkBS+stkUAyOw3lvbDuSh/fBPJrDpMu2nRB9rlotPiTN8s/CctbxVaL6k4NsuYpIOf51WdvirbvG7q4WJLuEsJzJ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777917550; c=relaxed/simple;
	bh=1IqJvmzII7/T39MzvKNBERzTIiEA/ExVEQqrmFi4W5I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e0ZSPWPipX4lbpr/WjOIBLSjCs7QOVAYq8BfclTt/AJu32Ljio3a7yIIcK21Cx7Qixdofkt9PCN8yb0Evdt1TPzPIGIceQ94RXo7I9UKsgFV0qRiXJlsWdgxRQ65wuBCd6kwiYk65Hy4WIF7d2R8iSlklDOIH7L6fmPxh3QRiM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+eFMwoX; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+eFMwoX"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa2165c3eso3055233b3a.0
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777917549; x=1778522349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkucIX59KTNPBaVai4FthTKe5zTpFdhn5FHJDfPK5ao=;
        b=N+eFMwoXxgt8jiu1JI0ibHDGvQMB30SwtW54St1UX5hkRMSv6uUayt6tBdpfC2n2P2
         BAI9tAC5OI4lrrTxpo+eg4w5K4ECulrhM3mek/9jucUrK+t79W9hfQky8FdpqXjpKJOQ
         TYsaLK73UX9MTGE2ZEnY/1n5havNOpKocRjOdph+y4AttcR5lON0QrQhLPdg4RILvnTu
         Wg6d5tdvUzR3SqlhBHRDPHrszOXFpQNQPd0sMzANzGuX3LUSIFsJgR2z+0WygP50jJOT
         dCcn+EEaA8BtCCaVdkaq/J7mjBXTmrEyYLP2qdClsCrSaQj2OcT1gAxAhSL3+xw0q0Kc
         +EBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777917549; x=1778522349;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zkucIX59KTNPBaVai4FthTKe5zTpFdhn5FHJDfPK5ao=;
        b=F8JRDYq/7LLHV2B+gR7wrvoL7SBxcY4LGfC9q+CvbWY1jMcbe+PrWVuLxxCIOxaDf+
         6v3OkB5nQSLoMxBTbSU02ni2c3uyYAjKGxDOz/+Xa3irMhVPRfNHKupylphBuXUssayV
         k4wQ8SNogXpbkSuVPRnVMRMy1994Z/ujkKNK7YZ2M1nu6nLEukreZ23y6wjdspy1NhPH
         a4k9w8DD4Wevot6CRw8fJxx6QJgrPjRNzhhhD1XLBgq2tcXiPItXYPULrs0yNDCSuYDQ
         M/490wshpNxuhkQ2djKWKJUqIBIaVre0MN5N54oVla5q31VZbXrM1nhvbVKbD4hSAc3j
         DXYA==
X-Forwarded-Encrypted: i=1; AFNElJ9teqlvoYZldlUy4Ny6DEswI35lDJTRMiV8/crviMhwr8IfD5MWQJXWdi6V0KmJ7+uRk+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZRTg6Yi53E+w8QZcMcp3v9f8J3Zep4wnqti5vCU0EXhF508uZ
	qvVQWawVacegMN2zdYZwIREWwkKhfWmptp5PuS0ypMu4bzR0sCae5SCwmxqTSebbWy+OHp2gSQr
	MY4c6fQ==
X-Received: from pfoo26.prod.google.com ([2002:a05:6a00:1a1a:b0:82f:b388:7a9e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a489:b0:835:685b:8e31
 with SMTP id d2e1a72fcca58-835685b9161mr6298997b3a.25.1777917548420; Mon, 04
 May 2026 10:59:08 -0700 (PDT)
Date: Mon, 4 May 2026 10:59:06 -0700
In-Reply-To: <20260427080554.GD1733452@pedri>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <c2fad21764d2561469151f5dd5d35833ae8f76e6.camel@infradead.org> <20260427080554.GD1733452@pedri>
Message-ID: <afjeahNaSG0zsMgx@google.com>
Subject: Re: [PATCH v2 0/3] KVM: Fix and clean up kvm_vcpu_map[_readonly]() usages
From: Sean Christopherson <seanjc@google.com>
To: Peter Fang <peter.fang@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Fred Griffoul <fgriffo@amazon.com>, Yosry Ahmed <yosry@kernel.org>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026, Peter Fang wrote:
> On Fri, Apr 24, 2026 at 11:27:03AM +0100, David Woodhouse wrote:
> >=20
> > Fred is already removing all the usage of kvm_vcpu_map() in nested VMX=
=C2=B9
> > and nested SVM probably wants the same treatment. And the PowerPC one
> > looks like it could just as easily operate on the userspace address?=20
> >=20
> > Could we just kill kvm_vcpu_map() completely?

Yeah, that's probably for the best in the long run.

> Thanks David!
>=20
> I think I'd need at least input from the maintainers on this but just by
> code inspection, the kvm_vcpu_map() usage in sev.c seems a bit tricky.
> Unmapping doesn't happen until right before switching to the guest, so
> this might fall into the "keep the mapping around for a longer time"
> category [1].

It definitely falls into that category.  But that code is also rather gross=
, i.e.
could use some cleanup no matter what, so I don't think it's a good argumen=
t for
keeping kvm_vcpu_map() around.

To avoid a bunch of pointless work and churn, let's hold off on hardening a=
nd/or
renaming kvm_vcpu_map() for now.  I'll take this v2 as-is; even though taki=
ng a
gpa instead of a gfn will conflict with the nVMX series, it's dead simple a=
nd a
worthwhile cleanup even if some of the conversions get discarded shortly af=
ter.
