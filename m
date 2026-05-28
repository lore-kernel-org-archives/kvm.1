Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF923F39F1
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974469; cv=none; b=Ix0hxM1Y7C8BEz548uBOCwOb/zsju79W0LJJuzTxcccqCI/Tj4idAEQWWAfXa0xfqNGmOCyAF/BycpVUDpHCys4xiT6cYMh7spIsT1RIfIve5f5ke8wBaXfPLsFcd+dBCvQT6H+MvxXdtIA5yA9My2F1ZArPDXB/fw0bQzZVAtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974469; c=relaxed/simple;
	bh=KycBQ9WQVwk13VRyQWEJeBpD8BVbZhadC15kR85B8sU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nP53Vfas5yBPfEjWc9x8BVSnqhf0KbRGjaZybXM+Xe6MwK6ymKj5py1bVUZDBkOpq3N8qDiEuG0AifBW9C0VGk4+G79xjNGVgYkplvT01zYf67oUf8od4im2VwKG14L6GjYg6bOjzevTkUmkRWWBEBz24i4uCk7hEcCi+VNJqzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gurxxBX6; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gurxxBX6"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36641bb3d97so8097382a91.3
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 06:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779974466; x=1780579266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KycBQ9WQVwk13VRyQWEJeBpD8BVbZhadC15kR85B8sU=;
        b=gurxxBX6+6K6f5C+6c2Gkfv9KZkd2bWA6yZSZv7mTfvMoy8VkioCT0BM/NDXO6A6f/
         gWVi747qxB4Fl2Ny/UCOnZL9scQB6l0Jc1aGLrRJMrrqwUST4nN4fLE8PuYsrbTWONhw
         Yx+HhL6AtMAco44mnjmY6R5nC372bKZ+6aWxbDlImkjmbjQ5vQW6I5PWsTPX11FTT+Dk
         Dhfd5KLS9rcKx3lytrZglfKGEhpf9fIdzpMDm65QYQ7IQUfay3k6uzBHBeSXphl/hZcw
         5XSzWKJ+6mgBA2a3sTJW1PSPWJvuAK1YVUT2T2b4IMqthfM7bsSVZTJT/mi3cEgeQqVQ
         iW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779974466; x=1780579266;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KycBQ9WQVwk13VRyQWEJeBpD8BVbZhadC15kR85B8sU=;
        b=TLhTZZY5n8w9mLTjVFTIXiDYHgQfzmiM9y/14Ec7RblR6hm4/c4e8l8EBUPXs8251D
         A5R5ihNWVZE7J6dTxE4aNA22L9bzJEIihvLYYYBnxq2s+ZaoFJxs7ktQMXDjVBhQGGt/
         +ZkFmOYZCOcFWWN4Zr1qxP6Fl/5B5RjMmvC1HcNLMEmx1pjMC88tGtLC/If6Ak/o+e4g
         bCy2qdS6dHy/9fL3cDn+ZNCtjgfqFsJe5NXpGgx/cB+8QBk0zYV3oOPxHESsofSSxead
         X0q378a4icAAMLvkYH+vzClSTYWG4af/cpleiCWdONwSbePC+8CoKZFwNe0zfzMqUc1u
         EcSQ==
X-Forwarded-Encrypted: i=1; AFNElJ+p+j4X+SopOtQxR2vpjcntKlas85TxQ5yCQluMSMb3WJz5/cSuSkSjNlMKvC2E7HRvs+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgTOPrLuQay/vrB4ICn7OkJoYHOF/9hqjlmrYV4FGgIN6aNuka
	52lRDsPxxkAFH9yxtmTiHhfh0N7Rqs7DR7KwYSp+jk7g3TFdU28huQdIs+SMNLOPWgcB/1gU5fk
	YUnYrbw==
X-Received: from pgiy11.prod.google.com ([2002:a63:de4b:0:b0:c74:497:507e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:56ce:b0:36a:cace:a4b6
 with SMTP id 98e67ed59e1d1-36acacea4d5mr18554876a91.9.1779974465476; Thu, 28
 May 2026 06:21:05 -0700 (PDT)
Date: Thu, 28 May 2026 06:21:04 -0700
In-Reply-To: <476964db-837a-45d8-a647-c5a2ea8b0cb6@suse.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528113605.267111-1-jgross@suse.com> <a8f495f0-b4a9-42b6-be74-4fa9d83c7346@suse.com>
 <ahg-bEiwyqYTdWOD@google.com> <476964db-837a-45d8-a647-c5a2ea8b0cb6@suse.com>
Message-ID: <ahhBQDvyzHQfTCBD@google.com>
Subject: Re: [PATCH v2 0/6] KVM/x86: Drop "1" as MSR emulation return value
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?B?SsO8cmdlbiBHcm/Dnw==?=" <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026, J=C3=BCrgen Gro=C3=9F wrote:
> On 28.05.26 15:09, Sean Christopherson wrote:
> > On Thu, May 28, 2026, Juergen Gross wrote:
> > > Please disregard this series, there is one complication sashiko made =
me
> > > aware of.
> >=20
> > Sashiko beat me to the punch. :-)
> >=20
> > See commit 2368048bf5c2 ("KVM: x86: Signal #GP, not -EPERM, on bad WRMS=
R(MCi_CTL/STATUS)")
> > for a real world example of how things can and will go wrong.
>=20
> Yeah, with Sashiko's pointer it was easy to spot.
>=20
> Question now is whether the already existing cases of -errno passed as re=
turn
> value are wrong or on purpose.=20

What are the existing cases?

> If the latter, there should be a comment for
> that, otherwise they need to be fixed..
>=20
> Disentangling the MSR emulation return values from the "normal" ones ("re=
turn
> to guest"/"return to user mode") will be quite interesting with the overl=
oaded
> semantics of "1".

LOL, "interesting".
