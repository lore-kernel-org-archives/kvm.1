Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF78B3DBD6F
	for <kvm@vger.kernel.org>; Thu,  5 Mar 2026 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730568; cv=none; b=pK3EUNE+YV2GBowaDJG+p9K36+uGZr4dnV4LLAKzdU8t90kmlhGj30ebyUym2rI1DadqB2AFFQCLyF+tQ8ueRPhU5uDG1JrESep5/zM7EANUS2Bwja8ECST6FurB4cC9/q9FOIjvxyc3cwLV5cKA9ETAAtU821UfTspc5Q7QUuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730568; c=relaxed/simple;
	bh=IOxD4RMWl0XT1BquGevJUbg9V0DTPXIxl+uwM6zy6DM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NePNeD7CPsZKDs4QvXMIvRPO+4WzMKNrWrHEqBSAM4H23YhJzFihC0Ix7QJ8hYclyPQ3Z0WXl3CSHOwQuXZlnq0tpwzZRhk0+bmzYWjepIiwwFzgz1V7gQ7ivRy3Wzw/0YJSZw/1+zSlIEu3jnK60brZD4ZyjbL8JwtVOUyHzQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qkHZ4CXT; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkHZ4CXT"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c7387c70046so841179a12.0
        for <kvm@vger.kernel.org>; Thu, 05 Mar 2026 09:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772730567; x=1773335367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jvpCZZ0a9Yq+2yPdrdKB9QY+RilUr22l4yi9tVPddtU=;
        b=qkHZ4CXTx+Kn3hle6nnUwY1Pdhho+2AMAirDWyKM+RernKDZB0bP+N/k90rExohiKh
         OMfcIr8GCK/lz5WlXfYSJZOsH3iA4+yo0gcNIlyZ6knwUM0XOWrYlfsbxjMKVw9Mc5TS
         UFCNVsRBiKULuHx/htUS2wsC54fM6mq7uOf7qdWSj2ADs/uGqcfltvUJ0lkJy1o4Mj2e
         1qvWarKWoDaP4GXhWnfQw+qiolRKuuGRR8kXLGbATfi7/0O6K8tRwc2SzpX5dhCj3Yqr
         zat6+tm73JC9dsLF05J+uvmYk4xyRLIa/FEtFhZW4qbt64ubrEchEzKUd6LuxMQYqX3W
         x/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730567; x=1773335367;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvpCZZ0a9Yq+2yPdrdKB9QY+RilUr22l4yi9tVPddtU=;
        b=uX+noxcMxFmk7EIb5K/q3mmXbP+kbFk4ujgFT7lNgsvRVcdtErPF5X1p63p/g8iUjh
         6bvgYLE2McUq9llFuH2bVrv10rAyLuvVzj8EOx0b7hWnAEot+Zjjozl91FxnZeW+lDS7
         1M4A9eKBg1vz8L1ryHD6aUF14CWCRiG93vj+XDSEp9Q2lEp1wcV6UQDI4cz4fLTmQbgF
         UyjISR4JbYh4aOFwiJzT1ptvEm1hlwxRIdrTZ1cLNXL2DlWgMKEfDOg15G1vQ7ib21N5
         s1+770Vnkrpg4MHbjyV5yatkAotzQ1Q2dIuw3WI5g6ALf5VViGAKfEvloEffPcK3pSdH
         Hzfw==
X-Gm-Message-State: AOJu0YzvcWe1wlsyGE7jSsb6LNW0dc3aFpCFHI4eMqoOZmGygU0WbHwQ
	MsWOFPFDNVTdLAWJStj1PSK+KAj/u9hY5V8ihwJQoGqI9bOXX/ccLg+WSu+ptCHs+hvyP3gAISq
	ChnN8dw==
X-Received: from pfjj9.prod.google.com ([2002:a05:6a00:2349:b0:829:9475:6dd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:21c9:b0:824:36f8:3461
 with SMTP id d2e1a72fcca58-82972b67282mr5893351b3a.23.1772730566836; Thu, 05
 Mar 2026 09:09:26 -0800 (PST)
Date: Thu,  5 Mar 2026 09:07:41 -0800
In-Reply-To: <20260203190711.458413-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203190711.458413-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <177273040930.1572436.340994491480957114.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: SVM: Fix CR8 intercpetion woes with AVIC
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Naveen N Rao <naveen@kernel.org>, 
	"Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 03 Feb 2026 11:07:08 -0800, Sean Christopherson wrote:
> Fix a bug (or rather, a class of bugs) where SVM leaves the CR8 write
> intercept enabled after AVIC is enabled.  On its own, the dangling CR8
> intercept is "just" a performance issue.  But combined with the TPR sync bug
> fixed by commit d02e48830e3f ("KVM: SVM: Sync TPR from LAPIC into VMCB::V_TPR
> even if AVIC is active"), the danging intercept is fatal to Windows guests as
> the TPR seen by hardware gets wildly out of sync with reality.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/2] KVM: SVM: Initialize AVIC VMCB fields if AVIC is enabled with in-kernel APIC
      https://github.com/kvm-x86/linux/commit/9071d0eb6955
[2/2] KVM: SVM: Set/clear CR8 write interception when AVIC is (de)activated
      https://github.com/kvm-x86/linux/commit/e992bf67bcba

--
https://github.com/kvm-x86/linux/tree/next
