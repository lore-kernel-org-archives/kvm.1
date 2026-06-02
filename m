Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA07175A98
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431732; cv=none; b=Y3Je/qWpaGU/uErjegsdWdzpzaDLo5u6nb93wqiE9CRbI9nWm/UmyvnGQatrFUtiGPuQZ8jZ5ZRJv7R5AEvmdpphT5sVb72BrmEQ67PwZ1+kv5vL9WMM8f267sYXutOOS7amTw3FHGTmI1NNySRcKIj43OmsFZMUGIs5OWle4nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431732; c=relaxed/simple;
	bh=09pPts/S+qG2EQmOU69lsHsyvL+j1EGZLwNE/bXDGxQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K6VLgEh47KFk1RPSM6EPR1qwdaq8cFpo7xQqk9xDZXAuWTkBRjgU4qFcuIQzkfAUloZFxwR4XmgSST4gGvTYlJGW97/u8E0itUaR/GHnApF5j6CUaKsmvST1NqnMq6ENFrhQ5v1hjIRVNhGg6kBDRxUpE/4VxfVVdmhEherq1Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gXWAHilF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXWAHilF"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0d0516ad7so30892695ad.0
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 13:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780431730; x=1781036530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8juMfY/540rb4l7Aiwif4ecZkPdMLTHbkQLXjM93ro=;
        b=gXWAHilFyloDCzhEoP4kiE9d+02VbW96M4XbEBzgXv+EmqoA8qD5OIOHonMo2SuMe1
         temJGOadBrKtwdsFKlqs26t80KB2l05Hg21DlEKXYGZCbKOeOXCPfDbe0e+8hsBuHT+W
         Vwy8ajQYkDE0puflgzEd3PmjlzQP6TSIVrDb38q4vRXbtEwT3T0AbP6vskjIIl4Vkh+E
         NIiS3fLbJ4i2ILxdrjRx2n9JC37c2OVqmbWxnyjtiDrRG3K/ZnY5ehRT5mWwolB2K30n
         umFLLxcXKr28TZ1E/YID7+fCr8firyURNJ7cQaZZgBOoWMJJoysv9qS04CYzeabRsDSF
         Kn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780431730; x=1781036530;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w8juMfY/540rb4l7Aiwif4ecZkPdMLTHbkQLXjM93ro=;
        b=oMlNHyIYrtvLqE9WCYPsouZeU7HlkHJnaKV/Kt+pFtmOZxJxh8HkjzqFO+2C20zlap
         YEPU3u/hEoCRuo0fOaybpyRzJJBJeG1ouDFi1WNKOsYZBri7Vv+jM3EXceKDaJmXLZGP
         k75NricpjrScSkwf0NnnCGqDlXsfH/BCug5GfqKxRlQWdyFbE1WfBRli9u+4TyQ/DCDY
         uX6f7sbBWT95mB4tRw9tAOHb4U0Rliv5g6jUw5N2f2ioZ9up6lUdInR2PW8kUqBVtGAI
         A2yp27L6EI5qFbhSW160m+5Z7jtvRXD/Vn9y2jk6R+iPoP09X2ZFJS6FiHQLtjfz/wxF
         Dp0A==
X-Forwarded-Encrypted: i=1; AFNElJ943fhlGGYxrEiYRTUyisoCoJ+w+msEXtPFA18MT0LUmoyBK5l/buO+sInXCnBqmWmrNQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3MXsjKrDW+MTH0IIA2VeYs18jilu3BvLYuKbr8SaJrLdAB3YW
	t5dMaU34TrOgCuyOpuuAAED6bLMOXCeMd6ODZMsk8NHezXFw6CYCjIjK0GTGIBPJgjrX4Kwmgeu
	n6rnTnQ==
X-Received: from plhz20.prod.google.com ([2002:a17:902:d9d4:b0:2b0:af76:bcc2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:a9cc:b0:2c0:c262:b919
 with SMTP id d9443c01a7336-2c1639ec947mr1978755ad.5.1780431729816; Tue, 02
 Jun 2026 13:22:09 -0700 (PDT)
Date: Tue, 2 Jun 2026 13:22:09 -0700
In-Reply-To: <ah7mxim83BLuF-Ia@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528071712.1407929-1-xiaoyao.li@intel.com>
 <ahg8i_Zv9TRk-UzE@google.com> <7987e722-4ee3-4d6c-a4b7-369cfd272dac@intel.com>
 <fe9d441a-91b1-4084-8e1c-71813c3c8bb2@intel.com> <ah7mxim83BLuF-Ia@google.com>
Message-ID: <ah87cbm6mxt0aWWk@google.com>
Subject: Re: [kvm-unit-tests PATCH] x86/run: Use separate "-accel" option to
 configure the accelerator
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2026, Sean Christopherson wrote:
> On Tue, Jun 02, 2026, Xiaoyao Li wrote:
> > On 5/29/2026 8:09 AM, Xiaoyao Li wrote:
> > > On 5/28/2026 9:00 PM, Sean Christopherson wrote:
> > > > On Thu, May 28, 2026, Xiaoyao Li wrote:
> > > > > When configuring accelerator via machine's "accel" property, it c=
annot
> > > > > pass additional ACCEL_PROPS. For example, it hits following error=
 when
> > > > > configuring KVM with "notify-vmexit":
> > > > >=20
> > > > > =C2=A0=C2=A0 # ACCEL=3D"kvm,notify-vmexit=3Dinternal-error" ./x86=
-run x86/apic.c
> > > > > =C2=A0=C2=A0 #=C2=A0=C2=A0 qemu-system-x86_64: Property
> > > > > 'pc-i440fx-11.1-machine.notify- vmexit' not found
> > > > >=20
> > > > > Switch to use separate "-accel" option to configure the accelerat=
or.
> > > > >=20
> > > > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > > ---
> > > > > =C2=A0 x86/run | 2 +-
> > > > > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/x86/run b/x86/run
> > > > > index dd38f14c871f..a68d469dd1b8 100755
> > > > > --- a/x86/run
> > > > > +++ b/x86/run
> > > > > @@ -43,7 +43,7 @@ fi
> > > > > =C2=A0 pit=3D"-global kvm-pit.lost_tick_policy=3Ddiscard"
> > > > > =C2=A0 command=3D"${qemu} --no-reboot -nodefaults $pit $pc_testde=
v
> > > > > -display none -serial stdio $pci_testdev"
> > > > > -command+=3D" -machine accel=3D$ACCEL$ACCEL_PROPS"
> > > > > +command+=3D" -accel $ACCEL$ACCEL_PROPS"
> > > >=20
> > > > This breaks my setup for specifying kernel_irqchip=3Dsplit.
> > > >=20
> > > > =C2=A0=C2=A0 qemu: -accel kvm,kernel_irqchip=3Dsplit: Property 'kvm=
-
> > > > accel.kernel_irqchip' not found
> > >=20
> > > If you switch "kernel_irqchip" to "kernel-irqchip", it should work ag=
ain.
> > >=20
> > > This needs to be fixed on QEMU side. I'll look at it.
> >=20
> > Well, I feel hard to justify a QEMU "fix" for it.
> >=20
> > "kernel_irqchip" was a property of "machine" in old QEMU, and QEMU swit=
ched
> > it to "kernel-irqchip" automatically.
> >=20
> > Then QEMU moved it to be a property of "accel", while keeping the
> > compatibility when users configure it via "machine" that QEMU internall=
y
> > setting it to accel's property in this case.
> >=20
> > However, "kernel_irqchip" is only valid on "machine", but not on "accel=
".
> >=20
> > For this KVM unit test issue, do we need to add workaround to keep your
> > (work-by-accident) usage working? or just kill it?
>=20
> Nah, just switch to "accel" and call it good.  I'm likely the one and onl=
y user
> of kernel_irqchip.

There's another problem: the CET and LAM tests force -enable-kvm:

  [cet]
  file =3D cet.flat
  arch =3D x86_64
  smp =3D 2
  qemu_params =3D -enable-kvm -m 2048 -cpu host

  [lam]
  file =3D lam.flat
  arch =3D x86_64
  qemu_params =3D -enable-kvm -cpu max

Which apparently is wired up to "-machine accel=3D" under the hood, because=
 they
get skipped with:

  SKIP cet (qemu: The -accel and "-machine accel=3D" options are incompatib=
le)
  SKIP lam (qemu: The -accel and "-machine accel=3D" options are incompatib=
le)

