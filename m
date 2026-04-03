Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E2B35AC32;
	Fri,  3 Apr 2026 02:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775185193; cv=none; b=ds1KMUg2ErqMUvz7MtuOolZVbGIKX3VuiB80yS85PWkYBjAj/H3FtTNqcuCH24HTNdqB1pA3eI3BjUMK+DR4xjjvJRyYCIrl7OG66jHYGJex1TAHaHL1guBVmPk3Lds96FALpTEhkTqB21jkBcBGBDb+nyEuqOlNDNrXadicQmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775185193; c=relaxed/simple;
	bh=YBf7SatwQ9p/g+niFh8koBnIyM6E1gPeb0dkOeKrGb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkXQBxn79CEl1vSJogTkPVKp8sFuLu+lPWGXssNcltTCBmGr7dI1Pt/71/zjF2Ph/yz1/qYF5WcTS0fJH3N8mkzBsqyWY+43FHohQzVu4u1JFDwDq84AFRwRqimP7PlxpwtZiNWjr8uKYnkmAxp7THMtgBe1xtbpK5H7OGapT0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IiRTsUOV; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IiRTsUOV"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775185184; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=hz8Xf0WjqAmv02QAnNq4g/lk3QXHFKGIGokcVeGTTF4=;
	b=IiRTsUOVyCiDz8TVOyS3TvWLOL6yngAjFI0bP6tGAq3XNtrcqNZqeJwkGn6jwpj9H0axBrd/0TpYqXzMjNaic9yhRplP0TyGSEjtrAvsE5S15F6intz4jqfgczujzOiJ8j3pNhhEFKzRydAq7i/bYGmRTb656Bw0slYfkZGu85Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X0IpQik_1775185180;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X0IpQik_1775185180 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Apr 2026 10:59:42 +0800
From: fangyu.yu@linux.alibaba.com
To: radim.krcmar@oss.qualcomm.com
Cc: alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	corbet@lwn.net,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pbonzini@redhat.com,
	pjw@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: Re: [PATCH v7 4/4] RISC-V: KVM: add KVM_CAP_RISCV_SET_HGATP_MODE 
Date: Fri,  3 Apr 2026 10:59:39 +0800
Message-Id: <20260403025939.43841-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <DHIVQI1DY4MK.27YZ2NPDXF5WM@oss.qualcomm.com>
References: <DHIVQI1DY4MK.27YZ2NPDXF5WM@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>
>> Add a VM capability that allows userspace to select the G-stage page table
>> format by setting HGATP.MODE on a per-VM basis.
>>
>> Userspace enables the capability via KVM_ENABLE_CAP, passing the requested
>> HGATP.MODE in args[0]. The request is rejected with -EINVAL if the mode is
>> not supported by the host, and with -EBUSY if the VM has already been
>> committed (e.g. vCPUs have been created or any memslot is populated).
>>
>> KVM_CHECK_EXTENSION(KVM_CAP_RISCV_SET_HGATP_MODE) returns a bitmask of the
>> HGATP.MODE formats supported by the host.
>>
>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
>> Reviewed-by: Guo Ren <guoren@kernel.org>
>> ---
>> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
>> @@ -211,12 +214,23 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>
>>  int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
>>  {
>> +	case KVM_CAP_RISCV_SET_HGATP_MODE:
>> +		if (!kvm_riscv_hgatp_mode_is_valid(cap->args[0]))
>> +			return -EINVAL;
>> +
>> +		if (kvm->created_vcpus || !kvm_are_all_memslots_empty(kvm))
>> +			return -EBUSY;
>
>Since multiple VM ioctls can execute concurrently, I would protect
>created_vcpus by kvm->lock and kvm_are_all_memslots_empty by
>kvm->slots_lock.
>

Agreed. I’ll protect created_vcpus with kvm->lock and call
kvm_are_all_memslots_empty() under kvm->slots_lock, following the
kvm->lock -> kvm->slots_lock ordering in v8.

Thanks,
Fangyu

>Thanks.
