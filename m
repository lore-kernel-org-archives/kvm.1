Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3343F23C5
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777467536; cv=none; b=gik8nTR84yTBpcbJ+hS3iklfKsH+oOow4CxGhsRV85Nf3D8vPSpz8TTu7djkWxNpi3DmWfaAMgi5ZX4/n5VSdSIL+yRwiRR3FOHf0cpjt0Sv/MVxTZMl9jL1dAOVZRxP+NtakFpPlYsPhlsy80DdROyyCOZBYilm2F+S4s/uPRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777467536; c=relaxed/simple;
	bh=BAiwoyLEuv74ENQ+Kv2M3FCiBUBSpE0jVXqZETMiRXY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eGlaSFBvLwIaJsX2ze7VdDiF82pbEgkOnjdicrZbJ8dSepy4qU62GbNrIU4DK1vRDYZx9/wIQFAZo2aIGPH1syEJ1xiPPY0HMyUatUbEVMRYnMYWtqJ0pEtvoFLD8A4B8ACK1hzCVqvB0th1p4vaVZPCG5FfzBDvYKzUypjW6Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ExriS37h; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ExriS37h"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354c44bf176so14810496a91.0
        for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777467534; x=1778072334; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xQ6zwRFc5Ah3WUePxKXm1iJwrz49K4Q1fO29o5vaDLU=;
        b=ExriS37hzkJFvMPRnwTbr3OW2NEc2wCnMmLTX34jTxjkbABdWoNaR5IftfqXqYespi
         OUtYakB4IMLC2h4oP/BlVmad1Kayk4QGqCCy44IepgtS0cO2ySC6zCrJKrnl6BRRQtBo
         aAaeItyhQr2muX31fUP2PuzewVetbAjIGSaKz/RQBAbhoH8sPjp4jIJfufzqfMT/B/44
         A2jmCwvaeu0Cr9tRSHjNRVhHyND5ytD8SegI514I1GSaFbTJofYhaVvWlCxievjLNwqp
         yEUnvj9qggXrYvem+RSFM1tYRID3tiDxT13g98VBJFwe0wLvn0UYkXtPf+Dhszz40JRQ
         hCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777467534; x=1778072334;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQ6zwRFc5Ah3WUePxKXm1iJwrz49K4Q1fO29o5vaDLU=;
        b=VkgukV8olTlb0HE2abHI7k8SuE1JsnY1EYlNMrcWqwW3OGkaq3jU+l85sYRo1olbhI
         a30PjCyl+NKwF9zfX8QeudEyBeGhCvpO4elKRxUIdJLasvx/XspcOIQWmV4qZpFH+iyb
         GK/+oS06euELuMOdBPjUAYrA+Z+PkBh+e8QXP+Mmx9NlzHE6P03VcQye+mnrtVv7X5xZ
         iZTLZidaX2osLkNRah4i/HPHicCyZ/V/SxteaG18UP43Gic4og80VqfRFNnTuG6xU979
         gQJXm/UVsEmXXQrn/vXqHhlWVDitkCPFG+uWVMY9tAumdqnk4nTsyfpaYC3f3Nj+BWpK
         oiCg==
X-Forwarded-Encrypted: i=1; AFNElJ85amJhnN18vZTuFe79aZCUJnTDh+hVmzzMKJu2NTq4RpknIoXwdQZkWuEnAQ/iA30aVJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbMLgdLjh83TzlMcveFarUuymjORzitBbIt01khmqHz3efnVYc
	59LiYHSzoF+Dmm7phweLJn3Kr0iBmm/C3cmDN2Kg6X+CXvfBlu4cRbOSb1o/Bz969rvseqyELkt
	zu2Cn9A==
X-Received: from plbf14.prod.google.com ([2002:a17:902:e98e:b0:2b2:470c:82e2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d510:b0:2b4:586d:2e5c
 with SMTP id d9443c01a7336-2b98b2842admr23964655ad.2.1777467533978; Wed, 29
 Apr 2026 05:58:53 -0700 (PDT)
Date: Wed, 29 Apr 2026 05:58:51 -0700
In-Reply-To: <0dacbe06-5b97-4dee-b8f2-a235b70448e2@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428070349.1633238-1-chenyi.qiang@intel.com>
 <3235eb76-9b28-4000-920a-491659927e67@redhat.com> <04c954e6-a23a-4cc8-8bd3-5882a951a8cc@intel.com>
 <afDXUwq6pR7SgxIC@google.com> <0dacbe06-5b97-4dee-b8f2-a235b70448e2@intel.com>
Message-ID: <afIAixCQqJNYWLBK@google.com>
Subject: Re: [PATCH] KVM: VMX: Fall back to IRR scan when PIR is empty despite
 PID.ON being set
From: Sean Christopherson <seanjc@google.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Gao Chao <chao.gao@intel.com>, 
	Farrah Chen <farrah.chen@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 29, 2026, Chenyi Qiang wrote:
> On 4/28/2026 11:50 PM, Sean Christopherson wrote:
> > On Tue, Apr 28, 2026, Chenyi Qiang wrote:
> >> On 4/28/2026 3:45 PM, Paolo Bonzini wrote:
> >>> On 4/28/26 09:03, Chenyi Qiang wrote:
> >>>> The interrupt is not lost (it resides in the IRR from the first sync and
> >>>> is recovered on the next vcpu_enter_guest() iteration), but the incorrect
> >>>> max_irr causes a spurious WARNING and a wasted L2 VM-Enter/VM-Exit cycle.
> >>>>
> >>>> Fixes: b41f8638b9d3 ("KVM: VMX: Isolate pure loads from atomic XCHG when processing PIR")
> > 
> > Cc: stable@vger.kernel.org
> > 
> >>>> Reported-by: Farrah Chen <farrah.chen@intel.com>
> >>>> Assisted-by: GitHub Copilot:Claude Opus 4.6
> >>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> >>>>
> >>>> ---
> >>>> There is a WARNING call trace during a nested VM stress test.
> > 
> > Any chance the stress test is something that can be shared?  I've seen this WARN
> > 2-3 times over the last year, but it was never reproducible, and so intermittent
> > that I couldn't even correlate what I was doing at the time with the WARN.
> 
> It's not something special. The stress test is only to create and tear down
> 20 nested VM instance in a cycle.  It often takes more than 20 cycles to
> reproduce this issue.

Got it, thanks much!
