Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793386447;
	b=OugP9cmUf1GWq3GOnV5JsXzImQjpcxNp/xkpWFCb7KtjVXikLlezR9sFs+EwmEx91hdc
	 DmlzrWqmGkQAMSGfGtd1flqXQ4IWyoe63po7otav0prESJxGaE3kvTqDyVAy+LNe7VZ9y
	 u9YGbyw0pftOTGxC/q2yaAlV54/AUV7e/drTAwQ3d5jX/80qMl4XjU9nvXD2gbSXlG/5g
	 4I6bE3G428I2V4/nnxEpgXgGAbH2+gErY34LS1uEY24qTS+gt1eUNZy7YUNzvspgAWwGA
	 5vP8yC+uNZEyik6ed1WQ7DnJQg+8TXX+i7tKjjCCSYbOU2iD0MQnabwbhXWph/GvBoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=u/p+CdNB031652mF8XZuXCF6muaar3ooWIvBYaXGN3c=;
	b=Lx485Reg+e76Z+8p9fPJ8Y84lwmEjwj5tw5u/3kvXNPgiUv7BVyY1wTL/dQ+jwNjjFZb
	 mWmCbMcxVgTuqCbmFTyeQJ9HjahsjoOJ6CSmYyrQtPmp2TLC1eMsfp2nuHgzDj3woaAke
	 anygxA8GhPCVTWn5daB/wQrqUfPIUTB07bvwePC1Rf7WfBoMR6ehRNNTTg6EZyyEO9AR8
	 yCNqCdYnsjpjpT/AlQjWc/ndfuDBvpwuLT90bQl3bjZHtqy2my8TApz4gxEtyNq2mDdql
	 YDU6SGdC0oWD/RWVfhvqbnHkByRepllf5zmoacY0vpfR1RW/Qscz8BY1gJd9/VVCt5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="cnRI/wVD";
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002DE606A324
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 18:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 002DE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cnRI/wVD
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab926c236aso909442a91.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 11:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793386446; x=1793991246; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u/p+CdNB031652mF8XZuXCF6muaar3ooWIvBYaXGN3c=;
        b=cnRI/wVDs05gS9M2Bq0RLbN+ADojbqHvUc87f7ibZ/up8TS9ooi7XFmypERgojXCMB
         Nku8VC3bOY33aAdfXQg9FmqxGQzv9cRZOEp8T9v8+b+mp4K2d9k/ZafQtAHgMtehPdp7
         x4CfRAWSC4w2DnJX7B+Sc3CUffw6l5VNkgRgFTNYdyLik/ssf+eN41sDXASLJnzJ4X2i
         JXMUNH3wQB9L5AByEY+aS/BauKzCUHHFLoo0nk+frQ+t6mUD+9/9E9rmRw4903/1OxkD
         QnYMFACSTVcv1f5Pl/7jzfFQG47zbMgHOsC6fIBNtnqGsRllKCc0iRCfBscN1SMKwkDD
         dOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793386446; x=1793991246;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/p+CdNB031652mF8XZuXCF6muaar3ooWIvBYaXGN3c=;
        b=f5Rj6k7kFiuBoY8++hndNLN1i9GlfNgwUgdv00FVZygmZzMkqX3qYGJsAbHERrjBzs
         pTVN+u3DO8PJIOUEQn7Q9EtW5YgsLrg3GDOkuNA9zsdEuTdZeluDa9/VQJDh958MRNtF
         Sz09qu5TWMWaLgbYr/erAsgIFjP7ftGS0O6eiDSg9HE8a4eLl1VZErUdqjL6OUBZj/gR
         tGiMwbN+fsQakMZiyvTe55poVZk4uxTIUqYfrZkJ8jgDrGEOre7N2PrFvabPNHfg/1Ah
         DExlrFJG6dm7mBcP/afbVecc9/L0KGoyrLtGXPTxk+F4ODt4coat1b/iRtYHF0JQy9pC
         EtFg==
X-Forwarded-Encrypted: i=1; AKwUvByVN1ijnQtSMYZAuQzccPNTKwcY/OJGCXmSK6z+DhL2THrdUDOtB5cUSQisJrvJq451vCs=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2P690avuwZqJFl1RHBM9k9LBAnFcAvVF3VyxIwTgFoQDdeWXm
	uti4vGsau+8hNyEYJNjyZTdlzsTsFKpgaykldyl+VqfZQhBBdwp4QZcERnMYNDVkq3USK0VV19T
	C+ysIsA==
X-Received: from pgkp2.prod.google.com ([2002:a63:f442:0:b0:cca:5338:9514])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:44:b0:3ab:ab5a:ef06
 with SMTP id 98e67ed59e1d1-3ae896f832bmr2783583a91.12.1793386446130; Fri, 30
 Oct 2026 11:54:06 -0700 (PDT)
Date: Fri, 30 Oct 2026 11:54:05 -0700
In-Reply-To: <CALMp9eS_XAyfRQ0aa7pGmC2t-=mbHA7rngWD9oqOB2U8AJZMsw@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030032937.2813-1-ma.mandourr@gmail.com> <auTnBZMSHWKL4j4b@google.com>
 <CALMp9eS_XAyfRQ0aa7pGmC2t-=mbHA7rngWD9oqOB2U8AJZMsw@mail.gmail.com>
Message-ID: <auTnzSiIihVgs8ha@google.com>
Subject: Re: [PATCH v2 0/2] KVM: nVMX: Don't let L2's LMSW modify CR0 bits
 owned by L1
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Mahmoud Abumandour <ma.mandourr@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026, Jim Mattson wrote:
> On Fri, Oct 30, 2026 at 11:51=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > On Thu, Oct 29, 2026, Mahmoud Abumandour wrote:
> > > When L2's LMSW exits to L0 but not to L1, KVM emulates it with
> > > kvm_lmsw(), which ignores vmcs12's CR0 guest/host mask, so L2 can cha=
nge
> > > CR0 bits that L1 owns.
> > >
> > > v2:
> > >  - Patch 2: order the CR0 store before FNOP and check L2's whole CR0.
> >
> > I'll send a v3, I already spent an absurd amount of time figuring all o=
f this
> > out.  I really hate x86 sometimes.
>=20
> You should redirect that emotion to KVM APIs!

Heh, saying I hate KVM's APIs sometimes would be a lie.  I hate them all th=
e time.
