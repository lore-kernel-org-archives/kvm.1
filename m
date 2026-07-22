Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFBD233704
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784679057; cv=pass; b=QeXslzQCR5jHk3gBM+9yvf1Zy4A0fsChTAstBbqITWHGiLsAQ7f9aZHDzPWLx7n9p5iViTXsFrzLaZznUNBbWJiSL2tgcyc0+wLEHOxVDns8S+JXFPpMTkrFy2Q6p/c3RBMkdyy71fENAQjAqxHFMAWS5H4SE9AqvaCJ2FhSagg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784679057; c=relaxed/simple;
	bh=4L9xDls0N49Nt36slBKsrAdIWjUYYuvqIwnq8Vxi99M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHsFUsXo4EmJvTa1ok1jLBBhOpQopAyY4uHgQFwnfLy+aine/EOVW2eibRMo5/m0rNCAAh0h+l3NrmurgNwfv5gSHXboKLBPhwTSKa48bSS7IzZFWLhWawDeggWH4jU7pkuhhTIQvnwQbI27XNNCGyXCoGW5s5UhydrkUEQZ6hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M1UIVgsq; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M1UIVgsq"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso13524a12.1
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 17:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784679053; cv=none;
        d=google.com; s=arc-20260327;
        b=r73nLzYLR2ra90p5bxBfFKEgz49z8yp8zExvdgQq9hSTxHIHJmQeAs1e/cUCu1Jocf
         7rH50thhW11pzsU8125NoHwtOpOMw4fsuxP+AqTVQwehJmnJFXcNRYmHDjff0tv1gSVg
         qYLFDp4R6daxqiaEhTpx2k+7GCgXMN9mx1ZB69RSMWr/PHTcTEZYnyQ36dNLouhHZcW5
         NY4aPXbWE1ssnag66NT/l8UEUPz+9AF0VRxlmKfEEnH/XthqywJdbPVXGUmRSBitIucy
         VG+P162jvER9nKscDHskyH1S9c79akuiIL5uEoiR1Nis8zh+wqDqSpXS8dJ6gOEhmpWF
         m4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IGjwl2vvPVoFGeq1ISztqF77IOKjCvKq1HjXvy8DQTk=;
        fh=XHpDkK5Gosth1PWLcCgKONZrbRdBXOdiClY7gsXH5VM=;
        b=QLz6UF6Kkf9wBGbUASyiC9bxPOnMu218pRe8B1YOaTuov3RlM/nKo2b2TIZToS+jBw
         j9cpYDo9JRsvZ1B3VC0e9pB+ebk0wO3ofucynUAiMVWQsphtiNTIFUY8n0otXajGCawo
         VwE35jRJGzb0C3Dy36q06/mBZjGH8/YZdka6T4VxdzzZY2VcbL00FExFHUlMlow6+GGG
         5cc+cmTtRGluORNUO9cXHvoYgSCgHbbH00FLqpzI8CPiGau4w54T5CSyWSWPXG2aQZ91
         uR2IXyTCZGuy2h5nIYYsOB9yDcrwxmsxmpOxNoiXf1zYGT8C1NHed/jkXPAXSOKk+esJ
         Pr6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784679053; x=1785283853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IGjwl2vvPVoFGeq1ISztqF77IOKjCvKq1HjXvy8DQTk=;
        b=M1UIVgsqn9HhDTgo0fYzI+vAln1sZTXRPoH56EYyiYhH3LFlY1XbZUIk1lcO1yy9c6
         UC6YZ8OH9oka7Mq4tHcKGK2+Q8xKI05KvBPCBWCaPYWtQYiBLmR8qacHedXF5JbFhZXH
         mFrelQdTn2cm6tAzcy+0L9swIH5kRJP5Im3LtuCAvmXsyvo2X++foY/HZU8eeUeLypvz
         kpISCSg2wivOBtcDmHFeLSOrA1ZSGdEMh6w8T3ItQClqe8Bgu2hZhLIjE2GKtvoTxFZm
         w5QIEwLNWJ+kQ3IDUiYod4KHnhLKPwGaTyiw0ep/aW8jMsej/pZniWf8oR3XxYFx4VRn
         bK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784679053; x=1785283853;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IGjwl2vvPVoFGeq1ISztqF77IOKjCvKq1HjXvy8DQTk=;
        b=B8WQVYiT5pN9roT+vAlFLcF4HcPbw+0o3ORuz/DSZtQMhov/2VYrc3Ksm2gEu1d3yI
         iB5k4M9bVMDw8HYAEdSs6Xd49bRQUaPi5d2X7v8iSNoAEZQcHYMzxGHg86idyuTMDrpN
         cmVbxF7zB0aXXNqK2xfE5K5LH2JTVkf7qx8Oq3hK5sigxC/khUQHsBg/TtSNlcWBSocK
         VC/4AhAGqADXJ4wMDUlnhedl1R0E0mK+MUZmqq/IdKamkYSxf9O+YIfgZ38JjB5xzAd3
         n8iTEKwFcOXL0xLRuh4MIrkntjHbEyBztpNuWnGYt6vWTKyM3GxDNIvjHoodrELMHXz9
         5n4Q==
X-Forwarded-Encrypted: i=1; AHgh+Roj2HFYnEIyz5tpkG7VqUEZGZvjpjnpbEtlj3N7r8f3jNkl+881GIDYa/UsYtAm5m5EOwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeH1zkIilGo/db/l5FqPwgXIV71OhUASXEokARD8jmqDFBuaNi
	m/DgRBxPeEHejj/EGSkUAduxHL/EatpG9hob9huF2l7Tezm9O6IRrISaAOQaTJTZUJ8aaiMPYc3
	aFSVwP7WfFSg7qLY2XEQpjKEZ1/ONJGyZqe6XIzfkE9z/J+iWACmPtpQ0mfE=
X-Gm-Gg: AR+sD10Bxvq6hOI2T0lwdanI/VAZpf8MbXWfDg31YRGa0VqWETKqQnYpDxXblgoT0mw
	faFTBV944WVy1raxXIrh8VoiYWQI/FNKHubvzKGFcSKwj3RdrpAOYSE5oiW+m+DLX1ZsCySTmW7
	xASF3/MS0Sb8cwgAYGwS67ov5Hm3yI1bS0rAmEWlh90j7rirDzdakeSRPy+QjvPnGcCEiYOVwUn
	OCCVGwPT9VHg3FaFBOZoehecUglG3qi5HJRhswnT84Pr1mCK9j+WNItZEjYwA==
X-Received: by 2002:a05:6402:888:b0:68a:e1ba:9cc0 with SMTP id
 4fb4d7f45d1cf-69f35fcfd90mr23494a12.8.1784679053005; Tue, 21 Jul 2026
 17:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720231639.1592848-1-jmattson@google.com> <al9cWDWvIK6RCrnN@intel.com>
In-Reply-To: <al9cWDWvIK6RCrnN@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 21 Jul 2026 17:10:40 -0700
X-Gm-Features: AUfX_mwPSWJfCk_1jhbt5K2CQSQOOc6GawpDEowApq0OAePBpvfrAf1WpWyAp7E
Message-ID: <CALMp9eQN_UDhd7RVP8v4wBTaEbq0GXmbAiay+uXgzSEV7T1uQw@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: VMX: Cap VMX preemption timer to work around
 Intel errata
To: Chao Gao <chao.gao@intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 4:47=E2=80=AFAM Chao Gao <chao.gao@intel.com> wrote=
:
>
> On Mon, Jul 20, 2026 at 04:16:39PM -0700, Jim Mattson wrote:
> >Due to a widespread Intel erratum (e.g. EMR158), programming the
> >VMX-preemption timer with certain large values may cause the timer to
> >expire earlier than expected.  The recommended workaround is to cap the
> >VMX-preemption timer value to strictly less than 2^25 * CPUID.15H:EBX[31=
:0]
> >/ CPUID.15H:EAX[31:0].
> >
> >Calculate preemption_timer_limit during hardware setup based on CPUID 15=
H
> >when available, and return -ERANGE in vmx_set_hv_timer() if the shifted
> >delta_tsc reaches or exceeds preemption_timer_limit.
> >
> >Reported-by: Sean Christopherson <seanjc@google.com>
> >Closes: https://lore.kernel.org/all/Zn9X0yFxZi_Mrlnt@google.com/
> >Suggested-by: Chao Gao <chao.gao@intel.com>
> >Assisted-by: Gemini:Gemini-Next
> >Signed-off-by: Jim Mattson <jmattson@google.com>
> >---
> >v2:
> > - Use div_u64() instead of 64-bit division '/' operator to fix link-tim=
e
> >   error (__udivdi3) on 32-bit x86 builds. [Sashiko]
> >
> >v1: https://lore.kernel.org/all/20260720205230.1457146-1-jmattson@google=
.com/
> >
> > arch/x86/kvm/vmx/vmx.c | 29 ++++++++++++++++++++++++++---
> > 1 file changed, 26 insertions(+), 3 deletions(-)
> >
> >diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> >index cc75feec05da..e43ed863d5f9 100644
> >--- a/arch/x86/kvm/vmx/vmx.c
> >+++ b/arch/x86/kvm/vmx/vmx.c
> >@@ -151,6 +151,7 @@ module_param(dump_invalid_vmcs, bool, 0644);
> > /* Guest_tsc -> host_tsc conversion requires 64-bit division.  */
> > static int __read_mostly cpu_preemption_timer_multi;
> > static bool __read_mostly enable_preemption_timer =3D 1;
> >+static u64 __read_mostly preemption_timer_limit =3D 1ULL << 32;
>
> This is set once at init, so __ro_after_init may be better and no need
> to initialize it at declaration.
>
> The rest looks good,
>
> Reviewed-by: Chao Gao <chao.gao@intel.com>
>
>
> btw, KVM is using 0xffffffff as preemption timer's max value in a few
> places (the use_timer_freq sanity check in vmx_hardware_setup() and the
> soft-disable path in vmx_update_hv_timer()). I am not sure if those shoul=
d
> use preemption_timer_limit - 1.

Thanks! I'll address both points in V3.

Do we want to keep the hv_timer 64-bit only? AFAICT, this was only
done out of convenience.
See https://lore.kernel.org/kvm/1465000951-13343-3-git-send-email-yunhong.j=
iang@linux.intel.com/.

I think something like this should work for 32- and 64- bit kernels (untest=
ed):

 /* (a << shift) / divisor, return 1 if overflow otherwise 0 */
 static inline int u64_shl_div_u64(u64 a, unsigned int shift,
                                  u64 divisor, u64 *result)
 {
-       u64 low =3D a << shift, high =3D a >> (64 - shift);
+       u64 high =3D shift ? (a >> (64 - shift)) : 0;

-       /* To avoid the overflow on divq */
-       if (high >=3D divisor)
+       if (high >=3D divisor || !divisor)
                return 1;

-       /* Low hold the result, high hold rem which is discarded */
-       asm("divq %2\n\t" : "=3Da" (low), "=3Dd" (high) :
-           "rm" (divisor), "0" (low), "1" (high));
-       *result =3D low;
-
+       *result =3D mul_u64_u64_div_u64(a, 1ULL << shift, divisor);
        return 0;
 }

But I don't want to open up a can of worms.

Sean? Thoughts?
