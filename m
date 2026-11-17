Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794887751;
	b=d3qXvbBdD4Vdwvw9+iPVKuxZJF3C6oq04Z2QxvK7MCC87lr8d908Y+BeXDPUAGoEBuwY
	 qx+PFFpoTxtVAQXpvZK/P393mwV0oumyxqMept/3WOtHjlqxePRSDqMiqeKdHfrqVcYqU
	 4+pNw5BPsJbmuLIOefY4x1jPEfJ+1FUTNb/0mBymXlqT3ObcsQlg9VKezeo1PMQhpYyWN
	 nkyzMoqrcBH3jOORZBf/GSwv7RzoEzIg+OT3vAqWy+MFZ5Sh9ef7KQxGcoprcXt4DDt/6
	 UZBWbFJ+ykWjyDJd47kmMwuft/wRRtV9FV1ZaDeb3kyscKCzZU/E32+FTqMPW7yPzWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794887751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=mygYInQxR58p7J21QOwq1w85iqa2FjsjKi0zK68sH8M=;
	b=i0Ajtt942/fHzxnFpPJX5VW1pjOjlJnqMnEyhLEyyksReDrSeenS1zmpCiLZlFiVb7G/
	 +pW2np+gU10JWJwNHvzC2eOj7OLuikW7N//tUAXPyFLphmohU3UapL/HEclznZpXMTwUz
	 bwJn1igaryfnOpg5n28YYNxKBMozD3RE5yVP1esKVtz7e6pICTykdTZkFrc1+q6BgVcK8
	 GqTY/S9ddFvPLAu+shEuGSIUSiXaZmV+7tAa/xXVtDsuUCTf3bG8JThTbCtOQGKZW1UK2
	 DTDAaWKEbM4j/MTcOTkmaiJTofjFFYU1l/DpCZZHWssF+uk2Z6KkFK4lv3jBlvJmCcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="LBjd6o/y";
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7FA606A329
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 03:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F7FA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LBjd6o/y
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ee254f6eefso44885ad.0
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 19:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794887750; x=1795492550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mygYInQxR58p7J21QOwq1w85iqa2FjsjKi0zK68sH8M=;
        b=LBjd6o/yAggU52OhlodXDqJoVcvYEbBnB0WOCq8zJnkRdo7EzOHYqX0NeJrqKrnaAo
         eF4weWGdQOJCbg4oYMCs5ImotDaotpgDwm2+1JqD77g2dC92z8MVsAbQpwGepXdNezQN
         kq3scDPx3LFheFo0FxDxIGFB3F8h//x7TfrvqHsB+yVIJk+Z0bMzpzMFiUNEzcMiRZbV
         qWJ/ui2NdhfloZ1MbzN8Qv1REspTiWO05oFJXTvEB94eUXHFCazsrA97vyIMbxdiBzp3
         mz6yGvDqVZYkuGAXy57lafEUdi/s7mIctPNbmGOLgVr4VbcjsJkeEtVz2xDdLizhVOWP
         QXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794887750; x=1795492550;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mygYInQxR58p7J21QOwq1w85iqa2FjsjKi0zK68sH8M=;
        b=MekRN+XdkvWltIlffbljuMXGSMt9TxmAxT3e/VXXPO197Q3WPwpt90h7QFSmlhtqa9
         KrKGDxeiehR7wI2IsUhSJHdnCgIaSSCuipsu0uLsNPJUWPbw9OHRZTpAiUIPx96nszAj
         Xiaznjj2MrnHg+puzWGswL9Bdlpf/LOQhe3LZT+rkjBgIbU/m7F85Pt21B8Yvq6opvMz
         KdVqsP6aX9KtQWUqIuojOM77p4EjJevp+RUaTXKmNk0xhtj9aJ6OWSCFlTEqzuVZXLVG
         YQQ5CaACzMzfwPoTSYPDHmIE4ldnAyDZPtUPCYa3cV59b+XO1A35UHMuNkW+6A9u48jw
         7noA==
X-Forwarded-Encrypted: i=1; AL+hErHMKw8WC3SW4qDpc5SsPq20rRyyYCyLWowDr1XIAASE+CAk/cF9V8CT2sxcuiGzSUitjIc=@vger.kernel.org
X-Gm-Message-State: APuU4Z93AMvpW3jbpi3cHHVEJqyxljihUq/i4mV7JlNRwFe6eaTGH/tf
	ae91ADUxAE0cDboOM+aXMKCBrzGWgMMHx+5+haylP4e3ubQfBNezaiFfuXZ2ijCxOQ==
X-Gm-Gg: AZFdTZen1KsmexOT6kuOV/W3nSVwodCTRCxsZpPMuBZPyrIw0yiGMJNkluwVanjrUqX
	agEjaDhWJMhIL6IvKUx3zLkAMRmJgfhI9X55YX1oiZVPJyujyoJRBsHNyiEL48zVwRFViYnLgpt
	UyB5e4HzLgMtePn56alqxQBs2GRkpOUb6TSXWZh6tGl7Br4dwO1xiTijNGXUcmI/LGnHhakPN6T
	VhFwGs15ptMaE+3rphQSiqYCq8S3PGIQnpCvHEZifu0HCZ+HlWcaNV5Dg2iwZ9SPC69uNKZ+ZTi
	Gr5tymCyinAvojU/DPgAV5Z49LxXdSDu0jle7+8ZbTClazUu5acaRFJvVWsbw0T0TlJfYbi5PVn
	0E+4O07ekPSiEPreandJrMEH+UA3rWORAmotsXoNJXNcxQOXeWB7oajhcgOQFYfU2SgCuPt+Hqv
	VOii1ipJjrcWWMSMnFXNDbY1QLDPOV3rtB4+YfnVBU2I6oKUBqL4+pO/MQChRS0+oJLRXDgbO+W
	qG4CWjo9AE/qQ+5De2kAc1QDEXzvFBlBahuIQ+KPVvCt1s0s/QlAL7n/P4LpU7waMkVGyuohExC
	tbwns2EENtQdDcZ/RzlEesvvgPaFIfGEd1AIGtEs7XUnsD0D1HZPPGzNO/2JwhUuY3Qjp2gavId
	KvDJRjsIylENv4FnRiCMQ7w==
X-Received: by 2002:a17:902:ce04:b0:2ec:f228:764d with SMTP id d9443c01a7336-2efdc8db07amr2084325ad.18.1794887749194;
        Mon, 16 Nov 2026 19:55:49 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a818asm4348658b3a.17.2026.11.16.19.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 19:55:48 -0800 (PST)
Date: Tue, 17 Nov 2026 03:55:45 +0000
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
Subject: Re: [PATCH v7 12/18] iommu: Restore and reattach preserved domains
 to devices
Message-ID: <avvK73lUs9RXdl0-@google.com>
References: <20261110040828.1774343-1-skhawaja@google.com>
 <20261110040828.1774343-13-skhawaja@google.com>
 <0a38ae25-3eac-42f6-862e-3dc1d644ab97@linux.intel.com>
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
In-Reply-To: <0a38ae25-3eac-42f6-862e-3dc1d644ab97@linux.intel.com>

On Tue, Nov 17, 2026 at 10:29:37AM +0800, Baolu Lu wrote:
>On 11/10/2026 12:08 PM, Samiullah Khawaja wrote:
>>During default domain setup, restore the preserved domains by restoring
>>the page tables using restore() iommupt op. Associated the restored
>>domain with the iommu group of the preserved device, and reattach the
>>domain to the device.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/iommu.c            | 115 +++++++++++++++++++++++++++++--
>>  drivers/iommu/liveupdate.c       | 106 ++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h |  39 +++++++++++
>>  3 files changed, 253 insertions(+), 7 deletions(-)
>
>[...]
>
>>+
>>+/**
>>+ * iommu_restore_domain() - Restore a preserved domain for a device
>>+ * @dev: Target device
>>+ * @ser: Serialized device state
>>+ *
>>+ * Restores or reuses a restored preserved domain for @dev from serialized state
>>+ * @ser.
>>+ *
>>+ * Return: Restored iommu_domain pointer, or ERR_PTR.
>>+ */
>>+struct iommu_domain *iommu_restore_domain(struct device *dev,
>>+					  struct iommu_device_ser *ser)
>>+{
>>+	struct iommu_domain_ser *domain_ser;
>>+	struct iommu_flb_obj *flb_obj;
>>+	struct iommu_domain *domain;
>>+	struct pt_iommu *pt;
>>+	int ret;
>>+
>>+	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
>>+	if (ret)
>>+		return ERR_PTR(ret);
>>+
>>+	mutex_lock(&flb_obj->lock);
>>+
>>+	/* Preserved device should have a preserved domain */
>>+	if (!ser->attachment.domain_phys) {
>>+		domain = ERR_PTR(-EINVAL);
>>+		goto out;
>>+	}
>>+
>>+	domain_ser = phys_to_virt(ser->attachment.domain_phys);
>>+	if (domain_ser->restored_domain) {
>>+		domain = domain_ser->restored_domain;
>>+		goto out;
>>+	}
>>+
>>+	domain_ser->hdr.flags |= IOMMU_SER_FLAG_INCOMING;
>>+	domain = iommu_paging_domain_alloc(dev);
>
>Ah, here it is.
>
>This allocation uses the driver's default. For VT-d, it prefers first-
>stage translation when supported. But the preserved domain may be
>second-stage, for example if it was allocated for dirty tracking or
>nested parent. Would the restore callback then walk the preserved page
>table using the wrong format-specific operations?

Yes, that is a valid case. We can store the allocation flags in the
serialized state of the domain so it picks the right domain format
during restore. Note that in case of dirty tracking, we do not
preserve/restore the dirty tracking state, as the restored domain is
immutable and will be replaced with a new one.

>
>>+	if (IS_ERR(domain))
>>+		goto out;
>>+
>>+	pt = iommupt_from_domain(domain);
>>+	if (!pt) {
>>+		iommu_domain_free(domain);
>>+		domain = ERR_PTR(-EOPNOTSUPP);
>>+		goto out;
>>+	}
>>+
>>+	ret = pt->ops->restore(pt, domain_ser);
>>+	if (ret) {
>>+		iommu_domain_free(domain);
>>+		domain = ERR_PTR(ret);
>>+		goto out;
>>+	}
>>+
>>+	domain->domain_ser = domain_ser;
>>+	domain_ser->restored_domain = domain;
>>+
>>+out:
>>+	mutex_unlock(&flb_obj->lock);
>>+	liveupdate_flb_put_incoming(&iommu_flb);
>>+	return domain;
>>+}
>>diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
>>index fb1e8efac8ec..68c7ebca25f6 100644
>>--- a/include/linux/iommu-liveupdate.h
>>+++ b/include/linux/iommu-liveupdate.h
>>@@ -99,8 +99,31 @@ static inline void *dev_iommu_restored_state(struct device *dev)
>>  	return NULL;
>>  }
>Thanks,
>baolu
>

Thanks,
Sami
