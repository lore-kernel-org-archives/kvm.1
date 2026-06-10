Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FA3213E89
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 01:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053383; cv=none; b=XBZLn1XzY0lZd0i3evTsI/3dHyBKMFo4SDISZQMuLysp+7B1AlXNncLzL0TCxGCet4/gV85OxGrfZ5sz82NfCphpVh8VN2Xngc9u19V7/rtus+0qDAuWH44M9U297y6VDdWdb0qrPP5+9NBkOxm5Fpk/2G6Nu+yZJBfPJIdTxd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053383; c=relaxed/simple;
	bh=PXwUzpnz4eBj1WQ+TD+5Uu7eVe3SvBw47vw4s43Pyb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/A/fqWjTuVk8FHLZakUJ0GZqdB04a/5ni7BHlEZ3Ps37rel2vukWQ2gBqj8HTZ1SoYZ9nDGoTWFiDZtSRRypRYxjSvBKjpzJU98nJcW6qhCJbhXeoZEJmwPXw+frAd4n028b/BSE/bP034MeS1+cwf5zTj9S5TR3hqOUO5Fjf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9IYAnaL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9IYAnaL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B161F0089A
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 01:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053381;
	bh=0KhZLWd/0WNr0F7B3z82wYcw7VkW/wRF2JhStKd6qGc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=k9IYAnaLaFA/Ferf7hpNISPaeRMMapMTVGaD+Uk0dsorce+GOVHZmQGZ6b8q5MAdK
	 zkjLBgco/Os6Wi3fEnL521/+Cvvcwucqr1O+wkEonO6G/cz1K4ReqM1T7bhDedK/Ew
	 PIxhBUBm0WWanf3tV3kU7Rl8RRKJuNsU3pneRkmG7Nv7ylwM426jTkWFUtXH9qeJAV
	 NFwvy5k8VH4fDuXeL3kI4HJ7GJzSFCkD1hHIYwz5iIPFm0F6y29OOX3mUSZoVwb9m8
	 I8D2hUak6VpH+p6qrH7AAc3ZSjFrS2WF8HUO9PPsKgE9t96gpsWDTIqZvqJrmJttvx
	 6/KaGoBN+OrJw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bed2b9bfa02so838953766b.1
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 18:03:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+79QpGUaSfW3Ca1hvmnHPjGFPv/TGlLJJq7N8VsTxJJzm6JguazQTRNpIxDmnOkfhPlns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzHCWdIHr+/bI2Pk/mmtdpJTw5/gPFaGwg+zrSTVeoJ/aEUS9E
	IUgmF+Vl+iKBlNu97D1Xo2JVluMhAGokEzSIbRmmYJYC6WbSSVVLT8hrIUhqdv/Q+nDkaMUn/mr
	GhGQL1pDqdz2hB+5UYZk+9qWbXMjsM/c=
X-Received: by 2002:a17:907:a0d1:b0:bd4:f3e2:f1b with SMTP id
 a640c23a62f3a-bf373df06fdmr1227534466b.32.1781053380857; Tue, 09 Jun 2026
 18:03:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610003030.2957261-1-seanjc@google.com>
In-Reply-To: <20260610003030.2957261-1-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 9 Jun 2026 18:02:48 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOKyCTxKWHU_3R2k=BLZOnVuG5SP1gtL3e1GhSp__XTBg@mail.gmail.com>
X-Gm-Features: AVVi8Cf94fVW99ygTy7zphWtzlwDfrmEtz3Tai05c7lW-4Om8PH9pQu0zHXNdj4
Message-ID: <CAO9r8zOKyCTxKWHU_3R2k=BLZOnVuG5SP1gtL3e1GhSp__XTBg@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] KVM: selftests: Add AMD PMU Host/Guest test
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 5:30=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> This is the selftests portion of the mediated PMU Host-Only/Guest-Only se=
ries.
> My plan is to get this into 7.2-rc1, but after the other KVM x86 pull req=
uests
> have been merged by Paolo (several unpleasant conflicts across multiple
> branches).  I'll either send a separate pull request, or see if Paolo wan=
ts
> to apply them directly.
>
> v8:
>  - Add a kvm_is_mediated_pmu_enabled() helper.
>  - Drop the AMD Family check.

Thanks for sending the new version!
