Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087C939CCE6
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788375567; cv=none; b=d5JkaFPSn7rW/JOn3cHPXXqCmnrSOQXH60KoQtCs1bd/W+lGEt3VmwqAA59bwMXY3e7tsghfy4k9w15fKgCPd8YN+fITfNN1/Ga0PNWCkT1tq8RGM41mjM4OyFOxANkjc3EWJuHIkU/X9HlcvlCR3LlSTrLUA8ks8xZ6sbji1qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788375567; c=relaxed/simple;
	bh=7PXo5Wpu6Af+4MmXNKs6cxvjpFBlp65k3SMKWJ0KLLo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WMzkhLKOmcoQhKqlpFj7fq+mLZm8RQv8IT4OP0EEIzVuqHdgngr68Q3nr+fowhPepjr49RVNFPAWZRs1ZPsaLN57tskEO7O5kuqHyraFVdOioOVxx3bu4wqOUbcvMyCMpbTucLMyWX51bi1eVptTTVRWn1Lpd3lQPZYpU649eMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T6cFBFB3; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T6cFBFB3"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbedbd182f5so162438a12.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 11:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788375565; x=1788980365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7PXo5Wpu6Af+4MmXNKs6cxvjpFBlp65k3SMKWJ0KLLo=;
        b=T6cFBFB3iY0ruAJnVHREVT9QrOdXBiEc+0N3VIWcZm3zON0x6L2cRlzXBmg+LfzXtx
         pMoNGVHyTOJFWaxgJiiUbM8eLLVv3DbZYteqDymknDrtz5Er8aJUA0jqnhtQifHIrhSz
         xv/Bu9/YpWATZVsXppo/+KwwfuQeHOmRr+7QGM7RmByhzQK3XQqiVDxJx5X9ZtaE5VZA
         LAkrBy+pwZDzqYurqy2nJ6T6xEjeYwuZX4YkMqvr1fgfMCtqfdvRx6E96jben3/rgl0X
         sJTCzZDuXOF975KCUkg070C9qO5WBHI4tLNgJltieNFtenkfpkwEpak4i71UffGPOe7J
         RF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788375565; x=1788980365;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7PXo5Wpu6Af+4MmXNKs6cxvjpFBlp65k3SMKWJ0KLLo=;
        b=SzCe8MAOsZTs7py6BqdQf97nCdphv3yXNoujDlv0lMBLJT6Yton0hVwl8jDDadgDcL
         qAZkTvmGQdwcXoSXiNWR8Ax7AFeCfDCgx2AgSxK3t9XHVYCYwqQQIuIR8sBT+srDf/3z
         BCKp5M9Q7kObOWKGZUgTZDbPXRzkWQYwbUimcsJcVf1CcKP0fB3mmcEnqYaLVuP8nzVs
         LhhutPDSiqnftg1hRHAdBmzmQnnqi91qRat8Bwpi45srGhYszTWpom97BF4gqH+4RSmH
         /OCuNa2Nkwrt+kv2dfkFtjlj1f/74wjoLzgisf/qcnyUCVOEBDM/tb/+xmg+mOAvbdKT
         +eBg==
X-Forwarded-Encrypted: i=1; AKwUvBxFyE9xJV2JXcpOHm8CBZ+3dFwqcqsprfxCDUj6Cy1XghNNDWrelqCanL+QVxqGEmF/siQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k+bdV6tUjkjpuJ9F32L/iJmJ21EBQGonAx5PZ98F4kUkyhXBN5
	qXA1Y6ZGE2L6GoHtVy4qE/fnpLHEYsGoLg63v86CaEO5/vwiLPnG6C5CNxb2PP2MAmKqvz6P/Wb
	Q9fnQ2g==
X-Received: from plje8.prod.google.com ([2002:a17:902:ed88:b0:2d9:a2:2c28])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:987:b0:2cf:b9f9:18bb
 with SMTP id d9443c01a7336-2dafaf44dd9mr11183595ad.4.1788375565114; Wed, 02
 Sep 2026 11:59:25 -0700 (PDT)
Date: Wed, 2 Sep 2026 11:59:24 -0700
In-Reply-To: <92ddaa4e6e791773160d58348436739d6a0f23ba.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260831213632.81023-1-dwmw2@infradead.org> <20260831213632.81023-10-dwmw2@infradead.org>
 <37f8d783-3305-44de-8ba0-ab0d2134a83e@xen.org> <92ddaa4e6e791773160d58348436739d6a0f23ba.camel@infradead.org>
Message-ID: <aphyDNxosUIOCwbE@google.com>
Subject: Re: [PATCH v3 09/13] KVM: x86/xen: Use atomic*() APIs instead of open
 coded equivalents
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Durrant <xadimgnik@gmail.com>, pbonzini@redhat.com, joao.m.martins@oracle.com, 
	boris.ostrovsky@oracle.com, ankur.a.arora@oracle.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	x86@kernel.org, syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, suryasaimadhu369@gmail.com, lkp@intel.com, 
	nicoyip.dev@gmail.com, frn1furkan10@gmail.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imv4bel@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2026, David Woodhouse wrote:
> On Wed, 2026-09-02 at 13:41 +0100, Paul Durrant wrote:
> > On 31/08/2026 22:26, David Woodhouse wrote:
> > > From: Sean Christopherson <seanjc@google.com>
> > >=20
> > > Replace the open coded atomic asm blobs in the Xen event injection co=
de
> > > with equivalent atomic{,64}_xxx() operations.=C2=A0 Casting the event=
 channel
> > > to atomic types is ugly, but not as ugly as asm blobs.
> > >=20
> > > No functional change intended.
> > >=20
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > > ---
> > > =C2=A0=C2=A0 arch/x86/kvm/xen.c | 35 ++++++++++++--------------------=
---
> > > =C2=A0=C2=A0 1 file changed, 12 insertions(+), 23 deletions(-)
> > >=20
> > Not entirely clear why going to the trouble of replacing the asm blobs=
=20
> > in patch 8 was necessary only to remove them here but, if that's=20
> > preferable to squashing this into patch 8...
>=20
> I think Sean's logic in doing it that way is that *this* patch can be
> marked 'No functional change intended' as it's merely changing *how*
> the atomic access is done, while the previous patch actually changes
> the pattern of *which* atomic accesses are done.

Yep, exactly.
