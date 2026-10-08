Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABE136E48C
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487935; cv=none; b=ZEPCZaZFNtmSwULFb4BhpJeAz/z5tXs+h93iJk5I44gqmu79QsWXOCtk2fVBOP0DXjo3Iexj32yzfJRkaZucLOv8fWEKPVaT4hp8RbfPpf4dtBR/6pgmaKWUPPmj5FdJrnim2ZKr+7+OEiXWoEOrdkAffd2hqlFunVhtI3ssaUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487935; c=relaxed/simple;
	bh=ih1JtM7Z+Fcv8FJCiDhnaor7p5/rX/PNyTaBfJvEo6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TAPbxUllTJqZEjDtCqxN0BZQweEPJLptB0jGuMSXbWwogDLIoRx2BqRvGph7BSGMt1BK4CK1G9tzDdS3N0bewJWI1yGFYuOFmHXG2UaHlOQHiqK5PPzFmaj4K3nIj20lwSJQ/TwJ2bhxjcQsM8UrajmD9dAJosg+7mv9ck+9ULU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eg6pvOZh; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eg6pvOZh"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc4922b7c31so4221106a12.1
        for <kvm@vger.kernel.org>; Thu, 08 Oct 2026 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791487933; x=1792092733; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zlBSbycgqhKXLo8mgxN6MxQbS9RlUEzSvbMwcgSitw0=;
        b=Eg6pvOZhdFihRhVOzq2MPo/lm3wZq5hBToSXgfhNNIKTKJGHj/pacBMUTpNULgV7pA
         XtXogxQTbYxZW+OYxmzEa/wmVVP+Y0Ii9zVfkxsghKDWHBB9Ielf+QcTtiWrzBum6i9R
         TWXawiK6TtFKO5ecEGwv5uA+CptcsU4+7j850ivWo13t3/SWXh9l8Kqger59irywaBiG
         KahUaCuUU8G6fDPuDoa4GvrGhsfeLYEjwoFUHpIZItBeuPRTHuFkmp5+sIqQsx2zhW+6
         +A7SBDaf9JqAE1EW7R3RI70X22WP3EjxAuxouitpMz74jma95wn/UIWNPdvA3qj6huGe
         q/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791487933; x=1792092733;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zlBSbycgqhKXLo8mgxN6MxQbS9RlUEzSvbMwcgSitw0=;
        b=DijTiFIdxkibImfiNd9JMcwRdJwPfQyUeSURI7CHAuw70HS8pwH3yUql54hF9JO35V
         9kEzclkjzW1RsuS1y8t8pNoC414D9PJLhhBxCYVcMWj10AVgnjdFoLybFTCh5O9XF7Xt
         +xKdH31U3fId2hUQ0vgNBJbHXs0x0JKbqEup2Smv3qYtNM0//RAhYVFGA5YaBG51kOLR
         aalzdFRDI90VpFW9zoarL/sdQxqPQmQtcplQ+KAJREbRcthekPIL2gdbLaqw2edPOfkH
         QrNXczjoNIm+pXqZWaWp4MZocGLmYRcSypnynKmhDhWeKVOZ0fWE6TfC0UfLE8sMnciA
         G3Xg==
X-Forwarded-Encrypted: i=1; AKwUvBwSCv5JPAvEbms1S+mBh+hxKf7pWRm5t8SOfRo3ogK7PEVObN8k8/u4/wxtboZhghpCZ5U=@vger.kernel.org
X-Gm-Message-State: AFuF++lxSeOkHm/66Md1bAvx9qT0ZT/WD5vEi4zur6QgdoGkXSueFlVK
	g2Q0aVYzBahK1xwTSDTxIw8aoZ4Vn8J7hFk+rb3MT4U3frlNk3tt6zhBUwRLx56hO5LpfOh/IBJ
	W0ynaEwG6TpzwaQ==
X-Received: from pgaa1-n1.prod.google.com ([2002:a05:6a02:6481:10b0:cc7:a34e:6ed3])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6004:b0:3e1:2a89:db18 with SMTP id adf61e73a8af0-3e164e1fdecmr215228637.88.1791487933066;
 Thu, 08 Oct 2026 12:32:13 -0700 (PDT)
Date: Thu,  8 Oct 2026 12:32:04 -0700
In-Reply-To: <20260310060022.15120-8-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310060022.15120-1-manali.shukla@amd.com> <20260310060022.15120-8-manali.shukla@amd.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261008193208.832031-1-jmattson@google.com>
Subject: Re: [PATCH v3 7/9] perf/x86/amd: Enable VPMU passthrough capability
 for IBS PMU
From: Jim Mattson <jmattson@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: Jim Mattson <jmattson@google.com>, seanjc@google.com, pbonzini@redhat.com, 
	mingo@redhat.com, bp@alien8.de, kvm@vger.kernel.org, x86@kernel.org, 
	santosh.shukla@amd.com, nikunj.dadhania@amd.com, Naveen.Rao@amd.com, 
	dapeng1.mi@linux.intel.com, ravi.bangoria@amd.com, peterz@infradead.org, 
	Sandipan.Das@amd.com, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 10, 2026 at 06:00:19AM +0000, Manali Shukla wrote:
> IBS MSRs are classified as Swap Type C, which requires the hypervisor
> to save and restore its own IBS state before VMENTRY and after VMEXIT.
>
> To support this, set the ibs_op and ibs_fetch PMUs with the
> PERF_PMU_CAP_MEDIATED_VPMU capability. This ensures that these PMUs are
> exclusively owned by the guest while it is running, allowing the
> hypervisor to manage IBS state transitions correctly.
>
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 6d230e417b61..e075c5ed136c 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -978,6 +978,7 @@ static struct perf_ibs perf_ibs_fetch = {
>  		.stop		= perf_ibs_stop,
>  		.read		= perf_ibs_read,
>  		.check_period	= perf_ibs_check_period,
> +		.capabilities	= PERF_PMU_CAP_MEDIATED_VPMU,

At this point in the series, perf_ibs_init() still rejects events with
exclude_guest set, so every IBS event is an "include guest" event, as
defined by is_include_guest_event(). With this capability:

- If any IBS event exists, perf_create_mediated_pmu() returns -EBUSY, so
  KVM cannot create a vCPU in a VM with a mediated PMU.

- If any VM with a mediated PMU exists, mediated_pmu_account_event()
  returns -EOPNOTSUPP, so no IBS event can be created.

Patch 8/9 removes the exclude_guest check. Please squash patches 7/9 and
8/9 together, so that the series does not have this regression at any
commit.

Do we really want to set this capability when the CPU does not support IBS
virtualization (or when kvm_amd.vibs=0)? In that case, the guest cannot use
IBS, but host IBS events that do not set exclude_guest still block mediated
PMU VMs, and vice versa.

When the guest context is loaded, perf_load_guest_context() schedules
out the exclude_guest IBS events through perf_ibs_stop(). On hardware
with IBS_CAPS_DIS, perf_ibs_stop() does not clear IbsFetchEn or IbsOpEn.
See my comment on patch 6/9.

>  	},
>  	.msr			= MSR_AMD64_IBSFETCHCTL,
>  	.msr2			= MSR_AMD64_IBSFETCHCTL2,
