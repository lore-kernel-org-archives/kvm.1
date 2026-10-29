Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793311269;
	b=tdnYcgA7jUSjGYmLRov2Aua3Ed9ArEI/vJw/mOGUtR14Zll/D+gObafzaFcD5VINLFa6
	 x8qvFerA29UK4ui6XLlCv/wHKHyL5hJq9W3VIx0rfhJIts0dnwPIHDyrCuOOAdUrRhbti
	 znJSWXa+QyneQmJFG0J29U46XXKbLjFayoSyR8UTZiV3R21BL4D+g2xS6rPZE2ZxLfnR+
	 V2L4cmkHPA0jwpE6+r4H8xQbYa2eVZib5WRc5pZAlC5OZ5iwwIsoVOBWZwKNB2XJGqCyH
	 Kom5ozW+mBC40FPCWoqMBgqq4W6iYbMBiB8LqJcCsMx+RsPFJT+2y1MdrgwwWz68l7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=i+Wj9No24ZIzSMb91s5eR7ARJ45VgEQSQYILDa8r2Ls=;
	b=qHSiLBFdEHlv14IOP6t/bGOYxi4SCXwHouOP5adLE+Fm/FfkQmPFEhGLCh1pEKdWDY8v
	 AqyOL9LX8yXcFqkXeUBkyEjA1oyT68ehKvtLNhdIvgbstMAkXMsYmiejLI3egvl6eBxWI
	 pvL9RsUfszyUvJB3eUkwlpZjGnzI1kqownAotVZPs7BX2S1cBaiCIlfPG6P2rNaOXB33O
	 VeLYTatt+5dlWfGLmLJXhiI1c9EAXD1o1rIbAms0/AE0Wl5xRIeoJP0GLfPkn5Zo08IzM
	 wehs1qnbGHhygWxL6fpefk2ffxtpKZhK162dD8/nnS9RcDh6vtV9Lxt3oow/OrLGinQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k1eJoYKz;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D642A606A31D
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 22:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D642A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k1eJoYKz
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ea7f9c11e6so26135ad.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 15:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793311268; x=1793916068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i+Wj9No24ZIzSMb91s5eR7ARJ45VgEQSQYILDa8r2Ls=;
        b=k1eJoYKzIXh1DdeuC+lIzguVMMOtZhzu5/GIvst1fFcjG92N19fD7h4lrgsQPWBFG4
         oYnnpxlRcTv+AqNBMm48jKU/wN894JsRuNxjxfW14FGhJUP4ab76rRbtSCyE39WdMAT+
         bMU/GmkT/PyGcBnwHlfOVihPJ9YoTH98C+L4Pq1kyOhr0Wd7NoOqAmCDtb0AspWHeNMJ
         uID+JjnU5xoICee0uRZZPvZ48WfFuTtxRVDxKBdAoMq1UVOWA2djEkw8rtTCdZUfuBZ2
         AQWuZkYf+qB80og00gQ2IMaVeeKYHzGKthlW/pGCN2f8iWqSJsk1XPEDNHCoFM60yxVS
         ABNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311268; x=1793916068;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i+Wj9No24ZIzSMb91s5eR7ARJ45VgEQSQYILDa8r2Ls=;
        b=QLlkziz7Vg43pkdyHBAYREnQcjf3CKRtfEzI7UCh6IzjI40eg2aMpdzdqi67ttDyWc
         86zm77YgqwEnEbnOzFqceKrcYjulpn2vdeo9IcHKvuQ7YW8jNiT7bCxT2NGL7vQQ6BSX
         0oZ0faP2D/uT/q12XuMX0QN6imzqndgvWCqrh56GFuo1SAqknXNdNzMByaAdZFmJu/24
         BcNy3s/9jGjLZnYuWdqz1BGKI30B4BfKLgtMPudgcxHV9R9tSD/2haqq+/ee86pBrmCm
         jbwG93xyPrZUy1m4zFyuFj4LlXfuf63GfntVDLvZjZPOrAsnZWz3VzJVXGl7T7lbvOsS
         26tA==
X-Forwarded-Encrypted: i=1; AKwUvBxiIkouZz/UkuCGXmYp9sm08Mv4+TJzrXYgrh+ekRag9YqTAG2xJW5FJ+G09Qw9ITIY3Z8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7fw0M+h8q5J/0XDdUMYa9eWIUn+5zUrfu4F4tNtDqsOdqNgp+
	NO4duvktC/+p62QwUHENWOI6v1AMfde6dKDYlJbQbjdqhXJm+0ehQsuKn9xR+dBI9w==
X-Gm-Gg: AYBFou1FAsmSSP+COKGESvMU0wcaSsqjFjnlP+OtNXSDMK6NX+g+RNFzXEyfCLHnI2/
	DE8aQSWq1clqzzhYlZlbVPnhDPP3TSS7eGkdZ3zbMJ5haBKDzBRsyY/A+Llstu0Od7fW6FwXK9A
	pcKgpP9+oGJjU41D6TBtLg55VnRtepNxUG1BpEwNkqwZD8fxURng91xHTN5j/SuB6OzS+T9Fv93
	YYNStQSr3CDge//7XdRwC77U8ycg7phAk4kP8C+nqeWG1RulDLGbWNCNycPjFfjrYhqM/kiKGuy
	Ryg7CmQDzfaoLpxZGlGo7sb6x+yte2+5YQ+ejELngJdax1qPcR0Yc8QHA94bpFD/wQQNYNoxenb
	1U5RD1ltU7sG0H23Flt/rER+OxeGpncbDxpfmajQ/51fD0Xho6NPJe8tmv7vQv2sRp8wbLaPwdu
	S3XKtxWd6ANPoO1QXfxwMaOv0yWQ7BkQezmBiLnNPE5oC6Smv0Ilh5G1pNF5uLkQnlsi2cCxFP2
	qPo2Fbvt0QzsAIvS4BovngbFkkzCKdtiUGXlLQe6arc+L2FyHc/F+vUGNgctHhtfBLJt2ArSeza
	7znP3hirqJd/sWXa9dFckMU+xk2V/vc3n2ULinHWdwWbWgEgSCmWCDRFMxmuHfuSZHbsIVVe8ki
	ldtvHKMkTvmd7ZkNNQ1ljLA==
X-Received: by 2002:a17:902:d2ce:b0:2eb:188a:1c06 with SMTP id d9443c01a7336-2eb1ec12e12mr6703785ad.9.1793311267514;
        Thu, 29 Oct 2026 15:01:07 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3694c6aasm1096605ad.51.2026.10.29.15.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:00:36 -0700 (PDT)
Date: Thu, 29 Oct 2026 22:00:32 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 07/18] iommu/vt-d: Clear unpreserved context entries
 during shutdown
Message-ID: <auOtrI8lFrfwdkB3@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-8-skhawaja@google.com>
 <5e0be0cd-c2ae-4488-b95f-b04b8315a1ed@linux.intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5e0be0cd-c2ae-4488-b95f-b04b8315a1ed@linux.intel.com>

On Thu, Oct 29, 2026 at 11:18:02AM +0800, Baolu Lu wrote:
>On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
>>During normal shutdown the iommu translation is disabled. Since the root
>>table is preserved during live update, it needs to be cleaned up and the
>>context entries of the unpreserved devices and root entries for the
>>unpreserved context tables need to be cleared.
>>
>>This is required because during kexec reboot and shutdown the devices do
>>not go through the release flow, so there might be stale entries in the
>>root table and context tables. Also note that new unpreserved context
>>tables for unpreserved devices might have been added after preservation,
>>so the root table entries for unpreserved context tables also need to
>>removed.
>>
>>Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      |  15 +++-
>>  drivers/iommu/intel/iommu.h      |   5 ++
>>  drivers/iommu/intel/liveupdate.c | 134 +++++++++++++++++++++++++++++++
>>  3 files changed, 152 insertions(+), 2 deletions(-)
>>
>>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>index 14bd1ca4fbd5..23a1da351ddf 100644
>>--- a/drivers/iommu/intel/iommu.c
>>+++ b/drivers/iommu/intel/iommu.c
>>@@ -1967,6 +1967,14 @@ static int iommu_suspend(void *data)
>>  	iommu_flush_all();
>>+	/*
>>+	 * Note that IOMMU suspend doesn't affect live update. The state
>>+	 * preserved during live update is not released and remains valid during
>>+	 * suspend and reused during IOMMU resume.
>>+	 *
>>+	 * Also note deployment of suspend/resume and live updated use case
>>+	 * should be mostly mutually exclusive.
>>+	 */
>>  	for_each_active_iommu(iommu, drhd) {
>>  		iommu_disable_translation(iommu);
>>@@ -2512,8 +2520,11 @@ void intel_iommu_shutdown(void)
>>  		/* Disable PMRs explicitly here. */
>>  		iommu_disable_protect_mem_regions(iommu);
>>-		/* Make sure the IOMMUs are switched off */
>>-		iommu_disable_translation(iommu);
>>+		/* Make sure the IOMMUs are switched off if not preserved. */
>>+		if (iommu_preserved_state(&iommu->iommu))
>>+			clear_unpreserved_context_entries(iommu);
>>+		else
>>+			iommu_disable_translation(iommu);
>>  	}
>>  }
>
>When I revisit this, perhaps we have overlooked something.
>
>After intel_iommu_shutdown() in the previous kernel, the memory for the
>Invalidation Queue, the memory for the PRQ, and the interrupt vector for
>the DMAR fault are all freed. However, the hardware is still configured
>with those resources. This potentially results in use-after-free bugs.
>So my understanding is that while we can preserve the translation state
>in intel_iommu_shutdown(), QI, PRQ, and fault handling should be
>disabled and their resources should be released.

Agreed. I will disable QI and mask the fault and page request interrupts
for the preserved IOMMUs in the next revision.

For PRQ, there is no way to disable it at the IOMMU level while
translation is enabled. But PRE is already disabled for the devices on
the preserved IOMMU, so we should not get any page requests.

>
>In a normal kexec, DMA translation is disabled, thus all resources
>configured to the hardware are released. However, this is not the case
>for the live update scenario.
>
>Thanks,
>baolu

Thanks,
Sami
