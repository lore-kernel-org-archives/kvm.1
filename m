Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793389149;
	b=USJdGYRYDlejUYc1WcxE/I72lfW85eTAsa4dxwcwK9dSjpXeExJRcmSlknLqGY/6o8U0
	 LX+YKBH9xnnqSjfMphk06BTkh46o4j2eNkTYM8023/g1kre9yPHkD5hB7shAmEoZKHMq4
	 HmZjP6nzQo60mCW6cf2vNknt9sMtHAJhEFE7yL9E6xoNUUH9333fIN+o0bpHBeFfsSO0W
	 feN0NEENi9ILw5YINVh/c3rCI8SW2WbAq/u1+MV89PxOAfXMbq2Tizwn5nAEwLaZFckbA
	 diSpV/diBWA1bFF6YDfiVEjVrgE7qNxhUR/HP95Qjqlvrf2xiK4ULjdmXAH6MHfHPUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=928MzBvfJGc3AdaD6rfLR7nqVT2HnyKwpgdCp3LF6iM=;
	b=5VbNFFky8wV4i8aa4w5M0DCs8dr7tvLnUDKJ9GLFyDhAcFahrkIWdDetTU6ApFJDevdb
	 l5d6Z2wpS+DeV5Vib+nGJy7mUBsDSAIFXnxfKLP/to4Qy9h+HBotOC7nM7La8Nzl3w6h7
	 dI2GhHtb3X4AUo6XK2DsX5Owb+RlnIj30tiD8ha1kPa8qpUGmi1SiCP33SeAw44Qn/dEC
	 D6rKpvbeHhgQPvYtbBfbFM/ffr/s5oH69zKeu0ZoLxlAvE21rugjO0SHQpkLQnejLbpMh
	 ZWDt5rY6TvWrTZN+MAYJ+4g0Qag1rXiEdi61AFz6lGZ5J+TWjNbZNA71WOF/7UdvK0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="dQ/dTEoP";
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71462606A31C
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 19:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71462606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dQ/dTEoP
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so11625ad.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 12:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793389149; x=1793993949; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=928MzBvfJGc3AdaD6rfLR7nqVT2HnyKwpgdCp3LF6iM=;
        b=dQ/dTEoPD3WVV7Ho8VHQe9A8qyi5svlbDqa16gbM/7MXLKWR8nHEh683silBiiRDlf
         3t3wlmi2c5Utyy55nETPvrP3qdazTvfk9WpoTx8yohEW0Nznf9PyDBCOvxzPUqTdNO7w
         87N/pWP0Ubq4WhpW6NR5lI+kvlb8fxWNYbbYgD24ZbyoDy/d6DRQcncvgYyC3qBGSUnZ
         z7Mz6XiFB2M2oBvwAT45Y18D8tWEVvqYeqmGN1cut98sTf8iMKKpFuisJazNernmGk7T
         9oSMY+QFXgIChxreoAyz+jSWXcmd1lz50vSDbGxUivDVJ2VBoQkYG04FHXSGV2iLaQu6
         uzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793389149; x=1793993949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=928MzBvfJGc3AdaD6rfLR7nqVT2HnyKwpgdCp3LF6iM=;
        b=EDJUTQdvD7zzcT9k6Rt0nyCvUav95OZ/fpmBMRKnxpXROPdQHDSpfqtIcXxiG9EhUv
         2DI9MgTycOt4FkQSLTToKlPbOZrDv5RHpw3+umZ5SZ+Upfb88MLlEFy0aJGvhPjdXe3N
         YpgJtG+2r+6QPStSfMsHf2aJQvFlGNTKx/qikTqwNgs8hM06uJkLXZ91kBiIVjZ9ajyU
         6wwLnGw2VJvST61pCc5nU71qZcNzU8Pr1ndTroWNF5vFbUzEfT0IJRBBStoC+Bw88GQ9
         vh1ZpKIgi5+887ISJX1SwI2TiabmPmc7nhs0USrun3FuPrCu2OcZxFlxHcHWouLtG4+o
         HuqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcp4Us0YPhLAscv+QK1OrZg8FZGNAIRYzidfFzpoG1fIMjpb2SpxAelJhEiDSCWEcKW4g=@vger.kernel.org
X-Gm-Message-State: AFq9FYLF+f+wAeLGNzKfm1EtWvCpSkEFW/nypbfFBqv6Sj+uitemy2Tt
	uO2gXKX0DAe1K25ABiQ/vHtkFJbN0Suob9IDFdOxDN+wYCuGCn6x+QtsoTg/j2ivQw==
X-Gm-Gg: AYBFou1R+IDkzW63TasMOpOP495yS23ja/ZFbyviWDcQ/ya15nLZAQeu4x5PxrGREL3
	YyNvxOWgNWDNC9yFpol6PrPunrUztpZJiyVtVGl0PBbGqvdK5gG+YH7LK2zX140ADTcFhAGyjOG
	4fCLWNMdURAZhEhAow6DBNPlr8sYbGjDAfegoyK/v4FdJeVRaFnRv7rgbo/Kf0Y8wSHfxi3/wTP
	YfCbRRwRmH6QHH+5ODJpj5H/9R5a/5Cjr98nWCSoS8n3hvjKLkYMmUzn7vBrsrPbqOJR1LSBSec
	iOKXTLUI+o6UTYVvRydgP4nwHasYVYfXnm+DjkeelpvWTjUXKN5RdvEW4HDRyFfHrU3pcbDPAhh
	H40pCRORysVdvts3UEMPzscv6oQg5Ib527z7bWHk8N6THHdDGQTq2Jr009JPz+/+RriW+I5PqSm
	pKXQE6ocacBLcDySHFPZbDGS2T60FWyTDEwAPZ7iQYGeaTJSoxxnFVRny14t/G1FUaxsF/1LSrH
	nRq7DK73AjhjfbAAau8KQbWQFYH1AkaRHacMFZMiSA2RoEnKyPgJ0j3BLes9UnNh0FLu+H/YOEC
	sCV0bRZU2p+pfizbRgAR0A0ebqjp9FxJnL8RfxjLNeUOH3VypJ+mgf2nTNaM81Rs6Tede9y+2Lb
	Etrejd3nZAWEsG5qNid7SnA==
X-Received: by 2002:a17:903:1a2b:b0:2ea:7180:3abf with SMTP id d9443c01a7336-2eb019a757fmr19414385ad.15.1793389148212;
        Fri, 30 Oct 2026 12:39:08 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e98f888sm9577767a91.13.2026.10.30.12.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:39:07 -0700 (PDT)
Date: Fri, 30 Oct 2026 19:39:04 +0000
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
Subject: Re: [PATCH v6 13/18] iommu/vt-d: Handle reattach of the restored
 domain
Message-ID: <auTxXD6mztQRp2qd@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-14-skhawaja@google.com>
 <faeedd16-a271-4ced-be1a-7bd70860bcdc@linux.intel.com>
 <auPC2pByvuW5uHyH@google.com>
 <84fe2789-7bbc-436e-9141-e879d2e90ef9@linux.intel.com>
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
In-Reply-To: <84fe2789-7bbc-436e-9141-e879d2e90ef9@linux.intel.com>

On Fri, Oct 30, 2026 at 07:38:54AM +0800, Baolu Lu wrote:
>On 10/30/26 06:34, Samiullah Khawaja wrote:
>>>>diff --git a/drivers/iommu/intel/liveupdate.c 
>>>>b/drivers/iommu/intel/ liveupdate.c
>>>>index 36816d3651e6..665ebb81bd61 100644
>>>>--- a/drivers/iommu/intel/liveupdate.c
>>>>+++ b/drivers/iommu/intel/liveupdate.c
>>>>@@ -394,6 +394,137 @@ void 
>>>>intel_iommu_handle_drhd_restore_failure(struct intel_iommu 
>>>>*iommu)
>>>>               iommu->name);
>>>> }
>>>>+static void domain_detach_restored_iommu(struct dmar_domain *domain,
>>>>+                     struct intel_iommu *iommu)
>>>>+{
>>>>+    struct iommu_domain_info *info;
>>>>+
>>>>+    guard(mutex)(&iommu->did_lock);
>>>>+    info = xa_load(&domain->iommu_array, iommu->seq_id);
>>>>+    if (--info->refcnt == 0) {
>>>>+        xa_erase(&domain->iommu_array, iommu->seq_id);
>>>>+        kfree(info);
>>>>+    }
>>>
>>>This seems to be different from normal domain_detach_iommu(), which
>>>looks like this,
>>>
>>>       if (--info->refcnt == 0) {
>>>               ida_free(&iommu->domain_ida, info->did);
>>>               xa_erase(&domain->iommu_array, iommu->seq_id);
>>>               kfree(info);
>>>       }
>>>
>>>why ida_free() is skipped in the restored path?
>>
>>The restored device can be removed and probed again while the PASID and
>>context entries stay intact. So the restored did is not freed in this
>>path. Once the domain is reclaimed by the iommufd, then it takes the
>>normal detach path.
>
>Can you please add a comment to explain this?

Agreed. I will add a comment for this.
>
>Thanks,
>baolu

Thanks,
Sami
