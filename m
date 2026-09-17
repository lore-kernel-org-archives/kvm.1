Received: from mta0.migadu.com (out-209.mta0.migadu.com [91.218.175.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A0B4AE8D5
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644305; cv=none; b=ZBt9USTwlEPjzVp8Xioe9kb0n3cgBRUltFwWPi/f9/sp/BXw/5ooD7ZzsYKRWvyFf/lMcyuxi5D0SxRpGgIegxO6tSrkVhwlL6tCswTRqPEGbOHDuyavUevd1tQbsWFQYAkZXmKPHDNRc4Xt/oMLtlr/ZcmeK49klEZzoxlutXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644305; c=relaxed/simple;
	bh=6cLtGQr3NeN6cuI+wwoUX8J3Vbq5/m8fhyoeTXSQu5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMF+NuNKMrPCjPVZqTv9EjtCpG8vBx7z6Er+Va0UbAAE9FbJFQkmHRgJTRtMhzoO9RVrAFn3NjU82zIzHCjtVV14gPIvMUiW8CYRPIQigKEcTXNwWHwzNxnd3/aaJeDSuhoFB1gTzCwRhl4yS+umZNFRBQbQn6ERzq+NtM43/1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pjJ2UQrZ; arc=none smtp.client-ip=91.218.175.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pjJ2UQrZ"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6cLtGQr3NeN6cuI+wwoUX8J3Vbq5/m8fhyoeTXSQu5k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789644301; v=1; x=1790249101;
 b=pjJ2UQrZPSy32y9oizHMMJcmh5pyDaraotlKB9zcN/IcNMmPkI/F75rz+Pb/YlECyOuibccZ
 P5ZtF/IgCaRMuKScZrnFDzjIVDgZCapxEuTuztKZLdInSFqf3jDcAuhtvNIakDEq0Ik3/JrZhEu
 zIXYuIYGnEV5ko/CxMpCw9lM=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7b6ebce2d6cedfff;
	Thu, 17 Sep 2026 11:25:01 +0000
X-Mizu-Trace-ID: 7b6ebce2d6cedfff
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b83c1421ecso864e87.1
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 04:24:59 -0700 (PDT)
X-Gm-Message-State: AFuF++klNvj4mSGqi1nnt74/Yuv8WoSKWesU3QVqwnvzk4OBVI0oYfHh
	v3I3PhvhjPiZulGG6H6JMWAuuPOPUR5YPnAlNoR9nlUmJfkIn44f28ReUDonVu6LYnxNd4pPGq9
	crm4V6wfq4BXDp+Q3SVnN6AYuCopboWnra4/eioNZ
X-Received: by 2002:a05:6512:3054:b0:5b6:4ad:d6ba with SMTP id
 2adb3069b0e04-5b8bff4a5d7mr13058e87.15.1789644298430; Thu, 17 Sep 2026
 04:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915160141.3543048-1-suzuki.poulose@arm.com> <20260915160141.3543048-6-suzuki.poulose@arm.com>
In-Reply-To: <20260915160141.3543048-6-suzuki.poulose@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 17 Sep 2026 12:24:21 +0100
X-Gmail-Original-Message-ID: <CA+EHjTz65G0MM=tOrzmk=jMweBX1us6FqfrmSkQs4KSyAEoxhg@mail.gmail.com>
X-Gm-Features: AcwNN1VFMe-nqpetX5NFULE-T8FsNAG-h344sw-wYzui_i8Ztl6ucWB9ep0N7uI
Message-ID: <CA+EHjTz65G0MM=tOrzmk=jMweBX1us6FqfrmSkQs4KSyAEoxhg@mail.gmail.com>
Subject: Re: [PATCH v18 05/23] KVM: arm64: Track the type of VM in kvm_arch
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

On Tue, 15 Sep 2026 17:01:23 +0100, Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
[...]
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
[...]
> +#define kvm_vm_hyp_is_pkvm(kvm)                (is_protected_kvm_enabled())

I'd keep is_protected_kvm_enabled() at the three call sites: this
takes a VM and ignores it, so it reads as per-VM when it's the mode,
and patch 20's comment about not being able to use the kvm_vm_ helpers
with a NULL kvm goes away too.

> diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
[...]
> @@ -432,7 +432,7 @@ static void init_pkvm_hyp_vm(struct kvm *host_kvm, struct pkvm_hyp_vm *hyp_vm,
>
>          hyp_vm->host_kvm = host_kvm;
>          hyp_vm->kvm.created_vcpus = nr_vcpus;
> -        hyp_vm->kvm.arch.pkvm.is_protected = READ_ONCE(host_kvm->arch.pkvm.is_protected);
> +        hyp_vm->kvm.arch.vm_flavor = READ_ONCE(host_kvm->arch.vm_flavor);

Could EL2 reduce this to VM_PKVM or VM_PROTECTED_PKVM here instead of
storing what it reads? The host supplies the value, and it's now an
enum rather than a bool. Patch 12 relies on EL2 only ever seeing those
two, and with VM_REALM above the marker a host-written value passes
kvm_vm_is_protected() but not the == form, if EL2 ever adds one.

Both hunks are new since v17, which is where I gave the Reviewed-by.
Happy to keep it if you can settle these please.

Cheers,
/fuad
