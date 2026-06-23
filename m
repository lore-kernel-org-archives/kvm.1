Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B42A35E930
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782218013; cv=none; b=IrqFGymvNwjcie9JCs7fSbLzksM7VtzuLlEe+PeKETnZLKqs7CW4riG1j5QlXqlEHzifxUa3fOPj/T1tRIVPxpLX9xDGFN9jQ14E/jXiiFN9qal3v5uRWwtO89rzM6BmT9N7OVBpjYJiX1bJEDoTdju6Jnb0Y/B6j5XZpV8zW/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782218013; c=relaxed/simple;
	bh=FskFBBlcS/2QLlosfPGONyA8sYVW1HS6WCJ3Pa4/5Ns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WxF8+CZ2Kx6cC7zpG2P07acUnf32MQhIyFAzlWS5PGA+rcISiU0AVjsoqYgKO065GLz/omvMI28vaBrNfr0oW9X2c/T6iCpx5qt+b8G06//I21EHydI5pBDRQnDtzP/5ZiYe+A18PCVoMcUKd6AqW4KOnXzlecZ8iDb17DRddTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGfSOFPb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGfSOFPb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8611F000E9;
	Tue, 23 Jun 2026 12:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782218011;
	bh=D3AScV+zyDWt0wgDfLKmc+CSV8qhhTZJCrDHs+hfswo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QGfSOFPbPsVF2f+vjLetlTn/Ot4kWKeSqUZ0UWVuqr9NAVzgDu/TF1tTgCJRlJXnJ
	 Zera+UJhlH/JXsESNSsMpR86pQbd67DRVc2Oo59dLbWlOant9IS4bCbx8Y5SyOCDsk
	 eLNfNOWogNtAM0HVaTU+DHqKUmzEMEYrtagEa4six4zhOf/GRBlPzi6OhXrsLntjgw
	 1pBXo/SapQV5OxvVzLQMSo/ROMefvcyP/DukNdKwwGH006nNLX0HYR6Slb6cQBtABO
	 9ZnxSD6ogbB0xClEnXh0IcequY2sVg7zHfgmdim34EkpQ9sqjVVhQ8n/PlHknLOEFQ
	 r2TLfvpWBcvKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] RISC-V: KVM: Split huge pages during
 KVM_CLEAR_DIRTY_LOG
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Yechao" <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260623121332.78514-5-wang.yechao255@zte.com.cn>
References: <20260623121332.78514-1-wang.yechao255@zte.com.cn>
 <20260623121332.78514-5-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 12:33:31 +0000
Message-Id: <20260623123331.7F8611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Dropping kvm->mmu_lock before flushing TLBs leads to lost dirt=
y page tracking and silent data corruption.
--

commit ea1e9d47d599e24f8216769c511d82126690b4ec
Author: Wang Yechao <wang.yechao255@zte.com.cn>

RISC-V: KVM: Split huge pages during KVM_CLEAR_DIRTY_LOG

Split huge pages on the range specified using KVM_CLEAR_DIRTY_LOG.
And do not split when enabling dirty logging if
KVM_DIRTY_LOG_INITIALLY_SET is set.

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 8220efadb8713..d2d36a9dca06f 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -164,6 +164,9 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct k=
vm *kvm,
>  	kvm_riscv_gstage_init(&gstage, kvm);
> =20
>  	kvm_riscv_gstage_wp_range(&gstage, start, end);
> +
> +	if (kvm_dirty_log_manual_protect_and_init_set(kvm))
> +		mmu_split_huge_pages(&gstage, start, end);

[Severity: Critical]
Does this code inadvertently drop kvm->mmu_lock while there are pending
deferred TLB flushes?

When userspace calls KVM_CLEAR_DIRTY_LOG, virt/kvm/kvm_main.c clears bits
in the software dirty bitmap and calls
kvm_arch_mmu_enable_log_dirty_pt_masked() to write-protect the pages. The
TLB flush is intentionally deferred across the batch loop:

virt/kvm/kvm_main.c:kvm_clear_dirty_log_protect() {
    ...
    kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot, offset, mask);
    ...
}

However, mmu_split_huge_pages() drops the lock:

arch/riscv/kvm/mmu.c:mmu_split_huge_pages() {
    ...
    write_unlock(&kvm->mmu_lock);
    cond_resched();
    ...
}

Because the lock is dropped before the deferred TLB flush completes, guest
vCPUs can resume and write to memory using stale, writable TLB entries.

Since the software dirty bitmap was already cleared and these writes bypass
KVM's write-protection faults, can this result in permanently lost dirty
page tracking and memory corruption during live migration?

>  }
> =20
>  void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *me=
mslot)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623121332.7851=
4-1-wang.yechao255@zte.com.cn?part=3D4
