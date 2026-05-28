Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96B51F938
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 05:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779944609; cv=none; b=U4WVlxmO1WtNWwDiILSumTCm22NzMArmhjUdcAyk4U3468nIeerff50bo+Nknlb8AOxghbeB8YJnFJRE2QPIQ+TqpChDkKD3VHaFozslEdDrdar2qwFqVuKYEBmzOoHk+ft6hYOIv5n6ZPZhQ3fBuc1SdCiwSUVSsAFUXXuCyTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779944609; c=relaxed/simple;
	bh=c3M2wwVK8Ko3wWXtJq5scLGJOnS6c3GEbbCzhOP8rPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NR2rI8M1LGAb9A2aXw3y5OZA+qqy6qZbWz94J0hiuPIcTpOQZBF8U/xf1r39bJa/nZsJ/pqIXYqIcNczQNiyfkL1GqhhL9gq4jvFIJFihatJn1duSZiRUohSlsd9X71RObOiQKxDCjmqemkOaQrU5z7RccSg9obtkFdrj2UkNuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i1JbMRua; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBA31BPm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1JbMRua";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBA31BPm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779944606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UqvCi0lCynTmviHWeEa7hB9XA+pHd1N3wbumIZfeiYk=;
	b=i1JbMRua+XC1Qtdd8YvVGtcszfQW/XvWHAct0zRQZHE5VK3/NyeIQMuVBgooqVfz6jrVe6
	R3SJrBdwXk+f00xqwaB2ZlTuBoCUW1q2Bo04wHjX2CIZUyxXJgHEzD/LLvGQDqAoEhfUSO
	LWi+RxrHFIx5+e3vI7BwkYQ7OavAw2g=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-fJlGeOdrO1a9k54oCUnVVQ-1; Thu, 28 May 2026 01:03:25 -0400
X-MC-Unique: fJlGeOdrO1a9k54oCUnVVQ-1
X-Mimecast-MFC-AGG-ID: fJlGeOdrO1a9k54oCUnVVQ_1779944604
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2befec3fd8fso4920915ad.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 22:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779944604; x=1780549404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UqvCi0lCynTmviHWeEa7hB9XA+pHd1N3wbumIZfeiYk=;
        b=ZBA31BPmfyukYtCHqhjcapM/mynRth+Ek4s4L6JZDnqUmKobnHC2R0W++xlszroBaH
         RNpKXFeI3SnYXOjg23SCoZbOpc2E/zuyRe/fealzjiMGkxtBZgswt2tWPjliqqZJ1fUo
         lTifwYsRqEF26sedpvX5lgTatt72Cxs3mQe8tR09OmsOlHmrdjRJ9/IZCgaiQi3dhNRF
         gbf08y+Lo3dvvCn5Jeps/o933TJXaN/k4jAMb02AGqXAnNQX+DWPfueI6q2GKBi+Cm+d
         0Nafq4qEVti4+1ZoubvpuNIxgj3EcxPzWrhSWSw/WQGTo9ma2phMHTmTlMxXcDL8ryyJ
         v1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779944604; x=1780549404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqvCi0lCynTmviHWeEa7hB9XA+pHd1N3wbumIZfeiYk=;
        b=AAl6tEYiJkrtGjRRtoLXD/XGJ0qWLVXZ+7qw93Pb1kD0VKRb/0ar4/o3PH4ykzNHwL
         AOMg3ofYuhbHxnD1O9awEf1xPqHGmItehwiHaOiCnsRgBfdnWBnSwy7AAMR1qcx4ClQ/
         WTfGL6dzGYlhqKKrYvfEf8tUldm7mA49/0gdz95Lj+nlGfcXfMLqjzUhPe3SdjFbAP63
         dt+LYZR1u7Qhul7XwT9fpf7G+4L9npm1DyojfTqhYw7mEw7zQNCuiuDmw8DtpANh+Vgu
         v6KInAMh77qTiD/WicSZkwNMvZ7YQeA/rZGLHH6etnkiYB3qyONJ3wJCRk0xl3011oKM
         EZ3w==
X-Forwarded-Encrypted: i=1; AFNElJ8CT4MDolJggAWmX1aRvrCn5tXubzbIV8SGogdpSJfnBcWx+KmrVv/toFfUPhfp1vkoGd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSHcZNwR52wjt6+l+LM7VZWgTEorNSEzMKszfHRgHEY0Kj599d
	XQckonZSugn1onsZP5XTng39j0HqMLUB8vtth8axSNYFrZnQe8Yns1R/jC2kJDsW7wwDSJzolin
	9+R3mhNdrHc8yuK1PbSI3a8v/cLnVEuqyO5zyXr9sNBvjxcuhbM29Yg==
X-Gm-Gg: Acq92OFzGb0VVPTvkX5wA/iZz1xji3p3RYZWp7T9caeI0TaAMW+MFixmjzjVafGlcf+
	fK9VKWHkJru3CktCGAQ9/4BSZuDIzPppWTZ8zbeBMvTe7I9iDS1hEcCpys0efIflMo+1zuhGphf
	0reMzwHxqLxObPi9LBBnevDlvxL6ZOF1O17dVfDUoPlN7z2N3ZcrLjZzoM3x5J1qumE+Tvq4Naz
	0IMw1brxxAFd+Mm8HmRQmcv6/91NRkUmM7JiXmk1LqwGrgyTmY/PvD+cr/9A0K5nqVMuMCPK9ah
	3jFx3UBcNWXMXkFTI38xIwwOCyCCa05QArNcU3ccn9BDP/WNS7WYTtl1CUbunbkoP7ELUyRXVoF
	hqTL0XNhOCQf1n6J4g7kCXJ6bDyXyb+Jz0ppRSUfbymngfgZmPHqo2damr+O8N+uBs6MBP+yH+V
	I=
X-Received: by 2002:a17:902:c94f:b0:2b0:608d:d8a8 with SMTP id d9443c01a7336-2beb0366400mr275002415ad.1.1779944603820;
        Wed, 27 May 2026 22:03:23 -0700 (PDT)
X-Received: by 2002:a17:902:c94f:b0:2b0:608d:d8a8 with SMTP id d9443c01a7336-2beb0366400mr275001935ad.1.1779944603275;
        Wed, 27 May 2026 22:03:23 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56f4343sm221300525ad.36.2026.05.27.22.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 22:03:22 -0700 (PDT)
Message-ID: <8b648b59-c411-4126-be18-686d2927f24a@redhat.com>
Date: Thu, 28 May 2026 15:03:11 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 24/44] KVM: arm64: Handle realm MMIO emulation
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Emi Kisanuki <fj0570is@fujitsu.com>, Vishal Annapurve
 <vannapurve@google.com>, WeiLin.Chang@arm.com, Lorenzo.Pieralisi2@arm.com
References: <20260513131757.116630-1-steven.price@arm.com>
 <20260513131757.116630-25-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260513131757.116630-25-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steve,

On 5/13/26 11:17 PM, Steven Price wrote:
> MMIO emulation for a realm cannot be done directly with the VM's
> registers as they are protected from the host. However, for emulatable
> data aborts, the RMM uses GPRS[0] to provide the read/written value.
> We can transfer this from/to the equivalent VCPU's register entry and
> then depend on the generic MMIO handling code in KVM.
> 
> For a MMIO read, the value is placed in the shared RecExit structure
> during kvm_handle_mmio_return() rather than in the VCPU's register
> entry.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v7:
>   * New comment for rec_exit_sync_dabt() explaining the call to
>     vcpu_set_reg().
> Changes since v5:
>   * Inject SEA to the guest is an emulatable MMIO access triggers a data
>     abort.
>   * kvm_handle_mmio_return() - disable kvm_incr_pc() for a REC (as the PC
>     isn't under the host's control) and move the REC_ENTER_EMULATED_MMIO
>     flag setting to this location (as that tells the RMM to skip the
>     instruction).
> ---
>   arch/arm64/kvm/inject_fault.c |  4 +++-
>   arch/arm64/kvm/mmio.c         | 16 ++++++++++++----
>   arch/arm64/kvm/rmi-exit.c     | 14 ++++++++++++++
>   3 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
> index 89982bd3345f..6492397b73d7 100644
> --- a/arch/arm64/kvm/inject_fault.c
> +++ b/arch/arm64/kvm/inject_fault.c
> @@ -228,7 +228,9 @@ static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt, u32 addr)
>   
>   static void __kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr)
>   {
> -	if (vcpu_el1_is_32bit(vcpu))
> +	if (unlikely(vcpu_is_rec(vcpu)))
> +		vcpu->arch.rec.run->enter.flags |= REC_ENTER_FLAG_INJECT_SEA;
> +	else if (vcpu_el1_is_32bit(vcpu))
>   		inject_abt32(vcpu, iabt, addr);
>   	else
>   		inject_abt64(vcpu, iabt, addr);
> diff --git a/arch/arm64/kvm/mmio.c b/arch/arm64/kvm/mmio.c
> index e2285ed8c91d..6a8cb927fcca 100644
> --- a/arch/arm64/kvm/mmio.c
> +++ b/arch/arm64/kvm/mmio.c
> @@ -6,6 +6,7 @@
>   
>   #include <linux/kvm_host.h>
>   #include <asm/kvm_emulate.h>
> +#include <asm/rmi_smc.h>
>   #include <trace/events/kvm.h>
>   
>   #include "trace.h"
> @@ -138,14 +139,21 @@ int kvm_handle_mmio_return(struct kvm_vcpu *vcpu)
>   		trace_kvm_mmio(KVM_TRACE_MMIO_READ, len, run->mmio.phys_addr,
>   			       &data);
>   		data = vcpu_data_host_to_guest(vcpu, data, len);
> -		vcpu_set_reg(vcpu, kvm_vcpu_dabt_get_rd(vcpu), data);
> +
> +		if (vcpu_is_rec(vcpu))
> +			vcpu->arch.rec.run->enter.gprs[0] = data;
> +		else
> +			vcpu_set_reg(vcpu, kvm_vcpu_dabt_get_rd(vcpu), data);
>   	}
>   
>   	/*
>   	 * The MMIO instruction is emulated and should not be re-executed
>   	 * in the guest.
>   	 */
> -	kvm_incr_pc(vcpu);
> +	if (vcpu_is_rec(vcpu))
> +		vcpu->arch.rec.run->enter.flags |= REC_ENTER_FLAG_EMULATED_MMIO;
> +	else
> +		kvm_incr_pc(vcpu);
>   
>   	return 1;
>   }
> @@ -167,14 +175,14 @@ int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
>   	 * No valid syndrome? Ask userspace for help if it has
>   	 * volunteered to do so, and bail out otherwise.
>   	 *
> -	 * In the protected VM case, there isn't much userspace can do
> +	 * In the protected/realm VM case, there isn't much userspace can do
>   	 * though, so directly deliver an exception to the guest.
>   	 */
>   	if (!kvm_vcpu_dabt_isvalid(vcpu)) {
>   		trace_kvm_mmio_nisv(*vcpu_pc(vcpu), esr,
>   				    kvm_vcpu_get_hfar(vcpu), fault_ipa);
>   
> -		if (vcpu_is_protected(vcpu))
> +		if (vcpu_is_protected(vcpu) || vcpu_is_rec(vcpu))
>   			return kvm_inject_sea_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
>   
>   		if (test_bit(KVM_ARCH_FLAG_RETURN_NISV_IO_ABORT_TO_USER,
> diff --git a/arch/arm64/kvm/rmi-exit.c b/arch/arm64/kvm/rmi-exit.c
> index e7c51b6cf6ce..8ec0d179eba2 100644
> --- a/arch/arm64/kvm/rmi-exit.c
> +++ b/arch/arm64/kvm/rmi-exit.c
> @@ -25,6 +25,20 @@ static int rec_exit_reason_notimpl(struct kvm_vcpu *vcpu)
>   
>   static int rec_exit_sync_dabt(struct kvm_vcpu *vcpu)
>   {
> +	struct realm_rec *rec = &vcpu->arch.rec;
> +
> +	/*
> +	 * In the case of a write, copy over gprs[0] to the target GPR,
> +	 * preparing to handle MMIO write fault. The content to be written has
> +	 * been saved to gprs[0] by the RMM (even if another register was used
> +	 * by the guest). In the case of normal memory access this is redundant
> +	 * (the guest will replay the instruction), but the overhead is
> +	 * minimal.
> +	 */
> +	if (kvm_vcpu_dabt_iswrite(vcpu) && kvm_vcpu_dabt_isvalid(vcpu))
> +		vcpu_set_reg(vcpu, kvm_vcpu_dabt_get_rd(vcpu),
> +			     rec->run->exit.gprs[0]);
> +

{ } is needed here.

>   	return kvm_handle_guest_abort(vcpu);
>   }
>   

Thanks,
Gavin

