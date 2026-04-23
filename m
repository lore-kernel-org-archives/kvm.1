Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0E9347FD7
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 18:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968057; cv=pass; b=X4oXi2KvO7WKnQ82aQtgCNjnAI76OUo0loZHfVsTXAXbUIIOL0o4l9/6392aCa4jM1OOTya6BhUmDnhwvw9G5LeXO/Ra9TRO7KHgBHXeVnWyl2EVRxKPr+8drVpcFPanIHFksQsiqrcBttv3Eh7p32PYwMpZu3ZIbl/ZNrBOsTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968057; c=relaxed/simple;
	bh=3X0XEQ7mUewMdktVqynHYf8leq1tI6zJiV17AX+r9CY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNM5K4PtjtuU1gHihqqowtLy8/JVFhSBMi18OwvIREoPHChM5gPzeYZNeelIZN73YkHmVKgyYKNg8kGLQ5HjZZXopr7HZtfrA9fK0G43A+r0XSeAX7ZuQiGv98Ky6N8/I7N93BZo9cdCA4EYmxYLHTAWIRmJJhpFS2nSZbEVQHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jbuBaOLu; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jbuBaOLu"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67148a70f8aso56919a12.1
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 11:14:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776968054; cv=none;
        d=google.com; s=arc-20240605;
        b=AHzRXyGAY/xnpsGhnC56SfpyK7Chu42ZMQYT7NazYibJBxW+pY1dHyqPsv2bYpqEjc
         FUrU8WnKfBzYZbvHniLuhBVQ9MxqytgAPcnbE0WJk7VKimrvLDFK41CmP+MHiA8q2vRG
         38X6DKtexQe0Cs1FYxMwHibwVa42rS7x8OIJ9CH1BZTcNc1sG7cWSi/mvylbYAlbCwOS
         JrEKN6RqZ84gEBgUamHYrc+CTJWj9P4fpQ3eWu88Q01Ev/RBUJsxp7o1gNw4ePIDxirg
         hfOTgRy9pk5whfcoCRuc5k6I5oMjuDpsVd2dLNt/+ttbPqhBwRBqY2YMTA5pH+lxEt1O
         05eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K4QPY9s3GqKXMk5HSC8jCFB/X41J7ptf4y91qIA/h/U=;
        fh=uS06rJCUKMhhDBAZHqN5kKJQQpaMGbLPx1TZJ63XRe4=;
        b=b9mhQLh+aSsZu4CoHt4iOTDyk39/MSxHArb72ax5ZNAj5CK/wGDwKXhVll+qkQ4KVQ
         qQg1P1jSE6TZ9hdgtdGd37q+dRcQM4sQzqxZAqQOiHRr8OZ4oqVvs/Zdetd1gdXGbqMu
         X3m5b3yogQnKEct3E9Ph7iVZJ8FYLpQah3p2fE5RlCgmp1L/fh4OqBXpjLxU7rGASQk/
         GBf+J5JybTY8Fvdn8KBC3IZO/mWUUqsFzhVXIrQCrEoIpNA6+4WPzW6rmr+5CjF/Yxf8
         mZSvL1duz3N2felAuqdNC+mvctrMsg45FSj6qkGWpmssXj3xbeGWqQSdDagudPFGl9+/
         RMPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776968054; x=1777572854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4QPY9s3GqKXMk5HSC8jCFB/X41J7ptf4y91qIA/h/U=;
        b=jbuBaOLuRFbY4hV2GM54HNoLpwfm1m4mjMMwrJRig/CoyXFg6IEayF+LDESMNawKpW
         E3JdIWpxkoCkLc8DyOiHr+fjHbghzpY1xWbp5OK5IEKri4krZQTxlp18C1GykIqPxzV5
         nEFfYeJK5bvZBXF+Bi2V7uyO4dyXIPn80W0KOMxhMB2xMnRgdfBnJf5hRZmwt1sztolC
         5bfMdqJ3tWp9VDW4RJFUOguZchn0dLlOVoAvxhduV1k3EVZ8t23as0tEOalXardC+nG2
         iCAktBVftDLpcuOx44WuRh1vjzLpROXZ/FO/YxFG6SxXLkyQuGT4hlE5VK9nAXqHEqwg
         Yz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776968054; x=1777572854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K4QPY9s3GqKXMk5HSC8jCFB/X41J7ptf4y91qIA/h/U=;
        b=AI0wmKshCE2NAgybv2NK1tCfBBimT/iym50sPCOj2I6UoN48T/p9d0+y4y2fC8o3oh
         HYrWwJpPVyAvHkS6isB7Y2UyhYOqMJvsV0v+cC1+cFaWgbTPTnny6QqANjwTc5QRRQOI
         9z1p/32o4A9HRtn4Kgl+HoSunVUn/GNM3vY/edxT3T8wmAEdSP1cIZenkuQLfi3Hr7kH
         GmjMm4FhlEgjWQskBt5WzwuwJkJ1wRsqCddMvca0bBELN/uMq3dO+q0Rga4NN557Synd
         MdJCmg6rXc/SMFimgXz5RTiGhP160n3fuC6nFxPqdBOV0e2lIHFfunhZiGGrszhnHFbt
         PWYA==
X-Forwarded-Encrypted: i=1; AFNElJ/vC3RmB6ErXBBhRv5zgcGdFXrR1duiof/hZnTWeQqVVsjciwsyqIINGPC8SPtzoEROTo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIWGNN3JWMhU4ELLjI3aLuF0YWaZZEgKNztr+9kussCcKBSOsp
	AzRyOFnPmT02DwAysIFzQ4DJ01TXSiOWJsJvdXryFSgvPp482mdrY/h6/NMRtW/lsxE1XmCQu4L
	bWbtXmjbNTfxjRxdCtgJuGfIcY8zbtUFVBvXLzJnh
X-Gm-Gg: AeBDieuaBh4ikk/nIjtPaeNwU5Rv+WppF19wiZTtezxMa4Rys0jqVMun9Op5vBxXJw3
	TAJJY4XBbzc2FIY7TL3tRcafKID0hSRmcm37OScylkkzQlc5qQ8ppng01iSal5S3Ql7r8IKn6rM
	Cq+F1/kwZ+q5yIxcijrKfhI2P8Q1mvk5mB3TB4f7uflED3rAsnPwg8XKisXEA7vsCtn04ytRad8
	brODrRKpvqIu0gOMKaJQm8v12ApZ5OZoAH+A+seX33pfSL05c9OrpMii6KmjHOD0GWI7WrJDrzW
	6OZleMpXxxtlbB1jh5Stgf7jfbNU
X-Received: by 2002:a05:6402:951:b0:670:9e9f:1a5e with SMTP id
 4fb4d7f45d1cf-674404f0026mr269246a12.2.1776968053761; Thu, 23 Apr 2026
 11:14:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423150340.463896-1-seanjc@google.com> <20260423150340.463896-5-seanjc@google.com>
In-Reply-To: <20260423150340.463896-5-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 23 Apr 2026 11:14:01 -0700
X-Gm-Features: AQROBzA-HWufnC0-Ev6XrddaWAfr8RjJyxYq0ElI4imQXSGVPU0VALJTnOxzTWM
Message-ID: <CALMp9eTYhE7Co7LHb-251NhSHdyK4vzC4mrPu2_bRbDbrDcwew@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf/x86: KVM: Have perf define a dedicated struct
 for getting guest PEBS data
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 8:03=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Have perf define a struct for getting guest PEBS data from KVM instead of
> poking into the kvm_pmu structure.  Passing in an entire "struct kvm_pmu"
> _as an opaque pointer_ to get at four fields is silly, especially since
> one of the fields exists purely to convey information to perf, i.e. isn't
> used by KVM.
>
> Perf should also own its APIs, i.e. define what fields/data it needs, not
> rely on KVM to throw fields into data structures that effectively hold
> KVM-internal state.
>
> Opportunistically rephrase the comment about cross-mapped counters to
> explain *why* PEBS needs to be disabled.
>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Jim Mattson <jmattson@google.com>
