Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793644372;
	b=329GdOWiA5C1oFU3zMJTr5QcMN47uaNhTNpmD33S8SbrgOcJDJSFtSXTSHzesiv0askX
	 K8gOuKVvNpkh03DseTnL9PkdY3fQztrI6tb6g/jkeqoo0YIwU3oMHERHtEYgoN/6IMdbO
	 IYy2d8dlMw8NbLnigT/Ld28ZzHqv8JwdD2AxL4xsC2yFgETPJvOz9F8Yg85FJBRn05/G4
	 kB1ekvJHXDcLh9hhVXz1aMg34CJyLDE29wzhrt42w+jR/lzQQjs08M92a2ViOGXacx4YZ
	 4Q53IcEHKliTwKfp1aAx6l3YWojY4HCeqleyRwLnQF3gK9jexLdc5alFQK49BUem2XQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YB3c0VJ2rpFd4tVqUs/wI8HYHytn5yPy0WZ3W2zVxqk=;
	b=cm3vg+tGzRzunbvcnpSirHodiRtUAAQpu9j7c5Uk928kyjn0CYim853KYUmO7njr59hR
	 AeQ66Lnwr041H4SZuJPxzDXNEmS6CRHzh3yqEb1I0Xz5TG+HAozzQVztNrW8Oit9YxC4W
	 mho/OPECDAkntZTwD/VCTIbfyLoXn2uxkXLLNXzmzPo9tJIug7HNWNR/C0FNN2OQWJmF/
	 C0HfqB1Yn8IJGJaVgOygtentHwwsJhKvogvfABccgf/eYfv3Nt4qkdFMING1kGT8oXhh1
	 KGNKf1dxCkURSzDts2uK6Oyose2QUv//aioVKa8Vyn7HEVQidi/+IMJ33aPMPzli1ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wjptjc4z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DA8606A326
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68DA8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wjptjc4z
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso44a12.0
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 10:32:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793644371; cv=none;
        d=google.com; s=arc-20260327;
        b=kgc7T3ZHfXkOqfixl2wm88HIGbe2Me/sTag27sVjvy5GT/RFpHwWZJQyELnsLVIydI
         p3GPvJOtykQA7SLw/U8XkGZp2kSRthcAnKeiE3eRfhvk3GafHhojj46DCUOJG72UvMDg
         glJOb1TluAVgdHVhYPtwHb6uFjVFnLKyKgLik4OcpmPXubNVUpkckh2mKZ0W0b8vBn1a
         2vw/YW2mmXyy/9ujLNUJ6c7nPZ2SkGPXDRzhm3QSzFOlspGRJg6Q0VgIaeSZvX7TMh23
         1QiWp+gM6sfuzFZokba2oAI7t8LoJDExwbpdCOtCMVEvHV6e1hBr8tFPt8DDveBlCLVd
         Bzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YB3c0VJ2rpFd4tVqUs/wI8HYHytn5yPy0WZ3W2zVxqk=;
        fh=0CYiuMkGwcgjzmNwchTZMcjOfHFNkaEADA22QIHcU8k=;
        b=HtQIKm2hONkY4POBhjcVuwnxUUZBbE9JrIGRwFIAGrECa3oSBZ8KSZTMhB3XyGxiKK
         GBwpG+MeoHJAIiex7nKVVw8AJ/xQuZV8WoO4IN60/aq103Dlk1YRHfH3zanRAiZjz7DZ
         5jis1ZfTYbmfNPAqhfNo+JMULN/B29qfzTG4telTXaRF4dhqBH9fiUVNJqEhWasjWYby
         apNHQp/T4XmG73mj9lOLO7ELNETJ64c3vT/3plkE/0oqmIuw83e5uSRWD7QiIrEqYpC+
         nK4WjffdqvnMYihUR480a/ISuGkVn0iIs8YvFnd3mVcf54EEpAwSgHLxpzWIUNo8Xo6F
         vcSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793644371; x=1794249171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YB3c0VJ2rpFd4tVqUs/wI8HYHytn5yPy0WZ3W2zVxqk=;
        b=Wjptjc4zJZSx2STlK1NxCVRYDtRciqfYpzSJqPY1hypYzaOZRsWxmF8Wh8zT0UiypU
         slhcjtoaPPnaXkg6jwnRWi50ip4LreVUYPMYbcTT4bnhnT2AwhQ2/EbH4JI7JW9denj+
         AFBbcqwrQjhZwdrcuyqrfn/QdUwKCNqV147jCWsnM20K3h19yoEPoAnb5da4blLg8jqd
         gOWAUDcCvCmFi8CwpBe0KQ865xVXSHrsx2XTRIHcqIIaO24zeyiQOYFF/0lRcB+d3u3j
         ipJZP3jvalHJM9IJvvozebnsJbpFL4PV9WZP8SBBLaDTgiZheO/5oPRjCOtLfPBsxqAF
         4H7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793644371; x=1794249171;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YB3c0VJ2rpFd4tVqUs/wI8HYHytn5yPy0WZ3W2zVxqk=;
        b=w24yVhZjv/n7x1qVxQlKW0kjwhoNMZLmDDzpEAev4aqt+lApOruzWiCa2VY8kvxJcS
         h0upUe6jzXY8tYjOvbCRNeWljI8+RyYjIEyjvvaWajc/pzz9+toZPphNlyJCypVmY9Fw
         9R28LfM1kLcsOVb6lBL/5hfbdrnQUxhqrTiYUyVnler+IKM0vIrcTK3Z93j2rcUlDsxs
         gFrTVkqbYRR6bPge78i2mMGYfqceN0b1VspatQVv8xaz5x3blrigSoRfDxtf4KINH6g3
         Q4OFUrc3IoGiCmPJdpBHheF8sPmkOtCdMtE61KdgG/iJ+dZrOuq6bgNOHXY17k6xyS6k
         t6Sw==
X-Forwarded-Encrypted: i=1; AKwUvBxYQVI3/Zz6pbTTBSgdqBj7ZzelSYI6gdk0ybwHZ42rBpY3gmsbm5HOah/Za6d0uFiQz40=@vger.kernel.org
X-Gm-Message-State: APuU4Z8G0bWxTImdDDYG0mNPIHGbibCRCZ1jUv9QdmFmQr3oNU5eTgSN
	l8hT+R7OyvbNzSbnAbuYfQjWjrFbzyYXYttZq+D9n3SSiymNYSrkrTKQkIhlQhqMY3fHLdN3JWv
	Fn4jwCtFMgUS2HhOVd4pgr2mEPuNw2MgDfB1s1ltk
X-Gm-Gg: AYBFou0HDOXuq9/kpXZ2AMns1GRstQtDo47BxDD81UPzh4pq8pXieeOrr2HJOnTr4rK
	10FbTYqEctPM2sEBbN88chqpLyTA9AbeCh/n8S5LFFRAKgeZUKolTHGMbMxjbVFsqR8KySP1+8x
	adO28jUwj8Appvc6ct6YMuvpsGoJZva2ru8GfF4uJs60efpH+mX5HePIesY9A41cNNgmUBw9Txd
	iVey+cQAw5PPKpsgQB4coIz2IU14DX9Yxq7+QKxs7giUx11wr/oiTWHoTePY5G16m0/Hv9QRcZN
	+ZUcnGfGwVdLthpCzvR9osOMCKLz9wzn+VYVikCEZrg434rn2F43LSK6QWuKIIs8gUv0fd0r0th
	E2yH9SSDDkpWW8UWPdm7etP2U0EiJ+ms3YjNC
X-Received: by 2002:a05:6402:460e:20b0:6b1:aa31:a627 with SMTP id
 4fb4d7f45d1cf-6b4b10df53amr314955a12.4.1793644370270; Mon, 02 Nov 2026
 10:32:50 -0800 (PST)
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
In-Reply-To: <3276824d-f6a0-455a-bf0c-703fc6d52cf1@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 2 Nov 2026 10:32:38 -0800
X-Gm-Features: AclHuK-Bo4Ydf5I9_TcA3ok2eQLscUvZDzf1qXDouSZiHdDa6pavu3yPyZGjv9E
Message-ID: <CALMp9eTiAMLsH7cO9Mc982WwDTAFcYOua+32Ykpj3gR_Oscfww@mail.gmail.com>
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

On Mon, Nov 2, 2026 at 9:38=E2=80=AFAM Chen, Zide <zide.chen@intel.com> wro=
te:
>
>
>
> On 10/30/2026 5:13 PM, Yosry Ahmed wrote:
> >>> @@ -865,6 +867,7 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct=
 msr_data *msr_info)
> >>>         case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
> >>>         case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
> >>>         case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
> >>> +       case MSR_CORE_PERF_GLOBAL_STATUS_SET:
> >>>                 msr_info->data =3D 0;
> >>>                 break;
> >>>         default:
> >>> @@ -931,6 +934,12 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struc=
t msr_data *msr_info)
> >>>                 if (!msr_info->host_initiated)
> >>>                         pmu->global_status &=3D ~data;
> >>>                 break;
> >>> +       case MSR_CORE_PERF_GLOBAL_STATUS_SET:
> >>> +               if (data & pmu->global_status_rsvd)
> >>> +                       return 1;
> >>> +               if (!msr_info->host_initiated)
> >>> +                       pmu->global_status |=3D data;
> >>> +               break;
> >>
> >> According to Intel SDM Vol. 4, Table 2-2 ("IA-32 Architectural MSRs"),
> >> IA32_PERF_GLOBAL_STATUS.CondChgd[bit 63] cannot be set by writing to
> >> IA32_PERF_GLOBAL_STATUS_SET, because IA32_PERF_GLOBAL_STATUS_SET[bit 6=
3] is
> >> reserved.  In other words, it is not possible to save/restore
> >> IA32_PERF_GLOBAL_STATUS when bit 63 is set.
> >>
> >> Because bit 63 is clear in pmu->global_status_rsvd:
> >>
> >> 1. An intercepted guest WRMSR(MSR_CORE_PERF_GLOBAL_STATUS_SET, BIT_ULL=
(63))
> >>    succeeds instead of injecting #GP(0) and sets bit 63 in
> >>    pmu->global_status.
> >> 2. When bit 63 is set in pmu->global_status (whether it was set by
> >>    kvm_pmu_set_msr() or by intel_mediated_pmu_put()), the next
> >>    intel_mediated_pmu_load() will try to write an illegal value to
> >>    MSR_CORE_PERF_GLOBAL_STATUS_SET. I don't think we get a #GP, becaus=
e
> >>    every wrmsr is "safe" these days, but the write will be ignored.
> >
> > On SPR, it does produce a #GP that gets ignored (and logged) and the bi=
t
> > is not set.  Interestingly, on CLX, the write goes through and the bit
> > is set. Didn't check other CPUs.
>
> Good catch! I tested a few more CPUs (DMR/CWF/SRF/GNR/NVL/LNL), and all
> of them #GP on writes that set bit 63.
>
> However, SKX, CLX, and ICX accept writes with bit 63 set and do not
> generate #GP. On those systems, bit 63 also becomes visible when reading
> back GLOBAL_STATUS. This behavior is documented in their errata:
>
> SKX95/CLX89/ICX166. Bit 63 of IA32_PERF_GLOBAL_STATUS_SET MSR (391H) is
> reserved. Due to this erratum, setting the bit will not result in #GP.
>
> SKX:
> https://cdrdv2-public.intel.com/336065/336065_Intel%20Xeon%20Processor%20=
Scalable%20Family%20Public%20Specification%20Update_rev17.pdf
>
> CLX:
> https://cdrdv2-public.intel.com/338848/338848_2nd%20Gen%20Intel%C2%AE%20X=
eon%C2%AE%20Scalable%20Processors%20Specification%20Update_Rev028US.pdf
>
> ICX:
> https://cdrdv2-public.intel.com/637780/637780_3rd_Gen_Xeon_Scalable_Spec_=
Update_026US.pdf
>
> Given that SKX95/CLX89/ICX166 document this behavior as an erratum,
> while SPR and newer CPUs appear to follow the SDM and #GP, should KVM
> continue to inject #GP for writes that set bit 63?

Ugh. It seems like we have two options, neither of them all that appealing.

1. KVM fixes the errata and raises #GP. To ensure consistency, KVM
always intercepts the MSR on affected CPUs.
2. KVM mimics the errata and allows writes to bit 63 when virtualizing
affected CPUs. This allows the MSR to be passed through, unless an
unaffected CPU masquerades as an affected one.

Sean? WDYT?
