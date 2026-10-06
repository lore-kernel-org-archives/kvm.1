Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC16B1E9B3D
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 03:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791256635; cv=none; b=oOCs0aFxQNTQFhzimy45cxS5e4qP0YiVlwnG3va1FuDtfiQC7s62pZx46JystYeoljfEro8VAsyb9ucbqI5h7QjEjQkvVjd8WKMkBqPeWCjHtwgaLQ058Io+svIP9u3facHegyv1Wa2krt08mWKTUvsSE8tOFckE6otOZteXVrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791256635; c=relaxed/simple;
	bh=OCwy2T21o6KZK5vUec+S24BqJgmIfSohdnltBRqhZh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FwWngCzCQCXJ4nDdX/PGYhZaA12oaXMz3SE1UwVrprO4CuTKiK34g+fqrQb1yP+fR/jTI/sXdfYScbZzrGeh+dnczWTjoykBPiCPbqRZRlymP0hVmySRoDGVfO7DI02xs8LutpMaED6sGlYjSeaEWMiyk6mIDWpKNDfV4arBQZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JmRa6+pG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGEemvMb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmRa6+pG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGEemvMb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791256632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmIEoaAK9H0I/DObf/8+7Lpe62dBXA5oIjHsrjeoKTg=;
	b=JmRa6+pG+IfDsTB9eepNfpqWczkdHGUdGggMTuKdZCcorkxOVQklsIna/sgOlxYcPNymWc
	ddHuqZo1Xk8cuGs9GxmKRpWVNOv98I1IGdxmE8HJfPdGLKK0MzyGmN9xX5ZAgC+oO+Du4+
	DbQmt6Axb51VYKrsTbJeQjyFL7Ot74I=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-TLs9mMcdMaKcGoys_pZk-Q-1; Mon, 05 Oct 2026 23:17:11 -0400
X-MC-Unique: TLs9mMcdMaKcGoys_pZk-Q-1
X-Mimecast-MFC-AGG-ID: TLs9mMcdMaKcGoys_pZk-Q_1791256630
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a47617a0b3so2252315a91.2
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 20:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791256630; x=1791861430; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cmIEoaAK9H0I/DObf/8+7Lpe62dBXA5oIjHsrjeoKTg=;
        b=FGEemvMbompPq+Nk/NOUUYMi++roDUYFHTw8BumHn8ORzIY+mcu4tcR2WjqNLTWac1
         x16aQeuoPkUr4vK9wAI8YtHW7R3FZnxwyQe+iivLkZ6muQDUiCyS/1XlN7roKR4C+j5n
         RVdoE+XwcHHTH8uzKHAfZtnWnVAyt8kzLtA2KP6msExPoNet91Gj0zf5R0pE5+M1VjkL
         PMVpKm+8gpbwhzQJ+DuVMxuYPArohSw5uWAL0BugQ5Mq5ejy9Fp0EOqevIar2PxZluAq
         rDSKG26EKgeH7aOf3StJLwdSLl8WZaUddidK5wr/vBCiXvMivng/w6wOi+Y8xz9dPXXy
         +5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791256630; x=1791861430;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cmIEoaAK9H0I/DObf/8+7Lpe62dBXA5oIjHsrjeoKTg=;
        b=gH7RDoplAC07JIm3d4/OfyqWzkiFqXW1BHC0Q5Ciz4HVQ5Vcs3Vi7HG8r9zayVyzB9
         jb1TuZ5nwKwRnIw3eIRFaqQN6IvWtcPdkK0Dhqag/Ya6CUgUSI8t1YAMyap0D264JNd+
         ez0oZkyGIarc+OMqOtj1zLsnXVLXVScYODY6htPSomOwy2hDzaxRVup++eoI9rj1205A
         a35uQW7CIofe8FcSc7Ky2rF87kt6yiYOFktILnM4H0/ns80ftoemZkEHcM0K+uFpjFdZ
         /Kz6knoWzqgZk+tPjn2XSvraAjrzuAaP4o2WaWrV26ffynqKl8H0hPYP0aqeV8F1xwCi
         nVNQ==
X-Forwarded-Encrypted: i=1; AKwUvBzy80IPZUjkprFkvRm0pNl/fJO7I5cYsH4EUPEBu1v4W8PI0K6GOabmWWSXS/Pf0LUhzGI=@vger.kernel.org
X-Gm-Message-State: AFuF++klyEdKsngVH0f5JxUrB3pPL56BAn3UAuxqgv25+mWu1Umuqp+o
	E4KYFq2w/IYJ91Bk5csqDSgMphtOQ/diTQ6jxN+y6NJcqgXLeKg9Fcf0hvKK3wrFqqJMUXJ5TXO
	ZnmbklR9Evg4tDfkbB0m1LbBG9FQxkUhTy8Bpw8Tmyz2iIUANuClOxA==
X-Gm-Gg: AYBFou1TW8vlDDpXEPebQgwPLMYJXIDMqF/q9hkQM1P+ZYcbdiT0DtHa/QsqPlM2mkG
	9QlSOotXneWq3A788usASc4KxjGRUTJ6zxDaq+8AJPUEHaEpr1zzPlZQSfavspbzcttVKVXli7P
	s2yR8YSVQsL5xslMm8/SZaWR/TQcqcn/NZw3TyE2cCSOraJ3QxoERvMqu6Zvaz67TLR7U4o4nRT
	6/VAoTM1qFvxr/khZnNjXCkL6wr63qGqO6RT1o3US1uROxJSWmXq34956Ys3KxMnketCx0OS3k2
	kamWiC4cMGgfBNOTlWrxvZKgEaWockNP1QNjsGEZT+JnWzWM2lLaiI8uqTb2LNfP5AfY375d4qN
	RmGnFyGk4TnngSOS0DpukCcy5eRCSI5/jbS6KstAkmA==
X-Received: by 2002:a05:6300:6698:b0:3de:7bd5:fb47 with SMTP id adf61e73a8af0-3e12474463bmr68479637.39.1791256630139;
        Mon, 05 Oct 2026 20:17:10 -0700 (PDT)
X-Received: by 2002:a05:6300:6698:b0:3de:7bd5:fb47 with SMTP id adf61e73a8af0-3e12474463bmr68459637.39.1791256629711;
        Mon, 05 Oct 2026 20:17:09 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cce6b358400sm1870050a12.4.2026.10.05.20.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 20:17:08 -0700 (PDT)
Message-ID: <fdc81d01-27df-4557-80bf-80d4527e4bf2@redhat.com>
Date: Tue, 6 Oct 2026 13:16:59 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 16/23] KVM: arm64: CCA: Add VCPU load/put for Realms
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
References: <20261005090754.2140522-1-suzuki.poulose@arm.com>
 <20261005090754.2140522-17-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20261005090754.2140522-17-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/26 7:07 PM, Suzuki K Poulose wrote:
> RMM controls the VCPU settings and most are hidden from the KVM, except
> for the VGIC and timer bits.
> 
> A later patch would add syncing the VCPU state into the Realm REC related
> SMC parameters.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm64/kvm/arm.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 6c81fec35ecec..294cea4cc8271 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -802,6 +802,13 @@ static void pkvm_vcpu_load(struct kvm_vcpu *vcpu)
>   			  &vcpu->arch.vgic_cpu.vgic_v3);
>   }
>   
> +static void realm_vcpu_load(struct kvm_vcpu *vcpu)
> +{
> +	kvm_timer_vcpu_load(vcpu);
> +	kvm_vgic_load(vcpu);
> +	vcpu_set_wfx_traps(vcpu);

Why we need to call vcpu_set_wfx_traps(), which updates 'vcpu->arch.hcr_el2'? I don't
see how 'vcpu->arch.hcr_el2' is affects realm in RMM. Could you please explain in the
commit log.

> +}
> +
>   void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>   {
>   	vcpu->cpu = cpu;
> @@ -854,6 +861,12 @@ static void pkvm_vcpu_put(struct kvm_vcpu *vcpu)
>   	kvm_vcpu_pmu_restore_host(vcpu);
>   }
>   
> +static void realm_vcpu_put(struct kvm_vcpu *vcpu)
> +{
> +	kvm_timer_vcpu_put(vcpu);
> +	kvm_vgic_put(vcpu);
> +}
> +
>   void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>   {
>   	vcpu->arch.vcpu_ops->vcpu_put(vcpu);
> @@ -2213,6 +2226,11 @@ static const struct kvm_vcpu_ops pkvm_vcpu_ops = {
>   	.vcpu_put = pkvm_vcpu_put,
>   };
>   
> +static const struct kvm_vcpu_ops realm_vcpu_ops = {
> +	.vcpu_load = realm_vcpu_load,
> +	.vcpu_put = realm_vcpu_put,
> +};
> +
>   #define KVM_VCPU_OPS(flavor, ops)		\
>   	[(flavor)] = &(ops)
>   

Thanks,
Gavin

