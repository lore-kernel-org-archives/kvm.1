Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793361352;
	b=uldLrglM4HEaXg/VyI8HLyyOeRGRpp9LaF+pPgdFP5S6/DJ4JT3Fy19z3kDQxIMkUeCD
	 SmNtefgaU82Q5uTKRWHfIzf9lpf2Zp0hms7KcUC303qQGQm1N2E44sZ2QbXzdsQ4z90ca
	 v2ThkKrrY54rYrpKXcTOYOgDb2N1TNJ2wx5M5Q05LsWd0L8U1VRIOF/HIqiswHpZe1+9M
	 89gVb2ddJp5EyQD7aNy+XJqoHORjM9suj2ZE6iHlWqIaMqGrPfGJB8zFaHe4G5GCxm5nQ
	 AnnnRd8OyLlLdYqyfNIIkXvF/oElgtk3UVFnKOH4WKneKG5Evp2TguzA3Ay/f22rr2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gynuYOYjBlWXiC/Ji28tlTf9iaepwWTtf+nCYUbuqa4=;
	b=axAa1Cc4S8U8uaOO2ITBbLoO1U5kk9qQnHbS4df39DmQEXS8u/Auw4qNiopwox7VqMUB
	 DlNKHiT8QmIFbH/4etL6KopQeE7jWAe9PHqc1hMGREph+0d+T9a4YaYxDAW2ZmlcIp4Fh
	 PbUaHDOaU1MneDnR6o/rm5wKrh5bmcrnyDeZ83FGQ7VEsCxceLgkjvyOOssOVPv0j8y/e
	 c2oGmNq3Bl2eWRahpFVXHqh3Dd+OiCN/Swc3TNP2LKWLdDkYvHTkE2sWeRyJbsqpJfBNc
	 OslUV2PmevcQTatoB2f95/ExcDRSEUjGmIV2qw7+saN0ujvbt0Wft846bWYJUZ4U9vQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=boxhw4dH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69726606A326
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 11:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69726606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=boxhw4dH
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso11165a12.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 04:55:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793361351; cv=none;
        d=google.com; s=arc-20260327;
        b=ChMjd5RoBa2fubU+0YfyE9/6zcOCqxkuI77T+opbw6/YHsyLCmrZGGDoaZziCFCDh1
         xamvpEIenblEYHYJp1CwlbCIkdlqUl5R6QjyeGNsoF4XMNRsv1Nhm6Ueg+x77qFb7Uih
         0PE5YecGqYxTCamOhj1dARJglOZvcLI+Uyzo33QH4ZbAUhuq3tFWWuqUr43937/ltyCu
         UrgiddlHYbbGLUKG+LDsG+c3xA8yVJx/818tjER2cFkCFwZBsPtPV8K9dt96ogUMS+ps
         qI5P/aaK/B6IH8VZNF94RIUPJrFi1oVx1+AzkVM5r+NlrsspCoTEA/C8/mKVelDjlCCj
         1U5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gynuYOYjBlWXiC/Ji28tlTf9iaepwWTtf+nCYUbuqa4=;
        fh=KmA0O6E6SrdItJB3aM06Q3VWiKneSn4Nr+HtSJ54AH0=;
        b=Q24cAUEowO2Q5OWWwnMVtfwd4izcyZTVvm/aQeNTlYteC2Dx8vrIgGvcNyKK1lKxId
         1GBoHPuNpmdqGnQ8e306AUMYCdbPqF3q+k7gHQAPImfLYrQrUWmHk01wkdT80ahp8imP
         OiNk/vq8KBkDhhPCLVD387hr+B+t1whH4eAMAvwNj5hLBpNVTr4XElDIu9WmMjOdizRX
         85Bct0Cp3UNuGcR1SS09puvVwDeR0qmlY9HzZAgF0LkQ5gFXPetb1FBVrv70o2Usayi8
         zKWRxe/jS+eRnP7YfMysRskWSr29QaMd5YqWwYXAllvEe1ujUdzLH8tt88z4UrZZSvvw
         +3kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793361351; x=1793966151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gynuYOYjBlWXiC/Ji28tlTf9iaepwWTtf+nCYUbuqa4=;
        b=boxhw4dH86RIu+y5xz+rjBlb4lW673ZL0lmVmDE269CuQ2MCVDr2OVFsLbJ8hi1sIg
         /bHsfkhKJK5R4k9j4NeShwo2c1vPohfq03Z3e0B24rHWjQ8i5dikKTbdAp5dvSEG/Gy5
         WMaktuLq1v2M68zTgN/jAm9mdeotjjj2MBOMJzSJ8V+3DMo6fRel1NXEDz/CjHx8h2Av
         zWpM9hxTdcPPRfgNZbsC5wQT0cLQpv/Hu/l451ATqVE44LG+T8j1rQjta7AlTYw17kIS
         YbdAeuNZCq9IXbpHVKxOAitgiVhK3GQcv76+ZK062ljwg63TZP88lZJmkJuXvMzZ/tpI
         ApPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361351; x=1793966151;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gynuYOYjBlWXiC/Ji28tlTf9iaepwWTtf+nCYUbuqa4=;
        b=StxEDKMTj+q8TKP9A1MR+uoxe27egMt9aXQfqwxxLYcDCp4yriYq3c72vmVJc9ioGv
         gCgNJvEd8ymDN9HKlX8uund4ljSCa/jdUr7WjLaO/qBU31yE0yorN3LBvnwsldTRLA2s
         nmxfx7FKhVhK0RardW3zaYEv89EMpy5uRcTMSvSipj6FS6fJX5pWCRWLWEdS4bfK9DSY
         FF7M7X5GESdURcjVowSdMeNQzJOeNaErq2eE6/yy4Z35DZErBKiuoNL/Rvs5hm/8qe5S
         N+ILI3RpxymZ3NvqWYjvoibSv7iv2/cwUb3yGkHJeAkmtTWLQgrsm4H6wPcF/SrQt8qN
         Xbyg==
X-Forwarded-Encrypted: i=1; AKwUvBxSBSetG0ZIzMtqIAljv+4H1JD0JZaIYcoo80lxEMcNdhyj+Ckq54UjIBdY0kBtYeTvmeI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJg9DKvcek/kiEUH6jFL5Ukvg4DIu2Ic1ovHv4XTQNo+In43Z0b
	0DDkwAoWySO6KeJTFuc8XF8SlKi5dRcftHTniOjyfK8OnD7nAAqEILi9QeVLyLvFO7T7xpzkS9y
	MW9OpU/Fz6sU03+VwJrjkBzwSCcDw/EkbF/fjdB4Knojy1Bc3CJGlXH1d
X-Gm-Gg: AYBFou1QQVNvzR9b1x9oGND8a5zcHvfeSEZEMRinoMzY1hR0m1mZvoGcUzggsoo0Z5w
	S/krssPVZ78YLffFuR0wk+L0TbbH5TCButR34G51JeYU5b0mhIaBrFI5FysaLVd1wWu99PtxA6U
	/aiyQgt0FalJ/I7g5ataT61BjlMOZgtdFJ4RF2pOElqJbaifGVQL+bgGUPkhg4kY+LvxioyXxlz
	VH8FFPn+3SCYIUlPbPmXzsul0xNgolPssWvHey2XDQGNueHHdVCxJ/h3rSJ9Y/W1cJwMql1uCB4
	v3QtRz+pJIQ3iV4x7qU812L+mFa/grymgOTIHdRyabvAT892Jx4Xk7MGpvBeXBkin8v0E1OIHIV
	6TcWWWnkctUQ1MIE/0lfwmfrYv/8oE1xWRHxdzQ==
X-Received: by 2002:a05:6402:1a58:b0:6b4:880b:1b61 with SMTP id
 4fb4d7f45d1cf-6b4b3cd2861mr140092a12.12.1793361350377; Fri, 30 Oct 2026
 04:55:50 -0700 (PDT)
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
 <CALMp9eRvQ+iQdw_dWPLqZCrO7zpLut+O27pb-EPNa33hkegaBw@mail.gmail.com> <b3dcb403-ec19-4d23-9bab-336e2eb344bd@intel.com>
In-Reply-To: <b3dcb403-ec19-4d23-9bab-336e2eb344bd@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 30 Oct 2026 04:55:38 -0700
X-Gm-Features: AclHuK_puoGdrXd53jsXaOwX1cFb2UMvIc6UqgWONJCoSZMyJit01Nsz-Bi7xBU
Message-ID: <CALMp9eTHRzXXm1gpKR3u1nzJU3i9M1a_wUjp9+bD8_r4eoPQ_Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and
 GLOBAL_INUSE MSRs
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 10:45=E2=80=AFAM Chen, Zide <zide.chen@intel.com> w=
rote:
> On 10/28/2026 4:24 PM, Jim Mattson wrote:
[ ... ]
> > As I pointed out in patch 04/16, we can't pass through the PMU global
> > controls unless their reserved bits match hardware.
>
> Totally agree. Then the handling of bit 55 breaks this rule as well.
>
> if (vmx_pt_mode_is_host_guest())
>         pmu->global_status_rsvd &=3D ~GLOBAL_STATUS_TRACE_TOPAPMI;
>
> Always intercepting GLOBAL_OVF_CTRL and GLOBAL_STATUS_SET can solve this
> problem, but it may impair guest performance, especially for nested.
>
> Instead, I'd propal to have separate reserved masks:
> - pmu->global_status_rsvd: unchanged, strictly tracking virtualized
> guest state and preserving live migration validation.
> - pmu->global_status_{clr,set}_rsvd: unmasking all architecturally valid
> hardware bits for the corresponding MSRs on v4+.
>
> Any bits allowed by hardware but unvirtualized by KVM are
> scrubbed/filtered in intel_mediated_pmu_{put,load}().

That is a terrible proposal. MSR bits that vanish at unpredictable
times?!? No. If an MSR contains bits that aren't virtualized, that MSR
can't be passed through. Full stop.
