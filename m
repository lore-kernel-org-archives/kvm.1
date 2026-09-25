Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60B83AFAEA
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354997; cv=none; b=LEar2v70dRKMOZvP+XGYEoimNm0Dh1+clkSVLxQmdnyS/JYxEv7C1ms1AQsDxHIaqRgCZBjSM/N9Itd9wP1+xdn5bQ606ARdWzgMVWvL3Hb/6DJyHweFX1lwOOdMYzmtYfMVaUNaCATtyGNp9M9dPkqtkobR+Y/7CCfVVRuOdQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354997; c=relaxed/simple;
	bh=ybpnPiewI5hD8i1HJuxtluWtjfYkoFoAc7TBpg6MjJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dexahXWtQY0d1r8kLV1kV1zifruIb/J159ErYv8ShpO5hRhyAHqRqCRseRIMFDfHBJI3ubxytxzvywh+tjOdfn+ea9kIdcP5LBzsaNCLJsd7+Wt8FXh+pzQciSCBvoJeJ81o7RyVOofxGZHwN6csIYQDpt4hiJuNLN3St1v8omg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKLJaR34; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKLJaR34"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E011F000FF;
	Fri, 25 Sep 2026 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790354990;
	bh=CSR1dNFry5HDkFro5l0N2s8MlUG7mEY2ilKQL+nMXFI=;
	h=From:To:Cc:Subject:Date;
	b=kKLJaR34fiSv4I8ZiYf0KIoc1sSfB8yRBfZ77A7iY1Xqt8dQgJlahhcMG8TFwk8vC
	 1O1gVaTlFYe8qOxhhM+Uu9d6IuI24WG9m0Hc8qm/vdKaZXP55Ygy+wS9Q2PYUUrORl
	 iHoHhr4an3SFYZY+NtwK6gJAR5BzzG4A4lyXrE9bxNurAaT3uw+OhvUbZtw4i0iEn9
	 A+dMer/I0ACsdlVWYDP2Pw0Aw+VBzDS17CRXm3EiaTxQnVRI8B75KorS14GiR48Yn6
	 qW/qfUxd903nkiMbsSSP0cPP4hdXGSRpXj5EDnObyWzrQHOncPqlNpMSIQ63H6JEBT
	 9HAWT4uH4rCQg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Logan Odell <loganodell@google.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Tarun Sahu <tarunsahu@google.com>
Cc: kexec@lists.infradead.org, kvm@vger.kernel.org,
	Pratyush Yadav <pratyush@kernel.org>
Subject: LPC 2026: Live update BoF?
Date: Fri, 25 Sep 2026 18:49:46 +0200
Message-ID: <2vxzse2x46ol.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi all,

We have had some discussions recently about the scope of the KHO/LUO ABI
and what kind of backwards and forwards compatibility we should support.
The two main threads that I have seen are [0] and [1]. I have also been
in various 1:1 discussions about this with many people, and I have seen
all sorts of varying opinions.

While Logan has a talk about live update versioning on the Live Update
MC [2], it is a 20 minute slot and I am not sure we will have enough
time to fully flesh out the discussion. I am also not sure what exactly
Logan plans to talk about, but from reading the abstract, it seems to be
around the mechanics of handling multiple versions. So perhaps we should
keep Logan's talk about the mechanics, and we can discuss the policy
around ABI stability separately?

So I propose that we schedule a Live Update BoF. The main topic will be
around ABI stability, but if time permits, we can have secondary topics
too.

I see two open BoF slots:

  1. Monday between 12:00 and 13:30. This overlaps eBPF, Refereed,
     Toolchains, Device and Specific Purpose Memory, Safe Systems MC,
     Android MC, Monitoring and Observability MC, and DRM Rust Workshop.

     I think this slot is great because I think none of the overlaps are
     major conflicts with this interest group.

  2. Wednesday between 15:00 and 15:45. This overlaps with Networking,
     Live Patching MC, Confidential Computing MC, sched_ext MC, and Driver
     Core MC.

     This slot is not as good I think because I reckon KVM folks might
     be interested in the Confidential Compute MC.

So I propose we have the Live Update BoF on Monday between 12:00 and
13:00. The BoF slots are first-come-first-serve, so I'd like to book it
soon-ish.

Thoughts?

[0] https://lore.kernel.org/kexec/2vxzik5f311e.fsf@kernel.org/#r
[1] https://lore.kernel.org/kexec/20260904160009.GV4157646@nvidia.com/#r
[2] https://lpc.events/event/20/contributions/2613/

-- 
Regards,
Pratyush Yadav
