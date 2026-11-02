Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659927;
	b=j3ur0GhmgB26JrrlTwa6L4tIHfGymbgtOk8Ofndl+KEok2GrPeZbqj0YvtSKNqJe/9rR
	 PyHEA26co5puc48VdjNGnbkGi4OqUgX25ZKnpjRKXeUu/qRroWiZoV3eEZd0jFLqwFbmZ
	 DivdisF4OPY9m/rrmKkACECuOXFDGrJ8o7q6UMRe1g03NveBN9GHpw9sAcxtdVafv3hPS
	 IggcNd/rg/lLJTCYmPNrXgQ3rbVaJZ8QGHkUuNFHLsodNoeGgLZDMlZDgIAkGhASMEI+d
	 w1w+71DOkHoo98ql6Uc7NUBLcqc9NGQOsiDG7PIl7SFa9zpu2cXQEs0WnANkoZH87kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659927;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OtNEE3ZW3uw4w0YqrDkfOK6Bbaypb22ED6pu823ifGQ=;
	b=P/Vrv446LY6BK68dTqCxZpnpsyVWvIbpdP7ut4/zREEAQBa9tMojWYz2CafF+gZIbQuX
	 eYoYZ77PJ4XmEicjvolwoDnOSPGQ+MZ/1nJwwKwjfc9lgWa+PDxQTP03yRkJ9CXz9QPUU
	 XDszLUDA9nL0ZkCq+Z4340uUgTZdB3di3lXbdlbLManxNORmlrq6TaTScB6sp+G/mRZKL
	 AWK/pQATvSm1qGPsoC1CWCGhHoEp84Q++G1BI6arMnl2q9/FG/6khRnl21lfxNUL8PLQA
	 xilNGbtOdNwStWrmpiboNKo+c5kgfMGufgiS+D6ccZcGHydrfHdxrE97yDNh2noq4vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=STricPRH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9B4606A324
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=STricPRH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9731F00A1B
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 22:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793659926;
	bh=OtNEE3ZW3uw4w0YqrDkfOK6Bbaypb22ED6pu823ifGQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=STricPRHGSs6TitDw728rcmtjh69ZjP6E5Jr8WXLVTfCoZ61sFNPSl5kjiue5hO3j
	 2Ot32N42otnZkA5nfc+yblJB+h/UMJCYUqqFsa7CzWMyQV2xDG0UNm6WVi736B3qm7
	 xXDRIY0+AkxINmGcMPazhWG9Nl8ay0PIDqMCvSrXidTI6URt9zLvMU5THdtBpl0qOC
	 PcCtwdr7vD1i/UwgdGeskZ+rnIFe8BuY/akgMlY6kxHqL4YMJymQ6HxTO7Pydeqolv
	 lWJ2PHLZk4lBsW9dKcxPzINM809nTR/bWCznGU/8o7kk9cj0dGw7id2aC9t8dQDsRZ
	 Eb1A8iDQQM3AA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b1ab2ad719so4916156a12.3
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 14:52:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBztMehSSuMKMAppJ7T/FT5JFkx1qs0SQm3ySAnb98CgE6iy5ISBXAI9KAHyu8lmV4/wmMA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSKJIo5+snt99kZ4zG0JGfNQb/+pzlb51mO5tX3iyMyJ7MP7SB
	dxqcdUIY3liBRtSDEYKL4nTI0nmU61/ob0ebq1FRWCcTQdNsBRwGeeK3j3XLMlnhfaJzoJnpbFT
	GanqqhVZ1nKKuLT94r9mmHoZ4x5V25Gk=
X-Received: by 2002:a17:906:ee8b:b0:c3e:f39b:2286 with SMTP id
 a640c23a62f3a-c4ca740be5fmr894588966b.0.1793659925605; Mon, 02 Nov 2026
 14:52:05 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260827223755.143247-1-zide.chen@intel.com> <20260827223755.143247-12-zide.chen@intel.com>
 <CALMp9eRvQ+iQdw_dWPLqZCrO7zpLut+O27pb-EPNa33hkegaBw@mail.gmail.com>
 <auUQgRVFASkWtkoK@google.com> <3276824d-f6a0-455a-bf0c-703fc6d52cf1@intel.com>
 <CAO9r8zMxQnRLKGrW69rX7703AatWMp6KOXMObL9baHRPs4dW8A@mail.gmail.com>
 <6c9a13c9-e6c1-4540-a8ca-1f0e800f3571@intel.com> <CAO9r8zOWzr61pkkF01AvEp+YSOo6bA1N=L91RYiM=ETtK5+D9w@mail.gmail.com>
 <69c428d7-239a-485e-9494-32b8aa82da05@intel.com> <CALMp9eRsR8xaUmQyVu5QmYx1cZ2qFGGk+31bMymhmN9_iaPuMg@mail.gmail.com>
 <f7213eba-5b61-4514-a315-bce64823fad5@intel.com>
In-Reply-To: <f7213eba-5b61-4514-a315-bce64823fad5@intel.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 2 Nov 2026 14:51:54 -0800
X-Gmail-Original-Message-ID: <CAO9r8zM4eWD538L3osqSVoB0VHnjgRREtv2k419a1Vvuq+Q9rw@mail.gmail.com>
X-Gm-Features: AclHuK_2rBhHLL0tYLOP9nLQiYxSAqJwaA8XVvekSHYFiqb69UryMmLey5Dw9Ps
Message-ID: <CAO9r8zM4eWD538L3osqSVoB0VHnjgRREtv2k419a1Vvuq+Q9rw@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and
 GLOBAL_INUSE MSRs
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Jim Mattson <jmattson@google.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 2:48=E2=80=AFPM Chen, Zide <zide.chen@intel.com> wro=
te:
>
>
>
> On 11/2/2026 4:25 PM, Jim Mattson wrote:
> > On Mon, Nov 2, 2026 at 2:13=E2=80=AFPM Chen, Zide <zide.chen@intel.com>=
 wrote:
> >>
> >>
> >> On 11/2/2026 3:36 PM, Yosry Ahmed wrote:
> >>>>>>> 1. GLOBAL_STATUS_TRACE_TOPAPMI_BIT can leak from the host into th=
e
> >>>>>>> guest. If a host PT PMI arrives while the guest context is loaded=
, bit
> >>>>>>> 55 will be set for the guest, and the guest won't be able to clea=
r it if
> >>>>>>> OVF_CTRL is intercepted (it will #GP as it is reserved for the gu=
est).
> >>>>>>> Similarly, the value can't be restored through KVM_SET_MSRS.
> >>>>>> I think mediated vPMU assumes that no host PMIs can be generated w=
hile
> >>>>>> guest PMU state is loaded.
> >>>>>>
> >>>>>> If PT state can leak into the guest via bit 55, similar leakage ca=
n also
> >>>>>> occur for other status bits, e.g. when the guest exposes fewer
> >>>>>> general-purpose or fixed counters than the host.
> >>>>>>
> >>>>>> The scenario where both host and guest can be active simultaneousl=
y is
> >>>>>> handled by the perfmon_mask case, where intel_mediated_pmu_{load,p=
ut}()
> >>>>>> filter guest-owned status bits.
> >>>>> Looking at the code:
> >>>>>
> >>>>> kvm_mediated_pmu_load() -> perf_load_guest_context() ->
> >>>>> perf_ctx_disable() will iterate PMUs with for_each_epc() and disabl=
e
> >>>>> them, which skips PMUs without PERF_PMU_CAP_MEDIATED_VPMU.
> >>>>>
> >>>>> Same for kvm_mediated_pmu_load() -> perf_load_guest_context()
> >>>>> ->ctx_sched_out(), it also uses for_each_epc() to iterate PMUs and
> >>>>> schedule them out.
> >>>>>
> >>>>> pt_init() does not set PERF_PMU_CAP_MEDIATED_VPMU on pt_pmu.pmu.cap=
abilities
> >>>>>
> >>>>> Please correct me if I am wrong.
> >>>> My apologies, this bug is indeed real because pt_pmu lacks the
> >>>> PERF_PMU_CAP_MEDIATED_VPMU capability.
> >>>>
> >>>> Adding this capability to pt_pmu seems intuitive, but unlike
> >>>>
> >>>>                        the core PMU (which merely toggles enable bit=
s),
> >>>> Intel PT is an AUX-based PMU. Stopping and restarting it on every VM
> >>>> transition is heavier, and I'm not sure whether it could introduce a
> >>>> noticeable performance penalty.
> >>>>
> >>>> However, whether the solution is adding PERF_PMU_CAP_MEDIATED_VPMU o=
r
> >>>> some other mechanism to enforce mutual exclusion between pt_pmu and
> >>>> mediated vPMU, we can address that in a separate patch.
> >>>>
> >>>> To immediately protect guest state and live migration in this series=
,
> >>>> I'm thinking of adding the following defensive filter in
> >>>> intel_mediated_pmu_put():
> >>>>
> >>>> + /*
> >>>> +  * Scrub bits that are not virtualized for the guest to prevent
> >>>> +  * possible host state from leaking into guest state and breaking
> >>>> +  * live migration.
> >>>> +  */
> >>>> +  pmu->global_status &=3D ~pmu->global_status_rsvd;
> >>> This doesn't prevent the leakage, it just clears it on the guest->hos=
t
> >>> switch. So it helps live migration but I am not sure if it's better o=
r
> >>> worse if the guest sees the bit unexpectedly appear AND then
> >>> unexpectedly disappear.
> >> Right, as long as the GLOBAL_STATUS is passthru, the leak can't be
> >> prevented.
> >>> We can clear it when the MSR is read by userspace, which should fix
> >>> live migration, but the guest will still see the bit, and it will
> >>> still disappear unexpectedly but only during live migration.
> >>>
> >>> The guest still won't be able to clear it when OVF_CTRL is intercepte=
d.
> >> GLOBAL_STATUS and OVF_CTRL share the same interception policy. If they
> >> are passed through, the guest can see the bit and clear it; if both ar=
e
> >> intercepted, then bit 55 can't leak to the guest.
> >>
> >> It's not perfect, but at least the guest won't observe bit 55 and then
> >> get an unexpected #GP when attempting to clear it.
> > I'm not sure what imperfect solution you are referring to, but Yosry's
> > proposal that the bit gets cleared on a guest->host switch is a
> > non-starter. MSR bits must not vanish unpredictably.

I don't think I proposed this? :)

>
> Agree, then maybe Yosry's suggestion is what we can do for now: filter
> out unsupported bits when the MSR is read by userspace.

This I did propose, but I also noted that the MSR bit will still
vanish unpredictable, just on save/restore instead of guest->host
switch, which should be better.

>
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 38c7a4fa1007..3849b3f5234a 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -862,6 +862,8 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct
> msr_data *msr_info)
>         switch (msr) {
>         case MSR_CORE_PERF_GLOBAL_STATUS:
>         case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
> +               if (msr_info->host_initiated)
> +                       pmu->global_status &=3D ~pmu->global_status_rsvd;
>
> The underlying issue still requires proper mutual exclusion between
> Intel PT and mediated vPMU, which I think can be addressed separately.

Or maybe handle the host PT while the guest is running? Not sure if
that would be correct.
