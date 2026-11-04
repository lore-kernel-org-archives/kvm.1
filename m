Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830557;
	b=Pq4hQoyMzyhp28ox6YIbFTpcuMDtqm5oGSw6HQxHdiK7zNaN7gu7beidSRLtxxg3eljm
	 xut/k+AAqJ7Fwure934rGambXPNiSvtleRR7kXrKuG0Ip93giLyH6mU3Mc4lxKYspOYoo
	 Me/YbOXIkKFa4/g9j5Dmprj2+yzMVx88PpLRA8quu/9l3TAiPnMJ9nsBA+FRqYGs4RmQj
	 q7uUUMSVNc63EfeFacrGSKXazFgesLKytVDVK3BPURJoz0uGNr5NrO8uyK+b9LMDM54Ql
	 2YcZqZKrq52NbVGaVrKL0Qz9anumNgnZKtOf2NdItMzPS++kjbFtFTNf69uvSWK78xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830557;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=e9Al2DEvIWLb6MWcheqyXmrjikqbykjExztYBLPRPTY=;
	b=suW6C4wL9ZbHXc+xnGk7tc9liYRTidbZm/jzoRJ92GNmJnUyoRsiq/wFO0PEypH0o01S
	 JGPN8RwC8a4mtj2Y5sNo6ZdpVkrbe3yVgOzI+V6JEwkvvFuoT6gSxhJqGxvezCtUOqHjE
	 keUaxqqeWm+QQDdIQYMGMPjHhqhjtbsqHK5fCYS8lRI+bdmKW89WaYB71J4oeQs8Sf6eA
	 QhNCP+O/rO92+A+8BrLk5YMKzs67s5lSidawycmKsMsAaq+14QY03EB0QLFRsGmCTjaWY
	 ZAbMosmv4LOVPt+tpyz7CvteI+OgmkWfzca92lIE8QhAYib1ROTY8Wf2PMpMYEdThmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LPrGVcha;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464D1606AB04
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 22:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 464D1606AB04
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LPrGVcha
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ed276af91dso1916375ad.3
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 14:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793830557; x=1794435357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e9Al2DEvIWLb6MWcheqyXmrjikqbykjExztYBLPRPTY=;
        b=LPrGVchao38f/SC+Kx9VugPICoxtMEPaCao5/c92/o1Bs8B/BIu+4gtCfeX3e3gyLd
         Z3o4jqUFbAXFK8HujH66pWdUMmxYxgsf9SPw7Jt8ZoxqoUcCbMikYmtlnXQpBH+3J1m2
         3aENwqZ/9DjS/k2WO1q8pfqKv39uVLlxNH0jxS28STi/1Xd21DJKH3xPRWKsLl3E6Bz3
         GtlxX9Y0PJST+9xpuRkwGl6OBrdTOUBsKEn2pwrUsAWWb7PRRY5zxpE7upKmJ7i63xxH
         gmqBGFhGgh7SC4GyfSoyTO5KEs+GXPKuJ9gsaTciS/Ww6PWriMd+2GzOaeuqEf0qbLG0
         tGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830557; x=1794435357;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e9Al2DEvIWLb6MWcheqyXmrjikqbykjExztYBLPRPTY=;
        b=GMzJDXQqch6yO0WPkbcWhUVRIgU2Y5ievqN5NZJ+pVRiqvnmO0s4O7SppH3dCHFSFW
         K4IrUjkq8q85oCJ3kh3oh0TfR/E6noSvLvzWdQwQ93zohLJ8Y2a6QeKQXnf9BS/L9ejw
         0Nm/Nw0jlDEIW8USnZXAjN1dBDSFrnp1F9aWttW2nfwZjxNHHYYia/OARkzzF/+tsbsv
         YCquiGJdVSOFFiJiolQv9kVbEGjMkHIOBC8ErN5HbEqDKHePW74J0RhnXwvBBhzG0mrv
         NL83j/Lw2XNQ4VhSpcZcpgwIbgrgB//M6iAcE/Da+Ydqj5qiibG3tzd0MiGiYQNYGolq
         hUmQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJhODIMAB7K45lrR9ONAu5WHkYlTyxV5TBp/OO+RlrstyliIa1RJYLHIFykA1lT0eLxZk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8U35K3IBcIdM9kaDen1qqX6voLNpHjbAWGFhKDaU2ZgzT+ZR/2
	wYFXO2AoSpEKK2mXzApenjkeHB9wIAFNWvIlAzPf+r5yOHbcC0Gs6fmq2IUg74fxeNwFD5CMvwM
	eK/xjCA==
X-Received: from plbmc12.prod.google.com ([2002:a17:903:2b0c:b0:2ea:7f9c:2ce])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e84c:b0:2e9:4008:6fda
 with SMTP id d9443c01a7336-2eb364b5c4bmr178143285ad.28.1793830556445; Wed, 04
 Nov 2026 14:15:56 -0800 (PST)
Date: Wed, 4 Nov 2026 14:15:55 -0800
In-Reply-To: <CAO9r8zOa315UTmR4fbGzyHMtKDfUjW=6ehTrdA9js+JOAb3d7w@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <CALMp9eSuH1xe7PQ_WtE9DjqWjnKanFD_AFiiR9rEYkSV+sj45w@mail.gmail.com>
 <CAO9r8zOa315UTmR4fbGzyHMtKDfUjW=6ehTrdA9js+JOAb3d7w@mail.gmail.com>
Message-ID: <auuum7Dq0w-swARW@google.com>
Subject: Re: [PATCH v3 00/27] KVM: nSVM: Optimize nSVM TLB flushes
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026, Yosry Ahmed wrote:
> On Wed, Oct 14, 2026 at 6:23=E2=80=AFAM Jim Mattson <jmattson@google.com>=
 wrote:
> >
> > On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
> > > This series optimizes TLB flushes for nested SVM by using and maintai=
ning
> > > a separate ASID for L2 for each vCPU (similar to VMX's handling of VP=
IDs),
> > > rather than sharing the same ASID and flushing everything on every ne=
sted
> > > transition.
> > >
> > > The series also drops the dynamic ASID allocation scheme and uses a
> > > static ASID per vCPU (or two if using nested), bringing it closer to =
how
> > > VMX handles VPIDs. Modern CPUs (Rome, Milan, Genoa, Turin) advertise =
32K
> > > ASIDs, so there is no need for dynamic allocation.
> >
> > I'm not convinced that this is the right direction. It's almost always
> > better to do things locally when possible. Why not keep the per-CPU
> > generational allocation, but allocate two ASIDs per vCPU=E2=80=94one fo=
r each
> > VMCB?
>=20
> This is what a much older version of this series did:
> https://lore.kernel.org/lkml/20250205182402.2147495-1-yosry.ahmed@linux.d=
ev/
>=20
> Then we moved on to per-VM fixed ASIDs to align with SEV, but the
> tracking of "which vCPU used this ASID last" was annoying, so we
> settled on per-vCPU fixed ASIDs, similar to VPIDs, with the caveat of
> not being able to disable ASID (Hence the fallback ASID thing).
>=20
> Other than alignment, dynamic allocation of ASIDs means that we need
> to handle the possibility of ASID reuse, which imo introduces more
> complexity than the fallback ASID logic, patch 10 lists three very
> recent fixups that we need to handle corner cases with dynamic ASID
> allocations:
> https://lore.kernel.org/kvm/20261012233638.2546339-11-yosry@kernel.org/
>=20
> There is a 4th one that was sent after patch 10.
>=20
> Also, the dynamic ASID allocations give the VMs more noisy neighbor
> power, I think the ASID is reallocated on INIT, so a VM can trigger
> running out of ASIDs on a pCPU and flushing the ASIDs of all other
> VMs. Yes, we can handle this in INIT, but the problem is completely
> side-stepped by using static ASIDs.
>=20
> > This would eliminate the need for a fallback ASID and remove any
> > possible concerns about contention for a global bitmap.
>=20
> The fallback ASID logic is annoying, yes, but it's only in a few
> places. I don't think there's a risk of real contention in most
> practical use cases, we can run 32k vCPUs per pCPU before we run into
> issues. I think we will hit other scalability limits before the
> fallback ASID becomes a problem.
>=20
> > Moreover, it would be much simpler to implement.
>=20
> The delta is smaller and simpler, yes. But I think the static ASIDs
> code ends up being simpler to reason about.

+1.  The per-pCPU tracking might require less code, but OMG is it hard to r=
eason
about.  I also hate having completely different schemes for VMX vs. SVM, it=
 makes
it extra difficult to reason about TLB stuff when looking at KVM x86 as a w=
hole.

The other big argument for per-vCPU ASIDs is that it will allow us to elide=
 TLB
flushes on task migration[*], which might not be a major performance win fo=
r bare
metal, but it can be a significant win when running nested.

https://lore.kernel.org/all/aHWjPSIdp5B-2UBl@google.com
