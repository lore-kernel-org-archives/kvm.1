Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28610375F81
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117414; cv=none; b=CbQDH7V579UJZB9rTc2vUqfxA6bZ1wY/y0VRuSfMGT+2p5YWREVsURSvqe1A/KB/i46wsQTuaM6pU15jAh1ODpnnXV2Ds1w+e67L7gHTdo4kIE6WYh0wevFcDZ5Dc2aHzDJH97XEjEBzFCnfwmqFCOUhbsIbQqeWMZCwjPJ30zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117414; c=relaxed/simple;
	bh=hNrotANF/fNsBLn+vp334OYQiUsjqq/njbycF2YghQc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dR3ueVkz36rZTsGXkYaANpJSdFYhjuNo9YiBk/wg1p9/WOJDdpLRyHpgHKHj+XA56Isf/GNpYxHMtJTBsN33toXcVlP2WbjVCJdMxK83BQ4t8nsVx2tYRNTjTBx0nyk1JUmNDA2SrlpAliu1Tlj7EZAS71dRKRDXhNdPtJvu/1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pxMWrnnm; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxMWrnnm"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-837d43e9ff3so1585366b3a.2
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 08:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779117412; x=1779722212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0wuAL1060+cDsFFvYUT0tX5pCb+Jeju6WfI0kmVqr8=;
        b=pxMWrnnmKbiGaotZifnMJDfU1hyMkgAB4XsxrLn5CrTsJlgznHtrgZfcRwzsuQpbIG
         GTvQcg/JP4WF4pDLB9yhg3E4umFCiE65bzJDJkEpaotVVDeLol4iBmKqJSV3wmX4pY6t
         TMHreRHovaWTlcVU80JzPUJASaAJPqRCnZXSod4K7xRoMfI8KxPrNGj1ACOfmIZpIbDO
         bjxMHj+9Zfz1hUiojZl0syjXKvYniB+oAQVl5MciStN8Acus/PCj3dpxOa2K/b37nfzI
         /qzLsY3JR+ohWaafVik/D4ccvxxRtIAvNk3wHzCRD/eXBPsNIaJDEZc+mDbfo51hDZvt
         Accg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117412; x=1779722212;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n0wuAL1060+cDsFFvYUT0tX5pCb+Jeju6WfI0kmVqr8=;
        b=RTrApsvRtpVNpO660rsBRtnP0w2gtmfCDvy+Ob8MPqb5QjpNwOZfYRh9OY7p89s5O8
         cz+HtKAKhClZpRS8wRgQHBglSaPG3NPyCnoE1gmLUUfzra8tMEbNUq7e9VTdUm79eGgm
         mXX1R/DVKw036oxLoYfyDoesRp4+BV8pUI0wzIoEEL1cQLvQ3recCZFCW78E8uCWuxIC
         jh9HPG4hUOnVGtY1sxPBGgxdBwAbM6EAqG4mDenZsa+08XQdZ05w0eONZEEiiS/du2Zv
         4qmvj2U6vlALpCJ32lpoj4lmGpzj2sPIN1Nw8f8EFkyO2u2XNcPHL9I2GUDJzIdVII5H
         yoNQ==
X-Gm-Message-State: AOJu0Yz8ycmujztVjtd/37Pb5E8uyUKzWWQJC9RMpUhHJqE9s0J3jI5x
	TvzUOUxv+qiEgsl6hk+qXhr9knh3ZMv6Se30yADFVb3J5eqm4kcv4mloFsrLYvPKS4HOAoKI6xM
	LZGpApQ==
X-Received: from pgbcz14.prod.google.com ([2002:a05:6a02:230e:b0:c7f:ca3d:442c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d26:b0:3a2:dabf:fef6
 with SMTP id adf61e73a8af0-3b22ed62a5cmr17767724637.35.1779117412058; Mon, 18
 May 2026 08:16:52 -0700 (PDT)
Date: Mon, 18 May 2026 08:16:51 -0700
In-Reply-To: <agsmQaqJ5ShSaV07@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260516163412.601908-1-clopez@suse.de> <agsmQaqJ5ShSaV07@google.com>
Message-ID: <agstY455kTIumJ5P@google.com>
Subject: Re: [PATCH] KVM: x86: Fix array_index_nospec() protection in kvm_vcpu_ioctl_x86_set_mce()
From: Sean Christopherson <seanjc@google.com>
To: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>, Tony Luck <tony.luck@intel.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Jue Wang <juew@google.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

+Tony (questions regarding IA32_MCG_CTL and IA32_MCi_CTL behavior)

On Mon, May 18, 2026, Sean Christopherson wrote:
> On Sat, May 16, 2026, Carlos L=C3=B3pez wrote:
> > Commit aebc3ca19063 ("KVM: x86: Enable CMCI capability by default and
> > handle injected UCNA errors") introduced kvm_vcpu_x86_set_ucna(), which
> > accesses @vcpu->arch.mci_ctl2_banks[] using @mce->bank as the index. Th=
e
> > @mce struct is user-controlled, provided via the KVM_X86_SET_MCE ioctl.
> >=20
> > The caller of this function, kvm_vcpu_ioctl_x86_set_mce(), bounds-check=
s
> > @mce->bank and applies array_index_nospec() to advance the @banks
> > pointer, but @mce->bank itself is passed through unclamped. On a
> > speculative path that bypasses the bounds check, the raw @mce->bank
> > value can index mci_ctl2_banks[] out-of-bounds.
> >=20
> > In practice this is a very weak gadget, and would at most allow leaking
> > a single bit in a 64-bit integer, but prevent potential future issues b=
y
> > clamping @mce->bank in place with array_index_nospec(), before passing
> > the struct to kvm_vcpu_x86_set_ucna().
> >=20
> > Fixes: aebc3ca19063 ("KVM: x86: Enable CMCI capability by default and h=
andle injected UCNA errors")
> > Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>
> > ---
> >  arch/x86/kvm/x86.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 209eae67ab18..2d2415031267 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -5497,7 +5497,8 @@ static int kvm_vcpu_ioctl_x86_set_mce(struct kvm_=
vcpu *vcpu,
> >  	if (mce->bank >=3D bank_num || !(mce->status & MCI_STATUS_VAL))
> >  		return -EINVAL;
> > =20
> > -	banks +=3D array_index_nospec(4 * mce->bank, 4 * bank_num);
> > +	mce->bank =3D array_index_nospec(mce->bank, bank_num);
> > +	banks +=3D 4 * mce->bank;
> > =20
> >  	if (is_ucna(mce))
> >  		return kvm_vcpu_x86_set_ucna(vcpu, mce, banks);
>=20
> As a follow-up, I think we should fold kvm_vcpu_x86_set_ucna() into
> kvm_vcpu_ioctl_x86_set_mce().  Splitting it to a separately helper makes =
it
> unnecessarily difficult to see the usage of mce->bank.
>=20
> Hmm, and isn't the handling of UNCA errors misplaced?  Per the SDM, the o=
nly
> allowed values for IA32_MCG_CTL are -1ull and 0.
>=20
>   IA32_MCG_CTL controls the reporting of machine-check exceptions. If pre=
sent,
>   writing 1s to this register enables machine-check features and writing =
all 0s
>   disables machine-check features. All other values are undefined and/or
>   implementation specific.
>=20
> I don't see anything the SDM that exempts UNCA from that logic.  Ditto fo=
r the
> similar IA32_MCi_CTL check.  So on top of your fix, over two patches, I t=
hink we
> should end up with this?

...

> Unless I'm wrong, I'll send a v2 with your fix plus two more patches.

Heh, I was partially wrong.  I think.  The IA32_MCi_CTL MSRs control whethe=
r or
not a #MC is reported, but don't change error _logging_.

  Setting an EEj flag enables signaling #MC of the associated error and cle=
aring
  it disables signaling of the error. Error logging happens regardless of t=
he
  setting of these bits. The processor drops writes to bits that are not im=
plemented.

Ah, I was definitely wrong.  Section 17.5 CORRECTED MACHINE CHECK ERROR INT=
ERRUPT
explicitly says so:

  CMCI is not affected by the CR4.MCE bit, and it is not affected by the
  IA32_MCi_CTL MSRs.

Actually, that means the existing code is wrong, and has been since commit
890ca9aefa78 ("KVM: Add MCE support").

Hrm, and I'm not convinced KVM's handling of IA32_MCG_CTL is correct either=
.  The
SDM says it controls reporting of _exceptions_, it doesn't say anything abo=
ut
disabling loggin of errors.

  IA32_MCG_CTL controls the reporting of machine-check exceptions.


Tony,

Does clearing IA32_MCG_CTL affect error logging *and* #MC generation, or ju=
st #MC
generation?  And if it impacts logging, does it also apply to UCNA errors?
