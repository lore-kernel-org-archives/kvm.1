Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DE2364EAA
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784845866; cv=none; b=QwOkzcSw+E3gOBVjtU2XgoxfydoA3Dd1RR0p2TABlpCrP+qlGyIsC7hBde+LWG+INAVl72XG0OYTSOUvRuk34IxcQJeZweZsun6GwLOZBfyx1iWFmZMzVG6Xj5J18xmOU63fK/RXZP3cefL/l6aatwXicaVd7rhDL7VRSVR5QUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784845866; c=relaxed/simple;
	bh=RLQsNP3rI9SwpcKdLfGaORv7h6KM2W7G/Opl6Y9zdUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+Tnhw0AT86OeFXw6bdVtvfyNv4pOzNtm1a4sBA+KRYa9IWhxE/NimzRWZiWmqJYU+YX+aVa5iUmJXRbml7oSn8JTInKSHyaRdbqOuE6cnldiixGCnz4zD8EYCafTqpycKadLx04vsVbC2bAEzo7KEYoL78p3fwlARW/ws5VneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoRvO/pI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoRvO/pI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B1D1F00A3A
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 22:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784845865;
	bh=h0Mec8/GVZl0xwfSlHmKj3QfvJBgOauId4QfnpHUiNk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WoRvO/pIvftSP33s+TjIIK04RdirgQFNq3UYfkf05nGwxfuvlyvXGFzGBTT3dDYXm
	 xhMxqiq3uOrm0hELZh9KYbPnGQ8rzENcOYxeeu4tMXQ5rv/Z/PSov7pTZuhGQLIhPE
	 C08ncXdySev81r79Jpp7bOb3+dctXz3QoYaVAOfVh9PV4/2W6kw2cHSirzFZc651CX
	 qge/AJaICSuvHowudt/1jGbw0hm+8m8/y6iwB5wDAVDDE1J8Lrc8Rms4FZc7r1eM+M
	 aWp5Atcy8dYT3RNLu0ig16431HIfzVu/AEYDeHgA1BEo5QmAhXrAR4kQhxH83F/3Ay
	 IaBwuN+EaKcOw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so205267766b.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 15:31:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr1R9VDb2IETGIoI+3+KoAOk1lvybR582SaEi5sSMhnH674JMHR463sibekTQZgfEJgREM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvIHJSDbKeou3r/NOPvPHjXXVdCxyhvxQDqYsPiFr2Fre3mRIX
	b5x4KMp0AeW8uIC41NenJWp3LMfOZ0nVk3STjfv5D/6njC49FYHKAJjkvXvnmwD0R6d+Nrt13B7
	swhe3bAjUxx3Q+3HmaVAM1AgLgqgjC4g=
X-Received: by 2002:a17:907:608f:b0:c19:5db0:edd3 with SMTP id
 a640c23a62f3a-c1c50cf9265mr187233666b.58.1784845864122; Thu, 23 Jul 2026
 15:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629163337.1264881-1-hannes@cmpxchg.org> <amGpEEqxoLq/Y7ZO@yzhao56-desk.sh.intel.com>
 <amIcXrS7nGX-adpG@google.com> <amIrDncrL4K-JRBO@cmpxchg.org>
 <amIxyy4Vg_TTE8Y4@gourry-fedora-PF4VCD3F> <amJKOPczNMb96NJv@cmpxchg.org>
 <amJQAs3Bm99ZR_sF@gourry-fedora-PF4VCD3F> <amJgdSXxFk24e94p@gourry-fedora-PF4VCD3F>
In-Reply-To: <amJgdSXxFk24e94p@gourry-fedora-PF4VCD3F>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 23 Jul 2026 15:30:52 -0700
X-Gmail-Original-Message-ID: <CAO9r8zN2mPsFiRTPYOPTq3gTVZwsj5hODke4asTTY-jXpSioxA@mail.gmail.com>
X-Gm-Features: AUfX_my37iO8kg43fRJAMFzRp5ru5qgHtGIQ_-ffgL4wvv2TG3Cin2cd_aD6SYo
Message-ID: <CAO9r8zN2mPsFiRTPYOPTq3gTVZwsj5hODke4asTTY-jXpSioxA@mail.gmail.com>
Subject: Re: [PATCH] mm: mempolicy: fix automatic numa balancing for shmem
To: Gregory Price <gourry@gourry.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Sean Christopherson <seanjc@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Neha Gholkar <nehagholkar@gmail.com>, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, vishal.l.verma@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 11:45=E2=80=AFAM Gregory Price <gourry@gourry.net> =
wrote:
>
> On Thu, Jul 23, 2026 at 01:48:27PM -0400, Gregory Price wrote:
> > On Thu, Jul 23, 2026 at 01:07:04PM -0400, Johannes Weiner wrote:
> >
> > So the default global mempolicy is effectively:
> >
> >     (MPOL_PREFERRED | (MPOL_F_MOF | MPOL_F_MORON)
> >
> > which is just MPOL_F_NUMA_BALANCING without MPOL_F_NUMA_BALANCING.
> >
> > The user can't actually see that - because the MOF/MORON flags get
> > stripped out when it's queried (because they're internal only).
> >
> > Maybe we should just set MPOL_F_NUMA_BALANCING in the default/preferred
> > policies and document that the global preferred policy default-enables
> > MPOL_F_NUMA_BALANCING - and that if a user (KVM) doesn't want to be
> > affected by numa balancing it needs to set a policy to disable it.
> >
>
> Walking this all back:
>
>   - MPOL_DEFAULT is the default policy
>   - numa_balancing=3Don means enable NUMA_BALANCING on the defaul policy
>   - shmem was broken and did not respect this
>
> Johannes' fix is correct, and there are no additional changes required.
>
> Users enabling numa balancing while running KVM with shared regions are
> not getting what they're asking for presently - that is a bug.
>
> They should get the performance hit they're asking for (and then either
> turn off numa balancing or set an explicit mempolicy for those tasks /
> memfd's).

Does it make sense to add a pr_warn() or pr_info() to help users
figure this out when they see a regression?
