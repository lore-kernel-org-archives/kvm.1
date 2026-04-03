Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6399A329C57;
	Fri,  3 Apr 2026 02:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775182409; cv=none; b=eyl7eNh6qRLOWHLyRdxhG52U1efHzW22zqNlI6M9zzQkYPnahQ8tQZyzFsaIuqOHgG57PY79bjYihJZqH43JNt68pm+nyAyseYJr527s9EmFugVYssWxt47fZETEp5oerBTkvjGTBY8Sc6GFBqP+YSwhNcMo3YtJMe8HErRmq7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775182409; c=relaxed/simple;
	bh=z0aWfzvADX3lZ3pGX2du3oyFQkC8+kMYJW5GbxgMEj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbkngIpXojjmX5ArdaFlzHANXx4+uaZMXirUAuzILNIRRXIPIX5ZUMnrZf42qvpUNWMvXrBhRT3As4YthrFMEO9mNjSyM/nTXrT6UvJJvB93WtvtMa+ni12/Er6o+JGwTsWMs7kTfMaoO8MqGq27aB+Xg0zjs1Xpfk7fLmqeAww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mlDGxAUH; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mlDGxAUH"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775182398; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=gocmGB7MJ4Q1qvd4NluMp0l37EG2b31vDelpHwCN26o=;
	b=mlDGxAUHRd8Tjlg6LeYnPcDMdFiBxJ3R2xbzbgvdUx/e3h5he4W3zu0R7nydAJnr/NfuX6XcjPoabc5IU9pGVFxaohuf24roBmHqPvzthKPCjqpiMl8a19faYH4zSnNUFZGa4XqAPnzyBSWwJcRaeJBD3BY/yMc3Q613HucHZpo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X0IcLEJ_1775182395;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X0IcLEJ_1775182395 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Apr 2026 10:13:16 +0800
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
Subject: Re: Re: [PATCH v7 1/4] RISC-V: KVM: Support runtime configuration for per-VM's HGATP mode 
Date: Fri,  3 Apr 2026 10:13:14 +0800
Message-Id: <20260403021314.37990-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <DHIV81G43OJO.2HY4RIYFRD0RL@oss.qualcomm.com>
References: <DHIV81G43OJO.2HY4RIYFRD0RL@oss.qualcomm.com>
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
>> Introduces one per-VM architecture-specific fields to support runtime
>> configuration of the G-stage page table format:
>>
>> - kvm->arch.pgd_levels: the corresponding number of page table levels
>>   for the selected mode.
>>
>> These fields replace the previous global variables
>> kvm_riscv_gstage_mode and kvm_riscv_gstage_pgd_levels, enabling different
>> virtual machines to independently select their G-stage page table format
>> instead of being forced to share the maximum mode detected by the kernel
>> at boot time.
>>
>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
>> Reviewed-by: Anup Patel <anup@brainfault.org>
>> Reviewed-by: Guo Ren <guoren@kernel.org>
>> ---
>> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
>> @@ -199,7 +199,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>  		r = KVM_USER_MEM_SLOTS;
>>  		break;
>>  	case KVM_CAP_VM_GPA_BITS:
>> -		r = kvm_riscv_gstage_gpa_bits;
>> +		r = kvm_riscv_gstage_gpa_bits(kvm->arch.pgd_levels);
>
>kvm_vm_ioctl_check_extension() also gets called from with kvm == NULL
>from kvm_dev_ioctl().  I think we can continue to return
>...(kvm_riscv_gstage_max_pgd_levels) in that case.
>

Thanks for catching this. I’ll handle the kvm == NULL case (from kvm_dev_ioctl)
and return the host maximum based on kvm_riscv_gstage_max_pgd_levels in v8.

Also, if the intended semantics of KVM_CAP_VM_GPA_BITS is to report the maximum
supported value, then we could simply always return the host maximum based on
kvm_riscv_gstage_max_pgd_levels.

Thanks,
Fangyu

>Thanks.
