Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF92244684
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 22:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776205786; cv=pass; b=OCoTXkmsW2aQvtRDP/VJoByD0UJksRCDa2YHvtSEVWXoD83mdhvJ5pxTzAx6TWLB2wigcDUNVJG1kmAVAkoCsgxd4cb5YIvz/5nBWCoYaAwtwuzYSlWPEF3wPqTmaflJ8i4OhDrlhjVgBR3JwtEzGeGFz2vZURBYDBRAI7NxCG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776205786; c=relaxed/simple;
	bh=fBbjf16osq2lmBsm3qe27/2B7qTE2ZnTyCx45QXf1GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZ0WBzGkRuFIQIiJsA5xSs+i5GvSJ9qXAmJ1n5xUggjrRmbnRz9tCaYgJ/6l2jMskoodeiqTrO8Mn+kXV5w/cqTYmVhlDKU0R97lvio3e0gUpqxn1q7nPmaqUgfEotVceR0rEjEvq/ndiCRfV5DRRVnJqt7tQae+UQUIF9p6n2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YqgvuZjB; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YqgvuZjB"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67148a70f8aso28934a12.1
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 15:29:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776205782; cv=none;
        d=google.com; s=arc-20240605;
        b=glLNR5HR3VaHfkJnt80RONR15T4pT5dytb92Akg8xsmKpGrldl/PiJ0j1H4ViHEI7M
         xCWgVFDpO5txQvIC9hXBA854g1CEvS7s1WAmT1LBuDqBcH62FkLMmIqgc3k52ahnU2KM
         YV5kPp2Ui0jMRZaUuxiLvcBqB/tYkD+tnNm3f3blP12KP3xh+rxTri+U0vYZOK0pR3LN
         4yAq+gQd0MbIG9M/hzMRB61q4MC1fuXAzbL71/QqRPCMcRVsZ6RLnwjMVroTXoQDhlCp
         E2pCQcFcbFurXdXv/i1cL3oon2oLgqWvPpvp4nxz6HVkcViu1y8oTIoBtbHSpFHcxJxA
         x8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1stwh6IzFVN5ADaOr/0ZpBdvHW9a8MLzS14mBjhnkQw=;
        fh=DY5c+Q4V73LKqa+t6yX66iElfhtyj064uTlHSVs8j+M=;
        b=Cul3VL3evMuDf3jF/3/inWw1rzqXaSTcQqbgvSMaJotFqef7rV46Z3jzgMb3q8XDB/
         DHgA7OcNtECU1C9AOIZ7ncRTk/jdh8+9Ge+i01RzMCVEIXYAfjfj5TrN1Gfr4wBalEV9
         wSKGAIChk2XhseY9s+MCQwh4b4wVacX0uwI2j5ruTSqcGpDG6svRC7TVU5nOcryaYt1i
         wXOm3ZEFSMFyLgEmph4p0pPxHdGg6bFJHtdgAUp1MU/mn671Jc/K4Vc0hTkrmiqxYh+C
         cfeki4DODmh5t9umt5G4ObukArMexouBeysiybr/wPR6/AJQLilUhrH5oVsUQgMQnHnl
         7Ivg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776205782; x=1776810582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1stwh6IzFVN5ADaOr/0ZpBdvHW9a8MLzS14mBjhnkQw=;
        b=YqgvuZjB/qVnsTU9DkIQHn6ZV2NlU+KNKbxGmJqPgQj80bj4ypVt2eJnrKhNHc8ecE
         YafRVzfJKWPkXztsKZQDIHh6I8LaLqijjJZbU+fzODuAdMhEeeVDiuuRjzbuoBhJXucZ
         k0zX/vHC9p65fZIWsJufdZKE9qR17gA61pTNoQlydOR56UYogERy6cP0MibGbUvuYqeG
         mZdJWvxB5Wnf7NZ+TbonGf5j9fFGK0Bhf2jDZlVRaiaxvCj1c08Zpo/B+D7QiaHS4X0a
         JpF7rDthUOu+/LmLDblznc5pyP6uyRR9FBHE0HoH2NOAiUdWwSfpCV8jyrVmKCyMLAPx
         +EPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776205782; x=1776810582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1stwh6IzFVN5ADaOr/0ZpBdvHW9a8MLzS14mBjhnkQw=;
        b=Zas1yft+yQYh/rGAZOLyJ8Fs09eBtMO9wF8Cu1Qs2jV9Ju0hbFOpYLJQQ3/ClojG+u
         14rHCVBiRNqI61Ub1ZKN139FZCW4a6tr2lHYMhCbdLmCD7LH6Wiyds3K3MbPb1NCzhGh
         Ckx2vpKGbt9jdAxZDBJBK6+8kNYgA25mmUHIvpVRZN5T1rLsVbboXJ5DV/s9W/96dgxf
         1TlilNmw39jc+e7DjPf2hcF8gpkzqJJNKcfmo2E1OYEOqxIGiEZOxh83Z7aYR4plzSLr
         8KoF72+aFg7p8FRW86XZqpExlrF/oHhw4r/9p2bmho8qlPEDRV0qZtxLs+ERILIkjnyp
         K6cw==
X-Forwarded-Encrypted: i=1; AFNElJ8e63va1BusVluR9WmvYjWK80kIQLAU70VE63vXeQkbrJgOeNwtKqx1CnL84b91XrgXHS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY6JH4PbJc1CzmndZFmEQFUHMHcSUXOGVaOL4ch7S3luzPWphj
	0FJOmksgW6eeyjOt50UGovqUmT1ikvHmp5IinQQIXb119bxxHgRY7CXtm456IBOg2TvgnJBSpfa
	yBE72p5hCefhMtTDOvYkr10/0DkW541zPLa5V4pv8
X-Gm-Gg: AeBDieu1HkkziFN/hIJxkWZx9Qs02QdVjsXTw9RWKgPdKPxTQ/CYOQVCumiBFakkp6p
	FqV91IPfgrPA0RdHeAw7EMO/yUkwUwrqJhFLVk3E2w6GWCPOio91IAtVbuNAKts5t1IH3VAtoPc
	Kp9mde6nFxvSOzdII15L/uA5eEeJZU3iB5HeCd4jSm3UiBqx/EUXHDkbM0mk64MBss/lKSz0hKD
	Epf1EUPzE8JzHqrukzXWNdnsibrGZq0qX4CBLcMIvbj4XjPum5AxW4UQ/L5G24/qHIKOXGgHiBm
	5+nFtPhJYzLjuTFb+YM0JqigzeMg
X-Received: by 2002:a50:fa90:0:b0:670:3723:70ad with SMTP id
 4fb4d7f45d1cf-672315817b3mr5119a12.3.1776205781431; Tue, 14 Apr 2026 15:29:41
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414191425.2697918-1-seanjc@google.com> <20260414191425.2697918-4-seanjc@google.com>
In-Reply-To: <20260414191425.2697918-4-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 14 Apr 2026 15:29:29 -0700
X-Gm-Features: AQROBzDk78p-yC_-TyPp-cyL-cS1J8qrJKkTJuwtTmxDA43bY6KLY86NJfmlLZI
Message-ID: <CALMp9eTFi+9HrxfjiqLGw5BbdJiZsO4DxzhxN5-tCSbZAPY5aw@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf/x86/intel: Make @data a mandatory param for intel_guest_get_msrs()
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

On Tue, Apr 14, 2026 at 12:14=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> Drop "support" for passing a NULL @data/@kvm_pmu param when getting guest
> MSRs.  KVM, the only in-tree user, unconditionally passes a non-NULL
> pointer, and carrying code that suggests @data may be NULL is confusing,
> e.g. incorrectly implies that there are scenarios where KVM doesn't pass
> a PMU context.
>
> Fixes: 8183a538cd95 ("KVM: x86/pmu: Add IA32_DS_AREA MSR emulation to sup=
port guest DS")
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Mingwei Zhang <mizhang@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Jim Mattson <jmattson@google.com>
