Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADEC4519B6
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790980098; cv=none; b=krTM1Ly7RPb10fYzZQDGkw8MIrJU1JDM2dVsqdPaOe5qTOOTwow7gX4h6LSYvwZBEOOj11v5DfwMXK87NVNnl3arvAgMyP84QFLAC3S3orCmoNiyO9vKi7yxX8Flkb8X3w1dCoHlEuCrYGzx7JbXPw5/5/gOtUpn0MSqFovSeB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790980098; c=relaxed/simple;
	bh=viZVgZTEOWBDWo0bJxuaEJyH1pxng8uJPGmDGrWWCXk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SD09rt80gIqISzXJk+emsZBQSWWTY3X0dNCSOTBCYnra0rTrRirONRnIY0o4+KNDielAp8Z6uLXSebz/DlNK/+0AqGybRYTMqcY/9Lh7qjBC4DgR+WxxjRnL5A5CfL3SBmO9YrzkY1Sa0L00VRo3gW98XVqqNt4MCPMdUTJ1HKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wMreCSeY; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wMreCSeY"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so58196a91.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 15:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790980096; x=1791584896; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cEXwvHyHYypv1TjIMTLjauYp2kWmUbEs4O5rr+p48c=;
        b=wMreCSeYPjL8f6twIufOEruV7I0Q7H0kmxFqN3arecpg90CUJR/ZFAtkmHglEod34N
         4UZwwVyRcC3H8CIuWvT6Kc6kaHbVSY4VeNPLM5WJ03tvWYqzPAHNHDxgFx2n7Ulf6i5/
         lHeOlQ5lbk/zDPhcTQ7NDYDL+tNP1XMm+fWy2/hUYwJ/GQdDNQ/lvk7XsDIZjZADDplA
         DMooCqGDnFuQVfyjWckMM1FXLLOIpkveOMJwhA8MRIDqZH7fRLChd4i+gwl4ZHtjF+t8
         Ml4LvUp27XgDNx5LOpA1es0knr2fo2IrC5/kC2WW1LlMzLtVk2hldCikI6ME9uRqWHgd
         plZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790980096; x=1791584896;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6cEXwvHyHYypv1TjIMTLjauYp2kWmUbEs4O5rr+p48c=;
        b=vW2ktMwhVAEHk6+M6GKyYR632kK4KhSlj1hTGxQiU+gwkdXi7KDxWehrvOUoGoQVyG
         B5Y9QlGyDYT6zLCf7qvtk7a8ScrQ+ENbiIzi6QYSFuRDkbLtVPhBxBvsP0Cc4YZMslf2
         hU4VKgXqtFy+nEnS3Qqa+QjJHYIN8E0skzf3brLF17EGg/fvhYNUobFQHDXPRfEGhVm/
         8u5eFNsZP63MCKlfk6Wydw+zeKbpWfOxY4lkwV3uHjwEa+j9vq/E5NAnV7W1rcMyLaPz
         hsipHMA9ULAk36BPZSekQqZLbUBlwYS03XO1/LGKSRNrJX99pcEuMlxACSd/3wcukP3S
         8NtA==
X-Gm-Message-State: AFq9FYJNhCaINfs3op2/dYWTSCUl7hazrG/Mk8ro9337g24jY9z9Nq0A
	6y1LMEYLCh32gBHmmUlaRzK7RZiziRCt6Yd88t1xNvvkl0BEDJhv/cdSFs2cfNmvc4gPbO3lVN0
	cZ6zaOw==
X-Received: from pjbfr22.prod.google.com ([2002:a17:90a:e2d6:b0:3a0:b207:df5a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f8c:b0:3a4:7730:33dd
 with SMTP id 98e67ed59e1d1-3a78776199bmr395614a91.58.1790980096162; Fri, 02
 Oct 2026 15:28:16 -0700 (PDT)
Date: Fri, 2 Oct 2026 15:28:15 -0700
In-Reply-To: <55452f6b9bd1dc241d0a9a0781fbda1c2850d2ce.1790101179.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790101179.git.ritesh.list@gmail.com> <55452f6b9bd1dc241d0a9a0781fbda1c2850d2ce.1790101179.git.ritesh.list@gmail.com>
Message-ID: <asAv__Gozv6r3QWt@google.com>
Subject: Re: [PATCH v5 9/9] KVM: selftests: Move memslot_perf_test off the
 256M ELF load address
From: Sean Christopherson <seanjc@google.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 22, 2026, Ritesh Harjani (IBM) wrote:
> KVM selftests are built with -fno-PIE/-no-pie so the binary uses fixed
> load addresses.
> On powerpc64, GNU ld default links at 0x10000000 (256M) which is also
> the MEM_GPA, so the identity map trips with the error:
>   PTE already present at level: 4 gva: 0x10000000 pte:0xc00000000002018f
> 
> Put the test slots at 512M instead which is past the ELF.
> e.g. failure w/o this fix:
> 
> ./memslot_perf_test -s 514

This, and any other adjustments/fixes to get common test functional on PPC needs
to land *before* the tests are enabled.
