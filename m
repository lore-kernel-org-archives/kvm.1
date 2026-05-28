Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A9407598
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992156; cv=pass; b=YFcjKNfOucHhtNfjQfhlQAVJKFNVE8/zNSGSUnM3OLMqBWIpYx0gDMhhxgocIL7M+OcYJ4hH51dm0f0fopbOzDiSmKMlQbvMlzNVERdWxCAFiouZOmobVISz0ixXgf4L2ywLd19QV+/9wuPijFB6mEPMrvNqUVnwK4+UdJf09I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992156; c=relaxed/simple;
	bh=5JQJW42qHMleCXvSU5fTbstaP7/3alPlHerGe6sypRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3+uFLkwlWMlbiR4MX8G+31nAliT8xZCWUS0RvRwwgTOV5LkWHLPoQMtjWvOR+JFEtyIBE146RcunCovQDY7vFw93NOCnApydN3XkrqaSbBVfY+OhAb+0uda5hdYAfxV8Ci18RvP3Sx39enThXxm/oaOaLWiZkBBg5B8DI8AuI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P30+tvO2; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P30+tvO2"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-671f1a0d0c5so284a12.0
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:15:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779992154; cv=none;
        d=google.com; s=arc-20240605;
        b=OlcDguOTolktVVGbCE8+hU8wJmBIZb6F9wx08pG4/Nby4p/39QuQ5kuPtkQjhDjlzs
         8jUFv1jQN3erHXOBwwt9RPo8jTzvpmXrDs9D5LlYqk+q/U+JMfRI7Kfs+3/6DqkdnZhH
         bDCyjNRn5wsjLGMxTuFfmTX59zweK2pd83KQCbVCVdqWKQExe8Ld8XeWJLdzrloFNCCb
         bSwlg+JiQX20lPyoJg4R+YNOQJtic9l24Ar6jMs6tlxha1x399kXmrvIOtHRbgIVX+Jz
         uXHIdBYgzdFSxqIVqKlFZ/kcwIfWTI0ym4UWNjWrnwrbsCAxn3IQARQBa0cYH0J6FMXz
         UrMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6xndtT2YQxXDMNCl45esU4g7iivqG3FpYPEf1rUXYMY=;
        fh=qXRMZ8wUzj/8bYomX8xsGhlKZ4snU9EJlwX5yFyqOIg=;
        b=T0tc6ygPFNBsS3604axkt9+kjRIxufBWI4o0gn+X7DQu8Px5/xWabMqDVFd7uuM3nv
         xvkYt2DdqZhznaGjDQqZaoyxdOa/T/BX4X3OE/xfUW8N3UQvn6c7C2+0qC5iYsn6vf4k
         jJL0WabXOxopC2IpA4gw2Me8gB3nyM2oGjX2aoiwSqguQNZSTw9fEpM+pypPVERryrOr
         Dt4++aDxtSBpuyjpMmMlC3vv87XLUVJCqJJtwP9U5aKkqpPqB/32yQfcEAXg50RaEYnO
         6f3hK6h3rqzo/6OBraGzxrTlw69HDkZa4WC/lvFWg+DGJ7a1Z5VHsdwADTP8mmrSBg6b
         LtIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779992154; x=1780596954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xndtT2YQxXDMNCl45esU4g7iivqG3FpYPEf1rUXYMY=;
        b=P30+tvO2SmsO7yaadQSg1wvyOf7mL9rE2PuBeJKjbdIhI4qNdDhYufGkY6XpjGAG2E
         BDCyBgrldt7XtF45w0Owdgtix0Tl6bSwGg0BWKtU1YH3NS8jskhwd/fTVHvZoqlQSq/l
         iVpieKIFoDVMSk3090r751cwbVNBidg0rb5FGH4qHgciZp0OTEj4UW1QjYeSLpZpVOEV
         xEHlM+FI2MLmytnTtxxdUfy9xZKyKYS0b1S6DE2PrQpj36rIdl30ZSM5cErxQJnWJRb3
         J0LvnYSiY2n7mjUI9fXK314XtL5F0mDvwXTiFuxar9RPoC1+RJn8yjc2ZRfPJ1YqyV+i
         lQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779992154; x=1780596954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6xndtT2YQxXDMNCl45esU4g7iivqG3FpYPEf1rUXYMY=;
        b=alVi9iI4UfkwQHJGrXk9FpOZiB89MKx6pqDtX/XEbEjdpzCy2l7GnQvtywtXeP/LhD
         ddmt30aT2Faa6zi8gj9L+5rK7/tOSdjfMkHpv7bwBfL4RlOtJ4sSj9H+ot7FBsCJaNhj
         FNpvoyoQRUDVqk0D7FTNGI9gKk2XJEbhNUPyZxueDS81KhFtoMRMnf1diIN0/WEKZl3v
         4gMj8IcUr2mQ6rqNZCklhDEucYlyxZE2Q2m491Hqt8KslOEjX5DQkgxJsUc8tMKBEyv9
         zuGbikbu+Ap8TDMM1MS5295MrKoTjZ6n2afnPuMhplLZx0zWCmWCyV7so/jG4RMG8ANB
         gCFQ==
X-Forwarded-Encrypted: i=1; AFNElJ8W7weSkuXFoGocFcTO5BbYMbVp10+NJeOPV5UyZSulMvEUsx1LExZpoqfrqBKx/7qRJCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpHgkZb2zmQuDDSRgblYf6GhLQmuj7p/zG6v6W9cx5HB9v1bpZ
	8I4uQqyj8CSiRcZEjXvlOH92Cx1OxDz87A0VJad5D/hgvnsJ4+i+r0afejlh0SyHbJYXGjFTaUe
	3/4PAdj6aAkuyLnW+26pRdv2354qbwzS5ql56nn67
X-Gm-Gg: Acq92OGECGxva3a0271o3qRBgEo0PI6Hp5L1iry825x0xEl059G1yoNIkP9HVsRo1dh
	3/dbCQPpteTGkuiA+Fg8yDs8OAY8R5njWNwwMP626PoUWl97vQUm6Hr1emC+UBqkH4kpID3mACI
	pbb0Z4Bz7sgJ7CRdvLfYTauOvqSp1X4xDgVyJ2SZsVPzpCl1Ac2cmfYBM/sq80D4pPy+h0H9p7H
	576YXGV9OGeglHTlte6wN2BPynuIm1fjlDj80EGT9FSZA0qeGkmstZYlymRD8nM/86FZlRX5cBF
	QHakyEvTZBn5iRSlDA==
X-Received: by 2002:a05:6402:14d4:b0:68a:83c2:9c75 with SMTP id
 4fb4d7f45d1cf-68bef1b2518mr30a12.0.1779992153438; Thu, 28 May 2026 11:15:53
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527234711.4175166-1-yosry@kernel.org> <20260527234711.4175166-18-yosry@kernel.org>
 <ahenmnACHMNKO3WC@google.com> <CAO9r8zNzFWYBqZ_ACC_rfaYoxARn18UdUUymkYaroXizj_+cog@mail.gmail.com>
 <ahiDsTe5Pge2qNxC@google.com>
In-Reply-To: <ahiDsTe5Pge2qNxC@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 28 May 2026 11:15:40 -0700
X-Gm-Features: AVHnY4JQRHwT-1kJx8zGOg1FrVgMqQGJ618Zs64dRkCJw_EioF3ThXmMPfSxp7Q
Message-ID: <CALMp9eQ72U9XS9hZtVvq_w=oP3hvA+LLk2SQXx9GJcyDRe9J5A@mail.gmail.com>
Subject: Re: [PATCH v7 17/17] KVM: selftests: Add svm_pmu_host_guest_test for
 Host-Only/Guest-Only bits
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 11:04=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Thu, May 28, 2026, Yosry Ahmed wrote:
> > On Wed, May 27, 2026 at 7:25=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Wed, May 27, 2026, Yosry Ahmed wrote:
> > > > +int main(int argc, char *argv[])
> > > > +{
> > > > +     struct kvm_pmu_event_filter *filter;
> > > > +     struct kvm_vcpu *vcpu;
> > > > +     struct kvm_vm *vm;
> > > > +     struct ucall uc;
> > > > +     gva_t svm_gva;
> > > > +
> > > > +     TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
> > > > +     TEST_REQUIRE(kvm_is_pmu_enabled());
> > > > +     TEST_REQUIRE(get_kvm_amd_param_bool("enable_mediated_pmu"));
> > >
> > > This can and should be handled in a helper, using either host_cpu_is_=
intel or
> > > host_cpu_is_amd_compatible to choose while vendor to query.
> > >
> > > > +     TEST_REQUIRE(host_cpu_is_amd && kvm_cpu_family() >=3D 0x17);
> > >
> > > Why the family check?  Actually, why check host_cpu_is_amd at all?
> >
> > I assume you mean that we don't need host_cpu_is_amd because we
> > require X86_FEATURE_SVM above?
>
> Yes.
>
> > Unless H/G emulation doesn't really work for cross-vendor emulation? I
> > honestly don't know.
>
> Not just cross-vendor emulation, KVM and selftests also support Hygon CPU=
s.
>
> > I will defer to Jim for the family check, I took this as-is. My guess
> > is that maybe older families did not support H/G bits or some of the
> > other PMU features used by the test.
>
> If that's true, then the mediated PMU shouldn't be enabled.  If the media=
ted PMU
> _can_ be enabled for CPUs that do _and_ don't support H/G bits, then we n=
eed to
> figure out a way to enumerate H/G support to userspace.  Because telling =
userspace
> to check F/M/S ain't going to fly.

The test counts AMD_ZEN_INSTRUCTIONS_RETIRED, so I tested for
"Zen."This is admittedly pedantic, as I don't think AMD has ever
changed this event code. Blame AMD for not having any architected
events. :)
