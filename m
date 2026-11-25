Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627794;
	b=v4za2O/T2pe8CMpGjSmIJQf6TV1avDF8fUzjq8xU0HqXxA2ZnjPP8HcAb2Y6nPmBUIAO
	 f5FJFYwH8acrC9ZjdhVc/yTrNGcgQFYrPPvwpTtijkwUO/wWZx50gT8M2FKscM3kYy5Mv
	 NF1pf54+tjnZlxAGuJFOYSQCazxu+XBRAtIvLY/mHwIv+aYQprPu3QJLh02oaDiweLux6
	 hhYrWM57HiuYCzM47UGfaIiIujeGMp/fwamDtWsr2O+kN/902dmgvIQIzsT2GVoBUN9Og
	 kiVEfctPGBb4PKJNVqJARQCbJrZZKLahYlI1XQRjnhd9vfCJqnQGPnxdgIPkitPo/xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627794;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=YJ8R+dYZDQ9KyTkPEremEmFEW4vzpcNZM9DVH1mOkXU=;
	b=0vtzLTsxw95ac8U4a6EfmKZMxaMIXusz9I4+ubfYm92Rsi+BWEQ6/hqm0cBjLZXU2CbA
	 gZ/rX0Tk7yKhFy0SHT/P4iFaHSplEh2Z6k0k+8Inn28KYm48sUpIjH/xnqZiHLoXwocdC
	 2AZSfXuBKhDEtt46bB6rI/g2lv5YZ1Ikd+DCW8ei0Oji0zVDu//iaKLs6gRcuWcThyRee
	 ern/GUxusFcdVtDffOtPlL0CdD/nlCk9j4ytBjYQAPr++Xuvo80okWi3ldQmVBJ3aSOzG
	 s3JUwalakrJE/NsljDE1PDYE0vmuXWOaL/i/Gz4JRg69vIIZix25WWUk9XY1YWXjvGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iF0cREcs;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=E6Yr8D5E;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E592606A321
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 17:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E592606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iF0cREcs;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=E6Yr8D5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795627793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJ8R+dYZDQ9KyTkPEremEmFEW4vzpcNZM9DVH1mOkXU=;
	b=iF0cREcsXl50pzH64ghm7b9W7ovD4f9nlNzOcvwYgWsPL6tr8B1pspfClWyhcB+gI2dnA9
	g9IXdYPmYrEvVBxSSHgAb28Gs1FrqMk/65ZpRlm0L1ack1V4tdqL8IdEzeQyQibF6plqL/
	twUwBtOZLaDgbGGSz4jl6MF/N9rFB0Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-KpRg7L5IPueQhOe9ZCAFpw-1; Wed, 25 Nov 2026 17:29:50 +0000
X-MC-Unique: KpRg7L5IPueQhOe9ZCAFpw-1
X-Mimecast-MFC-AGG-ID: KpRg7L5IPueQhOe9ZCAFpw_1795627790
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c508f61e492so439960466b.2
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 09:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795627790; x=1796232590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YJ8R+dYZDQ9KyTkPEremEmFEW4vzpcNZM9DVH1mOkXU=;
        b=E6Yr8D5EMn+yx903zHBvzvvEkX6cYwusARxZdaK6nYn0TjYVBV6W91fq8R2MDC7+x6
         JBoQKtwQ/N/PXhZdj0xbBqHHZpXUQLPDlzh4wPDEGyoPVi1Cab+8CJr4fScTniklqWtW
         Kr7J04lVgvVWQvZOBChRjnzYizgNRGLnO2ZWPwaU2xddS+1HuwOwZ/SEB5ts6a93I+PX
         +01AORl+AZSAdgUD+ZdFbMkrhDapi/eMe18u69n53+zhxpHHbJMQS88jACaF/zFLmsns
         0G3FdbVlf2TqKL0uq1MeGwvzGh1RVIQWSRPr71MzHlpagSf49Dh5qKSd17QTjKGdxUR8
         +6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795627790; x=1796232590;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YJ8R+dYZDQ9KyTkPEremEmFEW4vzpcNZM9DVH1mOkXU=;
        b=aLm+bnAg3X0nWqoCpsKKY57j1mR2wo3Jelq2WpKD6Ojopuh1NApIMdSC+iG1zb7xJK
         UXux+wPCDKijPJWAE1e9SsCmpEPwOT5NFv/VXfBp9vMyUWmwqQZ8zlz+cSGQ9A4F4dp4
         IJwfgJFPCALNoVoQ/O4V5NREHqna1iCJSklNQmMUVZVxCsSsZqtQKA/TiM0NaTtn9Bs/
         BYMMhgY75vb1U5bQWbaL4tf7RYrxBaSEQvL7QodO4fdKaqzgIiB8UMSWtxnbM5DV6qVK
         /65FVwITLA/UrVJRqSNues5TdDuHMhhaG8d6RVq6NuHtaTme3yIRxnxMAf/z/RN+TvIe
         dlrw==
X-Forwarded-Encrypted: i=1; AL+hErEAUo7jYdLpeRjauC0hREYOtF2xTq00enDNyFRk+YGg0odK1dfzcXWQqHgCjbiJ9utLE+U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dxUMMqhT86HslgTXRt1PtoEvgLtgjjG/6i5DBaj8Ii/SiWBGR
	fkkpSOCAJFwaLfEQ3iTjCEHx7XINP8SrcbI8ozRUGiknq+adliE/bSqkI3bey7NzAAtTv+K56IK
	DHoy9UFB3vNmPc9zDB538r0pZESokXgfuMgyFk90EEjG7YYgDR7eshA==
X-Gm-Gg: AZFdTZd16Pw5s9fOVHADRgLn68vB+1+yYLvXRil1elnwRUAOWgaY7QEybOqefn6RXBW
	1VvtHu8fvq8OscZ7fOinTjxW19MpOceJ7GpVHMk5H6F9rslZSrA4X47Qg+ot6iJA8WAaLtssJZU
	Bpy1jUdZsS/EbXxZPDxxaZgstwZ0MxBjT1CDOIOqZWQ5whVu+kBi+es5BNxKAHdYj6FGua16Roj
	iW8L3MOBX6IksMHHYuA1aEL2YM/Y0Wm5MM1e05izm18QYpZmDo2FgdLNcSGyKApwTfU4groQzLG
	aeNueVJm32VThw4wPQxbgHTd3hU/Y4k44DlmiBqd/nvlScIatQx2q5vlCvEu7akx9Dga22is9ly
	84TF/ABvnlsnZOjv1aahZpILfbsBjrvsdBXKfAnn6KhQozIdnRp6WubaA+ftiGyTFYYpLX2hF8+
	bjUMC8nk+rxzzTJCjM
X-Received: by 2002:a17:907:ea90:b0:c50:5e90:5ea7 with SMTP id a640c23a62f3a-c513ac9dac3mr1535855566b.49.1795627789646;
        Wed, 25 Nov 2026 09:29:49 -0800 (PST)
X-Received: by 2002:a17:907:ea90:b0:c50:5e90:5ea7 with SMTP id a640c23a62f3a-c513ac9dac3mr1535854166b.49.1795627789196;
        Wed, 25 Nov 2026 09:29:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:af16:8320:54ea:4bc9? ([2a01:e0a:f0e:9070:af16:8320:54ea:4bc9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513acfe25asm670749766b.11.2026.11.25.09.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 09:29:48 -0800 (PST)
Message-ID: <63fcaf35-5d3f-42fb-868f-9fcd644bf494@redhat.com>
Date: Wed, 25 Nov 2026 18:29:47 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/3] arm/kvm: select an nVHE-only EL2 with
 SYSREG_ID_AA64MMFR1_EL1_VH
To: Haseeb Ashraf <haseebashraf091@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
 Eric Auger <eric.auger@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Khushit Shah <khushit.shah@nutanix.com>
References: <20261121095636.289814-1-haseebashraf091@gmail.com>
 <20261121204601.741616-1-haseebashraf091@gmail.com>
Content-Language: en-US
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20261121204601.741616-1-haseebashraf091@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Haseeb,

On 11/21/26 9:45 PM, Haseeb Ashraf wrote:
> From: Haseeb Ashraf <haseeb.ashraf@siemens.com>
> 
> Hi,
> 
> KVM presents a VHE-only EL2 (HCR_EL2.E2H RES1) to a nested guest unless
> KVM_ARM_VCPU_HAS_EL2_E2H0 is requested at vCPU initialization.  Guest
> hypervisors which only support nVHE, such as Xen, cannot run in that
> mode.  This series lets the user select an nVHE-only EL2 with:
> 
>   -M virt,virtualization=on -accel kvm \
>       -cpu host,SYSREG_ID_AA64MMFR1_EL1_VH=0
> 
> Following Marc's feedback on v1, this is built on Eric Auger's
> SYSREG_<REG>_<FIELD> framework instead of a new machine or CPU
> property.  It is an RFC because that framework is not merged yet.
> 
> Dependencies
> ------------
> 
> The series applies on top of the remaining patches of Eric's v11 [1],
> which are on his arm-cpu-model-v11-rc branch [2], rebased on current
> master.  On current master those patches need two mechanical build
> fixes: object_property_add() now takes &uint64_type_info, and
> kvm_feature_idx_to_idregs_idx() must sit after kvm_arm_sve_get_vls()
> instead of inside it.  The fixes belong to Eric's series and are not
> part of these three patches.
> 
> Questions
> ---------
> 
>  - KVM does not let userspace write ID_AA64MMFR1_EL1.VH, so the generic
>    "writable fields only" rule would not create the property.  Patch 2
>    treats VH as selected through a vCPU init feature and exposes it as
>    an exception.  Is that acceptable, or would you prefer a generic
>    representation of such fields in the framework?

Well I am a bit embarrassed to answer at that point since the series is not fully reviewed and this addition blurs some lines.

We have a way to introspect which fields that are let writable by KVM. We don't have any way to understand which bit can be set at VCPU INIT. So hardcoding the exception is the only way I see. If this tends to reproduce we can effectively have a table for such fields but I am not sure this would be needed at that point.

Overall it complexifies the logic & description of those properties because we said they apply at the end of the init chain and now we start to have a mix. We said SYSREG props were not supposed to replace legacy composite options. Now I guess it paves the way to have SYSREG props that do stuff at vcpu init and latter which is less obvious.   >  - Only VH is updated in QEMU's copy of the ID registers.  Other fields
>    which KVM derives from E2H0, for example ID_AA64MMFR4_EL1, are not
>    refreshed.  Is that acceptable, or should QEMU re-read the ID
what do you mean by other derived IDREG fields are not refreshed. Isn't it done automatically by KVM when you apply the VCPU init to reflect the above changes?

Adding Khushit in the loop.

Eric  >    registers after vCPU initialization?
> 
> Scope
> -----
> 
> TCG and HVF are unchanged by design.  The property is available for the
> host (and max) CPU model with KVM, when the host kernel advertises
> KVM_CAP_ARM_EL2_E2H0.  Xen and QNX already boot with TCG, where
> HCR_EL2.E2H is under the control of the guest.
> 
> Changes since v1 [3]:
> 
>   - Removed the dedicated virt machine and ARM CPU "vhe" properties.
>   - Switched to Eric's SYSREG ID-register framework and use
>     SYSREG_ID_AA64MMFR1_EL1_VH to select an nVHE-only EL2.
>   - Exposed the property only when KVM advertises
>     KVM_CAP_ARM_EL2_E2H0.
>   - Derived KVM_ARM_VCPU_HAS_EL2_E2H0 from VH and rejected VH=0 when
>     virtualization is disabled.
>   - Added documentation and a KVM functional selftest which verifies
>     that the guest hypervisor initializes in nVHE mode.
> 
> Testing
> -------
> 
> Validation was performed on an AmpereOne A192-32X (Ampere-1a) running
> host kernel 6.18.29+3-arm64:
> 
>   - TCG-only, KVM-only and aarch64-linux-user builds succeeded.
>   - TCG rejects SYSREG_ID_AA64MMFR1_EL1_VH because the property does not
>     exist for that accelerator.
>   - The existing AArch64 KVM nVHE and VHE selftests pass under TCG.
>   - The arm-cpu-features qtest passes.
>   - Linux 6.12.67 initialized KVM in nVHE mode with VH=0 and in VHE mode
>     with VH=1; both boots reached login.
>   - QNX Hypervisor 8.0.5 reached login with both values and reported the
>     corresponding ID register state.
>   - Xen dom0 reached login with VH=0.  With VH=1, Xen did not boot.
>   - The complete AArch64 KVM functional suite passed, including the new
>     nVHE-only selftest.
> 
> Not tested: live migration, and hosts other than AmpereOne.
> 
> [1] https://patchew.org/QEMU/20261030131406.461599-1-eric.auger@redhat.com/
> [2] https://github.com/eauger/qemu/commits/arm-cpu-model-v11-rc
> [3] https://patchew.org/QEMU/20261121095636.289814-1-haseebashraf091@gmail.com/
> 
> Thanks,
> Haseeb
> 
> Haseeb Ashraf (3):
>   target/arm/kvm: Add kvm_arm_el2_e2h0_supported()
>   target/arm/kvm: Let SYSREG_ID_AA64MMFR1_EL1_VH select an nVHE EL2
>   tests/functional: Add a KVM selftest for an nVHE-only EL2
> 
>  docs/system/arm/cpu-features.rst     | 22 ++++++++++++
>  target/arm/cpu-idregs.h              | 31 +++++++++++++++++
>  target/arm/cpu64.c                   | 51 ++++++++++++++++++++++------
>  target/arm/kvm-stub.c                |  5 +++
>  target/arm/kvm.c                     | 29 ++++++++++++++--
>  target/arm/kvm_arm.h                 | 13 +++++++
>  tests/functional/aarch64/test_kvm.py | 22 ++++++++++--
>  7 files changed, 157 insertions(+), 16 deletions(-)

