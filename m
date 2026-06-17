Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAE4399CED
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781701242; cv=none; b=qU+PTr46i/kJB6jYxYI3tNWGrQO9/MmLwkoNe88ByX63OhsxPzrCLVzgqocE6pwTihNX/Z/om8qNRvlv1rabShHOqdk7vN3C2kxFXt9ban6V2cMEEwf+AbqOpHdTxowmZfoWzVg2cuOhw0EB3xtNRYGJjNnTZBqIMMuef8ZmLog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781701242; c=relaxed/simple;
	bh=v9AW9ttnyqMH8SLe1cvzY21GDBcPgzmm6bezz+XRKfg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jCpsA1zaKg5B3eRYyV1CCjWskS85w4dtG5GTxC3+eK1fMtGSl9VHPkFBhNuInuXkGMyGM1ED3hPNNZy+jdhdoq6JgjME4xrVllY0k0BKIKw7XCguFQ8hpFMLlX9WlCqow5zluxiwr4LtC4EONbC4vracypW0Ey0fHszXURULZds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zpfe6Cwl; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zpfe6Cwl"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84238e83851so3749922b3a.1
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 06:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781701240; x=1782306040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ot+PTpIfkC3BFgu+DoGlv5FhONUNAHAv7ldmmbQzbTA=;
        b=Zpfe6CwlF7O5Bw8U6CMBwFHXiiP5rCSt2GV9umLQDED0XhlMGzNlW7xa5P8HiJqM1J
         LqNsCZ5tk9ZN07+L4PWfYnrtSObmvbdu5tHXR0HhSXTWEuxHYP3e7opUGJ/sz8NaPYs5
         h0MDwT7/F8JuKqVM5wY4qJ0BMQCzUD8synxVRsJjtnEHs7EWhAK4wm2fe5Lvz4MC7Uug
         tkwTIGmJppVzEspYjsg+NohQZPhN8kRRysVWaFJlV0mpaK4UJtMD4OdqXY9xMa6Y4pkl
         V43Yy80cIQuzT09qvEqbypz4ACBU6PHF6cvs2gYA0aGLoh3CVppoU4aim19Z8XT0j/ck
         HqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781701240; x=1782306040;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ot+PTpIfkC3BFgu+DoGlv5FhONUNAHAv7ldmmbQzbTA=;
        b=NJoxkia1bjS42peljZ5N3vGq3TD6NA7KOCoQECUuY3Q8Y1xF70QX8GjREkhNaGqX1I
         JwxANW1zSSv548aUYZGNmSXfLP1s9FJkS5bTzaDCq5rLIeeYwSJeTRoxg7G4BPyLKhvo
         MA5uJOvohHKHSKnUnBtJV1jwiYREwTTfUuYt/ZhypYC/0gDA1qJGGaaqAYMCrKWurO/J
         ZUzPmf2lA2mGiMGwh0dqFpPvC03Zf9jk0vBGNKTytsq9ISA14yf/gHeQuMlw0KTMI3WA
         gHshlrkS2PhuRLr4X7tH49+2r/Astg2dv4BIhdtKNY6ClfFivMFgBwv4Tv+flpzuWvkn
         Uy5A==
X-Forwarded-Encrypted: i=1; AFNElJ/qoiVWayC2wuoO1ImaXsOMkcgqmnz8QQfHDnkVhJl32Ra7N0SnSWGv6+YvEYeFHuQDQpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPoL935DSt8Q9ZcVkkldk8ciHUDAbGR4tfpSvaWk17l8rTvBlZ
	OtGSANGk0Ej5jx6DxErtnlW4UlXd0uVDY6B1O83/iY/0UE9ly2eBmMcLrNSzPb3EbVovBUdEd7c
	XzjMRRg==
X-Received: from pfbmy11-n1.prod.google.com ([2002:a05:6a00:6d4b:10b0:842:4be5:5ed6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ca7:b0:83e:b443:965e
 with SMTP id d2e1a72fcca58-8452442926amr3817503b3a.3.1781701240120; Wed, 17
 Jun 2026 06:00:40 -0700 (PDT)
Date: Wed, 17 Jun 2026 06:00:39 -0700
In-Reply-To: <ajJAYZAPxNrrsiYp@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611123528.572255-1-joro@8bytes.org> <20260611123528.572255-5-joro@8bytes.org>
 <aiqtWVMqTK6vDoZ8@google.com> <aiqwjn2DVOumfr3T@8bytes.org>
 <ajGOELiYwKByXbVP@google.com> <ajJAYZAPxNrrsiYp@8bytes.org>
Message-ID: <ajKadxZEMI253AoT@google.com>
Subject: Re: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA at SNP_LAUNCH_UPDATE
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coconut-svsm@lists.linux.dev, 
	Joerg Roedel <joerg.roedel@amd.com>, Jethro Beekman <jethro@fortanix.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026, J=C3=B6rg R=C3=B6del wrote:
> On Tue, Jun 16, 2026 at 10:55:28AM -0700, Sean Christopherson wrote:
> > Isn't this essentially the same thing as hot-plugging vCPUs after launc=
h?  I
> > have yet to review it in depth (sorry Jethro), but it looks a *lot* sim=
pler.
>=20
> Replacing the VMSA after launch (as supported with the AP_CREATE GHCB cal=
l) is
> different because this has no influence on the launch measurement.
>=20
> The point of providing an initial VMSA is to get a predictable launch
> measurement which is independent of the number of VCPUs the guest has.
>=20
> With the current code KVM will create its own VMSA for each created VCPU =
and
> measure it into the guests initial image. This makes predicting the initi=
al
> launch measurement difficult (as it depends on KVM internals) and fragile=
 because
> KVM-internal changes always carry a risk to change the launch measurement

The same holds true for userspace.

> (which has happened a couple of times already).

Examples?  The SEV features thing jumps to mind, but I don't recall any oth=
ers
off the top of my head.
