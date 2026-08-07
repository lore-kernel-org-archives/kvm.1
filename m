Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1784C6D
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 00:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786062725; cv=none; b=pfz87dpfWHYJT7hGvES75Ex5lJmQ1og9PNU3u0SATeiL+9jzKC7N8yzodktXINc6i4YKeUc8AFmAS060R2WdhZHV2oTvpsO1YJHxeTVbUOodvdwV4/DSazccdsYwQfSOOhTlwU9Kgmbj0vAtls/gbPJsfyaObTPI9vmSQVPenPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786062725; c=relaxed/simple;
	bh=OaqD/7GFD/C7GLTIlUmRBirSEoL5NPBI1RXJquudk6k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GKdIWMup+RIXGye1ny9ZIoD/2vn2yJxs0TtJdT6AoGD8+K6iRIOycn3MX9l3r2p/o4sKFGRo6poo64BUUs9ZoL9CLkhSKsrAcgfBzTi0Z4rouHcRh6Tn4QeXsD+c6a02w+Ua5LqLomr0quK11zFGbzzm76L0tVovJm8Y/aXyyDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TXrWw8x2; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TXrWw8x2"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84eee2147ffso3529885b3a.0
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 17:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786062723; x=1786667523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FQ61FKO513ZDkdjmEmRdv5VstyB6n09n16DTaCoYCSQ=;
        b=TXrWw8x2BdoNbqtHJWDUQakF6GSt3bUzP1d1nSjCz9fJRQqPyys7OBCOE2b53s2+0x
         +pQ7kxH6GnMUogrclrT0TlETqcSrmInWddqlwI7TRRbezGvqHgMSzFFWlMEYS2MkOpln
         vwv2fWvJowrn9FeQQBjAtUxBP1bcKfUYAJa5EUg/G02qfK/Jk8+ob6KCAFwxMgDfxehe
         BjmiKoSCg17ctm+jwk84Z3jSjIxu3rQlOlAvKMgGOUJUqHRHREj85YBcbGJbVjzYgaXZ
         1hoqB3uCD9JwfCoC33PiRMWD1NWCEZPNo82uEIIPDEaGw2LVg5lYhb97E50jd2avWiaP
         Tt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786062723; x=1786667523;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FQ61FKO513ZDkdjmEmRdv5VstyB6n09n16DTaCoYCSQ=;
        b=bmjBl8D+xG8KJPqOtv9YRh5uKhAiQ0gdhtTtnmlBe0BfKucao76oGE65zw55oEchsG
         eqQf/2thD72J0s9dmYU5WFR3YEFT39nmJKbYb9bY/NC324vFDtkOQHUmTZh2ZC7O40Gz
         YVRG5p9qhB8zcs3s4kFdp6VcAZxIsRKRpEOlu4uzNy+YLOvb3S9vuoR4OQZ/qKICbWbn
         VQn9hozdhn5RRqJERXEkGrqDvQJMlnKmDXqQQjiPxBjBGMbBd7X53Y+ngOZxWAbRfURd
         +daZ4uMmOuzjBS0wuVrPYPL8w+b1dSOFxeyyKdCDJ8Z+f14vAaIacYknygxgozuMe/eR
         O+oQ==
X-Forwarded-Encrypted: i=1; AHgh+RpuXirwheXEtYHmsz5IIfnq0M+91Y47cS6KIrK6uu1nFI/JvYVMf1KG7omNSRPQdDnHGSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/rCSdy8t9vdKe/ia364ehS8WwkLBCRa0vJfiWq0ZC4/vKzBJ6
	pKFVjUYFkSnG2rffkyd8HkyuouvgNC4ITlELLjZzEtsyl3752SwHNJHGsAsl0hS+DCkhiFfBPsO
	eioXRbg==
X-Received: from pghu18.prod.google.com ([2002:a63:ef12:0:b0:c98:2639:852c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d1f:b0:848:6b43:35dc
 with SMTP id d2e1a72fcca58-84f2e13b57dmr18018952b3a.35.1786062722908; Thu, 06
 Aug 2026 17:32:02 -0700 (PDT)
Date: Thu, 6 Aug 2026 17:32:02 -0700
In-Reply-To: <5ab71720460d268e3336e521209c796ca04b0012.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260805031257.1844914-1-xiaoyao.li@intel.com>
 <20260805031257.1844914-2-xiaoyao.li@intel.com> <82482276-0140-4d90-a983-fdfc5bc2e4a5@suse.com>
 <anSRCBhWi2BK9kYB@google.com> <5ab71720460d268e3336e521209c796ca04b0012.camel@intel.com>
Message-ID: <anUngktlwsNI6oUM@google.com>
Subject: Re: [PATCH 1/2] KVM: TDX: Enable Notify VM exit
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, 
	"x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Chang Seok Bae <chang.seok.bae@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2026, Rick P Edgecombe wrote:
> On Thu, 2026-08-06 at 06:50 -0700, Sean Christopherson wrote:
> > > It should be instruction timeout (as is in the SDM). Please reword th=
e
> > > changelog to refer to the name of the features as they are in the SDM=
. I.e
> > > if you search for NOTIFY_VMEXIT or NOTIFY_WINDOW absolutely nothing c=
an be
> > > found in the SDM.=C2=A0 The changelog should ideally mention both - S=
DM's
> > > nomenclature and linux's nomenclature.
> >=20
> > No, let's change Linux's nomenclature before merging this, "Notify" was=
 always
> > vague and confusing.=C2=A0 It's unfortunate that we let that bleed into=
 uAPI
> > headers, but we can simply #define aliases (or just force userspace to =
update
> > as well, if they use kernel headers directly).
>=20
> Hmm, ok. We were trying to go with a minimal backport friendly fix.
>=20
> Xiaoyao, if we are going to carve it up, I guess we might as well do the
> consolidation of the exit handlers too on this version. (a cleanup patch =
that
> got left off of this).

Oh, I missed that this was tagged for stable@.  Do the mass rename on top. =
 To
address Nikolay's concerns, I think a brief blurb at the end calling out th=
at
KVM currently uses old terminology would suffice.  E.g.

  Note, KVM uses "pre-production" terminology for the feature formally call=
ed
  Notify VM-Exit.  All public versions of the SDM refer to the feature as
  Instruction Timeout.  This will be remedied in the near future, for now,
  use KVM's terminology for consistency.
