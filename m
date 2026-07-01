Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1628538F244
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 17:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782926714; cv=none; b=i3vQSfVp1aHXWYwACW8T9/F5gCa7ZH9qrPvCzqjE8SEhUWe951KtIrBW2nRX4mFq6+stpeipViZ7iD1sdLb6knlggGLRjlh1VZrq9/ozlIHU8Ooqmg3HczJ4r5JcTcwN8tkhu9TE6x0AXYZqYsWlUj6i9SPcgT2GDSfLGFySniI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782926714; c=relaxed/simple;
	bh=uq9mftAVkqg2VPJr4cBMZLEVHMpbU5TYZwZql0DNjWs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HvU9FST0TRFcxKFfWI2y0AwfdIyLjt7lRm2Ut7/mjS+PCM78JGH+68zpSmjSl9qIRyf7TG6lF8gjS5SGgJf0I/UKxPAKcRvY33t7aLpH3Jmh+w9E2VCthxwOTPRfETSUIGx8/6xEcTZbwG3nfCszDqVomh6WnfChaitQBEgzda4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ih0mQw5u; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ih0mQw5u"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c7f385887bso20763575ad.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 10:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782926712; x=1783531512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GY/K611H4+IH7+nHcd47WRcy75RcHzOXMZTnRVs6V4s=;
        b=ih0mQw5uh2TdPR2Z+6ExyuSb8YZ5UD7xG+9oD091SgNasacT5uAxnkKhgiAbNAxwy9
         S1EiN3IaJ9Wc5nwp2g5NVZPNYG00XZuMTukHEslA7m55QmjO7URhGqa18BWMO0+jHQkZ
         CANlT6g0FT7KewIBDUeWn2rjceAfLd2SiO7mSyFitbzlszjzL0NZMoPTUa9CMvQ8i9Fm
         UNCKEmWT8BELaYd2NR5GlfchNxBZQhIEiuZXHCK/JDQ+LfegcGlywgg46OARAja4wRGw
         4mB11n1U88QPh+cq52mlcg8D6K6IQ1NCAw+6Zu+kzLcJCjZl9B1aHAXT4h9ikAXVWNDO
         CKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782926712; x=1783531512;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GY/K611H4+IH7+nHcd47WRcy75RcHzOXMZTnRVs6V4s=;
        b=UGv8arAinZXq4F/FfH7e6BJTap1qYmLp/SBM5m18/WcnCB508/DgPPpcTpmdTH3te2
         xrkccgaK5wxY230PhRaEq0y+WueOw+wJmKNJqODA7y6auyhVVGzVcP8YuEZPpwupnk3V
         qSkKOU7YsC75fC5cRwuPqErrvNmUH4zTrFMs8XTWZJTCxc6Ntk07Wo9yW2Q7ep+w4sk/
         zCXnwewuFSs343STrvg2oaY9hEPHPxQY8svWqzDqjMn+LDiCXFrud6l/dSlhBfLmdODk
         dNfX4/jghO+T3RZ6miKDMxqeBWite8WJjVkF2SRblHLsdW5Onu9FNk5jK8T7ESnahaPu
         cr+w==
X-Forwarded-Encrypted: i=1; AHgh+RqGoV7PjxDAWiRAl3RuqT2fm/da4e24h9QekF17Q1im+XSkJgc1qHmZgLiS05MT2+tP0iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMzGY9ai/Wffo4PA0KeLx7OpuX2iWZ5dlKR6x4dIRIEkS09zin
	AgarepmkAH+VVoZ2Q3WeZL6JtaCeDgt4jbr6lDYC6XQR3AjqhjzuCP4NBVAYWlhzhek0wKb+jz4
	gnm0l2A==
X-Received: from plbky5.prod.google.com ([2002:a17:902:f985:b0:2c6:e595:44e1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4cd:b0:2c9:bd64:8c81
 with SMTP id d9443c01a7336-2ca7e6d9f27mr25313235ad.18.1782926711942; Wed, 01
 Jul 2026 10:25:11 -0700 (PDT)
Date: Wed, 1 Jul 2026 10:25:11 -0700
In-Reply-To: <6a445e4be6b12_3a3568100db@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-17-yilun.xu@linux.intel.com> <aj1tFuwZWdPGfUoG@google.com>
 <20260629100301.GA1743876@pedri> <akMQ3J6fK3DUBsPH@google.com>
 <23a9173f6e278ca7dfedce3374626c6ea3e1b47a.camel@intel.com> <6a445e4be6b12_3a3568100db@djbw-dev.notmuch>
Message-ID: <akVNdxCzk-n4bgMv@google.com>
Subject: Re: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
From: Sean Christopherson <seanjc@google.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, Peter Fang <peter.fang@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Dave Hansen <dave.hansen@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yilun Xu <yilun.xu@intel.com>, 
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, Sohil Mehta <sohil.mehta@intel.com>, 
	Zhenzhong Duan <zhenzhong.duan@intel.com>, Kishen Maloor <kishen.maloor@intel.com>, 
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026, Dan Williams (nvidia) wrote:
> Edgecombe, Rick P wrote:
> > On Mon, 2026-06-29 at 17:42 -0700, Sean Christopherson wrote:
> > > Answering my own question (though probably poorly), IIUC the answer i=
s that
> > > DICE-based quoting is done through the TDX Module, whereas existing q=
uoting is
> > > done through an SGX enclave and so was routed through userspace.
> > >=20
> > > If that's all there is too this, then why is KVM involved?=C2=A0 I.e.=
 why doesn't the
> > > TDX Module provide the quote directly to the guest?
> >=20
> > That is a good question. The answer is partly historical reasons, but I=
 think
> > the pros/cons don=E2=80=99t really move the needle too much.
> >=20
> > The main benefit of doing it with the host in the loop is that the gues=
t side
> > TDVMCALL quoting interface can stay the same. There is also a wrinkle i=
n that
> > there is a limited HW resource involved in the quoting,

What is this magical resource?

> > so we want to do these operations one at a time. Having a mutex on the =
host
> > is the KISS way of accomplishing some level of fairness for DOS prevent=
ion.

At the risk of unintentionally causing effecitvely DoS by introducing a sys=
tem-
wide lock.

> > We should've explained this more, but TBH this solution is *way* simple=
r than
> > the initial one that never saw the light of day. So this extra host wor=
k seemed
> > quite small compared to what we have been staring at and we kinda overl=
ooked it.

Simpler for what?

> > The other relevant tidbit is that the TDX module folks have some proble=
ms to
> > solve before they can support TDG calls to TDX module extensions. I thi=
nk we can
> > get them to though. The question is probably really: do we want the gue=
st
> > trying/selecting multiple interfaces, or the host.
>=20
> tl;dr: FWIW, host, if only because this is one of many blob transports
> across multiple archs that need host coordination.
>=20
> While TDG calls to do the same helps a TDX problem it does not generally
> reduce the Linux problem of multiple archs having multiple blob protocols
> to shuffle data from host to guest in shared memory.

Why is that KVM's problem?

> The current direction for other archs (CCA, SEV-SNP) and blobs (e.g. PCI
> attestation collateral) is shift the burden from arch/*/kvm/ to
> drivers/. There might be a later opportunity to consolidate some of
> those drivers' internals on a cross-arch generic transport (AF_VSOCK),
> but there remains a requirement to talk to the host.

Why?

Bluntly, this series is unreviewable.  I've speed read through most of the =
patches,
and I have *zero* clue as to *why* any of the design decisions were made.  =
E.g.
why is there a common buffer that's apparently shared by all CPUs and VMs, =
only
for the API to immediately allocate per-quote memory and copy out the buffe=
r?

The changelogs are all heavy on the "what", but explanations of why any of =
this
is being done, and in the exact way it's being done, are non-existent.

So, back up to the beginning and explain why I should spend any time deciph=
ering
this series, because as-is I don't have the interest or the time.
