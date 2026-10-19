Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439530;
	b=qOMakNOxTxSrN+Vc2zcNz9C+25Xe8CU7ubJC5VWSmGRXiV8uxgBbHEyeQQ6h2pWZrqAm
	 IcUqPrqzt6wTDuqN6V0R/neeNo2KppioEZNArphnHeuHhM0z02+h6oOUy63t4I7EsO/Bu
	 35mR7HCigPbupfDUnNHUpMCbZWic0QQEnoVX5ejDejkxGLhHOzI015SUko+BTg8hTPF8x
	 z++DENMKYlTFtUvd+4zOWlkUQAJnNz1wluBx6bKs+L/oLMpAhy2+WXg1GVOuTx9ACJddY
	 4qezvVwLIZOLVGNFDNgaBptindrTn2gwX+bSTbXa5hGe6smlrbqvesXEWwRjeSAzkSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439530;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fw09UutyHUduFpWZBPLYb8dsT3BQWfkURXiLOP0HpZI=;
	b=hjXhcQrIImJJahKHmKfz1KL0qZ+pHp4dhQuHo7f1Q+fjtqyEtbHuRqgXqFyQbpE5NKif
	 4qBigVon+xXlRaquFt5VeAyL4EvmV3HwVE/xgig9fnZBZk1yas/+H4jGUmMTM3d+5SHrl
	 Hc/+Ic4tUj9sd33vfO0PnoRLYyUAe/mgfqjdn7sI8zqPdCJ+y1bZVF/rivooGgoY9GUyG
	 qT6Fk6jg3v0B1yO0YADemrf/YTNJ6zBeBHME8FbYveewbhAbyy+o28dkj42fDKQqUCu2R
	 EQl8v4A0xhfpu0eOVikUYIEbnSLXqjv0IN1fR1FM0k2Pr6XvWTXIBepa2Z1+CuwK1BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jMu6TnIf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61718606A320
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jMu6TnIf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60791F000C4
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 19:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792439529;
	bh=fw09UutyHUduFpWZBPLYb8dsT3BQWfkURXiLOP0HpZI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jMu6TnIfTNL4eRW0Js34t44xMai7XURJsas9RHqMz2yu9DqxycEs9EUSWqGtrlKBv
	 48cdxx5qRmaJv0czwbMX1upiuyeQumZglPdYSDHShuMHaRa+YKpkhltXYH4rXDhtJq
	 3oz3bo+qgw52QloWelMJdAUVFsHV67TicwFah+6/VE9U2+SiUL9z5mY6jt1+b0F2XO
	 ZZXC0XggEs4p0jWRDp69LYNezW00aYukcqlBwufOaK1isPw18A+TzyN57bUIFKav2M
	 vrtERrm+aO2B9k8jLILhIkvMUH2aXEAX5vxp5gTNTokxE87EUvvBIUWasyv0dxj8PT
	 EC9CkitAMnNLw==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b170129413so3983034a12.1
        for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 12:52:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxcYBijHTp6F7v1CSYWRDC1f9spuWTdFpluUjiLxgLoEBeyot46un2pc6NjEiz1vwJKgx8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXCkqaxEUVeFKLJTVGoF9GrUBPBm0Nu9c+AmwJIKNtm/ZD3Z/D
	Yqk26Ez948HxeoeSolh7KlOiJm4E3yWxpcncsIKwvPlvdFAjPGlK+8PBNxNFVy2+TPqewcIofRf
	VbAN7rldHdzCHbFZFGtFCBA6cTznW4zQ=
X-Received: by 2002:a17:907:e114:b0:c42:6350:dfc4 with SMTP id
 a640c23a62f3a-c426350e5e0mr292574466b.24.1792439528817; Mon, 19 Oct 2026
 12:52:08 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-27-yosry@kernel.org>
 <CALMp9eS8KDozNGT9J_uN69W32QEvTbg2JrtRqN0ESi00b_uq=A@mail.gmail.com>
 <atK3Y5XxL-zmAvY-@google.com> <CALMp9eRcWZ8fh8_m35RDw-VNrqz4kapVodGoLr=B_iAZaPOA=Q@mail.gmail.com>
In-Reply-To: <CALMp9eRcWZ8fh8_m35RDw-VNrqz4kapVodGoLr=B_iAZaPOA=Q@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 19 Oct 2026 12:51:56 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMdu+YyPb3RhdTDzYteRAE9dBqxTQZKSajm4eYZCp9Y9Q@mail.gmail.com>
X-Gm-Features: AclHuK-WXUmbGE969wYGI9ZZxINhiGhrG6z65F41z9sxkj_UYKXRaPnp2UFqYDg
Message-ID: <CAO9r8zMdu+YyPb3RhdTDzYteRAE9dBqxTQZKSajm4eYZCp9Y9Q@mail.gmail.com>
Subject: Re: [PATCH v3 26/27] KVM: nSVM: Use different ASIDs for L1 and L2
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 11:50=E2=80=AFAM Jim Mattson <jmattson@google.com> =
wrote:
>
> On Fri, Oct 16, 2026 at 5:25=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > On Fri, Oct 16, 2026 at 02:17:30PM -0700, Jim Mattson wrote:
> > > On Mon, Oct 12, 2026 at 4:37=E2=80=AFPM Yosry Ahmed <yosry@kernel.org=
> wrote:
> > > >
> [ ... ]
> > > Per the APM, volume 2, Section 15.16.1, "TLB Flush":
> > >
> > > > All TLB entries belonging to all ASIDs are flushed by SMI, RSM, MTR=
R modifications, IORR modifications, and access to other system MSRs that a=
ffect address translation.
> > >
> > > With two separate ASIDs and the unconditional flush removed, do we
> > > flush both ASIDs in the above instances?
> >
> > SMI and RSM, yeah I think so. kvm_smm_changed() ->
> > kvm_mmu_reset_context() deletes all roots, and kvm_mmu_load() will flus=
h
> > the current ASID when a new root is loaded.
>
> Okay. Is this mechanism obvious to those who are versed in the ways of
> the KVM MMU?

I don't consider myself versed in the ways of the KVM MMU, it took me
a few minutes to track this done, so I think it's okay.

>
> > MTRR writes seem to do nothing beyond store the value, probably since
> > 0a7b73559b39 ("KVM: x86: Remove VMX support for virtualizing guest MTRR
> > memtypes"). It is documented as an errata but I maybe KVM should still
> > flush the TLB? If that's a real bug, it's separate from this series tho=
.
> > We just need to make sure if we fix it, we should flush both ASIDs. We
> > can probably just reset the MMU context here too?
>
> Probably. Admittedly, it's orthogonal to this series.

Agreed.

>
> > I can't find anything related to IORR in KVM.
>
> Me neither. :)
>
> > For MSRs, I think the relevant ones are EFER and PAT:
> >
> > - For EFER, a change to KVM_MMU_EFER_ROLE_BITS resets the MMU similar t=
o
> >   SMI/RSM, so covers both ASIDs. Clearing EFER.SVME frees L2's ASID and
> >   re-allocating an ASID will flush it by clearing last_asid.
>
> Okay.
>
> > - For PAT, I am not sure if that falls under "system MSRs that affect
> >   address translation", but KVM isn't flushing for L1 today on PAT
> >   writes anyway, so I hope not?
>
> Maybe not. Intel, at least, puts the burden of flushing TLBs on
> software. In volume 3 of the SDM, section 14.12.4, "Programming the
> PAT":
>
> > The operating system (OS) is responsible for ensuring that changes to a=
 PAT entry occur in a manner that maintains the consistency of the processo=
r caches and translation lookaside buffers (TLB). It requires the OS to inv=
alidate all affected TLB entries (including global entries) and all entries=
 in all paging-tructure caches.

Nice!

>
> > >
> > > Moreover, does this change the semantics of PV TLB flush? In
> > > record_steal_time(), we have:
> > >
> > > if (st_preempted & KVM_VCPU_FLUSH_TLB)
> > >         kvm_vcpu_flush_tlb_guest(vcpu);
> > >
> > > IIUC, an idle vCPU that wakes into L2 will flush only L2's ASID. In
> > > the past, with a shared ASID, L1's ASID was always flushed on emulate=
d
> > > VM-exit anyway. Now, L1's ASID will be unaffected. Though I can't fin=
d
> > > any real documentation on PV TLB flush, it *seems* like the remote
> > > vCPU would want L1's ASID to be flushed. OTOH, this change makes nSVM
> > > behave just like nVMX.
> >
> > I am honestly not sure. It seems like we should be flushing the context
> > that issued the PV flush. But I also suppose (aside from Hyper-V) all L=
2
> > PV calls should go to L1, not L0, so should we always flush L1's contex=
t
> > here?
> >
> > It would be a pre-existing bug, but this series would be adding it to
> > SVM as well. Adding David here since his name appears all over the git
> > log for that code, so hopefully he'll tell us for sure.
>
> It's just happenstance that the PV TLB flush mechanism works with nSVM
> today, but I don't think we should feel free to break it.

Nested virtualization on Intel is probably more popular than AMD at
this point, so my gut feeling is that we shouldn't block on fixing
this. But I agree we shouldn't feel free to break it either. Will wait
for Sean or David to chime in before deciding the way forward, but if
there's a fix it would be separate from this series imo anyway.
