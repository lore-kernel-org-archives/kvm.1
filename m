Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5E12DF128
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790890911; cv=none; b=bt9o9yDK1F+VuYYqT19xu1X0GIbTXGmzOef1gFbfTFRxk6lSR8clcUAyOPpI1rNT8Hb9Vtuvfu7J0Pp02AQd0AYuQbSpqhObGVKvJbI+fMRiq8Xo8aHwRZKPFEadh7DkXfATeoA4ZgXiQwPr4nVz2gjBWRGmz381SMW3SzQhY+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790890911; c=relaxed/simple;
	bh=fPmxCx4qpK2t/MvuNp/xRsfzossr1PfbTfKiv5o2cf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7dk0pgrSetzho2wjYRO7HVI2flgz8o3s3lrSL9b+G+IHFtp6G+8vaVkqvKiUfSBWzN9rM1fTQ01KZf22GzHF0rIv0Vy6QT3ddEOPMVoSTAlr4NzFm9h/p6UUQ75ilVdFJWSagtXZQuhnK43RC4L3+ms0vi/bW1qkyzsjHK4zPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RX++VI9A; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rjOxJ8dO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RX++VI9A";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rjOxJ8dO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790890908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oaFDnLPAu8Azz5pGOzAaVOnZU0E7BdpohXF2E62Q87s=;
	b=RX++VI9AHz5vfn1fXYGsJfzS/rX7vXXI4rJuNUvFppKhaITyoLWRLw9omTUWXFJST5ZtyT
	mzBMzz7ee/JK7/G2jDNF5l+9qMnoyP8PF8+K814IJTwbhBTnsXywQEQfl0OUSmG/d/W+XY
	7zdvy1hQhQgvTfOPZ0H2mdJOnWcjwvs=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-eLF3nx6TMCmYuDkDMtXUsA-1; Thu, 01 Oct 2026 17:41:47 -0400
X-MC-Unique: eLF3nx6TMCmYuDkDMtXUsA-1
X-Mimecast-MFC-AGG-ID: eLF3nx6TMCmYuDkDMtXUsA_1790890906
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc7d2ff0087so2213546a12.0
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790890906; x=1791495706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oaFDnLPAu8Azz5pGOzAaVOnZU0E7BdpohXF2E62Q87s=;
        b=rjOxJ8dO5ltGvsD28IzEJPTlWVslhMZA3I87ouoh+eHbKd45Qpo5EIr/MGETujaScn
         +W9w+TZmHWBiPoMMzvJLAbHgKD977QnBgLjgPyOGYjvdM80ipOe7wG4rkrU6oe9he48t
         HDJHFR4puRanLbzoaV7PLlxSgaTnWz8xojcHIcYSAiFIEiSZVU1UhZVPUcvoJUZfXhFT
         LQLGsqR2AEQcWsh+GEKFwmg8eJIkx4F/lUa7jDfkJ7U9sruQBII2/HEbXOb9Cvz/LDpi
         gbuKx9Fhd6m8UjikhLuIE9cnemCFlFKXzLfufF2ovyo01VgRHHIDpS4tEZ/D9yNwYxs3
         g1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790890906; x=1791495706;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oaFDnLPAu8Azz5pGOzAaVOnZU0E7BdpohXF2E62Q87s=;
        b=k+BAimzdancguOQz6/1mhI+yo16J1yIpdsX3A6EAcJdFjGxpgn2whQx5VjbJBRLgQ4
         rhkC6B3EGb1wjWcrWPgZ/fQ0r6gj/yVbdGaGdSIaOvmNeWS2cOhe3kP6cMpJexyEo1Yr
         9tAsEvJPsQDOAlQcT+AYwNNQ60E96LNRvE2oNMDq6RBdDpQzPfH27GCU9zG2SmKYWFVZ
         ira4xapvitPDsoAP+ElUElB7rarThpJ9+fcZhb4dFo2rQ1pis2w/r1PeiCY2SP3Rif3a
         ejjuFx8D+cyOBEUS2iAA1/vt51OOeoq4wBIaOOKfuai0lj2P+GPzlE8ymD0ibJnyN9tD
         ERkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxnComvbGF+J2XROccEZTvmBMqvV9og9MLD7LvASGiZjlB9DSoYVN2/F8jIKVsJICXesA0=@vger.kernel.org
X-Gm-Message-State: AFuF++lZbrsYNYZYqOcsltUrw1s0soFYFGRU0kyvwqQMZojWF01/zAFM
	Kd47wnAUzXPEwXkYfmlboe6PNOVlj/16fSwDcYCOAiGeTRyn37AZwywqS5Rxk9vG0fb09iU6Rz1
	N1b7MG0OGTvl7Z7M2c6Nr8UCNesuuiEzNlZix3OBIdklVH8I/bMr5oQ==
X-Gm-Gg: AYBFou0rP5o86oVWkKbwx56ZuFFM1aUoRVA17+OWVFn5BorCr11fui2EWiizXVQ6XaQ
	Vggy2PfsiczD9tnSLgetogKn5/tDoX0tufB+KyztPLO8n7//94LhtfSgqcFT8QWaz23VuWeyh3w
	oMYlmcNxoDMPQ5NNX/mmfePRckFpS30WHzHQ2OkeHH6y1IrEg+6V1sKzMCWpzaRuJj7DU3FMrXl
	PCamyetD1UJbXLm3z6LwPRGAxO/lZ/UAIaETvWSgEIPnI63b2+YXnBifPf0OvTJ6a2Nr0bq5dQK
	65zrNjtt7pn/Z+toVkxj7k4+3Zll7JU0TA1DIDOMliBmqze5qx69qHoCWFAXsW9JhxuzNqpDtia
	VZXdlmweZtQeI5LFPNR4uBhv6qnVCz4+u4j6O6ka3GQ==
X-Received: by 2002:a05:6a00:409a:b0:882:1b4d:1840 with SMTP id d2e1a72fcca58-88af58d4e46mr745874b3a.24.1790890906230;
        Thu, 01 Oct 2026 14:41:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:409a:b0:882:1b4d:1840 with SMTP id d2e1a72fcca58-88af58d4e46mr745848b3a.24.1790890905746;
        Thu, 01 Oct 2026 14:41:45 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0cb72834sm165561b3a.45.2026.10.01.14.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 14:41:45 -0700 (PDT)
Message-ID: <1ed590aa-a4bf-4980-82e1-185aee205909@redhat.com>
Date: Fri, 2 Oct 2026 07:41:37 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 00/23] KVM: arm64: CCA: Add basic plumbing for Realms
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com,
 sudeep.holla@arm.com, jonathan.cameron@oss.qualcomm.com
References: <20261001210703.1597150-1-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20261001210703.1597150-1-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Suzuki,

On 10/2/26 7:06 AM, Suzuki K Poulose wrote:

[...]

> 
> NOTE: There is a conflict with Fuad's patch to drop the WARN for unknown vm
> ioctls, that is queued in fixes.
> 
>    https://lore.kernel.org/all/20260914093838.1082637-1-fuad.tabba@linux.dev
> 
> This series is comprised of (3) and (4) above.
> 
> The integration branch has been tested with the following components:
> 
>    tf-RMM:   main branch (commit 5e6e2acd) compliant to RMM-v2.0-beta3 [4]
>    kvmtool: git@git.gitlab.arm.com:linux-arm/kvmtool-cca.git tag:cca-kvm-v20
> 
> [0] Arm CCA KVM Support v16 : https://lore.kernel.org/all/20260803134403.80630-1-steven.price@arm.com
> [1] Linux firmware RMI v22 https://git.gitlab.arm.com/linux-arm/linux-cca/ cca/cca-host/fw_rmm/v22
> [2] Linux GPF Host  https://git.gitlab.arm.com/linux-arm/linux-cca/ cca/cca-host/host-gpf/v19
> [3] https://git.gitlab.arm.com/linux-arm/linux-cca/ cca/cca-host/kvm-v21/integration-v3

This branch doesn't exist. I guess it's "cca/cca-host/kvm-v21/integration-v2" instead?

> [4] https://support.arm.com/documentation/den0137/2-0bet3/
> 

Thanks,
Gavin

