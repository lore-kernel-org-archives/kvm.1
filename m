Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668692C11E6
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306646; cv=none; b=hwHujnLmJagSKtcN6UqNPh9eG6+uYHGtIunLyK2urjWzC0N3Nv+DJ/RLhcAOJwP+y7LleKB+IqAQpgz4Q2rWs1cgz2snUqaq6mPCS8cEXxfsLTfgI1k6320/s7V/7at2kL6NzSVODE/AJuW6IP8630/Ul0NhbJ9lm/l9XaQ5YdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306646; c=relaxed/simple;
	bh=38oreodTd3a6pgd9iHihqPkmarP5WZdM5RpNKRkZshU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWqvSMvjcM4035s2rxrVj9RaCEbjHWRJFXFDzhqX40qmzFrIzQmZC9rm3Y1cwfysXth8Az4N+o3iKvC6m1KzqVXtP5Emx4a9aFp2T3U3iv1kPtJRUbg4fsGbrNY+r/kcT0R5GY86A7Bfu3+kZ3hvvlMObf46J8mYAtna0LjJKPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qOkM6CJ3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qOkM6CJ3"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b46da8c48eso1135ad.1
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 12:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779306645; x=1779911445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zGlZIIGtCBSMFz+AR7h4nxPLAjxI6s+Py2Of2qTbbXE=;
        b=qOkM6CJ3PRTIuXFlbIEte4u+2ePR75ptmPuG2AH+B2HVX3inE5WOBxxyWtS7kLmTPe
         nEVG1uK0cEQa941gTNQ+qQ5femZeSPLN/qmEsAPNLhGroRMsPs0Pu9QjGHbUq5GX6DL/
         EKxpFeavb7BsKEpInoZYBasq1TSnMmB0mCSo/+Q9x0JuNYRR2MdQyEvp+ymqD1C5qYel
         8jsrTfPouc7qRdktuBaD6LEpoWJUI9BBC6rJs6rkcRsdJTaK9DYQJnfABUEVUBFO3S+G
         GiIIRfNYeGD14Z83995wDzSZMk9lZEJ/Byv34q6EijImOuwTV5cmoUdfOetPrM6Rzxr/
         R7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779306645; x=1779911445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGlZIIGtCBSMFz+AR7h4nxPLAjxI6s+Py2Of2qTbbXE=;
        b=IB2YVdJeTtndB5IaAtiNYAhXfj3mN00V6GhmfA+bu6Zv+bQaF4dz1z/HUyhnGr1YbQ
         9q6i599fzKioN80uk0vsISFwo072qICi3jhpCDNgxOiNPTgcyx5XC2PoQJzjj9gz6wE9
         +mkPE9qvuUWiKrDHCiIEfB10KRBCrNXLVwbn2haieZDg0p11tAyGrc2jU/A2g9bhrRd8
         D6KsHeEkbLuqdba0tOTc3xASHuJe1nZD/QwDeXjH4a6ietPOMWMdPzgQ5peX7jQgYP+d
         8Dx2Y9OTZ5gq0/I5cjr7eN9NivpbNqjXvgT8FWfs+ceBwMBVfMgzYbj+60DGlCgZZSWE
         Gzqg==
X-Forwarded-Encrypted: i=1; AFNElJ/JMqbMCv9FISopQvsWaNAtbtrLd9t8xdn/pmwXVCmjD1YEVioxlFASHk2B++yXFhHdQbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrhXZNHsGDPetk/eAJ/ARvyRGbxIFbruXN5o/6xlt/jfWgLaNT
	SXgiQJn4cjRgZRd2eoeJJt4rNvATI8Y+Fi5kpH9W9uGB2YTPA+lUEhzYjHts5iAUQA==
X-Gm-Gg: Acq92OFl6yQZt8UGSql/Oa4SkRZiaLwT+eTqMqSCEmL4UfBYw/9xOGNJ9mHcscZYIlx
	LKA2nrELDm2OZM8KItk2VRYeiRm4nanFno2ZFQ5ikAV9Xu5IkVbn+Y+8BDC4Vv/7mB5WA8Ok28x
	1x26fk6z9pvogVVM4stUDclU0+0AHBXY7nPkgO1tr7h3k8+98HDC2KiFIFfIILxy4o+hRDducUM
	Z1Dm690wbAPd5M5VOtROFTgRXoZgFBKhoLwC0oTnWCZLEY8CAeCG1Vpn18LV632nNm51OKClczm
	jvll1jak93DuFdL920pDTaxdfGDpimD2tXpzUgtwmWW8yJYyMSJu0Nm6GGibHLcwOuUb3BeUjKg
	xfVywJ581UwOJMY2vAUK9Qyco6cQNUfHDwInPY8Gn22reHCil4A6YhpTpFg8rOUsksxSIbBY5kQ
	3jn+urnmXRfM882PxHaw9X+R808LEEhbXGH6L2XDotoGgwuAfQsgp6KlxaSdbm2mtEOqDB0Q==
X-Received: by 2002:a17:902:ce0a:b0:2bd:6dad:3dfd with SMTP id d9443c01a7336-2be9f6d571amr560625ad.27.1779306644147;
        Wed, 20 May 2026 12:50:44 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84149619c9dsm224416b3a.36.2026.05.20.12.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 12:50:43 -0700 (PDT)
Date: Wed, 20 May 2026 19:50:40 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v2 12/16] iommufd: Implement ioctl to mark HWPT for
 preservation
Message-ID: <ag4QQRB6g7BkANj7@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-13-skhawaja@google.com>
 <agzsngLHDmoD3JxT@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agzsngLHDmoD3JxT@google.com>

On Tue, May 19, 2026 at 11:05:02PM +0000, Pranjal Shrivastava wrote:
>On Mon, Apr 27, 2026 at 05:56:29PM +0000, Samiullah Khawaja wrote:
>> From: YiFei Zhu <zhuyifei@google.com>
>>
>> Userspace provides a token to mark the HWPT for preservation. Note that
>> this token is not the LUO token that is used to preserve the iommufd.
>> Once all the required HWPT are marked for preservation, the user can
>> preserve the iommufd into LUO. The iommufd will preserve the HWPTs that
>> are marked for preservation.
>>
>> The marked HWPTs are tracked using a new XArray mark protected by a new
>> liveupdate mutex. This mutex will also be used during iommufd
>> preservation to protect against any race with the mark preserve ioctl.
>>
>> The HWPT token will be used during restore to identify this HWPT. The
>> restoration logic is not implemented and will be added later.
>>
>> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>

[snip]
>
>> +int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
>> +{
>> +	struct iommu_hwpt_liveupdate_mark_preserve *cmd = ucmd->cmd;
>> +	struct iommufd_hwpt_paging *hwpt_target;
>> +	struct iommufd_hwpt_paging *hwpt_paging;
>> +	struct iommufd_ctx *ictx = ucmd->ictx;
>> +	struct iommufd_object *obj;
>> +	unsigned long index;
>> +	int rc = 0;
>> +
>> +	hwpt_target = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
>> +	if (IS_ERR(hwpt_target))
>> +		return PTR_ERR(hwpt_target);
>> +
>> +	mutex_lock(&ictx->liveupdate_mutex);
>> +
>> +	xa_lock(&ictx->objects);
>> +	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
>> +		if (WARN_ON_ONCE(obj->type != IOMMUFD_OBJ_HWPT_PAGING))
>> +			continue;
>> +
>> +		hwpt_paging = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
>> +		if (hwpt_paging->liveupdate_token == cmd->hwpt_token) {
>> +			rc = -EADDRINUSE;
>> +			goto out_unlock;
>> +		}
>> +	}
>> +
>
>Nit: What happens if the user calls this IOCTL on an HWPT that is already
>marked but passes a different token?
>
>The xa_for_each_marked loop will not match the new token (so it bypasses
>-EADDRINUSE case) and the code will silently overwrite the HWPT's
>existing token?
>
>Since there is no unmark / update UAPI, It can be a fair policy as well,
>but maybe we should call it out explicitly, maybe a log like:
>dev_warn("Overwriting token to %d ...") ?

Agreed. I will do this.
>
>If NOT, then we should avoid overwriting the token and scream with
>retval like -EINVAL & dev_err in dmesg.
>
>> +	__xa_set_mark(&ictx->objects, hwpt_target->common.obj.id, IOMMUFD_OBJ_LIVEUPDATE_MARK);
>> +	hwpt_target->liveupdate_token = cmd->hwpt_token;
>> +
>> +out_unlock:
>> +	xa_unlock(&ictx->objects);
>> +	mutex_unlock(&ictx->liveupdate_mutex);
>> +	iommufd_put_object(ictx, &hwpt_target->common.obj);
>> +	return rc;
>> +}
>
>With those two nits addressed,
>
>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>
>Thanks,
>Praan

Thanks,
Sami
