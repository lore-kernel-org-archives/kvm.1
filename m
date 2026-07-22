Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6E543D508
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 22:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784758175; cv=none; b=tDIzGosilqg8CVr/+pmVo3lzpxoYcEDHtgIW07GE1VjzH23pWRNeX4PNHQnFKcVZze4X3p0q0Fuwpw4ZwdhBev7/HEz8ets8W/EBheuHUA73ATG/Uz24vsyJ4GgHXiDxjhzd4C177SQIH5RBqTplhKE0zf8JMXO5AEQ03pITk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784758175; c=relaxed/simple;
	bh=BvrcAeGYxP6POw2jbXtWTig813bTQmdrgS1FdeG+l1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SKJvJfuOa/nvx+v1CjweAgUt1zX6Hewy3Jgb3NPlTP6i2nLAfcGbKMKG/dTKXoBblwKgAOLJ08GIYLXsnqXDaRNIfgLmY+X76bXFgxQV9C6FFekvBIXQbasCxR3oSDfghy45YFD/UffVIAWBrI9TMd9Qbk1vOe7QH4ws6njGHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T751kGfg; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T751kGfg"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-847a00bcbd0so16370054b3a.0
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 15:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784758174; x=1785362974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fAykqS9DtvWGSj58lKIuZXh9sJItsA/beqvkn+rWVtE=;
        b=T751kGfgIqfkjnQuzRQfRn2cAdSQuQAfY0yrpYBGdL8DJZmGK2C/NXrMkVijbdoGB6
         n2vL9XzfwH7BWrXYTOHm/0hbaN7kUnZY00WMFdpyATMyeM74QsbCA1765NkS9awcaU4b
         JbfhmryJuH7DViCvUHOnp8ATJK3l2kNjPWZxsjM5FDzF1PuQgaL9GbkILH/VxE5ux7CF
         zsfVsUEvUsCo9Hft/b9ClICzhLu8lK32gsgbjGAyeR0z11UVNArgUzg330beTfMr5A1T
         74EkXcvYKbdI5MHfn28rdm4QOX0U+YfooGBdCpyDkCEYi1CEsp7K0SDknunNI7PFfIKd
         TwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784758174; x=1785362974;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fAykqS9DtvWGSj58lKIuZXh9sJItsA/beqvkn+rWVtE=;
        b=TUTl2mw9aRdPIqkgEZ+ZpbW3RSNdZA1jATJvzaKygHwr3grlWAs9UyhblXumoJnoaS
         D1IVq3t8MLNLagln/UJCpF9jMgfNAruh9BgUSm9Jec4EA6yY/cUu8tzCPxs6vuziUfkP
         zRA8Xf7w3N7McFy7aiO2zIWtw67NrIfT0afY01mDJSEH7UsZyrxbvrY30+Rm4I/lMAGj
         1lxxAQ8OrXqp8rK5MzeeF8gdz06WzrrJBIQ67/e2ucHD2UcA13CAA2OQzrwYOp1zYBMa
         U+ng3pdqiQhQmotcVTyCQvRX1h2PpIoD+wICTr+sOUKxJj+8k02QvdFwNhdlbyfkbA4W
         PUKQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq5dUJw8oqFjvSGPH8OhPFuJIZTzsMcvC9lujk8cop42/DkPvE+1/n1XAx56TE8zGdcihM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcp2irTT0jxPq7vqfse/0QdUja+R8tjjTILshmivZKW3kNocIk
	a5xfVUs7KoVLTvMNZ8DwoZRmFkEBLekfoUkw5DV7vVS7r6ktme58iWnbWuoOyIckhV84qEtRMn/
	us/L3Fg==
X-Received: from pfbfj32.prod.google.com ([2002:a05:6a00:3a20:b0:848:56a2:f6a9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ccf:b0:842:614e:cc94
 with SMTP id d2e1a72fcca58-84e2b8ab35amr818120b3a.26.1784758173554; Wed, 22
 Jul 2026 15:09:33 -0700 (PDT)
Date: Wed, 22 Jul 2026 15:09:32 -0700
In-Reply-To: <CALMp9eRGx=K+UBp76A=dZ=bD_Txonq7j8pSn9HVczdtyyuAs3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-3-yosry@kernel.org>
 <CAO9r8zPnXM1rypG8=YVsb7bir3J084Sza-0onnNX3s=uPK-JWg@mail.gmail.com>
 <CALMp9eT2W-oPtMpFdHZi1=F5MwVpx1YWKTh4n+O=STz7N=F_qg@mail.gmail.com>
 <CAO9r8zNso+8iKgiHc_VnCnTLKor-mGsFEV1U1N=RVLdn=FPNUQ@mail.gmail.com>
 <albJNb-akQJ97Yor@google.com> <CALMp9eRGx=K+UBp76A=dZ=bD_Txonq7j8pSn9HVczdtyyuAs3Q@mail.gmail.com>
Message-ID: <amE_nPDem-imSfqF@google.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026, Jim Mattson wrote:
> On Tue, Jul 14, 2026 at 4:41=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
>=20
> > What complications?  Advertise the lowest common feature set for the po=
ol, just
> > like userspace has to do for literally every other feature.
>=20
> The problem with passing through the number of host ASIDs to the guest
> is what to do when the combined host plus guest usage exceeds the
> number of available ASIDs, particularly when FlushByASID is not
> available.

But that doesn't have anything to do with the number of ASIDs that KVM enum=
erates
to L1.  As of this series, the number ASIDs KVM will consume in hardware is=
 a
property of the total number of vCPUs in the system (one ASID per vCPU, plu=
s one
more for nested usage).  E.g. if KVM advertises 10000 ASIDs to L1, all 1000=
0
(10001, if ASID=3D0 counts?) of the those ASIDs will map to svm->nested.asi=
d02.

Of course, that completely undermines my statement about suboptimal perform=
ance:

  And potentially suboptimal for performance.  There might be a legitimate =
reason
  why a CPU generation advertises X instead of Y.

My bogus assertion about performance notwithstanding, I still think adverti=
sing
what hardware supports is the simple, sane approach.  Because at the end of=
 the
day it's just that: advertising.  Userspace can do whatever it wants, inclu=
ding
peeking at raw CPUID.  E.g. if we want to pull a stupid and emulate the beh=
avior
of ignoring "unsupported" ASIDs, then we'd need to do that based on userspa=
ce's
defined CPUID model, not KVM's advertised support.
