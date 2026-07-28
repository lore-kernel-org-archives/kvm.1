Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140844C50C
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785265896; cv=none; b=i7QOYCc5IA37FF1OtZpG6AB+7BUoxw4ksFEDFkYvbkdZxwBfRcp00Xw08q8jEdFaA4IiOJCbkv1urQJeQq1PiXjBsagkRevlZ+bh8+UNu/CSbivuuEF9tebkuN2VWjKOYmaHF9XoHLQmZ9uuOUZMTyVxLaepz+UA0WK+EiDljtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785265896; c=relaxed/simple;
	bh=N3ZrdsGwfEzhZbFy0qfF5O21GAEDFFBE9xNlzK9q2uo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G2K8xUUNN6DKnCPNbtxiU+JZuOS4wyjhAy93s1H7AE8Mb6Ems48ahhi8RGEJ5m/EzMpG8AJSfTqGGyv7MdlXrW48QuH4NqQ+ddY3tIqFuQLRDc0T2dxwt7W7Ahc5R5YUxLfvvHJmbOvdGF/KmaKhvbHQlouCDKRXUGKRjraM2kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AnwnfhoL; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AnwnfhoL"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8482b95574dso204821b3a.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785265894; x=1785870694; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLX45j8vCen4k6YfFS7OwZXepDZJojOyGTgLYSQeZ3M=;
        b=AnwnfhoLwzaNDgfeev3N3WZFIr0kzXan2dVOYet0/qItvdEu3u3eO0kiRQBi7x9reg
         s5NXeR0y0k0uW7z67uehTq1HMPQnxNn2up9QSkDMBclern/kc9jjhOAAtewBOvgfHFor
         zdxnBnVtQN6pSRjAV//5Ifzqe36XN5B+gXwGSEQ3zXyUgJYzt8dg3qfKBB1mQSp66Yok
         elNBtQ/3QznDffKChYqeo/9b3XOPXOxnkyHR596BzSGh/2XFr89GAjaZ80cfAsPEeGNd
         QTTJYvqxDrMIMGwFF1u2pkzNqXIBSpg5IDnwsGk+S7+k9wiDcavffH/2oYr2U09y/q4c
         I7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785265894; x=1785870694;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oLX45j8vCen4k6YfFS7OwZXepDZJojOyGTgLYSQeZ3M=;
        b=Y86bqQaAx97pwu7GOYg0WAqi3kCW8sjvC/wO17NpHkZuC8uApp8dfxZFH0Qj37rwl1
         kYlTBJWK3r2MzFQI0fmc2xoxh750+kBy/69obEqVklXMzbMHy5wi7bMSKTO9jlC+wLle
         DVZc9GKzR22qVZX8Fe3Pyyu34pkW/UmdQTkUqA6h/FWOjwczduUGdG0JXe0ov8/hRYl/
         0yJhigzdaRB+IZ+KBE30dxzGUY+BcEtVZTDWKpbOGcvs+a0vz4euW00v23m1xRj6uaZ/
         ApbqUGwTftTcNQNR1hko3VduX4IAdml79j5y/mcwB1U5ZU4ZyKHCxOCweq8o2hx1GW5D
         BdUA==
X-Forwarded-Encrypted: i=1; AHgh+RpqIMwW2ruhvnmPo1OdUnGRbRzDqTZdF0oZ4USuGHRbG84JW967lrOImH9MmWdXVi8xZe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/n0/rPbN1isFS23VOv8cK96OMCtO5Sbnqtq6NfVtI5/DKMp/i
	JjIDRIdwJReRDTgOfFq9hk/2X1j5iKyd9FpClSizpxiPeO2rBtUn6mMGozEx1k8UNFvn3cP+6r3
	mZmWdYg==
X-Received: from pfcp16.prod.google.com ([2002:a05:6a00:a250:b0:82f:d8c0:fef8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d10:b0:848:2ae4:d2ba
 with SMTP id d2e1a72fcca58-84e932501c9mr3837381b3a.28.1785265893891; Tue, 28
 Jul 2026 12:11:33 -0700 (PDT)
Date: Tue, 28 Jul 2026 12:11:33 -0700
In-Reply-To: <20260707183405.15571-3-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707183405.15571-1-zide.chen@intel.com> <20260707183405.15571-3-zide.chen@intel.com>
Message-ID: <amj-5YH-LSwZOLow@google.com>
Subject: Re: [PATCH 02/15] KVM: x86/pmu: Rename all_valid_pmc_idx to all_valid_pmc_mask
From: Sean Christopherson <seanjc@google.com>
To: Zide Chen <zide.chen@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 07, 2026, Zide Chen wrote:
> all_valid_pmc_idx is a bitmap of valid PMC indices, not an index
> itself; rename it to all_valid_pmc_mask to better reflect what it
> holds.

How about "pmc_exists"?  All the other bitmaps start with pmc_ and describe when
the bit is set for the PMC.

	DECLARE_BITMAP(pmc_in_use, X86_PMC_IDX_MAX);
	DECLARE_BITMAP(pmc_counting_instructions, X86_PMC_IDX_MAX);
	DECLARE_BITMAP(pmc_counting_branches, X86_PMC_IDX_MAX);
	DECLARE_BITMAP(pmc_has_mode_specific_enables, X86_PMC_IDX_MAX);
