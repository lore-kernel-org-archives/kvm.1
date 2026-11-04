Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821999;
	b=PQAyZ3QHCHpVRJ/IrkkISYfBIVmMUN3sYa/ObNgRcecn/e1RPWdsHKxfhkC4CTWmX+cb
	 EQmSN/sjsddw6beimSTdJoyhAxMM6P5D83Aj8hvCM+2Ur7dTE2oRRCLr410w6I5ZndvnC
	 Z92Y3JgRgSqxFliTa1qpQfGXEP6jjLR2wN9sJaz12KkEcxOXu5TJydUVou4sdGlOp0WiE
	 tYD8rcRLqw9vbAnmKW8xu5AfF6NK041wtVyEfhpQrylcFLR3CjpDGfqbzrStGMbX+F3WY
	 SxhqnUp+pT0uWuwUBQQz9GwFAxr5y/gu0sltND7k4ZzUWTeVUGd6sH7Xp5VAXNLmlEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=6/ZM+kSr71E5pYSORU1PeqM92yW7X1HiRlNL7QxACZg=;
	b=PC6UKKgnEcxqtTsZecrKD+qi90+Fda4ocK02VvENjLCW0wPyzg0fKRbUYPMh/iyznCHU
	 jH+xpwQWD/Tt12naJ3NpoTrN2444LZJ94vRgRjn73z5whGOMaDZNB4s0vYiz2AfCjDYmJ
	 PFJ7ZrasCwDrDCnKE5n9JfgBLzOZhmm0wD4/M++dxwxxld7r1ZlaXukGjTEHFrgT+NYtO
	 XY48o+uUaIbCxL0GeUuBqu49cWYKEyEaMGCVwieRXlPtz0KgbahtMXrCBTCDXvJVv+fLp
	 L9yGqjDZfUsQecqyhxbtp8x+Krb8epBsnqQ2HXj7m2QBMkM8jXpXBR7ErlkQLGJhtUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W6sYwyNA;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC0F6097313
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 19:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDC0F6097313
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W6sYwyNA
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2eac6e96bd4so17065075ad.2
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 11:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793821998; x=1794426798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6/ZM+kSr71E5pYSORU1PeqM92yW7X1HiRlNL7QxACZg=;
        b=W6sYwyNAxuQUEpjWv8f1oH2vG0MBnCjpJ9/AtYQncZ2Z6jPn4xuWM3v4EYR9NVm6fT
         kJlsieHkxnP/R7cR9ZfvNqyDtA1hw7cpOXvlth6a53CQ+7SUHe9kQWqvewcdNmc+V2K8
         YkJzX7xmF5R8+nfSQXz1Wv02fKkr4DCgGIoMkC5SFKqhwAvFx5iclvD1DXFluqYSyFLa
         9UwJdbtqIQaZOOTIHQFg3IBgq7WEwFOhRnwBXNHXOfQ9Q8pNwCgwodm0SwRh0oQUTAzS
         B/jB52exYbrGZShO80FqS9oxSfEk1akmtFA/sBBzyb5AfhGfn1OuEP7ObIKAu8eCkk9w
         PBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821998; x=1794426798;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6/ZM+kSr71E5pYSORU1PeqM92yW7X1HiRlNL7QxACZg=;
        b=1pS/OM5du8lTb8vhHfpYiJtxtwSh8quFwCoVnEpxLxoTFGPf3dBu++u63aAlU558Il
         sO33ULk7yk0QR1yDasyobR1o+9NpqSFQBtuDfjxoCwWWne5Fl+OsHHhZQDLmtUiJLE3x
         ZmS/2yMk5iatjbyAQPbFy5xziVdROlPCaugxBDOFQtF2bq4uKHmjcsK9V/oeKYMw0ARY
         4Or84GyEP7tAu6gE9fH1azyekTHEm41d2BWxzQ3iKIAydHL8HwHPtTYlFLM1XKhwif2m
         20BN0aCx38HZ+UoJIIeTvINyxHQ0EPGYrNtEoKiHuU0boOE46mvz9gptrJ83LOrbHA0V
         LQKQ==
X-Gm-Message-State: APuU4Z/nfxXFwECf0Y/v04wi+yeSaHpCELBMRjo9fENlM1UTLvHq9Fqf
	Iqg7OBtl6pHh3RMYhllQx0GJEripiqSeivnHeVQOt/YF3hUo2RLIgZeZKJxsmQb7KXnUtYPRZBY
	jWGSiMA==
X-Received: from plbkm6.prod.google.com ([2002:a17:903:27c6:b0:2ec:f25e:f5dd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db07:b0:2ea:cb4f:fd3
 with SMTP id d9443c01a7336-2eb36401dc1mr187678735ad.4.1793821997670; Wed, 04
 Nov 2026 11:53:17 -0800 (PST)
Date: Wed, 4 Nov 2026 11:53:16 -0800
In-Reply-To: <20261019162445.37219-1-dwmw2@infradead.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019162445.37219-1-dwmw2@infradead.org>
Message-ID: <auuNLC2BJRpJZKA6@google.com>
Subject: Re: [PATCH v4 00/12] KVM: x86/xen: Don't drop event deliveries which
 race memslot updates
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Durrant <paul@xen.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, Fred Griffoul <fgriffo@amazon.co.uk>, 
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> Sashiko analysis and torture testing of the upcoming conversion of the
> gfn_to_pfn_cache from rwlock to atomic SRCU=C2=B9 highlighted a pre-exist=
ing
> problem: refreshing a cache can fail while a memslot is briefly marked
> KVM_MEMSLOT_INVALID during a memslot update, causing kvm_gpc_refresh() to
> return -EFAULT. The Xen event channel and timer delivery paths silently
> dropped events when this happened.

Gah, sorry for not reacting to versions 1-3, I completely misread the cover=
 letter's
subject or something.

KVM's de facto ABI is that userspace must "pause" vCPUs when modifying mems=
lots.
KVM obviously needs to ensure racing updates don't harm the host, but beyon=
d that,
it's userspace's responsibility to ensure vCPUs can't see mixed state.

> The first patch is a standalone fix which the same testing found: a guest
> parked in SCHEDOP_poll with a zero timeout halts holding vcpu_run's
> kvm->srcu read section =E2=80=94 unlike every other halt, which drops it =
=E2=80=94 so the
> VMM's next memslot update hangs, unkillably, in synchronize_srcu() until =
the
> guest deigns to be woken. A memslot add which normally completes in
> microseconds blocks forever.
>=20
> For the KVM_MEMSLOT_INVALID case, in some cases we don't really care very
> much: the VMM should really be using the KVM_XEN_ATTR_TYPE_SHARED_INFO_HV=
A
> mode which doesn't depend on memslots at all, and more faithfully represe=
nts
> the Xen semantics where the shared info page exists whether it's mapped i=
nto
> the guest at any given moment or not. But we can be more consistent, and
> more intentional about it. So...

I don't want to be more consistent or intentional though, because that risk=
s
signing KVM up for something it fundamentally can't support.

See also: https://lore.kernel.org/all/20220909104506.738478-1-eesposit@redh=
at.com
