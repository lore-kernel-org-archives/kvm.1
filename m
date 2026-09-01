Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270CF20D4F0
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 04:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237951; cv=none; b=NAkBE603WCg4BdHRNMEZwGDWcLfUphpRKotX/sikzQ578MgdLl5LFG0LxD8jihCijdPFAav3GUxhnE6z/hD09krazdL+kS1KqeAlJ4/zybJCHV8dOtwErGsfSyRHcfqj5XcaP9P8agOxQSzz196cjXKKVu/iGEubSorAkn+ZBk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237951; c=relaxed/simple;
	bh=Jmkwxqy/ZvGVHKyyYPxHqUaecy4WhtwqUYZDe5W9ceo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4ly5fBJES1DVVdJ27pycciaq2K2lCRyeelmY5BlHZooblNPXPjsDD7aGcou+7IZMPwOXn2S9JDyEwa0bR7Y8aYyjrKG717ZO2CjqeorMt/Z36IUVRU8qmBgms3EPalp3ynYmjsE9B3jKq9Y7Pw1e+xzs2ZvIdVBKzDdVD6T2lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OORIIB3B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SgSzd3Cu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OORIIB3B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgSzd3Cu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788237949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJEzvIaybX9Dts9DYz8bf1h8e9d8Ys+d8ayhElVmFmU=;
	b=OORIIB3BY0QqW5OJa7EMhJNk5MrXhD4EaQRJAEe7uBvcyUqhMG3hBLmPkmuBYoAOZJFb5p
	of8nEOcH/bJsoB79b2Y+TLEjq+0VGIgySGy2xzLolylAg6a51tqrGm37DqBuoHYMhVJG+l
	T5Sz8UdEUZzjY1zqEM+oAC4GnX0ne4M=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-PEXk6GTjOmKoQ0IZtQUVVA-1; Tue, 01 Sept 2026 00:45:48 -0400
X-MC-Unique: PEXk6GTjOmKoQ0IZtQUVVA-1
X-Mimecast-MFC-AGG-ID: PEXk6GTjOmKoQ0IZtQUVVA_1788237947
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f283baf1fso857801a91.3
        for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 21:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788237947; x=1788842747; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pJEzvIaybX9Dts9DYz8bf1h8e9d8Ys+d8ayhElVmFmU=;
        b=SgSzd3CuRTO/so/a8dLXrEFk29MrF3roqbSY2/PG0gzwX+5sGjG+YlDJC8U+XpnbkC
         iCzs6w/XbL1TZ9qsuRUJJ34fUxpDlkmHtBM7cB6mpl3wBNUjHxF+ZK3duV8gCK7Mwg26
         0czKA3se30MegtbcQ53SSDCNl7GVU1mxhge25sWXpNVNKSy0iXR4BGKdRZs1LpiY9+Id
         P2yVwI5y8Xwvx7gaUC0LlIyRVaj8JE6WCjU7mIUCxw0dTLXTEqxhdL+GEHAflkJdd6tu
         kR5a1n4II87cY+uldkDUID66Ig+eOTopk1wIr17ubXBv6T4+OvbHy5hR27k9TLETk5zZ
         HbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788237947; x=1788842747;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pJEzvIaybX9Dts9DYz8bf1h8e9d8Ys+d8ayhElVmFmU=;
        b=EqwViSHvHn2gRDgr/XqIbym1vzSesgk1wdhaXlPkaXn4gUSPZUDLkh0V4SHkuEKYCN
         moahgZOqhX7yK/ecf96UCgGei4gOJ+lC7DiStEpbHTKOTnIt8XB4GIUtXV3J8iZrL1em
         o9Hdq3AodSJphKUB3RTPEy7HIRApJ4Y5YBX7J4g9XcQdeHmddRgywkWUDa9yOGNlKafX
         fIdErZ9N4zxqMmCdAFXn/3xG+/sX9GoP30HWZx7Ji9bh5y7lQH0HwPtJ6aDOr6MIk7/f
         jF+O2nJIKvlZ7wz84X2WAGJ4hOK0hOakRCkU/NAs5fP5ZnYnpmQ3/NQVBhTNPX6xO8XN
         7QGQ==
X-Forwarded-Encrypted: i=1; AKwUvByN6TnZhfV5pSnzoBBo43JtToXiKhk476sv5qPkbjxbgCIMt+LXG3AFI3QqW/rQb8q8BHA=@vger.kernel.org
X-Gm-Message-State: AFuF++laSbIeuhsAAK70EdQndVzLprD27M7DHHcKSGY2Xfew/+uh1K7H
	VBclQrK4UzDS9kZowe9Z2jGcWHeZyPPsRvrVJyYgprr9ypv7/krclm8d9OghsltHJe8lkM2rP/u
	7plVRlZnq0MAvqjKJdFJGH6jjvoklR+GXv53CvvA7tZWVlmJ9JaaeEQ==
X-Gm-Gg: AYBFou0qQGBJ8JQRJI/ZX5E/M/QmQ/zeM80bsNsDRkcU9YBjVR3mmS3ZdBp6+0yxfJa
	Sjw3T2eCUhl04joehXnr3jjohUi+eZNnYeEz/TKvZk7zK7Ho8EzICC4OQX+W+sdiBZqTUOOyfj4
	RL1UWC+7vT95yrU/W/v5Xp2Hf8S/wVyMAALSeYI4VIlsw4ctbFPXXf8LgALRMo0Uq6AQozaJs9x
	uvdYU94he+qQb8aoslyOYfIVV5hA+Kuuv1F1NC2VF+Hcj5WxTzjBkswBh5x9EEXGGkBkMj2x637
	ZlVUp8pOh0GQEI0FFHsWyjq5KwRP2aO2fhTs+V4kWj4gyapbKfjMDaV3yPoqVRNoDbpV0iNzMkQ
	xLGuGQYD+C9UTPzrumDi7uBgXg2y53DHotqmpsGVIDA==
X-Received: by 2002:a17:90b:3c45:b0:398:c292:ac80 with SMTP id 98e67ed59e1d1-398c292b6b2mr26462475a91.10.1788237946697;
        Mon, 31 Aug 2026 21:45:46 -0700 (PDT)
X-Received: by 2002:a17:90b:3c45:b0:398:c292:ac80 with SMTP id 98e67ed59e1d1-398c292b6b2mr26462384a91.10.1788237946100;
        Mon, 31 Aug 2026 21:45:46 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f99585csm33333687eec.21.2026.08.31.21.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 21:45:45 -0700 (PDT)
Message-ID: <216cfe43-e696-4de1-bf8e-58b2d35f3372@redhat.com>
Date: Tue, 1 Sep 2026 14:45:35 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 16/45] KVM: arm64: CCA: Allow passing the machine type
 in KVM creation
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
 <vannapurve@google.com>, WeiLin.Chang@arm.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>
References: <20260803134403.80630-1-steven.price@arm.com>
 <20260803134403.80630-17-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260803134403.80630-17-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steve,

On 8/3/26 11:43 PM, Steven Price wrote:
> Previously machine type was used purely for specifying the physical
> address size of the guest. Reserve the higher bits to specify an ARM
> specific machine type and declare a new type 'KVM_VM_TYPE_ARM_REALM'
> used to create a realm guest.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v15:
>   * Specify the encoding for each VM type in the documentation.
> Changes since v13:
>   * Rework to use the two top bits for the machine type now that pKVM has
>     merged and used the top bit for KVM_VM_TYPE_ARM_PROTECTED.
>   * Update the documentation to include KVM_VM_TYPE_ARM_PROTECTED as
>     well.
> Changes since v9:
>   * Explictly set realm.state to REALM_STATE_NONE rather than rely on the
>     zeroing of the structure.
> Changes since v7:
>   * Add some documentation explaining the new machine type.
> Changes since v6:
>   * Make the check for kvm_rme_is_available more visible and report an
>     error code of -EPERM (instead of -EINVAL) to make it explicit that
>     the kernel supports RME, but the platform doesn't.
> ---
>   Documentation/virt/kvm/api.rst | 21 +++++++++++++++++++--
>   arch/arm64/kvm/arm.c           | 11 +++++++++++
>   include/uapi/linux/kvm.h       |  7 ++++++-
>   3 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index ce588c05b26a..802601eaf560 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -181,8 +181,25 @@ flag KVM_VM_MIPS_VZ.
>   ARM64:
>   ^^^^^^
>   
> -On arm64, the physical address size for a VM (IPA Size limit) is limited
> -to 40bits by default. The limit can be configured if the host supports the
> +On arm64, the machine type identifier is used to encode a type and the
> +physical address size for the VM. The lower byte (bits[7:0]) encodes the
> +address size and the upper bits[31:30] encode a machine type. The machine
> +types that might be available are:
> +
> + =========================   =======   ========================================
> + Type                        [31:30]   Description
> + =========================   =======   ========================================
> + KVM_VM_TYPE_ARM_NORMAL      0b00      A standard VM
> + KVM_VM_TYPE_ARM_REALM       0b01      A "realm" VM using the Arm Confidential
> +                                       Compute extensions, the VM's memory is
> +                                       protected from the host.
> + KVM_VM_TYPE_ARM_PROTECTED   0b10      A "protected" VM using pKVM to
> +                                       isolate the VM from the host.
> + Reserved                    0b11      Reserved for future use
> + =========================   =======   ========================================
> +
> +The physical address size for a VM (IPA Size limit) is limited to 40bits
> +by default. The limit can be configured if the host supports the
>   extension KVM_CAP_ARM_VM_IPA_SIZE. When supported, use
>   KVM_VM_TYPE_ARM_IPA_SIZE(IPA_Bits) to set the size in the machine type
>   identifier, where IPA_Bits is the maximum width of any physical
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 6f39831dcf5d..9881fd6c511c 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -249,6 +249,17 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>   	mutex_unlock(&kvm->lock);
>   #endif
>   
> +	if ((type & KVM_VM_TYPE_ARM_PROTECTED) &&
> +	    (type & KVM_VM_TYPE_ARM_REALM))
> +		return -EINVAL;
> +
> +	if (type & KVM_VM_TYPE_ARM_REALM) {
> +		if (!static_branch_unlikely(&kvm_rmi_is_available))
> +			return -EINVAL;
> +		kvm_set_realm_state(kvm, REALM_STATE_NONE);
> +		kvm->arch.is_realm = true;
> +	}
> +

Shall we use kvm_arm_rmi_supported() here? In that way, the check is consistent
to what has been done for KVM_CAP_ARM_RMI. You know that a misbehaving VMM can
issue KVM_CREATE_VM to create a realm VM without checking if KVM_CAP_ARM_RMI
is supported by the host.

	if (type & KVM_VM_TYPE_ARM_REALM) {
		if (!kvm_arm_rmi_supported())
			return -EINVAL;

		kvm_set_realm_state(kvm, REALM_STATE_NONE);
		WRITE_ONCE(kvm->arch.is_realm, true);
	}

>   	kvm_init_nested(kvm);
>   
>   	ret = kvm_share_hyp(kvm, kvm + 1);
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 0231ff174a50..adee3936d6ae 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -700,14 +700,19 @@ struct kvm_enable_cap {
>    * address size for the VM. Bits[7-0] are reserved for the guest
>    * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
>    * value 0 implies the default IPA size, 40bits.
> + *
> + * Bits[30-31] are reserved for the VM type
>    */
>   #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
>   #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
>   	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
>   
> +#define KVM_VM_TYPE_ARM_NORMAL		0
> +#define KVM_VM_TYPE_ARM_REALM		(1UL << 30)
>   #define KVM_VM_TYPE_ARM_PROTECTED	(1UL << 31)
>   #define KVM_VM_TYPE_ARM_MASK		(KVM_VM_TYPE_ARM_IPA_SIZE_MASK | \
> -					 KVM_VM_TYPE_ARM_PROTECTED)
> +					 KVM_VM_TYPE_ARM_PROTECTED | \
> +					 KVM_VM_TYPE_ARM_REALM)
>   
>   /*
>    * ioctls for /dev/kvm fds:

Thanks,
Gavin

