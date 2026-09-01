Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0219A3AFD0A
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 04:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788236981; cv=none; b=Opy0HcGfM0fSNgmPAeEraQ191hnA1FYh063vAt1v+Gz5qcu8RzOq3u06gMSLN3Ab2dHLjdAo9B6eDAXVzP9nmnAtJo5RZGOFi1XhsFKma01GoVragPgOInGPlpmIklhu/Ij6RkaJ9Jr289XNBK1peC+CFo+Y50HPRaN/P8S31oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788236981; c=relaxed/simple;
	bh=b/q72RLD9lBRxi2VmlFM4dWbgfCb6GrTRD2Ri5Ba41s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OyoZt27WXvmx/7noBmtkGthpScRjrbF30fr2JJEM5Y2myJW1yzlx1Xo3tGj5sRxgSJyvJumAxce/mcyqCnPi0U8olQOdZJ/ZIK3RwN5pDmRHJNgVqDKg/KUswEHb61nTc+/a25WIVPQOnyOBe4IMX1mQ4FABJefP5tazUn8+EfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A4tcZVGE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMsvE++6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4tcZVGE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMsvE++6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788236978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCQU+V95xqEH8EbNTciL/CsMqe3BTX/wUO0rCYM10FE=;
	b=A4tcZVGE4bceXNMihwcmmtZgtCsA6DhSssCnRXhfCx+oNxTIhBVD3ou4UQCSBFS2dnshub
	bwCrcnLMl4XbDJ8Rb5hEAtbdnj1nVTuyY27pvkiA4jipy1i7PqOLLU+dwI9OZKsdGzvaUs
	MZkX9RsztIfB4ASsHv2qmfbHFsck+E0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-RmI_GpFDOra-5skgA-mmig-1; Tue, 01 Sept 2026 00:29:35 -0400
X-MC-Unique: RmI_GpFDOra-5skgA-mmig-1
X-Mimecast-MFC-AGG-ID: RmI_GpFDOra-5skgA-mmig_1788236975
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d02df2bf09so41475805ad.0
        for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 21:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788236974; x=1788841774; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YCQU+V95xqEH8EbNTciL/CsMqe3BTX/wUO0rCYM10FE=;
        b=NMsvE++6I9fn7aSErb3o67Ji9NQU272oz3zfRNJkPQ/gWQQ6gIiyqgSSxM9dMDC1/f
         113oVV1yVIyUJBs5LqcmbgfO5Agc+/mH0zJXGRxhTU1M2XwDn5woFWJ1Vt3KMb5qQWa1
         6zDivTbm6CXRtIAETQpbGBz82USH1XziqNNRGuN+JPN+gpLr04riNc3hQlFdUdjzNZyD
         Pm8wGJC+W/Ivaab1uCUuKemvJ9BDMuNXZ9aN9iELBIQnrFew3Wk3qJ8lDk8sK+35MrJE
         Para5AyX7uoIeE0tidigjc+fgI/ydNtSoeEm94tNnGX2xknnltm0MbLPSO/B9OEpfYFo
         C9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788236974; x=1788841774;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YCQU+V95xqEH8EbNTciL/CsMqe3BTX/wUO0rCYM10FE=;
        b=snIURyHHpFPDgFGkk8B8K4IvC4Ju8xWar/74wdiwZiCFc3zH7r0RVBSjlEEesR87mC
         7RCAfInsO2VpWAUJJ/yY6UjSTVmFxTl88ZLjOQwz5O+XKBYwV+z/HgNvfA15SVBiWAep
         DmblYHnaFM+QwdVWNbozmeYCBEbTODgtb9AiFofzvgbhByyVCrqMtzCYlguQZwe8PRPN
         smAyFu87CEJnuNabtaUq6lk5Wx+10XWDKeltUYL/QYAgWLCIndc42fW8lGx/Sdn3ZCH0
         0FG4xr+72eF4Ey+RblnumlkwT4CgF64EX3DD9S7GX1XYJpGq+3N+Ez2IDwo+6eOVJX9Y
         hRbw==
X-Forwarded-Encrypted: i=1; AKwUvBx29MGQYgZjOwBtS956WnXvYXDs39iHagV9BmzmuLWLAQX3akNe4VnVucY9YMg1TdSi6hc=@vger.kernel.org
X-Gm-Message-State: AFuF++nyPXfN/k/XKHburU6yg1hYfROZBSRJ+ACQ7rIg2It6ERxhxWmJ
	veFuPEoYpDytpe2MWH8THSBQBnHQ54I6qOzJzLf3W1WgqVPgnYFIdPu1ag4XnTLHt/TNhg02hf7
	zl90wMixnHnbLIDLfefYpe/WEowuuNH/g9sh5xlm2Ozj7dFIERvWmBA==
X-Gm-Gg: AYBFou1FJb1Xzf9eT7lGGmDi/wOwpnivTlLpUWs1FDEgccDZYA+7WKiHXbtNFy3ZaH9
	pKu+vsHcceRhPSi27p2aevGXIioE0eS3/Czm6QE9bN5Sii9HcH37PnkD7ScvTKyUGcBdbf58Wvi
	yKwNAKKr6vXOGX7hcCO9VJ6GPge1sJwIbefHVQLtoCvD/KT0WqmFo02xtmD1ynq/p1A0kv5nVh4
	MigK2AuRh9sveO8F/spR9DH4ho4WkaSKJXUh+iKBwd5WRsZ61OgQOrO8uqjWCHdXE5vbvTue/sX
	CGU1tQT8CCBo5jmjC6oqCIEuM/DwBo5reGLTBJKUT7kkhHvTdIpE8QRXagFRZ/86kh4NspBfaMg
	PirDCiiWZ3cFX4g4palUPgbmKrbWnXjdDz8nBP+EKUg==
X-Received: by 2002:a17:903:2acb:b0:2d9:1c02:5a19 with SMTP id d9443c01a7336-2d94a956b48mr72439835ad.22.1788236974295;
        Mon, 31 Aug 2026 21:29:34 -0700 (PDT)
X-Received: by 2002:a17:903:2acb:b0:2d9:1c02:5a19 with SMTP id d9443c01a7336-2d94a956b48mr72439155ad.22.1788236973766;
        Mon, 31 Aug 2026 21:29:33 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f95a847sm30663601eec.17.2026.08.31.21.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 21:29:33 -0700 (PDT)
Message-ID: <8e699e2d-c04c-4ff7-98a3-c01e573ee817@redhat.com>
Date: Tue, 1 Sep 2026 14:29:22 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 15/45] KVM: arm64: CCA: Don't expose unsupported
 capabilities for realm guests
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei
 <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Emi Kisanuki <fj0570is@fujitsu.com>, Vishal Annapurve
 <vannapurve@google.com>, WeiLin.Chang@arm.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>
References: <20260803134403.80630-1-steven.price@arm.com>
 <20260803134403.80630-16-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260803134403.80630-16-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steve,

On 8/3/26 11:43 PM, Steven Price wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> RMM v2.0 provides no mechanism for the host to perform debug operations
> on the guest. So limit the extensions that are visible to an allowlist
> so that only those capabilities we can support are advertised.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v13:
>   * Add missing check in kvm_vm_ioctl_enable_cap().
> Changes since v10:
>   * Add a kvm_realm_ext_allowed() function which limits which extensions
>     are exposed to an allowlist. This removes the need for special casing
>     various extensions.
> Changes since v7:
>   * Remove the helper functions and inline the kvm_is_realm() check with
>     a ternary operator.
>   * Rewrite the commit message to explain this patch.
> ---
>   arch/arm64/kvm/arm.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index c4d906861736..6f39831dcf5d 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -135,6 +135,26 @@ int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
>   	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
>   }
>   
> +static bool kvm_realm_ext_allowed(long ext)
> +{
> +	switch (ext) {
> +	case KVM_CAP_IRQCHIP:
> +	case KVM_CAP_ARM_PSCI:
> +	case KVM_CAP_ARM_PSCI_0_2:
> +	case KVM_CAP_NR_VCPUS:
> +	case KVM_CAP_MAX_VCPUS:
> +	case KVM_CAP_MAX_VCPU_ID:
> +	case KVM_CAP_MSI_DEVID:
> +	case KVM_CAP_ARM_VM_IPA_SIZE:
> +	case KVM_CAP_ARM_PTRAUTH_ADDRESS:
> +	case KVM_CAP_ARM_PTRAUTH_GENERIC:
> +	case KVM_CAP_ARM_RMI:
> +	case KVM_CAP_SYNC_MMU:
> +		return true;
> +	}
> +	return false;
> +}
> +

Nitpick: The code can be simplified a bit if @kvm is passed to kvm_realm_ext_allowed().
In this way, kvm_realm_ext_allowed() looks similar to kvm_pkvm_ext_allowed().

static bool kvm_realm_ext_allowed(struct kvm *kvm, long ext)
{
	if (!kvm || !kvm_is_realm(kvm))
		return true;

	switch (ext) {
	case KVM_CAP_IRQCHIP:
		:
	case KVM_CAP_SYNC_MMU:
		return true;
	}

	return false;
}

>   int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>   			    struct kvm_enable_cap *cap)
>   {
> @@ -146,6 +166,9 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>   	if (is_protected_kvm_enabled() && !kvm_pkvm_ext_allowed(kvm, cap->cap))
>   		return -EINVAL;
>   
> +	if (kvm && kvm_is_realm(kvm) && !kvm_realm_ext_allowed(cap->cap))
> +		return -EINVAL;
> +

	if (!kvm_realm_ext_allowed(kvm, cap->cap))
		return -EINVAL;

>   	switch (cap->cap) {
>   	case KVM_CAP_ARM_NISV_TO_USER:
>   		r = 0;
> @@ -380,6 +403,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	if (is_protected_kvm_enabled() && !kvm_pkvm_ext_allowed(kvm, ext))
>   		return 0;
>   
> +	if (kvm && kvm_is_realm(kvm) && !kvm_realm_ext_allowed(ext))
> +		return 0;
> +

	if (!kvm_realm_ext_allowed(kvm, ext))
		return 0;

>   	switch (ext) {
>   	case KVM_CAP_IRQCHIP:
>   		r = vgic_present;

Thanks,
Gavin

