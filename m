Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF4234040D
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457773; cv=none; b=mRLtSm27wGh/RIjTFB4ZgC8HFMKE3AWK4WrxaD75JUcFH/mvCNX2h5YWPg+I96ia6jIh7JvKrZcNQHokAjd1TeSZTi2+mpZa62+4HpsGrnnr5/WIlnVF2Vr47Dt/V5I+5Xbr1YCE+hWoCwCJPQT89U5uWOsgBkWuEXqjyM3UnnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457773; c=relaxed/simple;
	bh=0x2URhZVNyLUMnaCJcyZpjyHlUxRNnCvJLXmuoMKMjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XT4DYr89Ji5rZOvgGEtWyeLowzQtTIe1WoD8MMj+fVy8lAuAsR54SrIpEnmYnql/J+pEnubuDYn0xD1XTOTpnFwQ5oa2vzmiPytkUKsmVEArFy4h1J572gUfujd2Sg0hCX1uz0OkrDqDNz93B5KKqcURA+I8CiFJp0NFPZAQVCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XEO4CqtS; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XEO4CqtS"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e04598adeso2552104b3a.2
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786457772; x=1787062572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0x2URhZVNyLUMnaCJcyZpjyHlUxRNnCvJLXmuoMKMjI=;
        b=XEO4CqtS8aDisY+Uw7VySRK0BIWEWbYHQIsFGfqni7rAGJbYKYNhet2im8KYQoPPuo
         80dW73Ssja6qRmy18juP6gb6zhSu1Ofp2Fe7BCBat5vCXXx/krQp2ubmAS2C8JPSxE5V
         X7HIT30zzpcncs3FC+i4eVeELwXtBn8YCbhR8AIeW55Db1LmKi+u9dw7gx2faf00mvmo
         l6QyQQtmSdouN0pXKR8n8fk948lJMW376Tmg/GalgBWPCTWGdp3hRlVEpnn91uD6dEcR
         AMLTwYa4Q70dYWszBdy2gWWTGGIwbPpPDt3yP9Nv/WNEaIN/0M3N8jOWBuGaUyMV2+7x
         49EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786457772; x=1787062572;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0x2URhZVNyLUMnaCJcyZpjyHlUxRNnCvJLXmuoMKMjI=;
        b=OsO27bQ1tQ0NJUuOh/RK1DFQ2u4RCPmbDZ846tr9+m7kEAkJV4aCmpZ6IY5HZHJGoD
         M2S4MsHfWL2wY0J1cZBANMvJ5KyTJZIXRtjl6sfVzC5W8cAq9kA6ULLZx/84hZEFKbpJ
         jOFRTSFk0xcztWGnWJ/8yP66kLi/u4uvN0Y4XoaQdKxHTjtxiyiRYcnub3q918AhYIXS
         dzWdDNO1MiYi6Z5yvfm9gQsV09hkLz3FTs+noo9oxr+4c7n9vynTfoIBjHkZZvGW9l/g
         0jsXfLd4KhqhvW16umvHmN+MsZQz65IKO6MQHLT/qCKVRRP+2YScjtPow3Eo5C9TyHyo
         JACg==
X-Forwarded-Encrypted: i=1; AHgh+RqseqRB7k7OPtrh4AVGsy6q+rDhOcl+A2+xQS6/BybgpxLVGI1fHF1UxI/I1rek5KV1GEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRQf69I4QAtxIMma9lZP/w8qwE7nnPUiOZEjF1AvRTSY39pjzu
	xEdqLRv6s3T6yRSlTyUTLXz1yysGlgkJWcyTFw0qDx7w5m84fX5gazvoczCvuopJVNWp7nDANBG
	BN/J2nQ==
X-Received: from pfbkm16.prod.google.com ([2002:a05:6a00:3c50:b0:84a:310d:317a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:f8b:b0:84e:4d6:78fe
 with SMTP id d2e1a72fcca58-84fa86b672amr4014025b3a.3.1786457771384; Tue, 11
 Aug 2026 07:16:11 -0700 (PDT)
Date: Tue, 11 Aug 2026 07:16:10 -0700
In-Reply-To: <bb9a12cc663130eb2caa8e839d0f6ca53d722d1c.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728144954.355376-1-dwmw2@infradead.org> <20260728144954.355376-18-dwmw2@infradead.org>
 <anoOz2rZ02KFk1l-@google.com> <acd9b32617f75d188c370a464a922af0d650d4f5.camel@infradead.org>
 <ano6-gIZtqMfipiD@google.com> <bb9a12cc663130eb2caa8e839d0f6ca53d722d1c.camel@infradead.org>
Message-ID: <ansuqrD2KwFuLWbV@google.com>
Subject: Re: [PATCH v7 17/36] KVM: x86: Allow KVM master clock mode when TSCs
 are offset from each other
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026, David Woodhouse wrote:
> On Mon, 2026-08-10 at 13:56 -0700, Sean Christopherson wrote:
> > =C2=A0
> > > > To allow different offsets, KVM would need to track a per-vCPU offs=
et to the
> > > > master clock and apply that in kvm_guest_time_update() (and maybe o=
ther places?).
> > > > Which is doable, but it's not clear to me why we'd want to support =
that (though
> > > > I haven't fully processed the back half ot his series, so it's very=
 possible I'm
> > > > missing something obvious).
> > >=20
> > > Because I want to reduce the number of cases where we have to fall ba=
ck
> > > to non-masterclock mode. Especially the ones which are driven by
> > > *guests* rather than weird choices on the VMM's part.
> >=20
> > But why though?=C2=A0 What is the harm to the host or guest?=C2=A0 E.g.=
 does it make it more
> > difficult to accurately migrate the VM?=C2=A0 I'm not opposed to allowi=
ng master-clock
> > mode with diverging offsets, just trying to understand why it matters.
>=20
> Accurate migration without masterclock is hard, yes. The
> KVM_SET_CLOCK_GUEST thing relies on it (because the principle is that
> you get the *TSC* right, then the KVM clock is just a fixed
> mathematical function of that).
>=20
> That *shouldn't* be difficult with offsets between vCPUs. Just use the
> TSC of vCPU0 as the reference for KVM_SET_CLOCK_GUEST and let the
> others just have their offset from that.

Yeah, my only (quite mild) concern is that we would introduce fragility by =
adding
yet another variable that needs to be accounted for, but AFAICT it's litera=
lly
just the tsc_timestamp in the shared data structure that consumes the per-v=
CPU
offset.
