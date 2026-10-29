Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793310745;
	b=AXkdaR9VYmZ9YebMri7y584KChYgmq+3pJjFaTw5al4uBYfO58ppW4oO9izib8OGHJZ0
	 mxgpHlAX8dtmjHsHFHL7GZLMYeSkb8ZIljy//C8zAIjn6zG0E35Gt2JrJRkIKwu1503K5
	 sTVN0emdTtG07xZHWGIFzDeKyufexmPMwx6lGn6z3XnYJg1NWtkZ3AAaQq8LiCSWjNnxq
	 jwHRsAHWEcxLSGOaYhXN6iODFXOXQoEsCcEmWc1YsMu4FbSb1D/Ji4dIxujj+59/Xm+98
	 zWly/ujQUK2UiZCvDi6ITY5Qkf8RprjIm/UVVAue437ts3zZMobr56zPa2BZDJGYVNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793310745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=9hubGuaWBIVJLpBbvvkgCy68Va0Ble3qI+p4rrOMI8U=;
	b=YXehTkJTTdlZ2P/UVTYhXmuPuWUE/ve8O+ZDk7Sp9PTA1WQbVDz3QuBk7EQh3RB29EFr
	 RzPDG8VAVOH/nxgz5g/JoxtM67OR5fkaTud5wSTjFtwcrrbEZJP0b4tYuU75P+X+Mnn9p
	 v3kUgKx4N0dsG1b53dkh9H/sTFvEH5otXaZdCj+1wfYMvUftHzbHoC8ClZnfrf9ARXDS2
	 y35SbTM1Idyp47tTmcT3e+nbt9aZS1LyfI72ijrQuw208KVwewnCTGyPy9Hiz0XMIhhoI
	 U/Nlr5vdwysbuC8fevNOQdqz1lIYKeXrmJkd9h8zDg1sMsxgZJt2LBPbPqP7r+n1e5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UoxpmelK;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42490606A31C
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 21:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42490606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UoxpmelK
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e93f266d20so1421515ad.3
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 14:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793310744; x=1793915544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9hubGuaWBIVJLpBbvvkgCy68Va0Ble3qI+p4rrOMI8U=;
        b=UoxpmelKpm9qa5OtKA90jq22WU41dhObIzezb/KbNxjp4D01x9arfXHeALX1Iu6dUA
         qh4EzHDCOPu6kRFUE5b/yVwfE00nZv41AIa4b0fL5/NS/C+6pxNJhLq4aH93SsHR/yQE
         MDpIhRbMfbmWOgMS7H2m3C86V0PEVq0mnr0Mx9ar5jQaY+p2HmFbT2U8mCAMopjeKueD
         tdn4mdb1JX6FN/7BTE9RUjs/eNtWXR9F7E+RFhmtUGBo+lddAmiWJZWP6ULgdIe50p8e
         iC4QZXXNIsF6pMajwI/5v8chznRe3nKCEUyKjq1NSJC68qOFe67YRDEUCXbVp+qUNvh6
         poJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793310744; x=1793915544;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9hubGuaWBIVJLpBbvvkgCy68Va0Ble3qI+p4rrOMI8U=;
        b=Jh8voot6P5Au9jAJ41tv8QU0fI/+Cd6Mjzb7hZ9/RdaiH2VxDN2sWkyL3QiXucozTu
         BycxZ9rpWgF0lSYnMNzQDdyCydcQNlj3Uqf6bz/5OfNde1o2gJbjQSgSHzZEUcb1SURI
         69cPupJx0ETSnHxIxMnN7JW03DZLLkALf2yybyku5uf8+W2/XhFMQBd+c8b00MxMLVHs
         bCF4Hn/FWcly6SWfITFxFH4otQY/kDJYoZjq+Q/zbPwmV/067iZYTNxPNFMnydpRLJA/
         HBGHanElA45N3CQ9M17d/WCUO6KwonMVJWAVaF7FE9py90ttAnFVwuHNUffhynM3YDUq
         nwBQ==
X-Forwarded-Encrypted: i=1; AKwUvBymXDgufORaKXj6+RpOf2vRJqOFTfgRTwsNYYpsansO1ZkZxtpXRa/E2hkT67AoLawBwzQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLXNgX6r2OBfg1aZlDRTxY4WCIlS68308QmcMOMDWjxoBbMTgWB
	/8A9ko/iErT3iNGDkPfuFeq9GyDW/2aG30QovpLve3AHUDRLTXdYfMSRxysfJEQjtzo91KiuTlW
	bFlTupA==
X-Received: from plrb5.prod.google.com ([2002:a17:902:a9c5:b0:2e8:8642:f035])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:986:b0:2e9:7719:40f0
 with SMTP id d9443c01a7336-2eb364962ffmr5977675ad.19.1793310744369; Thu, 29
 Oct 2026 14:52:24 -0700 (PDT)
Date: Thu, 29 Oct 2026 14:52:23 -0700
In-Reply-To: <CALMp9eTKXa9v1TxJMPrE-tSXajwJCErCk=g34dOPJtG057t5mg@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029202817.901145-1-jmattson@google.com> <auO4UueaV0mTVzzB@google.com>
 <CALMp9eTKXa9v1TxJMPrE-tSXajwJCErCk=g34dOPJtG057t5mg@mail.gmail.com>
Message-ID: <auPAFxXy4ulcK_jq@google.com>
Subject: Re: [PATCH 1/3] KVM: SVM: Check EFER.SVME before updating MSR_VM_CR
 on guest writes
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026, Jim Mattson wrote:
> On Thu, Oct 29, 2026 at 2:19=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Thu, Oct 29, 2026, Jim Mattson wrote:
> > > (Host- initiated writes are allowed to set any valid MSR_VM_CR bits.)
> >
> > Eww.  Why?  If we allow this, then we'll end up with the mess where the=
 guest
> > can't write back the current value (if userspace is being weird).  I ge=
t that
> > we want to avoid ordering issues, but there's *already* a required orde=
r here,
> > unless userspace ignores the failure from svm_set_vm_cr() and continues=
 on.
> >
> > KVM doesn't advertise the MSR as something to be saved/restored, and no=
ne of
> > QEMU, CHV, CrosVM, or our VMM appear to save/restore it.  So why make t=
rouble
> > for ourselves?
>=20
> OMG! I didn't look any farther than the obviously broken svm_set_vm_cr().
>=20
> It looks like svm->nested.vm_cr_msr controls nothing other than itself.

LOL, nice.

> It's just 5 bits of storage with some weird locking rules, and it
> resets to 0 on suspend/resume.
>=20
> What is the point of such half-baked support?

More than likely, so that older kernels didn't crash when writing an MSR KV=
M
didn't emulate. :-(
