Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4806C305673
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780094908; cv=none; b=Ynoj65KxxWCjijQfB+nzcxCsT1m70FoZjyfwR/YyE26n83b/WVIIQNYvVWuDjHbBJbhbFYWkiPdEmljrdJfCzxYdByli1+WF+ro4IqQcozqc+/uHmjFcSRO7EXTZU4uwbREsNt3cZbbHaI/SoDMzTrN/eYT92SJmy6zPCGjM4kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780094908; c=relaxed/simple;
	bh=dxJifg/pg7Ny3j1Vf54ahG5+UMAOvTCdePrfMrguaeo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cF7Ydw4AFhCYY/cOtSMW33xAkIkDDotADcdEghgF2+SgysPEL3fNHV1X6mn8KL7WgmOdPZtsx/a3Oi1by08wr5COCrZhUvTGWPU1RTOYlD1Sv7pcLTLMfDTuHMldyXZDJgPRuJ4Vpc9KAs3AMGVFxxb2/rXBDkr5vQb+iCbTv2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UhUro49L; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UhUro49L"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8281d4cef8so7014646a12.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780094906; x=1780699706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=idd/vKeFvJURIZwCXF0gmf9KrzMg5XgY56RpNOji2OA=;
        b=UhUro49Lpr2VUspnaiUygVnjuWKM6OSonRqUodvVk2OmLu+4xvWB+ojCLXwG/dqJhD
         OqA+BpRPtU/XhP0yjhgNB498iUGnU/Wbc0Oba0kw456aiJzY0ECl/k7bhTd9B/939aOG
         F8O+ccq+Cr3MgFDTDJqx2C/8nxZKuWi2QScc7hT9uRR6IBeMRn/Pye3/TywR7AZVXC7J
         GnTx32YHNLyW2c/ddcjtQq6Rizr3OiPG2EzDA0HGT5FxfSzCN3cEGwZtANZlBZp9CGtG
         GysVpwNQOGlpPxxmW2nZpAzXpniB3bbWVjdaaELzt8ez6aFKlCFUABTjAVsSyafwrBsZ
         JFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780094906; x=1780699706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=idd/vKeFvJURIZwCXF0gmf9KrzMg5XgY56RpNOji2OA=;
        b=AD9oE+zBU+ZZM81pUjQ+7CYC/CIBjd1FndJiKJxfBYj5HsoSu+k+DDuztaDAe0nQAT
         8RdAOKv9ZgG4+getuAnEwDTRStiIsitAov2Am7wj4i9EwV8LrSIWKx8Lppp2NfD18018
         txHe+N4DQ/rco0wSn81kVB3i4Q3Wj2dcV7LpcmIUAsr9ebYYU/N9+JjBkTlHW7F163lk
         0uqs4/gDXOKEOzL/WoOmpM0CPbUivPrigAZq1zty/ytB4iNuHFH0rjfjEUGcPKInyTvk
         ZHBuFDe/XzBChgO0wykGzOZiqNJLYlBLDAxaRfkYKzNj+iYZciPO5VEj5Rx7yJ3/oVjl
         9Hdg==
X-Forwarded-Encrypted: i=1; AFNElJ85i3Y7Zt+BqpYFYH6TAstiFqNJRpn31fXWZFRAOkwFPTJ6me9BGKQzQ0jgm/DlR6iOGWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ9Tel9acUMHWNNlfz7UEa2NfxUh1hVwzmHbyxZzIxoe2t7svn
	HKsMOPwE8BHN4odhI3MPGznjzInU1smiXaOE40pTE43DDPur9IEyrIZkmADyu9fwgpTaP5Dd/5H
	hmM5ObQ==
X-Received: from pgy31.prod.google.com ([2002:a63:185f:0:b0:c85:7e9d:d473])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6813:b0:39b:dea7:5624
 with SMTP id adf61e73a8af0-3b427fe9517mr1282711637.47.1780094906347; Fri, 29
 May 2026 15:48:26 -0700 (PDT)
Date: Fri, 29 May 2026 15:47:52 -0700
In-Reply-To: <20260527234711.4175166-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527234711.4175166-1-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <178009450438.879236.9673876537100547847.b4-ty@google.com>
Subject: Re: [PATCH v7 00/17] KVM: x86/pmu: Add support for AMD
 Host-Only/Guest-Only bits
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 27 May 2026 23:46:54 +0000, Yosry Ahmed wrote:
> v7 of Jim and myself's series adding support for AMD's Host-Only and
> Guest-Only performance counter eventsel bits in KVM's mediated PMU
> passthrough implementation. The series keeps growing in size over
> versions. This is Sean's fault (as usual), as he keeps finding subtle
> problems and making excellent suggestions.
> 
> These bits allow an nSVM-enabled guest to configure performance counters
> that count only during L1 execution (Host-Only) or only during L2 execution
> (Guest-Only).
> 
> [...]

Applied the KVM changes to kvm-x86 svm.  Please yell at me if you haven't seen
new versions of the selftests after the 7.2 merge window has opened (assuming
Paolo and I are somewhat on top of things and actually get the KVM x86 pull
requests merged _before_ Linus opens the window).

[01/17] KVM: nSVM: Stop leaking single-stepping on VMRUN into L2
        https://github.com/kvm-x86/linux/commit/8862376260c4
[02/17] KVM: nSVM: Bail early out of VMRUN emulation if advancing RIP fails
        https://github.com/kvm-x86/linux/commit/42ff88db18a5
[03/17] KVM: nSVM: Unify RIP and PMU handling calls when emulating VMRUN
        https://github.com/kvm-x86/linux/commit/0a35c2a051f3
[04/17] KVM: nSVM: Move VMRUN instruction retirement after entering guest mode
        https://github.com/kvm-x86/linux/commit/9be579d22651
[05/17] KVM: x86: Move enable_pmu/enable_mediated_pmu to pmu.h and pmu.c
        https://github.com/kvm-x86/linux/commit/277eb65b6cc3
[06/17] KVM: x86/pmu: Rename reprogram_counters() to clarify usage
        https://github.com/kvm-x86/linux/commit/103cd7deda58
[07/17] KVM: x86/pmu: Do a single atomic OR when reprogramming counters
        https://github.com/kvm-x86/linux/commit/e48810e06f45
[08/17] KVM: x86/pmu: Check mediated PMU counter enablement before event filters
        https://github.com/kvm-x86/linux/commit/232eadc3110b
[09/17] KVM: x86/pmu: Add support for KVM_X86_PMU_OP_OPTIONAL_RET0
        https://github.com/kvm-x86/linux/commit/f98ef41a5af4
[10/17] KVM: x86/pmu: Disable counters based on Host-Only/Guest-Only bits in SVM
        https://github.com/kvm-x86/linux/commit/2ed72677a5c1
[11/17] KVM: x86/pmu: Track mediated PMU counters with mode-specific enables
        https://github.com/kvm-x86/linux/commit/c0d4c9c54c25
[12/17] KVM: x86/pmu: Reprogram Host/Guest-Only counters on nested transitions
        https://github.com/kvm-x86/linux/commit/a02a25a65246
[13/17] KVM: x86/pmu: Allow Host-Only/Guest-Only bits with nSVM and mediated PMU
        https://github.com/kvm-x86/linux/commit/f4805dcf2d21

--
https://github.com/kvm-x86/linux/tree/next
