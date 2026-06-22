Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F275F3090DE
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 23:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782169463; cv=none; b=Nz+ELGhmQtx+zZSZpSDYMc2d6Ho89mtfwCCKHvjb4XYN/weUU6OZTT7qw4P7fWvmytwWElfCNCcJuS9qBjqjNWiCu8EBoLeNLZxvn8Vt4emW2A2pzZXmR1HGSaruXsEXqDakuvegAUm/UFbfizd5sS/AlPcLKMNPfHa77DGHSoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782169463; c=relaxed/simple;
	bh=Jmd4nVp4kfTrvTVEijkTHHv51r48Mo7H+ZvtGBWl2O0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p8RX+kqrLDnS+ANtHH2VLTbxJQKnAMAf+iJLy2g9IzyGw7FRXG/qHdoR63tXr9mhD21NutrQ/z659sZJ1+m5IDlUAKPrx35uxFPI+EWq3n0OmvRuMg/JuhcjOH921glnS1IQKpF3xd0aINAWJRs6UDoKbr6p76BFdJmlrJ9fJA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hM2T6UMu; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hM2T6UMu"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c725d3e886so63717175ad.0
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 16:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782169461; x=1782774261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DbguCPrep9cl5dKCDjv+7UBnuf7b6qWOrC/gr5Xvvj8=;
        b=hM2T6UMuho37ng1/rWpqebDHst9a5fLryKsERU4XYe/gjNXgENoyxPLd6i2Hyk4coN
         dBKmfmTDxh+urr1pEM8p/B0axYoqaK4vsui2zNm2H1YCABrhOld/SweyM9/pvCmvMVqo
         VfWrTMRFH+TunaDzd9v1+Ujtbo8u7ph4eh9klbv9fBklTvu1hEgerSmPWDfWjT8p9bpl
         whelWeO4HJhEsMkowwj2yMUkbj9rC4cepbLqzXy+Ui99EMP5hJeVo3d3iWI15l9V4zWw
         SU68PuWN78lH+BBDHtw9akKKNbCDl0pI8a77R8M4dm6CO2MNZXXT+rnFMzKDdpXuqgDs
         vfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782169461; x=1782774261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbguCPrep9cl5dKCDjv+7UBnuf7b6qWOrC/gr5Xvvj8=;
        b=DBj09tvFwkYO0yhhzMnT7y63uj3hgcDJRprEF1qD5jRXdLu979xOkiV3gjU+eTxFST
         uonIRRw8ihiEhmSSsD3rCaTIFwv2gICJLJjchX9phN3igpoaCZQLpJho2QB0JSCZjIqD
         qFPWCSMtPv8GSmP/YIG+IGSgzLbjoJqd2gzYF721kg9qyvKPUhAaElPmuqffSv5rKP/r
         YB9CqeQ6dT3blqExEmnrSUmo7wK1mJWzbjIV4dnD81vlP+umWjH4EBw/d9GM1aHdpGX3
         0J2epd/1gCptyZrP4PG1Jw/fgsJH3w5fyNrJOM9DzqZLETB/mJ1J8hXJ0FTBfr6ujZUN
         U3xg==
X-Forwarded-Encrypted: i=1; AHgh+Rr9ZeizfqdF3J1udi27VyPItJfROP0g1t6nIcDS8Dg0R7DNR0ActmzXgC8xN/lStz/JGRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK9y3GM3KqO860Qlu3TkAAg6VpWL07C89MhsLnzQjrI1F3tTvC
	XuUdcpXhYRIn5kSQA/9grWz90EvgbwCvNwwaHvxWyCMs5/K/Km12sxSGJwk7RPOnpbwxnzCcHdG
	oaq21+A==
X-Received: from plpm7.prod.google.com ([2002:a17:903:3de7:b0:2c6:9f4f:f3b8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8cd:b0:2b4:656b:aeb0
 with SMTP id d9443c01a7336-2c718f67cfbmr186053355ad.35.1782169460861; Mon, 22
 Jun 2026 16:04:20 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:04:20 -0700
In-Reply-To: <DJFI4P57YE9X.20DPMTK9LL7LW@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-6-31f31367d420@google.com> <20260622101056.4120C1F000E9@smtp.kernel.org>
 <DJFI4P57YE9X.20DPMTK9LL7LW@linux.dev>
Message-ID: <ajm_dEqauYLBi-7T@google.com>
Subject: Re: [PATCH v2 06/13] KVM: VMX: Use higher-level allocator
From: Sean Christopherson <seanjc@google.com>
To: Brendan Jackman <brendan.jackman@linux.dev>
Cc: sashiko-reviews@lists.linux.dev, Brendan Jackman <jackmanb@google.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 22, 2026, Brendan Jackman wrote:
> On Mon Jun 22, 2026 at 10:10 AM UTC, sashiko-bot wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] The commit message incorrectly states that `__alloc_pages_node()` allows passing `NUMA_NO_NODE`, while the opposite is true.
> > --
> >
> > commit 7bd439c242125db27305b61b14c9972fb028282a
> > Author: Brendan Jackman <jackmanb@google.com>
> >
> > KVM: VMX: Use higher-level allocator

While you're dealing with nits, can you massage the shortlog to something like:

  KVM: VMX: Use no-underscores API when allocating pages for a specific NUMA node

"Use higher-level allocator" is extremely vague, and arguably misleading because
the "allocator" being used isn't changing.  Which is kinda the point: *nothing*
is changing in practice.
