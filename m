Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794861258;
	b=BGptpIEQMx3nzGyPaTt86tb1+RktHMPHMi2ggP2eu3No37Z5A0VYI0Gui0EvRqCkfC0/
	 9PUY3WIQ5Z6ei0BbreVKIV09MOtzI9JcgLwiL0LQNk3G5EM0r0HzDPl3jcuYGjwd9OSkq
	 JmpIeD7qfZfb467nVePzgXZQiflNEGLg71x/iIe1Sc5AV9RjI1/O3nNey4cTj3s5fteAw
	 lXSJGgb57qmdGdg0mh9ZGhEPFxyeUrofB6zdpZ7OwK1oX5GQLnCcYqkE6UoOtoHXlek0y
	 Nl4+CEtK0X73VdFXDva1qCboEpt1SJ71wA2qYRhtqQFHvWsuhLQpFjxJJkjG9Z80qXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794861258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=FuP841QZILSYrGI+sOs3ttqavD6cxIfZJ60TQUpud2E=;
	b=N8dy4IR7ZDmIZ6druJ2QfDYZNwq6mBCtmt7JvQQ2jzf8SRdEJm89boAzohkaYTnIjN02
	 AkbLAGK7qrpfOuMUjiXv2ELvM5bPStQ1qI+Cri4Y66S6rhhygNbFYgbksdgyEGPGTAd8t
	 9qO106xma/R2ABiUpdXpZbnvbkmAC50fUqTRJ6l5+77hWQvAQJbR4H3encHAFEx3Ez7NW
	 IwJfiC72VECaL5wPqKR8zrWOmSMdtvA5whjIhivLzTZH/i9Nc7duOpgSF5HKrpphkAdIe
	 XueuGw4FuoCoYoVQeDFU72vdbnxItbpV1qtbH0cngUKPq7rp6RHdNld1/XFO3qcnx0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dmIh0sGt;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1D8606A31C
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 20:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A1D8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dmIh0sGt
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2efc4a84e75so15755ad.1
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 12:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794861257; x=1795466057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FuP841QZILSYrGI+sOs3ttqavD6cxIfZJ60TQUpud2E=;
        b=dmIh0sGtUdCAx8LVvuF/0RO/gJohVjpsrtSP6D1QcLtRNEi2/v8twNsF/c14q5WWea
         5aJpv6F0z2BBmb203b94WEPy4PXC6rPyo6J6qignUfTVY4xU1ee1WA+qn3DvYU3KJWPM
         dO8vtHLvA4gSIufqC84szJg9Payfl1GxRnA+yj/LMoXwNhpCe1YTz9Wc24b3KkCFcWTx
         AamxzZn8M2rcTxGe1aCkt6LGHqA2EhAWiYmonxn+RRDOAFTv6tSYKxAZ3GgzqmIqqY5d
         MPpUrwTmupi2pLnunFZs9nEcLvGteQGea9UzdaVTBPPTcCoivc5w5biFVnrG4KR57E1E
         eedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794861257; x=1795466057;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FuP841QZILSYrGI+sOs3ttqavD6cxIfZJ60TQUpud2E=;
        b=chccsKQbmtDERLlJmFIElyF0I2me8V1vvuWH8ENd5KGoOif72Drqy73DRbQNUWEpNG
         Qw8WqzK/3scgsIIxqy6/Fs0nPfg1XWinTennGI8q+liE+3etA1jarCzutjasi5INI/dq
         HWFWx2TbXbmELDRjFaO+IhzKkB/bRfp5fKDU1zh8WzG+nRJUGJ6o3+XtkoY96Evhwxmi
         fNuP23TEfhusXF/IW6m5aGSWvX5w3juK5LigpHrwYRfPD6VHv50aEhuEPuyEIm2pd5hv
         VpH2YrzBEA70Pt4gNQbT3xfs2tzGC/QJ6oOHZcGMToHKkUkrCPLRGiAcmaypVgEwW9pe
         pLWQ==
X-Forwarded-Encrypted: i=1; AL+hErFkrLCoDbGovTF0CUbMaqKvohT3XlTzfZYi4b8Vs1BPGKvtwZz0CxupsKNMwZEms8taBZE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1EIL9Q8KTJX34QnQqca55XHWDSLAkQkwOyoy+BHjGHyzGAVV8
	KTJo5T/HFQ0Td27jt1Op7lkhsVygHGZXGCOWCHWIZMuwHOKbAVR/i7Jke2iwWWvvIA==
X-Gm-Gg: AZFdTZeLsZv/FQcuZAiIN6HZCqFc5yJoRckty8mc+3Axpo+ob+BXJRoWFAVVhN/Q8Rd
	cPOpJ7K4sCRIooXFr8Mao8nph0YT+eZCWlUr2z812fnupTp/7IWpx4U+u4V0qLHoI+XhkzIh7o3
	PsTZRDiuy1f0ZF5XgICecSxncLIZ2HIq1LWPdeO98tKaI5QRGClyrvOY3teepBehxir4hpp8wDQ
	QF/oM8mq1WyR0OAwwbs+tHlSGzXv8xRka76JPVNdYbMjE+Zjyr9HK+xOvivP8pKNflfBatd0TGO
	KlrU0wzaFf+PVb2Wn8khO4PmkwC0VCeZmNJW5y85+MEy+zZEmiK7j1UzKzC5iNZbADvjeLKFoig
	uK/j8893ZRPdgLwhlTYGLzczT9v22p/+MJYbZZfuHOJlY1vTsHcgfXEYVEYkl4Z+ZR1gGXaGuja
	moHeDP5i2F6SXabS5p/XoM/bNIAD1NCyNL8twQE2vnZ9XbxsKzL3ra6N8Em49CIC+7MakBJURdE
	uKIj4Sesygzoo8vYiy+TCcoeIoP1zHEZaaNdCejSCPWd6EfrZIIbiK/eHGe997Q/GOX2jCaII2+
	DFjnIA/QjOeNUo1IA0gYIA+kM8SjVpIOvuhwyXxKEnt1a4QwaPKx+CN8zp+ymfCWH7410qF2BGM
	xqlXWuBC56VaAnMQX1BI72w==
X-Received: by 2002:a17:903:37cc:b0:2ef:d87f:8a20 with SMTP id d9443c01a7336-2efdc89d1a2mr134375ad.12.1794861256762;
        Mon, 16 Nov 2026 12:34:16 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ab9f4c98sm775625a91.0.2026.11.16.12.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:34:14 -0800 (PST)
Date: Mon, 16 Nov 2026 20:34:11 +0000
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
Subject: Re: [PATCH v7 10/18] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
Message-ID: <avtiC6VfIf7uc5gj@google.com>
References: <20261110040828.1774343-1-skhawaja@google.com>
 <20261110040828.1774343-11-skhawaja@google.com>
 <57c85edf-8400-4b45-9a64-5eddc0d29134@linux.intel.com>
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
In-Reply-To: <57c85edf-8400-4b45-9a64-5eddc0d29134@linux.intel.com>

On Mon, Nov 16, 2026 at 11:31:29AM +0800, Baolu Lu wrote:
>On 11/10/2026 12:08 PM, Samiullah Khawaja wrote:
>>During boot fetch the preserved state of IOMMU unit and if found then
>>restore the state.
>>
>>- Reuse the root_table that was preserved in the previous kernel.
>>- Reclaim the domain ids of the preserved domains for each preserved
>>   devices so these are not acquired by another domain.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      |  57 ++++++++++---
>>  drivers/iommu/intel/iommu.h      |  14 ++++
>>  drivers/iommu/intel/liveupdate.c | 139 +++++++++++++++++++++++++++++++
>>  3 files changed, 197 insertions(+), 13 deletions(-)
>>
>>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>index 6c86c155d12b..a83971368bef 100644
>>--- a/drivers/iommu/intel/iommu.c
>>+++ b/drivers/iommu/intel/iommu.c
>>@@ -987,6 +987,8 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
>>  static void release_dmar_iommu(struct intel_iommu *iommu)
>>  {
>>+	intel_iommu_handle_drhd_restore_failure(iommu);
>>+
>>  	/*
>>  	 * All iommu domains must have been detached from the devices,
>>  	 * hence there should be no domain IDs in use.
>>@@ -1452,7 +1454,7 @@ static void intel_iommu_init_qi(struct intel_iommu *iommu)
>>   * Returns 0 when the ID is reserved, was already reserved, or cannot be
>>   * re-assigned, and a negative errno for a genuine allocation failure.
>>   */
>>-static int reserve_domain_id(struct intel_iommu *iommu, int did)
>>+int reserve_domain_id(struct intel_iommu *iommu, int did)
>>  {
>>  	int ret;
>>@@ -1743,12 +1745,16 @@ static int copy_translation_tables(struct intel_iommu *iommu)
>>  static int __init init_dmars(void)
>>  {
>>+	struct iommu_hw_ser *iommu_ser;
>>  	struct dmar_drhd_unit *drhd;
>>  	struct intel_iommu *iommu;
>>  	int ret;
>>  	for_each_iommu(iommu, drhd) {
>>+		iommu_ser = iommu_get_restored_state(iommu->reg_phys,
>>+						     IOMMU_SER_TYPE_INTEL);
>>  		if (drhd->ignored) {
>>+			intel_iommu_handle_drhd_restore_failure(iommu);
>>  			iommu_disable_translation(iommu);
>>  			continue;
>>  		}
>>@@ -1766,7 +1772,9 @@ static int __init init_dmars(void)
>>  		}
>>  		intel_iommu_init_qi(iommu);
>>-		init_translation_status(iommu);
>>+
>>+		if (!iommu_ser)
>>+			init_translation_status(iommu);
>>  		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
>>  			iommu_disable_translation(iommu);
>>@@ -1775,14 +1783,18 @@ static int __init init_dmars(void)
>>  				iommu->name);
>>  		}
>>-		/*
>>-		 * TBD:
>>-		 * we could share the same root & context tables
>>-		 * among all IOMMU's. Need to Split it later.
>>-		 */
>>-		ret = iommu_alloc_root_entry(iommu);
>>-		if (ret)
>>-			goto free_iommu;
>>+		if (iommu_ser) {
>>+			intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);
>
>What happens if the incoming kernel is booted with intel_iommu=off?
>
>intel_iommu_init() calls intel_disable_iommus() before reaching this
>restore path. A preserved device may still be issuing DMA, which would
>then bypass translation.
>
>Could we detect preserved IOMMUs and force VT-d on in that case? We

Booting the new kernel with intel_iommu=off after a live update is a
configuration mistake. I will check for preserved IOMMU state in
intel_iommu_init() and force VT-d on like you suggested.

>should also ensure that the ACS configuration for preserved devices and
>their upstream bridges remains consistent with the previous kernel.

The ACS configuration of the preserved devices and their upstream
bridges is preserved and restored by the PCI live update series.

>
>Thanks,
>baolu

Thanks,
Sami
