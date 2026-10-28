Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793168095;
	b=l15e6NUnJs6yWt9fmmCNHJVzaU4cL1iH7bNIHM2pUYz3TiFftVo1moLkUnVF8DhCX7i1
	 LZBIfs3iq4/1mA5SF1xM6lXc6rD0D/bkKsPFwlcjLCmkeCaQcsnYFGzKLVof6mSbLydoK
	 XGDYFw4zYTiRoKHYGDIh3C9O4aA0snw17vU5FwEqCHVcVKVxF+11JTaecYbRJsNJOA25R
	 UMP7mdPhwODYK3zw3Nsu/dqYssJmPHy0XGN4IsPfRS89sABVrz0keXIUEEU/yu4KMYgEG
	 PZx/pR83JiUJ/TkfF2pXHlLG0dh8VSi3m4qg5tE4eRcSjd5wzRpDKboxNB/ab9Zr+zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793168095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RpEkHIqZvFWx+elGJR4nCS2qOS6JG40/XuUxXPK9HjI=;
	b=f4qIZl7GjoOLr5+K9TEwpufMoFbJGYjeKA8SR/PeU22AGIyw2kayGKddvgvHr1hREqnq
	 api4bdOexUbA7Im71+m6vAPDv/FZ4pLR4xQvPtxm39W3HLkmxwrV1F4aZOYVpGteB/Vb2
	 Zzpm8OH5h+u1dP8OW/xv327cpgJXBb7lPsaBZecyZG4smc0d5FnNkX4pG/1P1lVWrv3AY
	 YaMvmkcTldn8Lrno0BZJCdNuZAz+wL1+Eku8EQEQjsQIxH9ubbAY+WQRdzRh1GdwwFBRF
	 8b7alyEa55mwmdWvU8RecIeHeSGMIcxIv7CysuSI745WXPlpImGBjY434HjqnSWp8pQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=dUgirNjx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE02606A31D
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 06:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BE02606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=dUgirNjx
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so4938135e9.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 23:14:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793168092; cv=none;
        d=google.com; s=arc-20260327;
        b=N9JGC/C+rUS6cpi+iWMRgolEJ0TmXAe2Afrbky9EAsOHGcmEjwLdEg7qwanuqDLt6g
         CS9Xxn2TTHZQgcgkz9n9kaIi4ABz0USFrmy3n5WdcNRgqn89mEFCRGAncKzZCD3sls4y
         UCLfXbbA/Zj/cLdHkTb3gToIpAcSAuIt4k3tOk37FC6v7SLTYloa3JveU4Z4DLXX7J11
         7+sZh7O9ss+av272QKQTkMP5lUoUfUlkWkYtjpBQRJ7wH+BrafKCYsD9JgA6u0hRSVNC
         A40+Jr0rMwd1bVQED5YMB7GW7opuUnbmHn3Qev/XogtDj6dvfzw/hxq/TZjRrLWVxWcU
         HUYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RpEkHIqZvFWx+elGJR4nCS2qOS6JG40/XuUxXPK9HjI=;
        fh=PNeSz1d6WrKH/nmZYGsQQja9Rid47EP19BiNCPEeKZU=;
        b=gDIig34DRKHn6L0QJiuiFh7NS5D4NFjQAQjaLa2ab3Y67KLJ3R8QqA3vyoNS5VKAYW
         0t5N5w9O+8KEyiDiB9Q9K4X+IxbzNdxEOuoKV8gNQNtGI1sT1YhseebaLwcXscq3T+Kc
         xm1h2sMqkmzgVhl5xsU6hJh2bY5pCmGqdrXn55tGWq7sd7kuQ+VjHAf5FvZRsT0JzXyE
         +7ibuJc7MySkONcwov+uAv6hfUFj42/5WdsHsyvwT3ylGiAOtaCZ2LWceVseY8+cEFYb
         i23wTSsTNd/K0bQGANsqBXMUAL5xWHRghreouq0JWwlZ2W1FNa3C1mlp/U7pgkhI4kBj
         2veg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1793168092; x=1793772892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RpEkHIqZvFWx+elGJR4nCS2qOS6JG40/XuUxXPK9HjI=;
        b=dUgirNjxgEIQlt+pRPw93cXsA810Cyi7EGP8ksEWmg1FXvN1swilrYzWwM04Io6/f/
         w5XKyp9HZHi7IPKzJhoDTKsFIAVgxnUBP56lqPZ+E+CosY31qWa+w2yatvURIPRSkjXf
         AVXamE69hrKAKyZLvHR2/9o8+QIm9DhL8xw8taJwHEooN6gUohn5XQ++iFL6zwmuGtQ+
         lffD9dzGJFyoBmsIzy/2cRVITkh3U0IXO0U0Qyo/OiUfyLqVamfpk1IM/Smmh/gNkN0d
         6QKeWXWNjh3pV4noQmWYi2OllntIgor7lBqu11sd0d5wMjZlYnwHkxu542KEBSn87Rjx
         hiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793168092; x=1793772892;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RpEkHIqZvFWx+elGJR4nCS2qOS6JG40/XuUxXPK9HjI=;
        b=xLKqZyWXXJPoiwKvsCoJD+u25CJvpP8IIyJWWGhH/XJyUHslpVavtlfYdgds0+4ugw
         1lVGMQFcsUALSjDXYao4mATGuGs83r8u5kALGMXaGJxYt8FmNcw/npvLfuM/wlRM9W91
         YHMGXxlhu7h5WFsRes4VcPz/dWR2z4xbgy2tAA/PZ4z2FYfbyDCGob0iLJdrJ+DOARqp
         YutT1FvK3hH2rFwuRMfrfaHAMPxF9MPRrS9xp5psbzv3+oO29Zhy0o1hb4670PAggGSs
         b+pxprvSgPSSdEi50l0htdoPYN7Gk2Z7wT2z9Wwg/HRPyoVw/0ISO9BhHg9UTIMtPqgr
         s+Hg==
X-Forwarded-Encrypted: i=1; AKwUvBxbVlNiCUoOmyr6W1h43ab2h9zuhfSESb7vbpMbpycjUM0UBQMGFo/G4e0FFjPoJHoJmiM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJlovUPZhNh92jrgxWOGN6oeSJKMamgfQYaP/4U1qqDFjH91a53
	27J8+B+nda25XhWW1+YyoKsb8+AnTHu1Ghudr4j4rD7XcT2G4GYQC29Rrn+0lKChg4pEYM8o5EY
	3m4bMGvTt8QX7BxCUWqYRP+dxm7sTygVTfQvJ6DmOqFqitYrEz900OPBmKQ==
X-Gm-Gg: AYBFou2s4goOtrXso012lscELo89a8W4oPEDN4azoymoxMPteo84dKsn/lhf7Qmpv1C
	/vfw30oc7VgOcM1OlIBhLRaV2JkCc33bN0q3yrTWMLUfbOI+Pml/HEsDtp6vkcXPZ+FyhR0LmX/
	oB4Ld+XSHLeGYW0Vmo1nhwIAXqIT571yz+SKmELPPoy94pmLEKgcBR8H41nGjnrk+tSdOOthQPS
	fnT5Nm5N0Z2tkt8J13DzE+mGFqQHwkWp+t+aBxzFDZEx/U5IyoRAwSMJuG+dtOdpQ1gV39viEU8
	OX/8lt0B10Jh1wlJa50P9lil9pPnp7s8I12SeBIFllDcs1GqRbozch20RDGgGPEt3jbq894RQxC
	IOHgTtpSF3ga2im737+vFtkt9jAxfb5yzkIC9icjVAUT9NY9z0dOcrILSwvGAIGKastLSNY8uV4
	DrsVdxmHSIFtJHIN1jTBG7vvHN/Snm6ndNGtCGq+cU9l6fqDuEsOqxS0o=
X-Received: by 2002:a05:600c:3b24:b0:4a3:5a98:c279 with SMTP id
 5b1f17b1804b1-4a966c41c8dmr22109035e9.8.1793168092310; Tue, 27 Oct 2026
 23:14:52 -0700 (PDT)
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
 <8dfb9c5b-cc02-4340-8f6c-61265f711d5a@bosc.ac.cn>
In-Reply-To: <8dfb9c5b-cc02-4340-8f6c-61265f711d5a@bosc.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 28 Oct 2026 11:44:40 +0530
X-Gm-Features: AclHuK8hQ5V7ATMF1H2qSx4l_DNtfMwaNrXX6RpZzbmYTwM8sl9t3qn4qaJQljk
Message-ID: <CAAhSdy3Qthj3va39BqAMK5GCSqXp6Kz15mb=q2cs4Uj-ZOZ-bA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Flush VS-stage TLB before reusing a host CPU
To: guoyaxing <guoyaxing@bosc.ac.cn>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	majiuyue@bosc.ac.cn, anzoso@outlook.com, xiangwencheng@lanxincomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 3:49=E2=80=AFPM guoyaxing <guoyaxing@bosc.ac.cn> wr=
ote:
>
>
>
> =E5=9C=A8 2026/10/24 23:49, Anup Patel =E5=86=99=E9=81=93:
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
> > 3) The per-CPU pointer in struct kvm_arch is racy because we
> > may have two VCPUs on same host CPU which are migrated to
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
> > +        }
> > +    }
> > +
> > +    /* Clear current host CPU from the tlb_sanitize_mask */
> > +    cpumask_clear_cpu(vcpu->cpu, &vcpu->arch.tlb_sanitize_mask);
> >
> >       /*
> >        * On RISC-V platforms with hardware VMID support, we share same
> > diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> > index dd786f758eb7..c00dc0b191dc 100644
> > --- a/arch/riscv/kvm/vcpu.c
> > +++ b/arch/riscv/kvm/vcpu.c
> > @@ -107,6 +107,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu
> > *vcpu, bool kvm_sbi_reset)
> >
> >       vcpu->arch.last_exit_cpu =3D -1;
> >
> > +    cpumask_clear(&vcpu->arch.tlb_sanitize_mask);
> > +
> >       kvm_riscv_vcpu_context_reset(vcpu, kvm_sbi_reset);
> >
> >       kvm_riscv_vcpu_fp_reset(vcpu);
> >
> > Regards,
> > Anup
>
> Hi Anup,
>
> Thanks for the explanation and for suggesting the per-vCPU sanitization
> mask. Building on your proposal, I would like to suggest two changes:
>
> 1. Separate the invalidation strategy for vCPU migration and a mask hit.
>
>     Keep HFENCE.GVMA for vCPU migration, identified by
>     last_exit_cpu !=3D vcpu->cpu, when hardware VMIDs are available. Use
>     HFENCE.VVMA when the current host CPU is marked in tlb_sanitize_mask.
>     A mask hit caused by another vCPU of the same VM running on this CPU
>     requires VS-stage sanitization; it does not by itself require G-stage
>     invalidation.
>
>     For example, if vCPU0 and vCPU1 both last ran on CPU0, switching from
>     vCPU1 back to vCPU0 only needs the mask-triggered VVMA. This avoids
>     requesting G-stage invalidation when the shared G-stage mappings have
>     not changed. If both migration and a mask hit occur, both fences run.

HFENCE.GVMA is sufficient for most implementations so to sanitize all TLB
entries matching a particular VMID.

Refer, the following text from RISC-V Privileged specification section "5.3=
.2.
Hypervisor Memory-Management Fence Instructions":

  Conceptually, an implementation might contain two
address-translation caches: one that
  maps guest virtual addresses to guest physical addresses, and
another that maps guest
  physical addresses to supervisor physical addresses. HFENCE.GVMA
need not flush the
  former cache, but it must flush entries from the latter cache that
match the HFENCE.GVMA=E2=80=99s
  address and VMID arguments.

  More commonly, implementations contain address-translation caches
that map guest virtual
  addresses directly to supervisor physical addresses, removing a
level of indirection. For such
  implementations, any entry whose guest virtual address maps to a
guest physical address that
  matches the HFENCE.GVMA=E2=80=99s address and VMID arguments must be
flushed. Selectively
  flushing entries in this fashion requires tagging them with the
guest physical address, which is
  costly, and so a common technique is to flush all entries that match
the HFENCE.GVMA=E2=80=99s
  VMID argument, regardless of the address argument.

Doing HFENCE.GVMA in certain cases and HFENCE.VVMA other cases is
maintainence burden without much benefits. Also, VCPU migrating from one
host CPU to another is an infrequent event so no point over optimizing with=
out
much benefits.

In short, NACK to your suggestion #1.

>
> 2. Move mask updates to kvm_arch_vcpu_put().
>
>     Mark the outgoing host CPU in the masks of the other vCPUs of the
>     same VM when a vCPU is put. This also covers a switch between vCPUs
>     on one host CPU without either vCPU migrating. Marking only when
>     migration is detected in kvm_riscv_local_tlb_sanitize() would miss
>     that case.
>
>     The marking now happens on the outgoing CPU before another vCPU can
>     enter guest mode there. The migration-time marking and kicks are
>     therefore removed. The trade-off is an O(nr_vcpus) walk on each
>     qualifying put().
>
>     How about the following change ?
>
> diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> index 2ac3c0a20fce..ae8a40b3429c 100644
> --- a/arch/riscv/kvm/tlb.c
> +++ b/arch/riscv/kvm/tlb.c
> @@ -160,32 +160,15 @@
>
>   void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu)
>   {
> -       struct kvm_vcpu *tvcpu;
> -       unsigned long i, vmid;
> -
> -       if (!cpumask_test_cpu(vcpu->cpu, &vcpu->arch.tlb_sanitize_mask)) =
{
> -               if (!kvm_riscv_gstage_vmid_bits() ||
> -                   vcpu->arch.last_exit_cpu =3D=3D vcpu->cpu)
> -                       return;
> -       }
> -
> -       /*
> -        * The VCPU might have left stale TLBs on the previous host CPU s=
o
> -        * mark previous host CPU in the tlb_sanitize_mask of other VCPUs=
.
> -        */
> -       if (vcpu->arch.last_exit_cpu > -1 &&
> -           vcpu->arch.last_exit_cpu !=3D vcpu->cpu) {
> -               kvm_for_each_vcpu(i, tvcpu, vcpu->kvm) {
> -                       if (tvcpu =3D=3D vcpu)
> -                               continue;
> -                       cpumask_set_cpu(vcpu->arch.last_exit_cpu,
> -                                       &tvcpu->arch.tlb_sanitize_mask);
> -                       kvm_vcpu_kick(tvcpu);
> -               }
> -       }
> -
> -       /* Clear current host CPU from the tlb_sanitize_mask */
> -       cpumask_clear_cpu(vcpu->cpu, &vcpu->arch.tlb_sanitize_mask);
> +       unsigned long vmid;
> +       bool vcpu_migrated, sanitize_vsstage;
> +
> +       vcpu_migrated =3D vcpu->arch.last_exit_cpu !=3D vcpu->cpu;
> +       sanitize_vsstage =3D cpumask_test_and_clear_cpu(vcpu->cpu,
> +                                               &vcpu->arch.tlb_sanitize_=
mask);
> +       if (!sanitize_vsstage &&
> +           (!kvm_riscv_gstage_vmid_bits() || !vcpu_migrated))
> +               return;
>
>         /*
>          * On RISC-V platforms with hardware VMID support, we share same
> @@ -199,13 +182,16 @@
>          */
>
>         vmid =3D READ_ONCE(vcpu->kvm->arch.vmid.vmid);
> -       kvm_riscv_local_hfence_gvma_vmid_all(vmid);
> +       if (vcpu_migrated && kvm_riscv_gstage_vmid_bits())
> +               kvm_riscv_local_hfence_gvma_vmid_all(vmid);
>
>         /*
> -        * Flush VS-stage TLB entries for implementation where VS-stage
> -        * TLB does not cahce guest physical address and VMID.
> +        * Flush VS-stage entries marked when another VCPU left this CPU,=
 or when
> +        * required by the split-TLB vendor workaround on this VCPU's mig=
ration.
>          */
> -       if (static_branch_unlikely(&kvm_riscv_vsstage_tlb_no_gpa))
> +           if (sanitize_vsstage ||
> +               (vcpu_migrated &&
> +               static_branch_unlikely(&kvm_riscv_vsstage_tlb_no_gpa)))
>                     kvm_riscv_local_hfence_vvma_all(vmid);
>   }
>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index f2e52f3b0786..6209c66b24e1 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -644,8 +644,18 @@
>
>   void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>   {
> +       struct kvm_vcpu *tvcpu;
> +       unsigned long i;
> +       int cpu =3D vcpu->cpu;
>         void *nsh;
>         struct kvm_vcpu_csr *csr =3D &vcpu->arch.guest_csr;
> +
> +       if (cpu >=3D 0 && vcpu->arch.last_exit_cpu =3D=3D cpu) {
> +               kvm_for_each_vcpu(i, tvcpu, vcpu->kvm) {
> +                       if (tvcpu !=3D vcpu)
> +                               cpumask_set_cpu(cpu, &tvcpu->arch.tlb_san=
itize_mask);
> +               }
> +       }
>
>         vcpu->cpu =3D -1;
>
>     Would these changes make sense to you, or is there anythingI might
> be overlooking?

The kvm_arch_vcpu_put() is called every time a VCPU exits to
user space for MMIO emulation and handling other exits. Now,
imagine VCPU0 and VCPU1 running on same host CPU where
VCPU0 is doing lot of MMIO exits causing VCPU1 to sanitize
TLB frequently on the same host CPU.

Based on above, NACK to your suggestion #2

Regards,
Anup
