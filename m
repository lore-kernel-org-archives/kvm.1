Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793794395;
	b=VoTx4JpHfXiIH41q8VtVzDJSUrBBfmYYIKuUbNP8IyQ5ZqEF3YUH/sTqmjGCaSnUH4Vq
	 Vcg6wnsHTxLHC1zrgmLuBMiopgP21i3I2wgE47zURCCP+V6Vb6xS8Lm3wOjEdiwtqCqfj
	 Jov8ELQ4Fc+oTeOyLFjSKwklib15/JU/LCQt+2wsi5MCqU+2CiBCBq8Qc+CzJ18mahxZg
	 afNxGJ/TxLNfBMsz/BHI4yy8mbwWHk8bv0uKyJYRyKS+mrtu3E64uHmqwbImQaZ7wNZd5
	 SnqL2SoN0bd8K8zs4PFtfxQapZcFRq/4GofhMxnJ+tJqsAEVVWwXMlurdaUCgDFeQIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=l29EI5/p6/DEhToAZfMpMUc9xElFfXdkOy19HxoMaLo=;
	b=XAwBypfMzuYrgsqbCcXT1WFcBGwbIFIh4Aen2CvwocKXSSdJ/7n0thk7oip0GQsKF0Hz
	 Poew7XijorRPZzxmFU69ABlVNK8tZqX3zqJpA38xx84nI5P8Muxjfyz5Maf2tsLK63qeT
	 Eq5EDKUNXcKTAp4LC+U+DZosPLY8fmYr3ODHzDkBzGYyhf9Wcm2esHKDX5VNLSkPckoen
	 xN7vLHXeAOG+nRzb9Pmraho3euuaUzLiq9OIsGAvLDZR4JTR87k/CENhpfNYFu9ZqKU4H
	 4VTjSarQD4ay8b8VAwhwQKS88gGHbItsPlypt+32Gy+SuZ2p1cskZFNZ2JGMMoAnzOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=ffOgxxwq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.172
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48594606A31B
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 12:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48594606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=ffOgxxwq
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a9a1ed66b9so5016211fa.2
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 04:13:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793794392; cv=none;
        d=google.com; s=arc-20260327;
        b=AisvwOnOWu5CYPU4god6olDgnJf2ZYeleABOGjxF9ymsGbmjJn9yO8JpTln3qOfU1U
         rZl5dgf8vZotTugNLUjF+ePmWbSMiPhdy5MKS7tbCkcsjiufrhqKhTSsL56aM2HU3DW8
         0u153o/qiK4uJHGEDpRnqqF9zpkq/wtLeFc4yd3sBstrwL9ibpG4Tekq6ArZjish3M8w
         96r8MQq7iWpXVjbsRFkKiuAdIcMe2Jer7s+P3Ff8D0ZQ8qC4MWlbcUH+9adNYy9mmdKn
         aMBSuaTMenkjk9jHFypHjxwIEusc0pjuVCPxECKqPvmE0S0Kpemi7EOM0gW/Oavr7ZYm
         pWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l29EI5/p6/DEhToAZfMpMUc9xElFfXdkOy19HxoMaLo=;
        fh=0TdDGBeooqSlRX90gXBwkhO1djicPbgSDx7FSUdtcA0=;
        b=KpQ/RmwhOLWwBe8DSx7K0x1GZz7aip6Tm9YKv1aaT9AHeaieEU8Zmzjs8MpqiquBIQ
         lj4gGo6WluNzVe/B4242y6lg/VYfkaOEgbozyeJN5sIHSRbz9gh5Tx+4cnmZ4WMqriOv
         VXqISEvOtvkZurcBuQtFBwa4XpxBmECRUOMkZ1LcNa+XvAc98OYn8A9IFQs1PN9SYJBu
         HWayWS8u8LYyXsvYXE/zA/zdLAN4lB5qlpYC7tFVJq1Q+0/P8cwk9a/NX8M4muCSUJ2c
         H+PfFzSGpcSMMUgE1ZxmwPtQWc7wV6YlnjG8krJ3NO8SxoCBvhlL86/tRry38PFkw5K8
         ep8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1793794392; x=1794399192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l29EI5/p6/DEhToAZfMpMUc9xElFfXdkOy19HxoMaLo=;
        b=ffOgxxwqisaC7QsYjh3DtjmPhetf9wQjxHtK9Xxua07hTZ0YdlX9vMPTmn5FibBE/7
         MPW0P8RW8tFDV6l1EAwtVJAjfP8Uwb97ItQFHIdMHXpXIioIFIUUjGgFMS5eTO+Lvsfg
         5b8GUdEeCzg0JYyPipJ6ivCNEWAF1XzpN7GrUMt07yqB33ykTPHAZ8GNpXK3KvIQhtgb
         rnFZ2OektpaFjtp0avqK4iQh6UDvj57WThHQYAUnlycHmSmzqyPfcEM25SJLJLt/Vpi/
         FgEqTeOPe9KRb8vuKLdNmJVlBKA7TjI3iTqYnS5ZYp8R4JihNOphjddlrGLsCcG2/CoG
         +q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793794392; x=1794399192;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l29EI5/p6/DEhToAZfMpMUc9xElFfXdkOy19HxoMaLo=;
        b=mKqoT7c0kofvP7LKloEv9I4bA+YAvef09g9ucNinRH27oTvESJCslb1Abj+VPMv9wu
         MOGHYAaOy18WH0Xzt3sAg/4Gr6gkEMiL4cUeUJPtd6qT7udzHfUKqQWKxfXCEe4l0zBj
         TvR635rN04gy6pWvxSOmboottJe0rQwSW+LNZxkgeEZMMxDw6FMlncp2VHug4kOQTmKG
         HWoVyuvkc5ov4T3sqftPz8GncaDUBOhuE7G9LSkmUWYJl21Z1QILSq9gs27s5xkC9mDR
         oBRk5AvsNFBw91UB9hdw50jjjK6vIGtquL7+6ehbc8jC49cOVSa/kr068e/I4QjxPMnn
         5ByQ==
X-Forwarded-Encrypted: i=1; AKwUvBzVc/gLKRR69UQa+Ed18eMNIyeB7GRYaKrd+InAYa3qt7QGOb/UQwBtxCPjg8lRR1pBOdg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HwEFTOogMSiwLfxhA+ddah1dwXRvfuGq+8oLPCTY2QEDr/Iis
	3Bxs3KSJD4m+92vBV6vES/hD+pJ2e13wI//CahSQVqRt9ZtC/k/uMJDs1girz8mRP3RUkXLyRSJ
	o5FpWmeyGv78ZNQ2i+bnSE2HNeJOZTFWBAieQTmRHIA==
X-Gm-Gg: AYBFou2bsvW++BEBR9ZA8ifn3qo/Y+1GeJiFU4DirDRWg/4FrMYVMgUxMoB740w8IKz
	8jOa//Ojv6DWu2H9Jdo2y97zuF7mNulceb3H+qygloigXPXAW7rZ5RHhTuK7ytTgkjgjJ1CRwiS
	utkOzuWi0KSZePzCNLIG+uR4aI18Li/h9UtwkHx2Chz9KYnQW9yAFlIe5wxCIV8kBRqb3Om8Iav
	no+Ux22aM6Vw0PDlbDvYxc+Geis4jtQBLNLzrQXrMY7HV45Hf9mTgRPRZZvUna/vsQd31JpuIJO
	Rs/DeeJxOgCjR7RveMTVcyNlSb5TlPcBUTJuN8FOwya8Y1DGslFIObEWelDzGDveYrEK/gYCx0E
	yxn6ZBiC/B91I6EBqWoU8ULe79ZH3n7rbOo4ZZqcnEB7XF9RHdOxI8RyEoXUxBqBxrUPAUz0D7w
	c4jBHhp5zE8zIbP9M1QmwLReDUPIzdyZxl+wG/xhYkTPP3xD7C0dYcFT8=
X-Received: by 2002:a2e:bc04:0:b0:3a7:6090:e0b3 with SMTP id
 38308e7fff4ca-3acb7a99f7amr41249841fa.20.1793794391777; Wed, 04 Nov 2026
 04:13:11 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260817102447.40259-1-guoyaxing@bosc.ac.cn> <CAAhSdy2qwdHE7SB2gRK3_PQ6m_bMSfWpvcuSG-31W2yd3-UTKg@mail.gmail.com>
 <285419e5-c4fc-4c75-a765-436165bdc8b9@bosc.ac.cn> <CAAhSdy1Q7a+54qn0xNBQBd1eV2ve+Nzqz9uRsWrGSmTn35z8=A@mail.gmail.com>
 <c050c85c-482a-4351-b627-ac074f7f7952@bosc.ac.cn> <CAAhSdy3XDEGfFJJnHfx2Q0w+dG4FombF3Lj5O_V4wBpkyAYTNg@mail.gmail.com>
 <504d1c51-857b-4f42-ad66-bea00ab9a03f@lanxincomputing.com>
In-Reply-To: <504d1c51-857b-4f42-ad66-bea00ab9a03f@lanxincomputing.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 4 Nov 2026 17:42:55 +0530
X-Gm-Features: AclHuK92DgwuSVb6_NyY9PQpGR8Bz8fkGq5phk_kH5NMdrxG2QcR7UNhbZ_LWKA
Message-ID: <CAAhSdy1_fwKKPKfw24MeNoqVyL9WG=b_HM0T++P3fB6BMr9PtA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Flush VS-stage TLB before reusing a host CPU
To: BillXiang <xiangwencheng@lanxincomputing.com>
Cc: guoyaxing <guoyaxing@bosc.ac.cn>, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	majiuyue@bosc.ac.cn, anzoso@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 9:35=E2=80=AFAM BillXiang
<xiangwencheng@lanxincomputing.com> wrote:
>
> On 10/24/2026 11:49 PM, Anup Patel wrote:
> > On Sat, Oct 10, 2026 at 2:36=E2=80=AFPM guoyaxing <guoyaxing@bosc.ac.cn=
> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2026/10/10 15:50, Anup Patel =E5=86=99=E9=81=93:
> >>> On Sat, Oct 10, 2026 at 4:12=E2=80=AFAM guoyaxing <guoyaxing@bosc.ac.=
cn> wrote:
> >>>>
> >>>>
> >>>>
> >>>> =E5=9C=A8 2026/10/10 02:51, Anup Patel =E5=86=99=E9=81=93:
> >>>>> On Mon, Aug 17, 2026 at 12:25=E2=80=AFPM Yaxing Guo <guoyaxing@bosc=
.ac.cn> wrote:
> >>>>>>
> >>>>>> Guest Linux uses mm_cpumask to decide whether an sfence.vma needs =
to be
> >>>>>> local or remote. Under KVM that mask tracks guest CPUs, not the ho=
st CPUs
> >>>>>> that previously backed a vCPU.
> >>>>>>
> >>>>>> This can miss stale VS-stage TLB entries when a vCPU migrates acro=
ss host
> >>>>>> CPUs. For example:
> >>>>>>
> >>>>>>      - vcpu0 runs on host CPU1 and fills a VS-stage TLB entry.
> >>>>>>      - vcpu0 migrates to host CPU0.
> >>>>>>      - the guest updates the mapping on vcpu0 and issues a local s=
fence.vma.
> >>>>>>      - later, the guest task runs on vcpu1 while vcpu1 is backed b=
y host CPU1.
> >>>>>
> >>>>> When the vcpu0 is brought back to host CPU1, the kvm_riscv_local_tl=
b_sanitize()
> >>>>> will ensure TLB entries associated with Guest/VM are nuked.
> >>>>>
> >>>>> By default, kvm_riscv_local_hfence_gvma_vmid_all() will only do HFE=
NCE.GVMA
> >>>>> for the associated VMID because most RISC-V H-extension implemenati=
on will
> >>>>> tag VS-stage TLB entries with VMID and HFENCE.GVMA must remove both
> >>>>> G-stage and VS-stage TLB entries for given VMID.
> >>>>>
> >>>>> If your HW does not tag VS-stage TLB enteries with VMID then it bug=
gy
> >>>>> / inefficient
> >>>>> so you have to set kvm_riscv_vsstage_tlb_no_gpa in
> >>>>> kvm_riscv_setup_vendor_features()
> >>>>> as work-around.
> >>>>>
> >>>>> NACK to this patch from myside.
> >>>>>
> >>>>> Regards,
> >>>>> Anup
> >>>>>
> >>>> Hi Anup,
> >>>>      Thanks for the review and clarification.
> >>>>
> >>>>      Regarding =E2=80=9CWhen the vcpu0 is brought back to host CPU1=
=E2=80=9D: the failure
> >>>> we hit is not caused by vcpu0 being brought back onto host CPU1. In =
our
> >>>> case, after vcpu0 has already migrated away, neither vCPU migrates
> >>>> again. The guest process is later scheduled inside the multi-vCPU gu=
est
> >>>> onto vcpu1, which is still running on host CPU1. So the stale TLB is
> >>>> re-hit without any further KVM vCPU migration, and
> >>>> kvm_riscv_local_tlb_sanitize() is not involved on that path.
> >>>>
> >>>>      My commit message was a bit too terse on this point. The concre=
te
> >>>> sequence we observed was described earlier in the RFC discussion:
> >>>>
> >>>>
> >>>> https://lore.kernel.org/kvm/0d15b098-b8f7-4080-9f33-e8c49c2331e1@bos=
c.ac.cn/
> >>>>
> >>>>      In short, the issue is: because vcpu0 migrated away, cpu1 still=
 has
> >>>> stale TLB entries while cpu0 has the new mapping. After that, neithe=
r
> >>>> vcpu migrated again, but the process was scheduled from vcpu0 to vcp=
u1
> >>>> (which is on cpu1), causing it to hit the stale TLB. Consider the
> >>>> following scenario:
> >>>>
> >>>>      1. vcpu0 and vcpu1 are both running on cpu1. At this point, vcp=
u0 is
> >>>> on cpu1, and a process on it reads a page, which gets cached in the =
TLB
> >>>> (let's call this the "stale TLB entry").
> >>>>
> >>>>      2. vcpu0 migrates to cpu0, and then the process (on vcpu0, now =
on
> >>>> cpu0) does a CoW (copy-on-write) and establishes a new mapping.
> >>>>
> >>>>      3. Neither vcpu0 nor vcpu1 migrates again. At this point, the p=
rocess
> >>>> gets scheduled inside the VM onto vcpu1 (which is on cpu1), reads th=
e
> >>>> same page, and hits the stale TLB entry.
> >>>
> >>> This cannot happen because in step#2 when mapping was updated the
> >>> Guest OS will do TLB flush for all its VCPUs which means vcpu1 on cpu=
0
> >>> will also receive TLB flush and the stale TLB will be removed. This m=
eans
> >>> when process is moved back to vcpu1 on cpu0, HW will fetch updated
> >>> PTE and new TLB entry will be populated.
> >>>
> >>
> >> Hi Anup,
> >>
> >> Thanks for the follow-up. I may be missing something, so I wanted to
> >> double-check this against the guest TLB shootdown path.
> >>
> >> If I follow the Linux guest CoW path correctly, when the mapping is
> >> updated in step#2 it goes through:
> >>
> >>     wp_page_copy()
> >>       -> ptep_clear_flush()
> >>         -> flush_tlb_page()
> >>           -> __flush_tlb_range(mm, mm_cpumask(mm), ...)
> >>
> >> So the remote SFENCE.VMA appears to be targeted only at CPUs in
> >> mm_cpumask(mm), rather than at all VCPUs of the guest. mm_cpumask is
> >> updated in switch_mm()/set_mm() for guest CPUs that have actually run
> >> that mm.
> >>
> >> In our case, before the CoW the process had only ever run on vcpu0. Fr=
om
> >> the guest's point of view it did not migrate: the host migration of
> >> vcpu0 from cpu1 to cpu0 is not visible to guest Linux, which only sees
> >> vCPUs. So at CoW time mm_cpumask still contains only vcpu0 (or at leas=
t
> >> does not contain vcpu1), and __flush_tlb_range() would not IPI vcpu1.
> >> The local SFENCE on vcpu0 would only cover host cpu0, where vcpu0 is
> >> currently running. The stale VS-stage TLB entry left on host cpu1 from
> >> when vcpu0 previously ran there would then remain.
> >>
> >> Later, still without any further vCPU migration, the process is
> >> scheduled inside the guest onto vcpu1, which remains on host cpu1, and
> >> can hit that stale entry.
> >>
> >> This also seems more likely when the ASID allocator is enabled, becaus=
e
> >> set_mm_asid() does not always local_flush_tlb_all() on switch_mm(). So
> >> even the first time the process lands on vcpu1, a stale ASID-tagged
> >> entry on host cpu1 may still be present.
> >>
> >> In other words, I am not sure this case is covered by a full guest TLB
> >> flush to all VCPUs on the mapping update. Guest shootdown looks
> >> mm_cpumask-based, and host pCPU migration of a vCPU does not by itself
> >> add other vCPUs that never ran the mm into that mask.
>
> Hi Anup,
>
> I have a few more questions about the issues and changes you raised.
>
> >
> > This makes sense now considering ASID allocator in Guest Linux is globa=
l
> > and not local. In any case, KVM RISC-V must not assume that the Guest O=
S
> > has local ASID allocator hence the kvm_riscv_local_tlb_sanitize() must =
also
> > santize TLB for other VCPUs of the same Guest which can potentially run
> > on the previous host CPU where current VCPU ran.
> >
> > Having said the above, there are multiple issues with the current patch=
:
> > 1) The kvm_riscv_local_hfence_gvma_vmid_all() is sufficient for most
> > implementations to sanitize both G-stage and VS-stage TLB entries
> > because both G-stage and VS-stage TLB entries are generally tagged
> > with VMID. The kvm_riscv_vsstage_tlb_no_gpa work-around is for
> > implmentations which do not tag VS-stage TLB entries with VMID
> > and this patch remove this work-around.
> > 2) The other VCPUs on the previous host CPU may be already running
> > and may still hit stale TLB entry before kvm_riscv_local_tlb_sanitize()
> > gets a chance to sanitize TLB on previous host CPU.
>
> First, the migrated vCPU have run on the previous host CPU before the
> other vCPUs do, and kvm_riscv_local_tlb_sanitize() will have been called
> before the other vCPUs run on that previous host CPU. Therefore, with
> vcpu_switched in Yaxing's original patch, no stale TLB entries remain.

I am not going to explain again. Please refer point #1 which I mentioned
previously.

>
> > 3) The per-CPU pointer in struct kvm_arch is racy because we
> > may have two VCPUs on same host CPU which are migrated to
>
> Seconed, kvm_riscv_local_tlb_sanitize() is called under
> preempt_disabled() in kvm_arch_vcpu_ioctl_run, so it is not racy between
> two vCPUs.

Think about this more you will be able to come up with an example
where per-CPU pointer table updated on a particular CPU is not
seen correctly by other CPUs.

>
> > other host CPUs. Instead, it is much simpler to have an atomic
> > cpumask in each VCPU where any part of KVM can mark a host
> > CPU in the cpumask of the VCPU to force TLB sanitization whenever
> > the VCPU runs on that particular host CPU.
> >
> > How about the following change ?
> >
> > diff --git a/arch/riscv/include/asm/kvm_host.h
> > b/arch/riscv/include/asm/kvm_host.h
> > index a30600579231..c975eee7240c 100644
> > --- a/arch/riscv/include/asm/kvm_host.h
> > +++ b/arch/riscv/include/asm/kvm_host.h
> > @@ -9,6 +9,7 @@
> >   #ifndef __RISCV_KVM_HOST_H__
> >   #define __RISCV_KVM_HOST_H__
> >
> > +#include <linux/cpumask.h>
> >   #include <linux/types.h>
> >   #include <linux/kvm.h>
> >   #include <linux/kvm_types.h>
> > @@ -184,6 +185,9 @@ struct kvm_vcpu_arch {
> >       /* ISA feature bits (similar to MISA) */
> >       DECLARE_BITMAP(isa, RISCV_ISA_EXT_MAX);
> >
> > +    /* Sanitize TLB host CPU mask */
> > +    cpumask_t tlb_sanitize_mask;
> > +
> >       /* Vendor, Arch, and Implementation details */
> >       unsigned long mvendorid;
> >       unsigned long marchid;
> > diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> > index 2ae34632cdcb..b1387a00c8b0 100644
> > --- a/arch/riscv/kvm/tlb.c
> > +++ b/arch/riscv/kvm/tlb.c
> > @@ -207,11 +207,31 @@ void kvm_riscv_local_hfence_vvma_all(unsigned lon=
g vmid)
> >
> >   void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu)
> >   {
> > -    unsigned long vmid;
> > +    struct kvm_vcpu *tvcpu;
> > +    unsigned long i, vmid;
> >
> > -    if (!kvm_riscv_gstage_vmid_bits() ||
> > -        vcpu->arch.last_exit_cpu =3D=3D vcpu->cpu)
> > -        return;
> > +    if (!cpumask_test_cpu(vcpu->cpu, &vcpu->arch.tlb_sanitize_mask)) {
> > +        if (!kvm_riscv_gstage_vmid_bits() ||
> > +            vcpu->arch.last_exit_cpu =3D=3D vcpu->cpu)
> > +            return;
> > +    }
> > +
> > +    /*
> > +     * The VCPU might have left stale TLBs on the previous host CPU so
> > +     * mark previous host CPU in the tlb_sanitize_mask of other VCPUs.
> > +     */
> > +    if (vcpu->arch.last_exit_cpu > -1 && vcpu->arch.last_exit_cpu !=3D
> > vcpu->cpu) {
> > +        kvm_for_each_vcpu(i, tvcpu, vcpu->kvm) {
> > +            if (tvcpu =3D=3D vcpu)
> > +                continue;
> > +            cpumask_set_cpu(vcpu->arch.last_exit_cpu,
> > +                    &tvcpu->arch.tlb_sanitize_mask);
> > +            kvm_vcpu_kick(tvcpu);
>
> Last, vcpu_kick is an asynchronous operation, so there is still a chance
> that the other vCPUs will hit stale TLB entries.
>

There is zero chance that VCPUs on pervious host CPU will
run in VS/VU mode before the migrated VCPU enters VS/VU-mode
on the new host CPU because the kvm_vcpu_kick() causes an IPI
at HS-level so if some VCPU was running in VS/VU mode it will be
preempted immediately to HS-mode and result kvm_riscv_local_tlb_sanitize()
on previous host CPU even.

Regards,
Anup
