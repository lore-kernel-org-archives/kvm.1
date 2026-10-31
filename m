Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793474629;
	b=GGxQnIHpfG0d0qH9JOCpYVx+9/YEWCmDfkgg2RxDKNllPfzlm5YNORuaBiPAkzU3gzOu
	 m5NVrp+MopkswRXD0Obg1Mu0aoHnWkb9/onQcysGkcykHqCNDga951MQpJxoZfOArFlDK
	 A4NSxjEFHTRNUbkLTHNmptUKmp0QEKzS+5bAtkwOKYfbWaHkncC0kO+azk3oVsaeZ2t1t
	 DcOtD/NEK4Y7/U019lmFiG63s0V8HhFxa484uRKMjzbi0RP/b33buHTc7SGafQHKp1Scp
	 1tnEianQ+QoB9NsAaH9OVdgW/liDtsPaa/fKHpY6ju3rsQy4YkCx4QbvVXk6J2D+Ukg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793474629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=qee3FwDn+lR4Rdz4X353Tv1A8/aooI3LNRhrS8wuqjk=;
	b=qwJ8b1hEGe5QConl3ZRErQVJ+r7/8hWtNodOc1IQ4m0/nNUxBG18ArP23UD3ed8FDOSz
	 iP50VkvWG1iSJrp0Qdc93iVKJMZ6oP0uGvcIneDZJ9Lj0iigPssbrs3XPMbR10pwXOUx0
	 Spy0AzRpG9sg3u2Scn/eN3Jcb5B9C58hpwpVhBYvtXJXDr3GXrFZV0No76L+nK+jh2l9v
	 8vuz0pmLCtY2ZpcE14Fedb4p9bSc4R6Hqey6hHU8fhZtDcNQVsWxn2h7rWtzQNwZfHCWv
	 DhnULxuDgQ8YZhjicY7iaBLWPaakGqsrEh1Icujfdqn2tiymd6YikEzP2dqgrwPlTBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Aam5o7a8;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A80606A31D
	for <kvm@vger.kernel.org>; Sat, 31 Oct 2026 19:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54A80606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Aam5o7a8
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2eb0a52d605so38725ad.0
        for <kvm@vger.kernel.org>; Sat, 31 Oct 2026 12:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793474629; x=1794079429; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qee3FwDn+lR4Rdz4X353Tv1A8/aooI3LNRhrS8wuqjk=;
        b=Aam5o7a8hUW4mc8284I69mOwmhTF493/rFhQuGGspiyeTybiS/cluWSoa64PtfbBb/
         ABnWD2HlOW3xv0edtXq3OAdDmMk80Npd8dsL7UrCg1Yh4uB+WEEqi+jxIHRJwDOixemH
         Mq52MZLQpfPDBeVW1lrO+V5tH87YOpccoeXNTLh4/CkK+WNvDbQ/+5m2X3Flhe+/l0V9
         ObA+I3e5BCPZ+E31xJyEcze1c9VYcKTy1Zxe8p1398Ak8gTmleOTi5TUdg/Miyg7+VCe
         X6PnNisIE0Xr7uFBONgsRs+S7ZWawVGABpOc0adz9V3eNQ2yZIfk/Z6/a8IM7oHCFoZZ
         Y16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793474629; x=1794079429;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qee3FwDn+lR4Rdz4X353Tv1A8/aooI3LNRhrS8wuqjk=;
        b=N09lzJztVgMpUkaO/fq1UvkaOS7bohXODVKn3tT88k9anQiqfNGDgxrlcq8W+/ZpST
         WQRH8ETgnapH4r3klAyaHwfVmZbiu3aVeqhkw9U8qjwTEp254Tp3mpsUtos/EazYmyy6
         ars77p1iqqCj7jBcD3Mhis2+1O8ZdSdSSdH8FXKc9gkVyJbc8GaxoXRu2sFoRoVFyojJ
         d5gc6vmdKyCGH7B2Ij9fKqTGTpbqXC5EjxtmQOHHyK4cDtPCpbcMnBSwiDLjVSfGDSap
         42xngSYAx2Z5g2d21N+C+pOxDHAyqyoJpT4wpWz8cJUHGPAjftW7kqqQ22M0iBKmpOsJ
         sonA==
X-Forwarded-Encrypted: i=1; AKwUvBz8UxcsDpfdkxX57ZBpMM1vmzuLEgt1P1xM4o4+JMyMk6iude24L1fBhvxhdJCgFlaYGRM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLx7MfS86hdJdQc4J3p38fGGxudIZ8jR0HVMCsSTlosChnaYuh0
	HyY2kmXCqX0g1fLQTi3LaNGn3YrZyaboTJvULgRafzIzOz2ooGMp2x/Jbu4azYbMSQ==
X-Gm-Gg: AYBFou2kQUAqHyj5Bi4AL+nmsT6dI7UyGyP5GtCmNXGHy8oaDk8FfzezqVL+8A8mT7e
	w1Mzva+XBB+f46n8GYnQcPBe+XtEZ6dBzFrOLV89/FH85QmlertdJRzVesHXhZdZskRCTBf1ec0
	DvseHAvC0Lyq1dwS3ogDFJztYjmI6sLhoxqcHpH0oe7lqcy00gFxWJ3q4o5UfLYRhmtzD+Rl+Cb
	DqfjySqZQXna6UmRFQy7Y0sxJ8ElrOeRy5lbHIjPOguGGGXhRxERibUHMQEjDb1fq+mi/KG993v
	lYOaZoaVznXAOhppcowB9vlOLLpRhbQAKmUrkR4as2NsVsIiqQRFOafeXli28NbXHYoOGR8AVc5
	8AMqjD1Zl+BkohHUW1ZWr/PWwc2UiQ7gKyblJ61lgbLwqf7vB9yz7UZE/GwwUc7+3Xwx+7vuNvu
	m9F46ACWOODD+i08kpTLlvfQyKYo1iKFAYI4+Eb0msaZNRNy1aEQ3E4JZQ6alucUvog8wVk63Ka
	4MPtg1HofypM8Ub5cG/nF64CZMDgJ5io27hhQ1FykvVZBx6gNB+u3JLkqyMnQBabypxElCQsQui
	gv8jRX41uhstxdeC5Wyd5G3zeKf+QK2RH+Cjciv01ErDVFh1y19ylCszLbyawua8LhfjJjqHdYP
	nVM1klnQATlWdo5NiwJtnfA==
X-Received: by 2002:a17:903:3c70:b0:2ea:4a1:e8a4 with SMTP id d9443c01a7336-2eb1b8c029emr17347455ad.13.1793474627935;
        Sat, 31 Oct 2026 12:23:47 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8fb1ddsm12878243a91.5.2026.10.31.12.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 12:23:47 -0700 (PDT)
Date: Sat, 31 Oct 2026 19:23:44 +0000
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
Subject: Re: [PATCH v6 05/18] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <auY_eWa6J567s1uU@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-6-skhawaja@google.com>
 <df75f891-05a0-4d47-8705-d6a00c81ff97@linux.intel.com>
 <auTzN4NWuKsBvIZU@google.com>
 <51b23019-8ac2-4f6b-9be7-29f3635b472e@linux.intel.com>
 <auVfqaDhk25JUkYd@google.com>
 <7b059c0e-3b60-4d8c-b7d2-7dcb89a51c6f@linux.intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b059c0e-3b60-4d8c-b7d2-7dcb89a51c6f@linux.intel.com>

On Sat, Oct 31, 2026 at 01:27:05PM +0800, Baolu Lu wrote:
>On 10/31/2026 11:39 AM, Samiullah Khawaja wrote:
>>On Sat, Oct 31, 2026 at 11:04:22AM +0800, Baolu Lu wrote:
>>>On 10/31/2026 9:45 AM, Samiullah Khawaja wrote:
>>>>>>+
>>>>>> #if IS_ENABLED(CONFIG_IOMMUFD_TEST)
>>>>>> void iommu_device_unregister_bus(struct iommu_device *iommu,
>>>>>>                  const struct bus_type *bus,
>>>>>>@@ -626,8 +668,8 @@ DEFINE_MUTEX(iommu_probe_device_lock);
>>>>>> static int __iommu_probe_device(struct device *dev, struct 
>>>>>>list_head *group_list)
>>>>>> {
>>>>>>+    struct group_device *gdev, *gdev2;
>>>>>>     struct iommu_group *group;
>>>>>>-    struct group_device *gdev;
>>>>>>     int ret;
>>>>>>     /*
>>>>>>@@ -661,6 +703,13 @@ static int __iommu_probe_device(struct 
>>>>>>device *dev, struct list_head *group_list
>>>>>>         goto err_put_group;
>>>>>>     }
>>>>>>+    for_each_group_device(group, gdev2) {
>>>>>>+        if (dev_iommu_has_preserved_state(gdev2->dev)) {
>>>>>>+            ret = -EBUSY;
>>>>>>+            goto err_free_gdev;
>>>>>>+        }
>>>>>>+    }
>>>>>>+
>>>>>>     /*
>>>>>>      * The gdev must be in the list before calling
>>>>>>      * iommu_setup_default_domain()
>>>>>>@@ -697,6 +746,7 @@ static int __iommu_probe_device(struct 
>>>>>>device *dev, struct list_head *group_list
>>>>>> err_remove_gdev:
>>>>>>     list_del(&gdev->list);
>>>>>>+err_free_gdev:
>>>>>>     __iommu_group_free_device(group, gdev);
>>>>>> err_put_group:
>>>>>>     iommu_deinit_device(dev);
>>>>>>@@ -3543,6 +3593,26 @@ bool 
>>>>>>iommu_group_dma_owner_claimed(struct iommu_group *group)
>>>>>> }
>>>>>> EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
>>>>>>+/**
>>>>>>+ * iommu_group_is_singleton() - Query if group contains 
>>>>>>exactly one device
>>>>>>+ * @group: The group.
>>>>>>+ *
>>>>>>+ * Return: true if group contains exactly 1 device, false otherwise.
>>>>>>+ */
>>>>>
>>>>>We discussed this interface before, and the consensus was that such an
>>>>>interface is not feasible, because the membership of an iommu_group is
>>>>>not fixed, given the hot-plug support of buses like PCI.
>>>>>
>>>>>I am fine with the usage model of ensuring the iommu group of a
>>>>>preserved device to be a singleton, but I don't think we even need such
>>>>>a kAPI. It should be handled case by case.
>>>>
>>>>The iommu_group membership can change, this is why we check it in two
>>>>places, both under group->mutex:
>>>>
>>>>- During preservation we check that the group is a singleton, and check
>>>>  again after setting device_ser.
>>>>- During probe we refuse to add a device to a group that has a preserved
>>>>  device.
>>>>
>>>>So if a device is added to the group while we are preserving, either the
>>>>probe fails because the group already has a preserved device, or the
>>>>preservation fails because the group is no longer a singleton. Could you
>>>>please elaborate what you mean by handling it case by case?
>>>
>>>I am fine with the singleton-group checking logic you described above,
>>>but I don't think we need a helper like iommu_group_is_singleton(). It
>>>drops group->mutex before returning, so its result may already be stale
>>>when the caller uses it. That makes it easy to misuse in the future.
>>>
>>>I'd prefer to open-code the check where group->mutex is already held, as
>>>iommu_attach_device() does today:
>>
>>struct iommu_group is private to drivers/iommu/iommu.c, and
>>iommu_preserve_device() is in liveupdate.c, so open coding it there is
>>tricky.
>>
>>You are correct that it drops the lock before returning. That is why I
>>recheck the singleton state after setting device_ser, which handles the
>>race.
>>
>>I was thinking of adding something like iommu_group_lock() and
>>iommu_group_unlock() for this, but the number of devices check also
>>needs struct iommu_group definition.
>>
>>To avoid misuse, I can add a comment on iommu_group_is_singleton() that
>>the result may be stale and the caller must recheck. What do you think?
>
>I would suggest something like this:
>
>size_t iommu_group_device_count(struct iommu_group *group)
>{
>        size_t count;
>
>        mutex_lock(&group->mutex);
>        count = list_count_nodes(&group->devices);
>        mutex_unlock(&group->mutex);
>
>        return count;
>}
>
>and, add a comment stating that the device count may change after the
>function returns, so the caller must recheck it.

Sounds good. I will replace iommu_group_is_singleton() with
iommu_group_device_count() and add the comment.

>
>Thanks,
>baolu

Thanks,
Sami
