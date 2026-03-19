Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEAE38D6B9;
	Thu, 19 Mar 2026 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941774; cv=none; b=SMZBJFiHF2BWYwIINkZh5agBsjySJhx7oIA3lTVrSs/pAziZkQbULkyF57dZQ/+xhXNpTwlZG2IStbPFD/6pFFLZAkwJpwBt490Gv72D/hQPgqR1S7EcbX4MlRjqBtQJW66qdUmQqloh0+c7jwYO48CpLs0GSF314USJrJLbVoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941774; c=relaxed/simple;
	bh=57Oq1ul3PkHolG6C+GNoZwXxgCA9lHpKpn4VDoXEUL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WEIJWnmU9jAYsaodewOAfUiiwMJIH3G8qg0XfpLyWRhudOBqa15aCBClRmmwVeAPSqoJL1JLU8GVLKtq5IpC0s4FNYU6+jc1eWUgswgI/io9fd8q0NXxNNoPNC1RmoettGUrjvIZj+0v5gV5DEksKYqe/xXim4PV/lRynWwl/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0FE52247;
	Thu, 19 Mar 2026 10:36:02 -0700 (PDT)
Received: from [10.57.20.123] (unknown [10.57.20.123])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A2743F778;
	Thu, 19 Mar 2026 10:36:05 -0700 (PDT)
Message-ID: <79564d59-032e-40c9-b4eb-f79f805b8238@arm.com>
Date: Thu, 19 Mar 2026 17:36:04 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 46/48] KVM: arm64: Expose KVM_ARM_VCPU_REC to user
 space
Content-Language: en-GB
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei
 <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Gavin Shan <gshan@redhat.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 Alper Gun <alpergun@google.com>, "Aneesh Kumar K . V"
 <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>,
 Vishal Annapurve <vannapurve@google.com>
References: <20260318155413.793430-1-steven.price@arm.com>
 <20260318155413.793430-47-steven.price@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20260318155413.793430-47-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/03/2026 15:54, Steven Price wrote:
> Increment KVM_VCPU_MAX_FEATURES to expose the new capability to user
> space.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>

Not needed any more as we don't need the VCPU feature.

Cheers
Suzuki



> ---
> Changes since v8:
>   * Since NV is now merged and enabled, this no longer conflicts with it.
> ---
>   arch/arm64/include/asm/kvm_host.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 1d5fb001408c..b02f97de4436 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -40,7 +40,7 @@
>   
>   #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
>   
> -#define KVM_VCPU_MAX_FEATURES 9
> +#define KVM_VCPU_MAX_FEATURES 10
>   #define KVM_VCPU_VALID_FEATURES	(BIT(KVM_VCPU_MAX_FEATURES) - 1)
>   
>   #define KVM_REQ_SLEEP \

