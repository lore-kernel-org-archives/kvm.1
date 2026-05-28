Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A83FD957
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991301; cv=none; b=CYxOkeidF7xBSHDzPR4oz8K/wZe4SKrL/cVG9qU4FeQMKn9mvjhOKHJGC6mGJyY9Xm74PT60FfNPELzOFpxe6jpwhLdJDH0zPZHXiyq+PGihBM3+GPuQLMA3QiuLFwAGixSJs8hTlJDx0MUfe4aAi/yXDY3DfK1gPDLYX0+7pEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991301; c=relaxed/simple;
	bh=7PeyEZdJ0S6Ea+KKuw43vY10+nLOWkNtVqeYqRTIiBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=En8K37bRvkwZSIAeXP62QQimap3KofbLcDwYLUb4ZnYuzJqnKHGOLI+0IFZ8vJaKa0Kpwqhg2MYq/UV0NCS7CFYXrHHo2+W8icTffYMXbGcPo+saC7mJpQa5wvdqqFALU/9GrV7HM031/d9YkXtMGVbNN75aZu/+yQG+WB2/KGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzE18Y5K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzE18Y5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464E01F00ACA
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 18:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779991300;
	bh=7PeyEZdJ0S6Ea+KKuw43vY10+nLOWkNtVqeYqRTIiBs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KzE18Y5Km0e8ZZjsy3bcm5SVy50j7pPCoc03xh+z7mZpgc38q85VbHoyCptXMYRUC
	 wiq8gpXYFjLXJxkF7mMmDCy5Orjul/lycwka6zkD3bISjU3E8s+ZUPQZw9S2SLI6Ib
	 1VAqH+uNtuRTavmag0hFAytO0Ta9EYYhvNdTtFWGzFQn5HXPSK+FXbS3kpIrWuObqV
	 KIhQqisQWVA6+t+r9isnsziVoP5nTRtq/yeTYJtapULs+oGPY1XV+uc9Yg2CEw8PR5
	 6AOiPe/NqSP2IUwQQJfwOuj+tZ+6d+P04MDq0m+iCJh2WSdZjOFjrS4q+aXbR2IBzz
	 Q9XSGkx2KQhGg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bd2087858c4so2337008566b.0
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:01:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/IsisH95c4E2xQH/xXF7l2JUgJ+yC4QdMcgWORT5UlZjKoi2/sb+CgCW0r3ntfckItoig=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxh68qGpcXMrZ9gXU4yoZMqlUbII68bcwDE1FUwnXN1m3i4rEt
	8o+QE6SwAv5uIs1X2Q9ciM3Asu5sQSBCVJZC9vtdwIbPROBGGvr1mMo/Twe6LLpJRhRpw9dbutF
	u5EO5LPvK6KA6e1i29pFO61PzU3bwHxk=
X-Received: by 2002:a17:907:25cc:b0:bdd:3c8:3348 with SMTP id
 a640c23a62f3a-be97441e783mr14316266b.40.1779991299186; Thu, 28 May 2026
 11:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527234711.4175166-1-yosry@kernel.org> <a2b2cbc1-c293-4e1b-ba8f-8f18c952e82f@linux.intel.com>
In-Reply-To: <a2b2cbc1-c293-4e1b-ba8f-8f18c952e82f@linux.intel.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 28 May 2026 11:01:27 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNzfB57YE_iCN6MfXTWAT+zM+hZtLS6BM9kZ08z2qEXAg@mail.gmail.com>
X-Gm-Features: AVHnY4JHB5jOIu3PikBvkoreYO5sL2o1a6F8yQ3yP4PhHeh78jUVL9rX_IzPcbs
Message-ID: <CAO9r8zNzfB57YE_iCN6MfXTWAT+zM+hZtLS6BM9kZ08z2qEXAg@mail.gmail.com>
Subject: Re: [PATCH v7 00/17] KVM: x86/pmu: Add support for AMD
 Host-Only/Guest-Only bits
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 1:30=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
> Run below KVM PMU selftests on SPR for both mediated vPMU and legacy
> emulated vPMU modes, no issue is found.
>
> - pmu_counters_test
>
> - pmu_event_filter_test
>
> - vmx_pmu_caps_test
>
> I know the patches have been merged, so just post the test results here.
> Thanks.

Thank you for checking!
