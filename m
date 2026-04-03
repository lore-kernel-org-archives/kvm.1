Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F82B30498E;
	Fri,  3 Apr 2026 02:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775183524; cv=none; b=GylncQz6/LlNminql8OOIPDL0hOmqYubRBhEU9GAzSm88dF/sCRoO7mJAucncoC/yyiAPK/StBC1WfvJd4yaZbCrsLUPfPLs62vG+jLnBZse23K4VO+X/+AkaTJWIiX5e6iuFlIfkYDKt2xGcDN4RsoEKgcl/FFgUKkMcfVCBZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775183524; c=relaxed/simple;
	bh=K8UIoDM9Y79rXpP5AvK3R/ZZGKRIHdOw+0SbrTOmr+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnDhepc+QYpokKbUPGgEUpcZMnjEuZAI2QAYbWYelpkJ0rIVR5xINdOdIOnU5HBUu3AJglE6NCUH9RSCCzCVH6ZLGaL67j5r8XjIvpC/5xLqi+gJKE2KIA7zCPxWLgr2XGLgomVmRyRJneUctRUVhqTkzNDLCugw0B4myVKQ2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nRYdxP7t; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nRYdxP7t"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775183518; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=MwMGTOvDH+UUgg3XppNhDJ7Wm/kQtmd8riFK4rQdv6Y=;
	b=nRYdxP7tb5xtGegSF2QiQHghgJfveD5QgeqcdNhhLk8ZTY3vwv6QtIaM589GZSkxLmJGuBug/VWhiJarNLx6m3ShKHmuu8oVLIYBTosb0knwEU/EhGz/a4lWIO2FXl5oeQj4lEnlXoqdWHWMckMsvATbkEgydnBt8cA+Q4jGx+w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X0IegUK_1775183514;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X0IegUK_1775183514 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Apr 2026 10:31:56 +0800
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
Subject: Re: Re: [PATCH v7 3/4] RISC-V: KVM: Detect and expose supported HGATP G-stage modes 
Date: Fri,  3 Apr 2026 10:31:49 +0800
Message-Id: <20260403023149.40338-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <DHIVKK81LLM2.3VTYW1UXM6USQ@oss.qualcomm.com>
References: <DHIVKK81LLM2.3VTYW1UXM6USQ@oss.qualcomm.com>
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
>> Extend kvm_riscv_gstage_mode_detect() to record HGATP.MODE values in a
>> bitmask. Keep tracking the maximum supported G-stage page table level
>> for existing internal users.
>>
>> Also provide lightweight helpers to retrieve the supported-mode bitmask
>> and validate a requested HGATP.MODE against it.
>>
>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
>> Reviewed-by: Guo Ren <guoren@kernel.org>
>> ---
>> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
>> @@ -102,4 +103,14 @@ static inline void kvm_riscv_gstage_init(struct kvm_gstage *gstage, struct kvm *
>> +static inline bool kvm_riscv_hgatp_mode_is_valid(unsigned long mode)
>> +{
>> +	return kvm_riscv_gstage_supported_mode_mask & BIT(mode);
>
>Shifting by more than the bit width is undefined behavior in C.
>RV64 effectively translates BIT(mode) to 1UL << (mode & 0x3f), so this
>could allow values larger than the mask.
>

Thanks for catching this.

You’re right: BIT(mode) is undefined for out-of-range shifts, and on RV64 it can
effectively mask the shift amount, potentially making invalid MODE values appear
valid. In v8 I’ll add an explicit bounds check before shifting.

Thanks,
Fangyu

>Thanks.
