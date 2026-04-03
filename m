Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F982628D
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 23:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257665; cv=none; b=niuCUzkJyR5wmLQKEZDVSsfYLuNvE1JZVL8OwpGOWuAJbxLzqRyi0rzfwERhN8mbpraY/vzH9blZn4Ke/Ms/1bXy5D3syA2Z3q5iFZl4NdgfaVoX0pxTNeKj9mcMt2LYMl+REuzob8/tcCxlyuiG2Xz2RSKoLU6O2zT9PrZ1sDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257665; c=relaxed/simple;
	bh=QFw0rrC9aSRV2WEJT8WSxFXaANoNrpSU9ltrBzCF5KU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cm6V90kHjqPVwuR8fHu75SyK0BZByOdpvsHX6uXmhjomXBqti0sf+FHekvHTnPjsUGBbrpkuoTANueWJLK3/x9S9gV57ZD1s6MSoxhScby6si4EqRHI1zCRYlvo/ll3v7Gz0wv/b5USrqPrxjqzSZKtjLe6T6Ugy7jUVg+NtyWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PCGinfKA; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PCGinfKA"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82cf084fe58so1155169b3a.1
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 16:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775257664; x=1775862464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hyvj5kBMSuNn+SZot72GWuwcDIHZb7QGlMIx1bfcdhA=;
        b=PCGinfKAygOkkUXf+DY3y087qTEWqrFKxAXmXE6FLgGHVE30kP6BYJ2yCWv4wwKRC1
         Zwqq8fhu/MtrCSuZM8FZI4fW1Rklj9zbKCOtM1zXpYMcAKpIjl2Ura1+lw+LYzdClvBP
         Kuqj985YIhOxJ9DHA/peUFZE2F7aXQwo5mk7/0qOzen2Is6t8PY6OQj1DXPc80Rd+IBB
         6VG1MdBC8/YCedky63Npj8Z9cAbhAuIQO+e/k0XhDd4d3xcFMDXmyuUlKJ02Y2xTF/Ft
         cu7uQ4UpPG05TXHKX7sS13MUd3XGX8EXSgurJK/DqAszzZzmQIpwkE2I/AE3ie+8ugBi
         lQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775257664; x=1775862464;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hyvj5kBMSuNn+SZot72GWuwcDIHZb7QGlMIx1bfcdhA=;
        b=b3tOj3oFX9sVDI7W7HkSK+OlceCX7oJaZSL+kKKF0S9r+HZxCqW4lhO3peHEl+PxZd
         CDLPEwJ8R+oAArwR1dUqqCR2uAWl3o3aYHwRubuUaLdizMsEZQnQubhgpcSrPqqp9XIa
         iO7rcTmG6OUirRg3fRYHLOV43/VRMafauSf6I9elm5qH/wGGAqwjr5PSZIhjZWlu7NNi
         YcX+h2+yrCuMF1QpSit9eqTazqydos22NTiiWeDVcRSMSpv4+EQDnzKMDPbBezy+L7ga
         Cg54Y1hbtBrF9hgkJnH9rLhQnGP2nse4viDu5In8Nc2Y/lXmRhm87D5cA9bsG9hUonkN
         Wljw==
X-Forwarded-Encrypted: i=1; AJvYcCUNSGLH4IY40UkMyXqslDwdiNEPxqWpDiwT5xzrCJ6aI65VBfhO2kTDl56k5sZb5RNYswU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyitfeep9LIeSNHVePRVzaNnz/NmafEJLhs1Hto51h1H/hZ3gTi
	soU89YcA+MrBcKt60YwDxmz98/o+G7A2+pMSRuaz0PPfA/Lxlro4Eew0orP9Vu7IKro6yN9dxlY
	FCIjL5w==
X-Received: from pfra8.prod.google.com ([2002:aa7:8e88:0:b0:824:ada9:ae89])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1a89:b0:823:3079:7c7
 with SMTP id d2e1a72fcca58-82d0db6bb43mr4629830b3a.29.1775257663390; Fri, 03
 Apr 2026 16:07:43 -0700 (PDT)
Date: Fri, 3 Apr 2026 16:07:41 -0700
In-Reply-To: <ec581571ab4141ed77e6979b3e03773e301a62c1.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260318190111.1041924-1-dmaluka@chromium.org>
 <94b06319-2be8-4f01-87d1-8989ae1ca85d@intel.com> <cb99e44c-8bc9-4bab-b485-9f63a4d0b262@linux.intel.com>
 <93358559-5ed1-4574-8951-24d7ea9354e4@intel.com> <ee8d7ea3-0ece-43cf-ab07-6954df4c01ad@linux.intel.com>
 <f67179d7050ae28ac261bb6227b1c045c10579c9.camel@intel.com>
 <ac_rNT69TdocrMYc@google.com> <401db97a254b356ad8539a5d637d68ee826179a5.camel@intel.com>
 <adAQCXI-7Yj0wcKA@google.com> <ec581571ab4141ed77e6979b3e03773e301a62c1.camel@intel.com>
Message-ID: <adBIPdBA-aJWcUrY@google.com>
Subject: Re: [PATCH] KVM: TDX: Fix APIC MSR ranges in tdx_has_emulated_msr()
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Dave Hansen <dave.hansen@intel.com>, 
	"dmaluka@chromium.org" <dmaluka@chromium.org>, "bp@alien8.de" <bp@alien8.de>, "kas@kernel.org" <kas@kernel.org>, 
	"x86@kernel.org" <x86@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2026, Rick P Edgecombe wrote:
> On Fri, 2026-04-03 at 12:07 -0700, Sean Christopherson wrote:
> > > > No?=C2=A0 Don't we just want to allow access to MSRs that aren't ac=
celerated?=C2=A0
> > > > What the TDX-Module supports is largely irrelevant, I think.
> > >=20
> > > Not sure if I might be missing the point here. As above, we don't hav=
e
> > > enough info to=C2=A0know which MSRs are accelerated. If the guest ena=
bled #VE
> > > reduction, it changes which ones are accelerated and the VMM is not
> > > notified.
> >=20
> > What does the "accleration" in that case?=C2=A0 Or does it reduce which=
 ones are
> > accelerated?
>=20
> I mean ones where wrmsr is handled by the TDX module instead of generatin=
g a #VE
> that gets morphed into TDVMCALL by the guest. Actually usually called "na=
tive",
> but I just reused your "accelerated" term from the mail.

It's neither.  Precision matters here, otherwise I can't follow along.  Acc=
elerated
means the CPU virtualizes it without software involvement.  Native would me=
an the
guest has direct access to bare metal hardware.  IIUC, what's happening her=
e is
that the TDX-Module is emulating x2APIC stuff.

> So... "Reduced #VE" (also called "VE reduction") reduces which things cau=
se a
> #VE. The guest opts into it and the TDX module starts behaving differentl=
y. It's
> kind of grab bag of changes including changing CPUID behavior, which is a=
nother
> wrinkle. It was intended to fixup guest side TDX arch issues.

And KVM has no visilibity into which mode the guest has selected?  That's a=
wful.

If KVM has no visiblity, then I don't see an option other than for KVM to a=
dvertise
and emulate what it can at all times, and it becomes the guest's responsibi=
lity
to not screw up.  I guess it's not really any different from not trying to =
use
MMIO accesses after switching to x2APIC mode.
