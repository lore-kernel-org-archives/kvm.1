Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D1637AA7F
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 22:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782169013; cv=none; b=ab7H1s4B61gk1sU6L2rg0FcxSxJtVFmlC6ClO+oQ3wYI1XUIAHiSp2jB6a3XW9PFekqAiDL7E27uLT86DM+rB1/HRw8p+NAb5DJYTauKFbfGqpQ4ocCLW6yGR02nZnGl5VjYu25cH2WAgieEVRnpa+lLSRh3gmPuFVt4XkLRVe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782169013; c=relaxed/simple;
	bh=ohBLg6zklX4DgJ9bSXQSZGhcNkuU9UAPO40x8h/3VwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzYsGS0QbeK+SF1sI5cRmNZf0MapZKbfQ4LsK1iLpCQuKjg0RnC38h2rAJlggfzGY8ykcotdSL51BTffXxh/1rOrk2xjqrgg98D+wgKXm7gHTSCGrqbxz4cgUVTc0ImPmUCIQSBPsbjNGmGKE87ZPfF4IUCdgTLWK841PP0IeaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ORdk/7OD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORdk/7OD"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c73cefe192so8965ad.1
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 15:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782169011; x=1782773811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O/6a4uQH4M/fYcm4KZch0IFgU0DNYbj6+XqTiDv43tU=;
        b=ORdk/7OD6virfHoPzSpIpikWmWptA45y3idYnpJYpjrDFY0e18hvilQKSpWHcSb7Pf
         a1gATysZGRB+t6TW0WHGav3KAPrmSwreqdBumcYhEulyDsM4O2/43arA4nTAEqFjIlma
         f2z6sGIYBM+KPCoVvPO/mD8NW1GazD7v9LnB+EMhbc4VlTCvOMqEU2iPP8KLSgUaf7DZ
         Sixa3CTfoSTbLyQtps6q27/AjKiSodKnrl7PrhLxjLCHu9lFxEUQOGcfXrgz9UcuGhe1
         ScCHaVkNZaFEBou0TQiGOah3xoD2BtwR7gA25sS6LDIs+PQflwhcAI5bz20lYXvh58lc
         asGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782169011; x=1782773811;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O/6a4uQH4M/fYcm4KZch0IFgU0DNYbj6+XqTiDv43tU=;
        b=AZjYK5syg65hziiL/Be9k5VC5Pjeury4sxVzxY1o2r4Th6sjSJEEW3DqueajyZqbX6
         wmMs4+spAl0wZiOCq8Ro9ZAEj7SPRjiG2UwkjSdp5/FCgEE7GaiVdi6XaMd/oKXQ6j9A
         jXx99EZqfsZuetMo0pGU0hjid6b3aUKAHwQrShwsnGJtw3wLB3sviuKiSdbOi2VGDJjS
         TXJrMLqSBosK5a/z1yfGB5ayGRWIri1kUYujmqGM37AiyM04/zlR/AwYPoArMmcmpBE0
         9Fc9C+wMXeSlOIlC0arLgWVClHT7bQpAm5snQjo43NsFs1R7vMsQs4oBbui8p/ncndrN
         0bJQ==
X-Forwarded-Encrypted: i=1; AHgh+RrGNm1wzzMpvbVjyKebN0M3L++zS2IqZUxzIeORfujvkmlxpnlulVOOu2HfewpsBqwc+a4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpfm11E3Ypssol3zSXOAie5nruoCgwDjQJT2/rFuYTNmbFqdq3
	8MtaxXLKP+aShZJOLGZcSyeaU5aNNWKCB3G30AejLfMW5ZcA/kz6sM+C3irmFIGx4Q==
X-Gm-Gg: AfdE7ckEmv9HFgfcih7gCog7INl8rsSWczGCQgzWhgerpMAEIpZUW6gbPtImby5GhZk
	1paY6e0f/DGLoexa1FZDhQ77e1R2Yk6/t8W/mZcCVlkofVX8aE29iLT8jCjMve7AAMrD3IINctL
	r+vn1w+jskwmkWo/vYAljnoHCRFWoWAUBoNi722VesivJRYRSmwAyHEVHNpJsV+Tz2dQHwFPuff
	fD00BZPZOHWVID1EBog/SOkVLGHLAFFQDCBxPS5SoGaTBQ0LgHmt7Yi5SArx56Ru5wLjvGRQlTg
	nAzM60RFthIGuhCy6jmu1DHjhWk/Wj6nEwOaCAMVo9A0qPZGW8VsdYHmD3HRFOVIIZvX+TnVWyO
	KV7+jhW576H4lDsIYYUdvMTyqUYuUV6UmPrOGpW2HSAlIARuAn5FH3OP2uR62JGf7T6RGA1Fkfi
	zw4RJeGyJu88C4WJAGQ1ur7axzZA4JtfM9IXEiPdbm2xYnW8e/Q04lv0PAwDNpjXW/IGjqj06J4
	4yOFb05
X-Received: by 2002:a17:903:98b:b0:2c1:ee6e:be1e with SMTP id d9443c01a7336-2c7c539a5acmr932245ad.28.1782169010638;
        Mon, 22 Jun 2026 15:56:50 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7444aa5f1sm105411885ad.78.2026.06.22.15.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 15:56:49 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:56:46 +0000
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
Subject: Re: [PATCH v3 08/18] iommu/vt-d: clear unpreserved context entries
 during shutdown
Message-ID: <ajmYQFemGb2JD0BF@google.com>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-9-skhawaja@google.com>
 <51e03b42-796c-489c-a0fa-525ed1a492ca@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <51e03b42-796c-489c-a0fa-525ed1a492ca@linux.intel.com>

On Mon, Jun 22, 2026 at 10:47:05AM +0800, Baolu Lu wrote:
>On 6/15/26 07:37, Samiullah Khawaja wrote:
>>During normal shutdown the iommu translation is disabled. Since the root
>>table is preserved during live update, it needs to be cleaned up and the
>>context entries of the unpreserved devices and root entries for the
>>unpreserved context tables need to be cleared.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      |  9 ++--
>>  drivers/iommu/intel/iommu.h      |  6 +++
>>  drivers/iommu/intel/liveupdate.c | 74 ++++++++++++++++++++++++++++++++
>>  3 files changed, 86 insertions(+), 3 deletions(-)
>
>Please tweak the commit title to: "iommu/vt-d: Clear unpreserved..."
>(capitalize "Clear") to match the driver's commit history style.

Agreed. Will do.
>
>A high-level question: have you looked at how the suspend/resume path
>behaves with the iommu and device preservation? DMA translation is
>disabled and re-enabled there. I don't see any immediate changes are
>needed there, but it would be good to call it out explicitly if it was
>overlooked.

I looked into this during early implementation. The preserved state data
structures are not affected by the suspension of the IOMMU, as during
resume it reuses those exact same data structures in RAM. But I have not
tested this since it is unlikely that in the environments where
liveupdate is used, the suspend/resume functionality is also used.

But I plan to simply return -EBUSY from iommu_suspend() if the IOMMU is
currently preserved. This explicitly prevents the two states from
overlapping and avoids any complex edge cases. I'll add that check in
v4.
>
>>
>>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>index 715b538e7efe..26258861e3bf 100644
>>--- a/drivers/iommu/intel/iommu.c
>>+++ b/drivers/iommu/intel/iommu.c
>>@@ -2374,8 +2374,11 @@ void intel_iommu_shutdown(void)
>>  		/* Disable PMRs explicitly here. */
>>  		iommu_disable_protect_mem_regions(iommu);
>>-		/* Make sure the IOMMUs are switched off */
>>-		iommu_disable_translation(iommu);
>>+		/* Make sure the IOMMUs are switched off if not preserved. */
>>+		if (iommu_preserved_state(&iommu->iommu))
>>+			clear_unpreserved_context_entries(iommu);
>
>How are PCI devices handled during a live update kexec? Do they go
>through the standard iommu_release_device() path?
>
>I assume they do not, because if they did, the context entries for
>preserved devices could be updated after preservation. If they do bypass
>the release_device path, why not just explicitly invoke
>iommu_release_device() for all devices that are not preserved?
>
>Using iommu_release_device() for the unpreserved devices would naturally
>erase their context entries and securely park those devices in a DMA
>blocking state.

I considered reusing iommu_release_device(), but it leaves the hardware
in a state that is unsafe to carry across a kexec boundary when global
translation remains enabled.

- In legacy mode, iommu_release_device() does not clear the context
   entries. It assumes device_block_translation() was called during a
   prior domain detach to clear context entries.
- In scalable mode, while it does clear the context entries, it skips
   the PASID cache invalidations (per VT-d spec 6.5.3.3 Table 25, second
   row). It assumes intel_pasid_tear_down_entry() was already called
   during domain detach to handle the invalidations.

During a normal shutdown, this is safe because the IOMMU driver disables
translation globally. However, since live update keeps global
translation enabled across the kexec, relying on iommu_release_device()
would lead to DMAR faults from unpreserved devices.

Manually clearing the entries and issuing global invalidations is the
safest way to guarantee the unpreserved devices are securely parked.
>
>>+		else
>>+			iommu_disable_translation(iommu);
>>  	}
>>  }
>>
>
>[...]
>
>Thanks,
>baolu

Thanks,
Sami
