Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793663072;
	b=PzryJLHwat7KGEqpoqfiFddG1JoP0fWplu+kMouQMOQmbK7P3W4/UyNX2v8IFfW77uyw
	 xr8b2tOh0yUW1Qjr5ohRQGkWEh4+2RGGiskfre8tI5TO6qyUC5t2+z7HtO/2BDveI+rTM
	 WJp6lWTgrb9sWFV2805/B0ycWJ22mydDTffPlFWRMNoslPV0a8GBoM+qXN+RY1Jdcs6J1
	 t3ea/f19qHPSj4QakktQZhAbVAcBmGw1QOznrhbqDIANJYpCmV1ZXWPN1aA+tdGWcNuzA
	 r1yi1b0Z0zFlqMs7+hUKJJg5Z9uV7HCWFHcH9+rQXg7k5G/YJKjxrJ6xjNM1QvejuAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793663072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TNEeC5pua4/FbwyGVOQ8AWkGjsS+NBvpjdfyZDyp6tQ=;
	b=ok8mfdh4KgvGaxWiDFDTJ8cVr6mCtZp0cqcFFWQ6DJfRkS8dkWYyR1kwltxPOSdHUw6L
	 VuMvsUgmJaIJiixaxmnSu1KMdJDZ9M0QN70d+BnoytbYjIiG4/71ctzmKTrV9u6MDgf5z
	 UPLtu0Z0Pexs7qC9f+0rD4/a5SG75cWH1TEvyBnZheyyhS4z458shXjtRiopqYX615pFx
	 CV8TilRTBhEOK7ffe+Y0vyrzW1XdzMrOp5kqF3wOZj2oiDG8eqziuEcvaV4SvLMX6a/kG
	 p7XM3+iFCKeTC/pPePZXJHrkMIo0KJfqqHEZ12hQgu4ZYAv/rLnevWncf9NtFIzPGNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SrHuwxu0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A58606A324
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 23:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94A58606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SrHuwxu0
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so1350a12.1
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 15:44:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793663070; cv=none;
        d=google.com; s=arc-20260327;
        b=auiBD07wRyylLOmSZAud9YQ1iPg3bQp2n5TKeUCm2gIysA1tcKUDrI2cdPw9R+yl1M
         WDR9HEZRSMQMqKmco+p0eqb0VG/qSDdr6fVqxemqYvoFcGc5Xo0q3W+2Lvc8kTE7eHII
         j6UsAWHjsv1c4wk6HE/BLphOMH06SRAk3LOTQwP4OxxuCQoI3mqkD7ScmN6ambtIvc7q
         tgiq3MNaiwlM5acqJ5Ionb1zgzLbaS0xxi8eJDYYLXPzT1jTGYddw9wVGr6emGCqIF1/
         fUWthUPj8A2p938eErYFgzGdo/yG6aFBnlagnXDhuUX2BIu9WahdidVADJ9SgvM2A52h
         6Wqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TNEeC5pua4/FbwyGVOQ8AWkGjsS+NBvpjdfyZDyp6tQ=;
        fh=w4i93DQd8l8r5UyGbTDIvkibGtSbXB/QV/Th9jzkMTA=;
        b=Ao8pSSwdbFWWQpzJjwiOkNNiCnVn7B+WxICqVA7I7eX/imGERemF/L3KENnI7YHpEK
         sod++9l+ElMu1NpfoC+U6lormdwh4oSRW+g0UjL2bKaILCTiEyWsZUSJE3ocePgfOhJP
         SJ0pB2NRcpv8dM0YoBGdHNzU/wn2+BrpIRLTgAn9rD5g77TDJGfTjB064jAExYHrNrbs
         vdBgPq5nTqC5dY+5ZrO6oOlyuzXSWdxjuetyLOPqmkZ0CKVlN14XC0RSq3ZeFfimgEK2
         f2C7PZsyuVMdB0h79zzfAFY5aJUrdy682KcazJsY+06D8whvHUgqsjdyQjUcgeVnrqtI
         9gCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793663070; x=1794267870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TNEeC5pua4/FbwyGVOQ8AWkGjsS+NBvpjdfyZDyp6tQ=;
        b=SrHuwxu0OA7hy5K2ovTqpGpNg9M0+WPa9AS7+NxROMiLDRIdOt8pLsRu5QLdPG/Ukx
         QTKcgOwuxVjoZzNXkqXiT7AGfuRHR5QzK7zwPBK4AvMxePovZn8m7niD8sJ0ADnjDsJX
         cJGlsuiIBkPXdqQqszZLUqr4Wo9Ni/tUk33C/WtGIcODvr0rlm8yaiiq3V25sxnBbUY4
         2/gxg18rbzG+yGk9birQnzyCsfaJn4u/jzQVHF6vk7HxLTQqHMlXbZqMwgIXMjQF7FsV
         w5xvuv6cu5s9Et1j3jLFSAPUzhkLCDEnOf+VdCSo95JEN7oEdVUwCZtxzgxG3OtpAUcV
         Vz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793663070; x=1794267870;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TNEeC5pua4/FbwyGVOQ8AWkGjsS+NBvpjdfyZDyp6tQ=;
        b=g8G5XZe8PBXDj8vDRBuCq1eoTr7uyCQA3JzpwcJTIvtAl+BVRBm+wCoKaC2fPzLQRD
         5KY1SBDTVDyid12ryCwRLIEhKBQbUzjg28Lzquhgj3cBQZPYgSMYrr34v5+M7vKUSftg
         cmwEc6z+LCCKtssVUaAuJtABOs6AaXPdO0UzhMqhgCwHVP789W0Y48yD4ClW+Je8cN/L
         i/cEOaQpKx2N7DF2kkLps3+azfq8OZOmFPV3cJ4pYBE9r8YQxjy+iDnsx7TV53MNVZ+J
         6LwONfqUJbxdN+oBunKjT31dIuQmynnrYyyHlGXq5bYLIPoDFWu4ae3n0hwwdClCek8w
         +/jw==
X-Forwarded-Encrypted: i=1; AKwUvByHkRWvVEjc9wvsufrY5NAmvog4kn1Jz6FOu0iUQR5CAd5QpL7wEL2SsmDypB3TBupEi5g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9H8bFhyANeq8iX/n1LgQeXSpeCoDGXcQNa85U0HuhLLj5bmzwF
	ZqsQ8UFSHYACWum3bGSO/gddpOPWRMEl1Ic9+DNerSKcayEvNwTQ9vl75uIYm/3o7e1qOCYepX7
	nCOch+i5PHbr+wyNQeN33BK/vCfBcWjild8g4RnBi
X-Gm-Gg: AYBFou2EmOX3yaVhNCi6ABbAEfZpOqZoAOXp7159u6GwsbtXWqDPa0gaD8UQbK3n2Sq
	m8dEqKs6syZJfL0y5122kkmtMp9Q3zOJ/bwehCAHgQiXTyOizcKBEWkZTUnxd3rti0bclAgcYaz
	28ydTatAcNPUaHEW1Dk1IzEofLDFGhCnAg9h/rRvU/W7POjNtDzGZHEKbWX25LRRuLpaIATU7OF
	xiriXmbVgtTH/MbzFuhNbJXP6j0zwEPjeikIPfvnWk4ykaRW1jdXTTI4hYGS3yOV1JIlgRX/vcF
	a3U419050TOV+faqOIti07MEbFSe2eGvGYED1c2n6r1yT7rN2Fd14ovlQgTH+AGHMP88rHF+ppH
	4k0v4e48LoPdrq7qXvtdTY2YgvgHpvxo/Lqd3tIpzbqthELQD64VJVaFQRg==
X-Received: by 2002:a05:6402:238e:b0:6b4:5f93:339c with SMTP id
 4fb4d7f45d1cf-6b539cdbffdmr17311a12.3.1793663069589; Mon, 02 Nov 2026
 15:44:29 -0800 (PST)
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
 <f7213eba-5b61-4514-a315-bce64823fad5@intel.com> <CAO9r8zM4eWD538L3osqSVoB0VHnjgRREtv2k419a1Vvuq+Q9rw@mail.gmail.com>
In-Reply-To: <CAO9r8zM4eWD538L3osqSVoB0VHnjgRREtv2k419a1Vvuq+Q9rw@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 2 Nov 2026 15:44:17 -0800
X-Gm-Features: AclHuK8P1m7t5vt3Bx8GjuqEUPevdnDGV0WRQiLnhUfpSiQOAaom_jdohRxq-k0
Message-ID: <CALMp9eQPaGG+-wsfp541OTJAP2G0Pq9L2aDeRG0_MFHoa67x0w@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and
 GLOBAL_INUSE MSRs
To: Yosry Ahmed <yosry@kernel.org>
Cc: "Chen, Zide" <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 2:52=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrote=
:
>
> On Mon, Nov 2, 2026 at 2:48=E2=80=AFPM Chen, Zide <zide.chen@intel.com> w=
rote:
> >
> >
> >
> > On 11/2/2026 4:25 PM, Jim Mattson wrote:
> > > On Mon, Nov 2, 2026 at 2:13=E2=80=AFPM Chen, Zide <zide.chen@intel.co=
m> wrote:
> > >>
> > >>
> > >> On 11/2/2026 3:36 PM, Yosry Ahmed wrote:
> > >>>>>>> 1. GLOBAL_STATUS_TRACE_TOPAPMI_BIT can leak from the host into =
the
> > >>>>>>> guest. If a host PT PMI arrives while the guest context is load=
ed, bit
> > >>>>>>> 55 will be set for the guest, and the guest won't be able to cl=
ear it if
> > >>>>>>> OVF_CTRL is intercepted (it will #GP as it is reserved for the =
guest).
> > >>>>>>> Similarly, the value can't be restored through KVM_SET_MSRS.
> > >>>>>> I think mediated vPMU assumes that no host PMIs can be generated=
 while
> > >>>>>> guest PMU state is loaded.
> > >>>>>>
> > >>>>>> If PT state can leak into the guest via bit 55, similar leakage =
can also
> > >>>>>> occur for other status bits, e.g. when the guest exposes fewer
> > >>>>>> general-purpose or fixed counters than the host.
> > >>>>>>
> > >>>>>> The scenario where both host and guest can be active simultaneou=
sly is
> > >>>>>> handled by the perfmon_mask case, where intel_mediated_pmu_{load=
,put}()
> > >>>>>> filter guest-owned status bits.
> > >>>>> Looking at the code:
> > >>>>>
> > >>>>> kvm_mediated_pmu_load() -> perf_load_guest_context() ->
> > >>>>> perf_ctx_disable() will iterate PMUs with for_each_epc() and disa=
ble
> > >>>>> them, which skips PMUs without PERF_PMU_CAP_MEDIATED_VPMU.
> > >>>>>
> > >>>>> Same for kvm_mediated_pmu_load() -> perf_load_guest_context()
> > >>>>> ->ctx_sched_out(), it also uses for_each_epc() to iterate PMUs an=
d
> > >>>>> schedule them out.
> > >>>>>
> > >>>>> pt_init() does not set PERF_PMU_CAP_MEDIATED_VPMU on pt_pmu.pmu.c=
apabilities
> > >>>>>
> > >>>>> Please correct me if I am wrong.
> > >>>> My apologies, this bug is indeed real because pt_pmu lacks the
> > >>>> PERF_PMU_CAP_MEDIATED_VPMU capability.
> > >>>>
> > >>>> Adding this capability to pt_pmu seems intuitive, but unlike
> > >>>>
> > >>>>                        the core PMU (which merely toggles enable b=
its),
> > >>>> Intel PT is an AUX-based PMU. Stopping and restarting it on every =
VM
> > >>>> transition is heavier, and I'm not sure whether it could introduce=
 a
> > >>>> noticeable performance penalty.
> > >>>>
> > >>>> However, whether the solution is adding PERF_PMU_CAP_MEDIATED_VPMU=
 or
> > >>>> some other mechanism to enforce mutual exclusion between pt_pmu an=
d
> > >>>> mediated vPMU, we can address that in a separate patch.
> > >>>>
> > >>>> To immediately protect guest state and live migration in this seri=
es,
> > >>>> I'm thinking of adding the following defensive filter in
> > >>>> intel_mediated_pmu_put():
> > >>>>
> > >>>> + /*
> > >>>> +  * Scrub bits that are not virtualized for the guest to prevent
> > >>>> +  * possible host state from leaking into guest state and breakin=
g
> > >>>> +  * live migration.
> > >>>> +  */
> > >>>> +  pmu->global_status &=3D ~pmu->global_status_rsvd;
> > >>> This doesn't prevent the leakage, it just clears it on the guest->h=
ost
> > >>> switch. So it helps live migration but I am not sure if it's better=
 or
> > >>> worse if the guest sees the bit unexpectedly appear AND then
> > >>> unexpectedly disappear.
> > >> Right, as long as the GLOBAL_STATUS is passthru, the leak can't be
> > >> prevented.
> > >>> We can clear it when the MSR is read by userspace, which should fix
> > >>> live migration, but the guest will still see the bit, and it will
> > >>> still disappear unexpectedly but only during live migration.
> > >>>
> > >>> The guest still won't be able to clear it when OVF_CTRL is intercep=
ted.
> > >> GLOBAL_STATUS and OVF_CTRL share the same interception policy. If th=
ey
> > >> are passed through, the guest can see the bit and clear it; if both =
are
> > >> intercepted, then bit 55 can't leak to the guest.
> > >>
> > >> It's not perfect, but at least the guest won't observe bit 55 and th=
en
> > >> get an unexpected #GP when attempting to clear it.
> > > I'm not sure what imperfect solution you are referring to, but Yosry'=
s
> > > proposal that the bit gets cleared on a guest->host switch is a
> > > non-starter. MSR bits must not vanish unpredictably.
>
> I don't think I proposed this? :)
>
> >
> > Agree, then maybe Yosry's suggestion is what we can do for now: filter
> > out unsupported bits when the MSR is read by userspace.
>
> This I did propose, but I also noted that the MSR bit will still
> vanish unpredictable, just on save/restore instead of guest->host
> switch, which should be better.

I will reject any proposal that involves MSR bits vanishing unpredictably.
