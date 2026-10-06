Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED3E26AA91
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 03:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791256073; cv=none; b=dgPZ+2twihHOpcAnZ2OMVrK067qmBz20dpNv2qfCwd75vPn2cmR8AFlzSlqaRBoSmjP3K+GDXyAj1RXust8jkrdLOf/R+chKGfNBVuh8U0NX4UwqxC12Oc8GY1nPbteJifcbIjwPjJcfUiES3bcIc1iE2z1jzeyTqobcajC1XPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791256073; c=relaxed/simple;
	bh=gzkLCBUFd4kbcPEHkSHri54LfRKFf1qQMHTvyuqX+WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASAXw97bv9L4xmJRiDiTMWIJjKigo1RhEyiLX/7XjmolBWctX7m/tQEujtHiwfknmkd4sQwU/S9qlWrBcs2MOUzACZBmdae6wnsdLwLcdL0xwjTZVtfphshJaZ6+MEd+TTpv2Yq0vTqg8RZraGHku44LS69i7dq9jg39cRVYe08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eo0Br1Or; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HMS7+4X/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eo0Br1Or";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMS7+4X/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791256071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fNeoxAcpqLuP6xVkV/ooADVzEQHG7XjJg+hDhApi/Aw=;
	b=eo0Br1OrXAZZ0HcBx5Lnqd8nVbRSv08SNjIHebzgAEP3ms+DzVctNCTp0sdWr9AVpPaCn+
	jQnXLPll0qt6nqKHAOcBq8oyE6jcSY0XRd1W3+dArrYagjOQYkNjZXqEwRBIvi8+p/GugE
	ERw87b9naA5bULWe3D0Ryn8T7qmZT4o=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-woyETVb1P9a7brCTQL3LuA-1; Mon, 05 Oct 2026 23:07:49 -0400
X-MC-Unique: woyETVb1P9a7brCTQL3LuA-1
X-Mimecast-MFC-AGG-ID: woyETVb1P9a7brCTQL3LuA_1791256069
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc7ce00b8c6so2035329a12.2
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 20:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791256069; x=1791860869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fNeoxAcpqLuP6xVkV/ooADVzEQHG7XjJg+hDhApi/Aw=;
        b=HMS7+4X/5hci77rPT6blpHh7ZqqtowcGr/IxUiDQz17P/knyTmZQhtlDqlDtxrBfce
         F4pnrz/V5V7UMDoKA5i6mlgJaWacr9WWxat5eZYtMJh3B3gd++Trw9vOzoTN+7gmo6hx
         a8OudFb2b9mLAeJrunUj9DzkiT8sMG6WNBxgwKJLaKpCxa4MN/dWOnDhFKS5ftX/f0Tt
         YEIT9epttVmSCiwJGg3mkzKq/TgzyMJLXZ2jGzC8qDuMz9gfjaI6MckG7vTWbX93YbfC
         5cKly72CpKTU/xDB3B3+lHhTvThMcW865jtC/1Y9K+D3WBoo5qUeXYq/MwbDhTY8wdSB
         QELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791256069; x=1791860869;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fNeoxAcpqLuP6xVkV/ooADVzEQHG7XjJg+hDhApi/Aw=;
        b=ga1kSCmteCs8B14Y1FjmMG+gaQ4LX9EMsiTG9kGtPgA9WVW9OD1l8tBoqi7O29Gsbl
         9F2oBc8RkaxEjwKKThb/2FlTEGyZ/DtJAGa/vvzffWiZY090yIoqSwOjEFwk48Hmr/wm
         kVoAXvuB+xhRtOQeKxvuzfACZ8F1MRLBPVsw3JuTzMi48nzfJN1RHXotXoYRIPewVGFb
         MbP7qAnQXSQKqn+D1rxoRJ46jfjBklf3ctufylQ8fNapHZzi3jgZizRd11jS8kUV9Tex
         y0bbFC7V3Ya+KtrD22KbvOS0LS1vV0mRa8/UTJsa9k8FGvhNkgF+/6ox+c0oeCHSZqv4
         Zjjg==
X-Forwarded-Encrypted: i=1; AKwUvBxlONOoVm6kgnc5s8LBfZw8fjMAOlR8n+Rxf/VdEyroJFsBsfdL1S56bQeUktRo2u9Q/i8=@vger.kernel.org
X-Gm-Message-State: AFuF++lXwtSA2QuskF669b7tyudibWB1Jr07MXY66fL6UOeqEZIteqve
	qmFcMA1YE7tbISkqkB9bDYOWc8QsdNTCl2BiszVTt9RSYe5iN2ah8wh8esy7Au4Dq6f3h5aIwt9
	c1SINOBLjYOcD6MkBBX+DJHIVFfmwGeY3t3yXo59mBqfY8K4V6ny0AQ==
X-Gm-Gg: AYBFou1ewALEIifhuwsil2yyM9OB3QpDjTK7Y2X1Lulc41htHY5oD1igXuqcexhhlvw
	U+VsuQcGNEZTVDnkHQOQyeY4jb0l0lsdr23KrbRva9fvPcDwzS0hAcl89YUuqMNVJx9lMr+uewx
	1PVT92n1FT8O75dQEzTnID5rycyuO03oJcP157/SI99aXTmAhEQw1fY7+LooGsUP7iTJAFxAOK5
	vaq8xpIR8duqoNxGW1LG2HFLrSbqghSkEvozrlSwZM9rbnZc2SjCRpJ0RlujAq0czj8s9/gtC3n
	35PKMwdPHg5NhKxXxyLGHXTdEmzxDLKTPuMse57cdtDTV5E2DlUB5vDRHvugccNCcQQ7f5BG6P3
	SqU/4L6BSHoozTWqr+bUhjpiFXQO+r0Fw42Ssiv2HLw==
X-Received: by 2002:a05:6a21:1392:b0:3e0:c57c:200b with SMTP id adf61e73a8af0-3e0d6cda067mr8229893637.40.1791256068598;
        Mon, 05 Oct 2026 20:07:48 -0700 (PDT)
X-Received: by 2002:a05:6a21:1392:b0:3e0:c57c:200b with SMTP id adf61e73a8af0-3e0d6cda067mr8229853637.40.1791256068087;
        Mon, 05 Oct 2026 20:07:48 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cce6b542fc9sm1722095a12.1.2026.10.05.20.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 20:07:46 -0700 (PDT)
Message-ID: <d8bdfcaf-3b4f-4ab1-9b73-597c60bbb60b@redhat.com>
Date: Tue, 6 Oct 2026 13:07:37 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 13/23] KVM: arm64: Abstract out memory abort handling
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
 <20261005090754.2140522-14-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20261005090754.2140522-14-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/26 7:07 PM, Suzuki K Poulose wrote:
> Move the memory abort handling under VM specific s2 operation.
> 
> Tested-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v21:
>   - Rename protected_vm_mem_abort => protected_pkvm_mem_abort for consistency
>     with the other callbacks.
> ---
>   arch/arm64/include/asm/kvm_host.h |  2 ++
>   arch/arm64/kvm/mmu.c              | 33 ++++++++++++++++++-------------
>   2 files changed, 21 insertions(+), 14 deletions(-)
> 

One nitpick below. In either way:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 0778c308ce597..7cb343583953d 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -156,6 +156,7 @@ struct kvm_vcpu_ops {
>   };
>   
>   struct kvm_gfn_range;
> +struct kvm_s2_fault_desc;
>   
>   struct kvm_vm_s2_ops {
>   	bool (*vm_age_gfn)(struct kvm *kvm, struct kvm_gfn_range *range);
> @@ -166,6 +167,7 @@ struct kvm_vm_s2_ops {
>   	void (*vm_stage2_unmap_range)(struct kvm_s2_mmu *mmu,
>   				      phys_addr_t start, u64 size,
>   				      bool may_block);
> +	int (*vm_mem_abort)(const struct kvm_s2_fault_desc *s2fd);
>   };
>   
>   struct kvm_s2_mmu {
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 9cc7fcde4dd0a..ccbe2ffeda40b 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1740,7 +1740,7 @@ struct kvm_s2_fault_vma_info {
>   	bool		map_non_cacheable;
>   };
>   
> -static int pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
> +static int protected_pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
>   {
>   	unsigned int flags = FOLL_HWPOISON | FOLL_LONGTERM | FOLL_WRITE;
>   	struct kvm_vcpu *vcpu = s2fd->vcpu;
> @@ -2178,6 +2178,20 @@ static int user_mem_abort(const struct kvm_s2_fault_desc *s2fd)
>   	return kvm_s2_fault_map(s2fd, &s2vi, prot, memcache);
>   }
>   
> +static int kvm_vm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
> +{
> +	struct kvm_vcpu *vcpu = s2fd->vcpu;
> +
> +	VM_WARN_ON_ONCE(kvm_vcpu_trap_is_permission_fault(vcpu) &&
> +			!kvm_is_write_fault(vcpu) &&
> +			!kvm_vcpu_trap_is_exec_fault(vcpu));
> +
> +	if (kvm_slot_has_gmem(s2fd->memslot))
> +		return gmem_abort(s2fd);
> +	else
> +		return user_mem_abort(s2fd);
> +}

The "if...else" block is moved from kvm_handle_guest_abort(), but it might be
clearer if we have:

	if (kvm_slot_has_gmem(s2fd->memslot))
		return gmem_abort(s2fd);

	return user_mem_abort(s2fd);

> +
>   /* Resolve the access fault by making the page young again. */
>   static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
>   {
> @@ -2447,19 +2461,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>   		.hva		= hva,
>   	};
>   
> -	if (kvm_vm_is_protected(kvm)) {
> -		ret = pkvm_mem_abort(&s2fd);
> -	} else {
> -		VM_WARN_ON_ONCE(kvm_vcpu_trap_is_permission_fault(vcpu) &&
> -				!write_fault &&
> -				!kvm_vcpu_trap_is_exec_fault(vcpu));
> -
> -		if (kvm_slot_has_gmem(memslot))
> -			ret = gmem_abort(&s2fd);
> -		else
> -			ret = user_mem_abort(&s2fd);
> -	}
> -
> +	ret = kvm->arch.vm_s2_ops->vm_mem_abort(&s2fd);
>   	if (ret == 0)
>   		ret = 1;
>   out:
> @@ -2873,6 +2875,7 @@ static const struct kvm_vm_s2_ops protected_pkvm_vm_s2_ops = {
>   	.vm_age_gfn			= no_age_gfn,
>   	.vm_test_age_gfn		= no_age_gfn,
>   	.vm_stage2_unmap_range		= no_stage2_unmap_range,
> +	.vm_mem_abort			= protected_pkvm_mem_abort,
>   };
>   
>   static const struct kvm_vm_s2_ops pkvm_vm_s2_ops = {
> @@ -2881,6 +2884,7 @@ static const struct kvm_vm_s2_ops pkvm_vm_s2_ops = {
>   	.vm_age_gfn			= pkvm_age_gfn,
>   	.vm_test_age_gfn		= pkvm_test_age_gfn,
>   	.vm_stage2_unmap_range		= pkvm_stage2_unmap_range,
> +	.vm_mem_abort			= kvm_vm_mem_abort,
>   };
>   
>   static const struct kvm_vm_s2_ops kvm_default_vm_s2_ops = {
> @@ -2889,6 +2893,7 @@ static const struct kvm_vm_s2_ops kvm_default_vm_s2_ops = {
>   	.vm_age_gfn			= kvm_vm_age_gfn,
>   	.vm_test_age_gfn		= kvm_vm_test_age_gfn,
>   	.vm_stage2_unmap_range		= kvm_vm_stage2_unmap_range,
> +	.vm_mem_abort			= kvm_vm_mem_abort,
>   };
>   
>   #define KVM_VM_S2_OPS(flavor, ops)		\

Thanks,
Gavin

