Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859498;
	b=wbQoFdqXzg7zZeQSESE5PnRbnkuRhG9Hl00/js44IkwSELCxKMp85G6LMnxM7GeVOEg7
	 M+oLzrQvk6S7midVLEoochJ64VFCkQAdN55UZuSvQ5mLFxd8neQcWXOr+bTt2h9RsabFk
	 vo77DOog5Arp5mJAhEzSX2dxVWKmMKkM7vI8/YgieG8cuiwW6SCoJXmEHBZpB3tVz/Wn8
	 5WiWuE8lQfoB4/gXLjNk2uauHewhTkF88fvZRLsit2d38PQeVz7tQjLMvwA1GaF44t7Cr
	 hFJGB+xJv8tNiOkzixEFJn6BJIn3VYLqcf4ep7KVSlcseXRal5AYdbShLrAPGjyLWIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=GpoVt9829rgvfoUhDyd+CedkZ9hCk1E54sZ/xm+5leo=;
	b=4u4rT9Em4qaWA8aB8CD78AKGS5kzytaTPu/rBEN5f1Z4fS/qsQ0BzGQKkVGP9ysFtpsw
	 ImsQ6DJbrx3jMgV+y5TVR8JHFJXb+tiJA7F+9/FFrT2o3lb1RvYp7vcx7DiqAl3MBWypr
	 o0yifpVobskoSNXYtqiM6IQLmS0HFmu+4TOz2iptIBfCtqbLY5xjk7ABYWSV/JSvBAspk
	 zPXPyr0uFC3AAB8gWUA4AeX7xMWALqq4HAWqqEj/pNwY6Iq4jsVrt2pc/RZxCcSIcBpxx
	 j6m08cZ/S7KDjenBYWsKwCHqzFk/jGtDVxPNUIvFKMhz0rlYXJpZ6EXNFg0Kp7YRzNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AW+9ELtj;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60A4606A881
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 20:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E60A4606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AW+9ELtj
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2efc4a84e75so13665ad.1
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 12:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794859497; x=1795464297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GpoVt9829rgvfoUhDyd+CedkZ9hCk1E54sZ/xm+5leo=;
        b=AW+9ELtjY4IEAV6pWNtpVONxcUyWG1yHYWZbLXUGbgzEm2yjKYJh8P9AltAYWsNVaa
         ljTLluOmvNNO5Ktf1kkokrkGXHcRFSEPKSCcab6HDNcgfrkiAJNvGlJT+MILjO2/zZfi
         EPaiqp+1Rq4At1nG0vL/CFdtTSFH4HR2su0R9cF94vr1iekk2yPkoZq/dObQeslGeX5w
         WRJvYunMLEK9y4YSEOkXrf36Acmp5DXe9dxco6fTC0SnfrHeBNfrKVTmN3HjVfkqidYx
         O/IZKXpTqsjB9LT5k3NvFXtn0hczcGp3cIswieCv4nqnBD3zS/YLwnjiN4VMTpG6Fkl2
         icMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859497; x=1795464297;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GpoVt9829rgvfoUhDyd+CedkZ9hCk1E54sZ/xm+5leo=;
        b=EPlLD29cdAaJ1iThzgmF20uMILn9xt2FAXC96saLLYga5NjCAL+KD6dKY1yNcq+gjB
         APIiaxQv30wwiEZGi12cYVx4u1aG600Ajr0jdQTnXWQcakAnaj8Poroh7XV8FUMvJ2a0
         C5vphilqg+7nZh3QSYnQCaFxHIFyQdepYhz8budfDAjOrx0oXFyQ9sBTXHFLNRV28k4Y
         jax9k/PAMF/5eFyLkKxh56Qrc1J7vrIIxIo9kEz8PEE9+QnmSETxNMcU3a2dcM4yENUe
         dpRMj7AwdOsllnasvxCiwWEJDWPX0mRHi68LfUDFI1v3D/be8ynQlnHNuckO06QQ5TEH
         YQMA==
X-Forwarded-Encrypted: i=1; AL+hErFCDDH24W5pu6GKObwP0QSfN+VMgoxvUq895pybCWKa+XNJ+zHdNwoPESgXfyH0e69ZQGQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ufYBTrCYBTMCCnEjy+PC9xwlfLMDmzRM/eZc2Bc1vVnO1YqVT
	r/Wq5YOjcuhhZjS/A5JIzISf91TAWu5VmQcrS3AQpY/g88pn0Y4zbEoXkSJx+Q8gTw==
X-Gm-Gg: AZFdTZdTzEUk6sS6K/WCGtnB13UVb9ekNH3/Zqd08BIkY9PiEdj0OWqpEM7pKC56Hub
	gSCgRL7/jZ7t6sHqe/kDG1jLJBKPQzekACHF0SdeO1fEVtb3CaS6kAsOSiX6pIvprbz8V0oEhE2
	b/HiUDJI0tVL2SkzuNJZDbTetjJH3CAJjvLalT6fde6zV2Wbe70qMg4X7YFQcsCJKD+evsbcwsb
	ZgYcbCUScPHRYfA4z/dk8TGusZtRRnOcktkRAvNaJlJa4Yuc3MpJrcrngVGhVqjeTX/IzKLj/fA
	BiJtxIDth5eKc1tW1AevhO5wpgpjETyQGv64TcBGo4tP5m8mU7YOa8sy50GRNffFoLgn72BKtsN
	kTrvLLEE4Na/F/8QM7opHWkJYXfYV3cDi0lo07XLLD1bPxXdBL92SZILxaN021MiHeMPQIhAGBw
	d3ipUjjfeuBHUXB8G7cs3vwdsLxdPHt/RnUhUDS1LO1tpudOv6ASYfksuvUQD+XCiKamS0kJKCP
	VYkPQoljCw+QNTPQlOsf86evsIO91dU6NVwfXMugQkeJ2w3uvkbI9QEMfDeNBPNZC1GwmzaXnzB
	UyXpPf9WQvdCIwE1FpENZzXPOjP7kJnxLR8KJCh1gaNxsqOrGUZTTw9pMoBKPlzJsftfy6T6ewz
	euVJZcDrVuPY70cj5GLmrhA==
X-Received: by 2002:a17:902:cec9:b0:2ea:4a1:e8a4 with SMTP id d9443c01a7336-2efdac96629mr683765ad.13.1794859496524;
        Mon, 16 Nov 2026 12:04:56 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18adce4sm4599286a12.23.2026.11.16.12.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:04:54 -0800 (PST)
Date: Mon, 16 Nov 2026 20:04:51 +0000
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
Subject: Re: [PATCH v7 13/18] iommu/vt-d: Handle reattach of the restored
 domain
Message-ID: <avtOvPkcidH1RRST@google.com>
References: <20261110040828.1774343-1-skhawaja@google.com>
 <20261110040828.1774343-14-skhawaja@google.com>
 <7ef6d626-4920-434f-bbd9-eda46e7ab780@linux.intel.com>
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
In-Reply-To: <7ef6d626-4920-434f-bbd9-eda46e7ab780@linux.intel.com>

On Mon, Nov 16, 2026 at 03:38:14PM +0800, Baolu Lu wrote:
>On 11/10/2026 12:08 PM, Samiullah Khawaja wrote:
>>Reattach the restored domain to the preserved device using restored
>>domain ID. While reattaching do not setup the context and PASID entries
>>as those are preserved during liveupdate.
>>
>>Note that in this phase nothing clears IOMMU_SER_FLAG_INCOMING of the
>>restored domain or the restored state of the device, so the restored
>>domain cannot be replaced yet. Replacing it is left to a later phase.
>>
>>Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      |  28 ++++--
>>  drivers/iommu/intel/iommu.h      |  14 +++
>>  drivers/iommu/intel/liveupdate.c | 141 +++++++++++++++++++++++++++++++
>>  3 files changed, 175 insertions(+), 8 deletions(-)
>>
>>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>index b3402fd9fe75..95ec37554360 100644
>>--- a/drivers/iommu/intel/iommu.c
>>+++ b/drivers/iommu/intel/iommu.c
>>@@ -3296,6 +3296,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>>  {
>>  	int ret;
>>+	if (dev_iommu_restored_state(dev))
>>+		return intel_iommu_attach_restored_device(domain, dev);
>
>How is the restored domain's type and page table format selected? I
>don't see the allocation path using the preserved state to choose
>between different domain type and page table format. Could this result
>in a mismatch with the hardware configuration?

The restored domain is always a paging domain allocated with the default
flags, as only those can be preserved. With the default flags the driver
picks the page table format from the IOMMU capabilities and
configuration. These stay the same across a live update on the same
machine, so the new kernel always picks the same format. I will record
the default paging domain format in the preserved IOMMU state, and use
it when allocating the restored domain to check if the formats match. I
will also add sanity checks in the HWPT preservation for this.
>
>>+
>>  	device_block_translation(dev);
>>  	ret = paging_domain_compatible(domain, dev);
>>@@ -3426,7 +3429,8 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>>  	info->iommu = iommu;
>>  	RB_CLEAR_NODE(&info->node);
>>  	if (dev_is_pci(dev)) {
>>-		if (ecap_dev_iotlb_support(iommu->ecap) &&
>>+		if (!dev_iommu_restored_state(dev) &&
>>+		    ecap_dev_iotlb_support(iommu->ecap) &&
>>  		    pci_ats_supported(pdev) &&
>>  		    dmar_ats_supported(pdev, iommu)) {
>>  			info->ats_supported = 1;
>>@@ -3531,12 +3535,16 @@ static void intel_iommu_release_device(struct device *dev)
>>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>  	struct intel_iommu *iommu = info->iommu;
>>-	iommu_disable_pci_pri(info);
>>-	iommu_disable_pci_ats(info);
>>+	if (!dev_iommu_restored_state(dev)) {
>>+		iommu_disable_pci_pri(info);
>>+		iommu_disable_pci_ats(info);
>
>Above changes are not needed for domain reattachment, right? My
>understanding is that ATS and PRI are not supported for preserved
>devices in this phase. If so, could they be split into a separate patch?

Yes the ATS/PRI should already be disabled for preserved device so this
change is basically a no-op. I will remove this.
>
>>-	if (info->pasid_enabled) {
>>-		pci_disable_pasid(to_pci_dev(dev));
>>-		info->pasid_enabled = 0;
>>+		if (info->pasid_enabled) {
>>+			pci_disable_pasid(to_pci_dev(dev));
>>+			info->pasid_enabled = 0;
>>+		}
>>+	} else {
>>+		intel_iommu_detach_restored_device(dev);
>>  	}
>>  	mutex_lock(&iommu->iopf_lock);
>>@@ -3544,11 +3552,15 @@ static void intel_iommu_release_device(struct device *dev)
>>  		device_rbtree_remove(info);
>>  	mutex_unlock(&iommu->iopf_lock);
>>-	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev) &&
>>+	if (!dev_iommu_restored_state(dev) && sm_supported(iommu) &&
>>+	    !dev_is_real_dma_subdevice(dev) &&
>>  	    !context_copied(iommu, info->bus, info->devfn))
>>  		intel_pasid_teardown_sm_context(dev);
>>-	intel_pasid_free_table(dev);
>>+	if (!dev_iommu_restored_state(dev))
>>+		intel_pasid_free_table(dev);
>>+	else
>>+		kfree(info->pasid_table);
>>  	intel_iommu_debugfs_remove_dev(info);
>>  	kfree(info);
>>  }
>
>Thanks,
>baolu

Thanks,
Sami
