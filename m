Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127F23DA5B8
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785448355; cv=none; b=Efp8YUkvRt8RkWdECwAg6nfyg2ZoeixkMt5aGs42sDGCx4tg53vJp+PT7sBjwk40+aOTbRVGeIC21SZVMEbuRlimHZPbhN7lv+dkX1LAgxYn2Ihh/ZiEzE/bLN3bD54v2OB/tRn/EbkbaG6f1WYw5NNggN8f6Thwx8c5VgdaUlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785448355; c=relaxed/simple;
	bh=3ax2xWT96hdBxoA/EzUeFCl5VjuMJx1x4gBNptWsfs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=og9BcfOGsLdRVFSvsOp5KOOMEBWGIipcZXsX9LZ6CZSwzxdgCtM2qEIQno10hNB/c87FHavAclr77jF4liWWA50Eo7QX8D1LKH+Z6tT4YfsRBa428PH9Jd6BVn3/xRPmmhBBEWvqALPqeB6vUq1/DXEF5OTGxlOjgIUJ0mAyfkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGgQuMii; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGgQuMii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF911F00A3D
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 21:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785448353;
	bh=mOkuZXXkYQQc+HwFSsqYbvnpokRgyX0t3K5LtyeMgAk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IGgQuMii2YPYQyJnf+bRi5v4E4OhmvP1FM5M3KddzigdPIU77/yRYLbIUXw5wE6uO
	 O5dusUH/ZO6b45V/DkV0yRTihGfftQmF6YO7QPYMTTevU2Q00IcHfv4Vf3cQcbipzX
	 ylf1OGe0MmHLEZEd2dx/X2RdfmJNJ0potE9o0Z1cgh5oU08/J0vTha7GK/4O3FOM4G
	 tlbJ8tYJCVQuFz/lSduwDXCtKdUojsC8nVWcwpwYWogFt/Z05PD0+BNx9XQ7tnc5l8
	 kBW2kmnP/wX8WRkUa67w0qatj754czhPjJ3UmLA+n1w/rNzBrlB/M9Alo/VyXI9xXE
	 rkFpqpOUIo5RA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c197f968b3cso34165366b.2
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 14:52:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq9nhmlxskMjCrSQ+USCzY3CrpAlUlmM98XV2TXqvAJgxWVozQZj/SuHrMQqUYLNb15A3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuffv7WZIkur/nCymbF2OIy01KVs0b5cqL1ht8V6YVkJO8HuTT
	VfU2vplFCdwcW0jeGpI2AUROkYyJEVe2HQXGHXO9JYfNrTF50/vwDUUA09qOLU5yvcwdsYDTseA
	ZwOwwdkYmc8VgjJkhpBXQeiEwAs9bz5s=
X-Received: by 2002:a17:907:b041:10b0:c1c:1e4e:f924 with SMTP id
 a640c23a62f3a-c1fa57c58a0mr149363866b.34.1785448352324; Thu, 30 Jul 2026
 14:52:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728003557.1136583-1-yosry@kernel.org> <CAO9r8zOVyea=7yRD25JcRmar4-0JtTpuoDpK__J431o9MJYj2Q@mail.gmail.com>
 <amgDgTpPGsE451QP@google.com>
In-Reply-To: <amgDgTpPGsE451QP@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 30 Jul 2026 14:52:20 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNFoxNTb7zm7vUJ1TbybxisYpJ_eHEsgSYrSib5WtG3Dg@mail.gmail.com>
X-Gm-Features: AUfX_mztqLmnvjMe8rxRDQp66UrwXOLVd5-8ucW-dBQQOtOC4h5_aPiLzWjoryM
Message-ID: <CAO9r8zNFoxNTb7zm7vUJ1TbybxisYpJ_eHEsgSYrSib5WtG3Dg@mail.gmail.com>
Subject: Re: [PATCH v1 00/28] KVM: nSVM: Optimize nSVM TLB flushes
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 6:19=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Jul 27, 2026, Yosry Ahmed wrote:
> > > Yosry Ahmed (28):
> > >   KVM: nSVM: Flush the TLB after forcefully leaving nested
> > >   KVM: SVM: Document number of ASIDs CPUID setting
> > >   KVM: VMX: Generalize VPID allocation to be vendor-neutral
> > >   KVM: x86/mmu: Support specifying reserved TLB tags
> > >   KVM: SVM: Add helpers to set/clear ASID flush in VMCB
> > >   KVM: SVM: Fallback to flush everything if FLUSHBYASID is not availa=
ble
> > >   KVM: SVM: Duplicate pre-run ASID check for SEV and non-SEV guests
> > >   KVM: SEV: Do ASID initialization at VMCB initialization
> > >   KVM: SEV: Expose sev_get_asid() outside of sev.c
> > >   KVM: SVM: Use a static ASID per vCPU
> > >   KVM: SVM: Only flush the fallback ASID when used by a different vCP=
U
> > >   KVM: nSVM: Add a placeholder ASID for L2
> > >   KVM: x86: hyper-v: Rename kvm_hv_vcpu_purge_flush_tlb()
> > >   KVM: x86: hyper-v: Allow puring all TLB flush FIFOs
> > >   KVM: nSVM: Drop svm->nested.initialized
> > >   KVM: nSVM: Flush both L1 and L2 ASIDs on KVM_REQ_TLB_FLUSH
> > >   KVM: nSVM: Always switch VMCB before leaving guest mode
> > >   KVM: nSVM: Split nested_svm_transition_tlb_flush() into entry/exit =
fns
> > >   KVM: nSVM: Service local TLB flushes before nested transitions
> > >   KVM: nSVM: Handle nested TLB flush requests through TLB_CONTROL
> > >   KVM: nSVM: Flush the TLB if L1 changes L2's ASID in vmcb12
> > >   KVM: nSVM: Do not reset TLB_CONTROL in vmcb02 on nested VM-Enter
> > >   KVM: x86/mmu: Rename __kvm_mmu_invalidate_addr() to
> > >     kvm_mmu_sync_addr()
> > >   KVM: x86/mmu: Refactor kvm_mmu_invlpg() to allow skipping the GVA
> > >     flush
> > >   KVM: nSVM: Flush L2's ASID when emulating INVLPGA
> > >   KVM: nSVM: Flush the ASID on nested transitions if shared by L1 and=
 L2
> > >   KVM: nSVM: Use different ASIDs for L1 and L2
> > >   KVM: selftests: Add a test for nested TLB flushes
> >
> > Sashiko wasn't able to apply the patches:
> > https://sashiko.dev/#/patchset/20260728003557.1136583-1-yosry%40kernel.=
org.
> >
> > For some reason, it failed to apply on the baseline commit,
> > 271255273d5ff348fe29d89fe4712b2f7f7907c3.
> >
> > This is the top of kvm-x86/next tho, so I am not sure what went wrong:
> >
> > $ git show upstream/kvm-x86/next
> > commit 271255273d5ff348fe29d89fe4712b2f7f7907c3 (tag:
> > kvm-x86-next-2026.07.27, upstream/kvm-x86/next, upstream/kvm-x86/HEAD)
> > Merge: a204badd8432f 2abcdf03fda13 9c66085e6dcfb db3a46e200df2
> > 2708ecca4dbdb 710b3a30f407e e428f9779a437 653857a5af462 ec9a16c6aeba8
> > 05a0b701d1089
> > Author: Sean Christopherson <seanjc@google.com>
> > Date:   Mon Jul 27 12:44:28 2026 -0700
> > ...
> >
> > The commit was from earlier today, maybe Sashiko only fetches the
> > trees every once in a while?
> >
> > kvm-x86/next is not among the list of branches it tried. I don't see
> > the tree in MAINTAINERS, so perhaps this patch was never picked up:
> > https://lore.kernel.org/kvm/20260428171541.1342335-2-seanjc@google.com/=
.
>
> Yeah, I need to get Paolo's eyeballs on those changes.

It's really none of my business, but what about just getting patch 1
merged for now? I think this is everything Sashiko needs and the tree
is already documented in the maintainer profile (so it's nothing new)?
