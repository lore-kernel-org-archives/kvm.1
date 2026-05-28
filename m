Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECF13E63BB
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973427; cv=none; b=Uw1/QH7T6AR3QnVWUzv6Ln8CnZXmMKTaNX8odZufL54OxwRiRIYGpifSYAUdKAgLkn3uwdu+QtywTu5czBcNqxzAOg//C9I5vOrJl7yfXV3O0Kgq3OmSZr54pDBCCsKPxXX0iuQv2LSq6BW2iw2s0gxsfJnwSG0EdiNlL5ngjfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973427; c=relaxed/simple;
	bh=52Xo0LsgsP411aojMAqPYRJROcqDRxDLrDzGWO9Ks/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gHwDHL7xrNJP3k6iRQGS+Vsxrn4p2j4LSFMFACQuHmoWi81QVJO3Uw6+5BiGAuzcPuwEECqLIKiEppJqavU0b7upSrelbs8LovoeLouk7hXqwMhT8OoAQnrqZTbjskYotrq6F3qrpTixrxfcfs61VUDf9boc6AGb/qL+CDDfY2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JThX/zuC; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JThX/zuC"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c81086bf930so8460213a12.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 06:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779973425; x=1780578225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7wsv1/raNLhutjN+sKiK1ZJvmuMahn/APbpaz4qf4t8=;
        b=JThX/zuCCT1hh6FeGjiE5U7jqmwb7MOnHVHGK16T4/VahSIIb5IuGZTkNr+bk7F+bQ
         wS8JKbqy6XC0kX57eSJ4fnth9G5wg659v5LFaAFNb+JF2xrMBu4XgueFGtOH4uqR/9hK
         QB8It5wV9X4F2uKzDt8t8lZ8GD8hGbf+OZVw+sYoQO313rvXMH6f4vrVaSkmi2HzH6gz
         87ekGE8w1nRbM8nTxP88PZk8MdlbBscwQC8ShdSn26rsTyj+xxZ6Ochy5YZWOBmX60Nt
         bswRtYoZaEUeM6XN4YfN6qRtOmo3zgSMnVFhaihk7joNR8i4Q01AW7etJvNlcC2E8UNB
         2Yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779973425; x=1780578225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wsv1/raNLhutjN+sKiK1ZJvmuMahn/APbpaz4qf4t8=;
        b=WoXg2C7Ikd8ggqT/4obF4aVUGoosbSUY2POQ42c+FZTdKC6Xdv1R2Slg1RP22EbRYN
         OfFiR7qfeZ7SaGTCIhixwusSFduTRBw6OMmu8wLC1PBah1mx4e3dsqNWFhvKKan14c+o
         r5lQsBnh6S1PGZ6BA6NgEUXR7bP6xGh+ZuNjYpG3pSURN/zejVWAJ79Vb/h/Xz8ygjvT
         yKOTjDKAD/VW+ED8Um62VqYHLcAY0Ibihoh5Z7qixQct/diDmBThvlv9mLCm3j4ZsnTh
         /z/jXDyf/RLYWudsCsEpLI5E/NzBtOzFvRz8j53jeHYPCCzzu9snPmDbuPoT8GjZ9re2
         kc4A==
X-Forwarded-Encrypted: i=1; AFNElJ9/ZqsKcTMEHAXAfcL6TnOgf0abPiXanX81qyRHrElQFBrgw2cQeGpRV9RAR76w0jFTh7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDPofxJfy2eujy5XtptFnmQDdxqiy7HVa+4GpKRujLDOIMjP2M
	MQEo4GuPzsQKsPq0OLOfFxz8mJwEDNowCPTJDrZ90z5x/+e4yjAj0JOKfziwnwprHeOnVRksh4O
	5uglaRA==
X-Received: from pgbcz5.prod.google.com ([2002:a05:6a02:2305:b0:c74:42:899a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:68e:b0:398:76d4:c7e9
 with SMTP id adf61e73a8af0-3b3feff493cmr1504891637.35.1779973425208; Thu, 28
 May 2026 06:03:45 -0700 (PDT)
Date: Thu, 28 May 2026 06:03:43 -0700
In-Reply-To: <20260528080856.10141-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528080856.10141-1-yan.y.zhao@intel.com>
Message-ID: <ahg9L2F4bA_8lXFI@google.com>
Subject: Re: [PATCH v3 00/15] TDX MMU refactors
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, rick.p.edgecombe@intel.com, 
	kas@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	dave.hansen@intel.com, kai.huang@intel.com, binbin.wu@linux.intel.com, 
	xiaoyao.li@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, May 28, 2026, Yan Zhao wrote:
> This is v3 of the TDX MMU refactor series, a simple rebase of v2 [2] to
> kvm-x86-next-2026.05.26 plus addressing a trace issue reported by Sashiko
> [7].
> 
> The code is also available at [3]. (Note: due to the instability of
> v7.1.0-rc2, I also applied series [4] and [5] in [3] to pass CI.)
> 
> As in v2, patches 9 and 15 still have the "Not-yet-Signed-off-by" tag.

Gah, sorry, I told Rick I couldn't get v2 applied and needed a v3, then realized
it was largely a PEBKAC issue and got it all sorted out.  v2 is already in
kvm-x86/mmu, assuming no one and nothing complains in the next few hours, I'll
get "thanks" sent out later today.
