Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2554D30F7FB
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 01:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558888; cv=none; b=gFvJBlfWhYHdV1y0wm9ZCaod1cuKgCrJyxSHCQl615YK8iPQcecL7U9e9R986rwVflDmuI/fdiJdoRy3qNo4CQHb57Qtwx4hRXKidsINDVH7T64Jtt/PNXUOp/o56f0472LpWU+LwUymNjBBufGYE+oNRUUqZ3MqTDzrqrYMRL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558888; c=relaxed/simple;
	bh=E7cY/7poBmsn/1R0JExGYYnhLt2AAvvBzlqZZtWGrFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FS9c1PKEKHClt3+fQKMiT6w1/uaBI4PI7o/axqRJA0GqfdDUjqC2kqyV6pe/3oN5k6NeMhTE1VdZ/rSanO/355rcc9CougUVVj0acXmySnP1DllMNPrfTy7cVnpjVjfdHFQchSJl/JSJFmyDmb66IKaCdnqbMrL1n5AUz31rT3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUq2C6tW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s7Sd5AnU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUq2C6tW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s7Sd5AnU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790558886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Pz+VkJaf3rDADUJdpqmWyIZGulrG9C1hI5BJar5zt4=;
	b=hUq2C6tW8q4yQfXyAC+XF5jp+UpbCjigBPScNRokO+V9axxeIeJdNPLo2Q8o/zFUgB+ccu
	qOSZypOROCx9ulzKgDq5jxY977VzelkI/9ejD7UJ2qaXN/N4uYfU9Qg9G+VoRbVvyAvOfP
	frECmDvgMUzxCvL0ko0tBTXLjnf1B9w=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-NBBVuMo2Ms-J-V-kt4Qz7g-1; Sun, 27 Sep 2026 21:28:04 -0400
X-MC-Unique: NBBVuMo2Ms-J-V-kt4Qz7g-1
X-Mimecast-MFC-AGG-ID: NBBVuMo2Ms-J-V-kt4Qz7g_1790558884
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc7361c62b9so1676417a12.3
        for <kvm@vger.kernel.org>; Sun, 27 Sep 2026 18:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790558884; x=1791163684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Pz+VkJaf3rDADUJdpqmWyIZGulrG9C1hI5BJar5zt4=;
        b=s7Sd5AnUesp23uMftfXN5MORwOOeiRhV6Lr413H0t3ZnpS1+w3hwsJZunWwI6vjFNk
         QkjQXRTbaPuXDkg8CeoebWsXVeyCnb35L/XDVZocXHUtmr1R90LNR1vWd5yXWYOsrkVN
         WsBXYg4DyqefECN1yOxEJJx72SMAnBTjG3WHmdzNjkU5nShCM19AAKilf0sb0IJyMkUO
         jb23SMVV3yIcnMdo+18Dev77ucHe1dPGnQSpbbbGr3uG1gGAk1t7AJNHb1/CHrevbPf5
         x63rigqtAzqgXuyBb8+TOh6iwbXj00a2OwfapTYar0taEuH9lS15oEkMTluu+14+au9P
         dUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790558884; x=1791163684;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Pz+VkJaf3rDADUJdpqmWyIZGulrG9C1hI5BJar5zt4=;
        b=TqD8B/19CrDuaAo8+Qxz2UG+ZRPKric6h7hN2w+BQHEf0yvSKE8XCdNvm7WXxtMYl5
         y+JF/Hcoh0DPfHR7Y9YUXe7tjD20s9tTAJ/E29F5nw9okfXFfuq9NibnNmjWtI3oWUe3
         EOgxSI41lHFJxkYhcY+Vrp1EoItBfrNU4tLvATboHQ9t65pb0PNjYR6V9MQZ48PMcKEq
         1B4pE4SToQzaOBhxjq8WqfcqWrkioU++I6slvozRtj1CH4lCA/MtUOlFeDYqLPC4iWrG
         KWj7+MWnOYm0lgXs7YPSNWWGYeVnVUs/PrgajRrhvizwbV8Q3RdHCPGa1GANeD8YbEFP
         ESEg==
X-Forwarded-Encrypted: i=1; AKwUvBwdzliGPISIe2IZTiKMTqt5Bry0WvMppMBRhdqVkKXrGeXe3R830LQkR4zbdgzUPZVFKXw=@vger.kernel.org
X-Gm-Message-State: AFuF++kOYBJMaem9TUsGNVpVGpmZquNhLusuAQAbYfurS8vMmcRCC6SZ
	k5AuICQkSPGGaMbVpvg8OptFUwNagH2KssTQs/Oy4Na+SdGB8XiwFJU16rZsaeLO6y8fyXetDYM
	9+XnJ+XauxxJtUdAZ9nwsKmyAHH8hbiNAwcSOuvhsTc6GBF34SFT9lQ==
X-Gm-Gg: AYBFou1g7j4bxNE7V85v2QC63uUxVGPpWot8ckOzrCYHGqGbtyGzJ9UsZsD5GAJm3gY
	ZDD5Cuhl9uWS5vvhYMTwK+3wqb27IWipKKeocnuW99XqyFIbJNsj1bCFPsTjQxAKBsykJDk/RBE
	3AQuYO0zCXhg1XGpkJdak8MDIAiH9boNG82fWP9wam6ePykS6HosmNbuFEg0toUk7ni+nV3dDob
	meSI36QCDyAKUjRKFjEnpORSpOFfcWu4QMTM5VK2HgUOIAE0o4vZ1QMbzRd7Tb5o7clHMMQ7QGJ
	3vu8J3gnOQ5b2NJmveNeJMbNyL2R8DLEiiuPa/npodD1PxyXLrUdApaQ6D1FB4xGDSO4Si1oRQW
	L1doLitCxRwnxBbAunOGXRKpG1qE76BjaUkth9ycDag==
X-Received: by 2002:a05:6a20:244f:b0:3de:6873:84d1 with SMTP id adf61e73a8af0-3de6873856fmr678761637.74.1790558883730;
        Sun, 27 Sep 2026 18:28:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:244f:b0:3de:6873:84d1 with SMTP id adf61e73a8af0-3de6873856fmr678737637.74.1790558883223;
        Sun, 27 Sep 2026 18:28:03 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc794ef8befsm2931082a12.12.2026.09.27.18.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 18:28:02 -0700 (PDT)
Message-ID: <346eb257-23ce-4a43-a17a-f532d7448582@redhat.com>
Date: Mon, 28 Sep 2026 11:27:55 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 15/20] KVM: arm64: CCA: Introduce Realms
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
References: <20260920212845.707-1-suzuki.poulose@arm.com>
 <20260920212845.707-16-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260920212845.707-16-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/26 7:28 AM, Suzuki K Poulose wrote:
> From: Steven Price <steven.price@arm.com>
> 
> Add foundational work for supporting Realms.
>   - Add a new VM flavor.
>   - At KVM init, check if the KVM can support Realms (though not functional yet)
>     and will be advertised by static key kvm_rmi_is_available. This will be
>     turned on in a later patches, once we have all the bits and pieces ready.
>     For now check if we are blessed with KVM_MODE_RMM.
>   - Add realm specific tracking in kvm_arch. Since Realm and protected pKVM
>     states are mutually exclusive, move them into a union.
> 
> Please note that we cannot create Realm VMs yet. This requires further changes
> to the UABI and core RMI driver support, which will come later.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v16:
>   * Share mutually exclusive pKVM and Realm per-VM storage in a union.
>   * Move to the new VM flavor infrastructure, split bits out. Trimmed down
>   * Move in Realm state and basic boiler plates
> Changes since v13:
>   * Most of the init has been moved out of the 'kvm' directory so this is
>     much more basic now.
> Changes since v12:
>   * Drop check for 4k page size.
> Changes since v11:
>   * Reword slightly the comments on the realm states.
> Changes since v10:
>   * kvm_is_realm() no longer has a NULL check.
>   * Rename from "rme" to "rmi" when referring to the RMM interface.
>   * Check for RME (hardware) support before probing for RMI support.
> Changes since v8:
>   * No need to guard kvm_init_rme() behind 'in_hyp_mode'.
> Changes since v6:
>   * Improved message for an unsupported RMI ABI version.
> Changes since v5:
>   * Reword "unsupported" message from "host supports" to "we want" to
>     clarify that 'we' are the 'host'.
> Changes since v2:
>   * Drop return value from kvm_init_rme(), it was always 0.
>   * Rely on the RMM return value to identify whether the RSI ABI is
>     compatible.
> ---
>   arch/arm64/include/asm/kvm_emulate.h | 16 ++++++++
>   arch/arm64/include/asm/kvm_host.h    | 18 +++++---
>   arch/arm64/include/asm/kvm_rmi.h     | 61 ++++++++++++++++++++++++++++
>   arch/arm64/include/asm/virt.h        |  1 +
>   arch/arm64/kvm/Makefile              |  2 +-
>   arch/arm64/kvm/arm.c                 |  6 +++
>   arch/arm64/kvm/mmu.c                 |  1 +
>   arch/arm64/kvm/rmi.c                 | 18 ++++++++
>   8 files changed, 117 insertions(+), 6 deletions(-)
>   create mode 100644 arch/arm64/include/asm/kvm_rmi.h
>   create mode 100644 arch/arm64/kvm/rmi.c
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>

