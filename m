Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2001B304BA3
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782171033; cv=none; b=q83aJjm1aJNL3+QLq8YB7BFexIXu/dvkguA+Nbm+PfashtlKIesTSzfcvxNphJgpkD+xheVxOpKdnAP8k6EfkBft8vPFxmhZa+ulYU5WzSFv7He88L/0p8jymq+8ivgs9BEa7umQx8cS/OTAJ6QtpMFd7EjsZBjtefU76QDPOEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782171033; c=relaxed/simple;
	bh=Id55ZmT3Ny8JY/8w5j8U96LeMpdqCvG/wazyNv7Ousw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7O2focYZ8n/6XEctLITFuKemFuGXV1e3bW5sm/3XycC3clYtiNuv0lBuZbGhgb6w97QwBFAW2pwPzuvT+pAZobTsYgrgceClISjEYcI1UprYDMFqJ0PBDKqJFhmEu4Oa74gUVwybFIA60jlLinJ0OhVDWK9oyFgIKoMSxnI8KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SW8nfISA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SW8nfISA"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c6b7bd4e8dso18485ad.0
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 16:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782171031; x=1782775831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BLj+HmvLjzLOHpEqRh1wn6kUXzQVKOV8V8gw6F5PDGc=;
        b=SW8nfISAxoOdjm87HlyqZwVjj8AgpbEAmK+Pj0x+fetXxj3wT9j+FUbu5cpxDCTCfJ
         3G6z+lrOn2I61hjq7qV6RKsIg9q3aAeAF6R5ItR1A9fWIfLjz/WcDLyHuU1Og9aD+jMO
         3r8+0mW2BWHxx6LZri+RAkglP3zRXCt80vLItDik5WVBL/DUDGuuI8dEpZS45p/CyZtF
         ZdmvAtpKM1GjB8qQxFXcijxxfFDEQe8khTq3+bYXAHxTXOq0DtJ/EV8hxUYR2LvEY7sD
         Lw7c91jH8Kp2gFchz0RWMpwslPkbbDMBQXE1RcggqfH/IO8Knn4IiG0N3s0F/G+VxXcE
         QmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782171031; x=1782775831;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BLj+HmvLjzLOHpEqRh1wn6kUXzQVKOV8V8gw6F5PDGc=;
        b=cHfNSZuMYwBzd+X9vM32X5Xc3axsdteQ6Q7kVrxqNfkLoMe9FR5yJx9DfSrH2VaAuJ
         2Mjglv3b8pfZ7WpnS7p2+6JyZC2n0hEpYgLjSedH4SjXHi7m/pmc7ew1c3woi1kGtA7r
         hXcBQYya3utjFamN9onNjl65/Qj/CwNMTa0HSLjbjyT3KMbm/4ewtCqUTgQqYGozrS0y
         zVOpwJf7zpYPAJ9cnKbwBs9mYYZ5b3Q5Hb8o8G5n1jRG+yq+HhL6p9HLIwKogS6aoAG3
         KmG9TKQFmbvwxLoWsex/XvVDZEDyfWZyuF+JtZEebOLUw4cGnb78txpsQadpqQtzfL3/
         HpUA==
X-Forwarded-Encrypted: i=1; AHgh+RoayzflPPgRlrrTm7JSZqFNUy5Ccr4dYIVnTCn22O/PYb+q3/7OYAXnqEK9cw6S+Z2XyMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2WgzpgxbWifuJzy7bH5LnL65AHgj6Gaylwb+fuHCp6MbpZFuq
	dYBS1BrrOAUzM1HmJeAY1G16bS3oOGZkG8swGxUu7xYtEAbvTMhVIWjRA6Cv8ElhIg==
X-Gm-Gg: AfdE7cnE0TBApR/+UXzHMkDCWkAiZJaQtabklqDid3XyllXTzSMYySeyTJwnWa1VEaR
	OeSw+vF6qMw1sunu3QOVnO/bZPCv2kjAiMa/a3Zi7coJ2zTw9M6/qV90Nivdp+UhxxykLLD6jVf
	ALPWxZHm3lF2Za/U7WWYFkAMeEU1n6I3U4FS2ltQGDwXa8KlNszk4rEgvTkRw236prAdoNBojCU
	GbFGsXn/UR+CyXQXQFMzQL6bkeyT3iMRMFa3uY4tR+tjnkMZXhHT/qRegOwYJtgqvN7xKgFVt14
	7R4uT8il3bQyECS43BEuHU6KjON85az1aH92SbjS7i/hs/InmNRvBRHBaG0mEAP7xsnckkSUR6a
	gtTh4jWxiQADaeHXOJq04iqvien8W4cNPaiRbcM7CgNqvfp4lbP+Dc1VaxmT017jjtq2kRQx583
	C6MM6aT3lFrO10b2b2Fk4CsBncz0rj/HlzSJBJtiMcNlCQb6xk4nIiKL1grb1wU5JNoF7B3eMBH
	pdo1S/T
X-Received: by 2002:a17:902:ec88:b0:2c1:ee6e:4e4e with SMTP id d9443c01a7336-2c7c713f231mr649335ad.31.1782171030705;
        Mon, 22 Jun 2026 16:30:30 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1aa087e9sm2638998a91.2.2026.06.22.16.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 16:30:30 -0700 (PDT)
Date: Mon, 22 Jun 2026 23:30:26 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v3 10/18] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
Message-ID: <ajnFOZuL2WXrZCLd@google.com>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-11-skhawaja@google.com>
 <23d4a3b9-41ac-4e05-ada6-01b6ae5e9f04@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <23d4a3b9-41ac-4e05-ada6-01b6ae5e9f04@linux.intel.com>

On Mon, Jun 22, 2026 at 01:14:48PM +0800, Baolu Lu wrote:
>On 6/15/26 07:37, Samiullah Khawaja wrote:
>>During boot fetch the preserved state of IOMMU unit and if found then
>>restore the state.
>>
>>- Reuse the root_table that was preserved in the previous kernel.
>>- Reclaim the domain ids of the preserved domains for each preserved
>>   devices so these are not acquired by another domain.
>>
>>Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      | 87 +++++++++++++++++++++++---------
>>  drivers/iommu/intel/iommu.h      |  7 +++
>>  drivers/iommu/intel/liveupdate.c | 60 ++++++++++++++++++++++
>>  3 files changed, 130 insertions(+), 24 deletions(-)
>>
>>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>index 26258861e3bf..cd40e274482b 100644
>>--- a/drivers/iommu/intel/iommu.c
>>+++ b/drivers/iommu/intel/iommu.c
>>@@ -990,15 +990,16 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
>>  		iommu_disable_translation(iommu);
>>  }
>>-static void free_dmar_iommu(struct intel_iommu *iommu)
>>+static void free_dmar_iommu(struct intel_iommu *iommu, struct iommu_hw_ser *iommu_ser)
>>  {
>>  	if (iommu->copied_tables) {
>>  		bitmap_free(iommu->copied_tables);
>>  		iommu->copied_tables = NULL;
>>  	}
>>-	/* free context mapping */
>>-	free_context_table(iommu);
>>+	/* free context mapping if there is no serialized state. */
>>+	if (!iommu_ser)
>>+		free_context_table(iommu);
>>  	if (ecap_prs(iommu->ecap))
>>  		intel_iommu_finish_prq(iommu);
>
>disable_dmar_iommu() and free_dmar_iommu() are always paired in the
>code. How about merging them into a single helper that is aware of iommu
>preservation? Something like the following?
>
>static void release_dmar_iommu(struct intel_iommu *iommu)
>{
>        struct iommu_hw_ser *iommu_ser =
>                        iommu_get_preserved_data(iommu->reg_phys, 
>IOMMU_INTEL);
>
>        /*
>         * All iommu domains must have been detached from the devices,
>         * hence there should be no domain IDs in use.
>         */
>        if (WARN_ON(!ida_is_empty(&iommu->domain_ida)))
>                return;
>
>        if ((iommu->gcmd & DMA_GCMD_TE) && !iommu_ser)
>                iommu_disable_translation(iommu);
>
>        if (iommu->copied_tables) {
>                bitmap_free(iommu->copied_tables);
>                iommu->copied_tables = NULL;
>        }
>
>        /* free context mapping if there is no serialized state. */
>        if (!iommu_ser)
>                free_context_table(iommu);
>
>        if (ecap_prs(iommu->ecap))
>                intel_iommu_finish_prq(iommu);
>}

This looks great. I will update this in v4.
>
>Thanks,
>baolu
>

Thanks,
Sami
