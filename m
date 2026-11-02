Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650041;
	b=qJK/Gw+XEd52kgpGhtl9wl3CWYX9ihiE11aWyBAUI7vK3wwIqor6poEmhsvvA8VcmL/0
	 P98I2DElPlmZX6VMr+GXOWhAgmDxodkIX+8BDRWixbQELxMQIJ35EC1mTmKwwxzoHG/NR
	 UttXjWLXJe1a1AkwYDaUcsArPvUG9Adi/mjzPPxB7wMtPqJLBenTpKwsOQmBkxgTzHy9I
	 UPu2zq8xhFIZP9y+HIZp9Mz7RLBvhNoZVanY16GArDC1aDDpk2R9xof9oO6BtFKgSh6Pa
	 zfdpIaWmnr+uyA+eneXFh7DPgQXqf23rkw+ngH411+hHeHp4z0fnqfNdkyO3gJmXo3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=nNfm4rH6eQ2Oj47JrfSVJCEhe2McbXnswnFij5qW64Y=;
	b=VXqQETHMno65r4m3imO8N/5AZ+AisJQFOV5Naz3IW7cl0iMOgg3chfRNv1A0Q2Az6sIr
	 Sga8BdfZ4wb9DsKtgvdDHTysDmLXkQreQgYxRqzHGYg3QDmZtT+ugECFYT9dT+kcQo312
	 FrE8pYIrmcrqTsx3Jhok3X5c09ZwDUBK4sJK7GlHUMid7WmiEZw2HwLQIsGZzeyiS/A9D
	 CGzcUwvCCOLJ1VMcnNrUV3K9M+DgVkA/Hld6R/WfR8it+t/BF5iTkFQm7QjEPiaDGzQ5R
	 HGr4IWYD9U6auITSxtGW7ZQdloZAT4wyy0m+VqLvSEkxtMVpdY1gen+X66I2fRzQ5Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ckpGuMv7;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811C4606A329
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 20:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 811C4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ckpGuMv7
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3aed1b64104so1056422a91.0
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 12:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793650040; x=1794254840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nNfm4rH6eQ2Oj47JrfSVJCEhe2McbXnswnFij5qW64Y=;
        b=ckpGuMv7zO3B8SDR4ofmLGE5IZmRvz6MfHgSdQXThAu2Q9bhPx5NM4gY52stRxZTVE
         z+NHbcRvOPk6UGebzuGiZbI5R4wh8RyisAjrQR+cz1NpeM5T2OSwbpg77iVRzKyBEJTl
         BMdlxG5YX5oMQTihNRuQJ9jRTRhOst6271mHsjDQd3Pwt7Ih8d7jVCYWoXr8MHfVKnJJ
         niyf/n/HD+77i2PetyVMF2K0KO2HQ2yHtduKaggxhBsfqVnigRMPSaTnOQSIg1dAl9Kf
         YROm3diLAFEDadbQZSIEoEbDxhCNW7/OgieUGSBIkYDcmDr5wPtknt0PS+z1FyvUOQUR
         2gHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793650040; x=1794254840;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nNfm4rH6eQ2Oj47JrfSVJCEhe2McbXnswnFij5qW64Y=;
        b=kjNsGNiXUGAlKLY+6T6xIIaFfM8wii0VI2yvAcp0TU05sbyHRw13z3DAcVJRFeSs6/
         LL7s1fOEqFPyjYpiM0tukKPShsghSfSc1kIKrSfhcgL5Z/qk3/lKGwkwVW7B/gqZBXLZ
         V21rxd/HglQZb8RSM8kdS/dMO1/aN9kNkO2PevvQ0wjqryyLQ/OQM/+XQsQFMpQqX2e0
         9D2H9+b3NcAxB6DieZ5ycbugLIZsTQRYr+sQtsOKmaOXQYXA/Y2cR277iGodQLgqC9Hp
         Hr6CfBFx6a5kWLMjLBPS+S05ilMqtp3qKOtHMq5gaU4iNZeQo86L4/4QJGeEhR+mNcCo
         B96Q==
X-Forwarded-Encrypted: i=1; AKwUvBz5mX62PNupeqbFORDY9eudovuJcaNwB/MOAYki9OxGRtf34xVZkDhkD97JvDunC9uFOGI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8G9yKf76jidj8/VwwSClU19b5SP/2RkcLqiHWhtKK9JR74E+nH
	LtTdD0LusevBws5P6Gl+fGf8xV3HJvul9UMKCvAhEOcMaOYUaZR4koDkA+dQDgWGSbWhqanvq+t
	2ehiuYA==
X-Received: from pjwo8.prod.google.com ([2002:a17:90a:d248:b0:3ac:16a7:52de])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d44:b0:3ac:9d83:885e
 with SMTP id 98e67ed59e1d1-3ae898392a1mr8899415a91.52.1793650039539; Mon, 02
 Nov 2026 12:07:19 -0800 (PST)
Date: Mon, 2 Nov 2026 12:07:18 -0800
In-Reply-To: <953b3d774dc281bf13f5025041d4434f560cf776.camel@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <TY3PR01MB113468FBD8E5EFA65C4B4E5EB86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <072dd88c-4ca1-4c8a-98b1-7783bc43c1c5@kernel.org> <TY3PR01MB11346BAE55FF22F66E86A6F8B86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <afdf1864-4721-4177-bc18-2a5821d97559@kernel.org> <20261027205411.GAauEPc4AtLwvrDfFr@fat_crate.local>
 <7b0a2e98-c614-4cdd-8604-3b5b21e8474f@kernel.org> <20261028154743.GCauIZH3pZm24jCX9b@fat_crate.local>
 <20261030023338.GGauQCAuYyXGwIhlqX@fat_crate.local> <20261031030112.GHauVZ-OI2KjdkjrcY@fat_crate.local>
 <953b3d774dc281bf13f5025041d4434f560cf776.camel@intel.com>
Message-ID: <aujtdn73XnWH5g-i@google.com>
Subject: Re: [PATCH -v2] MAINTAINERS: Fix Intel TDX kernel file patterns
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "kas@kernel.org" <kas@kernel.org>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"krzk@kernel.org" <krzk@kernel.org>, "au.dang.jx@renesas.com" <au.dang.jx@renesas.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "x86@kernel.org" <x86@kernel.org>, 
	"biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"biju.das.au@gmail.com" <biju.das.au@gmail.com>, "jirislaby@kernel.org" <jirislaby@kernel.org>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026, Rick P Edgecombe wrote:
> On Fri, 2026-10-30 at 20:01 -0700, Borislav Petkov wrote:
> > From: "Borislav Petkov (AMD)" <bp@alien8.de>
> >=20
> > A K: is a content regex file pattern which matches any text in a patch
> > so if a commit message contains "tdx" as in
> >=20
> > =C2=A0 has_tdxe_auto_clear
> >=20
> > for example, see
> >=20
> > =C2=A0 https://lore.kernel.org/r/20261026-g2ul_sci-v3-3-b3097163edd5@bp=
.renesas.com
> >=20
> > get_maintainer.pl erroneously adds the x86 gang to the Cc list for what
> > obviously is a completely unrelated patch.
> >=20
> > The same happens when someone uses it to check
> >=20
> > =C2=A0 drivers/power/reset/tdx-ec-poweroff.c
> >=20
> > patches.
> >=20
> > So switch the x86 TDX patterns to files and directories (F:) wildcard
> > type patterns and group them by path, for less false positives.
> >=20
> > Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> > Link:
> > https://lore.kernel.org/r/20261027055750.GBauA9XlPykc1c1Xhv@fat_crate.l=
ocal
> > ---
> > =C2=A0MAINTAINERS | 7 +++++--
> > =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7a162e9bcab1..015cf66afb96 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -30347,8 +30347,11 @@ L:	linux-coco@lists.linux.dev
> > =C2=A0L:	kvm@vger.kernel.org
> > =C2=A0S:	Supported
> > =C2=A0T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git =
x86/tdx
> > -N:	tdx
> > -K:	\b(tdx)
> > +F:	arch/x86/**/*tdx*
> > +F:	Documentation/**/*tdx*
> > +F:	drivers/virt/coco/tdx*/
> > +F:	include/uapi/linux/tdx
> > +F:	tools/testing/selftests/tdx/
>=20
> This drops arch/x86/kvm/vmx/tdx.c. Not that we are sending any PRs based =
on this
> maintainer entry, but I'd like to continue to keep tabs on that code.
>=20
> Sean do you have any thoughts about how this entry applies to the KVM sid=
e of
> TDX? I'm not sure we actually ever had a specific discussion.

Honestly, it annoys me.  I often temporarily delete the TDX MAINTAINERS ent=
ry when
sending patches that affect arch/x86/kvm/vmx/tdx.c, because many, if not mo=
st, of
the KVM changes are purely mechanical and/or KVM-internal that don't have m=
uch to
do with TDX as a whole.  Although maybe that's just a reflection of the typ=
es of
patches I tend to send.

But I do that purely to try and not pollute x86@ and linux-coco@ with stuff=
 I'm
99.9% certain they don't care about.  If y'all want to sign up for spam, I =
won't
stop you. :-D

> In practice it has been a cross subsystem wrangler role. With TDX connect=
 it
> will likely grow more tentacles.
