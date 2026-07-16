Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5830925B0B8
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196352; cv=none; b=BXJ3X+ZafYW1u7ND4jR1UkhZcdfx5zTket7RHJb/AnBImAaZvMCcnpBu3yKnsQKyWK7VGqN1gWWh/4xgXiG3qU7JYtPSoKBFXTquPIGM7YS4f+rVJL8KCLtZQK4TVEMGqsblQKodpxnTVqlzupxzYZhRUlp8cS+4RSazAfxd31M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196352; c=relaxed/simple;
	bh=oaNcItQX3+lZDLiWbz3+OgDBTksCf3a74PZXGOrAarc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nI4S7nYMV03dF0P/8qQF2VaXZ+0ODJEMnLtLftD0ug7zZJVTtaU4j6iA2lNrvk8ov9iVy4hLOqmexkryi/r3/pwWwSyc9jDjKVqzmVlyt23lSP569dsjRqVh/02yq88qBYTdKq8YxHgGd/RKU9l/b78H1H9SzOZYqx286bwlkZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F7L2LVDW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7L2LVDW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784196350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mAq1Bt90R9SWsWMZK2rHJPQpSqkEPM2EYKiyU0yD7NU=;
	b=F7L2LVDWXzOga16iaX1NlXUnpBFatf6UONbuExyO+djTKWgchWA0HeJCXMN2jtp4Xk3kkw
	NffgpMHUfjoAxZ6ami6GHCUsg21FgaOZUNrBeGTchLBZLXzsKOAoBoMMAuCowZfMjWu31a
	9HhQKQ5L2g6wXk280l5kyGjoKPba8zw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-Uv_d8R6WMrGk4SaouL40hQ-1; Thu,
 16 Jul 2026 06:05:46 -0400
X-MC-Unique: Uv_d8R6WMrGk4SaouL40hQ-1
X-Mimecast-MFC-AGG-ID: Uv_d8R6WMrGk4SaouL40hQ_1784196346
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0004F1955D9C;
	Thu, 16 Jul 2026 10:05:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.22.29])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4667E1955F74;
	Thu, 16 Jul 2026 10:05:43 +0000 (UTC)
From: Anthony Harivel <aharivel@redhat.com>
To: aharivel@redhat.com
Cc: kvm@vger.kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com
Subject: Re: [RFC PATCH] KVM: x86: RFC for per-VM C-state policy enforcement (KVM_CAP_CSTATE_POLICY)
Date: Thu, 16 Jul 2026 12:05:38 +0200
Message-ID: <20260716100539.2059970-1-aharivel@redhat.com>
In-Reply-To: <20260715124235.1444895-1-aharivel@redhat.com>
References: <20260715124235.1444895-1-aharivel@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Paolo, Sean,

I sent an RFC to kvm@ for a per-VM C-state policy capability
(KVM_CAP_CSTATE_POLICY). The idea is to let the host set a max C-state ceiling
per VM, filling the gap between full interception (cpu-pm=off) and full
delegation (cpu-pm=on).

https://lore.kernel.org/kvm/20260715124235.1444895-1-aharivel@redhat.com/

I've been tracing the implementation path and I've hit a design question I'd
value your input on before going further.

The enforcement point is kvm_vcpu_halt() → kvm_vcpu_block() → schedule()
→ cpuidle. The problem is that cpuidle has no per-task C-state constraint
— states_usage[].disable is per-CPU, and forced_idle_latency_limit_ns is also
per-CPU.

So three options:

  (a) Temporarily toggle states_usage[i].disable on the pinned pCPU
      before/after kvm_vcpu_block(). Simple, works with existing API,
      but only correct with dedicated pinning (overcommit with mixed
      policies would race on the disable flags).

  (b) Use forced_idle_latency_limit_ns on the pCPU — same per-CPU
      limitation, and latency-based rather than state-index-based.

  (c) Propose a new cpuidle API for per-task idle constraints (e.g.
      a per-task_struct annotation checked by the governor). Correct
      for all cases, but bigger scope and needs cpuidle maintainer
      buy-in (Rafael Wysocki).

My use case is NFV with dedicated pinned cores, so option (a) would work.

But I'm wondering:

1. Is this use case too niche for upstream KVM? The target is cloud
operators running VNFs on dedicated cores who need a host-side
kill switch for deep C-states without guest cooperation.

2. If it is worth pursuing — would you accept option (a) scoped to
the dedicated-pinning case for v1, or would you want the cleaner
option (c) from the start?

3. Is there a simpler approach I'm missing entirely? I looked at
whether KVM could cap things before reaching schedule() (e.g.
custom idle with MONITOR+MWAIT), but that breaks scheduler/RCU
invariants as the sashiko review pointed out.

Happy to prototype whichever direction you think has the best chance of landing.

Anthony

