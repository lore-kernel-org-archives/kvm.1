Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA334B7A4B
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269509; cv=pass; b=niPge0Kf2JfntLTqLa7emJWeRT3yGVpKiiRvoL+hM5wqxyjPxF836cUoPf16uqtrO2BLQgi6uIf/Qjo5QYSGeBH0qBHnE+2XllT6O1o4z2xt8lxghkUQIQpuJOqnchz/+cipzhpWNZlv7va8++9N36O+rvZBLAFv0k9tY9t73tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269509; c=relaxed/simple;
	bh=1F8/rz3ypcsoCgDUnUPkG7WkBCl4kCGuN1jCJU9T35k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfdxAd7NdHAKTvimgFU3WASYBPl9JmtYPditECzJ+Clf5JTHclTdfk6jD423iEBElQMqpxc+UTmEJA4xDfHMIrlwCT1vXcYM7wDIflaYcTJXD0+xLanwzkAJFR/zjNKg8NHmrhjUECt9Moh8xqOuS2sCBDRVnWaHmPGGkeiK2VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s5wdWVwc; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s5wdWVwc"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfbd148aso733786d6.2
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 10:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790269506; cv=none;
        d=google.com; s=arc-20260327;
        b=o7vdyr13VKi35fstOgDapUJ4uM6c8pgJbIizKNs2pPqWIPZ2XQxGlhxl1MCubLVoek
         Oa56dBvJUyuA2cfZmM5wY6XxOnQ0HOSzjBSO8xK1LrsyG0T7hUkSwDXC0woSsA0QChVi
         +G2SpuCeGmgNMeciWa7VS1Eau33qHlBeYyxQ3EBMzaril2zIi/3EwnM7W5G4nRxnvxOs
         QiylFU2ozhoLFa5m5QM55JjRk25oeGKXmXhK09fwAZDFRTyOssIhws0LqfgQA90kZ4+I
         HaYLnsgL8MQk2rritpIueJQoa3SSqtAvUFZYaRSsaUw6jvtsgtmMoqFUeglru/UmaHRr
         Xmfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=OHcWMQ1Z3aW3bHAxm3qzvYkMiIOMbOZVWxnCDEHnj30=;
        fh=pZzI/K6dg++hi8F1p3mr7n9fLdLEo4m+vUj9GPuyD3A=;
        b=IvM47/kXfvuL3UBEAEovRviGrqQHngNJqRVSw8PnDsdLjY4MtbTQGq3PTYUFiCITvD
         y2KkdLOE+81UHj+yDkI743tLUAUY9WFGliheOuKg5U+mp+mwOUFq34dVFlOXemobOfN+
         emoeyTwOqGLDfwzOHCjOMi+hgcW3q7/C9UpIHhbZL79xdGNpmRhsUw907DANUou2oT7E
         3nCIHAh05VYb2XwuokFrm91zCoH9KVpVUsVqNG4wL72Dd3lWuuHsbWSAsAucF6wRCHEv
         1PI8q7d++PQeRiJdAAw5C7cBRH/DShV3CdC4jL9l8p1+5wydvjPMIKDt7W0DevV5i6F/
         J6Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790269506; x=1790874306; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OHcWMQ1Z3aW3bHAxm3qzvYkMiIOMbOZVWxnCDEHnj30=;
        b=s5wdWVwc5chjFqw2cWCygu2xSMRvyyJf5NFwiFfSSQvFMOVGSbt8gkny9PTMMJTc52
         yHZMs9R/JVxLJjKgptEPtXI/kYOyeWwcmUKY6tSsDiTGO43LilqoZHkloUcvLGPWTFoI
         PaGqpr8l0jlYeQww8GvXDfpx2MPg/SIJ5geyxpZcSV2+AJ7SIU5OSe6bz3gzBHOtoObF
         FMAZj4AsT8QvtstcM+JzkKTY1ujPqPrtR19K0jI5ZqzJ60Mz86/jpPYQ1CEQZ88AH/8c
         HxImTm1F8JH+l730uPkU74cgWmu5QWVe/hlhLpuwqjQIwoiOtxWmSKNe99myPbBrL0qO
         UXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269506; x=1790874306;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OHcWMQ1Z3aW3bHAxm3qzvYkMiIOMbOZVWxnCDEHnj30=;
        b=K27OLI/BshQevVRGvV0djMyyenqhOuy5z/KDXH4uS1nMNLykGhHNc0N4Uts3zFs9tC
         CbF3tjfIYgRkjSGNTx/8KIKZ8+trz7Mitx8wRhfRgGXN8RATlZJyHFSAW1xlDk7ALL1H
         4BWnSzO2CHliI5waUAc0IUxusrVIafEg1uNMq9lZfVOfP5NvB32WyiBnvqUl1PCTdui5
         CwJtdjvxv7Xmxvgh9oADfMOc9Z6O2yiJE7Y0mzfvxNn37XH4libxUpgLY8TyP3S8/Md6
         JUAMAsn6b/RXur8Npn5gmaonez1eDL7dgZ9TDODumE70Lv2FkrJSmYNNY+xH9IkDNuVe
         uZow==
X-Forwarded-Encrypted: i=1; AKwUvBwWOUuLtEkO6JDD3kxRWWSOyyGVoWvIX0kAyql3S/nXNsqDSsrfAaQczryub2yGloE9AQM=@vger.kernel.org
X-Gm-Message-State: AFuF++mOqV916RbATuEOuXmLxnLISQQ0T/88gviHnLnG/UccWbn7ITtM
	NJokCEuokqUhXwOgHfVtqexehaPFKyLbM4ucCBcNPZzHKlpX7rnGPv6NBWXZJMwdFPIZQsUPMJD
	Znlp5yUaSb6BFIRyOKw4Mb8KeGiClYGd4x7k9xBCt
X-Gm-Gg: AYBFou39EMastUewAh5SXOxX5n5MEUuSpgZ4kdugd2lDqjMXhfgqgaeh2LeQZSck3HB
	Z/St6aFFDlpm7tKSPeWTSo8p3re9aR8lXyRDDcVsfP0bYVaFw0+SwGUCscA16qVwdAonvv3yUbu
	CQPnDrk8eA+i349UnispoME21RRuTP7I2haRYQFDIRs5GYVmYcTYACobzysrHIcbWfysZ2oXmzV
	NdIxVjSCW9s7ViLStRy+mTtRfLqFVblvHlk+QorTcewP9kD9JxemRdiv2ZpjSKKhl7ZZPjDRSmg
	+yyi/MMv5mit7DwRhnQ4rGlgITvWP9696zdfydmmKdK2h7NnRMuIFVpWNu1raGcI4NQZq00mXXs
	I8/HxCSVWifVtKMTPIUnrnXMFHOHSVx2E3nEXYcEvDA==
X-Received: by 2002:a05:6214:4a83:b0:912:cec:7450 with SMTP id
 6a1803df08f44-91421b1851amr31284116d6.0.1790269505101; Thu, 24 Sep 2026
 10:05:05 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Sep 2026 10:05:04 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Sep 2026 10:05:04 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260924135201.850038-2-suzuki.poulose@arm.com>
References: <20260924135201.850038-1-suzuki.poulose@arm.com> <20260924135201.850038-2-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Sep 2026 10:05:04 -0700
X-Gm-Features: AclHuK_DlezgNpJkyQ6-N0Dq0ZFyu15Ut5n5SPUx6_YH9nitYJ5xMl_wRWW9wVM
Message-ID: <CAEvNRgH8Hwt6_VaFxJVvytZ4La1R7bUN2emc37_fWecF9j2-YA@mail.gmail.com>
Subject: Re: [PATCH v19 1/7] firmware: arm_rmm: Add SMC definitions for
 calling the RMM
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org, 
	gshan@redhat.com, joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com, 
	linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com, 
	sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com, 
	WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com, 
	sudeep.holla@arm.com, jonathan.cameron@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

>
> [...snip...]
>
> +
> +/*
> + * Note many of these fields are smaller than u64 but all fields have u64
> + * alignment, so use u64 to ensure correct alignment.
> + */
> +struct rmm_config {
> +	union { /* 0x0 */
> +		struct {
> +			u64 tracking_region_size;
> +			u64 rmi_granule_size;
> +		};
> +		u8 sizer[SZ_4K];
> +	};
> +};
> +
> +static_assert(sizeof(struct rmm_config) == SZ_4K);
> +
> +#define RMI_REALM_PARAM_FLAG_MEC_POLICY_MASK	GENMASK(8, 7)
> +#define RMI_REALM_PARAM_FLAG_LFA_POLICY_MASK	GENMASK(6, 5)
> +#define RMI_REALM_PARAM_FLAG_DA			BIT(3)
> +#define RMI_REALM_PARAM_FLAG_PMU		BIT(2)
> +#define RMI_REALM_PARAM_FLAG_SVE		BIT(1)
> +
> +#define RMI_HASH_SHA_256			0
> +#define RMI_HASH_SHA_512			1
> +#define RMI_HASH_SHA_384			2
> +
> +struct realm_params {
> +	union { /* 0x0 */
> +		struct {
> +			u64 flags0;
> +			u64 s2sz;
> +			u64 sve_vl;
> +			u64 num_bps;
> +			u64 num_wps;
> +			u64 pmu_num_ctrs;
> +			u64 hash_algo;
> +			u64 num_aux_planes;
> +		};
> +		u8 padding0[0x400];

The union + sizer concept is cool. Technically this one isn't a padding,
it's also a sizer? (same for the other structs below.

> +	};
> +	union { /* 0x400 */
> +		struct {
> +			u8 rpv[64];
> +			u64 ats_plane;
> +		};
> +		u8 padding1[0x400];
> +	};
> +	union { /* 0x800 */
> +		struct {
> +			u64 padding2;
> +			u64 rtt_base;
> +			s64 rtt_level_start;
> +			u64 rtt_num_start;
> +			u64 flags1;
> +			u64 max_num_vdevs;
> +		};
> +		u8 padding3[0x700];
> +	};
> +	union { /* 0xf00 */
> +		struct {
> +			u8 padding4[0x80];
> +			u64 aux_rtt_base[3];
> +		};
> +		u8 padding5[0x100];
> +	};
> +};
> +
> +static_assert(sizeof(struct realm_params) == SZ_4K);
> +

Does declaring this struct as packed matter? I guess the static_assert()
has the same effect.

>
> [...snip...]
>
