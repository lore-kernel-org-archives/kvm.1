Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500BF35AC0C
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410058; cv=none; b=cD8z7XTToPZxBiGKSAeSHlZlUAE01q+JYbY2J0XiHgOVWtJYV/9a3ey3RmyrSVjVgw1v96OXOMSjn9BZbcxnWQFWiz6WHOh16LUNfIVOg5IKxab2MAhSW/ViWZxjeokx24qVwXGu4OYLSVbBXHnxYhSEevrMoBPSJneyVuNsWvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410058; c=relaxed/simple;
	bh=61cr3ndLZXx3RwIlq22N0fmg1a7lTd8VZUV0j73FrJ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i/yB0epwjQ5WbaueoTL/xbQyKA8NJdC2qOJjz/DpCyvm62ooHCcfLPxiCJ5LNlpFnkBH2OFgyZOrJJAWd8LUJuqYhnuuwqmP3XHvIVkhuDxueN1rgLmKSeO/vdSH89KgPl5i1idypQzrG7uT47ikEzqo2gFQ4WmTVvP3+rGVZXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVVrBELh; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVVrBELh"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c331eda3so34101265ad.2
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780410056; x=1781014856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvSnhMCL5wsb7ip48leAGmiQMyVWAb5YtAjAkdm5aw0=;
        b=FVVrBELhTAYCI8eZcU1fMxWZG7AeHC/vC/5ygwqgq4wh9LXeckBQo7b/MsQrmMey56
         A+yP4vKmr4A+uuTdNENQKuLfHcRo8vWuXozr7jl3yx87iBZmxethoy/XpEy7v3AHDnBt
         AUu9MH8XuZDfWCopl0t0BuWgQQZch9edMu+0agGC+H7YHmyyvw2XnWYqTCM/fp3ePOKv
         LsEgGOZAngnlP5ZZ3BrV8mr4g12UWtti+fsUmiW9xoUjjo/gU60wtOllZvw7x78ggOT2
         9eaaqSv8HXF/70kT0MC3uLjveFzPcQmrUZuRwWsUiMCW4rJdRjDTFamG1+/QKcIaqNCz
         F8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410056; x=1781014856;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nvSnhMCL5wsb7ip48leAGmiQMyVWAb5YtAjAkdm5aw0=;
        b=XtaUV2+DTRMyjoxffDUH5M+9tyUhcvC2NXaQexUtCS1TvWZ6rd8F8dBu1HbWcFIRer
         +cGhmF6aUFYUIXS8NzpyN1SaKuxXK5yRZNU+Khw63WtOv8TnofrzagEaxxCG7Fy2MuSz
         fv0WQxVkntLRTuLGbR7rJq242F7rBJh9CikD61ysm4R1Tqn0R/E1uczsX0QhiASvZY5R
         Z3uY/i17p/BIJOvFlFVC5OhEo1wer/xkUpMutSk/BnbySk3WU3b18Fi1hWTWDvOY0rGa
         9zxGLUSM+jTrwb+/C6I6Kx6UFvrcK5N9DvvsvzoZvigKZRrH4Hn5tlPTZrxR3ZA7GiqP
         VhIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8CphBsXAVjyNjS6PRPlTnRo19IDU2yJAzHSb9zCcbL3/W0N1Nzd9NgPKCj1YrXZE16gI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3+zb2QjJ2d3KEq5JVJQD6urSlShOvxFK1d01J743A+LWdXRUP
	4BebfrelKmZNjsPwuoaJ9sdQU6sM34LU863DD/ZOOi1ooro4/3/0lzxAi3/3uk9YR4yHjMB1Xz+
	6jqnWrg==
X-Received: from plbkp13.prod.google.com ([2002:a17:903:280d:b0:2b7:c361:c75c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf4c:b0:2c0:bd28:bed5
 with SMTP id d9443c01a7336-2c0bd28c19emr127646515ad.10.1780410056281; Tue, 02
 Jun 2026 07:20:56 -0700 (PDT)
Date: Tue, 2 Jun 2026 07:20:54 -0700
In-Reply-To: <fe9d441a-91b1-4084-8e1c-71813c3c8bb2@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528071712.1407929-1-xiaoyao.li@intel.com>
 <ahg8i_Zv9TRk-UzE@google.com> <7987e722-4ee3-4d6c-a4b7-369cfd272dac@intel.com>
 <fe9d441a-91b1-4084-8e1c-71813c3c8bb2@intel.com>
Message-ID: <ah7mxim83BLuF-Ia@google.com>
Subject: Re: [kvm-unit-tests PATCH] x86/run: Use separate "-accel" option to
 configure the accelerator
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2026, Xiaoyao Li wrote:
> On 5/29/2026 8:09 AM, Xiaoyao Li wrote:
> > On 5/28/2026 9:00 PM, Sean Christopherson wrote:
> > > On Thu, May 28, 2026, Xiaoyao Li wrote:
> > > > When configuring accelerator via machine's "accel" property, it can=
not
> > > > pass additional ACCEL_PROPS. For example, it hits following error w=
hen
> > > > configuring KVM with "notify-vmexit":
> > > >=20
> > > > =C2=A0=C2=A0 # ACCEL=3D"kvm,notify-vmexit=3Dinternal-error" ./x86-r=
un x86/apic.c
> > > > =C2=A0=C2=A0 #=C2=A0=C2=A0 qemu-system-x86_64: Property
> > > > 'pc-i440fx-11.1-machine.notify- vmexit' not found
> > > >=20
> > > > Switch to use separate "-accel" option to configure the accelerator=
.
> > > >=20
> > > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > ---
> > > > =C2=A0 x86/run | 2 +-
> > > > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/x86/run b/x86/run
> > > > index dd38f14c871f..a68d469dd1b8 100755
> > > > --- a/x86/run
> > > > +++ b/x86/run
> > > > @@ -43,7 +43,7 @@ fi
> > > > =C2=A0 pit=3D"-global kvm-pit.lost_tick_policy=3Ddiscard"
> > > > =C2=A0 command=3D"${qemu} --no-reboot -nodefaults $pit $pc_testdev
> > > > -display none -serial stdio $pci_testdev"
> > > > -command+=3D" -machine accel=3D$ACCEL$ACCEL_PROPS"
> > > > +command+=3D" -accel $ACCEL$ACCEL_PROPS"
> > >=20
> > > This breaks my setup for specifying kernel_irqchip=3Dsplit.
> > >=20
> > > =C2=A0=C2=A0 qemu: -accel kvm,kernel_irqchip=3Dsplit: Property 'kvm-
> > > accel.kernel_irqchip' not found
> >=20
> > If you switch "kernel_irqchip" to "kernel-irqchip", it should work agai=
n.
> >=20
> > This needs to be fixed on QEMU side. I'll look at it.
>=20
> Well, I feel hard to justify a QEMU "fix" for it.
>=20
> "kernel_irqchip" was a property of "machine" in old QEMU, and QEMU switch=
ed
> it to "kernel-irqchip" automatically.
>=20
> Then QEMU moved it to be a property of "accel", while keeping the
> compatibility when users configure it via "machine" that QEMU internally
> setting it to accel's property in this case.
>=20
> However, "kernel_irqchip" is only valid on "machine", but not on "accel".
>=20
> For this KVM unit test issue, do we need to add workaround to keep your
> (work-by-accident) usage working? or just kill it?

Nah, just switch to "accel" and call it good.  I'm likely the one and only =
user
of kernel_irqchip.
