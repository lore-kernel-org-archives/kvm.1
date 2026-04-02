Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534BB24BBF4;
	Thu,  2 Apr 2026 01:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775093421; cv=none; b=LrM66hQ3Kv7SrZFX/4Ic3hpCdKHrDY7UO+79q6rQSdyLyEbR0ufHSaoe/ylHaPG172gL827Me8tL9nRFoGi6PzDWQhvkOBT7OK7bS2o0bI1D4F1hKMAxhM0hfyRFTyjGXb8zOkwptsozmT56cpbhPLBKIJBtgnymIHyOOUA2xwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775093421; c=relaxed/simple;
	bh=NjmXATPGid77lEYSs73L1TeQKlGhYK8+n9RO1pStMpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkkLUEuNyHa6kPk959usB1JMz6Oj9Tb/pbiVqLBytuLeLBXEQVfhxmvlOvHGUwo2aQcAhjRKcUnFFfG8j4jBuq8ukDC7cT7u+9PoTirIO2Ii1ZypafEz4Yezs/aAgT7MWRZd2HlZn7HfDpToNghZ8g8Q3330Qazh2nZAm1As8us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yEGSW+7g; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yEGSW+7g"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775093415; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=LQI8bgcOyvJ94DrVUS67dvIGyB2c7fWfel9wByeq7fM=;
	b=yEGSW+7gU/q8FtO3BrF2/8I1db9PRn2cykK47MsqzrE8ERqbCE6kUkb5Y/h6D11kZ8RbO1YTPhnLqhiOqisEioC7kIzMJB1kldlNl8UuqXpPt4Faw1oCuZEWhLIwITQFNu84VE8fQs3FJsEJTKNCX58NfQsirVxERxH3tGB+7sg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X0FQ265_1775093412;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X0FQ265_1775093412 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Apr 2026 09:30:13 +0800
From: fangyu.yu@linux.alibaba.com
To: anup@brainfault.org
Cc: alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
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
	radim.krcmar@oss.qualcomm.com,
	skhan@linuxfoundation.org
Subject: Re: Re: [PATCH v6 3/4] RISC-V: KVM: Detect and expose supported HGATP G-stage modes 
Date: Thu,  2 Apr 2026 09:30:10 +0800
Message-Id: <20260402013010.9030-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CAAhSdy0ri8sWZn0CsCpfSgNqXw5gEesfKxcKqc56azVOrqz86w@mail.gmail.com>
References: <CAAhSdy0ri8sWZn0CsCpfSgNqXw5gEesfKxcKqc56azVOrqz86w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>>
>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>
>> Extend kvm_riscv_gstage_mode_detect() to probe all HGATP.MODE values
>> supported by the host and record them in a bitmask. Keep tracking the
>> maximum supported G-stage page table level for existing internal users.
>>
>> Also provide lightweight helpers to retrieve the supported-mode bitmask
>> and validate a requested HGATP.MODE against it.
>>
>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
>> ---
>>  arch/riscv/include/asm/kvm_gstage.h | 11 ++++++++
>>  arch/riscv/kvm/gstage.c             | 43 +++++++++++++++--------------
>>  2 files changed, 34 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
>> index 70d9d483365e..bbf8f45c6563 100644
>> --- a/arch/riscv/include/asm/kvm_gstage.h
>> +++ b/arch/riscv/include/asm/kvm_gstage.h
>> @@ -31,6 +31,7 @@ struct kvm_gstage_mapping {
>>  #endif
>>
>>  extern unsigned long kvm_riscv_gstage_max_pgd_levels;
>> +extern u32 kvm_riscv_gstage_supported_mode_mask;
>>
>>  #define kvm_riscv_gstage_pgd_xbits     2
>>  #define kvm_riscv_gstage_pgd_size      (1UL << (HGATP_PAGE_SHIFT + kvm_riscv_gstage_pgd_xbits))
>> @@ -102,4 +103,14 @@ static inline void kvm_riscv_gstage_init(struct kvm_gstage *gstage, struct kvm *
>>         gstage->pgd_levels = kvm->arch.pgd_levels;
>>  }
>>
>> +static inline u32 kvm_riscv_get_hgatp_mode_mask(void)
>> +{
>> +       return kvm_riscv_gstage_supported_mode_mask;
>> +}
>> +
>> +static inline bool kvm_riscv_hgatp_mode_is_valid(unsigned long mode)
>> +{
>> +       return kvm_riscv_gstage_supported_mode_mask & BIT(mode);
>> +}
>> +
>>  #endif
>> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
>> index 7c4c34bc191b..459041255c14 100644
>> --- a/arch/riscv/kvm/gstage.c
>> +++ b/arch/riscv/kvm/gstage.c
>> @@ -16,6 +16,8 @@ unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init = 3;
>>  #else
>>  unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init = 2;
>>  #endif
>> +/* Bitmask of supported HGATP.MODE encodings (BIT(HGATP_MODE_*)). */
>> +u32 kvm_riscv_gstage_supported_mode_mask __ro_after_init;
>>
>>  #define gstage_pte_leaf(__ptep)        \
>>         (pte_val(*(__ptep)) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC))
>> @@ -315,42 +317,43 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end
>>         }
>>  }
>>
>> +static bool __init kvm_riscv_hgatp_mode_supported(unsigned long mode)
>> +{
>> +       csr_write(CSR_HGATP, mode << HGATP_MODE_SHIFT);
>> +       return ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == mode);
>> +}
>> +
>>  void __init kvm_riscv_gstage_mode_detect(void)
>>  {
>> +       kvm_riscv_gstage_supported_mode_mask = 0;
>> +       kvm_riscv_gstage_max_pgd_levels = 0;
>> +
>>  #ifdef CONFIG_64BIT
>> -       /* Try Sv57x4 G-stage mode */
>> -       csr_write(CSR_HGATP, HGATP_MODE_SV57X4 << HGATP_MODE_SHIFT);
>> -       if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV57X4) {
>> -               kvm_riscv_gstage_max_pgd_levels = 5;
>> -               goto done;
>> +       /* Try Sv39x4 G-stage mode */
>> +       if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV39X4)) {
>> +               kvm_riscv_gstage_supported_mode_mask |= BIT(HGATP_MODE_SV39X4);
>> +               kvm_riscv_gstage_max_pgd_levels = 3;
>>         }
>>
>>         /* Try Sv48x4 G-stage mode */
>> -       csr_write(CSR_HGATP, HGATP_MODE_SV48X4 << HGATP_MODE_SHIFT);
>> -       if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV48X4) {
>> +       if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV48X4)) {
>> +               kvm_riscv_gstage_supported_mode_mask |= BIT(HGATP_MODE_SV48X4);
>>                 kvm_riscv_gstage_max_pgd_levels = 4;
>> -               goto done;
>
>Keep the original approach until then NACK to this series.
>

Hi Anup,

Thanks for the review.

Ack. I’ll keep the original HGATP mode probing logic for now and send a v7 accordingly.

Thanks,
Fangyu

>Regards,
>Anup
>
>>         }
>>
>> -       /* Try Sv39x4 G-stage mode */
>> -       csr_write(CSR_HGATP, HGATP_MODE_SV39X4 << HGATP_MODE_SHIFT);
>> -       if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV39X4) {
>> -               kvm_riscv_gstage_max_pgd_levels = 3;
>> -               goto done;
>> +       /* Try Sv57x4 G-stage mode */
>> +       if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV57X4)) {
>> +               kvm_riscv_gstage_supported_mode_mask |= BIT(HGATP_MODE_SV57X4);
>> +               kvm_riscv_gstage_max_pgd_levels = 5;
>>         }
>>  #else /* CONFIG_32BIT */
>>         /* Try Sv32x4 G-stage mode */
>> -       csr_write(CSR_HGATP, HGATP_MODE_SV32X4 << HGATP_MODE_SHIFT);
>> -       if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV32X4) {
>> +       if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV32X4)) {
>> +               kvm_riscv_gstage_supported_mode_mask |= BIT(HGATP_MODE_SV32X4);
>>                 kvm_riscv_gstage_max_pgd_levels = 2;
>> -               goto done;
>>         }
>>  #endif
>>
>> -       /* KVM depends on !HGATP_MODE_OFF */
>> -       kvm_riscv_gstage_max_pgd_levels = 0;
>> -
>> -done:
>>         csr_write(CSR_HGATP, 0);
>>         kvm_riscv_local_hfence_gvma_all();
>>  }
>> --
>> 2.50.1
>>
