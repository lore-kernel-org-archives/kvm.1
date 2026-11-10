Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353660;
	b=4ofSegcBhGIuRKyWUp0rkzwIIuafIOImkgng0EY9jyvJ7NkVexg63vnZRi0rnxmk43w9
	 gTC08VWEMlpEWrbZ5E//c2PCaR5kRhSBhCtKcSGrFJxR6DExqzQyQh2KshVZycuq80Ccz
	 zzAPI3uWc1vXyFTuAMK5rfQ/K9bMa4mGel0SGgtDv8flwRqzfmHSZVG5ppcnJNgvLj6VV
	 oro8I7phORU55kbR/JkPzysFqjCbea6vP6MC0z89G8z9hr/sxftDRD1cmIjnVqLGwZ2pF
	 TCV3syAM24DwUfR54AhZdCEJJyH4N3Lq9DnDTDrR+Gxq68MAEQs+Qhall5FeMZIDvQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=maMMv4jIWhT/WuiiquFkWwtVqzwmWNG01HiS3weib7s=;
	b=BTYpV1Y9z63oWVMO7W61GnkC2my4OQLAjS6Y6EPLbK7MljAO/obb9bYHcnibSqpfU6N+
	 0sVvCPyM+vlV/V7wtOXV8buF7eNRpdcVF19B+P/88owgx8V4ONMcn/kXT/fUcDQ47a3e4
	 4/zeP3sJmYUYwIp2hx3VjGX4KogjSCerlzfOmvvFv5jMbMYaJQvyvJ5SrsyranabrJZQH
	 jJjFZx9PlvqZKPA3Cjzx6w7gnCM2IIP/0uP+Raua6gd6aGTznEgobYvT8OtVB33u2n+E8
	 MQLmIB40g2l27TfFcRSvlZKAPNL59mMAt6piUD9w7vGHFNO0RbpZUMA0cgX9rQDopPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ASdoOIsI;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD6A606A31C
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 23:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DD6A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ASdoOIsI
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd60e4e8bc3so1706042a12.1
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 15:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794353659; x=1794958459; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=maMMv4jIWhT/WuiiquFkWwtVqzwmWNG01HiS3weib7s=;
        b=ASdoOIsI6hyttLF63ae8LDYlWzdUFHzcGBAY4V79qFW6skYsBkIHrgXhxq/7CRJWbg
         yvW3XJz39vxNwOdhYYSOXbPNzzVVFD8wgnVmQWRCDIewc7lZjTEaOk8HEDdTI5Kfg5J7
         i/W0rCZlHyEb/2+acMY8sNbJLBqTpmnuADkpXtDiOsZJiOxhCsuKFlcnkMT4AHwHgnfO
         yM7MximB3CVmtdZpw01C/YroVk0BnFLelNN3sLFAv/udDmgg/M6VsxZezSd7h8+I4acM
         idodTez70qKllWvn+CIABcGv7mvhfwbcojJtbBGKJzu7sr2cq0YpeuSydFPpXOSiMIff
         w72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794353659; x=1794958459;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=maMMv4jIWhT/WuiiquFkWwtVqzwmWNG01HiS3weib7s=;
        b=v9FlWunO0H4LtjcILoOspQ5N9kguLLaVvYfO8zN9w8XUZOqR95Cp/IwFt+7Wfcr5LN
         kNp7hcoJThxWBhUBEAfkaqTaf2s8DsfqyFPz7bX/v5J3sICatn0EcfvZnC6m/imeMb1o
         oquSxpcP/JVOo8dOlQ8Ko2hysDG2DgO1YeE7/6ZXuvGzlgTg3+tyjTIIIlH7MM+Ez2fR
         6XsF0sQadNvOAQ0gfa7lM/XjE3jf/t3GmVgtGeoWFb7ywatTpYIF1x+uf4ElcnF3I9a8
         000ff1AZ+1BvWTjvaK5JrDD9Np8A+ib+aRG3UVK7pfXZDkmT0dn5nqA+ESDaBQB2aCwW
         TitA==
X-Forwarded-Encrypted: i=1; AL+hErEWlg+LWfNlqGUF545ufevPDjPvEU9xzTPSTX/RQOwD8rqLzU4fXe5W2fmxp7HuMbzGM68=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WLRU4lvX6L7S+TjV/0fNX5CuSat0IHMABB5nmU9fwf53JNe4x
	LWqpR8qq2VYBdI9NmHI0EmBNJg+uyX8Tzxr764Xqijv/eMs+/jjhFkPuMdv3BCegqF8uYOa2I53
	9j49KWw==
X-Received: from pgbbo3.prod.google.com ([2002:a05:6a02:383:b0:cd8:ba74:813f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224c:b0:3a2:b16d:928b
 with SMTP id 98e67ed59e1d1-3b182f86a71mr580515a91.46.1794353659122; Tue, 10
 Nov 2026 15:34:19 -0800 (PST)
Date: Tue, 10 Nov 2026 15:34:18 -0800
In-Reply-To: <sashiko-outbox-199646@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105164531.313849-1-pbonzini@redhat.com> <20261105164531.313849-6-pbonzini@redhat.com>
 <sashiko-outbox-199646@kernel.org>
Message-ID: <avOp-gc3nU35Z7H-@seanjc-mac.roam.internal>
Subject: Re: [PATCH 5/5] KVM: x86: move asynchronous page fault handling to vcpu_enter_guest()
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 05, 2026, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Can this leave the stack-allocated host_apf_node linked in async_pf_sleepers
> after vcpu_enter_guest() returns when token is 0?
> 
> In kvm_handle_host_apf_irqoff(), kvm_async_pf_queue_task(token,
> host_apf_node) is called without checking whether token is 0 or recording the
> boolean return value:
> 
> arch/x86/kernel/kvm.c:kvm_async_pf_queue_task() {
> 	...
> 	n->token = token;
> 	n->cpu = smp_processor_id();
> 	init_swait_queue_head(&n->wq);
> 	hlist_add_head(&n->link, &b->list);
> 	raw_spin_unlock(&b->lock);
> 	return true;
> }
> 
> If token is 0, kvm_async_pf_queue_task() still inserts &host_apf_node.link
> into async_pf_sleepers with host_apf_node.token == 0 and returns true.
> 
> Then in vcpu_enter_guest(), the condition:
> 
> 	if (exit_fastpath == EXIT_FASTPATH_APF && host_apf_node.token)
> 		kvm_handle_pv_async_pf(&host_apf_node);
> 
> evaluates to false because host_apf_node.token is 0, skipping
> kvm_handle_pv_async_pf() and returning from vcpu_enter_guest() while
> host_apf_node.link remains queued in async_pf_sleepers.
> 
> A zero token with KVM_PV_REASON_PAGE_NOT_PRESENT set can occur if L0 is buggy
> or untrusted, or if L0 KVM sets KVM_PV_REASON_PAGE_NOT_PRESENT in L1's
> apf_reason.flags via kvm_arch_async_page_not_present() and queues
> vcpu->arch.exception_vmexit, but exception_vmexit is subsequently cleared
> before injection into L1 (for example, when preempted by KVM_APIC_INIT in
> vmx_check_nested_events() or svm_check_nested_events() calling
> kvm_clear_exception_queue(), or across KVM_GET_VCPU_EVENTS and
> KVM_SET_VCPU_EVENTS), leaving KVM_PV_REASON_PAGE_NOT_PRESENT stale in L1's
> apf_reason.flags until L2 triggers a regular #PF VM-exit whose faulting
> address has lower 32 bits equal to 0.
> 
> Previously, kvm_handle_host_apf_irqoff() checked the boolean return value of
> kvm_async_pf_queue_task() directly instead of testing host_apf_node.token != 0.

And on a related topic, can't exit_fastpath be set to HANDLED at this point?
I.e. why is it not this?  I feel like I'm missing something.

	if (exit_fastpath == EXIT_FASTPATH_APF) {
		kvm_handle_pv_async_pf(&host_apf_node);
		exit_fastpath = EXIT_FASTPATH_EXIT_HANDLED;
	}
