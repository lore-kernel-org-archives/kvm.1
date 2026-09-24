Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4784AD4CD
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272183; cv=none; b=jrWFbB8MFtKuZpnl9mUVdAm/V1uYudlZQAqCbSzVCfiXLF39QiuwqnHDHFqxve38bdrk1cdbpdzYHDnA/7A+gZKy8u8ki9DqsI/Qxz4zDWYYIZyztbIyWqbLR0WUblD/KqtfHzq40PYeTlNsUUG5v2DZtHWfZYIOI/pGcxkQ+Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272183; c=relaxed/simple;
	bh=TDcsYHIaw35uYfkUp8SSuaUhuxl/3WHswj8+KRQh5cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g85RuH0F2g/tCJTWqT5BUAZ+idww5cVszVNAMvlmbVcOrwgDhYVFIsfSlFSEnbi0zjEr3FJn15m1ryse8OMXtWbxNYjTB2CSDAbyOPqIXAMwYQqMLjVvBp8pfS2QXVesdxOHahW3f/xvS3Lu6CZ5OVnUjvxImTwbejn6uxunqvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B3va6LvO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B3va6LvO"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d8facae850so6915ad.0
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790272181; x=1790876981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dby+5gVayzal4X1RiSbAFD0yfNnYiqO5W3Aena5N53g=;
        b=B3va6LvOA5zo0WjSYx5SJjlwRF2kB2CR55XaBhG54cV5S6BynDG1IcCY3fEki+zu7H
         PnvkHPvKhBTpxz6cQHVqxx3O5bwLp2Ag54cFlbZWYDjxlDIVNp4nhp3y7kRF3oQOD3hW
         0xeAKS38jfVUwAroG5svS9rVoZj7BakkMWRoaBZjate38rgyX4omIQ46uxvotbu+Xaqr
         8x76w/zjxUuBWRRi3I8nti+tRNwjLBPpXqMhqOrXrxQOtvAkF7oPcSzTFKm8xDzaGzJQ
         jnEbeG2Gy342G7wm5+xPISV6YSDkIyObdgGovEHvV5EKqPMG71qEcA1R4Zv1xv72qres
         pYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790272181; x=1790876981;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dby+5gVayzal4X1RiSbAFD0yfNnYiqO5W3Aena5N53g=;
        b=teMBdoMg/YIvejtP8T5ZRSQznYjdR31++QXTrzWbCrG1e3y5ZIKNEOoVcnJc6KjaGk
         9x6MWiPvewAJ8t6EzcwLT1rQc/W4Ix/f/RzG8dq1ofEoh0CGp7N+uKo0/3xwxXjzlHaS
         O5/+t7/gB2n3VxU3PAu9QDxaQPE8TJ5ySkLL2XyYqWX3OC7YNS10GnKIsmWFWzEDtTXo
         AwElHjdjqoNKM5QQ53lbN1aBWKNOJYN4espFO3QJL+CXPUIY0giLQx9HnnF25wtV3UIl
         CND796cm12X9u9a2ymTsTgOCzN//mWcH+cDy1s97ajCFJfo6nS2JYHlxRDryBsNAXcRh
         //HA==
X-Forwarded-Encrypted: i=1; AKwUvBxqjkHAW3VNUX7jHQdpDD3OpnIFM/Wy1J1HhZKnM1xKjXmXpjD6fxvXE9Je67qIFPDh2PM=@vger.kernel.org
X-Gm-Message-State: AFuF++mhGuq8vSl+cVGXeMeESeTkctPdHvs7GRFv5W6XvOl2Vtm2bSvD
	E7p+BDsP2Se/4OiWlSafI1B0Fuv4RVCUEYyfdDUQFeQBBhkPrTZ8ZZyND/A6i+6+GQ==
X-Gm-Gg: AYBFou35f/CSp3dO+Rr4qdL4ausWFhNw/c6CzHg+Lg3uYTzP23HQoGr7prKwY23Q/R8
	EffzZIqFErjx0qKh3xVBfk7y3td48vzM2eaHu9D2MF1joxN+Sf143cu77XvJ1gmsnBzEpuupqdS
	Qd0gS1aSzTljGWFeK7rIvPk8s531CTzbXB2FFVrSHl5QTZ0Ixf4Ri0+diRm1OOsB4d7mGX6Cwvc
	shJnzqgTi3qYwO6DV8ykRgFiE2ClP8+8hfuP24jUnAP2OPOpJYiU/AE5gXtY2dBzKoFq0nfgVmp
	SLZ3cYEGIiKU4iN7b26DdkNbwwth5SkK+0ndZkB7s6wBlI0NkaEy8QJUibL1UGWBBh6U4A85zmh
	NOhBNJihPI6ORbWPXuhMACvMqf1IQb7KPASNWp+gp8C4X2Sulq0lBmO/2Nnk3HmN/RDH5qESq3J
	O/PvAaLMrh2KZGdAe2VJ7rBVGgYGF9a/fPDL6zmXsYcImnhiGTpdLnqpd1YWZu+OYFq+94Y1jlN
	nbiE6saXofrjRSnXHRnf56BqHm/9fxltdMrzzviZWeR9sDPC66k/KhyMuYZ0yBxfooQEQ==
X-Received: by 2002:a17:903:1aee:b0:2dd:3a08:d47b with SMTP id d9443c01a7336-2df90f4fcbfmr274255ad.13.1790272179931;
        Thu, 24 Sep 2026 10:49:39 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b2235811sm595000a91.7.2026.09.24.10.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:49:39 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:49:35 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: John Starks <dev@jstarks.net>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, John Starks <jostarks@microsoft.com>
Subject: Re: [PATCH v5 15/18] iommufd: Persist iommu hardware pagetables for
 live update
Message-ID: <arVYa_90j0oN1hnu@google.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-16-skhawaja@google.com>
 <goxdwq6ny332pnrojvp4nuz2mliofd3yxd73fpjnbesq3e34fe@jq4d7v7rbwx3>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <goxdwq6ny332pnrojvp4nuz2mliofd3yxd73fpjnbesq3e34fe@jq4d7v7rbwx3>

On Wed, Sep 23, 2026 at 04:59:30PM -0700, John Starks wrote:
>On Mon, Sep 21, 2026 at 12:48:31AM +0000, Samiullah Khawaja wrote:
>> From: YiFei Zhu <zhuyifei@google.com>
>> +
>> +		/*
>> +		 * When this memory file was mapped it should be sealed and seal
>> +		 * should be sealed. This means that since mapping was done the
>> +		 * memory file was not grown or shrink and the pages being used
>> +		 * until now remain pinned and preserved.
>> +		 */
>> +		if ((pages->seals & req_seals) != req_seals) {
>> +			ret = -EINVAL;
>> +			break;
>> +		}
>> +
>
>Is this sealing business sufficient? Even with the specified
>seals, user mode can still punch a hole in the memfd after it
>has been mapped. This will disassociate those pages from the memfd
>but leave them referenced by the HWPT.

Nice catch. Since punch hole doesn't change size, the shrink/grow seals
will not stop that from happening.

Once the memfd is preserved it is frozen, so punch hole is not allowed
after that. To catch the punch hole between map and iommufd preserve, we
need a truncate count on the memfd that can be checked here. Or we can
iterate through the iopt pages and verify that they are still associated
with the preserved memfd, similar to how memfd preserve already loops
through all the pages. I am inclined towards the iterative solution as
it handles all the future cases.

I will fix this in the next revision.

Thanks,
Sami
>
>Then, when the memfd gets preserved, the hole will be filled
>by a new set of pages, and only those pages that will be
>preserved across the kexec. The original set, unless I'm missing
>something, will be dangling in the HWPT, allowing attached
>devices to DMA to the wrong memory.
