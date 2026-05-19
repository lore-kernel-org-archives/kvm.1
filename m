Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786B524E4AF
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 00:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151375; cv=none; b=W21CWWNZkM2PEQnbk5UjQskB5Fac+AY/Jlwf8ixo/zx8F7fnTi/p+1A0fZ++W/ecksoroleNfcL0+js/eQ33RdxfI/cx6bEprhrWUJ9YZFl5ehKP34Pr1bjwnnwRQSZ+yHks2nVGi6Fkt1y0bdTk1kig1QUyDVT7LjP6ioM8mjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151375; c=relaxed/simple;
	bh=Tj9JJccZdDpKFD19XxI9N4WbCNWN3CNkeATkWIg7HrM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F99lxE2pJ4vWGRfcmDCZU9lnuIYD5UorEYr42An2nV5i06wNgoAxn0RqmPJfgwDCcsrqdtz4pVwP+PdFnaz71zAdWSftzehAQ6zKTYpMcIvJHDfRDCWuL6NdkK6+/QsQ65VPjUOrGt0+Rw21906mjttIiTU/OfFjcR6cVzbzKJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4Pma09D; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4Pma09D"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c70ea91bfe1so1667920a12.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779151372; x=1779756172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdiIx/sN3iBwE5Ls1fsTB1smXXTi4iFgxSPkO8HfJpw=;
        b=I4Pma09DkB/jGoH3W6vEfSNiSahEjTeGb1swYmP1faxco0jbtJvygZpy9MUDh0Ip7f
         JOdqK32Cuo4iukT8TbXU0kx+UcrmAww8i2SbF9iSMBe2/sYKlobmw3QBJvCBEGHn/jCH
         2DP19FTsniU28E4yNMepgqXBkKRj7dXgM/2eTUUg8nLsuKVJOl1qfu2zcOQgSPM4uxnt
         aG0T3c3rSdxpbt0fi1GlJSWlzN6m99H2F1PQ4LfM/eA3zNO8xKKwWuK5/KAlfHaR1wd6
         kiieSXqqPRDhOUAAGIH+cghAu/x92o/VxQKCuypIRTWWr4m8VSKNi5hMgcNYYQCy/ZsU
         XVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151372; x=1779756172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdiIx/sN3iBwE5Ls1fsTB1smXXTi4iFgxSPkO8HfJpw=;
        b=YDnv8J5Vlm+CEU7Q5OpLuW5L6acq5ejRU8sVyAZAbiX4/89liq+1m9rzOYvuUGozPG
         uqWKawHr8f/M9UAKdLyVl97HrxhXB864fa1tvvwT2ZR5HmhlDHRHpBp81zPOTj1TbtSr
         ylKBMPoK/KTMR5LFb1wGHk8/KjEPxgXroSdZRp9kzpKh7beoHOilIG/0A2hKPmHoyitB
         69JvS3zCrpweGVhb+RHUa6FhBRUMlYwUv1SxBSwi6JIxEWzKDgqztzW70ASnLk3tkdl6
         xG/Ckd9WtnFkaEVsCArQFbUWdvL3JPjP9P3EAQqm4wVAtzKu/HFIdCKjq+qGKloI6buK
         +WkQ==
X-Gm-Message-State: AOJu0Yxymt0jtPV/pJCz2jY8E1BDzBHDOxeBTSkmBoPfDwBVHahIH12d
	TJngTueGIvXeBQ3N62DsEnwyC1HIBvfRX7U3OVjERME7/adKae0z97TBbufZMGu2cNg6ZwCv0Z/
	uYtqOWQ==
X-Received: from pgdh5.prod.google.com ([2002:a05:6a02:5185:b0:c79:7107:a67a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748b:b0:3a2:e0e4:f072
 with SMTP id adf61e73a8af0-3b22ece871emr19015697637.48.1779151372400; Mon, 18
 May 2026 17:42:52 -0700 (PDT)
Date: Mon, 18 May 2026 17:40:48 -0700
In-Reply-To: <20251218232618.2504147-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251218232618.2504147-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <177915043896.2224332.6543465183454014287.b4-ty@google.com>
Subject: Re: [kvm-unit-tests PATCH] x86/cstart: Delete "local" version of
 save_id() to fix x2APIC SMP bug
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Igor Mammedov <imammedo@redhat.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 18 Dec 2025 15:26:18 -0800, Sean Christopherson wrote:
> Delete cstart.S's version of save_id() to play nice with 32-bit SMP tests
> on CPUs that support x2APIC.  The local version assumes xAPIC mode and so
> depending on the underlying "hardware" (e.g. AVIC vs. APICv vs. emulated,
> and with or without KVM_X86_QUIRK_LAPIC_MMIO_HOLE), may mark the wrong CPU
> as being online.
> 
> 
> [...]

Applied to kvm-x86 next, thanks!

[1/1] x86/cstart: Delete "local" version of save_id() to fix x2APIC SMP bug
      https://github.com/kvm-x86/kvm-unit-tests/commit/d0052ffe48da

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
