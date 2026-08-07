Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C614570C4
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 22:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141110; cv=none; b=svJLgHfBaDxnBrWhCTSsC73u1I69B+dPXR4JQ38ZxGXsOU0sl468DYT4/e/7yYf/s/dwYTlfp9muqJZwnoqBeIg5PE7i2uWQIadA6yLwAbL/AM0qQpFgps65bWlsL+ULJy6W0DUJIM7mWrz1fE/uRUycrvo+yq5QpLHgS72DwYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141110; c=relaxed/simple;
	bh=UaZLKKYAR0Bykvjw7Qw7kvekD6nDm2+d1Ld06FHPdAo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y8PUDHG/3zvXS0i5kNrABhhHiobHEc7OC4bcMcQrniONgYqKrkmcnkzMzmyZhFnM6WVfg8/OmVmgr0xfp6FqblKG60CSltfghLRG3NLvYxuJ4ZPjdyXQ58/9MspFWJC3bJ3wqhxbCTBh8eoHqq7/FMxp1ZxBDgwsEVsx1gB/Lio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k5dPZ4XQ; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k5dPZ4XQ"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84a67b16217so28103b3a.3
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 15:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786141107; x=1786745907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lbAbat6Q7esV8SJCpy/SV9WJwrsxxo4l4sIA0GuCoM0=;
        b=k5dPZ4XQ7LnhelJL9zvtHR5ynb3Mh+TXa7YG2Ea9uTZOJDiXMjpTWaTFvjdVFbQvxc
         Fj7BEQgR/TM1zqteaLvRuTs/5fxSy2U7oPr5Z37if0QyFbuYNHo0CjJoHOUz1IZogBWb
         pW51gURip6vhOhWQhNSuqmkw4BNe6YWNJnuCRjBFHIFcAT8e3ahCYPooMz4z+v3fSdoB
         zEOSzabSW9RQ4jvBp5fOIgZ/WWdfqCdEmhVFuNiyKESmCfPAIx0noShABraMrmgSea+T
         /Y3PYuakp7c+NqpeA6Ge6GUcS3X271mWuWvesNPsQAdVaYB1YMZynr70hYvE3Zc7sNUW
         /cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786141107; x=1786745907;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lbAbat6Q7esV8SJCpy/SV9WJwrsxxo4l4sIA0GuCoM0=;
        b=Z6Iy1HBmD2EyNCs37JPE9l3gSV51xUEOq7D5W0CBlvYg7h1JQXVlVkdFjVCBWE7DlR
         09VNvMjvY/F8+Fb+B4nhZEKZ5pGybXVUlFuFIKMCM5e1Ry23kxuoejg5r82Nph4/jMEv
         fkPXBzI8Ams/zyNMXQETeIL+8nvnPfCB4qqUXQCQA3nEvkkCklG15Qw2l84YGNjTZIFS
         r6Q/khzKW03rYJmi8Bm3/pWevhjNjV3zvdjLbsNp6dmSADP6dKA4bK4QrznG9F77LcQ3
         P9yHmGgTHV+KUIxJm0JFQlxEMOHSOnGrAjxkpAJjz+JrlZXIz0PlWUNQqCzwH3ax/w69
         MbLg==
X-Forwarded-Encrypted: i=1; AHgh+RqvLjaPHeQW2i3ivq0PBfN/QgsMG/5KAg5TO+kWSqFaD6UTnZsAH/8aigeBMF+UhlSKLy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8DlObh0A58trv0WbWCroQX07kVQxE3vgF9yQ7mdY575fVJIRq
	boMf6QbnLHCOAs8ghQMJiGtG4whhNYk1sZmK1R442XFg+Dg9PPrq9K24p+KgcoKpQLkfmXLZ+HS
	icBIKEg==
X-Received: from pfbgh5.prod.google.com ([2002:a05:6a00:6385:b0:845:48ff:3362])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:987:b0:847:8b1d:230d
 with SMTP id d2e1a72fcca58-84f69421bcamr3113008b3a.3.1786141107295; Fri, 07
 Aug 2026 15:18:27 -0700 (PDT)
Date: Fri, 7 Aug 2026 15:18:26 -0700
In-Reply-To: <a05089fa3c5aa0ec9cdbd88d8aefc7b9ffa77e0d.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806214050.78058-1-seanjc@google.com> <20260806214050.78058-3-seanjc@google.com>
 <a05089fa3c5aa0ec9cdbd88d8aefc7b9ffa77e0d.camel@intel.com>
Message-ID: <anZZsiNZAxcg3FPH@google.com>
Subject: Re: [PATCH 2/4] KVM: x86/mmu: Harden "map private PFN" against
 unexpected root invalidation
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kai Huang <kai.huang@intel.com>, 
	Yan Y Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2026, Rick P Edgecombe wrote:
> On Thu, 2026-08-06 at 14:40 -0700, Sean Christopherson wrote:
> > @@ -5199,10 +5195,21 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu=
 *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> > =C2=A0		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu))
> > =C2=A0			return -EIO;
> > =C2=A0
> > +		r =3D kvm_mmu_reload(vcpu);
> > +		if (r)
> > +			return r;
> > +
> > =C2=A0		cond_resched();
> > =C2=A0
> > =C2=A0		guard(read_lock)(&kvm->mmu_lock);
> > =C2=A0
> > +		/*
> > +		 * Because slots_lock is held, it should be impossible for roots
> > +		 * to be invalidated after the initial MMU reload.=C2=A0 WARN, but
> > +		 * continue and re-reload the MMU to try and keep the VM alive.
> > +		 */
>=20
> It might be a little confusing when no MMU reload follows the comment. Ma=
ybe
> mention that the MMU reload is above? Either way ok to me.

Yeah, I don't love the comment either.  The subtlety that it doesn't captur=
e is
that KVM_REQ_MMU_FREE_OBSOLETE_ROOTS doesn't actually mean the current root=
 is
invalid, just that it might be invalid and the vCPU needs to check.

How about this? =20

		/*
		 * Because slots_lock is held, it should be impossible for *any*
		 * roots to be invalidated after the initial MMU reload.  WARN,
		 * but continue on; the above MMU reload will do the right thing
		 * if the current root is actually invalid.
		 */

> > +		WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu)=
);
> > +
> > =C2=A0		r =3D kvm_tdp_mmu_map(vcpu, &fault);
>=20
