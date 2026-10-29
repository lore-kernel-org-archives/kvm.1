Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793316407;
	b=MaI/pRpRRsY6TgJ3D54als5wwoo0Z8Dqlr/tgM85oN1GZOjf2EUQ4s8hU3POj6Crg2Sx
	 /J3Hq7WYxLiLYcrfHoXtrq52JoPL0WMY+EnENgHTMd4s7SmVHOyiJfQxch8YOk5UfJg1W
	 E1J7AbVbWS9/E5zUnDh7PXVwJCFhGQC8R/vkvJPlNEzoa1eZSmVsmBB4Yw4KiLbmRVPHd
	 D+kPf2mOmf0nxEubtqhOPBQugRfHlPsbxp77HmnFu21WCl3hHUu5ua1oQaIkCvQM5qOtx
	 xsrM2GBU/KSHpIzY9tpM6LkwrWg+vtRL2gpKkeXtv3KKSV7EXhYWZNotW0hHdnG5d3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yYH3RocyPgWezXrGK54xrpA6RaOriIdgQYE/bOmcp54=;
	b=sGpSlP91r8q8f2Qk7gFRmM4z4z3hfOQvZpfDDWoCJnZygijhHCk64HVzGzvMqGWk/uv0
	 OION2TveXHNDulFjF8AqIygMjFzMyRsVWRcGWOyQHT578kuXBlqEkViiyr46BMGBNbwPK
	 HFUWuKGZIXgjHYRz3cndHhcH/874XOCL8JKZGtPkdkEHM+fsBiQ9fQSReJSsYz80cvjR7
	 dCeH+FbwY1KQtDYpYuzWIQW+fPs8+UHEw4VcKdvaKfMS/iKO8PtU2ZVHsckaJ1SInAXF/
	 FvhL5kLoMJ/dT9d56tfexQON1e3WvHce8K9fbBhUtYJDnsoBMrj361RQNpIYFURJdBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GoH8Oosm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF89606A31D
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 23:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FF89606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GoH8Oosm
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so5063a12.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 16:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793316405; cv=none;
        d=google.com; s=arc-20260327;
        b=NK4wcMT6+vbkrJVot5WKlBl2trIXWQrM5ZQgkHxJSG/lNnl+00s0pAUewlqWgSanBM
         eypRzyoxtdDKw76Of470giN8mAC2gDRCL2TU8z2XST3zL7xoLdKaCqMbVKzHlqA1vDjR
         NnSu1sKaSpjBsWE18S35FWHwvn/bigPNY+xh0jaFgqZVqyrsnUCISHQO6CanalivjshK
         2MvcaFslHT+FAyTt1DUyefkGsgkGHrXbpzHkpKsxG6tvUKmEInQquAewASqPHRfX/Vot
         hqpxhwizcPoeLc+8/Z9Baprl6tv3P55tgz5QdK9k+fJZ9EqpoMBoZ56YngMdw/u4b7ZI
         SD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yYH3RocyPgWezXrGK54xrpA6RaOriIdgQYE/bOmcp54=;
        fh=EJRt3aZpBt6+D6ZfKNB2hDfJfCc9XaAYeFPsw//x2+Q=;
        b=EMsjMET8vKIzBCmwiU5b+Tx1PHPyGNvU70EenBZ/Jd8RCBx211/GySYi3AU8zz6b3a
         lewX5XFWRBNMwq0pEN0hHCHVMxdteJRlBNmqYyKPfVFLTteT/YWpS66OdganbAIMzLET
         VRz4sZOOJOm4obzcNYfrUN9DNW+696AIWMOTJHMIUqDEeaKlr2Q39sqGq/OOmKhmmy4+
         ym/UjhR4n/44ppyafJlJ5TXHvlQ/31T0yZ4MnBMscmo1zWa7kZzxx+GaIWLpcdk7ni8y
         +VRRhkwTetH8u9OyRHHntesoAPKHl185S+Tz0X940RgB9kAUaeyEZlps/Gw885AWfQli
         C+Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793316405; x=1793921205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yYH3RocyPgWezXrGK54xrpA6RaOriIdgQYE/bOmcp54=;
        b=GoH8Oosmkz9B07pQnR6cX7nTZI8hDA1ULa7uTLwGKAPHj24WbOPMX7wEBnG+APx/0k
         tr+IBvgc3LqD4kWQscyU1PjXkSMGsqTkxf1c6qwvGG7nLJVCh9BwoELCdQVjJ9422ffO
         MlnqXCeD/5JWLe+7znpgRMuNppJF2PATQmI05v3GeXuYp8OJE5OdJQTOShf7r3qrJgWI
         Eg5/8u4Lz3CU5G7YWgZTLiMOfvvm3A6N/CdZtDuum9whwY2g5RzEMXwtm4yt8U8M997v
         MWzGWeTU5t3XpX37E+NrgbmNLL0qZa070TeBQFyLhTdIa2J0QdbsW7QWM5lQTh2zv3ga
         0rZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793316405; x=1793921205;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yYH3RocyPgWezXrGK54xrpA6RaOriIdgQYE/bOmcp54=;
        b=RNWP3G5a+HqEqx0mi/+xwLxIsHnVtw+qxLhFfxlAHi79YB+f6ZL6va+M/wQrnZoTJx
         zqDEJ40vI5eIu8iQY+x008wytHY46tHAjyoKGNOjp5/9mAV+VTnnP7G52+LRfDVe7FS5
         qoXfnldWNOt1lPImiVxWHxEqFSenSZBbCvOnzfjQzTPeoOik/Y6cZ9YI+x6ehdbKg+a4
         GcVhoyQudKKnSi4hLDhPCw2DjN4ug2o514ZQSiWtyJXRoZGYvnApLLjHvfGRKkQXugPa
         aZViNbderQUwd6btgKWHD5UO6pWAh5ibdZK1XI+bEu+I3k25Jc+lm2a3OI5fWld+pnzx
         7ZOg==
X-Forwarded-Encrypted: i=1; AKwUvBxhdHNRco2PhvDMkBzml17KFiaSeDP9iQA1YZ4EXp/vAlC2At8xg1Igv0Ogi9kJ5dZb7wg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWcgRUmpUCNzEX2tGGWbsa18JxeOUkajzRRg5bkp23FFDwbowe
	JzeX+2PabsTt4yTIvyR3PFJUZk8sM6p3kp2bKyblliwDBJ+flY3i8wsU0sPB8suIrRJPKJi7qkk
	4VulL4Zai/9BayMAbCnNuVA4dwYVC/kx9lWOd1cVV
X-Gm-Gg: AYBFou2ILd+hYVWAppolR860ABGNaeBhUTQinZD8LnPoWvDVNxdVInCHcr91mBXouMJ
	OplSCr0fEVEpidWwk/h7c2+jRjTPpcIY8S3DiLgNzMlY2HMDLI3ggIkx6k3VuLq2VVxPcP0Q2TL
	0BOaaHhdOoLHww78DmEYeLO0Jp67TvfdYJBg7uaQ2UOGHwPhgtDuUh+/NnRYx4W/mJvg+d7Dxvy
	t3WpseJMWXid6F29nseJFtbfHAvFWKc3RVW1jJ3qU64LZlUjkuUu+PHKwhcOu1Msn+TAgld49bx
	1zHipQq/5y8Ml1pt4w2jnrMbEvS1Z2jnlFDXJXxUGvl600OV8daPqAETcW/BxuXbm44hbIwmfnF
	9b2lZu/w5zziTkAEn5wKQP9eGWdcNXRI5ZnLs
X-Received: by 2002:a05:6402:4246:10b0:6b4:2188:97d0 with SMTP id
 4fb4d7f45d1cf-6b4b1106ef0mr117279a12.6.1793316404675; Thu, 29 Oct 2026
 16:26:44 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260918193937.569414-1-zide.chen@intel.com> <20260918193937.569414-6-zide.chen@intel.com>
 <CAO9r8zOY8W6s5U8O_tZ3dERA4h+mnWWjeS2GDgF=gbo+CQDNLg@mail.gmail.com>
 <e5e719ec-7012-413c-a446-86fd35aca33d@intel.com> <CAO9r8zOLCBhWZ5P1BEU24p8++3jVLTPSOdNreBk3RUC10Z79TQ@mail.gmail.com>
In-Reply-To: <CAO9r8zOLCBhWZ5P1BEU24p8++3jVLTPSOdNreBk3RUC10Z79TQ@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 29 Oct 2026 16:26:30 -0700
X-Gm-Features: AclHuK_4QMg9zYzI7j3e-Iti3pLTo86KYlWly6SV-6Z_xIbdZQsthDMnW1g0dY4
Message-ID: <CALMp9eTOvhiLw7L--DQp_0QaFS=O1TaCQ3q0jPh=70273DA+=w@mail.gmail.com>
Subject: Re: [PATCH v9 05/12] KVM: x86/pmu: Support PERF_METRICS MSR in
 mediated vPMU
To: Yosry Ahmed <yosry@kernel.org>
Cc: "Chen, Zide" <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 4:19=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Thu, Oct 29, 2026 at 4:17=E2=80=AFPM Chen, Zide <zide.chen@intel.com> =
wrote:
> >
> >
> >
> > On 10/29/2026 5:06 PM, Yosry Ahmed wrote:
> > >> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> > >> index 448044a2b121..f4d3801b97bc 100644
> > >> --- a/arch/x86/kvm/pmu.c
> > >> +++ b/arch/x86/kvm/pmu.c
> > >> @@ -806,9 +806,16 @@ static bool kvm_need_any_pmc_intercept(struct k=
vm_vcpu *vcpu)
> > >>                pmu->nr_arch_fixed_counters !=3D kvm_host_pmu.num_cou=
nters_fixed;
> > >>  }
> > >>
> > >> +static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu)
> > >
> > > The name is confusing, this doesn't control the intercept of
> > > PERF_METRICS (and it wouldn't be correct to use it for that AFAICT).
> >
> > Right, these two APIs do not directly determine whether the mentioned
> > resources need interception:
> >
> > kvm_need_any_pmc_intercept()
> > kvm_need_perf_metrics_intercept()
>
> Jim suggested folding kvm_need_perf_metrics_intercept() into
> kvm_need_any_pmc_intercept(). The name of kvm_need_any_pmc_intercept()
> might be confusing as well, but at least it's one less interface to
> worry about?
>
> >
> > This is different from kvm_need_perf_global_ctrl_intercept() and
> > kvm_need_rdpmc_intercept().
> >
> > How about change them to something like these?
> >
> > kvm_pmu_has_unexposed_pmcs()
> > kvm_pmu_has_unexposed_perf_metrics()
> >
> > Or merge them into one single API? kvm_pmu_has_unexposed_resources()
>
> I don't like this name any better, but I don't have better
> suggestions. Since we already have kvm_need_any_pmc_intercept(), let's
> just use it for now?

How about kvm_pmu_incomplete_passthrough()?
