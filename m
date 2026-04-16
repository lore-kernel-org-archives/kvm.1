Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033E83890EA
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776368334; cv=none; b=QlBYpT0v2IkH+Fhd4nM0RW1F++Vk/RCPiQCgQ3LjMnByulY+pL0tTHKuj1EFEzCWHCFBpaPzAsJOr9DrPgpnP/68nenh9XJzxnjtXS9e51tmNSmz3+9uEyc+HBiSFzoC3JhEoVRxx6TrzHRufXnw9o3/Jq/gCbGt3hCHFd0VWPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776368334; c=relaxed/simple;
	bh=ysLa6ksEOUYVMmhdG9ZT9GZLHSpQavIhtm92MOWxgRM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mnkBd3IFZWNch62oqBmQ3uktX3nWZTtf5MIPYhLQkKAMfiDMdelG884b9+9d7rSIevS8Uy5FNk40xdgj5FbX+oWKeMSn491cc7/I7W+dMMXBN9lk2ZE3uFZFOu50tEQ19Cx54Gy0mvSweBaNzFIj7w7SUUMR3GfLsW231T+UxIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QA0N+lt+; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QA0N+lt+"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f2138a9e0so3182384b3a.3
        for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 12:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776368331; x=1776973131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S4kcc1nmfLe/qZYFBrnwpUX8iJIcKjKD0pIVP+tkdCo=;
        b=QA0N+lt+3MOuNXIatUTJ/9rnYKhuleyJizI0cnqBx7rfHOHFLboUaZ2BZvbzmKek5l
         SRmGmP2+G3sfqZERHWWnYNTiEygzovhw6i0pKpeSChtl4BduUjRUu9vnKSIVDrXL2OLS
         sf7/o7SmAMbxb6GSNP46f41yZt4DwshU9fOMpnlG6iZB2nBMGI61Wiq3lx6V3v+ZVPXC
         9IU2ZHU8Oufo0LFLW0wjXV3BjRaSiltQ8Fpsl0mFq3SXDaXsrdSvQvP3VAA1T/+BtQk0
         BeVedJOXaEdn1nuaBUtOKwoZDjHgTK2qndlwa251dnyccf/Ncv5+qJt5J92BFdgkX0WM
         Zaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776368331; x=1776973131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4kcc1nmfLe/qZYFBrnwpUX8iJIcKjKD0pIVP+tkdCo=;
        b=AWtF2JNJPB6g1h3gqFFt6Pogto/pUmkxLgAPStC6T+PgsD614mvXLEfVGKiqZTkCSx
         5OrxKoiHeG3WYvUZfTdb19Eq4BB/K91WA36dkM9YoxdLbxTF6irzBWc6dzllI37fWzI4
         9kRNA6c5yPvuqeZk8i2ZdPBE+uH+POOqrN+v68tqqd9PDcF3o3pUCsImaOk+YnIIau+3
         jiotCRvOy9+NUAXMrNyGVqRDZ+W5Rd+xnPa377iZSLcYk/kH9oGpuZS6w5J4hL7W2TFm
         P5iR3TioJFl/CIiQuXr2xgNKlPhawILiHd40/Z8tADdpRvnkZ+DrsuEKXeqX65q5hz0d
         IUJg==
X-Forwarded-Encrypted: i=1; AFNElJ9yfS+ap4ANX8LLW81pPwfH0Sg5vsg97C5rpLqZy154VwFJY6lzevWKAiYM+MNUIDqGHQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhZnSiWvPFH3y7qeXsSoaGkIRS4G8vaJCcqzrj4Y750ODF1SOb
	Jw+fYyajSEN9cBUCSVtkmTQj/JqoCG4v/MuKflqApT7lp13/JzhKn1WmEmV/L2Lk7qCm6n+EUOK
	h0ctCYQ==
X-Received: from pfgs39.prod.google.com ([2002:a05:6a00:17a7:b0:82a:108d:4308])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:18a7:b0:82f:6bd2:eac5
 with SMTP id d2e1a72fcca58-82f885645f2mr646007b3a.2.1776368330543; Thu, 16
 Apr 2026 12:38:50 -0700 (PDT)
Date: Thu, 16 Apr 2026 12:38:49 -0700
In-Reply-To: <aeEpV9kfBSQrxwm-@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414191425.2697918-1-seanjc@google.com> <20260414191425.2697918-2-seanjc@google.com>
 <aeEpV9kfBSQrxwm-@google.com>
Message-ID: <aeE6yYGaq2rnj77v@google.com>
Subject: Re: [PATCH 1/4] perf/x86/intel: Don't write PEBS_ENABLED on
 host<=>guest xfers if CPU has isolation
From: Sean Christopherson <seanjc@google.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Stephane Eranian <eranian@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 16, 2026, Namhyung Kim wrote:
> > +	/*
> > +	 * Disable counters where the guest PMC is different than the host PMC
> > +	 * being used on behalf of the guest, as the PEBS record includes
> > +	 * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
> > +	 * wrong counter(s).  Similarly, disallow PEBS in the guest if the host
> > +	 * is using PEBS, to avoid bleeding host state into PEBS records.
> > +	 */
> > +	guest_pebs_mask &= kvm_pmu->pebs_enable & ~kvm_pmu->host_cross_mapped_mask;
> > +	if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
> > +		guest_pebs_mask = 0;
> >  
> > +	/*
> > +	 * Do NOT mess with PEBS_ENABLED.  As above, disabling counters via
> > +	 * PERF_GLOBAL_CTRL is sufficient, and loading a stale PEBS_ENABLED,
> > +	 * e.g. on VM-Exit, can put the system in a bad state.  Simply enable
> > +	 * counters in PERF_GLOBAL_CTRL, as perf load PEBS_ENABLED with the
> > +	 * full value, i.e. perf *also* relies on PERF_GLOBAL_CTRL.
> > +	 */
> > +	arr[global_ctrl].guest |= guest_pebs_mask;
> 
> I was confused by the earlier comment in the funcion that says it is not
> enough to disable counters but I've realized it's only for the case PEBS
> isolation is not supported by CPU/ucode.

Yeah, me too, more than once. :-/

> I think it's ok for disabling guest PEBS, but I'm curious if there's a
> case to enable PEBS only in guest and it'd be handled correctly.

Yep, if PEBS is being virtualized for the guest, unless the host is also profiling,
then PEBS will be active for the guest but not the host.  KVM tests for PEBS pass,
and while they aren't exactly comprehensive, they should detect outright breakage.
