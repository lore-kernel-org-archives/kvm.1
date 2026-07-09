Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A3813A86C
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606123; cv=none; b=ef5UWZ8sY9CG4AiHUy3BMJQXeRKKSn71GtIWn7zpF9pr3ovyJTXoUio38jQYFSIwU7gZU1hDnScuvWShlQIqLptuaKw78Am49elqRaIlu1tdTYyueiEaAiXe8myNloFqEta63t6RhqMkfFCMu8NH/bTeHSUj60Za/Gfa1DYMVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606123; c=relaxed/simple;
	bh=LJQ+Wy5qFlw23RxcEXk2UYe+R7vipLE6QRbmbH5p65M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fdVJeTVYgtV5Qw4k4U25oblp9W6WpyS+2bAt6Rg5YsB2kfyR/KCnQ7Rm0b9matN2db68buwWWRwudbMHT3ZXYEl8U33Ed4mLCtWtOwYslAyHSvF6DRBIMs0CEziuz/2+iudolpVpHSE37gUCxXFxDrqKfT9m/eCwrUzcDwpzCk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bfBg0JQs; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bfBg0JQs"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c9d5a5b63c5so1738349a12.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 07:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783606121; x=1784210921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KgH/ydIU7zEHefclnHmkpwsTp6JMOkXk2hxaj+W5rx0=;
        b=bfBg0JQsn9Gxbuqkb/5sA9a0f3mMZtpc/n5XCztCZl4TxCNXpsZEnCcbEblwpJoGRo
         V0GLXaaCNsKoBXuMC2CfURdt5wMD7va4EYxpcMzomf3LwHMJERAnMxQTc39Nl3EyO+kN
         P4wnTcgiCjCHZFneK5yLqdrK18D+hNmTiEWTA/YQBGctcG2UMvyGpkK9z8CCNt/9p+MC
         nxxNFWBPt1W7Q67ph8C4G2HFpm4XvFCPdoiE/qfJF5brrAJyNbaJWJZzYEEgeSljwcEx
         qCbQUzuu1IgWiKKzMvWTM3wtbgJSdWXG6giCo7Z9FOfnD07IoUaw9vCaoGjS6UL411dD
         hbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783606121; x=1784210921;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KgH/ydIU7zEHefclnHmkpwsTp6JMOkXk2hxaj+W5rx0=;
        b=s5qdDR0PKQy5sYmoFf59n+aldDn2l8Rwq/5WdvGlsjws2rpKg8cgctJsDXu0UPHaNd
         f8nJrfsb7VEsBrGgGnu6EboMKwb94cQ3Sr7Xpm3UElFg2JAOxqtRLT9d/qLVTjCOpyqN
         EZ/lAjAFyoOur4C8tURvdjL5bzghpxRkrvOfvBnS54EdehijEJU1LMM8p7vQh/SBYxU/
         sX/rm5qQBGaMbXFFcBDGQv9i9BIOmvFrI86OVEASA/17vkZQGWetQNRziunorslXNe9e
         HcmZ1iF65a+gkkSKfeTG9q2A6CRSRq9NpK38sStck66mkg0Qx5F8PmxKz6AP3TSENAkH
         u2FA==
X-Forwarded-Encrypted: i=1; AHgh+RrFnZHAiTWgI3Yw9p4x2g22Ewis1JcjFGETkfWCNKA85Azw73gcHf80i3M5Boo6p3wpDUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzx5Be9KB6jo8xQXiJz3OnvNHP4Uvix4CfyVytxMyrfDN5jI6f
	R9ZuS08t2xTO9htCWpgWQJLEOmmAiFLPsjxcv2K7584qPysFqnvRDBrOy5OtqanJMRugEYiQe4y
	Zal3Ykg==
X-Received: from pgbfm1.prod.google.com ([2002:a05:6a02:4981:b0:c96:4086:38b5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d0b:b0:3b3:f46:1efa
 with SMTP id adf61e73a8af0-3c0bd0fa172mr9218633637.42.1783606121082; Thu, 09
 Jul 2026 07:08:41 -0700 (PDT)
Date: Thu, 9 Jul 2026 07:08:40 -0700
In-Reply-To: <CAA0tLEpxE-YAigp-j6jC4pyQTv9vOPbs030Fs3kVFkczC9Etkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629125205.52394-1-zhang_wei@open-hieco.net>
 <CALMp9eSLH7pT7X22es+AotxhRMQ1VyziWWELQu6_ZRsyuQ=xzw@mail.gmail.com>
 <0e576fd8d8cd2ed1739cee36eba393fea7745506.camel@redhat.com>
 <f70b4a3b-1ac1-4269-ab7c-0ed1fb42c357@open-hieco.net> <CALMp9eR5jVLGeQck89kro1ocEX5aZcovdGMK+fuzXjqK1NR7kQ@mail.gmail.com>
 <CAA0tLEpxE-YAigp-j6jC4pyQTv9vOPbs030Fs3kVFkczC9Etkg@mail.gmail.com>
Message-ID: <ak-raI43liqnqGKb@google.com>
Subject: Re: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
From: Sean Christopherson <seanjc@google.com>
To: Venkatesh Srinivas <venkateshs@chromium.org>
Cc: Jim Mattson <jmattson@google.com>, Tina Zhang <zhang_wei@open-hieco.net>, mlevitsk@redhat.com, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026, Venkatesh Srinivas wrote:
> On Mon, Jul 6, 2026 at 6:34=E2=80=AFPM Jim Mattson <jmattson@google.com> =
wrote:
> >
> > On Mon, Jul 6, 2026 at 5:02=E2=80=AFPM Tina Zhang <zhang_wei@open-hieco=
.net> wrote:
> >
> > > I will take another look for the next version and try to handle the
> > > remaining pieces properly, while also making sure we don't expose sta=
le
> > > or incorrectly synthesized decode-assist state for emulated exits.
> >
> > Naples erratum 1096 seems to imply that the instruction bytes stored
> > in the VMCB are not necessarily the same instruction bytes that were
> > fetched and decoded to lead to the #PF/#NPF. Hence, in the case of
> > emulation, it might be sufficient to read the instruction bytes quite
> > late in nested_svm_vmexit(). That would certainly simplify the
> > plumbing.
>=20
> Would not passing through this feature when erratum 1096 is present
> simplify this?

I don't think so?  I'd be fine with KVM propagating the erratum to the gues=
t,
i.e. not trying to fixup the decode-assist information if hardware failed t=
o
provide it.

Jim mentioned the erratum because the only way for the erratum to exist is =
if
hardware re-reads memory after the initial fetch, and so exactly how and wh=
en
hardware/KVM reads the bytes is a micro-architectural detail.  I.e. the mer=
e
existence of the erratum simplifies KVM's implementation, because we don't =
have
to strictly read and propagate the entire 15 bytes from KVM's equilavent of=
 the
fetch phase.
