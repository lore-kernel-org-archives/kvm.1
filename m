Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793658346;
	b=48+YNrANz4msXm7l/OkuKWCLFB9/pi1W9E6hSMkI+ZeJTDfpC8W+rGRyMrEILkCE9gge
	 NTI5JnNnAPPyXNWX/s6uta6ptoGeYwmdjJCcOKnumJ9s4KJyclB6h4FCN9imBr+/Pu2gh
	 TEcyCW5iIESsoJe8zTRDXBQxOESON09BBNvD1tuU15eQqCHbFflcjLifNVUWRI8G2lby7
	 Wgjzpbhz2Cx5PFtbUx9B3lSrNYF1bsyHxGNFhV4c7CY8gEPMa4yK3S9sshohkXk8SJM8i
	 ey78+nMo/zeULvzSH4GizX37taUMljTOt0t78TLgt+pNriPueJIEe19QP/SZnnU/IwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793658346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Vrq4CVs6mJDEjF2xNX7uMso578nq3pxdhCMsIm+kdqA=;
	b=00uiPNPBIAYF51Mq6SahswqAQ7lH1I8F0rJdGSqItgZ2F6w/iYeHDSgtE0I2nJBYKTrT
	 OkB9r8vaOhDFFHJMrwQ81uiZUi0FXIxDdVbfGjewAFNEBQiz1WiJqh0+ZZDiPfui6s5BF
	 5bL7p+/W7R2um5NVhDU3z6BJHjI6q5kBpxNmdfoN2cfWfH6L80P/ca7qYPOkI+v8Kk4pt
	 zITOUDpkOcsVcKuYRkJ2Ef6u92U5qfsriU05tZ5WumUn3IoxiiXR4xRuUWfUVQ26fAnDb
	 OPm11c+VV6UZPV1+ITujpkiqPq+NGsFJr70Ey7yyuqNzjghkE+0Eb8r8vHt+qHl0Avw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="og/PJlRg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF7B606A324
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 22:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FF7B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=og/PJlRg
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso947a12.1
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 14:25:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793658345; cv=none;
        d=google.com; s=arc-20260327;
        b=hcdzTjAUC0F4Uxi7XhaoqbLZkb7tue1NzurU4a0/lEoYK4eId8KiHX1I/q9Wt1Ti4G
         lEE8sg3tNVSb06JkaEVuWvgLdWqF5x6i7tImk/4Jn0uf7DeYqw4sMDadytF2I4f+AIJa
         SjpgKD7v2z3Z9xxcprnRHBzBEhaJkoorwqk9yuBhaSv4dbLoR/5VhVLK8Bos3N9g9uKB
         6DW/wS4hEd+gd2KRPCJn2bbW+0HdXHihP/U1rMSfmc3TIMhe2oeRwNvlDA3M6Af0aSoM
         N2llDsy45E0lBGkJvQj4BBsgSqDx3Q+cAA7iI++9bs/h2Ye/mmQY81SDuIdZM0Mxvfjm
         DFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vrq4CVs6mJDEjF2xNX7uMso578nq3pxdhCMsIm+kdqA=;
        fh=W3QpUH7LAhBeSMJFET3tTGljT3LDyKh18O2SQVlxxXc=;
        b=Ho+alU/QfAfPitFkXSdRd8KW5YywgRj2ui+EeRDhmuIi/+VPELcg31dti2KjfnOAHn
         WRJBH290RaXmHkDqguSrhuvX8pIt25hXRbgP7+lvkMX6SxsK1IFe/HI1NRml8grZY75o
         ZhvZO/oVUVTOsBaS9d+FzyKqqPgJ7EJ4SbyFsWaXuveP2y/Jbnms9w8vU3VTG9vQPNu4
         OGW/g0t7WvNqSh3qI84jQlFty8WMHnvuG+nqnTIGgNVwH2zRzf3GpP9AD6h+dBOgRCAJ
         cNnNKPad5Se9h5Z92wV9wZtbQa9Vxqc717w77l8WfWOXkzRJNTyxdr9RJHKWmE718UFE
         fy/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793658345; x=1794263145; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vrq4CVs6mJDEjF2xNX7uMso578nq3pxdhCMsIm+kdqA=;
        b=og/PJlRgrFDz11cuit4CTCsoMeTKqnxgm0MQxXtbHlClqvxLWyHJPt4Vhxsm+V1hRU
         hnKj+HTAOJsVfVyst1WMNh6ZIsRwnjiA8L0CL3WWwHhmkv22ZI5NhMJ6Xn8yzaEzonho
         LD7Sw8v5e+CTBLwewuRNengVeamR0TCR6wn3FscdY+1dZNOG8nzdoXv/fOHaynzw/PHz
         mluTkM2PZ52Kx6kGvO/QjKfuF5rT0UniQ+wBbL59XUcaGonkmjCNBiek+lT1mXPeUybN
         oilRH/QGyzjUko+fj/0xTPAdvDpfDE2DVtMK5PDTNFPr0qglYaPJg4JXSyiPVP9QDrBW
         VBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793658345; x=1794263145;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vrq4CVs6mJDEjF2xNX7uMso578nq3pxdhCMsIm+kdqA=;
        b=IrgnB1L4BO+XuPR15R6o7FD0D5NZBy3YnP3ATQyNVjQ1Hm61NtSkrt0+09rtGzoWHB
         SAbXLuUEMWi0UB9U/uNyPktFWAODoWtC0Mj7T8RuFYda7ecZavtXnvUi+epN/yzMs5Ne
         tTV5soj3qQTUiZkRD4YK8kNftO0+TnWL3n3+h+FmdAv5BE15yCMAi7ec400PyBZTVIIU
         +6LGyOtcdNVK9jzVv5FuEf6x5n0LfOWaXg8WmgsjJJa2FTVAMzHMngj56d5F9LPDZJbJ
         AABLn77WWAEJQTnSM9ZnM/qK1CqTEU0c6OCNafs32b41SmHfnt6F6VoYQAEoBLxBScp8
         Cffg==
X-Forwarded-Encrypted: i=1; AKwUvBxUVAerBrre6TKX5yKBDiddcJGT/+K0BoWcouoNDifKdgtIBAKrO9XXodHEeggHdqxqzuc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8J+fChnEkgyxMSD+NSPmhiR+hwY28SNGX8xXPdR6hLgpp51RFP
	s8ACuKpyH+tR9eiA40YIjKViMHEa2aymKyjGG0qt6k6gvT2Ek5hl8F8p9BpWq+K9jqnuZno0a9D
	IHTnFsHJRJJl9Hiw574RW8NfDe1Yt+4f0MS8fxaLL
X-Gm-Gg: AYBFou20EFIn6J/+AvcfxjDDuhrSKETganlewt5O5YUj1Ftnw5keIpbJ+1lMXt9P7Ia
	Axc9wUZr6ITBavquVxoAm94m1A+P0eHhHDRuj7MXstkQFWlhYvYBe4eaBr21H9CKt57A0QjVR9r
	EZHn7/eJ//YfzhIM1ft4uydaEvrTF3CrjMgwnh76OIPuwAcGXUoPbIig0VADKczb50WIkh1X0QP
	SSLPxHbSl9/WQ6A4eaIPi7/WVmFzFqJYSDxo2ajoUj5WKu+Wp3Lmi6CKxrAGv3A1FifAij2CrES
	Gfq9UnZ8uQnQN4At5h9fFM59ACH+U8EeObC0YTQ0QWnJznbcJVtB62ri0xZw8olqabQ6BtodDMw
	Ap2wL+3lu8stg0bjSX+ZIZBgGynq1+MfzPyL8
X-Received: by 2002:a05:6402:10c9:b0:6aa:128c:36ad with SMTP id
 4fb4d7f45d1cf-6b53e764c47mr5314a12.10.1793658344205; Mon, 02 Nov 2026
 14:25:44 -0800 (PST)
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
 <69c428d7-239a-485e-9494-32b8aa82da05@intel.com>
In-Reply-To: <69c428d7-239a-485e-9494-32b8aa82da05@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 2 Nov 2026 14:25:32 -0800
X-Gm-Features: AclHuK-Cg-hCvFwpQyev-snLvGrjjN8oCWiVCvcXqcfI9YoxexkU_ERZvH5A9ao
Message-ID: <CALMp9eRsR8xaUmQyVu5QmYx1cZ2qFGGk+31bMymhmN9_iaPuMg@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and
 GLOBAL_INUSE MSRs
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 2:13=E2=80=AFPM Chen, Zide <zide.chen@intel.com> wro=
te:
>
>
>
> On 11/2/2026 3:36 PM, Yosry Ahmed wrote:
> >>>>> 1. GLOBAL_STATUS_TRACE_TOPAPMI_BIT can leak from the host into the
> >>>>> guest. If a host PT PMI arrives while the guest context is loaded, =
bit
> >>>>> 55 will be set for the guest, and the guest won't be able to clear =
it if
> >>>>> OVF_CTRL is intercepted (it will #GP as it is reserved for the gues=
t).
> >>>>> Similarly, the value can't be restored through KVM_SET_MSRS.
> >>>>
> >>>> I think mediated vPMU assumes that no host PMIs can be generated whi=
le
> >>>> guest PMU state is loaded.
> >>>>
> >>>> If PT state can leak into the guest via bit 55, similar leakage can =
also
> >>>> occur for other status bits, e.g. when the guest exposes fewer
> >>>> general-purpose or fixed counters than the host.
> >>>>
> >>>> The scenario where both host and guest can be active simultaneously =
is
> >>>> handled by the perfmon_mask case, where intel_mediated_pmu_{load,put=
}()
> >>>> filter guest-owned status bits.
> >>>
> >>> Looking at the code:
> >>>
> >>> kvm_mediated_pmu_load() -> perf_load_guest_context() ->
> >>> perf_ctx_disable() will iterate PMUs with for_each_epc() and disable
> >>> them, which skips PMUs without PERF_PMU_CAP_MEDIATED_VPMU.
> >>>
> >>> Same for kvm_mediated_pmu_load() -> perf_load_guest_context()
> >>> ->ctx_sched_out(), it also uses for_each_epc() to iterate PMUs and
> >>> schedule them out.
> >>>
> >>> pt_init() does not set PERF_PMU_CAP_MEDIATED_VPMU on pt_pmu.pmu.capab=
ilities
> >>>
> >>> Please correct me if I am wrong.
> >>
> >> My apologies, this bug is indeed real because pt_pmu lacks the
> >> PERF_PMU_CAP_MEDIATED_VPMU capability.
> >>
> >> Adding this capability to pt_pmu seems intuitive, but unlike
> >>
> >>                        the core PMU (which merely toggles enable bits)=
,
> >> Intel PT is an AUX-based PMU. Stopping and restarting it on every VM
> >> transition is heavier, and I'm not sure whether it could introduce a
> >> noticeable performance penalty.
> >>
> >> However, whether the solution is adding PERF_PMU_CAP_MEDIATED_VPMU or
> >> some other mechanism to enforce mutual exclusion between pt_pmu and
> >> mediated vPMU, we can address that in a separate patch.
> >>
> >> To immediately protect guest state and live migration in this series,
> >> I'm thinking of adding the following defensive filter in
> >> intel_mediated_pmu_put():
> >>
> >> + /*
> >> +  * Scrub bits that are not virtualized for the guest to prevent
> >> +  * possible host state from leaking into guest state and breaking
> >> +  * live migration.
> >> +  */
> >> +  pmu->global_status &=3D ~pmu->global_status_rsvd;
> >
> > This doesn't prevent the leakage, it just clears it on the guest->host
> > switch. So it helps live migration but I am not sure if it's better or
> > worse if the guest sees the bit unexpectedly appear AND then
> > unexpectedly disappear.
>
> Right, as long as the GLOBAL_STATUS is passthru, the leak can't be
> prevented.
> > We can clear it when the MSR is read by userspace, which should fix
> > live migration, but the guest will still see the bit, and it will
> > still disappear unexpectedly but only during live migration.
> >
> > The guest still won't be able to clear it when OVF_CTRL is intercepted.
>
> GLOBAL_STATUS and OVF_CTRL share the same interception policy. If they
> are passed through, the guest can see the bit and clear it; if both are
> intercepted, then bit 55 can't leak to the guest.
>
> It's not perfect, but at least the guest won't observe bit 55 and then
> get an unexpected #GP when attempting to clear it.

I'm not sure what imperfect solution you are referring to, but Yosry's
proposal that the bit gets cleared on a guest->host switch is a
non-starter. MSR bits must not vanish unpredictably.
