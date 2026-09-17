Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D245C4E2F31
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 11:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646181; cv=pass; b=Ns4k3/+fQ8x3LEol+DckfUx2fBHzR5dzLhWfjGyq27Eo0QRDyDkUrIhQiFZPt2KvRU69qYOPz8WBKGi+1ttFZVSIg6QxrRKJBLjvBClNBGFwKURyUWifsmQZeQHZFkCLkG/JMu2omcRxsfwkTGiTqbsLp/PU4/ApMlL7q0+zVWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646181; c=relaxed/simple;
	bh=CU3ksfEGHWdCIaQTH2LQ60wY6nLY7ierlfjMVdlARvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ins7rbTtKfLl82Qpu8PyonuVvktWl3WcbYFRck0Pw9Lyej4iSKjoBa44MVw2ebDLWtyMIgy2eyHj1Hy0CB7DtsmbNbdbIbklrMY1SJXK0eH2tz7epvmdnGqCqixvGeJQMUwiIyzSi3FV7GqcmRkGjJcNXwnIcROO0d9LXqmI6K0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tGoTOL/X; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tGoTOL/X"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b778bdb5b8so1095e87.1
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 04:56:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789646172; cv=none;
        d=google.com; s=arc-20260327;
        b=FEcN8dWFNdQMv7Rm9PHmFFOAQqZQOB5v5n9R2o+IqX+Eu4laA25qBh00MnErgzwSZF
         NLGvngu/CKMhLxQ1mW1vVJB/1AQXvTEiJuMI1jpUb16JmC63f73gYlsEDDdT7YzHqTtN
         KH0fbCfuHx/fVaRVl6OMbgTUIMC1JbmPr45A536iT6EO0Fo04QJ1XDU8/TqF8+NSHX38
         Vl0SGP3DJPv2RvcVmcVpgTGhzKMBBFIVdk7lZsyYcHKRN8+aOfTcXkgdQVIbeYh121BX
         37aVWKl4/W9D7j8xGB+QmrCTfZ7ChAm7lV4BZqxlB95zqjdSLUcklu/Ek6r7P0AkkelQ
         /msA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kosCb2yMfsMu2L7rZnHgF6oeDYnJPHYiEzUWC4os9nk=;
        fh=Ez8NpNZlYpJMs5FsbI2d5a16stCZJhW3aTDCQxMMJyU=;
        b=DBczwyJyzjR0muiJM1GqGZNtUAlEGBl4d7fm9Mz3vogI4+0AeM1Bjo7LlUZhG8lyJa
         LW5MmNlW95yk34/3LXrQ2CfOQdsYaXLJn3RgQEJfIfL3YAr5URBPry2CW/3/IAXAAUxa
         IXiKA+DmQ8bZGs6qcOdUVxUd8ShRUeVLoLpDBAN16CLjMOoOHwR4KY683UKdNWsGD4wS
         WHIq/9DB2uIBPsqf5JDdY97akmuYA+SsCYZS6FcrS4SCs8s/xb4raWupQWj0+Ev+LyVB
         bQLOGfNz1ZBVxfI/B0skrBBnWf/un/Of6Gr7SFlzHjGHNwm4tx+7fd6S5WK9lvF1CuZQ
         ZYFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789646172; x=1790250972; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kosCb2yMfsMu2L7rZnHgF6oeDYnJPHYiEzUWC4os9nk=;
        b=tGoTOL/XSZ+R/T9gS3JmKFaz8i/orjxMg3pm4QOoeosZfhJ5zxkTi8e/ZdCXsNl6mW
         pJWQ2HrrNUh1wf1ujOU50xTcCBwfuaAVnIQ2+9QW80W9ggsR+sqvc7alFbPa296ZIN+v
         EysBpp6xJvJZ49/WBE+rgsun/IfMZDOAWIvqOiQo5EW4Q7UGTs5RHGSLCvUUGfkB/pCR
         Bg75sgAwlfizHV/hp5gEykcZpZEeVvoUhaS/nsKLZzgkgNChKdTFNLipPMcpVhwEU0tF
         1lO9PHBfbGfF7FMrIz1L4x3LbDvJrLGazL8hXPQ40dlEXLjEZMcTQ73oNK0yiVSAVXCv
         63pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789646172; x=1790250972;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kosCb2yMfsMu2L7rZnHgF6oeDYnJPHYiEzUWC4os9nk=;
        b=NLUQi1Zp577q90S7U/sL8QYmZnv+r9Fg0SBGnDlyI2g/bcXS4k/hURVZwXxRXEhffN
         48aK79EFg1gTH7N5z6c+l0awoXw4Z07V1/q6sMxf+aASF8eQgjbUE5myq5z+iX7b56tq
         y6ONGT5rsehNOYV0b470LE7aBEMNRpf74msl73xt6ILmJJcn4U5uMMCVEcCD+DTHIzbS
         xXX4ki39BifrxUxsCb9WtZsYSaeE5Yi6O5OY1coF3XLDA7SMvfWeYmHahaYiWVlmuD7T
         JM41GVG08qyIqNFfotoqt5i9wU0x5gBSiEFQIsFigQ09qT2P4Evd7nV33LuK/WwQUcSl
         R7Xw==
X-Gm-Message-State: AFuF++mZAZfJmNW+MBQ0p4htF6zMz1asdzVib6djuysq7eIiaOLx5w/1
	dzZephkH8O8CqdI6uufef1GMizqdTN2KbFW1otl/vOHvevz1IzIKXNWJ6IPzAvH5Q/8/K/m5Gmc
	S1IASUsjQKm7Y+VBzFg3Kn+JNiCH7S1IJ/XhhM15GIITw/afL2qJwjcBVyy4=
X-Gm-Gg: AYBFou0OFfOGEOdfn5Li1VHA9r4MmL0MLm6jWV6W+WigkfhtFUMKUQwYePXaxbpSGE2
	x8pvU2kzqi+vVST1tmKUQMb3Ubzku7mxe/lmTvm4cq0DR6JJYiD9JIo1Ms5C9SdF0VBBcwU+P/E
	T4Rybq8P9qtwvhcFeet7BL098JGz5AtOqOZwo9Y4t691H1d9NHxtls30AYKCLP3suAl7K1KLk2h
	pZ1fSiqDqWbwRKGSHff/0q7uPdcQAmlX3TO7pG5U0Xj3G6VuDhJb67V++V15/C96mQe0TyCardB
	FeEVV1PJTSFquNxmksRK+O02eZg5F9eMUyVjVFTrJgksBKM+MnnwpFxlJzev3QhBNgT2dsCE7Y8
	KxrappsGwQ9uUvg==
X-Received: by 2002:a05:6512:686:b0:5b4:74e2:4171 with SMTP id
 2adb3069b0e04-5b8bff1fc30mr29453e87.4.1789646171156; Thu, 17 Sep 2026
 04:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915160141.3543048-1-suzuki.poulose@arm.com> <20260915160141.3543048-14-suzuki.poulose@arm.com>
In-Reply-To: <20260915160141.3543048-14-suzuki.poulose@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 17 Sep 2026 12:55:35 +0100
X-Gm-Features: AcwNN1Und6z4n8NhcdREXtYfkYZKnB08V2Uvzr0E-uhaZeSThY7dario3kxcFlo
Message-ID: <CA+EHjTxe=UXnKR6DzTqL9d6O0aG+rO+nPKTxKKQ_-w6tpkGCVQ@mail.gmail.com>
Subject: Re: [PATCH v18 13/23] KVM: arm64: Add a helper for VMs running on hyp
 that don't trust the host
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com
Content-Type: text/plain; charset="UTF-8"

Hi Suzuki,

On Tue, 15 Sep 2026 17:01:31 +0100, Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
[...]
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
[...]
>  enum kvm_arm_vm_flavor {
>          VM_NVHE,
>          VM_VHE,
> +        /* VMs running on a hyp that doesn't trust */
> +        MARKER(__VM_DISTRUSTING_HYP),
>          VM_PKVM,                /* Normal guests on pKVM */
[...]
> +#define kvm_vm_hyp_is_distrusting(kvm)        ((kvm)->arch.vm_flavor > __VM_DISTRUSTING_HYP)

I think this should be `>=`, as in kvm_vm_is_protected(): MARKER()
gives the marker the same value as the enumerator after it, so `>`
leaves out VM_PKVM. As posted, kvm_phys_addr_ioremap() no longer
returns -EPERM for non-protected VMs under pKVM (EL2 still rejects the
mapping, so it's only the errno that changes).

Cheers,
/fuad
