Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54422481A82
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945567; cv=pass; b=SAo+xZdSv/w6H06x8QmPeQZlWok9v3CMruIdG0WzzVzZWNq0g3VCrFSfkKDmC2txCooxbXlOx8xtTqGzEPbqahcuzsSobqeohc683FrZNclI5qU51Sd1LuFGCbr0P6BdM83bBHWx3JyC/pegPCkbCWJXZXE4j35tSggYCvWhAxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945567; c=relaxed/simple;
	bh=vBtrTO+xzdjdKu06LW7AV+Jy0mqjzAYX4zJzogz18Ig=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZPod6GBo6iryhhXFRs12j3VcZ1lzaY6jJrsMPOARMetfSR//MF9/mD2aMpYXY/Jt/V4N0sCSzWg9GagxxSNgAValrj33lsnucWKrg/giRd9sWVArrYMVYIszCq738EdSVmgT7HG+bj+uzPrzt8//Hku3Sbc0ES+BLrv+EYDHL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J8ktlrc/; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J8ktlrc/"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so934382a12.2
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 08:59:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785945555; cv=none;
        d=google.com; s=arc-20260327;
        b=MiTqIwn+vXT3I2uraglKgXbafeBFZQkvuc3WbqLCaCy6Up6aNPr03P4LXrMwM1Ij4f
         BaQ11gnpsYuX0gnGd+N/WVFkNTF0HbA2pbf7IldFW6RZskFmdmsK0aq8eOCyOFr4ahDe
         2tqz1Mru7h07iZCfGxt35HU265ifsiVXnVXGLkUV0aRCofWB94zEqcuNw21snQ9dSyWo
         mybPQcmGTUPwpvwwpzJTK4gM3LMl+z5JE2Upo+a1n1ELhh9N5Q5opvUaqqFyIv7rSooR
         xfHBgLazZqioqsAJxdltkoM2MDaBT5fIfJBzfmQEe8Vsko8nXCpadB3AJZWzBpbTL/Z1
         ksuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=6P2+ujme6g+HTSW6n7ztSC163pEV3pR8Oo8zV1D+dnQ=;
        fh=k84Vay+56fA29mevdbd/oWEC0feeGMH6htTcDMlT/GI=;
        b=VfATKuqSekrQ9P3GJM2NKix6b1gGT2cTGEpZYMjIcWBBEvzUlOwCt2AHKpBqFcwwi1
         ytBFdcIH1yvpNtEhXuLZMJ3hMNXGuhujECG/CPoCcTxrwCAK8lVdbswC7LrR3JZYL6mc
         5zyVN02UWQ+Kz2VgXAaCmISRZs+MHjPTv5SSpNYuUJBX7VJUho8ZTjREThOswCxCRKNF
         /ic5lmuFJpVZ/QfiAMkDC+9LxLH+DTuai0zYw4unD1NtQ27i6BHL2nP5SZnMSwChI58w
         10edWEr8vRdbwT7Yk/EMBFAvKrVpq1KbWRUjXjrBAvZbNvfa/x0GDLEC9U0jrcyXNOrV
         w0ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785945555; x=1786550355; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6P2+ujme6g+HTSW6n7ztSC163pEV3pR8Oo8zV1D+dnQ=;
        b=J8ktlrc/TfiNR9D0wK4FhsgKsN90H3SAowC1uFvSNxQcPTgYAtv8Vwx+euZl8yMlM7
         JQXY5ydjvRcl1DgGdk/JWBbFJVZfYFgMKtXIcYOKZJxr+V/V/SgHLRCbYq7+ZFs9VQhM
         QMEJ27a28ZbfVb4RTQ8/rAtu47LJRm4RUZxwAyDKIsgiYgREQOPAPF4WFSkWnaPXYIrs
         eXtcPuJsAUh/KviM5TUUllrjd5b6Lgd2mysRFrK+6cjmsilGshucz9ajQI9xm36nbkzx
         tVGDZ3P+OxpUFtFAMvrtFwXiyZtWlTaU8Y3MHxuiWSg7f1RdHjJnWJKMgcg4ijy7z0NI
         5Vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785945555; x=1786550355;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6P2+ujme6g+HTSW6n7ztSC163pEV3pR8Oo8zV1D+dnQ=;
        b=dtjcRie4G4STDBDh896gqqST+b4nX55SYM8c8EwaG1RFRsjftnQZQN6BWkGS4ttiQj
         RrztAI5ghnAvcOKldOfqBZ1Qr7rro5cBU2xusTVLE4v6j1st8Lr2r87X3FFCeWFvQhL/
         ACYthwPMdC14KByUlZzhDlTL7exHZf8AWLkCk164Qp3Og+E3PperVw0w6kyWmMTQwO4o
         Tig0Ro76ihTPpXeWLk2lPkuNNAHCVbfQGbGOKz65aCURm6/hYWhub4Ph/C1uvtFcmA6B
         tKZov7I7yEzl6wqUkj7OKHGKRu3Fzidi9Chcv8KnBJUup0cMcTG3R+IZ/jVE90yalr/I
         gusw==
X-Forwarded-Encrypted: i=1; AHgh+RqCOXzTPeKyNZSjfrotLOacgrD8gfuBIG2i7f88LaTD4rUIt3KI3zmwt7FnGf8F+dHTk2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWN0JTPMI6fzIFC7MuVWWBMK4yMX/fNL/AhLoLWzsvVbulwJiE
	AGWXGxJV9i9yGpzATIkiL2bDnjlyde75QfhwXzoGNfMaWQ88z9tJ/7+hBsRE3ueAECMKfAW2R0/
	TNM988SdMhwo1Sh/BnFNBF6schY/ox9TOAELcOieA
X-Gm-Gg: AR+sD11ec2JqHAMAX4XfqG27qQYuva9Zi0ZzEM+y+LsVL4kq0AvEt/xsYRkb/YoWaNN
	HfT02t36+94ghIA+bolVr1xGYYFCNEjKseU7TL2KrfXH5QGD1Xhmj8/E6gBycgEk1DBp6caGa9W
	e+GCJzBY2+pFiwRdq6C5pDLDDbcvVQOQlHGWQrfGkPoqkceC2jRUl8ziyZ/kkyw8gFJZ39sGyL2
	nQ9TS6EZtAmp0FjtphhXhQvL9vT+XRWW3Tu0TeRPdmv0dAesb4KtG4ERFRsw8WMdZj9B+OsZtxX
	yY6ekZGfuVNDUedQrbOMq1tacooj4aZ5THfE8UfrpU+w8dsew1Fquc/ccEfVIcnlElLJyluDymN
	SP53rvnfU1BNpGDLt/v6qJeDPS8Ywi4T5/Ys=
X-Received: by 2002:a05:6a20:9392:b0:3c3:a140:9380 with SMTP id
 adf61e73a8af0-3cb85e469d1mr8503935637.16.1785945554052; Wed, 05 Aug 2026
 08:59:14 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Aug 2026 08:59:13 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Aug 2026 08:59:13 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260803134403.80630-23-steven.price@arm.com>
References: <20260803134403.80630-1-steven.price@arm.com> <20260803134403.80630-23-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 5 Aug 2026 08:59:13 -0700
X-Gm-Features: AUfX_mw87HguPfWFRxAUKpdtMQ3QriucOf-WRaZA41ldEtA-bI259FcP0zXpgjI
Message-ID: <CAEvNRgH+HWHgf26XDHN6aMLYjRh4M8okntBfjDFCBreXRXL=TA@mail.gmail.com>
Subject: Re: [PATCH v16 22/45] KVM: arm64: CCA: Handle RMI_EXIT_RIPAS_CHANGE
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, 
	Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>, 
	Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Steven Price <steven.price@arm.com> writes:

> The guest can request that a region of its protected address space is
> switched between RIPAS_RAM and RIPAS_EMPTY (and back) using
> RSI_IPA_STATE_SET. This causes a guest exit with the
> RMI_EXIT_RIPAS_CHANGE code. We treat this as a request to convert a
> protected region to unprotected (or back), exiting to the VMM to make
> the necessary changes to the guest_memfd and memslot mappings. On the
> next entry the RIPAS changes are committed by making RMI_RTT_SET_RIPAS
> calls.
>
> The VMM may wish to reject the RIPAS change requested by the guest. For
> now it can only do this by no longer scheduling the VCPU as we don't
> currently have a usecase for returning that rejection to the guest, but
> by postponing the RMI_RTT_SET_RIPAS changes to entry we leave the door
> open for adding a new ioctl in the future for this purpose.
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v15:
>  * Propagate negative error returns.
> Changes since v14:
>  * Use addition rather than bitwise OR for adding the shared_bit in
>    realm_unmap_shared_range(), this handles the case where the region
>    includes the last address (which means 'end' already has the bit
>    set).
> Changes since v13:
>  * Switch to the new RMI_RTT_UNPROT_UNMAP range-based API.
>  * Drop ugly hack for RMM bug which errored when the RIPAS was already
>    set to the desired value.
> Changes since v12:
>  * Switch to the new RMM v2.0 RMI_RTT_DATA_UNMAP which can unmap an
>    address range.
> Changes since v11:
>  * Combine the "Allow VMM to set RIPAS" patch into this one to avoid
>    adding functions before they are used.
>  * Drop the CAP for setting RIPAS and adapt to changes from previous
>    patches.
> Changes since v10:
>  * Add comment explaining the assignment of rec->run->exit.ripas_base in
>    kvm_complete_ripas_change().
> Changes since v8:
>  * Make use of ripas_change() from a previous patch to implement
>    realm_set_ipa_state().
>  * Update exit.ripas_base after a RIPAS change so that, if instead of
>    entering the guest we exit to user space, we don't attempt to repeat
>    the RIPAS change (triggering an error from the RMM).
> Changes since v7:
>  * Rework the loop in realm_set_ipa_state() to make it clear when the
>    'next' output value of rmi_rtt_set_ripas() is used.
> New patch for v7: The code was previously split awkwardly between two
> other patches.
> ---
>  arch/arm64/include/asm/kvm_rmi.h |   6 +
>  arch/arm64/kvm/mmu.c             |   8 +-
>  arch/arm64/kvm/rmi.c             | 473 +++++++++++++++++++++++++++++++
>  3 files changed, 484 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_rmi.h b/arch/arm64/include/asm/kvm_rmi.h
> index 1e5026039458..751659a48be3 100644
> --- a/arch/arm64/include/asm/kvm_rmi.h
> +++ b/arch/arm64/include/asm/kvm_rmi.h
> @@ -107,6 +107,12 @@ int kvm_rec_exit(struct kvm_vcpu *vcpu, int rec_run_status);
>  int kvm_rec_handle_request(struct kvm_vcpu *vcpu);
>  bool kvm_rec_handle_hvc(struct kvm_vcpu *vcpu, int *ret);
>
> +void kvm_realm_unmap_range(struct kvm *kvm,
> +			   unsigned long ipa,
> +			   unsigned long size,
> +			   bool unmap_private,
> +			   bool may_block);
> +
>  static inline bool kvm_realm_is_private_address(struct realm *realm,
>  						unsigned long addr)
>  {

Coming here from guest_memfd, would like to look more closely at the
conversions-related stuff, and learn more about ARM CCA in the process :)

> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index cd06881c1497..dcc2ab08d0e4 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -319,6 +319,7 @@ static void invalidate_icache_guest_page(void *va, size_t size)
>   * @start: The intermediate physical base address of the range to unmap
>   * @size:  The size of the area to unmap
>   * @may_block: Whether or not we are permitted to block
> + * @only_shared: If true then protected mappings should not be unmapped
>   *
>   * Clear a range of stage-2 mappings, lowering the various ref-counts.  Must
>   * be called while holding mmu_lock (unless for freeing the stage2 pgd before
> @@ -326,7 +327,7 @@ static void invalidate_icache_guest_page(void *va, size_t size)
>   * with things behind our backs.
>   */
>  static void __unmap_stage2_range(struct kvm_s2_mmu *mmu, phys_addr_t start, u64 size,
> -				 bool may_block)
> +				 bool may_block, bool only_shared)
>  {

Why convert attr_filter to a boolean, why not pass the filter through? I
think that might allow all the 3 states - unmapping private, unmapping
shared, and unmapping both. (Assuming unmapping none == not even calling
this function).

Also, perhaps it's better to add this parameter to
__unmap_stage2_range() together with the patch that uses the only_shared
information :)

I see that in [1] not changing __unmap_stage2_range() was going to be
explored, did that work out?

[1] https://lore.kernel.org/all/3b8d49be-f031-4134-bd20-a8c51632f4ad@arm.com/

>  	struct kvm *kvm = kvm_s2_mmu_to_kvm(mmu);
>  	phys_addr_t end = start + size;
> @@ -343,7 +344,7 @@ void kvm_stage2_unmap_range(struct kvm_s2_mmu *mmu, phys_addr_t start,
>  	if (kvm_vm_is_protected(kvm_s2_mmu_to_kvm(mmu)))
>  		return;
>
> -	__unmap_stage2_range(mmu, start, size, may_block);
> +	__unmap_stage2_range(mmu, start, size, may_block, false);
>  }
>
>
> [...snip...]
>
