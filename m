Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00023A48C5
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789767146; cv=none; b=WExyEXK5cPqkhpX3OWIF9GxrfBEjkkpu06epZvGj0OI25TnvA6vzlfQCtUCcsllx5BKp70LK3rB8PWjceSGrDdlMvzhdRV2KaBSFQt+Qon2V6RdToKGHb7DYYaWmACqi/+ozJ/tbjJ0/ReKGvqy6Cib6sGYZa4pUQYg+b/N3sBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789767146; c=relaxed/simple;
	bh=i+AIJ7kveZ6bTwB9nAnv/K3Y/I8+LS/Dr18pfaPSPIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EPhIpKMqOCzuF98k1t88PHWcxYRtEkj0QqzOs1kxqCapvFRbOqcrPK1u6wp2OAQuw0oklzaP6sPh9yP9x0SPaKpMzsnqsnFg9ngL27oTBkhI1LVLWpH9G9rtlKpx7IzYQWG+wpzzpQ2ToDjfDqOjv+MONpDLyKH3WW3sszftNJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ryvLFuk2; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ryvLFuk2"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccb687f82eso16973705ad.3
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 14:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789767144; x=1790371944; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=njzJ20D4uLqX8b8VhscD9ctvL+AlXe9kGWUy4cyvKI8=;
        b=ryvLFuk2Bf2OInmOAWjxPnJH3jTVsowrVBNDZk8i74UjmNKikEmKoVlYUxPGFounFA
         FpnesZ2KPjsKxRuA/UpwDWOihZoOPI54qmpinS8Hz3V/U90ZNOXsa51/OX3Gu3Moc78f
         Dsa4+ahiFTuVVTF/EErxIcIUbUZ53zDuwNaCO6P3Rsd8ZIP+Su088+9DMBKS/78L4LpO
         FK5RadGlm7fmTnXX/f+8It9UutMcHfxZIngYp5dcPWndPcYJ6/nA9dBEc6kEGCDY934O
         dLqB8IX8MuO8Rjuiq78kTFbG81WQlgl+vcG59gYWZ5NxQu+9RL1etuCpxR+9Lckahuha
         baMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789767144; x=1790371944;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=njzJ20D4uLqX8b8VhscD9ctvL+AlXe9kGWUy4cyvKI8=;
        b=P8nq7mHQtMiIF/5dlrp0rfjhbHTjJ85q33op6v4lENVLKoYYpDlpLd6Cb2rikkUwdY
         PYk8IKXDERRxu2uFjBXhMYx5+4XN4RlHlM3LyRlcnpmU99WjRU863xSuO65cNw4Pmm2S
         niEYKDYjzHb36H0d+PrfqFzC+Ike12Xx1U192R4FhKfJ0mMRXNEfxypRQ/S8E3UkDYfT
         Ehjd8uy7zCLW1tgktK5EJCts7E19dU+X+GgWOc5tJTKuoelkKK1v1/vrjxa8XLlqbzzO
         Cixs1pEBD1zwV/MDEttmE9LbX7r/aYRo4ALSLrjOmaEkJewT0Ah7d3ZPORmYmWApJgaz
         OhJA==
X-Forwarded-Encrypted: i=1; AKwUvBzSsECCkqylwj6u47kSZ2hhZ1d8rYrCebluLkhcFyRPNrAdoFtU2HMkJ0HvzN1ScNt9Lbo=@vger.kernel.org
X-Gm-Message-State: AFuF++nnOObUTWpXoWo/zC/h4Zl6KeSG0TErw2oXgFWc48Xk5AKGdQhZ
	YkgULBO1dSPNKd8I+Ia7zt78kAJt+dBqAkcyfRk9NimmbrybeFFWIlLT1E1nrbpNEhrhvxhVNVK
	iVIGGLQ==
X-Received: from plbiw23.prod.google.com ([2002:a17:903:457:b0:2dd:bf8a:52b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19cd:b0:2dd:c100:b2bf
 with SMTP id d9443c01a7336-2ddc100b30amr11139185ad.42.1789767143896; Fri, 18
 Sep 2026 14:32:23 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:32:23 -0700
In-Reply-To: <7d40bcd97e01390a345ce1dbe26264e7b064a619.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aqss_eQAY7soHRwJ@google.com> <28f7a805c57da35d86b5c495cdf2b613a61d235e.camel@intel.com>
 <aqvtG90zWq6SkU8L@google.com> <3f97caf660cbe460b8bbaf3f2a72e4b6a3ea83d9.camel@intel.com>
 <aqxGN2Zc8sOl2RKx@google.com> <906d0cb6515b396f4e9d74f1d546c902ea3ce49a.camel@intel.com>
 <aqyAED5ZK48eEZtq@google.com> <56a61983c03806120e607dfd1e1b7c9046c1f54b.camel@intel.com>
 <aq048KmPN5WPQ4sQ@google.com> <7d40bcd97e01390a345ce1dbe26264e7b064a619.camel@intel.com>
Message-ID: <aq2t5wJGLtsltMza@google.com>
Subject: Re: TDG quote analysis
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Yilun Xu <yilun.xu@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Binbin Wu <binbin.wu@intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, "kas@kernel.org" <kas@kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Peter Fang <peter.fang@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026, Rick P Edgecombe wrote:
> On Fri, 2026-09-18 at 06:13 -0700, Sean Christopherson wrote:
> > =C2=A0But given that you say "This idea came up before actually", maybe=
 chunking
> > the quote operation isn't a big lift?
>=20
> The idea that came up was to have a saved state are per-TD. But this only
> eliminated concurrency issues in the SW based flow. In the future a HW ba=
sed
> flow would be S3M limited. Which is why I keep saying a redesigned soluti=
on
> should be robust to concurrency limitations.

IMO, that's the complete wrong way to look at this.  HW-based is inherently
serialized, it does NOT have concurrency, period.  SW-based is has no inher=
ent
concurrency restrictions beyond existing CPU contention.

Trying to find a perfect one-size-fits-all solution is impossible, because =
the
problems with each are so very different.  The problem you want to solve fo=
r
SW-based is how to support preemption.  The problem you want to solve for H=
W-based
is how to hide the fact that someone in the future might think following AM=
D's
lead and putting a precious resource into a tiny microprosser on a slow bus=
 is a
fantastic idea.

By creating these system-wide thread pools, TDX has effectively created a b=
izarre
M:N scheduling problem, *and* introduced a completely avoidable noisy-neigh=
bor
problem.

Assuming my understanding is (finally) correct, and the SW-based flows do a=
ll the
work on the CPU, then the only way making the SW-based flows asynchronous a=
dds
value is if the host is willing to set aside CPU cores for such chores.  An=
d for
the use cases where TDX makes sense, AFAIK no CSP *wants* to do that.  Not =
to
mention the RFC doesn't even support that, because KVM doesn't resume the v=
CPU
until the quote is ready.

> But now I'm wondering what your specific interest is. It seems you have m=
ore
> interest in non-KVM in-the-loop guest side latency than you did on host s=
ide.
> Which is fine. But it makes me want to double check: You want an average =
and
> worse case latency for the first DICE attestation "SW" flow?

I care about future me not getting pulled into a customer issue because a v=
CPU
got waylaid by a system-wide mutex for multiple seconds.
