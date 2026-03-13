Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D3034C123
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773427804; cv=none; b=N9tn4ojvdneNlsnkIGtTBQOifSo6TwqAcxWrzLqrCk7BkjtO1fhHNDYtFEL14IMklUsoB3xEOgsbbfzYnal1tm3Kx9CcxyX0ZVe/6/b24sfbDd7JUIp6+kpXhN3Z6I9UnE2GGahGN9bqhyeNeuecg8NXNeF73Bv1ZrtEuBsM0I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773427804; c=relaxed/simple;
	bh=Cgw7rgg052jBwsBm6FVNyDCSrT6homGIa8xXe2Nl/LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q96HPLkibocpZyGiX+vQN2PyVusQolc88hy+U5gC3BG7bEElu2Lwkib0cyUFhi3pu6Bx1d6yqPID8f2bdCQmsWrenIA82tUwGPB8220aP0WkOPWUYuPpiJUTKSJhvxKoGn6mYOH4AYAOxFqPUZ8OvAKOjlY29YDKR9EphYRlOWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K9YjvRks; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K9YjvRks"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89a09ef1e3aso33131936d6.0
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773427799; x=1774032599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OmAqHdmpJRsgkjLn2CzcNC2LkQHnurZaGunyWBb1R7Y=;
        b=K9YjvRksQY3FFeQ1Ul8m4OwqoG7uRV5kVSzI34hshgibVjh6/iaT45ASgrVOQuoJEg
         KwUdmPbcljGdyjVhm/gOMEaHWAgp1v2h7M7gig4pqIgrC6Rbs5UxisQd914AdmoyeEGr
         blDcFL5b7aT2kBHnl3OkryosFmHAJ5jrk4boo24+f0/raau9ruT00S5KaquvO9on0dzb
         hq7e6E0cLQqrEQSkWqOPiFB2c+qduQfWrQmwJhTWL/AFjGWhN5Ue7RSq1MN0vSRtX+X1
         DUb0y6gOdJDd1J17SswISjCZgrZcBhdygZycT0P97u+0taLLxLf2FEFPOtrinVCcoCZZ
         3byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773427799; x=1774032599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmAqHdmpJRsgkjLn2CzcNC2LkQHnurZaGunyWBb1R7Y=;
        b=oey7cuMFfDQAWMh/gsRIToHTC8rJnm+jAoVY6kmnNjc2NhI04JweMabNZfaC0B5QPx
         ziSC/spHnCEoxJVf54Q6rUIrCwnY/WvVE/dtGCFCH7hFSdnBC4mdrIe0FcVi/p/PO1Nb
         eqWKjd7YqswcPsgaaisfTKL4ZSmL70GJDDExPnAjDi49I9ql7X2botH/BlNdzVzyYVHJ
         sIZkE+fcpOYGXn7LB/0qHu2GCwcZzY//C3mH+ROkkdcyihgY+6hJKPnOd8emb4np8FE7
         4ceaA+qd2uvu9o6EdIkCROZrDWIKJqn/9c4ehCvHHXZ38z6snQpsa+ZVEsZM8va+RO72
         Wh6A==
X-Forwarded-Encrypted: i=1; AJvYcCXCo4PcKFZUS9k9fk+J+B5w79ilXl0r2TH804P01b4KYVB8Sky8qwtd8UkLvC+/I9YfQwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx8eLZ5ssJEAgXNsdVBIPNnsfiUDbj9llyefqMg6gmpOtXh4iM
	N+O0gESVW4QVqBXFsRxnUiI+/IPHblkxkcvTcwan+MttDJd3h9TUiUyrP5MyMHS45IU=
X-Gm-Gg: ATEYQzwxkTKWo6yFEbRvX5+aIVvnN3IKdif0niZ5G2POLyrNGBY8bTspCVKX86vM/2G
	3esKbV+JuaxH4RoR47Q6l0uzMBE9cgnEwQ3ovzDORWU8xuASip1aIy2grlw8TzpDEOQNoYDLpb4
	o7s9bfHJRN6w14+XsHWntNPVAXNDamnlGoEV2WIivrnnWv6uUkSQtdnMKQK19dTvqhktBtoleIQ
	xXiFEdeWE+ms5gG2Jp84NV85MF829EnxsfokP18kGjkcFythOly1+AbUavokl2zkflO2E/79aTe
	3lOLX7cMaxJB5AeqWtq+HTqSOuHosI36huwbl0hXyPdTqbbxxNKvdB5LIZMNPUbkiwVezRUjJR4
	7bhJwNNa4y4FXxfFpMQnOi1JCgYbfKob9bpUeBw4XWOmoaYVQmiPL0FUilxyHUdHy9LAnX1jeao
	mFz6lRxmMq5VxA1IsZ+IhGaFk2NiMwCyPGimwtU+AJzIbXwwp4ridJeML5cE9mcsqfI0yMqNZcM
	plgU+fs
X-Received: by 2002:a05:6214:1c0b:b0:89a:ff2:b8d4 with SMTP id 6a1803df08f44-89a81ef3356mr69685496d6.36.1773427799050;
        Fri, 13 Mar 2026 11:49:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65bd318fsm60836326d6.8.2026.03.13.11.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 11:49:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w17a9-00000007M5A-3jdN;
	Fri, 13 Mar 2026 15:49:57 -0300
Date: Fri, 13 Mar 2026 15:49:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 3/3] iommufd/vdevice: add TSM guest request ioctl
Message-ID: <20260313184957.GP1704121@ziepe.ca>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-4-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309111704.2330479-4-aneesh.kumar@kernel.org>

On Mon, Mar 09, 2026 at 04:47:04PM +0530, Aneesh Kumar K.V (Arm) wrote:
> +/**
> + * struct iommu_vdevice_tsm_guest_request - ioctl(IOMMU_VDEVICE_TSM_GUEST_REQUEST)
> + * @size: sizeof(struct iommu_vdevice_tsm_guest_request)
> + * @vdevice_id: vDevice ID the guest request is for
> + * @scope: scope of tsm guest request
> + * @req_len: the blob size for @req_uptr, filled by guest
> + * @resp_len: the blob size for @resp_uptr, filled by guest
> + * @req_uptr: request data buffer filled by guest
> + * @resp_uptr: response data buffer
> + */

This needs a much better kdoc.

Refer to specs that define this.

Explain WTF scope is

> +struct iommu_vdevice_tsm_guest_request {
> +	__u32 size;
> +	__u32 vdevice_id;
> +	__u32 scope;
> +	__u32 req_len;
> +	__u32 resp_len;

do not leave implicit padding, add a reserved, and check it is 0

Jason
