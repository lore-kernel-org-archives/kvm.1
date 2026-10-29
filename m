Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793233955;
	b=bS6tQs7a/fbpx9apwOAOYior6y5lu/BkQ1hZhcBVqizLaLwO4e5Z7Onho9banrgSfHdf
	 Pg+aKnKc/LcewHLYVFWKkzXppj/Ln9/byZBNkD0Zcv9CwS7JF6LkVMYubo4FYfkiWr6m/
	 ry0DL8pGI/L5X+/W5MDStZeYkpdRGzZ/GtoryUe2+ji3mGjo//pvbt/ZNkwwgdCxmZ6E7
	 ZaaD4ySXTDZfayQriwZX/cPfXvMuVwNYh8vVGW2CzVloa6WILnOZ6EcV/zo5Qt67LaAG4
	 v3PSIzoP92b0vflnQBupifoqFFWbXR9E3f+NxWKg1Pw/c1YFjBRUtCoWDz5hx4tjhgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=sKubpdguY3Kmvsl1ZnTrZPoghLHUacKxP5MDaB4jurw=;
	b=vvw31LIrLRpKeIsm16wyg5drFhUgJvkkOncvnzDa6iVftka94hVdsPRctVooFuzr/7Nn
	 B4jQC54TJPp6kwFTOn7Kwlh86oOpelXrFKlLKmBfbBZ6oHe4NuEUH9O3M95DboBlPIgXM
	 TzULQngY56+4aVqGWqHPv9LW5Ln9CKF/jJeYKu/nnA93sdc7VnNMBADgqKBULrQrjsK0i
	 Hnr7ez/E4rln3+JBCX2KUzFn54oBPA/Dy3prSNxizt8nf36QS9Id0jBSxfZ5JY2VJ9B+e
	 I7kUuhtkPzA15IGguwcO35kLb5Q/4dyZp527JO/g6jP6aekY9jrimR4cNLyL1XdZq0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RpJ7de5Z;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A88606A31C
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 00:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04A88606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RpJ7de5Z
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ea7f9c11e6so33775ad.0
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 17:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793233954; x=1793838754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sKubpdguY3Kmvsl1ZnTrZPoghLHUacKxP5MDaB4jurw=;
        b=RpJ7de5ZS0NtLJLR14z7WpIOcaB18je3EwrQvb14vO8ZL4kKt9oAnivGHdUoozLvCN
         OQWhzClfula2k1Tu9qY3l77lJTe2jCodtO0HYtM0PrsS52+/78d46dbi5+YkMXc0EiX8
         EO646ECToD76YlRMzv34mKXrn3F6tweMMq+gltE9DYwHMHvf8aDEo3f1+T1g20xrQ/98
         PnL/IXs7UgR6nyea0//EI+e4ED1LHln8u1tE5YCCokpkr66Lf7vv+Cyxec6kdB4RnwYo
         ZN1o9hhjI3XEUZDxXA5XFdnhcPkP07nJv2Kzf5Da2NK9rjF6wFhaV0y4TYJG7qWqrAAI
         qdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793233954; x=1793838754;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sKubpdguY3Kmvsl1ZnTrZPoghLHUacKxP5MDaB4jurw=;
        b=I9GvyLiLGbz3ZPwD3VgsvuQLfLxhSsSJgn/Q4lWUOb3VI0yHZx1gBoXxtUoKW138yd
         4sKpUDjyFt0oKtlXNYyQTcL647P+3FjFdzUTuo78Kfux4lEwCoYVMojzjBa5MByRMUT4
         1lzYvVVTiLrrGTDrrPcll7zGk3z4mUHspdHMRsmpnjhx8fOytn5lS4LHO4cCV/Fwe3y2
         Sv7F1GvkSHvwLj6gcfAfsxIvUicqHJDm+l78f04uA+8C84aYdh9iadhj+LmxP/17NnMn
         g7CHapMSs1ZZvNCXu2LWXlSoyRWQ0JK8podd2cYHnFZnwWOOoO35nrPnGanKvd+o4Dpv
         zv1A==
X-Forwarded-Encrypted: i=1; AKwUvBxxfuHsY75wyqMDYEgOLOajs422yZvbNvqlEW1Gqr5pBXDL/Bzf995BXIf+Io/c0cEtGug=@vger.kernel.org
X-Gm-Message-State: AFq9FYId+zus/jOCq0XvUhmetmVS9NqTIxZpm9pNeeaIwHYiFu8PMIsH
	O2u4hUWvSh/6h8qALCt+p6cqzCj+aCmwiwrtr9c/HKjwRctKaz8Ciaiv/g3GkdQTbg==
X-Gm-Gg: AYBFou3hwUYBzQpx2EuHkphMNZDe03DE6J5+c5lkSMy7wcXz9CsHm1mwq+RG81VvqWJ
	/Lh/yU+NM9NNWXHztveJzCe/34PjAxK60YdliHnUbVsNaXYKU/Wh1qTPxPjBWuhHURMVM3m/llp
	S30VBsobRdbnMVtJvG8ridEuf+tiZnL/1fb6vZMMjvDx9y0vueLGZ5c+9Hl2NZXYTQQmdYwCJ+1
	MzH9MzqHQ9WY0vVZH9hMc/SJcflBG8+XDlPV8YojStY2seYw/m/VP6naLBdrMMyKMBABRXWFoGK
	/SBqJbqyub6LynwDVsuLgMyRnTfsdnLkVAEIA1tCDDN2G1VZHlCetw/aytXHJVGrXE6iuSnybfk
	ip03iBjhSvEaspYIyBejGleZJksQvBY1Bf6751Us4tf0z3QfeEYfhuMMtMEVPP1B7Dng/u0SxKi
	VbA/76mzXh4t5eUUNwiYoIuNuJVkNwQQ2q9kxsGHKDoOezI00qij16zhedIdtb84fJcQ0BmKWad
	lJzxLm+EK2a1yu3dO0SM+Padx+Wx94iTyMkUz2Wvqc7RYuH+CwAuw8C3g0VNojc3SKOTmPp3ahK
	iiIn+Tx///fXODmsSaiUgcMAFFsUpJiHXzUDTEun749vQjXkIgpDoIPF2dNQdJg8xGb1pufFVDr
	nFeIelkxRiPxOjitUiuHYjg==
X-Received: by 2002:a17:902:ccc2:b0:2d5:db38:8013 with SMTP id d9443c01a7336-2eb1ececd67mr1628615ad.18.1793233953646;
        Wed, 28 Oct 2026 17:32:33 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e944ba9sm1363649a91.8.2026.10.28.17.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 17:32:32 -0700 (PDT)
Date: Thu, 29 Oct 2026 00:32:29 +0000
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
Subject: Re: [PATCH v6 10/18] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
Message-ID: <auKJ2xTMCXwGxUyl@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-11-skhawaja@google.com>
 <e86c855a-bad8-4909-ae88-a7cdca2837a7@linux.intel.com>
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
In-Reply-To: <e86c855a-bad8-4909-ae88-a7cdca2837a7@linux.intel.com>

On Wed, Oct 28, 2026 at 03:14:26PM +0800, Baolu Lu wrote:
>On 10/25/26 10:19, Samiullah Khawaja wrote:
>>During boot fetch the preserved state of IOMMU unit and if found then
>>restore the state.
>>
>>- Reuse the root_table that was preserved in the previous kernel.
>>- Reclaim the domain ids of the preserved domains for each preserved
>>   devices so these are not acquired by another domain.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      |  71 ++++++++++++------
>>  drivers/iommu/intel/iommu.h      |  14 ++++
>>  drivers/iommu/intel/liveupdate.c | 121 +++++++++++++++++++++++++++++++
>>  3 files changed, 185 insertions(+), 21 deletions(-)
>>
>>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>index 35ec2ae0c8d5..991ad9b2456e 100644
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
>>+		iommu_ser = iommu_get_preserved_data(iommu->reg_phys,
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
>
>Why skipping init_translation_status() for a preserved iommu? The final
>step of intel_iommu_init() does the following:
>
>        /* Finally, we enable the DMA remapping hardware. */
>        for_each_iommu(iommu, drhd) {
>                if (!drhd->ignored && !translation_pre_enabled(iommu))
>                        iommu_enable_translation(iommu);
>
>                iommu_disable_protect_mem_regions(iommu);
>        }
>
>That touches the gcmd register of a preserved iommu.
>VTD_FLAG_TRANS_PRE_ENABLED should be set for all preserved iommu. Or
>not?

I skipped init_translation_status() on purpose:
VTD_FLAG_TRANS_PRE_ENABLED drives kdump behaviour in init_dmars()
(disabling translation when not in kdump, copying the old tables) and in
intel_iommu_is_attach_deferred(), none of which is right for a preserved
IOMMU.

But you're right that the final loop then calls
iommu_enable_translation() on a preserved IOMMU. Since alloc_iommu()
mirrors GSTS into iommu->gcmd, that write only re-asserts TE with the
current values, but I agree it shouldn't touch GCMD at all. I'll skip
preserved IOMMUs in that loop explicitly.

>
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
>>+		} else {
>>+			/*
>>+			 * TBD:
>>+			 * we could share the same root & context tables
>>+			 * among all IOMMU's. Need to Split it later.
>>+			 */
>>+			ret = iommu_alloc_root_entry(iommu);
>>+			if (ret)
>>+				goto free_iommu;
>>+		}
>>  		if (translation_pre_enabled(iommu)) {
>>  			pr_info("Translation already enabled - trying to copy translation structures\n");
>>@@ -1818,7 +1830,11 @@ static int __init init_dmars(void)
>>  	 */
>>  	for_each_active_iommu(iommu, drhd) {
>>  		iommu_flush_write_buffer(iommu);
>>-		iommu_set_root_entry(iommu);
>>+
>>+		iommu_ser = iommu_get_preserved_data(iommu->reg_phys,
>>+						     IOMMU_SER_TYPE_INTEL);
>>+		if (!iommu_ser)
>>+			iommu_set_root_entry(iommu);
>>  	}
>>  	check_tylersburg_isoch();
>>@@ -2245,17 +2261,28 @@ int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
>>  static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>>  {
>>  	struct intel_iommu *iommu = dmaru->iommu;
>>+	struct iommu_hw_ser *iommu_ser;
>>  	int ret;
>>-	/*
>>-	 * Disable translation if already enabled prior to OS handover.
>>-	 */
>>-	if (iommu->gcmd & DMA_GCMD_TE)
>>-		iommu_disable_translation(iommu);
>>+	/* Use IOMMU HW unit MMIO base to identify the preserved state. */
>>+	iommu_ser = iommu_get_preserved_data(iommu->reg_phys,
>>+					     IOMMU_SER_TYPE_INTEL);
>>+	if (iommu_ser) {
>>+		if (dmaru->ignored)
>>+			intel_iommu_handle_drhd_restore_failure(iommu);
>
>intel_iommu_add() runs during runtime ACPI hot-add, not during boot.
>It's unclear whether an preserved IOMMU can reach this path. By the time
>a hot-add event occurs, the preserved data may already be gone because
>the LUO session has ended.
>
>I would suggest starting from simple by not supporting IOMMUs with
>preserved state in the hot-plug case. Returning -EBUSY here would be
>enough?

Agreed. A preserved IOMMU can't reach this path: intel_iommu_add() only
runs for a runtime ACPI hot-add, and an IOMMU that existed in the
previous kernel isn't hot-added again after kexec. So AFAIU this is dead
code for preserved IOMMUs.

I think I will put a warning here for preserved IOMMU and return -EBUSY
as you suggested.

>
>>-	ret = iommu_alloc_root_entry(iommu);
>>-	if (ret)
>>-		goto out;
>>+		intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);
>>+	} else {
>>+		/*
>>+		 * Disable translation if already enabled prior to OS handover.
>>+		 */
>>+		if (iommu->gcmd & DMA_GCMD_TE)
>>+			iommu_disable_translation(iommu);
>>+
>>+		ret = iommu_alloc_root_entry(iommu);
>>+		if (ret)
>>+			goto out;
>>+	}
>>  	intel_svm_check(iommu);
>>@@ -2281,7 +2308,8 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>>  	if (ret)
>>  		goto out;
>>-	iommu_set_root_entry(iommu);
>>+	if (!iommu_ser)
>>+		iommu_set_root_entry(iommu);
>>  	iommu_enable_translation(iommu);
>>  	iommu_disable_protect_mem_regions(iommu);
>>@@ -2797,7 +2825,8 @@ int __init intel_iommu_init(void)
>>  		 * to avoid unnecessary lock order splat.
>>  		 */
>>  		up_read(&dmar_global_lock);
>>-		iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
>>+		if (iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL))
>>+			intel_iommu_handle_drhd_restore_failure(iommu);
>>  		down_read(&dmar_global_lock);
>>  		iommu_pmu_register(iommu);
>>diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>>index 16ab103d308a..260c7a5b1240 100644
>>--- a/drivers/iommu/intel/iommu.h
>>+++ b/drivers/iommu/intel/iommu.h
>>@@ -1307,6 +1307,8 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
>>  	return 0;
>>  }
>>+int reserve_domain_id(struct intel_iommu *iommu, int did);
>>+
>>  #ifdef CONFIG_IOMMU_LIVEUPDATE
>>  int intel_iommu_preserve_device(struct device *dev,
>>  				struct iommu_device_ser *device_ser);
>>@@ -1317,10 +1319,22 @@ int intel_iommu_preserve(struct iommu_device *iommu,
>>  void intel_iommu_unpreserve(struct iommu_device *iommu,
>>  			    struct iommu_hw_ser *iommu_ser);
>>  void clear_unpreserved_context_entries(struct intel_iommu *iommu);
>>+void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>>+					       struct iommu_hw_ser *iommu_ser);
>>+void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu);
>>  #else
>>  static inline void clear_unpreserved_context_entries(struct intel_iommu *iommu)
>>  {
>>  }
>>+
>>+static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>>+							     struct iommu_hw_ser *iommu_ser)
>>+{
>>+}
>>+
>>+static inline void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu)
>>+{
>>+}
>>  #endif
>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>>diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
>>index f92cb774cc99..cf98b95bf8d2 100644
>>--- a/drivers/iommu/intel/liveupdate.c
>>+++ b/drivers/iommu/intel/liveupdate.c
>>@@ -272,6 +272,127 @@ static int preserve_iommu_context_tables(struct device_domain_info *info)
>>  	return 0;
>>  }
>>+static int restore_context_table(struct intel_iommu *iommu,
>>+				 struct iommu_hw_ser *ser,
>>+				 u8 bus, u8 devfn, u64 root_val)
>>+{
>>+	bool present = root_val & 1;
>>+
>>+	/*
>>+	 * The root entries of unpreserved context tables are cleared during
>>+	 * shutdown, so the preserved bitmap must match the present bits.
>>+	 */
>>+	if (is_context_table_preserved(iommu, ser, bus, devfn) != present)
>>+		return -EINVAL;
>>+
>>+	if (present)
>>+		iommu_restore_pages(root_val & VTD_PAGE_MASK);
>>+
>>+	return 0;
>>+}
>>+
>>+static int restore_iommu_context(struct intel_iommu *iommu,
>>+				 struct iommu_hw_ser *ser)
>>+{
>>+	struct root_entry *root;
>>+	int ret;
>>+	int i;
>>+
>>+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
>>+		root = &iommu->root_entry[i];
>>+
>>+		ret = restore_context_table(iommu, ser, i, 0, root->lo);
>>+		if (ret)
>>+			return ret;
>>+
>>+		if (!sm_supported(iommu))
>>+			continue;
>>+
>>+		ret = restore_context_table(iommu, ser, i, 0x80, root->hi);
>>+		if (ret)
>>+			return ret;
>>+	}
>>+
>>+	return 0;
>>+}
>>+
>>+static int _restore_used_domain_ids(struct iommu_device_ser *ser, void *arg)
>>+{
>>+	int id = ser->attachment.attachment_id;
>>+	struct iommu_hw_ser *iommu_hw_ser;
>>+	struct intel_iommu *iommu = arg;
>>+
>>+	if (WARN_ON(!ser->iommu_phys))
>>+		return 0;
>>+
>>+	iommu_hw_ser = phys_to_virt(ser->iommu_phys);
>>+	if (iommu_hw_ser->type != IOMMU_SER_TYPE_INTEL)
>>+		return 0;
>>+
>>+	/* Only allocate domain ID from associated IOMMU HW unit */
>>+	if (iommu_hw_ser->intel.phys_addr != iommu->reg_phys)
>>+		return 0;
>
>Unlike kdump case, where out-of-range did is ignored.
>
>	/* For live update, an out-of-range did means corrupt state. */
>	if (id < 0 || id >= iommu->max_domain_id)
>		return -EINVAL;

Agreed. I will add this.

>
>>+
>>+	return reserve_domain_id(iommu, id);
>>+}
>>+
>>+/**
>>+ * intel_iommu_liveupdate_restore_root_table() - Restore root table and reclaim domain IDs
>>+ * @iommu: Target IOMMU
>>+ * @iommu_ser: Serialized IOMMU hardware state from previous kernel
>>+ *
>>+ * Restores the preserved root table and context tables for the IOMMU hardware
>>+ * instance across Live Update, and reclaims all domain IDs previously allocated
>>+ * to preserved devices so they are not reused.
>>+ *
>>+ * The preserved devices keep doing DMA through the preserved translation
>>+ * tables, so a failure to restore them is fatal.
>>+ */
>>+void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>>+					       struct iommu_hw_ser *iommu_ser)
>>+{
>>+	int ret;
>>+
>>+	/*
>>+	 * The kernel command line might have changed across kexec, e.g.
>>+	 * intel_iommu=sm_off, so make sure the preserved tables are in the
>>+	 * format this kernel is going to use.
>>+	 */
>>+	if (iommu_ser->intel.sm_enabled != sm_supported(iommu))
>>+		panic("%s: preserved scalable mode %u does not match current %u\n",
>>+		      iommu->name, iommu_ser->intel.sm_enabled,
>>+		      sm_supported(iommu));
>
>I'm not clear on the trust model for the preserved data. What if it does
>not match the hardware's current configuration? Should we verify that
>the preserved data matches the hardware state here? Would the following
>check help detect such mismatches?
>
>	u64 rtaddr = readq(iommu->reg + DMAR_RTADDR_REG);
>	u32 gsts = readl(iommu->reg + DMAR_GSTS_REG);
>
>	if (!(gsts & DMA_GSTS_TES) ||
>	    (rtaddr & VTD_PAGE_MASK) != iommu_ser->intel.root_table ||
>	    !!(rtaddr & DMA_RTADDR_SMT) != !!iommu_ser->intel.sm_enabled)
>		panic(...);

The preserved data comes from the previous kernel through KHO, so it's
trusted like kernel memory, but checking it against the hardware catches
bugs and mismatches. I will add it.

>
>>+
>>+	iommu_restore_pages(iommu_ser->intel.root_table);
>>+	iommu->root_entry = __va(iommu_ser->intel.root_table);
>
>__va() is used here while other places use phys_to_virt(). Why?

I will update this to phys_to_virt().

>
>>+
>>+	ret = restore_iommu_context(iommu, iommu_ser);
>>+	if (ret)
>>+		panic("%s: failed to restore preserved context tables\n",
>>+		      iommu->name);
>>+
>>+	ret = iommu_for_each_preserved_device(_restore_used_domain_ids, iommu);
>>+	if (ret)
>>+		panic("%s: failed to reclaim preserved domain IDs: %d\n",
>>+		      iommu->name, ret);
>>+}
>>+
>>+/**
>>+ * intel_iommu_handle_drhd_restore_failure() - Handle DRHD restore failure
>>+ * @iommu: Target IOMMU
>>+ */
>>+void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu)
>>+{
>>+	/*
>>+	 * The preserved devices keep doing DMA through the preserved
>>+	 * translation tables, so a failure to restore and register the IOMMU
>>+	 * is fatal.
>>+	 */
>>+	if (iommu_get_preserved_data(iommu->reg_phys, IOMMU_SER_TYPE_INTEL))
>>+		panic("%s: failed to restore IOMMU with preserved state\n",
>>+		      iommu->name);
>>+}
>>+
>>  /**
>>   * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
>>   * @dev: Target device
>
>Thanks,
>baolu

Thanks,
Sami
