Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515585476FF
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988637; cv=none; b=Znv+EfU1eH0sD3MFMVfGwum9Rw53nbUUx3FZDs+ZDbT24Yo9Gd/700s3ytqx9UT0Fv6GUlAiy8hQz08oN2zPhFHnAQT2XBPrr79LVXtmMALunnVCWP0pctnJ+2gQNlCjAnBozxurafhHJOsbKPfzVdc5CabcpmTxevgEt30XUBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988637; c=relaxed/simple;
	bh=vdNA7jo5ThQ0/g/Mvq3QFGhjnhcNF97t+CXdd3sFVdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLeiyje7HkACw9VvGDf3EO8k061K2k5Jh6KtfwNpsJ2tVBSLHgSO0p+wPDE073RD7vHagxU7100yRlAqm/rRY1mkVthx7Y+ROjOi7nBSt5q6IoxBt7gcT69GDl3XDlOH98Zcuz+qHkWgHO/9/B/ZWw+xp7BG6bDDIWftL8jBjOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7G61rjf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7G61rjf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49041F000C9
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 14:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791988635;
	bh=vdNA7jo5ThQ0/g/Mvq3QFGhjnhcNF97t+CXdd3sFVdM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=d7G61rjfSQ6LRia9RWZTwjVf0NeYOFhgoxMZ96Kl4PW5oLwnG8p4waY8n6FVzYFL0
	 4t2m0WBhhWY1Bhkb0+L6+pn/c3oh225lIjS50AZdgbffKK01YUaJQL74OCbxvuxycH
	 35egPYY7EdZGu9Ms3XwDiDuE8aVWdDDTruDHn64691jb5uQSA45Iw/JKi1epqj5B9Q
	 mub2x5u8+zFIdc5GpYlScxfxUAEZ26PXJs1ZDzsM+2qJAE71hAS+6zPNSSBk0tuLJS
	 2itT0aFDhebWT8wbWeaDP5lOG4f2iykvj6mXmCZ2iQwP02w7SBdEb/4OOmMGtbJiU7
	 Ea4EKMyvU0aYg==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b21cf1a580so277318a12.1
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 07:37:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBykvv2fCmyt9KbAXseWqEzqFH3i3fcr+9++aYbhQRTtglCcdnKz9z4b1vGsz1ygl9lqpBo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8j9IhFzfhuT1NedpqZpKAaoGZBS54DYW3fqr3QzLRLXFkKXgy
	ftMdNSW7CMixuXu6CY+IxwY5dRjagKhi5EsPRhl7a2cFlaeJdMmJgZbTuFLODIfvcnAUQxCBJR8
	dlLf4qO2UHjSZK3U9umPsZ1tsZIb+o4A=
X-Received: by 2002:a17:907:1c85:b0:c29:f5d8:9c75 with SMTP id
 a640c23a62f3a-c31aa091abemr1555431066b.36.1791988634791; Wed, 14 Oct 2026
 07:37:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <CALMp9eSuH1xe7PQ_WtE9DjqWjnKanFD_AFiiR9rEYkSV+sj45w@mail.gmail.com>
In-Reply-To: <CALMp9eSuH1xe7PQ_WtE9DjqWjnKanFD_AFiiR9rEYkSV+sj45w@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 14 Oct 2026 07:37:03 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOa315UTmR4fbGzyHMtKDfUjW=6ehTrdA9js+JOAb3d7w@mail.gmail.com>
X-Gm-Features: AclHuK8oDraLUPWMqArOWOtqh1FiQ5d61othfXt-SvNrn68twSc-YeznLDhqjGI
Message-ID: <CAO9r8zOa315UTmR4fbGzyHMtKDfUjW=6ehTrdA9js+JOAb3d7w@mail.gmail.com>
Subject: Re: [PATCH v3 00/27] KVM: nSVM: Optimize nSVM TLB flushes
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 6:23=E2=80=AFAM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > This series optimizes TLB flushes for nested SVM by using and maintaini=
ng
> > a separate ASID for L2 for each vCPU (similar to VMX's handling of VPID=
s),
> > rather than sharing the same ASID and flushing everything on every nest=
ed
> > transition.
> >
> > The series also drops the dynamic ASID allocation scheme and uses a
> > static ASID per vCPU (or two if using nested), bringing it closer to ho=
w
> > VMX handles VPIDs. Modern CPUs (Rome, Milan, Genoa, Turin) advertise 32=
K
> > ASIDs, so there is no need for dynamic allocation.
>
> I'm not convinced that this is the right direction. It's almost always
> better to do things locally when possible. Why not keep the per-CPU
> generational allocation, but allocate two ASIDs per vCPU=E2=80=94one for =
each
> VMCB?

This is what a much older version of this series did:
https://lore.kernel.org/lkml/20250205182402.2147495-1-yosry.ahmed@linux.dev=
/

Then we moved on to per-VM fixed ASIDs to align with SEV, but the
tracking of "which vCPU used this ASID last" was annoying, so we
settled on per-vCPU fixed ASIDs, similar to VPIDs, with the caveat of
not being able to disable ASID (Hence the fallback ASID thing).

Other than alignment, dynamic allocation of ASIDs means that we need
to handle the possibility of ASID reuse, which imo introduces more
complexity than the fallback ASID logic, patch 10 lists three very
recent fixups that we need to handle corner cases with dynamic ASID
allocations:
https://lore.kernel.org/kvm/20261012233638.2546339-11-yosry@kernel.org/

There is a 4th one that was sent after patch 10.

Also, the dynamic ASID allocations give the VMs more noisy neighbor
power, I think the ASID is reallocated on INIT, so a VM can trigger
running out of ASIDs on a pCPU and flushing the ASIDs of all other
VMs. Yes, we can handle this in INIT, but the problem is completely
side-stepped by using static ASIDs.

> This would eliminate the need for a fallback ASID and remove any
> possible concerns about contention for a global bitmap.

The fallback ASID logic is annoying, yes, but it's only in a few
places. I don't think there's a risk of real contention in most
practical use cases, we can run 32k vCPUs per pCPU before we run into
issues. I think we will hit other scalability limits before the
fallback ASID becomes a problem.

> Moreover, it would be much simpler to implement.

The delta is smaller and simpler, yes. But I think the static ASIDs
code ends up being simpler to reason about.
